function Get-MemberOfSMBXs {

    <#
	    .SYNOPSIS
	    Checks all Exchange Online shared mailboxes for a specific defined user with permissions to that mailbox. Returns an object with details of shared mailbox and user.
        .DESCRIPTION
        Cmdlet is for Exchange online only.
	    .PARAMETER Email
	    The Email Address of the user you want to search.
        .PARAMETER Name
        The Name of the user you want to search.
        .Parameter SaveToCSV
        (OPTIONAL) The absolute path where you would like CSV to be exported to. Must be path and not file.
	    .EXAMPLE
	    Get-MemberOfSMBXs John.Smith@contoso.co.uk
        .EXAMPLE
        Get-MemberOfSMBXs -Email John.Smith@contoso.co.uk
        .EXAMPLE
        Get-MemberOfSMBXs -Email John.Smith@contoso.co.uk -SaveToCSV C:\Folder
        .EXAMPLE
        Get-MemberOfSMBXs -Email John.Smith@contoso.co.uk -Path C:\Folder
	    .INPUTS
	    System.String
	    .OUTPUTS
	    PSCustomObject
        .AUTHOR
        Aaron Mennitto
	#>

    [CmdletBinding()]
    param(
        [Parameter(Mandatory, Position = 0)]
        [alias("e")]
        [string]$Email,

        [Parameter(Position = 1)]
        [alias("Path")]
        [ValidateScript({
                if ( -Not ($_ | Test-Path)) {
                    throw "File or folder does not exist!"
                }
                if ( -Not ($_ | Test-Path -PathType container)) {
                    throw "The Path argument must be a folder. File paths are not allowed!"
                }
                return $true
        
            })]
        [System.IO.FileInfo]$SaveToCSV
              
    )
    
    $ErrorActionPreference = "Stop"
    $CachesDir = Get-CachesDir
    $MBXCachePath = "$CachesDir\MemberOfSMCache.csv"
    
    $Elevated = ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
    #$username = $Email.Split('@')[0]

    if ( -not $Elevated ) {
        throw "This module requires elevation."
    }

    Import-Module ExchangeOnlineManagement   

    Connect-ExchangeOnline -ShowBanner:$false

    try {

        Get-User $Email -wa Stop -ea Stop
    }
    catch {
        Write-Error "[$($_.Exception.GetType().FullName)] - $($_.Exception.Message)"
        break
    }

    try {
        Get-MemberOfCache
    }
    catch {
        Write-Error "$($_.Exception.Message)"
        break
    }


    $cache = Set-MBXsCache

    if($cache){
        $MBXs = @(Import-Csv $MBXCachePath)
    }
    
    $userperms = Get-UserInSMBXs -Email $email -MBXs $MBXs.PrimarySmtpAddress

    Clear-Host

    Write-Host "Complete! Results Below!"

    $userperms | Format-List

    # if ($SaveToCSV -ne $null) {
    
    
    #     $date = Get-Date -Format "HH-mm-ss(dd-MM-yyyy)"
    #     $join = ($date, "-", $username, ".csv")

    #     $filename = -Join $join
    #     $csvpath = Join-Path -Path $SaveToCSV -ChildPath $filename

    #     Write-Host "********************************************************************************"
    #     Write-Host "Saving to..." $csvpath
    #     Write-Host "********************************************************************************"

    
    #     New-Item -ItemType File -Path $csvpath -Force
    #     $userperms | Export-CSV -Path $csvpath -NoTypeInformation -Force

    # } 

    pause
 
}
   

