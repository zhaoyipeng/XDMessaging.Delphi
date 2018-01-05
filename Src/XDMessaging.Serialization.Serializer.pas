unit XDMessaging.Serialization.Serializer;

interface
{$IF RTLVersion>=32}  // Rad Studio Tokyo
{$XD_VER320_up}
{$IFEND}

uses
  {$IFDEF XD_VER320_up}
  System.JSON.Serializers
  {$ELSE}
  XSuperObject
  {$ENDIF}
  ;

type
  TSerializer = class
  private
    {$IFDEF XD_VER320_up}
    FSerializer: TJsonSerializer;
    {$ENDIF}
  public
    constructor Create;
    destructor Destroy; override;
    function Deserialize<T>(const data: string): T;
    function Serialize<T>(const obj: T): string;
  end;

implementation

{ TSerializer }

constructor TSerializer.Create;
begin
  {$IFDEF XD_VER320_up}
  FSerializer := TJsonSerializer.Create;
  {$ENDIF}
end;

function TSerializer.Deserialize<T>(const data: string): T;
begin
  {$IFDEF XD_VER320_up}
  Result := FSerializer.Deserialize<T>(data);
  {$ELSE}
  Result := TJSON.Parse<T>(data);
  {$ENDIF}
end;

destructor TSerializer.Destroy;
begin
  {$IFDEF XD_VER320_up}
  FSerializer.Free;
  {$ENDIF}
  inherited;
end;

function TSerializer.Serialize<T>(const obj: T): string;
begin
  {$IFDEF XD_VER320_up}
  Result := FSerializer.Serialize<T>(obj);
  {$ELSE}
  Result := TJSON.SuperObject<T>(obj).AsJSON;
  {$ENDIF}
end;

end.
