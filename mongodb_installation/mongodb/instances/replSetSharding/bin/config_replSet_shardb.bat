call script.conf.bat shardb1
%MONGODB_HOME%/mongo.exe localhost:5200/admin %MONGODB_INSTANCE_HOME%/scripts/config_replicaset.js
