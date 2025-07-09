<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en"><!-- InstanceBegin template="/Templates/advanced.dwt" codeOutsideHTMLIsLocked="false" -->
<head>
<meta http-equiv="content-type" content="text/html; charset=utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE8"/>

<title>TRENDnet | TEW-818DRU | <!--#tr id="project.desc"-->AC1900 Dual Band Wireless Router<!--#endtr--></title>
<!-- InstanceBeginEditable name="Page Title" -->

<!-- InstanceEndEditable -->

<link href="../style/frame.css" rel="stylesheet" type="text/css" media="screen" />
<link href="../style/style.css" rel="stylesheet" type="text/css" media="screen" />
<!-- InstanceBeginEditable name="Local Styles" -->
	<style type="text/css">
	/*
	 * Styles used only on this page.
	 */
	</style>
	<!-- InstanceEndEditable -->

<script type="text/javascript" src="../scripts/jquery.min.js"></script>
<script type="text/javascript" src="../scripts/ddaccordion.js"></script>
<script type="text/javascript" src="../scripts/um.js?20120904<% nvram_get("Language"); %>"></script>
<script type="text/javascript" src="../scripts/func.js?20120904<% nvram_get("Language"); %>"></script>
<script type="text/javascript" src="../scripts/overlib.js"></script>
<!-- InstanceBeginEditable name="Include Files" -->

	<!-- InstanceEndEditable -->
<script language="JavaScript" type="text/javascript">
var langset = "<% nvram_get("Language"); %>";
var lang = (langset=="")? "EN":langset;
function doLangSet() {
	document.getElementById("redirect_url").value = location.pathname;
	document.Lang.submit();
}

var DosCotrolItme = "<% getDoSDefined(); %>";

function expand_path()
{
	//Expand menu by pathname
	var path = location.pathname;
	if(dev_Wlmode == "psta") {
		//Expand menu by pathname
		if (path.indexOf("/adm/") > -1)
			ddaccordion.expandone('expandable2', 0);
		if (path.indexOf("/internet/") > -1)
			ddaccordion.expandone('expandable2', 1);
	} else {
		if (path.indexOf("/adm/") > -1)
			ddaccordion.expandone('expandable2', 0);
		if (path.indexOf("/internet/") > -1)
			ddaccordion.expandone('expandable2', 1);
		if((path.indexOf("/wireless/") > -1 || path.indexOf("/wps/") > -1) && "<% nvram_invmatch("wl_unit_if", "1", "0"); %>" == "0")
			ddaccordion.expandone('expandable2', 2);
		if((path.indexOf("/wireless/") > -1 || path.indexOf("/wps/") > -1) && "<% nvram_invmatch("wl_unit_if", "0", "1"); %>" == "1")
			ddaccordion.expandone('expandable2', 3);
		if(path.indexOf("/advanced/") > -1) {
			if(path.indexOf("access_control.asp") > -1 || path.indexOf("filter.asp") > -1)
				ddaccordion.expandone('expandable2', 4);
			else
				ddaccordion.expandone('expandable2', 5);
		}
		if(path.indexOf("/usb/") > -1)
			ddaccordion.expandone('expandable2', 6);
	}
}

function menu_adjust() {
	if (lang=="DE") {
	} else	if (lang=="FR") {
	} else	if (lang=="ESP") {
	} else	if (lang=="RU") {
		if(dev_Wlmode != "psta")
			document.getElementById("mainmenu_3").style.margin = "-12px 0px 0px 5px";
	}
}

var dev_Wlmode = "<% nvram_get("wl_mode"); %>";
function template_load() {
	expand_path();

	//Language default selection
	var i;
	var lang_element = document.getElementById("langSelection");
	for (i=0; i<lang_element.options.length; i++) {
		if (lang == lang_element.options[i].value) {
			lang_element.options.selectedIndex = i;
			break;
		}
	}
	page_load();
	menu_adjust();
}
</script>
<!-- InstanceBeginEditable name="Scripts" -->
<script language="JavaScript" type="text/javascript">
<!--
/*
#ifdef BCMVISTAROUTER                 
*/  
var ap = "<% nvram_match("router_disable", "1", "1"); %>";  
var ipv6_hint = "Sets the IPv6 Network Prefix for WAN.";

function macCloneMacFillSubmit()
{
    http_request = false;
    if (window.XMLHttpRequest) { // Mozilla, Safari,...
        http_request = new XMLHttpRequest();
        if (http_request.overrideMimeType) {
            http_request.overrideMimeType('text/xml');
        }
    } else if (window.ActiveXObject) { // IE
        try {
            http_request = new ActiveXObject("Msxml2.XMLHTTP");
        } catch (e) {
            try {
            http_request = new ActiveXObject("Microsoft.XMLHTTP");
            } catch (e) {}
        }
    }
    if (!http_request) {
        Alert.render('<!--#tr id="wan.alert.1"-->Cannot create an XMLHTTP instance<!--#endtr-->');
		//Alert.render(_("wan.alert.1"));
        return false;
    }
    http_request.onreadystatechange = doFillMyMAC;

    http_request.open('POST', '/getMyMAC.cgi', true);
    http_request.send('n\a');
}

function doFillMyMAC()
{
    if (http_request.readyState == 4) {
		if (http_request.status == 200) {
			document.getElementById("pppoeMacAddress").value = http_request.responseText;
			document.getElementById("pptpMacAddress").value = http_request.responseText;
			document.getElementById("l2tpMacAddress").value = http_request.responseText;
			document.getElementById("macAddress").value = http_request.responseText;	
		} else {
			Alert.render("<!--#tr id="wan.alert.2"-->Can\'t get the mac address.<!--#endtr-->");
			//Alert.render(_("wan.alert.2"));
		}
	}
}

