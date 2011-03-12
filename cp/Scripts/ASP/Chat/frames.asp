<%	Option Explicit %>
<!-- #include file="constants.inc" -->
<%
	
	Dim userId
	userId = CStr(Request("chatId"))
	If (userId = "") Then
'		Response.Write "Wait..."
		Response.Redirect "expired.asp?reload=true"
		Response.End
	End If
	
%>
<html>
<head>
	<title></title>
	<link rel="stylesheet" type="text/css" href="chat.css">
</head>

<frameset cols="*,150" frameborder="1" frameborder="yes">
	<frameset rows="*,100" frameborder="0" frameborder="no">
		<frame name="messages" src="window.asp?chatId=<%= userId %>">
		<frame name="message" src="message.asp?chatId=<%= userId %>" scrolling="no" target="_self">
	</frameset>
	<frameset rows="66%,34%" frameborder="1" frameborder="yes">
		<frame name="users" src="users.asp?chatId=<%= userId %>" scrolling="no">
		<frameset rows="*,30" frameborder="1" frameborder="yes">
			<frame name="rooms" src="rooms.asp?chatId=<%= userId %>" scrolling="no">
			<frame name="add_room" src="addroom.asp?chatId=<%= userId %>" scrolling="no" noresize border="0" frameborder="0" frameborder="no">
		</frameset>
	</frameset>
	<noframes>
	<body>
		Your browser can't chat with us :(
	</body>
	</noframes>
</frameset>

</html>