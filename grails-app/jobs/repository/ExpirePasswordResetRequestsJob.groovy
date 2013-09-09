package repository

import repository.*
import org.joda.time.*

class ExpirePasswordResetRequestsJob {
    static triggers = {
	  cron name:'expirePasswordResetRequestsTrigger', startDelay:5000, cronExpression: '15 * * * * ?'
    }

    def execute() {
		User.findAllByWhenPasswordResetHashCodeWasIssuedIsNotNull().each { user ->
			def duration = new Duration(new Instant(user.whenPasswordResetHashCodeWasIssued.time), new Instant())
			if (duration.standardHours >= 2) {
				user.passwordResetHashCode = ""
				user.whenPasswordResetHashCodeWasIssued = null;
				user.save()
			}
		}
    }
}
