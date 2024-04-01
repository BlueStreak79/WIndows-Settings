$ErrorActionPreference = SilentlyContinue

# Function to check and apply setting with restart prompt after all changes
function Set-SmartSetting ($keyPath, $name, $valueType, $value, $successMsg) {
  $currentValue = Get-ItemProperty -Path $keyPath -Name $name -ErrorAction SilentlyContinue
  if ($currentValue -eq $value) {
    Write-Host "$name setting already applied."
  } else {
    Regعداد Set-ItemProperty -Path $keyPath -Name $name -Type $valueType -Value $value
    Write-Host $successMsg
  }
}

# Explorer Settings (combined)
Set-SmartSetting -keyPath "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -name "Start_Mode" -valueType DWORD -value 1 -successMsg "Explorer set to open to This PC and hide recently used files & folders."
Set-SmartSetting -keyPath "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -name "ShowRecentlyUsedFiles" -valueType DWORD -value 0
Set-SmartSetting -keyPath "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -name "ShowFrequentFolders" -valueType DWORD -value 0

# Personalization (combined)
Set-SmartSetting -keyPath "HKCU:\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize" -name "AppsUseLightTheme" -valueType DWORD -value 1 -successMsg "Light theme applied with automatic accent color."
Set-SmartSetting -keyPath "HKCU:\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize" -name "SystemUsesLightTheme" -valueType DWORD -value 1
Set-SmartSetting -keyPath "HKCU:\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize" -name "EnableAutomaticAccentColor" -valueType DWORD -value 1

# Personalization - Enable title bars & borders, desktop icons
Set-SmartSetting -keyPath "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -name "ShellBrowserWindowBorders" -valueType DWORD -value 1 -successMsg "Enabled title bars, window borders, and desktop icons."
Set-SmartSetting -keyPath "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -name "HideIcons" -valueType DWORD -value 0

# Taskbar settings
Set-SmartSetting -keyPath "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Taskbar" -name "GroupBy" -valueType DWORD -value 2 -successMsg "Taskbar buttons will combine when full."

# Start Menu settings
Set-SmartSetting -keyPath "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -name "Start_ShowAllSubItems" -valueType DWORD -value 1 -successMsg "Enabled showing all folders in Start menu."

# Time zone settings
Set-TimeZone -Id "India Standard Time"  # Time zone +5:30
wmic time set format "h:mm tt"  # Time format AM/PM

# Attempt Explorer restart (informational message after all changes)
Restart-Process explorer.exe -ErrorAction SilentlyContinue
Write-Host "Explorer restarted (may require logoff/logon for full effect)."

Write-Host "Script execution complete."
