# Change Windows settings

# Open default explorer to This PC
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v LaunchTo /t REG_DWORD /d 1 /f
Write-Host "Default explorer changed to This PC."

# Disable show recently used files & show frequently used folders
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v Start_TrackDocs /t REG_DWORD /d 0 /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v Start_TrackProgs /t REG_DWORD /d 0 /f
Write-Host "Disabled showing recently used files and frequently used folders."

# Change color to Light in personalization
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize" /v SystemUsesLightTheme /t REG_DWORD /d 1 /f
Write-Host "Changed personalization color to Light."

# Enable automatically pick an accent color from my background
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize" /v SystemAccentColorAuto /t REG_DWORD /d 1 /f
Write-Host "Enabled automatically picking an accent color from the background."

# Enable title bars & window borders
reg add "HKCU\SOFTWARE\Microsoft\Windows\DWM" /v ColorPrevalence /t REG_DWORD /d 1 /f
Write-Host "Enabled title bars and window borders."

# Enable desktop icons: Computer, User's Files, Network, Recycle Bin, Control Panel
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel" /v "{20D04FE0-3AEA-1069-A2D8-08002B30309D}" /t REG_DWORD /d 0 /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel" /v "{59031a47-3f72-44a7-89c5-5595fe6b30ee}" /t REG_DWORD /d 0 /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel" /v "{F02C1A0D-BE21-4350-88B0-7367FC96EF3C}" /t REG_DWORD /d 0 /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel" /v "{B4FB3F98-C1EA-428d-A78A-D1F5659CBA93}" /t REG_DWORD /d 0 /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel" /v "{5399E694-6CE5-4D6C-8FCE-1D8870FDCBA0}" /t REG_DWORD /d 0 /f
Write-Host "Enabled desktop icons: Computer, User's Files, Network, Recycle Bin, Control Panel."

# Enable all folders to appear on start
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v StartMenuInit /t REG_DWORD /d 1 /f
Write-Host "Enabled all folders to appear on start."

# Combine taskbar buttons when taskbar is full
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v TaskbarGlomming /t REG_DWORD /d 1 /f
Write-Host "Combined taskbar buttons when taskbar is full."

# Change time zone to +5:30 & format to AM & PM
tzutil /s "India Standard Time"
reg add "HKCU\Control Panel\International" /v sTimeFormat /t REG_SZ /d "h:mm tt" /f
Write-Host "Changed time zone to +5:30 and format to AM & PM."

# Attempt to restart explorer after all changes are made to apply changes
# Check if Explorer is running
if (Get-Process -Name explorer -ErrorAction SilentlyContinue) {
    Stop-Process -Name explorer -Force
    Start-Sleep -Seconds 2
    Start-Process explorer
}

# Confirmation output
Write-Host "Windows settings have been successfully updated."
