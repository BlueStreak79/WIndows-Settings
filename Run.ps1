# Set Date & Time to +5:30 (Indian Standard Time)
tzutil /s "India Standard Time"

# Set Theme to Light
New-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize" -Name "SystemUsesLightTheme" -Value 1 -PropertyType DWORD -Force
New-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize" -Name "AppsUseLightTheme" -Value 1 -PropertyType DWORD -Force

# Set Lock Screen to Windows Spotlight (this part may need to be done manually)
# Note: No direct PowerShell command to apply Windows Spotlight to desktop wallpaper, only lock screen.
# Navigate to Settings > Personalization > Lock screen > Background: Select "Windows Spotlight" manually.

# Enable All Desktop Icons (Computer, Network, User Files, Recycle Bin)
$regPath = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel"
Set-ItemProperty -Path $regPath -Name "{20D04FE0-3AEA-1069-A2D8-08002B30309D}" -Value 0  # This PC
Set-ItemProperty -Path $regPath -Name "{F02C1A0D-BE21-4350-88B0-7367FC96EF3C}" -Value 0  # Network
Set-ItemProperty -Path $regPath -Name "{59031a47-3f72-44a7-89c5-5595fe6b30ee}" -Value 0  # User Files
Set-ItemProperty -Path $regPath -Name "{645FF040-5081-101B-9F08-00AA002F954E}" -Value 0  # Recycle Bin

# Taskbar: Only Show Search Icon
New-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Search" -Name "SearchboxTaskbarMode" -Value 1 -PropertyType DWORD -Force

# News & Interests set to Full view (has to be done manually)
# Right-click the Taskbar > News and Interests > Show icon and text (manual setting)

# Set File Explorer to open to "This PC" by default
New-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "LaunchTo" -Value 1 -PropertyType DWORD -Force

# Disable Quick Access in File Explorer (disable Frequent and Recent files)
New-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "ShowFrequent" -Value 0 -PropertyType DWORD -Force
New-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "ShowRecent" -Value 0 -PropertyType DWORD -Force

# Refresh Explorer to apply changes
Stop-Process -Name explorer -Force
Start-Process explorer