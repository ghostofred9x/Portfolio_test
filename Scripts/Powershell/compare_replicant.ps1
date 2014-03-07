#This is the start of my script that will check to see if we have replicas for the right servers in DR.
#To-do List for script
#Narrow it down so that only servers on IHSVC02 are pulled in by the tracker. How would I filter this?
#Initializing Variables
#$replica_list = @()
#$unreplicated_servers = @()
#$possible_inactive_servers = @()
#$replicas_that_need_checked = @()
#$replicas_ready = @()
$a = Get-date
$date_today = $a.ToShortDateString()
$date_yesterday = $a.AddDays(-1).Date.ToShortDateString()
$date_yesterday2 = $a.AddDays(-2).Date.ToShortDateString()
#$server_replicas__outdated = @()

$hours = 36
#This is creating the connection I will use to query the DR location.
add-pssnapin VMware.VimAutomation.Core
$vCenterServer = "ihsvc03.printhosting.com"
#connect to VC
$user = "sitescope"
$pwd = "PROTECTED"
write-host "Connecting to Virtual Center"
$connect = Connect-VIServer $vCenterServer -User printhosting\$user -Password $pwd


#This will be the part where I am connecting to the tracker and getting all P1 servers.

#This part will query the tracker for all relevant P1 servers
#select name from device where active='1' and prioritylevelid='1' and servertypeid<>'3'
$SQLServer = "IHSMON08\SQLEXPRESS"
$SQLDBName = "IHSTracker"
$SqlQuery = "select * from device where active='1' and prioritylevelid='1' and servertypeid='6' and location<>'SunGard Chicago' and location<>'IHS - PIT' and location<>'Microsoft Azure Cloud ' and location<>'SunGard UK' and location<>'SunGard DR'"
$SqlConnection = New-Object System.Data.SqlClient.SqlConnection
$SqlConnection.ConnectionString = "Server = $SQLServer; Database = $SQLDBName; Integrated Security = True"
$SqlCmd = New-Object System.Data.SqlClient.SqlCommand
$SqlCmd.CommandText = $SqlQuery
$SqlCmd.Connection = $SqlConnection
$SqlAdapter = New-Object System.Data.SqlClient.SqlDataAdapter
$SqlAdapter.SelectCommand = $SqlCmd
$DataSet = New-Object System.Data.DataSet
$SqlAdapter.Fill($DataSet)


$pone_list = $dataset.tables[0].rows | foreach{$_.name}

#This part will query the DR environment for all of the replicas currently stored out there
$replica_list += get-vm | where-object{$_ -like "*_Replica"} | foreach-Object{$_ -replace "_Replica" , ""}

#This part will compare both of them to make sure everything is as it should be.
$compared_list = compare-object $pone_list $replica_list -includeequal

$unreplicated_servers = $compared_list | where-object{$_.sideindicator -eq "<="} | foreach-object{$_.inputobject}| foreach-object{"<tr><td>" + $_ + "<tr><td>"}
$possible_inactive_servers = $compared_list | where-object{$_.sideindicator -eq "=>"} | foreach-object{$_.inputobject}
$replicas_that_need_checked = $compared_list | where-object{$_.sideindicator -eq "=="} | foreach-object{$_.inputobject + '_Replica'}



#Once it compares the data, and it finds that the replica is out there, it will check to see if the replica has successfully been created within the last 24 hours.
#Date format: $b = [1/25/2014 7:06 PM]
#get-vm -name pacprdapp192_Replica | select-object -expandproperty Notes
#$a = Get-date
#$date_today = $a.ToShortDateString()

foreach($r in $replicas_that_need_checked){
$notes = get-vm -name $r | select-object -expandproperty Notes

#Attempt to 
if($notes -like "*$date_today*" -or "*$date_yesterday*" -or "*$date_yesterday2*"){
write-host "the replica is good"
}else{
$server_replicas__outdated += ("<tr><td>$r</td><td>$notes</td></tr>")

}
}

#Here I check for possible inactive servers that have a DR replica, but don't have an active entry in the tracker
$possible_inactive_servers
$SqlQuery = "select name from device where active='0' and prioritylevelid='1' and servertypeid='6'"
$SqlCmd.CommandText = $SqlQuery
$SqlAdapter.SelectCommand = $SqlCmd
$DataSet_0 = New-Object System.Data.DataSet
$SqlAdapter.Fill($DataSet_0)

$inactive_pone_list = $dataset.tables[0].rows | foreach{$_.name}
$inactive_compared_list = compare-object $inactive_pone_list $possible_inactive_servers -includeequal
$inactive_final = $inactive_compared_list | where-object{$_.sideindicator -eq "=="}
#$non_pone_servers_in_DR = $inactive_compared_list | where-object{$_.sideindicator -eq "=>"} | foreach-object{$_.inputobject}| foreach-object{"<tr><td>" + $_ + "<tr><td>"}
foreach($serv in $inactive_compared_list){
if($serv.sideindicator -eq "=>"){
$non_pone_servers_in_DR += $serv.inputobject | foreach-object{"<tr><td>" + $_ + "<tr><td>"}

}

}


#Here is where the script emails
$reportemailbody = "<table><td><tr><h2>Here are the servers that don't have replicas in DR</h2></td></tr>" + "$($unreplicated_servers)" + "<td><tr> <h2>Here are the servers with replicas that might not have finished</h2></tr></td>" + "$($server_replicas__outdated)" + "<tr><td> <h2>Here are the servers that don't seem to be active in our environment, yet have replicas in DR</h2></td></tr>" + "$($inactive_final)" + "<tr><td> <h2>Here are the servers in DR that aren't P1 servers</h2></td></tr>" + "$($non_pone_servers_in_DR)" + "</table>"
$SqlConnection.Close()
function sendMail{

     Write-Host "Sending Email"

     $smtpServer = "mr.printhosting.com"

     $msg = new-object Net.Mail.MailMessage

     $smtp = new-object Net.Mail.SmtpClient($smtpServer)

     $msg.From = "ops@efi.com"
     $msg.ReplyTo = "patrick.loper@efi.com"
     $msg.To.Add("patrick.loper@efi.com")
     $msg.subject = "Replica Status in DR"
     $msg.IsBodyHtml = "True"
	 $msg.body = "$reportemailbody"
     $smtp.Send($msg)
 
}

sendMail
