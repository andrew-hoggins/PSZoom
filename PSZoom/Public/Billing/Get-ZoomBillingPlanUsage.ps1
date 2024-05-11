<#

.SYNOPSIS
Returns information on plan usage for an account. This API supports standard and master accounts and subaccounts.

.DESCRIPTION
Returns information on plan usage for an account. This API supports standard and master accounts and subaccounts.

.PARAMETER BillingAccountId
Unique Identifier of the account.

.LINK
https://developers.zoom.us/docs/api/rest/reference/billing/ma/#operation/GetPlanUsage


.EXAMPLE
Details for a specific billing account.
Get-ZoomBillingPlanUsage -BillingAccountId "3vt4b7wtb79q4wvb"



#>

function Get-ZoomBillingPlanUsage {
    [CmdletBinding()]
    param (
        [Parameter(
            Mandatory = $True, 
            Position = 0, 
            ValueFromPipeline = $True,
            ValueFromPipelineByPropertyName = $True
        )]
        [Alias('account_id')]
        [string]$BillingAccountId
     )

    process {
        $request = [System.UriBuilder]"https://api.$ZoomURI/v2/accounts/$BillingAccountId/plans/usage"

        $response = Invoke-ZoomRestMethod -Uri $request.Uri -Method GET

        Write-Output $response
    
    } 
}
