#Variable Initialization
$sqlservername = "DESKTOP-S25NQBT\VADIVEL2017ENT"
$queryFindAllUsersDB = "SELECT name FROM sys.databases WHERE database_id > 4"
$dbs = Invoke-Sqlcmd -ServerInstance $sqlservername -Query $queryFindAllUsersDB
#$dbs

#Get date formatted to append as part of the backup filename
$strdate =  (Get-Date -Format 'yyyyMMddHHmm')
#$strdate

foreach($db in $dbs.name)
{
    $dir = "E:\DBFiles\Bak\$db"
 
    if(!(Test-Path $dir))
    {
        New-Item -ItemType Directory -path $dir
        Write-Host "[Info] Directory" $dir "has been created" -ForegroundColor Yellow
    }
    else
    {
        Write-Host "[Info] Directory" $dir "already exists" -ForegroundColor DarkYellow
    }
    
    $bakFilename = "$db-$strdate.bak"
    $backup=Join-Path -Path $dir -ChildPath $bakFilename
        
    try
    {
        #Take a compressed backup of each db in the list
        Backup-SqlDatabase -ServerInstance $sqlservername -Database $db -BackupFile $backup -CompressionOption On
        Write-Host "Backup succeeded for the DB " $db -ForegroundColor green

        #Purge previous backups
        Get-ChildItem $dir\*.bak| Where {$_.LastWriteTime -lt (Get-Date).AddMinutes(-1)}|Remove-Item
    }
    catch
    {
        #Write-Warning "Backup failed on $db"
        Write-Host "[Error] Backup failed on " $db -ForegroundColor red
        continue
    }
}