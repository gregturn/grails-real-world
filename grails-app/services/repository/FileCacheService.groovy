package repository

import com.mongodb.*
import com.mongodb.gridfs.*

import org.joda.time.*

class FileCacheService {
	
	transient springSecurityService
	
	DB db
	GridFS fs
	
	static def mongoURI = null
	static def mongoDatabaseName = ""
	static def mongoHostname = ""
	static def mongoPort = -1
	
	public FileCacheService() {
		if (mongoURI != null) {
			db = new MongoClient(new MongoClientURI(mongoURI)).getDB(mongoDatabaseName)
			fs = new GridFS(db)
		} else {
			db = new MongoClient(mongoHostname, mongoPort).getDB("repository")
			fs = new GridFS(db)
		}
	}

	private String filename(URL url) {
		url.file.split("/")[-1]
	}
	
    boolean exists(URL url) {
		fs.findOne(filename(url)) != null
    }
	
	def storeFile(URL url) {
		try {
			def filename = filename(url)
			def stream = url.openStream()
			fs.createFile(stream, filename, true).save()
			return true
		} catch (MongoException e) {
			log.error "Received MongoException ${e.code} => ${e.message}"
		}
		return false
	}
	
	InputStream getFile(URL url) {
		def filename = filename(url)
		if (exists(url)) {
			new LogEntry(user: springSecurityService.currentUser.username, category: "STATS", description: "Retrieved ${filename} from cache").save()
			return fs.findOne(filename).getInputStream()
		} else {
			throw new RuntimeException("${filename} doesn't appear to exist in GridFS")
		}
	}
	
	def emptyCache(String username) {
		DBCursor cursor = fs.fileList
		while (cursor.hasNext()) {
			DBObject object = cursor.next()
			new LogEntry(user: username, category: "CACHE", description: "Deleting ${object} from cache").save()
			fs.remove(object)
		}
	}
	
	def deleteOldestFile() {
		def files = fs.find(new BasicDBObject())
		if (files.size() > 0) {
			def min = files.min{it.uploadDate}
			def max = files.max{it.uploadDate}
			log.error "Min is ${min}"
			log.error "Max is ${max}"
			log.error "Deleting ${min.filename}"
			fs.remove(min.filename)
		}
	}
	
	def cleanoutOldFiles() {
		fs.find(new BasicDBObject()).each { file ->
			def duration = new Duration(new Instant(file.uploadDate), new Instant())
			if (duration.standardHours >= 48) {
				log.error "${file.filename} is ${duration.standardHours} hours old and is being deleted."
				fs.remove(file.fileName)
			}
		}
	}
}
