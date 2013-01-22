<%inherit file="/base/base.mako"/> 
<%block name='script'>
<script>
	$(function() {
		$("#radio").buttonset();
	});
</script>
</%block>
<div id="profilep">
	<form action="/home" autocomplete="on" method="post">
		<dl>
			<dt>
				<label for="name">Name :</label>
			</dt>
			<dd>${user.get('first_name')}</dd>
		</dl>
		<dl>
			<dt>
				<label for="surname">Surname :</label>
			</dt>
			<dd>${user.get('last_name')}</dd>
		</dl>
		<dl>
			<dt>
				<label for="email">Email :</label>
			</dt>
			<dd>${user.get('email')}</dd>
		</dl>
		<div id="radio" class="centered">
			<a href='/home'>Back</a>
		</div>
	</form>
</div>