<!DOCTYPE html>
<html>
	<head>
		<meta charset="utf-8">
	    <title>Case Study - Grails in the Real World&trade;</title>
	    
	    <meta name="viewport" content="width=device-width, initial-scale=1.0">
	    <meta name="description" content="">
	    <meta name="author" content="">
	    
	    <g:render template="/styling"></g:render>
		
	</head>
	<body>
		<div class="navbar navbar-inverse">
			<div class="navbar-inner">
				<div class="container">
					<g:link class="brand" controller="application">Case Study - Grails in the Real World&trade;</g:link>
					<ul class="nav">
						<sec:access expression="hasRole('ROLE_ADMIN')">
						<li><g:link controller="admin" action="logs">View Logs</g:link></li>
						<li><g:link controller="admin" action="users">Manage Users</g:link></li>
						<li><a href="#emptyCache" data-toggle="modal" data-target="#emptyCache">Empty Cache</a></li>
						<li><a href="#emptyLogs" data-toggle="modal" data-target="#emptyLogs">Empty Logs</a></li>
						</sec:access>
						<li class="dropdown">
							<a href="#" class="dropdown-toggle" data-toggle="dropdown">Edit My Account <b class="caret"></b></a>
							<ul class="dropdown-menu">
								<li><g:link controller="application" action="editEmail">Change My Email Address</g:link></li>
								<li><g:link controller="application" action="editPassword">Change My Password</g:link></li>
							</ul>
						</li>
					</ul>
					<g:link class="pull-right btn btn-primary" controller="logout">Logout</g:link>
				</div>
			</div>
		</div>
		
		<sec:access expression="hasRole('ROLE_ADMIN')">
		<div id="emptyCache" class="modal hide fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
				<h3>Confirmation</h3>
			</div>
			<div class="modal-body">
				<p class="lead">Are you sure you want to empty the cache?</p>
			</div>
			<div class="modal-footer">
				<button class="btn" data-dismiss="modal" aria-hidden="true">Close</button>
				<g:link class="btn btn-danger" controller="admin" action="emptyCache"><i class="icon-trash icon-white"></i> Empty Cache</g:link>
			</div>
		</div>
		<div id="emptyLogs" class="modal hide fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
				<h3>Confirmation</h3>
			</div>
			<div class="modal-body">
				<p class="lead">Are you sure you want to empty the logs?</p>
			</div>
			<div class="modal-footer">
				<button class="btn" data-dismiss="modal" aria-hidden="true">Close</button>
				<g:link class="btn btn-danger" controller="admin" action="emptyLogs"><i class="icon-trash icon-white"></i> Empty Logs</g:link>
			</div>
		</div>
		</sec:access>
		
		<div class="container" role="main">
			<div>
				<div class="pull-right">
					<p>Welcome <sec:username/></p>
				</div>
				<br/>
				<br/>
				
				<g:if test='${flash.message}'>
					<div class="alert alert-error">
						${flash.message}
					</div>
				</g:if>
				<p>
				<p>Add the following to any project where you need the maven artifacts.<p>
				<pre>&lt;repository&gt;
	&lt;id&gt;grails-real-world-release&lt;/id&gt;
	&lt;name&gt;Grails in the Real World&lt;/name&gt;
	&lt;url&gt;${mavenLink2}&lt;/url&gt;
&lt;/repository&gt;</pre>
				<p>To access these artifacts, you must add an entry to .m2/settings.xml</p>
				<pre>&lt;settings&gt;
  &lt;servers&gt;
  	...
    &lt;server&gt;
      &lt;id&gt;grails-real-world-release&lt;/id&gt;
      &lt;username&gt;${user.username}&lt;/username&gt;
      &lt;password&gt;&lt;!-- Insert your decrypted password (which we don't have) --&gt;&lt;/password&gt;
    &lt;/server&gt;
    ...
  &lt;/servers&gt;
&lt;/settings&gt;</pre>
			</div>
			
		    <g:render template="/footer"></g:render>
		</div>
	</body>
</html>
