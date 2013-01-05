<%inherit file="/base/base.mako"/>

<script>
	$(function() {
		$("#register").button();
		$("#reset").button();
		$("#cancel").button();
	});
</script>
<div></div>
<div class="ui-overlay">
	<div class="ui-widget-overlay"></div>
	<div class="ui-widget-shadow ui-corner-all register-set-shadow-style"></div>
</div>
<div class="ui-widget ui-widget-content ui-corner-all register-set-content-style">
	<div class="ui-dialog-content ui-widget-content register-set-content-inner-style">
		<form action="/register" method="post">
		    <div class="form-name">:: Register Form ::</div>
			<dl>
				<dt>
					<label for="name">Name :</label>
				</dt>
				<dd>
					${form.name(class_='text ui-widget-content ui-corner-all')}
				</dd>
			</dl>
			<dl>
				<dt>
					<label for="surname">Surname :</label>
				</dt>
				<dd>
				${form.surname(class_='text ui-widget-content ui-corner-all')}
				</dd>
			</dl>
			<dl>
				<dt>
					<label for="email">Email :</label>
				</dt>
				<dd>
				${form.email(class_='text ui-widget-content ui-corner-all')}
				</dd>
			</dl>
			<dl>
				<dt>
					<label for="password">Password :</label>
				</dt>
				<dd>
				${form.password(class_='text ui-widget-content ui-corner-all')}
				</dd>
			</dl>
			<dl>
				<dt>
					<label for="confirm-password">Confirm Password :</label>
				</dt>
				<dd>
				${form.confirm(class_='text ui-widget-content ui-corner-all')}
				</dd>
			</dl>
			<div class="form-message">
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
			<div class="form-button">
			    <button id="register" class="register-button" type="submit">Register</button>
				<button id="reset" type="Reset" class="register-button">Reset</button>
				<a href='/login'><button id="cancel" class="register-button">Cancel</button></a>
			</div>
		</form>
	</div>
</div>
