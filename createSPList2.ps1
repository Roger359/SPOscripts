#Load SharePoint CSOM Assemblies
Add-Type -Path "C:\Program Files\Common Files\Microsoft Shared\Web Server Extensions\16\ISAPI\Microsoft.SharePoint.Client.dll"
Add-Type -Path "C:\Program Files\Common Files\Microsoft Shared\Web Server Extensions\16\ISAPI\Microsoft.SharePoint.Client.Runtime.dll"
  
#Variables for Processing
$SiteURL = "https://cpvenoffice365.sharepoint.com/sites/qhse"
$ListName="Entrenamientos5"
 
#Setup Credentials to connect
$Cred = Get-Credential
$Cred = New-Object Microsoft.SharePoint.Client.SharePointOnlineCredentials($Cred.UserName,$Cred.Password)
 
Try {
    #Setup the context
    $Ctx = New-Object Microsoft.SharePoint.Client.ClientContext($SiteURL)
    $Ctx.Credentials = $Cred
     
    #Get All Lists 
    $Lists = $Ctx.Web.Lists
    $Ctx.Load($Lists)
    $Ctx.ExecuteQuery()
 
    #Check if List doesn't exists already
    if(!($Lists.Title -contains $ListName))
    { 
        #sharepoint online powershell create list
        $ListInfo = New-Object Microsoft.SharePoint.Client.ListCreationInformation
        $ListInfo.Title = $ListName
        $ListInfo.TemplateType = 100 #Custom List
        $List = $Ctx.Web.Lists.Add($ListInfo)
        $List.Description = "Repository to store project artifacts"
        $List.Update()
        $Ctx.ExecuteQuery()
  
        write-host  -f Green "New List has been created!"
    }
    else
    {
        Write-Host -f Yellow "List '$ListName' already exists!"
    }
}
Catch {
    write-host -f Red "Error Creating List!" $_.Exception.Message
}