@echo off
if "%1"=="" goto loop
copy brick%1.in brick.in >nul
echo Problem Test
echo Data %1
time<enter
brick.exe
time<enter
copy brick%1.out brick.ans >nul
fc brick.out brick.ans
del brick.in
del brick.out
del brick.ans
pause
goto quit
:loop
for %%i in (1 2 3 4 5 6 7 8 9 10) do call %0 %%i
:quit
