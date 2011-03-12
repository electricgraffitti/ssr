<% Option Explicit %>
<!-- #include file="constants.inc" -->
<%

	Dim userId, user, fromUserId
	userId = Request("userId")
	fromUserId = Request("fromUserId")
	
	Set user = getUser(userId)
	
	If ( (userId = "") OR (fromUserId = "") OR (user Is Nothing) ) Then
		Response.Write("<script language=javascript>window.close();</script>")
	End If
	
%>
<html>
<head>
	<title><%= APPLICATION_NAME %> - User Profile</title>
	<link rel="stylesheet" type="text/css" href="chat.css">
</head>

<body topmargin=0 leftmargin=0 marginwidth=0 marginheight=0>

<table border=0 width="100%" height="48" cellspacing="0" cellpadding="8" bgcolor="#FFCC66">
<tr>
 <td width="100%"><b>Statistics for <%= user.name %></b></td>
 <td nowrap>[ <b>
 <a title="Profile" href="profile.asp?userId=<%= userId %>&fromUserId=<%= fromUserId %>">1</a></b> <b>2</b> ]</td>
</tr>
</table>
<table border=0 width=100% cellspacing=0 cellpadding=0 bgcolor=black>
<tr>
 <td><img src="images/dot.gif" height=1 width=32></td>
</tr>
</table>
<table border=0 width=100% cellspacing=0 cellpadding=8>
<tr>
 <td>
 <table border=0 cellspacing="0" style="border-collapse: collapse" bordercolor="#111111" width="100%" cellpadding="2">
 <tr>
   <td>
     IP Address</td><td align="right"><%= user.ipAddress %></td>
 </tr>
 <tr><td>
     Logged On</td><td align="right"><%= user.loggedOn %></td></tr><tr><td>
     Last Action</td><td align="right"><%= user.lastAction %></td></tr><tr><td>
     Written Messages</td><td align="right"><%= user.sendMessages %></td></tr></table>
 </td>
</tr>
</table>
</body>
</html>