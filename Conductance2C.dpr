program Conductance2C;

uses
  Vcl.Forms,
  uConductance2C in 'uConductance2C.pas' {Form3};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm3, Form3);
  {Application.Run;}
  Form3.Button1.Click;
end.
