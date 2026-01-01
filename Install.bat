@echo off
setlocal

:: ---------------------------------------------------------
:: ENSURE SCRIPT RUNS IN ITS OWN FOLDER
:: ---------------------------------------------------------
:: This handles cases where you run it from the root like:
:: .config\CsEditorConfig\Install.bat
pushd "%~dp0"

:: ---------------------------------------------------------
:: 1. FIND GIT HOOKS DIRECTORY
:: ---------------------------------------------------------
:: git rev-parse automatically finds the correct hook path for this specific submodule
for /f "delims=" %%i in ('git rev-parse --git-path hooks') do set "HOOKS_DIR=%%i"

if "%HOOKS_DIR%"=="" (
    echo [Error] Could not find Git hooks directory. 
    echo Are you sure this folder is inside a Git repository?
    popd
    exit /b 1
)

:: ---------------------------------------------------------
:: 2. CREATE THE POST-CHECKOUT HOOK
:: ---------------------------------------------------------
set "HOOK_FILE=%HOOKS_DIR%\post-checkout"
echo [Setup] Found hooks directory: %HOOKS_DIR%
echo [Setup] Creating 'post-checkout' hook...

:: The hook simply calls the copy script located in the same directory
(
    echo #!/bin/sh
    echo echo "Git Hook: Submodule updated. Syncing .editorconfig..."
    echo cmd.exe /c .\CopyEditorConfig.bat
) > "%HOOK_FILE%"

:: ---------------------------------------------------------
:: 3. RUN IT ONCE NOW
:: ---------------------------------------------------------
echo [Setup] Hook installed. Running initial sync...
call CopyEditorConfig.bat

echo.
echo [Setup] Complete. 
echo         The .editorconfig is synced to the repo root.
echo         It will auto-update whenever you update this submodule.

:: Restore original directory
popd
pause