<%inherit file="/base/base.mako"/>

<p1>Name : ${user.get('first_name')}</p1><br/>
<p1>Surname :  ${user.get('last_name')}</p1><br/>
<p1>Email :  ${user.get('email')}</p1><br/>
<a href='/home'>back</a>