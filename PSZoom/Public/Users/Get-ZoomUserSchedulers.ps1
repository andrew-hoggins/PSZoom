<#

.SYNOPSIS
List user schedulers.

.DESCRIPTION
List user schedulers.

.PARAMETER UserId
The user ID or email address.

.OUTPUTS
An array of objects.

.EXAMPLE
Get-ZoomUserSchedulers jmcevoy@lawfirm.com

.LINK
https://developers.zoom.us/docs/api/rest/reference/user/methods/#operation/userSchedulers

#>

function Get-ZoomUserSchedulers {
    [CmdletBinding()]
    param (
        [Parameter(
            Mandatory = $True, 
            Position = 0, 
            ValueFromPipeline = $True,
            ValueFromPipelineByPropertyName = $True
        )]
        [Alias('Email', 'EmailAddress', 'Id', 'user_id')]
        [string]$UserId
    )

    process {
        $Request = [System.UriBuilder]"https://api.$ZoomURI/v2/users/$UserId/schedulers"
        $response = Invoke-ZoomRestMethod -Uri $request.Uri -Method GET | Select-Object -ExpandProperty "schedulers"

        Write-Output $response
    }
}