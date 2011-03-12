<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
<head>
<?php require_once("stylesheets.php"); ?>
</head>
<div id="content">
  <div id="logo">
    <h2>SilverState Refrigeration</h2>
    </div>
	<div id="contact_heading">
		<h2>Online Service Request Form</h2>
	</div>

<?php
if(isset($sent) && $sent == true)
{
echo "";
}else{
?>
  
  <?php if(isset($warning)){echo "$message";} ?>
  <form method="post" action="online_rq.php" name="contact">
    
    <label>* Name:</label><br />
			<div class="form_field">
    		<input name="name" type="text" value="<?php echo $name; ?>" size="35"/><br />
			</div>
			<div class="error">
				<!--ERRORMSG:name-->
			</div>
		<label>* Street Address:</label><br />
			<div class="form_field">
    		<input name="street" type="text" value="<?php echo $street; ?>" size="35"/><br />
			</div>
			<div class="error">
				<!--ERRORMSG:name-->
			</div>
      <label>City:</label><br /> 
      <div class="form_field">
    		<input name="City" type="text" value="<?php echo $city; ?>" size="35"/><br />
			</div>
			<div class="error">
				<!--ERRORMSG:name-->
			</div>
		<label>* Zip:</label><br />
			<div class="form_field">
    		<input name="Zip" type="text" value="<?php echo $zip; ?>" size="35"/><br />
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

			<div class="error"></div>
    <label> Additional Comments:</label><br />
			<div class="form_field_text">
    	<textarea name="comments" cols="37" rows="6"><?php echo $comments; ?></textarea>
			</div>
<div class="clear"></div>
			<div class="form_field_button">
      <input name="submit" type="submit" value="Submit" class="btn" />
			</div>
  </form>
	<?php } ?>
	<div id="sidebar">
	  </div>
</div>