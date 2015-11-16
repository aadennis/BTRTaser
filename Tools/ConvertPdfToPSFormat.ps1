Clear-Host
#enums...
$columnName = [int] 1
$columnOffset = [int] 0
$columnLength = [int] 2
$recordDefinitionToConvert = 

# This line can be used to get it into the format below from the PDF table: [Get-Clipboard | % { "`"$_`","} | clip]
# place the FinCen formatted metadata below here
"1-2 	Record Type 	2 ",
"3-152 	Transmitter Name 	150 ",
"153-252 	Transmitter Address 	100 ",
"253-302 	Transmitter City 	50 ",
"303-305 	Transmitter State 	3 ",
"306-314 	Transmitter ZIP/Postal Code 	9 ",
"315-316 	Transmitter Country 	2 ",
"317-332 	Transmitter Telephone Number 	16 ",
"333-482 	Transmitter Contact Name 	150 ",
"483-507 	Transmitter Taxpayer Identification Number (TIN) 	25 ",
"508-515 	Coverage Beginning Date 	8 ",
"516-523 	Coverage Ending Date 	8 ",
"524-531 	Transmitter Control Code (TCC) 	8 ",
"532-534 	Batch Sequence Number (BSN) 	3 ",
"535-1186 	Filler 	652 ",
"1187-1190 	Format Indicator 	4 ",
"1191-1200 	User Field 	10 "
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

    


