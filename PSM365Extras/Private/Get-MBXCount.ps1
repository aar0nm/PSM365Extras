function Get-MBXCount {
        <#
	    .SYNOPSIS
	    Counts through Mailboxes in MemberOfCache.csv
        .DESCRIPTION
        Counts through Mailboxes in MemberOfCache.csv

        Parameter to account for Titles in CSV file.

        Returns integer with the value of items in CSV file.

	    .EXAMPLE
        Get-MBXCount
        .EXAMPLE
        Get-MBXCount -titles
        .EXAMPLE
        Get-MBXCount -t

	    .OUTPUTS
	    Integer
	#>

    [CmdletBinding()]
    param (
        [Parameter(Position = 0)]
        [Alias("t")]
        [Switch]
        $titles
    )

    $CachesDir = Get-CachesDir
    Write-Verbose $CachesDir
    $MBXCachePath = "$CachesDir\MemberOfSMCache.csv"
    [int]$MBXCOUNT = 0
    $CSVREADER = New-Object IO.StreamReader $MBXCachePath
    if ($titles) {[void]($CSVREADER.ReadLine())}
    while($CSVREADER.ReadLine() -ne $null){$MBXCOUNT++}
    ($CSVREADER.Dispose())
    Write-Verbose $MBXCOUNT
    return $MBXCOUNT
}