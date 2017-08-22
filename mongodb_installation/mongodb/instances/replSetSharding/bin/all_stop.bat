call script.conf.bat mongos
%MONGODB_HOME%/mongo.exe localhost:3200/admin --eval "db.shutdownServer()"
%MONGODB_HOME%/mongo.exe localhost:3300/admin --eval "db.shutdownServer()"
%MONGODB_HOME%/mongo.exe localhost:3400/admin --eval "db.shutdownServer()"

%MONGODB_HOME%/mongo.exe localhost:5200/admin --eval "db.shutdownServer()"
%MONGODB_HOME%/mongo.exe localhost:5300/admin --eval "db.shutdownServer()"
%MONGODB_HOME%/mongo.exe localhost:5400/admin --eval "db.shutdownServer()"

%MONGODB_HOME%/mongo.exe localhost:3100/admin --eval "db.shutdownServer()"
%MONGODB_HOME%/mongo.exe localhost:3110/admin --eval "db.shutdownServer()"
%MONGODB_HOME%/mongo.exe localhost:3120/admin --eval "db.shutdownServer()"

%MONGODB_HOME%/mongo.exe localhost:3000/admin --eval "db.shutdownServer()"