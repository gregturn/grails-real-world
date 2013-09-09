package repository

class LogEntry {
	
	String user
	String category
	String description	
	Date dateCreated
	
	static mapping = {
		sort id: "desc"
	}

    static constraints = {
    }
	
	def beforeInsert() {
		description = prune(description)
	}
	
	protected def prune(msg) {
		if (msg.size() > 255) {
			msg.substring(0,252) + "..."
		} else {
			msg
		}
	}

}
