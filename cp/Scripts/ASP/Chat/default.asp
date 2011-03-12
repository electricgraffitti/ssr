<%	Option Explicit %>
<!-- #include file="constants.inc" -->
<%
	
	' 
	' :@default.asp
	' 
	' This page is the main entrace for ConquerChat. It shows a list of currently
	' logged in chatusers and makes it possible to log in by entering your user-
	' name in the appropriate field.
	'
	' @author	Peter Theill	peter@theill.com
	' 
	
	Response.Buffer = True
	
	' many users does not read the included README.TXT file before trying to 
	' set up this chat -- in order to help them a bit we check if we have the
	' required objects properly initialised
	On Error Resume Next
	If (NOT IsObject(conquerChatUsers) OR NOT IsObject(conquerChatRooms)) Then
		Response.Redirect("errorInSetup.asp")
		Response.End
	End If
	
	' Enable constant (from constants.inc) to reinitialise the chat in order to 
	' fix users hanging in the chat or to apply room changes. Make sure you dis-
	' able the constant once again after having displayed this (default.asp) 
	' page or you will clear all users every time the default.asp page is shown.
	If (INITIALIZING_CHATSYSTEM) Then
		conquerChatUsers.RemoveAll
		conquerChatRooms.RemoveAll
		conquerChatMessages.RemoveAll
	End If

	Dim userId
	userId = Request("chatId")
	
	' do not show login screen if a valid session exists
	If (userId <> "") Then
		Response.Redirect "frames.asp?chatId=" & userId
		Response.End
	End If
	
	Function isUserNameBlocked(userName)
		isUserNameBlocked = False
	End Function
	
	Dim i
	
	Dim mode, errorMessage
	mode = Request("mode")
	
	If (mode = "userLogin") Then
		
		Dim userName
		userName = Server.HTMLEncode(Request("userName"))
		
		If (countUsers() >= USERS) Then
			errorMessage = "The maximum number of users have been reached. You are not allowed to login at this time."
		ElseIf (Len(userName) = 0)  Then
			errorMessage = "You have to enter a username before starting to chat."
		ElseIf (Len(userName) > MAX_USERNAME_LENGTH) Then
			errorMessage = "Username must not exceed " & MAX_USERNAME_LENGTH & " characters."
		ElseIf (userExists(userName)) Then
			errorMessage = "Sorry,<br><br>You cannot use this username, since another person is using this already."
		ElseIf (InStr(userName, Chr(1)) <> 0) Then
			errorMessage = "Your username contains inappropriate characters. Please choose another one."
		ElseIf (isUserNameBlocked(userName)) Then
			errorMessage = "You cannot log on with this username."
		Else
			
			Dim p
			Set p = New Person
			p.id = -1
			p.name = userName
			p.roomId = 0
			p.ipAddress = Request.ServerVariables("REMOTE_ADDR")
			
			' we have a new chat user thus we need to create a new
			' id for him/her
			Set p = addUser(p)
			
			' tell all other users about this new user
			Call addMessage( _
				p.id, _
				"-1", _
				"<span class='loggedIn'><img src='images/new.gif' height=9 width=9>&nbsp;" & p.name & " logged on at " & Now() & "</span><br>" _
			)
			
			' redirect to new frame window and create a new user login
			Response.Redirect("frames.asp?chatId=" & p.id)
			Response.End
			
		End If
		
	End If ' > If (mode = "userLogin") Then
	
	' make sure we don't show any inactive users for new chat users
	kickInactiveUsers()
	
	' create default rooms if no is available (which will be the case the
	' very first time after a server restart)
	Application.Lock
	If (conquerChatRooms.Count = 0) Then
		Dim defaultRooms
		defaultRooms = Split(DEFAULT_ROOMS, ";")
		If (IsArray(defaultRooms)) Then
			For i = 0 To UBound(defaultRooms)
				defaultRooms(i) = Trim(defaultRooms(i))
				If (defaultRooms(i) <> "") Then
					Call addRoom(defaultRooms(i), "-1")
				End If
			Next
		End If
	End If
	Application.UnLock
	
