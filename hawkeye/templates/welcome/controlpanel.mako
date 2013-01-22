<%inherit file="/base/base.mako"/> 

<%block name='script'>
<script type="text/javascript">
	$(function(){
		$("#back").button();
	});
</script>
</%block>
<%block name='menu'>
<div class="menu">
	<a href="/home" id="back">Back</a>
</div>
</%block>
<div id="controlpanel">
	<div id="list-user">
	
	</div>
</div>
