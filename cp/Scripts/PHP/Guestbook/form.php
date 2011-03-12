
<?
include ("config.php")
?>
<html>
<head>
<title>Jevonweb Guestbook</title>
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
<body bgcolor="<? echo $pagebgc?>" marginwidth="10" marginheight="10" topmargin="10" leftmargin="10" rightmargin="10" bottommargin="10">
<table style="border:1 solid black;" cellpadding="0" cellspacing="0" bgcolor="#000000">
<tr>
<td>
<table width="450" cellpadding="0" cellspacing="0" border="0">
<tr>
<td bgcolor="#476F97" width="10" height="20"></td>
<td bgcolor="#476F97" width="440" height="20" align="left"><font face="Tahoma" size="2" color="#ffffff">
<b>Sign My Guestbook!</b></font></td>
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
<FORM name=Jpmaster action="guestbook.php" method=post>
<br>
<font face="Tahoma" size="2">
<b>Name:</b><br>
<input name="nick" maxlength="30"><br><br>
<b>Email:</b><br>
<input name="email" maxlength="40"><br><br>
<b>URL:</b><br>
<input name="url" value="http://" maxlength="70"><br><br>
<b>Add Smileys:</b>&nbsp;<a href=javascript:smile()><img src="images/smile.gif" border="0"></a>&nbsp;<a href=javascript:laugh()><img src="images/laugh.gif" border="0"></a>&nbsp;<a href=javascript:wink()><img src="images/wink.gif" border="0"></a>&nbsp;<a href=javascript:smilehard()><img src="images/smilehard.gif" border="0"></a>&nbsp;<a href=javascript:embarassed()><img src="images/embarassed.gif" border="0"></a>&nbsp;<a href=javascript:tongue()><img src="images/tongue.gif" border="0"></a>&nbsp;<a href=javascript:sad()><img src="images/sad.gif" border="0"></a>&nbsp;<a href=javascript:shocked()><img src="images/shocked.gif" border="0"></a>&nbsp;<a href=javascript:cool()><img src="images/cool.gif" border="0"></a>&nbsp;<a href=javascript:rolleyes()><img src="images/rolleyes.gif" border="0"></a><br>
<script language="javascript">
if(!((navigator.appName == "Netscape" && navigator.appVersion.charAt(0) >= 4) || (navigator.appName == "Microsoft Internet Explorer" && navigator.appVersion.charAt(0) >= 4) || (navigator.appName == "Opera" && navigator.appVersion.charAt(0) >= 4))) {
document.write("<font size=1 color=red>** browser not compatible with these buttons</font>"); }
</script>
<br>
<b>Message:</b><br>
<textarea name="msg" wrap=virtual cols="40" rows="5"></textarea><br><br>
<input class="whatever" type="submit" value="Sign Guestbook!"><br><br>
</FORM>
</td>
</tr>
</table>
</td>
</tr>
</table>

</body>
</html>