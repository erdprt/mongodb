call script.conf.bat mongos
%MONGODB_HOME%/mongo.exe localhost:3000/admin --eval "db.printShardingStatus();" > %MONGODB_STATS%\status_%F_DATETIME%.txt 2>&1