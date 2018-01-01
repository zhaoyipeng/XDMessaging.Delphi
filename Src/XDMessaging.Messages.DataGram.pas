unit XDMessaging.Messages.DataGram;

interface

uses
  System.SysUtils,
  System.JSON.Serializers;

type
  TDataGram = class
  private const
    AppVersion = '1.1';
  private
    [JsonName('type')]
    FAssemblyQualifiedName: string;

    [JsonName('channel')]
    FChannel: string;

    [JsonName('message')]
    FMessage: string;

    [JsonName('ver')]
    FVersion: string;
    procedure SetAssemblyQualifiedName(const Value: string);
    procedure SetChannel(const Value: string);
    procedure SetMessage(const Value: string);
    procedure SetVersion(const Value: string);
  public
    constructor Create; overload;
    constructor Create(const AChannel, AnAssemblyQualifiedName,
      AMessage: string); overload;
    function IsValid: Boolean;
  published
    property AssemblyQualifiedName: string read FAssemblyQualifiedName
      write SetAssemblyQualifiedName;
    property Channel: string read FChannel write SetChannel;
    property Message: string read FMessage write SetMessage;
    property Version: string read FVersion write SetVersion;
    function ToString: string;
  end;

implementation

{ TDataGram }

constructor TDataGram.Create;
begin
  Version := AppVersion;
end;

constructor TDataGram.Create(const AChannel, AnAssemblyQualifiedName,
  AMessage: string);
begin
  Channel := AChannel;
  AssemblyQualifiedName := AnAssemblyQualifiedName;
  Message := AMessage;
  Version := AppVersion;
end;

function TDataGram.IsValid: Boolean;
begin
  Result := (not Channel.IsEmpty) and (not Message.IsEmpty);
end;

procedure TDataGram.SetAssemblyQualifiedName(const Value: string);
begin
  FAssemblyQualifiedName := Value;
end;

procedure TDataGram.SetChannel(const Value: string);
begin
  FChannel := Value;
end;

procedure TDataGram.SetMessage(const Value: string);
begin
  FMessage := Value;
end;

procedure TDataGram.SetVersion(const Value: string);
begin
  FVersion := Value;
end;

function TDataGram.ToString: string;
begin
  Result := Channel + ':' + Message;
end;

end.
