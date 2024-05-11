<#

.SYNOPSIS
Lets master accounts retrieve subaccounts' plan information.

.DESCRIPTION
Lets master accounts retrieve subaccounts' plan information.
Prerequisite: This API can only be used by master accounts that pay all billing charges of their associated Pro or higher subaccounts.

.PARAMETER BillingAccountId
Unique Identifier of the account.

.LINK
https://developers.zoom.us/docs/api/rest/reference/billing/ma/#operation/GetAccountPlanInformation


.EXAMPLE
Plan details for a specific billing account.
Get-ZoomBillingPlan -BillingAccountId "3vt4b7wtb79q4wvb"



#>

function Get-ZoomBillingPlan {
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
        $request = [System.UriBuilder]"https://api.$ZoomURI/v2/accounts/$BillingAccountId/plans"

        $response = Invoke-ZoomRestMethod -Uri $request.Uri -Method GET

        Write-Output $response
    
    } 
}
