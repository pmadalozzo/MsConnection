unit Model.Components.Connections.Interfaces;

interface

uses
  Data.DB,
  System.Classes;

type
  iModelComponentsConnections = interface
   ['{EC0BF578-4E32-4178-9D22-E0846645FE31}']
   function AddParam(aParam : string; aValue : Variant) : iModelComponentsConnections; overload;
   function AddParam(aParam : string; aValue : TPersistent) : iModelComponentsConnections; overload;
   function Close : iModelComponentsConnections;
   function Clear : iModelComponentsConnections;
   function DataSet : TDataSet;
   function Disconnect (aIndexConn : integer) : iModelComponentsConnections;
   function Connected : integer;
   function ExecSQL : iModelComponentsConnections;
   function IndexConn : integer;
   function Open : iModelComponentsConnections;
   function SQL (aValue : string) : iModelComponentsConnections;
   function Isempty : boolean;
  end;

implementation

end.
