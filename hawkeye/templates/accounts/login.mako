<%inherit file="/base/base.mako"/>
<%block name='script'>
<script type="text/javascript">
	$(function(){
		$("#radio").buttonset();
	});
</script>
</%block>

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
		<div id="radio" class="centered">
			<button type="submit" value="Login">Login</button>
		    <a href="/register" >Register</a>
		    <a href="/exit" >Exit</a>
		</div>
	</form>
</div>
