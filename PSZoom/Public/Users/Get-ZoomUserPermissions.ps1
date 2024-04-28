<#

.SYNOPSIS
Retrieve a user’s permissions.

.DESCRIPTION
Retrieve a user’s permissions.

.PARAMETER UserId
The user ID or email address.


.OUTPUTS
An array of objects.

.EXAMPLE
Get-ZoomUserPermissions jsmith@lawfirm.com

.LINK
https://developers.zoom.us/docs/api/rest/reference/user/methods/#operation/userPermission
#>

function Get-ZoomUserPermissions {
    [CmdletBinding()]
    param (
        [Parameter(
            Mandatory = $True, 
            Position = 0, 
            ValueFromPipeline = $True,
            ValueFromPipelineByPropertyName = $True
        )]
        [Alias('Email', 'EmailAddress', 'Id', 'user_id')]
        [string[]]$UserId
     )

    process {
        $AggregatedResponse = @()
        $UserId | ForEach-Object {
            $Request = [System.UriBuilder]"https://api.$ZoomURI/v2/users/$_/permissions"
            $response = Invoke-ZoomRestMethod -Uri $request.Uri -Method GET 
            $response | Add-Member -Name 'UserID' -Type NoteProperty -Value $_
            $AggregatedResponse += $response | Select-Object UserID,permissions
        }
        

        Write-Output $AggregatedResponse
    }
}