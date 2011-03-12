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
# File: E-Guest_show.pl
#
#----------------------------------------
#
# This is a full feature guestbook written
# in Perl.
# Working demo in http://leungeric.com/eric/demo/E-Guest_show.pl
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
$tbcolor = '000000';	# table border color
$tpadding = '5';	# table padding size
$tspacing = '5';	# table spacing size
$tcolor1 = 'dddddd';	# table color 1
$tcolor2 = '999999';	# table color 2

#========================================
# NO EDITING AFTER THIS LINE
#========================================

#========================================
# Solve and Set Query String
#----------------------------------------
# Check if query string. If yes, split
# the string and set them to different
# variables.
#========================================

if ($ENV{'QUERY_STRING'}) {
  ($s1,$s2,$s3,$s4) = split(/\&/,$ENV{'QUERY_STRING'});
  ($type1,$value1) = split(/\=/,$s1);
  ($type2,$value2) = split(/\=/,$s2);
  ($type3,$value3) = split(/\=/,$s3);
  ($type4,$value4) = split(/\=/,$s4);
  $start = $value1;
  $sort = $value2;
  $display = $value3;
  $search = $value4;
} else {
  $start = 0;
  $sort = lifo;
}

$stop = $start + $display;

#========================================
# Open Data File and Sort
#----------------------------------------
# Open the data file and according to the
# query string, sort the data in different
# ways
#========================================

open(temp,"$data");
  flock(temp, 2);
  @indata = <temp>;
  if ($sort eq lifo) { @datass = reverse(@indata); }
  elsif ($sort eq lilo) { @datass = @indata; }
  elsif ($sort eq name) { @datass = sort(@indata); }
close(temp);

#========================================
# Count Total
#----------------------------------------
# Open the data file and count how many
# entries are in the database.
#========================================

open(file,"$data");
  while(<file>) {
    $TheLine = $_;
    chomp($TheLine);
    $LineCount = $LineCount + 1;
  }
close(file);

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
      <b><a href=E-Guest_sign.pl>Sign Guestbook</a></b>
    </td>
  </tr>
~;

#========================================
# Search and Submit
#----------------------------------------
# This is the coding for the searching
# feature. Included an text input field
# and a submit button.
#========================================

print qq~

  <tr bgcolor=#$tcolor1>
    <td width=50% align=center>
      <font size=$fsize face=$fface color=$fcolor>
      <form name=form1>
      <input type=hidden name=display value=0>
      <input type=hidden name=sort value=$sort>
      <input type=hidden name=entry value=$display>
      <input type=text name=search size=10 style="font-family: Arial; font-size: 10pt" value=$search>
      <input type=submit value=Search style="font-family: Arial; font-size: 10pt" onSubmit="self.location=document.form1.display.value+document.form1.sort.value+document.form1.entry.value+document.form1.search.value">
      <input type=button value="Reset" style="font-family: Arial; font-size: 10pt" onClick="self.location='E-Guest_show.pl'">
    </td></form>
~;

#========================================
# Total Entries Message
#----------------------------------------
# This is the coding for the message
# which displays the total number of
# messages
#========================================

print qq~

 <td width=50% align=center>
      <font size=$fsize face=$fface color=$fcolor>
      There are $LineCount messages
    </td>
  </tr><form>
    <tr bgcolor=#$tcolor1>
    <td width=50% align=center> 
      <font size=$fsize face=$fface color=$fcolor>
      Display 
      <select style=\"font-family: Arial; font-size: 10pt\" onChange=\"if(this.options[this.selectedIndex].value!=0) self.location=this.options[this.selectedIndex].value\">
~;

#========================================
# Entry Number Menu
#----------------------------------------
# The drop down menu which control how many
# entries to be displayed per page.
# and If the option is using already, set
# it as selected.
#========================================

if ($display eq 5) {
  print "<option selected value=E-Guest_show.pl?display=$start&sort=$sort&entry=5&search=$search>5";
} else {
  print "<option value=E-Guest_show.pl?display=$start&sort=$sort&entry=5&search=$search>5";
}

if ($display eq 10) {
  print "<option selected value=E-Guest_show.pl?display=$start&sort=$sort&entry=10&search=$search>10";
} else {
  print "<option value=E-Guest_show.pl?display=$start&sort=$sort&entry=10&search=$search>10";
}

if ($display eq 15) {
  print "<option selected value=E-Guest_show.pl?display=$start&sort=$sort&entry=15&search=$search>15";
} else {
  print "<option value=E-Guest_show.pl?display=$start&sort=$sort&entry=15&search=$search>15";
}

if ($display eq 20) {
  print "<option selected value=E-Guest_show.pl?display=$start&sort=$sort&entry=20&search=$search>20";
} else {
  print "<option value=E-Guest_show.pl?display=$start&sort=$sort&entry=20&search=$search>20";
}

print qq~

    </select>
    per page
  </td></form><form>
  <td width=50% align=center>
    <font size=$fsize face=$fface color=$fcolor>
    Sort by
    <select style=\"font-family: Arial; font-size: 10pt\" onChange=\"if(this.options[this.selectedIndex].value!=0) self.location=this.options[this.selectedIndex].value\">
