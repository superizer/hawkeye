<!DOCTYPE HTML>
<html>
<head>
<meta charset="UTF-8" />
<link media="screen" href="${base_uri}/public/theme/style/jquery-ui-1.9.2.custom.css" rel="stylesheet" type="text/css" />
<link media="screen" href="${base_uri}/public/theme/style/jquery-ui-1.9.2.custom.min.css" rel="stylesheet" type="text/css" />
<link media="screen" href="${base_uri}/public/theme/style/core.css" rel="stylesheet" type="text/css" />
<%block name='style'></%block>
<script type="text/javascript" src="${base_uri}/public/js/jquery-1.8.3.js"></script>
<script type="text/javascript" src="${base_uri}/public/js/jquery-1.8.3.min.js"></script>
<script type="text/javascript" src="${base_uri}/public/js/jquery-ui-1.9.2.custom.js"></script>
<script type="text/javascript" src="${base_uri}/public/js/jquery-ui-1.9.2.custom.min.js"></script>
<%block name='script'></%block>
</head>

<body>
    <%block name='menu'></%block>
	<div id="wrapper">
		${next.body()}
	</div>
</body>
</html>