<?php
$username="coder";
$password="coder";
$database="artm3220f10";
// Connects to your Database

	mysql_connect('localhost', $username, $password) or die(mysql_error());
	mysql_select_db($database) or die(mysql_error());

				
	
	
	//This code runs if the form has been submitted
	if (isset($_POST['submit'])) {
		
	//This makes sure they did not leave any fields blank
	if (!$_POST['username'] | !$_POST['password'] | !$_POST['email'] | !$_POST['email1'] ) {
			die('You did not complete all of the required fields');
	}
	
	// checks if the username is in use
		if (!get_magic_quotes_gpc()) {
		$_POST['username'] = addslashes($_POST['username']);
	}
	
	$usercheck = $_POST['username'];
	
	$check = mysql_query("SELECT username FROM pjl_users WHERE username = '$username'") or die(mysql_error());
	$check2 = mysql_num_rows($check);
	
	$check2;
	
	
	
	//if the name exists it gives an error
	if($check2 != 0) {
		die('Sorry, the username '.$_POST['username'].' is already in use.');
	}
	
	
	// this makes sure both passwords entered match
	/*if ($_POST['email'] != $_POST['email1']) {
		die('Your emails did not match.<br/> <a href=""> Try Again?</a> ');
		
	}*/
	
	// here we encrypt the password and add slashes if needed
	$_POST['password'] =md5($_POST['password']);
	if (!get_magic_quotes_gpc()) {
		
		$_POST['password'] = addslashes($_POST['password']);
		$_POST['username'] = addslashes($_POST['username']);
	}
	
	
	// now we insert it into the database
	$insert = "INSERT INTO pjl_users (username, password, email, b_type, day, month, date) VALUES ('".$_POST['username']."', '".$_POST['password']."', '".$_POST['email']."','".$_POST['b_type']."', '".$_POST['day']."', '".$_POST['month']."', '".$_POST['year']."')";
	
	mysql_query($insert);
	mysql_close();
	header("Location: login.php");
	?>
    
	<?php
	}
	else
	{
		?>
        <html>
<head>
<title>
Calming Wake: Join us!
</title>


        
<script type="text/javascript" src="js/slideshow/js/jquery-1.3.1.min.js"></script>
<script type="text/javascript">

$(document).ready(function() {		
	
	//Execute the slideShow
	slideShow();

});

function slideShow() {

	//Set the opacity of all images to 0
	$('#gallery a').css({opacity: 0.0});
	
	//Get the first image and display it (set it to full opacity)
	$('#gallery a:first').css({opacity: 1.0});
	
	//Set the caption background to semi-transparent
	$('#gallery .caption').css({opacity: 0.7});

	//Resize the width of the caption according to the image width
	$('#gallery .caption').css({width: $('#gallery a').find('img').css('width')});
	
	//Get the caption of the first image from REL attribute and display it
	$('#gallery .content').html($('#gallery a:first').find('img').attr('rel'))
	.animate({opacity: 0.7}, 400);
	
	//Call the gallery function to run the slideshow, 6000 = change to next image after 6 seconds
	setInterval('gallery()',6000);
	
}

function gallery() {
	
	//if no IMGs have the show class, grab the first image
	var current = ($('#gallery a.show')?  $('#gallery a.show') : $('#gallery a:first'));

	//Get next image, if it reached the end of the slideshow, rotate it back to the first image
	var next = ((current.next().length) ? ((current.next().hasClass('caption'))? $('#gallery a:first') :current.next()) : $('#gallery a:first'));	
	
	//Get next image caption
	var caption = next.find('img').attr('rel');	
	
	//Set the fade in effect for the next image, show class has higher z-index
	next.css({opacity: 0.0})
	.addClass('show')
	.animate({opacity: 1.0}, 1000);

	//Hide the current image
	current.animate({opacity: 0.0}, 1000)
	.removeClass('show');
	
	//Set the opacity to 0 and height to 1px
	$('#gallery .caption').animate({opacity: 0.0}, { queue:false, duration:0 }).animate({height: '1px'}, { queue:true, duration:300 });	
	
	//Animate the caption, opacity to 0.7 and heigth to 100px, a slide up effect
	$('#gallery .caption').animate({opacity: 0.7},100 ).animate({height: '100px'},500 );
	
	//Display the content
	$('#gallery .content').html(caption);
	
	
}

</script>
<style>
*{margin:0px;
padding:0px;
}

body{

background:url(images/gradient_bg.png) repeat-x;
}


#wrapper{
margin:0px 0px 0px 20px;	
	
	
}


