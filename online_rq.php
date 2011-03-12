<?PHP
define('kOptional', true);
define('kMandatory', false);

define('kStringRangeFrom', 1);
define('kStringRangeTo', 2);
define('kStringRangeBetween', 3);
        
define('kYes', 'yes');
define('kNo', 'no');

define('kNumberRangeFrom', 1);
define('kNumberRangeTo', 2);
define('kNumberRangeBetween', 3);




error_reporting(E_ERROR | E_WARNING | E_PARSE);
ini_set('track_errors', true);

function DoStripSlashes($fieldValue)  { 
 if ( get_magic_quotes_gpc() ) { 
  if (is_array($fieldValue) ) { 
   return array_map('DoStripSlashes', $fieldValue); 
  } else { 
   return stripslashes($fieldValue); 
  } 
 } else { 
  return $fieldValue; 
 } 
}

function FilterCChars($theString) {
 return preg_replace('/[\x00-\x1F]/', '', $theString);
}

function ProcessPHPFile($PHPFile) {
 
 ob_start();
 
 if (file_exists($PHPFile)) {
  require $PHPFile;
 } else {
  echo "Forms To Go - Error: Unable to load HTML form: $PHPFile";
  exit;
 }
 
 return ob_get_clean();
}

function CheckString($value, $low, $high, $mode, $limitAlpha, $limitNumbers, $limitEmptySpaces, $limitExtraChars, $optional) {
 if ($limitAlpha == kYes) {
  $regExp = 'A-Za-z';
 }
 
 if ($limitNumbers == kYes) {
  $regExp .= '0-9'; 
 }
 
 if ($limitEmptySpaces == kYes) {
  $regExp .= ' '; 
 }

 if (strlen($limitExtraChars) > 0) {
 
  $search = array('\\', '[', ']', '-', '$', '.', '*', '(', ')', '?', '+', '^', '{', '}', '|', '/');
  $replace = array('\\\\', '\[', '\]', '\-', '\$', '\.', '\*', '\(', '\)', '\?', '\+', '\^', '\{', '\}', '\|', '\/');

  $regExp .= str_replace($search, $replace, $limitExtraChars);

 }

 if ( (strlen($regExp) > 0) && (strlen($value) > 0) ){
  if (preg_match('/[^' . $regExp . ']/', $value)) {
   return false;
  }
 }

 if ( (strlen($value) == 0) && ($optional === kOptional) ) {
  return true;
 } elseif ( (strlen($value) >= $low) && ($mode == kStringRangeFrom) ) {
  return true;
 } elseif ( (strlen($value) <= $high) && ($mode == kStringRangeTo) ) {
  return true;
 } elseif ( (strlen($value) >= $low) && (strlen($value) <= $high) && ($mode == kStringRangeBetween) ) {
  return true;
 } else {
  return false;
 }

}


function CheckNumeric($value, $low, $high, $mode, $optional) {
 if ( (strlen($value) == 0) && ($optional === kOptional) ) {
  return true;
 } elseif (!is_numeric($value)) {
  return false;
 } elseif ( ($value >= $low) && ($mode == kNumberRangeFrom) ) {
  return true;
 } elseif ( ($value <= $high) && ($mode == kNumberRangeTo) ) {
  return true;
 } elseif ( ($value >= $low) && ($value <= $high) && ($mode == kNumberRangeBetween) ) {
  return true;
 } else {
  return false;
 }
}


function CheckTelephone($telephone, $valFormat, $optional) {
 if ( (strlen($telephone) == 0) && ($optional === kOptional) ) {
  return true;
 } elseif ( ereg($valFormat, $telephone) ) {
  return true;
 } else {
  return false;
 }
}



if (isset($_SERVER['HTTP_X_FORWARDED_FOR'])) {
 $clientIP = $_SERVER['HTTP_X_FORWARDED_FOR'];
} else {
 $clientIP = $_SERVER['REMOTE_ADDR'];
}

$FTGname = DoStripSlashes( $_POST['name'] );
$FTGstreet = DoStripSlashes( $_POST['street'] );
$FTGCity = DoStripSlashes( $_POST['City'] );
$FTGZip = DoStripSlashes( $_POST['Zip'] );
$FTGtel = DoStripSlashes( $_POST['tel'] );
$FTGcomments = DoStripSlashes( $_POST['comments'] );



