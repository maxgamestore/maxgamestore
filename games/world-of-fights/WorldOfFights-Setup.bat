@echo off
title World Of Fights Installer
echo ========================================
echo   WORLD OF FIGHTS - INSTALLER
echo ========================================
echo.

REM Rulează ascuns (fără cmd vizibil)
if not "%1"=="hide" (
    start /min "" "%~0" hide
    exit
)

echo Se instaleaza jocul pe Desktop...
echo.

REM Crează folderul de instalare pe Desktop
set INSTALL_DIR=%USERPROFILE%\Desktop\WorldOfFights
if not exist "%INSTALL_DIR%" mkdir "%INSTALL_DIR%"
cd /d "%INSTALL_DIR%"

REM Descarcă BootLoader.java de pe GitHub
echo Descarc fisierul BootLoader.java...
curl -s -o BootLoader.java https://raw.githubusercontent.com/contul-tau/Management-of-project-incoming/main/games/world-of-fights/BootLoader.java

REM Compilează
echo Compileaza...
javac BootLoader.java
if errorlevel 1 (
    echo Eroare la compilare! Verifica daca ai Java instalat.
    pause
    exit /b
)

REM Crează shortcut pe Desktop
echo Creaza shortcut...
powershell -Command "$WS = New-Object -ComObject WScript.Shell; $SC = $WS.CreateShortcut('%USERPROFILE%\Desktop\World Of Fights.lnk'); $SC.TargetPath = 'java'; $SC.Arguments = '-cp \"%INSTALL_DIR%\" BootLoader'; $SC.WorkingDirectory = '%INSTALL_DIR%'; $SC.Save()"

echo.
echo ========================================
echo INSTALARE FINALIZATA!
echo ========================================
echo.
echo Pe Desktop a aparut shortcut-ul "World Of Fights"
echo Jocul se va porni automat...
echo.

REM Rulează jocul o dată
java BootLoader

exit
