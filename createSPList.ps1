#Load SharePoint CSOM Assemblies
Add-Type -Path "C:\Program Files\Common Files\Microsoft Shared\Web Server Extensions\16\ISAPI\Microsoft.SharePoint.Client.dll"
Add-Type -Path "C:\Program Files\Common Files\Microsoft Shared\Web Server Extensions\16\ISAPI\Microsoft.SharePoint.Client.Runtime.dll"
  
#Variables for Processing
$SiteURL = "https://cpvenoffice365.sharepoint.com/sites/qhse"
$ListName="Entrenamientos"
 
#Get Credentials to connect
$Cred = Get-Credential
 
#Setup the context
$Ctx = New-Object Microsoft.SharePoint.Client.ClientContext($SiteURL)
$Ctx.Credentials = New-Object Microsoft.SharePoint.Client.SharePointOnlineCredentials($Cred.UserName,$Cred.Password)
     
#Create a custom list in sharepoint online using powershell
$ListCreationInfo = New-Object Microsoft.SharePoint.Client.ListCreationInformation
$ListCreationInfo.Title = $ListName
$ListCreationInfo.TemplateType = 100
$List = $Ctx.Web.Lists.Add($ListCreationInfo)
$List.Description = "Projects List"
$List.Update()
$Ctx.ExecuteQuery()