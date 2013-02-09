<%inherit file="/base/base.mako"/>
<%block name="style">
<link href="${base_url}/public/theme/style/contextmenu.css" rel="stylesheet" type="text/css" />
<style>
#wrapper {
	position: absolute;
    overflow: auto;
    left: 0;
    right: 0;
    top: 42px;
    bottom: 0;
	font-family: arial, helvetica, sans-serif;
	background-color: #fff;
	/* border: 5px solid red; */
}
</style>
</%block>
<%block name="script">
<script type="text/javascript">
	$(function(){
		$("#prev-views").button();
		$("#home").button();
	});
</script> 
</%block>
<%block name='menu'>
<div class="menu">
	<a href="${route}"  id="prev-views" >Back</a>
	<a href="/home" id="home" >Home</a>
</div>
</%block>
% if image:
	<img style="height: 100%; width: 100%;" src='${url}' /><br/>
% else:
	<video style="height: 100%; width: 100%;" controls="controls" autoplay="autoplay">
  		<source src="${url}" type="video/ogg"/>
  		Your browser does not support the HTML 5 video tag.
	</video><br/>
% endif