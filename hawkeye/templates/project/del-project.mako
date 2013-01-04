<%inherit file="/base/base.mako"/>
<form action="/delete" method="get">
<p1>Project:</p1>
<p1>${form.project()}</p1>
<input type="submit" value="Delete">
<a href="/home"><input type="button"  value="Cancel"></a>
</form>