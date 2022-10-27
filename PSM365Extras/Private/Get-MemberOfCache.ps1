function Get-MemberOfCache {
    
    <#
	    .SYNOPSIS
	    Checks if cached CSV file for MemberOfMailbox exists.
        .DESCRIPTION
        Checks if cached CSV file for MemberOfMailbox exists.

        If not, create new cache file.

        Also checks how out of date cache is and replaces if necessary.

        Returns boolean
	    .EXAMPLE
        Get-MemberOfCache
	    .OUTPUTS
	    boolean
	#>

    $CachesDir = Get-CachesDir
    
    $MBXCachePath = "$CachesDir\MemberOfSMCache.csv"

    if(-not(Test-Path -Path $MBXCachePath -PathType Leaf)){
        try {
            [void](New-Item -ItemType File -Path $MBXCachePath -Force)
            Set-ItemProperty -Path $MBXCachePath -Name IsReadOnly -Value $true

            return $true
        }
        catch {
            throw $_.Exception.Message
            break
        }
    }
    Else{

        $lastWrite = (Get-Item $MBXCachePath).LastWriteTime
        $timespan = New-TimeSpan -Hours 6

        if(((Get-Date) - $lastWrite) -gt $timespan){
            Remove-Item $MBXCachePath -Force
            New-Item -ItemType File -Path $MBXCachePath -Force
            Set-ItemProperty -Path $MBXCachePath -Name IsReadOnly -Value $true
            return $true
        }
    }
    return $false
}