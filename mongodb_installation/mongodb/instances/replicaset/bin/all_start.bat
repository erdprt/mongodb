start "node0_arbitrer" cmd.exe /C call node0_arbitrer_start.bat
start "node1" cmd.exe /C call node1_start.bat
start "node2" cmd.exe /C call node2_start.bat
start "node3" cmd.exe /C call node3_start.bat
start "node4" cmd.exe /C call node4_start.bat

ping 0.0.0.0 -n 10 > nul
start "config_install" cmd.exe /C call config_install.bat