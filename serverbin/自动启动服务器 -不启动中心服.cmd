@echo off

taskkill /f /im DBServer.exe
cd DBServer
start "" DBServer.exe
cd ..
ping /n 5 127.1>nul

taskkill /f /im AccountServer.exe
cd AccountServer
start "" AccountServer.exe
cd ..
ping /n 5 127.1>nul

taskkill /f /im LoginServer.exe
cd LoginServer
start "" LoginServer.exe
cd ..
ping /n 5 127.1>nul

taskkill /f /im zoneserver.exe
cd ZoneServer
start "" zoneserver.exe
cd ..



