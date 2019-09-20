<#
 .SYNOPSIS Clone a set of VMs to any number of teams for ccdc practice
 .NOTES
   Author: warecrash
#>
 
$vcenter = ""
$datastore = ""
$cluster = ""
$destdir = ""
$srcdir = ""
$nameconv = ""
$numteams = 8

Connect-VIServer -Server $vcenter -Protocol https

# Get-FolderByPath Credit: Luc Dekens http://www.lucd.info/2012/05/18/folder-by-path/
. .\Get-FolderByPath.ps1

$targetvms = Get-FolderByPath -Path $srcdir | Get-VM
for ($team=1; $team -le $numteams; $team++){
    foreach ($vm in $targetvms){
        $destpath = Get-FolderByPath -Path $($destdir+$nameconv+$team)
        $destvmname = $("T"+$team+"-"+$vm.name)
        New-VM -name $destvmname -vm $vm.name -Location $destpath -Datastore $datastore -ResourcePool $cluster -DiskStorageFormat thin
    }
}
