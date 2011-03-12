<%	Option Explicit %>
<!-- #include file="constants.inc" -->
<%
	
	' 
	' :@addroom.asp
	' 
	' 
	'
	' @author	Peter Theill	peter@theill.com
	' 
	
	Response.Buffer = True
	
	Dim userId
	userId = Request("chatId")
	
	If (NOT isLoggedIn(userId)) Then
		Response.Redirect "expired.asp"
		Response.End
	End If
	
	Dim roomName, needToRefreshRooms, noMoreRoomsAllowed
	roomName = Request("ediRoomName")
	needToRefreshRooms = False
	noMoreRoomsAllowed = False
	If ((Request("action") = "addRoom") AND (Len(roomName) > 0)) Then
		needToRefreshRooms = True
		If (conquerChatRooms.Count < NUMBER_OF_ROOMS) Then
			' a new room needs to be added the chat. We include id of the chat user
			' creating this chat. This makes it possible for us to print his/hers
			' name next to the name of the room
			Call addRoom(roomName, userId)
		Else
			noMoreRoomsAllowed = True
		End If
	End If
%>
<html>
<head>
	<title><%= APPLICATION_NAME %> - Add Room</title>
	<link rel="stylesheet" type="text/css" href="../chat.css">
</head>

<body bgcolor=#F0F0F0 topmargin=4 leftmargin=4 marginwidth=4 marginheight=4>
<table border=0 width=100% cellspacing=0 cellpadding=0>
<form method="POST" name="frmAddRoom" action="addroom.asp">
<input type="hidden" name="action" value="addRoom">
<input type="hidden" name="chatId" value="<%= userId %>">
<tr>
	<td width="100%"><input type="text" class='editField' name="ediRoomName" size=10 style="width: 100%"></td>
	<td><img src="../images/transparent.gif" width=4 height=16 border=0><input type="image" name="submit" src="../images/btn_add.gif" width=48 height=16 border=0></td>
</tr>
</form>
</table>
<% If (needToRefreshRooms) Then %>
<script language="JavaScript">
<!--
	parent.rooms.location.href = 'rooms.asp?chatId=<%= userId %>';
// -->
</script>
<% End If %>

<% If (noMoreRoomsAllowed) Then %>
<script language="JavaScript">
<!--
	
	alert(	'Error adding new room\n\n' +
			'You are not allowed to add more rooms in this chat. The\n' +
			'limit of <%= NUMBER_OF_ROOMS %> has been reached. You may want to contact the\n' +
			'webmaster (mailto:<%= WEBMASTER_EMAIL %>) in order to\n' +
			'have this number increased.');
	
// -->
</script>
<% End If %>
</body>
</html>