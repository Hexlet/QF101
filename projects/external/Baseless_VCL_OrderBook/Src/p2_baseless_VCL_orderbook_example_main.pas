unit p2_baseless_VCL_orderbook_example_main;

interface

uses
  Windows, SysUtils, Classes, ActiveX, Forms, Controls, StdCtrls, Grids,
  P2ClientGate_TLB,
  p2_orderbook_collector, ExtCtrls;

const
  INI_FILE_NAME      = 'P2ClientGate.ini';

  STREAM_INFO_NAME   = 'FORTS_FUTINFO_REPL';
  STREAM_AGGR_NAME   = 'FORTS_FUTAGGR50_REPL';

  TABLE_AGGR_NAME    = 'orders_aggr';
  TABLE_FUTSESS_NAME = 'fut_sess_contents';

// класс для получения времени с точностью до милисекунд
type
  TPreciseTime = class(TComponent)
  private
    fTime: tDateTime;
    fStart: int64;
    fFreq: int64;
  public
    constructor Create(AOwner: TComponent); override;
    function    Now: TDateTime; overload;
  end;

// главная форма приложения
type
  TForm1 = class(TForm)
    LogListBox: TListBox;
    ConnectButton: TButton;
    DisconnectButton: TButton;
    InstrumentComboBox: TComboBox;
    OrderBookGrid: TStringGrid;
    procedure FormCreate(Sender: TObject);
    procedure ConnectButtonClick(Sender: TObject);
    procedure DisconnectButtonClick(Sender: TObject);
    procedure InstrumentComboBoxChange(Sender: TObject);
  private
    fPreciseTime: TPreciseTime;
    fApp: TCP2Application;
    fConn: TCP2Connection;

    fInfoStream: TCP2DataStream;
    fAggrStream: TCP2DataStream;

    procedure ProcessPlaza2Messages(Sender: TObject; var Done: Boolean);

    procedure ConnectionStatusChanged(Sender: TObject; var conn: OleVariant; newStatus: TConnectionStatus);

    procedure StreamStateChanged(Sender: TObject; var stream: OleVariant; newState: TDataStreamState);
    procedure StreamLifeNumChanged(Sender: TObject; var stream: OleVariant; LifeNum: Integer);

    procedure StreamDataInserted(Sender: TObject; var stream: OleVariant; var tableName: OleVariant; var rec: OleVariant);
    procedure StreamDataDeleted(Sender: TObject; var stream: OleVariant; var tableName: OleVariant; Id: Int64; var rec: OleVariant);
    procedure StreamDataEnd(Sender: TObject; var stream: OleVariant);

    procedure StreamDatumDeleted(Sender: TObject; var stream: OleVariant; var tableName: OleVariant; rev: Int64);

    procedure RedrawOrderBook(forceredraw: boolean);
  public
    function CheckAndReopen(AStream: TCP2DataStream): boolean;
    procedure log(const alogstr: string); overload;
    procedure log(const alogstr: string; const aparams: array of const); overload;
  end;

var
  Form1: TForm1;

implementation

{$R *.DFM}

function _StrToFloatDef(const str: string; Default: extended): extended;
begin if not TextToFloat(PChar(str), Result, fvExtended) then Result:= Default; end;

{ TPreciseTime }

constructor TPreciseTime.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  QueryPerformanceFrequency(fFreq);
  FTime:= SysUtils.now;
  QueryPerformanceCounter(fStart);
end;

function TPreciseTime.Now: TDateTime;
var fEnd : int64;
begin
  QueryPerformanceCounter(fEnd);
  result:= fTime + (((fEnd - fStart) * 1000) div fFreq) / 86400000.0;
end;

{ TForm1 }

