$formatenumerationlimit = 30
#Get-date | Out-file -append serverevent.log
$email_body = ""
$line = "-------------------------------------------------"


function sendMail{

     Write-Host "Sending Email"

     $smtpServer = "mr.printhosting.com"

     $msg = new-object Net.Mail.MailMessage

     $smtp = new-object Net.Mail.SmtpClient($smtpServer)

     $msg.From = "ops@efi.com"
     $msg.ReplyTo = "patrick.loper@efi.com"
     $msg.To.Add("patrick.loper@efi.com")
     $msg.subject = "Event Log Errors: Broken Distributed Service"
     $msg.IsBodyHtml = "True"
	 $msg.body = "$email_body"
     $smtp.Send($msg)
 
}


cd C:\event_log
if(test-path C:\event_log\server_event.csv){
Remove-Item server_event.csv

}
New-Item server_event.csv -type file
$csv_start = "Servername,Error"
$csv_start | Out-file -append server_event.csv

#event log search
$events = 4
$dsf_servers = @()


$message = ""
$SQLServer = "IHSMON08\SQLEXPRESS"
$SQLDBName = "IHSTracker"
$SqlQuery = "select name from device where active='1' and osid='1' order by name"
$SqlConnection = New-Object System.Data.SqlClient.SqlConnection
$SqlConnection.ConnectionString = "Server = $SQLServer; Database = $SQLDBName; Integrated Security = True"
$SqlCmd = New-Object System.Data.SqlClient.SqlCommand
$SqlCmd.CommandText = $SqlQuery
$SqlCmd.Connection = $SqlConnection
$SqlAdapter = New-Object System.Data.SqlClient.SqlDataAdapter
$SqlAdapter.SelectCommand = $SqlCmd
$DataSet = New-Object System.Data.DataSet
$SqlAdapter.Fill($DataSet)
$SqlConnection.Close()

$DataSetItems = $dataset.tables[0].rows | foreach{$_.name}
$dsf_servers = $DataSetItems | where-object{$_ -like "DSF*"} | where-object{$_ -notlike "DSFPRDDB??"} | where-object{$_ -notlike "DSFQADB??"} | where-object{$_ -ne "DSFDEVAPP07"} | where-object{$_ -ne "DSFPRDAPP601"} | where-object {$_ -ne "DSFPRDDB601"} | where-object{$_ -ne "DSFPRDAPP505"} | where-object{$_ -ne "DSFPRDAPP506"} | where-object{$_ -ne "DSFPRDAPP511"} | where-object{$_ -ne "DSFPRDAPP512"} | where-object{$_ -ne "DSFPRDAPP517"} | where-object{$_ -ne "DSFPRDAPP518"} | where-object{$_ -ne "dsfprdapp523"} | where-object{$_ -ne "DSFPRDAPP591"} | where-object{$_ -ne "DSFQAAPP39"} | where-object{$_ -ne "dsfprdapp26"} | where-object{$_ -ne "dsfprdapp501"} | where-object{$_ -ne "dsfprdapp502"} | where-object{$_ -ne "dsfprdapp515"} | where-object{$_ -ne "dsfprdapp516"} | where-object{$_ -ne "dsfprdapp521"} | where-object{$_ -ne "dsfprdapp522"} | where-object{$_ -ne "dsfprdapp527"} | where-object{$_ -ne "dsfprdapp528"} | where-object{$_ -ne "dsfprdapp533"} | where-object{$_ -ne "dsfprdapp571"} | where-object{$_ -notlike "dsfprdapp8??"} | where-object{$_ -ne "dsfprddb501"} | where-object{$_ -ne "dsfprddb502"}

Foreach($s in $dsf_servers){
if((Test-Connection -Cn $s -BufferSize 16 -Count 1 -ea 0 -quiet)) 
{
$s
#$message = get-eventlog -computername $s -logname application -newest 10 | where-object{$_.entrytype -eq "Error"} | where-object{$_.instanceID -eq 4} | where-object{$_.message -like "*An exception occurred updating configuration for site at url*"} | select-object Timegenerated, message | ft -wrap | Out-string | Out-Default
$message = get-eventlog -computername $s -logname application -newest 10 | where-object{$_.entrytype -eq "Error"} | where-object{$_.instanceID -eq 4} | where-object{$_.message -like "*An exception occurred updating configuration for site at url*"} | select-object Timegenerated, message | ft -wrap Timegenerated, message
#$message = get-eventlog -computername dsfprdapp12 -logname application -newest 10 | where-object{$_.entrytype -eq "Error"} | where-object{$_.instanceID -eq 4} | where-object{$_.message -like "*An exception occurred updating configuration for site at url*"} | select-object Timegenerated, message | ft -wrap timegenerated, message | Export-csv C:\event_log\test.csv

#$s + "," + 
if($message){
$s | Out-file -append server_event.csv
$message | Out-file -append server_event.csv
$message = ""
}

}
}



#