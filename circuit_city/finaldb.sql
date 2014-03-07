DROP DATABASE IF EXISTS loper_final;
CREATE DATABASE IF NOT EXISTS loper_final;
USE loper_final;

CREATE TABLE items_table (
	itemsID INT(5) PRIMARY KEY AUTO_INCREMENT,
	item_name CHAR(50),
	item_price DEC(3,2),
	item_amount INT(3),
	item_description TEXT,
	item_image CHAR(25),
	item_thumb CHAR(25),
	item_stat CHAR(30),
	item_stat2 CHAR(30),
	item_stat3 CHAR(30)
	
) TYPE=InnoDB;


INSERT INTO items_table
	(item_name, item_price, item_amount, item_description, item_image, item_thumb, item_stat)
	VALUES
	("Element 15.4 LCD HDTV", 219.99, 3, "This TV is one of the better TVs out there because it includes a built-in HD TV tuner.", "TV_image.jpg", "TV_thumb.jpg", "Screen resolution: 1280 x 800"),
	("Sony Blu-ray Disc Player", 399.99, 2, "This Sony Blu-ray Disc Player is one of our very stylish Blu-ray Disc Players. It has the ability to play Blu-Ray discs and all of your old DVDs, and it is a very attractive addition to any home.", "blu-ray_image.jpg", "blu-ray_thumb.jpg", "Progressive scan: Yes"),
	("Apple 80GB iPod classic – Black (MB147LL/A)", 237.49, 5, "This iPod isn't 60GB, but it's 80GB! It is in a very stylish case. This iPod can holg up to 20,000 songs, and it has up to 30-hrs of battery life!", "iPod_image.jpg", "iPod_thumb.jpg", "Holds up to 20,000 songs"),
	("Proview PL713B2 17” Monitor (PL713B2)", 37.96, 2, "This screen will enchance your visuals on your computer. It has a resolution of 1280 x 1024, and is compatible with mostly every computer you can hook a monitor up to!", "monitor_image.jpg", "monitor_thumb.jpg", "1280 x 1024 resolution"),
	("Kensington Ci65M Wireless Laptop Optical Mouse", 17.99, 5, "This mouse is wireless, and it also has a battery indicator so you now when your about to run out.", "mouse_image.jpg", "mouse_thumb.jpg", "Wireless Mouse"),
	("Canon PowerShot SD750 7.1-Megapixel Digital Camera - Silver", 199.99, 3, "The PowerShot SD 750 is a powerful compact camera with a 7.1 million pixel sensor. It is more than capable of superior-quality prints at sizes even larger than 13 x 19, which makes the SD750 great for almost any situation. The genuine Canon 3x optical zoom UA lens lets you get up close before you take your shot, and the additional 4x digital zoom lets you enlarge the details before or after shooting.", "camera_image.jpg", "camera_thumb.jpg", "7.1 megapixels"),
	("HP iPAQ 211 Enterprise Handheld PDA", 449.99, 2, "Whether you're an IT manager or a mobile professional, you can maximize your business results with an organizer that makes the most of your on-the-go style. The powerful iPAQ 211 Enterprise Handheld will run your work applications and a broad range of third-party solutions. The large 4 inch touch screen means excellent viewing in a variety of light conditions. It has robust SDIO expansion. And it lets you connect to the Internet and get e-mail at the office and in Wi-Fi hot spots in airports, cafes, and hotels.", "PDA_image.jpg", "PDA_thumb.jpg", "4 inch TFT touch screen"),
	("Canon HV20 HD Camcorder", 729.96, 3, "MiniDV media keeps this camcorder compact for easy transport. Weighing less than a pound, it's perfect for one-handed operation. Capture your surroundings in true 1080 high-definition resolution video. The 16:9 format gives you professional, top-quality video. This camcorder also has a standard definition option for viewing on non-HD equipment. The HV20 has a CMOS processing chip rather than a CCD. CMOS chips allow for more precise image processing which means that individual pixels can be targeted for correction rather than the entire image, which is how most CCDs work. Also, CMOS chips perform a lot more of the image processing on-chip, which cuts down on power consumption.", "camcorder_image.jpg", "camcorder_thumb.jpg", "10x optical zoom"), 
	("Fellowes Powershred P-57Cs Shredder", 69.99, 4, "The Powershred P-57Cs shreds your sensitive documents into confetti-cut particles (5/32” x 2”) for higher security and less bulk waste. The durable steel cutters also accept credit cards, staples and small paper clips. The P-57Cs shreds up to 8 sheets per pass, 10-20 times per day, for a total daily capacity as high as 160 sheets. Equipped with a 9 inch paper entry, the P-57Cs easily accepts standard letter or legal size documents. The patented SafeSense technology stops shredder immediately when paper entry is touched. An auto start/stop feature ensures quick, easy shredder operation. The P-57Cs also has a pivoting head with a handle that allows quick, easy waste removal from 5-gallon wastebasket.", "shredder_image.jpg", "shredder_thumb.jpg", "Confetti-cut shredder"),
	("Texas Instruments Advanced Graphing Calculator", 149.99, 3, "The Texas Instruments TI-89 Titanium graphing calculator is a quick and comprehensive tool for math and science operations, as well as the humanities. The 2.7MB user-available FLASH™ ROM lets you download software applications to your calculator, similar to programs you download to a computer. It has 24MB of available memory. Transfer data to your computer and between calculators with ease. This graphing calculator hosts a wide variety of software applications, so you can download software applications and customize your calculator for use in a wide variety of subjects, including business, languages, science, study tools, mathematics, software development and the humanities.", "calculator_image.jpg", "calculator_thumb.jpg", "2.7MB FLASH™ ROM memory");


SELECT * FROM items_table;
	



CREATE TAblE user_table (
		userID INT(5) PRIMARY KEY AUTO_INCREMENT,
		username CHAR(50),
		user_pw CHAR(50),
		user_priv ENUM("none", "user", "administrator"),
) TYPE=InnoDB;

INSERT INTO user_table
		(username, user_pw, user_priv)
		VALUES
		("Red9x", "lol", "administrator"),
		("Blue7", "yay", "user");


SELECT * FROM user_table;
	
	