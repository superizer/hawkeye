<%inherit file="/base/base.mako"/>
<script>
	$(function() {
		$("#accordion").accordion({collapsible : true});
		<% x = 0 %>
		% for project in projects:
			$("#${x}").buttonset();
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
% for project in projects:
	<h3>${project['name']}</h3>
	<div>
	<div class="menu-project">
		<div id="${x}">
			<label for="radio1"><a href = "/camera/add?id=${project['id']}"><span class="ui-icon ui-icon-circle-plus" style="clear:both;float:left;margin:0 5px 0 0;"></span>Add camera</a></label>
			<label for="radio2"><a href ="/project/edit?id=${project['id']}"><span class="ui-icon ui-icon-wrench" style="clear:both;float:left;margin:0 5px 0 0;"></span>Edit project</a></label>
			<label for="radio3"><a href ="/project/delete?id=${project['id']}"><span class="ui-icon ui-icon-trash" style="clear:both;float:left;margin:0 5px 0 0;"></span>Delete project</a></label>
		</div>
	</div>
	<div class="des-project">
		%if project['description'] != "":
			  Description : ${project['description']}
		%endif
	</div>
	% for camera in project['cameras']:
		${camera['name']} <a href ="/camera/edit?camera_id=${camera['id']}&project_id=${project['id']}">edit</a>  <a href ="/camera/delete?camera_id=${camera['id']}">delete</a><a href ="/camera/storage?camera_id=${camera['id']}">storage</a><br/>
	% endfor
		<ul>
			<li>camera one</li>
			<li>camera two</li>
			<li>camera three</li>
		</ul>
	</div>
	<% x = x + 1 %>
% endfor
</div>
</div>
</div>
</div>
