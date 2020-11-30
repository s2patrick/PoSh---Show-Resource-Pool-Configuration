
# load the SCOM module
import-module operationsmanager

# get all resource pools
$rps = Get-SCOMResourcePool

# show every resource pool and its members
foreach ($rp in $rps) {
    "-"*50
    $rp.displayname
    write-host "isDynamic:" $rp.IsDynamic
    write-host "Observers:" $rp.Observers
    write-host "UseDefaultObserver:" $rp.UseDefaultObserver
    write-host "Members:"
    ($rp.Members).displayname
    if ($rp.members.count -eq 1) {
        Write-Host "There only 1 member in your pool." -ForegroundColor Red
        Write-Host "The pool is not high available since it contains only 1 GW." -ForegroundColor Red
    }
    if ($rp.members.count -eq 2) {
        Write-Host "There are 2 members in your pool." -ForegroundColor Yellow
        if ($rp.Observers) {
            Write-Host "The pool is high available since Observer has been configured." -ForegroundColor Green
        } else {
            Write-Host "The pool is not high available since it contains only 2 GWs." -ForegroundColor Red
        }
    }
}
