# Function to check if a registry value exists and matches a given data
function Test-RegistryValue {
    param (
        [string]$Path,
        [string]$Name,
        [string]$ExpectedValue
    )
    $value = Get-ItemProperty -Path $Path -Name $Name -ErrorAction SilentlyContinue
    if ($value -ne $null -and $value.$Name -eq $ExpectedValue) {
        return $true
    }
    return $false
}

# Function to enable desktop icons
function Enable-DesktopIcons {
    $shell = New-Object -ComObject shell.application
    $folder = $shell.Namespace('Desktop')
    $folderItem = $folder.Self
    $folderItem.InvokeVerb('Show')
}

# Function to restart Explorer process
function Restart-Explorer {
    Stop-Process -Name explorer -Force
    Start-Process explorer
}

# Function to set Explorer settings
function Set-ExplorerSettings {
    # Open default Explorer to This PC
    Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "LaunchTo" -Value 1

    # Disable showing recently used files in Quick access
    Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer" -Name "ShowRecent" -Value 0

    # Disable showing frequently used folders in Quick access
    Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer" -Name "ShowFrequent" -Value 0
}

# Set Explorer settings
Set-ExplorerSettings

# Check and change color mode to light if needed (for Windows 10 and 11)
$colorModePath = "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize"
$colorModeValue = "AppsUseLightTheme"
$colorModeExpectedValue = 1
$colorModeStatus = Test-RegistryValue -Path $colorModePath -Name $colorModeValue -ExpectedValue $colorModeExpectedValue

# Check and change accent color to automatic if needed (for Windows 10 and 11)
$accentColorPath = "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize"
$accentColorValue = "SystemUsesLightTheme"
$accentColorExpectedValue = 1
$accentColorStatus = Test-RegistryValue -Path $accentColorPath -Name $accentColorValue -ExpectedValue $accentColorExpectedValue

# Check and enable accent color on title bars & window borders if needed (for Windows 10 and 11)
$dwmPath = "HKCU:\SOFTWARE\Microsoft\Windows\DWM"
$dwmValue = "ColorPrevalence"
$dwmExpectedValue = 1
$dwmStatus = Test-RegistryValue -Path $dwmPath -Name $dwmValue -ExpectedValue $dwmExpectedValue

# Check and enable all desktop icons if needed (for Windows 10 and 11)
$desktopIconsPath = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced"
$desktopIconsValue = "HideIcons"
$desktopIconsExpectedValue = 0
$desktopIconsStatus = Test-RegistryValue -Path $desktopIconsPath -Name $desktopIconsValue -ExpectedValue $desktopIconsExpectedValue
if (-not $desktopIconsStatus) {
    Enable-DesktopIcons
}

# Check and combine taskbar buttons when taskbar is full if needed (for Windows 10 and 11)
$taskbarPath = "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced"
$taskbarValue = "TaskbarGlomming"
$taskbarExpectedValue = 1
$taskbarStatus = Test-RegistryValue -Path $taskbarPath -Name $taskbarValue -ExpectedValue $taskbarExpectedValue

# Restart Explorer to apply changes
Restart-Explorer

# Output verification
Write-Host "Settings verification:"

Write-Host "Color mode: Light"
Write-Host "   Status:" -NoNewline
if ($colorModeStatus) {
    Write-Host "  [Green]Enabled[/Green]"
} else {
    Write-Host "  [Red]Disabled[/Red]"
}

Write-Host "Accent color: Automatic"
Write-Host "   Status:" -NoNewline
if ($accentColorStatus) {
    Write-Host "  [Green]Enabled[/Green]"
} else {
    Write-Host "  [Red]Disabled[/Red]"
}

Write-Host "Accent color on title bars & window borders: Enabled"
Write-Host "   Status:" -NoNewline
if ($dwmStatus) {
    Write-Host "  [Green]Enabled[/Green]"
} else {
    Write-Host "  [Red]Disabled[/Red]"
}

Write-Host "All desktop icons: Enabled"
Write-Host "   Status:" -NoNewline
if ($desktopIconsStatus) {
    Write-Host "  [Green]Enabled[/Green]"
} else {
    Write-Host "  [Red]Disabled[/Red]"
}

Write-Host "Combine taskbar buttons when taskbar is full: Enabled"
Write-Host "   Status:" -NoNewline
if ($taskbarStatus) {
    Write-Host "  [Green]Enabled[/Green]"
} else {
    Write-Host "  [Red]Disabled[/Red]"
}

Write-Host "Explorer settings applied."
