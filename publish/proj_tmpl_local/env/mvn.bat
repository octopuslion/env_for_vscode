@echo off

@rem -------------- options ----------------------------------------------------
set maven_shell_file=C:\Users\~\project\env_common\maven\bin\mvn
set maven_setting_file=C:\Users\~\project\proj_tmpl_local\env\maven\settings.xml

@rem -------------- run maven with necessary options ---------------------------
@rem add -s arg if mvn doesn't contain args of "-s" and "--settings", this is to prevent to use global maven setting.
set cmd_options=%*
if "%cmd_options%"=="" ( goto fill_options )

set exists_command=false
echo %cmd_options% | find "-s" >nul && set exists_command=true
if "%exists_command%"=="true" ( goto check_options_end )

set exists_command=false
echo %cmd_options% | find "--settings" >nul && set exists_command=true
if "%exists_command%"=="true" ( goto check_options_end )

:fill_options
set cmd_options=%cmd_options% -s %maven_setting_file%
:check_options_end

echo.
echo %cd%^>%maven_shell_file% %cmd_options%
echo.
cmd /c %maven_shell_file% %cmd_options%