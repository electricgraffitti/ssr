<html>
<head>
<title>Hit Counter</title>
<!-- The Web Wiz Guide hit counter is written by Bruce Corkhill ©2001
     	If you want your own hit counter then goto http://www.webwizguide.com -->
</head>
<body bgcolor="white" text="black">
<div align="center"> 
  <h1>Hit Counter</h1>
  <%
'Dimension variables
Dim fsoObject 			'File System Object
Dim tsObject 			'Text Stream Object
Dim filObject			'File Object
Dim lngVisitorNumber 		'Holds the visitor number
Dim intWriteDigitLoopCount 	'Loop counter to display the graphical hit count
	
'Create a File System Object variable
Set fsoObject = Server.CreateObject("Scripting.FileSystemObject")

'Initialise a File Object with the path and name of text file to open
Set filObject = fsoObject.GetFile(Server.MapPath("hit_count.txt"))
	
'Open the visitor counter text file
Set tsObject = filObject.OpenAsTextStream
	
'Read in the visitor number from the visitor counter file
lngVisitorNumber = CLng(tsObject.ReadAll)
	
'Increment the visitor counter number by 1
lngVisitorNumber = lngVisitorNumber + 1
			
'Create a new visitor counter text file over writing the previous one
Set tsObject = fsoObject.CreateTextFile(Server.MapPath("hit_count.txt"))
	
'Write the new visitor number to the text file
tsObject.Write CStr(lngVisitorNumber)
	
'Reset server objects
Set fsoObject = Nothing
Set tsObject = Nothing
Set filObject = Nothing

'HTML output to display the visitor number
Response.Write("<font size=2>Visitor Number</font><br>")

'Display the hit count as text
'Response.Write(lngVisitorNumber)

'Loop to display graphical digits
For intWriteDigitLoopCount = 1 to Len(lngVisitorNumber)
	
	'Display the graphical hit count
	Response.Write("<img src=""counter_images/") 
	Response.Write(Mid(lngVisitorNumber, intWriteDigitLoopCount, 1) & ".gif""") 
	Response.Write("alt=""" & Mid(lngVisitorNumber, intWriteDigitLoopCount, 1) & """>")
Next
%>
  <br>
  <br>
  <a href="http://www.webwizguide.com" target="_top"><img src="web_wiz_guide.gif" width="100" height="30" border="0" alt="Web Wiz Guide"></a> 
</div>
</body>
</html>