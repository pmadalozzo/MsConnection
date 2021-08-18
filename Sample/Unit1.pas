unit Unit1;

interface

uses
  Winapi.Windows,
  Winapi.Messages,
  System.SysUtils,
  System.Variants,
  System.Classes,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,
  Vcl.StdCtrls,
  MsConnection,
  MsConnection.Interfaces,
  Data.DB,
  Vcl.Grids,
  Vcl.DBGrids;

type
  TForm1 = class(TForm)
    Button1: TButton;
    DataSource1: TDataSource;
    DBGrid1: TDBGrid;
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    FMsConn : iMsConnection;
    FIndex : integer;
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}


procedure TForm1.Button1Click(Sender: TObject);
begin
  FMsConn
   .Connection
    .Close
     .Clear
      .SQL('select * from enti ')
     .Open;

end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  if not Assigned(FMsConn) then
     FMsConn := TMSConnection.New;

//  FIndex:= FMsConn.Connection.Connected;
//  DataSource1.DataSet:= FMsConn.Connection.DataSet;
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
  FMsConn
    .Connection
     .Disconnect(FIndex);
end;

end.
