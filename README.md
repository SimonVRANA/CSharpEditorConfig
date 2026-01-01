# CSharpEditorConfig
This is my personal editor config that I'll be reusing in all my C# projects.

## Install
- create a folder named `.config`.
- run `git submodule add git@github.com:SimonVRANA/CSharpEditorConfig.git .config/CsEditorConfig` from your root folder.
- run `.config/CsEditorConfig/Install.bat`.
- commit in your main repository.

>:warning: You'll need to do the last two steps each time you update the submodule repository.<br/>Install makes a hard copy of the .editorconfig file since Visual Studio have issues handling symlinks.

## Tips
Enable code cleanup on save (ctrl+Q -> "run code cleanup on save")