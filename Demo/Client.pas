unit Client;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls,
  XDListener,
  XDMessagingClient;

type
  TMessagingDemoForm = class(TForm)
    Label1: TLabel;
    Button1: TButton;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
    FClient: TXDMessagingClient ;
    FListener: IXDListener;
  public
    { Public declarations }
  end;

var
  MessagingDemoForm: TMessagingDemoForm;

implementation

{$R *.dfm}

procedure TMessagingDemoForm.FormCreate(Sender: TObject);
begin
  FClient := TXDMessagingClient.Create;
  FListener := FClient.Listeners.GetWindowsMessagingListener;
end;

procedure TMessagingDemoForm.FormDestroy(Sender: TObject);
begin
  FClient.Free;
end;

end.