function wan_ipv6_init()
{
	if (ap == "1") {
		ipv6_hint = "Currently IPv6 WAN Prefix is not effective. To Enable, Go to Basic Page and select the Router Mode."
		document.wan.wan_ipv6_prefix.disabled = 1;
	}
}
/*
#endif
*/
function wan_pppoe_demand_change()
{
	var wan_pppoe_demand = document.wan.wan_pppoe_demand[document.wan.wan_pppoe_demand.selectedIndex].value;

	if (wan_pppoe_demand == "1") {
		document.wan.wan_pppoe_idletime.disabled = 0;
		document.wan.wan_pppoe_keepalive.selectedIndex = 1;
	}
	else {
		document.wan.wan_pppoe_idletime.disabled = 1;
	}
}
function wan_pppoe_keepalive_change()
{
	var wan_pppoe_keepalive = document.wan.wan_pppoe_keepalive[document.wan.wan_pppoe_keepalive.selectedIndex].value;

	if (wan_pppoe_keepalive == "1") {
		document.wan.wan_pppoe_idletime.disabled = 1;
		document.wan.wan_pppoe_demand.selectedIndex = 1;
	}
}
/*
#ifdef __CONFIG_PPTP__                 
*/
function wan_pptp_demand_change()
{
	var wan_pptp_demand = document.wan.wan_pptp_demand[document.wan.wan_pptp_demand.selectedIndex].value;

	if (wan_pptp_demand == "1") {
		document.wan.wan_pptp_idletime.disabled = 0;
		document.wan.wan_pptp_keepalive.selectedIndex = 1;
	}
	else {
		document.wan.wan_pptp_idletime.disabled = 1;
	}
}
function wan_pptp_keepalive_change()
{
	var wan_pptp_keepalive = document.wan.wan_pptp_keepalive[document.wan.wan_pptp_keepalive.selectedIndex].value;

	if (wan_pptp_keepalive == "1") {
		document.wan.wan_pptp_idletime.disabled = 1;
		document.wan.wan_pptp_demand.selectedIndex = 1;
	}
}
function wan_pptp_static_change()
{
	var wan_pptp_static = document.wan.wan_pptp_static[document.wan.wan_pptp_static.selectedIndex].value;

	if (wan_pptp_static == "1") {
		document.wan.wan_pptp_localip.disabled = 0;
		document.wan.wan_pptp_netmask.disabled = 0;
		document.wan.wan_pptp_gateway.disabled = 0;
		document.wan.wan_pptp_dns0.disabled = 0;
		document.wan.wan_pptp_dns1.disabled = 0;
		//document.wan.wan_pptp_dns2.disabled = 0;
	} else {
		document.wan.wan_pptp_localip.disabled = 1;
		document.wan.wan_pptp_netmask.disabled = 1;
		document.wan.wan_pptp_gateway.disabled = 1;
		document.wan.wan_pptp_dns0.disabled = 1;
		document.wan.wan_pptp_dns1.disabled = 1;
		//document.wan.wan_pptp_dns2.disabled = 1;
	}
}
/*
#endif
*/
/*
#ifdef __CONFIG_L2TP__                 
*/
function wan_l2tp_demand_change()
{
	var wan_l2tp_demand = document.wan.wan_l2tp_demand[document.wan.wan_l2tp_demand.selectedIndex].value;

	if (wan_l2tp_demand == "1") {
		document.wan.wan_l2tp_idletime.disabled = 0;
		document.wan.wan_l2tp_keepalive.selectedIndex = 1;
	}
	else {
		document.wan.wan_l2tp_idletime.disabled = 1;
	}
}
function wan_l2tp_keepalive_change()
{
	var wan_l2tp_keepalive = document.wan.wan_l2tp_keepalive[document.wan.wan_l2tp_keepalive.selectedIndex].value;

	if (wan_l2tp_keepalive == "1") {
		document.wan.wan_l2tp_idletime.disabled = 1;
		document.wan.wan_l2tp_demand.selectedIndex = 1;
	}
}
function wan_l2tp_static_change()
{
	var wan_l2tp_static = document.wan.wan_l2tp_static[document.wan.wan_l2tp_static.selectedIndex].value;

	if (wan_l2tp_static == "1") {
		document.wan.wan_l2tp_ipaddr.disabled = 0;
		document.wan.wan_l2tp_netmask.disabled = 0;
		document.wan.wan_l2tp_gateway.disabled = 0;
		document.wan.wan_l2tp_dns0.disabled = 0;
		document.wan.wan_l2tp_dns1.disabled = 0;
		//document.wan.wan_l2tp_dns2.disabled = 0;
	} else {
		document.wan.wan_l2tp_ipaddr.disabled = 1;
		document.wan.wan_l2tp_netmask.disabled = 1;
		document.wan.wan_l2tp_gateway.disabled = 1;
		document.wan.wan_l2tp_dns0.disabled = 1;
		document.wan.wan_l2tp_dns1.disabled = 1;
		//document.wan.wan_l2tp_dns2.disabled = 1;
	}
}
/*
#endif
*/
function wan_proto_change()
{
	var wan_proto = document.wan.wan_proto[document.wan.wan_proto.selectedIndex].value;

	if (wan_proto == "pppoe") {
		document.getElementById("pppoe_div").style.visibility = "visible";
		document.getElementById("pppoe_div").style.display = "block";
		document.wan.wan_pppoe_username.disabled = 0;
		document.wan.wan_pppoe_passwd.disabled = 0;
		//document.wan.wan_pppoe_service.disabled = 0;
		//document.wan.wan_pppoe_ac.disabled = 0;
		document.wan.wan_pppoe_keepalive.disabled = 0;
		document.wan.wan_pppoe_demand.disabled = 0;
		document.wan.wan_pppoe_idletime.disabled = 0;
		document.wan.wan_pppoe_mru.disabled = 0;
		document.wan.wan_pppoe_mtu.disabled = 0;

		wan_pppoe_demand_change();
	} else {
		document.getElementById("pppoe_div").style.visibility = "hidden";
		document.getElementById("pppoe_div").style.display = "none";
		document.wan.wan_pppoe_username.disabled = 1;
		document.wan.wan_pppoe_passwd.disabled = 1;
		//document.wan.wan_pppoe_service.disabled = 1;
		//document.wan.wan_pppoe_ac.disabled = 1;
		document.wan.wan_pppoe_keepalive.disabled = 1;
		document.wan.wan_pppoe_demand.disabled = 1;
		document.wan.wan_pppoe_idletime.disabled = 1;
		document.wan.wan_pppoe_mru.disabled = 1;
		document.wan.wan_pppoe_mtu.disabled = 1;
	}
/*
#ifdef __CONFIG_PPTP__                 
*/
	if (wan_proto == "pptp") {
		document.getElementById("pptp_div").style.visibility = "visible";
		document.getElementById("pptp_div").style.display = "block";
		document.wan.wan_pptp_server_name.disabled = 0;
		document.wan.wan_pptp_static.disabled = 0;
		document.wan.wan_pptp_localip.disabled = 0;
		document.wan.wan_pptp_netmask.disabled = 0;
		document.wan.wan_pptp_gateway.disabled = 0;
		document.wan.wan_pptp_dns0.disabled = 0;
		document.wan.wan_pptp_dns1.disabled = 0;
		//document.wan.wan_pptp_dns2.disabled = 0;
		document.wan.wan_pptp_username.disabled = 0;
		document.wan.wan_pptp_passwd.disabled = 0;
		document.wan.wan_pptp_keepalive.disabled = 0;
		document.wan.wan_pptp_demand.disabled = 0;
		document.wan.wan_pptp_idletime.disabled = 0;
		document.wan.wan_pptp_mru.disabled = 0;
		document.wan.wan_pptp_mtu.disabled = 0;

		wan_pptp_demand_change();
		wan_pptp_static_change();
	} else {
		document.getElementById("pptp_div").style.visibility = "hidden";
		document.getElementById("pptp_div").style.display = "none";
		document.wan.wan_pptp_server_name.disabled = 1;
		document.wan.wan_pptp_static.disabled = 1;
		document.wan.wan_pptp_localip.disabled = 1;
		document.wan.wan_pptp_netmask.disabled = 1;
		document.wan.wan_pptp_gateway.disabled = 1;
		document.wan.wan_pptp_dns0.disabled = 1;
		document.wan.wan_pptp_dns1.disabled = 1;
		//document.wan.wan_pptp_dns2.disabled = 1;
		document.wan.wan_pptp_username.disabled = 1;
		document.wan.wan_pptp_passwd.disabled = 1;
		document.wan.wan_pptp_keepalive.disabled = 1;
		document.wan.wan_pptp_demand.disabled = 1;
		document.wan.wan_pptp_idletime.disabled = 1;
		document.wan.wan_pptp_mru.disabled = 1;
		document.wan.wan_pptp_mtu.disabled = 1;
	}
/*
#endif
*/
/*
#ifdef __CONFIG_L2TP__                 
*/
	if (wan_proto == "l2tp") {
		document.getElementById("l2tp_div").style.visibility = "visible";
		document.getElementById("l2tp_div").style.display = "block";
		document.wan.wan_l2tp_server_name.disabled = 0;
		document.wan.wan_l2tp_static.disabled = 0;
		document.wan.wan_l2tp_ipaddr.disabled = 0;
		document.wan.wan_l2tp_netmask.disabled = 0;
		document.wan.wan_l2tp_gateway.disabled = 0;
		document.wan.wan_l2tp_dns0.disabled = 0;
		document.wan.wan_l2tp_dns1.disabled = 0;
		//document.wan.wan_l2tp_dns2.disabled = 0;
		document.wan.wan_l2tp_username.disabled = 0;
		document.wan.wan_l2tp_passwd.disabled = 0;
		document.wan.wan_l2tp_keepalive.disabled = 0;
		document.wan.wan_l2tp_demand.disabled = 0;
		document.wan.wan_l2tp_idletime.disabled = 0;
		document.wan.wan_l2tp_mru.disabled = 0;
		document.wan.wan_l2tp_mtu.disabled = 0;

		wan_l2tp_demand_change();
		wan_l2tp_static_change();
	} else {
		document.getElementById("l2tp_div").style.visibility = "hidden";
		document.getElementById("l2tp_div").style.display = "none";
		document.wan.wan_l2tp_server_name.disabled = 1;
		document.wan.wan_l2tp_static.disabled = 1;
		document.wan.wan_l2tp_ipaddr.disabled = 1;
		document.wan.wan_l2tp_netmask.disabled = 1;
		document.wan.wan_l2tp_gateway.disabled = 1;
		document.wan.wan_l2tp_dns0.disabled = 1;
		document.wan.wan_l2tp_dns1.disabled = 1;
		//document.wan.wan_l2tp_dns2.disabled = 1;
		document.wan.wan_l2tp_username.disabled = 1;
		document.wan.wan_l2tp_passwd.disabled = 1;
		document.wan.wan_l2tp_keepalive.disabled = 1;
		document.wan.wan_l2tp_demand.disabled = 1;
		document.wan.wan_l2tp_idletime.disabled = 1;
		document.wan.wan_l2tp_mru.disabled = 1;
		document.wan.wan_l2tp_mtu.disabled = 1;
	}
/*
#endif
*/
	if (wan_proto == "static" || wan_proto == "dhcp") {
		document.getElementById("static_div").style.visibility = "visible";
		document.getElementById("static_div").style.display = "block";
		if (wan_proto == "static") {
			document.getElementById("static_title").innerHTML = "<!--#tr id="wan.ip.setting"-->WAN Interface IP Setting<!--#endtr-->";
			document.getElementById("wan_hostname_tr").style.visibility = "hidden";
			document.getElementById("wan_hostname_tr").style.display = "none";
			document.getElementById("wan_domain_tr").style.visibility = "hidden";
			document.getElementById("wan_domain_tr").style.display = "none";
			document.getElementById("hwaddr_tr").style.visibility = "visible";
			document.getElementById("hwaddr_tr").style.display = style_display_on_tr();
			document.getElementById("wan_ipaddr_tr").style.visibility = "visible";
			document.getElementById("wan_ipaddr_tr").style.display = style_display_on_tr();
			document.getElementById("wan_netmask_tr").style.visibility = "visible";
			document.getElementById("wan_netmask_tr").style.display = style_display_on_tr();
			document.getElementById("wan_gateway").style.visibility = "visible";
			document.getElementById("wan_gateway").style.display = style_display_on_tr();
			document.getElementById("wan_dns0_tr").style.visibility = "visible";
			document.getElementById("wan_dns0_tr").style.display = style_display_on_tr();
			document.getElementById("wan_dns1_tr").style.visibility = "visible";
			document.getElementById("wan_dns1_tr").style.display = style_display_on_tr();
			//document.getElementById("wan_dns2_tr").style.visibility = "visible";
			//document.getElementById("wan_dns2_tr").style.display = style_display_on_tr();
			document.getElementById("wan_wins0_tr").style.visibility = "hidden";
			document.getElementById("wan_wins0_tr").style.display = "none";
			document.getElementById("wan_wins1_tr").style.visibility = "hidden";
			document.getElementById("wan_wins1_tr").style.display = "none";
			document.getElementById("wan_wins2_tr").style.visibility = "hidden";
			document.getElementById("wan_wins2_tr").style.display = "none";
		} else {
			document.getElementById("static_title").innerHTML = "<!--#tr id="wan.dhcp.settings"-->DHCP Setting<!--#endtr-->";
			document.getElementById("wan_hostname_tr").style.visibility = "visible";
			document.getElementById("wan_hostname_tr").style.display = style_display_on_tr();
			document.getElementById("wan_domain_tr").style.visibility = "hidden";
			document.getElementById("wan_domain_tr").style.display = "none";
			document.getElementById("hwaddr_tr").style.visibility = "visible";
			document.getElementById("hwaddr_tr").style.display = style_display_on_tr();
			document.getElementById("wan_ipaddr_tr").style.visibility = "hidden";
			document.getElementById("wan_ipaddr_tr").style.display = "none";
			document.getElementById("wan_netmask_tr").style.visibility = "hidden";
			document.getElementById("wan_netmask_tr").style.display = "none";
			document.getElementById("wan_gateway").style.visibility = "hidden";
			document.getElementById("wan_gateway").style.display = "none";
			document.getElementById("wan_dns0_tr").style.visibility = "visible";
			document.getElementById("wan_dns0_tr").style.display = style_display_on_tr();
			document.getElementById("wan_dns1_tr").style.visibility = "visible";
			document.getElementById("wan_dns1_tr").style.display = style_display_on_tr();
			//document.getElementById("wan_dns2_tr").style.visibility = "visible";
			//document.getElementById("wan_dns2_tr").style.display = style_display_on_tr();
			document.getElementById("wan_wins0_tr").style.visibility = "hidden";
			document.getElementById("wan_wins0_tr").style.display = "none";
			document.getElementById("wan_wins1_tr").style.visibility = "hidden";
			document.getElementById("wan_wins1_tr").style.display = "none";
			document.getElementById("wan_wins2_tr").style.visibility = "hidden";
			document.getElementById("wan_wins2_tr").style.display = "none";
		}
	} else {
		document.getElementById("static_div").style.visibility = "hidden";
		document.getElementById("static_div").style.display = "none";
		document.getElementById("static_title").innerHTML = "<!--#tr id="wan.ip.setting"-->WAN Interface IP Setting<!--#endtr-->";
	}

	if (wan_proto != "static" && wan_proto != "disabled") {
		document.wan.wan_ipaddr.disabled = 1;
		document.wan.wan_domain.disabled = 1;
		document.wan.wan_netmask.disabled = 1;
		document.wan.wan_gateway.disabled = 1;
		//document.wan.wan_dns0.disabled = 1;
		//document.wan.wan_dns1.disabled = 1;
		//document.wan.wan_dns2.disabled = 1;
		document.wan.wan_dns0.disabled = 0;
		document.wan.wan_dns1.disabled = 0;
		//document.wan.wan_dns2.disabled = 0;
		document.wan.wan_wins0.disabled = 1;
		document.wan.wan_wins1.disabled = 1;
		document.wan.wan_wins2.disabled = 1;
	} else {
		document.wan.wan_ipaddr.disabled = 0;
		document.wan.wan_domain.disabled = 0;
		document.wan.wan_netmask.disabled = 0;
		document.wan.wan_gateway.disabled = 0;
		document.wan.wan_dns0.disabled = 0;
		document.wan.wan_dns1.disabled = 0;
		//document.wan.wan_dns2.disabled = 0;
		document.wan.wan_wins0.disabled = 0;
		document.wan.wan_wins1.disabled = 0;
		document.wan.wan_wins2.disabled = 0;
	}
/*
#ifdef BCMVISTAROUTER
*/ 
	//wan_ipv6_init();
/*
#endif
*/
}
function wan_ifname_change()
{
	var wan_ifname = document.wan.wan_ifname[document.wan.wan_ifname.selectedIndex];
	/* text attribute format: ifname (XX:XX:XX:XX:XX:XX) */
	document.wan.wan_hwaddr.value = wan_ifname.text.split(/\(/)[1].split(/\)/)[0];
}

/*
*  Afeter clicking apply button, it will trigger this function to check settings.
*  Accroding to different options, it will check their field values.
*  
*  Return :  If true, all fields is ok. Otherwise, some fileds settings is not ok.
*/
function applyCheck()
{
    var result = true;
    switch (document.getElementById("connetctionTypeSelector").selectedIndex)
    {
        case 0:
            result = checkDHCPSettings();
            break;
        case 1:
            result = checkStaticSettings();
            break;
        case 2:
            result = checkPPPOESettings();
            break;
        case 3:
            result = checkPPTPSettings();
            break;
        case 4:
            result = checkL2TPSettings();
            break;
        default :
    }

    if (!result)
    {
        return result;   
    }
	
	//Ryan 2015.01.12 add 
	// 1. When WAN mode from non (L2TP、PPTP) change to (L2TP、PPTP) mode, DUT need reboot and rmmod CTF
	// 2. When WAN mode from (L2TP、PPTP) change to non (L2TP、PPTP) mode, DUT need reboot and insmod CTF
	var current_select_wan_type = document.getElementById("connetctionTypeSelector").value;
	var previous_select_wan_type = "<% nvram_get("wan_proto"); %>";
	var need_reboot = "0";
	if (((current_select_wan_type == "l2tp")||(current_select_wan_type == "pptp")) && ((previous_select_wan_type != "l2tp") && (previous_select_wan_type != "pptp"))) {
		need_reboot = "1";
	} else if (((current_select_wan_type != "l2tp") && (current_select_wan_type != "pptp")) && ((previous_select_wan_type == "l2tp") || (previous_select_wan_type == "pptp"))) {
		need_reboot = "1";
	} else {
		need_reboot = "0";
	}
	document.wan.need_update_ctf.value= need_reboot;
	if (need_reboot) {
		totalWaitTime = 45;
	} else {
		totalWaitTime = 25;
	}
	
	wan_setting_NeedReboot = need_reboot;
	wan_setting_wait_page();
	document.getElementById("waitPad").style.display="block";
	scroll(0,0);
	return true;
}

function checkDHCPSettings()
{
    // 1. Check Host Name : only accept 0-9a-zA-Z_- characters for host name.
    if (!isBlankString(document.getElementById("dhcpHostName").value)) {
        var re = /^[\w\-\.]+$/;  
        if (!re.test(document.getElementById("dhcpHostName").value)) {
            Alert.render("<!--#tr id="wan.alert.4" -->Host Name only accept [0-9a-zA-Z_-.] characters.<!--#endtr -->");
            return false;
        }
    }
    
    // 2. Check Mac Address
    var macAddressElement = document.getElementById("macAddress");
    if (!isBlankString(macAddressElement.value) && !checkcloneMACAddr(macAddressElement.value)) {
        Alert.render("<!--#tr id="mac.address.error"-->Invalid MAC address! Please enter a valid MAC address.<!--#endtr-->");
        return false;
    }
    
    // 3. Check DNS Servers
    if (!checkDNS(document.getElementById("dnsSever1")) || 
        !checkDNS(document.getElementById("dnsSever2"))) {
        Alert.render("<!--#tr id="ip.address.error"-->Invalid IP address! Please enter a valid IP address.<!--#endtr-->");
        return false;
    }
    
    return true;
}

