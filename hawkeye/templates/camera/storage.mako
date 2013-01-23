<%inherit file="/base/base.mako"/>
<%block name="style">
<style>
#wrapper {
	position: absolute;
    overflow: auto;
    left: 0;
    right: 0;
    top: 0;
    bottom: 0;
	font-family: arial, helvetica, sans-serif;
	/* border: 5px solid red; */
}
</style>
</%block>
	% for file in files:
		% if file['file']:
		${file['name']} <a href="/camera/files?files_url=${file['download']}&camera_id=${camera['id']}">view</a> <a href="/camera/files/delete?files_url=${file['url']}">delete</a><br/>
		% else:
		${file['name']} <a href="/camera/storage?files_url=${file['url']}&camera_id=${camera['id']}">view</a> <a href="/camera/files/delete?files_url=${file['url']}">delete</a><br/>
		% endif
          % endfor
	% if route is not None:
		##${route}<br/>
		<a href=${route}><input type="button" value="Back"></a>
	% endif
	<a href="/home"><input type="button"  value="Home"></a>