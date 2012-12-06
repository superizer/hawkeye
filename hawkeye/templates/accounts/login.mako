<%inherit file="/base/base.mako"/>

<div id="login-box">
    <div id="login-messages">
		% if message: 
			${message} 
		% endif
		${form.get_error('email')}
		${form.get_error('password')}
	</div>
	<form id="login-form" action="/login" method="get">
		<div id="login-box-name">Email</div>
		<div id="login-box-field">${form.email(class_='form-login')}</div>
		<div id="login-box-name">Password</div>
		<div id="login-box-field">${form.password(class_='form-login')}</div>
		<div id="login-box-button">
			<input type="submit" class="login-button" value="login"> 
			<a href='/register'><input type="button"  class="login-button" value="register"></a> 
			<a href='/exit'><input type="button"  class="login-button" value="exit"></a>
		</div>
	</form>
</div>

