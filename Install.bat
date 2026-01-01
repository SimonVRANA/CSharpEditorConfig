@echo off
setlocal EnableDelayedExpansion

:: 1. Navigate to the folder where this script (and .editorconfig) resides
pushd "%~dp0"

:: 2. Dynamically determine the folder names
:: We assume the structure is Root -> ParentFolder (.config) -> SubmoduleFolder (CsEditorConfig) -> ThisScript
echo [Setup] detecting paths...
:: Get the Submodule Folder Name (e.g., CsEditorConfig)
for %%I in (.) do set "SubmoduleDir=%%~nxI"
:: Go up one level to the Parent Folder
cd ..
for %%I in (.) do set "ParentDir=%%~nxI"
:: Go up one more level to the Main Repository Root
cd ..

:: 3. Define paths relative to the Main Root
set "LINK_NAME=.editorconfig"
set "TARGET_PATH=%ParentDir%\%SubmoduleDir%\%LINK_NAME%"

echo    - Root detected at: %CD%
echo    - Target file is:   %TARGET_PATH%
echo.

:: 4. Check if a .editorconfig already exists at the Root
if exist "%LINK_NAME%" (
    echo [INFO] A %LINK_NAME% file already exists at the root.
    set /p "CHOICE=Do you want to replace it with the symlink? [Y/N] "
    if /i "!CHOICE!" neq "Y" (
        echo Operation cancelled.
        goto :End
    )
    del "%LINK_NAME%"
)

:: 5. Create the Symbolic Link
:: We are currently at the Root, so we link "Target Path" to ".editorconfig"
echo Creating symlink...
mklink "%LINK_NAME%" "%TARGET_PATH%"

if %errorlevel% neq 0 (
    echo.
    echo [ERROR] Failed to create symlink.
    echo ---------------------------------------------------
    echo Windows requires Administrator privileges for this.
    echo Please right-click Install.bat and "Run as administrator".
    echo ---------------------------------------------------
) else (
    echo.
    echo [SUCCESS] Root .editorconfig now linked to submodule!
)

:End
pause
popd