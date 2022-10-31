
function Get-MBXCachePath {
    $CachesDir = Get-CachesDir
    $MBXCP = "$CachesDir\f8b1494d-e56b-4ec0-9c88-6bc232c54ed5.tmp"

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
    $timespan = New-TimeSpan -Hours 6

    if (-not(Test-Path -Path $MBXCachePath -PathType Leaf)) {
        Write-Host "File not found..."
        try {
            [void](New-Item -ItemType File -Path $MBXCachePath -Force)
            Set-ItemProperty -Path $MBXCachePath -Name IsReadOnly -Value $true
            Write-Host "Creating new cache.. (This run may take longer than usual!)"
            return $true
        }
        catch {
            throw $_.Exception.Message
            break
        }
    }
    else{}
    $lastWrite = (Get-Item $MBXCachePath).LastWriteTime
    if (((Get-Date) - $lastWrite) -gt $timespan) {
        Write-Host "Cache is out of date..."        
        try {

            Remove-Item $MBXCachePath -Force
            New-Item -ItemType File -Path $MBXCachePath -Force
            Set-ItemProperty -Path $MBXCachePath -Name IsReadOnly -Value $true
            Write-Host "Creating new cache.. (This run may take longer than usual!)"
            return $true
        }
        catch {
            throw $_.Exception.Message
            break
        }

    }
    else{}

    if ((Get-MBXCount) -le 0) {
        Write-Host "Cache is empty..."
        try {

            Remove-Item $MBXCachePath -Force
            New-Item -ItemType File -Path $MBXCachePath -Force
            Set-ItemProperty -Path $MBXCachePath -Name IsReadOnly -Value $true
            Write-Host "Creating new cache.. (This run may take longer than usual!)"
            return $true
        }
        catch {
            throw $_.Exception.Message
            break
        }

    }
    else{
        return $false
    }

}


function Set-MemberOfCache {

    [CmdletBinding()]
    param (
        [Parameter(Mandatory, ValueFromPipeline)]
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