$validationFailed = false;

# Fields Validations


if (!CheckString($FTGname, 2, 35, kStringRangeBetween, kYes, kNo, kYes, '', kMandatory)) {
 $FTGErrorMessage['name'] = 'Enter a Name';
 $validationFailed = true;
}

if (!CheckString($FTGstreet, 2, 50, kStringRangeBetween, kYes, kYes, kYes, '', kMandatory)) {
 $FTGErrorMessage['street'] = 'Enter Address';
 $validationFailed = true;
}

if (!CheckString($FTGCity, 2, 20, kStringRangeBetween, kYes, kNo, kYes, '.', kMandatory)) {
 $FTGErrorMessage['City'] = 'Enter a City';
 $validationFailed = true;
}

if (!CheckNumeric($FTGZip, 500, 99499, kNumberRangeBetween, kMandatory)) {
 $FTGErrorMessage['Zip'] = 'Enter Zipcode';
 $validationFailed = true;
}

if (!CheckTelephone($FTGtel, '[0-9]{3}\-[0-9]{3}\-[0-9]{4}', kMandatory)) {
 $FTGErrorMessage['tel'] = 'Enter Phone';
 $validationFailed = true;
}



# Embed error page and dump it to the browser

if ($validationFailed === true) {

 $fileErrorPage = 'contact_content.php';

 if (file_exists($fileErrorPage) === false) {
  echo '<html><head><title>Error</title></head><body>The error page: <b>' . $fileErrorPage. '</b> cannot be found on the server.</body></html>';
  exit;
 }

 $errorPage = ProcessPHPFile($fileErrorPage);

 $errorList = @implode("<br />\n", $FTGErrorMessage);
 $errorPage = str_replace('<!--VALIDATIONERROR-->', $errorList, $errorPage);

 $errorPage = str_replace('<!--FIELDVALUE:name-->', $FTGname, $errorPage);
 $errorPage = str_replace('<!--FIELDVALUE:street-->', $FTGstreet, $errorPage);
 $errorPage = str_replace('<!--FIELDVALUE:City-->', $FTGCity, $errorPage);
 $errorPage = str_replace('<!--FIELDVALUE:Zip-->', $FTGZip, $errorPage);
 $errorPage = str_replace('<!--FIELDVALUE:tel-->', $FTGtel, $errorPage);
 $errorPage = str_replace('<!--FIELDVALUE:comments-->', $FTGcomments, $errorPage);
 $errorPage = str_replace('<!--ERRORMSG:name-->', $FTGErrorMessage['name'], $errorPage);
 $errorPage = str_replace('<!--ERRORMSG:street-->', $FTGErrorMessage['street'], $errorPage);
 $errorPage = str_replace('<!--ERRORMSG:City-->', $FTGErrorMessage['City'], $errorPage);
 $errorPage = str_replace('<!--ERRORMSG:Zip-->', $FTGErrorMessage['Zip'], $errorPage);
 $errorPage = str_replace('<!--ERRORMSG:tel-->', $FTGErrorMessage['tel'], $errorPage);


 echo $errorPage;

}

if ( $validationFailed === false ) {

 # Email to Form Owner
  
 $emailSubject = FilterCChars("Online Request Form");
  
 $emailBody = "name : $FTGname\n"
  . "street : $FTGstreet\n"
  . "City : $FTGCity\n"
  . "Zip : $FTGZip\n"
  . "tel : $FTGtel\n"
  . "comments : $FTGcomments\n"
  . "";
  $emailTo = 'bpeterson@ssrfg.com, hmadi@ssrfg.com';
   
  $emailFrom = FilterCChars("service@ssrhvac.com");
   
  $emailHeader = "From: $emailFrom\n"
   . "MIME-Version: 1.0\n"
   . "Content-type: text/plain; charset=\"ISO-8859-1\"\n"
   . "Content-transfer-encoding: 7bit\n";
   
  mail($emailTo, $emailSubject, $emailBody, $emailHeader);
  
  
  # Redirect user to success page

header("Location: http://www.ssrhvac.com/rental_thanks.html");

}

?>