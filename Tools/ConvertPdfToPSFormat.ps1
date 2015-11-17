Clear-Host
#enums...
$columnName = [int] 1
$columnOffset = [int] 0
$columnLength = [int] 2
$recordDefinitionToConvert = 

# This line can be used to get it into the format below from the PDF table: [Get-Clipboard | % { "`"$_`","} | clip]
# place the FinCen formatted metadata below here
"1-2 	Record Type 	2 ",
"3-9 	Filing Institution Contact Information Count (2A) 	7 ",
"10-16 	Financial Institution Where Activity Occurred Count (2B) 	7 ",
"17-23 	Suspicious Activity Count (3A) 	7 ",
"24-30 	Subject Count (4A) 	7 ",
"31-37 	Narrative Description (5A) Count 	7 ",
"38-44 	Branch Office Information (2C) Count 	7 ",
"45-51 	Attachment Count 	7 ",
"52-1190 	Filler 	1139 ",
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

    


