unit MsConnection.Interfaces;

interface

uses
  Model.Components.Interfaces;

type
  iRegister = interface;

  iMsConnection = interface
    ['{6478C4B6-1FDC-4EDD-9508-10E66DAF2531}']
    function Component : iModelComponentsFactory;
    function RowsetSize(aValue : integer = 50) : iMsConnection;
    function Host(aValue : string) : iMsConnection;
    function Port(aValue : string) : iMsConnection;
    function This : iRegister;
  end;

  iRegister = interface
    ['{FE7084A4-0F10-4750-B73A-5DF8D92F0337}']
    function &End : iMsConnection;
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
  end;

implementation

end.
