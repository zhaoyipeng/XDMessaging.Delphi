unit Client;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls,
  XDListener,
  XDMessagingClient;

type
  TForm2 = class(TForm)
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
  Form2: TForm2;

implementation

{$R *.dfm}

procedure TForm2.FormCreate(Sender: TObject);
begin
  FClient := TXDMessagingClient.Create;
  FListener := FClient.Listeners.GetWindowsMessagingListener;
end;

procedure TForm2.FormDestroy(Sender: TObject);
begin
  FClient.Free;
end;

end.
