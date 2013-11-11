program p2_baseless_VCL_orderbook_example;

uses
  Forms,
  p2_baseless_VCL_orderbook_example_main;

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
