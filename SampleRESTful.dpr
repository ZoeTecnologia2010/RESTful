program SampleRESTful;
{$APPTYPE GUI}

uses
  FMX.Forms,
  Web.WebReq,
  IdHTTPWebBrokerBridge,
  View.Server in 'View.Server.pas' {ViewServer},
  Model.ServerMethods in 'Model.ServerMethods.pas' {SMSamples: TDataModule},
  Controller.WebModule in 'Controller.WebModule.pas' {ModelWebModule: TWebModule};

{$R *.res}

begin
  if WebRequestHandler <> nil then
    WebRequestHandler.WebModuleClass := WebModuleClass;
  Application.Initialize;
  Application.CreateForm(TViewServer, ViewServer);
  Application.Run;
end.
