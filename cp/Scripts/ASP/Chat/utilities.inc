<%
	
	'
	' Replaces most commonly used smilies with small images indicating the
	' text-smiley in a more fancy way ;-)
	'
	Function replaceSmilies(s)
		
		If (Len(s) = 0) Then
			replaceSmilies = ""
			Exit Function
		End If
		
		s = Replace(s, "O:-)", "<img src='images/angel.gif' width=15 height=23 alt='O:-)'>")
		s = Replace(s, "xx(",  "<img src='images/dead.gif' width=15 height=15 alt='xx('>")
		s = Replace(s, ":-)",  "<img src='images/smile.gif' width=15 height=15 alt=':-)'>")
		s = Replace(s, ":o)",  "<img src='images/clown.gif' width=15 height=15 alt=':o)'>")
		s = Replace(s, ":-(",  "<img src='images/frown.gif' width=15 height=15 alt=':-('>")
		s = Replace(s, ":o(",  "<img src='images/frown.gif' width=15 height=15 alt=':o('>")
		s = Replace(s, ";-)",  "<img src='images/wink.gif' width=15 height=15 alt=';-)'>")
		s = Replace(s, ";o)",  "<img src='images/wink.gif' width=15 height=15 alt=';o)'>")
		s = Replace(s, ":-[",  "<img src='images/angry.gif' width=15 height=15 alt=':-['>")
		s = Replace(s, ":o[",  "<img src='images/angry.gif' width=15 height=15 alt=':o['>")
		s = Replace(s, ":-]",  "<img src='images/devil.gif' width=15 height=15 alt=':-]'>")
		s = Replace(s, ":o]",  "<img src='images/devil.gif' width=15 height=15 alt=':o]'>")
		s = Replace(s, ":)",   "<img src='images/smile.gif' width=15 height=15 alt=':)'>")
		s = Replace(s, ":(",   "<img src='images/frown.gif' width=15 height=15 alt=':('>")
		s = Replace(s, ";)",   "<img src='images/wink.gif' width=15 height=15 alt=';)'>")
		s = Replace(s, ":]",   "<img src='images/devil.gif' width=15 height=15 alt=':]'>")
		s = Replace(s, ":[",   "<img src='images/angry.gif' width=15 height=15 alt=':['>")
		s = Replace(s, ":D",   "<img src='images/biggrin.gif' width=15 height=15 alt=':D'>")
		s = Replace(s, ":O",   "<img src='images/oh.gif' width=15 height=15 alt=':O'>")
		s = Replace(s, ":P",   "<img src='images/tongue.gif' width=15 height=15 alt=':P'>")
		
		replaceSmilies = s
		
	End Function	
	
%>