~;

#========================================
# Sort List Menu
#----------------------------------------
# The drop down menu which control how
# to sort the entries. Like LIFO, LILO
# or in alphabetical.
# and If the option is using already, set
# it as selected.
#========================================

if ($sort eq lifo) {
  print "<option selected value=E-Guest_show.pl?display=$start&sort=lifo&entry=$display&search=$search>Last entry first";
} else {
  print "<option value=E-Guest_show.pl?display=$start&sort=lifo&entry=$display&search=$search>Last entry first";
}

if ($sort eq lilo) {
  print "<option selected value=E-Guest_show.pl?display=$start&sort=lilo&entry=$display&search=$search>First entry first";
} else {
  print "<option value=E-Guest_show.pl?display=$start&sort=lilo&entry=$display&search=$search>First entry first";
}

if ($sort eq name) {
  print "<option selected value=E-Guest_show.pl?display=$start&sort=name&entry=$display&search=$search>Name alphabetically";
} else {
  print "<option value=E-Guest_show.pl?display=$start&sort=name&entry=$display&search=$search>Name alphabetically";
}

print "</select></td></form></tr><tr></tr><tr></tr>";

#========================================
# Format and Display Entries
#----------------------------------------
# With a FOR loop and condition, display
# the corresponding entries.
# Becos not all fields are required,
# Set if field value is here, display the
# corresponding code.
#========================================

$match = $start;
$matchcount = 0;

for($i = $start; $match < $stop && $i < $LineCount; $i++) {

$newdata = $datass[$i];
($name,$email,$UIN,$url,$place,$comment,$date) = split(/\|\|/,$newdata);

  if ($name =~ /$search/i) {
    $match++;
    $lastmatch = $i;
    $matchcount++;
    print "<tr bgcolor=#$tcolor1><td colspan=2>" if ($name);
    print "<font size=$fsize face=$fface color=$fcolor>" if ($name);
    print "<font color=#$alink><b>$name</b></font> <a href=\"mailto:$email\"><img src=email.gif border=0></a>\n" if ($name);
    print " <a href=\"$url\" target=\"_blank\"><img src=home.gif border=0></a>\n" if($url);
    print " <a href=http://wwp.icq.com/scripts/search.dll?to=$UIN><img src=icq.gif border=0></a>\n" if($UIN);
    print "<br>$place\n" if($place);
    print "<br>$comment\n" if($comment);
    print "<br>Date: $date\n" if ($name);
    print "</td></tr>" if ($name);
  }
}

#========================================
# No Matching Entry
#----------------------------------------
# If no matching entry is found in
# database, then display a message about
# it.
#========================================

if ($matchcount == 0) {

  print qq~
    <tr bgcolor=#$tcolor1><td colspan=2 align=center>
    <font size=$fsize face=$fface color=$fcolor>
    No matching entry found!
    </td></tr>
  ~;
  
}

#========================================
# Check for Next Matches
#----------------------------------------
# With a FOR loop, check if there are
# more matching entries.
# If yes, we'll display a NEXT link for
# going to the next page.
#========================================

$morematch = 0;
$findstart = $lastmatch + 1;

for($i = $findstart; $i < $LineCount; $i++) {
  $newdata = $datass[$i];
  ($name,$email,$UIN,$url,$place,$comment,$date) = split(/\|\|/,$newdata);

  if ($name =~ /$search/i) {
    $morematch++;
  }

}

#========================================
# Check for Prev Matches
#----------------------------------------
# With a FOR loop, check back the index
# number for the last page.
# Becos, number of entry to display and
# the search condition can be changed
# anytime, so we have to check the index
# number for the PREV link.
#========================================

$prevmatch = 0;
$prevstart = $start - 1;

for($i = $prevstart; $i >= 0 && $prevmatch < $display; $i--) {
  $newdata = $datass[$i];
  ($name,$email,$UIN,$url,$place,$comment,$date) = split(/\|\|/,$newdata);

  if ($name =~ /$search/i) {
    $prevmatch++;
    $previndex = $i;
  }

}

#========================================
# Display Next and Prev Links
#----------------------------------------
# After the checking, then we can decide
# if it'll display a NEXT and PREV links
# for going to the next or prev page.
#========================================

print "<tr></tr><tr></tr><tr>";
print "<td bgcolor=#$tcolor1 align=center><b><font size=$fsize face=$fface color=$fcolor><a href=\"E-Guest_show.pl?display=$previndex&sort=$sort&entry=$display&search=$search\">Prev $display</a></td>" if ($start > 0 && $prevmatch > 0);
print "<td bgcolor=#$tcolor1 align=center><b><font size=$fsize face=$fface color=$fcolor><a href=\"E-Guest_show.pl?display=$findstart&sort=$sort&entry=$display&search=$search\">Next $display</a></td>" if ($morematch > 0);

#========================================
# Print Page Footer & Demo ADV
#----------------------------------------
# This is the coding for the page footer.
# And there is a place for you to place your own ADV,
# change the ADV coding to anything you want.
#========================================

print "</tr></table>";

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