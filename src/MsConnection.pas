unit MsConnection;

interface

uses
  MsConnection.Interfaces,
  Vcl.Forms;

type
  TMsConnection = class(TInterfacedObject, iMsConnection)
    private
      FCredential : iMsCredential;
      FConnection : iComponentsConnections;

      FRowsetSize : integer;
    public
      constructor Create;
      destructor Destroy; override;
      class function New : iMsConnection;
      function Credential : iMsCredential;
      function Connection : iComponentsConnections;

      function RowsetSize(aValue : integer = 50) : iMsConnection;
  end;

var
  vMsConnection : iMsConnection;

implementation

uses
  MsCredential,
  Components.Firedac,
  Components.Unidac;

{ TMsConnection }

function TMsConnection.Connection: iComponentsConnections;
begin
  if not Assigned(FConnection) then
    FConnection:= TComponentsFiredac.New(Self);

  Result:= FConnection;
end;

constructor TMsConnection.Create;
begin

end;

function TMsConnection.Credential: iMsCredential;
begin
  if not Assigned(FCredential) then
    FCredential:= TMsCredential.New(Self);

  Result:= FCredential;
end;

destructor TMsConnection.Destroy;
begin

  inherited;
end;

class function TMsConnection.New : iMsConnection;
begin
  if not Assigned(vMsConnection) then
    vMsConnection := Self.Create;

  Result := vMsConnection;
end;

function TMsConnection.RowsetSize(aValue: integer): iMsConnection;
begin
  result:= Self;
  FRowsetSize:= aValue;
end;


end.
