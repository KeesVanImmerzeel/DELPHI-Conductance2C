unit uConductance2C;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, uerror, AVGRIDIO,
  uTabstractESRIgrid, uTSingleESRIgrid;

type
  TForm3 = class(TForm)
    Button1: TButton;
    SingleESRIgridConductance: TSingleESRIgrid;
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form3: TForm3;

implementation
{$R *.dfm}

procedure TForm3.Button1Click(Sender: TObject);
var
  filename1, filename2, filename3: string;
  iResult, nrows, ncols, i, j: Integer;
  conductance, cbodem: Single;
  CellArea: Double;
begin
  filename1 := paramstr(1); {Conductance}
  filename2 := paramstr(2); {c-waarden}
  if ( ParamCount = 3 ) then
    filename3 := paramstr(3);

  SingleESRIgridConductance := TSingleESRIgrid.InitialiseFromIDFfile( filename1, iResult, self );

  nrows:=SingleESRIgridConductance.NRows;
  ncols:=SingleESRIgridConductance.NCols;

  CellArea := SingleESRIgridConductance.CellArea;
  for i := 1 to NRows do
    for j := 1 to NCols do begin
      if not SingleESRIgridConductance.IsMissing(i,j) then begin
        conductance := SingleESRIgridConductance[ i, j];
        if conductance > 0 then begin
          cbodem := CellArea / conductance ;
          SingleESRIgridConductance[ i, j] := cbodem;
        end; {-if conductance > 0}
      end; {-for j}
    end; {-for i}
  SingleESRIgridConductance.ExportToIDFfile( filename2 );
  if ( ParamCount = 3 ) then
    SingleESRIgridConductance.SaveAsInteger( filename3 );
end;

procedure TForm3.FormCreate(Sender: TObject);
begin
InitialiseLogFile;
InitialiseGridIO;
end;

procedure TForm3.FormDestroy(Sender: TObject);
begin
FinaliseLogFile;
end;

end.
