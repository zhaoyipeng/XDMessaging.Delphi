unit XDMessaging.Messages.TypedDataGram;

interface

uses
  XDMessaging.Messages.DataGram,
  XDMessaging.Serialization.Serializer;

type
  TTypedDataGram<T: class> = class
  private
    FDataGram: TDataGram;
    FObjectSerializer: TSerializer;
    function GetAssemblyQualifiedName: string;
    function GetChannel: string;
    function GetMessage: T;
  public
    constructor Create(ADataGram: TDataGram; ASerializer: TSerializer);
    function IsValid: Boolean;
    property AssemblyQualifiedName: string read GetAssemblyQualifiedName;
    property Channel: string read GetChannel;
    property Message: T read GetMessage;
  end;
implementation

uses
  XDMessaging.XDMessagingClient;

{ TTypedDataGram<T> }

function TTypedDataGram<T>.GetAssemblyQualifiedName: string;
begin
  Result := FDataGram.AssemblyQualifiedName;
end;

function TTypedDataGram<T>.GetChannel: string;
begin
  Result := FDataGram.Channel;
end;

function TTypedDataGram<T>.GetMessage: T;
begin
  Result := FObjectSerializer.Deserialize<T>(FDataGram.Message);
end;

function TTypedDataGram<T>.IsValid: Boolean;
var
  msg: T;
begin
  msg := Message;
  try
    Result := msg <> nil;
  finally
    msg.Free;
  end;
end;

constructor TTypedDataGram<T>.Create(ADataGram: TDataGram;
  ASerializer: TSerializer);
begin
  FObjectSerializer := ASerializer;
  FDataGram := ADataGram;
end;

end.
