unit XDMessaging.Transport.WindowsMessaging.XDWinMsgBroadcaster;

interface

uses
  Winapi.Windows,
  Winapi.Messages,
  System.Classes,
  XDMessaging.XDBroadcaster,
  XDMessaging.Serialization.Serializer,
  XDMessaging.Transport.WindowsMessaging.WindowEnumFilter,
  XDMessaging.Transport.WindowsMessaging.XDWinMsgListener,
  XDMessaging.Transport.WindowsMessaging.WindowsEnum,
  XDMessaging.Transport.WindowsMessaging.WinMsgDataGram;

type
  TXDWinMsgBroadcaster = class(TInterfacedObject, IXDBroadcaster)
  private
    FSerializer: TSerializer;
    procedure SendToChannel(const channel, ADataType, AMessage: string); overload;
  public
    constructor Create(ASerializer: TSerializer);
    function GetAlive: Boolean;
    property IsAlive: Boolean read GetAlive;
    procedure SendToChannel(const channel: string; const AMessage: string); overload;
    procedure SendToChannel(const channel: string; AMessage: TObject); overload;
  end;
implementation

{ TXDWinMsgBroadcaster }

constructor TXDWinMsgBroadcaster.Create(ASerializer: TSerializer);
begin
  Self.FSerializer := ASerializer;
end;

function TXDWinMsgBroadcaster.GetAlive: Boolean;
begin
  Result := True;
end;

procedure TXDWinMsgBroadcaster.SendToChannel(const channel, AMessage: string);
begin
  SendToChannel(channel, 'string', AMessage);
end;

procedure TXDWinMsgBroadcaster.SendToChannel(const channel: string;
  AMessage: TObject);
begin
  SendToChannel(channel, AMessage.ClassType.ClassName, FSerializer.Serialize(AMessage));
end;

procedure TXDWinMsgBroadcaster.SendToChannel(const channel, ADataType,
  AMessage: string);
var
  dataGram: TWinMsgDataGram;
  dataStruct: TCopyDataStruct;
  filter: TWindowEnumFilter;
  winEnum: TWindowsEnum;
  Handle: HWND;
begin
  dataGram := TWinMsgDataGram.Create(FSerializer, channel, ADataType, AMessage);
  try
    dataStruct := dataGram.ToStruct();
    filter := TWindowEnumFilter.Create(TXDWinMsgListener.GetChannelKey(channel));
    winEnum := TWindowsEnum.Create(filter.WindowFilterHandler);
    for Handle in winEnum.Enumerate do
    begin
      SendMessage(Handle, WM_COPYDATA, 0, LPARAM(@dataStruct));
    end;
  finally
    dataGram.Free;
  end;
end;

end.
