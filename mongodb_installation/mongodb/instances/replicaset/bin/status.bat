call script.conf.bat node1
%MONGODB_HOME%/mongo.exe localhost:3200/admin --eval "rs.status()" > %MONGODB_STATS%\status_%F_DATETIME%.txt 2>&1