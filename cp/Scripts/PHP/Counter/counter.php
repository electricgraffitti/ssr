<?

////////////////////////////////////////////////////////////
//
// counter.php - a graphical counter
//
////////////////////////////////////////////////////////////
//
// This script outputs a "hit count" displayed using digit
// images and formatted according to the setting for
// "minDigits".  The hit count can be incremented on every
// page hit or only for unique IP addresses (the
// "countOnce" feature).
//
// See help.txt for more information.
//
// Author: Jon Thomas <jthomas@spiderdepot.com>
// Last Modified: 7/13/01
//
// You may freely use, modify, and distribute this script.
// You may remove this notice.
//
////////////////////////////////////////////////////////////

// define the variables
$file = "count.txt";	// text file that stores hit count
$imgExtension = "gif";	// file extension of digit images
$minDigits = 0;		// the minimum # of digits to display
			// set to 0 to display only needed digits
$countOnce = 0;		// set to 1 to count unique IPs only
			// set to 0 to count all hits
$ipFile = "ips.txt";	// text file that stores IP addresses

// DO NOT EDIT BELOW THIS POINT UNLESS YOU KNOW PHP! //

// get the current hit count
$fp_count = fopen($file, "r");
$count = fread($fp_count, filesize($file));
fclose($fp_count);

// if the "countOnce" feature is enabled
if ($countOnce) {
	// open the IP address file
	$fp_ips = fopen($ipFile, "r");

	// compare each entry with the user's IP address
	while (!feof($fp_ips)) {
		// get an entry from the IP file
		$ip = fgets($fp_ips, 20);

		// if the user's IP matches, set the user to old
		if ($ip == $REMOTE_ADDR . "\r\n") {
			$is_old = 1;
			break;
		}

		// otherwise, set the user to new
		else {
			$is_old = 0;
		}
	}

	// close the IP address file
	fclose($fp_ips);

	// if the user is not old, add his IP to the IP file
	if (!$is_old) {
		// reopen the IP address file
		$fp_ips = fopen($ipFile, "a");

		// add the user's IP address
		fputs($fp_ips, $REMOTE_ADDR . "\r\n");

		// close the IP address file
		fclose($fp_ips);
	}
}

// if the "countOnce" feature is disabled, set the user to new
else {
	$is_old = 0;
}

// if the user is not old, increment the counter
if (!$is_old) {
	$count++;

	// save the new hit count
	$fp_count = fopen($file, "w");
	fputs($fp_count, $count);
	fclose($fp_count);
}

// count the number of digits in the hit count
$digits = strlen($count);

// if minDigits is set and the number of digits is less than minDigits, add leading zeroes
if ($minDigits && $digits < $minDigits) {
	// find the difference between minDigits and the number of digits in the count
	$diff = $minDigits - $digits;

	// add a number of leading zeroes equal to the difference
	for ($i = 0; $i < $diff; $i++) {
		$count = "0" . $count;
	}

	// set digits equal to minDigits
	$digits = $minDigits;
}
echo "<center>";
// print the appropriate image for each digit in the hit count
for ($i = 0; $i < $digits; $i++)
{
	// get a digit from the hit count
	$digit = substr("$count", $i, 1);

	// print the image for that digit
	echo "<img src=images/digits/$digit.$imgExtension>";
}
echo "</center>";
?>