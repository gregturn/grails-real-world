<!DOCTYPE html>
<html>
	<head>
		<meta charset="utf-8">
	    <title><g:message code="springSecurity.denied.title" /></title>
	    
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
					<g:link class="pull-right btn btn-primary" controller="logout">Logout</g:link>
				</div>
			</div>
		</div>

		<div class="container" role="main">
			<div class="alert alert-error">				
				<g:message code="springSecurity.denied.message"></g:message>
			</div>

		    <g:render template="/footer"></g:render>
		</div>

	</body>
</html>
µ