@echo off

@rem -------------- options ----------------------------------------------------
set maven_shell_file="C:\Users\~\project\env_common\maven\bin\mvn"
set maven_setting_file="C:\Users\~\project\proj_tmpl_local\env\maven\settings.xml"

goto:main

@rem -------------- recreate commond options -----------------------------------
:recreate
@rem add -s arg if mvn doesn't contain args of "-s" and "--settings", this is to prevent to use global maven setting.
if "%cmd_options%"=="" ( goto:eof )

set exists_command=false
echo %cmd_options% | find "-s" >nul && set exists_command=true
if "%exists_command%"=="true" ( goto:eof )

set exists_command=false
echo %cmd_options% | find "--settings" >nul && set exists_command=true
if "%exists_command%"=="true" ( goto:eof )

set cmd_options=%cmd_options% -s %maven_setting_file%
goto:eof

@rem -------------- run maven with necessary options ---------------------------
:main
set cmd_options=%*
call:recreate

echo.
echo %cd%^>%maven_shell_file:~1,-1% %cmd_options%
echo.
cmd /c "%maven_shell_file:~1,-1% %cmd_options%"