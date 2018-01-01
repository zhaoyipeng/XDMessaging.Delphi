unit XDMessaging.Serialization.Serializer;

interface

uses
  System.JSON.Serializers;

type
  TSerializer = class
  private
    FSerializer: TJsonSerializer;
  public
    constructor Create;
    destructor Destroy; override;
    function Deserialize<T>(const data: string): T;
    function Serialize<T>(obj: T): string;
  end;

implementation

{ TSerializer }

constructor TSerializer.Create;
begin
  FSerializer := TJsonSerializer.Create;
end;

function TSerializer.Deserialize<T>(const data: string): T;
begin
  Result := FSerializer.Deserialize<T>(data);
end;

destructor TSerializer.Destroy;
begin
  FSerializer.Free;
  inherited;
end;

function TSerializer.Serialize<T>(obj: T): string;
begin
  Result := FSerializer.Serialize<T>(obj);
end;

end.
