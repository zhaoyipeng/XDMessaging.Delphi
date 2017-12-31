unit XDMessaging.Transport.WindowsMessaging.XDWinMsgListener;

interface
uses
  System.Generics.Collections,
  Vcl.Controls,
  XDMessagingClient,
  XDMessaging.Serialization.Serializer;

type
  TXDWinMsgListener = class(TWinControl)
  private
    FMessageReceived: TList<XDMessageHandler>;
    FDisposeLock: TObject;
    FSerializer: TSerializer ;
    FDisposed: Boolean;
  public
    constructor Create(ASerializer: TSerializer);
    procedure AddHandler(AHandler: XDMessageHandler);
    procedure RemoveHandler(AHandler: XDMessageHandler);
    class function GetChannelKey(const channelName: string): string;
  end;
implementation

{ TXDWinMsgListener }

procedure TXDWinMsgListener.AddHandler(AHandler: XDMessageHandler);
begin

end;

constructor TXDWinMsgListener.Create(ASerializer: TSerializer);
begin
  FSerializer := ASerializer;
end;

class function TXDWinMsgListener.GetChannelKey(
  const channelName: string): string;
begin
  Result := 'TheCodeKing.Net.XDServices.'+channelName;
end;

procedure TXDWinMsgListener.RemoveHandler(AHandler: XDMessageHandler);
begin

end;

end.
