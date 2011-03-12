<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
	<html xmlns="http://www.w3.org/1999/xhtml">
		<head>
			<link href="/images/favicon.ico" rel="icon" type="image/x-icon" />
			<link rel="stylesheet" type="text/css" href="public/stylesheets/application1.css" />
			<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1" />
			<title>SILVERSTATE REFRIGERATION & HVAC</title>
			<meta name="keywords" content= "air conditioning, las vegas air conditioning service, hvac, ac service, henderson ac service, las vegas ac rentals. hvac rentals, generator rentals, temporary ac rentals, party rentals"/>
			<meta name="description" content="Las Vegas Valley's Best Service Provider in the AC Business"/>
		</head>
		<body> 
			
						<div id="content">
							<div class="contest_image">
								<img src="images/contest_header.png" /></a>
							</div>
							<div id="left">
								<img src="images/contest_right.png" /></a>
								<div id="purchase">
									<img src="images/contest_purchase_tag.png" /></a>
								</div>
							</div>
							<div id="right">
							<div id="contact_heading">
								<h2>Contest Entry Form</h2>
							</div>

							<?php
							if(isset($sent) && $sent == true)
							{
								echo "";
							}else{
							?>
  
  							<?php if(isset($warning)){echo "$message";} ?>
  							<form method="post" action="contest_rq.php" name="contact">
    
    							<label>* Name:</label><br />
									<div class="form_field">
    								<input name="name" type="text" value="<?php echo $name; ?>" size="35"/><br />
									</div>
									<div class="error">
										<!--ERRORMSG:name-->
									</div>
    							<label>* Telephone: (555-555-5555)</label><br />
									<div class="form_field">
      							<input name="tel" type="text" value="<?php echo $tel; ?>" size="35"/><br />
									</div>
									<div class="error">
										<!--ERRORMSG:tel-->
									</div>
									<label>* Email:</label><br />
									<div class="form_field">
      							<input name="email_address" type="text" value="<?php echo $tel; ?>" size="35"/><br />
									</div>
									<div class="error">
										<!--ERRORMSG:email_address-->
									</div>
									<div class="clear"></div>
									<div class="form_field_button">
      							<input name="Submit" type="submit" value="Enter" class="btn" />
									</div>
  							</form>
							<?php } ?>
							</div>
							<div id="email">
							  <img src="images/fox5.png" /></a>
							</div>
						</div>
			</body>
	</html>