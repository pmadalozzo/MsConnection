unit MsConnection.Interfaces;

interface

uses
  Model.Components.Interfaces, MsRegister;

type
  iMsConnection = interface
    ['{6478C4B6-1FDC-4EDD-9508-10E66DAF2531}']
    function Component : iModelComponentsFactory;
    function RowsetSize(aValue : integer = 50) : iMsConnection;
    function Host(aValue : string) : iMsConnection;
    function Port(aValue : string) : iMsConnection;
    function This : TMsRegister;
  end;

implementation

end.
