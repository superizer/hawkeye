<%inherit file="/base/base.mako"/>
<form action="/project/add" method = "get">
Name : ${form.name} <br/>
Description : ${form.description}<br/>
<input type="submit" value="Add">
<input type="reset"   value="Reset"> 
<a href="/home"><input type="button"  value="Cancel"></a>
</form>