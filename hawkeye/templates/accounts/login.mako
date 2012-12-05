<%inherit file="/base/base.mako"/>

% if message:
	${message}
% endif

<form action="/login" method="get">
Email: ${form.email} ${form.get_error('email')}<br/>
Password: ${form.password} ${form.get_error('password')}<br/>
<input type="submit" value="Submit">&nbsp;<a href="/register">register</a>
</form>
