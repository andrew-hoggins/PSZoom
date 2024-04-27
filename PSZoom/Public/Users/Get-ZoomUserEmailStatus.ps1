<#

.SYNOPSIS
Verify if a user’s email is registered with Zoom.

.DESCRIPTION
Verify if a user’s email is registered with Zoom.

.PARAMETER Email
The email address to be verified.

.EXAMPLE
Get-ZoomUserEmailStatus jsmith@lawfirm.com

.LINK
https://developers.zoom.us/docs/api/rest/reference/user/methods/#operation/userEmail

.OUTPUTS
A hastable with the Zoom API response.

#>

function Get-ZoomUserEmailStatus {
    [CmdletBinding()]
    param (
        [Parameter(
            Mandatory = $True, 
            Position = 0, 
            ValueFromPipeline = $True
        )]
        [Alias('EmailAddress', 'Id', 'UserId')]
        [string]$Email
     )

    process {
        $Request = [System.UriBuilder]"https://api.$ZoomURI/v2/users/email"
        $query = [System.Web.HttpUtility]::ParseQueryString([String]::Empty)
        $query.Add('email', $Email)
        $Request.Query = $query.ToString()
        $response = Invoke-ZoomRestMethod -Uri $request.Uri -Method GET

        Write-Output $response
    }
}