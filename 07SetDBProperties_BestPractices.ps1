$sqlservername = "DESKTOP-S25NQBT\VADIVEL2017ENT"
$sqlquery  = "SELECT name, is_auto_shrink_on, is_auto_close_on, is_auto_create_stats_on, is_auto_update_stats_on FROM sys.databases"
$dbs = Invoke-Sqlcmd -ServerInstance $sqlservername -Query $sqlquery

try
{
    Write-Host " Going to start reconfigure the SQL Settings as per best practices!"

    # Loop through the database properties
    foreach ($db in $dbs)
    {
        if ($db.is_auto_shrink_on -eq $true)
        {
            $sqlquery2 = "ALTER DATABASE " + $db.name + " SET AUTO_SHRINK OFF;"
            Invoke-SQLcmd -Query $sqlquery2 -ServerInstance $sqlservername -Database "master" 
        }
    }
}
Catch
{
      Write-Host "Error occurred while trying to reconfigure the SQL Settings. Please contact your admin!" -ForegroundColor Red
}