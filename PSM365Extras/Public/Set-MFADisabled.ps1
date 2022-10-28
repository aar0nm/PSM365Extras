function Set-MFADisabled {

    [CmdletBinding()]
    param (
        [Parameter(Mandatory, Position = 0)]
        [string]
        $email
    )

    Connect-MsolService
    
    $st = New-Object -TypeName Microsoft.Online.Administration.StrongAuthenticationRequirement 
    $st.RelyingParty = "*" 
    $st.State = "Disabled" 
    $sta = @($st)

    Set-MsolUser -UserPrincipalName $email -StrongAuthenticationRequirements $sta

    $a = Get-MsolUser -UserPrincipalName $email | Select-Object DisplayName,StrongAuthenticationRequirements
    $b = Get-MsolUser -UserPrincipalName $email | Select-Object UserPrincipalName -ExpandProperty StrongAuthenticationRequirements | Select-Object UserPrincipalName,State

    $a
    $b
}