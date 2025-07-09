<html>
<head>
<META HTTP-EQUIV="CACHE-CONTROL" CONTENT="NO-CACHE">
<meta http-equiv="Pragma" content="no-cache">
<meta http-equiv="expires" content="Mon, 22 Jul 1999 11:12:01 GMT">
<title>Commit</title>
<script type="text/javascript" src="/func.js"></script>
<link rel='stylesheet' href='/normal_ws.css' type='text/css'>
<script language="JavaScript" type="text/javascript">
var url = "/";

function GetArgsFromHref(sHref, sArgName)
{
	var args = sHref.split("?");
	var retval = "";
	
	if(args[0] == sHref)
		return retval;
	var str = args[1];
	args = str.split("&");
	for(var i = 0; i < args.length; i ++)	{
		str = args[i];
		var arg = str.split("=");
		if(arg.length <= 1) continue;
		if(arg[0] == sArgName) retval = arg[1];
	}
	return unescape(retval);
}

function page_load() {
	url = GetArgsFromHref(window.location.href,"url");
	//Tom.Hung 2013-5-7, security vulnerabilities
	if(url.charAt(0) != "/")
		top.location.href = "/";
	else
	//Tom.Hung 2013-5-7 end
	top.location.href = url;
}
</script>
<% language=javascript %>
</head>
<body onLoad="page_load();">
</body>
</html>