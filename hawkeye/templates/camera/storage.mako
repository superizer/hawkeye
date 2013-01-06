<%inherit file="/base/base.mako"/>
% for file in files:
	% if file['file']:
	${file['name']} <a href="/camera/files?files_url=${file['download']}">view</a> <a href="/camera/files/delete?files_url=${file['url']}">delete</a><br/>
	% else:
	${file['name']} <a href="/camera/storage?files_url=${file['url']}">view</a> <a href="/camera/files/delete?files_url=${file['url']}">delete</a><br/>
	% endif
% endfor

% if route is not None:
	${route}<br/>
	<a href=${route}><input type="button" value="Back"></a>
	##<% route = None %>
% endif
<a href="/home"><input type="button"  value="Home"></a>