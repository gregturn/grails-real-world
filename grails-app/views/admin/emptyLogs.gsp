<!DOCTYPE html>
<html>
	<head>
		<meta charset="utf-8">
	    <title>Case Study - Grails in the Real World</title>
	    
	    <meta name="viewport" content="width=device-width, initial-scale=1.0">
	    <meta name="description" content="">
	    <meta name="author" content="">
	    
	    <g:render template="/styling"></g:render>
		
	</head>
	<body>
		<div class="navbar navbar-inverse">
			<div class="navbar-inner">
				<div class="container">
					<g:link class="brand" controller="application">Case Study - Grails in the Real World</g:link>
					<ul class="nav">
						<sec:access expression="hasRole('ROLE_ADMIN')">
						<li><g:link controller="admin" action="logs">View Logs</g:link></li>
						<li><g:link controller="admin" action="users">Manage Users</g:link></li>
						<li><a href="#emptyCache" data-toggle="modal" data-target="#emptyCache">Empty Cache</a></li>
						<li class="active"><a href="#emptyLogs" data-toggle="modal" data-target="#emptyLogs">Empty Logs</a></li>
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
				<g:if test='${flash.message}'>
					<div class="alert alert-error">
						${flash.message}
					</div>
				</g:if>
				<p>The logentry table has been emptied.</p>
			</div>
			
		    <g:render template="/footer"></g:render>
		</div>
	</body>
</html>
