start "shard11" cmd.exe /C call shard11_start.bat
start "shard12" cmd.exe /C call shard12_start.bat
start "shard13" cmd.exe /C call shard13_start.bat
start "configserver" cmd.exe /C call configserver_start.bat
start "mongos" cmd.exe /C call mongos_start.bat  

ping 0.0.0.0 -n 10 > nul
call config_replSet_configServer.bat
ping 0.0.0.0 -n 10 > nul
call config_sharding.bat