program Demo.Client;

uses
  Vcl.Forms,
  Client in 'Client.pas' {Form2},
  XDMessaging.Serialization.Serializer in '..\Src\Serialization\XDMessaging.Serialization.Serializer.pas',
  XDMessaging.Messages.DataGram in '..\Src\Messages\XDMessaging.Messages.DataGram.pas',
  WinMsgDataGram in '..\Src\WinMsgDataGram.pas',
  XDBroadcaster in '..\Src\XDBroadcaster.pas',
  XDListener in '..\Src\XDListener.pas',
  XDMessaging.Messages in '..\Src\XDMessaging.Messages.pas',
  XDMessaging.Transport.WindowsMessaging.WindowEnumFilter in '..\Src\XDMessaging.Transport.WindowsMessaging.WindowEnumFilter.pas',
  XDMessagingClient in '..\Src\XDMessagingClient.pas',
  XDMessaging.Transport.WindowsMessaging.XDWinMsgBroadcaster in '..\Src\XDMessaging.Transport.WindowsMessaging.XDWinMsgBroadcaster.pas',
  XDMessaging.Transport.WindowsMessaging.XDWinMsgListener in '..\Src\XDMessaging.Transport.WindowsMessaging.XDWinMsgListener.pas',
  XDMessaging.Transport.WindowsMessaging.WindowsEnum in '..\Src\XDMessaging.Transport.WindowsMessaging.WindowsEnum.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm2, Form2);
  Application.Run;
end.
