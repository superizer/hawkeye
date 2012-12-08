<%inherit file="/base/base.mako"/>

<div id="register-box">
	<div id="register-form-inform">Register Form</div>
	<form id="register-form" action="/register" method="get">
		<div id="register-form-name">Name</div>
		<div id="register-form-field">${form.name(class_='form-register')}</div>
		<div id="register-form-name">Surname</div>
		<div id="register-form-field">${form.surname(class_='form-register')}</div>
		<div id="register-form-name">${form.email.label}</div>
		<div id="register-form-field">${form.email(class_='form-register')}</div>
		<div id="register-form-name">${form.password.label}</div>
		<div id="register-form-field">${form.password(class_='form-register')}</div>
		<div id="register-form-name">Confirm Password</div>
		<div id="register-form-field">${form.confirm(class_='form-register')}</div>
		<div id="register-message">
	        % if form.get_error('name'): 
				${form.get_error('name')}
			% elif form.get_error('surname'):
				${form.get_error('surname')}
			% elif form.get_error('email'): 
			    ${form.get_error('email')}
			% elif form.get_error('password'): 
			    ${form.get_error('password')}
			% endif
        </div>
		<div id="register-form-button">
			<input type="submit" class="register-button" value="Register">
			<input type="reset" class="register-button" value="Reset"> 
			<a href="/login"><input type="button" class="register-button" value="Cancel"></a>
		</div>
	</form>
</div>
