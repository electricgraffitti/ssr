#!/usr/bin/perl
#========================================
#
# Script:	E-Guest
# Version:	1.1
# Date:		1 April 2001
# Author:	Leung Eric
# Email:	eric@leungeric.com
# Homepage:	http://leungeric.com
#
#----------------------------------------
#
# File: E-Guest_sign.pl
#
#----------------------------------------
#
# This is a full feature guestbook written
# in Perl.
# Working demo in http://leungeric.com/eric/demo/E-Guest_sign.pl
#
# - Multi-pages display
# - Sort entry (LIFO, LILO, alphabetical)
# - Set number of entries per page
# - Search for matching name
# - Total entries count
# - Message for no matching found
# - Dynamic icon display
# - Dynamic Next and Prev link display
# - Checking for required field
# - Warning messages for missing fields
# - Entry preview after submitted
# - URL fixing if "http://" is missing
# - HTML tag filtering
# - Multiple line in comment support
#
#----------------------------------------
#
# INSTALLATION:
#
# - change the first line of the scripts to your perl path.
# - edit the list of variables for both E-guest-view.pl and E-Guest-sign.pl scripts.
# - upload all the files to your cgi-bin
# - chmod E-guest-view.pl and E-Guest-sign.pl to 755
# - DONE
#
# - To show the guestbook (http://yourdomain.com/cgi-bin/E-Guest_show.pl) 
# - To sign the guestbook (http://yourdomain.com/cgi-bin/E-Guest_sign.pl) 
#
#========================================

#========================================
# Set Variables
#----------------------------------------
# Those are list of variables which define
# the apperance for the guestbook.
#========================================

#========================================
# START EDITING HERE
#========================================

$data = 'cp/scripts/perl/guestbook/E-Guest_db.txt';	# path for data file

$title = 'E-Guest Demo (Perl CGI Guestbook System)';	# page title
$bgcolor = '3C507D';	# background color
$display = '10';	# default # of entries to display per page

$fsize = '2';		# font size
$fface = 'Arial';	# font face
$fcolor = '000000';	# font color

$alink = '003388';	# link color
$avisited = '003388';	# visited link color
$ahover = '2255AA';	# hover link color

$twidth = '550';	# table width
$talign = 'center';	# table align (left/right/center)
$tborder = '1';		# table border size
$tbcolor = '000000';	# table orbder color
$tpadding = '5';	# table padding size
$tspacing = '5';	# table spacing size
$tcolor1 = 'dddddd';	# table color 1
$tcolor2 = '999999';	# table color 2

#========================================
# NO EDITING AFTER THIS LINE
#========================================

#========================================
# Get Form Fields Values
#----------------------------------------
# To get the values of the fields. 
# Assign variables for each of the field's
# value.
#========================================

if ($ENV{"REQUEST_METHOD"} eq 'GET') {
  $buffer = $ENV{'QUERY_STRING'};
}
else {
  read(STDIN, $buffer, $ENV{'CONTENT_LENGTH'});
}

@pairs = split(/&/, $buffer);
foreach $pair (@pairs) {
        ($name, $value) = split(/=/, $pair);
        $value =~ tr/+/ /;
        $value =~ s/%([a-fA-F0-9][a-fA-F0-9])/pack("C", hex($1))/eg;
        $FORM{$name} = $value;
}

$fullname = $FORM{'fullname'};
$email = $FORM{'email'};
$homepage = $FORM{'homepage'};
$uin = $FORM{'uin'};
$location = $FORM{'location'};
$comment = $FORM{'comment'};
$action = $FORM{'action'};

#========================================
# Check and Fix Homepage Content
#----------------------------------------
# To check if the user input homepage value
# and if user input "http://" at the 
# beginning of the string or not,
# if not, add the "http://" to fix it.
#========================================

if ($homepage && $homepage =~ /^http:\/\//){
$homepage = "$homepage";
} elsif ($homepage) {
$homepage = "http://$homepage";
}

#========================================
# Construct Date String
#----------------------------------------
# Standard construction for the date and 
# time variable.
#========================================

@days = ('Sunday','Monday','Tuesday','Wednesday','Thursday','Friday','Saturday');
@months = ('January','Feburary','March','April','May','June','July','August','September',
			'October','November','December');
($sec, $min, $hour, $mday, $mon, $year, $wday, $yday, $isdst) = gmtime(time);
	if($hour < 10) { $hour = "0$hour"; }
	if ($min < 10) { $min = "0$min"; }
	if ($sec < 10) { $sec = "0$sec"; }
        $saveyear = ($year % 100);
	$year = 1900 + $year;

	$date = "$days[$wday], $months[$mon] $mday, $year";

#========================================
# Check for Required Fields
#----------------------------------------
# Checking for the values for Full name, Email
# and Comment. If it's empty, add warning
# message in the variable $msg. Check for
# value UIN, homepage and email address format.
#========================================

