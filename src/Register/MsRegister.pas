unit MsRegister;

interface

type
  TMsRegister = class
    private
      FDriver: string;
      FPort: string;
      FPass: string;
      FDatabase: string;
      FDll: string;
      FHost: string;
      FUser: string;
      procedure SetDatabase(const Value: string);
      procedure SetDll(const Value: string);
      procedure SetDriver(const Value: string);
      procedure SetHost(const Value: string);
      procedure SetPass(const Value: string);
      procedure SetPort(const Value: string);
      procedure SetUser(const Value: string);
      function GetDatabase: string;
      function GetDll: string;
      function GetDriver: string;
      function GetHost: string;
      function GetPass: string;
      function GetPort: string;
      function GetUser: string;
    public
      constructor Create;
      destructor Destroy; override;

      property Host : string read GetHost write SetHost;
      property Port : string read GetPort write SetPort;
      property User : string read GetUser write SetUser;
      property Pass : string read GetPass write SetPass;
      property Database : string read GetDatabase write SetDatabase;
      property Driver : string read GetDriver write SetDriver;
      property Dll : string read GetDll write SetDll;
  end;

var
  aMsRegister : TMsRegister;

implementation

{ TMsRegister }

uses
  LocalCache4D,
  System.SysUtils;

constructor TMsRegister.Create;
begin
  LocalCache.LoadDatabase('D:\Componentes\Madalozzo\MsConnection\Config\MsConfig.lc4');

  FHost:= LocalCache.Instance('Database').GetItem('host');
  FPort:= LocalCache.Instance('Database').GetItem('port');
  FUser:= LocalCache.Instance('Database').GetItem('user');
  FPass:= LocalCache.Instance('Database').GetItem('pass');
  FDatabase:= LocalCache.Instance('Database').GetItem('database');
  FDriver:= LocalCache.Instance('Database').GetItem('driver');
  FDll:= LocalCache.Instance('Database').GetItem('dll');
end;

destructor TMsRegister.Destroy;
begin

  inherited;
end;

function TMsRegister.GetDatabase: string;
begin
  Result:= FDatabase;

  if Result = '' then
    raise Exception.Create('Não foi possivel carregar o parametro "Database", favor verificar !!!');
end;

function TMsRegister.GetDll: string;
begin
  Result:= FDll;

  if Result = '' then
    raise Exception.Create('Não foi possivel carregar o parametro "DLL", favor verificar !!!');
end;

function TMsRegister.GetDriver: string;
begin
  Result:= FDriver;

  if Result = '' then
    raise Exception.Create('Não foi possivel carregar o parametro "Driver", favor verificar !!!');
end;

function TMsRegister.GetHost: string;
begin
  Result:= FHost;

  if Result = '' then
    raise Exception.Create('Não foi possivel carregar o parametro "Host", favor verificar !!!');
end;

function TMsRegister.GetPass: string;
begin
  result:= FPass;

  if Result = '' then
    raise Exception.Create('Não foi possivel carregar o parametro "Pass", favor verificar !!!');
end;

function TMsRegister.GetPort: string;
begin
  Result:= FPort;

  if Result = '' then
    raise Exception.Create('Não foi possivel carregar o parametro "Port", favor verificar !!!');
end;

function TMsRegister.GetUser: string;
begin
  Result:= FUser;

  if Result = '' then
    raise Exception.Create('Não foi possivel carregar o parametro "User", favor verificar !!!');
end;

procedure TMsRegister.SetDatabase(const Value: string);
begin
  FDatabase := Value;
end;

procedure TMsRegister.SetDll(const Value: string);
begin
  FDll := Value;
end;

procedure TMsRegister.SetDriver(const Value: string);
begin
  FDriver := Value;
end;

procedure TMsRegister.SetHost(const Value: string);
begin
  FHost := Value;
end;

procedure TMsRegister.SetPass(const Value: string);
begin
  FPass := Value;
end;

procedure TMsRegister.SetPort(const Value: string);
begin
  FPort := Value;
end;

procedure TMsRegister.SetUser(const Value: string);
begin
  FUser := Value;
end;

initialization
  aMsRegister := TMsRegister.Create;

finalization
  aMsRegister.Free;

end.
