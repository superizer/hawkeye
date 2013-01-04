<%inherit file="/base/base.mako"/>

<script>
	$(function() {
		$("#login").button();
		$("#register").button();
		$("#exit").button();
	});
</script>
<div></div>
<div class="ui-overlay">
	<div class="ui-widget-overlay"></div>
	<div class="ui-widget-shadow ui-corner-all"
		style="width: 332px; height: 152px; position: absolute; left: 50%; top: 50%; margin-left: -166px; margin-top: -76px;"></div>
</div>
<div
	style="position: absolute; width: 310px; height: 130px; left: 50%; top: 50%; margin-left: -155px; margin-top: -65px; padding: 7px;"
	class="ui-widget ui-widget-content ui-corner-all">
	<div class="ui-dialog-content ui-widget-content"
		style="background: none; border: 0;">
		<form action="/login" method="get">
		<div class="form-name">:: Login Form ::</div>
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
			<div class="form-message">
				% if message: 
					${message}
				% elif form.get_error('email'):
					${form.get_error('email')}
				% elif form.get_error('password'): 
			    	${form.get_error('password')}
				% endif
			</div>
			<div class="form-button">
				<button id="login" style="width:80px;" type="submit">Login</button>
				<a href='/register'><button id="register" style="width:80px;">Register</button></a>
				<a href='/exit'><button id="exit" style="width:80px;">Exit</button></a>
			</div>
		</form>
	</div>
</div>

