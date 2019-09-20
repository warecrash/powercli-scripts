<#
 .SYNOPSIS Clone a template to any number of teams for ccdc practice
 .NOTES
   Author: warecrash
#>
 
$vcenter = ""
$datastore = ""
$cluster = ""
$destdir = ""
$nameconv = ""
$template = ""
$basename = ""
$numteams = 8

Connect-VIServer -Server $vcenter -Protocol https

# Get-FolderByPath Credit: Luc Dekens http://www.lucd.info/2012/05/18/folder-by-path/
. .\Get-FolderByPath.ps1

for ($team=1; $team -le $numteams; $team++){
    $destpath = Get-FolderByPath -Path $($destdir+$nameconv+$team)
    $destvmname = $("T"+$team+"-"+$basename)
    New-VM -name $destvmname -Template $(Get-Template -Name $template).name -Location $destpath -Datastore $datastore -ResourcePool $cluster -DiskStorageFormat thin
}
