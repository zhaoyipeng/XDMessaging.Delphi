unit XDMessaging.Transport.IOStream.XDIOStreamBroadcaster;

interface

uses
  Winapi.Windows,
  Winapi.ShlObj,
  System.SysUtils,
  System.Threading,
  System.Types,
  XDMessaging.XDBroadcaster,
  XDMessaging.Serialization.Serializer;

type
  XDIOStreamBroadcaster = class(TInterfacedObject, IXDBroadcaster)
  private const
    MutexCleanUpKey = 'Global\XDIOStreamBroadcastv4.Cleanup';
  private class var
    InvalidChannelChars: TArray<Char>;
    TemporaryFolder: string;
  private
    FMessageTimeoutInMilliseconds: Integer;
    FSerializer: TSerializer;
    class constructor Create;
    procedure CleanUpOldMessagesForAllChannels;
    class procedure CleanUpMessages(directory: string;
      fileTimeoutMilliseconds: Integer); static;
    class function GetChannelDirectory(const channelName: string): string;
    class function GetChannelKey(const channelName: string): string;
  public
    constructor Create(ASerializer: TSerializer; AMessageTimeoutInMilliseconds: UInt32);
    function GetAlive: Boolean;
    property IsAlive: Boolean read GetAlive;
    procedure SendToChannel(const channel: string; const message: string); overload;
    procedure SendToChannel(const channel: string; message: TObject); overload;
  end;

implementation

uses
  System.IOUtils;

{ XDIOStreamBroadcaster }
procedure getFolder(aLocation: Integer; var path: string); // path为输出参数
var
  pIdl: PItemIDList;
  hPath: PChar;
begin
  if SUCCEEDED(SHGetSpecialFolderLocation(0, aLocation, pIdl)) then
  begin
    hPath := StrAlloc(max_path);
    SHGetPathFromIDList(pIdl, hPath);
    path := strpas(hPath);
    StrDispose(hPath);
  end;
end;

class constructor XDIOStreamBroadcaster.Create;
var
  AppDataPath: string;
begin
  getFolder(CSIDL_COMMON_APPDATA, AppDataPath);
  TemporaryFolder := TPath.Combine(AppDataPath, 'XDMessagingv4');
  InvalidChannelChars := TPath.GetInvalidPathChars;
end;

class procedure XDIOStreamBroadcaster.CleanUpMessages(directory: string; fileTimeoutMilliseconds: Integer);
begin
//        {
//            try
//            {
//                if (!Directory.Exists(directory.FullName))
//                {
//                    return;
//                }
//
//                foreach (var file in directory.GetFiles("*.msg"))
//                {
//                    if (file.CreationTimeUtc > DateTime.UtcNow.AddMilliseconds(-fileTimeoutMilliseconds)
//                        || !File.Exists(file.FullName))
//                    {
//                        continue;
//                    }
//
//                    try
//                    {
//                        file.Delete();
//                    }
//                    catch (IOException)
//                    {
//                    }
//                    catch (UnauthorizedAccessException)
//                    {
//                    }
//                }
//            }
//            catch (IOException)
//            {
//            }
//            catch (UnauthorizedAccessException)
//            {
//            }
//        }
end;

procedure XDIOStreamBroadcaster.CleanUpOldMessagesForAllChannels;
var
  Dirs: TStringDynArray;
begin
  Dirs := TDirectory.GetDirectories(TemporaryFolder, '*', TSearchOption.soTopDirectoryOnly);
  TParallel.For(0, High(Dirs),
    procedure(I: Int64)
    var
      directory: string;
      Files: TStringDynArray;
    begin
        directory := Dirs[I];
        CleanUpMessages(directory, FMessageTimeoutInMilliseconds);
        Files := TDirectory.GetFiles(directory);
        if (Length(Files) = 0) and (TDirectory.GetLastAccessTime(directory) < (Now - 30)) then
        begin
            TDirectory.Delete(directory);
        end;
    end);
end;

constructor XDIOStreamBroadcaster.Create(ASerializer: TSerializer;
  AMessageTimeoutInMilliseconds: UInt32);
begin
  FSerializer := ASerializer;
  FMessageTimeoutInMilliseconds := AMessageTimeoutInMilliseconds;
  TTask.Run(
    procedure
    begin
      CleanUpOldMessagesForAllChannels
    end);
end;

function XDIOStreamBroadcaster.GetAlive: Boolean;
begin

end;

class function XDIOStreamBroadcaster.GetChannelDirectory(
  const channelName: string): string;
var
  folder, channelKey: string;
//  sfo: TJwSecureFileObject;
begin
   channelKey := GetChannelKey(channelName);
   folder := TPath.Combine(TemporaryFolder, channelKey);
   if (not TDirectory.Exists(folder)) then
   begin
     TDirectory.CreateDirectory(folder);
//      try
//          var directorySecurity = TDirectory.GetAccessControl(folder);
//          var everyone = new SecurityIdentifier(WellKnownSidType.WorldSid, null);
//          directorySecurity.AddAccessRule(new FileSystemAccessRule(everyone,
//              FileSystemRights.Modify | FileSystemRights.Read | FileSystemRights.Write |
//              FileSystemRights.Delete |
//              FileSystemRights.Synchronize,
//              InheritanceFlags.ContainerInherit | InheritanceFlags.ObjectInherit, PropagationFlags.None,
//              AccessControlType.Allow));
//          Directory.SetAccessControl(folder, directorySecurity);
//      except
//
//      end;
   end;
end;

class function XDIOStreamBroadcaster.GetChannelKey(
  const channelName: string): string;
var
  c: Char;
  I: Integer;
begin
  Result := channelName;
  for c in InvalidChannelChars do
  begin
    if Result.IndexOf(c) >= 0 then
    begin
      Result := Result.Replace(c, '_');
    end;
  end;
end;

procedure XDIOStreamBroadcaster.SendToChannel(const channel, message: string);
var
  fileName: string;
begin
  fileName := TGUID.NewGuid.ToString;
  fileName := fileName.Substring(1, fileName.Length-2);
//  folder := GetChannelDirectory(channel);
//            var filePath = Path.Combine(folder, string.Concat(fileName, ".msg"));
//
//            using (var writer = File.CreateText(filePath))
//            {
//                var dataGram = new DataGram(channelName, dataType, message);
//                writer.Write(serializer.Serialize(dataGram));
//                writer.Flush();
//            }
//
//            ThreadPool.QueueUserWorkItem(CleanUpMessages, new FileInfo(filePath).Directory);

end;

procedure XDIOStreamBroadcaster.SendToChannel(const channel: string;
  message: TObject);
begin

end;

end.
