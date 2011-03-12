<% Option Explicit %>
<!-- #include file="constants.inc" -->
<%

	Dim userId, user, fromUserId, msg
	userId = Request("userId")
	fromUserId = Request("fromUserId")
	
	Set user = getUser(userId)
	
	If ( (userId = "") OR (fromUserId = "") OR (user Is Nothing) ) Then
		Response.Write("<script language=javascript>window.close();</script>")
	End If
	
	If (Request("action") = "post") Then
		
		' send a private message to user
		Call addPrivateMessage(fromUserId, userId, Request("message"))
		
		msg = "Your private message has been send"
		
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
 <td width="100%"><b>Profile for <%= user.name %></b></td>
 <td nowrap>[ <b>1</b> <b>
 <a title="Statistics" href="user_statistics.asp?userId=<%= userId %>&fromUserId=<%= fromUserId %>">2</a></b> ]</td>
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
 	<font color=#008000><%= msg %></font>
<p>Type in a private message: </p>
<form method="POST" action="profile.asp">
	<input type=hidden name=action value=post>
	<input type=hidden name=userId value="<%= userId %>">
	<input type=hidden name=fromUserId value="<%= fromUserId %>">
	<input type="text" name="message" size="20">&nbsp;<input type="submit" value="Send">
</form>
<p>&nbsp;</td>
</tr>
</table>
</body>
</html>