<%inherit file="/base/base.mako"/>

% if image:
	<img src='${url}' /><br/>
% else:
	<video width="640" controls="controls" autoplay="autoplay">
  		<source src="${url}" type="video/ogg"/>
  		Your browser does not support the HTML 5 video tag.
	</video><br/>
% endif
##${route}<br/>
<a href=${route}><input type="button" value="Back"></a>
<a href="/home"><input type="button"  value="Home"></a>