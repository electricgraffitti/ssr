spiderDiscussion v1.0 README
	Script and README Author: <jthomas@spiderdepot.com>
	Script Last Modified: 7/13/01
	README Last Modified: 7/13/01

TABLE OF CONTENTS
1. Purpose
2. Requirements
3. Installation
4. Customization
5. Getting Support and Reporting Bugs
6. Acceptable Use

1. PURPOSE - Brief Explanation and Advantages
	spiderDiscussion v1.0 is a graphical counter.  Custom digit images can be used.  Leading zeroes can be added to the count to achieve a speedometer effect.  The counter can track only unique IP addresses or count all hits.

2. REQUIREMENTS - Necessary Software and Server Access
	PHP must be installed on your Web server.  You must be able to set file permissions.

3. INSTALLATION - Step-by-Step
	(1) Download and unzip counter.zip.  You should now have the following files:
		* counter.php
		* count.txt
		* images (directory), which contains 10 image files
		* ips.txt
	(2) Open counter.php for editing.  Read the notice and, if you wish, remove it.  Edit the variables (found under "// define the variables").  Skip ahead to the next section, Customization, if you don't understand what each variable does.  Save your changes.
	(3) If you wish to use other digit images, replace the ones found in the images directory.  Your images must be named 0-9.  If you use an extension besides .gif, you must edit the appropriate variable in counter.php.
	(4) Upload the files to your Web site.  You must place the digit images in a directory named images.
	(5) CHMOD count.txt and ips.txt 666 (read and write).
	(6) Add the following line of code to all pages that should display the counter:
		<? include("counter.php"); ?>
	    These pages must carry the .php or .phtml extensions.

4. CUSTOMIZATION
	The greatest customizable component to this script is the collection of digit images.  You can create any images you'd like to represent the digits 0-9 as long as you follow the instructions under Installation.
	There are also two features in counter.php:
	(1) The first is "minDigits".  You can achieve a "speedometer" effect for your counter by setting the minDigits variable to a number higher than the actual number of digits needed to display your hit count.  To show only the needed digits, set this variable to 0.  This is the default.
	(2) The second is "countOnce".  Set this variable to 1 if you want to count only unique IP addresses (in which case addresses will be logged to ips.txt, by default, although this filename can also be changed through a variable).  Set it to one if you want to count all hits, including multiple hits from the same person.  This is the default.

5. GETTING SUPPORT AND REPORTING BUGS
	Visit <http://www.spiderdepot.com/prebuilt/counter/> for updates.
	E-mail the author <jthomas@spiderdepot.com> for help and to report bugs.

6. ACCEPTABLE USE
	You may freely use, modify, and distribute this script.  You may remove notices on the script files.