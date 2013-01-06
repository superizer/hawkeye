<!DOCTYPE HTML>
<html>
<head>
<meta charset="UTF-8" />
<link media="screen" href="${base_url}/public/theme/style/jquery-ui-1.9.2.custom.css" rel="stylesheet" type="text/css" />
<link media="screen" href="${base_url}/public/theme/style/jquery-ui-1.9.2.custom.min.css" rel="stylesheet" type="text/css" />
<link media="screen" href="${base_url}/public/theme/style/core.css" rel="stylesheet" type="text/css" />

<script type="text/javascript" src="${base_url}/public/js/jquery-1.8.3.js"></script>
<script type="text/javascript" src="${base_url}/public/js/jquery-1.8.3.min.js"></script>
<script type="text/javascript" src="${base_url}/public/js/jquery-ui-1.9.2.custom.js"></script>
<script type="text/javascript" src="${base_url}/public/js/jquery-ui-1.9.2.custom.min.js"></script>
<script>
	$(function(){
		$("body").css("overflow", "hidden");
	});
</script>
</head>
<body>
	<div id="wrapper">
		${next.body()}
	</div>
</body>
</html>