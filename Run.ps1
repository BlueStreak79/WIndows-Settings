$ErrorActionPreference = SilentlyContinue

# Function to check and apply setting with restart prompt
function Set-SmartSetting ($keyPath, $name, $valueType, $value, $successMsg, $alreadyAppliedMsg) {
  $currentValue = Get-ItemProperty -Path $keyPath -Name $name -ErrorAction SilentlyContinue
  if ($currentValue -eq $value) {
    Write-Host $alreadyAppliedMsg
  } else {
    Regعداد Set-ItemProperty -Path $keyPath -Name $name -Type $valueType -Value $value
    Write-Host $successMsg
    $restartRequired = Read-Host "Some changes may require a restart to take effect. Restart now? (y/N): "
    if ($restartRequired -eq "y") {
      Restart-Computer -Force
    }
  }
}

# Explorer Settings
Set-SmartSetting -keyPath "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -name "Start_Mode" -valueType DWORD -value 1 -successMsg "Explorer set to open to This PC." -alreadyAppliedMsg "Explorer already opens to This PC."
Set-SmartSetting -keyPath "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -name "ShowRecentlyUsedFiles" -valueType DWORD -value 0 -successMsg "Disabled showing recently used files in Explorer." -alreadyAppliedMsg "Already disabled showing recently used files."
Set-SmartSetting -keyPath "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -name "ShowFrequentFolders" -valueType DWORD -value 0 -successMsg "Disabled showing frequently used folders in Explorer." -alreadyAppliedMsg "Already disabled showing frequently used folders."

# Personalization - Light theme & accent color
Set-SmartSetting -keyPath "HKCU:\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize" -name "AppsUseLightTheme" -valueType DWORD -value 1 -successMsg "Light theme applied." -alreadyAppliedMsg "Light theme already applied."
Set-SmartSetting -keyPath "HKCU:\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize" -name "SystemUsesLightTheme" -valueType DWORD -value 1 -successMsg "Light theme applied." -alreadyAppliedMsg "Light theme already applied."
Set-SmartSetting -keyPath "HKCU:\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize" -name "EnableAutomaticAccentColor" -valueType DWORD -value 1 -successMsg "Automatic accent color enabled." -alreadyAppliedMsg "Automatic accent color already enabled."

# Personalization - Enable title bars & borders, desktop icons
Set-SmartSetting -keyPath "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -name "ShellBrowserWindowBorders" -valueType DWORD -value 1 -successMsg "Enabled title bars and window borders." -alreadyAppliedMsg "Title bars and window borders already enabled."
Set-SmartSetting -keyPath "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -name "HideIcons" -valueType DWORD -value 0 -successMsg "Enabled desktop icons." -alreadyAppliedMsg "Desktop icons already enabled."

# Taskbar settings
Set-SmartSetting -keyPath "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Taskbar" -name "GroupBy" -valueType DWORD -value 2 -successMsg "Taskbar buttons will combine when full." -alreadyAppliedMsg "Taskbar buttons already combine when full."

# Start Menu settings
Set-SmartSetting -keyPath "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -name "Start_ShowAllSubItems" -valueType DWORD -value 1 -successMsg "Enabled showing all folders in Start menu." -alreadyAppliedMsg "Start menu already shows all folders."

# Time zone settings
Set-TimeZone -Id "India Standard Time"  # Time zone +5:30
wmic time set format "h:mm tt"  # Time format AM/PM

# Attempt Explorer restart (informational message)
Restart-Process explorer.exe -ErrorAction SilentlyContinue
Write-Host "Explorer restarted (may require logoff/logon for full effect)."

Write-Host "Script execution complete."
