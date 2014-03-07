<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Schurter's Sweets - View All Records</title>
<style type="text/css">
*{
margin:0;
padding:0;
}
body{
background:#996633;
font-family:Verdana, Arial, Helvetica, sans-serif;
font-size:10px;
color:#663333;
}
#wrapper{
margin:0 auto 0 auto;
width:800px;
background:url(wrapperbg.jpg) repeat-y;
}
#masthead{
margin:10px auto 10px auto;
width:700px;
height:50px;
background:url(bannerbg.jpg);
border:#eeeedd solid thin;
}
#content, #mainnav{
margin:0 auto 10px auto;
width:650px;
background:url(alpha50pixel.png);
padding-left:50px;
}
}

</style>
</head>

<body>
<div id="wrapper">
  <div id="masthead"></div>
  <div id="mainnav">Main nav goes here.</div>
  <div id="content"><h2>Online Catalog</h2>
    <div id="subnav">Sub nav goes here.</div> 
  	<h3>View All Records</h3>
   <table>
    	<?php
		//connect to our server...mysql_connect("servername", "username", "password")
		$link = mysql_connect("localhost", "root");
		//connect to our database
		$db = mysql_select_db("finaldemoDB") or die(mysql_error());
		//construct a SQL query
		$query = "SELECT * FROM choc_table";
		//run the query
		$results = mysql_query($query);
		//begin WHILE loop: for each row, do what's om {}
		while($row = mysql_fetch_array($results)){
			//store in a var the PK ID
			$chID = $row['chocID'];
			// -----------------
			$chName = $row['chocname'];
			$chPrice = $row['chocprice'];
		//display the results
		print "<tr><td>$chID</td><td> $chName </td><td>$chPrice</td> </tr>";
		//end WHILE loop:
		}
		//close the server connection
    	mysql_close($link);
    
    
    ?>
   </table>
    </div>
</div>

</body>
</html>
