<#

.SYNOPSIS
Update a user's email.

.DESCRIPTION
Update a user's email.

.PARAMETER UserId
The user ID or email address.

.PARAMETER Email
User's email. The length should be less than 128 characters.

.OUTPUTS
No output. Can use Passthru switch to pass UserId to output.

.EXAMPLE
Update-ZoomUserEmail lskywalker@thejedi.com

.LINK
https://developers.zoom.us/docs/api/rest/reference/user/methods/#operation/userEmailUpdate

#>

function Update-ZoomUserEmail {
    [CmdletBinding()]
    param (
        [Parameter(
            Mandatory = $True, 
            Position = 0, 
            ValueFromPipeline = $True,
            ValueFromPipelineByPropertyName = $True
        )]
        [Alias('Id')]
        [string]$UserId,

        [Parameter(
            Mandatory = $True,
            Position = 1,
            ValueFromPipelineByPropertyName = $True
        )]
        [ValidateLength(0,128)]
        [string]$Email,

        [switch]$Passthru
    )

    process {
        $request = [System.UriBuilder]"https://api.$ZoomURI/v2/users/$UserId/email"

        $requestBody = @{
            'email' = $Email
        } 

        $requestBody = $requestBody | ConvertTo-Json

        Invoke-ZoomRestMethod -Uri $request.Uri -Body $requestBody -Method PUT

        if ($Passthru) {
            Write-Output $UserId
        }
    }
}