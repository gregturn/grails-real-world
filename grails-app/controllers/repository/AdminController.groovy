package repository

import grails.plugins.springsecurity.Secured;

@Secured(["ROLE_ADMIN"])
class AdminController {
	
	def springSecurityService
	def fileCacheService

    def logs() {
		[entries: LogEntry.list(params), entriesCount: LogEntry.count()]
	}
	
	def users() {
		[users: User.list(params), userCount: User.count()]
	}
	
	def editUser() {
		[user: User.get(params.id)]
	}
	
	def updateUser() {
		def user = User.get(params.id)
		user.username = params.email
		user.save()
		def logEntry = new LogEntry(user: springSecurityService.currentUser.username, category: "ADMIN", description: "${user.username} has been updated.").save()
		flash.message = "<strong>${user.username}</strong> has been updated."
		redirect action:"users"
	}
	
	def deleteUser() {
		def user = User.get(params.id)
		UserRole.findByUser(user)?.delete()
		user.delete()
		def logEntry = new LogEntry(user: springSecurityService.currentUser.username, category: "ADMIN", description: "${user.username} has been deleted.").save()
		flash.message = "<strong>${user.username}</strong> has been deleted."
		redirect action:"users"
	}
	
	def upgradeUser() {
		def user = User.get(params.id)
		UserRole.findByUser(user)?.delete()
		def logEntry = new LogEntry(user: springSecurityService.currentUser.username, category: "ADMIN", description: "${user.username} has been upgraded to ADMIN status.").save()
		flash.message = "<strong>${user.username}</strong> has been upgraded to ADMIN status."
		UserRole.create user, Role.findByAuthority("ROLE_ADMIN"), true
		redirect action:"users"
	}
	
	def downgradeUser() {
		def user = User.get(params.id)
		UserRole.findByUser(user)?.delete()
		def logEntry = new LogEntry(user: springSecurityService.currentUser.username, category: "ADMIN", description: "${user.username} has been downgraded to USER status.").save()
		flash.message = "<strong>${user.username}</strong> has been downgraded to USER status."
		UserRole.create user, Role.findByAuthority("ROLE_USER"), true
		redirect action:"users"
	}
	
	def disableUser() {
		def user = User.get(params.id)
		user.enabled = false
		user.save()
		def logEntry = new LogEntry(user: springSecurityService.currentUser.username, category: "ADMIN", description: "${user.username} has been manually disabled.").save()
		flash.message = "<strong>${user.username}</strong> has been manually disabled."
		redirect action:"users"

	}
	
	def enableUser() {
		def user = User.get(params.id)
		user.enabled = true
		user.save()
		def logEntry = new LogEntry(user: springSecurityService.currentUser.username, category: "ADMIN", description: "${user.username} has been manually enabled.").save()
		flash.message = "<strong>${user.username}</strong> has been manually enabled."
		redirect action:"users"
	}
	
	def emptyCache() {
		fileCacheService.emptyCache(springSecurityService.currentUser.username)
	}
	
	def emptyLogs() {
		LogEntry.list().each{it.delete(flush:true)}
	}

}
