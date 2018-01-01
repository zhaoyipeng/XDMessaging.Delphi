unit XDMessaging.XDMessagingClient;

interface

uses
  XDMessaging.XDBroadcaster,
  XDMessaging.XDListener,
  XDMessaging.Serialization.Serializer;

type
  TXDMessagingClient = class;

  TBroadcasters = class
  private
    FSerializer: TSerializer ;
  public
    constructor Create(client: TXDMessagingClient; ASerializer: TSerializer);
    function GetBroadcaster: IXDBroadcaster;
  end;

  XDMessageHandler = procedure (sender: TObject; e: TObject) of object;

  TListeners = class
  private
    FSerializer: TSerializer;
  public
    constructor Create(client: TXDMessagingClient; ASerializer: TSerializer);
    function GetListener: IXDListener;
  end;

  TXDMessagingClient = class
  private class var
    FSerializer: TSerializer;
  private
    FListeners: TListeners;
    FBroadcasters: TBroadcasters;
    class constructor Create;
  public
    constructor Create;
    destructor Destroy; override;
    property Broadcasters: TBroadcasters read FBroadcasters;
    property Listeners: TListeners read FListeners;
  end;
implementation

uses
  XDMessaging.Transport.WindowsMessaging.XDWinMsgBroadcaster,
  XDMessaging.Transport.WindowsMessaging.XDWinMsgListener;


{ TBroadcasters }

constructor TBroadcasters.Create(client: TXDMessagingClient; ASerializer: TSerializer);
begin
  self.FSerializer := ASerializer;
end;

function TBroadcasters.GetBroadcaster: IXDBroadcaster;
begin
  Result := TXDWinMsgBroadcaster.Create(FSerializer);
end;

{ TListeners }

constructor TListeners.Create(client: TXDMessagingClient;
  ASerializer: TSerializer);
begin
  FSerializer := ASerializer;
end;

function TListeners.GetListener: IXDListener;
begin
  Result := TXDWinMsgListener.Create(FSerializer);
end;

{ TXDMessagingClient }

constructor TXDMessagingClient.Create;
begin
  FListeners := TListeners.Create(Self, FSerializer);
  FBroadcasters := TBroadcasters.Create(Self, FSerializer);
end;

destructor TXDMessagingClient.Destroy;
begin
  FBroadcasters.Free;
  FListeners.Free;
  inherited;
end;

class constructor TXDMessagingClient.Create;
begin
  FSerializer := TSerializer.Create;
end;

end.
