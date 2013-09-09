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
				</div>
			</div>
		</div>
		
		<div class="container" role="main">

			<div>
				A password reset email has been sent to <strong>${username}</strong> 
				with a link. When you receive that link, click on it to reset your password.
			</div>		
			
		    <g:render template="/footer"></g:render>
		</div>
	</body>
</html>
