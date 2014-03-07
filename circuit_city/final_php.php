<?php
session_start();
//if user hasn't logged in and started session...
if(!isset($_SESSION['priv'])) {
	//redirect to login
	header("Location:login.php");
//print $_SESSION['priv'];

}
?>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Circuit City - View All Records</title>
<link rel="stylesheet" type="text/css" href="final_css.css" media="screen"/>
</head>

<body>
<div id="wrapper">
<div id="top_border">
<div id="top_logo">
</div></div>
<div id="header">
<h3>View All Records</h3>
</div>
<div id="nav">
<div id="nav_left">
</div>
<div id="nav_center"><a href="login.php">Login</a>&nbsp;&nbsp;<a href="addrecord.php">Add Record</a><br><a href="final_php.php">View all Records</a>
</div>
<div id="nav_right">
</div>
</div>
<table cellspacing="2">
<tr><td>ID Number</td><td>Name</td><td>Price</td><td>Amount</td></tr>
<?php
		//connect to our server...mysql_connect("servername", "username", "password")
		$link = mysql_connect("localhost", "root");
		//connect to our database
		$db = mysql_select_db("loper_final") or die(mysql_error());
		//construct a SQL query
		$query = "SELECT * FROM items_table";
		//run the query
		$results = mysql_query($query);
		//begin WHILE loop: for each row, do what's om {}
		while($row = mysql_fetch_array($results)){
			//store in a var the PK ID
			$chID = $row['itemsID'];
			// -----------------
			$chName = $row['item_name'];
			$chPrice = $row['item_price'];
			$chAmount = $row['item_amount'];
			$chDescription = $row['item_description'];
			$chImage = $row['item_image'];
			$chThumb = $row['item_thumb'];
			$chStat = $row['item_stat'];
		//display the results
		print "
		<tr><td>$chID</td><td><a href='final_details.php?newID=$chID'> $chName</a> </td><td>$chPrice</td><td>$chAmount</td> </tr>
		<tr><td><a href='$chImage'><img src='$chThumb'/></a></td><td>$chStat</td>";
		//end WHILE loop:
		}
		//close the server connection
    	mysql_close($link);
    
    
    ?>
    </table>
</div>
<p><a href="log-out.php">Logout</a></p>
</body>
</html>
