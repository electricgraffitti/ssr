<html>
<head>
	<meta http-equiv="Content-Language" content="en-us">
	<title>Error In Setup</title>
</head>

<body>
<p><b><font face="Verdana, Sans-serif" size="2">Initialization failed</font></b></p>
<p><font face="Verdana, Sans-serif" size="2">It seems like you are missing a 
couple of steps in your setup of ConquerChat. In order to setup ConquerChat 
correctly, please make sure to follow the steps described in the included <b>README.TXT</b> 
file.</font></p>
<p><font face="Verdana, Sans-serif" size="2">This file is shown below for your 
convenience...</font></p>
<code style='font-size: 8pt;'>
<%

	Dim fs, readme
	Set fs = CreateObject("Scripting.FileSystemObject")
	Set readme = fs.openTextFile(Server.MapPath("readme.txt"))
	
	Do While (NOT readme.AtEndOfStream)
		Response.Write(readme.readLine & "<br>")
	Loop
	readme.Close
	Set fs = Nothing
	
%>
</code>

</body>
</html>