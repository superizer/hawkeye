<%inherit file="/base/base.mako"/>
<script>
	$(function() {
		$("#accordion").accordion({collapsible : true});
		<% x = 0 %>
		<% y = 0 %>
		% for project in projects:
			$("#menu-project-${x}").buttonset();
		    % for camera in project['cameras']:
		    	$("#menu-project-camera-${y}").buttonset();
		        <% y = y + 1 %>
		    % endfor
		    <% x = x + 1 %>
		% endfor
		$("#addProject").button();
		$("#profile").button();
		$("#logout").button();
	});
</script>
<!-- <p1>Project:</p1>-->
<!-- <p1>${form.project()}</p1>   -->
<!-- <a href ="/edit">Edit Project</a> -->
<div class="main-menu">
<a href="/project/add"><button id="addProject">Add Project</button></a>
<div class="main-menu-right">
<a href="/profile"><button id="profile">Profile</button></a>
<a href="/logout"><button id="logout">Logout</button></a>
</div>
<!-- <a href="/delete">Delete Project</a> -->
</div>
<%doc>
<a href="/observe">Observe</a>
<a href="/exit">Exit</a></br></br></br>
<a href="/live">Live</a></a></br></br></br>
</%doc>
<div style="margin:0 12px 0 12px;">
<div id="accordion">
<% x = 0 %>
<% y = 0 %>
% for project in projects:
	<h3>${project['name']}</h3>
	<div>
		<div class="menu-project">
			<div id="menu-project-${x}">
				<label for="radio1"><a href = "/camera/add?id=${project['id']}"><span class="ui-icon ui-icon-circle-plus index-icon-button" ></span>Add camera</a></label>
				<label for="radio2"><a href ="/project/edit?id=${project['id']}"><span class="ui-icon ui-icon-wrench index-icon-button" ></span>Edit project</a></label>
				<label for="radio3"><a href ="/project/delete?id=${project['id']}"><span class="ui-icon ui-icon-trash index-icon-button" ></span>Delete project</a></label>
			</div>
		</div>
<<<<<<< HEAD
		<div class="des-project">
			%if project['description'] != "":
				  Description : ${project['description']}
			%endif
		</div>
=======
	</div>
	<div class="des-project">
		%if project['description'] != "":
			  Description : ${project['description']}
		%endif
	</div>
	% for camera in project['cameras']:
		${camera['name']} <a href ="/camera/edit?camera_id=${camera['id']}&project_id=${project['id']}">edit</a>  <a href ="/camera/delete?camera_id=${camera['id']}">delete</a> <a href ="/camera/storage?camera_id=${camera['id']}">storage</a><br/>
	% endfor
>>>>>>> branch 'master' of ssh://git@github.com/superizer/hawkeye.git
		<ul>
		% for camera in project['cameras']:
		    <li> 
			    <div class="" style="height:35px;">
			        ${camera['name']}
				    <div id="menu-project-camera-${y}" class="index-camera-list-tool" style="margin-top:-7px; ">
						<label for="radio1"><a href = "/camera/edit?camera_id=${camera['id']}&project_id=${project['id']}"><span class="ui-icon ui-icon-wrench index-icon-button" ></span>Edit</a></label>
						<label for="radio2"><a href = "/camera/storage?camera_id=${camera['id']}"><span class="ui-icon ui-icon-disk index-icon-button" ></span>Storage</a></label>
						<label for="radio3"><a href = "/camera/delete?camera_id=${camera['id']}"><span class="ui-icon ui-icon-trash index-icon-button" ></span>Delete</a></label>
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
</div>
