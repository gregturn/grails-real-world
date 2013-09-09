package repository

import repository.*
import org.joda.time.*

class RemoveOldActivationLinksJob {
    static triggers = {
	  cron name:'removeOldActivationLinksTrigger', startDelay:5000, cronExpression: '30 7 * * * ?'
    }

    def execute() {
		User.findAllByWhenConfirmationHashCodeWasIssuedIsNotNull().each { user ->
			def duration = new Duration(new Instant(user.whenConfirmationHashCodeWasIssued.time), new Instant())
			if (duration.standardDays >= 7) {
				user.delete()
				new LogEntry(user: user.username, category: "CONFIRMATION", description: "${user.username}'s activation link was issued ${duration.standardDays} days ago but never activated. Deleting.").save()
			}
		}
    }
}