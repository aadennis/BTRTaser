﻿$RAS = "RAS"
$BTR = "BTR"


<#
.Synopsis 
  Fincen Compliance specification metadata rules 
.Description 
. Example 
  Get-ComplianceRecordDefinition $recordType $fileType
#>
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
                {1,2,"Record Type "},
                {3,150,"Transmitter Name "},
                {153,100,"Transmitter Address "},
                {253,50,"Transmitter City "},
                {303,3,"Transmitter State "},
                {306,9,"Transmitter ZIP/Postal Code "},
                {315,2,"Transmitter Country "},
                {317,16,"Transmitter Telephone Number "},
                {333,150,"Transmitter Contact Name "},
                {483,25,"Transmitter Taxpayer Identification Number (TIN) "},
                {508,8,"Coverage Beginning Date "},
                {516,8,"Coverage Ending Date "},
                {524,8,"Transmitter Control Code (TCC) "},
                {532,3,"Batch Sequence Number (BSN) "},
                {535,652,"Filler "},
                {1187,4,"Format Indicator "},
                {1191,10,"User Field "}
            return $recordDef
        }
        if ($recordType -eq "2A") {
            $recordDef = 
                {1,2,"Record Type"},
                {3,1,"Reporting Business same..."},
                {4,55,"Reporting Business Name"},
                {59,55,"Reporting Business Doing Business As Name"},
                {114,50,"Reporting Business Address"},
                {164,25,"Reporting Business City"},
                {189,2,"Reporting Business State"},
                {191,9,"Reporting Business ZIP Code (Item 40)"},
                {200,2,"Reporting Business Country (Item 43) "},
                {202,9,"Reporting Business EIN or SSN/ITIN (Individual)"},
                {211,10,"Reporting Business Phone number (Item 42)"},
                {221,22,"Internal File/Report Number (Item 44)"},
                {243,228,"Filler"},
                {471,10,"User Field"}
            return $recordDef
        }
        if ($recordType -eq "2B") {
            $recordDef = 
                {1,2,"Record Type"},
                {3,7,"Transaction Location Code"},
                {8,1,"Multiple Transaction Locations (Item 22)"},
                {9,1,"Type of Business Location (Item 23)"},
                {10,55,"Transaction Location Legal Name (Item 24)"},
                {65,55,"Doing Business As Name (Item 25)"},
                {120,50,"Transaction Location Permanent Address (Item 26)"},
                {170,25,"Transaction Location City (Item 27)"},
                {195,2,"Transaction Location State (Item 28) "},
                {197,9,"Transaction Location ZIP Code (Item 29)"},
                {206,2,"Transaction Location Country (Item 32)"},
                {208,9,"Transaction Location EIN or SSN/ITIN (Individual) (Item 30)"},
                {217,10,"Transaction Location Business Phone Number (Item 31)"},
                {227,22,"Internal File/Report Number"},
                {249,222,"Filler"},
                {471,10,"User Field"}
            return $recordDef
        }
        Write-Host "Details for Record type [$recordType] not currently available" -ForegroundColor Yellow
    }
}

function Get-ComplianceRecordSize ($recordType, $fileType) {
    $lastColumn = (Get-ComplianceRecordDefinition $recordType $fileType)[-1]
    $lastColumnParts = $lastColumn -split ","
    $offSet = $lastColumnParts[0]
    $columnLength = $lastColumnParts[1]
    $recordSize = [int] $offSet + $columnLength - 1
    return $recordSize 
}
