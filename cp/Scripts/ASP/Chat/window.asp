<%	Option Explicit %>
<!-- #include file="constants.inc" -->
<!-- #include file="utilities.inc" -->
<%
	
	' 
	' :@window.asp
	' 
	' Prints all available chatlines out on response stream if user has a valid
	' session, i.e. hasn't been logged out of the system and has a valid chat
	' identifier.
	' 
	' This script also logs off users if they requested it or if their session
	' has timed out, e.g. if they haven't written anything in the chat window
	' for a while (default is 5 minutes)
	' 
	' @author	Peter Theill	peter@theill.com
	' 
	
	Response.Buffer = True
	
	Dim userId
	userId = CStr(Request("chatId"))
	
	If (NOT isLoggedIn(userId)) Then
		Response.Redirect "expired.asp"
		Response.End
	End If
	
	Dim user, room_
	Set user = getUser(userId)
	Set room_ = getRoom(user.roomId)
	
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<html>
<head>
	<meta http-equiv='Refresh' content='<%= MESSAGES_REFRESH_RATE %>; URL=window.asp?chatId=<%= userId %>&nocache=<%= Timer %>'>
	<title><%= APPLICATION_NAME %></title>
	<link rel="stylesheet" type="text/css" href="chat.css">
</head>

<body>
<%
	
	' user wants to logoff, so we will have to notify all other users 
	' about this by printing some kind of 'user X is now logging off' 
	' message.
	If (Len(Request("logoff.x")) > 0) Then
		
		Dim x
		
		' add a leaving message to chatroom and remove user from list of active
		' users in this chat room
		logoutUser(userId)
		
		' by executing this script, we redirect user to login page
		' you might want to change the "top" location to suit your
		' needs, e.g. if you embed ConquerChat into a frame-enabled
		' site.
		Response.Write "<script language='JavaScript'>"
		Response.Write "  top.location.href = 'default.asp';"
		Response.Write "</script>"
		
	ElseIf (Request("mode") = "message") Then
		
		' a new message has been send to chat. We want this message to 
		' be added our list of messages, indicating which user send it
		
		Dim textMessage
		textMessage = Request("message")
		
		' do not add empty messages to chat
		If (Len(textMessage) > 0) Then
			
			' we do not support most tags, however <b>, <i> and <u> ARE supported, 
			' thus we have to make check for these and replace with actual tags
			textMessage = Server.HTMLEncode(textMessage)
			textMessage = Replace(textMessage, "&lt;b&gt;", "<b>", 1, -1, 1)
			textMessage = Replace(textMessage, "&lt;/b&gt;", "</b>", 1, -1, 1)
			textMessage = Replace(textMessage, "&lt;i&gt;", "<i>", 1, -1, 1)
			textMessage = Replace(textMessage, "&lt;/i&gt;", "</i>", 1, -1, 1)
			textMessage = Replace(textMessage, "&lt;u&gt;", "<u>", 1, -1, 1)
			textMessage = Replace(textMessage, "&lt;/u&gt;", "</u>", 1, -1, 1)
			
			' if chat administrator wants it, we replace smilies with images
			If (USE_IMAGE_SMILEY) Then
				textMessage = replaceSmilies(textMessage)
			End If
			
			' build new message - we use tables to make a better formatting
			textMessage= "<table width=100% border=0 cellpadding=2 cellspacing=1>" & _
					"<tr>" & _
					" <td nowrap valign=top class=MessageName><span class='Name'>" & user.name & "</span></td>" & _
					" <td width=100% align=justify><div class='Message' align='justify'>" & textMessage & "</span></td>" & _
					"</tr>" & _
					"</table>"
			
			If (DEBUG__) Then
				Response.Write("<br>userId      = " & userId)
				Response.Write("<br>textMessage = " & textMessage)
				Response.Write("<br>user.roomId = " & user.roomId)
			End If
			Call addUserMessage(userId, textMessage)
			
			If (CLEAR_MESSAGE) Then
				Response.Write("<script language=JavaScript>parent.message.clearMessageArea();</script>")
			End If
			
		End If ' > If (Len(textMessage) > 0) Then
	
	End If ' > ElseIf ( Request("mode") = "message" ) Then
	
	kickInactiveUsers()
	
	If (countUsers() = 0 AND CLEAR_ON_EMPTY) Then
		
		' clear all messages in all rooms
		conquerChatMessages.RemoveAll
		
	End If
	
	' print all messages in this room
	If (NEWEST_MESSAGE_IN_TOP) Then
		Response.Write("<a name='newestMessage'>")
		Call printMessages(user.roomId, user.id, True)	
	Else
		Call printMessages(user.roomId, user.id, False)
		Response.Write("<a name='newestMessage'>")
	End If
	
%>

<script language="JavaScript">
<!--
	
	// jump to the hashmark with latest message (top or bottom of document) 
	// which depends on the message order selected
	document.location.hash = "#newestMessage";
	
// -->
</script>

</body>
</html>