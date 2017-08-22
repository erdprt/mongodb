SET PATH=C:/WINDOWS/system32;C:/WINDOWS
rem SET JAVA_HOME=D:/java/jdks/32bits/jdk1.7.0_07
SET JAVA_HOME=D:/java/jdks/32bits/jdk1.7.0_07
SET PATH=%PATH%;%JAVA_HOME%/bin
SET CLASSPATH=%JAVA_HOME%/lib/tools.jar

SET JAVA_CLASSPATH=
@echo off
setLocal EnableDelayedExpansion
for %%f in (../lib/*.jar) do set classpath_app=!classpath_app!;../lib/%%f
endLocal & SET JAVA_CLASSPATH=%classpath_app%

SET JAVA_CLASSPATH=../conf;%JAVA_CLASSPATH%
@echo on

echo cp=%JAVA_CLASSPATH%
 
SET JAVA_OPTS=-Xms512m -Xmx1024m -Dcom.sun.management.jmxremote -Dcom.sun.management.jmxremote.ssl=false -Dcom.sun.management.jmxremote.authenticate=false
%JAVA_HOME%/bin/java -classpath %JAVA_CLASSPATH% %JAVA_OPTS% fr.personal.erdprt.integration.starter.ApplicationStarter