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
<title>Circuit City - Add Records</title>
<link rel="stylesheet" type="text/css" href="final_css.css" media="screen"/>
<script type="text/javascript">
<!--
function MM_openBrWindow(theURL,winName,features) { //v2.0
  window.open(theURL,winName,features);
}
//-->
</script>
</head>

<body>
<div id="wrapper">
<div id="top_border">
<div id="top_logo">
</div></div>
<div id="header">
<h3>Add Records</h3>
</div>
<div id="nav">
<div id="nav_left">
</div>
<div id="nav_center"><a href="final_php.php">Login</a>&nbsp;&nbsp;<a href="addrecord.php">Add Record</a><br><a href="final_php.php">View All Records</a>
</div>
<div id="nav_right">
</div>
</div>
<form method="POST" action="process.php" enctype="multipart/form-data">
<table cellspacing="2" cellpadding="0">
<tr><td><h4>Product Name</h4></td><td><input type="text" name="username"/></td><td><?php 
			//if an error was passed from addprocess
			if(isset($_GET['error'])){
				//if it was a no name error
				if($_GET['error']=="noname"){
					print "Please type a name.";
					} 
			}
			
			?></td>
</tr>
<tr><td><h4>Product Price</h4></td><td><input type="text" name="userprice"/></td><td><?php 
			//if an error was passed from addprocess
			if(isset($_GET['error'])){
				//if it was a no name error
				if($_GET['error']=="pricenum"){
					print "Please use a number.";
					} 
			}
			
			?></td></tr>
<tr><td><h4>Product Amount</h4></td><td><input type="text" name="useramount"/></td><td><?php 
			//if an error was passed from addprocess
			if(isset($_GET['error'])){
				//if it was a no name error
				if($_GET['error']=="pricenum"){
					print "Please use a number.";
					} 
			}
			
			?></td></tr>
<tr><td><h4>Product Description</h4></td><td><textarea name="userdescription" col="" row=""></textarea></td></tr>
<tr><td><h4>Product Image</h4></td><td><input type="file" name="userimage"/></td></tr>
<tr><td><h4>Product Thumbnail</h4></td><td><input type="file" name="userthumb"/></td></tr>
<tr><td><h4>Product Stat</h4></td><td><input type="text" name="userstat"/></td></tr>
<tr><td><input type="submit" value="Add Record"/></td></tr>

    </table>
</form>
</div>
</body>
</html>
