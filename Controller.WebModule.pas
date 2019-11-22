unit Controller.WebModule;

interface

uses
     System.SysUtils, System.Classes, Web.HTTPApp, Datasnap.DSHTTPCommon, Datasnap.DSHTTPWebBroker, Datasnap.DSServer, Datasnap.DSAuth, IPPeerServer, Datasnap.DSCommonServer, Datasnap.DSHTTP, System.JSON, Data.DBXCommon;

type
     TModelWebModule = class(TWebModule)
          DSServer: TDSServer;
          DSAuthenticationManager: TDSAuthenticationManager;
          DSServerClass: TDSServerClass;
          DSRESTWebDispatcher: TDSRESTWebDispatcher;
          procedure DSServerClassGetClass(DSServerClass: TDSServerClass; var PersistentClass: TPersistentClass);
          procedure DSAuthenticationManagerUserAuthorize(Sender: TObject; EventObject: TDSAuthorizeEventObject; var valid: Boolean);
          procedure DSAuthenticationManagerUserAuthenticate(Sender: TObject; const Protocol, Context, User, Password: string; var valid: Boolean; UserRoles: TStrings);
          procedure WebModule1DefaultHandlerAction(Sender: TObject; Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
          procedure DSRESTWebDispatcherFormatResult(Sender: TObject; var ResultVal: TJSONValue; const Command: TDBXCommand; var Handled: Boolean);
     private
          { Private declarations }
     public
          { Public declarations }
     end;

var
     WebModuleClass: TComponentClass = TModelWebModule;

implementation

{%CLASSGROUP 'FMX.Controls.TControl'}
{$R *.dfm}

uses Model.ServerMethods, Web.WebReq;

procedure TModelWebModule.WebModule1DefaultHandlerAction(Sender: TObject; Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
begin
     Response.Content := '<html>' + '<head><title>Samples RESTful</title></head>' + '<body>Server RESTFul with ORMBr</body>' + '</html>';
end;

procedure TModelWebModule.DSServerClassGetClass(DSServerClass: TDSServerClass; var PersistentClass: TPersistentClass);
begin
     PersistentClass := Model.ServerMethods.Samples;
end;

procedure TModelWebModule.DSAuthenticationManagerUserAuthenticate(Sender: TObject; const Protocol, Context, User, Password: string; var valid: Boolean; UserRoles: TStrings);
begin
     valid := True;
end;

procedure TModelWebModule.DSAuthenticationManagerUserAuthorize(Sender: TObject; EventObject: TDSAuthorizeEventObject; var valid: Boolean);
begin
     valid := True;
end;

procedure TModelWebModule.DSRESTWebDispatcherFormatResult(Sender: TObject; var ResultVal: TJSONValue; const Command: TDBXCommand; var Handled: Boolean);
var
     FJSONResult: TJSONValue;
begin
     FJSONResult := ResultVal;
     //
     try
          ResultVal := TJSONArray(FJSONResult).Items[0];
          //
          TJSONArray(FJSONResult).Remove(0);
          //
          Handled := True;
     finally
          FJSONResult.Free;
     end;
end;

initialization

finalization

Web.WebReq.FreeWebModules;

end.
