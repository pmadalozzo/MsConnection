unit MsConnection.Interfaces;

interface

uses
  System.Classes,
  Data.DB;

type
  iMsCredential = interface;
  iComponentsConnections = interface;

  iMsConnection = interface
    ['{6478C4B6-1FDC-4EDD-9508-10E66DAF2531}']
    function RowsetSize(aValue : integer = 50) : iMsConnection;
    function Connection : iComponentsConnections;
    function Credential : iMsCredential;
  end;

  iMsCredential = interface
    ['{FE7084A4-0F10-4750-B73A-5DF8D92F0337}']
    function &End : iMsConnection;
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
  end;

  iComponentsConnections = interface
   ['{EC0BF578-4E32-4178-9D22-E0846645FE31}']
   function AddParam(aParam : string; aValue : Variant) : iComponentsConnections; overload;
   function AddParam(aParam : string; aValue : TPersistent) : iComponentsConnections; overload;
   function Close : iComponentsConnections;
   function Clear : iComponentsConnections;
   function DataSet : TDataSet;
   function Disconnect (aIndexConn : integer) : iComponentsConnections;
   function Connected : integer;
   function ExecSQL : iComponentsConnections;
   function IndexConn : integer;
   function Open : iComponentsConnections;
   function SQL (aValue : string) : iComponentsConnections;
   function Isempty : boolean;
   function &End : iMsConnection;
  end;

implementation

end.
