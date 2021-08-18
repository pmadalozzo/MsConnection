unit Service;

interface

type
  TService = class
    private
      procedure RegisterMsConnection;
    public
      constructor Create;
      destructor Destroy; override;

  end;

var
  aService : TService;

implementation

uses
  MsConnection,
  LocalCache4D,
  System.SysUtils;

{ TService }

constructor TService.Create;
begin
  RegisterMsConnection;
end;

destructor TService.Destroy;
begin

  inherited;
end;

procedure TService.RegisterMsConnection;
begin
  LocalCache.LoadDatabase('D:\Componentes\Madalozzo\MsConnection\Config\MsConfig.lc4');

  TMsConnection
    .New
     .Credential
      .Host(LocalCache.Instance('Database').GetItem('host'))
      .Port(strtoint(LocalCache.Instance('Database').GetItem('port')))
      .User(LocalCache.Instance('Database').GetItem('user'))
      .Pass(LocalCache.Instance('Database').GetItem('pass'))
      .Database(LocalCache.Instance('Database').GetItem('database'))
      .Driver(LocalCache.Instance('Database').GetItem('driver'))
      .Dll(LocalCache.Instance('Database').GetItem('dll'))
      .RowsetSize(LocalCache.Instance('Database').GetItem('rowsetsize'))
     .&End;
end;

initialization
  aService := TService.Create;
finalization
  aService.Free;

end.
