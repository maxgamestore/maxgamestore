@echo off
title World Of Fights - Installer
echo ========================================
echo   WORLD OF FIGHTS - INSTALLER
echo ========================================
echo.

REM Crează folderul de instalare
set INSTALL_DIR=%USERPROFILE%\Desktop\WorldOfFights
if not exist "%INSTALL_DIR%" mkdir "%INSTALL_DIR%"

REM Descarcă Launcherul de pe GitHub
curl -L -o "%INSTALL_DIR%\WorldOfFights_Launcher.jar" "https://raw.githubusercontent.com/maxgamestore/maxgamestore/main/launcher/WorldOfFights_Launcher.jar"

REM Crează shortcut pe Desktop
powershell -Command "$WS = New-Object -ComObject WScript.Shell; $SC = $WS.CreateShortcut('%USERPROFILE%\Desktop\World Of Fights.lnk'); $SC.TargetPath = 'javaw'; $SC.Arguments = '-jar \"%INSTALL_DIR%\WorldOfFights_Launcher.jar\"'; $SC.WorkingDirectory = '%INSTALL_DIR%'; $SC.Save()"

echo.
echo ========================================
echo   INSTALARE FINALIZATA!
echo ========================================
echo.
echo Pe Desktop a aparut shortcut-ul "World Of Fights"
echo.
pause
