

<?
if (!$pagebgc){
$back = "<b><font size=5>You forgot something!</font></b>";
echo $back;
exit;
}
else if (!$headerbgc){
$backy = "<b><font size=5>You forgot something!</font></b>";
echo $backy;
exit;
}
else if (!$namebgc){
$backy = "<b><font size=5>You forgot something!</font></b>";
echo $backy;
exit;
}
else if (!$messagebgc){
$backy = "<b><font size=5>You forgot something!</font></b>";
echo $backy;
exit;
}
 else if (!$linebgc){
$backy = "<b><font size=5>You forgot something!</font></b>";
echo $backy;
exit;
}
 else if (!$titlecolor){
$backy = "<b><font size=5>You forgot something!</font></b>";
echo $backy;
exit;
}
 else if (!$namecolor){
$backy = "<b><font size=5>You forgot something!</font></b>";
echo $backy;
exit;
}
else if (!$messagecolor){
$backy = "<b><font size=5>You forgot something!</font></b>";
echo $backy;
exit;
}
else if (!$datecolor){
$backy = "<b><font size=5>You forgot something!</font></b>";
echo $backy;
exit;
}
else if (!$back_link_normal){
$backy = "<b><font size=5>You forgot something!</font></b>";
echo $backy;
exit;
}
 else if (!$back_link_hover){
$backy = "<b><font size=5>You forgot something!</font></b>";
echo $backy;
exit;
}
else if (!$em_url_link_normal){
$backy = "<b><font size=5>You forgot something!</font></b>";
echo $backy;
exit;
}
else if (!$em_url_link_hover){
$backy = "<b><font size=5>You forgot something!</font></b>";
echo $backy;
exit;
}
else if (!$home){
$backy = "<b><font size=5>You forgot something!</font></b>";
echo $backy;
exit;
}
else if (!$entries){
$backy = "<b><font size=5>You forgot something!</font></b>";
echo $backy;
exit;
}
$tekst ="Ready" ;
echo $tekst     ;
$fh = fopen ("config.php", "w");
fwrite ($fh, "<? \n\$smiley = \"$smiley\" ; \n\$entries = \"$entries\" ; \n\$strip = \"$strip\" ;\n\$home = \"$home\" ;\n\$show_date = \"$show_date\" ; \n\$show_time = \"$show_time\" ;\n\$pagebgc = \"$pagebgc\" ; \n\$headerbgc = \"$headerbgc\"  ; \n\$namebgc = \"$namebgc\" ; \n\$messagebgc = \"$messagebgc\" ; \n\$linebgc = \"$linebgc\" ; \n\$titlecolor = \"$titlecolor\" ; \n\$namecolor = \"$namecolor\" ; \n\$messagecolor = \"$messagecolor\" ; \n\$datecolor = \"$datecolor\" ; \n\$back_link_normal = \"$back_link_normal\" ; \n\$back_link_hover = \"$back_link_hover\" ; \n\$em_url_link_normal = \"$em_url_link_normal\" ; \n\$em_url_link_hover = \"$em_url_link_hover\" ; \n?> "   ) ;
fclose ($fh);
?>


<html>
<head>
<META HTTP-EQUIV="refresh" CONTENT="0;URL=setup.php">
<title>Saving config...</title>
</head>
</html>