# CSharpEditorConfig
This is my personal editor config that I'll be reusing in all my C# projects.

## Install
- create a folder named `.config`.
- run `git submodule add git@github.com:SimonVRANA/CSharpEditorConfig.git .config/CsEditorConfig` from your root folder.
- run `.config/CsEditorConfig/Install.bat`.
- commit in your main repository.

>:warning: Install.bat will create a git hook to the submodule, updating the .editorconfig file in your main repository each time you update the submodule. Don't forget to commit the .editorconfig file in the main repository if it has changes.

## Tips
Enable code cleanup on save (ctrl+Q -> "run code cleanup on save")