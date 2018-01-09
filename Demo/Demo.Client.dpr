program Demo.Client;

uses
  Vcl.Forms,
  Client in 'Client.pas' {MessagingDemoForm},
  XDMessaging.Serialization.Serializer in '..\Src\XDMessaging.Serialization.Serializer.pas',
  XDMessaging.Messages.DataGram in '..\Src\XDMessaging.Messages.DataGram.pas',
  XDMessaging.Transport.WindowsMessaging.WinMsgDataGram in '..\Src\XDMessaging.Transport.WindowsMessaging.WinMsgDataGram.pas',
  XDMessaging.XDBroadcaster in '..\Src\XDMessaging.XDBroadcaster.pas',
  XDMessaging.XDListener in '..\Src\XDMessaging.XDListener.pas',
  XDMessaging.Transport.WindowsMessaging.WindowEnumFilter in '..\Src\XDMessaging.Transport.WindowsMessaging.WindowEnumFilter.pas',
  XDMessaging.XDMessagingClient in '..\Src\XDMessaging.XDMessagingClient.pas',
  XDMessaging.Transport.WindowsMessaging.XDWinMsgBroadcaster in '..\Src\XDMessaging.Transport.WindowsMessaging.XDWinMsgBroadcaster.pas',
  XDMessaging.Transport.WindowsMessaging.XDWinMsgListener in '..\Src\XDMessaging.Transport.WindowsMessaging.XDWinMsgListener.pas',
  XDMessaging.Transport.WindowsMessaging.WindowsEnum in '..\Src\XDMessaging.Transport.WindowsMessaging.WindowsEnum.pas',
  XDMessaging.RegisterWithClient in '..\Src\XDMessaging.RegisterWithClient.pas',
  FormattedUserMessage in 'FormattedUserMessage.pas',
  XDMessaging.XDMessageEventArgs in '..\Src\XDMessaging.XDMessageEventArgs.pas',
  XDMessaging.Messages.TypedDataGram in '..\Src\XDMessaging.Messages.TypedDataGram.pas',
  XDMessaging.FileSystemWatcher in '..\Src\XDMessaging.FileSystemWatcher.pas',
  XDMessaging.Transport.IOStream.XDIOStreamBroadcaster in '..\Src\XDMessaging.Transport.IOStream.XDIOStreamBroadcaster.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TMessagingDemoForm, MessagingDemoForm);
  Application.Run;
end.
