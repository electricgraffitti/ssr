<?
include("config.php");
?>

<html>
<head>
<title>Jevonweb Guestbook</title>
</head>
<style><!-- .back{text-decoration:none; font-weight: bold; font-size: 8.0pt; font-family:Tahoma}, .back:hover{color:<? echo $back_link_hover; ?>; text-decoration:underline;}, .back:link{color:<? echo $back_link_normal; ?>;}, .back:visited{color:<? echo $back_link_normal; ?>;}, .back:hover{color:<? echo $back_link_hover; ?>; text-decoration:underline;}-->
</style>
<style><!-- a{text-decoration:underline; font-weight: bold; font-size: 8.0pt; font-family:Tahoma}, a:hover{color:<? echo $em_url_link_hover; ?>;}, a:link{color:<? echo $em_url_link_normal; ?>;}, a:visited{color:<? echo $em_url_link_normal; ?>;}, a:hover{color:<? echo $em_url_link_hover; ?>;}-->
</style>
<body bgcolor="<? echo $pagebgc; ?>" marginwidth="10" marginheight="10" topmargin="10" leftmargin="10" rightmargin="10" bottommargin="10">
<table width="100%" style="border:1 solid black;" cellpadding="0" cellspacing="0" bgcolor="#000000">
<tr>
<td>
<table width="100%" cellpadding="0" cellspacing="0" border="0">
<tr>
<td bgcolor="<? echo $headerbgc; ?>" width="1%" height="20"></td>
<td bgcolor="<? echo $headerbgc; ?>" width="80%" height="20" align="left"><font face="Tahoma" size="2" color="<? echo $titlecolor; ?>">
<b>Jevonweb Guestbook</font></td>
<td bgcolor="<? echo $headerbgc; ?>" width="18%" height="20" align="right"><font face="Tahoma" size="2" color="<? echo $back_link_normal; ?>"><a class="back" href=<? echo $home ?>>Back to Home</a></font></td>
<td bgcolor="<? echo $headerbgc; ?>" width="1%" height="20"></td></tr>
<tr>
<td bgcolor="#000000" width="100%" height="1" colspan="4"></td>
</tr>
<tr>
<td bgcolor="<? echo $linebgc; ?>" width="100%" height="4" colspan="4"></td>
</tr>
<tr>
<td bgcolor="#000000" width="100%" height="1" colspan="4"></td>
</tr>


<?
include("messages.txt");
?>


<tr>
<td bgcolor="<? echo $headerbgc; ?>" width="100%" height="30" colspan="4">
<font face="Tahoma" size="1" color="<? echo $titlecolor; ?>">
<center>Copyright Jeroen Vennegoor <a class="back" href="http://www.jevonweb.f2s.com">Download your own guestbook HERE</a><br> </center>
</font></td>
</tr>
</table>
</td>
</tr>
</table>
</body>
</html>