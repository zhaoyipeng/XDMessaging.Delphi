unit WinMsgDataGram;

interface

uses
  Winapi.Windows,
  XDMessaging.Serialization.Serializer,
  XDMessaging.Messages.DataGram;

type
  TWinMsgDataGram = class
  private
    FDataGram: TDataGram;
    FSerializer: TSerializer ;
    FAllocatedMemory: Boolean;
    FDataStruct: TCopyDataStruct;
  public
    constructor Create(ASerializer: TSerializer; const channel, dataType, message: string);
    function ToStruct: TCopyDataStruct;
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

function TWinMsgDataGram.ToStruct: TCopyDataStruct;
begin

end;

end.
