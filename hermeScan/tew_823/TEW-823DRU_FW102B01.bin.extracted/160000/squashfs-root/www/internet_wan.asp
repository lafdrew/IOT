<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html lang="en-US" xmlns="http://www.w3.org/1999/xhtml" xml:lang="en-US">
<head>
<title></title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<link href="/css/style.css" rel="stylesheet" type="text/css" />
<link href="/css/css_router.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="/uk_<!--# echo language -->.js"></script>
<script type="text/javascript" src="public_tew.js"></script>
<script type="text/javascript" src="public_msg.js"></script>
<script type="text/javascript" src="pandoraBox.js"></script>
<script type="text/javascript" src="js/jquery-1.3.2.min.js"></script>
<script type="text/javascript" src="js/xml.js"></script>
<script type="text/javascript" src="js/object.js"></script>
<script type="text/javascript" src="js/ddaccordion.js"></script>
<script type="text/javascript" src="js/ccpObject.js"></script>
<script type="text/javascript">
	var main = new ccpObject();
	
	main.get_config_obj();
	
function select_wan_page(){
	var html_file;
	var sel_wan = "<!--# echo wan_proto -->"; 
	switch(sel_wan)
	{
		case "static":
			html_file = "internet_wan_static.asp";
			break;
		case "dhcpc":
			html_file = "internet_wan_dhcp.asp";
			break;
		case "pppoe":
			if ( "<!--# echo wan_pppoe_russia_enable -->" == "1" )
				html_file = "internet_rus_wan_poe.asp";
			else
				html_file = "internet_wan_poe.asp";
			break;
		case "pptp":
			if ( "<!--# echo wan_pptp_russia_enable -->" == "1" )
				html_file = "internet_rus_wan_pptp.asp";
			else
				html_file = "internet_wan_pptp.asp";
			break;
		case "l2tp":
			if ( "<!--# echo wan_l2tp_russia_enable -->" == "1" )
				html_file = "internet_rus_wan_l2tp.asp";
			else
				html_file = "internet_wan_l2tp.asp";
			break;
		default:
			html_file = "internet_wan_dhcp.asp";
			break;
	}

	location.href = html_file;
}

</script>
</head>

<body>
</body>
<script>
	select_wan_page();
</script>
</html>
