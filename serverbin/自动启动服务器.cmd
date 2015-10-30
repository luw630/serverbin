@echo off

taskkill /f /im TestPolicySocket.exe
taskkill /f /im zoneserver.exe
taskkill /f /im LoginServer.exe
taskkill /f /im AccountServer.exe
taskkill /f /im CenterServer.exe
taskkill /f /im DBServer.exe

ping /n 10 127.1>nul


cd AccountServer
start "" AccountServer.exe
cd ..
ping /n 5 127.1>nul



cd DBServer
start "" CenterServer.exe
cd ..
ping /n 5 127.1>nul



cd DBServer
start "" DBServer.exe
cd ..
ping /n 5 127.1>nul




cd LoginServer
start "" LoginServer.exe
cd ..
ping /n 5 127.1>nul


cd ZoneServer
start "" zoneserver.exe
cd ..



