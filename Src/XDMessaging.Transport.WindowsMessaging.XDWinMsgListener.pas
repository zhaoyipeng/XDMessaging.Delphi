unit XDMessaging.Transport.WindowsMessaging.XDWinMsgListener;

interface
uses
  Winapi.Windows,
  System.SysUtils,
  System.Generics.Collections,
  Vcl.Controls,
  XDMessaging.XDMessagingClient,
  XDMessaging.Serialization.Serializer,
  XDMessaging.XDListener;

type
  TXDWinMsgListener = class(TWinControl, IXDListener)
  private
    FMessageReceived: TList<XDMessageHandler>;
    FDisposeLock: TObject;
    FSerializer: TSerializer ;
    FDisposed: Boolean;
  public
    constructor Create(ASerializer: TSerializer);
    destructor Destroy; override;
    procedure AddHandler(AHandler: XDMessageHandler);
    procedure RemoveHandler(AHandler: XDMessageHandler);
    class function GetChannelKey(const channelName: string): string;
    function GetAlive: Boolean;
    property IsAlive: Boolean read GetAlive;
    procedure RegisterChannel(const channelName: string);
    procedure UnRegisterChannel(channelName: string);
  end;
implementation

{ TXDWinMsgListener }

procedure TXDWinMsgListener.AddHandler(AHandler: XDMessageHandler);
begin

end;

constructor TXDWinMsgListener.Create(ASerializer: TSerializer);
begin
  FSerializer := ASerializer;
  FDisposeLock := TObject.Create;
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
  Result := 'TheCodeKing.Net.XDServices.'+channelName;
end;

procedure TXDWinMsgListener.RegisterChannel(const channelName: string);
begin
  TMonitor.Enter(FDisposeLock);
  try
    if (disposed) then
    begin
       Raise Exception.Create('IXDListener: This instance has been disposed.');
    end;

    SetProp(Handle, PChar(GetChannelKey(channelName)), Handle);
  finally
    TMonitor.Exit(FDisposeLock);
  end;
end;

procedure TXDWinMsgListener.RemoveHandler(AHandler: XDMessageHandler);
begin

end;

procedure TXDWinMsgListener.UnRegisterChannel(channelName: string);
begin

end;

end.
