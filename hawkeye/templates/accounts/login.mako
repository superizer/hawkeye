<%inherit file="/base/base.mako"/>

% if message:
	${message}
% endif

<form action="/login" method="get">
Username: <input type="text" name="username"><br/>
Password: <input type="password" name="password"><br/>
<input type="submit" value="Submit">
</form>
