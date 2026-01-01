@echo off

set "SOURCE=%~dp0.editorconfig"
set "DESTINATION=%~dp0..\.editorconfig"

echo [ConfigSync] Copying .editorconfig to main repository...
copy /Y "%SOURCE%" "%DESTINATION%"