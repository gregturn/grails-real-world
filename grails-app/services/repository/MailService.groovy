package repository

import org.codehaus.groovy.grails.commons.GrailsApplication;
import org.springframework.beans.factory.InitializingBean;
import org.springframework.mail.javamail.JavaMailSenderImpl
import org.springframework.mail.javamail.MimeMessageHelper

class MailService {

	transient springSecurityService
	
	Properties props = new Properties()
	JavaMailSenderImpl mailSender = new JavaMailSenderImpl()
		
	public MailService() {
		props.put("mail.smtp.host", "smtp.gmail.com")
		props.put("mail.from", grailsApplication.config.email.address)
		props.put("mail.smtp.auth", "true")
		props.put("mail.smtp.starttls.enable", "true")
		props.put("mail.smtp.port", "587")
		props.setProperty("mail.debug", grailsApplication.config.email.debug)
		
		mailSender.javaMailProperties = props
		mailSender.username = grailsApplication.config.email.address
		mailSender.password = grailsApplication.config.email.password
	}
	
	def sendEmail(String subject, String email, String message) {
		try {
			def msg = mailSender.createMimeMessage()
			MimeMessageHelper helper = new MimeMessageHelper(msg)
			helper.setSubject(subject)
			helper.setTo(email)
			helper.setText("""
				<p>${message}</p>
	
				Regards,<br/>
				Grails in the Real World&trade;
			""", true)
			mailSender.send(msg)
		} catch (Exception e) {
			new LogEntry(user: "SYSTEM", category: "ERROR", description: e).save()
			log.error e
		}
	}

    def sendConfirmationEmail(String email, def g) {
		def user = User.findByUsername(email)
		user.confirmationHashCode = springSecurityService.encodePassword("${email}${new Date()}")
		user.whenConfirmationHashCodeWasIssued = new Date()
		user.save(flush:true)
		def link = g.render(template:"confirmationTemplate", model:[hashcode: user.confirmationHashCode])
		try {
			def msg = mailSender.createMimeMessage()
			MimeMessageHelper helper = new MimeMessageHelper(msg)
			helper.setSubject("Grails in the Real World&trade; activation message")
			helper.setTo(email)
			helper.setText("""
				<p>Welcome to Grails in the Real World&trade;.</p>
	
				<p>${link}</p>

				<p>You have seven days to confirm your account.</p>

				<p>After you confirm your account, then you will be given a URL to embed in 
				projects that will let you access Grails in the Real World&trade;'s repositories.</p>
	
				Regards,<br/>
				Grails in the Real World&trade;
			""", true)
			mailSender.send(msg)
			new LogEntry(user: email, category: "CONFIRMATION", description: "Sent a confirmation email to ${email}").save()
		} catch (Exception e) {
			new LogEntry(user: "SYSTEM", category: "ERROR", description: e).save()
			log.error e
		}
    }
	
	def sendPasswordResetEmail(String email, def g) {
		def user = User.findByUsername(email)
		user.passwordResetHashCode = springSecurityService.encodePassword("${email}passwordreset${new Date()}")
		user.whenPasswordResetHashCodeWasIssued = new Date()
		user.save(flush:true)
		def link = g.render(template:"passwordResetTemplate", model:[hashcode: user.passwordResetHashCode])
		try {
			def msg = mailSender.createMimeMessage()
			MimeMessageHelper helper = new MimeMessageHelper(msg)
			helper.setSubject("Grails in the Real World&trade; password reset message")
			helper.setTo(email)
			helper.setText("""
				<p>Greetings from Grails in the Real World&trade;.</p>
	
				<p>${link}</p>

				<p>The link to initiate a password reset is only good for the next two hours.</p>
	
				Regards,<br/>
				Grails in the Real World&trade;
			""", true)
			mailSender.send(msg)
			new LogEntry(user: email, category: "ADMIN", description: "Sent a password reset email to ${email}").save()
		} catch (Exception e) {
			new LogEntry(user: "SYSTEM", category: "ERROR", description: e).save()
			log.error e
		}

	}
}
