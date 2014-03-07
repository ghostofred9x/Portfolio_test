$email_body = ""

function sendMail{

     Write-Host "Sending Email"

     $smtpServer = "mr.printhosting.com"

     $msg = new-object Net.Mail.MailMessage

     $smtp = new-object Net.Mail.SmtpClient($smtpServer)

     $msg.From = "ops@efi.com"
     $msg.ReplyTo = "patrick.loper@efi.com"
     $msg.To.Add("patrick.loper@efi.com")
     $msg.subject = "(Runs from IHSMON04 as Pace_wiki_Check)EoM CheckList Item \ Info Only"
     $msg.IsBodyHtml = "True"
	 $msg.body = "$email_body"
     $smtp.Send($msg)
 
}
#'<!--GroupCanvasOff-->([\s\S]*)<!--GroupCanvasOff-->'
#$url = "http://pacetwiki/cgi-bin/twiki/view/Know/PaceIHSProcesses";
$url = "http://10.34.1.152/cgi-bin/twiki/view/Know/PaceIHSProcesses";
$userName = "TWikiGuest";
$password = "PROTECTED";
$domain = "pacetwiki";
$pace = @()
$bad_pace = @()
$wc = new-object system.net.WebClient
$Creds = new-object System.Net.NetworkCredential($username, $password)
$cache = New-Object System.Net.CredentialCache
$cache.add($url,"Basic",$Creds)
$wc.Headers["Accept"] = "application/x-ms-application, image/jpeg, application/xaml+xml, image/gif, image/pjpeg, application/x-ms-xbap, application/x-shockwave-flash, application/vnd.ms-excel, application/vnd.ms-powerpoint, application/msword, */*";
$wc.Headers["User-Agent"] ="Mozilla/4.0 (compatible; MSIE 8.0; Windows NT 6.1; WOW64; Trident/4.0; SLCC2; .NET CLR 2.0.50727; .NET CLR 3.5.30729; .NET CLR 3.0.30729; Media Center PC 6.0; MDDC)";
$wc.Credentials = $cache
$webpage_inc = $wc.DownloadString($url)
$webpage = ($webpage_inc | Out-string |  Select-String -pattern 'id="table3"([\s\S]*?)Note I.H.S. priorities' -AllMatches).matches
if($webpage){
$SQLServer = "IHSMON08\SQLEXPRESS"
$SQLDBName = "IHSTracker"
$SqlQuery = "select name from device where active='1' and osid='2' order by name"
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
$pace = $datasetitems | where-object{$_ -like "PAC*"}
foreach($s in $pace){

	if(($webpage | where-object{$_ -like "*$s*"})){


	}else{
	$bad_pace += ($s, "<br/>")

	}
}

}else {

Write-Host "The Website wasn't able to be reached. Check to see if the correct credentials are in use"

$email_body = "The Website wasn't able to be reached. Check to see if the correct credentials are in use"
#didn't find the webpage

sendMail
}

if($bad_pace){

$email_body  = "These servers are not present on the pace wiki located here(http://pacetwiki/cgi-bin/twiki/view/Know/PaceIHSProcesses). <br/><br/><p><b>Offenders:</b><br/>" + "$($bad_pace)</p>"
sendMail
}