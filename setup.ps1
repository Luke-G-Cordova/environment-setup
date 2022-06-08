
$hasPackageManager = Get-AppPackage -name 'Microsoft.DesktopAppInstaller'
if (!$hasPackageManager -or [version]$hasPackageManager.Version -lt [version]"1.10.0.0") {
    "Installing winget Dependencies"
    Add-AppxPackage -Path 'https://aka.ms/Microsoft.VCLibs.x64.14.00.Desktop.appx'

    $releases_url = 'https://api.github.com/repos/microsoft/winget-cli/releases/latest'

    [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
    $releases = Invoke-RestMethod -uri $releases_url
    $latestRelease = $releases.assets | Where { $_.browser_download_url.EndsWith('msixbundle') } | Select -First 1

    "Installing winget from $($latestRelease.browser_download_url)"
    Add-AppxPackage -Path $latestRelease.browser_download_url
}else {
    "winget already installed"
}


winget install --id Microsoft.WindowsTerminal

winget install --id Microsoft.PowerShell 

winget install oh-my-posh

Install-Module -Name PSReadLine

Install-Module -Name Terminal-Icons -Repository PSGallery

$username = [System.Environment]::UserName
Remove-Item -r C:\Users\$username\Documents\PowerShell
Copy-Item -Path ".\PowerShell" -Destination "C:\Users\$username\Documents\PowerShell" -Recurse


echo "Installing fonts"
cd CascadiaCode
$fonts = (New-Object -ComObject Shell.Application).Namespace(0x14)
foreach ($file in Get-ChildItem *.ttf){
    $fileName = $file.Name
    if (-not(Test-Path -Path "C:\Users\$username\AppData\Local\Microsoft\Windows\Fonts\$fileName")-and(Test-Path -Path "C:\Windows\fonts\$fileName")) {
        echo $fileName
        Get-ChildItem $file | %{ $fonts.CopyHere($_.fullname) }
    }else{
        echo "$fileName already installed"
    }
}
cd ..

echo "----- Make sure you change your terminal fonts to CaskaydiaCove Nerd Font -----"