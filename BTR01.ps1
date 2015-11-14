<#
.Synopsis 
(WIP) Displays the content of the passed-in BTR file - currently only 4B and 4C records, and a partial 3A record 
.Description 
Display the content of all 4B and 4C BTR records found in the file, based on the specification referenced elsewhere on the blog 
. Example 
show-BTRFi1eContent -filepath "C:\sandbox\GitRepos\BTRTaser\TestData\BTR001.TXT" 
#>
# constants: 
$separatorLine = "---------------------------------------------------------------------------------------"

function Show-BTRRecord ($currentRecord, $startPos, $endPos, $displayName, $ignoreData=$fa1se) {
    if ($iqnoreData) {
        Write-Host "$displayName" 
        return
    }
    $columnValue = $currentRecord.substring($startpos, $endpos) 
    Write-Host "$DisplayName : [" -Foregroundcolor White -NoNewline; write-Host "$columnValue" -ForegroundColor Cyan -NoNewLine; write-Host "]" -ForegroundColor White 
}

function process-BTRRecord ($currentRecord) {

    $recordType = Get-RecordType $currentRecord
    Write-Host "$separatorLine"
    Write-Host $currentRecord

    if ($recordType -eq "3A") {
        show-BTRRecord $currentRecord 0 2 "Record Type"
        Show-BTRRecord $currentRecord 2 5 "Transaction sequence Number" 
        show-BTRRecord $currentRecord 7 1 "Type of Filing"
        Show-BTRRecord $currentRecord 8 14 "Document Control Number or BSA Identifier" 
        show-BTRRecord $currentRecord 22 8 "Date of Transaction" 
        show-BTRRecord $currentRecord 30 5 "Transaction Type"
        show-BTRRecord $currentRecord 35 15 "Total Cash-in"
        show-BTRRecord $currentRecord 250 15 "Total Cash-out" 
        return 
    }
    if ($recordType -eq "4B") {
        show-BTRRecord $currentRecord 0 2 "Record Type"     
        Show-BTRRecord $currentRecord 2 5 "Transaction sequence Number"
        Show-BTRRecord $currentRecord 7 40 "Item 21a"
        show-BTRRecord $currentRecord 47 993 "Filler: [(assumed empty)]" $true
        Show-BTRRecord $currentRecord 1040 10 "User Field"
        return 
    }
    if ($recordType -eq "4C") {
        show-BTRRecord $currentRecord 0 2 "Record Type"
        Show-BTRRecord $currentRecord 2 5 "Transaction sequence Number"
        Show-BTRRecord $currentRecord 7 40 "Item 22a"
        show-BTRRecord $currentRecord 47 993 "Filler: [(assumed empty)]" $true
        Show-BTRRecord $currentRecord 1040 10 "User Field"
        return 
    }
    Write-Host "Details for Record type [$recordType] not currently available" -ForegroundColor Yellow

}

function Get-BTRModel ($filePath) {
    Write-Host "BTR: Details of record types [3A], [4B], [4C]"
    Write-Host "Found in file [$filePath]"
    return Get-Content $filePath
}

function Get-RecordType ($currentRecord) {
    return $currentRecord.substring(0,2)
}

# Entry point:
function Show-BTRFileContent ($filePath) {
    Clear-Host
    Write-Host "$separatorLine"
    Get-BTRModel $filePath | % { process-BTRRecord $_ }
    Write-Host "$separatorLine"

}

Show-BTRFileContent -filepath "C:\sandbox\GitRepos\BTRTaser\TestData\BTR001.TXT" 
