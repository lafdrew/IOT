<html>
<head>
<META HTTP-EQUIV="CACHE-CONTROL" CONTENT="NO-CACHE">
<meta http-equiv="Pragma" content="no-cache">
<meta http-equiv="expires" content="Mon, 22 Jul 1999 11:12:01 GMT">
<title>Commit</title>
<script type="text/javascript" src="/func.js"></script>
<link rel='stylesheet' href='/normal_ws.css' type='text/css'>
<script language="JavaScript" type="text/javascript">
function page_load() {
	var currectIP = "<% nvram_get("lan_ipaddr"); %>";
	if (currectIP != "")
		top.location.href = "http://" + currectIP + "/";
}
</script>
<% language=javascript %>
</head>
<body onLoad="page_load();">
</body>
</html>