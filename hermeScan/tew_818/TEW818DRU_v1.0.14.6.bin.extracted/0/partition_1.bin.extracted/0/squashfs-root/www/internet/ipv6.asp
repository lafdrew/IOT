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
var ipv6hint6to4 = "Sets the 6to4 subnet ID(0-65535)";

function countSemicolon(prefix) {
	var count = 0;
	for (var i=0; i<prefix.length; i++){
		if(prefix.charAt(i) == ':'){
			count = count + 1;
		}
	}

	return count;
}


function checkPrefixLenMatch(prefix, len) {
        var plen;

        if(len <= 16){
                plen = 2;
        }
        else{
                var tmp_len = len / 8;
                plen = ~~(tmp_len);

                if((len % 16) == 0){
                        plen = plen - 1;
                }
        }

        var semi_num = countSemicolon(prefix);
        if(plen != semi_num){
                return false;
        }
        else{
                return true;
        }
}

function show_ipv6_wan_manual(mode)
{
	document.getElementById("ipv6Manual1").style.display = "none";
	document.getElementById("ipv6Manual2").style.display = "none";
	document.getElementById("ipv6Manual3").style.display = "none";
	document.getElementById("ipv6Manual4").style.display = "none";
	document.getElementById("ipv6Manual5").style.display = "none";
	document.getElementById("mode6to4").style.display = "none";
	document.getElementById("mode6rd").style.display = "none";
	document.getElementById("modepppoe").style.display = "none";

	if (mode == 2) {
		document.getElementById("ipv6Manual1").style.display = style_display_on_tr();
		document.getElementById("ipv6Manual2").style.display = style_display_on_tr();
		document.getElementById("ipv6Manual3").style.display = style_display_on_tr();
		document.getElementById("ipv6Manual4").style.display = style_display_on_tr();
		document.getElementById("ipv6Manual5").style.display = style_display_on_tr();
	}
	else if (mode == 3) {
		document.getElementById("mode6to4").style.display = style_display_on_tr();
	}
	else if (mode == 4) {
		document.getElementById("mode6rd").style.display = style_display_on_tr();
	}
	else if (mode == 5) {
		document.getElementById("modepppoe").style.display = style_display_on_tr();
		var pppoe_session = document.lan.wan_ipv6_pppoe_session.value;
		if (pppoe_session == "0") {
			show_ipv6_pppoe(0);
		}
		else if (pppoe_session == "1") {
			show_ipv6_pppoe(1);
		}
	}
}

function show_ipv6_lan(type)
{
	document.getElementById("ipv6Lan1").style.display = "none";
	document.getElementById("ipv6Lan1-1").style.display = "none";
	document.getElementById("ipv6Lan2").style.display = "none";
	document.getElementById("ipv6Lan3").style.display = "none";
	document.getElementById("ipv6Lan4").style.display = "none";
	document.getElementById("ipv6Lan5").style.display = "none";
	document.getElementById("ipv6Lan6").style.display = "none";
	document.getElementById("ipv6Lan7").style.display = "none";
	document.getElementById("ipv6PPPoE1").style.display = "none";
	document.getElementById("ipv6PPPoE2").style.display = "none";
	document.getElementById("ipv6PPPoE3").style.display = "none";

	if (type == 2) {
		document.getElementById("ipv6Lan1-1").style.display = style_display_on_tr();
		document.getElementById("ipv6Lan1").style.display = style_display_on_tr();
	}
	else if (type == 3) {
		var mode_6to4_manual = document.getElementById("IPv66to4Mode2").checked;

		if (mode_6to4_manual == true) { 
			document.getElementById("ipv6Lan2").style.display = style_display_on_tr();
			document.getElementById("ipv6Lan3").style.display = style_display_on_tr();
		}
	}
	else if (type == 4) {
		var mode_6rd_manual = document.getElementById("IPv66rdMode2").checked;

		if (mode_6rd_manual == true) {			
			document.getElementById("ipv6Lan4").style.display = style_display_on_tr();
			document.getElementById("ipv6Lan5").style.display = style_display_on_tr();
			document.getElementById("ipv6Lan6").style.display = style_display_on_tr();
			document.getElementById("ipv6Lan7").style.display = style_display_on_tr();
		}
	}
	else if (type == 5) {
		var session = "<% nvram_get("wan_ipv6_pppoe_session"); %>";

		if (session == "1") {
			document.getElementById("ipv6PPPoE1").style.display = style_display_on_tr();
			document.getElementById("ipv6PPPoE2").style.display = style_display_on_tr();
			document.getElementById("ipv6PPPoE3").style.display = style_display_on_tr();
		}
	}
}

