<%
	
	' 
	' --------------------- C H A T   A P P L I C A T I O N   S E T T I N G S
	'
	
	'
	' Enable this state if you have changed the number of rooms in the chat 
	' or if you some users are 'hanging' in some rooms without getting auto-
	' matically logged out. After having enabled this state go to the main
	' page of the chat to refresh all data. Now change this state back to
	' default in order to reenable the chat functionality.
	'
	' Default value: False
	'
	Const INITIALIZING_CHATSYSTEM = False
	
	'
	' Name of this Chat application. If you want to use it on your own site,
	' you probably wants to give it a different name, e.g. 'Lucky Chat'. By
	' changing this value, all text strings in chat will be changed.
	' 
	' Default Value: ConquerChat On·Line
	'
	Const APPLICATION_NAME = "ConquerChat On·Line"
	
	'
	' Contains the e-mail address for the web administrator for this web site.
	' If an error occurs or a user wants to send an email to the webmaster,
	' this email will be shown.
	' 
	' Default Value: webmaster@mydomain.com
	'
	Const WEBMASTER_EMAIL = "webmaster@mydomain.com"
	
	'
	' The maximum number of shown messages on the screen. You may want to 
	' limit this number in order to have all messages written on one page
	' without the user having to scroll his/hers chat window. The value is
	' on a 'per room' basis.
	'
	' Default Value: 25
	'
	Const MESSAGES = 25
	
	' 
	' This specifies the number of users allowed to log into this chat. If
	' you have a large site you may want to increase this number to allow
	' more users.
	'
	' Default Value: 30
	' 
	Const USERS = 30
	
	'
	' No more than X rooms are allowed to be created for any chat. This value
	' will limit the number of rooms for the entire chat -- not just for one
	' user.
	'
	' Default Value: 10
	'
	Const NUMBER_OF_ROOMS = 10
	
	' 
	' Timeout in seconds - a session times out after 5 minutes (5*60=300) thus
	' if a logged in user hasn't entered anything in the window he will be
	' logged out in order to avoid taking up a space in the chat.
	' 
	' Default Value: 300
	' 
	Const TIMEOUT = 300
	
	'
	' Number of milliseconds a user needs to wait before sending a new 
	' message. This setting prevents "message flooding" so a user do not
	' sends the same message a great number of times. Set this number to 
	' zero (0) if you want to disable it.
	' 
	' Default Value: 1500
	' 
	Const MESSAGE_FLOOD_TIMEOUT = 1500
	
	' 
	' Specify is all messages should be wiped, when last user leaves the 
	' chatroom. This feature is also called the 'whiteboard cleaner'.
	' 
	' Default Value: True
	' 
	Const CLEAR_ON_EMPTY = True
	
	' 
	' Clears message in textbox when it has been send off to the chat room.
	' If this setting is False, the message will stay in the textbox, but
	' will be highlighted to indicate you are able to just type in a new
	' message to override the existing one.
	' 
	' Default Value: True
	' 
	Const CLEAR_MESSAGE = True
	
	' 
	' If True, a typed smiley (e.g. :-) will be replaced by a small image
	' representation.
	' 
	' Default Value: True
	' 
	Const USE_IMAGE_SMILEY = True
	
	'
	' List of default rooms available for all users. Rooms are separated
	' using a simicolon (;) and first room is _always_ the default room,
	' i.e. where all new users are placed
	'
	' Default Value: Entrance;Music;Sport
	'
	Const DEFAULT_ROOMS = "Entrance;Music;Sport"
	
	'
	' Indicates if all chat messages should print from top-to-bottom or from
	' bottom-to-top. If this flag is set to True new messages will be
	' printed in the top of the chat area otherwise a new message appear
	' in the bottom.
	'
	' Default Value: True
	'
	Const NEWEST_MESSAGE_IN_TOP = True
	
	'
	' This value indicates the maximum length of a username. If a user enters
	' a username larger than this value, he will be prompted to enter another
	' name.
	' 
	' Default Value: 20
	'
	Const MAX_USERNAME_LENGTH = 20
	
	'
	' Refresh rates for updating windows with messages, users and rooms. All
	' rates are defined in seconds. Do not set these values too low since it
	' may influence on the performance of your chat application.
	' 
	' Default Value: 10
	'
	Const MESSAGES_REFRESH_RATE = 10
	
	' Default Value: 15
	Const USERS_REFRESH_RATE = 15
	
	' Default Value: 15
	Const ROOMS_REFRESH_RATE = 15
	
	
	'
	' Internal constant used for debugging this chat application. You should 
	' not need to enable it unless you are customizing ConquerChat and want
	' to have a better detail level of used ids, etc.
	'
	' Default Value: False
	'
	Const DEBUG__ = False
	
	
	
	' 
	' --------------------------------------------------------- C L A S S E S
	'
	
	Class Person
		
		Private id_
		Private name_
		Private roomId_
		Private lastAction_
		
		Private loggedOn_
		Private ipAddress_
		Private sendMessages_
		
		Private Sub Class_Initialize()
			id_ = -1
			name_ = "Guest"
			roomId_ = -1
			action()
			loggedOn_ = Now()
			ipAddress = ""
			sendMessages_ = 0
		End Sub
		
		Public Property Get id
			id = id_
		End Property
		
		Public Property Get name
			name = name_
		End Property
		
		Public Property Get roomId
			roomId = roomId_
		End Property
		
		Public Property Get lastAction
			lastAction = lastAction_
		End Property
		
		Public Property Get loggedOn
			loggedOn = loggedOn_
		End Property
		
		Public Property Get ipAddress
			ipAddress = ipAddress_
		End Property
		
		Public Property Get sendMessages
			sendMessages = sendMessages_
		End Property
		
		
		Public Property Let id(v)
			id_ = v
		End Property
		
		Public Property Let name(v)
			name_ = v
		End Property
		
		Public Property Let roomId(v)
			roomId_ = v
		End Property
		
		Public Sub action()
			lastAction_ = CStr(Now())
		End Sub
		
		Private Property Let loggedOn(v)
			loggedOn_ = v
		End Property
		
		Public Property Let ipAddress(v)
			ipAddress_ = v
		End Property
		
		Public Property Let sendMessages(v)
			sendMessages_ = v
		End Property
		
		Public Property Get data
			data = id_ & Chr(1) & name_ & Chr(1) & roomId_ & Chr(1) & lastAction_ & Chr(1) & loggedOn_ & Chr(1) & ipAddress_ & Chr(1) & sendMessages_
		End Property
		
		Public Property Let data(v)
			Dim dataArray
			dataArray = Split(v, Chr(1))
			If (IsArray(dataArray) AND (UBound(dataArray) >= 6)) Then
