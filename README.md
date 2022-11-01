# PSM365Extras
<img src="./PSM365Extras/icon.png" width="50%" height="50%">

A basic _**Pre-Release**_ PowerShell module that allows users to easily execute functions that are not normally available in the current management command sets.

Suggestions and comments are welcome on the repo discussion page, _**go easy on me!**_ This is the first time that I have touched upon any of the slightly more advanced features of PowerShell.

## Features

* Check what EXO Shared Mailboxes a specific user currently has permissions on.
    - Param to save results to CSV file.
    
* Enabling MFA on M365 Accounts.

* Enforcing MFA on M365 Accounts.

* Disabling MFA on M365 Accounts.

## Installation
### Nightly (GitHub)

**Currently the method with the latest changes, may also have the most bugs.**
1. Clone the GitHub repository to your local machine.

2. While using an elevated PowerShell instance navigate to where the repo clone is saved.

3. Import the module.

4. 
```PowerShell
cd C:/PSM365Extras/
```
5. 
```PowerShell
Import-Module ./PSM365Extras.psm1
```

### Pre-Release (PSGallery)

```PowerShell
Install-Module -Name PSM365Extras -AllowPrerelease
```

**A dialog asking to trust installation from unknown sources may appear.**

## Links

- [PSGallery Module](https://www.powershellgallery.com/packages/PSM365Extras)

## Authors

- [@aar0nm (Just me!)](https://www.github.com/aar0nm)


