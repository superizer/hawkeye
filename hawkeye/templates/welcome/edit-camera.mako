<%inherit file="/base/base.mako"/>
<form action="/camera/edit" method = "put">
Add Camera to Project ${project['name']}<br/>
Name : ${form.name} <br/>
Url :  ${form.url} <br/>
Username : ${form.username} </br>
Password : ${form.password} </br>
Fps : ${form.fps()} </br> 
Image size : ${form.image_size()}  </br>
Menufactory : ${form.manufactory()} </br>
Model : ${form.model()} </br>
Record Store : ${form.record_store} </br> 
<input type="hidden" name="camera_id" value="${camera['id']}"/>
<input type="hidden" name="project_id" value="${project['id']}"/>
<input type="submit" value="Save">
<input type="reset"   value="Reset"> 
<a href="/home"><input type="button"  value="Cancel"></a>
</form>