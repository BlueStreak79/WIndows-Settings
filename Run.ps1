# Change Windows settings

# Open default explorer to This PC
# Reference: https://superuser.com/a/1016949
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v LaunchTo /t REG_DWORD /d 1 /f

# Disable show recently used files & show frequently used folders
# Reference: https://superuser.com/a/1117295
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v Start_TrackDocs /t REG_DWORD /d 0 /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v Start_TrackProgs /t REG_DWORD /d 0 /f

# Change color to Light in personalization
# Reference: https://superuser.com/a/1097611
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize" /v SystemUsesLightTheme /t REG_DWORD /d 1 /f

# Enable automatically pick an accent color from my background
# Reference: https://www.windowscentral.com/how-enable-windows-10-dark-mode
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize" /v SystemUsesLightTheme /t REG_DWORD /d 1 /f

# Enable title bars & window borders
# Reference: https://www.windowscentral.com/how-enable-windows-10-dark-mode
reg add "HKCU\Control Panel\Colors" /v TitleText /t REG_SZ /d "0 0 0" /f

# Enable desktop icons: Computer, User's Files, Network, Recycle Bin, Control Panel
# Reference: https://superuser.com/a/1557199
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel" /v {20D04FE0-3AEA-1069-A2D8-08002B30309D} /t REG_DWORD /d 0 /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel" /v {59031a47-3f72-44a7-89c5-5595fe6b30ee} /t REG_DWORD /d 0 /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel" /v {F02C1A0D-BE21-4350-88B0-7367FC96EF3C} /t REG_DWORD /d 0 /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel" /v {645FF040-5081-101B-9F08-00AA002F954E} /t REG_DWORD /d 0 /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel" /v {5399E694-6CE5-4D6C-8FCE-1D8870FDCBA0} /t REG_DWORD /d 0 /f

# Enable all folders to appear on start
# Reference: https://superuser.com/a/949204
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v StartMenuInit /t REG_DWORD /d 1 /f

# Combine taskbar buttons when taskbar is full
# Reference: https://superuser.com/a/1202845
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v TaskbarGlomming /t REG_DWORD /d 1 /f

# Change time zone to +5:30 & format to AM & PM
# Reference: https://superuser.com/a/1403578
tzutil /s "India Standard Time"
reg add "HKCU\Control Panel\International" /v sTimeFormat /t REG_SZ /d "h:mm tt" /f

# Attempt to restart explorer after all changes are made to apply changes
# Reference: https://superuser.com/a/1003549
Stop-Process -Name explorer -Force

# Confirmation output
Write-Host "Windows settings have been successfully updated."

