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
	<div class="ui-widget-shadow ui-corner-all add-project-set-shadow-style"></div>
</div>
<div class="ui-widget ui-widget-content ui-corner-all add-project-set-content-style">
	<div class="ui-dialog-content ui-widget-content add-project-set-content-inner-style">
		<form action="/project/add" method="post">
		<div class="form-name">:: Add Project Form ::</div>
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
				% elif form.get_error('name'):
					${form.get_error('name')}
				% endif
			</div>
			<div class="form-button">
				<button id="submit" class="add-project-button" type="submit">Save</button>
				<button id="reset" class="add-project-button" type="reset">Reset</button>
				<a href='/home'><button id="cancel" class="add-project-button">Cancel</button></a>
			</div>
		</form>
	</div>
</div>