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