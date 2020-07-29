# Microsoft 365 Update Immutable ID
## Scenario

Occasionally when trying to sync Windows AD with an existing Microsoft 365 tenant you will run into sync errors. One of them may look like this:

```sh
[{"Key":"ObjectId","Value":["677e2ead-14e8-4e18-9b25-49d5c75472f1"]},
{"Key":"ObjectIdInConflict","Value":["7505ed65-e7f5-4dca-9f78-2617a247f047"]},
{"Key":"AttributeConflictName","Value":["SipProxyAddress"]},
{"Key":"AttributeConflictValues","Value":["user@domain.com"]}]
```
This may be due to Immutable ID mismatch. This script will generate an Immutable ID based on user data in Windows AD and assign it to the same user in Microsoft 365. The script is simple and will produce the following output:
```sh
Generated ImmutableID: ABCdeFgHIJklmN0pqrS+uVw==
ImmutableID written to Office 365 User. Please confirm it matches generated ImmutableID

UserPrincipalName    ImmutableId              LastDirSyncTime
-----------------    -----------              ---------------
user@domain.com      ABCdeFgHIJklmN0pqrS+uVw==      
```

## Usage
### Without Parameters
```sh
PS C:\SomeFolder> .\updateImmutableId.ps1
```
Using the script without parameters will prompt you to input the UPN of the user and also prompt you for your Microsoft 365 admin credentials.

### With Parameters
```sh
PS C:\SomeFolder> .\updateImmutableId.ps1 -upn "user@domain.com" -Credentials $true|$false
```
__-upn__
String of the users UPN to avoid the prompt.

__-Credentials__
If set to false the script will not ask you for admin credentials. This is useful if you have already connected to Microsoft Online in Powershell.

# Requirements
In order to run this script you will need to have both MSOnline and ActiveDirectory modules installed. Additionally, this script must be run on server with access to Active Directory.

# More Information
After the script is executed successfully, you may need to do a Full Import or Full Synchronization manually in Azure AD Sync Services.