<%@ LANGUAGE = VBScript.Encode %>
<% 
session("securedbyuser") = "test"
session("securedbygroup") = ""   'this line is available in the licensed version
session("pagename") = "ASPSecured Test Page"
session("loginpage") = "/aspsecured/login.asp"
%>
<!--#include virtual="/aspsecured/secured.asp"-->



<html>

<head>
<meta http-equiv="Content-Language" content="en-us">
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
<meta name="GENERATOR" content="Microsoft FrontPage 4.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
<title>New Page 3</title>
</head>

<body>

<p>you have logged in </p>
<p>thanks</p>
<p>userid:<b><%=session("secureduserid")%></b></p>
<p>username:<b><%=session("securedusername")%></b></p>





</body>

</html>
