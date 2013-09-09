package repository

class WhitelistService {
	
	def grailsApplication

    def valid(String restOfUrl) {
		grailsApplication.config.mavenDownloadWhitelist.any { pattern -> restOfUrl.startsWith(pattern) }
    }
}
