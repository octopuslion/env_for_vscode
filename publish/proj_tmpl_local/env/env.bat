@echo off
if not "%1"=="-import" ( goto shell_end )
if not "%2"=="-silence" ( echo import environment settings to vscode cmd. && echo. )

@rem -------------- options ----------------------------------------------------
set proj_dir=C:\Users\~\project\proj_tmpl_local
set git_dir=C:\Users\~\project\env_common\PortableGit
set git_work_dir=C:\Users\~\project\.git
set jdk_dir=%proj_dir%\env\jdk
set node_dir=%proj_dir%\env\node
set python_dir=%proj_dir%\env\python
set putty_dir=%proj_dir%\env\putty
set depl_dir=%proj_dir%\depl

@rem -------------- set environment path ---------------------------------------
@rem git
if exist "%git_dir%" (
    set "path=%git_dir%\bin;%path%"
    if exist %git_work_dir% ( set "GIT_DIR=%git_work_dir%" )
    if not "%2"=="-silence" ( echo ... set git path success. )
) else if not "%2"=="-silence" ( echo ... set git path failure. )

@rem jdk
if exist "%jdk_dir%" (
    set "path=%jdk_dir%\bin;%path%"
    set "JAVA_HOME=%jdk_dir%"
    if not "%2"=="-silence" ( echo ... set jdk path success. )
) else if not "%2"=="-silence" ( echo ... set jdk path failure. )

@rem node
if exist "%node_dir%" (
    set "path=%node_dir%;%path%"
    if not "%2"=="-silence" ( echo ... set node path success. )
) else if not "%2"=="-silence" ( echo ... set node path failure. )

@rem python
if exist "%python_dir%" (
    set "path=%python_dir%;%path%"
    if exist "%python_dir%\Scripts" ( set "path=%python_dir%;%python_dir%\Scripts;%path%" )
    if not "%2"=="-silence" ( echo ... set python path success. )
) else if not "%2"=="-silence" ( echo ... set python path failure. )

@rem putty
if exist "%putty_dir%" (
    set "path=%putty_dir%;%path%"
    if not "%2"=="-silence" ( echo ... set putty path success. )
) else if not "%2"=="-silence" ( echo ... set putty path failure. )

@rem depl
if exist "%depl_dir%" (
    set "path=%depl_dir%;%path%"
    if not "%2"=="-silence" ( echo ... set depl path success. )
) else if not "%2"=="-silence" ( echo ... set depl path failure. )

@rem current env
set "path=%~dp0;%path%"
if not "%2"=="-silence" ( echo ... set current env path success. )
echo.
:shell_end