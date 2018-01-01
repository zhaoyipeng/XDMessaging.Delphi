unit FormattedUserMessage;

interface

type
  TFormattedUserMessage = class
  private
    FFormattedTextMessage: string;
    procedure SetFormattedTextMessage(const Value: string);
  public
    constructor Create(const formatMessage: string; const Args: array of const);
    property FormattedTextMessage: string read FFormattedTextMessage write SetFormattedTextMessage;
  end;

implementation

{ TFormattedUserMessage }

constructor TFormattedUserMessage.Create(const formatMessage: string;
  const Args: array of const);
begin

end;

procedure TFormattedUserMessage.SetFormattedTextMessage(const Value: string);
begin
  FFormattedTextMessage := Value;
end;

end.
