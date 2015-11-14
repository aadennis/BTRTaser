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

$RAS = "RAS"
$BTR = "BTR"

function Show-ComplianceRecord ($currentRecord, $startPos, $columnLength, $displayName) {
    $len = $currentRecord.length
    if ($len -lt ([int] $startPos + $columnLength)) {
        Write-Host "The current record only contains [$len] characters, but you have asked for a column [$displayName] at position [$startPos, $columnLength]. Exiting..."
        exit
    }
    $columnValue = $currentRecord.substring($startpos, $columnLength) 
    Write-Host "$DisplayName [$columnLength]: [" -Foregroundcolor White -NoNewline; write-Host "$columnValue" -ForegroundColor Cyan -NoNewLine; write-Host "]" -ForegroundColor White 
}

function Get-ComplianceRecordDefinition($recordType, $fileType) {
    if ($fileType -eq $BTR) {
        if ($recordType -eq "3A") {
            $recordDef = 
                {1,2,"Record Type"},
                {3,5,"Transaction sequence Number"},
                {8,1,"Type of Filing"},
                {9,14,"Document Control Number or BSA Identifier"},
                {23,8,"Date of Transaction"},
                {31,5,"Transaction Type"},
                {36,15,"Total Cash-in (Item 25)"},
                {51,15,"Cash-in: Deposit(s) (Item 25a)"},
                {66,15,"Cash-in: Payment(s)(Item 25b)"},
                {251,15,"Total Cash-out"}
            return $recordDef
        }
        if ($recordType -eq "4B") {
            $recordDef = 
                {1,2,"Record Type"},
                {3,5,"Transaction sequence Number"},
                {8,40,"Item 21a"},
                {48,993,"Filler"},
                {1041,10,"User Field"}
            return $recordDef
        }
        if ($recordType -eq "4C") {
            $recordDef = 
                {1,2,"Record Type"},
                {3,5,"Transaction sequence Number"},
                {8,40,"Item 22a"},
                {48,993,"Filler"},
                {1041,10,"User Field"}
            return $recordDef
        }
        Write-Host "Details for Record type [$recordType] not currently available" -ForegroundColor Yellow

    }
      if ($fileType -eq $RAS) {
        if ($recordType -eq "1A") {
            $recordDef = 
                {1,2,"Record Type"},
                {3,55,"Transmitter Name"},
                {58,50,"Transmitter Address"},
                {108,25,"Transmitter City"},
                {133,2,"Transmitter State"},
                {135,9,"Transmitter ZIP Code"},
                {144,10,"Transmitter Telephone Number"},
                {154,55,"Transmitter Contact Name "},
                {66,15,"Transmitter Contact Name"},
                {209,9,"Transmitter EIN"},
                {218,8,"Coverage Beginning Date"},
                {226,8,"Coverage Ending Date"},
                {234,8,"Transmitter Control Code"},
                {242,4,"New Format Indicator"},
                {246,225,"Filler"},
                {471,10,"User Field"}
            return $recordDef
        }
        if ($recordType -eq "4B") {
            $recordDef = 
                {1,2,"Record Type"},
                {3,5,"Transaction sequence Number"},
                {8,40,"Item 21a"},
                {48,993,"Filler"},
                {1041,10,"User Field"}
            return $recordDef
        }
        if ($recordType -eq "4C") {
            $recordDef = 
                {1,2,"Record Type"},
                {3,5,"Transaction sequence Number"},
                {8,40,"Item 22a"},
                {48,993,"Filler"},
                {1041,10,"User Field"}
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

        $offset = [int] $columnDefinition[0] - 1
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
    $validFileTypes = $BTR,$RAS
    if ($validFileTypes -notcontains $fileType ) {
       Write-Host "File type [$fileType] not recognised. Exiting..."
       return
    }
    Get-ComplianceModel $filePath | foreach { Process-ComplianceRecord $_ $fileType }
    Write-Host "$separatorLine"
    return
}

Show-ComplianceFileContent -fileType "RAS" -filePath "C:\sandbox\GitRepos\BTRTaser\TestData\RAS001.TXT" 
#Show-ComplianceFileContent -fileType "BTR" -filePath "C:\sandbox\GitRepos\BTRTaser\TestData\BTR001.TXT" 

