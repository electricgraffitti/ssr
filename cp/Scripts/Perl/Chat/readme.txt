########################################
# EveryChat 3.61 (rev. 1/20/01)
#
# http://www.everysoft.com/everychat/
#
# Documentation

----------------------
Contents:

1. Legal Stuff
2. Description
3. Installation
4. Options
     - Making EveryChat compatible with EVERY browser
     - How to disable HTML removal
5. What it DOES do
6. What it DOESN'T do
7. Troubleshooting
8. Known Bugs
9. Version History
----------------------

1 - LEGAL STUFF

This program is free software; you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation; either version 2 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program; if not, write to the Free Software
Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA

The newest version of this software is always available at:
http://www.everysoft.com/everychat/

2 - DESCRIPTION

EveryChat is a very simple chat script designed to work on ANY server with Perl correctly
installed.  It allows a multi-user chat to take place with no maintenance.  With both
a frames and non frames mode using the SAME script, it can be used under ANY browser, even
lynx.  The whole script is under 5 kilobytes and lightning fast!

The script was built and tested using Perl for Win32 version 5, but the script should work
on every platform which supports perl.

The reason it is so fast and so light on the server is that the message file is a simple
HTML file. When users are in frames mode, the script is not called each time the messages
reload.  The only time scripts are used is when a new message is posted.

3 - INSTALLATION

a) Unzip the file using pkunzip, winzip, or another zip compression program for your
   platform.
b) Place all HTML files into a single directory accessible by the web (probably tour main
   HTML document directory).
c) Make a new EMPTY web-accessible subdirectory somewhere on your server and place the
   messages.html file there.  If you are on a UNIX system, use "chmod" to make the directory
   permissions writable by everybody.
d) Place everycht.cgi file in your cgi-bin directory or a shell-cgi directory, depending on
   your server setup.  You may have to rename it everycht.pl if you are on a server that
   only recognizes scripts as perl with a PL extension.
e) Install perl if it is not already installed.  You can get perl from
   http://www.perl.com/perl/
f) Open the everycht.cgi script with a text editor.  The first line of the script must point
   to the perl program on your server.  The configuration lines must be modified for your
   system.  The first configuration line should point to the directory you made in step c).
   Other lines are heavily commented.
g) Open the chatframes.html document with a text editor.  Be sure all paths are correct.
   Remember, the messages.html file is in the directory you made in step c).
h) Open the chatform.html file with a text editor.  Make sure the form points to YOUR
   everycht.cgi script.
i) Change the messages.html file permissions to writable by everybody.  Change the
   everycht.cgi permissions to executable by everybody.  Use chmod.  (UNIX systems only)
j) Give it a try by opening chatframes.html (for frames) or chatform.html (for non-frames)
   on your web server and pray real hard!

3a - MULTI-ROOM INSTALLATION

a) For each additional chat room you want, copy the messages.html file and save it as
   [roomName].html in the same directory.
   For example:
   If I wanted CoolRoom and MyRoom created, I would create two files in the same directory
   as messages.html called CoolRoom.html and MyRoom.html.  Each would contain 17 lines of
   text, just like messages.html.
   *** be sure to change file permissions to writable by everybody if you are on a
       UNIX system!!!
b) Create copies of chatform.html and edit the "room" line of the form to show the name of
   your new room (room names contain no spaces and are case sensative).  The room name
   should match the name given to your new message files, without the html extension.
c) Create copies of chatframes.html that point to your new chat messages files and the
   chatforms you created in step b).
   For example:
   My chatframes.html file for CoolRoom would point to CoolRoom.html
d) Open the new chatframes.html files and they should access the new rooms.

As it is set up, the multi-room feature of EveryChat works great for ISP's who want to give
their clients chat rooms (just give each client html files pointing to the room you have
created with their name).

It also works for remote hosting.  If you would like to remotely host EveryChat for people
without CGI access, that is fine.

The multiroom feature is very secure and users cannot just instantly create a new room
running from your server.  For additional chat rooms to work, the administrator must have
first created new messages files in the same directory as messages.html.

4 - OPTIONS

HOW TO MAKE THIS SCRIPT COMPATIBLE WITH EVERY BROWSER
Out of the box, this script only supports Netscape.  Users will see new messages added
to the bottom of the messages screen.  Using simple HTML tags, QuikChat looks great
under Netscape, scrolling to the bottom of the screen with each refresh.

Unfortunately, a bug in Microsoft's browser doesn't allow the "scroll to the bottom"
feature to work correctly.

Have no fear!  EveryChat has a built-in browser compatibility mode.  When enabled, the
script will add new messages to the top instead of the bottom of the messages file.
Internet Explorer users will see messages correctly and even lynx users will be able
to take advantage of the new non-frame features.  To enable this, edit everycht.cgi
and change $iecompatible=1.  Then remove the reference to #END from the chatframes.html
file (line 7).

