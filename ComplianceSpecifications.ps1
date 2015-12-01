$RAS = "RAS"
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
        if ($recordType -eq "2C") {
            $recordDef = 
                {1,2,"Record Type "},
                {3,10,"Branch or Office Location Code "},
                {13,1,"Part III Branch's Role in Transaction (Item 64) "},
                {14,100,"Part III Address of Branch or Office (Item 65) "},
                {114,50,"Part III Branch or Office City (Item 67) "},
                {164,3,"Part III Branch or Office State (Item 68) "},
                {167,9,"Part III Branch or Office ZIP/Postal Code (Item 69) "},
                {176,2,"Part III Branch or Office Country (Item 70) "},
                {178,20,"Part III Branch or Office RSSD Number (Item 66) "},
                {198,993,"Filler "},
                {1191,10,"User Field "}
            return $recordDef
        }

        if ($recordType -eq "3A") {
            $recordDef = 
                {1,2,"Record Type "},
                {3,5,"Transaction Sequence Number "},
                {8,1,"Attachment Indicator "},
                {9,1,"Type of Filing (Item 1) "},
                {10,1,"Continuing Activity Report (Item 1) "},
                {11,1,"Joint Report (Item 1) "},
                {12,14,"Prior Report Document Control Number/ BSA Identifier (Item 1) "},
                {26,15,"Amount Involved In This Report (Item 26) "},
                {41,1,"Amount Unknown or No Amount Involved (Item 26) "},
                {42,8,"Date or Date Range of Suspicious Activity - From (Item 27) "},
                {50,8,"Date or Date Range of Suspicious Activity - To (Item 27) "},
                {58,15,"Cumulative Amount (Item 28) "},
                {73,7,"Structuring (Item 29) "},
                {80,50,"Structuring - Other Description (Item 29) "},
                {130,2,"Terrorist Financing (Item 30) "},
                {132,50,"Terrorist Financing - Other Description (Item 30) "},
                {182,11,"Fraud (Item 31) "},
                {193,50,"Fraud - Other Description (Item 31) "},
                {243,5,"Casinos (Item 32) "},
                {248,50,"Casinos - Other Description (Item 32) "},
                {298,13,"Money Laundering (Item 33) "},
                {311,50,"Money Laundering - Other Description (Item 33) "},
                {361,6,"Identification / Documentation (Item 34) "},
                {367,50,"Identification / Documentation - Other Description (Item 34) "},
                {417,19,"Other Suspicious Activities (Item 35) "},
                {436,50,"Other Suspicious Activities - Other Description (Item 35) "},
                {486,7,"Insurance (Item 36) "},
                {493,50,"Insurance - Other Description (Item 36) "},
                {543,5,"Securities/Futures/Options (Item 37) "},
                {548,50,"Securities/Futures/Options - Other Description (Item 37) "},
                {598,5,"Mortgage Fraud (Item 38) "},
                {603,50,"Mortgage Fraud - Other Description (Item 38) "},
                {653,20,"Product Type(s) Involved (Item 39) "},
                {673,50,"Product Type(s) Involved- Other Description (Item 39) "},
                {723,10,"Instrument Type(s)/Payment Mechanism(s) Involved (Item 40) "},
                {733,50,"Instrument Type(s)/Payment Mechanism(s) Involved - Other Description (Item 40) "},
                {783,150,"LE Contact Agency (Item 92) "},
                {933,150,"LE Contact Name (Item 93) "},
                {1083,16,"LE Contact Telephone Number (Item 94) "},
                {1099,6,"LE Contact Telephone Extension (Item 94) "},
                {1105,8,"LE Contact Date (Item 95) "},
                {1113,10,"Filing Institution Contact Office (Item 96) "},
                {1123,16,"Filing Institution Phone Number (Item 97) "},
                {1139,6,"Filing Institution Phone Number Extension (Item 97) "},
                {1145,8,"Date Filed (Item 98) "},
                {1153,20,"Internal Control/ File Number (Item 91) "},
                {1173,18,"Filler "}
             return $recordDef
        }
        if ($recordType -eq "3B") {
            $recordDef = 
                {1,2,"Record Type "},
                {3,5,"Transaction Sequence Number "},
                {8,50,"Commodity Type (Item 41) "},
                {58,1133,"Filler "},
                {1191,10,"User Field "}
            return $recordDef
        }
        if ($recordType -eq "3C") {
            $recordDef = 
                {1,2,"Record Type "},
                {3,5,"Transaction Sequence Number "},
                {8,50,"Commodity Type (Item 42) "},
                {58,1133,"Filler "},
                {1191,10,"User Field "}
            return $recordDef
        }
        if ($recordType -eq "3D") {
            $recordDef = 
                {1,2,"Record Type "},
                {3,5,"Transaction Sequence Number "},
                {8,5,"Market Where Traded (Item 43) "},
                {13,1178,"Filler "},
                {1191,10,"User Field "}
            return $recordDef
        } 
        if ($recordType -eq "3E") {
            $recordDef = 
                {1,2,"Record Type "},
                {3,5,"Transaction Sequence Number "},
                {8,39,"IP Address (Item 44) "},
                {47,1144,"Filler "},
                {1191,10,"User Field "}
            return $recordDef
        }
        if ($recordType -eq "3F") {
            $recordDef = 
                {1,2,"Record Type "},
                {3,5,"Transaction Sequence Number "},
                {8,12,"CUSIP Number (Item 45) "},
                {20,1171,"Filler "},
                {1191,10,"User Field "}
            return $recordDef
        }
        if ($recordType -eq "4A") {
            $recordDef = 
                {1,2,"Record Type "},
                {3,5,"Transaction Sequence Number "},
                {8,1,"If Entity (Item 2a) "},
                {9,1,"If All Critical* Subject Information Is Unavailable (Item 2b) "},
                {10,150,"Individual's Last Name or Entity's Legal Name (Item 3) "},
                {160,1,"Individual's Last Name or Entity's Legal Name Unknown (Item 3) "},
                {161,35,"First Name (Item 4) "},
                {196,1,"First Name Unknown (Item 4) "},
                {197,35,"Middle Name or Middle Initial (Item 5) "},
                {232,35,"Suffix (Item 5) "},
                {267,1,"Gender (Item 5a) "},
                {268,30,"Occupation or Type of Business (Item 7) "},
                {298,6,"NAICS Code (Item 7) "},
                {304,25,"TIN (Item 13) "},
                {329,1,"TIN Unknown (Item 13) "},
                {330,1,"TIN Type (Item 14) "},
                {331,1,"Form of Identification for Subject Unknown (Item 15) "},
                {332,8,"Date of Birth (Item 16) "},
                {340,1,"Date of Birth Unknown (Item 16) "},
                {341,1,"Corroborative Statement to Filer? (Item 20) "},
                {342,1,"No Known Account Involved (Item 24) "},
                {343,1,"Subject Role in Suspicious Activity (Item 25) "},
                {344,847,"Filler "},
                {1191,10,"User Field "}
             return $recordDef
        }
        if ($recordType -eq "4B") {
            $recordDef = 
                {1,2,"Record Type "},
                {3,5,"Transaction Sequence Number "},
                {8,100,"Part I Address (Item 8) "},
                {108,1,"Part I Address Unknown (Item 8) "},
                {109,50,"Part I City (Item 9) "},
                {159,1,"Part I City Unknown (Item 9) "},
                {160,3,"Part I State (Item 10) "},
                {163,1,"Part I State Unknown (Item 10) "},
                {164,9,"Part I ZIP/Postal Code (Item 11) "},
                {173,1,"Part I ZIP/Postal Code Unknown (Item 11) "},
                {174,2,"Part I Country (Item 12) "},
                {176,1,"Part I Country Unknown (Item 12) "},
                {177,1014,"Filler "},
                {1191,10,"User Field "}
            return $recordDef
        }
        if ($recordType -eq "4C") {
            $recordDef = 
                {1,2,"Record Type "},
                {3,5,"Transaction Sequence Number "},
                {8,1,"Form of Identification - Type (Item 15) "},
                {9,24,"Form of Identification - Number (Item 15) "},
                {33,3,"Subject Identification Issuing State (Item 15) "},
                {36,2,"Subject Identification Issuing Country (Item 15) "},
                {38,50,"Subject Identification - Other (Item 15) "},
                {88,1103,"Filler "},
                {1191,10,"User Field "}
           return $recordDef
        }
        if ($recordType -eq "4D") {
            $recordDef = 
                {1,2,"Record Type "},
                {3,5,"Transaction Sequence Number "},
                {8,150,"Part I Alternate Name (Item 6) "},
                {158,1033,"Filler "},
                {1191,10,"User Field "}

           return $recordDef
        }
        if ($recordType -eq "4E") {
            $recordDef = 
                {1,2,"Record Type "},
                {3,5,"Transaction Sequence Number "},
                {8,1,"Part I Phone Number - Type (Item 17) "},
                {9,16,"Part I Phone Number (Item 18) "},
                {25,6,"Part I Phone Number Extension (Item 18) "},
                {31,1160,"Filler "},
                {1191,10,"User Field "}
           return $recordDef
        }
        if ($recordType -eq "4F") {
            $recordDef = 
                {1,2,"Record Type "},
                {3,5,"Transaction Sequence Number "},
                {8,50,"E-mail Address (Item 19) "},
                {58,1133,"Filler "},
                {1191,10,"User Field "}
           return $recordDef
        }
        if ($recordType -eq "4G") {
            $recordDef = 
                {1,2,"Record Type "},
                {3,5,"Transaction Sequence Number "},
                {8,517,"Website (URL) Address (Item 19) "},
                {525,666,"Filler "},
                {1191,10,"User Field "}
           return $recordDef
        }
        if ($recordType -eq "4H") {
            $recordDef = 
                {1,2,"Record Type "},
                {3,5,"Transaction Sequence Number "},
                {8,25,"Institution TIN (Item 21) "},
                {33,12,"Relationship of the Subject to an Institution (Item 21) "},
                {45,50,"Relationship of the Subject to an Institution - Other Description (Item 21) "},
                {95,1,"Status of Subject Relationship to Institution (Item 22) "},
                {96,8,"Action Date (Item 23) "},
                {104,1087,"Filler "},
                {1191,10,"User Field "}
            return $recordDef
        }
        if ($recordType -eq "4I") {
            $recordDef = 
                {1,2,"Record Type "},
                {3,5,"Transaction Sequence Number "},
                {8,1,"Non-US Financial Institution (Item 24) "},
                {9,25,"Financial Institution TIN and Account Number Related to Subject (Item 24) "},
                {34,40,"Financial Institution TIN and Account Number Related to Subject (Item 24) "},
                {74,1,"Account Closed - Yes (Item 24) "},
                {75,1116,"Filler "},
                {1191,10,"User Field "}
            return $recordDef
        }
        if ($recordType -eq "5A") {
            $recordDef = 
                {1,2,"Record Type "},
                {3,5,"Transaction Sequence Number "},
                {8,850,"Suspicious Activity Information - Narrative "},
                {858,333,"Filler "},
                {1191,10,"User Field "}
            return $recordDef
        }

        if ($recordType -eq "9A") {
            $recordDef = 
                {1,2,"Record Type "},
                {3,7,"Suspicious Activity Count (3A) "},
                {10,7,"Subject Count (4A) "},
                {17,7,"Narrative Description (5A) Count "},
                {24,7,"Branch Office Information (2C) Count "},
                {31,1160,"Filler "},
                {1191,10,"User Field "}
            return $recordDef
        }
        if ($recordType -eq "9B") {
            $recordDef = 
                {1,2,"Record Type "},
                {3,7,"Financial Institution Where Activity Occurred Count (2B) "},
                {10,7,"Suspicious Activity Count (3A) "},
                {17,7,"Subject Count (4A) "},
                {24,7,"Narrative Description (5A) Count "},
                {31,7,"Branch Office Information (2C) Count "},
                {38,1153,"Filler "},
                {1191,10,"User Field "}
                return $recordDef
        }
        if ($recordType -eq "9Z") {
            $recordDef = 
                {1,2,"Record Type "},
                {3,7,"Filing Institution Contact Information Count (2A) "},
                {10,7,"Financial Institution Where Activity Occurred Count (2B) "},
                {17,7,"Suspicious Activity Count (3A) "},
                {24,7,"Subject Count (4A) "},
                {31,7,"Narrative Description (5A) Count "},
                {38,7,"Branch Office Information (2C) Count "},
                {45,7,"Attachment Count "},
                {52,1139,"Filler "},
                {1191,10,"User Field "}              
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
