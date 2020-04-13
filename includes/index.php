<form class="sign-in-form" action="dataGetter.php" method="POST">
	<div class="form-group">
		<label for="exampleInputEmail1">Email address</label>
		<input type="email" class="form-control" name="email"  placeholder="Email" ng-model="email">
	</div>
	<div class="form-group">
		<label for="password">Password</label>
		<input type="password" class="form-control" name="password" placeholder="Password"ng-model="password">
	</div>
	<input type="hidden" name="user" value="true">
	<button id="sign-in" type="submit" class="btn btn-primary" ng-click="submit(email, password)">Sign in</button>
</form>