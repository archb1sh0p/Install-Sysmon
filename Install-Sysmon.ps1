<#
.SYNOPSIS
Install-Sysmon downloads SysInternals Suite and installs Sysmon
with a configuration file.
.DESCRIPTION
PowerShell script or module to install Sysmon with configuration 
.PARAMETER path
The path to the working directory.  Default is user Documents.
.EXAMPLE
Install-Sysmon -path C:\Users\example\Desktop
#>

[CmdletBinding()]

#Establish parameters for path
param (
    [string]$path=[Environment]::GetFolderPath("Desktop")   
)

#Test path and create it if required

If(!(test-path $path))
{
	Write-Information -MessageData "Path does not exist.  Creating Path..." -InformationAction Continue;
	New-Item -ItemType Directory -Force -Path $path | Out-Null;
	Write-Information -MessageData "...Complete" -InformationAction Continue
}

Set-Location $path

Invoke-WebRequest -Uri https://download.sysinternals.com/files/SysinternalsSuite-Nano.zip -Outfile SysinternalsSuite-Nano.zip

Expand-Archive SysinternalsSuite-Nano.zip

Set-Location $path\SysinternalsSuite-Nano

Invoke-WebRequest -Uri https://raw.githubusercontent.com/aluminoobie/sysmon-config/master/sysmonconfig-export.xml -Outfile sysmonconfig-export.xml

.\sysmon64.exe -accepteula -i sysmonconfig-export.xml

Write-Host "Sysmon Installed!"