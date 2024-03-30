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

# Check and change color mode to light if needed (for Windows 10 and 11)
$colorModePath = "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize"
if (-not (Test-RegistryValue -Path $colorModePath -Name "AppsUseLightTheme" -ExpectedValue 1)) {
    Set-ItemProperty -Path $colorModePath -Name "AppsUseLightTheme" -Value 1
}

# Check and change accent color to automatic if needed (for Windows 10 and 11)
$accentColorPath = "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize"
if (-not (Test-RegistryValue -Path $accentColorPath -Name "SystemUsesLightTheme" -ExpectedValue 1)) {
    Set-ItemProperty -Path $accentColorPath -Name "SystemUsesLightTheme" -Value 1
}

# Check and enable accent color on title bars & window borders if needed (for Windows 10 and 11)
$dwmPath = "HKCU:\SOFTWARE\Microsoft\Windows\DWM"
if (-not (Test-RegistryValue -Path $dwmPath -Name "ColorPrevalence" -ExpectedValue 1)) {
    Set-ItemProperty -Path $dwmPath -Name "ColorPrevalence" -Value 1
}

# Check and enable all desktop icons if needed (for Windows 10 and 11)
$desktopIconsEnabled = Test-RegistryValue -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "HideIcons" -ExpectedValue 0
if (-not $desktopIconsEnabled) {
    Enable-DesktopIcons
}

# Check and enable all folders on start menu if needed (for Windows 10 and 11)
$startMenuPath = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced"
if (-not (Test-RegistryValue -Path $startMenuPath -Name "Start_ShowClassicMode" -ExpectedValue 0)) {
    Set-ItemProperty -Path $startMenuPath -Name "Start_ShowClassicMode" -Value 0
}

# Check and combine taskbar buttons when taskbar is full if needed (for Windows 10 and 11)
$taskbarPath = "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced"
if (-not (Test-RegistryValue -Path $taskbarPath -Name "TaskbarGlomming" -ExpectedValue 1)) {
    Set-ItemProperty -Path $taskbarPath -Name "TaskbarGlomming" -Value 1
}

# Restart Explorer to apply changes
Restart-Explorer

# Verification
Write-Host "Settings verification:"

Write-Host "Color mode: Light"
Write-Host "   Status:" (Test-RegistryValue -Path $colorModePath -Name "AppsUseLightTheme" -ExpectedValue 1)

Write-Host "Accent color: Automatic"
Write-Host "   Status:" (Test-RegistryValue -Path $accentColorPath -Name "SystemUsesLightTheme" -ExpectedValue 1)

Write-Host "Accent color on title bars & window borders: Enabled"
Write-Host "   Status:" (Test-RegistryValue -Path $dwmPath -Name "ColorPrevalence" -ExpectedValue 1)

Write-Host "All desktop icons: Enabled"
Write-Host "   Status:" $desktopIconsEnabled

Write-Host "All folders on start menu: Enabled"
Write-Host "   Status:" (Test-RegistryValue -Path $startMenuPath -Name "Start_ShowClassicMode" -ExpectedValue 0)

Write-Host "Combine taskbar buttons when taskbar is full: Enabled"
Write-Host "   Status:" (Test-RegistryValue -Path $taskbarPath -Name "TaskbarGlomming" -ExpectedValue 1)

Write-Host "Explorer settings applied."
