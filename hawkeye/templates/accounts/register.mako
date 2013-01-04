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
	<div class="ui-widget-shadow ui-corner-all"
		style="width: 332px; height: 232px; position: absolute; left: 50%; top: 50%; margin-left: -166px; margin-top: -116px;"></div>
</div>
<div
	style="position: absolute; width: 310px; height: 210px; left: 50%; top: 50%; margin-left: -155px; margin-top: -105px; padding: 7px;"
	class="ui-widget ui-widget-content ui-corner-all">
	<div class="ui-dialog-content ui-widget-content"
		style="background: none; border: 0;">
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
			    <button id="register" style="width:80px;" type="submit">Register</button>
				<button id="reset" type="Reset" style="width:80px;">Reset</button>
				<a href='/login'><button id="cancel" style="width:80px;">Cancel</button></a>
			</div>
		</form>
	</div>
</div>