'			If (IsArray(dataArray)) Then
				id_ = dataArray(0)
				name_ = dataArray(1)
				roomId_ = dataArray(2)
				lastAction_ = dataArray(3)
				loggedOn_ = dataArray(4)
				ipAddress_ = dataArray(5)
				sendMessages_ = dataArray(6)
			End If
		End Property
		
		Private Sub debug()
			Response.Write "<table><tr><td colspan=4><b>User</b></td></tr><tr><td>" & id_ & "</td><td>" & name_ & "</td><td>" & roomId_ & "</td><td>" & lastAction_ & "</td></tr></table>"
		End Sub
		
	End Class
	
	
	Class Room
		
		Private id_
		Private name_		
		Private createdBy_
		
		Private Sub Class_Initialize()
			id_ = -1
			name_ = "Guest"
			createdBy_ = -1
		End Sub
		
		
		Public Property Get id
			id = id_
		End Property
		
		Public Property Get name
			name = name_
		End Property
		
		Public Property Get createdBy
			createdBy = createdBy_
		End Property
		
		
		Public Property Let id(v)
			id_ = v
		End Property
		
		Public Property Let name(v)
			name_ = v
		End Property
		
		Public Property Let createdBy(v)
			createdBy_ = v
		End Property
		
		
		Public Property Get data
			data = id_ & Chr(1) & name_ & Chr(1) & createdBy_
		End Property
		
		Public Property Let data(v)
			Dim dataArray
			dataArray = Split(v, Chr(1))
			If (IsArray(dataArray) AND (UBound(dataArray) >= 2)) Then
