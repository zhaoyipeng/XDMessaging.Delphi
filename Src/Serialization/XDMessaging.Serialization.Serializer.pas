unit XDMessaging.Serialization.Serializer;

interface
type
  TSerializer = class
  public
    function Deserialize<T>(const data: string): T;
    function Serialize<T>(obj: T): string;
  end;

implementation

{ TSerializer }

function TSerializer.Deserialize<T>(const data: string): T;
begin

end;

function TSerializer.Serialize<T>(obj: T): string;
begin

end;

end.
