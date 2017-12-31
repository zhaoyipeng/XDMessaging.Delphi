program Demo.Client;

uses
  Vcl.Forms,
  Client in 'Client.pas' {Form2},
  IXDBroadcaster in '..\Src\IXDBroadcaster.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm2, Form2);
  Application.Run;
end.