'			If (IsArray(dataArray)) Then
				id_ = dataArray(0)
				name_ = dataArray(1)
				createdBy_ = dataArray(2)
			End If
		End Property
		
		Private Sub debug()
			Response.Write "<table><tr><td colspan=3><b>Room</b></td></tr><tr><td>" & id_ & "</td><td>" & name_ & "</td><td>" & createdBy_ & "</td></tr></table>"
		End Sub
		
	End Class
	
	' [>] moved to release 3.1
	Class Message
		
		Private roomId_			' room where message appears
		Private position_		' line number for message (starting from 0)
		Private userId_			' user sending message
		Private receiverId_		' user receiving message (-1 for all)
		Private text_			' message
		
		Public Property Get roomId
			roomId = roomId_
		End Property
		
		Public Property Get position
			position = position_
		End Property
		
		Public Property Get userId
			userId = userId_
		End Property
		
		Public Property Get receiverId
			receiverId = receiverId_
		End Property
		
		Public Property Get text
			text = text_
		End Property
		
		
		Public Property Let roomId(v)
			roomId_ = v
		End Property
		
		Public Property Let position(v)
			position_ = v
		End Property
		
		Public Property Let userId(v)
			userId_ = v
		End Property
		
		Public Property Let receiverId(v)
			receiverId_ = v
		End Property
		
		Public Property Let text(v)
			text_ = v
		End Property
		
		
		Public Property Get data
			data = roomId_ & Chr(1) & position & Chr(1) & userId_ & Chr(1) & receiverId_ & Chr(1) & text_
		End Property
		
		Public Property Let data(v)
			Dim dataArray
			dataArray = Split(v, Chr(1))
			If (IsArray(dataArray) AND (UBound(dataArray) >= 4)) Then
				roomId_ = dataArray(0)
				position_ = dataArray(1)
				userId_ = dataArray(2)
				receiverId_ = dataArray(3)
				text_ = dataArray(4)
			End If
		End Property
		
		Public Sub debug()
			Response.Write("<table><tr><td colspan=5><b>Message</b></td></tr><tr><td>" & roomId_ & "</td><td>" & position_ & "</td><td>" & userId_ & "</td><td>" & receiverId_ & "</td><td>" & text_ & "</td></tr></table>")
		End Sub
		
	End Class
	
	
	' Internal constants used within ConquerChat -- warning: please do not 
	' modify these values unless you know what you are doing!
	Const USER_UNAVAILABLE = "-1"
	Const PAGE_EXPIRED = "expired.asp"
	
	
	'
	' ------------------------------------- U T I L I T Y   F U N C T I O N S
	'
	
	'
	' The UserExists(username) function is able to find a specific logged in
	' user using his or hers username (aka chatname).
	' 
	' Function returns True if user was found, False otherwise.
	'
	Function UserExists(userName)
		
		userName = Trim(userName)
		
		Dim arUsers, i, user
		arUsers = conquerChatUsers.Keys
		For i = 0 To conquerChatUsers.Count-1
			
			Set user = getUser(arUsers(i))
			If (StrComp(userName, user.name, 1) = 0) Then
				UserExists = True
				Exit Function
			End If
			
		Next
		
		UserExists = False
		
	End Function ' // > Function UserExists(userName)
	
	
	'
	' Returns Room object specified by parameter "roomId". If the room 
	' does not exist, Nothing is returned
	'
	Function getRoom(roomId)
		
		' make sure id is treated as a String variant
		roomId = CStr(roomId)
		
		If (conquerChatRooms.Exists(roomId)) Then
			Set getRoom = New Room
			getRoom.data = conquerChatRooms.Item(roomId)
			Exit Function
		End If
		
		Set getRoom = Nothing
		
	End Function ' // > Function getRoom(roomId)
	
	
	Function getRoomByName(roomName)
		
		Dim roomId
		For Each roomId In conquerChatRooms
			Set getRoomByName = getRoom(roomId)
			If (NOT (getRoomByName Is Nothing)) Then
				If (StrComp(roomName, getRoomByName.name, 1) = 0) Then
					Exit Function
				End If
			End If
		Next
		
		Set getRoomByName = Nothing
		
	End Function ' // > Function getRoomByName(roomName)
	
	
	'
	' The isLoggedIn(userId) function ensures a valid user login. If the user
	' has been kicked out or his/hers session has expired, the user has been
	' removed from the array of active users and thus needs to login again
	' if he/she wants to continue chatting.
	'
	' Function returns True if user is logged in, False otherwise.
	'
	Function isLoggedIn(userId)
		
		Dim user
		Set user = getUser(userId)
		If (NOT (user Is Nothing)) Then
			Dim room
			Set room = getRoom(user.roomId)
			If (NOT (room Is Nothing)) Then
				isLoggedIn = True
				Exit Function
			End If
		End If
		
		isLoggedIn = False
		
	End Function ' // > Function isLoggedIn(userId)
	
	
	' 
	' The "adduser(user)" function adds a new user to the chat. When a 
	' user enters, a unique key is generated in order to track user properly
	' without using an ASP Session object.
	' 
	' Function returns unique id of new user.
	' 
	Function addUser(user)
		
		' generate an unique id (timestamp) for this user session. To avoid
		' having , or . in the id we replace them with 'x'
		user.id = Replace(Replace(CStr(Timer), ",", "x"), ".", "x")
		
		' as default, the user is placed in the main entrance room
		user.roomId = 0
		
		' add user to our internal structure of active users
		conquerChatUsers.Add user.id, user.data
		
		' return user with updated information
		Set addUser = user
		
	End Function ' // > Function addUser(user)
	
	'
	' Since classes in VBScript doesn't maintains its instance between pages
	' we have to make sure all data we change on an instance will be stored
	' in our global structure of users. This method simply reset the values
	' for the specified user.
	'
	Private Function updateUser(user)
		
		' reflect local changes in global object
		conquerChatUsers.Item(user.id) = user.data
		
		Set updateUser = user
		
	End Function ' // > Private Function updateUser(user)
	
	
	Sub logoutUser(userId)
		
		userId = CStr(userId)
		
		Dim user
		Set user = getUser(userId)
		
		Call addMessage( _
			user.id, _
			"-1", _
			"<span class='LoggedOut'><img src='images/bp.gif' height=9 width=9>&nbsp;" & user.name & " decided to leave us at " & Now() & "</span><br>" _
		)
		
		' remove user timestamps and name
		Call removeUser(userId)
		
		Set user = Nothing
		
	End Sub
	
	
	'
	' The 'removeUser(userId)' sub procedure removes a logged in user either
	' because his/hers session has expired, was kicked or clicked on logout.
	' 
	Private Sub removeUser(userId)
		
		' make sure we convert this in-parameter to a string since we store
		' user keys as strings in our global Dictionary object
		userId = CStr(userId)
		
		If (conquerChatUsers.Exists(userId)) Then
			conquerChatUsers.Remove(userId)
			
			' we need to remove all rooms for this user as well
			removeUserRooms(userId)
		End If
		
	End Sub ' // > Private Sub removeUser(userId)
	
	
	Private Function removeUserRooms(userId)
	
		Application.Lock
		Dim roomId, room
		For Each roomId In conquerChatRooms
			Set room = getRoom(roomId)
			If (NOT room Is Nothing) Then
				If (room.createdBy = userId) Then
					removeRoom(room.id)
				End If
			End If
		Next
		
