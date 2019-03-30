@echo off
setlocal enabledelayedexpansion
set BASH=%LocalAppData%\Atlassian\SourceTree\git_local\bin\bash.exe

SET MC=%MALLOC_CONF%
REM unit tests
for /f %%a in (unittests.txt) do (
set r=%%a
call :getpath !r!
set units=!r! !units!
)
REM echo !units!
%BASH% test.sh !units!

if "%ERRORLEVEL%" neq "0" exit /b 1

REM check_integration_prof
for /f %%a in (integrationtests.txt) do (
set r=%%a
call :getpath !r!
set integs=!r! !integs!
)
echo !integs!
SET MALLOC_CONF="prof:true" 
%BASH% test.sh !integs!

if "%ERRORLEVEL%" neq "0" exit /b 1

SET MALLOC_CONF="prof:true,prof_active:false" 
%BASH% test.sh !integs!

if "%ERRORLEVEL%" neq "0" exit /b 1

REM check_integration_decay
SET MALLOC_CONF="dirty_decay_ms:-1,muzzy_decay_ms:-1"
%BASH% test.sh !integs!

if "%ERRORLEVEL%" neq "0" exit /b 1

SET MALLOC_CONF="dirty_decay_ms:0,muzzy_decay_ms:0"
%BASH% test.sh !integs!

if "%ERRORLEVEL%" neq "0" exit /b 1

REM check_integration
SET MALLOC_CONF=%MC%
%BASH% test.sh !integs!


if "%ERRORLEVEL%" neq "0" exit /b 1

REM check_stress
for /f %%a in (stresstests.txt) do (
set r=%%a
call :getpath !r!
set stresses=!r! !stresses!
)
%BASH% test.sh !stresses!

if "%ERRORLEVEL%" neq "0" exit /b 1

exit /b
SETLOCAL
:getpath !full!
set fullpath=%~1%
set r=!fullpath:*test\=! 
set r=!r:.cpp=!
set r=!r:.c=!
set %~1=!r!
