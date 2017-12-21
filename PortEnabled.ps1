
$Port = "1433"
$Server = "mytest.cloudapp.net"
 
if ($Server -and ($Port -eq "")) 
{
    Test-NetConnection -ComputerName $Server -InformationLevel Detailed
}
 
if ($Port -ne "") 
{
    Test-NetConnection -ComputerName $Server -InformationLevel Detailed -Port $Port
}
