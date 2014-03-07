



<?php
//store in var's the user's choices from index page:
$namechoice=$_POST['uname'];
$passchoice=$_POST['upass'];



//connect to our server...mysql_connect("servername", "username", "password")
		$link = mysql_connect("localhost", "root");
		//connect to our database
		$db = mysql_select_db("loper_final") or die(mysql_error());
		//construct a SQL query
		$query = "SELECT * FROM user_table WHERE username='$namechoice' AND user_pw='$passchoice'";
		//run the query
		$results = mysql_query($query);
		//begin WHILE loop: for each row, do what's om {}
		//print $query;
		//echo ($results)? "query OK" : "query BAD";
		
		
		
		
		
		
		//if there was a row that matched (valid user)		
		if($row = mysql_fetch_array($results)) {
		
		//print "valid user";
			//otherwise no such user is in our table, so...
			//start a new session
			session_start();
			//print session_id();
			$_SESSION['priv']=$row['user_priv'];
			mysql_close($link);
			//redirect to view all
			header("Location:final_php.php");
			
		} else{
		//print "invalid user";
		//close the server connection
    	mysql_close($link);
		//redirect user back to index with an error trigger:
		header("Location:login.php?error=incorrect_user");
		}
		
		
		



?>