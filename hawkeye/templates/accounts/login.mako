<%inherit file="/base/base.mako"/>

% if message:
	${message}
% endif

<div id="login-box">
	<form id="login-form" action="/login" method="get">
		<div id="login-box-name">Email</div>
		<div id="login-box-field">
			<input type="email" class="form-login" name="usr-email">
		</div>
		<div id="login-box-name">Password</div>
		<div id="login-box-field">
			<input type="password" class="form-login" name="usr-password">
		</div>
		<div id="login-box-button">
			<input type="submit"  class="login-button" value="login"> 
			<input type="button"  class="login-button" value="register"> 
			<input type="button"  class="login-button" value="exit">
		</div>
	</form>
</div>