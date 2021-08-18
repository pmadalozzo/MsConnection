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
  end;

implementation

end.
