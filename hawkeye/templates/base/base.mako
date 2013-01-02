<!DOCTYPE HTML>
<html>
<head>

<link media="screen" href="public/theme/style/jquery-ui-1.9.2.custom.css" rel="stylesheet" type="text/css" />
<link media="screen" href="public/theme/style/jquery-ui-1.9.2.custom.min.css" rel="stylesheet" type="text/css" />
<link media="screen" href="public/theme/style/core.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="public/js/jquery-1.8.3.js"></script>
<script type="text/javascript" src="public/js/jquery-ui-1.9.2.custom.js"></script>
<script type="text/javascript" src="public/js/jquery-ui-1.9.2.custom.min.js"></script>

</head>
<body>
	<div id="wrapper">
		<div id="header"><%block name='menu'></%block></div>
		<div id="content">${next.body()}</div>
	</div>
</body>
</html>