unit FormattedUserMessage;

interface

uses
  System.SysUtils
  {$IFDEF XD_VER320_up}
  , System.JSON.Serializers
  {$ENDIF}
  ;

type
  TFormattedUserMessage = class
  private
    {$IFDEF XD_VER320_up}
    [JsonName('FormattedTextMessage')]
    {$ENDIF}
    FFormattedTextMessage: string;
    procedure SetFormattedTextMessage(const Value: string);
  public
    constructor Create; overload;
    constructor Create(const formatMessage: string; const Args: array of const); overload;
    property FormattedTextMessage: string read FFormattedTextMessage write SetFormattedTextMessage;
  end;

implementation

{ TFormattedUserMessage }

constructor TFormattedUserMessage.Create(const formatMessage: string;
  const Args: array of const);
begin
  FFormattedTextMessage := Format(formatMessage, Args);
end;

constructor TFormattedUserMessage.Create;
begin
  FFormattedTextMessage := '';
end;

procedure TFormattedUserMessage.SetFormattedTextMessage(const Value: string);
begin
  FFormattedTextMessage := Value;
end;

end.
