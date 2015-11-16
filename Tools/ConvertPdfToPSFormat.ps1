Clear-Host
#enums...
$columnName = [int] 1
$columnOffset = [int] 0
$columnLength = [int] 2
$recordDefinitionToConvert = 

# This line can be used to get it into the format below from the PDF table: [Get-Clipboard | % { "`"$_`","} | clip]
# place the FinCen formatted metadata below here
"1-2 	Record Type 	2 ",
"3-7 	Transaction Sequence Number 	5 ",
"8 	Attachment Indicator 	1 ",
"9 	Type of Filing (Item 1) 	1 ",
"10 	Continuing Activity Report (Item 1) 	1 ",
"11 	Joint Report (Item 1) 	1 ",
"12-25 	Prior Report Document Control Number/ BSA Identifier (Item 1) 	14 ",
"26-40 	Amount Involved In This Report (Item 26) 	15 ",
"41 	Amount Unknown or No Amount Involved (Item 26) 	1 ",
"42-49 	Date or Date Range of Suspicious Activity - From (Item 27) 	8 ",
"50-57 	Date or Date Range of Suspicious Activity - To (Item 27) 	8 ",
"58-72 	Cumulative Amount (Item 28) 	15 ",
"73-79 	Structuring (Item 29) 	7 ",
"80-129 	Structuring - Other Description (Item 29) 	50 ",
"130-131 	Terrorist Financing (Item 30) 	2 ",
"132-181 	Terrorist Financing - Other Description (Item 30) 	50 ",
"182-192 	Fraud (Item 31) 	11 ",
"193-242 	Fraud - Other Description (Item 31) 	50 ",
"243-247 	Casinos (Item 32) 	5 ",
"248-297 	Casinos - Other Description (Item 32) 	50 ",
"298-310 	Money Laundering (Item 33) 	13 ",
"311-360 	Money Laundering - Other Description (Item 33) 	50 ",
"361-366 	Identification / Documentation (Item 34) 	6 ",
"367-416 	Identification / Documentation - Other Description (Item 34) 	50 ",
"417-435 	Other Suspicious Activities (Item 35) 	19 ",
"436-485 	Other Suspicious Activities - Other Description (Item 35) 	50 ",
"486-492 	Insurance (Item 36) 	7 ",
"493-542 	Insurance - Other Description (Item 36) 	50 ",
"543-547 	Securities/Futures/Options (Item 37) 	5 ",
"548-597 	Securities/Futures/Options - Other Description (Item 37) 	50 ",
"598-602 	Mortgage Fraud (Item 38) 	5 ",
"603-652 	Mortgage Fraud - Other Description (Item 38) 	50 ",
"653-672 	Product Type(s) Involved (Item 39) 	20 ",
"673-722 	Product Type(s) Involved- Other Description (Item 39) 	50 ",
"723-732 	Instrument Type(s)/Payment Mechanism(s) Involved (Item 40) 	10 ",
"733-782 	Instrument Type(s)/Payment Mechanism(s) Involved - Other Description (Item 40) 	50 ",
"783-932 	LE Contact Agency (Item 92) 	150 ",
"933-1082 	LE Contact Name (Item 93) 	150 ",
"1083-1098 	LE Contact Telephone Number (Item 94) 	16 ",
"1099-1104 	LE Contact Telephone Extension (Item 94) 	6 ",
"1105-1112 	LE Contact Date (Item 95) 	8 ",
"1113-1122 	Filing Institution Contact Office (Item 96) 	10 ",
"1123-1138 	Filing Institution Phone Number (Item 97) 	16 ",
"1139-1144 	Filing Institution Phone Number Extension (Item 97) 	6 ",
"1145-1152 	Date Filed (Item 98) 	8 ",
"1153-1172 	Internal Control/ File Number (Item 91) 	20 ",
"1173-1190 	Filler 	18 "
# place the FinCen formatted metadata above here

#$recordDefinitionToConvert.Count
$recordDefinitionAsSplitArray = ($recordDefinitionToConvert | % {  $_ -split "\t" })
#$recordDefinitionAsSplitArray
#$recordDefinitionAsSplitArray.Count
$loopCount = 0
$recordToPrint = New-Object string[] 3

$recordDefinitionAsSplitArray | % {
    $currentIndexType = $loopCount%3

    if ($currentIndexType -eq $columnOffset) {
    $location = $_.indexOf("-")

    if ($location -eq -1) {
        $xl = [int] $_
    } else {
        $xl = [int] $_.substring(0,$location)
    }
    $recordToPrint[0] = "{$xl,"
    }
    if ($currentIndexType -eq $columnName) {
        $recordToPrint[2] = "`"$_`"},"
    }
    if ($currentIndexType -eq $columnLength) {
        $a = [int] $_
        $recordToPrint[1] = "$a,"
        $formattedRecord = $recordToPrint -join ""
        Write-Host $formattedRecord
    }
    $loopCount++
}

    


