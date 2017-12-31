unit XDMessaging.Transport.WindowsMessaging.WindowEnumFilter;

interface

uses
  Winapi.Windows;

type
  TWindowEnumFilter = class(TInterfacedObject)
  private
    FProperty: string;
  public
    constructor Create(AProperty: string);
    procedure WindowFilterHandler(Handle: HWND; var include: Boolean);
  end;
implementation

{ TWindowEnumFilter }

constructor TWindowEnumFilter.Create(AProperty: string);
begin
  Self.FProperty := AProperty;
end;

procedure TWindowEnumFilter.WindowFilterHandler(Handle: HWND;
  var include: Boolean);
begin
  if (GetProp(Handle, PChar(FProperty)) = 0) then
  begin
    include := False;
  end;
end;

end.
