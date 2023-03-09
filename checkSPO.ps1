

#Check if SharePoint Online PowerShell module has been installed
Try {
    Write-host "Checking if SharePoint Online PowerShell Module is Installed..." -f Yellow -NoNewline
    $SharePointOnlineModule = Get-Module -ListAvailable "Microsoft.Online.SharePoint.PowerShell"
 
    #Check if SharePoint Online Module is installed
    If(!$SharePointOnlineModule)
    {
        Write-host "No!" -f Green
 
        #Check if script is executed under elevated user permissions - Run as Administrator
        If (-NOT ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator"))
        {   
            Write-Host "Please Run this script in elevated mode (Run as Administrator)! " -NoNewline
            Read-Host "Press any key to continue"
            Exit
        }
 
        Write-host "Installing SharePoint Online PowerShell Module..." -f Yellow -NoNewline
        Install-Module "Microsoft.Online.SharePoint.PowerShell" -Force -Confirm:$False
        Write-host "Done!" -f Green
    }
    Else
    {
        Write-host "Yes!" -f Green
        #sharepoint online powershell module import
        Write-host "Importing SharePoint Online PowerShell Module..." -f Yellow  -NoNewline
        Import-Module "Microsoft.Online.SharePoint.PowerShell" -DisableNameChecking
        Write-host "Done!" -f Green
    }
}
Catch{
    write-host "Error: $($_.Exception.Message)" -foregroundcolor red
}