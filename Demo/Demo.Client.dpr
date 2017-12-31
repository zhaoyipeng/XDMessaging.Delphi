program Demo.Client;

uses
  Vcl.Forms,
  Client in 'Client.pas' {Form2},
  XDListener in '..\Src\XDListener.pas',
  XDMessagingClient in '..\Src\XDMessagingClient.pas',
  Listeners in '..\Src\Entities\Listeners.pas',
  XDBroadcaster in '..\Src\XDBroadcaster.pas',
  Broadcasters in '..\Src\Entities\Broadcasters.pas',
  XDWinMsgBroadcaster in '..\Src\WindowsMessaging\XDWinMsgBroadcaster.pas',
  Serializer in '..\Src\Serialization\Serializer.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm2, Form2);
  Application.Run;
end.
