param (
    [string]$InputFile
)

# 1. 设置工具目录
$ToolDir = Split-Path -Parent $MyInvocation.MyCommand.Path

# 2. 设置配件路径
$CssFile = Join-Path $ToolDir "style.css"
$LuaFilter = Join-Path $ToolDir "mermaid-build.lua"
$AppendFile = Join-Path $ToolDir "mermaid_script.html"

# 3. 设置输出路径 (把 .md 换成 _preview.html)
$BaseName = [System.IO.Path]::GetFileNameWithoutExtension($InputFile)

$ParentDir = Split-Path -Parent $InputFile

$OutputFileName = $BaseName + "_preview.html"
$OutputFile = Join-Path $ParentDir $OutputFileName

# 4. 运行 Pandoc
# PowerShell 使用 & 符号调用命令，对带空格的路径极其友好
& pandoc "$InputFile" -o "$OutputFile" `
    --lua-filter "$LuaFilter" `
    --css "$CssFile" `
    --embed-resources `
    --standalone `
    -A "$AppendFile"

# 返回退出码
exit $LASTEXITCODE
