unit XDMessaging.XDListener;

interface

uses
   XDMessaging.XDMessageEventArgs;

type
  XDMessageHandler = procedure (sender: TObject; e: TXDMessageEventArgs) of object;

  IXDListener = interface
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

end.
