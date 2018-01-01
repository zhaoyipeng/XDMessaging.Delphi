unit XDMessaging.XDBroadcaster;

interface
type
  IXDBroadcaster = interface
    function GetAlive: Boolean;
    property IsAlive: Boolean read GetAlive;
    procedure SendToChannel(const channel: string; const message: string); overload;
    procedure SendToChannel(const channel: string; message: TObject); overload;
  end;
implementation

end.
