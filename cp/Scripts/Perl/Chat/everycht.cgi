#>---------------------------------------<#
#| EveryChat 3.61 (rev. 1/20/01)         |#
#| Copyright (C) 1999 Matt Hahnfeld      |#
#>---------------------------------------<#

# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 2 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
#
# The newest version of this software is always available at:
# http://www.everysoft.com/everychat/

#>---------------------------------------<#
#| CONFIGURATION (MODIFY THIS SECTION)   |#
#>---------------------------------------<#

# place the absolute path to your chat room message files
# here (include a trailing slash).

	$filepath='cp/scripts/perl/chat/messages/';

# place the file extention of your chat room message files
# here, including the dot.  It is probably .htm or .html

	$filext='.html';

# setting this flag will make messages scroll from top to
# bottom, making the script compatible with EVERY browser.
# See the readme.txt file under OPTIONS for more details!

	$iecompatible=0;

#>---------------------------------------<#
#| Main Program                          |#
#| (all it does is call subprograms)     |#
#>---------------------------------------<#

print "Content-type: text/html\nPragma: no-cache\n\n";
print "<html><title></title><BODY BGCOLOR=#000080 TEXT=#FFFFFF>\n";
&getform;
if (&getoldfile) {
	&gettime;
	&printform;
	if ($form{'message'} ne "") { &printnewfile; }
	else { &printnoframes; }
}
else
{
	print "The room you entered <I>$form{'room'}</I> does not exist.<BR>\n";
	print "Tell the server administrator to check the file: <I>$filepath$form{'room'}$filext</I>\n";
}
print "</font></body></html>\n";
exit(0);

#>---------------------------------------<#
#| Sub getform - reads form data         |#
#>---------------------------------------<#

sub getform {
	$buffer = "";
	read(STDIN, $buffer, $ENV{'CONTENT_LENGTH'});
	@pairs=split(/&/,$buffer);
	foreach $pair (@pairs)
	{
		@a = split(/=/,$pair);
		$name=$a[0];
		$value=$a[1];
		$value =~ s/\+/ /g;
		$value =~ s/%([a-fA-F0-9][a-fA-F0-9])/pack("C", hex($1))/eg;
		$value =~ s/~!/ ~!/g;
		$value =~ s/\</\&lt\;/g;  # html tag removal (remove these lines to enable HTML tags in messages)
		$value =~ s/\>/\&gt\;/g;  # html tag removal (remove these lines to enable HTML tags in messages)
		$value =~ s/[\r\n]//g;
		push (@data,$name);
		push (@data,$value);
	}
	%form=@data;
	%form;
}

#>---------------------------------------<#
#| Sub getoldfile - reads old HTML       |#
#| messages file and returns 0 if not    |#
#| found or 1 if found                   |#
#>---------------------------------------<#

sub getoldfile {
	$form{'room'} =~ s/\W//g;
	return 0 unless open(HTMLOLD, "$filepath$form{'room'}$filext");
	@lines=<HTMLOLD>;
	close(HTMLOLD);
	return 1;
}

#>---------------------------------------<#
#| Sub gettime - reads system time       |#
#>---------------------------------------<#

sub gettime {
	$now_string = localtime;
	@thetime = split(/ +/,$now_string);
	@theclock = split(/:/,$thetime[3]);
	$ampm = 'am';
	if ($theclock[0] > 11)
	{ $ampm = 'pm'; }
	if ($theclock[0] == 0)
	{ $theclock[0] = 12; }
	if ($theclock[0] > 12)
	{ $theclock[0] -= 12; }
	else
	{ $theclock[0] += 0; }
}

#>---------------------------------------<#
#| Sub printform - prints new form       |#
#>---------------------------------------<#

sub printform {
	if ($form{'logoff'} eq '1')
	{
		print << "EOF";
		<CENTER>Thank you for using EveryChat 3.61!</CENTER><BR><HR><FONT SIZE=-1>
EOF
	}
	else
	{
		print << "EOF";
		<CENTER><TABLE CELLSPACING=0 CELLPADDING=0>
		<TR><TD>
		<nobr><FORM ACTION="$ENV{'SCRIPT_NAME'}" METHOD="POST">
		Your message: <input name=username type=hidden value="$form{'username'}">
		<input name=room type=hidden value="$form{'room'}">
		<input type=text name=message size=35>
		<input type=submit value="Post This">
		</form></nobr>
		</TD><TD>
		<nobr><FORM ACTION="$ENV{'SCRIPT_NAME'}" METHOD="POST">
		<input name=username type=hidden value="$form{'username'}">
		<input name=room type=hidden value="$form{'room'}">
		<input name=logoff type=hidden value=1>
		<input type=hidden name=message value="Buh-Bye! I just logged off!">
		<input type=submit value="Logoff">
		</form></nobr>
		</TD></TR>
		</TABLE></CENTER><BR><HR>
		<FONT SIZE=-2>Hit "post" without entering a message to refresh the screen...</FONT><FONT SIZE=-1>
EOF
	}
}

#>---------------------------------------<#
#| Sub printnewfile - prints new HTML    |#
#| messages file                         |#
#>---------------------------------------<#

sub printnewfile {
	$newmessage = "<P><B>$form{'username'}</B> says,\"$form{'message'}\" ($thetime[0] $theclock[0]:$theclock[1]$ampm)\n";
	open (NEW, ">$filepath$form{'room'}$filext");
	print NEW "<HTML><HEAD><META HTTP-EQUIV=Refresh CONTENT=5><META HTTP-EQUIV=Pragma CONTENT=no-cache></HEAD><BODY BGCOLOR=#FFFFFF>\n";
	if ($iecompatible) {
		print NEW $newmessage;
		print $newmessage;
		for ($i = 1; $i < 15; $i++)
		{
			print NEW "$lines[$i]";
			print "$lines[$i]";
		}
		print NEW "<BR><FONT COLOR=#FFFFFF>EveryChat (c) 1997-99 Matt Hahnfeld</FONT></BODY>\n";
	}
	else {
		for ($i = 2; $i < 16; $i++)
		{
			print NEW "$lines[$i]";
			print "$lines[$i]";
		}
		print NEW $newmessage;
		print $newmessage;
		print NEW "<BR><FONT COLOR=#FFFFFF><A NAME=END>EveryChat (c) 1997-99 Matt Hahnfeld</A></FONT></BODY>\n";
	}
	close NEW;
}

#>---------------------------------------<#
#| Sub printnoframes - refreshes screen  |#
#| if no messages are posted             |#
#>---------------------------------------<#

sub printnoframes {
	for ($i = 1; $i < 16; $i++)
	{
		print "$lines[$i]";
	}
}
