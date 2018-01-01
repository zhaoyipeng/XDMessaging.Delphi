unit Client;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls,
  Vcl.ExtCtrls, Vcl.ComCtrls,
  XDMessaging.XDListener,
  XDMessaging.XDBroadcaster,
  XDMessaging.XDMessagingClient,
  XDMessaging.XDMessageEventArgs,
  FormattedUserMessage;

type
  TMessagingDemoForm = class(TForm)
    Panel1: TPanel;
    edtInput: TEdit;
    btnSend: TButton;
    GroupBox1: TGroupBox;
    chkChannel1: TCheckBox;
    chkChannel2: TCheckBox;
    chkStatus: TCheckBox;
    displayTextBox: TRichEdit;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnSendClick(Sender: TObject);
  private
    { Private declarations }
    FUniqueInstanceName: string;
    FBroadcast: IXDBroadcaster;
    FClient: TXDMessagingClient ;
    FListener: IXDListener;
    procedure SendMessage;
    procedure Initialize;
    procedure OnMessageReceived(sender: TObject; e: TXDMessageEventArgs);
    procedure UpdateDisplayText(const channelName, displayText: string); overload;
    procedure UpdateDisplayText(const AMessage: string; textColor: TColor); overload;
  public
    { Public declarations }
  end;

var
  MessagingDemoForm: TMessagingDemoForm;

implementation

{$R *.dfm}

function GetComputerNetName: string;
var
  buffer: array [0 .. 255] of char;
  size: dword;
begin
  size := 256;
  if GetComputerName(buffer, size) then
    Result := buffer
  else
    Result := ''
end;

procedure TMessagingDemoForm.btnSendClick(Sender: TObject);
begin
  SendMessage;
end;

procedure TMessagingDemoForm.FormCreate(Sender: TObject);
begin
  FUniqueInstanceName := Format('%s-%d', [GetComputerNetName, Handle]);
  FClient := TXDMessagingClient.Create;
  Initialize;
end;

procedure TMessagingDemoForm.FormDestroy(Sender: TObject);
begin
  FClient.Free;
end;

procedure TMessagingDemoForm.Initialize;
begin
  FListener := FClient.Listeners.GetListener(Self);
  FListener.OnMessageReceived := OnMessageReceived;

  if (chkStatus.Checked) then
  begin
    FListener.RegisterChannel('Status');
  end;

  if (chkChannel1.Checked) then
  begin
    FListener.RegisterChannel('BinaryChannel1');
  end;

  if (chkChannel2.Checked) then
  begin
    FListener.RegisterChannel('BinaryChannel2');
  end;

  FBroadcast := FClient.Broadcasters.GetBroadcaster;
end;

procedure TMessagingDemoForm.OnMessageReceived(sender: TObject;
  e: TXDMessageEventArgs);
var
  channel: string;
begin
  channel := e.DataGram.Channel.ToLower;
  if channel.Equals('status') then
  begin
    //UpdateDisplayText(e.DataGram.Channel, e.DataGram.Message);
  end
  else
  begin
    if (e.DataGram.AssemblyQualifiedName = TFormattedUserMessage.ClassName) then
    begin
      //TypedDataGram<FormattedUserMessage> typedDataGram = e.DataGram;
      //UpdateDisplayText(typedDataGram.Channel, typedDataGram.Message.FormattedTextMessage);
    end
    else
    begin
      Raise Exception.Create(Format('Unknown message type: %s', [e.DataGram.AssemblyQualifiedName]));
    end;
  end;
end;

procedure TMessagingDemoForm.SendMessage;
var
  AMessage: TFormattedUserMessage;
begin
 if Length(edtInput.Text) > 0 then
 begin
    AMessage := TFormattedUserMessage.Create('%s says %s', [FUniqueInstanceName, edtInput.Text]);
    if chkChannel1.Checked then
    begin
      FBroadcast.SendToChannel('BinaryChannel1', AMessage);
    end;
    if chkChannel2.Checked then
    begin
      FBroadcast.SendToChannel('BinaryChannel2', AMessage);
    end;
    edtInput.Text := '';
  end;
end;

procedure TMessagingDemoForm.UpdateDisplayText(const AMessage: string;
  textColor: TColor);
begin
//  if (IsDisposed)
//            {
//                return;
//            }

  displayTextBox.Lines.Append(AMessage);
  displayTextBox.SelStart := Length(displayTextBox.Text) - AMessage.Length + 1;
  displayTextBox.SelLength := Length(AMessage);
  displayTextBox.SelAttributes.Color := textColor;
  displayTextBox.SelStart := Length(displayTextBox.Text);
  displayTextBox.SelLength := 0;
//  displayTextBox.CaretPos := ();
end;

procedure TMessagingDemoForm.UpdateDisplayText(const channelName,
  displayText: string);
var
  textColor: TColor;
  msg: string;
begin
  if channelName.IsEmpty or displayText.IsEmpty then
    Exit;
  if channelName.ToLower.Equals('status') then
    textColor := clGreen
  else
    textColor := clBlue;
  msg := channelName + ': ' + displayText + #13#10;
  UpdateDisplayText(msg, textColor);
end;

end.
