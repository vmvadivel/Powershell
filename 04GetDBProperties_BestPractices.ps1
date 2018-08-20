$Success  = 1
$sqlservername = "DESKTOP-S25NQBT\VADIVEL2017ENT"
$sqlquery  = "SELECT name, is_auto_shrink_on, is_auto_close_on, is_auto_create_stats_on, is_auto_update_stats_on FROM sys.databases"

# Execute a query against the SQL Server instance
$dbs = Invoke-Sqlcmd -ServerInstance $sqlservername -Query $sqlquery

# Loop through the database properties
foreach ($db in $dbs)
{
    if ($db.is_auto_shrink_on -eq $true)
    {
        Write-Host "[Error] Database" $db.name "has Auto Shrink turned on" -ForegroundColor Red
        $Success = 0
    }
    if ($db.is_auto_close_on -eq $true)
    {
        Write-Host "[Error] Database" $db.name "has Auto Close turned on" -ForegroundColor Red
        $Success = 0
    }
    if ($db.is_auto_create_stats_on -eq $false)
    {
        Write-Host "[Error] Database" $db.name "has Auto Create Stats turned off" -ForegroundColor Red
        $Success = 0
    }
        if ($db.is_auto_update_stats_on -eq $false)
    {
        Write-Host "[Error] Database" $db.name "has Auto Update Stats turned off" -ForegroundColor Red
        $Success = 0
    }
}

if ($Success -eq 1)
{
    Write-Host "All Databases looks fine!!" -ForegroundColor Green
}