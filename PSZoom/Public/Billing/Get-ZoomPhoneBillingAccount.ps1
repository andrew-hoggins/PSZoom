<#

.SYNOPSIS
List billing account information.

.DESCRIPTION
List billing account information.

.PARAMETER BillingAccountId
Unique Identifier of the account.

.PARAMETER PageSize
The number of records returned within a single API call (Min 30 - MAX 100).

.PARAMETER NextPageToken
The next page token is used to paginate through large result sets. A next page token will be returned whenever the set 
of available results exceeds the current page size. The expiration period for this token is 15 minutes.

.PARAMETER Full
When using -Full switch, receive the full JSON Response to see the next_page_token.

.LINK
https://developers.zoom.us/docs/zoom-phone/apis/#operation/GetABillingAccount

.EXAMPLE
Return a list of all the zoom phone users.
Get-ZoomPhoneBillingAccount

.EXAMPLE
Details for a specific billing account.
Get-ZoomPhoneBillingAccount -BillingAccountId "3vt4b7wtb79q4wvb"

.EXAMPLE
Get a page of zoom users with phone accounts.
Get-ZoomPhoneBillingAccount -PageSize 100 -NextPageToken "8w7vt487wqtb457qwt4"

#>

function Get-ZoomPhoneBillingAccount {
    [CmdletBinding(DefaultParameterSetName="AllData")]
    [Alias("Get-ZoomPhoneBillingAccounts")]
    param (
        [Parameter(
            ParameterSetName="SelectedRecord",
            Mandatory = $True, 
            Position = 0, 
            ValueFromPipeline = $True,
            ValueFromPipelineByPropertyName = $True
        )]
        [Alias('id')]
        [string[]]$BillingAccountId,

        [parameter(ParameterSetName="NextRecords")]
        [ValidateRange(1, 100)]
        [Alias('page_size')]
        [int]$PageSize = 100,
		
        # The next page token is used to paginate through large result sets. A next page token will be returned whenever the set of available results exceeds the current page size. The expiration period for this token is 15 minutes.
        [parameter(ParameterSetName="NextRecords")]
        [Alias('next_page_token')]
        [string]$NextPageToken,

        [parameter(ParameterSetName="SpecificSite")]
        [parameter(ParameterSetName="AllData")]
        [switch]$Full = $False
     )

    process {
        $baseURI = "https://api.$ZoomURI/v2/phone/billing_accounts"

        switch ($PSCmdlet.ParameterSetName) {
            "NextRecords" {
                $AggregatedResponse = Get-ZoomPaginatedData -URI $baseURI -PageSize $PageSize -NextPageToken $NextPageToken
            }

            "SelectedRecord" {
                $AggregatedResponse = Get-ZoomPaginatedData -URI $baseURI -ObjectId $billingAccountId
            }

            "AllData" {
                $AggregatedResponse = Get-ZoomPaginatedData -URI $baseURI -PageSize 100
            }
        }
    
        if ($Full) {
            $AggregatedIDs = $AggregatedResponse | select-object -ExpandProperty ID
            $AggregatedResponse = Get-ZoomItemFullDetails -ObjectIds $AggregatedIDs -CmdletToRun $MyInvocation.MyCommand.Name
        }

        Write-Output $AggregatedResponse 
    } 
}
