<!DOCTYPE HTML>
<html>
<head>

<meta charset="utf-8"/>
<link media="screen" href="${base_url}/public/theme/style/core.css" rel="stylesheet" type="text/css" />

</head>
<body>
	<div id="wrapper">
		<div id="header"><%block name='menu'></%block></div>
		<div id="content">${next.body()}</div>
		<div id="footer"></div>
	</div>
</body>
</html>