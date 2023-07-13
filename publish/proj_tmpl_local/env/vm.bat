@echo off

@rem -------------- options ----------------------------------------------------
set vm_ip="*.*.*.*"
set vm_entity_name="ubuntu_server_22042"
set vm_entity_file="~\%vm_entity_name:~1,-1%\%vm_entity_name:~1,-1%.vmx"
set vm_shell_file="~\vmrun"
set vm_login_user="~"
set vm_login_ssh_key_file="C:\Users\~\project\env_common\ssh\~_vscode_rsa"

goto:check_options

@rem -------------- status -----------------------------------------------------
:status
echo.
echo %cd%^>%vm_shell_file% list
echo.
cmd /c "%vm_shell_file% list"
echo.
echo %cd%^>ping -n 2 -w 3 %vm_ip:~1,-1%
cmd /c "ping -n 2 -w 3 %vm_ip:~1,-1%"
goto:eof

@rem -------------- start ------------------------------------------------------
:start
@rem cmd /c "vmrun -T player start %vm_entity%.vmx gui"
echo.
echo %cd%^>%vm_shell_file% -T player start %vm_entity_file% nogui
cmd /c "%vm_shell_file% -T player start %vm_entity_file% nogui"
echo.
echo %cd%^>%vm_shell_file% list
echo.
cmd /c "%vm_shell_file% list"
goto:eof

@rem -------------- stop -------------------------------------------------------
:stop
echo.
echo %cd%^>%vm_shell_file% stop %vm_entity_file% soft
cmd /c "%vm_shell_file% stop %vm_entity_file% soft"
echo.
echo %cd%^>%vm_shell_file% list
echo.
cmd /c "%vm_shell_file% list"
goto:eof

@rem -------------- login ------------------------------------------------------
:login
@rem logout with commond of "logout" in linux shell.
echo.
echo %cd%^>ssh -i %vm_login_ssh_key_file% %vm_login_user:~1,-1%@%vm_ip:~1,-1%
cmd /c "ssh -i %vm_login_ssh_key_file% %vm_login_user:~1,-1%@%vm_ip:~1,-1%"
goto:eof

@rem -------------- upload -----------------------------------------------------
:upload
echo.
echo %cd%^>plink -batch -i ^"%vm_login_ssh_key_file:~1,-1%.ppk^" %vm_login_user:~1,-1%@%vm_ip:~1,-1% rm -rf %2;mkdir -p %2
cmd /c "plink -batch -i ^"%vm_login_ssh_key_file:~1,-1%.ppk^" %vm_login_user:~1,-1%@%vm_ip:~1,-1% rm -rf %2;mkdir -p %2"
echo.
echo %cd%^>scp -i %vm_login_ssh_key_file% -r %1 %vm_login_user:~1,-1%@%vm_ip:~1,-1%:%2
cmd /c "scp -i %vm_login_ssh_key_file% -r %1 %vm_login_user:~1,-1%@%vm_ip:~1,-1%:%2"
goto:eof

@rem -------------- download file ----------------------------------------------
:download_file
if exist "%~2\%~3" ( del /a/f/q "%~2\%~3" )
if not exist %2 ( md %2 )
echo.
echo %cd%^>scp -i %vm_login_ssh_key_file% %vm_login_user:~1,-1%@%vm_ip:~1,-1%:^"%~1/%~3^" %2
cmd /c "scp -i %vm_login_ssh_key_file% %vm_login_user:~1,-1%@%vm_ip:~1,-1%:^"%~1/%~3^" %2"
goto:eof

@rem -------------- download dir -----------------------------------------------
:download_dir
if exist "%~2\%~3" (
    del /s /q "%~2\%~3"
    rd  /s /q "%~2\%~3"
)

if not exist "%~2\%~3" ( md "%~2\%~3" )
echo.
echo %cd%^>scp -i %vm_login_ssh_key_file% -r %vm_login_user:~1,-1%@%vm_ip:~1,-1%:^"%~1/%~3/^" %2
cmd /c "scp -i %vm_login_ssh_key_file% -r %vm_login_user:~1,-1%@%vm_ip:~1,-1%:^"%~1/%~3/^" %2"
goto:eof

@rem -------------- run cmd ----------------------------------------------------
:run_cmd
echo.
echo %cd%^>plink -batch -i ^"%vm_login_ssh_key_file:~1,-1%.ppk^" %vm_login_user:~1,-1%@%vm_ip:~1,-1% %1
cmd /c "plink -batch -i ^"%vm_login_ssh_key_file:~1,-1%.ppk^" %vm_login_user:~1,-1%@%vm_ip:~1,-1% %1"
goto:eof

@rem -------------- help -------------------------------------------------------
:help
echo.
echo usage: vm [options]
echo.
echo  start                                             start the vm entity.
echo  stop                                              stop the vm entity.
echo  status                                            check the vm entity status by using ping command.
echo  login                                             login to vm, type "logout" to lout the vm.
echo  upload [windir with \*] [linux dir]               upload specified windows files to linux directory.
echo  run-cmd [linux command, split with semicolons]    run command on linux server.
goto:eof

@rem -------------- check options ----------------------------------------------
:check_options
if "%1"=="status" (
    call:status
) else if "%1"=="start" (
    call:start
) else if "%1"=="stop" (
    call:stop
) else if "%1"=="login" (
    call:login
) else if "%1"=="upload" (
    call:upload %2 %3
) else if "%1"=="download-file" (
    call:download_file %2 %3 %4
) else if "%1"=="download-dir" (
    call:download_dir %2 %3 %4
) else if "%1"=="run-cmd" (
    call:run_cmd %2
) else (
    call:help
)