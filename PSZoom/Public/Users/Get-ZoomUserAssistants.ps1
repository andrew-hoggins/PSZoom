<#

.SYNOPSIS
List user assistants.

.DESCRIPTION
List a user's assistants. For user-level apps, pass the me value for the -userId parameter.

.PARAMETER UserId
The user ID or email address.

.LINK
https://developers.zoom.us/docs/api/rest/reference/user/methods/#operation/userAssistants

.EXAMPLE
Get-ZoomUserAssistants jmcevoy@lawfirm.com

.OUTPUTS
An array of objects.

#>

function Get-ZoomUserAssistants {
    [CmdletBinding()]
    param (
        [Parameter(
            Mandatory = $True, 
            Position = 0, 
            ValueFromPipeline = $True,
            ValueFromPipelineByPropertyName = $True
        )]
        [Alias('Email', 'EmailAddress', 'Id', 'user_id', 'userids', 'ids', 'emailaddresses','emails')]
        [string[]]$UserId
     )

    process {
        foreach ($id in $UserId) {
            $Request = [System.UriBuilder]"https://api.$ZoomURI/v2/users/$Id/assistants"

            $response = Invoke-ZoomRestMethod -Uri $request.Uri -Method GET | Select-Object -ExpandProperty "assistants"
    
            Write-Output $response
        }
    }
}