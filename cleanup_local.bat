@echo off
REM Remove lines with woofwoof.ddns.net:<any port> or "coming in" from all files recursively

for /r %%f in (*.*) do (
    findstr /v /i /r /c:"woofwoof\.ddns\.net:[0-9][0-9]*" /c:"coming in" "%%f" > "%%f.tmp" && move /y "%%f.tmp" "%%f" >nul
)
echo Cleanup complete.
pause