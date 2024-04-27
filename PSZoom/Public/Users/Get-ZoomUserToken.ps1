<#

.SYNOPSIS
Retrieve a user's token.

.DESCRIPTION
Retrieve a user's token.

.PARAMETER UserId
The user ID or email address.

.PARAMETER Type
Token - Used for starting meeting with client SDK.
ZPK - Used for generating the start meeting url. (Deprecated)
ZAP - Used for generating the start meeting url. The expiration time is two hours. For API users, the expiration time is 90 days.

.OUTPUTS
A hastable with the Zoom API response.

.EXAMPLE
Get-ZoomUserToken jsmith@lawfirm.com

.LINK
https://developers.zoom.us/docs/api/rest/reference/user/methods/#operation/userToken

#>

function Get-ZoomUserToken {
    [CmdletBinding()]
    param (
        [Parameter(
            Mandatory = $True, 
            Position = 0, 
            ValueFromPipeline = $True,
            ValueFromPipelineByPropertyName = $True
        )]
        [Alias('Email', 'EmailAddress', 'Id', 'user_id')]
        [string]$UserId,

        [Parameter(ValueFromPipelineByPropertyName = $True)]
        [ValidateSet('token', 'zpk', 'zap')]
        [string]$Type
     )

    process {
        $Request = [System.UriBuilder]"https://api.$ZoomURI/v2/users/$UserId/token"

        if ($PSBoundParameters.ContainsKey('Type')) {
            $query = [System.Web.HttpUtility]::ParseQueryString([String]::Empty)  
            $query.Add('login_type', $Type)
            $Request.Query = $query.ToString()
        }

        $response = Invoke-ZoomRestMethod -Uri $request.Uri -Method GET


        Write-Output $response
    }
}