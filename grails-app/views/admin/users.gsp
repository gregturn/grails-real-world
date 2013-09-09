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
						<li class="active"><g:link controller="admin" action="users">Manage Users</g:link></li>
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
                 <g:if test='${flash.message}'>
	                 <div class="alert alert-info">
	                         ${flash.message}
	                 </div>
                 </g:if>
				<sec:access expression="hasRole('ROLE_ADMIN')">
					<table class="table table-striped table-hover table-condensed table-border">
						<tr><th>ID</th><th>Username</th><th>Confirmed?</th><th>Locked?</th><th>Roles</th><th>Operations</th></tr>
						<g:each in="${users}" var="user">
							<tr>
								<td>${user.id}</td>
								<td>${user.username}</td>
								<td>${user.enabled}</td><td>${user.accountLocked}</td>
								<td>${user.authorities.collect{it.authority}}</td>
								<td>
									<g:link class="btn btn-primary btn-mini" action="editUser" params="[id:user.id]"><i class="icon-edit icon-white"></i> Edit</g:link>
									<g:if test="${user.enabled}">
									<g:link class="btn btn-danger btn-mini" action="disableUser" params="[id:user.id]"><i class="icon-lock icon-white"></i> Disable</g:link>
									</g:if>
									<g:if test="${!user.enabled}">
									<g:link class="btn btn-danger btn-mini" action="enableUser" params="[id:user.id]"><i class="icon-ok-sign icon-white"></i> Enable</g:link>
									</g:if>
									<a href="#deleteUser${user.id}" role="button" class="btn btn-danger btn-mini" data-toggle="modal" data-target="#deleteUser${user.id}"><i class="icon-trash icon-white"></i> Delete</a>
									<g:if test="${user.authorities.collect{it.authority}.contains('ROLE_USER')}">
									<g:link class="btn btn-success btn-mini" action="upgradeUser" params="[id:user.id]"><i class="icon-arrow-up icon-white"></i> Upgrade to Admin</g:link>
									</g:if>
									<g:if test="${user.authorities.collect{it.authority}.contains('ROLE_ADMIN')}">
									<g:link class="btn btn-success btn-mini" action="downgradeUser" params="[id:user.id]"><i class="icon-arrow-down icon-white"></i> Downgrade to User</g:link>
									</g:if>
								</td>
							</tr>
							
							<div id="deleteUser${user.id}" class="modal hide fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
								<div class="modal-header">
									<button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
									<h3>Confirmation</h3>
								</div>
								<div class="modal-body">
									<p class="lead">Are you sure you want to delete <strong>${user.username}</strong>?</p>
								</div>
								<div class="modal-footer">
									<button class="btn" data-dismiss="modal" aria-hidden="true">Close</button>
									<g:link class="btn btn-danger" action="deleteUser" id="${user.id}"><i class="icon-trash icon-white"></i> Delete</g:link>
								</div>
							</div>
							
						</g:each>
					</table>
					<div class="pagination">
						<ul>
							<g:paginate controller="admin" action="users" total="${userCount}" next="Older" prev="Newer" />
						</ul>
					</div>
					<script type="text/javascript">
						$(".currentStep").wrap("<li></li>")
						$(".step").wrap("<li></li>")
						$(".prevLink").wrap("<li></li>")
						$(".nextLink").wrap("<li></li>")
					</script>
				</sec:access>
			</div>
						
		    <g:render template="/footer"></g:render>
		</div>
	</body>
</html>