'		Dim roomIds, roomOwners, i
'		roomIds = conquerChatRooms.Keys
'		roomOwners = conquerChatRooms.Items
'		If (IsArray(roomOwners)) Then
'			For i = 0 To conquerChatRooms.Count-1
'				If (roomOwners(i) = userId) Then
'					conquerChatRooms.Remove(roomIds(i))
'				End If
'			Next
'		End If
		Application.UnLock
		
	End Function ' // > Private Function removeUserRooms(userId)
	
	' 
	' The countUsers function returns the number of currently logged in chat
	' users in all rooms.
	' 
	Function countUsers()
		
		countUsers = conquerChatUsers.Count
		
	End Function ' // > Function countUsers()
	
	
	'
	' Adds a new message to the room the user is currently located in. The
	' message will be added to the queue of posted messages and printed for
	' all users the next time the "window.asp" page is refreshed.
	'
	Function addUserMessage(userId, message)
		
		' lock (synchronize) access to global variables
		Application.Lock
		
		' get user information
		Dim user
		Set user = getUser(userId)
		
		' adds new message to queue
		Call addMessage(userId, -1, message)
		
		user.sendMessages = user.sendMessages + 1
		
		' update users timestamp (thus we know he/she is active)
		user.action()
		
		' update internal class structure
		updateUser(user)
		
		' unlock access to global variables
		Application.UnLock
		
	End Function ' // > Function addUserMessage(userId, message)
	
	
	Function addPrivateMessage(fromUserId, toUserId, message)
		
		' get user information
		Dim user
		Set user = getUser(fromUserId)
		
		' format message before adding it to message queue
		message = Server.HTMLEncode(message)
		message = Replace(message, "&lt;b&gt;", "<b>", 1, -1, 1)
		message = Replace(message, "&lt;/b&gt;", "</b>", 1, -1, 1)
		message = Replace(message, "&lt;i&gt;", "<i>", 1, -1, 1)
		message = Replace(message, "&lt;/i&gt;", "</i>", 1, -1, 1)
		message = Replace(message, "&lt;u&gt;", "<u>", 1, -1, 1)
		message = Replace(message, "&lt;/u&gt;", "</u>", 1, -1, 1)
		message = "<table width=100% border=0 cellpadding=2 cellspacing=1>" & _
			"<tr>" & _
			" <td nowrap valign=top class=PrivateMessageName><span class=PrivateMessageName>" & user.name & "</span></td>" & _
			" <td width=100% align=justify><div class=PrivateMessage align='justify'>" & message & "</span></td>" & _
			"</tr>" & _
			"</table>"
		
		' adds new message to queue
		Call addMessage(fromUserId, toUserId, message)
		
		user.sendMessages = user.sendMessages + 1
		
		' update users timestamp (thus we know he/she is active)
		user.action()
		
		' update internal class structure
		updateUser(user)
		
	End Function
	
	
	' 
	' The getUser(userId) function returns the object of specified user. 
	' All users of this chat has a unique id in order to identify him/her
	' without using sessions.
	' 
	' Function returns object of user if found, 'Nothing' object otherwise.
	' 
	Function getUser(userId)
		
		userId = CStr(userId)
		If (conquerChatUsers.Exists(userId)) Then
			Set getUser = New Person
			getUser.data = conquerChatUsers.Item(userId)
			Exit Function
		End If
		
		Set getUser = Nothing
		
	End Function ' // > Function getUser(userId)
	
	
	Function getMessage(messageId)
		
		messageId = CStr(messageId)
		If (conquerChatMessages.Exists(messageId)) Then
			Set getMessage = New Message
			getMessage.data = conquerChatMessages.Item(messageId)
			Exit Function
		End If
		
		Set getMessage = Nothing
		
	End Function
	
	
	Function addRoom(roomName, userId)
	
		' check for valid room name
		Dim check
		Set check = New RegExp
		check.Pattern = "[a-zA-z0-9 ]"
		check.IgnoreCase = False
		check.Global = True
		If (NOT check.Test(roomName)) Then
			addRoom = False
			Exit Function
		End If
		
		Application.Lock
		If (getRoomByName(roomName) Is Nothing) Then
			Dim room
			Set room = New Room