function show_ipv6_pppoe(session)
{
	document.getElementById("ipv6PPPoE1").style.display = "none";
	document.getElementById("ipv6PPPoE2").style.display = "none";
	document.getElementById("ipv6PPPoE3").style.display = "none";

	if (session == 1) {
		document.getElementById("ipv6PPPoE1").style.display = style_display_on_tr();
		document.getElementById("ipv6PPPoE2").style.display = style_display_on_tr();
		document.getElementById("ipv6PPPoE3").style.display = style_display_on_tr();
	}
	else {
		var wan_mode = "<% nvram_get("wan0_proto"); %>";
		if (wan_mode != "pppoe") {
			Alert.render("<!--#tr id="ipv6.pppoe.warning"-->Please don't forget to set your PPPoE user name and password in Wide Area Network (WAN) Settings.<!--#endtr-->");
		}
	}
}

function wan_ipv6_change(load)
{
	var ipv6mode, ipv6PPPoE;

	if (load == 0) {
		ipv6mode = document.lan.wan_ipv6_mode.value;
	}
	else {
		var wan_select;
		ipv6mode = <% nvram_get("wan_ipv6_mode"); %>;

		wan_select = document.getElementById("wanIPv6Mode");
		wan_select.options.selectedIndex = ipv6mode;
	}

	show_ipv6_wan_manual(ipv6mode);
	lan_update(ipv6mode);
}

function lan_update(ipv6mode)
{
	show_ipv6_lan(ipv6mode);
}

