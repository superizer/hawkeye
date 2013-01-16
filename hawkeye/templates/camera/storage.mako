<%inherit file="/base/base.mako"/>
<%block name='script'>
<script type="text/javascript">
	$(function() {
		$.ajax({
			type : 'GET',
			url : "${request.config.settings['nokkhum.api.url']}/storage/1",
			datatype : 'json',
			error : function(resp) { console.debug("header-> : " + JSON.stringify(resp.getAllResponseHeaders())); },
			success : function(dir) {
				function generteNextFolder(tmp){
					$.ajax({
						type : 'GET',
						url : "${request.config.settings['nokkhum.api.url']}"+tmp,
						datatype : 'json',
						error : function(resp) { console.debug("header-> : " + JSON.stringify(resp.getAllResponseHeaders())); },
						success : function(dir) {
							generteFolder(dir.files);
						}
					});
				}
				function generteFolder(tmp) {
					for (i in tmp) {
						$("<div/>", {
							"class" : "folder",
							text : tmp[i].name,
							dblclick :function(){
								$('#storage').empty();
								generteNextFolder(tmp[i].url);
							}
						}).appendTo('#storage');
					}
				}
				generteFolder(dir.files);
			}
		});
	});
</script>
</%block>
<%block name='menu'>
<div  class="menu">
    <ul class="button-group" >
		<li><a class="button"><</a></li>
		<li><a class="button">></a></li>
    </ul>
	% if route is not None: 
		<a href=${route}>Back</a> 
	% endif
		<a href="/home">Home</a>
</div>
</%block>
<div id="storage"></div>
