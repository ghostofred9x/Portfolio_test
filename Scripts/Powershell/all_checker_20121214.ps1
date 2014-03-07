#This area is where I am initializing all of my variables that I will be using throughout the script.
#F5 IPs
$f5primary = "10.33.50.26"
$f5secondary = "10.33.50.23"
#Checking gateways
$datasetitems = @()
$final = @()
$serverList = @()
$IPList = @()
$full_list = @()
$gatewayList = @()

#Checking routes
$routes = @()
$badroutes = @()
$routeserver = @()


#Checking DNS
$dnsserverlist = @()

#Email settings
$gateemailbody = ""
$routeemailbody = ""
$DNSemailbody = ""
$finalemailbody = ""


#This is the function that I use to install the powershell snapin to connect to the f5
function Do-Initialize()
{
if ( (Get-PSSnapin | Where-Object { $_.Name -eq "iControlSnapin"}) -eq $null )
{
Add-PSSnapIn iControlSnapIn
}
if ((Test-Connection $f5primary -Count 1 -quiet)) {
$success = Initialize-F5.iControl -hostname 10.33.50.26  -username pcops -password PROTECTED
return $success;
} else {
$success = Initialize-F5.iControl -hostname 10.33.50.23  -username pcops -password PROTECTED
return $success;
}
}
Do-Initialize

#This area is for getting the loadbalanced gateway IPs out of the f5 and into a suitable variable
$SelfIP = (Get-F5.iControl).NetworkingSelfIP
$gateway = $SelfIP.get_list()
foreach($z in $gateway){
$gatewaylist += @($z)
}

#This is a check to see if the script connected to the f5 successfully. If it doesn't, it will email an error to the team saying that it couldn't connect
if($gatewaylist -gt 0){



#This is the section that I use to connect to the tracker database to pull the list of server names I will be working with.
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


#This part is to turn the list of server names into an array that I can work with in powershell. This is also the spot where you would add exceptions, as there are a few below.
$DataSetItems = $dataset.tables[0].rows | foreach{$_.name}
$final = $datasetitems | where-object{$_ -ne "DSFPRDAPP601"} | where-object {$_ -ne "DSFPRDDB601"} | where-object{$_ -ne "IHSFS92"} | where-object{$_ -ne "IHSMON11"} | where-object{$_ -ne "PGHMON01"} | where-object{$_ -ne "AUTUMNTEST"} | where-object{$_ -ne "IHSMON13"}

#This is the part of the script that actually hits the server to pull the different types of information we will be working with for this script.
#It collects the DNS, the Routes, and the Gateway IP. It then checks these values against a bit of logic.
#If it doesn't pass the logic, the server will get added to an array, so that it can be sent out in an email.
foreach($s in $final){
if((Test-Connection -Cn $s -BufferSize 16 -Count 1 -ea 0 -quiet)) 
	{
	write-host "Currently on:$s"
$serverconfig = get-WMIObject Win32_NetworkAdapterConfiguration -computer $s -Filter IPEnabled=TRUE
$dnsservers = $serverconfig | Select DNSserversearchorder | foreach{$_.DNSserversearchorder} | where-object{($_ -like "10.33.50.10") -or ($_ -like "10.33.50.11")}
$serverIP = $serverconfig | foreach{$_.DefaultIPGateway} | where-object{$_ -notlike ""}
$serverIP2 = "$serverIP"
$utoh = compare-object  -ReferenceObject $serverIP2 -DifferenceObject $gatewaylist | where-object{$_.SideIndicator -eq "<="} | foreach{$_.InputObject} | where-object{$_ -notlike "10.*.*.1"} | where-object{$_ -notlike ""}

if (compare-object  -ReferenceObject $serverIP2 -DifferenceObject $gatewaylist -IncludeEqual | where-object{$_.SideIndicator -eq "=="} | foreach{$_.InputObject} | where-object{$_ -notlike ""})
{

$routes = Get-WMIObject win32_IP4RouteTable -ComputerName $s | foreach{$_.Description} | where-object{($_ -like "*$serverIP2") -or ($_ -like "10.33.0.0 - 255.255.0.0 - 10.*.*.1") -or ($_ -like "10.34.0.0 - 255.255.0.0 - 10.*.*.1")}
if ($routes.count -eq 3){

} else {
write-host "Error: The routes for $s are incorrect!"
$badroutes += @($s)
}
}
	
if($dnsservers.count -eq 2){

} else {
$dnsserverlist += @($s)
write-host "Error:The DNS is NOT set correctly!"
}

if ($utoh){
$IPList += @($utoh)

$serverlist += @($s)
}
	
	
	}
	
	}

#Here are the variables where the problem servers and IPs would be stored, and below it will check these to see if they have discrepencies in them.
#After checking them, if they do have discrepencies in them, an email will be sent detailing the servers that have problems.
$dnsserverlist	
$badroutes
$full_list += @($serverlist),($IPlist)
	
If ($IPlist.count -gt 0){	
	write-host "The incorrect gateways are below."
	$full_list
$carry = foreach ($xer in $full_list) {$xer | Out-string}
	$gateemailbody = "The incorrect gateways are below <br/>" + "$($carry)"
	} else {
	$gateemailbody = "There are no incorrect gateways!"
	}
	
If ($dnsserverlist.count -gt 0){
	write-host "The servers with incorrect dns settings are below."
	$dnsserverlist
	$DNSemailbody = "The servers with incorrect dns settings are below. <br/>" + "$($dnsserverlist)"
	} else {
	$DNSemailbody = "There are no incorrect DNS settings!"
	}
	
If ($badroutes.count -gt 0){
	write-host "The servers with bad routes are below."
	$badroutes
	$routeemailbody = "The servers with bad routes are below. <br/>" + "$($badroutes)"
	} else {
	$routeemailbody = "There are no misconfigured routes!"
	}
	

#This is the function that I use to send the errors out, if there are any.
	function sendMail{

     Write-Host "Sending Email"

     $smtpServer = "mr.printhosting.com"

     $msg = new-object Net.Mail.MailMessage

     $smtp = new-object Net.Mail.SmtpClient($smtpServer)

     $msg.From = "ops@efi.com"
     $msg.ReplyTo = "patrick.loper@efi.com"
     $msg.To.Add("patrick.loper@efi.com")
     $msg.subject = "Gateway, DNS, & Routes Checker: Powershell"
     $msg.IsBodyHtml = "True"
	 $msg.body = "$finalemailbody"
     $smtp.Send($msg)
 
}
$finalemailbody = "$gateemailbody <br/><br/> $DNSemailbody <br/><br/> $routeemailbody"

} else {

function sendMail{

     Write-Host "Sending Email"

     $smtpServer = "mr.printhosting.com"

     $msg = new-object Net.Mail.MailMessage

     $smtp = new-object Net.Mail.SmtpClient($smtpServer)

     $msg.From = "ops@efi.com"
     $msg.ReplyTo = "patrick.loper@efi.com"
     $msg.To.Add("patrick.loper@efi.com")
     $msg.subject = "F5 Problems"
     $msg.IsBodyHtml = "True"
	 $msg.body = "There seems to be a problem with this script connecting to the F5. Please check!"
     $smtp.Send($msg)
 
}

}

sendmail
