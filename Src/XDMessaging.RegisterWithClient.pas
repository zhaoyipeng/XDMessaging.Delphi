unit XDMessaging.RegisterWithClient;

interface

uses
  XDMessaging.XDBroadcaster,
  XDMessaging.XDListener,
  XDMessaging.XDMessagingClient;

type
  TRegisterWithClient = class
  public
    class function GetWindowsMessagingBroadcaster(client: TBroadcasters ): IXDBroadcaster;
    class function GetWindowsMessagingListener(client: TListeners ): IXDListener;
  end;
implementation

{ TRegisterWithClient }

class function TRegisterWithClient.GetWindowsMessagingBroadcaster(
  client: TBroadcasters): IXDBroadcaster;
begin
   Result := client.GetBroadcaster;
end;

class function TRegisterWithClient.GetWindowsMessagingListener(
  client: TListeners): IXDListener;
begin
  Result := client.GetListener;
end;

end.
