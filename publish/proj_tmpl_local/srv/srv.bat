@echo off

@rem -------------- options ----------------------------------------------------
set local_dir="C:\Users\~\project\proj_tmpl_local\srv"
set server_dir="/home/~/project/proj_tmpl_server"

set file_01= "%server_dir:~1,-1%/prod/depl/proj" "%local_dir:~1,-1%\depl" "Dockerfile"
set file_02= "%server_dir:~1,-1%/prod/depl/proj" "%local_dir:~1,-1%\depl" "launch.sh"
set dir_01= "%server_dir:~1,-1%/dev" "%local_dir:~1,-1%" "src"

@rem -------------- download server files --------------------------------------
if not "%1"=="download" ( goto:shell_end )
cmd /c "vm download-file %file_01%"
cmd /c "vm download-file %file_02%"
cmd /c "vm download-dir %dir_01%"

:shell_end