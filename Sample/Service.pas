unit Service;

interface

type
  TService = class
    private
    public
      constructor Create;
      destructor Destroy; override;

  end;

var
  aService : TService;

implementation

uses
  MsConnection;

{ TService }

constructor TService.Create;
begin

end;

destructor TService.Destroy;
begin

  inherited;
end;

initialization
  aService := TService.Create;
finalization
  aService.Free;

end.
