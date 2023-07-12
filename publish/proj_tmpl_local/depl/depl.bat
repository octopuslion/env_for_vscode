@echo off

@rem -------------- options ----------------------------------------------------
set proj_dir=C:\Users\~\project\proj_tmpl_local
set proj_out_dir=%proj_dir%\depl\build

@rem java
set java_out_dir=%proj_out_dir%
set proj_java_dir=%proj_dir%\src\java_tmpl
set proj_maven_pom_name=pom-prod.xml
set proj_java_out_name=java_tmpl-0.1.jar

@rem react
set react_out_dir=%proj_out_dir%\dist
set proj_react_dir=%proj_dir%\src\react_tmpl
set proj_npm_script_name=prod

@rem server
set server_proj_dir=/home/~/project/proj_tmpl_server
set server_output_dir=%server_proj_dir%/prod/depl/proj/build
set server_rebuild_shell_file=%server_proj_dir%/prod/depl/proj/launch.sh

@rem -------------- check options ----------------------------------------------
if "%1"=="local" (
    if "%2"=="all" (
        goto local_all_start
    ) else if "%2"=="java" (
        goto local_java_start
    ) else if "%2"=="react" (
        goto local_react_start
    ) else if "%2"=="run" (
        goto local_run
    ) else (
        goto help
    )
) else if "%1"=="server" (
    if "%2"=="full" (
        goto local_all_start
    ) else if "%2"=="upload" (
        goto server_upload
    ) else if "%2"=="run" (
        goto server_run
    ) else (
        goto help
    )
) else (
    goto help
)

@rem -------------- build all packages -----------------------------------------
:local_all_start
set current_dir_all=%cd%
cd /d %~dp0
if exist %proj_out_dir% (
    del /s /q %proj_out_dir%
    rd  /s /q %proj_out_dir%
)

@rem -------------- build java package -----------------------------------------
:local_java_start
if not exist %proj_java_dir% ( goto local_java_end )
set current_dir=%cd%

@rem build
cd  %proj_java_dir%
cmd /c mvn package -f %proj_maven_pom_name%

@rem copy
if not exist %java_out_dir% ( md %java_out_dir% )
copy /Y target\*.jar %java_out_dir%

cd %current_dir%
:local_java_end
if "%2"=="java" ( goto local_all_end )

@rem -------------- build react package ----------------------------------------
:local_react_start
if not exist %proj_react_dir% ( goto local_react_end )
set current_dir=%cd%

@rem build
cd  %proj_react_dir%
cmd /c npm run %proj_npm_script_name%

@rem copy
if not exist %react_out_dir% ( md %react_out_dir% )
xcopy /S /Y dist %react_out_dir%
cd %react_out_dir%
del /s /q .\*.license.txt

cd %current_dir%
:local_react_end
if "%2"=="react" ( goto local_all_end )

@rem -------------- build packages end -----------------------------------------
:local_all_end
if "%1"=="local" ( cd %current_dir_all% )
if "%1"=="server" ( cd %current_dir_all% )
if not "%1"=="server" ( goto shell_end )
if not "%2"=="full" ( goto shell_end )

@rem -------------- upload packages, rebuild and restart on vm server ----------
:server_upload

cmd /c vm upload %proj_out_dir%\* %server_output_dir%
if not "%2"=="full" ( goto shell_end )
cmd /c vm run-cmd "%server_rebuild_shell_file% -rebuild-image"
goto shell_end

@rem -------------- run local package ------------------------------------------
:local_run
set current_dir=%cd%

cd %proj_out_dir%
cmd /c java -jar %proj_java_out_name%

cd %current_dir%
goto shell_end

@rem -------------- run server package -----------------------------------------
:server_run
cmd /c vm run-cmd %server_rebuild_shell_file%
goto shell_end

@rem -------------- show help --------------------------------------------------
goto shell_end
:help
echo.
echo usage: depl [options]
echo.
echo  local all          clean build directory then rebuild all packages.
echo  local java         only rebuild java package.
echo  local react        only rebuild react package.
echo  local run          run packages.
echo  server full        rebuild all packages locally, then upload, make and restart docker container.
echo  server upload      only upload all packages to server.
echo  server run         run docker image on server.
echo.

:shell_end