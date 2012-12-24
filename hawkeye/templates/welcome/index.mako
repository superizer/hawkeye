<%inherit file="/base/base.mako"/>
<!-- <p1>Project:</p1>-->
<!-- <p1>${form.project()}</p1>   -->
<!-- <a href ="/edit">Edit Project</a> -->
<a href="/observe">Observe</a>
<a href="/project/add">Add Project</a>
<!-- <a href="/delete">Delete Project</a> -->
<a href="/profile">Profile</a>
<a href="/logout">Log out</a>
<a href="/exit">Exit</a></br></br></br>

% for project in projects:
	${project['name']}&nbsp;&nbsp;
	<a href = "/camera/add?id=${project['id']}">Add</a>
	<a href ="/project/edit?id=${project['id']}">Edit</a>
	<a href ="/project/delete?id=${project['id']}">Delete</a>
	<br/>
% endfor