object ModelWebModule: TModelWebModule
  OldCreateOrder = False
  Actions = <
    item
      Default = True
      Name = 'DefaultHandler'
      PathInfo = '/'
      OnAction = WebModule1DefaultHandlerAction
    end>
  Height = 230
  Width = 415
  object DSServer: TDSServer
    Left = 96
    Top = 11
  end
  object DSAuthenticationManager: TDSAuthenticationManager
    OnUserAuthenticate = DSAuthenticationManagerUserAuthenticate
    OnUserAuthorize = DSAuthenticationManagerUserAuthorize
    Roles = <>
    Left = 264
    Top = 75
  end
  object DSServerClass: TDSServerClass
    OnGetClass = DSServerClassGetClass
    Server = DSServer
    LifeCycle = 'Invocation'
    Left = 264
    Top = 11
  end
  object DSRESTWebDispatcher: TDSRESTWebDispatcher
    DSContext = 'api/'
    Server = DSServer
    SessionLifetime = Request
    OnFormatResult = DSRESTWebDispatcherFormatResult
    Left = 96
    Top = 80
  end
end
