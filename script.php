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
// temporary fix for PHP6 compatibility - magic quotes deprecated in PHP6
 if ( function_exists( 'get_magic_quotes_gpc' ) && get_magic_quotes_gpc() ) { 
  if (is_array($fieldValue) ) { 
   return array_map('DoStripSlashes', $fieldValue); 
  } else { 
   return trim(stripslashes($fieldValue)); 
  } 
 } else { 
  return $fieldValue; 
 } 
}

function FilterCChars($theString) {
 return preg_replace('/[\x00-\x1F]/', '', $theString);
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
$FTGselect = DoStripSlashes( $_POST['select'] );
$FTGZip = DoStripSlashes( $_POST['Zip'] );
$FTGtel = DoStripSlashes( $_POST['tel'] );
$FTGcomments = DoStripSlashes( $_POST['comments'] );



$validationFailed = false;

# Fields Validations


if (!CheckString($FTGname, 2, 35, kStringRangeBetween, kYes, kNo, kYes, '', kMandatory)) {
 $FTGErrorMessage['name'] = 'Please Enter a Valid Name';
 $validationFailed = true;
}

if (!CheckString($FTGstreet, 2, 40, kStringRangeBetween, kYes, kYes, kYes, '', kMandatory)) {
 $FTGErrorMessage['street'] = 'Please Enter a Street Number';
 $validationFailed = true;
}

if (!CheckNumeric($FTGZip, 500, 99499, kNumberRangeBetween, kMandatory)) {
 $FTGErrorMessage['Zip'] = 'Please Enter a Valid Zip Code';
 $validationFailed = true;
}

if (!CheckTelephone($FTGtel, '[0-9]{3}\-[0-9]{3}\-[0-9]{4}', kMandatory)) {
 $FTGErrorMessage['tel'] = 'Please Enter Phone Number';
 $validationFailed = true;
}



# Include message in error page and dump it to the browser

if ($validationFailed === true) {

 $errorPage = '<html><head><meta http-equiv="content-type" content="text/html; charset=utf-8" /><title>Error</title></head><body>Errors found: <!--VALIDATIONERROR--></body></html>';


 $errorList = @implode("<br />\n", $FTGErrorMessage);
 $errorPage = str_replace('<!--VALIDATIONERROR-->', $errorList, $errorPage);



 echo $errorPage;

}

if ( $validationFailed === false ) {

 # Email to Form Owner
  
 $emailSubject = FilterCChars("SSR Online Contact");
  
 $emailBody = "name : $FTGname\n"
  . "street : $FTGstreet\n"
  . "select : $FTGselect\n"
  . "Zip : $FTGZip\n"
  . "tel : $FTGtel\n"
  . "comments : $FTGcomments\n"
  . "";
  $emailTo = 'Bob <bob@cube2media.com>';
   
  $emailFrom = FilterCChars("larry@cube2media.com");
   
  $emailHeader = "From: $emailFrom\n"
   . "MIME-Version: 1.0\n"
   . "Content-type: text/plain; charset=\"ISO-8859-1\"\n"
   . "Content-transfer-encoding: 7bit\n";
   
  mail($emailTo, $emailSubject, $emailBody, $emailHeader);
  
  
  # Include message in the success page and dump it to the browser

$successPage = '<html><head><meta http-equiv="content-type" content="text/html; charset=utf-8" /><title>Success</title></head><body>Form submitted successfully. It will be reviewed soon.</body></html>';


echo $successPage;

}

?>