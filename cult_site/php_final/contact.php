<html>
<head>
<title>
Calming Wake: Contact
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
	$('#gallery .caption').css({opacity: 0.0});

	//Resize the width of the caption according to the image width
	$('#gallery .caption').css({width: $('#gallery a').find('img').css('width')});
	
	//Get the caption of the first image from REL attribute and display it
	$('#gallery .content').html($('#gallery a:first').find('img').attr('rel'))
	.animate({opacity: 0.0}, 400);
	
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
	$('#gallery .caption').animate({opacity: 0.0},100 ).animate({height: '100px'},500 );
	
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
height:271px;
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

#left_panel h2{
	
font-family:Verdana, Arial, Helvetica, sans-serif;
font-weight:lighter;
color:#bcafd6;
font-size:20px;
margin:5px 0px 0px 5px;


	
	
	
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

#login{
padding:5px;
font-family:Verdana, Arial, Helvetica, sans-serif;
font-weight:lighter;
color:#bcafd6;
font-size:13px;
margin:48px 0px 0px 240px;



}

.login1{
	
	background:#bcafd6 none;
	-moz-border-radius: 30px;
	color:#5565af;
	width:60px;
	-moz-box-shadow: 1px 1px 4px #000;
	border: solid #bcafd6 3px;
	margin:0px 0px 0px 0px;
}

.login1:hover {
	
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

#family{
background:url(looking-into-the-distance.png);
-moz-border-radius: 10px;
width:361px;
height:271px;
}

#family:hover{background:url(looking-into-the-distance1.png);
width:361px;
height:271px;

}

p{
padding:5px;
font-family:Verdana, Arial, Helvetica, sans-serif;
font-weight:lighter;
color:#bcafd6;
font-size:13px;
}

a:hover{
	color:#59263f;
}

#test { width:209px; height:365px; background-color:#06C;}

#content { width:830px;-moz-border-radius: 30px;}


#ticker{
width:200px;
height:392px;
-moz-border-radius: 15px;
background: #5565af no-repeat;
float:right;
border: solid #bcafd6 3px;
z-index:1;
margin:-407px 0px 0px 0px;
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



/* Slidshow CSS */
.clear {
	clear:both
}

#gallery {
	position:relative;
	height:392px
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
		z-index:600; 
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
<h2>Contact</h2>
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
<h2>Here is some contact information!</h2>
<p>(555) 555-5555</p>
<p>Lost One Lane Inn's Shadow, USA!</p>
<p>Come visit sometime! Or make an account and we can come get you!</p>
</div>
<div id="right_panel">
<a href="lies.html"><div id="family">

</div></a>
</div>
<div id="ticker"><div id="gallery">

	<a href="#" class="show">
		<img src="js/slideshow/images/0.png" alt="Flowing Rock" width="200" height="392" title="" alt="" rel="<h3>Flowing Rock</h3>Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. "/>
	</a>
	
	<a href="#">
		<img src="js/slideshow/images/1.png" alt="Grass Blades" width="200" height="392" title="" alt="" rel="<h3>Grass Blades</h3>Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. "/>
	</a>
	
	<a href="#">
		<img src="js/slideshow/images/2.png" alt="Ladybug" width="200" height="392" title="" alt="" rel="<h3>Ladybug</h3>Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur."/>
	</a>

	<a href="#">
		<img src="js/slideshow/images/3.png" alt="Lightning" width="200" height="392" title="" alt="" rel="<h3>Lightning</h3>Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."/>
	</a>
	
	<a href="#">
		<img src="js/slideshow/images/4.png" alt="Lotus" width="200" height="392" title="" alt="" rel="<h3>Lotus</h3>Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo."/>
	</a>
	
	<a href="#">
		<img src="js/slideshow/images/5.png" alt="Mojave" width="200" height="392" title="" alt="" rel="<h3>Mojave</h3>Nemo enim ipsam voluptatem quia voluptas sit aspernatur aut odit aut fugit, sed quia consequuntur magni dolores eos qui ratione voluptatem sequi nesciunt."/>
	</a>
		
	<a href="#">
		<img src="js/slideshow/images/6.png" alt="Pier" width="200" height="392" title="" alt="" rel="<h3>Pier</h3>Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua."/>
	</a>
	
	<a href="#">
		<img src="js/slideshow/images/7.png" alt="Sea Mist" width="200" height="392" title="" alt="" rel="<h3>Sea Mist</h3>Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat."/>
	</a>
	
	<a href="#">
		<img src="js/slideshow/images/8.png" alt="Stone" width="200" height="392" title="" alt="" rel="<h3>Stone</h3>Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur."/>
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