'			room.id = Replace(Replace(CStr(Timer), ",", "x"), ".", "x")
			room.id = CStr(conquerChatRooms.Count)
			room.name = roomName
			room.createdBy = userId
			
			conquerChatRooms.Add room.id, room.data
			addRoom = True
		Else
			addRoom = False
		End If
		Application.UnLock
		
	End Function ' // > Function addRoom(roomName, userId)
	
	
	Function removeRoom(roomId)
	
		' treat as string
		roomId = CStr(roomId)
		
		' make sure we actually have the room we are about to remove
		If (conquerChatRooms.Exists(roomId)) Then
			
			' remove from global internal structure
			conquerChatRooms.Remove(roomId)
			
			' transfer all users from this (removed) room to main entrance
			Dim userId, user
			For Each userId In conquerChatUsers
				Set user = getUser(userId)
				If (NOT user Is Nothing) Then
					If (user.roomId = roomId) Then
						user.roomId = 0
						updateUser(user)
					End If
				End If
			Next
			
		End If
		
	End Function ' // > Function removeRoom(roomId)
	
	
	' this user wants to switch to another room thus we have to remove
	' the id from the old one and place it in the new
	Function enterRoom(userId, roomId)
	
		Application.Lock
		
		Dim user
		Set user = getUser(userId)
		
		' notify users in old room
		Call addUserMessage(userId, "<span class='LeavingRoom'>&nbsp;" & user.name & " left the room</span><br>")
		
		' change room
		user.roomId = roomId
		
		updateUser(user)
		
		' notify users in new room
		Call addUserMessage(userId, "<span class='EnteringRoom'>&nbsp;" & user.name & " has entered the room</span><br>")
		
		Application.UnLock
		
	End Function ' // > Function enterRoom(userId, roomId)
	
	
	Function getNumberOfPublicMessages()
	
		Dim i, message
		
		getNumberOfPublicMessages = 0
		
		For i = 0 To conquerChatMessages.Count-1
			Set message = getMessage(CStr(i))
			
			If (StrComp(CStr(message.receiverId), "-1", 1) = 0) Then
				getNumberOfPublicMessages = getNumberOfPublicMessages + 1
			End If
			
		Next
		
	End Function ' // > Function getNumberOfPublicMessages()
	
	
	Sub pushMessage(data)
		
		If (getNumberOfPublicMessages() >= MESSAGES) Then
			' we need to remove a public entry from message array
			
			Dim i
			For i = 0 to conquerChatMessages.Count-2
				conquerChatMessages.Item(CStr(i)) = conquerChatMessages.Item(CStr(i+1))
			Next
			
			conquerChatMessages.Remove(CStr(conquerChatMessages.Count-1))
			
		End If
		
		conquerChatMessages.Add CStr(conquerChatMessages.Count), data
		
	End Sub
	
	
	Function addMessage(userId, receiverId, text)
		
		Dim user, message
		Set user = getUser(CStr(userId))
		Set message = New Message
		
		message.roomId = user.roomId
		message.userId = user.id
		message.receiverId = receiverId
		message.text = text
		
		pushMessage(message.data)
		
		Set addMessage = message
		
	End Function ' // > Function addMessage(userId, receiverId, text)
	
	
	Sub printMessages(roomId, userId, topToBottomOrder)
		
		Dim a, b, c, i, message
		
		If (topToBottomOrder) Then
			a = conquerChatMessages.Count-1
			b = 0
			c = -1
		Else
			a = 0
			b = conquerChatMessages.Count-1
			c = 1
		End If
		
		For i = a To b Step c
			Set message = getMessage(i)
			
			If (message.roomId = roomId) Then
				If (StrComp(CStr(message.receiverId), "-1", 1) = 0) Then
					' messages to all users
					Response.Write(message.text)
					
				ElseIf (StrComp(CStr(message.receiverId), CStr(userId), 1) = 0) Then
					' private messages to this user
					Response.Write(message.text)
					
				End If
			End If
			
			Set message = Nothing
		Next
		
