<html>

<head>
	<META HTTP-EQUIV='Refresh' CONTENT='5; URL=expired.asp?reload=true'>
	<title>Session has expired</title>
	<link rel="stylesheet" type="text/css" href="chat.css">
</head>

<body>

<% If (Request("reload") = "true") Then %>
<script language="JavaScript">
<!--

	top.location.href = "default.asp";
	
// -->
</script>
<% End If %>

<p>Your session has expired or your have disabled temporary cookies in your
browser.</p>
<p>&nbsp;</p>
<p><a target="_top" href="default.asp">Click here to login</a></p>

</body>

</html>