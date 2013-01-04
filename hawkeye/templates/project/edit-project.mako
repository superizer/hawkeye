<%inherit file="/base/base.mako"/>
<script>
	$(function() {
		$("#submit").button();
		$("#reset").button();
		$("#cancel").button();
	});
</script>
<div class="ui-overlay">
	<div class="ui-widget-overlay"></div>
	<div class="ui-widget-shadow ui-corner-all"
		style="width: 322px; height: 172px; position: absolute; left: 50%; top: 50%; margin-left: -161px; margin-top: -86px;"></div>
</div>
<div
	style="position: absolute; width: 300px; height: 150px; left: 50%; top: 50%; margin-left: -150px; margin-top: -75px; padding: 7px;"
	class="ui-widget ui-widget-content ui-corner-all">
	<div class="ui-dialog-content ui-widget-content"
		style="background: none; border: 0;">
		<form action="/project/edit" method="get">
		<input type="hidden" name="id" value="${project['id']}"/>
		<div class="form-name">:: Edit ${project['name']} ::</div>
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
					<label for="description">Description :</label>
				</dt>
				<dd>
					${form.description(class_='text ui-widget-content ui-corner-all')}
				</dd>
			</dl>
			<div class="form-message">
				% if message: 
					${message}
				% elif (form.get_error('name')) :
					${form.get_error('name')}
				% endif
			</div>
			<div class="form-button">
				<button id="submit" style="width:80px;" type="submit">Save</button>
				<button id="reset" style="width:80px;" type="reset">Reset</button>
				<a href='/home'><button id="cancel" style="width:80px;">Cancel</button></a>
			</div>
		</form>
	</div>
</div>