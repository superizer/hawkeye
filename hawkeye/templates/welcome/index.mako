<%inherit file="/base/base.mako"/>
<script>
	$(function() {
		$("#accordion").accordion({collapsible : true});
		% for project in projects:
			$("${"#"+project[0]}").buttonset();
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
% for project in projects:
	<h3>${project[0]}</h3>
	<div>
	<div class="menu-project">
		<div id=${project['name']}>
			<label for="radio1"><a href = "/camera/add?id=${project['id']}">Add camera</a></label>
			<label for="radio2"><a href ="/project/edit?id=${project['id']}">Edit project</a></label>
			<label for="radio3"><a href ="/project/delete?id=${project['id']}">Delete project</a></label>
		</div>
	</div>
	<p>Description : ${project[1]}</p>
		<ul>
			<li>camera one</li>
			<li>camera two</li>
			<li>camera three</li>
		</ul>
	</div>
% endfor
</div>
</div>