<?
  include ("config.php") ;

if (!$nick) {
$back = "<b><font size=5>Please enter your name. Go back and try again :)</font></b>";
echo $back;
exit;
}
else if (!$msg){
$backy = "<b><font size=5>Please enter a message. Go back and try again :)</font></b>";
echo $backy;
exit;
}
else {
$nick = strip_tags($nick);
$email = strip_tags($email);
$url = strip_tags($url);
$msg = eregi_replace(chr(13).chr(10)," <br> ",$msg);

if ($strip == 1){
        $msg = strip_tags($msg, "<br>");
}

if ($email){
if (!(eregi("([_\.0-9a-z-]+@([0-9a-z][0-9a-z-]+\.)+[a-z]{2,3})", $email))){
$blah = "<b><font size=5>Please enter a valid email address. :)</font></b>";
echo $blah;
exit;
}
}

if ($url != "http://" && $url != ""){
if (!(eregi("([_\.0-9a-z-]+.([0-9a-z][0-9a-z-]+\.)+[a-z]{2,3})", $url))){
$blaah = "<b><font size=5>Please enter a valid URL address. :)</font></b>";
echo $blaah;
exit;
}
}

$mesg = $msg;

if ((eregi("(((f|ht){1}tp://)[a-zA-Z0-9@:%_.~#-\?&]+[a-zA-Z0-9@:%_~#\?&/])", $mesg)) || (eregi("(www.[a-zA-Z0-9@:%_.~#-\?&]+[a-zA-Z0-9@:%_~#\?&/])", $mesg)) || (eregi("([_\.0-9a-z-]+@([0-9a-z][0-9a-z-]+\.)+[a-z]{2,3})", $mesg))){

$mesg = explode (" ", $mesg);
$size = sizeof($mesg);

for ($i=0; $i < $size; $i++){
if (eregi("(((f|ht){1}tp://)[a-zA-Z0-9@:%_.~#-\?&]+[a-zA-Z0-9@:%_~#\?&/])", $mesg[$i])){
$mesg[$i] = eregi_replace("$mesg[$i]", "[<a href=\"$mesg[$i]\" target=\"_blank\">link</a>]", $mesg[$i]);
}

else {
if (eregi("(www.[a-zA-Z0-9@:%_.~#-\?&]+[a-zA-Z0-9@:%_~#\?&/])", $mesg[$i])){
$mesg[$i] = eregi_replace("$mesg[$i]", "[<a href=\"http://$mesg[$i]\" target=\"_blank\">link</a>]", $mesg[$i]);
}
else {
if (eregi("([_\.0-9a-z-]+@([0-9a-z][0-9a-z-]+\.)+[a-z]{2,3})", $mesg[$i])){
$mesg[$i] = eregi_replace("$mesg[$i]", "[<a href=\"mailto:$mesg[$i]\">mail</a>]", $mesg[$i]);
}
else {
$mesg[$i] = wordwrap( $mesg[$i], 24, " ", 1);
}
}
}

}

$funny = "$mesg[0]";
for ($i=1; $i < $size; $i++){

$funny = "$funny $mesg[$i]";

}

$msg = $funny;

}



if ($smiley == 1){
$msg = ereg_replace(":\(", "<img src=\"images/sad.gif\">",$msg);
$msg = ereg_replace(":)", "<img src=\"images/smile.gif\">",$msg);
$msg = ereg_replace(":D", "<img src=\"images/laugh.gif\">",$msg);
$msg = ereg_replace(":P", "<img src=\"images/tongue.gif\">",$msg);
$msg = ereg_replace(";)", "<img src=\"images/wink.gif\">",$msg);
$msg = ereg_replace(";D", "<img src=\"images/smilehard.gif\">",$msg);
$msg = ereg_replace(":o", "<img src=\"images/shocked.gif\">",$msg);
$msg = ereg_replace("8)", "<img src=\"images/cool.gif\">",$msg);
$msg = ereg_replace("\=)", "<img src=\"images/rolleyes.gif\">",$msg);
$msg = ereg_replace(":-\[", "<img src=\"images/embarassed.gif\">",$msg);
}

if ($show_date == 1){
        $date = date("F d Y");
}
if ($show_time == 1){
        $time = date("h:i a");
}

if ($entries == 0 || $entries < 0){
        $entries = 20;
}
if ($entries > 30){
        $entries = 20;
}
if ($entries != 0 && $entries > 0){
        $count = $entries;
}
$mail = "mailto:$email";
if ($show_time == 1 && $show_date == 1){
        $message = "<tr><td bgcolor=\"$namebgc\" width=\"100%\" height=\"3\" colspan=\"4\"></td></tr><tr><td bgcolor=\"$namebgc\" width=\"1%\"></td><td bgcolor=\"$namebgc\" width=\"99%\" colspan=\"3\"><font face=\"Tahoma\" size=\"2\" color=\"$namecolor\"><b>Name:&nbsp;</b>$nick<br><b>Email:&nbsp;</b><a href=$mail>$email</a><br><b>URL:&nbsp;</b><a href=$url>$url</a><br><br></font></td></tr><tr><td bgcolor=\"$messagebgc\" width=\"1%\"></td><td bgcolor=\"$messagebgc\" width=\"99%\" colspan=\"3\"><font face=\"Tahoma\" size=\"2\" color=\"$messagecolor\"><br>$msg<br><br></font></td></tr><tr><td bgcolor=\"$messagebgc\" width=\"100%\" colspan=\"4\" align=\"right\"><font face=\"Tahoma\" size=\"1\" color=\"$datecolor\">$date - $time</font></td></tr><tr><td bgcolor=\"#000000\" width=\"100%\" height=\"1\" colspan=\"4\"></td></tr><tr><td bgcolor=\"$linebgc\" width=\"100%\" height=\"4\" colspan=\"4\"></td></tr><tr><td bgcolor=\"#000000\" width=\"100%\" height=\"1\" colspan=\"4\"></td></tr>";
}
if ($show_time == 1 && $show_date != 1){
        $message = "<tr><td bgcolor=\"$namebgc\" width=\"100%\" height=\"3\" colspan=\"4\"></td></tr><tr><td bgcolor=\"$namebgc\" width=\"1%\"></td><td bgcolor=\"$namebgc\" width=\"99%\" colspan=\"3\"><font face=\"Tahoma\" size=\"2\" color=\"$namecolor\"><b>Name:&nbsp;</b>$nick<br><b>Email:&nbsp;</b><a href=$mail>$email</a><br><b>URL:&nbsp;</b><a href=$url>$url</a><br><br></font></td></tr><tr><td bgcolor=\"$messagebgc\" width=\"1%\"></td><td bgcolor=\"$messagebgc\" width=\"99%\" colspan=\"3\"><font face=\"Tahoma\" size=\"2\" color=\"$messagecolor\"><br>$msg<br><br></font></td></tr><tr><td bgcolor=\"$messagebgc\" width=\"100%\" colspan=\"4\" align=\"right\"><font face=\"Tahoma\" size=\"1\" color=\"$datecolor\">$time</font></td></tr><tr><td bgcolor=\"#000000\" width=\"100%\" height=\"1\" colspan=\"4\"></td></tr><tr><td bgcolor=\"$linebgc\" width=\"100%\" height=\"4\" colspan=\"4\"></td></tr><tr><td bgcolor=\"#000000\" width=\"100%\" height=\"1\" colspan=\"4\"></td></tr>";
}
if ($show_time != 1 && $show_date == 1){
        $message = "<tr><td bgcolor=\"$namebgc\" width=\"100%\" height=\"3\" colspan=\"4\"></td></tr><tr><td bgcolor=\"$namebgc\" width=\"1%\"></td><td bgcolor=\"$namebgc\" width=\"99%\" colspan=\"3\"><font face=\"Tahoma\" size=\"2\" color=\"$namecolor\"><b>Name:&nbsp;</b>$nick<br><b>Email:&nbsp;</b><a href=$mail>$email</a><br><b>URL:&nbsp;</b><a href=$url>$url</a><br><br></font></td></tr><tr><td bgcolor=\"$messagebgc\" width=\"1%\"></td><td bgcolor=\"$messagebgc\" width=\"99%\" colspan=\"3\"><font face=\"Tahoma\" size=\"2\" color=\"$messagecolor\"><br>$msg<br><br></font></td></tr><tr><td bgcolor=\"$messagebgc\" width=\"100%\" colspan=\"4\" align=\"right\"><font face=\"Tahoma\" size=\"1\" color=\"$datecolor\">$date</font></td></tr><tr><td bgcolor=\"#000000\" width=\"100%\" height=\"1\" colspan=\"4\"></td></tr><tr><td bgcolor=\"$linebgc\" width=\"100%\" height=\"4\" colspan=\"4\"></td></tr><tr><td bgcolor=\"#000000\" width=\"100%\" height=\"1\" colspan=\"4\"></td></tr>";
}
if ($show_time != 1 && $show_date != 1){
        $message = "<tr><td bgcolor=\"$namebgc\" width=\"100%\" height=\"3\" colspan=\"4\"></td></tr><tr><td bgcolor=\"$namebgc\" width=\"1%\"></td><td bgcolor=\"$namebgc\" width=\"99%\" colspan=\"3\"><font face=\"Tahoma\" size=\"2\" color=\"$namecolor\"><b>Name:&nbsp;</b>$nick<br><b>Email:&nbsp;</b><a href=$mail>$email</a><br><b>URL:&nbsp;</b><a href=$url>$url</a><br><br></font></td></tr><tr><td bgcolor=\"$messagebgc\" width=\"1%\"></td><td bgcolor=\"$messagebgc\" width=\"99%\" colspan=\"3\"><font face=\"Tahoma\" size=\"2\" color=\"$messagecolor\"><br>$msg<br><br></font></td></tr><tr><td bgcolor=\"$messagebgc\" width=\"100%\" colspan=\"4\" align=\"right\"></td></tr><tr><td bgcolor=\"#000000\" width=\"100%\" height=\"1\" colspan=\"4\"></td></tr><tr><td bgcolor=\"$linebgc\" width=\"100%\" height=\"4\" colspan=\"4\"></td></tr><tr><td bgcolor=\"#000000\" width=\"100%\" height=\"1\" colspan=\"4\"></td></tr>";
}

$fcontents = join ( '', file ( "messages.txt"));
$check = file ("messages.txt");
$thing = "true";
$checker = "$message\n";

for ($i=0; $i < $count; $i++){
if ($checker == "$check[$i]"){
$thing = "false";
}
}
if ($thing == "true"){
$fp = fopen ("messages.txt", "w");
fwrite ($fp, "$message\n");
fwrite ($fp, $fcontents);
fclose ($fp);
if ($entries != 0 && $entries > 0){
$jpmaster = file ("messages.txt");
$fpp = fopen ("messages.txt", "w");
for ($i=0; $i < $count; $i++){
fwrite ($fpp, $jpmaster[$i]);
}
}
fclose ($fpp);
}
}
?>

<html>
<head>
<META HTTP-EQUIV="refresh" CONTENT="0;URL=entries.php">
<title>GUESTBOOK M.E. REDIRECTING...please wait</title>
</head>
</html>