@echo off
:: Request admin rights if not already running as admin
net session >nul 2>&1
if %errorlevel% neq 0 (
    echo Requesting administrator privileges...
    powershell -Command "Start-Process '%~f0' -Verb RunAs"
    exit /b
)

echo Running as administrator...

:: Set the folder to clean (change as needed)
set "TARGET=overrides\config"

:: Loop through files, skip the batch file itself
for /r "%TARGET%" %%f in (*.*) do (
    if /i not "%%~nxf"=="%~nx0" (
        >nul 2>&1 (
            findstr /v /i /r /c:"woofwoof\.ddns\.net:[0-9][0-9]*" /c:"coming in" "%%f" > "%%f.tmp" && move /y "%%f.tmp" "%%f"
        )
    )
)
echo Cleanup complete.
echo Looking for .tmp files in %TARGET% and subfolders...
for /r "%TARGET%" %%t in (*.tmp) do echo Found: %%t
echo Deleting all .tmp files in %TARGET% and subfolders...
for /f "delims=" %%t in ('dir /b /s "%TARGET%\*.tmp" 2^>nul') do (
    echo Deleting: %%t
    del /f /q "%%t"
)
pause