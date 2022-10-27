
function Get-MBXCachePath {
    $CachesDir = Get-CachesDir
    $MBXCP = "$CachesDir\MemberOfSMCache.csv"

    return $MBXCP
}

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
    $MBXCachePath = Get-MBXCachePath

    if(-not(Test-Path -Path $MBXCachePath -PathType Leaf)){
        try {
            [void](New-Item -ItemType File -Path $MBXCachePath -Force)
            Set-ItemProperty -Path $MBXCachePath -Name IsReadOnly -Value $true

            return
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
            return
        }
    }
    
}

function Set-MemberOfCache {

    [CmdletBinding()]
    param (
        [Parameter(Mandatory,ValueFromPipeline)]
        [System.Array]
        $MBXs
    )
    $MBXCachePath = Get-MBXCachePath
    try {
        $MBXs | Export-Csv -Path $MBXCachePath -NoTypeInformation -Force
        return
    }
    catch {
        Write-Error "[$($_.Exception.GetType().FullName)] - $($_.Exception.Message)"
        break
    }
    

}

function Set-MBXsCache {

    $importMBXs = Get-MBXCount

    if ($importMBXs -gt 0) {
        return $true
    }
    elseif ($importMBXs -le 0) {

        $MBXs = Get-SharedMBXs

        Set-MemberOfCache -MBXs $MBXs

        return $true
        
        
    }
    
}