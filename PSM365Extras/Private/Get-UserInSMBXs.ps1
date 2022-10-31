function Get-UserInSMBXs {
    <#
	    .SYNOPSIS
	    Checks Mailbox for Certain users permissons.
        .DESCRIPTION
        Checks Mailbox for Certain users permissons.
	    .EXAMPLE
        Get-UserInSMBXs -Email <Email> -MBXs <System.Array>
	    .OUTPUTS
        pscustomobject
	#>

    [CmdletBinding()]
    param (
        [Parameter(Mandatory, Position = 0)]
        [alias("e")]
        [string]
        $email,

        # Parameter help description
        [Parameter(Mandatory, Position = 1)]
        [Alias("m")]
        [System.Array]
        $MBXs
    )
    
    $UserSMBXPerms = @()
    Clear-Host
    foreach ($MBX in $MBXs) {

        $i++
        Write-Progress -activity "Checking Mailboxes..." -status "Checked: $i of $($MBXs.Count)" -percentComplete (($i / $MBXs.Count)  * 100)
        
        $SMBXCheck = Get-MailboxPermission -Identity $MBX -User $email
        
        if ([string]::IsNullOrEmpty($SMBXCheck)) {} else {

            $UserSMBXPerms += [pscustomobject]@{
                MailboxName = $SMBXCheck.Identity
                MailboxAddress = $MBX
                User        = $SMBXCheck.User
                Permissions = $SMBXCheck.AccessRights
            }
        }
    }
    Clear-Host
    return $UserSMBXPerms
}