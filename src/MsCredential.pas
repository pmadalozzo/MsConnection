unit MsCredential;

interface

uses
  MsConnection.Interfaces;

type
  TMsCredential = class(TInterfacedObject, iMsCredential)
    private
      [weak]
      FParent : iMsConnection;
      FDriver: string;
      FPort: string;
      FPass: string;
      FDatabase: string;
      FDll: string;
      FHost: string;
      FUser: string;
    public
      Constructor Create(Parent : iMsConnection);
      Destructor Destroy; override;
      class Function New(Parent : iMsConnection) : iMSCredential;
      function Host(aValue : string) : iMsCredential; overload;
      function Host : string; overload;
      function User(aValue : string) : iMsCredential; overload;
      function User : string; overload;
      function Dll(aValue : string) : iMsCredential; overload;
      function Dll : string; overload;
      function Database(aValue : string) : iMsCredential; overload;
      function Database : string; overload;
      function Pass(aValue : string) : iMsCredential; overload;
      function Pass : string; overload;
      function Port(aValue : integer) : iMsCredential; overload;
      function Port : string; overload;
      function Driver(aValue : string) : iMsCredential; overload;
      function Driver : string; overload;
      function &End : iMsConnection;
  end;

implementation

uses
  System.SysUtils;

{ TMsCredential }

Constructor TMsCredential.Create(Parent : iMsConnection);
begin
  FParent:= Parent;
end;

function TMsCredential.Database: string;
begin
  Result:= FDataBase;
end;

function TMsCredential.Database(aValue: string): iMsCredential;
begin
  Result:= Self;
  FDatabase:= aValue;
end;

destructor TMsCredential.Destroy;
begin

  inherited;
end;

function TMsCredential.Dll: string;
begin
  Result:= FDll;
end;

function TMsCredential.Dll(aValue: string): iMsCredential;
begin
  Result:= Self;
  FDll:= aValue;
end;

function TMsCredential.Driver: string;
begin
  Result:= FDriver;
end;

function TMsCredential.Driver(aValue: string): iMsCredential;
begin
  Result:= Self;
  FDriver:= aValue;
end;

function TMsCredential.&End: iMsConnection;
begin
  Result:= FParent;
end;

function TMsCredential.Host(aValue: string): iMsCredential;
begin
  Result:= Self;
  FHost:= aValue;
end;

function TMsCredential.Host: string;
begin
  Result:= FHost;
end;

class Function TMsCredential.New(Parent : iMsConnection) : iMSCredential;
begin
  Result:= Self.Create(Parent);
end;

function TMsCredential.Pass(aValue: string): iMsCredential;
begin
  Result:= Self;
  FPass:= aValue;
end;

function TMsCredential.Pass: string;
begin
  Result:= FPass;
end;

function TMsCredential.Port(aValue: integer): iMsCredential;
begin
  Result:= Self;
  FPort:= inttostr(aValue);
end;

function TMsCredential.Port: string;
begin
  Result:= FPort;
end;

function TMsCredential.User(aValue: string): iMsCredential;
begin
  Result:= Self;
  FUser:= aValue;
end;

function TMsCredential.User: string;
begin
  Result:= FUser;
end;

end.
