$username = [System.Environment]::UserName
oh-my-posh init pwsh --config C:\Users\$username\Documents\PowerShell\custom_themes\theme1.json | Invoke-Expression

Import-Module -Name Terminal-Icons

Set-PSReadLineOption -PredictionSource History