function applyCheck()
{
    // 1. Check WAN Network Prefix
/*
    var wanNetworkPrefixElement = document.getElementById("wanNetworkPrefix");
    if (!isBlankString(wanNetworkPrefixElement.value))
    {
        if (!checkipv6(wanNetworkPrefixElement.value.split("/")[0]))
        {
            wanNetworkPrefixElement.focus();
            Alert.render("<!--#tr id="ip.address.error"-->Invalid IP address! Please enter a valid IP address.<!--#endtr-->");
            return false;   
        }
    }
*/

/*
    
    // 2. Check LAN Network Prefix
    var lanNetworkPrefixElement = document.getElementById("lanNetworkPrefix");
    var guestLanNetworkPrefixElement = document.getElementById("guestLanNetworkPrefix");
    if (!lanNetworkPrefixElement.disabled && !checkipv6(lanNetworkPrefixElement.value.split("/")[0]))
    {
        lanNetworkPrefixElement.focus();
        Alert.render("<!--#tr id="ip.address.error"-->Invalid IP address! Please enter a valid IP address.<!--#endtr-->");
        return false;   
    }
    else if (!guestLanNetworkPrefixElement.disabled && !checkipv6(guestLanNetworkPrefixElement.value.split("/")[0]))
    {
        guestLanNetworkPrefixElement.focus();
        Alert.render("<!--#tr id="ip.address.error"-->Invalid IP address! Please enter a valid IP address.<!--#endtr-->");
        return false;   
    }
    
    
    // 3. Check DNS Server
    var dnsServerElement = document.getElementById("dnsServer");
    var guestDnsServerElement = document.getElementById("guestDnsServer");
    if (dnsServerElement.value == "")
    {
    	// Allow empty DNS server
    }
    else if (!dnsServerElement.disabled && !checkipv6(dnsServerElement.value))
    {
        dnsServerElement.focus();
        Alert.render("<!--#tr id="ip.address.error"-->Invalid IP address! Please enter a valid IP address.<!--#endtr-->");
        return false;   
    }

    if (guestDnsServerElement.value == "")
    {
    	// Allow empty DNS server
    }
    else if (!guestDnsServerElement.disabled && !checkipv6(guestDnsServerElement.value))
    {
        guestDnsServerElement.focus();
        Alert.render("<!--#tr id="ip.address.error"-->Invalid IP address! Please enter a valid IP address.<!--#endtr-->");
        return false;   
    }
    
    // 4. Check 6to4 subnet ID
    var subnetIDElement = document.getElementById("subnetID");
    var guestSubnetIDElement = document.getElementById("guestSubnetID");
    if (!subnetIDElement.disabled)
    {
        if (!is_number(subnetIDElement.value) || !checkRange(subnetIDElement.value, 0, 65535))
        {
            subnetIDElement.focus();
            Alert.render("<!--#tr id="ipv6.alert.1"-->Please input a correct subnet ID between 0 and 65535<!--#endtr-->");
            return false;       
        }
    }
    
    if (!guestSubnetIDElement.disabled)
    {
        if (!is_number(guestSubnetIDElement.value) || !checkRange(guestSubnetIDElement.value, 0, 65535))
        {
            guestSubnetIDElement.focus();
            Alert.render("<!--#tr id="ipv6.alert.1"-->Please input a correct subnet ID between 0 and 65535<!--#endtr-->");
            return false;       
        }
    }
*/

	var ipv6mode = document.lan.wan_ipv6_mode.value;

	if (ipv6mode == 0 || ipv6mode == 1){ //diable / Auto Detect
		//do nothing
	}
	else if (ipv6mode == 2) { //static
		var addr, prefix_len, gw, dns1, dns2, lan_prefix, lan_prefix_len;
		addr = document.getElementById("wanIPv6Address");
		prefix_len = document.getElementById("wanPrefixLength");
		gw = document.getElementById("wanDefaultGateway");
		dns1 = document.getElementById("wanIPv6PrimaryDNS");
		dns2 = document.getElementById("wanIPv6SecondaryDNS");
		lan_prefix = document.getElementById("lanNetworkPrefix");
		lan_prefix_len = document.getElementById("lanNetworkPrefixLen");
		
		if (isBlankString(addr.value)) {
			addr.focus();
			Alert.render("<!--#tr id="ipv6.alert.2"-->WAN IP address cannot be blank.<!--#endtr-->");
			return false;
		}
		else {
			if (!checkipv6(addr.value)) {
				addr.focus();
				Alert.render("<!--#tr id="ip.address.error"-->Invalid IP address! Please enter a valid IP address.<!--#endtr-->");
				return false;
			}
		}

		if (isBlankString(prefix_len.value)) {
			prefix_len.focus();
			Alert.render("<!--#tr id="ipv6.alert.3"-->Prefix length cannot be blank.<!--#endtr-->");
			return false;
		}
		else {
			if (!is_number(prefix_len.value) || !checkRange(prefix_len.value, 1, 128)) {
				prefix_len.focus();
				Alert.render("<!--#tr id="ipv6.alert.4"-->Please input a correct prefix length between 1 and 128.<!--#endtr-->");
				return false;
			}
		}

		if (isBlankString(gw.value)) {
			gw.focus();
			Alert.render("<!--#tr id="ipv6.alert.5"-->Gateway cannot be blank.<!--#endtr-->");
			return false;
		}
		else {
			if (!checkipv6(gw.value)) {
				gw.focus();
				Alert.render("<!--#tr id="ip.address.error"-->Invalid IP address! Please enter a valid IP address.<!--#endtr-->");
				return false;
			}			
		}

		if (isBlankString(dns1.value)) {
			dns1.focus();
			Alert.render("<!--#tr id="ipv6.alert.6"-->Primary DNS cannot be blank.<!--#endtr-->");
			return false;
		}
		else {
			if (!checkipv6(dns1.value)) {
				dns1.focus();
				Alert.render("<!--#tr id="ip.address.error"-->Invalid IP address! Please enter a valid IP address.<!--#endtr-->");
				return false;
			}			
		}

		if (!isBlankString(dns2.value) && !checkipv6(dns2.value)) {
			dns2.focus();
			Alert.render("<!--#tr id="ip.address.error"-->Invalid IP address! Please enter a valid IP address.<!--#endtr-->");
			return false;
		}

		if (isBlankString(lan_prefix.value)) {
			lan_prefix.focus();
			Alert.render("<!--#tr id="ipv6.alert.7"-->Internal Lan prefix cannot be blank.<!--#endtr-->");
			return false;
		}
		else {
			if (!checkipv6(lan_prefix.value)) {
				lan_prefix.focus();
				Alert.render("<!--#tr id="ipv6.alert.8"-->Please input a valid prefix. eg. 2008:1234::<!--#endtr-->");
				return false;
			}			
		}

		if (isBlankString(lan_prefix_len.value)) {
			lan_prefix_len.focus();
			Alert.render("<!--#tr id="ipv6.alert.12"-->Internal Lan prefix length cannot be blank.<!--#endtr-->");
			return false;
		}
		else {
			if (!is_number(lan_prefix_len.value) || !checkRange(lan_prefix_len.value, 1, 128)) {
				lan_prefix_len.focus();
				Alert.render("<!--#tr id="ipv6.alert.4"-->Please input a correct prefix length between 1 and 128.<!--#endtr-->");
				return false;
			}
		}
	}
	else if (ipv6mode == 3) { //6to4
		var mode_6to4_manual, server, sub_id;

		mode_6to4_manual = document.getElementById("IPv66to4Mode2").checked;
		server = document.getElementById("tunnel6to4Server");
		sub_id = document.getElementById("tunnel6to4SubnetID");
		
		if (mode_6to4_manual == true) {
			if (isBlankString(server.value)) {
				server.focus();
				Alert.render("<!--#tr id="ipv6.alert.9"-->6to4 server cannot be blank.<!--#endtr-->");
				return false;
			}
			else {
				if (!checkDomain(server.value) && !checkIpAddr(server, false)) {
					server.focus();
					Alert.render("<!--#tr id="ipv6.alert.10"-->6to4 server is invalid. Please input a valid domain name or IP address.<!--#endtr-->");
					return false;
				}
			}

			if (isBlankString(sub_id.value)) {
				sub_id.focus();
				Alert.render("<!--#tr id="ipv6.alert.11"-->Subnet ID cannot be blank.<!--#endtr-->");
				return false;
			}
			else {
				if (!is_number(sub_id.value) || !checkRange(sub_id.value, 1, 65535)) {
					sub_id.focus();
	            			Alert.render("<!--#tr id="ipv6.alert.1"-->Please input a correct subnet ID between 1 and 65535<!--#endtr-->");
       	     			return false;       
        			}
			}
		}
	} 
	else if (ipv6mode == 4) { //6rd
		var mode_6td_manual, prefix, prefix_len, server, mask, pppoe_session;

		mode_6rd_manual = document.getElementById("IPv66rdMode2").checked;
		prefix = document.getElementById("tunnel6rdPrefix");
		prefix_len = document.getElementById("tunnel6rdPrefixLen");
		server = document.getElementById("tunnel6rdBorderRelay");
		mask = document.getElementById("tunnel6rdAddrMask");

		if (mode_6rd_manual == true) {
			if (isBlankString(prefix.value)) {
				prefix.focus();
				Alert.render("<!--#tr id="ipv6.alert.13"-->6rd prefix cannot be blank.<!--#endtr-->");
				return false;
			}
			else {
				if (!checkipv6(prefix.value)) {
					prefix.focus();
					Alert.render("<!--#tr id="ipv6.alert.8"-->Please input a valid prefix. eg. 2008:1234::<!--#endtr-->");
					return false;
				}
			}

			if (isBlankString(prefix_len.value)) {
				prefix_len.focus();
				Alert.render("<!--#tr id="ipv6.alert.14"-->6rd prefix length cannot be blank.<!--#endtr-->");
				return false;
			}
			else {
				if (!is_number(prefix_len.value) || !checkRange(prefix_len.value, 1, 128)) {
					prefix_len.focus();
					Alert.render("<!--#tr id="ipv6.alert.4"-->Please input a correct prefix length between 1 and 128.<!--#endtr-->");
       	     			return false;       
        			}
        			
				if (!checkPrefixLenMatch(prefix.value, prefix_len.value)) {
					prefix_len.focus();
					Alert.render("<!--#tr id="ipv6.alert.17"-->6rd prefix length must match 6rd prefix.<!--#endtr-->");
					return false;
				}
			}

			if (isBlankString(server.value)) {
				server.focus();
				Alert.render("<!--#tr id="ipv6.alert.15"-->6rd server cannot be blank.<!--#endtr-->");
				return false;
			}
			else {
				if (!checkDomain(server.value) && !checkIpAddr(server, false)) {
					server.focus();
					Alert.render("<!--#tr id="ipv6.alert.18"-->6rd server is invalid. Please input a valid domain name or IP address.<!--#endtr-->");
					return false;
				}
			}

			if (isBlankString(mask.value)) {
				mask.focus();
				Alert.render("<!--#tr id="ipv6.alert.16"-->6rd server mask cannot be blank.<!--#endtr-->");
				return false;
			}
			else {
				if (!is_number(mask.value) || !checkRange(mask.value, 0, 32)) {
					mask.focus();
					Alert.render("<!--#tr id="ipv6.alert.19"-->Please input a correct mask length between 0 and 32.<!--#endtr-->");
       	     			return false;       
        			}
			}
		}
	}
	else if (ipv6mode == 5) { //PPPoE
		pppoe_session = document.getElementById("IPv6SessionNew");
		
		if (pppoe_session.checked == true) {
			// 1. Check User name
			if (isBlankString(document.getElementById("wanIPv6PPPoEUser").value)) {
				Alert.render("<!--#tr id="wan.alert.7" -->PPPoE user name is blank!<!--#endtr -->");
				return false;
			}
    
    			// 2. Cheeck Password
    			if (isBlankString(document.getElementById("wanIPv6PPPoEPassword").value)) {
    				Alert.render("<!--#tr id="wan.alert.6" -->PPPoE password is blank!<!--#endtr -->");
    				return false;
    			}
		}
	}
	
	totalWaitTime = 25;
	redirectURL = ".." + location.pathname;
	wait_page();
	document.getElementById("waitPad").style.display="block";
	scroll(0,0);
	return true;
}