procedure TForm1.FormCreate(Sender: TObject);
begin
  // устанавливаем обработчик события Application.OnIdle, в нем мы будем запускать
  // обработку сообщений plaza2
  Application.OnIdle:= ProcessPlaza2Messages;

  // создаем счетчик времени
  fPreciseTime:= TPreciseTime.Create(Self);

  // проверяем наличие конфигурационного файла
  if not fileexists(INI_FILE_NAME) then begin
    // если файл отсутствует, выводим сообщение
    MessageBox(0, 'Отсутствует файл настроек P2ClientGate.ini; создаем пустой...', 'Ошибка', 0);
    // создаем файл
    fileclose(filecreate(INI_FILE_NAME));
  end;

  // создаем экземпляр приложения plaza2
  fApp:= TCP2Application.Create(Self);
  // указываем имя ini-файла с настройками библиотеки
  fApp.StartUp(INI_FILE_NAME);

  // создаем соединение plaza2
  fConn:= TCP2Connection.create(Self);
  with fConn do begin
    // устанавливаем адрес машины с роутером (в данном случае - локальный)
    Host:= 'localhost';
    // указываем порт, к которому подключается это приложение
    Port:= 4001;
    // задаем произвольное имя приложения
    AppName:= 'P2VCLTestApp';
    // устанавливаем обработчик изменения статуса потока (connected, error...)
    OnConnectionStatusChanged:= ConnectionStatusChanged;
  end;

  // создаем потоки plaza2
  fInfoStream  := TCP2DataStream.create(Self);
  with fInfoStream do begin
    // указываем режим открытия потока (в delphi слово type - ключевое, при импорте
    // библиотеки типов оно было автоматически переименовано
    type_:= RT_COMBINED_DYNAMIC;
    // задаем имя потока, например сделки по фьючерсам
    StreamName:= STREAM_INFO_NAME;
    // устанавливаем обработчик изменения статуса потока (remote_snapshot, online...)
    OnStreamStateChanged:= StreamStateChanged;
    // устанавливаем обработчик смены номера жизни, он необходим для корректного
    // перехода потока в online
    OnStreamLifeNumChanged:= StreamLifeNumChanged;
    // устанавливаем обработчик DatumDeleted
    OnStreamDatumDeleted:= StreamDatumDeleted;

    // устанавливаем обработчик получения данных
    OnStreamDataInserted:= StreamDataInserted;
    // устанавливаем обработчик удаления данных
    OnStreamDataDeleted:= StreamDataDeleted;
    // устанавливаем обработчик "конец данных"
    OnStreamDataEnd:= StreamDataEnd;
  end;

  fAggrStream  := TCP2DataStream.create(Self);
  with fAggrStream do begin
    // указываем режим открытия потока (в delphi слово type - ключевое, при импорте
    // библиотеки типов оно было автоматически переименовано
    type_:= RT_COMBINED_DYNAMIC;
    // задаем имя потока, например сделки по фьючерсам
    StreamName:= STREAM_AGGR_NAME;
    // устанавливаем обработчик изменения статуса потока (remote_snapshot, online...)
    OnStreamStateChanged:= StreamStateChanged;
    // устанавливаем обработчик смены номера жизни, он необходим для корректного
    // перехода потока в online
    OnStreamLifeNumChanged:= StreamLifeNumChanged;
    // устанавливаем обработчик DatumDeleted
    OnStreamDatumDeleted:= StreamDatumDeleted;

    // устанавливаем обработчик получения данных
    OnStreamDataInserted:= StreamDataInserted;
    // устанавливаем обработчик удаления данных
    OnStreamDataDeleted:= StreamDataDeleted;
    // устанавливаем обработчик "конец данных"
    OnStreamDataEnd:= StreamDataEnd;
  end;
end;

procedure TForm1.ProcessPlaza2Messages(Sender: TObject; var Done: Boolean);
const cs_connected = CS_CONNECTION_CONNECTED or CS_ROUTER_CONNECTED;
var cookie : longword;
begin
  // проверяем статус потока и переоткрываем его, если это необходимо
  if assigned(fConn) and (fConn.Status and cs_connected = cs_connected) then begin
    CheckAndReopen(fInfoStream);
    CheckAndReopen(fAggrStream);
  end;

  // запускаем обработку сообщения plaza2
  cookie:= 0;
  if assigned(fConn) then fConn.ProcessMessage(cookie, 1);

  // указываем, что обработка не завершена, для того чтобы vcl не уходил в ожидание сообщений windows
  Done:= false;
end;

function TForm1.CheckAndReopen(AStream: TCP2DataStream): boolean;
begin
  // проверка и переоткрытие потока
  result:= true;
  if assigned(AStream) then
    with AStream do try
      // если статус потока - ошибка или закрыт
      if (State = DS_STATE_ERROR) or (State = DS_STATE_CLOSE) then begin
        // ксли ошибка, то закрываем
        if (State = DS_STATE_ERROR) then Close;
        // далее пытаемся открыть его вновь
        if assigned(fConn) then Open(fConn.DefaultInterface);
      end;
    except result:= false; end;
end;

procedure TForm1.ConnectionStatusChanged(Sender: TObject; var conn: OleVariant; newStatus: TConnectionStatus);
begin
  // выводим сообщение об изменении статуса соединения
  log('Статус соединения изменился на: %.8x', [longint(newStatus)]);
end;

