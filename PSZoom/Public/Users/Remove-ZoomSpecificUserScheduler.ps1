<#

.SYNOPSIS
Delete a specific scheduler.

.DESCRIPTION
Delete a specific scheduler. Schedulers are the users to whom the current user has assigned  on the user’s behalf.

.PARAMETER UserId
The user ID or email address.

.PARAMETER SchedulerId
The scheduler ID or email address.

.OUTPUTS
No output. Can use Passthru switch to pass UserId to output.

.EXAMPLE
Remove-ZoomSpecificUsersSheduler jmcevoy@lawfirm.com

.LINK
https://developers.zoom.us/docs/api/rest/reference/user/methods/#operation/userSchedulerDelete

#>

function Remove-ZoomSpecificUserScheduler {
    [CmdletBinding(SupportsShouldProcess = $True, ConfirmImpact='Low')]
    param (
        [Parameter(
            Mandatory = $True, 
            Position = 0, 
            ValueFromPipeline = $True,
            ValueFromPipelineByPropertyName = $True
        )]
        [Alias('Email', 'EmailAddress', 'Id', 'user_id')]
        [string[]]$UserId,

        [Parameter(
            Mandatory = $True, 
            Position = 1,
            ValueFromPipelineByPropertyName = $True
        )]
        [Alias('scheduler_id')]
        [string[]]$SchedulerId,

        [switch]$Passthru
    )

    process {
        foreach ($user in $UserId) {
            foreach ($scheduler in $schedulerId) {
                if ($PScmdlet.ShouldProcess($user, "Remove $scheduler")) {
                    $request = [System.UriBuilder]"https://api.$ZoomURI/v2/users/$user/schedulers/$scheduler"
                    
                    Invoke-ZoomRestMethod -Uri $request.Uri -Method DELETE

                    if ($Passthru) {
                            Write-Output $UserId
                    }
                }
            }
        }
    }
}