#header{
width:604px;
height:101px;
margin:0px 0px 15px 0px;
}

#head_box{
background: url(images/head_new.png) 245px 0 #5565af no-repeat;
-moz-border-radius: 15px;
width:594px;
height:73px;
border: solid #bcafd6 3px;
-moz-box-shadow: 1px 1px 4px #000;
}

#head_circle{
margin:5px 0px 0px 9px;
background:#bcafd6 no-repeat;
-moz-border-radius: 400px;
border-radius: 200px;
width:160px;
height:90px;
border: thin #bcafd6 1px;
position:absolute;
-moz-box-shadow: 1px 1px 4px #000;


}

#head_circle2{
margin:1px 0px 0px 3px;
background:#5565af no-repeat;
-moz-border-radius: 400px;
border-radius: 200px;
width:150px;
height:83px;
position:absolute;


}

/*url(images/splash.png)*/

#right_panel{
width:361px;
height:300px;
-moz-border-radius: 15px;
background: #5565af no-repeat;
margin: 0px 0px 0px 238px;
border: solid #bcafd6 3px;
z-index:1;
position:relative;
-moz-box-shadow: 1px 1px 4px #000;
}
/*url(images/forms.png)*/


#left_panel {
position:relative;
width:209px;
height:365px;
-moz-border-radius: 15px;
background: #5565af no-repeat;
position:absolute;
border: solid #bcafd6 3px;
z-index:3;
-moz-box-shadow: 1px 1px 4px #000;
}

h2{
font-family:Verdana, Arial, Helvetica, sans-serif;
font-weight:lighter;
color:#bcafd6;
font-size:20px;
margin:22px 0px 0px 10px;

}

.float_right{
float:right;
margin:-32px 8px 0px 0px;
font-family:Verdana, Arial, Helvetica, sans-serif;
font-weight:lighter;
color:#bcafd6;
font-size:13px;


}

input{
	background:#bcafd6;
	margin:0px 0px 15px 0px;
}

.login{
margin:-4px 0px 0px 240px;
-moz-border-radius: 30px;
font-family:Verdana, Arial, Helvetica, sans-serif;
font-weight:lighter;
color:#bcafd6;
font-size:13px;
background:#bcafd6 none;
width:30px;
border: 0;



}

#login{
padding:5px;
font-family:Verdana, Arial, Helvetica, sans-serif;
font-weight:lighter;
color:#bcafd6;
font-size:13px;
margin:48px 0px 0px 240px;
}
.login1{
	
	color:#5565af;
	width:60px;
	margin:5px 0px 0px 0px;
	font-family:Georgia, "Times New Roman", Times, serif;
	
	background:#c6cbe4 none;
}

.login1:hover {
	margin:5px 0px 0px 0px;
	background:#c6cbe4 none;
	-moz-border-radius: 30px;
	color:#5565af;
	width:60px;
	border: solid #c6cbe4 3px;
	
	
}

ul{
list-style:none none;
}
a{
	color:#bcafd6;
	text-decoration:none;
	
	
}

a:hover{
	color:#59263f;
}

#head_box #login{
	position:absolute;
margin:50px 0px 0px 200px;	
	
}

#test { width:209px; height:365px; background-color:#06C;}

#content { width:830px;-moz-border-radius: 30px;}


#ticker{
width:200px;
height:auto;
-moz-border-radius: 15px;
background: #5565af no-repeat;
float:right;
border: solid #bcafd6 3px;
z-index:1;
margin:-421px -15px 0px 0px;
padding:5px;
color:#bcafd6;
-moz-box-shadow: 1px 1px 4px #000;
}

#form1{
	padding:5px;
	font-family:Verdana, Arial, Helvetica, sans-serif;
font-weight:lighter;
color:#bcafd6;
}

.year{
	
	
width:60px;	
	
	
}

/* Slidshow CSS */
.clear {
	clear:both
}

#gallery {
	position:relative;
	height:392px;
}
	#gallery a {
		float:left;
		position:absolute;
	}
	
	#gallery a img {
		border:none;
	}
	
	#gallery a.show {
		z-index:500
	}

	#gallery .caption {
		z-index:-1; 
		background-color:#000; 
		color:#ffffff; 
		height:100px; 
		width:100%; 
		position:absolute;
		bottom:0;
	}

	#gallery .caption .content {
		margin:5px
	}
	
	#gallery .caption .content h3 {
		margin:0;
		padding:0;
		color:#1DCCEF;
	}