procedure TForm1.StreamStateChanged(Sender: TObject; var stream: OleVariant; newState: TDataStreamState);
const state_unknown = -1;
const streamstates: array[state_unknown..DS_STATE_ERROR] of pChar = ('UNKNOWN', 'DS_STATE_CLOSE',
        'DS_STATE_LOCAL_SNAPSHOT', 'DS_STATE_REMOTE_SNAPSHOT', 'DS_STATE_ONLINE', 'DS_STATE_CLOSE_COMPLETE',
        'DS_STATE_REOPEN', 'DS_STATE_ERROR');
var   st: longint;
begin
  // выводим сообщение об изменении статуса потока
  st:= newState;
  if (st <= low(streamstates)) or (st > high(streamstates)) then st:= state_unknown;
  log('Поток %s статус изменился на %s (%.8x)', [stream.StreamName, streamstates[st], st]);
end;

procedure TForm1.StreamLifeNumChanged(Sender: TObject; var stream: OleVariant; LifeNum: Integer);
var strmname : string;
begin
  // при изменении номера жизни потока, указываем потоку новый номер жизни
  stream.TableSet.LifeNum:= olevariant(lifenum);

  strmname:= string(stream.StreamName);
  // очищаем таблицы, согласно документации
  if (CompareText(strmname, STREAM_INFO_NAME) = 0) then begin
    InstrumentComboBox.Items.Clear;
  end else 
  if (CompareText(strmname, STREAM_AGGR_NAME) = 0) then begin
    if assigned(OrderBookList) then OrderBookList.Clear;
  end;

  // выводим сообщение об этом
  log('Поток %s LifeNum изменился на: %d', [strmname, lifenum]);
end;

procedure TForm1.StreamDataInserted(Sender: TObject; var stream, tableName, rec: OleVariant);
var isin_id, idx : longint;
    strmname, tblname : string;
begin
  if (StrToInt64Def(rec.GetValAsString('replAct'), 1) = 0) then begin
    strmname := string(stream.StreamName);
    tblname  := string(tableName);
    // обработка пришедших данных
    if (CompareText(strmname, STREAM_INFO_NAME) = 0) then begin
      // поток INFO
      if (CompareText(tblname, TABLE_FUTSESS_NAME) = 0) then begin
        // таблица fut_sess_contents, формируем список инструментов
        isin_id:= rec.GetValAsString('isin_id');
        with InstrumentComboBox.Items do begin
          // добавляем инструмент combobox, если его там еще нет
          idx:= IndexOfObject(pointer(isin_id));
          if (idx < 0) then
            Objects[Add(format('%s [%s]', [rec.GetValAsString('short_isin'), rec.GetValAsString('name')]))]:= pointer(isin_id);
        end;
      end;
    end else
    if (CompareText(strmname, STREAM_AGGR_NAME) = 0) then begin
      // поток AGGR
      if (CompareText(tblname, TABLE_AGGR_NAME) = 0) then begin
        // добавляем строку в один из стаканов
        if assigned(OrderBookList) then OrderBookList.addrecord(rec.GetValAsLong('isin_id'),
                                                                StrToInt64Def(rec.GetValAsString('replID'), 0),
                                                                StrToInt64Def(rec.GetValAsString('replRev'), 0),
                                                                _StrToFloatDef(rec.GetValAsString('price'), 0),
                                                                _StrToFloatDef(rec.GetValAsString('volume'), 0),
                                                                rec.GetValAsLong('dir'));
      end;

    end;
  end;
end;

procedure TForm1.StreamDataDeleted(Sender: TObject; var stream, tableName: OleVariant; Id: Int64; var rec: OleVariant);
var strmname, tblname : string;
begin
  strmname := string(stream.StreamName);
  tblname  := string(tableName);
  if (CompareText(strmname, STREAM_AGGR_NAME) = 0) then begin
    // поток AGGR
    if (CompareText(tblname, TABLE_AGGR_NAME) = 0) then begin
      // удаляем строку из одного из стаканов
      if assigned(OrderBookList) then OrderBookList.delrecord(Id);
    end;
  end;
end;

procedure TForm1.StreamDatumDeleted(Sender: TObject; var stream, tableName: OleVariant; rev: Int64);
var strmname, tblname : string;
begin
  strmname := string(stream.StreamName);
  tblname  := string(tableName);
  if (CompareText(strmname, STREAM_AGGR_NAME) = 0) then begin
    // поток AGGR
    if (CompareText(tblname, TABLE_AGGR_NAME) = 0) then begin
      // удаляем строки из всех стаканов с ревиженом меньше заданного
      if assigned(OrderBookList) then OrderBookList.clearbyrev(rev);
      // перерисовываем стакан
      RedrawOrderBook(false);
    end;
  end;
