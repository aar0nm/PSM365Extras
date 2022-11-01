# PSM365Extras
<img src="./PSM365Extras/icon.png" width="50%" height="50%">

A basic _**Pre-Release**_ PowerShell module that allows users to easily execute functions that are not normally available in the current management command sets.

This is the first time that I have attempted to create PS module and there may be a few issues within the code! 

Suggestions and comments are welcome on the repo discussion page, _**go easy on me!**_ :metal:

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

3. Import the module:
    
    ```PowerShell
    cd **PathToClone**
    ```
    
    ---
    Example:
    
    ```PowerShell
    cd C:\PSM365Extras
    ```
    ---

    ```PowerShell
    Import-Module ./PSM365Extras.psm1
    ```

### Pre-Release (PSGallery)

```PowerShell
Install-Module -Name PSM365Extras -AllowPrerelease
```

**A dialog asking to trust installation from unknown sources may appear.**

## Usage
**List all shared mailboxes that a specific user has permissions for:**

```PowerShell
Get-MemberOfSMBXs -Email John.Smith@contoso.co.uk
```

**List all shared mailboxes that a specific user has permssions for and export the output to a auto generated CSV file in the path that is set:**
```PowerShell
Get-MemberOfSMBXs -Email John.Smith@contoso.co.uk -SaveToCSV C:\ExamplePath
```

_**More coming soon!**_


## Links

-  A link to the [PowerShell Gallery](https://www.powershellgallery.com/packages/PSM365Extras) package! 

## Authors

- [@aar0nm (Just me!)](https://www.github.com/aar0nm)


