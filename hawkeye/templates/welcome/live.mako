<%inherit file="/base/base.mako"/> 
<%block name='script'>
<script type="text/javascript">

$(function(){
	$('#home').button();	
});
function updateImage()
{
	var image = document.getElementById("display");
    if(image.complete) {
    	var timestamp = new Date().getTime();
    	var str = "${url}?.jpg";
        image.src = str.substr(0,str.lastIndexOf('.')) + 'data=' +timestamp;
        
    }
    setTimeout(updateImage, 1000);
}
</script>
</%block>
<%block name='menu'>
<div class="menu">
	<a href="/home" id="home" >Back</a>
</div>
</%block>
<img id="display" src="${url}?.jpg" height="100%" width="100%" onload="updateImage();"/><br/>