end;

procedure TForm1.StreamDataEnd(Sender: TObject; var stream: OleVariant);
var strmname : string;
begin
  strmname := string(stream.StreamName);
  if (CompareText(strmname, STREAM_AGGR_NAME) = 0) then begin
    // если закончился прием изменений потока AGGR, перерисовываем стакан
    RedrawOrderBook(false);
  end;
end;


procedure TForm1.ConnectButtonClick(Sender: TObject);
begin
  // установление соединения по кнопке connect

  // при импорте библиотеки типов метод Connect был автоматически переименован в
  // Connect1 для того, чтобы избежать пересечения со стандартным методом Connect
  // Ole-сервера дельфи
  if assigned(fConn) then try
    fConn.Connect1;
  except
    on e: exception do log('Исключение при попытке соединения: %s', [e.message]);
  end;
end;

procedure TForm1.DisconnectButtonClick(Sender: TObject);
begin
  // разрыв соединения по кнопке disconnect

  // при импорте библиотеки типов метод Disconnect был автоматически переименован в
  // Disconnect1 для того, чтобы избежать пересечения со стандартным методом Disconnect
  // Ole-сервера дельфи
  if assigned(fConn) then try
    fConn.Disconnect1;
  except
    on e: exception do log('Исключение при разрыве соединения: %s', [e.message]);
  end;
end;

procedure TForm1.log(const alogstr: string);
begin
  // вывод информации в LogListBox
  if assigned(LogListBox) then with LogListBox.Items do begin
    // храним только 50 строк
    if (Count > 50) then Delete(Count - 1);
    // добавляем строки в начало
    Insert(0, formatdatetime('hh:nn:ss.zzz ', fPreciseTime.Now) + alogstr);
  end;
end;

procedure TForm1.log(const alogstr: string; const aparams: array of const);
begin
  // вывод лога с форматированием строки
  log(format(alogstr, aparams));
end;

procedure TForm1.InstrumentComboBoxChange(Sender: TObject);
begin
  // переключаем инструмент в стакане
  if assigned(Sender) and (Sender is TComboBox) then begin
    with TComboBox(Sender) do begin
      // если в комбобоксе что-то выбрано, то устанавливаем isin_id для отрисовывания гридом,
      // если нет, присваиваем -1
      if ItemIndex >= 0 then OrderBookGrid.Tag:= longint(Items.Objects[ItemIndex])
                        else OrderBookGrid.Tag:= -1;
    end;
    // принудительно перерисовываем стакан
    RedrawOrderBook(true);
  end;
end;

procedure TForm1.RedrawOrderBook(forceredraw: boolean);
var   itm : tOrderBook;
      i   : longint;
const bsn : array[boolean] of longint = (0, 2);
  // очистка грида
  procedure ClearGrid;
  var i : longint;
  begin
    // устанавливаем кол-во строк = 1
    OrderBookGrid.RowCount:= 1;
    // очищаем ячейки строки
    for i:= 0 to OrderBookGrid.ColCount - 1 do OrderBookGrid.Cells[i, 0]:= '';
  end;
begin
  // если установлен isin_id для отрисовки
  if (OrderBookGrid.Tag >= 0) then begin
    if assigned(OrderBookList) then begin
      // ищем стакан, соответствующий isin_id
      itm:= OrderBookList.searchadditem(OrderBookGrid.Tag);
      // если он есть и изменился либо принудительная отрисовка
      if assigned(itm) and (forceredraw or itm.changed) then with itm do begin
        // если стакан не пуст
        if Count > 0 then begin
          // устанавливаем кол-во строк в гриде
          OrderBookGrid.RowCount:= Count;
          // заполняем ячейки грида
          for i:= 0 to Count - 1 do
            with pOrderBookItem(items[i])^ do begin
              // заполняем цену
              OrderBookGrid.Cells[1, i]:= FloatToStr(price);
              // помещаем кол-во справа или слева от цены, в зависимости от buysell
              OrderBookGrid.Cells[bsn[(buysell and 1 = 1)], i]     := FloatToStr(volume);
              // противоположную ячейку очищаем
              OrderBookGrid.Cells[bsn[not (buysell and 1 = 1)], i] := '';
            end;
        end else ClearGrid;
        changed:= false;
      end;
    end;
  end else ClearGrid;
end;

initialization
  // нужно для корректного перевода из строк, возвращаемых методом GetValAsString, в числа
  decimalseparator:= '.';

  // инициализируем COM
  CoInitializeEx(nil, COINIT_APARTMENTTHREADED);

finalization
  CoUnInitialize;

end.
