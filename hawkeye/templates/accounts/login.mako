<%inherit file="/base/base.mako"/>

% if message:
	${message}
% endif

<form action="/login" method="get">
Username: <input type="text" name="username">
<input type="submit" value="Submit">
</form>
