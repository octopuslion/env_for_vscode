@echo off

@rem -------------- options ----------------------------------------------------
set vm_ip=*.*.*.*
set vm_entity_name=ubuntu_server_22042
set vm_entity_file=~\%vm_entity_name%\%vm_entity_name%.vmx
set vm_shell_file="~\vmrun"
set vm_login_user=~
set vm_login_ssh_key_file=C:\Users\~\project\env_common\ssh\~_vscode_rsa

@rem -------------- check options ----------------------------------------------
if "%1"=="status" (
    echo.
    echo %cd%^>%vm_shell_file% list
    echo.
    cmd /c %vm_shell_file% list
    echo.
    echo %cd%^>ping -n 2 -w 3 %vm_ip%
    cmd /c ping -n 2 -w 3 %vm_ip%
) else if "%1"=="start" (
    @rem cmd /c "vmrun -T player start %vm_entity%.vmx gui"
    echo.
    echo %cd%^>%vm_shell_file% -T player start %vm_entity_file% nogui
    cmd /c %vm_shell_file% -T player start %vm_entity_file% nogui
    echo.
    echo %cd%^>%vm_shell_file% list
    echo.
    cmd /c %vm_shell_file% list
) else if "%1"=="stop" (
    echo.
    echo %cd%^>%vm_shell_file% stop %vm_entity_file% soft
    cmd /c %vm_shell_file% stop %vm_entity_file% soft
    echo.
    echo %cd%^>%vm_shell_file% list
    echo.
    cmd /c %vm_shell_file% list
) else if "%1"=="login" (
    @rem logout with commond of "logout" in linux shell.
    echo.
    echo %cd%^>ssh -i %vm_login_ssh_key_file% %vm_login_user%@%vm_ip%
    cmd /c ssh -i %vm_login_ssh_key_file% %vm_login_user%@%vm_ip%
) else if "%1"=="upload" (
    echo.
    echo %cd%^>plink -batch -i %vm_login_ssh_key_file%.ppk %vm_login_user%@%vm_ip% rm -rf %3;mkdir -p %3
    cmd /c plink -batch -i %vm_login_ssh_key_file%.ppk %vm_login_user%@%vm_ip%  rm -rf %3;mkdir -p %3
    echo.
    echo %cd%^>scp -i %vm_login_ssh_key_file% -r %2 %vm_login_user%@%vm_ip%:%3
    cmd /c scp -i %vm_login_ssh_key_file% -r %2 %vm_login_user%@%vm_ip%:%3
) else if "%1"=="run-cmd" (
    echo.
    echo %cd%^>plink -batch -i %vm_login_ssh_key_file%.ppk %vm_login_user%@%vm_ip% %2
    cmd /c plink -batch -i %vm_login_ssh_key_file%.ppk %vm_login_user%@%vm_ip% %2
) else (
    echo.
    echo usage: vm [options]
    echo.
    echo  start                                             start the vm entity.
    echo  stop                                              stop the vm entity.
    echo  status                                            check the vm entity status by using ping command.
    echo  login                                             login to vm, type "logout" to lout the vm.
    echo  upload [windir with \*] [linux dir]               upload specified windows files to linux directory.
    echo  run-cmd [linux command, split with semicolons]    run command on linux server.
)