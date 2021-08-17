unit Model.Components.Interfaces;

interface

uses
  Model.Components.Connections.Interfaces;

type
  iModelComponentsFactory = interface
   ['{72DC06C9-0892-498C-8415-7634D8A7E89B}']
   function Connection : iModelComponentsConnections;
   function RowsetSize(aValue : integer = 50) : iModelComponentsFactory;
  end;

implementation

end.
