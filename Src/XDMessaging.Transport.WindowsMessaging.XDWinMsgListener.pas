unit XDMessaging.Transport.WindowsMessaging.XDWinMsgListener;

interface
uses
  Winapi.Windows,
  Winapi.Messages,
  System.Classes,
  System.SysUtils,
  System.Generics.Collections,
  Vcl.Controls,
  XDMessaging.XDMessagingClient,
  XDMessaging.Serialization.Serializer,
  XDMessaging.Transport.WindowsMessaging.WinMsgDataGram,
  XDMessaging.XDMessageEventArgs,
  XDMessaging.XDListener;

type
  TXDWinMsgListener = class(TWinControl, IXDListener)
  private
    FOnMessageReceived: XDMessageHandler;
    FDisposeLock: TObject;
    FSerializer: TSerializer ;
  protected
    procedure CreateParams(var Params: TCreateParams); override;
    procedure WndProc(var Message: TMessage); override;
  public
    constructor Create(ASerializer: TSerializer); reintroduce;
    destructor Destroy; override;
    class function GetChannelKey(const channelName: string): string;

    function GetOnMessageReceived: XDMessageHandler;
    procedure SetOnMessageReceived(const Value: XDMessageHandler);
    function GetAlive: Boolean;
    property IsAlive: Boolean read GetAlive;
    property OnMessageReceived: XDMessageHandler
      read GetOnMessageReceived
      write SetOnMessageReceived;
    procedure RegisterChannel(const channelName: string);
    procedure UnRegisterChannel(channelName: string);
  end;
implementation

{ TXDWinMsgListener }

constructor TXDWinMsgListener.Create(ASerializer: TSerializer);
begin
  inherited Create(nil);
  FSerializer := ASerializer;
  FDisposeLock := TObject.Create;
  FOnMessageReceived := nil;
end;

procedure TXDWinMsgListener.CreateParams(var Params: TCreateParams);
var
  s: string;
  id: string;
begin
  inherited;
  Params.Width := 0;
  Params.Height := 0;
  Params.X := 0;
  Params.Y := 0;
  id := TGUID.NewGuid.ToString;
  s := 'TheCodeKing.Net.XDServices.' + id.Substring(1, id.Length-2);
  Params.Caption := PChar(s);
  Params.WndParent := 0;
  Params.Style := Params.Style and not (WS_CHILD or WS_GROUP or WS_TABSTOP);
end;

destructor TXDWinMsgListener.Destroy;
begin
  FDisposeLock.Free;
  FSerializer := nil;
  inherited;
end;

function TXDWinMsgListener.GetAlive: Boolean;
begin
  Result := True;
end;

class function TXDWinMsgListener.GetChannelKey(
  const channelName: string): string;
begin
  Result := 'TheCodeKing.Delphi.XDServices.'+channelName;
end;

function TXDWinMsgListener.GetOnMessageReceived: XDMessageHandler;
begin
  Result := Self.FOnMessageReceived;
end;

procedure TXDWinMsgListener.RegisterChannel(const channelName: string);
var
  s: string;
begin
  TMonitor.Enter(FDisposeLock);
  try
    s := GetChannelKey(channelName);
    SetProp(Handle, PChar(s), Handle);
  finally
    TMonitor.Exit(FDisposeLock);
  end;
end;

procedure TXDWinMsgListener.SetOnMessageReceived(const Value: XDMessageHandler);
begin
  FOnMessageReceived := Value;
end;

procedure TXDWinMsgListener.UnRegisterChannel(channelName: string);
var
  s: string;
begin
  TMonitor.Enter(FDisposeLock);
  try
    s := GetChannelKey(channelName);
    RemoveProp(Handle, PChar(s));
  finally
    TMonitor.Exit(FDisposeLock);
  end;
end;

procedure TXDWinMsgListener.WndProc(var Message: TMessage);
var
  ADataGram: TWinMsgDataGram;
  e: TXDMessageEventArgs;
begin
  inherited;
  if (Message.Msg <> WM_COPYDATA) then
  begin
    Exit;
  end;
  ADataGram := TWinMsgDataGram.FromPointer(Message.LParam, FSerializer);
  try
    if (Assigned(FOnMessageReceived)) and (ADataGram <> nil) and (ADataGram.IsValid) then
    begin
      e := TXDMessageEventArgs.Create(ADataGram.DataGram);
      try
        FOnMessageReceived(Self, e);
      finally
        e.Free;
      end;
    end;
  finally
    ADataGram.Free;
  end;
end;

end.
