# Convert Time PowerShell Module 
[![PSGallery Version](https://img.shields.io/powershellgallery/v/ConvertTime.svg?style=flat&logo=powershell&label=PSGallery%20Version)](https://www.powershellgallery.com/packages/ConvertTime) [![PSGallery Downloads](https://img.shields.io/powershellgallery/dt/ConvertTime.svg?style=flat&logo=powershell&label=PSGallery%20Downloads)](https://www.powershellgallery.com/packages/ConvertTime)

Convert Unix/Windows timestamps to a DateTime PowerShell Object. 

Get Unix/Windows time from a PowerShell DateTime Object.

Four cmdlets (two with optional switches to return conversion result as UTC time). 
* Convert-UnixTime
* Convert-WindowsTime
* Get-UnixTime
* Get-WindowsTime

[Available in the PowerShell Gallery](https://www.powershellgallery.com/packages/ConvertTime)

[Associated Blogpost](https://blog.darrenjrobinson.com/convert-windows-and-unix-epoch-times-with-powershell/)

## Install

Install direct from the PowerShell Gallery (Powershell 5.x and above)

```powershell
install-module -name ConvertTime
```

# Convert-UnixTime

## DESCRIPTION

Convert from Unix Epoch time to a PowerShell DateTime Object relative to local time based of system time zone.

(optional) Return DateTime as Coordinated Universal Time

## PARAMETER unixDate

The unix epoch time to convert

## PARAMETER UTC

(optional) The unix epoch time to converted as as Coordinated Universal Time

## INPUTS

Token from Pipeline.

## OUTPUTS

PowerShell Object

## SYNTAX 

Convert-UnixTime 1592001868

Convert-UnixTime 1592001868 -UTC

## EXAMPLE

```powershell
PS C:\Users\Darren Robinson> Convert-UnixTime 1592001868 

Saturday, 13 June 2020 8:44:28 AM
```

## EXAMPLE

```powershell
PS C:\Users\Darren Robinson> Convert-UnixTime 1592001868 -UTC

Friday, 12 June 2020 10:44:28 PM
```

# Convert-WindowsTime

## DESCRIPTION

Convert from Windows Epoch time to a PowerShell DateTime Object relative to local time based of system time zone.

(optional) Return DateTime as Coordinated Universal Time

## PARAMETER winDate

The windows epoch time to convert

## PARAMETER UTC

(optional) The unix epoch time to converted as as Coordinated Universal Time

## INPUTS

Token from Pipeline.

## OUTPUTS

PowerShell Object

## SYNTAX 

Convert-WindowsTime 132947402891099830

Convert-WindowsTime 132947402891099830 -UTC


## EXAMPLE

```powershell
PS C:\Users\Darren Robinson> Convert-WindowsTime 132947402891099830

Monday, 18 April 2022 5:24:49 PM
```

## EXAMPLE

```powershell
PS C:\Users\Darren Robinson> Convert-WindowsTime 132947402891099830 -UTC

Monday, 18 April 2022 7:24:49 AM
```

# Get-UnixTime

## DESCRIPTION

Convert from a PowerShell DateTime Object to Unix timestamp

## PARAMETER datetime

(optional) If no input PowerShell DateTime Object provided the current datetime is converted

## INPUTS

Token from Pipeline.

## OUTPUTS

Unix datetime stamp

## SYNTAX 

Get-UnixTime

## EXAMPLE

```powershell
PS C:\Users\Darren Robinson> Get-UnixTime
1665374881
```

## EXAMPLE

```powershell
PS C:\Users\Darren Robinson> Get-Date | Get-UnixTime
1665374931
```

## EXAMPLE

```powershell
PS C:\Users\Darren Robinson> Get-UnixTime -datetime 'Sunday, 9 October 2022 2:47:48 PM'
1665287268
```

# Get-WindowsTime

## DESCRIPTION

Convert from a PowerShell DateTime Object to Windows timestamp

## PARAMETER datetime

(optional) If no input PowerShell DateTime Object provided the current datetime is converted

## INPUTS

Token from Pipeline.

## OUTPUTS

Windows datetime stamp

## SYNTAX 

Get-WindowsTime

## EXAMPLE

```powershell
PS C:\Users\Darren Robinson> Get-WindowsTime 
133098487061671481
```

## EXAMPLE

```powershell
PS C:\Users\Darren Robinson> Get-Date | Get-WindowsTime
133098487250480096
```

## EXAMPLE

```powershell
PS C:\Users\Darren Robinson> Get-WindowsTime -datetime 'Sunday, 9 October 2022 2:47:48 PM'
133097608680000000
```

## LINKS

* [Darren Robinson's blog](https://blog.darrenjrobinson.com)
* [Associated ConvertTime Blogpost](https://blog.darrenjrobinson.com/convert-windows-and-unix-epoch-times-with-powershell/)
* [Follow Darren on Twitter](https://twitter.com/darrenjrobinson)![](http://twitter.com/favicon.ico)
