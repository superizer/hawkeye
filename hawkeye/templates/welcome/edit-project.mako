<%inherit file="/base/base.mako"/>
<form action="/project/edit" method = "get">
<p1>Project: ${project['name']}</p1>
<p1></p1>
change to ... <br/>
Name : ${form.name} <br/>
Description : ${form.description}<br/>
<input type="hidden" name="id" value="${project['id']}"/>
<input type="submit" value="Change">
<input type="reset"   value="Reset"> 
<a href="/home"><input type="button"  value="Cancel"></a>
</form>