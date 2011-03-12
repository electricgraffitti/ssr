 <?
include ("config.php")
?>
<html>
<head>
<title>Setup my Guestbook</title>
</head>
<script language="javascript">
function AddText(NewCode) {
        document.Jpmaster.msg.value+=NewCode;
        document.Jpmaster.msg.focus();
}
function smile(){
        AddTxt=" :)";
        AddText(AddTxt);
}
function sad(){
        AddTxt=" :(";
        AddText(AddTxt);
}
function smilehard(){
        AddTxt=" ;D";
        AddText(AddTxt);
}
function laugh(){
        AddTxt=" :D";
        AddText(AddTxt);
}
function tongue(){
        AddTxt=" :P";
        AddText(AddTxt);
}
function shocked(){
        AddTxt=" :o";
        AddText(AddTxt);
}
function cool(){
        AddTxt=" 8)";
        AddText(AddTxt);
}
function rolleyes(){
        AddTxt=" =)";
        AddText(AddTxt);
}
function wink(){
        AddTxt=" ;)";
        AddText(AddTxt);
}
function embarassed(){
        AddTxt=" :-[";
        AddText(AddTxt);
}
</script>
<style><!-- a{text-decoration:underline; font-weight: bold; font-size: 8.0pt; font-family:Tahoma}, a:hover{color:#395480;}, a:link{color:#748db5;}, a:visited{color:#748db5;}, a:hover{color:#395480;}
.whatever{ font-family: Verdana,Sans; color: #ffffff; font-size: 8.0pt; font-weight: bold; border: 1 solid #000000; background-color: #5582b0;}-->
</style>
<body bgcolor="#6A7F94" marginwidth="10" marginheight="10" topmargin="10" leftmargin="10" rightmargin="10" bottommargin="10">
<table style="border:1 solid black;" cellpadding="0" cellspacing="0" bgcolor="#000000">
<tr>
<td>
<table width="450" cellpadding="0" cellspacing="0" border="0">
<tr>
<td bgcolor="#476F97" width="10" height="20"></td>
<td bgcolor="#476F97" width="440" height="20" align="left"><font face="Tahoma" size="2" color="#ffffff">
<b>Setup my Guestbook!</b></font></td>
<tr>
<td bgcolor="#000000" width="450" height="1" colspan="2"></td>
</tr>
<tr>
<td bgcolor="#D0D7E0" width="450" height="4" colspan="2"></td>
</tr>
<tr>
<td bgcolor="#000000" width="450" height="1" colspan="2"></td>
</tr>
<tr>
<td bgcolor="#eeeeee" width="10"></td>
<td bgcolor="#eeeeee" width="440">
<FORM name=Jpmaster action="gsf.php" method=post>
<br>
<font face="Tahoma" size="2">
<b>Enter the full URL of your website's main page</b><br>
 <input name="home" size="40"value="<?echo $home?>" maxlength="40"><br><br>
<b>Strip all entries of HTML and PHP tags?</b><br>
<SELECT  name="strip"  value="<?echo $strip?>" >
<OPTION  value="1">Yes</OPTION>
<OPTION  value="0">No</OPTION> </SELECT><br><br>
 <b>The number of entries that are shown(a number between 1 and 30)</b><br>
<input name="entries" value="<?echo $entries?>" maxlength="30"><br><br>
<b>Show date on entry?</b><br>
<SELECT  name="show_date"  value="<?echo $show_date?>" >
<OPTION  value="1">Yes</OPTION>
<OPTION  value="0">No</OPTION> </SELECT><br><br>
<b>Show time on entry?</b><br>
<SELECT  name="show_time"  value="<?echo $show_time?>" >
<OPTION  value="1">Yes</OPTION>
<OPTION  value="0">No</OPTION> </SELECT><br><br>
 <b>Show smiley images?</b><br>
<SELECT  name="smiley"  value="<?echo $smiley?>" >
<OPTION  value="1">Yes</OPTION>
<OPTION  value="0">No</OPTION> </SELECT><br><br>
<b>Page background color</b><br>
<input name="pagebgc" maxlength="30" VALUE="<?echo $pagebgc?>"  ><br><br>
<b>Topheader color</b><br>
<input name="headerbgc" maxlength="30" VALUE="<? echo $headerbgc?>"><br><br>
<b>Color of name, email and URL background</b><br>
<input name="namebgc" value="<?echo $namebgc?>" maxlength="30"><br><br>
<b>Message entry background color</b><br>
<input name="messagebgc" maxlength="30" VALUE="<?echo $messagebgc ?>"  ><br><br>
<b>Color of line between entries</b><br>
<input name="linebgc" maxlength="30" VALUE="<? echo $linebgc?>"><br><br>
<b>Color of guestbooktitle</b><br>
<input name="titlecolor" value="<?echo $titlecolor?>" maxlength="30"><br><br>
<b>Color of name, email and URL text</b><br>
<input name="namecolor" maxlength="30" VALUE="<?echo $namecolor?>"  ><br><br>
<b>Color of message entry text</b><br>
<input name="messagecolor" maxlength="30" VALUE="<? echo $messagecolor?>"><br><br>
<b>Date color</b><br>
<input name="datecolor" value="<?echo $datecolor?>" maxlength="30"><br><br>
<b>Color of 'Back to Home' link normal  </b><br>
<input name="back_link_normal" maxlength="30" VALUE="<?echo $back_link_normal ?>"  ><br><br>
<b>Color of 'Back to Home' link hover</b><br>
<input name="back_link_hover" maxlength="30" VALUE="<? echo $back_link_hover?>"><br><br>
<b>Color of email and URL link normal</b><br>
<input name="em_url_link_normal" value="<?echo $em_url_link_normal?>" maxlength="30"><br><br>
 <b>Color of email and URL link hover</b><br>
<input name="em_url_link_hover" value="<?echo $em_url_link_hover?>" maxlength="30"><br><br>
<script language="javascript">
if(!((navigator.appName == "Netscape" && navigator.appVersion.charAt(0) >= 4) || (navigator.appName == "Microsoft Internet Explorer" && navigator.appVersion.charAt(0) >= 4) || (navigator.appName == "Opera" && navigator.appVersion.charAt(0) >= 4))) {
document.write("<font size=1 color=red>** browser not compatible with these buttons</font>"); }
</script>
<input class="whatever" type="submit" value="Save!"><br><br>
</FORM>
</td>
</tr>
</table>
</td>
</tr>
</table>


</body>
</html>