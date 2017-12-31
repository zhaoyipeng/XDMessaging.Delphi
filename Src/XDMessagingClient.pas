unit XDMessagingClient;

interface

uses
  XDBroadcaster,
  Listeners,
  Serializer,
  XDWinMsgBroadcaster;

type
  TXDMessagingClient = class;

  TBroadcasters = class
  private
    serializer: TSerializer ;
  public
    constructor Create(client: TXDMessagingClient; serializer: TSerializer);
    function GetBroadcaster: IXDBroadcaster;
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

{ TBroadcasters }

constructor TBroadcasters.Create(client: TXDMessagingClient; serializer: TSerializer);
begin
end;

function TBroadcasters.GetBroadcaster: IXDBroadcaster;
begin
  Result := TXDWinMsgBroadcaster.Create(serializer);
end;

end.
