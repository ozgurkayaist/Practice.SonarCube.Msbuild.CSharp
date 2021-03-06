
![enter image description here](https://raw.githubusercontent.com/ozgurkayaist/Practice.SonarCube.Msbuild.CSharp/master/images/banner.png)
Best Practice with SonarCube for your Visual Studio Projects
===================

## Prerequisites

A Java runtime is required for SonarQube to run. Supported JVMs:

Java (Oracle JRE 7 or greater or OpenJDK 7 or greater). (Java SE Runtime Environment)

Microsoft SQL Server 2008 or higher required. It must be set to UTF-8, language set to English, and collation to CS (case sensitive) and AS (accent sensitive).


Download and install latest "[Microsoft Build Tools 2015](https://www.microsoft.com/en-us/download/details.aspx?id=48159)". There is no need to install full Visual Studio 2015 version.


Download latest or LTS "[SonarQube Server](http://www.sonarqube.org/downloads/)" package
Download latest or LTS "[Sonar Csharp plugin](http://docs.sonarqube.org/display/PLUG/C#+Plugin)" package
Download latest or LTS "[MSBuild SonarQube Runner](http://docs.sonarqube.org/display/SONAR/Analyzing+with+SonarQube+Scanner+for+MSBuild)" package


Download the "[SonarQube Setup Guide For .NET Users](http://redirect.sonarsource.com/doc/sq-setup-guide-for-dotnet-users.html)" pdf file for advanced help

All Your downloaded code repository like (TFS build server/ Jenkins workspace/..) and "SonarQube" including "Sonar Runner" hosted on a single computer.

## Install Sonar Server

Copy **sonarqube-4.5.6.zip** to your downloaded code repository 

Extract zip files to "C:\sonar\sonarqube-4.5.6".

*Note: If you are not using a windows server OS, Right-click on sonarqube-4.5.6.zip, select Properties and then click on the Unblock button*

## Configure MSSQL Server
Create a database named with "**sonar**"

Create a sonar user and give db_owner permissions to it. (YOUR_SONAR_USER, YOUR_SONAR_PASS)


## Configure Sonar Server

Open the **soner.properties** file. "C:\sonar\sonarqube-4.5.6\conf\sonar.properties"
Unblock the following lines (Remove #) Search with variable names. Variable values are given at the following.

    sonar.jdbc.username=YOUR_SONAR_USER
    sonar.jdbc.password=YOUR_SONAR_PASS
    sonar.jdbc.url=jdbc:jtds:sqlserver://127.0.0.1/sonar;SelectMethod=Cursor
    
    sonar.web.port=9080
    sonar.search.port=9081

## Install SonarQube C# plugin

Copy the "**sonar-csharp-plugin-4.4.jar**" file to under this folder location"C:\sonar\sonarqube-4.5.6\extensions\plugins\"

*Note: If necessary Unblock file.(not required for windows server OS)*

## Run Sonar Server
Open Command Prompt (cmd) with Admin priviliges and change directory ( cd ) to the following folder.
"C:\sonar\sonarqube-4.5.6\bin\windows-x86-64"

Run "InstallNTService.bat" command. It will install it as windows service.

Run "services.msc" windows command. It will open the windows services list.

Find a service which has named like "SonarQube". Run with an local or domain account which is in local administrators group.

Right click and click start.

Open "C:\sonar\sonarqube-4.5.6\logs" and be sure there is no ERRORs like SQL connection problem in this files.

## Test Sonar Server

Open a browser which has enabled javascript execution.

Navigate to **http://localhost:9080**

If this is the first time you are using SonarQube, the default admin credentialsare:
- Username: admin
- Password: admin

Verify that the C# X.Y plugin has been correctly deployed, Navigate to Sonar Settings >System > Update Center.

## Install and Configure MSBuild SonarQube Runner

Extract the zipped files to this location "C:\sonar\MSBuild.SonarQube.Runner-1.1"

Open with notepad for editing "**SonarQube.Analysis.xml**" file.

Unblock the following lines. And change the values like your "**conf/sonar.properties**" file.

      <Property Name="sonar.host.url">http://localhost:9080</Property>
      <Property Name="sonar.login">YOUR_SONAR_USER</Property>
      <Property Name="sonar.password">YOUR_SONAR_PASS</Property>
      <Property Name="sonar.jdbc.url">jdbc:jtds:sqlserver://localhost/sonar;SelectMethod=Cursor</Property>
      <Property Name="sonar.jdbc.username">YOUR_SONAR_USER</Property>
      <Property Name="sonar.jdbc.password">YOUR_SONAR_PASS</Property>


Run "**sysdm.cpl**" command @Windows Run. Click Advanced->Environment variables
Find a system variabled named "**Path**"  CLick EDIT.
Add this string at the end of the line "**;C:\sonar\MSBuild.SonarQube.Runner-1.1**"


## Create a windows batch file

Create a bat file like "Sonar.Develop.Analyser.bat"

Copy the following lines in it. Change the directory which has the .sln file in it.

    ::======THIS IS MY FIRST CODE ANALYSIS==================
    cd C:\Program Files (x86)\Jenkins\workspace\YOURPATHTO_MSBUILD_SOLUTION1
    MSBuild.SonarQube.Runner.exe begin /key:"MYSOLUTION1" /name:"MYSOLUTION1" /version:%1
    "C:\Program Files (x86)\MSBuild\14.0\Bin\MSBuild.exe" /t:Rebuild
    MSBuild.SonarQube.Runner.exe end
    ::===========SECOND PROJECT=============
    cd C:\Program Files (x86)\Jenkins\workspace\YOURPATHTO_MSBUILD_SOLUTION2
    MSBuild.SonarQube.Runner.exe begin /key:"MYSOLUTION2" /name:"MYSOLUTION2" /version:%1
    "C:\Program Files (x86)\MSBuild\14.0\Bin\MSBuild.exe" /t:Rebuild "C:\Program Files (x86)\Jenkins\workspace\YOURPATHTO_MSBUILD_SOLUTION2\SomePath\MYPROJECT.sln"
    MSBuild.SonarQube.Runner.exe end
    ::========================
    
## Schedule Batch file with Jenkins

Copy the batch file to this location "C:\sonar\Scripts\Sonar.Develop.Analyser.bat"

Create a freestyle jenkins job. ([Version Number Plugin](https://wiki.jenkins-ci.org/display/JENKINS/Version+Number+Plugin) must be installed before)

Check Create a formatted version number and create an env. variable name like the screenshot.

Check Build periodically and set it with cron string. 
Example:

    H 4 * * *  

This value will be execute the job, @04:00 AM every night.

Add Execute Windows batch command build task. The following commands will send the batch file the version number. Which has named "%1" @batch script.

    cd C:\sonar\scripts
    call "C:\sonar\scripts\Sonar.Develop.Analyser.bat" %VERSION%

## Advanced settings
[C# Unit Test Execution Results Import](http://docs.sonarqube.org/display/PLUG/C#+Unit+Test+Execution+Results+Import)

[C# Code Coverage Results Import](http://docs.sonarqube.org/display/PLUG/C#+Code+Coverage+Results+Import)



















> Written with [StackEdit](https://stackedit.io/).