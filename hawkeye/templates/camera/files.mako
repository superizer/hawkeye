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