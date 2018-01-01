unit XDMessaging.XDMessageEventArgs;

interface

uses
  System.Classes,
  XDMessaging.Messages.DataGram;

type
  TXDMessageEventArgs = class(TInterfacedObject)
  private
    FDataGram: TDataGram;
  public
    constructor Create(ADataGram: TDataGram);
    property DataGram: TDataGram read FDataGram;
  end;
implementation

{ TXDMessageEventArgs }

constructor TXDMessageEventArgs.Create(ADataGram: TDataGram);
begin
  FDataGram := ADataGram;
end;

end.
