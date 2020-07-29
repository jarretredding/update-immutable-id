param(
    [string]$upn = $(Read-Host 'Enter UPN'),
    [bool]$Credentials = $true
)

Import-Module MSOnline
Import-Module ActiveDirectory

try{

    if($Credentials -eq $true){

        $Credential = Get-Credential
        Connect-MsolService -Credential $Credential

    }

    $GUID = (Get-ADUser -Filter {UserPrincipalName -eq $upn}).ObjectGUID 
    $ImmutableID = [System.Convert]::ToBase64String($GUID.tobytearray())

    Write-Host "Generated ImmutableID:" $ImmutableID

    Set-MSOLuser -UserPrincipalName $upn -ImmutableID $immutableID

    Write-Host "ImmutableID written to Office 365 User. Please confirm it matches generated ImmutableID"

    Get-MsolUser -UserPrincipalName $upn | ft UserPrincipalName,immutableid,lastdirsync*

} catch {

    Write-Host $_.Exception.Message -ForegroundColor Red -BackgroundColor Black

}