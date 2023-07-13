@echo off

@rem -------------- options ----------------------------------------------------
set proj_dir="C:\Users\~\project\proj_tmpl_local"
set proj_out_dir="%proj_dir:~1,-1%\depl\build"

@rem java
set java_out_dir="%proj_out_dir:~1,-1%"
set proj_java_dir="%proj_dir:~1,-1%\src\java_tmpl"
set proj_maven_pom_name="pom-prod.xml"
set proj_java_out_name="java_tmpl-0.1.jar"

@rem react
set react_out_dir="%proj_out_dir:~1,-1%\dist"
set proj_react_dir="%proj_dir:~1,-1%\src\react_tmpl"
set proj_npm_script_name="prod"

@rem server
set server_proj_dir="/home/~/project/proj_tmpl_server"
set server_output_dir="%server_proj_dir:~1,-1%/prod/depl/proj/build"
set server_rebuild_shell_file="%server_proj_dir:~1,-1%/prod/depl/proj/launch.sh"

goto:check_options

@REM @rem -------------- run server package ------------------------------------
:server_run
cmd /c "vm run-cmd %server_rebuild_shell_file%"
goto:eof

@rem -------------- build java package -----------------------------------------
:local_build_java
if not exist %proj_java_dir% ( goto:eof )
set current_dir=%cd%
cd /d %~dp0

@rem build
cd  %proj_java_dir%
cmd /c "mvn package -f %proj_maven_pom_name%"

@rem copy
if not exist %java_out_dir% ( md %java_out_dir% )
copy /Y "target\*.jar" %java_out_dir%

cd %current_dir%
goto:eof

@rem -------------- build react package ----------------------------------------
:local_build_react
if not exist %proj_react_dir% ( goto:eof )
set current_dir=%cd%
cd /d %~dp0

@rem build
cd %proj_react_dir%
cmd /c "npm run %proj_npm_script_name%"

@rem copy
if not exist %react_out_dir% ( md %react_out_dir% )
xcopy /S /Y "dist" %react_out_dir%
cd %react_out_dir%
del /s /q ".\*.license.txt"

cd %current_dir%
goto:eof

@rem -------------- build all packages -----------------------------------------
:local_build_all
set current_dir_all=%cd%
cd /d %~dp0
if exist %proj_out_dir% (
    del /s /q %proj_out_dir%
    rd  /s /q %proj_out_dir%
)

call:local_build_java
call:local_build_react
cd %current_dir_all%
goto:eof

@rem -------------- rebuild on server ------------------------------------------
:server_rebuild
cmd /c "vm upload ^"%proj_out_dir:~1,-1%\*^" %server_output_dir%"
cmd /c "vm run-cmd ^"%server_rebuild_shell_file% -rebuild-image^""
goto:eof

@rem -------------- full steps -------------------------------------------------
:full
call:local_build_all
call:server_rebuild
goto:eof

@REM @rem -------------- show help ---------------------------------------------
:help
echo.
echo usage: depl [options]
echo.
echo  full               clean build directory, rebuild all packages, deploy on docker, then restart docker container.
echo  local java         only rebuild java package.
echo  local react        only rebuild react package.
echo  server rebuild     upload packages, rebuild and restart docker container.
echo  server run         run docker container on server.
goto:eof

@rem -------------- check options ----------------------------------------------
:check_options
if "%1"=="local" (
    if "%2"=="all" (
        call:local_build_all
    ) else if "%2"=="java" (
        call:local_build_java
    ) else if "%2"=="react" (
        call:local_build_react
    ) else (
        call:help
    )
) else if "%1"=="server" (
    if "%2"=="rebuild" (
        goto:server_rebuild
    ) else if "%2"=="run" (
        call:server_run
    ) else (
        call:help
    )
) else if "%1"=="full" (
    call:full
) else (
    call:help
)