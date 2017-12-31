unit XDMessagingClient;

interface

uses
  XDBroadcaster,
  XDListener,
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
  public
    constructor Create(client: TXDMessagingClient; ASerializer: TSerializer);
    function GetWindowsMessagingListener: IXDListener;
  end;

  TXDMessagingClient = class
  private
    FListeners: TListeners;
    FBroadcasters: TBroadcasters;
  public
    property Broadcasters: TBroadcasters read FBroadcasters;
    property Listeners: TListeners read FListeners;
  end;
implementation

uses
  XDMessaging.Transport.WindowsMessaging.XDWinMsgBroadcaster;


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

end;

function TListeners.GetWindowsMessagingListener: IXDListener;
begin

end;

end.