// do the work of checking the string
function checkipv6(str)
{
	var perlipv6regex = "^\s*((([0-9A-Fa-f]{1,4}:){7}([0-9A-Fa-f]{1,4}|:))|(([0-9A-Fa-f]{1,4}:){6}(:[0-9A-Fa-f]{1,4}|((25[0-5]|2[0-4]\d|1\d\d|[1-9]?\d)(\.(25[0-5]|2[0-4]\d|1\d\d|[1-9]?\d)){3})|:))|(([0-9A-Fa-f]{1,4}:){5}(((:[0-9A-Fa-f]{1,4}){1,2})|:((25[0-5]|2[0-4]\d|1\d\d|[1-9]?\d)(\.(25[0-5]|2[0-4]\d|1\d\d|[1-9]?\d)){3})|:))|(([0-9A-Fa-f]{1,4}:){4}(((:[0-9A-Fa-f]{1,4}){1,3})|((:[0-9A-Fa-f]{1,4})?:((25[0-5]|2[0-4]\d|1\d\d|[1-9]?\d)(\.(25[0-5]|2[0-4]\d|1\d\d|[1-9]?\d)){3}))|:))|(([0-9A-Fa-f]{1,4}:){3}(((:[0-9A-Fa-f]{1,4}){1,4})|((:[0-9A-Fa-f]{1,4}){0,2}:((25[0-5]|2[0-4]\d|1\d\d|[1-9]?\d)(\.(25[0-5]|2[0-4]\d|1\d\d|[1-9]?\d)){3}))|:))|(([0-9A-Fa-f]{1,4}:){2}(((:[0-9A-Fa-f]{1,4}){1,5})|((:[0-9A-Fa-f]{1,4}){0,3}:((25[0-5]|2[0-4]\d|1\d\d|[1-9]?\d)(\.(25[0-5]|2[0-4]\d|1\d\d|[1-9]?\d)){3}))|:))|(([0-9A-Fa-f]{1,4}:){1}(((:[0-9A-Fa-f]{1,4}){1,6})|((:[0-9A-Fa-f]{1,4}){0,4}:((25[0-5]|2[0-4]\d|1\d\d|[1-9]?\d)(\.(25[0-5]|2[0-4]\d|1\d\d|[1-9]?\d)){3}))|:))|(:(((:[0-9A-Fa-f]{1,4}){1,7})|((:[0-9A-Fa-f]{1,4}){0,5}:((25[0-5]|2[0-4]\d|1\d\d|[1-9]?\d)(\.(25[0-5]|2[0-4]\d|1\d\d|[1-9]?\d)){3}))|:)))(%.+)?\s*$";
	var aeronipv6regex = "^\s*((?=.*::.*)(::)?([0-9A-F]{1,4}(:(?=[0-9A-F])|(?!\2)(?!\5)(::)|\z)){0,7}|((?=.*::.*)(::)?([0-9A-F]{1,4}(:(?=[0-9A-F])|(?!\7)(?!\10)(::))){0,5}|([0-9A-F]{1,4}:){6})((25[0-5]|(2[0-4]|1[0-9]|[1-9]?)[0-9])(\.(?=.)|\z)){4}|([0-9A-F]{1,4}:){7}[0-9A-F]{1,4})\s*$";
	
	var regex = "/"+perlipv6regex+"/";

	return (/^\s*((([0-9A-Fa-f]{1,4}:){7}([0-9A-Fa-f]{1,4}|:))|(([0-9A-Fa-f]{1,4}:){6}(:[0-9A-Fa-f]{1,4}|((25[0-5]|2[0-4]\d|1\d\d|[1-9]?\d)(\.(25[0-5]|2[0-4]\d|1\d\d|[1-9]?\d)){3})|:))|(([0-9A-Fa-f]{1,4}:){5}(((:[0-9A-Fa-f]{1,4}){1,2})|:((25[0-5]|2[0-4]\d|1\d\d|[1-9]?\d)(\.(25[0-5]|2[0-4]\d|1\d\d|[1-9]?\d)){3})|:))|(([0-9A-Fa-f]{1,4}:){4}(((:[0-9A-Fa-f]{1,4}){1,3})|((:[0-9A-Fa-f]{1,4})?:((25[0-5]|2[0-4]\d|1\d\d|[1-9]?\d)(\.(25[0-5]|2[0-4]\d|1\d\d|[1-9]?\d)){3}))|:))|(([0-9A-Fa-f]{1,4}:){3}(((:[0-9A-Fa-f]{1,4}){1,4})|((:[0-9A-Fa-f]{1,4}){0,2}:((25[0-5]|2[0-4]\d|1\d\d|[1-9]?\d)(\.(25[0-5]|2[0-4]\d|1\d\d|[1-9]?\d)){3}))|:))|(([0-9A-Fa-f]{1,4}:){2}(((:[0-9A-Fa-f]{1,4}){1,5})|((:[0-9A-Fa-f]{1,4}){0,3}:((25[0-5]|2[0-4]\d|1\d\d|[1-9]?\d)(\.(25[0-5]|2[0-4]\d|1\d\d|[1-9]?\d)){3}))|:))|(([0-9A-Fa-f]{1,4}:){1}(((:[0-9A-Fa-f]{1,4}){1,6})|((:[0-9A-Fa-f]{1,4}){0,4}:((25[0-5]|2[0-4]\d|1\d\d|[1-9]?\d)(\.(25[0-5]|2[0-4]\d|1\d\d|[1-9]?\d)){3}))|:))|(:(((:[0-9A-Fa-f]{1,4}){1,7})|((:[0-9A-Fa-f]{1,4}){0,5}:((25[0-5]|2[0-4]\d|1\d\d|[1-9]?\d)(\.(25[0-5]|2[0-4]\d|1\d\d|[1-9]?\d)){3}))|:)))(%.+)?\s*$/.test(str));
	
}

