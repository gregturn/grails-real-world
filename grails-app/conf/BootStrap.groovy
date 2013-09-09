import javax.net.ssl.SSLContext

import repository.MailService
import repository.FileCacheService

import repository.User
import repository.Role
import repository.UserRole
import javax.net.ssl.HostnameVerifier
import javax.net.ssl.HttpsURLConnection
import javax.net.ssl.SSLContext
import javax.net.ssl.TrustManager
import javax.net.ssl.X509TrustManager

import grails.converters.JSON

class BootStrap {
	
	def grailsApplication
	
    def init = { servletContext ->
		
		def adminRole = Role.findByAuthority("ROLE_ADMIN") ?: new Role(authority: "ROLE_ADMIN").save(flush:true)
		def userRole = Role.findByAuthority("ROLE_USER") ?: new Role(authority: "ROLE_USER").save(flush:true)

		def sysUser = User.findByUsername("gturnquist+grails@gopivotal.com")
		if (sysUser == null) {
			sysUser = new User(username: 'gturnquist+grails@gopivotal.com', enabled: true, password: 'secret!').save(flush:true)
			UserRole.create sysUser, adminRole, true
		}
		
		def nullTrustManager = [
			checkClientTrusted: { chain, authType ->  },
			checkServerTrusted: { chain, authType ->  },
			getAcceptedIssuers: { null }
		]
		
		def nullHostnameVerifier = [
			verify: { hostname, session -> true }
		]
		
		SSLContext sc = SSLContext.getInstance("SSL")
		sc.init(null, [nullTrustManager as X509TrustManager] as TrustManager[], null)
		HttpsURLConnection.setDefaultSSLSocketFactory(sc.getSocketFactory())
		HttpsURLConnection.setDefaultHostnameVerifier(nullHostnameVerifier as HostnameVerifier)
		
		MailService.metaClass.getGrailsApplication = { -> grailsApplication }
		
		if (inCloudFoundryEnvironment()) {
			try {
				def servicesMap = JSON.parse(System.getenv("VCAP_SERVICES"))
				servicesMap.each { key, services ->
					if (key.startsWith("mongo")) {
						for (service in services) {
							//FileCacheService.mongoURI = service.credentials.uri
							//FileCacheService.mongoDatabaseName = service.credentials.name
						}
					}
				}
			} catch (e) {
				log.error "Error occurred processing VCAP_SERVICES: ${e.message}"
			}
		} else {
			// Default mongo settings for local instance
			FileCacheService.mongoHostname = "localhost"
			FileCacheService.mongoPort = 27017
		}
		
    }
    def destroy = {
    }
	
	private boolean inCloudFoundryEnvironment() {
		System.getenv("VCAP_SERVICES") != null
	}
}
