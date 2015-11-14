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

function Show-BTRRecord ($currentRecord, $startPos, $endPos, $displayName) {
    $columnValue = $currentRecord.substring($startpos, $endpos) 
    Write-Host "$DisplayName : [" -Foregroundcolor White -NoNewline; write-Host "$columnValue" -ForegroundColor Cyan -NoNewLine; write-Host "]" -ForegroundColor White 
}

function Get-BTRRecordDefinition($recordType, $fileType) {
    if ($fileType -eq "BTR") {
        if ($recordType -eq "3A") {
            $recordDef = 
                {0,2,"Record Type"},
                {2,5,"Transaction sequence Number"},
                {7,1,"Type of Filing"},
                {8,14,"Document Control Number or BSA Identifier"},
                {22,8,"Date of Transaction"},
                {30,5,"Transaction Type"},
                {35,15,"Total Cash-in (Item 25)"},
                {50,15,"Cash-in: Deposit(s) (Item 25a)"},
                {65,15,"Cash-in: Payment(s)(Item 25b)"},
                {250,15,"Total Cash-out"}
            return $recordDef

        }
        if ($recordType -eq "4B") {
            $recordDef = 
                {0,2,"Record Type"},
                {2,5,"Transaction sequence Number"},
                {7,40,"Item 21a"},
                {47,993,"Filler"},
                {1040,10,"User Field"}
            return $recordDef

        }
        if ($recordType -eq "4C") {
            $recordDef = 
                {0,2,"Record Type"},
                {2,5,"Transaction sequence Number"},
                {7,40,"Item 22a"},
                {47,993,"Filler"},
                {1040,10,"User Field"}

            return $recordDef
        }
        Write-Host "Details for Record type [$recordType] not currently available" -ForegroundColor Yellow
    }
}

function Process-BTRRecord ($currentRecord, $fileType) {

    $recordType = Get-RecordType $currentRecord
    Write-Host "$separatorLine"
    Get-BTRRecordDefinition $recordType $fileType | % {
        $columnDefinition = $_ -split ","

        $offset = $columnDefinition[0]
        $columnLength = $columnDefinition[1] 
        $columnName = $columnDefinition[2] -replace "`"" 

        show-BTRRecord $currentRecord $offset $columnLength $columnName
    }
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
function Show-BTRFileContent ($fileType, $filePath) {
    Clear-Host
    Write-Host "$separatorLine"
    if ($fileType -eq "BTR") {
        Get-BTRModel $filePath | foreach { Process-BTRRecord $_ $fileType }
        Write-Host "$separatorLine"
        return
    }
    if ($fileType -eq "RAS") {
        Get-BTRModel $filePath | foreach { Process-RASRecord $_ $fileType}
        Write-Host "$separatorLine"
        return
    }
    Write-Host "File type [$fileType] not recognised. Exiting..."
    return
}

Show-BTRFileContent -fileType "BTR" -filePath "C:\sandbox\GitRepos\BTRTaser\TestData\BTR001.TXT" 
