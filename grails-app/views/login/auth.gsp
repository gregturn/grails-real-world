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
						<li><g:link controller="application" action="register">Register</g:link></li>
						<li class="active"><g:link controller="application" action="index">Login</g:link></li>
					</ul>
				</div>
			</div>
		</div>

		<div class="container" role="main">
			<div>				
				<form class="form-horizontal" action="${postUrl}" method="POST" autocomplete="off">
					<fieldset>
						<legend>Login</legend>
						<g:if test='${flash.message}'>
							<div class="control-group">
									<div class="alert alert-error">
										${flash.message}
									</div>
							</div>
						</g:if>
						<div class="control-group" id="email_field">
							<label class="control-label" for="email">Email</label>
							<div class="controls">
								<input type="email" id="username" name="j_username" value="" class="span5" required>
							</div>
						</div>
						<div class="control-group" id="password_field">
							<label class="control-label" for="password" id="password_field">Password</label>
							<div class="controls">
								<input type="password" id="password" name="j_password" value="" class="span5" required>
							</div>
						</div>
						<div class="control-group">
							<div class="controls">
								<g:link controller="application" action="forgotPassword"><small>Did you forget your password?</small></g:link>
							</div>
						</div>
						<div class="control-group" id="remember_me_field">
							<div class="controls">
								<input type="checkbox" id="remember_me" name="${rememberMeParameter}" <g:if test='${hasCookie}'>checked='checked'</g:if>>Remember Me</input>
							</div>
						</div>
						<div class="control-group">
							<div class="controls">
								<input type="submit" class="btn btn-primary" value="${message(code: "springSecurity.login.button")}">
								<g:link class="btn" controller="application" action="index">Cancel</g:link>
							</div>
						</div>
						<div class="control-group">
							<div class="controls">
								Don't have an account? <g:link controller="application" action="register">Register</g:link>
							</div>
						</div>
					</fieldset>
				</form>
			</div>

			<script type='text/javascript'>
				$(document).ready(function() {
					$("#username").focus();
				});
			</script>
			
		    <g:render template="/footer"></g:render>
		</div>

	</body>
</html>
