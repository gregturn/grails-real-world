package repository

import grails.plugins.springsecurity.Secured

class ApplicationController {
	
	def springSecurityService
	def mailService
	def grailsApplication
	def whitelistService
	def fileCacheService
	
	@Secured(["hasAnyRole('ROLE_USER', 'ROLE_ADMIN')"])
    def index() { 
		def link = g.render(template:"mavenTemplate2")
		[mavenLink2: link,
		 user: springSecurityService.currentUser]
	}
	
	def register() {
		
	}
	
	def registerNewUser() {
		if (params.password != params.password2) {
			flash.message = "Passwords don't match. Re-enter or cancel."
			redirect action:"register"
		} else {
			if (User.findByUsername(params.email) != null) {
				new LogEntry(user: params.email, category: "ERROR", description: "${params.email} is already registered.").save()
				flash.message = "<strong>${params.email}</strong> is already registered."
				redirect action:"register"
			} else {
				session.user = new User(username: params.email, password: params.password, enabled: false).save(flush:true)
				redirect action:"acceptEULA"
			}
		}
	}
	
	def acceptEULA() {
		[eula:grailsApplication.config.eula]
	}
	
	def completeRegistration() {
		new LogEntry(user: session.user.username, category: "CONFIRMATION", description: "${session.user.username} has accepted the EULA").save()
		mailService.sendConfirmationEmail(session.user.username, g)
	}
		
	@Secured(["hasAnyRole('ROLE_USER', 'ROLE_ADMIN')"])
	def editEmail() {
		[user: springSecurityService.currentUser]
	}
	
	@Secured(["hasAnyRole('ROLE_USER', 'ROLE_ADMIN')"])
	def updateEmail() {
		if (params.email == params.email2) {
			def user = User.get(params.id)
			def oldEmail = user.username
			user.username = params.email
			user.save()
			springSecurityService.reauthenticate(user.username, user.password)
			mailService.sendEmail("Email update", oldEmail, "Your email address was recently changed to ${user.username}. A copy of this message has also been sent to the new address.")
			mailService.sendEmail("Email update", user.username, "Your email was recently changed. A copy of this message has also been sent to the previous address.")
			new LogEntry(user: springSecurityService.currentUser.username, category: "ADMIN", description: "${oldEmail} has been changed to ${params.email}.").save()
			flash.message = "<strong>${oldEmail}</strong> has been changed to <strong>${params.email}</strong>."
			redirect action:"index"
		} else {
			flash.message = "Emails don't match. Re-enter or cancel."
			redirect action:"editEmail"
		}
	}
	
	@Secured(["hasAnyRole('ROLE_USER', 'ROLE_ADMIN')"])
	def editPassword() {
		[user: springSecurityService.currentUser]
	}
	
	@Secured(["hasAnyRole('ROLE_USER', 'ROLE_ADMIN')"])
	def updatePassword() {
		if (params.newPassword != params.newPassword2) {
			flash.message = "Passwords don't match. Re-enter or cancel."
			redirect action:"editPassword"
		} else {
			def user = User.get(params.id)
			if (springSecurityService.encodePassword(params.currentPassword) != user.password) {
				flash.message = "Current password is invalid."
				redirect action:"editPassword"
			} else {
				user.password = params.newPassword
				user.save()
				mailService.sendEmail("Password update", user.username, "Your password has been changed.")
				new LogEntry(user: springSecurityService.currentUser.username, category: "ADMIN", description: "${user.username}'s password has been changed.").save()
				flash.message = "<strong>${user.username}'s</strong> password has been changed."
				redirect action:"index"
			}
		}
	}

		
	def forgotPassword() {
		
	}
	
	def sendResetEmail() {
		if (params["email"] != null) {
			if (User.findByUsername(params.email) != null) {
				mailService.sendPasswordResetEmail(params.email, g)
				[username: params.email]
			} else {
				flash.message = "<string>${params.email}</strong> doesn't exist."
				redirect action:"forgotPassword"
			}
		} else {
			flash.message = "To reset your password, enter the email address you registered."
			redirect controller:"login", action:"auth"
		}
	}
	
	def resetPassword() {
		if (params["token"] != null) {
			def user = User.findByPasswordResetHashCode(params.token)
			if (user == null) {
				flash.message = "Invalid password reset. If you just clicked on a password reset link, it means the link has expired."
				redirect controller:"application", action:"forgotPassword"
			} else {
				[user: user]
			}
		} else {
			response.status = 500
		}
	}
	
	def doResetPassword() {
		def user = User.get(params.id)
		if (params.newPassword == params.newPassword2) {
			user.password = params.newPassword
			user.save(flush:true)
			springSecurityService.reauthenticate(user.username, user.password)
			mailService.sendEmail("Password reset", user.username, "Your password has been reset.")
			flash.message = "<strong>${user.username}'s</strong> was reset."
			redirect action:"index"
		} else {
			flash.message = "Password don't match. Re-enter or cancel."
			redirect action:"resetPassword", params:[token:user.passwordResetHashCode]
		}
	}
	
	def confirm() {
		if (params["token"] != null) {
			def user = User.findByConfirmationHashCode(params.token)
			if (user == null) {
				render "There is no user associated with '${params.token}'"
			} else if (user.enabled) {
				render "${user.username} has already been confirmed."
			} else {
				[hashcode: params.token]
			}
		} else {
			response.status = 500
		}
	}
	
	def confirmWithPassword() {
		if (params["token"] != null) {
			def user = User.findByConfirmationHashCode(params.token)
			if (user == null) {
				render "There is no user associated with '${params.token}'"
			} else if (user.enabled) {
				flash.message = "${user.username} has already been confirmed"
				redirect action:"index"
			} else {
				if (springSecurityService.encodePassword(params.j_password) == user.password) {
					user.enabled = true
					def userRole = Role.findByAuthority("ROLE_USER")
					UserRole.create user, userRole, true
					user.save(flush:true)
					flash.message = "<strong>${user.username}</strong> has been confirmed!"
					new LogEntry(user: user.username, category: "CONFIRMATION", description: "${user.username} has been confirmed.").save()
					springSecurityService.reauthenticate(user.username, params.j_password)
					redirect action:"index"
				} else {
					flash.message = "Invalid password for <strong>${user.username}</strong>"
					redirect action:"confirm", params: [token: params.token]
				}
			}
		} else {
			response.status = 500
		}
	}
	
	def data() {
		flash.message = "<strong>/data</strong> links have been deprecated and replaced with password-controlled <strong>/data2</strong> links as shown below."
		redirect action:"index"
	}
	
	@Secured(["hasAnyRole('ROLE_USER', 'ROLE_ADMIN')"])
	def data2() {
		if (params["restOfUrl"] != null && whitelistService.valid(params.restOfUrl)) {
			def url = "${grailsApplication.config.repo}/${params.restOfUrl}".toURL()
			
			if (!fileCacheService.exists(url)) {
				new LogEntry(user: springSecurityService.currentUser.username, category: "CACHE", description: "Storing ${fileCacheService.filename(url)} into cache").save()
				while (!fileCacheService.storeFile(url)) {
					fileCacheService.deleteOldestFile()
				}
				log.info "Done trying to store ${url}"
			}
			def stream = fileCacheService.getFile(url)
			try {
				response.setContentType("application/octet-stream")
				response.setHeader("Content-disposition", "attachment;filename=${fileCacheService.filename(url)}")
				response.outputStream << stream
			} finally {
				stream.close()
			}
		} else {
			response.status = 500
		}
	}

}
