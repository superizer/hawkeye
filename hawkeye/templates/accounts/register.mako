<%inherit file="/base/base.mako"/>

<%block name='script'>
<script>
	$(function() {
		$("#radio").buttonset();
	});
</script>
</%block>
<div id="register">
	% if form.get_error('name'): 
		<div class="validate">${form.get_error('name')}</div>
	% elif form.get_error('surname'):
		<div class="validate">${form.get_error('surname')}</div>
	% elif form.get_error('email'): 
	    <div class="validate">${form.get_error('email')}</div>
	% elif form.get_error('password'): 
	    <div class="validate">${form.get_error('password')}</div>
	% endif
	<form action="/register" autocomplete="on" method="post">
		${form.name(placeholder="Name")}
		${form.surname(placeholder="Surname")}
		${form.email(placeholder="Email")}
		${form.password(placeholder="Password")}
		${form.confirm(placeholder="Confirm Password")}
		<div id="radio" class="centered">
		    <button  type="submit">Register</button>
			<button  type="Reset" class="register-button">Reset</button>
			<a href='/login'>Cancel</a>
		</div>
	</form>
</div>