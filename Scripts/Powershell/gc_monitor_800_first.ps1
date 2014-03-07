
#starter variables for sending the email, and for some of the logic later in the script
$721_running = $false
$821_running = $false
$email_array = @()
$file_details = @()

#importing the .csv into powershell, then figuring out the variance.
$important_info = import-csv "\\ihsmon03\c$\opscripts\dsffiles2_stats\dsffiles2_stats.csv" | select-object -last 2
$final_num = @()
$final_num = $important_info | foreach{$_.{allotment usage}} | foreach{$_ -replace "%",""}
$variance = $final_num[1] - $final_num[0]

#if the variance is more than 2%, then it will log it in the email array, and then continue onwards.
if($variance -gt 2){
write-host "Looks like GC is broken, better take a look"
$email_array += "<tr><td>Variance was off by $variance. The drive is at $($final_num[1])% full.</td></tr>"
$file_details += "Variance was off by $variance. The drive is at $final_num[1]% full."


#Here the script is testing the connection on the two staples database servers.
#Once it connects to a database server, the script will run the query "select * from gc_batches  where CreationTime > dateadd(hh, -24, getutcdate())"
#The results will be dumped into a dataset.
if ((Test-Connection DSFPRDDB801 -Count 1 -quiet)) {
$SQLServer = "DSFPRDDB801"
$SQLDBName = "DSFDB_DSFPRD81ASP1"
$SqlQuery = "select * from gc_batches  where CreationTime > dateadd(hh, -24, getutcdate())"
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
$table = new-object data.datatable
$table = $dataset.tables[0]

} else {
$SQLServer = "DSFPRDDB701"
$SQLDBName = "DSFDB_DSFPRD71ASP1"
$SqlQuery = "select * from gc_batches  where CreationTime > dateadd(hh, -24, getutcdate())"
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
$table = new-object data.datatable
$table = $dataset.tables[0]



}



#If the dataset gathered from the database contains no entries It will log the data into the email array.
#The script will then continue onwards with the assessing what is breaking GC.
if($table.Rows.Count -eq 0){
write-host "nothing in database in last day"
$email_array += "<tr><td>Found no recent(within last 24 hours) Garbage Collection Jobs in the Staples Database</td></tr>"
$file_details += "Found no recent(within last 24 hours) Garbage Collection Jobs in the Staples Database"
#Here the script is pinging the servers that should be running EFI DIstributed Services.
#It will try both DSFPRDAPP721 & DSFPRDAPP821. If it can reach neither of the servers, it will record such in the email array.
#Once it reaches a server, it will pull that servers EFI Distributed Services information.
if ((Test-Connection DSFPRDAPP721 -Count 1 -quiet)) {
$service_info = get-service -computer DSFPRDAPP721  | where-object {$_.name -eq "EFI Distributed Services"} 
$721_running = $true
} elseif((Test-Connection DSFPRDAPP821 -Count 1 -quiet)) {
$service_info = get-service -computer DSFPRDAPP821  | where-object {$_.name -eq "EFI Distributed Services"} 
$821_running = $true
} else{

write-host "Neither server appears to be running that would run EFI DIstributed Services. Find out if DSFPRDAPP721 & DSFPRDAPP821 are still the right servers"
$email_array += "<tr><td>I then found that I had been configured for the wrong servers(DSFPRDAPP721 & DSFPRDAPP821). Please configure me for the correct servers."
$file_details += "I then found that I had been configured for the wrong servers(DSFPRDAPP721 & DSFPRDAPP821). Please configure me for the correct servers."
}


#Here the script checks to see if the service is running.
#If the service isn't running on the server, it will record such in the email array.

if(($service_info.status -eq "running")){

#Once it establishes that the service is running, it will then reach into the config file for that service on the server.
if(($721_running)){
$service_config = gc "\\DSFPRDAPP721\c$\Program Files (x86)\efi\dsf\EFIDistributedServices\DSFDistSvc.exe.config"


} else{
$service_config = gc "\\DSFPRDAPP821\c$\Program Files (x86)\efi\dsf\EFIDistributedServices\DSFDistSvc.exe.config"


}

#The information from the config file will then be parsed for the SystemBootURL in the config file.
$config_url = ($service_config | Out-string |  Select-String -pattern 'systembooturl" value="([\s\S]*?)"' -AllMatches).matches | foreach{ $_.value} | foreach{$_ -replace "SystemBootURL`" value=`"",""} | foreach{$_ -replace '"', ""}
if(($721_running = 1)){
$final_url = $config_url | foreach{$_ -replace "localhost", "DSFPRDAPP721"}

} else {
$final_url = $config_url | foreach{$_ -replace "localhost", "DSFPRDAPP821"}

}

#Once it has finished parsing the file, it will attempt to connect to the website in the file. It is a very basic check.
#The check is only trying to see if it can actually hit asp1 on the server. If it can't it will record that in the email array.
#If it is able to get a response back from the website, it will record that in the email array.
$wc = new-object system.net.WebClient

$response = $wc.DownloadString($final_url)

if($response = " "){
write-host "Looks like we couldn't find any site to connect to, check the below URL and email IS&T Internet Hosting Services and Staples QA if the systembooturl needs updated."
write-host "$config_url"
$email_array += "<tr><td> I couldn't retrieve any information from the site. The URL appears to be incorrect. Please take a look.<br/>$config_url</td></tr>"
$file_details += "I couldn't retrieve any information from the site. The URL appears to be incorrect. Please take a look.`r`n $config_url"
} else {
write-host "I have reached the limits of my programming. Please look at the below URL and see if it is viable. We got a response back when trying to connect to it on the server."
write-host "$config_url"
$email_array += "<tr><td> I reached the limits of my programming. I can't assess the problem any further, since I did get a response back from the SystemBootURL. Please look further.<br/>$config_url</td></tr>"
$file_details += "I reached the limits of my programming. I can't assess the problem any further, since I did get a response back from the SystemBootURL. Please look further. `r`n $config_url"



}





} else{

write-host "Email IS&T Internet Hosting Servers and Staples QA asking why the service isn't running"
$email_array += "<tr><td> I found that the service isn't running. Please ask IS&T Internet Hosting Servers and Staples QA if this is correct, then take further action upon response.</td></tr>"
$file_details += "I found that the service isn't running. Please ask IS&T Internet Hosting Servers and Staples QA if this is correct, then take further action upon response."
}




} else {

if ((Test-Connection DSFPRDDB801 -Count 1 -quiet)) {
$SQLServer = "DSFPRDDB801"
$SQLDBName = "DSFDB_DSFPRD81ASP1"
$SqlQuery = "select * from gc_batches where StepNumber <> 7"
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
$table = new-object data.datatable
$table = $dataset.tables[0]

} else {
$SQLServer = "DSFPRDDB701"
$SQLDBName = "DSFDB_DSFPRD71ASP1"
$SqlQuery = "select * from gc_batches where StepNumber <> 7"
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
$table = new-object data.datatable
$table = $dataset.tables[0]



}

if($table.Rows.Count -gt 0){
write-host "Failed batches"
$email_array += "<tr><td>GC ran, but didn't finish. Found some unfinished batches in the database.</td></tr>"
$file_details += "GC ran, but didn't finish. Found some unfinished batches in the database."
$fail_amount = $table.Rows.Count
[string]$fail_number = $table.Rows[0] | foreach{$_.stepnumber} | Out-string
[string]$fail_number = "$fail_number"
$email_array += "<tr><td>There are $fail_amount unfinished batches, and they are from step $($fail_number)</td></tr>"
$file_details += "There are $fail_amount unfinished batches, and they are from step $($fail_number)"
}


}
} else{

$email_array += "<tr><td>Everything seems fine on my end in regards to Staples GC. The variance isn't more than 2%.</td></tr>"
$file_details += "Everything seems fine on my end in regards to Staples GC. The variance isn't more than 2%."


}
#Once the script has finished running, if there are any items in the email array, they will be sent out for the operator on duty to look over.
$file_details += "RTMD located here...`r`n \\pghfs2.efi.internal\techsupport\ProdOps\Documents\Procedures_General\Staples_GC_Automation\Staples_GC_Automation.docx"
function sendMail{

     Write-Host "Sending Email"

     $smtpServer = "mr.printhosting.com"

     $msg = new-object Net.Mail.MailMessage

     $smtp = new-object Net.Mail.SmtpClient($smtpServer)

     $msg.From = "ops@efi.com"
     $msg.ReplyTo = "patrick.loper@efi.com"
     $msg.To.Add("patrick.loper@efi.com")
     $msg.subject = "Runs from IHSMON07: Staples GC Check"
     $msg.IsBodyHtml = "True"
	 $msg.body = "<style>BODY{background-color:#660000; color:#FFF;}TABLE{border-width: 1px;border-style: solid;border-color: #fff;border-collapse: collapse;  }TD{border-width: 1px;padding: 0px;border-style: solid;border-color: #fff;background-color:#660000;padding: 4px;}a{color:#FFCCCC;}a:hover{color:#FF9933;}</style><h2>The steps that I took in troubleshooting the Garbage Collection for Staples are below.</h2><table border=`"2px`">$($email_array)</table><p>RTMD located here...<br/> \\pghfs2.efi.internal\techsupport\ProdOps\Documents\Procedures_General\Staples_GC_Automation\Staples_GC_Automation.docx</p>"
     $smtp.Send($msg)
 
}
sendMail

if(test-path \\pghfs2.efi.internal\techsupport\ProdOps\Documents\Procedures_General\Staples_GC_Automation\staples_gc.txt){
rmdir \\pghfs2.efi.internal\techsupport\ProdOps\Documents\Procedures_General\Staples_GC_Automation\staples_gc.txt
} 
$file_details | Out-file \\pghfs2.efi.internal\techsupport\ProdOps\Documents\Procedures_General\Staples_GC_Automation\staples_gc.txt




