unit XDMessaging.Transport.WindowsMessaging.WindowsEnum;

interface

uses
  Winapi.Windows,
  System.SysUtils,
  System.Generics.Collections;

type
  WindowFilterHandler = procedure(Handle: HWND; var include: Boolean) of object;

  TWindowsEnum = class(TInterfacedObject)
  private
    FFilterHandler: WindowFilterHandler;
    FWinEnumList: TList<HWND> ;
  public
    constructor Create(filterHandler: WindowFilterHandler);
    destructor Destroy; override;
    function Enumerate: TList<HWND>;
  end;
implementation

function OnWindowEnum(Handle: HWND; obj: TWindowsEnum): Boolean; stdcall;
var
  include: Boolean;
begin
  include := true;
  obj.FFilterHandler(Handle, include);
  if (include) then
  begin
    obj.FWinEnumList.Add(Handle);
  end;
  Result := True;
end;

{ TWindowsEnum }

constructor TWindowsEnum.Create(filterHandler: WindowFilterHandler);
begin
  FFilterHandler := filterHandler;
  FWinEnumList := nil;
end;

destructor TWindowsEnum.Destroy;
begin
  FWinEnumList.Free;
  inherited;
end;

function TWindowsEnum.Enumerate: TList<HWND>;
begin
  if FWinEnumList = nil then
    FWinEnumList := TList<HWND>.Create
  else
    FWinEnumList.Clear;
  EnumWindows(@OnWindowEnum, LPARAM(Self));
  Result := FWinEnumList;
end;

end.
