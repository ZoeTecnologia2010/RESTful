object SMSamples: TSMSamples
  OldCreateOrder = False
  Height = 440
  Width = 680
  object FDConnection: TFDConnection
    Params.Strings = (
      
        'Database=C:\Users\zoete\source\repos\RESTful\Win32\Debug\Financa' +
        's.db3'
      'DriverID=SQLite')
    Connected = True
    LoginPrompt = False
    Left = 32
    Top = 24
  end
  object FDPhysSQLiteDriverLink: TFDPhysSQLiteDriverLink
    Left = 64
    Top = 24
  end
  object FDGUIxWaitCursor: TFDGUIxWaitCursor
    Provider = 'FMX'
    Left = 96
    Top = 24
  end
  object FDQueryExpo: TFDQuery
    Connection = FDConnection
    Left = 40
    Top = 96
  end
end
