Param(
  [Parameter(Position=0, HelpMessage="Command")]
  [string]
  $Command = 'build',

  [Parameter(HelpMessage="The build configuration (Release, Debug, RelWithDebInfo, MinSizeRel).")]
  [string]
  $Config = "Release"
)

$SrcDir = "src"
$BuildDir = "build\$Config"

if (!(Test-Path -Path $BuildDir))
{
  New-Item -ItemType directory -Path $BuildDir | Out-Null
}

switch ($Command.ToLower())
{
  "configure"
  {
    & cmake.exe -B "$BuildDir" -S "$SrcDir" -G "Visual Studio 17 2022"
  }
  "build"
  {
    & cmake.exe --build "$BuildDir" --config "$Config" --target ALL_BUILD
  }
  "clean"
  {
    Remove-Item -Force -Recurse -Path "build"
  }
}
