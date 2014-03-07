<?php
session_write_close();


?>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Circuit City - Login </title>
<link rel="stylesheet" type="text/css" href="final_css.css" media="screen"/>
</head>

<body>
<div id="wrapper">
<div id="top_border">
<div id="top_logo">
</div></div>
<div id="header">
<h3>Login</h3>
</div>
<div id="nav">
<div id="nav_left">
</div>
<div id="nav_center"><br/><a href="login.php">Login</a>
</div>
<div id="nav_right">
</div>
</div>
<div id="login_table">
<form action="login_process.php"  method="post">
<table cellspacing="2">
<tr><td><h4>Username:</h4></td><td><input type="text" name="uname" id="mysubmit" /></td><td rowspan="2"><?php if(isset($_GET['error'])){
	if($_GET['error']=="incorrect_user"){
	print "The username or password do not match, Please Try Again";
	}
	
}

?></td></tr></tr>
<tr><td><h4>Password:</h4></td><td><input type="password" name="upass" id="mysubmit" /></td></tr>
<tr><td colspan="2">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input name="submit" type="submit" value="Submit" id="mysubmit" /></td></tr>
  </table>
  </div>
</div>
</body>
</html>
