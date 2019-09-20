<#
 .SYNOPSIS Clone a set red team VMs for ccdc practice
 .NOTES
   Author: warecrash
#>
 
$vcenter = ""
$datastore = ""
$cluster = ""
$destdir = ""
$template = ""
$numteams = 8

Connect-VIServer -Server $vcenter -Protocol https

# Get-FolderByPath Credit: Luc Dekens http://www.lucd.info/2012/05/18/folder-by-path/
. .\Get-FolderByPath.ps1

$destpath = Get-FolderByPath -Path $($destdir+"Red Team")
for ($redteamer=1; $redteamer -le $numteams; $redteamer++) {
    $destvmname = $("RT0"+$redteamer)
    New-VM -name $destvmname -Template $(Get-Template -Name $template).name -Location $destpath -Datastore $datastore -ResourcePool $cluster -DiskStorageFormat thin
}
