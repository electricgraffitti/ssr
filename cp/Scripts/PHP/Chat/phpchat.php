<?php
// --------------------------------------------------------
// PHP Chat v002a
// Written by Maxime Labelle - info@vt220.com
//
// Will write chat into file chat.txt (Must be chmod 777)
// - Support diffrent file names
// - Support variable number of line display
// - Strip HTML code
//
// http://www.vt220.com
// --------------------------------------------------------
// SETTINGS

	$admin_pwd="change_me";		// Admin password !! CHANGE THIS
					// or it will NOT work..

	$me="phpchat.php";      	// This file name (important)

	$room="vt220.com";		// Chat room name

	$file_name="chat.db"; 		// File name of the database

	$number_of_lines="100"; 	// Number of line to display in window

	$strip_html="1"; 		// Set this to 0 if you want to 
			 		// allow users to use HTML code
			 		// in the chat window (NOT GOOD)

	$window_width="600";		// You should not change this
	$window_height="250";		// if you are not an expert..

// --------------------------------------------------------
// DO NOT EDIT BELOW THIS LINE
// --------------------------------------------------------
	if (!file_exists("$file_name")) {
		$fp=fopen($file_name,"w");
		fputs($fp,"");		// create empty file
		fclose($fp);		// close file pointer
	}

	if ($refresh == "") { $refresh=3; }
	if ($refresh == "0") { $selected[0]=selected; }
	if ($refresh == "1") { $selected[1]=selected; }
	if ($refresh == "2") { $selected[2]=selected; }
	if ($refresh == "3") { $selected[3]=selected; }
	if ($refresh == "4") { $selected[4]=selected; }
	if ($refresh == "5") { $selected[5]=selected; }
	if ($refresh == "6") { $selected[6]=selected; }
	if ($refresh == "10") { $selected[7]=selected; }
	if ($refresh == "99999") { $selected[8]=selected; }

	if ($nick == "") { $nick="guest"; }
	if ($nick != "" && $text != "" && $nick != " " && $text != " ") {
		if ($strip_html == "1") {
			$text = str_replace ("|", " ", $text); $nick = str_replace ("|", " ", $nick);
			$text = strip_tags($text); $nick = strip_tags($nick);
			$text = stripslashes($text); $nick = stripslashes($nick);
		}
			$fp=fopen($file_name,a); $suc=fputs($fp, "<<b>$nick</b>> $text <br>\n"); $suc=fclose ($fp); 
	}

	if ($mode == "chat") {
	echo "<html><head><title></title><META HTTP-EQUIV=refresh CONTENT=\"";
	echo $refresh; echo ";URL="; echo $me; echo "?refresh="; echo $refresh;
	echo "&mode=chat\"></head><body bgcolor=cccccc text=000000><font face=verdana size=-1><table border=0 width=90%><tr><td><font face=verdana size=-1><div align=justify>";
	$datapre = file("$file_name"); $rows = count($datapre); $y=0;
	for($x=$rows;($x>=0 && $y<=$number_of_lines);$x--) {
		$data = explode("¦¦",$datapre[$x]); echo "$data[0]";$y++;
		}
	echo "<br></font></td></tr></table></body></html>";
	}
	if ($mode == "showall") {
	echo "<html><head><title></title></head><body bgcolor=cccccc text=000000><div align=center><font face=verdana size=-1><i><b>Complete PHP Room message listing...</b></i><br><br><table border=0 width=80%><tr><td><font face=verdana size=-2><div align=justify>";
	include("$file_name");
	echo "<br></font></td></tr></table></body></html>";
	return;
	}
	if ($mode == "admin") {
	if ($pwd == "change_me") { echo "Change the default password, please.."; return; }
	if ($pwd == $admin_pwd) { 
	echo "Control Panel will allow you to:<br>";
	echo "- Ban user ip address..<br>";
	echo "- Remove lines..<br>";
	echo "- Clear the room<Br>";
	echo "- Change color settings<br>";
	echo "- Change table size settings<br>";
	echo "- Change Chat settings: buffer size, tag stripping, etc..";

	echo "<br><br><a href=/>Logout</a>"; return; 
	}
	if ($pwd != $admin_pwd) {
		echo "<Br><br><div align=center><table width=60% border=1 cellpadding=0 cellspacing=0><tr><td><FORM METHOD=POST \""; echo $PHP_SELF; echo "?mode=admin"; echo "\">";
		echo "<Br><div align=center><font face=verdana size=-1><b>Enter Admin password</b> : <input name=pwd type=password> <input type=submit name=insert value=submit class=button><br><br></td></tr></table></div>";
		return;
		}
	}

	if ($mode == "") {
	echo "<div align=center><FORM METHOD=POST \""; echo $PHP_SELF; echo "?nick=";
	echo $nick; echo "\"><table width="; echo $window_width; echo " border=0 cellpadding=0 cellspacing=0><tr><td><div align=center><font face=verdana size=-1><b>php chat @ ";
	echo $room; echo "</b></div><br><iframe name=cwindow width="; echo $window_width;
	echo " height="; echo $window_height; echo " src=\"";
	echo $me; echo "?mode=chat&refresh="; echo $refresh; echo "&nick="; echo $nick;
	echo "\"></iframe><table width=100% border=0><tr><td><font face=verdana size=-1>";
	$lines  = count(file($file_name));
	echo "<i>"; echo $lines; echo " messages in <a href="; echo $me;
	echo "?mode=showall target=_blank>"; echo "room</a>.</i> | <a href=";
	echo $me; echo "?mode=admin target=_blank><i>login</i></a>";
	echo "</td><td><div align=right><font face=verdana size=-1>speed ";
	echo "<SELECT NAME=refresh SIZE=1 class=choice><OPTION VALUE=0 "; echo $selected[0];
	echo ">fastest<OPTION VALUE=1 "; echo $selected[1]; echo ">Very fast<OPTION VALUE=2 "; echo $selected[2]; 
	echo ">Fast<OPTION VALUE=3 "; echo $selected[3]; echo ">Normal<OPTION VALUE=4 "; echo $selected[4]; echo ">slow<OPTION VALUE=5 "; echo $selected[5]; echo ">more slow<OPTION VALUE=6 "; echo $selected[6]; 
	echo ">very slow<OPTION VALUE=10 "; echo $selected[7]; echo ">slowest<OPTION VALUE=99999 "; echo $selected[8]; echo ">off</SELECT>";
	echo "</div></td></tr></table><table border=0 width=100%><tr><td><font face=verdana size=-2><</td><td><input type=text value=";
	echo $nick; echo " name=nick size=8 class=form MAXLENGTH=8><font face=verdana size=-2> ></td><td><font face=verdana size=-2>:</td><td><div align=center><input type=text name=text size=50 class=form MAXLENGTH=128></td><td><div align=right><input type=submit name=insert value=send. class=button> <input type=reset name=Clear_form value=clear. class=button></td></tr></table></form></td></tr></table></center>";
	}
?>
