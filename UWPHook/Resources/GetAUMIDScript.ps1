$installedapps = get-AppxPackage
$invalidNames = '*ms-resource*', '*DisplayName*'
$aumidList = @()

foreach ($app in $installedapps)
{
    try {
            if(-not $app.IsFramework){
            foreach ($id in (Get-AppxPackageManifest $app).package.applications.application.id)
            {
                    $appx = Get-AppxPackageManifest $app;
                    $name = $appx.Package.Properties.DisplayName;

                    if($name -like '*DisplayName*' -or $name  -like '*ms-resource*')
                    {
                        $name = $appx.Package.Applications.Application.VisualElements.DisplayName;
                        
                    # comment out below chunk and uncomment further below bit for original code
                        $logo = $app.InstallLocation + "\" + $appx.Package.Applications.Application.VisualElements.Square150x150Logo;

                        $aumidList += $name + "|" + $logo + "|" +
                        $app.packagefamilyname + "!" + $id+ ";"
                    }
                    # comment out ending here

#                   Original code
#                     }
#                     if(-not ($name -like '*DisplayName*' -or $name  -like '*ms-resource*'))
#                     {
#                         $name = "App name not found, double click here to edit it";
#                     }

#                     $logo = $app.InstallLocation + "\" + $appx.Package.Applications.Application.VisualElements.Square150x150Logo;

#                     $aumidList += $name + "|" + $logo + "|" +
#                     $app.packagefamilyname + "!" + $id+ ";"
                }
            }
        }
        catch
        {
            $ErrorMessage = $_.Exception.Message
            $FailedItem = $_.Exception.ItemName
        }
}

$aumidList;
