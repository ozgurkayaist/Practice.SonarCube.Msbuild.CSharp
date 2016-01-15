@echo off
::=======SET GLOBAL VARIABLES=================
SET msbuildfullpath=C:\Program Files (x86)\MSBuild\14.0\Bin
SET homepath=C:\sonar\scripts

::========YOUR PROJECT 1================
	SET workingpath=C:\Program Files (x86)\Jenkins\workspace\YOURPATHTO_MSBUILD_SOLUTION1
	SET projectname=MYSOLUTION1
	cd %workingpath%
	MSBuild.SonarQube.Runner.exe begin /key:"%projectname%" /name:"%projectname%" /version:%1
	"%msbuildfullpath%\MSBuild.exe" /t:Rebuild
	MSBuild.SonarQube.Runner.exe end
	cd %homepath%

::========YOUR PROJECT 2================
	SET workingpath=C:\Program Files (x86)\Jenkins\workspace\YOURPATHTO_MSBUILD_SOLUTION2
	SET projectname=MYSOLUTION2
	cd %workingpath%
	MSBuild.SonarQube.Runner.exe begin /key:"%projectname%" /name:"%projectname%" /version:%1
	"%msbuildfullpath%\MSBuild.exe" /t:Rebuild "%workingpath%\myproject.sln"
	MSBuild.SonarQube.Runner.exe end
	cd %homepath%