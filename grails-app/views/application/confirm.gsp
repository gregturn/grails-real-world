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
						<li><g:link controller="application" action="index">Login</g:link></li>
					</ul>
				</div>
			</div>
		</div>

		<div class="container" role="main">
			<div>				
				<form class="form-horizontal" action="${createLink(action:'confirmWithPassword', params:[token:hashcode])}" method="POST" autocomplete="off">
					<fieldset>
						<legend>Enter your registered password to confirm registration</legend>
						<g:if test='${flash.message}'>
							<div class="control-group">
									<div class="alert alert-error">
										${flash.message}
									</div>
							</div>
						</g:if>
						<div class="control-group" id="password_field">
							<label class="control-label" for="password" id="password_field">Password</label>
							<div class="controls">
								<input type="password" id="password" name="j_password" value="" class="span5" required>
								<span class="help-inline">Required</span>
							</div>
						</div>
						<div class="control-group">
							<div class="controls">
								<input type="submit" class="btn btn-primary" value="Confirm">
								<g:link class="btn" controller="application" action="index">Cancel</g:link>
							</div>
						</div>
					</fieldset>
				</form>
			</div>

			<script type='text/javascript'>
				$("#password").focus();
			</script>
						
		    <g:render template="/footer"></g:render>
		</div>

	</body>
</html>