function checkStaticSettings()
{
    // 1. Check Mac Address
    var macAddressElement = document.getElementById("macAddress");
    if (!isBlankString(macAddressElement.value) && !checkcloneMACAddr(macAddressElement.value)) {
        Alert.render("<!--#tr id="mac.address.error"-->Invalid MAC address! Please enter a valid MAC address.<!--#endtr-->");
        return false;
    }
    
    // 2. Check IP Address
    if (!checkIpAddr(document.getElementById("staticIPAddress"), false)) {
        Alert.render("<!--#tr id="ip.address.error"-->Invalid IP address! Please enter a valid IP address.<!--#endtr-->");
        return false;
    }
    
    // 3. Check Subnet Mask
    if (!checkIpAddr(document.getElementById("staticSubnetMask"), true)) {
        Alert.render("<!--#tr id="ip.address.error"-->Invalid IP address! Please enter a valid IP address.<!--#endtr-->");
        return false;
    }
    
    // 4. Check Default Gateway
    if (!checkIpAddr(document.getElementById("staicDefaultGateway"), false)) {
        Alert.render("<!--#tr id="ip.address.error"-->Invalid IP address! Please enter a valid IP address.<!--#endtr-->");
        return false;
    }
    
    // 5. Check DNS Servers
     if (!checkDNS(document.getElementById("dnsSever1")) || 
         !checkDNS(document.getElementById("dnsSever2"))) {
        Alert.render("<!--#tr id="ip.address.error"-->Invalid IP address! Please enter a valid IP address.<!--#endtr-->");
        return false;
    }
    
    return true;
}

function checkPPPOESettings()
{
    // 1. Check User name
    if (isBlankString(document.getElementById("pppoeUserName").value)) {
        Alert.render("<!--#tr id="wan.alert.7" -->PPPoE user name is blank!<!--#endtr -->");
        return false;
    }
    
    // 2. Cheeck Password
    if (isBlankString(document.getElementById("pppoePassword").value)) {
        Alert.render("<!--#tr id="wan.alert.6" -->PPPoE password is blank!<!--#endtr -->");
        return false;
    }
    
    // 3. Check Max Idle Time when On Demand Mode is enabled.
    if (document.getElementById("pppoeDemandMode").selectedIndex == 0 && 
        !checkRange(document.getElementById("pppoeMaxIdleTime").value, 1, 3600)) {
        Alert.render("<!--#tr id="wan.alert.8"-->Please input the value of Max Idle Time between 1 and 3600<!--#endtr-->");
        return false;
    }
    
    // 4. Check MRU
    //if (!checkRange(document.getElementById("pppoeMru").value, 576, 1492)) {
    //    Alert.render("<!--#tr id="wan.alert.9"-->Please input the value of MRU between 576 and 1492<!--#endtr-->");
    //    return false;
    //}
    
    // 5. Check MTU
    if (!checkRange(document.getElementById("pppoeMtu").value, 576, 1492)) {
        Alert.render("<!--#tr id="wan.alert.10"-->Please input the value of MTU between 576 and 1492<!--#endtr-->");
        return false;
    }
    else
        document.getElementById("pppoeMru").value = document.getElementById("pppoeMtu").value;
    
    // 6. Check Mac Address
    var macAddressElement = document.getElementById("pppoeMacAddress");
    if (!isBlankString(macAddressElement.value) && !checkcloneMACAddr(macAddressElement.value)) {
        Alert.render("<!--#tr id="mac.address.error"-->Invalid MAC address! Please enter a valid MAC address.<!--#endtr-->");
        return false;
    }
    else {
        document.getElementById("macAddress").value = macAddressElement.value;
    }

    return true;
}

