<#
 .SYNOPSIS Set correct port groups for newly created VMs
 .NOTES
   Author: warecrash
#>
 
$vcenter = ""
$destdir = ""
$srcdir = ""
$nameconv = ""
$portgroupconv = ""
$numteams = 8

Connect-VIServer -Server $vcenter -Protocol https

# Get-FolderByPath Credit: Luc Dekens http://www.lucd.info/2012/05/18/folder-by-path/
. .\Get-FolderByPath.ps1


for ($team=1; $team -le $numteams; $team++){
    $targetvms = Get-FolderByPath -Path $($srcdir+$destdir+$nameconv+$team) | Get-VM
    $targetportgroup = Get-VDPortgroup -Name $($portgroupconv+$team+"A")
    foreach ($vm in $targetvms){
        Get-VM $vm | Get-NetworkAdapter | Set-NetworkAdapter -Portgroup $targetportgroup
    }
}
