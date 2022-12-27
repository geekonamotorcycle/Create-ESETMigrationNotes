# Import CSV with company Details
$CompanyList = Import-Csv -Path .\MigrationList.csv;
# Build String variable
for ($i = 0; $i -lt $CompanyList.Count; $i++) {
    
    # Dynamic Workstation Type Group
    $WorkstationGroup = $CompanyList[$i].company + " - Workstations";
    $WorkstationGroupNotActivated = $CompanyList[$i].company + " - Workstations - Not Activated";
    $WorkstationGroupNoSecurityProductInstalled = $CompanyList[$i].company + " - Workstations - No Security Product Installed";
    $WorkstationGroupIncorrectLicense = $CompanyList[$i].company + " - Workstations - Incorrect License";
    # Dynamic Server Group Info        
    $ServerGroup = $CompanyList[$i].company + " - Server";
    $ServerGroupNotActivated = $CompanyList[$i].company + " - Server - Not Activated";
    $ServerGroupNoSecurityProductInstalled = $CompanyList[$i].company + " - Server - No Security Product Installed";
    $ServerGroupIncorrectLicense = $CompanyList[$i].company + " - Server - Incorrect License";
    # Dynamic Mac group
    $MacGroup = $CompanyList[$i].company + " - MacOS";
    $MacGroupNotActivated = $CompanyList[$i].company + " - MacOS - Not Activated";
    $MacGroupNoSecurityProductInstalled = $CompanyList[$i].company + " - MacOS - No Security Product Installed";
    $MacGroupIncorrectLicense = $CompanyList[$i].company + " - MacOS - Incorrect License";
    # Policy Items
    $BasePolicy = "DO NOT REMOVE - " + $CompanyList[$i].company + " - Base Policy";
    $AutoUpdate = $CompanyList[$i].company + " - Auto Update";
    $WorkstationPolicy = $CompanyList[$i].company + " - Antivirus - Balanced (Workstations)";
    $ServerPolicy = $CompanyList[$i].company + " - Antivirus - Maximum security - Recommended (Servers)";
    $MacPolicy = $CompanyList[$i].company + " - Antivirus - Maximum security - Recommended (MacOS)";
    # Tasks
    $ActivateWorkstations = $CompanyList[$i].company + " - Activate Workstations";
    $InstallWorkstations = $CompanyList[$i].company + " - Install Endpoint Security (Workstations)";
    $ActivateServer = $CompanyList[$i].company + " - Activate Servers";
    $InstallServer = $CompanyList[$i].company + " - Install Endpoint Security (Server)";
    $ActivateMac = $CompanyList[$i].company + " - Activate MacOS";
    $InstallMac = $CompanyList[$i].company + " - Install Endpoint Security (MacOS)";
    
    $CompanyName = $CompanyList[$i].company;
    $CompanyAddress = $CompanyList[$i].address;
    $EsetWorkstations = $CompanyList[$i].Workstation;
    $EsetServer = $CompanyList[$i].Server;
    $EsetMacOs = $CompanyList[$i].mac;
    $ManageCompanyCode = $CompanyList[$i].CompanyCode;
    $Markdown = "    
# Company Info
 
Company name: 
$CompanyName
 
Email: 
support@summitbiztech.com
 
Company Address:  
$CompanyAddress
 
Manage Company Code: 
$ManageCompanyCode
 
ESET ENDPOINT-Workstation (Monthly): $EsetWorkstations
ESET ENDPOINT-Server (Monthly):  $EsetServer
ESET ENDPOINT- MAC Workstation (Monthly): $EsetMacOs
 
## Action
 
-   Created Client in MSP Portal
-   Added Licenses to MSP Client
-   Removed licenses from Summit Tennant
-   Imported to ESET Protect
-   Created the following Dynamic Groups
-   Imported Licenses into DEM
-   Updated DEM installer package
-   Deactivated all $CompanyName Machines under Summit License
-   Moved All of $CompanyName to the MSP admin
-   Activated machines
 
### Dynamic Groups
 
$WorkstationGroup
Operating system is MS Windows (Client)
 
$WorkstationGroupNotActivated
Not activated security product
 
$WorkstationGroupIncorrectLicense
Activated with Summit Workstation License
  
$WorkstationGroupNoSecurityProductInstalled
No manageable security product installed

$MacGroup
Operating system is MacOS (Client)
 
$MacGroupNotActivated
Not activated security product
 
$MacGroupNoSecurityProductInstalled
No manageable security product installed
 
$MacGroupIncorrectLicense
Activated with Summit MacOS License
 
$ServerGroup
Operating system is MS Windows (Server)
  
$ServerGroupNotActivated
Not activated security product
  
$ServerGroupNoSecurityProductInstalled
No manageable security product installed
  
$ServerGroupIncorrectLicense
Activated with Summit Server License
 
### Policy Creation and Assignment
 
$BasePolicy
Root of $CompanyName
 
$AutoUpdate
Root of $CompanyName
 
$WorkstationPolicy
$CompanyName - Workstations
 
$ServerPolicy
$CompanyName - Servers
 
$MacPolicy
$CompanyName - MacOS

### Task Creation and Assignment 
 
$ActivateWorkstations
$CompanyName - Workstations - Not Activated
 
$InstallWorkstations
$CompanyName - Workstations - No Security Product Installed
 
$ActivateServer
$CompanyName - Servers - Not Activated
 
$InstallServer
$CompanyName - Servers - No Security Product Installed
 
$ActivateMac
$CompanyName - MacOS - Not Activated
 
$InstallMac
$CompanyName - MacOS - No Security Product Installed
"
# Export Block
$Filename = $CompanyName + " - Eset License Migration.md";
$localPath = Get-Location;
$BaseCSVPath = join-path -Path $localPath.Path -ChildPath "Unprocessed";
$MDPathFullPath = join-path -Path $BaseCSVPath -ChildPath $Filename;
# Test for and maybe Create Destnation
if (!(test-path -Path  $BaseCSVPath)) {
    New-Item -Path $BaseCSVPath -ItemType Directory;
}
$Markdown | Out-File -FilePath $MDPathFullPath -Verbose
}
