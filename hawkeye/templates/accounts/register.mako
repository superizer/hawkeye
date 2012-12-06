<%inherit file="/base/base.mako"/>

<form action="/register" method="get">
Name: <input type="text" name="name"><br/>
Surname: <input type="text" name="surname"><br/>
Email: <input type="text" name="email"><br/>
Password: <input type="password" name="password"><br/>
Confirm Password: <input type="password" name="password"><br/>
<input type="submit" value="Register">
<input type="reset" value="Reset">
<a href="/login"><input type="botton" value="Home"></a>
</form>