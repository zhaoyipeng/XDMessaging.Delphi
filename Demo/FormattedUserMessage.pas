unit FormattedUserMessage;

interface

uses
  System.SysUtils,
  System.JSON.Serializers;

type
  TFormattedUserMessage = class
  private
    [JsonName('FormattedTextMessage')]
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
  FFormattedTextMessage := Format(formatMessage, Args);
end;

procedure TFormattedUserMessage.SetFormattedTextMessage(const Value: string);
begin
  FFormattedTextMessage := Value;
end;

end.
