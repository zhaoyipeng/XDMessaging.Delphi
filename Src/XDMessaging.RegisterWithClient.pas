unit XDMessaging.RegisterWithClient;

interface

uses
  System.Classes,
  XDMessaging.XDBroadcaster,
  XDMessaging.XDListener,
  XDMessaging.XDMessagingClient;

type
  TRegisterWithClient = class
  public
    class function GetWindowsMessagingBroadcaster(client: TBroadcasters ): IXDBroadcaster;
    class function GetWindowsMessagingListener(AOwner: TComponent; client: TListeners ): IXDListener;
  end;
implementation

{ TRegisterWithClient }

class function TRegisterWithClient.GetWindowsMessagingBroadcaster(
  client: TBroadcasters): IXDBroadcaster;
begin
   Result := client.GetBroadcaster;
end;

class function TRegisterWithClient.GetWindowsMessagingListener(
  AOwner: TComponent; client: TListeners): IXDListener;
begin
  Result := client.GetListener(AOwner);
end;

end.
