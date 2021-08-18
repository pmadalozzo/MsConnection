unit MsRegister;

interface

uses
  MsConnection.Interfaces,
  MsConnection;

type
  TMsRegister = class(Tinterfacedobject, iRegister)
    private
      [weak]
      FParent : TMsConnection;
      FDriver: string;
      FPort: string;
      FPass: string;
      FDatabase: string;
      FDll: string;
      FHost: string;
      FUser: string;
    public
      constructor Create(Parent : TMsConnection);
      destructor Destroy; override;

      function Host(aValue : string) : iRegister; overload;
      function Host : string; overload;
      function User(aValue : string) : iRegister; overload;
      function User : string; overload;
      function Dll(aValue : string) : iRegister; overload;
      function Dll : string; overload;
      function Database(aValue : string) : iRegister; overload;
      function Database : string; overload;
      function Pass(aValue : string) : iRegister; overload;
      function Pass : string; overload;
      function Port(aValue : integer) : iRegister; overload;
      function Port : string; overload;
      function Driver(aValue : string) : iRegister; overload;
      function Driver : string; overload;

      function &End : iMsConnection;
  end;

var
  aMsRegister : TMsRegister;

implementation

{ TMsRegister }

uses
  LocalCache4D,
  System.SysUtils;

function TMsRegister.&End: iMsConnection;
begin
  Result:= FParent;
end;

function TMsRegister.Host: string;
begin
  result:= FHost;
end;

function TMsRegister.Pass: string;
begin
  result:= FPass;
end;

function TMsRegister.Pass(aValue: string): iRegister;
begin
  Result:= Self;
  FPass:= aValue;
end;

function TMsRegister.Port: string;
begin
  result:= FPort;
end;

function TMsRegister.Port(aValue: integer): iRegister;
begin
  Result:= Self;
  FPort:= inttostr(aValue);
end;

function TMsRegister.User(aValue: string): iRegister;
begin
  Result:= Self;
  FUser:= aValue;
end;

function TMsRegister.User: string;
begin
  Result:= FUser;
end;

function TMsRegister.Host(aValue: string): iRegister;
begin
  Result:= Self;
  FHost:= aValue;
end;

constructor TMsRegister.Create(Parent : TMsConnection);
begin
  if not Assigned(FParent) then
    FParent:= Parent;

//  LocalCache.LoadDatabase('D:\Componentes\Madalozzo\MsConnection\Config\MsConfig.lc4');
//
//  FHost:= LocalCache.Instance('Database').GetItem('host');
//  FPort:= LocalCache.Instance('Database').GetItem('port');
//  FUser:= LocalCache.Instance('Database').GetItem('user');
//  FPass:= LocalCache.Instance('Database').GetItem('pass');
//  FDatabase:= LocalCache.Instance('Database').GetItem('database');
//  FDriver:= LocalCache.Instance('Database').GetItem('driver');
//  FDll:= LocalCache.Instance('Database').GetItem('dll');
end;

function TMsRegister.Database(aValue: string): iRegister;
begin
  Result:= Self;
  FDatabase:= aValue;
end;

function TMsRegister.Database: string;
begin
  Result:= FDatabase;
end;

destructor TMsRegister.Destroy;
begin

  inherited;
end;

function TMsRegister.Dll: string;
begin
  Result:= FDll;
end;

function TMsRegister.Dll(aValue: string): iRegister;
begin
  Result:= Self;
  FDll:= aValue;
end;

function TMsRegister.Driver: string;
begin
  Result:= FDriver;
end;

function TMsRegister.Driver(aValue: string): iRegister;
begin
  Result:= Self;
  FDriver:= aValue;
end;

end.
