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
	<div class="ui-widget-shadow ui-corner-all profile-set-shadow-style"></div>
</div>
<div class="ui-widget ui-widget-content ui-corner-all profile-set-content-style">
	<div class="ui-dialog-content ui-widget-content profile-set-content-inner-style">
		<form action="/home" method="post">
		<div class="form-name">:: Profile ::</div>
			<dl>
				<dt>
					<label for="name">Name :</label>
				</dt>
				<dd>
					${user.get('first_name')}
				</dd>
			</dl>
			<dl>
				<dt>
					<label for="surname">Surname :</label>
				</dt>
				<dd>
					${user.get('last_name')}
				</dd>
			</dl>
			<dl>
				<dt>
					<label for="surname">Email :</label>
				</dt>
				<dd>
					 ${user.get('email')}
				</dd>
			</dl>
			<div style="float: right;">
				<a href='/home'><button id="exit" class="profile-button">Back</button></a>
			</div>
		</form>
	</div>
</div>