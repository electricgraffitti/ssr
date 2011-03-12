<% Option Explicit %>
<!-- #include file="constants.inc" -->
<%
	
	' 
	' :@rooms.asp
	' 
	' 
	'
	' @author	Peter Theill	peter@theill.com
	' 
	
	Response.Buffer = True
	
	Dim userId
	userId = CStr(Request("chatId"))
	
	If (NOT isLoggedIn(userId)) Then
		Response.Write("<font size=1>Please Wait ...</font>")
		Response.End
	End If
	
	If ((Request("action") = "remove") AND (Request("roomId") <> "")) Then
		
		' administrator of this room want to have it removed
		removeRoom(Request("roomId"))
		
	End If
	
%>
<html>
<head>
	<meta http-equiv='Refresh' content='<%= ROOMS_REFRESH_RATE %>; URL=rooms.asp?chatId=<%= userId %>&nocache=<%= Timer %>'>
	<title><%= APPLICATION_NAME %> - Rooms</title>
	<link rel="stylesheet" type="text/css" href="chat.css">
	<script language="JavaScript">
	<!--
		
		function confirmRemoveRoom(roomName)
		{
			return confirm('Please confirm you want to remove\n\n\t' + roomName + '\n\nfrom the list of available chat rooms?');
		}
		
	// -->
	</script>
</head>

<body topmargin=0 leftmargin=0 marginwidth=0 marginheight=0 class=Rooms>
<table border=0 width=100% cellspacing=0 cellpadding=2>
  <tr>
    <td colspan="2" width="100%" bgcolor="#D0D0D0">
     <table border=0 cellspacing=0 cellpadding=2>
     <tr>
      <td width=100%><nobr><b>Rooms</b></nobr></td>
      <td><a href="rooms.asp?chatId=<%= userId %>"><img src="images/ico.refresh.gif" width=16 height=16 border=0 alt="Refresh"></a></td>
     </tr>
     </table>
    </td>
  </tr>
<%
	
	Dim i, roomName, roomId, room_, user
	If (roomId = "") Then
		roomId = "0"
	End If
	
	Set user = getUser(userId)
	
	Dim rooms
	rooms = conquerChatRooms.Keys
	If (IsArray(rooms)) Then
		For i = 0 To UBound(rooms)
			Set room_ = getRoom(rooms(i))
			
			If (i MOD 2) Then
				Response.Write("<tr bgcolor='#F8F8F8'>")
			Else
				Response.Write("<tr>")
			End If
			
			If (room_.createdBy <> userId) Then
				Response.Write(" <td><img src='images/ico.room.gif' width=16 height=16 alt='" & room_.name & "' border=0></td>")
			Else
				Response.Write(" <td><a href='rooms.asp?chatId=" & userId & "&action=remove&roomId=" & room_.id & "' onClick=""return confirmRemoveRoom('" & room_.name & "')""><img src='images/ico.room.remove.gif' width=16 height=16 alt='Remove " & room_.name & "' border=0></a></td>")
			End If
			
			If (room_.id = user.roomId) Then
				' this room is where the user is located so we make it bold
				Response.Write(" <td width='100%' class='infoText'><a href='users.asp?chatId=" & userId & "&roomId=" & rooms(i) & "&action=switch' target='users'><b>" & Server.HTMLEncode(room_.name) & "</b></a></td>")
			Else
				Response.Write(" <td width='100%' class='infoText'><a href='users.asp?chatId=" & userId & "&roomId=" & rooms(i) & "&action=switch' target='users'>" & Server.HTMLEncode(room_.name) & "</a></td>")
			End If
			
			Response.Write("</tr>")
			
		Next
	Else
		Response.Write("<tr><td colspan=2>No rooms available</td></tr>")
	End If
	
%>
</table>
</body>
</html>