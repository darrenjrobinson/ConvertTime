$exportcmdlets = @()

function Convert-UnixTime {
    <#
.SYNOPSIS
Convert UnixTime to PowerShell DateTime 

.DESCRIPTION
Convert UnixTime to PowerShell DateTime 

.PARAMETER unixDate
(required) The unix time integer

.PARAMETER UTC
(optional) Return datetime relative to localtime based off system timezone

.EXAMPLE
Convert-UnixTime 1592001868

.EXAMPLE
Convert-UnixTime 1592001868 -UTC

.LINK
http://darrenjrobinson.com/convert-windows-and-unix-epoch-times-with-powershell

#>
    [cmdletbinding()]
    Param(
        [Parameter(Mandatory = $true, ValueFromPipeline = $true)][int32]$unixDate,
        [Parameter(Mandatory = $false, ValueFromPipeline = $true)]
        [switch]$UTC 
    )
    Try {
        $unixEpoch = (Get-Date -Year 1970 -Month 1 -Day 1 -hour 0 -Minute 0 -Second 0 -Millisecond 0)  
        if ($UTC) {
            $dateTime = $unixEpoch.AddSeconds($unixDate)
        }
        else {   
            $timeZone = Get-TimeZone
            $utcTime = $unixEpoch.AddSeconds($unixDate)
            $dateTime = $utcTime.AddMinutes($timeZone.BaseUtcOffset.TotalMinutes)
        }
        return $dateTime
    }
    catch {
        return $_
    }
}

$exportcmdlets += 'Convert-UnixTime'

function Convert-WindowsTime {
    <#
.SYNOPSIS
Convert Convert-WindowsTime to PowerShell DateTime 

.DESCRIPTION
Convert Convert-WindowsTime to PowerShell DateTime 

.PARAMETER winDate
(required) The Windows time integer

.PARAMETER UTC
(optional) Return datetime relative to localtime based off system timezone

.EXAMPLE
Convert-WindowsTime 132947402891099830

.EXAMPLE
Convert-WindowsTime 132947402891099830 -UTC

.LINK
http://darrenjrobinson.com/convert-windows-and-unix-epoch-times-with-powershell

#>
    [cmdletbinding()]
    Param(
        [Parameter(Mandatory = $true, ValueFromPipeline = $true)][int64]$winDate,
        [Parameter(Mandatory = $false, ValueFromPipeline = $true)]
        [switch]$UTC
    )

    try {
        $winEpoch = (Get-Date -Year 1601 -Month 1 -Day 1 -hour 0 -Minute 0 -Second 0 -Millisecond 0)        
        if ($UTC) {
            $dateTime = $winEpoch.AddDays($winDate / 864000000000)
        }
        else {
            $convertedDate = $winEpoch.AddDays($winDate / 864000000000)
            $timeZone = Get-TimeZone
            $dateTime = $convertedDate.AddMinutes($timeZone.BaseUtcOffset.TotalMinutes)
        }
        return $dateTime
    }
    catch {
        return $_
    }
}

$exportcmdlets += 'Convert-WindowsTime'

function Get-UnixTime {
    <#
.SYNOPSIS
Convert PowerShell DateTime to Unix epoch time

.DESCRIPTION
Convert PowerShell DateTime to Unix epoch time

.PARAMETER datetime
(required) A PowerShell DateTime object

.EXAMPLE
$now = Get-Date
Get-UnixTime $now

.EXAMPLE
Get-Date | Get-UnixTime

.EXAMPLE
Get-Unixtime -datetime 'Sunday, 9 October 2022 2:47:48 PM'

.LINK
http://darrenjrobinson.com/convert-windows-and-unix-epoch-times-with-powershell

#>

    [cmdletbinding()]
    Param(
        [Parameter(Mandatory = $false, ValueFromPipeline = $true)]
        [DateTime]$datetime       
    )
    try {
        if ($datetime) {
            $unixEpoch = [int][double]::Parse((Get-Date $datetime -UFormat %s))
        }
        else {
            $unixEpoch = [int][double]::Parse((Get-Date -UFormat %s))
        }
        return $unixEpoch
    }
    catch {
        return $_
    }
}
$exportcmdlets += 'Get-UnixTime'

