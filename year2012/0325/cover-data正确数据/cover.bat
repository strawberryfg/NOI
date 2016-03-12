@echo off
if "%1"=="" goto loop
copy cover%1.in cover.in >nul
echo Problem Test
echo Data %1
time<enter
cover.exe
time<enter
fc cover.out cover%1.out
del cover.in
del cover.out
pause
goto end
:loop
for %%i in (1 2 3 4 5 6 7 8 9 10 11) do call %0 %%i
:end
