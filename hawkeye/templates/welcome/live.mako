<script type="text/javascript">
function updateImage()
{
	var image = document.getElementById("display");
    if(image.complete) {
    	var timestamp = new Date().getTime();
    	var str = "${url}";
        image.src = str.substr(0,str.lastIndexOf('.')) + 'data=' +timestamp;
        
    }
    setTimeout(updateImage, 1000);
}
</script>

<img id="display" src="${url}" height="240" width="320" onload="updateImage();"/><br/>
<a href="/home"><input type="button"  value="Home"></a>