function page_load() {
	wan_ipv6_change(1);
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
<h1><!--#tr id="ipv6.title"-->IPv6 Settings<!--#endtr--></h1>
<div class="hr" ></div>
<p>
<!--#tr id="ipv6.desc"-->This section allows you to configure your IPv6 Internet connection settings and LAN IPv6 settings. If you are not sure of your IPv6 Internet connection settings or if IPv6 service is available, please contact your Internet Service Provider (ISP) for details.<!--#endtr-->
</p>

<form name="lan" method="post" action="/uapply.cgi" onSubmit="return applyCheck();" target="rebootRedirect">
<input type="hidden" name="page" value="/internet/ipv6.asp">
<input type="hidden" name="token" value="<% genToken(); %>">
<!-- These are set by the Javascript functions above --> 
<input type="hidden" name="num_lan_ifaces" value="2">
<input type="hidden" name="lan_ifname" value="<% nvram_get("lan_ifname"); %>" >
<input type="hidden" name="lan1_ifname" value="<% nvram_get("lan1_ifname"); %>" >
<!--
#ifdef BCMVISTAROUTER
-->	
<table width="100%" class="tbl_main">
	<tr>
		<td class="CT" colspan="2"><!--#tr id="ipv6.1"-->WAN IPv6 Setting<!--#endtr--></td>
	</tr>
	<tr>
    		<td class="CL"
			onMouseOver="return overlib('Select the IPv6 Network Mode for WAN.', LEFT);"
			onMouseOut="return nd();">IPv6 Connection Mode</td>
    		<td class="CR">
    			<select name="wan_ipv6_mode" id="wanIPv6Mode" onChange="wan_ipv6_change(0);">
      				<option value="0"  <% nvram_match("wan_ipv6_mode", "0", "selected"); %> ><!--#tr id="ipv6.link.local"-->Link Local<!--#endtr--></option>
      				<option value="1" <% nvram_match("wan_ipv6_mode", "1", "selected"); %> ><!--#tr id="ipv6.auto.conf"-->Auto Configuration (SLAAC/DHCPv6)<!--#endtr--></option>
      				<option value="2" <% nvram_match("wan_ipv6_mode", "2", "selected"); %> ><!--#tr id="wan.static"-->Static<!--#endtr--></option>
      				<option value="3" <% nvram_match("wan_ipv6_mode", "3", "selected"); %> ><!--#tr id="ipv6.6to4"-->6to4 Tunnel<!--#endtr--></option>
				<option value="4" <% nvram_match("wan_ipv6_mode", "4", "selected"); %> ><!--#tr id="ipv6.6rd"-->6rd Tunnel<!--#endtr--></option>
				<option value="5" <% nvram_match("wan_ipv6_mode", "5", "selected"); %> ><!--#tr id="wan.pppoe"-->PPPoE<!--#endtr--></option>
    			</select></td>
  	</tr> 
  	<tr id="ipv6Manual1" style="display:none">
  		<td class="CL"
  			onMouseOver="return overlib('Sets the IPv6 Address for WAN.', LEFT);"
			onMouseOut="return nd();"><!--#tr id="ipv6.wan.ip"-->WAN IPv6 Address<!--#endtr--></td>
    		<td class="CR">
      			<input name="wan_ipv6_address" type="text" id="wanIPv6Address" value="<% nvram_get("wan_ipv6_address"); %>" size="32" maxlength="39" /></td>
  	</tr>
	<tr id="ipv6Manual2" style="display:none">
    		<td class="CL"
			onMouseOver="return overlib('Sets the IPv6 Prefix Length for WAN.', LEFT);"
			onMouseOut="return nd();"><!--#tr id="ipv6.wan.prefixlen"-->WAN IPv6 Prefix Length<!--#endtr--></td>
    		<td class="CR">
      			<input name="wan_ipv6_prefix_length" type="text" id="wanPrefixLength" value="<% nvram_get("wan_ipv6_prefix_length"); %>" size="3" maxlength="3" /></td>
  	</tr>
  	<tr id="ipv6Manual3" style="display:none">
    		<td class="CL"
			onMouseOver="return overlib('Sets the IPv6 Gateway for WAN.', LEFT);"
			onMouseOut="return nd();"><!--#tr id="ipv6.wan.gw"-->IPv6 Default Gateway<!--#endtr--></td>
    		<td class="CR">
      			<input name="wan_ipv6_default_gateway" type="text" id="wanDefaultGateway" value="<% nvram_get("wan_ipv6_default_gateway"); %>" size="32" maxlength="39" /></td>
  	</tr>
  	<tr id="ipv6Manual4" style="display:none">
    		<td class="CL"
			onMouseOver="return overlib('Sets the IPv6 Primary DNS Server for WAN.', LEFT);"
			onMouseOut="return nd();"><!--#tr id="ipv6.wan.pri.dns"-->Primary IPv6 DNS Server<!--#endtr--></td>
    		<td class="CR">
    			<input name="wan_ipv6_dns1" type="text" id="wanIPv6PrimaryDNS" value="<% nvram_get("wan_ipv6_dns1"); %>" size="32" maxlength="39" /></td>
  	</tr>
  	<tr id="ipv6Manual5" style="display:none">
    		<td class="CL"
			onMouseOver="return overlib('Sets the IPv6 Secondary DNS Server for WAN.', LEFT);"
			onMouseOut="return nd();"><!--#tr id="ipv6.wan.sec.dns"-->Secondary IPv6 DNS Server<!--#endtr--></td>
    		<td class="CR">
      			<input name="wan_ipv6_dns2" type="text" id="wanIPv6SecondaryDNS" value="<% nvram_get("wan_ipv6_dns2"); %>" size="32" maxlength="39" /></td>
  	</tr>
  	<tr id="mode6to4" style="display:none">
		<td class="CL"
			onMouseOver="return overlib('Select 6to4 mode', LEFT);"
			onMouseOut="return nd();"><!--#tr id="ipv6.6to4.mode"-->6to4 Tunnel mode<!--#endtr--></td>
		<td class="CR">
			<input value="0" type="radio" name="wan_ipv6_6to4_mode" id="IPv66to4Mode1" onClick="show_ipv6_lan(3);" <% nvram_match("wan_ipv6_6to4_mode", "0", "checked"); %> />
			<strong><!--#tr id="auto"-->Auto<!--#endtr--></strong>
			<input value="1" type="radio" name="wan_ipv6_6to4_mode" id="IPv66to4Mode2" onClick="show_ipv6_lan(3);" <% nvram_match("wan_ipv6_6to4_mode", "1", "checked"); %>/>
			<strong><!--#tr id="manual"-->Manual<!--#endtr--></strong>
		</td>
  	</tr>
  	<tr id="mode6rd" style="display:none">
		<td class="CL"
			onMouseOver="return overlib('Select 6rd mode', LEFT);"
			onMouseOut="return nd();"><!--#tr id="ipv6.6to4.mode"-->6rd Tunnel mode<!--#endtr--></td>
		<td class="CR">
			<input value="0" type="radio" name="wan_ipv6_6rd_mode" id="IPv66rdMode1" onClick="show_ipv6_lan(4);" <% nvram_match("wan_ipv6_6rd_mode", "0", "checked"); %> />
			<strong><!--#tr id="auto"-->Auto<!--#endtr--></strong>
			<input value="1" type="radio" name="wan_ipv6_6rd_mode" id="IPv66rdMode2" onClick="show_ipv6_lan(4);" <% nvram_match("wan_ipv6_6rd_mode", "1", "checked"); %> />
			<strong><!--#tr id="manual"-->Manual<!--#endtr--></strong>
		</td>
  	</tr>
  	<tr id="modepppoe" style="display:none">
		<td class="CL"
			onMouseOver="return overlib('Select PPPoE mode', LEFT);"
			onMouseOut="return nd();"><!--#tr id="ipv6.pppoe.session"-->PPPoE Session<!--#endtr--></td>
		<td class="CR">
			<input value="0" type="radio" name="wan_ipv6_pppoe_session" id="IPv6SessionShare" onClick="show_ipv6_pppoe(0);" <% nvram_match("wan_ipv6_pppoe_session", "0", "checked"); %> />
			<strong><!--#tr id="ipv6.pppoe.session.share"-->Share with IPv4<!--#endtr--></strong>
			<input value="1" type="radio" name="wan_ipv6_pppoe_session" id="IPv6SessionNew" onClick="show_ipv6_pppoe(1);" <% nvram_match("wan_ipv6_pppoe_session", "1", "checked"); %> />
			<strong><!--#tr id="ipv6.pppoe.session.new"-->Create new session<!--#endtr--></strong>
		</td>
  	</tr>
  	<tr id="ipv6PPPoE1" style="display:none">
  		<td class="CL"
  			onMouseOver="return overlib('Sets IPv6 PPPoE user', LEFT);"
			onMouseOut="return nd();"><!--#tr id="wan.user.name"-->User Name<!--#endtr--></td>
    		<td class="CR">
      			<input name="wan_ipv6_pppoe_user" type="text" id="wanIPv6PPPoEUser" value="<% nvram_get("wan_ipv6_pppoe_user"); %>" maxlength="255" /></td>
  	</tr>
	<tr id="ipv6PPPoE2" style="display:none">
    		<td class="CL"
			onMouseOver="return overlib('Sets the IPv6 PPPoE password', LEFT);"
			onMouseOut="return nd();"><!--#tr id="wan.password"-->Password<!--#endtr--></td>
    		<td class="CR">
      			<input name="wan_ipv6_pppoe_password" type="password" id="wanIPv6PPPoEPassword" value="<% nvram_get("wan_ipv6_pppoe_password"); %>" maxlength="255" /></td>
  	</tr>
  	<tr id="ipv6PPPoE3" style="display:none">
		<td class="CL"
		onMouseOver="return overlib('Sets IPv6 PPPoE keep alive always.', LEFT);"
		onMouseOut="return nd();">
		<!--#tr id="wan.keep.alive.mode"-->Keep Alive Mode<!--#endtr-->
		</td>
		<td class="CR">
			<select id="pppoeKeepAliveMode" name="ipv6_wan_pppoe_keepalive" disabled>
				<option value="1" selected><!--#tr id="enabled"-->Enabled<!--#endtr--></option>
				<option value="0"><!--#tr id="disabled"-->Disabled<!--#endtr--></option>
			</select>
		</td>
	</tr>
</table>

<table width="100%" class="tbl_main">
	<tr>
		<td class="CT" colspan="3"><!--#tr id="ipv6.3"-->LAN IPv6 Setting<!--#endtr--></td>
	</tr>
	<tr>
		<td class="CL">
		<!--#tr id="lan.12"-->Configured Networks<!--#endtr-->
		</td>
		<td class="CR"><B><!--#tr id="internal.network"-->Internal Network<!--#endtr--></B></td>
	</tr>
	<tr id="ipv6Lan1" style="display:none">
		<td class="CL"
		onMouseOver="return overlib('Sets the IPv6 Network Prefix for LAN.', LEFT);"
		onMouseOut="return nd();">
		<!--#tr id="ipv6.lan.prefix"-->LAN IPv6 Prefix<!--#endtr-->
		</td>
		<td class="CR"><input id="lanNetworkPrefix" name="lan_ipv6_prefix" value="<% nvram_get("lan_ipv6_prefix"); %>" size="32" maxlength="41"></td>
	</tr>
	<tr id="ipv6Lan1-1" style="display:none">
		<td class="CL"
		onMouseOver="return overlib('Sets the IPv6 Network Prefix Length for LAN.', LEFT);"
		onMouseOut="return nd();">
		<!--#tr id="ipv6.lan.prefix.len"-->LAN IPv6 Prefix Length<!--#endtr-->
		</td>
		<td class="CR"><input id="lanNetworkPrefixLen" name="lan_ipv6_prefix_len" value="<% nvram_get("lan_ipv6_prefix_len"); %>" size="3" maxlength="3"></td>
	</tr>
	<tr id="ipv6Lan2" style="display:none">
		<td class="CL"
		onMouseOver="return overlib(ipv6hint6to4, LEFT);"
		onMouseOut="return nd();">
		<!--#tr id="ipv6.6to4.server"-->6to4 Server<!--#endtr-->
		</td>
		<td class="CR"><input id="tunnel6to4Server" name="lan_ipv6_6to4_server" value="<% nvram_get("lan_ipv6_6to4_server"); %>" size="15" maxlength="64"></td>
	</tr>
	<tr id="ipv6Lan3" style="display:none">
		<td class="CL"
		onMouseOver="return overlib(ipv6hint6to4_1, LEFT);"
		onMouseOut="return nd();">
		<!--#tr id="ipv6.10"-->6to4 subnet ID<!--#endtr-->
		</td>
		<td class="CR2"><input id="tunnel6to4SubnetID" name="lan_ipv6_6to4_id" value="<% nvram_get("lan_ipv6_6to4_id"); %>" size="5" maxlength="5"></td>
	</tr>
	<tr id="ipv6Lan4" style="display:none">
		<td class="CL"
		onMouseOver="return overlib(ipv6hint6rd1, LEFT);"
		onMouseOut="return nd();">
		<!--#tr id="ipv6.6rd.prefix"-->6rd Prefix<!--#endtr-->
		</td>
		<td class="CR"><input id="tunnel6rdPrefix" name="lan_ipv6_6rd_prefix" value="<% nvram_get("lan_ipv6_6rd_prefix"); %>" size="32" maxlength="41"></td>
	</tr>
	<tr id="ipv6Lan5" style="display:none">
		<td class="CL"
		onMouseOver="return overlib(ipv6hint6rd2, LEFT);"
		onMouseOut="return nd();">
		<!--#tr id="ipv6.6rd.prefix.len"-->6rd Prefix Length<!--#endtr-->
		</td>
		<td class="CR"><input id="tunnel6rdPrefixLen" name="lan_ipv6_6rd_prefix_len" value="<% nvram_get("lan_ipv6_6rd_prefix_len"); %>" size="3" maxlength="3"></td>
	</tr>
	<tr id="ipv6Lan6" style="display:none">
		<td class="CL"
		onMouseOver="return overlib(ipv6hint6rd3, LEFT);"
		onMouseOut="return nd();">
		<!--#tr id="ipv6.6rd.border.relay"-->6rd Border Relay<!--#endtr-->
		</td>
		<td class="CR"><input id="tunnel6rdBorderRelay" name="lan_ipv6_6rd_broder_relay" value="<% nvram_get("lan_ipv6_6rd_broder_relay"); %>" size="15" maxlength="64"></td>
	</tr>
	<tr id="ipv6Lan7" style="display:none">
		<td class="CL"
		onMouseOver="return overlib(ipv6hint6rd4, LEFT);"
		onMouseOut="return nd();">
		<!--#tr id="ipv6.6rd.addr.mask"-->6rd IPv4 Address Mask<!--#endtr-->
		</td>
		<td class="CR"><input id="tunnel6rdAddrMask" name="lan_ipv6_6rd_addr_mask" value="<% nvram_get("lan_ipv6_6rd_addr_mask"); %>" size="3" maxlength="3"></td>
	</tr>
</table>
<!--
#endif  /* BCMVISTAROUTER */
-->	

<table width="100%" class="tbl_main">
	<tr align="center">
		<td>
			<input type="submit" class="<!--#tr id="buttonWidth"-->button1<!--#endtr-->" name="action" value="<!--#tr id="apply"-->Apply<!--#endtr-->">
			<input type="reset" class="button1" name="action" value="<!--#tr id="cancel"-->Cancel<!--#endtr-->">
		</td>
	</tr>
</table>
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
