@echo off
if "%1"=="" goto loop
copy shape%1.in shape.in >nul
echo Problem Test
echo Data %1
time<enter
shape.exe
time<enter
copy shape%1.out shape.ans >nul
fc shape.out shape.ans
del shape.in
del shape.out
del shape.ans
pause
goto quit
:loop
for %%i in (1 2 3 4 5 6 7 8 9 10) do call %0 %%i
:quit
