<html>
<head>
<title>D-LINK CORPORATION, INC | WIRELESS ROUTER | HOME</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script type="text/javascript" src="/lang_<!--# echo language -->.js"></script>
<script type="text/javascript" src="/lang.js"></script>
<SCRIPT LANGUAGE="JavaScript">
function select_wan_page(){
var html_file;
var sel_wan = "<!--# echo wan_proto -->"; 
var russia_pptp_enable = "<!--# echo wan_pptp_russia_enable -->";
var russia_poe_enable = "<!--# echo wan_pppoe_russia_enable -->";
var russia_l2tp_enable = "<!--# echo wan_l2tp_russia_enable -->";

	if(sel_wan =="dhcpc"){
		html_file = "wan_dhcp.asp";
	}else if(sel_wan =="static"){
		html_file = "wan_static.asp";
	}else if(sel_wan =="pppoe"){
		if(russia_poe_enable == "1"){
			html_file = "wan_rus_poe.asp";
		}else{
			html_file = "wan_poe.asp";
		}
	}else if(sel_wan =="pptp"){
		if(russia_pptp_enable == "1"){
			html_file = "wan_rus_pptp.asp";
		}else{
			html_file = "wan_pptp.asp";
		}
	}else if(sel_wan =="l2tp"){
		if(russia_l2tp_enable == "1"){
			html_file = "wan_rus_l2tp.asp";
		}else{
		html_file = "wan_l2tp.asp";
		}
	}else if(sel_wan =="usb3g"){
		html_file = "wan_3G.asp";
	}else if(sel_wan =="usb3g_phone"){
		html_file = "wan_usb3G_phone.asp";
	}else if(sel_wan =="dslite"){
		html_file = "wan_dslite.asp";
	}else if(sel_wan =="mpppoe"){
		html_file = "wan_mpoe.asp";
	}else{
		html_file = "wan_bigpond.asp";
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
