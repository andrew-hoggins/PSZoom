<#

.SYNOPSIS
List billing account information.

.DESCRIPTION
List billing account information.

.PARAMETER BillingAccountId
Unique Identifier of the account.

.LINK
https://developers.zoom.us/docs/api/rest/reference/billing/ma/#operation/GetBillingInformation


.EXAMPLE
Details for a specific billing account.
Get-ZoomBillingInfo -BillingAccountId "3vt4b7wtb79q4wvb"



#>

function Get-ZoomBillingInfo {
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
        $request = [System.UriBuilder]"https://api.$ZoomURI/v2/accounts/$BillingAccountId/billing"

        $response = Invoke-ZoomRestMethod -Uri $request.Uri -Method GET

        Write-Output $response
    
    } 
}
