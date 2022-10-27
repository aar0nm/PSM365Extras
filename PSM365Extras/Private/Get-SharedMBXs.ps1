function Get-SharedMBXs{
    <#
	    .SYNOPSIS
	    Gets PrimarySmtpAddress of all Shared Mailboxes stored on Exchange Online server.
        .DESCRIPTION
        Gets PrimarySmtpAddress of all Shared Mailboxes stored on Exchange Online server.
	    .EXAMPLE
        Get-SharedMBXs
	    .OUTPUTS
        Syste.Array
	#>

    $MBXs = Get-EXOMailbox -RecipientTypeDetails SharedMailbox -ResultSize Unlimited | Select-Object PrimarySmtpAddress

    return $MBXs

}