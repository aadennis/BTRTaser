Clear-Host
#enums...
$columnName = [int] 1
$columnOffset = [int] 0
$columnLength = [int] 2
$x = 
"1-2 	Record Type 	2 ",
"3-7 	Transaction Location Code 	5 ",
"8 	Multiple Transaction Locations (Item 22) 	1 ",
"9 	Type of Business Location (Item 23) 	1 ",
"10-64 	Transaction Location Legal Name (Item 24) 	55 ",
"65-119 	Doing Business As Name (Item 25) 	55 ",
"120-169 	Transaction Location Permanent Address ()Item 26) 	50 ",
"170-194 	Transaction Location City (Item 27) 	25 ",
"195-196 	Transaction Location State (Item 28) 	2 ",
"197-205 	Transaction Location ZIP Code (Item 29) 	9 ",
"206-207 	Transaction Location Country (Item 32) 	2 ",
"208-216 	Transaction Location EIN or SSN/ITIN (individual) (Item 30) 	9 ",
"217-226 	Transaction Location Business Phone Number (Item 31) 	10 "

$x.Count

$y = ($x | % {  $_ -split "\t" })

$y

$y.Count

$count = 0
$recordToPrint = New-Object string[] 3

$y | % {

    
    $currentIndexType = $count%3
    if ($currentIndexType -eq $columnName) {
        $recordToPrint[2] = "`"$_`"},"
       
    }
    if ($currentIndexType -eq $columnLength) {
        $a = [int] $_
        $recordToPrint[1] = "$a,"
        $formattedRecord = $recordToPrint -join ""
        Write-Host $formattedRecord
    }
    if ($currentIndexType -eq $columnOffset) {
        $location = $_.indexOf("-")

        if ($location -eq -1) {
            $x = [int] $_
        } else {
            $x = [int] $_.substring(0,$location)
        }
        $recordToPrint[0] = "{$x,"
    }
    $count++
}

    


