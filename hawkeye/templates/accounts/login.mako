<%inherit file="/base/base.mako"/>

<div id="login">
	<div class="logo"></div>
	% if message: 
		<div class="validate">${message}</div> 
	% elif form.get_error('email'):
		<div class="validate">${form.get_error('email')}</div>
	% elif form.get_error('password'):
		<div class="validate">${form.get_error('password')}</div> 
	% endif
	<form action="/login" autocomplete="on">
		${form.email(placeholder="Username")}
		${form.password(placeholder="Password")}
		<ul class="button-group">
			<li><input type="submit" class="button" value="Login" /></li>
			<li><a href="/register" class="button">Register</a></li>
			<li><a href="/exit" class="button">Exit</a></li>
		</ul>
	</form>
</div>
