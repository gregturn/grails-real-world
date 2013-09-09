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
				<g:form class="form-horizontal" url="[controller:'application', action:'sendResetEmail']">
					<fieldset>
						<legend>Password Reset</legend>
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
							</div>
						</div>
						<div class="control-group">
							<div class="controls">
								<input type="submit" class="btn btn-primary" value="Reset">
								<g:link class="btn" controller="application" action="index">Cancel</g:link>
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
