<#

.SYNOPSIS
Add assistants to user(s).

.DESCRIPTION
Add assistants to user(s). Assistants are the users to whom the current user has assigned scheduling privilege on the user’s behalf.

.PARAMETER UserId
The user ID or email address.

.PARAMETER AssistantId
The ID of the assistant. If using an assistant's ID, an email is not needed.

.PARAMETER AssistantEmail
The email of the assistant. If using an assistant's Email, an id is not needed.

.EXAMPLE
Add an assistant to a user.
Add-ZoomUserAssistants -UserId 'dsidious@thesith.com' -AssistantEmail 'dmaul@thesith.com'

.EXAMPLE
Add assistants to a user.
Add-ZoomUserAssistants -UserId  'okenobi@thejedi.com' -AssistantId '123456789','987654321'

.EXAMPLE
Add assitant to multiple users.
Add-ZoomUserAssistants -UserId  'okenobi@thejedi.com', 'dsidious@thesith.com' -AssistantId 'dvader@thesith.com',

.LINK
https://developers.zoom.us/docs/api/rest/reference/user/methods/#operation/userAssistantCreate

.OUTPUTS
A hastable with the Zoom API response.

#>

function Add-ZoomUserAssistants {
    [CmdletBinding()]
    param (
        [Parameter(
            Mandatory = $True, 
            Position = 0, 
            ValueFromPipeline = $True,
            ValueFromPipelineByPropertyName = $True
        )]
        [Alias('Email', 'EmailAddress', 'ID', 'user_id', 'UserIds', 'Emails', 'IDs')]
        [string[]]$UserId,

        [Parameter(ValueFromPipelineByPropertyName = $True)]
        [Alias('assistantemails')]
        [string[]]$AssistantEmail,

        [Parameter(ValueFromPipelineByPropertyName = $True)]
        [Alias('assistantids')]
        [string[]]$AssistantId,

        [switch]$Passthru
    )

    process {
        foreach ($Id in $UserId) {
            $request = [System.UriBuilder]"https://api.$ZoomURI/v2/users/$Id/assistants"

            $assistants = @()
    
            foreach ($email in $AssistantEmail) {
                $assistants += @{'email' = $email}
            }
    
            foreach ($id in $AssistantId) {
                $assistants += @{'id' = $id}
            }
    
            $requestBody = @{
                'assistants' = $assistants
            }
            
            $requestBody = $requestBody | ConvertTo-Json
            $response = Invoke-ZoomRestMethod -Uri $request.Uri -Body $RequestBody -Method POST

            
            if ($Passthru) {
                Write-Output $UserId
            } else {
                Write-Output $response
            }
        }
    }
}
