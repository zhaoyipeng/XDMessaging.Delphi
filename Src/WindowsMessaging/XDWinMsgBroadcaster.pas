unit XDWinMsgBroadcaster;

interface

uses
  System.Classes,
  XDBroadcaster,
  Serializer;

type
  TXDWinMsgBroadcaster = class(TInterfacedObject, IXDBroadcaster)
  private
    serializer: TSerializer;
    procedure SendToChannel(const channel, dataType, message: string); overload;
  public
    constructor Create(serializer: TSerializer);
    function GetAlive: Boolean;
    property IsAlive: Boolean read GetAlive;
    procedure SendToChannel(const channel: string; const message: string); overload;
    procedure SendToChannel(const channel: string; message: TObject); overload;
  end;
implementation

{ TXDWinMsgBroadcaster }

constructor TXDWinMsgBroadcaster.Create(serializer: TSerializer);
begin

end;

function TXDWinMsgBroadcaster.GetAlive: Boolean;
begin
  Result := True;
end;

procedure TXDWinMsgBroadcaster.SendToChannel(const channel, message: string);
begin
  SendToChannel(channel, 'string', message);
end;

procedure TXDWinMsgBroadcaster.SendToChannel(const channel: string;
  message: TObject);
begin
  SendToChannel(channel, message.ClassType.ClassName, serializer.Serialize(message));
end;

procedure TXDWinMsgBroadcaster.SendToChannel(const channel, dataType,
  message: string);
begin

end;

end.
