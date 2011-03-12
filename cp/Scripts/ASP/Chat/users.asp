<% Option Explicit %>
<!-- #include file="constants.inc" -->
<%
	
	' 
	' :@users.asp
	' 
	' Shows a list of all active chat users in the current users room. The 
	' current user will be bolded in the list in order to separate him from
	' other users and all other users will have a link for opening their
	' profile, e.g. if you want to send a private mssage to him/her.
	' 
	' @author	Peter Theill	peter@theill.com
	' 
	
	Response.Buffer = True
	
	Dim userId, roomId
	userId = CStr(Request("chatId"))
	
	If (NOT isLoggedIn(userId)) Then
		Response.Write("<font size=1>Please Wait ...</font>")
		Response.End
	End If
	
	Dim user
	
	Dim changeRoom
	If (Request("action") = "switch") Then
		
		' user clicked on a new room and thus we need to put the user into the 
		' selected room and refresh list of messages, users and rooms
		changeRoom = True
		
		' get room destination
		roomId = Request("roomId")
		If (roomId = "") Then	' this ought not to happen, but ...
			roomId = u.roomId
		End If
		
		' switch to new room
		Call enterRoom(CStr(userId), CStr(roomId))
		
	Else
		' user has not requested to change to a new room so we just refresh
		' his current room
		changeRoom = False
		
		Set user = getUser(userId)
		roomId = user.roomId
	End If
	
%>
<html>
<head>
	<meta http-equiv='Refresh' content='<%= USERS_REFRESH_RATE %>; URL=users.asp?chatId=<%= userId %>&roomId=<%= roomId %>&nocache=<%= Timer %>'>
	<title><%= APPLICATION_NAME %> - Users</title>
	<link rel="stylesheet" type="text/css" href="chat.css">
	
	<script language="JavaScript">
	<!--
		
		/**
		 *	Open window showing the users profile.
		 *	
		 *	@param	userId		Id of user for which we need to see the profile.
		 *	@param	fromUserId	Id of current user.
		 *	
		 */
		function openUserProfile(userId, fromUserId)
		{
			
			var mConquerChatUserProfile = window.open(
				'profile.asp?userId=' + userId + '&fromUserId=' + fromUserId,
				mConquerChatUserProfile,
				'toolbar=no,width=320,height=320,resizable=0'
			);
			
			mConquerChatUserProfile.focus();
			
		} // > function openUserProfile(userId, fromUserId)
		
	// -->
	</script>
</head>

<body topmargin=0 leftmargin=0 marginwidth=0 marginheight=0 class=Users>
<table border=0 width=100% cellspacing=0 cellpadding=2>
  <tr>
    <td colspan=2 width=100% bgcolor=#D0D0D0>
     <table border=0 cellspacing=0 cellpadding=2>
     <tr>
      <td width=100%><nobr><b>Users</b></nobr></td>
      <td><a href="users.asp?chatId=<%= userId%>&roomId=<%= roomId %>"><img src="images/ico.refresh.gif" width=16 height=16 border=0 alt="Refresh"></a></td>
     </tr>
     </table>
    </td>
  </tr>
<%
	
	' we need to show all users available in this room
	
	Dim userId_, rowIdx
	For Each userId_ In conquerChatUsers
		Set user = getUser(userId_)
		If (user.roomId = roomId) Then
			If (rowIdx MOD 2) Then
				Response.Write "<tr bgcolor='#F8F8F8'>"
			Else
				Response.Write "<tr>"
			End If
			
			Response.Write " <td><img src='images/ico.user.gif' width=16 height=16 border=0 alt='user'></td>"
			
			If (user.id = userId) Then
				' print users own name in bold
				Response.Write " <td width=100% class='infoText'><b>" & user.name & "</b>&nbsp;</td>"
			Else
				' users are able to send private messages to all other users
				' but themselves
				Response.Write " <td width=100% class=infoText><a href=""javascript:openUserProfile('" & user.id & "', '" & userId & "')"">" & user.name & "</a>&nbsp;</td>"
			End If
			
			Response.Write "</tr>"
			rowIdx = rowIdx + 1
		End If
		
	Next ' // > For Each userId_ In conquerChatUsers
	
%>
</table>

<% If (changeRoom) Then %>
<script language="JavaScript">
<!--
	
	// update rooms and messages windows
	parent.rooms.location.href = 'rooms.asp?chatId=<%= userId %>';
	parent.messages.location.href = 'window.asp?chatId=<%= userId %>';
	
	// update roomId variable in message control. This is needed in order to 
	// send the correct one when a user adds a message to the chat.
	parent.message.frmControl.roomId.value = '<%= roomId %>';
	
	// bring focus to message edit field since a user probably wants to type
	// a message in this new chatroom he just entered
	parent.message.frmControl.message.focus();
	
// -->
</script>
<% End If %>
</body>
</html>