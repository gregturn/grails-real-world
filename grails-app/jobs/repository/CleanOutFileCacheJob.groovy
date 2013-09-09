package repository


class CleanOutFileCacheJob {
	def fileCacheService
	
    static triggers = {
	  cron name:'cleanOutOldFileCacheTrigger', startDelay:5000, cronExpression: '0 * * * * ?'
    }

    def execute() {
		fileCacheService.cleanoutOldFiles()
    }
}
