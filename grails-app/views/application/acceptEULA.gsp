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
				<g:form class="form-horizontal" url="[controller:'application', action:'completeRegistration']">
					<fieldset>
						<legend>${session.user.username}, please read this EULA my lawyers have crafted. You must click the checkbox to proceed.</legend>
						<div class="control-group">
							<div class="controls">
								<textarea rows="10" class="span8">${eula}</textarea>
							</div>
						</div>
						<div class="control-group">
							<div class="controls">
								<span><input type="checkbox" required />I agree to the terms of service</span>
							</div>
						</div>
						<div class="control-group">
							<div class="controls">
								<input type="submit" class="btn btn-primary" value="Submit" disabled>
								<g:link controller="application" class="btn">Cancel</g:link>
							</div>
						</div>
					</fieldset>
				</g:form>
			</div>
			
			<script>
				$(document).ready(function() {
					// Only enable the submit button when the acceptance checkbox is checked.
					$("input[type='checkbox']").click(function(){
						$("input[type='checkbox']").prop("disabled", true);
						$("span").css("opacity", "0.3");
						$("input[type='submit']").prop("disabled", false);
					});
				});
			</script>
			
		    <g:render template="/footer"></g:render>
		</div>
	</body>
</html>