</style>
</head>
<body>
<div id="wrapper">
<div id="header">

<div id="head_box">

<div id="head_circle">
<div id="head_circle2">
<h2>HOME</h2>
<ul class="float_right">
<li><a href="index.php">HOME</a></li>
<li><a href="about.html">ABOUT</a></li>
<li><a href="contact.php">CONTACT</a></li>
</ul>
</div>
</div><div id="login"><a href="login.php">Login?</a></div>
</div>



</div>
<div id="content">
<div id="left_panel">
<form id="form1" name="form1" method="post" action="<?php echo $_SERVER['PHP_SELF']?>">
<ul>
<li>
Username<br/>
<input type="text" name="username" id="username" />
</li>
<li>
Password<br/>
<input type="text" name="password" id="password" />
</li>
<li>
Your E-mail<br/>
<input type="text" name="email" id="email" />
</li>
<li>
Re-enter E-mail<br/>
<input type="text" name="email1" id="email1" />
</li>
<li>
Blood Type<br/>
<input type="text" name="b_type" id="b_type" />
</li>
<li>
Birthday<br/>
<select name="day" id="day" >
    <option>1</option>
    <option>2</option>
    <option>3</option>
    <option>4</option>
    <option>5</option>
    <option>6</option>
    <option>7</option>
    <option>8</option>
    <option>9</option>
    <option>10</option>
    <option>11</option>
    <option>12</option>
    <option>13</option>
    <option>14</option>
    <option>15</option>
    <option>16</option>
    <option>17</option>
    <option>18</option>
    <option>19</option>
    <option>20</option>
    <option>21</option>
    <option>22</option>
    <option>23</option>
    <option>24</option>
    <option>25</option>
    <option>26</option>
    <option>27</option>
    <option>28</option>
    <option>29</option>
    <option>30</option>
    <option>31</option>
  </select>
  <select name="month" id="month" >
    <option>January</option>
    <option>Febuary</option>
    <option>March</option>
    <option>April</option>
    <option>May</option>
    <option>June</option>
    <option>July</option>
    <option>August</option>
    <option>October</option>
    <option>September</option>
    <option>November</option>
    <option>December</option>
  </select>
    <select name="year" class="year" id="year"  >
    <option>2010</option>
    <option>2009</option>
    <option>2008</option>
    <option>2007</option>
    <option>2006</option>
    <option>2005</option>
    <option>2004</option>
    <option>2003</option>
    <option>2002</option>
    <option>2001</option>
    <option>2000</option>
    <option>1999</option>
  </select>
</li>
</ul>

<input type="submit" name="submit" value="Register" class="login1"/> </form>
</div>
<div id="right_panel">
<!--<div class="login1" >Already have a user account?<br/><a href="login.php">Login!</a></div>--><img src="images/splash.png"/>

</div>
<div id="ticker"><div id="gallery">

	<a href="#" class="show">
		<img src="js/slideshow/images/0.png" alt="Flowing Rock" width="200" height="392" title="" alt="" rel=""/>
	</a>
	
	<a href="#">
		<img src="js/slideshow/images/1.png" alt="Grass Blades" width="200" height="392" title="" alt="" rel=""/>
	</a>
	
	<a href="#">
		<img src="js/slideshow/images/2.png" alt="Ladybug" width="200" height="392" title="" alt="" rel=""/>
	</a>

	<a href="#">
		<img src="js/slideshow/images/3.png" alt="Lightning" width="200" height="392" title="" alt="" rel=""/>
	</a>
	
	<a href="#">
		<img src="js/slideshow/images/4.png" alt="Lotus" width="200" height="392" title="" alt="" rel=""/>
	</a>
	
	<a href="#">
		<img src="js/slideshow/images/5.png" alt="Mojave" width="200" height="392" title="" alt="" rel=""/>
	</a>
		
	<a href="#">
		<img src="js/slideshow/images/6.png" alt="Pier" width="200" height="392" title="" alt="" rel=""/>
	</a>
	
	<a href="#">
		<img src="js/slideshow/images/7.png" alt="Sea Mist" width="200" height="392" title="" alt="" rel=""/>
	</a>
	
	<a href="#">
		<img src="js/slideshow/images/8.png" alt="Stone" width="200" height="392" title="" alt="" rel=""/>
	</a>

	<div class="caption"><div class="content"></div></div>
</div>
<div class="clear"></div>
</div>
</div>
</div>
</body>
</head>
</html>
 <?php
	}
	?>