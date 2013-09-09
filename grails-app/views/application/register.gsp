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
						<li class="active"><g:link controller="application">Register</g:link></li>
						<sec:ifLoggedIn>
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
						</sec:ifLoggedIn>
						<sec:ifNotLoggedIn>
						<li><g:link controller="application" action="index">Login</g:link></li>
						</sec:ifNotLoggedIn>
					</ul>
					<sec:ifLoggedIn>
					<g:link class="pull-right btn btn-primary" controller="logout">Logout</g:link>
					</sec:ifLoggedIn>
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
				<div class="well">
					<p class="lead">Welcome to Case Study - Grails in the Real World&trade;.</p>
					To get started using the components we serve up within your applications, 
					please register for access.
				</div>
				
				<g:form class="form-horizontal" url="[controller:'application', action:'registerNewUser']">
					<fieldset>
						<legend>Register to get download links</legend>
						<g:if test='${flash.message}'>
							<div class="alert alert-error">
								${flash.message}
							</div>
						</g:if>
						<div class="control-group" id="email_field">
							<label class="control-label" for="email">Email</label>
							<div class="controls">
								<input type="email" id="email" name="email" value="" class="span5" required>
								<span class="help-inline">Required</span>
								<span class="help-block">Enter your email</span>
							</div>
						</div>
						<div class="control-group" id="password_field">
							<label class="control-label" for="password" id="password_field">Password</label>
							<div class="controls">
								<input type="password" id="password" name="password" value="" class="span5" required>
								<span class="help-inline">Required</span>
								<span class="help-block">Enter your password</span>
							</div>
						</div>
						<div class="control-group" id="password_field">
							<label class="control-label" for="password2" id="password_field">Re-enter Password</label>
							<div class="controls">
								<input type="password" id="password2" name="password2" value="" class="span5" required>
								<span class="help-inline">Required</span>
								<span class="help-block">Re-Enter your password</span>
							</div>
						</div>
						<div class="control-group">
							<div class="controls">
								<input type="submit" class="btn btn-primary" value="Register">
								<g:link class="btn" controller="application">Cancel</g:link>
							</div>
						</div>
						<div class="control-group">
							<div class="controls">
								<p>Already have an account? <g:link controller="application" action="index">Log in</g:link></p>
							</div>
						</div>
					</fieldset>
				</g:form>
				
			</div>

			<script type='text/javascript'>
				$(document).ready(function() {
					$("#email").focus();
				});
			</script>
			
		    <g:render template="/footer"></g:render>
		</div>
	</body>
</html>
