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
set "FILE_NAME=.editorconfig"
set "SOURCE_PATH=%ParentDir%\%SubmoduleDir%\%FILE_NAME%"

echo    - Root detected at: %CD%
echo    - Source file is:   %SOURCE_PATH%
echo.

:: 4. Check if a .editorconfig already exists at the Root
if exist "%FILE_NAME%" (
    echo [INFO] A %FILE_NAME% file already exists at the root.
    set /p "CHOICE=Do you want to overwrite it with the copy? [Y/N] "
    if /i "!CHOICE!" neq "Y" (
        echo Operation cancelled.
        goto :End
    )
    :: No need to explicitly del, copy /Y handles overwrite, but this keeps intent clear
)

:: 5. Create the Copy
:: We are currently at the Root. 
:: Syntax: copy /Y [Source] [Destination]
echo Copying file...
copy /Y "%SOURCE_PATH%" "%FILE_NAME%"

if %errorlevel% neq 0 (
    echo.
    echo [ERROR] Failed to copy file.
    echo ---------------------------------------------------
    echo Please check if the source file exists and
    echo that you have write permissions for this folder.
    echo ---------------------------------------------------
) else (
    echo.
    echo [SUCCESS] Root .editorconfig has been updated from submodule!
)

:End
pause
popd