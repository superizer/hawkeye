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
		style="width: 332px; height: 162px; position: absolute; left: 50%; top: 50%; margin-left: -166px; margin-top: -81px;"></div>
</div>
<div
	style="position: absolute; width: 310px; height: 140px; left: 50%; top: 50%; margin-left: -155px; margin-top: -70px; padding: 7px;"
	class="ui-widget ui-widget-content ui-corner-all">
	<div class="ui-dialog-content ui-widget-content"
		style="background: none; border: 0;">
		<form action="/home" method="get">
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
				<a href='/home'><button id="exit" style="width:80px;">Back</button></a>
			</div>
		</form>
	</div>
</div>