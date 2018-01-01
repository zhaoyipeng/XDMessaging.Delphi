unit XDMessaging.XDListener;

interface

type
  IXDListener = interface
    function GetAlive: Boolean;
    property IsAlive: Boolean read GetAlive;
    //property MessageReceived;
    procedure RegisterChannel(const channelName: string);
    procedure UnRegisterChannel(channelName: string);
  end;
implementation

end.
