#Import PowerShell module for SharePoint Online 
Import-Module Microsoft.Online.Sharepoint.PowerShell -DisableNameChecking
 
#Connect to SharePoint Online
Connect-SPOService -url "https://cpvenoffice365-admin.sharepoint.com" -Credential (Get-Credential)
 
#Get All SharePoint Sites
Get-SPOSite