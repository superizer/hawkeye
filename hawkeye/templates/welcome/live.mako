<!--  
<img src="http://admin:123zxc@172.30.235.183/video/mjpg.cgi?.mjpg" height="240" width="320"/>
-->
<script type="text/javascript">
function updateImage()
{
	var image = document.getElementById("display");
    if(image.complete) {
    	var timestamp = new Date().getTime();
        image.src = "http://admin:123zxc@172.30.235.183/image/jpeg.cgi?date="+timestamp;

    }

    setTimeout(updateImage, 1000);
}
</script>

<img id="display" src="http://admin:123zxc@172.30.235.183/image/jpeg.cgi?.jpg" height="240" width="320" onload="updateImage();"/>

