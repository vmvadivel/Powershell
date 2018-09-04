# Clear the output window 
clear

<# 
    Execute Microsoft Data Migration Assistant with hardcoded values

    Possible options for AssessmentTargetPlatform:
    - SqlServer2012
    - SqlServer2014
    - SqlServer2016
    - SqlServerWindows2017
    - SqlServerLinux2017
    - SqlDataWarehouse
    - ManagedSqlServer
#>

& "${env:ProgramFiles}\Microsoft Data Migration Assistant\DmaCmd.exe" /AssessmentName="SQLMigrationAssessment" /AssessmentDatabases="Server=yourserverinstancename;Initial Catalog=yourdbname;Integrated Security=true" /AssessmentTargetPlatform="SqlServerLinux2017" /AssessmentEvaluateCompatibilityIssues /AssessmentOverwriteResult /AssessmentResultCsv="E:\datamigration\report\ReviewReport.csv" /AssessmentResultJson="E:\datamigration\report\ReviewReport.json"
