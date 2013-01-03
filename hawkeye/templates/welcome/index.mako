<%inherit file="/base/base.mako"/>
<script>
	$(function() {
		$("#accordion").accordion({
			collapsible : true
		});
	});
</script>
<!-- <p1>Project:</p1>-->
<!-- <p1>${form.project()}</p1>   -->
<!-- <a href ="/edit">Edit Project</a> -->
<a href="/observe">Observe</a>
<a href="/project/add">Add Project</a>
<!-- <a href="/delete">Delete Project</a> -->
<a href="/profile">Profile</a>
<a href="/logout">Log out</a>
<a href="/exit">Exit</a></br></br></br>
<a href="/live">Live</a></a></br></br></br>
<div style="margin:0 10px 0 10px;">
<div id="accordion">
% for project in projects:
	<h3>${project['name']}</h3>
	<div>
	<a href = "/camera/add?id=${project['id']}">Add</a>
	<a href ="/project/edit?id=${project['id']}">Edit</a>
	<a href ="/project/delete?id=${project['id']}">Delete</a>
	<p>Description : n/a</p>
		<ul>
			<li>camera one</li>
			<li>camera two</li>
			<li>camera three</li>
		</ul>
	</div>
% endfor
</div>
</div>