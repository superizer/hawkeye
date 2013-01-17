<%inherit file="/base/base.mako"/> 
<%block name='style'>
<style>
.ui-menu { position: absolute; width: 100px; }
</style>
</%block>

<%block name='script'>
<script>
	$(function() {
		$("#accordion").accordion({
			collapsible : false,
			heightStyle: "content"
			});
		<% x = 0 %>
		<% y = 0 %>
		% for project in projects:
			$( "#pmenu-${x}" )
				.button()
					.next()
		        		.button({
		          			text: false,
		          			icons: {
		            		primary: "ui-icon-triangle-1-s"
		          			}
		        		})
		        	.click(function() {
		          		var menu = $( this ).parent().next().show().position({
		            		my: "left top",
		            		at: "left bottom",
		            		of: this
		          		}).css('z-index',1000);
		    			$( document ).one( "click", function() {
		    				menu.hide();
		   				});
		          		return false;
		        	}).parent().buttonset().next().hide().menu();
		    % for camera in project['cameras']:
	    		$.ajax({
    			  type: 'GET',
    	          url: "${request.config.settings['nokkhum.api.url']}/cameras/${camera['id']}/operating", 
    	          datatype: 'json',
    	          error: function(resp){
    	        	  console.debug("header-> : "+JSON.stringify(resp.getAllResponseHeaders()));
    	          },
    	          success: function(chonf){
					  if(chonf.camera.operating.status == 'Running'){
						  $('#myonoffswitch-${y}').attr('checked','checked');
					  }
					  $('#myonoffswitch-${y}').click(function() {
						  $.ajax({
			    			  type: 'GET',
			    	          url: "${request.config.settings['nokkhum.api.url']}/cameras/${camera['id']}/operating", 
			    	          datatype: 'json',
			    	          error: function(resp){
			    	        	  console.debug("header-> : "+JSON.stringify(resp.getAllResponseHeaders()));
			    	          },
			    	          success: function(chonf){
			    	        	  if(chonf.camera.operating.status == 'Running'){
									  $.ajax({
						    			  type: 'POST',
						    	          url: "${request.config.settings['nokkhum.api.url']}/cameras/${camera['id']}/operating",
						    	          data: JSON.stringify({'camera_operating' : { 'action' : 'stop' }}),
						    	          datatype: 'json'
						    	      });
								  }else{
									  $.ajax({
						    			  type: 'POST',
						    	          url: "${request.config.settings['nokkhum.api.url']}/cameras/${camera['id']}/operating",
						    	          data: JSON.stringify({'camera_operating' : { 'action' : 'start' }}),
						    	          datatype: 'json'
						    	      });
								  }
			    	          }
						  });
					  });
				  }
	    	    });
		    
		    	$("#live-${y}").button();
		    	$("#stor-${y}").button().next()
        		.button({
          			text: false,
          			icons: {
            		primary: "ui-icon-triangle-1-s"
          			}
        		})
        		.click(function() {
	          		var menu = $( this ).parent().next().show().position({
	            		my: "left top",
	            		at: "left bottom",
	            		of: this
	          		}).css('z-index',1000);
	          		menu.zIndex();
	    			$( document ).one( "click", function() {
	    				menu.hide();
	   				});
	          		return false;
        			}).parent().buttonset().next().hide().menu();
		    	<% y = y + 1 %>
			% endfor
		    <% x = x + 1 %>
		% endfor
		$("#addProject").button();
		$("#profile").button();
		$("#logout").button();
		
	});
</script>
</%block>
<!-- <p1>Project:</p1>-->
<!-- <p1>${form.project()}</p1>   -->
<!-- <a href ="/edit">Edit Project</a> -->
<%block name='menu'>
<div class="menu">
	<a href="/project/add" id="addProject">Add Project</a>
	<div class="right"> 
		<a href="/profile" id="profile">Profile</a> 
		<a href="/logout" id="logout">Logout</a>
	</div>
</div>
</%block>
<!-- <a href="/delete">Delete Project</a> -->
<%doc>
<a href="/observe">Observe</a>
<a href="/exit">Exit</a>
</br>
</br>
</br>
<a href="/live">Live</a>
</a>
</br>
</br>
</br>
</%doc>

<div id="accordion">
<% x = 0 %>
<% y = 0 %>
% for project in projects:
	<h3>${project['name']}</h3>
	<div>
		<div class="pmenu">
		  <div>
		    <a id="pmenu-${x}" href = "/camera/add?id=${project['id']}">Add camera</a>
		    <button id="select">Select an action</button>
		  </div>
		  <ul>
		    <li><a href ="/project/edit?id=${project['id']}">Edit project</a></li>
		    <li><a href ="/project/delete?id=${project['id']}">Delete project</a></li>
		  </ul>
		</div>
		<div class="pdes">
			Description :
			%if project['description'] != "":
				  ${project['description']}
		    %else:
		    	  N / A
			%endif
		</div>
		<ul>
		% for camera in project['cameras']:
		    <li> 
			    <div class="pclist">
			        ${camera['name']}
			        <div class="pclist-t">
						<div class="pcslist-t">	        
				        	<div>
							    <a id="live-${y}" href = "/live?camera_id=${camera['id']}">Live</a>
		 						<a id="stor-${y}" href = "/camera/storage?camera_id=${camera['id']}">Storage</a>
		   						<button id="select">Select an action</button>
		 					</div>
		 					<ul>
				    			<li><a href = "/camera/edit?camera_id=${camera['id']}&project_id=${project['id']}">Edit</a></li>
				    			<li><a href = "/camera/delete?camera_id=${camera['id']}">Delete</a></li>
							</ul>
						</div>
						<div class="on-pcslist-t">
							<div class="onoffswitch">
							    <input type="checkbox" name="onoffswitch" class="onoffswitch-checkbox" id="myonoffswitch-${y}">
							    <label class="onoffswitch-label" for="myonoffswitch-${y}">
							        <div class="onoffswitch-inner"></div>
							        <div class="onoffswitch-switch"></div>
							    </label>
							</div>	
						</div>
					</div>
				</div>
			</li>
			<% y = y + 1 %>
		% endfor
		</ul>
	</div>
	<% x = x + 1 %>
% endfor
</div>
</div>
</div>
