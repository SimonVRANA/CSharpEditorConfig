@echo off
setlocal

:: Switch to the script's directory (inside .config/CsEditorConfig)
pushd "%~dp0"

:: Define source (current folder)
set "SOURCE=%~dp0.editorconfig"

:: Define destination (Go up two levels: CsEditorConfig -> .config -> Root)
set "DESTINATION=%~dp0..\..\.editorconfig"

echo [ConfigSync] Syncing .editorconfig...
echo    Source: %SOURCE%
echo    Target: %DESTINATION%

:: Copy the file, suppressing the overwrite prompt
copy /Y "%SOURCE%" "%DESTINATION%" >nul

if %errorlevel% equ 0 (
    echo [ConfigSync] Success.
) else (
    echo [ConfigSync] FAILED. Could not copy to repository root.
)

:: Restore original directory
popd