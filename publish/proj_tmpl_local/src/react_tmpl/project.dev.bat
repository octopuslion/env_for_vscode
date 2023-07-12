@echo off

cd /d %~dp0
set dir=%cd%

cd ../../env/node
path=%path%;%cd%

cd /d %~dp0
start "Webpack for Dev Server" npm run dev