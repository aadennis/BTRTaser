<#
.Synopsis 
  Fincen Compliance specification metadata rules 
.Description 
. Example 
  Get-ComplianceRecordDefinition $recordType $fileType
#>
function Get-ComplianceRecordDefinition($recordType, $fileType) {

    $RAS = "RAS"
    $BTR = "BTR"

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
        if ($recordType -eq "2A") {
            $recordDef = 
                {1,2,"Record Type"},
                {3,1,"Reporting Business same..."},
                {4,55,"Reporting Business Name"},
                {59,55,"Reporting Business Doing Business As Name"},
                {114,50,"Reporting Business Address"}
            return $recordDef
        }
        Write-Host "Details for Record type [$recordType] not currently available" -ForegroundColor Yellow
    }

}
