MapApp.controller('SignInController', function SignInController($scope, $http, $cookies, $location) {
	
	$http.defaults.headers.post["Content-Type"] = "application/x-www-form-urlencoded";
	// $scope.email = 'aojv@mail.ru';
	// $scope.password = '123';
	$scope.submit = function (email, password) {
		$http.post(
			'includes/dataGetter.php', {
				user: true,
				email: email,
				password: password
			}
		)
		.then(x => {
			if (x.data) {
				localStorage.setItem('user', JSON.stringify(x.data));
				$location.path('/map');
			}
			else
				console.log('error');
		});
	}
})