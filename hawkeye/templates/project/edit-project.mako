<%inherit file="/base/base.mako"/>
<%block name='script'>
<script>
	$(function() {
		$("#radio").buttonset();
	});
</script>
</%block>
<div id="addproject">
	% if message: 
		<div class="validate">${message}</div>
	% elif form.get_error('name'):
		<div class="validate">${form.get_error('name')}</div>
	% endif
	<form action="/project/add" autocomplete="on" method="post">
		${form.name(placeholder="Name")}
		${form.description(placeholder="Description")}
		<div id="radio" class="centered">
			<button id="submit" type="submit">Save</button>
			<button id="reset" type="reset">Reset</button>
			<a href='/home'>Cancel</a>
		</div>
	</form>
</div>