'		For i = 1 To MESSAGES
'			Response.Write Application("$CONQUERCHAT:MESSAGES_" & user.roomId & "_" & i)
'		Next
		
		
	End Sub
	
	
	'
	' We do not want to have inactive users in our chat. In order to avoid
	' this, we enumerate all users last chat line and check the timestamp
	' on it. If it is older than the allowed inactivity limit, the user
	' is kicked from the chatroom
	'
	Function kickInactiveUsers()
		
		Dim i, now_
		now_ = Now()
		
		Application.Lock
		
		Dim userId, user
		For Each userId In conquerChatUsers
			Set user = getUser(userId)
			If (NOT user Is Nothing) Then
'				If (user.lastAction = "") Then
'					' somehow the lastAction is able to get zero or empty. I
'					' do not know why, but we take care of it by pinging the
'					' user (setting the lastAction) and .. well -- we're ex-
'					' tending his life a bit.
'					user.action()
'					Call updateUser(user)
'				End If
				
				If (DateDiff("s", CDate(user.lastAction), now_) > TIMEOUT) Then
					' this user needs to be logged out - he fell asleep in class..hmm
					Call removeUser(userId)
					For i = MESSAGES To 2 Step - 1
						Application("chatline_" & i) = Application("chatline_" & i-1)
					Next
					Application("chatline_1") = "<span class='LoggedOut'><img src='images/bp.gif' height='9' width='9'>&nbsp;" & user.name & " fell asleep and was put to bed at " & now_ & "</span><br>"
				End If
			End If
		Next
		
		Application.UnLock
		
	End Function ' // > Function kickInactiveUsers()
	
%>