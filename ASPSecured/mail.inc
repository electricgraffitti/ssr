<%

'make sure we set the following which are commented out but left now for refrence 
'mailserver = 
'recipient = 
'fromaddress = 
'subject = 
'message = 
'mailtype = 


dim mailing
			

function mailusers(mailtype,mailserver,recipient,fromaddress,subject,message)
			if mailtype  = "Bamboo" then 
			dim smtp
			set smtp = Server.CreateObject("Bamboo.SMTP")
			smtp.Server = mailserver
			smtp.Rcpt = recipient
			smtp.From = fromaddress
			smtp.FromName = fromaddress
			smtp.Subject = subject
			smtp.Message = message
			'on error resume next
			smtp.Send
			set smtp = Nothing
			

			elseif mailtype = "JMail" then
			
			Set mailing = Server.CreateObject("JMail.SMTPMail")
			mailing.silent = true
			mailing.ServerAddress = mailserver
			mailing.Sender = fromaddress
			mailing.SenderName = fromaddress
			mailing.AddRecipientEx recipient	
			mailing.Subject = subject
			mailing.Body = message
			mailing.Execute
			set mailing = nothing
			

			elseif mailtype = "ASPMail" then
			
			Set mailing = Server.CreateObject("SMTPsvg.Mailer")
			mailing.QMessage = TRUE
			mailing.RemoteHost = mailserver
			mailing.AddRecipient recipient
			mailing.FromAddress = fromaddress
			mailing.FromName = fromaddress
			mailing.Subject = subject
			mailing.BodyText = message
			mailing.SendMail
			set mailing = nothing
			

			elseif mailtype = "CDONTS" then
			
			Set mailing= Server.CreateObject("CDONTS.NewMail")
			mailing.MailFormat = 1	
			mailing.To = recipient
			mailing.From =  fromaddress
			mailing.Subject = subject
			mailing.Body = message
			mailing.Send			
			Set mailing= Nothing
			
			end if
			
end function

%>