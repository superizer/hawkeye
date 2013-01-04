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
	<div class="ui-widget-shadow ui-corner-all login-set-shadow-style"></div>
</div>
<div class="ui-widget ui-widget-content ui-corner-all login-set-content-style">
	<div class="ui-dialog-content ui-widget-content login-set-content-inner-style">
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
				<button id="login" style="width:80px;" class="login-button">Login</button>
				<a href='/register'><button id="register" class="login-button">Register</button></a>
				<a href='/exit'><button id="exit" class="login-button">Exit</button></a>
			</div>
		</form>
	</div>
</div>

