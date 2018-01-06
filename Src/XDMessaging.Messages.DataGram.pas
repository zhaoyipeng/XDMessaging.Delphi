unit XDMessaging.Messages.DataGram;

interface
{$INCLUDE XDMessaging.inc}
uses
  System.SysUtils,
  XDMessaging.Serialization.Serializer,
  {$IFDEF XD_VER320_up}
  System.JSON.Serializers
  {$ELSE}
  XSuperObject
  {$ENDIF}
  ;

type
  TDataGram = class
  private const
    AppVersion = '1.1';
  private
    {$IFDEF XD_VER320_up}
    [JsonName('type')]
    {$ENDIF}
    FAssemblyQualifiedName: string;

    {$IFDEF XD_VER320_up}
    [JsonName('channel')]
    {$ENDIF}
    FChannel: string;

    {$IFDEF XD_VER320_up}
    [JsonName('message')]
    {$ENDIF}
    FMessage: string;

    {$IFDEF XD_VER320_up}
    [JsonName('ver')]
    {$ENDIF}
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
    [ALIAS('type')]
    property AssemblyQualifiedName: string read FAssemblyQualifiedName
      write SetAssemblyQualifiedName;
    [ALIAS('channel')]
    property Channel: string read FChannel write SetChannel;
    [ALIAS('message')]
    property Message: string read FMessage write SetMessage;
    [ALIAS('ver')]
    property Version: string read FVersion write SetVersion;
    function ToString: string; override;
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
