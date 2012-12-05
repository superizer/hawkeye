<%inherit file="/base/base.mako"/>

% if message:
	${message}
% endif

<form action="/login" method="get">
Email: <input type="text" name="email"><br/>
Password: <input type="password" name="password"><br/>
<input type="submit" value="Submit">&nbsp;<a href="/register">register</a>
</form>
