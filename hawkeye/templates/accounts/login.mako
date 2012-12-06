<%inherit file="/base/base.mako"/>

<div id="login-box">
    <div id="login-messages">
		% if message: 
			${message} 
		% endif
	</div>
	<form id="login-form" action="/login" method="get">
		<div id="login-box-name">Email</div>
		<div id="login-box-field">${form.email(class_='form-login')}
			${form.get_error('email')}</div>
		<div id="login-box-name">Password</div>
		<div id="login-box-field">${form.password(class_='form-login')}
			${form.get_error('password')}</div>
		<div id="login-box-button">
			<input type="submit" class="login-button" value="login"> 
			<input type="button" class="login-button" value="register"> 
			<input type="button" class="login-button" value="exit">
		</div>
	</form>
</div>