function Get-WindowsTime {
    <#
.SYNOPSIS
Convert PowerShell DateTime to Windows epoch time

.DESCRIPTION
Convert PowerShell DateTime to Windows epoch time

.PARAMETER datetime
(required) A PowerShell DateTime object

.EXAMPLE
$now = Get-Date
Get-WindowsTime $now

.EXAMPLE
Get-Date | Get-WindowsTime

.EXAMPLE
Get-WindowsTime -datetime 'Sunday, 9 October 2022 2:47:48 PM'

.LINK
http://darrenjrobinson.com/convert-windows-and-unix-epoch-times-with-powershell

#>

    [cmdletbinding()]
    Param(
        [Parameter(Mandatory = $false, ValueFromPipeline = $true)]
        [DateTime]$datetime       
    )
    try {
        if ($datetime) {
            $windowsEpoch = (Get-Date $datetime).ToFileTime()
        }
        else {
            $windowsEpoch = (Get-Date).ToFileTime()
        }
        return $windowsEpoch
    }
    catch {
        return $_
    }
}
$exportcmdlets += 'Get-WindowsTime'

Export-ModuleMember -Function $exportcmdlets 

# SIG # Begin signature block
# MIINSwYJKoZIhvcNAQcCoIINPDCCDTgCAQExCzAJBgUrDgMCGgUAMGkGCisGAQQB
# gjcCAQSgWzBZMDQGCisGAQQBgjcCAR4wJgIDAQAABBAfzDtgWUsITrck0sYpfvNR
# AgEAAgEAAgEAAgEAAgEAMCEwCQYFKw4DAhoFAAQU2nSsw9gcEOotvuhdX+qvV5xK
# aBugggqNMIIFMDCCBBigAwIBAgIQBAkYG1/Vu2Z1U0O1b5VQCDANBgkqhkiG9w0B
# AQsFADBlMQswCQYDVQQGEwJVUzEVMBMGA1UEChMMRGlnaUNlcnQgSW5jMRkwFwYD
# VQQLExB3d3cuZGlnaWNlcnQuY29tMSQwIgYDVQQDExtEaWdpQ2VydCBBc3N1cmVk
# IElEIFJvb3QgQ0EwHhcNMTMxMDIyMTIwMDAwWhcNMjgxMDIyMTIwMDAwWjByMQsw
# CQYDVQQGEwJVUzEVMBMGA1UEChMMRGlnaUNlcnQgSW5jMRkwFwYDVQQLExB3d3cu
# ZGlnaWNlcnQuY29tMTEwLwYDVQQDEyhEaWdpQ2VydCBTSEEyIEFzc3VyZWQgSUQg
# Q29kZSBTaWduaW5nIENBMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEA
# +NOzHH8OEa9ndwfTCzFJGc/Q+0WZsTrbRPV/5aid2zLXcep2nQUut4/6kkPApfmJ
# 1DcZ17aq8JyGpdglrA55KDp+6dFn08b7KSfH03sjlOSRI5aQd4L5oYQjZhJUM1B0
# sSgmuyRpwsJS8hRniolF1C2ho+mILCCVrhxKhwjfDPXiTWAYvqrEsq5wMWYzcT6s
# cKKrzn/pfMuSoeU7MRzP6vIK5Fe7SrXpdOYr/mzLfnQ5Ng2Q7+S1TqSp6moKq4Tz
# rGdOtcT3jNEgJSPrCGQ+UpbB8g8S9MWOD8Gi6CxR93O8vYWxYoNzQYIH5DiLanMg
# 0A9kczyen6Yzqf0Z3yWT0QIDAQABo4IBzTCCAckwEgYDVR0TAQH/BAgwBgEB/wIB
# ADAOBgNVHQ8BAf8EBAMCAYYwEwYDVR0lBAwwCgYIKwYBBQUHAwMweQYIKwYBBQUH
# AQEEbTBrMCQGCCsGAQUFBzABhhhodHRwOi8vb2NzcC5kaWdpY2VydC5jb20wQwYI
# KwYBBQUHMAKGN2h0dHA6Ly9jYWNlcnRzLmRpZ2ljZXJ0LmNvbS9EaWdpQ2VydEFz
# c3VyZWRJRFJvb3RDQS5jcnQwgYEGA1UdHwR6MHgwOqA4oDaGNGh0dHA6Ly9jcmw0
# LmRpZ2ljZXJ0LmNvbS9EaWdpQ2VydEFzc3VyZWRJRFJvb3RDQS5jcmwwOqA4oDaG
# NGh0dHA6Ly9jcmwzLmRpZ2ljZXJ0LmNvbS9EaWdpQ2VydEFzc3VyZWRJRFJvb3RD
# QS5jcmwwTwYDVR0gBEgwRjA4BgpghkgBhv1sAAIEMCowKAYIKwYBBQUHAgEWHGh0
# dHBzOi8vd3d3LmRpZ2ljZXJ0LmNvbS9DUFMwCgYIYIZIAYb9bAMwHQYDVR0OBBYE
# FFrEuXsqCqOl6nEDwGD5LfZldQ5YMB8GA1UdIwQYMBaAFEXroq/0ksuCMS1Ri6en
# IZ3zbcgPMA0GCSqGSIb3DQEBCwUAA4IBAQA+7A1aJLPzItEVyCx8JSl2qB1dHC06
# GsTvMGHXfgtg/cM9D8Svi/3vKt8gVTew4fbRknUPUbRupY5a4l4kgU4QpO4/cY5j
# DhNLrddfRHnzNhQGivecRk5c/5CxGwcOkRX7uq+1UcKNJK4kxscnKqEpKBo6cSgC
# PC6Ro8AlEeKcFEehemhor5unXCBc2XGxDI+7qPjFEmifz0DLQESlE/DmZAwlCEIy
# sjaKJAL+L3J+HNdJRZboWR3p+nRka7LrZkPas7CM1ekN3fYBIM6ZMWM9CBoYs4Gb
# T8aTEAb8B4H6i9r5gkn3Ym6hU/oSlBiFLpKR6mhsRDKyZqHnGKSaZFHvMIIFVTCC
# BD2gAwIBAgIQDOzRdXezgbkTF+1Qo8ZgrzANBgkqhkiG9w0BAQsFADByMQswCQYD
# VQQGEwJVUzEVMBMGA1UEChMMRGlnaUNlcnQgSW5jMRkwFwYDVQQLExB3d3cuZGln
# aWNlcnQuY29tMTEwLwYDVQQDEyhEaWdpQ2VydCBTSEEyIEFzc3VyZWQgSUQgQ29k
# ZSBTaWduaW5nIENBMB4XDTIwMDYxNDAwMDAwMFoXDTIzMDYxOTEyMDAwMFowgZEx
# CzAJBgNVBAYTAkFVMRgwFgYDVQQIEw9OZXcgU291dGggV2FsZXMxFDASBgNVBAcT
# C0NoZXJyeWJyb29rMRowGAYDVQQKExFEYXJyZW4gSiBSb2JpbnNvbjEaMBgGA1UE
# CxMRRGFycmVuIEogUm9iaW5zb24xGjAYBgNVBAMTEURhcnJlbiBKIFJvYmluc29u
# MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAwj7PLmjkknFA0MIbRPwc
# T1JwU/xUZ6UFMy6AUyltGEigMVGxFEXoVybjQXwI9hhpzDh2gdxL3W8V5dTXyzqN
# 8LUXa6NODjIzh+egJf/fkXOgzWOPD5fToL7mm4JWofuaAwv2DmI2UtgvQGwRhkUx
# Y3hh0+MNDSyz28cqExf8H6mTTcuafgu/Nt4A0ddjr1hYBHU4g51ZJ96YcRsvMZSu
# 8qycBUNEp8/EZJxBUmqCp7mKi72jojkhu+6ujOPi2xgG8IWE6GqlmuMVhRSUvF7F
# 9PreiwPtGim92RG9Rsn8kg1tkxX/1dUYbjOIgXOmE1FAo/QU6nKVioJMNpNsVEBz
# /QIDAQABo4IBxTCCAcEwHwYDVR0jBBgwFoAUWsS5eyoKo6XqcQPAYPkt9mV1Dlgw
# HQYDVR0OBBYEFOh6QLkkiXXHi1nqeGozeiSEHADoMA4GA1UdDwEB/wQEAwIHgDAT
# BgNVHSUEDDAKBggrBgEFBQcDAzB3BgNVHR8EcDBuMDWgM6Axhi9odHRwOi8vY3Js
# My5kaWdpY2VydC5jb20vc2hhMi1hc3N1cmVkLWNzLWcxLmNybDA1oDOgMYYvaHR0
# cDovL2NybDQuZGlnaWNlcnQuY29tL3NoYTItYXNzdXJlZC1jcy1nMS5jcmwwTAYD
# VR0gBEUwQzA3BglghkgBhv1sAwEwKjAoBggrBgEFBQcCARYcaHR0cHM6Ly93d3cu
# ZGlnaWNlcnQuY29tL0NQUzAIBgZngQwBBAEwgYQGCCsGAQUFBwEBBHgwdjAkBggr
# BgEFBQcwAYYYaHR0cDovL29jc3AuZGlnaWNlcnQuY29tME4GCCsGAQUFBzAChkJo
# dHRwOi8vY2FjZXJ0cy5kaWdpY2VydC5jb20vRGlnaUNlcnRTSEEyQXNzdXJlZElE
# Q29kZVNpZ25pbmdDQS5jcnQwDAYDVR0TAQH/BAIwADANBgkqhkiG9w0BAQsFAAOC
# AQEANWoHDjN7Hg9QrOaZx0V8MK4c4nkYBeFDCYAyP/SqwYeAtKPA7F72mvmJV6E3
# YZnilv8b+YvZpFTZrw98GtwCnuQjcIj3OZMfepQuwV1n3S6GO3o30xpKGu6h0d4L
# rJkIbmVvi3RZr7U8ruHqnI4TgbYaCWKdwfLb/CUffaUsRX7BOguFRnYShwJmZAzI
# mgBx2r2vWcZePlKH/k7kupUAWSY8PF8O+lvdwzVPSVDW+PoTqfI4q9au/0U77UN0
# Fq/ohMyQ/CUX731xeC6Rb5TjlmDhdthFP3Iho1FX0GIu55Py5x84qW+Ou+OytQcA
# FZx22DA8dAUbS3P7OIPamcU68TGCAigwggIkAgEBMIGGMHIxCzAJBgNVBAYTAlVT
# MRUwEwYDVQQKEwxEaWdpQ2VydCBJbmMxGTAXBgNVBAsTEHd3dy5kaWdpY2VydC5j
# b20xMTAvBgNVBAMTKERpZ2lDZXJ0IFNIQTIgQXNzdXJlZCBJRCBDb2RlIFNpZ25p
# bmcgQ0ECEAzs0XV3s4G5ExftUKPGYK8wCQYFKw4DAhoFAKB4MBgGCisGAQQBgjcC
# AQwxCjAIoAKAAKECgAAwGQYJKoZIhvcNAQkDMQwGCisGAQQBgjcCAQQwHAYKKwYB
# BAGCNwIBCzEOMAwGCisGAQQBgjcCARUwIwYJKoZIhvcNAQkEMRYEFIKVJ9a8ywIf
# njYysXdg7PN554t8MA0GCSqGSIb3DQEBAQUABIIBAGsPtxNtnG3PHqfTmtho5Msw
# +dFaiUkmQZ6Hu33upwgPp9UPoeZ/ZDDSHnakFEFPWHFAFYzj6IQLBo1OMGeBp93B
# cueihvuMR6wNNlxygQcwJZIig1BQ1bQnJ6WTu9OeOSUUSfCez5DBHnlUkbGKGo6i
# lxbV4LaarX4YMOeHlg5chet9d0osSJ+oVhu/1m4waE4m7bCsNVFdx42+ieiSuI8G
# jn+tq1Tk851IqJF0D9BR994wViSOPmA+JEkipWd3msAcPyJy7ULRGAGFExs/OF9d
# CJ3vhCoY0ishxPg2DupZFoS7DUk4HX17BL4Tu62FLpFf2fXxMWijRqSTWLZAJqs=
# SIG # End signature block
