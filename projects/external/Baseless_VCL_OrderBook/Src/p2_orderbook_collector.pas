unit p2_orderbook_collector;

interface

uses  windows, classes, sysutils;

type  tDuplicates     = (dupAccept, dupIgnore, dupReplace);

      // базовый класс "список" с поддержкой автоматического освобождения элементов
type  tCustomList     = class(tList)
        procedure   clear; override;
        procedure   freeitem(item: pointer); virtual; abstract;
        procedure   freeall; virtual;
        procedure   delete(index: longint); virtual;
        procedure   remove(item: pointer); virtual;
        function    extract(item: pointer): pointer; virtual;
      end;

      // базовый класс "сортированный список"
type  tSortedList     = class(tCustomList)
        fDuplicates   : tDuplicates;
        constructor create;
        function    checkitem(item: pointer): boolean; virtual; abstract;
        function    compare(item1, item2: pointer): longint; virtual; abstract;
        function    search(item: pointer; var index: longint): boolean; virtual;
        procedure   add(item: pointer); virtual;
        procedure   insert(index: longint; item: pointer); virtual;
      end;

      // индекс стакана по цене
type  tOrderBook      = class(tSortedList)
      private
        fisin_id      : longint;
        fchanged      : boolean;
      public
        procedure   freeitem(item: pointer); override;
        function    checkitem(item: pointer): boolean; override;
        function    compare(item1, item2: pointer): longint; override;

        procedure   add(item: pointer); override;
        procedure   remove(item: pointer); override;

        property    isin_id: longint read fisin_id;
        property    changed: boolean read fchanged write fchanged;
      end;

      // элемент "строка в стакане"
type  pOrderBookItem  = ^tOrderBookItem;
      tOrderBookItem  = record
        recid         : int64;
        recrev        : int64;
        price         : double;  // цена
        volume        : double;  // кол-во
        buysell       : longint; // покупка/продажа
        priceidx      : tOrderBook;
      end;

      // список стаканов
type  tPriceLists     = class(tSortedList)
      private
        tmp_ordbook   : tOrderBook;
      public
        destructor  destroy; override;
        procedure   freeitem(item: pointer); override;
        function    checkitem(item: pointer): boolean; override;
        function    compare(item1, item2: pointer): longint; override;
        function    searchadditem(aisin_id: longint): tOrderBook;
      end;

      // общая таблица котировок
type  tOrderBookList  = class(tSortedList)
        fOrderBooks   : tPriceLists;
        constructor create;
        destructor  destroy; override;
        procedure   freeitem(item: pointer); override;
        function    checkitem(item: pointer): boolean; override;
        function    compare(item1, item2: pointer): longint; override;
        function    searchadditem(aisin_id: longint): tOrderBook;
        function    addrecord(aisin_id: longint; const aid, arev: int64; const aprice, avolume: double; abuysell: longint): boolean;
        function    delrecord(const aid: int64): boolean;
        procedure   clearbyrev(const arev: int64);
      end;

var   OrderBookList   : tOrderBookList;

implementation

function  cmpi64(a, b: int64): longint;
begin
  a:= a - b;
  if a < 0 then result:= -1 else
  if a > 0 then result:= 1  else result:= 0;
end;

function  cmpdouble(const a, b: double): longint;
var r : real;
begin
  r:= a - b;
  if r < 0 then result:= -1 else
  if r > 0 then result:= 1  else result:= 0;
end;

{ tCustomList }

procedure tCustomList.clear;
var i : longint;
begin for i:= 0 to count - 1 do freeitem(items[i]); inherited clear; end;

procedure tCustomList.freeall;
begin clear; end;

procedure tCustomList.delete(index: longint);
begin freeitem(items[index]); inherited delete(index); end;

procedure tCustomList.remove(item: pointer);
begin freeitem(item); inherited remove(item); end;

function tCustomList.extract(item: pointer): pointer;
var i : longint;
begin
  i:= indexof(item);
  if (i >= 0) then begin
    result:= item;
    inherited delete(i);
    notify(result, lnExtracted);
  end else result:= nil;
end;

{ tSortedList }

constructor tSortedList.create;
begin
  inherited create;
  fduplicates:=dupAccept;
end;

function tSortedList.search(item: pointer; var index: longint): boolean;
var l, h, i, c : longint;
begin
  result:= false;
  l:= 0;
  h:= count - 1;
  while (l <= h) do begin
    i:= (l + h) shr 1;
    c:= compare(items[i], item);
    if (c < 0) then l:= i + 1
    else begin
      h:= i - 1;
      if (c = 0) then begin
         result:= true;
         if (fDuplicates = dupIgnore) or (fDuplicates = dupReplace) then l:= i;
      end;
    end;
  end;
  index:= l;
end;

procedure tSortedList.add(item: pointer);
var index : longint;
begin
  if checkitem(item) then begin
    if search(item,index) then begin
      case fDuplicates of
        dupAccept  : insert(index, item);
        dupIgnore  : freeitem(item);
        dupReplace : begin freeitem(items[index]); items[index]:= item; end;
      end;
    end else insert(index, item);
  end else freeitem(item);
end;