function checkPPTPSettings()
{		
	var serverElement = document.getElementById("pptpServerName");

	if (serverElement.value == "") {
		Alert.render("<!--#tr id="um.js.1" -->Error. IP address is empty.<!--#endtr -->");
		return false;
	}
	if (isAllNum(serverElement.value) == 0) {
		var reg = /[;,\"\'#&*()\\|`<> ]/;
		var reg2 = /(http\:\/\/)?/;
		
		if (reg.test(serverElement.value)) {
			serverElement.focus();
			Alert.render("<!--#tr id="url.error.invalid.2"-->The URL can't include the following characters<!--#endtr-->: ; , \" \' # & * ( ) \\ | ` < > ");
			return false;
		}		
		serverElement.value = serverElement.value.replace(reg2, "");
	}
	else {
		if (!checkIpAddr(serverElement, false)) {
			serverElement.focus();
			Alert.render("<!--#tr id="ip.address.error"-->Invalid IP address! Please enter a valid IP address.<!--#endtr-->");
			return false;
		}
	}

    // 1. When Protocol of Physical Connetion is static,
    //    Check IP Address, Subnet Gateway, Default Gateway, DNS Servers
    if (document.getElementById("pptpConnection").selectedIndex == 1) {

        var ipAddressElement = document.getElementById("pptpIPAddress");
        var subnetMaskElement = document.getElementById("pptpSubnetMask");
        var gatewayElement = document.getElementById("pptpDefaultGateway");
	var dnsElement1 = document.getElementById("pptpDnsServer1");
	var dnsElement2 = document.getElementById("pptpDnsServer2");
                
        // 1.1 Check IP Address

        var ipAddressFormat1 = /^[\w\-\.]+$/; 
        var ipAddressFormat2 = /^[\w\-\.]+\.[\w\-\.]+$/; 
        
		if (ipAddressElement.value.indexOf("\"") > -1) {
            ipAddressElement.focus();
			Alert.render("<!--#tr id="wan.alert.18" -->PPTP Server IP Address have invalid characters<!--#endtr --> \".");
			return false; 
		}
		else if (!ipAddressFormat1.test(ipAddressElement.value)) {
		    ipAddressElement.focus();
			Alert.render("<!--#tr id="wan.alert.19" -->PPTP Server IP Address only accept [0-9a-zA-Z_-.] characters.<!--#endtr -->");
			return false;
		}
		else if (!ipAddressFormat2.test(ipAddressElement.value)) {
		    ipAddressElement.focus();
			Alert.render("<!--#tr id="wan.alert.20" -->PPTP Server IP Address format incorrect!<!--#endtr -->");
			return false;
		}
		else if (!checkIpAddr(ipAddressElement, false)) {
		    ipAddressElement.focus();
            Alert.render("<!--#tr id="ip.address.error"-->Invalid IP address! Please enter a valid IP address.<!--#endtr-->");
            return false;
        }
		
		// 1.2 Check Subnet Mask
        if (!checkIpAddr(subnetMaskElement, true)) {
            subnetMaskElement.focus();
            Alert.render("<!--#tr id="ip.address.error"-->Invalid IP address! Please enter a valid IP address.<!--#endtr-->");
            return false;
        }
        
		// 1.3 Check Default Gateway
		if (!checkIpAddr(gatewayElement, false)) {
		    gatewayElement.focus();
            Alert.render("<!--#tr id="ip.address.error"-->Invalid IP address! Please enter a valid IP address.<!--#endtr-->");
            return false;
        }
        
		// 1.4 Check DNS Servers
		if (!checkDNS(dnsElement1) || 
		    !checkDNS(dnsElement2) || ((dnsElement1.value == "") && (dnsElement2.value == ""))) {
            Alert.render("<!--#tr id="ip.address.error"-->Invalid IP address! Please enter a valid IP address.<!--#endtr-->");
            return false;
        }
        
        // 1.5 Check the relation between IP Address and Subnet Mask
        if(!checkIPwithSubnetMask(ipAddressElement.value, subnetMaskElement.value)) {
            return false;
        }

        // 1.6 Check the relation between Default Gateway and Subnet Mask
        if(!checkIPwithSubnetMask(gatewayElement.value, subnetMaskElement.value)) {
            return false;
        }
        
        // 1.7 Check the IP, Subnet Mask and Gateway
        if(!checkSameSubnet(ipAddressElement.value, gatewayElement.value, subnetMaskElement.value )) {
            Alert.render("<!--#tr id="wan.alert.23" -->The PPTP IP address is not within the subnet of Gateway.<!--#endtr -->");
            return false;
        }
    }
    
    // 2. Check User name
    var userNameElement = document.getElementById("pptpUserName");
    if (isBlankString(userNameElement.value)) {
        Alert.render("<!--#tr id="wan.alert.24" -->PPTP user name is blank!<!--#endtr -->");
        return false;
    }
    else if (userNameElement.value.indexOf("\"") > -1) {
        Alert.render("<!--#tr id="wan.alert.21" -->PPTP Server User Name have invalid characters<!--#endtr --> \".");
        return false; 
    }

    // 3. Check password
    var passwordElement = document.getElementById("pptpPassword");
    if (isBlankString(passwordElement.value)) {
        Alert.render("<!--#tr id="wan.alert.25" -->PPTP password is blank!<!--#endtr -->");
        return false;
    }
    else if (passwordElement.value.indexOf("\"") > -1) {
        Alert.render("<!--#tr id="wan.alert.22" -->PPTP Server Password have invalid characters<!--#endtr --> \".");
        return false; 
    }
    
    // 4. Check Max Idle Time when On Demand Mode is enabled.
    if (document.getElementById("pptpDemandMode").selectedIndex == 0 && 
        !checkRange(document.getElementById("pptpMaxIdleTime").value, 1, 3600)) {
        Alert.render("<!--#tr id="wan.alert.8"-->Please input the value of Max Idle Time between 1 and 3600<!--#endtr-->");
        return false;
    }
    
    // 5. Check MRU
    //if (!checkRange(document.getElementById("pptpMru").value, 576, 1492)) {
    //    Alert.render("<!--#tr id="wan.alert.9"-->Please input the value of MRU between 576 and 1492<!--#endtr-->");
    //    return false;
    //}
    
    // 6. Check MTU
    if (!checkRange(document.getElementById("pptpMtu").value, 576, 1460)) {
        Alert.render("<!--#tr id="wan.alert.11"-->Please input the value of MTU between 576 and 1460<!--#endtr-->");
        return false;
    }
    else
        document.getElementById("pptpMru").value = document.getElementById("pptpMtu").value;
    
    // 7. Check Mac Address
    var macAddressElement = document.getElementById("pptpMacAddress");
    if (!isBlankString(macAddressElement.value) && !checkcloneMACAddr(macAddressElement.value)) {
        Alert.render("<!--#tr id="mac.address.error"-->Invalid MAC address! Please enter a valid MAC address.<!--#endtr-->");
        return false;
    }
    else {
        document.getElementById("macAddress").value = macAddressElement.value;
    }

    return true;
}

function checkL2TPSettings()
{
	var serverElement = document.getElementById("l2tpServerName");
	
	if (serverElement.value == "") {
		Alert.render("<!--#tr id="um.js.1" -->Error. IP address is empty.<!--#endtr -->");
		return false;
	}
	if (isAllNum(serverElement.value) == 0) {
		var reg = /[;,\"\'#&*()\\|`<> ]/;
		var reg2 = /(http\:\/\/)?/;
		
		if (reg.test(serverElement.value)) {
			serverElement.focus();
			Alert.render("<!--#tr id="url.error.invalid.2"-->The URL can't include the following characters<!--#endtr-->: ; , \" \' # & * ( ) \\ | ` < > ");
			return false;
		}		
		serverElement.value = serverElement.value.replace(reg2, "");
	}
	else {
		if (!checkIpAddr(serverElement, false)) {
			serverElement.focus();
			Alert.render("<!--#tr id="ip.address.error"-->Invalid IP address! Please enter a valid IP address.<!--#endtr-->");
			return false;
		}
	}
	
    // 1. When Protocol of Physical Connetion is static,
    //    Check IP Address, Subnet Gateway, Default Gateway, DNS Servers
    if (document.getElementById("l2tpConnection").selectedIndex == 1) {

		var ipAddressElement = document.getElementById("l2tpIPAddress");
        var subnetMaskElement = document.getElementById("l2tpSubnetMask");
        var gatewayElement = document.getElementById("l2tpDefaultGateway");
	var dnsElement1 = document.getElementById("l2tpDnsServer1");
	var dnsElement2 = document.getElementById("l2tpDnsServer2");
                
        // 1.1 Check IP Address

        var ipAddressFormat1 = /^[\w\-\.]+$/; 
        var ipAddressFormat2 = /^[\w\-\.]+\.[\w\-\.]+$/; 
		
		if (ipAddressElement.value.indexOf("\"") > -1) {
			Alert.render("<!--#tr id="wan.alert.26" -->L2TP Server IP Address have invalid characters<!--#endtr --> \".");
			return false; 
		}
		else if (!ipAddressFormat1.test(ipAddressElement.value)) {
			Alert.render("<!--#tr id="wan.alert.27" -->L2TP Server IP Address only accept [0-9a-zA-Z_-.] characters.<!--#endtr -->");
			return false;
		}
		else if (!ipAddressFormat2.test(ipAddressElement.value)) {
			Alert.render("<!--#tr id="wan.alert.28" -->L2TP Server IP Address format incorrect!<!--#endtr -->");
			return false;
		}
		else if (!checkIpAddr(ipAddressElement, false)) {
		    Alert.render("<!--#tr id="ip.address.error"-->Invalid IP address! Please enter a valid IP address.<!--#endtr-->");
            return false;
        }
		
		// 1.2 Check Subnet Mask
        if (!checkIpAddr(subnetMaskElement, true)) {
            Alert.render("<!--#tr id="ip.address.error"-->Invalid IP address! Please enter a valid IP address.<!--#endtr-->");
            return false;
        }
        
		// 1.3 Check Default Gateway
		if (!checkIpAddr(gatewayElement, false)) {
            Alert.render("<!--#tr id="ip.address.error"-->Invalid IP address! Please enter a valid IP address.<!--#endtr-->");
            return false;
        }
        
		// 1.4 Check DNS Servers
		if (!checkDNS(document.getElementById("l2tpDnsServer1")) || 
		    !checkDNS(document.getElementById("l2tpDnsServer2")) || ((dnsElement1.value == "") && (dnsElement2.value == ""))) {
            Alert.render("<!--#tr id="ip.address.error"-->Invalid IP address! Please enter a valid IP address.<!--#endtr-->");
            return false;
        }
        
        // 1.5 Check the relation between IP Address and Subnet Mask
        if(!checkIPwithSubnetMask(ipAddressElement.value, subnetMaskElement.value)) {
            return false;
        }

        // 1.6 Check the relation between Default Gateway and Subnet Mask
        if(!checkIPwithSubnetMask(gatewayElement.value, subnetMaskElement.value)) {
            return false;
        }
        
        // 1.7 Check the 
        if(!checkSameSubnet(ipAddressElement.value, gatewayElement.value, subnetMaskElement.value )) {
            Alert.render("<!--#tr id="wan.alert.23" -->The L2TP IP address is not within the subnet of Gateway.<!--#endtr -->");
            return false;
        }
    }
    
    // 2. Check User name
    var userNameElement = document.getElementById("l2tpUserName");
    if (isBlankString(userNameElement.value)) {
        Alert.render("<!--#tr id="wan.alert.29" -->L2TP user name is blank!<!--#endtr -->");
        return false;
    }
    else if (userNameElement.value.indexOf("\"") > -1) {
        Alert.render("<!--#tr id="wan.alert.30" -->L2TP Server User Name have invalid characters<!--#endtr --> \".");
        return false; 
    }

    // 3. Check password
    var passwordElement = document.getElementById("l2tpPassword");
    if (isBlankString(passwordElement.value)) {
        Alert.render("<!--#tr id="wan.alert.31" -->L2TP password is blank!<!--#endtr -->");
        return false;
    }
    else if (passwordElement.value.indexOf("\"") > -1) {
        Alert.render("<!--#tr id="wan.alert.32" -->L2TP Server Password have invalid characters<!--#endtr --> \".");
        return false; 
    }
    
    // 4. Check Max Idle Time when On Demand Mode is enabled.
    if (document.getElementById("l2tpDemandMode").selectedIndex == 0 && 
        !checkRange(document.getElementById("l2tpMaxIdleTime").value, 1, 3600)) {
        Alert.render("<!--#tr id="wan.alert.8"-->Please input the value of Max Idle Time between 1 and 3600<!--#endtr-->");
        return false;
    }
    
    // 5. Check MRU
    //if (!checkRange(document.getElementById("l2tpMru").value, 576, 1492)) {
    //    Alert.render("<!--#tr id="wan.alert.9"-->Please input the value of MRU between 576 and 1492<!--#endtr-->");
    //    return false;
    //}
    
    // 6. Check MTU
    if (!checkRange(document.getElementById("l2tpMtu").value, 576, 1460)) {
        Alert.render("<!--#tr id="wan.alert.11"-->Please input the value of MTU between 576 and 1460<!--#endtr-->");
        return false;
    }
    else
        document.getElementById("l2tpMru").value = document.getElementById("l2tpMtu").value;
    
    // 7. Check Mac Address
    var macAddressElement = document.getElementById("l2tpMacAddress");
    if (!isBlankString(macAddressElement.value) && !checkcloneMACAddr(macAddressElement.value)) {
        Alert.render("<!--#tr id="mac.address.error"-->Invalid MAC address! Please enter a valid MAC address.<!--#endtr-->");
        return false;
    }
    else {
        document.getElementById("macAddress").value = macAddressElement.value;
    }

    return true;
}

/*******************************************************************************
Check DNS Address. It allow blank ip.
If ok, return true. Otherwise, return false;
*******************************************************************************/
function checkDNS(dnsElement)
{
    if (isBlankString(dnsElement.value)) {
        return true;
    }
    else {
        return checkIpAddr(dnsElement, false);
    }
}

function page_load() {
	wan_proto_change();
}
//-->
</script>
<!-- InstanceEndEditable -->
</head>
<body onload="template_load();">
<div id="waitPad" style="display: none;" ></div>
<div id="dialogoverlay" style="display: none;"></div>
<div id="dialogbox" style="display: none;">
<table class="tbl_main" style="color: #FFF;" width="420px">
	<tr>
		<td class="CT" height="20px"></td>
	</tr>
	<tr style="vertical-align: middle;">
		<td class="CR" style="background: #4F5158" align="center">
			<br><span id="dialogboxbody">&nbsp;</span><br><br>
			<span id="dialogboxfoot"></span>
		</td>
	</tr>
</table>
</div>
<div class="wrapper"> 
<table width="100%" border="0"  cellpadding="0" cellspacing="0" >
	<tr>
		<td class="header">
			<table width="100%" border="0" cellpadding="0" cellspacing="0">
				<tr>
					<td class="header_1">
						<table border="0" cellpadding="0" cellspacing="0"  style="position:relative;width:920px; top:8px;" class="maintable">
							<tr>
								<td  valign="top"><img src="../images/logo.png" ></td>
								<td align="right"  valign="middle" nowrap="nowrap" class="description" style="width:600px; line-height:1.5em">
									<!--#tr id="project.desc"-->AC1900 Dual Band Wireless Router<!--#endtr-->
									<br>
              						TEW-818DRU
								</td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
		</td>
	</tr>
	<tr>
		<td>
<div class="dialog" style="margin-left:auto; margin-right:auto">
<div style="background-color: transparent;background-attachment: scroll;background-image: url(../images/bg_main2.png); background-position: right top; height: 40px;"><div></div></div>
<div style="background-color: transparent;background-repeat: repeat-y;background-attachment: scroll;background-image: url(../images/bg_main2_overlay.png);  background-position: right top;">
<div class="t"></div>
			<!--START MAIN TABLE -->
			<table border="0" cellpadding="0" cellspacing="0"  style="width:940px;">
				<tr>
					<td valign="top">
						<!--START LEFT NAVIGATION -->
<script>
ddaccordion.init({ //top level headers initialization
	headerclass: "expandable", //Shared CSS class name of headers group that are expandable
	contentclass: "categoryitems", //Shared CSS class name of contents group
	revealtype: "click", //Reveal content when user clicks or onmouseover the header? Valid value: "click", "clickgo", or "mouseover"
	mouseoverdelay: 200, //if revealtype="mouseover", set delay in milliseconds before header expands onMouseover
	collapseprev: true, //Collapse previous content (so only one open at any time)? true/false 
	defaultexpanded: [], //index of content(s) open by default [index1, index2, etc]. [] denotes no content
	onemustopen: true, //Specify whether at least one header should be open always (so never all headers closed)
	animatedefault: true, //Should contents open by default be animated into view?
	persiststate: true, //persist state of opened contents within browser session?
	toggleclass: ["", "openheader"], //Two CSS classes to be applied to the header when it's collapsed and expanded, respectively ["class1", "class2"]
	togglehtml: ["src", "", ""], //Additional HTML added to the header when it's collapsed and expanded, respectively  ["position", "html1", "html2"] (see docs)
	animatespeed: 200, //speed of animation: integer in milliseconds (ie: 200), or keywords "fast", "normal", or "slow"
	oninit:function(headers, expandedindices){ //custom code to run when headers have initalized
	},
	onopenclose:function(header, index, state, isuseractivated){ //custom code to run whenever a header is opened or closed
	}
})

ddaccordion.init({ //top level headers initialization
	headerclass: "expandable2", //Shared CSS class name of headers group that are expandable
	contentclass: "categoryitems", //Shared CSS class name of contents group
	revealtype: "click", //Reveal content when user clicks or onmouseover the header? Valid value: "click", "clickgo", or "mouseover"
	mouseoverdelay: 200, //if revealtype="mouseover", set delay in milliseconds before header expands onMouseover
	collapseprev: true, //Collapse previous content (so only one open at any time)? true/false 
	defaultexpanded: [], //index of content(s) open by default [index1, index2, etc]. [] denotes no content
	onemustopen: true, //Specify whether at least one header should be open always (so never all headers closed)
	animatedefault: false, //Should contents open by default be animated into view?
	persiststate: true, //persist state of opened contents within browser session?
	toggleclass: ["", "openheader"], //Two CSS classes to be applied to the header when it's collapsed and expanded, respectively ["class1", "class2"]
	togglehtml: ["src", "", ""], //Additional HTML added to the header when it's collapsed and expanded, respectively  ["position", "html1", "html2"] (see docs)
	animatespeed: 200, //speed of animation: integer in milliseconds (ie: 200), or keywords "fast", "normal", or "slow"
	oninit:function(headers, expandedindices){ //custom code to run when headers have initalized
	},
	onopenclose:function(header, index, state, isuseractivated){ //custom code to run whenever a header is opened or closed
	}
})

jQuery(function(){
     $(".img-swap").hover(
          function(){this.src = this.src.replace("_0","_2");},
          function(){this.src = this.src.replace("_2","_0");
     });
});
</script>

<!-- InstanceParam name="img_folder" type="text" value="../images/" -->

<div class="arrowlistmenu" style="padding-top: 0px">
	<script>
		if(dev_Wlmode != "psta") {
			document.write("<div class=\"homenav\" style=\"margin-bottom:20px\">"+
			"<a href=\"../basic/home.asp?expandable=0\"><img src=\"../images/but_basic_0<!--#tr id="image.lang.png"-->.png<!--#endtr-->\" style=\"float:left\" class=\"img-swap\" border=\"0\" /></a><a href=\"../adm/status.asp?expandable2=0\"><img src=\"../images/but_advance_1<!--#tr id="image.lang.png"-->.png<!--#endtr-->\" border=\"0\" /></a>"+
			"</div>"+
			"<div class=\"borderbottom\"> </div>"+
			"<div class=\"menuheader expandable2\" onclick=\"location.href='../adm/status.asp'\"> <img class=\"CatImage\" src=\"../images/but_administrator_0.png\"><span class=\"CatTitle\" id=\"mainmenu_1\"><!--#tr id="administrator"-->Administrator<!--#endtr--></span></div>"+
			"<ul class=\"categoryitems\">"+
				"<li><a onclick=\"location.href='../adm/management.asp'\"><!--#tr id="adm.node.management"-->Management<!--#endtr--></a></li>"+
				"<li><a onclick=\"location.href='../adm/upload_firmware.asp'\"><!--#tr id="adm.node.upload"-->Upload Firmware<!--#endtr--></a></li>"+
				"<li><a onclick=\"location.href='../adm/settings.asp'\"><!--#tr id="adm.node.settings"-->Settings Management<!--#endtr--></a></li>"+
				"<li><a onclick=\"location.href='../adm/time.asp'\"><!--#tr id="adm.node.time"-->Time<!--#endtr--></a></li>"+
				"<li><a onclick=\"location.href='../adm/schedule.asp'\"><!--#tr id="adv.node.schedule"-->Schedule<!--#endtr--></a></li>"+
				"<li><a onclick=\"location.href='../adm/status.asp'\"><!--#tr id="adm.node.routerstatus"-->Router Status<!--#endtr--></a></li>"+
				"<li><a onclick=\"location.href='../adm/ipv6status.asp'\"><!--#tr id="adm.node.ipv6.status"-->IPv6 Status<!--#endtr--></a></li>"+
				"<li><a onclick=\"location.href='../adm/syslog.asp'\"><!--#tr id="adm.node.system.log"-->System Log<!--#endtr--></a></li>"+
				"<li><a onclick=\"location.href='../adm/network.asp'\"><!--#tr id="adv.node.network"-->Advanced Network<!--#endtr--></a></li>"+
				"<li><a onclick=\"location.href='../adm/clientstatus.asp'\"><!--#tr id="adm.node.clientstatus"-->Client Status<!--#endtr--></a></li>"+
				"<li><a onclick=\"location.href='../adm/devicemode.asp'\"><!--#tr id="adm.node.devicemode"-->Device Mode<!--#endtr--></a></li>"+
			"</ul>"+
			"<div class=\"menuheader expandable2\" onclick=\"location.href='../internet/lan.asp'\"><img class=\"CatImage\" src=\"../images/but_setup_0.png\"><span class=\"CatTitle\" id=\"mainmenu_2\"><!--#tr id="setup"-->Setup<!--#endtr--></span></div>"+
			"<ul class=\"categoryitems\">"+
				"<li><a onclick=\"location.href='../internet/lan.asp'\"><!--#tr id="net.node.lan"-->LAN<!--#endtr--></a></li>"+
				"<li><a onclick=\"location.href='../internet/wan.asp'\"><!--#tr id="net.node.wan"-->WAN<!--#endtr--></a></li>"+
				"<li><a onclick=\"location.href='../internet/routing.asp'\"><!--#tr id="adv.node.routing"-->Routing<!--#endtr--></a></li>"+
				"<li><a onclick=\"location.href='../internet/ipv6.asp'\"><!--#tr id="net.node.ipv6"-->IPv6<!--#endtr--></a></li>"+
				"<li><a onclick=\"location.href='../internet/qos.asp'\"><!--#tr id="net.node.qos"-->QoS<!--#endtr--></a></li>"+
				"<li><a onclick=\"location.href='../wizard/wizard_internet.asp'\"><!--#tr id="wizard.node"-->Wizard<!--#endtr--></a></li>"+
				"<li><a onclick=\"location.href='../internet/vlan.asp'\"><!--#tr id="net.node.vlan"-->VLAN<!--#endtr--></a></li>"+
			"</ul>"+

			"<div class=\"menuheader expandable2\" onclick=\"location.href='../wireless/multissid.asp?wl_unit=0.1'\"> <img class=\"CatImage\" src=\"../images/but_wireless_24_0<!--#tr id="image.lang.png"-->.png<!--#endtr-->\"><span class=\"CatTitle\" id=\"mainmenu_3\"><!--#tr id="wireless.24g"-->Wireless 2.4GHz<!--#endtr--></span></div> "+
			"<ul class=\"categoryitems\">"+
				"<li><a onclick=\"location.href='../wireless/multissid.asp?wl_unit=0.1'\"><!--#tr id="wireless.node.multissid"-->Multiple SSID<!--#endtr--></a></li>"+
				"<li><a onclick=\"location.href='../wireless/wds.asp?wl_unit=0'\"><!--#tr id="wireless.node.wds"-->WDS<!--#endtr--></a></li>"+
				"<li><a onclick=\"location.href='../wireless/advanced.asp?wl_unit=0'\"><!--#tr id="wireless.node.adv"-->Advanced<!--#endtr--></a></li>"+
				"<li><a onclick=\"location.href='../wps/wps.asp?wl_unit=0'\"><!--#tr id="wireless.node.wps"-->WPS<!--#endtr--></a></li>"+
			"</ul>"+

			"<div class=\"menuheader expandable2\" onclick=\"location.href='../wireless/multissid.asp?wl_unit=1.1'\"> <img class=\"CatImage\" src=\"../images/but_wireless_5_0<!--#tr id="image.lang.png"-->.png<!--#endtr-->\"><span class=\"CatTitle\" id=\"mainmenu_4\"><!--#tr id="wireless.5g"-->Wireless 5GHz<!--#endtr--></span></div>"+ 
			"<ul class=\"categoryitems\">"+
				"<li><a onclick=\"location.href='../wireless/multissid.asp?wl_unit=1.1'\"><!--#tr id="wireless.node.multissid"-->Multiple SSID<!--#endtr--></a></li>"+
				"<li><a onclick=\"location.href='../wireless/wds.asp?wl_unit=1'\"><!--#tr id="wireless.node.wds"-->WDS<!--#endtr--></a></li>"+
				"<li><a onclick=\"location.href='../wireless/advanced.asp?wl_unit=1'\"><!--#tr id="wireless.node.adv"-->Advanced<!--#endtr--></a></li>"+
				"<li><a onclick=\"location.href='../wps/wps.asp?wl_unit=1'\"><!--#tr id="wireless.node.wps"-->WPS<!--#endtr--></a></li>"+
			"</ul>"+

			"<div class=\"menuheader expandable2\" onclick=\"location.href='../advanced/access_control.asp'\"> <img class=\"CatImage\" src=\"../images/but_security_0.png\"><span class=\"CatTitle\" id=\"mainmenu_5\"><!--#tr id="security"-->Security<!--#endtr--></span></div> "+
			"<ul class=\"categoryitems\">"+
				"<li><a onclick=\"location.href='../advanced/access_control.asp'\"><!--#tr id="adv.node.ac"-->Access Control<!--#endtr--></a></li>"+
			"</ul>"+

			"<div class=\"menuheader expandable2\" onclick=\"location.href='../advanced/dmz.asp'\"> <img class=\"CatImage\" src=\"../images/but_firewall_0.png\"><span class=\"CatTitle\" id=\"mainmenu_6\"><!--#tr id="firewall"-->Firewall<!--#endtr--></span></div>"+
			"<ul class=\"categoryitems\">"+
				"<li><a onclick=\"location.href='../advanced/dmz.asp'\"><!--#tr id="adv.node.dmz"-->DMZ<!--#endtr--></a></li>"+
				"<li><a onclick=\"location.href='../advanced/single_port.asp'\"><!--#tr id="adv.node.virtual.rules"-->Virtual Server<!--#endtr--></a></li>"+
				"<li><a onclick=\"location.href='../advanced/port_trigger.asp'\"><!--#tr id="adv.node.special.app"-->Special Applications<!--#endtr--></a></li>"+
				"<li><a onclick=\"location.href='../advanced/port_range.asp'\"><!--#tr id="adv.node.gaming"-->Gaming<!--#endtr--></a></li>"+
				"<li><a onclick=\"location.href='../advanced/alg.asp'\"><!--#tr id="adv.node.alg"-->ALG<!--#endtr--></a></li>"+
			"</ul>"+

			"<div class=\"menuheader expandable2\" onclick=\"location.href='../usb/samba.asp'\"> <img class=\"CatImage\" src=\"../images/but_usb_0.png\"><span class=\"CatTitle\" id=\"mainmenu_7\"><!--#tr id="usb"-->USB<!--#endtr--></span></div>"+
			"<ul class=\"categoryitems\">"+
				"<li><a onclick=\"location.href='../usb/samba.asp'\"><!--#tr id="usb.node.samba"-->Samba Server<!--#endtr--></a></li>"+
				"<li><a onclick=\"location.href='../usb/ftp.asp'\"><!--#tr id="usb.node.ftp"-->FTP Server<!--#endtr--></a></li>"+
				"<li><a onclick=\"location.href='../usb/ejectdevice.asp'\"><!--#tr id="usb.node.eject.device"-->Eject Device<!--#endtr--></a></li>"+
				"</ul>");
		}
		else {
			document.write("<div class=\"homenav\" style=\"margin-bottom:20px\">"+
													"<a href=\"../station/link_status.asp?expandable=0\"><img src=\"../images/but_basic_0<!--#tr id="image.lang.png"-->.png<!--#endtr-->\" style=\"float:left\" class=\"img-swap\" border=\"0\" /></a><a href=\"../adm/status.asp?expandable2=0\"><img src=\"../images/but_advance_1<!--#tr id="image.lang.png"-->.png<!--#endtr-->\" border=\"0\" /></a>"+
											"</div>"+
											"<div class=\"borderbottom\"> </div>"+
											"<div class=\"menuheader expandable2\" onclick=\"location.href='../adm/status.asp'\"> <img class=\"CatImage\" src=\"../images/but_administrator_0.png\"><span class=\"CatTitle\" id=\"mainmenu_1\"><!--#tr id="administrator"-->Administrator<!--#endtr--></span></div>"+
											"<ul class=\"categoryitems\">"+
													"<li><a onclick=\"location.href='../adm/management.asp'\"><!--#tr id="adm.node.management"-->Management<!--#endtr--></a></li>"+
													"<li><a onclick=\"location.href='../adm/upload_firmware.asp'\"><!--#tr id="adm.node.upload"-->Upload Firmware<!--#endtr--></a></li>"+
													"<li><a onclick=\"location.href='../adm/settings.asp'\"><!--#tr id="adm.node.settings"-->Settings Management<!--#endtr--></a></li>"+
													"<li><a onclick=\"location.href='../adm/time.asp'\"><!--#tr id="adm.node.time"-->Time<!--#endtr--></a></li>"+
													"<li><a onclick=\"location.href='../adm/status.asp'\"><!--#tr id="adm.node.routerstatus"-->Router Status<!--#endtr--></a></li>"+
													"<li><a onclick=\"location.href='../adm/syslog.asp'\"><!--#tr id="adm.node.system.log"-->System Log<!--#endtr--></a></li>"+
													"<li><a onclick=\"location.href='../adm/devicemode.asp'\"><!--#tr id="adm.node.devicemode"-->Device Mode<!--#endtr--></a></li>"+
											"</ul>"+
											"<div class=\"menuheader expandable2\" onclick=\"location.href='../internet/lan.asp'\"><img class=\"CatImage\" src=\"../images/but_setup_0.png\"><span class=\"CatTitle\" id=\"mainmenu_2\"><!--#tr id="setup"-->Setup<!--#endtr--></span></div>"+
											"<ul class=\"categoryitems\">"+
													"<li><a onclick=\"location.href='../internet/lan.asp'\"><!--#tr id="net.node.lan"-->LAN<!--#endtr--></a></li>"+
											"</ul>");
		}
	</script>
</div>
						<!--END LEFT NAVIGATION --> 
<script type="text/javascript" src="../scripts/xpmenu.js"></script>
					</td>
					<td style="width:650px; padding: 10px 0px 0px 15px; " valign="top" class="txt_main">
<iframe class="rebootRedirect" name="rebootRedirect" id="rebootRedirect" frameborder="0" width="1" height="1" scrolling="no" src="" style="display:none">redirect</iframe>
<div id="waitform"></div>
<div id="mainform">
	<div id="main_content">
	<!-- InstanceBeginEditable name="Main Content" -->
<table class="body"><tr><td>
<h1><!--#tr id="wan.title"-->Wide Area Network (WAN) Settings<!--#endtr--></h1>
<div class="hr" ></div>
<p>
<!--#tr id="wan.desc"-->You may choose different connection type suitable for your environment. Besides, you may also configure parameters according to the selected connection type.<!--#endtr-->
</p>

<form name="wan" method="post" action="/wan.asp" onSubmit="return applyCheck();" target="rebootRedirect">
<input type="hidden" name="page" value="/internet/wan.asp">
<input type="hidden" name="need_update_ctf" value="0">
<input type="hidden" name="token" value="<% genToken(); %>">

<div style="display:none">
<table width="100%" class="tbl_main">
	<tr>
		<td class="CT" colspan="3"><!--#tr id="wan.connect.type"-->WAN Connection Type<!--#endtr--></td>
	</tr>
	<tr>
		<td class="CL"
		onMouseOver="return overlib('Selects which WAN connection to configure.', LEFT);"
		onMouseOut="return nd();">
		Connection:&nbsp;&nbsp;
		</td>
		<td class="CR2">
			<select name="wan_unit" onChange="submit();">
				<% wan_list(); %>
			</select>
		</td>
		<td class="CR2">
			<button type="submit" name="action" value="Apply">Select</button>
		</td>
	</tr>    
</table>
</div>

<div style="display:none">
<table width="100%" class="tbl_main">
	<tr align="center">
		<td>
			<input type="submit" class="button1" name="action" value="New">
			<input type="submit" class="button1" name="action" value="Delete">
		</td>
	</tr>
</table>
</div>

<table width="100%" class="tbl_main">
	<tr>
		<td class="CT" colspan="2"><!--#tr id="wan.connect.type"-->WAN Connection Type<!--#endtr--></td>
	</tr>
	<tr style="display:none">
		<td class="CL"
		onMouseOver="return overlib('Sets the connection name.', LEFT);"
		onMouseOut="return nd();">
		Description:&nbsp;&nbsp;
		</td>
		<td class="CR">
			<input name="wan_desc" value="<% nvram_get("wan_desc"); %>">
		</td>
	</tr>
	<tr style="display:none">
		<td class="CL"
		onMouseOver="return overlib('Selects the interface used by the connection.', LEFT);"
		onMouseOut="return nd();">
		Interface:&nbsp;&nbsp;
		</td>
		<td class="CR">
			<select name="wan_ifname" onChange="wan_ifname_change();">
				<% wan_iflist(); %>
			</select>
		</td>
	</tr>
	<tr>
		<td class="CL"
		onMouseOver="return overlib('Sets the method to use to obtain an IP address for the connection.', LEFT);"
		onMouseOut="return nd();">
		<!--#tr id="wan.conn.type"-->Connection Type<!--#endtr-->
		</td>
		<td class="CR">
			<select id="connetctionTypeSelector" name="wan_proto" onChange="wan_proto_change();">
				<option value="dhcp" <% nvram_match("wan_proto", "dhcp", "selected"); %>><!--#tr id="wan.dhcp"-->DHCP<!--#endtr--></option>
				<option value="static" <% nvram_match("wan_proto", "static", "selected"); %>><!--#tr id="wan.static"-->Static<!--#endtr--></option>
				<option value="pppoe" <% nvram_match("wan_proto", "pppoe", "selected"); %>><!--#tr id="wan.pppoe"-->PPPoE<!--#endtr--></option>
<!--
#ifdef __CONFIG_PPTP__
-->
				<option value="pptp" <% nvram_match("wan_proto", "pptp", "selected"); %>><!--#tr id="wan.pptp"-->PPTP<!--#endtr--></option>
<!--
#endif
-->
<!--
#ifdef __CONFIG_L2TP__
-->
				<option value="l2tp" <% nvram_match("wan_proto", "l2tp", "selected"); %>><!--#tr id="wan.l2tp"-->L2TP<!--#endtr--></option>
<!--
#endif
-->
<!--
				<option value="disabled" <% nvram_match("wan_proto", "disabled", "selected"); %>><!--#tr id="disabled"-->Disabled<!--#endtr--></option>
-->
			</select>
		</td>
	</tr>
	<tr style="display:none">
		<td class="CL"
		onMouseOver="return overlib('Sets the connection to be primary.', LEFT);"
		onMouseOut="return nd();">
		Primary:&nbsp;&nbsp;
		</td>
		<td class="CR">
			<select name="wan_primary">
				<option value="1" <% nvram_match("wan_primary", "1", "selected"); %>><!--#tr id="yes"-->Yes<!--#endtr--></option>
				<option value="0" <% nvram_match("wan_primary", "0", "selected"); %>><!--#tr id="no"-->No<!--#endtr--></option>
			</select>
		</td>
	</tr>
</table>

<div id="static_div">
<table width="100%" class="tbl_main">
	<tr>
		<td class="CT" colspan="2"><span id="static_title"></span></td>
	</tr>
	<tr id="wan_hostname_tr">
		<td class="CL"
		onMouseOver="return overlib('Some ISPs require that a host name be provided when requesting an IP address through DHCP.', LEFT);"
		onMouseOut="return nd();">
		<!--#tr id="wan.hostname"-->Host Name (optional)<!--#endtr-->
		</td>
		<td class="CR">
			<input id="dhcpHostName" name="wan_hostname" maxlength="255" value="<% nvram_get("wan_hostname"); %>" onkeydown="return prevent_press_enter(event);">
		</td>
	</tr>
	<tr id="wan_domain_tr">
		<td class="CL"
		onMouseOver="return overlib('Sets the domain name to be provided to LAN clients who request an IP address through DHCP.', LEFT);"
		onMouseOut="return nd();">
		<!--#tr id="wan.domain.name"-->Domain Name<!--#endtr-->
		</td>
		<td class="CR">
			<input id="staticDomainName" name="wan_domain" value="<% nvram_get("wan_domain"); %>" onkeydown="return prevent_press_enter(event);">
		</td>
	</tr>
	<tr id="hwaddr_tr">
		<td class="CL"
		onMouseOver="return overlib('Some ISPs require that a specific MAC address be used. Also known as MAC address cloning, this feature allows you to set the MAC address of the WAN interface. The MAC address format is XX:XX:XX:XX:XX:XX.', LEFT);"
		onMouseOut="return nd();">
		<!--#tr id="mac.address"-->MAC Address<!--#endtr-->
		</td>
		<td class="CR">
			<input name="wan_hwaddr" id="macAddress" size="17" maxlength="17" value="<% nvram_get("wan_hwaddr"); %>" onkeydown="return prevent_press_enter(event);">&nbsp;&nbsp;(Ex: 00:11:22:33:44:55)
			</br></br>
			<input type="button" name="macCloneMacFill" id="macCloneMacFill" class="button_submit_NoWidth" value="<!--#tr id="wan.42"-->Clone Your PC's MAC Address<!--#endtr-->" onClick="macCloneMacFillSubmit();">
		</td>
	</tr>
	<tr id="wan_ipaddr_tr">
		<td class="CL"
		onMouseOver="return overlib('Sets the IP address of the connection.', LEFT);"
		onMouseOut="return nd();">
		<!--#tr id="ip.address"-->IP Address<!--#endtr-->
		</td>
		<td class="CR">
			<input id="staticIPAddress" name="wan_ipaddr" value="<% nvram_get("wan_ipaddr"); %>" size="15" maxlength="15" onkeydown="return prevent_press_enter(event);">
		</td>
	</tr>
	<tr id="wan_netmask_tr">
		<td class="CL"
		onMouseOver="return overlib('Sets the IP netmask of the connection.', LEFT);"
		onMouseOut="return nd();">
		<!--#tr id="subnet.mask"-->Subnet Mask<!--#endtr-->
		</td>
		<td class="CR">
			<input id="staticSubnetMask" name="wan_netmask" value="<% nvram_get("wan_netmask"); %>" size="15" maxlength="15" onkeydown="return prevent_press_enter(event);">
		</td>
	</tr>
	<tr id="wan_gateway">
		<td class="CL"
		onMouseOver="return overlib('Sets the IP address of the default gateway to use on the connection.', LEFT);"
		onMouseOut="return nd();">
		<!--#tr id="default.gateway"-->Default Gateway<!--#endtr-->
		</td>
		<td class="CR">
			<input id="staicDefaultGateway" name="wan_gateway" value="<% nvram_get("wan_gateway"); %>" size="15" maxlength="15" onkeydown="return prevent_press_enter(event);">
		</td>
	</tr>
	<tr id="wan_dns0_tr">
		<td class="CL" valign="top" rowspan="2"
		onMouseOver="return overlib('Sets the IP addresses of the DNS servers to use for resolving host names.', LEFT);"
		onMouseOut="return nd();">
		<input type="hidden" name="wan_dns" value="2">
		<!--#tr id="wan.dns.servers"-->DNS Servers<!--#endtr-->
		</td>
		<td class="CR">
			<input id="dnsSever1" name="wan_dns0" value="<% nvram_list("wan_dns", 0); %>" size="15" maxlength="15" onkeydown="return prevent_press_enter(event);">
		</td>
	</tr>
	<tr id="wan_dns1_tr">
		<td class="CR">
			<input id="dnsSever2" name="wan_dns1" value="<% nvram_list("wan_dns", 1); %>" size="15" maxlength="15" onkeydown="return prevent_press_enter(event);">
		</td>
	</tr>
	<tr id="wan_wins0_tr" style="display:none">
		<td class="CL" valign="top" rowspan="3"
		onMouseOver="return overlib('Sets the IP addresses of the WINS servers to use for resolving NetBIOS names.', LEFT);"
		onMouseOut="return nd();">
		<input type="hidden" name="wan_wins" value="3">
		WINS Servers
		</td>
		<td class="CR">
			<input name="wan_wins0" value="<% nvram_list("wan_wins", 0); %>" size="15" maxlength="15" onkeydown="return prevent_press_enter(event);">
		</td>
	</tr>
	<tr id="wan_wins1_tr" style="display:none">
		<td class="CR">
			<input name="wan_wins1" value="<% nvram_list("wan_wins", 1); %>" size="15" maxlength="15" onkeydown="return prevent_press_enter(event);">
		</td>
	</tr>
	<tr id="wan_wins2_tr" style="display:none">
		<td class="CR">
			<input name="wan_wins2" value="<% nvram_list("wan_wins", 2); %>" size="15" maxlength="15" onkeydown="return prevent_press_enter(event);">
		</td>
	</tr>
</table>
</div>

<div id="pppoe_div">
<table width="100%" class="tbl_main">
	<tr>
		<td class="CT" colspan="2"><!--#tr id="wan.ppoe.setting"-->PPPoE Setting<!--#endtr--></td>
	</tr>
	<tr>
		<td class="CL"
		onMouseOver="return overlib('Sets the username to use when authenticating with a PPPoE server.', LEFT);"
		onMouseOut="return nd();">
		<!--#tr id="wan.user.name"-->User Name<!--#endtr-->
		</td>
		<td class="CR">
			<input id="pppoeUserName" name="wan_pppoe_username" maxlength="255" value="<% nvram_get("wan_pppoe_username"); %>" onkeydown="return prevent_press_enter(event);">
		</td>
	</tr>
	<tr>
		<td class="CL"
		onMouseOver="return overlib('Sets the password to use when authenticating with a PPPoE server.', LEFT);"
		onMouseOut="return nd();">
		<!--#tr id="wan.password"-->Password<!--#endtr-->
		</td>
		<td class="CR">
			<input id="pppoePassword" name="wan_pppoe_passwd" maxlength="255" value="<% nvram_get("wan_pppoe_passwd"); %>" type="password" onkeydown="return prevent_press_enter(event);">
		</td>
	</tr>
	<tr style="display:none">
		<td class="CL"
		onMouseOver="return overlib('Sets the PPPoE service name. Required by some ISPs.', LEFT);"
		onMouseOut="return nd();">
		<!--#tr id="wan.service.name"-->Service Name<!--#endtr-->
		</td>
		<td class="CR">
			<input id="serviceName" name="wan_pppoe_service" maxlength="255" value="<% nvram_get("wan_pppoe_service"); %>" onkeydown="return prevent_press_enter(event);">
		</td>
	</tr>
	<tr style="display:none">
		<td class="CL"
		onMouseOver="return overlib('Sets the name of the PPPoE access concentrator. Required by some ISPs.', LEFT);"
		onMouseOut="return nd();">
		<!--#tr id="wan.access.concentrator"-->Access Concentrator<!--#endtr-->
		</td>
		<td class="CR">
			<input name="wan_pppoe_ac" maxlength="255" value="<% nvram_get("wan_pppoe_ac"); %>" onkeydown="return prevent_press_enter(event);">
		</td>
	</tr>
	<tr>
		<td class="CL"
		onMouseOver="return overlib('Sets whether the PPPoE link should be automatically disconnected if no traffic has been observed for the period specified by <b>PPPoE Max Idle Time</b>.', LEFT);"
		onMouseOut="return nd();">
		<!--#tr id="wan.demand.mode"-->On Demand Mode<!--#endtr-->
		</td>
		<td class="CR">
			<select id="pppoeDemandMode" name="wan_pppoe_demand" onChange="wan_pppoe_demand_change();">
				<option value="1" <% nvram_match("wan_pppoe_demand", "1", "selected"); %>><!--#tr id="enabled"-->Enabled<!--#endtr--></option>
				<option value="0" <% nvram_match("wan_pppoe_demand", "0", "selected"); %>><!--#tr id="disabled"-->Disabled<!--#endtr--></option>
			</select>
		</td>
	</tr>
	<tr>
		<td class="CL"
		onMouseOver="return overlib('Sets the number of seconds to wait before disconnecting the PPPoE link if <b>PPPoE Connect on Demand</b> is <b><!--#tr id="enabled"-->Enabled<!--#endtr--></b>.', LEFT);"
		onMouseOut="return nd();">
		<!--#tr id="wan.max.idle.time"-->Max Idle Time<!--#endtr-->
		</td>
		<td class="CR">
			<input id="pppoeMaxIdleTime" name="wan_pppoe_idletime" value="<% nvram_get("wan_pppoe_idletime"); %>" size="4" maxlength="4" onkeydown="return prevent_press_enter(event);">&nbsp;<!--#tr id="lan.11"-->(seconds)<!--#endtr-->
		</td>
	</tr>
	<tr>
		<td class="CL"
		onMouseOver="return overlib('Sets whether the PPPoE link should be automatically restored if it is lost. This setting has no effect if <b>PPPoE Connect on Demand</b> is <b><!--#tr id="enabled"-->Enabled<!--#endtr--></b>.', LEFT);"
		onMouseOut="return nd();">
		<!--#tr id="wan.keep.alive.mode"-->Keep Alive Mode<!--#endtr-->
		</td>
		<td class="CR">
			<select id="pppoeKeepAliveMode" name="wan_pppoe_keepalive" onChange="wan_pppoe_keepalive_change();">
				<option value="1" <% nvram_match("wan_pppoe_keepalive", "1", "selected"); %>><!--#tr id="enabled"-->Enabled<!--#endtr--></option>
				<option value="0" <% nvram_match("wan_pppoe_keepalive", "0", "selected"); %>><!--#tr id="disabled"-->Disabled<!--#endtr--></option>
			</select>
		</td>
	</tr>
	<tr style="display:none">
		<td class="CL"
		onMouseOver="return overlib('Sets the maximum number of bytes that the PPPoE interface will receive in a single Ethernet frame.', LEFT);"
		onMouseOut="return nd();">
		<!--#tr id="wan.mru"-->MRU<!--#endtr-->
		</td>
		<td class="CR">
			<input id="pppoeMru"  name="wan_pppoe_mru" value="<% nvram_get("wan_pppoe_mru"); %>" size="4" maxlength="4" onkeydown="return prevent_press_enter(event);">&nbsp;(<!--#tr id="bytes"-->bytes<!--#endtr-->)
		</td>
	</tr>
	<tr>
		<td class="CL"
		onMouseOver="return overlib('Sets the maximum number of bytes that the PPPoE interface will transmit in a single Ethernet frame.', LEFT);"
		onMouseOut="return nd();">
		<!--#tr id="wan.mtu"-->MTU<!--#endtr-->
		</td>
		<td class="CR">
			<input id="pppoeMtu" name="wan_pppoe_mtu" value="<% nvram_get("wan_pppoe_mtu"); %>" size="4" maxlength="4" onkeydown="return prevent_press_enter(event);">&nbsp;(<!--#tr id="bytes"-->bytes<!--#endtr-->)
		</td>
	</tr>
	<tr>
		<td class="CL"
		onMouseOver="return overlib('Some ISPs require that a specific MAC address be used. Also known as MAC address cloning, this feature allows you to set the MAC address of the WAN interface. The MAC address format is XX:XX:XX:XX:XX:XX.', LEFT);"
		onMouseOut="return nd();">
		<!--#tr id="mac.address"-->MAC Address<!--#endtr-->
		</td>
		<td class="CR">
			<input name="wan_pppoe_hwaddr" id="pppoeMacAddress" size="17" maxlength="17" value="<% nvram_get("wan_hwaddr"); %>" onkeydown="return prevent_press_enter(event);">&nbsp;&nbsp;(Ex: 00:11:22:33:44:55)
			</br></br>
			<input type="button" name="macCloneMacFill" id="macCloneMacFill" class="button_submit_NoWidth" value="<!--#tr id="wan.42"-->Clone Your PC's MAC Address<!--#endtr-->" onClick="macCloneMacFillSubmit();" >
		</td>
	</tr>
</table>
</div>

<!--
#ifdef __CONFIG_PPTP__
-->
<div id="pptp_div">
<table width="100%" class="tbl_main">
	<tr>
		<td class="CT" colspan="2"><!--#tr id="wan.pptp.setting"-->PPTP Setting<!--#endtr--></td>
	</tr>
	<tr>
		<td class="CL"
		onMouseOver="return overlib('Sets host name or IP address of destination.', LEFT);"
		onMouseOut="return nd();">
		<!--#tr id="wan.pptp.server"-->PPTP Server<!--#endtr-->
		</td>
		<td class="CR">
			<input id="pptpServerName" name="wan_pptp_server_name" maxlength="255" value="<% nvram_get("wan_pptp_server_name"); %>" onkeydown="return prevent_press_enter(event);">
		</td>
	</tr>
	<tr>
		<td class="CL"
		onMouseOver="return overlib('Sets the method to use to obtain an IP address for the PPTP connection.', LEFT);"
		onMouseOut="return nd();">
		<!--#tr id="wan.protocol.phy.con"-->Protocol of Physical Connection<!--#endtr-->
		</td>
		<td class="CR">
			<select id="pptpConnection" name="wan_pptp_static" onChange="wan_pptp_static_change();">
				<option value="0" <% nvram_match("wan_pptp_static", "0", "selected"); %>><!--#tr id="wan.dhcp"-->DHCP<!--#endtr--></option>
				<option value="1" <% nvram_match("wan_pptp_static", "1", "selected"); %>><!--#tr id="wan.static"-->Static<!--#endtr--></option>
			</select>
		</td>
	</tr>
	<tr>
		<td class="CL"
		onMouseOver="return overlib('Sets the IP address of the PPTP connection.', LEFT);"
		onMouseOut="return nd();">
		<!--#tr id="ip.address"-->IP Address<!--#endtr-->
		</td>
		<td class="CR">
			<input id="pptpIPAddress" name="wan_pptp_localip" value="<% nvram_get("wan_pptp_localip"); %>" size="15" maxlength="15" onkeydown="return prevent_press_enter(event);">
		</td>
	</tr>
	<tr>
		<td class="CL"
		onMouseOver="return overlib('Sets the IP netmask of the PPTP connection.', LEFT);"
		onMouseOut="return nd();">
		<!--#tr id="subnet.mask"-->Subnet Mask<!--#endtr-->
		</td>
		<td class="CR">
			<input id="pptpSubnetMask" name="wan_pptp_netmask" value="<% nvram_get("wan_pptp_netmask"); %>" size="15" maxlength="15" onkeydown="return prevent_press_enter(event);">
		</td>
	</tr>
	<tr>
		<td class="CL"
		onMouseOver="return overlib('Sets the IP address of the default gateway to use on the PPTP connection.', LEFT);"
		onMouseOut="return nd();">
		<!--#tr id="default.gateway"-->Default Gateway<!--#endtr-->
		</td>
		<td class="CR">
			<input id="pptpDefaultGateway" name="wan_pptp_gateway" value="<% nvram_get("wan_pptp_gateway"); %>" size="15" maxlength="15" onkeydown="return prevent_press_enter(event);">
		</td>
	</tr>
	<tr>
		<td class="CL" valign="top" rowspan="2"
		onMouseOver="return overlib('Sets the IP addresses of the DNS servers to use for resolving host names.', LEFT);"
		onMouseOut="return nd();">
		<input type="hidden" name="wan_pptp_dns" value="2">
		<!--#tr id="wan.dns.servers"-->DNS Servers<!--#endtr-->
		</td>
		<td class="CR">
			<input id="pptpDnsServer1" name="wan_pptp_dns0" value="<% nvram_get("wan_pptp_dns0"); %>" size="15" maxlength="15" onkeydown="return prevent_press_enter(event);">
		</td>
	</tr>
	<tr>
		<td class="CR">
			<input id="pptpDnsServer2" name="wan_pptp_dns1" value="<% nvram_get("wan_pptp_dns1"); %>" size="15" maxlength="15" onkeydown="return prevent_press_enter(event);">
		</td>
	</tr>
	<tr>
		<td class="CL"
		onMouseOver="return overlib('Sets the username to use when authenticating with a PPTP server.', LEFT);"
		onMouseOut="return nd();">
		<!--#tr id="wan.user.name"-->User Name<!--#endtr-->
		</td>
		<td class="CR">
			<input id="pptpUserName" name="wan_pptp_username" maxlength="255" value="<% nvram_get("wan_pptp_username"); %>" onkeydown="return prevent_press_enter(event);">
		</td>
	</tr>
	<tr>
		<td class="CL"
		onMouseOver="return overlib('Sets the password to use when authenticating with a PPTP server.', LEFT);"
		onMouseOut="return nd();">
		<!--#tr id="wan.password"-->Password<!--#endtr-->
		</td>
		<td class="CR">
			<input id="pptpPassword" name="wan_pptp_passwd" maxlength="255" value="<% nvram_get("wan_pptp_passwd"); %>" type="password" onkeydown="return prevent_press_enter(event);">
		</td>
	</tr>
	<tr>
		<td class="CL"
		onMouseOver="return overlib('Sets whether the PPTP link should be automatically disconnected if no traffic has been observed for the period specified by <b>PPPoE Max Idle Time</b>.', LEFT);"
		onMouseOut="return nd();">
		<!--#tr id="wan.demand.mode"-->On Demand Mode<!--#endtr-->
		</td>
		<td class="CR">
			<select id="pptpDemandMode" name="wan_pptp_demand" onChange="wan_pptp_demand_change();">
				<option value="1" <% nvram_match("wan_pptp_demand", "1", "selected"); %>><!--#tr id="enabled"-->Enabled<!--#endtr--></option>
				<option value="0" <% nvram_match("wan_pptp_demand", "0", "selected"); %>><!--#tr id="disabled"-->Disabled<!--#endtr--></option>
			</select>
		</td>
	</tr>
	<tr>
		<td class="CL"
		onMouseOver="return overlib('Sets the number of seconds to wait before disconnecting the PPTP link if <b>PPTP Connect on Demand</b> is <b><!--#tr id="enabled"-->Enabled<!--#endtr--></b>.', LEFT);"
		onMouseOut="return nd();">
		<!--#tr id="wan.max.idle.time"-->Max Idle Time<!--#endtr-->
		</td>
		<td class="CR">
			<input id="pptpMaxIdleTime" name="wan_pptp_idletime" value="<% nvram_get("wan_pptp_idletime"); %>" size="4" maxlength="4" onkeydown="return prevent_press_enter(event);">&nbsp;<!--#tr id="lan.11"-->(seconds)<!--#endtr-->
		</td>
	</tr>
	<tr>
		<td class="CL"
		onMouseOver="return overlib('Sets whether the PPTP link should be automatically restored if it is lost. This setting has no effect if <b>PPTP Connect on Demand</b> is <b><!--#tr id="enabled"-->Enabled<!--#endtr--></b>.', LEFT);"
		onMouseOut="return nd();">
		<!--#tr id="wan.keep.alive.mode"-->Keep Alive Mode<!--#endtr-->
		</td>
		<td class="CR">
			<select name="wan_pptp_keepalive" onChange="wan_pptp_keepalive_change();">
				<option value="1" <% nvram_match("wan_pptp_keepalive", "1", "selected"); %>><!--#tr id="enabled"-->Enabled<!--#endtr--></option>
				<option value="0" <% nvram_match("wan_pptp_keepalive", "0", "selected"); %>><!--#tr id="disabled"-->Disabled<!--#endtr--></option>
			</select>
		</td>
	</tr>
	<tr style="display:none">
		<td class="CL"
		onMouseOver="return overlib('Sets the maximum number of bytes that the PPTP interface will receive in a single Ethernet frame.', LEFT);"
		onMouseOut="return nd();">
		<!--#tr id="wan.mru"-->MRU<!--#endtr-->
		</td>
		<td class="CR">
			<input id="pptpMru" name="wan_pptp_mru" value="<% nvram_get("wan_pptp_mru"); %>" size="4" maxlength="4" onkeydown="return prevent_press_enter(event);">&nbsp;(<!--#tr id="bytes"-->bytes<!--#endtr-->)
		</td>
	</tr>
	<tr>
		<td class="CL"
		onMouseOver="return overlib('Sets the maximum number of bytes that the PPTP interface will transmit in a single Ethernet frame.', LEFT);"
		onMouseOut="return nd();">
		<!--#tr id="wan.mtu"-->MTU<!--#endtr-->
		</td>
		<td class="CR">
			<input id="pptpMtu" name="wan_pptp_mtu" value="<% nvram_get("wan_pptp_mtu"); %>" size="4" maxlength="4" onkeydown="return prevent_press_enter(event);">&nbsp;(<!--#tr id="bytes"-->bytes<!--#endtr-->)
		</td>
	</tr>
	<tr>
		<td class="CL"
		onMouseOver="return overlib('Some ISPs require that a specific MAC address be used. Also known as MAC address cloning, this feature allows you to set the MAC address of the WAN interface. The MAC address format is XX:XX:XX:XX:XX:XX.', LEFT);"
		onMouseOut="return nd();">
		<!--#tr id="mac.address"-->MAC Address<!--#endtr-->
		</td>
		<td class="CR">
			<input name="wan_pptp_hwaddr" id="pptpMacAddress" size="17" maxlength="17" value="<% nvram_get("wan_hwaddr"); %>" onkeydown="return prevent_press_enter(event);">&nbsp;&nbsp;(Ex: 00:11:22:33:44:55)
			</br></br>
			<input type="button" name="macCloneMacFill" id="macCloneMacFill" class="button_submit_NoWidth" value="<!--#tr id="wan.42"-->Clone Your PC's MAC Address<!--#endtr-->" onClick="macCloneMacFillSubmit();" >
		</td>
	</tr>
</table>
</div>
<!--
#endif
-->

<!--
#ifdef __CONFIG_L2TP__
-->
<div id="l2tp_div">
<table width="100%" class="tbl_main">
	<tr>
		<td class="CT" colspan="2"><!--#tr id="wan.l2tp.setting"-->L2TP Setting<!--#endtr--></td>
	</tr>
	<tr>
		<td class="CL"
		onMouseOver="return overlib('Sets host name or IP address of destination.', LEFT);"
		onMouseOut="return nd();">
		<!--#tr id="wan.l2tp.server"-->L2TP Server<!--#endtr-->
		</td>
		<td class="CR">
			<input id="l2tpServerName" name="wan_l2tp_server_name" value="<% nvram_get("wan_l2tp_server_name"); %>" onkeydown="return prevent_press_enter(event);">
		</td>
	</tr>
	<tr>
		<td class="CL"
		onMouseOver="return overlib('Sets the method to use to obtain an IP address for the L2TP connection.', LEFT);"
		onMouseOut="return nd();">
		<!--#tr id="wan.protocol.phy.con"-->Protocol of Physical Connection<!--#endtr-->
		</td>
		<td class="CR">
			<select id="l2tpConnection" name="wan_l2tp_static" onChange="wan_l2tp_static_change();">
				<option value="0" <% nvram_match("wan_l2tp_static", "0", "selected"); %>><!--#tr id="wan.dhcp"-->DHCP<!--#endtr--></option>
				<option value="1" <% nvram_match("wan_l2tp_static", "1", "selected"); %>><!--#tr id="wan.static"-->Static<!--#endtr--></option>
			</select>
		</td>
	</tr>
	<tr>
		<td class="CL"
		onMouseOver="return overlib('Sets the IP address of the L2TP connection.', LEFT);"
		onMouseOut="return nd();">
		<!--#tr id="ip.address"-->IP Address<!--#endtr-->
		</td>
		<td class="CR">
			<input id="l2tpIPAddress" name="wan_l2tp_ipaddr" value="<% nvram_get("wan_l2tp_ipaddr"); %>" size="15" maxlength="15" onkeydown="return prevent_press_enter(event);">
		</td>
	</tr>
	<tr>
		<td class="CL"
		onMouseOver="return overlib('Sets the IP netmask of the L2TP connection.', LEFT);"
		onMouseOut="return nd();">
		<!--#tr id="subnet.mask"-->Subnet Mask<!--#endtr-->
		</td>
		<td class="CR">
			<input id="l2tpSubnetMask" name="wan_l2tp_netmask" value="<% nvram_get("wan_l2tp_netmask"); %>" size="15" maxlength="15" onkeydown="return prevent_press_enter(event);">
		</td>
	</tr>
	<tr>
		<td class="CL"
		onMouseOver="return overlib('Sets the IP address of the default gateway to use on the L2TP connection.', LEFT);"
		onMouseOut="return nd();">
		<!--#tr id="default.gateway"-->Default Gateway<!--#endtr-->
		</td>
		<td class="CR">
			<input id="l2tpDefaultGateway" name="wan_l2tp_gateway" value="<% nvram_get("wan_l2tp_gateway"); %>" size="15" maxlength="15" onkeydown="return prevent_press_enter(event);">
		</td>
	</tr>
	<tr>
		<td class="CL" valign="top" rowspan="2"
		onMouseOver="return overlib('Sets the IP addresses of the DNS servers to use for resolving host names.', LEFT);"
		onMouseOut="return nd();">
		<input type="hidden" name="wan_l2tp_dns" value="2">
		<!--#tr id="wan.dns.servers"-->DNS Servers<!--#endtr-->
		</td>
		<td class="CR">
			<input id="l2tpDnsServer1" name="wan_l2tp_dns0" value="<% nvram_get("wan_l2tp_dns0"); %>" size="15" maxlength="15" onkeydown="return prevent_press_enter(event);">
		</td>
	</tr>
	<tr>
		<td class="CR">
			<input id="l2tpDnsServer2" name="wan_l2tp_dns1" value="<% nvram_get("wan_l2tp_dns1"); %>" size="15" maxlength="15" onkeydown="return prevent_press_enter(event);">
		</td>
	</tr>
	<tr>
		<td class="CL"
		onMouseOver="return overlib('Sets the username to use when authenticating with a L2TP server.', LEFT);"
		onMouseOut="return nd();">
		<!--#tr id="wan.user.name"-->User Name<!--#endtr-->
		</td>
		<td class="CR">
			<input id="l2tpUserName" name="wan_l2tp_username" value="<% nvram_get("wan_l2tp_username"); %>" onkeydown="return prevent_press_enter(event);">
		</td>
	</tr>
	<tr>
		<td class="CL"
		onMouseOver="return overlib('Sets the password to use when authenticating with a L2TP server.', LEFT);"
		onMouseOut="return nd();">
		<!--#tr id="wan.password"-->Password<!--#endtr-->
		</td>
		<td class="CR">
			<input id="l2tpPassword" name="wan_l2tp_passwd" value="<% nvram_get("wan_l2tp_passwd"); %>" type="password" onkeydown="return prevent_press_enter(event);">
		</td>
	</tr>
	<tr>
		<td class="CL"
		onMouseOver="return overlib('Sets whether the L2TP link should be automatically disconnected if no traffic has been observed for the period specified by <b>PPPoE Max Idle Time</b>.', LEFT);"
		onMouseOut="return nd();">
		<!--#tr id="wan.demand.mode"-->On Demand Mode<!--#endtr-->
		</td>
		<td class="CR">
			<select id="l2tpDemandMode" name="wan_l2tp_demand" onChange="wan_l2tp_demand_change();">
				<option value="1" <% nvram_match("wan_l2tp_demand", "1", "selected"); %>><!--#tr id="enabled"-->Enabled<!--#endtr--></option>
				<option value="0" <% nvram_match("wan_l2tp_demand", "0", "selected"); %>><!--#tr id="disabled"-->Disabled<!--#endtr--></option>
			</select>
		</td>
	</tr>
	<tr>
		<td class="CL"
		onMouseOver="return overlib('Sets the number of seconds to wait before disconnecting the PPTP link if <b>L2TP Connect on Demand</b> is <b><!--#tr id="enabled"-->Enabled<!--#endtr--></b>.', LEFT);"
		onMouseOut="return nd();">
		<!--#tr id="wan.max.idle.time"-->Max Idle Time<!--#endtr-->
		</td>
		<td class="CR">
			<input id="l2tpMaxIdleTime" name="wan_l2tp_idletime" value="<% nvram_get("wan_l2tp_idletime"); %>" size="4" maxlength="4" onkeydown="return prevent_press_enter(event);">&nbsp;<!--#tr id="lan.11"-->(seconds)<!--#endtr-->
		</td>
	</tr>
	<tr>
		<td class="CL"
		onMouseOver="return overlib('Sets whether the L2TP link should be automatically restored if it is lost. This setting has no effect if <b>PPTP Connect on Demand</b> is <b><!--#tr id="enabled"-->Enabled<!--#endtr--></b>.', LEFT);"
		onMouseOut="return nd();">
		<!--#tr id="wan.keep.alive.mode"-->Keep Alive Mode<!--#endtr-->
		</td>
		<td class="CR">
			<select name="wan_l2tp_keepalive" onChange="wan_l2tp_keepalive_change();">
				<option value="1" <% nvram_match("wan_l2tp_keepalive", "1", "selected"); %>><!--#tr id="enabled"-->Enabled<!--#endtr--></option>
				<option value="0" <% nvram_match("wan_l2tp_keepalive", "0", "selected"); %>><!--#tr id="disabled"-->Disabled<!--#endtr--></option>
			</select>
		</td>
	</tr>
	<tr style="display:none">
		<td class="CL"
		onMouseOver="return overlib('Sets the maximum number of bytes that the L2TP interface will receive in a single Ethernet frame.', LEFT);"
		onMouseOut="return nd();">
		<!--#tr id="wan.mru"-->MRU<!--#endtr-->
		</td>
		<td class="CR">
			<input id="l2tpMru" name="wan_l2tp_mru" value="<% nvram_get("wan_l2tp_mru"); %>" size="4" maxlength="4" onkeydown="return prevent_press_enter(event);">&nbsp;(<!--#tr id="bytes"-->bytes<!--#endtr-->)
		</td>
	</tr>
	<tr>
		<td class="CL"
		onMouseOver="return overlib('Sets the maximum number of bytes that the L2TP interface will transmit in a single Ethernet frame.', LEFT);"
		onMouseOut="return nd();">
		<!--#tr id="wan.mtu"-->MTU<!--#endtr-->
		</td>
		<td class="CR">
			<input id="l2tpMtu" name="wan_l2tp_mtu" value="<% nvram_get("wan_l2tp_mtu"); %>" size="4" maxlength="4" onkeydown="return prevent_press_enter(event);">&nbsp;(<!--#tr id="bytes"-->bytes<!--#endtr-->)
		</td>
	</tr>
	<tr>
		<td class="CL"
		onMouseOver="return overlib('Some ISPs require that a specific MAC address be used. Also known as MAC address cloning, this feature allows you to set the MAC address of the WAN interface. The MAC address format is XX:XX:XX:XX:XX:XX.', LEFT);"
		onMouseOut="return nd();">
		<!--#tr id="mac.address"-->MAC Address<!--#endtr-->
		</td>
		<td class="CR">
			<input name="wan_l2tp_hwaddr" id="l2tpMacAddress" size="17" maxlength="17" value="<% nvram_get("wan_hwaddr"); %>" onkeydown="return prevent_press_enter(event);">&nbsp;&nbsp;(Ex: 00:11:22:33:44:55)
			</br></br>
			<input type="button" name="macCloneMacFill" id="macCloneMacFill" class="button_submit_NoWidth" value="<!--#tr id="wan.42"-->Clone Your PC's MAC Address<!--#endtr-->" onClick="macCloneMacFillSubmit();" >
		</td>
	</tr>
</table>
</div>
<!--
#endif
-->

<div style="display:none">
<table width="100%" class="tbl_main">
	<tr>
		<td class="CT" colspan="2"><!--#tr id="wan.status"-->WAN Status<!--#endtr--></td>
	</tr>
	<tr>
		<td class="CL"
		onMouseOver="return overlib('Shows the state of the connection.', LEFT);"
		onMouseOut="return nd();">
		<!--#tr id="wan.connection.status"-->Connection Status<!--#endtr-->
		</td>
		<td class="CR"><% wan_link(); %></td>
	</tr>
	<tr>
		<td class="CL"
		onMouseOver="return overlib('Shows the IP address lease info.', LEFT);"
		onMouseOut="return nd();">
		<!--#tr id="wan.address.expires.in"-->IP Address Expires In<!--#endtr-->
		</td>
		<td class="CR"><% wan_lease(); %></td>
	</tr>
</table>
</div>

<div>
<table width="100%" class="tbl_main">
	<tr align="center">
		<td>
			<input type="submit" class="<!--#tr id="buttonWidth"-->button1<!--#endtr-->" name="action" value="<!--#tr id="apply"-->Apply<!--#endtr-->">
			<input type="reset" class="button1" name="action" value="<!--#tr id="cancel"-->Cancel<!--#endtr-->">
		</td>
	</tr>
</table>
</div>
</form>

</td></tr></table>
	<!-- InstanceEndEditable -->
	</div>
</div>
					</td>
				</tr>
			</table>
    		<!--END MAIN TABLE -->
</div>
<div style="background-color: transparent;background-attachment: scroll;background-image: url(../images/bg_main2.png); background-position: right bottom; height: 50px;"><div></div></div>
</div>
		</td>
	</tr>
</table>
</div>

<div class="footer" >
<table border="0" cellpadding="0" cellspacing="0"  style="position:static; width:940px; margin:20px auto 0px auto ">
    <tr>
		<td>
			<form method="post" name="Lang" action="/goform/setSysLang">
			<table border="0" cellpadding="2" cellspacing="2" summary="" align="center" style="display:none">
				<tr><td>
					<input type="hidden" name="token" value="<% genToken(); %>">
					<select name="langSelection" id="langSelection" onchange="doLangSet();">
					<option value="EN" selected="selected">English</option>
					<option value="DE">Deutsch</option>
					<option value="FR">French</option>
					<option value="ESP">Espanol</option>
					<option value="RU">Russian</option>
					</select>
					<input type="hidden" id="redirect_url" name="redirect_url" value="/" />
				</td></tr>
			</table>
			</form>
		</td>
		<td class="txt_footer">
			<!--#tr id="bottom.copyright"-->Copyright &copy; 2014 TRENDnet. All Rights Reserved.<!--#endtr-->
		</td>
		<td align="right" class="txt_footer">
			<img src="../images/icons_warranty_1.png"><a href="http://www.trendnet.com/register" target="_blank" style="margin: 0 0 0 10px;line-height:25px;vertical-align: top;"><!--#tr id="bottom.product.registration"-->Product Warranty Registration<!--#endtr--></a>&nbsp;&nbsp;&nbsp;
		</td>
	</tr>
</table>
</div>
</body>
<!-- InstanceEnd --></html>
