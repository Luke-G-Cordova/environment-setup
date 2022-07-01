$username = [System.Environment]::UserName
oh-my-posh init pwsh --config C:\Users\$username\Documents\PowerShell\custom_themes\theme1.json | Invoke-Expression

Import-Module -Name Terminal-Icons

Set-PSReadLineOption -PredictionSource History

$VIMEXEPATH = "C:\Program Files\Git\usr\bin\vim.exe"

Set-Alias vim $VIMEXEPATH
Set-Alias vi $VIMEXEPATH

Set-PSReadLineOption -EditMode vi


$Env:SHELL_VI_MODE = "I"
Set-PSReadLineOption -ViModeIndicator Script -ViModeChangeHandler {
    Param($mode)

    if($mode -eq "Command"){
        $Env:SHELL_VI_MODE = "C"
        Write-Host -NoNewLine "`e[1 q"
    } else {
        $Env:SHELL_VI_MODE = "I"
        Write-Host -NoNewLine "`e[5 q"
    }
    [Microsoft.PowerShell.PSConsoleReadLine]::InvokePrompt()
}


# custom key handlers

# $wshell = New-Object -ComObject wscript.shell;

# Set-PSReadlineKeyHandler -ViMode Insert -Key 'j,j', 'j,k' -ScriptBlock {
#     param($key, $arg)
#     $wshell.SendKeys('{ESC}');
# }

# Set-PSReadLineKeyHandler -ViMode Insert -Key 'j' -ScriptBlock {
#     $line = $null
#     $cursor = $null
#     Start-Sleep -Milliseconds 100
#     [Microsoft.PowerShell.PSConsoleReadLine]::GetBufferState([ref]$line, [ref]$cursor)
#     [Microsoft.PowerShell.PSConsoleReadLine]::Insert("j")
#     [Microsoft.PowerShell.PSConsoleReadLine]::SetCursorPosition($cursor + 1)
# }

# Set-PSReadlineKeyHandler -Key Tab -Function MenuComplete

# Set-PSReadLineKeyHandler -ViMode Insert -Chord 'j' -ScriptBlock{
#     $wshell = New-Object -ComObject wscript.shell;
#     $wshell.SendKeys('{ESC}');
# } 

# smart braces

