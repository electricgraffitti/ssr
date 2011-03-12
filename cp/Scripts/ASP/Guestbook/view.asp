<html>
<head>
<title>My guestbook</title>
</head>
<body bgcolor="#ffffff" text="#000000" link="#000099" Alink="#007fff" Vlink="#000099">
<Style>
<!--
A:hover {color:#007fff;}
-->
</Style>
<center>
<font size=5 face="arial">
Welcome to my guestbook</font><br><a href="sign.asp">
<font size=2 face="arial">Sign guestbook</font></a></center>
<br><br><hr><br>
<%
fn = server.mappath("data.txt")
Set fs = server.CreateObject("Scripting.FileSystemObject") 
Set htmlfile = fs.OpenTextFile(fn, 1, 0, 0)	
hf = htmlfile.ReadAll
Response.write hf
htmlfile.close					
set htmlfile = nothing
set fs = nothing
%><br>
<hr><center><font size=1 face="arial">Written by Sakki http://www.welcome.to/Sakki</font></center>
</body></html>