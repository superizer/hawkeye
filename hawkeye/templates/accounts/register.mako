<%inherit file="/base/base.mako"/>

<div id="register-box">
<form action="/register" method="get">
Name: <input type="text" name="name"><br/>
Surname: <input type="text" name="surname"><br/>
Email: <input type="text" name="email"><br/>
Password: <input type="password" name="password"><br/>
Confirm Password: <input type="password" name="password"><br/>
<a href='/login' ><input type="submit" value="Register"></a>
</form>
</div>