<!-- #include file="constants.inc" -->
<html>
<head>
	<title><%= APPLICATION_NAME %> - Help</title>
	<link rel="stylesheet" type="text/css" href="chat.css">
</head>

<body topmargin=0 leftmargin=0 marginwidth=0 marginheight=0 background="images/helpbackground.gif">

<table border="0" width="100%" height="48" cellspacing="0" cellpadding="8" bgcolor="#FFCC66">
<tr>
 <td width="100%"><b>Quick Help</b></td>
 <% If (USE_IMAGE_SMILEY) Then %>
 <td nowrap valign="top"><span style="font-size: 8pt"><a href="smilies.asp"><img src="images/smilies.gif" width=64 height=32 border=0 alt='See available smileys'></a></span></td>
 <% End If %>     
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
<p>The following commands are available in the chat room.</p>

<ul>
  <li>&lt;b&gt; and &lt;/b&gt; to surround <b>bold</b> text.</li>
  <li>&lt;i&gt; and &lt;/i&gt; to surround <i>italic</i> text.</li>
  <li>&lt;u&gt; and &lt;/u&gt; to surround <u>underlined</u> text.</li>
</ul>
<p>Some symbols are used to indicate users logging in and out.</p>
<ul>
  <li>A <img border="0" src="images/new.gif" width="9" height="9" alt="new"> indicates a user has logged in.</li>
  <li>A <img border="0" src="images/bp.gif" width="9" height="9" alt="notify"> indicates a user has logged out.</li>
</ul>
<p>Hint:</p>
<ul>
  <li>Type an empty message to refresh chat window immediately.</li>
</ul>

</td>
</tr>
</table>
</body>
</html>