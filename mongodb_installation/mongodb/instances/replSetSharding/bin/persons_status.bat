call script.conf.bat mongos
%MONGODB_HOME%/mongo.exe localhost:3000/db_sharding_test --eval "db.persons.stats();" > %MONGODB_STATS%\person_status_%F_DATETIME%.txt 2>&1