procedure tSortedList.insert(index: longint; item: pointer);
begin if checkitem(item) then inherited insert(index, item); end;

{ tOrderBook }

procedure tOrderBook.freeitem(item: pointer);
begin end;

function tOrderBook.checkitem(item: pointer): boolean;
begin result:= assigned(item) and (pOrderBookItem(item)^.price > 0); end;

function tOrderBook.compare(item1, item2: pointer): longint;
begin
  result:= cmpdouble(pOrderBookItem(item1)^.price, pOrderBookItem(item2)^.price);
end;

procedure tOrderBook.add(item: pointer);
begin
  inherited add(item);
  fchanged:= true;
end;

procedure tOrderBook.remove(item: pointer);
begin
  inherited remove(item);
  fchanged:= true;
end;

{ tPriceLists }

destructor tPriceLists.destroy;
begin
  if assigned(tmp_ordbook) then freeandnil(tmp_ordbook);
  inherited destroy;
end;

procedure tPriceLists.freeitem(item: pointer);
begin if assigned(item) then tOrderBook(item).free; end;

function tPriceLists.checkitem(item: pointer): boolean;
begin result:= assigned(item); end;

function tPriceLists.compare(item1, item2: pointer): longint;
begin result:= tOrderBook(item1).isin_id - tOrderBook(item2).isin_id; end;

function tPriceLists.searchadditem(aisin_id: longint): tOrderBook;
var idx : longint;
begin
  if not assigned(tmp_ordbook) then tmp_ordbook:= tOrderBook.create;
  tmp_ordbook.fisin_id:= aisin_id;
  if not search(tmp_ordbook, idx) then begin
    result:= tOrderBook.create;
    result.fisin_id:= aisin_id;
    insert(idx, result);
  end else result:= tOrderBook(items[idx]);
end;

{ tOrderBookList }

constructor tOrderBookList.create;
begin
  inherited create;
  fOrderBooks:= tPriceLists.create;
end;

destructor tOrderBookList.destroy;
begin
  inherited destroy;
  if assigned(fOrderBooks) then freeandnil(fOrderBooks);
end;

procedure tOrderBookList.freeitem(item: pointer);
begin
  if assigned(item) then begin
     with pOrderBookItem(item)^ do begin
       if assigned(priceidx) then priceidx.remove(item);
     end;
     dispose(pOrderBookItem(item));
  end;
end;

function tOrderBookList.checkitem(item: pointer): boolean;
begin result:= assigned(item); end;

function tOrderBookList.compare(item1, item2: pointer): longint;
begin result:= cmpi64(pOrderBookItem(item1)^.recid, pOrderBookItem(item2)^.recid); end;

function  tOrderBookList.searchadditem(aisin_id: longint): tOrderBook;
begin if assigned(fOrderBooks) then result:= fOrderBooks.searchadditem(aisin_id) else result:= nil; end;

function tOrderBookList.addrecord(aisin_id: longint; const aid, arev: int64; const aprice, avolume: double; abuysell: longint): boolean;
var sitm     : tOrderBookItem;
    idx      : longint;
    itm      : pOrderBookItem;
    cf_price : boolean;
begin
  sitm.recid:= aid;
  result:= search(@sitm, idx);
  if not result then begin
    itm:= new(pOrderBookItem);
    with itm^ do begin
      recid    := aid;
      recrev   := arev;
      price    := aprice;
      volume   := avolume;
      buysell  := abuysell;
      if (price > 0) then begin
        priceidx:= searchadditem(aisin_id);
        if assigned(priceidx) then priceidx.add(itm);                 // добавляем в индекс
      end else priceidx:= nil;
    end;
    insert(idx, itm);                                                 // добавляем в стакан
  end else begin
    itm:= pOrderBookItem(items[idx]);

    cf_price  := (itm^.price <> aprice);                              // признак изменения цены

    if assigned(itm^.priceidx) then
      if cf_price then itm^.priceidx.remove(itm)                      // если изменилась цена, удаляем из индекса
                  else itm^.priceidx.changed:= true;                  // изменились другие параметры

    with itm^ do begin
      recrev  := arev;
      price   := aprice;
      volume  := avolume;
      buysell := abuysell;

      if cf_price then
        if (price > 0) then begin
          if not assigned(priceidx) then priceidx:= searchadditem(aisin_id);
          if assigned(priceidx) then priceidx.add(itm);               // добавляем в индекс
        end else priceidx:= nil;
    end;
  end;
end;

function tOrderBookList.delrecord(const aid: int64): boolean;
var itm : tOrderBookItem;
    idx : longint;
begin
  itm.recid:= aid;
  result:= search(@itm, idx);
  if result then delete(idx);                                         // удаляем из стакана
end;

procedure tOrderBookList.clearbyrev(const arev: int64);
var i   : longint;
    itm : pOrderBookItem;
begin
  for i:= count - 1 downto 0 do begin
    itm:= pOrderBookItem(items[i]);
    if (itm^.recrev < arev) then delete(i);                           // удаляем из стакана
  end;
end;

initialization
  OrderBookList:= tOrderBookList.create;

finalization
  if assigned(OrderBookList) then freeandnil(OrderBookList);

end.