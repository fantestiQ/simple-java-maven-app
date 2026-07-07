@echo off
echo The following Maven command installs your Maven-built Java application
echo into the local Maven repository, which will ultimately be stored in
echo Jenkins's local Maven repository (and the "maven-repository" Docker data volume).
call mvn jar:jar install:install help:evaluate -Dexpression=project.name

echo Extracting artifactId and version directly from pom.xml
for /f "tokens=2 delims=<>" %%i in ('findstr /r "<artifactId>" pom.xml ^| findstr /v "plugin"') do (
    if not defined NAME set "NAME=%%i"
)
for /f "tokens=2 delims=<>" %%i in ('findstr /r "<version>" pom.xml') do (
    if not defined VERSION set "VERSION=%%i"
)

echo NAME=%NAME%
echo VERSION=%VERSION%
java -jar target\%NAME%-%VERSION%.jar