%>
<html>
<head>
	<title><%= APPLICATION_NAME %></title>
	<link rel="stylesheet" type="text/css" href="chat.css">
</head>

<body topmargin=0 leftmargin=0 marginwidth=0 marginheight=0>
<table width=100% border=0 cellspacing=0 cellpadding=2 align=center bgcolor="#666666">
<tr>
 <td align="right"><a href="http://www.theill.com/" target="_top"><img border="0" src="http://www.theill.com/images/ani_theillcom_scroll.gif" alt="Part of the Theill Web Site"></a></td>
</tr>
</table>
<p>&nbsp;</p>
<form name="frmLogin" method="POST" action="default.asp">
  <input type="hidden" name="mode" value="userLogin">
  <div align="center">
    <table border=0 cellpadding=1 cellspacing=0 bgcolor=#999999>
    <tr>
    <td>
      <table border=0 cellspacing=0 cellpadding=4 width=320 bgcolor=white>
      <tr>
        <td bgcolor="#800000" style='border-bottom: 1px solid #C00000'><b><font color="#FFFFFF">&nbsp;Join <%= APPLICATION_NAME %></font></b></td>
      </tr>
      <tr>
        <td bgcolor="#F0F0F0">
          <table border=0 width=100% cellspacing=0 cellpadding=0>
            <tr>
              <td nowrap>Username&nbsp;&nbsp;</td>
              <td width="100%"><input type="text" name="username" class="editField" size="15" maxlength=20 value="<%= userName %>" tabindex="1" style="width: 100%"></td>
            </tr>
          </table>
        </td>
      </tr>
      <tr>
        <td width=100% bgcolor="#F0F0F0" align="right"><input type="image" name="login" value="submit" src="images/btn_login.gif" border=0 width=48 height=16 tabindex=2></td>
      </tr>
      <tr>
        <td width=100% align="right">&nbsp;</td>
      </tr>
      <% If (Len(errorMessage) > 0) Then %>
      <tr>
       <td bgcolor="#C00000"><font color=white><b><%= errorMessage %></b></font>&nbsp;</td>
      </tr>
      <% End If %>
      <tr>
        <td><%= countUsers() %> user(s) is currently chatting (max. <%= USERS %>):</td>
      </tr>
      <tr>
       <td>
        <table border=0 cellspacing=0 cellpadding=2 width=100%>
<%
	
	If (countUsers() <> 0) Then
		Dim user, room_, rowIdx
		For Each userId In conquerChatUsers
			Set user = getUser(userId)
			Set room_ = getRoom(user.roomId)
			If (room_ Is Nothing) Then
				Set room_ = New Room
				room_.name = "Unavailable"
			End If

			If (rowIdx MOD 2) Then
				Response.Write "<tr bgcolor='#F8F8F8'>"
			Else
				Response.Write "<tr>"
			End If
			
			Response.Write " <td width=24><img src='images/transparent.gif' width=8 height=16><img src='images/ico.user.gif' width=16 height=16 border=0 alt='active chat user'></td>"
			Response.Write " <td width='100%' class='infoText'>" & user.name & "&nbsp;-&nbsp;" & room_.name & "&nbsp;</td>"
			Response.Write "</tr>"
			
			rowIdx = rowIdx + 1
		Next
		
	Else
	
		Response.Write("<tr>")
		Response.Write("<td>&nbsp;&nbsp;&nbsp;<b>No users currently logged in.</b></td>")
		Response.Write("</tr>")
		
	End If
	
%>
	       </table></td>
         </tr>
      </table></td>
     </tr>
    </table>     
	</center>
	</div>
</form>

<script language="JavaScript">
<!--
	
	document.frmLogin.username.select();
	document.frmLogin.username.focus();
	
// -->
    </script>

</body>
</html>