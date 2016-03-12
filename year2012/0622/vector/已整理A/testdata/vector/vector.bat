@echo off
if "%1"=="" goto loop
copy vector%1.in vector.in >nul
copy vector%1.out vector.out >nul
copy vector%1.ans vector.ans >nul
echo Data %1
checkv.exe
echo ------------------
type check.txt
echo ------------------
del check.txt
del vector.ans
del vector.in
del vector.out
pause
goto end
:loop
for %%i in (1 2 3 4 5 6 7 8 9 10) do call %0 %%i
:end
