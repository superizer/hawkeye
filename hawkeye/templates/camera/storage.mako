<%inherit file="/base/base.mako"/>
<%block name="style">
<link href="${base_url}/public/theme/style/contextmenu.css" rel="stylesheet" type="text/css" />
<style>
#wrapper {
	position: absolute;
    overflow: auto;
    left: 0;
    right: 0;
    top: 42px;
    bottom: 0;
	font-family: arial, helvetica, sans-serif;
	background-color: #fff;
	/* border: 5px solid red; */
}
</style>
</%block>
<%block name="script">
<script src="${base_url}/public/js/Plugins/jquery.contextmenu.js" type="text/javascript"></script> 
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
		var history  = new Array();
		history.push("/storage/${camera}");
		var whatHere = 0;
		$("#home").button();
		$.ajax({
			type : 'GET',
			url : "${request.config.settings['nokkhum.api.url']}/storage/${camera}",
			datatype : 'json',
			error : function(resp) { console.debug("header-> : " + JSON.stringify(resp.getAllResponseHeaders())); },
			success : function(dir) {
				
				$("#prev-views").button({ disabled: true }).click(function(){
					$('#wrapper').empty();
					whatHere--;
					if(whatHere < 0 ){
						whatHere = 0;
					}
					var tmpName = history[whatHere].substr(history[whatHere].lastIndexOf('.') + 1,history[whatHere].length);
					if(tmpName == 'png'){
						showPicFile(history[whatHere]);
					}else if(tmpName == 'ogv' || tmpName == 'webm'){
						showVideoFile(history[whatHere]);
					}else{
						generteNextFolder(history[whatHere]);
					}
					if(history[whatHere] == history[0]){
						$("#prev-views").button({ disabled: true });
					}
					$("#next-views").button({ disabled: false });
		  		});
		  		$("#next-views").button({ disabled: true }).click(function(){
		  			$('#wrapper').empty();
		  			whatHere++;
		  			if(whatHere >  history.length - 1){
						whatHere = history.length - 1;
					}
		  			var tmpName = history[whatHere].substr(history[whatHere].lastIndexOf('.') + 1,history[whatHere].length);
					if(tmpName == 'png'){
						showPicFile(history[whatHere]);
					}else if(tmpName == 'ogv' || tmpName == 'webm'){
						showVideoFile(history[whatHere]);
					}else{
						generteNextFolder(history[whatHere]);
					}
					if(history[whatHere] == history[history.length - 1]){
						$("#next-views").button({ disabled: true });
					}
					$("#prev-views").button({ disabled: false });
		  		});
				
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
					}).appendTo('#wrapper'));
					
				}
				
				function showPicFile(tmpUrl){
					
					$("<img/>", {
						"style" : "width:100%; height:100%;",
						"src" : tmpUrl
					}).appendTo('#wrapper');
					
				}
				
				function generteFolder(tmp) {
					for (i in tmp) {
						if(tmp[i].file){
							var tmpName = tmp[i].name.substr(tmp[i].name.lastIndexOf('.') + 1,tmp[i].name.length);
							if(tmpName == "png"){
								$("<div/>", {
									"class" : "fname",
									text : tmp[i].name
								}).appendTo(
									$("<div/>", {
										"class" : "picture",
										dblclick :function(){
											$('#wrapper').empty();
											history.push(tmp[i].download);
											whatHere = history.length - 1;
											$("#next-views").button({ disabled: true });
											$("#prev-views").button({ disabled: false });
											showPicFile(tmp[i].download);
										}
									}).appendTo('#wrapper')		
								);
							}else{
								$("<div/>", {
									"class" : "fname",
									text : tmp[i].name
								}).appendTo(
									$("<div/>", {
										"class" : "video",
										dblclick :function(){
											$('#wrapper').empty();
											history.push(tmp[i].download);
											whatHere = history.length - 1;
											$("#next-views").button({ disabled: true });
											$("#prev-views").button({ disabled: false });
											showVideoFile(tmp[i].download);
										}
									}).appendTo('#wrapper')		
								);
							}
						}else{
							var option = { width: 150, items: [
							                                   { text: "Open", 
							                                	 icon: "${base_url}/public/theme/style/images/contextmenu/fileopen.png", 
							                                	 alias: "1-1", 
							                                	 action: openThis },
							                                   { text: "Delete", 
							                                	 icon: "${base_url}/public/theme/style/images/contextmenu/editdelete.png", 
							                                	 alias: "1-2", 
							                                	 action: deleteThis }
							                                   ]
							                           };
					        function openThis() {
					        	$('#wrapper').empty();
					        	$('.b-m-mpanel').remove();
								history.push(tmp[i].url);
								whatHere = history.length - 1;
								$("#next-views").button({ disabled: true });
								$("#prev-views").button({ disabled: false });
								generteNextFolder(tmp[i].url);
					        }
					        function deleteThis() {
					        	$.ajax({
					    			  type: 'DELETE',
					    	          url: "${request.config.settings['nokkhum.api.url']}"+tmp[i].url,
					    	          error: function(){
					    	        	  alert('Too Bad');
					    	          },
					    	          success: function(){
					    	        	  $('#wrapper').empty();
					    	        	  $('.b-m-mpanel').remove();
										  generteNextFolder(history[whatHere]);
					    	          }
					    	        });
					        }
							
							$("<div/>", {
								"class" : "fname",
								text : tmp[i].name
							}).appendTo(
								$("<div/>", {
									"class" : "folder",
									dblclick :function(){
										$('#wrapper').empty();
										$('.b-m-mpanel').remove();
										history.push(tmp[i].url);
										whatHere = history.length - 1;
										$("#next-views").button({ disabled: true });
										$("#prev-views").button({ disabled: false });
										generteNextFolder(tmp[i].url);
									}
								}).contextmenu(option).appendTo('#wrapper')		
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

<%block name='menu'>
<div class="menu">
	<a href="#"  id="prev-views" >Previous</a>
	<a href="#"  id="next-views" >Next</a>
	<a href="/home" id="home" >Home</a>
</div>
</%block>


<%doc>
<div id="storage"></div>
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
