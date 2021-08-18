unit Model.Components.Factory;

interface

uses
  Model.Components.Interfaces,
  Model.Components.Connections.Interfaces;

type
  TModelComponentsConnectionFactory = class(TInterfacedObject, iModelComponentsFactory)
   private
     FConnection : iModelComponentsConnections;
     FRowsetSize : integer;
   public
     constructor create;
     destructor Destroy; override;
     class function New : iModelComponentsFactory;
     function Connection : iModelComponentsConnections;
     function RowsetSize(aValue : integer = 50) : iModelComponentsFactory;
  end;

implementation

{ TModelComponentsConnectionFactory }

uses
  Model.Components.Connections.Firedac;
//  Model.Components.Connections.Unidac;

function TModelComponentsConnectionFactory.Connection: iModelComponentsConnections;
begin
  if not Assigned(FConnection) then
    FConnection:= TModelComponentsConnectionsFiredac.New(FRowsetSize);

                //TModelComponentsConnectionUnidac.New;
                //TModelComponentsConnectionsFiredac
  Result:= FConnection;
end;

constructor TModelComponentsConnectionFactory.create;
begin

end;

destructor TModelComponentsConnectionFactory.Destroy;
begin

  inherited;
end;

class function TModelComponentsConnectionFactory.New: iModelComponentsFactory;
begin
  Result:= self.create;
end;

function TModelComponentsConnectionFactory.RowsetSize(aValue: integer): iModelComponentsFactory;
begin
  result:= Self;
  FRowsetSize:= aValue;
end;

end.