if ($action eq add && $fullname eq '') {
$msg .= "Please fill in the \"Full name\" field!<br>"; 
}

if ($action eq add && $email eq '') {
$msg .= "Please fill in the \"Email\" field!<br>"; 
}

if ($action eq add && $comment eq '') {
$msg .= "Please fill in the \"Comment\" field!<br>"; 
}

if ($action ne add || $email eq '' || $email =~ /\@/i) {
} else {
$msg .= "Invalid address in \"Email\" field!<br>";
$format = Bad;
}

if ($action ne add || $homepage eq '' || $homepage =~ /\./i) {
} else {
$msg .= "Invalid address in \"Homepage\" field!<br>"; 
$format = Bad;
}

if ($action eq add && $uin ne '' && $uin =~ /[A-Z]/i) {
$msg .= "Invalid address in \"UIN\" field!<br>"; 
$format = Bad;
}

#========================================
# Print Page Header
#----------------------------------------
# This is the coding for the heading of
# the page.
#========================================

print "Content-Type: text/html\n\n";

print qq~
<!-- E-Guest guestbook system 1.1 -->
<!-- powered by leungeric.com --> 

<html><head><title>$title</title></head>
<style>
A:link {text-decoration: none; color: #$alink}
A:visited {text-decoration: none; color: #$avisited}
A:hover {text-decoration: underline; color: #$ahover}
</style>
<body bgcolor=#$bgcolor>

<table width=$twidth bgcolor=#$tcolor2 align=$talign cellpadding=$tpadding cellspacing=$tspacing border=$tborder bordercolor=#$tbcolor>
  <tr bgcolor=#$tcolor1 align=center>
    <td>
      <font face=$fface color=$fcolor><b>$title
      <p align=right><font size=1>powered by <a href=http://leungeric.com target=_blank>leungeric.com</a>

    </td>
  </tr>
</table>
<p>
<table width=$twidth bgcolor=#$tcolor2 align=$talign cellpadding=$tpadding cellspacing=$tspacing border=$tborder bordercolor=#$tbcolor>
  <tr bgcolor=#$tcolor1>
    <td colspan=2 align=center>
      <font size=$fsize face=$fface color=$fcolor>
      <b><a href=E-Guest_show.pl>View Guestbook</a></b>
    </td>
  </tr>
  <tr></tr><tr></tr>
~;

#========================================
# Check and Display Warning Message
#----------------------------------------
# If the required fields are missing,
# display the warning message in order to
# submit the entry.
#========================================

if ($msg) {
print qq~
  <tr bgcolor=#$tcolor1>
    <td colspan=2><font size=$fsize face=$fface color=#ff0000>$msg</td>
  </tr>
  <tr></tr><tr></tr>
~;
}

#========================================
# Displaying Sign Form 
#----------------------------------------
# Display the signning form if all required
# fields are empty.
#========================================

if ($fullname eq '' || $email eq '' || $comment eq '' || $format eq Bad) {
print qq~
  <form action="E-Guest_sign.pl" method=post>
  <tr bgcolor=#$tcolor1>
    <td><font size=$fsize face=$fface color=$fcolor>Full Name :</td>
    <td><input type=text name="fullname" value="$fullname" style="font-family: Arial; font-size: 10pt"> <font color=#$alink><b>*</b></td>
  </tr>
  <tr bgcolor=#$tcolor1>
      <td><font size=$fsize face=$fface color=$fcolor>Email :</td>
      <td><input type=text name="email" value="$email" style="font-family: Arial; font-size: 10pt"> <font color=#$alink><b>*</b> <font color=#$alink><b>#</b></td>
  </tr>
  <tr bgcolor=#$tcolor1>
      <td><font size=$fsize face=$fface color=$fcolor>Homepage :</td>
      <td><input type=text name="homepage" value="$homepage" style="font-family: Arial; font-size: 10pt"> <font color=#$alink><b>#</b></td>
  </tr>
  <tr bgcolor=#$tcolor1>
      <td><font size=$fsize face=$fface color=$fcolor>UIN :</td>
      <td><input type=text name="uin" value="$uin" style="font-family: Arial; font-size: 10pt"> <font color=#$alink><b>#</b></td>
  </tr>  
  <tr bgcolor=#$tcolor1>
      <td><font size=$fsize face=$fface color=$fcolor>Location :</td>
      <td><input type=text name="location" value="$location" style="font-family: Arial; font-size: 10pt"></td>
  </tr>
  <tr bgcolor=#$tcolor1>
    <td><font size=$fsize face=$fface color=$fcolor>Comment :</td>
    <td>
      <textarea name="comment" cols=47 rows=5 wrap=on style="font-family: Arial; font-size: 10pt">$comment</textarea> <font color=#$alink><b>*</b> <font color=#$alink><b>!</b>
    </td>
  </tr>
  <tr></tr><tr></tr>
  <tr bgcolor=#$tcolor1>
  <td colspan=2 align=center>
    <input type=submit value=" Sign Guestbook " style="font-family: Arial; font-size: 10pt">
    <input type=reset value=" Reset " style="font-family: Arial; font-size: 10pt">
    <input type=hidden name="action" value="add">
  </td>
  </tr></form>
  <tr></tr><tr></tr>
  <tr bgcolor=#$tcolor1>
    <td colspan=2>
    <font color=#$alink><b>*</b> <font size=1 face=$fface color=$fcolor>Required field</font>
    <font color=#$alink><b>!</b> <font size=1 face=$fface color=$fcolor>Multiple line support, HTML tag filtering</font>
    <font color=#$alink><b>#</b> <font size=1 face=$fface color=$fcolor>Valid format checking</font>
    </td>
  </tr>
~;
} else {

#========================================
# Check and Fix Comment Content
#----------------------------------------
# To check for any < and > and change them
# to special HTML tag to prevent harm to
# the guestbook. And change newline to <BR>
# which is to support for multiple lines.
#========================================

$comment =~ s/</&lt;/g;
$comment =~ s/>/&gt;/g;
$comment =~ s/\n/<br>/g;

#========================================
# Confirm Signned and Preview
#----------------------------------------
# If passed all checking, add the entry into
# database and display message and preview.
#========================================

open(datas,">>$data");
flock(datas, 2);
print datas "$fullname||$email||$uin||$homepage||$location||$comment||$date\n";
close(datas);

print qq~
<tr bgcolor=#$tcolor1>
  <td colspan=2>
    <font size=$fsize face=$fface color=$fcolor>
    There following are what you submitted. You can follow the above link to view the guestbook entries.
  </td>
</tr>
<tr></tr><tr></tr>
<tr bgcolor=#$tcolor1>
  <td colspan=2>
    <font size=$fsize face=$fface color=$fcolor>
    <font color=#$alink><b>$fullname</b></font> <a href=\"mailto:$email\"><img src=email.gif border=0></a>
~;

print " <a href=\"$homepage\" target=\"_blank\"><img src=home.gif border=0></a>\n" if($homepage);
print " <a href=\"$uin\"><img src=icq.gif border=0></a>\n" if($uin);
print "<br>$location\n" if($location);

print qq~

<br>$comment
<br>Date: $date
</td>
</tr>
~;
}

#========================================
# Print Page Footer & Demo ADV
#----------------------------------------
# This is the coding for the page footer.
# And there is a place for you to place your own ADV,
# change the ADV coding to anything you want.
#========================================

print "</table>";

print qq~

<p><table width=$twidth bgcolor=#$tcolor2 align=$talign cellpadding=$tpadding cellspacing=$tspacing border=$tborder bordercolor=#$tbcolor>
  <tr bgcolor=#$tcolor1 align=center>
    <td align=center>
      <font face=$fface color=$fcolor size=$fsize><b>Learn more about Perl</b></font>
      <br>
<A HREF="http://www.amazon.com/exec/obidos/ASIN/0596000278/leungericcom-20" target=_blank>
<IMG SRC="http://leungeric.com/eric/book/0596000278.01.TZZZZZZZ.jpg" border="0" alt="cover" hspace="3" vspace="3"></A>

<A HREF="http://www.amazon.com/exec/obidos/ASIN/0201615711/leungericcom-20" target=_blank>
<IMG SRC="http://leungeric.com/eric/book/0201615711.01.TZZZZZZZ.jpg" border="0" alt="cover" hspace="3" vspace="3"></A>

<A HREF="http://www.amazon.com/exec/obidos/ASIN/020135358X/leungericcom-20" target=_blank>
<IMG SRC="http://leungeric.com/eric/book/020135358X.01.TZZZZZZZ.gif" border="0" alt="cover" hspace="3" vspace="3"></A>

<A HREF="http://www.amazon.com/exec/obidos/ASIN/0966942604/leungericcom-20" target=_blank>
<IMG SRC="http://leungeric.com/eric/book/0966942604.01.TZZZZZZZ.jpg" border="0" alt="cover" hspace="3" vspace="3"></A>

<A HREF="http://www.amazon.com/exec/obidos/ASIN/0201700549/leungericcom-20"  target=_blank>
<IMG SRC="http://leungeric.com/eric/book/0201700549.01.TZZZZZZZ.jpg" border="0" alt="cover" hspace="3" vspace="3"></A>

<A HREF="http://www.amazon.com/exec/obidos/ASIN/0764507761/leungericcom-20"  target=_blank>
<IMG SRC="http://leungeric.com/eric/book/0764507761.01.TZZZZZZZ.jpg" border="0" alt="cover" hspace="3" vspace="3"></A>

    </td>
  </tr>
</table>

~;


print "</body></html>";

#========================================
# End of File
#========================================