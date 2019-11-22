unit Model.ServerMethods;

interface

uses System.SysUtils, System.Classes, System.Json, Datasnap.DSServer, Datasnap.DSAuth, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.SQLite, FireDAC.Phys.SQLiteDef, FireDAC.Stan.ExprFuncs, FireDAC.FMXUI.Wait, Data.DB, FireDAC.Comp.Client,
     FireDAC.Comp.UI, FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt, FireDAC.Comp.DataSet, Data.DBXPlatform, REST.Json;

type
{$METHODINFO ON}
     TSMSamples = class(TDataModule)
          FDConnection: TFDConnection;
          FDPhysSQLiteDriverLink: TFDPhysSQLiteDriverLink;
          FDGUIxWaitCursor: TFDGUIxWaitCursor;
          FDQueryExpo: TFDQuery;
     private
          { Private declarations }
          function GetDataSetAsJSON(DataSet: TDataSet): TJSONObject;
          procedure ResultJSON(const AID_CODE: Integer; const AContent: String);
     public
          { Public declarations }
          function Clientes(const AID_Cliente: Integer = 0): TJSONObject;
          function AcceptClientes(const AID_Cliente: Integer): TJSONObject;
          function UpdateClientes: TJSONObject;
          function CancelClientes(const AID_Cliente: Integer): TJSONObject;
     end;

     Samples = class(TSMSamples);
{$METHODINFO OFF}

implementation

{%CLASSGROUP 'FMX.Controls.TControl'}
{$R *.dfm}

uses System.StrUtils, System.Variants;

{ TSMSamples }

function TSMSamples.GetDataSetAsJSON(DataSet: TDataSet): TJSONObject;
var
     f: TField;
     o: TJSONObject;
     a: TJSONArray;
begin
     a := TJSONArray.Create;
     DataSet.Active := True;
     DataSet.First;
     while not DataSet.EOF do
     begin
          o := TJSONObject.Create;
          for f in DataSet.Fields do
               o.AddPair(f.FieldName, VarToStr(f.Value));
          a.AddElement(o);
          DataSet.Next;
     end;
     DataSet.Active := False;
     Result := TJSONObject.Create;
     Result.AddPair(DataSet.Name, a);
end;

function TSMSamples.AcceptClientes(const AID_Cliente: Integer): TJSONObject;
begin

end;

function TSMSamples.CancelClientes(const AID_Cliente: Integer): TJSONObject;
begin

end;

function TSMSamples.Clientes(const AID_Cliente: Integer): TJSONObject;
const
     _SELECT = 'SELECT * FROM CLIENTE';
begin
     FDQueryExpo.Active := False;
     FDQueryExpo.SQL.Clear;
     FDQueryExpo.SQL.Text := _SELECT;
     //
     if (AID_Cliente > 0) then
     begin
          FDQueryExpo.SQL.Add(' WHERE ID = :idCliente');
          //
          FDQueryExpo.Params.CreateParam(ftInteger, 'idCliente', ptInput);
          FDQueryExpo.ParamByName('idCliente').AsInteger := AID_Cliente;
     end;
     //
     FDQueryExpo.Active := True;
     //
     if FDQueryExpo.IsEmpty then
          Result := TJSONObject.Create().AddPair(TJSONPair.Create('Message', 'No Record'))
     else
          Result := GetDataSetAsJSON(FDQueryExpo);
     //
     ResultJSON(200, Result.ToString);
end;

procedure TSMSamples.ResultJSON(const AID_CODE: Integer; const AContent: String);
begin
     GetInvocationMetadata().ResponseCode := AID_CODE;
     //GetInvocationMetadata().ResponseContent := AContent;
end;

function TSMSamples.UpdateClientes: TJSONObject;
begin

end;

end.
