<%
'/----------------------------------------------\
'>********** Please choose you colors:**********<
'\----------------------------------------------/
HeadingCellBgColor="#000099"
HeadingCellTextColor="#ffffff"
CellBgColor="#f0f0f0"
CellTextColor="#000000"
%>
<!-- Guestbook written by Sakki www4.ewebcity.com/sakki -->
<html>
<head>
<title>My guestbook</title>
</head>
<body>
<%
'/----------------------------------------------\
'>********* Data selected or requested *********<
'\----------------------------------------------/
Flag = Request.form("Flag")
If Flag = 1 then
Name = Request.form("Name")
Email = Request.form("Email")
Url = Request.form("Url")
Comment = Request.form("Comment")
Comment = server.HTMLencode(Comment) 'Do not allow HTML
Comment = Replace(Comment,VbCrlf,"<br>")
'************************************************

'/----------------------------------------------\
'>*************** Validation *******************<
'\----------------------------------------------/
errmsg="<ul>"
If Replace(Name," ","") = "" then errmsg = errmsg & "<li>Name is missing</li>"
   If Replace(Email," ","") = "" then 
   errmsg = errmsg & "<li>Email is missing</li>"
   ElseIf InStr(Email,"@")=0 then 
		'all emails contain an at sign eg. you@you.com
   errmsg = errmsg & "<li>Email is invalid</li>"
   ElseIf InStr(Email,".")=0 then
		'all emails contain a dot eg. you@you.com
   errmsg = errmsg & "<li>Email is invalid</li>"
   End If
'Url is not required
If Replace(Comment," ","") = "" then errmsg = errmsg & "<li>Comment is missing</li>"
errmsg = errmsg & "</ul>"
If NOT errmsg ="<ul></ul>" then
%>
<font size=5 color=red>Following errors were detected:</font><br>
<%= errmsg %>
<i>Please click the back button on your browser, <a href="javascript:history.go(-1)">or click here</a> and fix these errors.</i>
</body></html>
<%
Response.end 
End If
'************************************************

'/----------------------------------------------\
'>********** The new record is created *********<
'\----------------------------------------------/
'Comment next line out if you want the new record to appear as the last record in the guestbook
Newrecord = "<!-- ## GBDATA ## -->"

Newrecord = Newrecord & "<!-- Begin record. Name:" & name & " -->" & VbCrlf
Newrecord = Newrecord & "<table border='0' align='center' width='500' cellpadding='0'>" & VbCrlf
Newrecord = Newrecord & "<tr><td width='70' bgcolor='" & HeadingCellBgColor & "'><Font size=2 face='arial' color='" & HeadingCellTextColor & "'><b>Date:</B></font></td><td bgcolor='" & CellBgColor & "'><Font size=2 face='arial' color='" & CellTextColor & "'>" & now & "</font></td></tr>" & VbCrlf
Newrecord = Newrecord & "<tr><td width='70' bgcolor='" & HeadingCellBgColor & "'><Font size=2 face='arial' color='" & HeadingCellTextColor & "'><b>Name:</B></font></td><td bgcolor='" & CellBgColor & "'><Font size=2 face='arial' color='" & CellTextColor & "'>" & Name & "</font></td></tr>" & VbCrlf
Newrecord = Newrecord & "<tr><td width='70' bgcolor='" & HeadingCellBgColor & "'><Font size=2 face='arial' color='" & HeadingCellTextColor & "'><b>Email:</B></font></td><td bgcolor='" & CellBgColor & "'><a href='mailto:" & Email & "'><Font size=2 face='arial'>" & Email & "</font></a></td></tr>" & VbCrlf

If NOT Url = "" then
Newrecord = Newrecord & "<tr><td width='70' bgcolor='" & HeadingCellBgColor & "'><Font size=2 face='arial' color='" & HeadingCellTextColor & "'><b>Own Url:</B></font></td><td bgcolor='" & CellBgColor & "'><a href='" & Url &"'><font size='2' Face='Arial'>" & Url & "</font></a></td></tr>" & VbCrlf
End If

Newrecord = Newrecord & "<tr><td colspan=2 bgcolor='" & HeadingCellBgColor & "'><center><Font size=2 face='arial' color='" & HeadingCellTextColor & "'><b>Comments:</b></font></center></td></tr>" & VbCrlf
Newrecord = Newrecord & "<tr><td colspan=2 bgcolor='" & CellBgColor & "'><Font size=2 face='arial' color='" & CellTextColor & "'>" & Comment & "</font></td></tr></table>" & VbCrlf
Newrecord = Newrecord & "<br><!-- End record. name:" & name & " -->" & VbCrlf & VbCrlf
If Instr(Newrecord,"<!-- ## GBDATA ## -->") = 0 then
Newrecord = Newrecord & "<!-- ## GBDATA ## -->"
End If
'************************************************

'/----------------------------------------------\
'>********** Edit data.txt *********************< 
'\----------------------------------------------/
fn = server.mappath("data.txt")			    'Find data.txt on server
Set fs = CreateObject("Scripting.FileSystemObject") 'Create the FileSystem object
Set htmlfile = fs.OpenTextFile(fn, 1, 0, 0)	    'Open data.txt
code = htmlfile.ReadAll				    'Read contents of file
htmlfile.close					    'Close data.txt
set htmlfile = nothing				

code = Replace(Code,"<!-- ## GBDATA ## -->",Newrecord) 'Add the new record

Set htmlfile = fs.CreateTextFile(fn)		    'ReCreate data.txt
htmlfile.write code				    'Write contents
htmlfile.close 					    'Close data.txt
set htmlfile = nothing
set fs = nothing				    'Close FileSystem object
' *****************************************
%>
<!-- Thank you message -->

<center><font size=4 face='arial'>Thank you for signing my guestbook</font>
<br><be><a href='view.asp'><font face='arial' color='#000099' size=2>View guestbook</font></center>

<!-- End of thank you message -->
<%
Else
%>
<!-- Sign form -->

<font size="5" face="arial"><center>Sign my guestbook</center></font><br>
<form action="sign.asp" method="post">
<table border="0" align="center">
<tr><td bgcolor='<%= HeadingCellBgColor %>'><font size="2" face="arial" color="<%= HeadingCellTextColor %>"><b>Name:</B></font></td><td bgcolor='<%= CellBgColor %>'><input type="text" name="name" maxlength="30"></td></tr>
<tr><td bgcolor='<%= HeadingCellBgColor %>'><font size="2" face="arial" color="<%= HeadingCellTextColor %>"><b>Email:</B></font></td><td bgcolor='<%= CellBgColor %>'><input type="text" name="email" maxlength="30"></td></tr>
<tr><td bgcolor='<%= HeadingCellBgColor %>'><font size="2" face="arial" color="<%= HeadingCellTextColor %>"><b>Own Url:</B></font></td><td bgcolor='<%= CellBgColor %>'><input type="text" name="url" maxlength="50"></td></tr>
<tr><td colspan=2 bgcolor="<%= HeadingCellBgColor %>"><center><font size="2" face="arial" color="<%= HeadingCellTextColor %>"><b>Comments:</b></font></center></td></tr>
<tr><td colspan=2 bgcolor='<%= CellBgColor %>'><textarea name="Comment" cols=30 rows=5></textarea></td></tr>
<tr><td>&nbsp;</td><td><input type="hidden" name="flag" value=1><input type=submit value="&nbsp;&nbsp;&nbsp;&nbsp;submit&nbsp;&nbsp;&nbsp;&nbsp;"></table>
</form>
<!-- End of sign form -->
<%
End If
%>
</body>
</html>