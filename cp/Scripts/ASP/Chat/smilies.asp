<%	Option Explicit %>
<!-- #include file="constants.inc" -->
<%
	
	' 
	' :@smilies.asp
	' 
	' 
	'
	' @author	Peter Theill	peter@theill.com
	' 
	
	Response.Buffer = True
	
%>
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
 <td nowrap valign="top">
  <p align="left"><span style="font-size: 8pt">[ <a href="help.asp"><b>general help</b></a> ]</span></p>
 </td>
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
<p>When typing in special characters known as smiley's, these will be replaced by
real images as shown in the list below.</p>

<div align="center">
  <center>

<table border="0" cellspacing="0" cellpadding="6">
  <tr>
    <td align="center" nowrap><font face="monospace">O:-)</font></td>
    <td align="center" nowrap><img border="0" src="images/angel.gif" width="15" height="23"></td>
    <td align="left" nowrap>Angel</td>
    <td align="center" nowrap width="32"></td>
    <td align="center" nowrap><font face="monospace">:-[</font></td>
    <td align="center" nowrap><img border="0" src="images/angry.gif" width="15" height="15"></td>
    <td align="left" nowrap>Angry</td>
  </tr>
  <tr>
    <td class="dark" align="center" nowrap><font face="monospace">xx(</font></td>
    <td class="dark" align="center" nowrap><img border="0" src="images/dead.gif" width="15" height="15"></td>
    <td class="dark" align="left" nowrap>Hung Over</td>
    <td class="dark" align="center" nowrap width="32"></td>
    <td class="dark" align="center" nowrap><font face="monospace">:-]</font></td>
    <td class="dark" align="center" nowrap><img border="0" src="images/devil.gif" width="15" height="15"></td>
    <td class="dark" align="left" nowrap>Devil</td>
  </tr>
  <tr>
    <td align="center" nowrap><font face="monospace">:-)</font></td>
    <td align="center" nowrap><img border="0" src="images/smile.gif" width="15" height="15"></td>
    <td align="left" nowrap>Smile</td>
    <td align="center" nowrap width="32"></td>
    <td align="center" nowrap><font face="monospace">:D</font></td>
    <td align="center" nowrap><img border="0" src="images/biggrin.gif" width="15" height="15"></td>
    <td align="left" nowrap>Big Grin</td>
  </tr>
  <tr>
    <td class="dark" align="center" nowrap><font face="monospace">:o)</font></td>
    <td class="dark" align="center" nowrap><img border="0" src="images/clown.gif" width="15" height="15"></td>
    <td class="dark" align="left" nowrap>Clown</td>
    <td class="dark" align="center" nowrap width="32"></td>
    <td class="dark" align="center" nowrap><font face="monospace">:O</font></td>
    <td class="dark" align="center" nowrap><img border="0" src="images/oh.gif" width="15" height="15"></td>
    <td class="dark" align="left" nowrap>Oh!</td>
  </tr>
  <tr>
    <td align="center" nowrap><font face="monospace">:-(</font></td>
    <td align="center" nowrap><img border="0" src="images/frown.gif" width="15" height="15"></td>
    <td align="left" nowrap>Frown</td>
    <td align="center" nowrap width="32"></td>
    <td align="center" nowrap><font face="monospace">:P</font></td>
    <td align="center" nowrap><img border="0" src="images/tongue.gif" width="15" height="15"></td>
    <td align="left" nowrap>Cheeky</td>
  </tr>
  <tr>
    <td class="dark" align="center" nowrap><font face="monospace">;-)</font></td>
    <td class="dark" align="center" nowrap><img border="0" src="images/wink.gif" width="15" height="15"></td>
    <td class="dark" align="left" nowrap>Wink</td>
    <td class="dark" align="center" nowrap width="32"></td>
    <td class="dark" align="center" nowrap></td>
    <td class="dark" align="center" nowrap></td>
    <td class="dark" align="left" nowrap></td>
  </tr>
</table>
  </center>
</div>
</td>
</table>

</body>
</html>