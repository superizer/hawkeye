<%inherit file="/base/base.mako"/>
<%block name="style">
<style>
#wrapper {
	position: absolute;
    overflow: auto;
    left: 0;
    right: 0;
    top: 0;
    bottom: 0;
	font-family: arial, helvetica, sans-serif;
	/* border: 5px solid red; */
}
</style>
</%block>
<%block name="script">
<script type="text/javascript">
/* 	$(function(){
		<% x = 0 %>
		% for file in files:
			% if file['file']:
				$("#file-${x}").dblclick( function () { 
					document.forms["file-${x}"].submit();
				});
			% else:
				$("#folder-${x}").dblclick( function () { 
					document.forms["folder-${x}"].submit();
				});
			% endif
			<% x = x + 1 %>
		% endfor
	}); */
	$(function() {
		$.ajax({
			type : 'GET',
			url : "${request.config.settings['nokkhum.api.url']}/storage/${camera}",
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
				
				function showVideoFile(tmpUrl){
				
					$("<source/>", {
						"src" : tmpUrl,
						"type":"video/ogg"
					}).appendTo(
					$("<video/>", {
						"style" : "width:100%; height:100%;",
						"controls":"controls",
						"autoplay":"autoplay"
					}).appendTo('#storage'));
					
				}
				
				function showPicFile(tmpUrl){
					
					$("<img/>", {
						"style" : "width:100%; height:100%;",
						"src" : tmpUrl
					}).appendTo('#storage');
					
				}
				
				function generteFolder(tmp) {
					for (i in tmp) {
						if(tmp[i].file){
							var tmpName = tmp[i].name.substr(tmp[i].name.lastIndexOf('.'),tmp[i].name.length);
							if(tmpName == "png"){
								$("<div/>", {
									"class" : "fname",
									text : tmp[i].name
								}).appendTo(
									$("<div/>", {
										"class" : "picture",
										dblclick :function(){
											$('#storage').empty();
											showPicFile(tmp[i].download);
										}
									}).appendTo('#storage')		
								);
							}else{
								$("<div/>", {
									"class" : "fname",
									text : tmp[i].name
								}).appendTo(
									$("<div/>", {
										"class" : "video",
										dblclick :function(){
											$('#storage').empty();
											showVideoFile(tmp[i].download);
										}
									}).appendTo('#storage')		
								);
							}
						}else{
							$("<div/>", {
								"class" : "fname",
								text : tmp[i].name
							}).appendTo(
								$("<div/>", {
									"class" : "folder",
									dblclick :function(){
										$('#storage').empty();
										generteNextFolder(tmp[i].url);
									}
								}).appendTo('#storage')		
							);
						}
					}
				}
				generteFolder(dir.files);
			}
		});
	});
</script>
</%block>
<div id="storage"></div>
<%doc>
<% x = 0 %>
% for file in files:
	% if file['file']:
		<form id="file-${x}" name="file-${x}" class="folder" action="/camera/files?files_url=${file['download']}&camera_id=${camera['id']}">
			<div class="fname">${file['name']}</div>
		</form>
	% else:
		<form id="folder-${x}" name="folder-${x}" class="folder" action="/camera/storage?files_url=${file['url']}&camera_id=${camera['id']}">
			<div class="fname">${file['name']}</div>
		</form>
	% endif
	<% x = x + 1 %>
% endfor

	% for file in files:
		% if file['file']:
		<span style="color: #fff;">${file['name']}</span> <a href="/camera/files?files_url=${file['download']}&camera_id=${camera['id']}">view</a> <a href="/camera/files/delete?files_url=${file['url']}">delete</a><br/>
		% else:
		<span style="color: #fff;">${file['name']}</span> <a href="/camera/storage?files_url=${file['url']}&camera_id=${camera['id']}">view</a> <a href="/camera/files/delete?files_url=${file['url']}">delete</a><br/>
		% endif
          % endfor
	% if route is not None:
		##${route}<br/>
		<a href=${route}><input type="button" value="Back"></a>
	% endif
	<a href="/home"><input type="button"  value="Home"></a>
</%doc>	
