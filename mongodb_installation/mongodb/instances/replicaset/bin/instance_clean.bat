call script.conf.bat %*

cd %MONGODB_INSTANCE_HOME%/datas
RMDIR /S /Q .
cd %MONGODB_INSTANCE_HOME%/logs
RMDIR /S /Q .
cd %MONGODB_COMMAND%