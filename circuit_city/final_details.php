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
<title>Circuit City - <?php //set up a var storing the ID # of the product we want to display:
		$chosenID=$_GET['newID'];
		//connect to our server...mysql_connect("servername", "username", "password")
		$link = mysql_connect("localhost", "root");
		//connect to our database
		$db = mysql_select_db("loper_final") or die(mysql_error());
		//construct a SQL query, getting info based on the ID # the user chose
		$query = "SELECT * FROM items_table WHERE itemsID=$chosenID";
		//run the query
		$results = mysql_query($query);
		//begin WHILE loop: for each row, do what's om {}
		while($row = mysql_fetch_array($results)){
			//store in a var the PK ID
				$chID = $row['itemsID'];
			// -----------------
			$chName = $row['item_name'];
			print $chName; }?></title>
<link rel="stylesheet" type="text/css" href="final_css.css" media="screen"/>
</head>

<body>
<div id="wrapper">
<div id="top_border">
<div id="top_logo">
</div></div>
<div id="header">
<h3><?php //set up a var storing the ID # of the product we want to display:
		$chosenID=$_GET['newID'];
		//connect to our server...mysql_connect("servername", "username", "password")
		$link = mysql_connect("localhost", "root");
		//connect to our database
		$db = mysql_select_db("loper_final") or die(mysql_error());
		//construct a SQL query, getting info based on the ID # the user chose
		$query = "SELECT * FROM items_table WHERE itemsID=$chosenID";
		//run the query
		$results = mysql_query($query);
		//begin WHILE loop: for each row, do what's om {}
		while($row = mysql_fetch_array($results)){
			//store in a var the PK ID
				$chID = $row['itemsID'];
			// -----------------
			$chName = $row['item_name'];
			print $chName; }?></h3>
</div>
<div id="nav">
<div id="nav_left">
</div>
<div id="nav_center"><a href="final_php.php">Login</a>&nbsp;&nbsp;<a href="addrecord.php">Add Record</a><br><a href="final_php.php">View all Records</a>
</div>
<div id="nav_right">
</div>
</div>
<table cellspacing="2">
<tr><td>ID Number</td><td>Name</td><td>Price</td><td>Amount</td></tr>
	<?php
		//set up a var storing the ID # of the product we want to display:
		$chosenID=$_GET['newID'];
		//connect to our server...mysql_connect("servername", "username", "password")
		$link = mysql_connect("localhost", "root");
		//connect to our database
		$db = mysql_select_db("loper_final") or die(mysql_error());
		//construct a SQL query, getting info based on the ID # the user chose
		$query = "SELECT * FROM items_table WHERE itemsID=$chosenID";
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
		//display the results
		print "<tr><td>$chID</td><td><a href='final_details.php'> $chName</a> </td><td>$chPrice</td><td>$chAmount</td> </tr>
		<tr><td rowspan='2'><a href='$chImage'><img src='$chImage'/></a></td><td>$chStat</td></tr><tr><td>$chDescription</td></tr>";
		//end WHILE loop:
		}
		//close the server connection
    	mysql_close($link);
    
    
    ?>
    </table>
</div>
</body>
</html>
