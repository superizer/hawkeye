<%inherit file="/base/base.mako"/>
<!-->Hello <strong>${username}</strong> login<br/> -->
<form name="input" action="/login" method="get">
Username: <input type="text" name="user">
<input type="submit" value="Submit">
</form>
<a href="/">go to home</a>