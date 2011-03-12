
 ConquerChat README
 Copyright (c) 2000-2001 Peter Theill, theill.com
 
 -----------------------------------------------------------------------------
 Introduction
 -----------------------------------------------------------------------------
 This archive contains a simple ASP chat. Most other chatrooms works using the
 Session object. This chat doesn't and  thus might be used on larger  range of
 browsers and -settings.
 
 By using  all files  in this  archive, you  are actually  able to  set up and
 customise your own chatroom on your ASP enabled web site.
 
 In order to  make the chat  work properly, you  will have to  add a couple of
 lines in your  "global.asa" file. The  lines below are  also included in  the
 downloadable package. You should  insert them in the  top of your file,  i.e.
 not in any of the default defined Sub functions.

	<OBJECT RUNAT=Server
		SCOPE=Application
		ID=conquerChatUsers
		PROGID="Scripting.Dictionary">
	</OBJECT>

	<OBJECT RUNAT=Server
		SCOPE=Application
		ID=conquerChatRooms
		PROGID="Scripting.Dictionary">
	</OBJECT>

	<OBJECT RUNAT=Server
		SCOPE=Application
		ID=conquerChatMessages
		PROGID="Scripting.Dictionary">
	</OBJECT>

 The lines above makes  it possible to store  currently logged in chat  users,
 rooms and  messages. We  check this  object every  time we  refresh the  chat
 window page and kick  out inactive users. If  you do not have  a 'global.asa'
 file use the one provided with this package. You have to place it in the root
 of your web server and not in the 'chat' directory or where you place all the
 other files.
 
 Please check:
 
 	http://www.theill.com/asp/conquerchat.asp
 	
 for FAQ & updated information about ConquerChat.
 
 
 -----------------------------------------------------------------------------
 Customize ConquerChat
 -----------------------------------------------------------------------------
 To make  customisation to  the name  and/or number  of rooms,  make sure  you
 reinitialise   the   chat.   This    is   done   by   temporarily    enabling
 INITIALIZING_CHATSYSTEM in constants.inc.
 
 After having  enabled this,  request the  default.asp page  and the chat will
 remove all rooms and users and  create the new rooms you might  have selected
 in the constants.inc file.
 
 If you need me  to make a customized  version of ConquerChat for  you, please
 contact me (sales@theill.com) for details about pricing.
 
 
 -----------------------------------------------------------------------------
 Copyright
 -----------------------------------------------------------------------------
 You are able to modify the  source-code any way you like. All  advertisements
 and/or banners shown in the downloaded chat may be removed before using it on
 your own site. ConquerChat  is 100% freeware and  enables you to get  a quick
 start setting up your own chat without any restrictions.
 
 
 -----------------------------------------------------------------------------
 Important note for Internet Information Server 5.0 users
 -----------------------------------------------------------------------------
 There might be a problem for users on older versions of IIS5:
   http://support.microsoft.com/support/kb/articles/Q271/7/87.ASP?LN=EN-US&SD=gn&FR=0&qry=Application.Lock%20IIS5&rnk=1&src=DHCS_MSPSS_gn_SRCH&SPR=MSALL
 
 
 -----------------------------------------------------------------------------
 Version History
 -----------------------------------------------------------------------------
 09/30/2001 - Released 3.1
  + Added support for private messages
  + Added user statistics for showing log on time, last action time, number of
    messages typed in the chat and the users IP address.
 
 06/09/2001 - Released 3.0.2.0
  + Added a page being displayed for the user if required variables haven't
    been included in global.asa file.
 
 05/01/2001
  + Added option for clearing message field after having send a message.
  
 03/21/2001 - Released 3.0.1.0
  + Added a new constant "TOP_MESSAGE_ORDER" for selecting if the messages
    should be printed top-to-bottom or bottom-to-top.
  
 02/08/2001 - Released 3.0.0.1
  ! Fixed a problem when checking for invalid username in default.asp page.
  
 10/22/2000 - Released 3.0.0.0
  + Added support for multiple rooms
 
 07/18/2000 - Released 2.1.1.0
  + updated code with a more safe logout method.
  + help files updated to show smiley states and descriptions.
 
 06/29/2000 - Released 2.1.0.0
  + added ability to replace typed smilies with images showing state. This
    feature was implemented thanks to Michael Mackert.
 
 Best regards,
  Peter Theill - peter@theill.com - http://www.theill.com
 -----------------------------------------------------------------------------