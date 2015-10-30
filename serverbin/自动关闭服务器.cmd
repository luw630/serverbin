@echo off

taskkill /f /im TestPolicySocket.exe
taskkill /f /im zoneserver.exe
taskkill /f /im LoginServer.exe
taskkill /f /im AccountServer.exe
taskkill /f /im CenterServer.exe
taskkill /f /im DBServer.exe



