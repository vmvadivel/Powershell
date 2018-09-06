clear

$sqlservername = "YourServerName"
$sqlquery  = "SELECT name, is_auto_shrink_on, is_auto_close_on, is_auto_create_stats_on, is_auto_update_stats_on FROM sys.databases"
$dbs = Invoke-Sqlcmd -ServerInstance $sqlservername -Query $sqlquery

try
{
    Write-Host "[Info] Going to start investigating & reconfigure the SQL Settings (if needbe) as per best practices!" -ForegroundColor Green

    # Loop through the database properties
    foreach ($db in $dbs)
    {
        if ($db.is_auto_shrink_on -eq $true)
        {
            $sqlquery2 = "ALTER DATABASE " + $db.name + " SET AUTO_SHRINK OFF;"
            Invoke-SQLcmd -Query $sqlquery2 -ServerInstance $sqlservername -Database "master" 
            Write-Host "[Info] Auto Shrink Turned OFF for Database" $db.name -ForegroundColor Green
        }
        if ($db.is_auto_close_on -eq $true)
        {
            $sqlquery2 = "ALTER DATABASE " + $db.name + " SET AUTO_CLOSE OFF;"
            Invoke-SQLcmd -Query $sqlquery2 -ServerInstance $sqlservername -Database "master"  
            Write-Host "[Info] Auto Close Turned OFF for Database" $db.name -ForegroundColor Green
        }
        if ($db.is_auto_create_stats_on -eq $false)
        {
            $sqlquery2 = "ALTER DATABASE " + $db.name + " SET AUTO_CREATE_STATISTICS ON (INCREMENTAL = ON );"
            Invoke-SQLcmd -Query $sqlquery2 -ServerInstance $sqlservername -Database "master"
            Write-Host "[Info] Auto Create Statistics Turned ON for Database" $db.name -ForegroundColor Green
        }
            if ($db.is_auto_update_stats_on -eq $false)
        {
            $sqlquery2 = "ALTER DATABASE " + $db.name + " SET AUTO_UPDATE_STATISTICS ON;"
            Invoke-SQLcmd -Query $sqlquery2 -ServerInstance $sqlservername -Database "master"
            Write-Host "[Info] Auto Update Statistics Turned ON for Database" $db.name -ForegroundColor Green
        }
    }
}
Catch
{
      Write-Host "Error occurred while trying to reconfigure the SQL Settings. Please contact your admin!" -ForegroundColor Red
}
