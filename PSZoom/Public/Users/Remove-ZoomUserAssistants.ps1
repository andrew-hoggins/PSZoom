<#

.SYNOPSIS
Delete all user assistants.

.DESCRIPTION
Delete all user assistants. Assistants are the users to whom the current user has assigned  on the user’s behalf.

.PARAMETER UserId
The user ID or email address.

.OUTPUTS
No output. Can use Passthru switch to pass UserId to output.

.EXAMPLE
Remove-ZoomUserAssistants jmcevoy@lawfirm.com

.LINK
https://developers.zoom.us/docs/api/rest/reference/user/methods/#operation/userAssistantsDelete

#>

function Remove-ZoomUserAssistants {
    [CmdletBinding()]
    param (
        [Parameter(
            Mandatory = $True, 
            Position = 0, 
            ValueFromPipeline = $True,
            ValueFromPipelineByPropertyName = $True
        )]
        [Alias('Email', 'EmailAddress', 'Id', 'user_id')]
        [string[]]$UserId,

        [switch]$Passthru
    )

    process {
        foreach ($user in $UserId) {
            $Request = [System.UriBuilder]"https://api.$ZoomURI/v2/users/$user/assistants"
    
            Invoke-ZoomRestMethod -Uri $request.Uri -Method DELETE
 
            if ($Passthru) {
                Write-Output $UserId
            }
        }
    }
}