program Demo.Client;

uses
  Vcl.Forms,
  Client in 'Client.pas' {MessagingDemoForm},
  XDMessaging.Serialization.Serializer in '..\Src\XDMessaging.Serialization.Serializer.pas',
  XDMessaging.Messages.DataGram in '..\Src\XDMessaging.Messages.DataGram.pas',
  WinMsgDataGram in '..\Src\WinMsgDataGram.pas',
  XDMessaging.XDBroadcaster in '..\Src\XDMessaging.XDBroadcaster.pas',
  XDMessaging.XDListener in '..\Src\XDMessaging.XDListener.pas',
  XDMessaging.Messages in '..\Src\XDMessaging.Messages.pas',
  XDMessaging.Transport.WindowsMessaging.WindowEnumFilter in '..\Src\XDMessaging.Transport.WindowsMessaging.WindowEnumFilter.pas',
  XDMessaging.XDMessagingClient in '..\Src\XDMessaging.XDMessagingClient.pas',
  XDMessaging.Transport.WindowsMessaging.XDWinMsgBroadcaster in '..\Src\XDMessaging.Transport.WindowsMessaging.XDWinMsgBroadcaster.pas',
  XDMessaging.Transport.WindowsMessaging.XDWinMsgListener in '..\Src\XDMessaging.Transport.WindowsMessaging.XDWinMsgListener.pas',
  XDMessaging.Transport.WindowsMessaging.WindowsEnum in '..\Src\XDMessaging.Transport.WindowsMessaging.WindowsEnum.pas',
  XDMessaging.RegisterWithClient in '..\Src\XDMessaging.RegisterWithClient.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TMessagingDemoForm, MessagingDemoForm);
  Application.Run;
end.
