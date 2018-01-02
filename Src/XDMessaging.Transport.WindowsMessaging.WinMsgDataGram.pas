unit XDMessaging.Transport.WindowsMessaging.WinMsgDataGram;

interface

uses
  Winapi.Windows,
  Winapi.ActiveX,
  System.SysUtils,
  System.JSON.Serializers,
  XDMessaging.Serialization.Serializer,
  XDMessaging.Messages.DataGram;

type
  TWinMsgDataGram = class(TInterfacedObject)
  private
    FDataGram: TDataGram;
    FSerializer: TSerializer ;
    FAllocatedMemory: Boolean;
    FDataStruct: TCopyDataStruct;
    constructor Create(lpParam: LPARAM; ASerializer: TSerializer); overload;
  public
    constructor Create(ASerializer: TSerializer; const channel, dataType, message: string); overload;
    destructor Destroy; override;
    function ToStruct: TCopyDataStruct;
    class function FromPointer(lpParam: LPARAM; ASerializer: TSerializer): TWinMsgDataGram;
    function IsValid: Boolean;
    property DataGram: TDataGram read FDataGram;
  end;
implementation

{ TWinMsgDataGram }

constructor TWinMsgDataGram.Create(ASerializer: TSerializer; const channel,
  dataType, message: string);
begin
  Self.FSerializer := ASerializer;
  FAllocatedMemory := False;
  FDataGram := TDataGram.Create(channel, dataType, message);
end;

destructor TWinMsgDataGram.Destroy;
begin
  if (FDataStruct.lpData <> nil) then
  begin
    if (FAllocatedMemory) then
    begin
      CoTaskMemFree(FDataStruct.lpData);
    end;

    FDataStruct.lpData := nil;;
    FDataStruct.dwData := 0;
    FDataStruct.cbData := 0;
  end;
  inherited;
end;

constructor TWinMsgDataGram.Create(lpParam: LPARAM; ASerializer: TSerializer);
var
  bytes: TBytes;
  rawmessage: string;
begin
  FSerializer := ASerializer;
  FAllocatedMemory := False;
  FDataStruct := PCopyDataStruct(lpParam)^;
  SetLength(bytes, FDataStruct.cbData);
  Move(FDataStruct.lpData^, bytes[0], FDataStruct.cbData);
  rawmessage := TEncoding.Default.GetString(bytes);
  FDataGram := FSerializer.Deserialize<TDataGram>(rawmessage);
end;

class function TWinMsgDataGram.FromPointer(lpParam: LPARAM;
  ASerializer: TSerializer): TWinMsgDataGram;
begin
  Result := TWinMsgDataGram.Create(lpParam, ASerializer);
end;

function TWinMsgDataGram.IsValid: Boolean;
begin
  Result := FDataGram.IsValid;
end;

function TWinMsgDataGram.ToStruct: TCopyDataStruct;
var
  raw: string;
  bytes: TBytes;
  ptrData: Pointer;
begin
   raw := FSerializer.Serialize<TDataGram>(FDataGram);
   bytes := TEncoding.Default.GetBytes(raw);
   ptrData := CoTaskMemAlloc(Length(bytes));

   FAllocatedMemory := True;
   Move(bytes[0], ptrData^, Length(bytes));

   FDataStruct.cbData := Length(bytes);
   FDataStruct.dwData := 0;
   FDataStruct.lpData := ptrData;

   Result := FDataStruct;
end;

end.
