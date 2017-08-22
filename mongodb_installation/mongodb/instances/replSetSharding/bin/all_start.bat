start "sharda1" cmd.exe /C call sharda1_start.bat
start "sharda2" cmd.exe /C call sharda2_start.bat
REM start "sharda3" cmd.exe /C call sharda3_start.bat

ping 0.0.0.0 -n 10 -w 5000 > nul
call config_replSet_sharda.bat
ping 0.0.0.0 -n 10 -w 5000 > nul

start "shardb1" cmd.exe /C call shardb1_start.bat
start "shardb2" cmd.exe /C call shardb2_start.bat
REM start "shardb3" cmd.exe /C call shardb3_start.bat

ping 0.0.0.0 -n 10 -w 5000 > nul
call config_replSet_shardb.bat
ping 0.0.0.0 -n 10 -w 5000 > nul

start "cfgserver1" cmd.exe /C call cfgserver1_start.bat
start "cfgserver2" cmd.exe /C call cfgserver2_start.bat
start "cfgserver3" cmd.exe /C call cfgserver3_start.bat

ping 0.0.0.0 -n 10 -w 5000 > nul
call config_replSet_cfgServer.bat
ping 0.0.0.0 -n 10 -w 5000 > nul

start "mongos" cmd.exe /C call mongos_start.bat

ping 0.0.0.0 -n 2 -w 5000 > nul
call config_sharding.bat