HOW TO DISABLE HTML TAG REMOVAL
To disable the HTML tag removal feature, remove the HTML removal lines that are located
in the getform subprogram.

5 - WHAT IT DOES DO

This script was made to be a free alternative to commercial chat scripts that is quick and
easy to use by both the user and administrator.  It allows users to chat using their own
nicknames in a single chat room. The interface is such that users simply type their
messages in the bottom frame, and the upper frame, updated at 5-second intervals, displays
the messages.  When a user logs on, a message is sent to all other users announcing the
logon.  At logoff a message is also displayed.

6 - WHAT IT DOES NOT DO

This script is made to be easy to use.  When other scripts were tested, many new users had
trouble using advanced and unnecessary features like complicated multi-room selection and
private messages.  Because of that, all messages are public.  No pictures, java, active-x,
or other scripting languages are used that only slow down the client.  For ease of use,
users do not have to log off after chatting.  There is no user list, because without the
use of java, it is hard to keep one updated.  If you want such features, I suggest you
look at other scripts or commission me to build you one.  (Yes, it WILL cost you money!)

7 - TROUBLESHOOTING

Q. I get a "document contains no data" message after typing my name.  What's wrong?

A. There is no messages file for your chat room.  Either you are trying to access a room
with no pre-made messages file (see section 3a) or the path to your messages files is wrong
in the script.

Q. I get the dreaded "server error" message...  What do I do?

A. The most common problem is not having the messages.html created ahead of time...  Be
sure to have a messages.html file at least 17 lines long created in the directory you
specified.

Other errors are usually due to improper setup of perl or the inability of your server to
use perl scripts.

Q. The script appears to work great, but no messages are written to the message file.

A. Either the path to your messages.html file is not correctly specified, the messages.html
file does not have write permissions set, or the messages.html file is in a directory
without write access.  Try typing "chmod a+w messages.html" if you are using a unix system.

Q. I am running the scripts from a UNIX server and am having problems. What's wrong?

A. Be sure the file permissions are set correctly.  The messages.html file and directory
it is in must be given read and write access by everybody.  You must also make the script
executable.  If all else fails, be sure the path to your perl program is set correctly in
the script header.  You would be amazed at how many people forget this!

Q. I have no idea what's wrong!

A. Maybe you shouldn't be administering your own server :)

Q. I kinda know what's wrong, but I don't know what to do...

A. Go to the EveryChat forum at http://www.everysoft.com/support/ and post your
question.  It will be answered within a few days.

Q. Can I e-mail you for support?

A. NO!!!  Any e-mail you send me asking for support will be ignored.  I don't have the
time, the disk space, or the care to answer questions over and over again because people
don't want to write them on the forum.  I visit the forum on a daily basis to answer
questions there.  If you don't like that kind of free support, go pay $100 for a script
and then take advantage of their "free" support.

8 - KNOWN BUGS

Users of Microsoft Internet Explorer will have to manually scroll down the messages frame
to read new messages due to a bug in MSIE if $iecompatible is set to 0.  See Section 4 for
how to enable the built-in Internet Explorer Compatability mode.

9 - VERSION HISTORY

1.0 -> Original Version Released 2-1-97.

2.0 -> Current Version adds logoff button and times.  Also updated poorly formatted HTML
and updated documentation.  New files added: quiklogoff.pl and chattop.html.  Released
3-31-97.

2.1 -> Fixed bad date/time bug.  Released 4-1-97

2.1 release 2 -> Added option for removal of HTML tags from messages. No formal version
change was made since the feature is so minimal.  Released 4-3-97.

2.2 -> Minor enhancements/bug fixes including no caching for message entry form (basically
disabling a user from typing the same thing over and over again without retyping it every
time) and two part name fix.  Released 4-16-97.

3.0 -> Re-wrote some of the script to make it more efficient, no more quiklogoff.pl file,
support for remotely-hosted chat rooms, allows multiple rooms from one script, and new
plugins available!  New installation documentation.  You don't have to know how to
program to set it up now :)  Internet Explorer fix.  Also added title graphic by Daniel Hoth.
Probably more I forgot to mention.  Released 6/17/97.

3.5 -> Again, this was an almost total re-write.  Some bugs were fixed that were causing server
errors on some systems.  Also, a non-frames mode was added.  The name was changed from QuikChat
to EveryChat to settle a trademark issue.  Now the script should work with EVERY server and
EVERY browser!  Released 9/1/97.

3.6 -> Re-wrote the script to look nicer.  Error messages are now less cryptic and the script
is more modular.  No new features (still super-simple).  Released 1/28/98.

3.6 (re-release) -> EveryChat Moves to everysoft.com.  Documentation and scripts modified to
reflect the change.  Released 2/18/99.

3.6 (another re-release) -> EveryChat is now distributed under the GNU Public License.
Released 7/1/99.

3.61 -> Fixed netscape cache bug.  Released 1/20/01.
