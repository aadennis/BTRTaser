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

$RAS = "SAR"

function Show-ComplianceRecord ($currentRecord, $startPos, $columnLength, $displayName) {
    $len = $currentRecord.length
    if ($len -lt ([int] $startPos + $columnLength)) {
        Write-Host "The current record only contains [$len] characters, but you have asked for a column at position [$startPos, $columnLength]. Exiting..."
        exit
    }
    $columnValue = $currentRecord.substring($startpos, $columnLength) 
    Write-Host "$DisplayName : [" -Foregroundcolor White -NoNewline; write-Host "$columnValue" -ForegroundColor Cyan -NoNewLine; write-Host "]" -ForegroundColor White 
}

function Get-ComplianceRecordDefinition($recordType, $fileType) {
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
      if ($fileType -eq $RAS) {
        if ($recordType -eq "1A") {
            $recordDef = 
                {0,2,"Record Type"},
                {2,55,"Transmitter Name"},
                {57,50,"Transmitter Address"},
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

function Process-ComplianceRecord ($currentRecord, $fileType) {

    $recordType = Get-RecordType $currentRecord
    Write-Host "$separatorLine"
    Get-ComplianceRecordDefinition $recordType $fileType | % {
        $columnDefinition = $_ -split ","

        $offset = $columnDefinition[0]
        $columnLength = $columnDefinition[1] 
        $columnName = $columnDefinition[2] -replace "`"" 

        show-ComplianceRecord $currentRecord $offset $columnLength $columnName
    }
}

function Get-ComplianceModel ($filePath) {
    Write-Host "Found in file [$filePath]"
    return Get-Content $filePath
}

function Get-RecordType ($currentRecord) {
    return $currentRecord.substring(0,2)
}

# Entry point:
function Show-ComplianceFileContent ($fileType, $filePath) {
    Clear-Host
    Write-Host "$separatorLine"
    $validFileTypes = "BTR",$RAS
    if ($validFileTypes -notcontains $fileType ) {
       Write-Host "File type [$fileType] not recognised. Exiting..."
       return
    }
    Get-ComplianceModel $filePath | foreach { Process-ComplianceRecord $_ $fileType }
    Write-Host "$separatorLine"
    return
}

Show-ComplianceFileContent -fileType "SAR" -filePath "C:\sandbox\GitRepos\BTRTaser\TestData\RAS001.TXT" 
