<% Option Explicit %>
<!-- #include file="constants.inc" -->
<%
	
	' 
	' :@message.asp
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
	
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<html>
<head>
	<title><%= APPLICATION_NAME %></title>
	<link rel="stylesheet" type="text/css" href="chat.css">
	<script language="JavaScript">
	<!--
		
		var justSent = false;
		
		function onSendMessage()
		{
			// user wants to open up the help screen
			if ((document.frmControl.message.value == '/help') || (document.frmControl.message.value == '/?'))
			{
				openHelp();
				return false;
			}
			
			// don't speed-limit message if it's empty (user wants to refresh chat)
			if (document.frmControl.message.value == '')
				return true;
			
			<% If (MESSAGE_FLOOD_TIMEOUT > 0) Then %>
			
			if (justSent)
			{
				alert('You are typing too fast. Wait a second then try again.');
				return false;
			}
			
			// avoid users spamming by sending a lot of messages all the time
			justSent = true;
			setTimeout('justSent = false;', <%= MESSAGE_FLOOD_TIMEOUT %>);
			
			<% End If %>
			
			document.frmControl.message.select();
			
			return true;
			
		} // > function onSendMessage()
		
		
		function openHelp()
		{
			var mConquerChatHelp = window.open(
				'help.asp',
				mConquerChatHelp,
				'toolbar=no,width=380,height=380,resizable=0'
			);
			
			mConquerChatHelp.focus();
			
		}
		
		
		function logoffUser()
		{
//			var mConquerChatLogoff
//			window.open('logoff.asp', mConquerChatLogoff, 'toolbar=no,width=380,height=380,resizable=0');
		}
		
		
		/**
		 *	Clears all text in message box.
		 *	
		 *	Function is called from 'window.asp' after it has been reloaded.
		 *	
		 */
		function clearMessageArea()
		{
			if (typeof document.frmControl != 'undefined' && document.frmControl.message != 'undefined')
			{
				document.frmControl.message.value = '';
				return true;
			}
			
			return false;
		}
		
	// -->
	</SCRIPT>
</head>

<body bgcolor="#FFCC66" background="images/pageBubbles.gif" onUnload="logoffUser()">
<form name="frmControl" method="POST" target="messages" action="window.asp" onSubmit="return onSendMessage()">
	<input type="hidden" name="mode" value="message">
	<input type="hidden" name="chatId" value="<%= userId %>">
	
	<!-- used when changing room -->
	<input type="hidden" name="roomId" value="">
	
	<table width=100% border=0 cellspacing=0 cellpadding=2>
	<tr>
		<td colspan=4><img src="images/dot.gif" width=1 height=24 border=0></td>
	</tr>
	<tr>
		<td colspan=4 class="infoHeader"><b>Message</b></td>
	</tr>
	<tr>
     	<td width="100%"><input type="text" class="editField" name="message" size="40" taborder="1"></td>
     	<td><input type="image" src="images/btn_send.gif" title="Sends message" taborder="2" name="submit" border="0" width="48" height="16"></td>
		<td align="right"><a href="javascript:openHelp()"><img border="0" src="images/btn_help.gif" width="48" height="16"></a></td>
		<td align="right"><input type="image" src="images/btn_logout.gif" title="Logs out of chat" name="logoff" taborder=3 border=0></td>
	</tr>
	</table>
</form>
<script language="JavaScript">
<!--
	
	if ((typeof document.frmControl != 'undefined') && (typeof document.frmControl.message != 'undefined'))
		document.frmControl.message.focus();
	
// -->
</script>
</body>
</html>