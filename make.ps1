Param(
  [Parameter(Position=0, HelpMessage="Command")]
  [string]
  $Command = 'build',

  [Parameter(HelpMessage="The build configuration (Release, Debug, RelWithDebInfo, MinSizeRel).")]
  [string]
  $Config = "Release"
)

$BaseDir = Split-Path $script:MyInvocation.MyCommand.Path

$SrcDir = "$BaseDir\src"
$BuildDir = "$BaseDir\build"

if (!(Test-Path -Path $BuildDir))
{
  New-Item -ItemType directory -Path $BuildDir | Out-Null
}

switch ($Command.ToLower())
{
  "configure"
  {
    Write-Host "cmake.exe -B `"$BuildDir`" -S `"$SrcDir`" -G `"Visual Studio 17 2022`""
    & cmake.exe -B "$BuildDir" -S "$SrcDir" -G "Visual Studio 17 2022"
  }
  "build"
  {
    Write-Host "cmake.exe --build `"$BuildDir`" --config `"$Config`" --target ALL_BUILD"
    & cmake.exe --build "$BuildDir" --config "$Config" --target ALL_BUILD
  }
  "clean"
  {
    Remove-Item -Force -Recurse -Path "$BaseDir\build"
  }
}
