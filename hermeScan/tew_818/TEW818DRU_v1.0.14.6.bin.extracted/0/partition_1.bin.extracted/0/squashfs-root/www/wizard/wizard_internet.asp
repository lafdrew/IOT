<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en"><!-- InstanceBegin template="/Templates/wizard.dwt" codeOutsideHTMLIsLocked="false" -->
<head>
<meta http-equiv="content-type" content="text/html; charset=utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE8"/>

<title>TRENDnet | TEW-818DRU | <!--#tr id="project.desc"-->AC1900 Dual Band Wireless Router<!--#endtr--></title>
<!-- InstanceBeginEditable name="Page Title" -->

<!-- InstanceEndEditable -->

<link href="/style/style.css" rel="stylesheet" type="text/css" media="screen" />
<link href="/style/frame.css" rel="stylesheet" type="text/css" media="screen" />
<!-- InstanceBeginEditable name="Local Styles" -->
	<style type="text/css">
	/*
	 * Styles used only on this page.
	 */
	.wizard_container
	{
		background-color: #FFFFFF;
		border-color: #FFFFFF;		
		border-style: none none none none; 
		width: 660px;
	}
	</style>
	<!-- InstanceEndEditable -->

<script type="text/javascript" src="/scripts/jquery.min.js"></script>
<script type="text/javascript" src="/scripts/ddaccordion.js"></script>
<script type="text/javascript" src="/scripts/um.js?20120904<% nvram_get("Language"); %>"></script>
<script type="text/javascript" src="/scripts/func.js?20120904<% nvram_get("Language"); %>"></script>
<script type="text/javascript" src="/scripts/overlib.js"></script>
<!-- InstanceBeginEditable name="Include Files" -->
	<!-- InstanceEndEditable -->
<script language="JavaScript" type="text/javascript">
function template_load() {
	page_load();
}
</script>
<!-- InstanceBeginEditable name="Scripts" -->
<script language="javascript" type="text/javascript">
/*
 * Set the no reboot location parameter to the wizard launch page
 */
no_reboot_alt_location = "/adm/status.asp";
var langset = "<% nvram_get("Language"); %>";
var lang = (langset=="")? "EN":langset;
/*
 * Handle for document.mainform.
 */
var mf;
var DEFAULT_STATIC_MTU = "1500";
var DEFAULT_DHCP_MTU = "1500";
var DEFAULT_PPPOE_MTU = "1492";
var DEFAULT_L2TP_MTU = "1464";
var DEFAULT_PPTP_MTU = "1452";

/*
 * WAN connection mode.
 */
var connection_mode;

/*
 * Wizard pages.
 */
var wz_min = 1;
var wz_max = 4;
var wz_cur = 1;

var wz_verify = [ null, wz_verify_2, wz_verify_3, null ];

function wz_verify_2()
{
	for (var i = 0; i <= 4; i++) {
		if (document.getElementById("wan_ip_mode_radio_" + i).checked == true) {
			connection_mode = i;
			return true;
		}
	}
	Alert.render("<!--#tr id="wi.alert.1"-->Please select a connection type option.<!--#endtr-->");
	return false;
}

//Tom.Hung 2009-2-13, check WAN static IP's subnet can't same as LAN IP.
function checkSubnet(ip1,ip2) {
	var m;

	m=ip1.lastIndexOf(".");
	ip1=ip1.substring(0,m);

	m=ip2.lastIndexOf(".");
	ip2=ip2.substring(0,m);
	
	if(ip1==ip2)
		return false;
	else
		return true;
}

function wz_verify_3()
{
	
	if (connection_mode == 0) { //Static		
		if (!checkIpAddr(document.getElementById("wan_ip_address"), false)) {
			return false;
		}
		
		//Tom.Hung 2009-2-13, check WAN static IP's subnet can't same as LAN IP.
		var LanIP = "<% nvram_get("lan_ipaddr"); %>";
		if (!checkSubnet(document.getElementById("wan_ip_address").value, LanIP)) {
			Alert.render("<!--#tr id="wan.alert.33"-->WAN IP's subnet can't be the same as the LAN IP's subnet.<!--#endtr-->");
			return false;
		} 
		
		if (!checkIpAddr(document.getElementById("wan_subnet_mask"), true)) {
			return false;
		}
		
		if (document.getElementById("wan_gateway").value != "") {// u-media(rh001)-Griffin Wang-TEW691GR ([+Use ID value to check])
			if (!checkIpAddr(document.getElementById("wan_gateway"), false)) {			
				return false;
			} 
		} 
		
		if (document.getElementById("wan_primary_dns").value != "") {// u-media(rh001)-Griffin Wang-TEW691GR ([+Use ID value to check])
			if (!checkIpAddr(document.getElementById("wan_primary_dns"), false)) {
				return false;
			} 
		}		
		
		if (document.getElementById("wan_secondary_dns").value != "") {// u-media(rh001)-Griffin Wang-TEW691GR ([+Use ID value to check])
			if (!checkIpAddr(document.getElementById("wan_secondary_dns"), false)) {
				return false;
			} 
		} 
		
		if(!checkSameSubnet(document.getElementById("wan_ip_address").value,document.getElementById("wan_gateway").value,document.getElementById("wan_subnet_mask").value )){
			Alert.render("<!--#tr id="wan.alert.3"-->The static IP address is not within the subnet of Gateway.<!--#endtr-->");
			return false;
		}
		
		return true; 		
	} else if (connection_mode == '1') { //DHCP
		if (document.getElementById("mac_cloning_address").value.length != 0) {
			var re = /^[A-Fa-f0-9]{2}:[A-Fa-f0-9]{2}:[A-Fa-f0-9]{2}:[A-Fa-f0-9]{2}:[A-Fa-f0-9]{2}:[A-Fa-f0-9]{2}$/;
			if (!re.test(document.getElementById("mac_cloning_address").value)) {
				Alert.render("<!--#tr id="wan.alert.9"-->Please fill the MAC Address in correct format! (XX:XX:XX:XX:XX:XX)<!--#endtr-->");
				document.getElementById("mac_cloning_address").focus();
				return false;
			}
			var re2 = /^[A-Fa-f0-9]{1}[02468aAcCeE]{1}:[A-Fa-f0-9]{2}:[A-Fa-f0-9]{2}:[A-Fa-f0-9]{2}:[A-Fa-f0-9]{2}:[A-Fa-f0-9]{2}$/;
			if (!re2.test(document.getElementById("mac_cloning_address").value)) {
				Alert.render("<!--#tr id="wan.alert.12"-->MAC Address can't be a multicast or broadcast MAC Address!<!--#endtr-->");
				document.getElementById("mac_cloning_address").focus();
				return false;
			}
		}
		
		// u-media(rh001)-Griffin Wang-TEW691GR ([+Add wizard DHCP Host Name check function])
		if( document.getElementById("wan_dhcp_gw_name").value != "" ){
			var re3 = /^[\w\-\.]+$/;  
			if (!re3.test(document.getElementById("wan_dhcp_gw_name").value)) {
				Alert.render("<!--#tr id="wan.alert.4"-->Host Name only accept [0-9a-zA-Z_-.] characters.<!--#endtr-->");
				return false;
			}
		}
	
	} else if (connection_mode == '2') { //PPPoE
		if (document.getElementById("pppoe_password").value != document.getElementById("second_pppoe_password").value) {
			Alert.render("<!--#tr id="wan.alert.3"-->Password mismatched!<!--#endtr-->");
			return false;
		}
		if (document.getElementById("pppoe_password").value == "") {
			Alert.render("<!--#tr id="wan.alert.6"-->PPPoE password is blank!<!--#endtr-->");
			return false;
		}
		if (document.getElementById("pppoe_username").value == "") {
			Alert.render("<!--#tr id="wan.alert.7"-->PPPoE user name is blank!<!--#endtr-->");
			return false;
		}
		// u-media(rh001)-Griffin Wang-TEW691GR ([+Add pppoe username , password check function])
		if (document.getElementById("pppoe_username").value.indexOf("\"") > -1) {
			Alert.render("<!--#tr id="wan.alert.7"-->PPPoE user name have invalid characters<!--#endtr-->");
			return false; 
		}
		if (document.getElementById("pppoe_password").value.indexOf("\"") > -1) {
			Alert.render("<!--#tr id="wan.alert.7"-->PPPoE password have invalid characters<!--#endtr-->");
			return false; 
		}
		
		return true;
	} else if (connection_mode == '3') { //L2TP
		
		if (document.getElementById("wan_l2tp_password").value != document.getElementById("second_wan_l2tp_password").value) {
			Alert.render("<!--#tr id="wan.alert.3"-->Password mismatched!<!--#endtr-->");
			return false;
		}
		
		if (document.getElementById("wan_l2tp_username").value == "") {
			Alert.render("<!--#tr id="wan.alert.3"-->L2TP user name is blank!<!--#endtr-->");
			return false;
		}
		// u-media(rh001)-Griffin Wang-TEW691GR ([+Add l2tp username, password check function])
		if (document.getElementById("wan_l2tp_password").value == "") {
			Alert.render("<!--#tr id="wan.alert.31"-->L2TP password is blank!<!--#endtr-->");
			return false;
		}
		
		if (document.getElementById("wan_l2tp_username").value.indexOf("\"") > -1) {
			Alert.render("<!--#tr id="wan.alert.15"-->L2TP Server User Name have invalid characters!<!--#endtr-->");
			return false; 
		}
		if (document.getElementById("wan_l2tp_password").value.indexOf("\"") > -1) {
			Alert.render("<!--#tr id="wan.alert.16"-->L2TP Server Password have invalid characters!<!--#endtr-->");
			return false; 
		}
		
		if (document.getElementById("wan_l2tp_server").value.indexOf("\"") > -1) {
			Alert.render("<!--#tr id="wan.alert.12"-->L2TP Server IP Address have invalid characters<!--#endtr--> \".");
			return false; 
		}
		var re = /^[\w\-\.]+$/; 
		if (!re.test(document.getElementById("wan_l2tp_server").value)) {
			Alert.render("<!--#tr id="wan.alert.13"-->L2TP Server IP Address only accept [0-9a-zA-Z_-.] characters.<!--#endtr-->");
			return false;
		}
		var re2 = /^[\w\-\.]+\.[\w\-\.]+$/; 
		if (!re2.test(document.getElementById("wan_l2tp_server").value)) {
			Alert.render("<!--#tr id="wan.alert.14"-->L2TP Server IP Address format incorrect!<!--#endtr-->");
			return false;
		}
		
		if (document.getElementById("l2tpMode_select").selectedIndex == 1) {		
			
			if (!checkIpAddr(document.getElementById("wan_l2tp_ip_address"), false)) {
				return false;
			}
			
			if (!checkIpAddr(document.getElementById("wan_l2tp_subnet_mask"), true)) {
				return false;
			}
						
			if (document.getElementById("wan_l2tp_gateway").value != "") {
				if (!checkIpAddr(document.getElementById("wan_l2tp_gateway"), false)) {
					return false;
				}
			}
						
		}
		
		return true;
	} else if (connection_mode == '4') { //PPTP
		if (document.getElementById("wan_pptp_password").value != document.getElementById("second_wan_pptp_password").value) {
			Alert.render("<!--#tr id="wan.alert.3"-->Password mismatched!<!--#endtr-->");
			return false;
		} 
		
		if (document.getElementById("wan_pptp_username").value == "") {
			Alert.render("<!--#tr id="wi.alert.4"-->PPTP user name is blank!<!--#endtr-->");
			return false;
		}
		
		// u-media(rh001)-Griffin Wang-TEW691GR ([+Add PPTP username, password check function])
		if (document.getElementById("wan_pptp_password").value == "") {
			Alert.render("<!--#tr id="wan.alert.32"-->PPTP password is blank!<!--#endtr-->");
			return false;
		}
		
		if (document.getElementById("wan_pptp_username").value.indexOf("\"") > -1) {
			Alert.render("<!--#tr id="wan.alert.21"-->PPTP Server User Name have invalid characters <!--#endtr-->");
			return false; 
		}
		if (document.getElementById("wan_pptp_password").value.indexOf("\"") > -1) {
			Alert.render("<!--#tr id="wan.alert.22"-->PPTP Server Password have invalid characters <!--#endtr-->");
			return false; 
		}
		
		if (!checkIpAddr(document.getElementById("wan_pptp_server"), false)) {
			document.getElementById("wan_pptp_server").focus();
			return false; 
		}
		
		var re = /^[\w\-\.]+$/; 
		if (!re.test(document.getElementById("wan_pptp_server").value)) {
			Alert.render("<!--#tr id="wan.alert.19"-->PPTP Server IP Address only accept [0-9a-zA-Z_-.] characters.<!--#endtr-->");
			return false;
		}
		var re2 = /^[\w\-\.]+\.[\w\-\.]+$/; 
		if (!re2.test(document.getElementById("wan_pptp_server").value)) {
			Alert.render("<!--#tr id="wan.alert.20"-->PPTP Server IP Address format incorrect!<!--#endtr-->");
			return false;
		}
		
		if (document.getElementById("pptpMode_select").selectedIndex == 1) {
		
			if (!checkIpAddr(document.getElementById("wan_pptp_ip_address"), false)) {
				return false;
			}
		
			if (!checkIpAddr(document.getElementById("wan_pptp_subnet_mask"), true)) {
				return false;
			} 
			
			if (document.getElementById("wan_pptp_gateway").value != "") {
				if (!checkIpAddr(document.getElementById("wan_pptp_gateway"), false)) {
					return false;
				}
			} 
			
			if (document.getElementById("wan_pptp_pridns").value != "") {
				if (!checkIpAddr(document.getElementById("wan_pptp_pridns"), false)) {
					return false;
				}
			} 
			
			if (document.getElementById("wan_pptp_secdns").value != "") {
				if (!checkIpAddr(document.getElementById("wan_pptp_secdns"), false)) {
					return false;
				}
			}
		} 
		
		return true;
	} else {
		Alert.render("<!--#tr id="wi.alert.2"-->Unknown Internet Connection Type, please check the setting again.<!--#endtr-->");
		return false;
	}
	
	return true;
}

/*
 * Show/Hide wizard pages and buttons.
 */
function wz_showhide()
{
	for (var i = 1; i <= wz_max; i++) {
		document.getElementById("wz_page_" + i).style.display = wz_cur == i ? "block" : "none";
	}
	ddaccordion.expandone('expandable', wz_cur-1);
	disable_form_field(document.getElementById("wz_prev_b"), wz_cur == wz_min ? true : false);
	disable_form_field(document.getElementById("wz_next_b"), wz_cur == wz_max ? true : false);
	disable_form_field(document.getElementById("wz_save_b"), wz_cur == wz_max ? false : true);
	scroll(0, 0);
}

/*
 * Validate current page and then show next page.
 */
function wz_next()
{
	if (typeof(wz_verify[wz_cur - 1]) == "function" && !wz_verify[wz_cur - 1]()) {		
		return;
	}

	if (connection_mode == 1 && wz_cur == 2) // DHCP mode & Step 1, TRENDnet request do not goto Step 2.
		wz_cur = wz_max;
	else
		wz_cur++;
	if (wz_cur == wz_max) { 		
		update_summary();
	}
	wz_showhide();
}

/*
 * Show previous page.
 */
function wz_prev()
{
	if (connection_mode == 1 && wz_cur == wz_max) // DHCP mode & Step 3, TRENDnet request do not goto Step 2.
		wz_cur = 2;
	else
		wz_cur--;
	wz_showhide();
}

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
		Alert.render("<!--#tr id="wan.alert.1"-->Cannot create an XMLHTTP instance<!--#endtr-->");
		return false;
	}
	http_request.onreadystatechange = doFillMyMAC;

	http_request.open('POST', '/goform/getMyMAC', true);
	http_request.send('n\a');
}

function doFillMyMAC()
{
	if (http_request.readyState == 4) {
		if (http_request.status == 200) {
			document.getElementById("mac_cloning_address").value = http_request.responseText;
		} else {
			Alert.render("<!--#tr id="wan.alert.2"-->Can\'t get the mac address.<!--#endtr-->");
		}
	}
}

function confirmCheck(confirmvalue){
	if(confirmvalue == "nochange_exit") {
		document.getElementById("wz_cancel_b").disabled = true;
		document.wizardset.submit();
		totalWaitTime = 3; //second
	} else if (confirmvalue == "exit") {
		no_reboot();
	} else if (confirmvalue == "save") {
		totalWaitTime = 25; //second
		wait_page();
		document.getElementById("waitPad").style.display="block";
		scroll(0,0);
		document.getElementById("wan_apply").click();
	}
}

function page_submit()
{
	if (connection_mode == 0) { //STATIC
		document.wan.wan_proto.selectedIndex = 1;
		document.wan.wan_ipaddr.value = document.getElementById("wan_ip_address").value; 
		document.wan.wan_netmask.value = document.getElementById("wan_subnet_mask").value;
		document.wan.wan_gateway.value = document.getElementById("wan_gateway").value;
		document.wan.wan_dns0.value = document.getElementById("wan_primary_dns").value;
		document.wan.wan_dns1.value = document.getElementById("wan_secondary_dns").value;		
	} else if (connection_mode == 1) { //DHCP
		document.wan.wan_proto.selectedIndex = 0;
		document.wan.wan_hostname.value = document.getElementById("wan_dhcp_gw_name").value;
		document.wan.wan_hwaddr.value = document.getElementById("mac_cloning_address").value;
	} else if (connection_mode == 2) { //PPPoE
		document.wan.wan_proto.selectedIndex = 2;
		document.wan.wan_pppoe_username.value = document.getElementById("pppoe_username").value;
		document.wan.wan_pppoe_passwd.value = document.getElementById("pppoe_password").value;
	} else if (connection_mode == 3) { //L2TP
		document.wan.wan_proto.selectedIndex = 4;
		document.wan.wan_l2tp_server_name.value = document.getElementById("wan_l2tp_server").value;
		document.wan.wan_l2tp_username.value = document.getElementById("wan_l2tp_username").value;
		document.wan.wan_l2tp_passwd.value = document.getElementById("wan_l2tp_password").value;
		document.wan.wan_l2tp_static.options.selectedIndex = document.getElementById("l2tpMode_select").options.selectedIndex;
		document.wan.wan_l2tp_ipaddr.value = document.getElementById("wan_l2tp_ip_address").value;
		document.wan.wan_l2tp_netmask.value = document.getElementById("wan_l2tp_subnet_mask").value;
		document.wan.wan_l2tp_gateway.value = document.getElementById("wan_l2tp_gateway").value;
	} else if (connection_mode == 4) { //PPTP
		document.wan.wan_proto.selectedIndex = 3;
		document.wan.wan_pptp_server_name.value = document.getElementById("wan_pptp_server").value;
		document.wan.wan_pptp_username.value = document.getElementById("wan_pptp_username").value;
		document.wan.wan_pptp_passwd.value = document.getElementById("wan_pptp_password").value;
		document.wan.wan_pptp_static.options.selectedIndex = document.getElementById("pptpMode_select").options.selectedIndex;
		document.wan.wan_pptp_localip.value = document.getElementById("wan_pptp_ip_address").value;
		document.wan.wan_pptp_netmask.value = document.getElementById("wan_pptp_subnet_mask").value;
		document.wan.wan_pptp_gateway.value = document.getElementById("wan_pptp_gateway").value;
		document.wan.wan_pptp_dns0.value = document.getElementById("wan_pptp_pridns").value;
		document.wan.wan_pptp_dns1.value = document.getElementById("wan_pptp_secdns").value;
	} else {
		Alert.render("<!--#tr id="wi.alert.2"-->Unknown Internet Connection Type, please check the setting again.<!--#endtr-->");
		return false;
	}
	
	Confirm.render("<!--#tr id="wz.confirm.3"-->Save and apply the changes?<!--#endtr-->","confirmCheck","save","","");
	return true; 
}

function page_cancel()
{
	var WizardConfigured = "<% nvram_get("WizardConfigured"); %>";

	if (WizardConfigured*1 != 1)
		Confirm.render("<!--#tr id="wz.confirm.2"-->There will be no changes applied to your device until the setup wizard is completed, are you sure you want to exit the wizard?<!--#endtr-->","confirmCheck","nochange_exit","","");
	else
		Confirm.render ("<!--#tr id="wz.confirm.1"-->Are you sure want to exit this wizard?<!--#endtr-->","confirmCheck","exit","","");
}

function update_summary()
{
	for (var i = 0; i <= 4; i++) {
		document.getElementById("wan_summary_" + i).style.display = connection_mode == i ? "block" : "none";
	}
	if (connection_mode == 0) {
		document.getElementById("wan_summary_type").innerHTML = "<!--#tr id="wan.static"-->Static<!--#endtr-->";
		document.getElementById("wan_summary_0_ip_address").innerHTML = document.getElementById("wan_ip_address").value;
		document.getElementById("wan_summary_0_subnet_mask").innerHTML = document.getElementById("wan_subnet_mask").value
		document.getElementById("wan_summary_0_gateway").innerHTML = document.getElementById("wan_gateway").value;
		document.getElementById("wan_summary_0_primary_dns").innerHTML = document.getElementById("wan_primary_dns").value;
		document.getElementById("wan_summary_0_secondary_dns").innerHTML = document.getElementById("wan_secondary_dns").value;
	} else if (connection_mode == 1) {
		document.getElementById("wan_summary_type").innerHTML = "<!--#tr id="wan.dhcp"-->DHCP<!--#endtr-->";
		document.getElementById("wan_summary_1_dhcp_gw_name").innerHTML = document.getElementById("wan_dhcp_gw_name").value;
	} else if (connection_mode == 2) {
		document.getElementById("wan_summary_type").innerHTML = "<!--#tr id="wan.pppoe"-->PPPoE<!--#endtr-->";
		document.getElementById("wan_summary_2_pppoe_username").innerHTML = document.getElementById("pppoe_username").value;
		//document.getElementById("wan_summary_2_pppoe_password").innerHTML = document.getElementById("pppoe_password").value);
	} else if (connection_mode == 3) {
		document.getElementById("wan_summary_type").innerHTML = "<!--#tr id="wan.l2tp"-->L2TP<!--#endtr-->";
		document.getElementById("wan_summary_3_l2tp_server").innerHTML = document.getElementById("wan_l2tp_server").value;
		document.getElementById("wan_summary_3_l2tp_username").innerHTML = document.getElementById("wan_l2tp_username").value;
		//document.getElementById("wan_summary_3_l2tp_password").innerHTML = document.getElementById("wan_l2tp_password").value;
		if (document.getElementById("l2tpMode_select").options.selectedIndex == 1) {
			document.getElementById("wan_summary_3_l2tpmode").innerHTML = "<!--#tr id="wan.static"-->Static<!--#endtr-->";
			document.getElementById("wan_summary_3_l2tpmode_field").style.display = style_display_on_tbody();
			document.getElementById("wan_summary_3_l2tpmode_field").style.visibility = "visible";
			document.getElementById("wan_summary_3_l2tp_ip_address").innerHTML = document.getElementById("wan_l2tp_ip_address").value;
			document.getElementById("wan_summary_3_l2tp_subnet_mask").innerHTML = document.getElementById("wan_l2tp_subnet_mask").value;
			document.getElementById("wan_summary_3_l2tp_gateway").innerHTML = document.getElementById("wan_l2tp_gateway").value;
		} else { 
			document.getElementById("wan_summary_3_l2tpmode").innerHTML = "<!--#tr id="wan.dynamic"-->Dynamic<!--#endtr-->";
			document.getElementById("wan_summary_3_l2tpmode_field").style.display = "none";
			document.getElementById("wan_summary_3_l2tpmode_field").style.visibility = "hidden";
		}		
	} else if (connection_mode == 4) {
		document.getElementById("wan_summary_type").innerHTML = "<!--#tr id="wan.pptp"-->PPTP<!--#endtr-->";
		document.getElementById("wan_summary_4_pptp_server").innerHTML = document.getElementById("wan_pptp_server").value;
		document.getElementById("wan_summary_4_pptp_username").innerHTML = document.getElementById("wan_pptp_username").value;
		//document.getElementById("wan_summary_4_pptp_password").innerHTML = document.getElementById("wan_pptp_password").value;
		document.getElementById("wan_summary_4_pptpmode").innerHTML = (document.getElementById("pptpMode_select").selectedIndex == 1)? "Static":"Dynamic";
		if (document.getElementById("pptpMode_select").options.selectedIndex == 1) {
			document.getElementById("wan_summary_4_pptpmode").innerHTML = "<!--#tr id="wan.static"-->Static<!--#endtr-->";
			document.getElementById("wan_summary_4_pptpmode_field").style.display = style_display_on_tbody();
			document.getElementById("wan_summary_4_pptpmode_field").style.visibility = "visible";
			document.getElementById("wan_summary_4_pptp_ip_address").innerHTML = document.getElementById("wan_pptp_ip_address").value;
			document.getElementById("wan_summary_4_pptp_subnet_mask").innerHTML = document.getElementById("wan_pptp_subnet_mask").value;
			document.getElementById("wan_summary_4_pptp_gateway").innerHTML = document.getElementById("wan_pptp_gateway").value;
			document.getElementById("wan_summary_4_pptp_pridns").innerHTML = document.getElementById("wan_pptp_pridns").value;
			document.getElementById("wan_summary_4_pptp_secdns").innerHTML = document.getElementById("wan_pptp_secdns").value;
		} else {
			document.getElementById("wan_summary_4_pptpmode").innerHTML = "<!--#tr id="wan.dynamic"-->Dynamic<!--#endtr-->";
			document.getElementById("wan_summary_4_pptpmode_field").style.display = "none";
			document.getElementById("wan_summary_4_pptpmode_field").style.visibility = "hidden";
		}		
	} else {
		document.getElementById("wan_summary_type").innerHTML = "<!--#tr id="ebd.wifi.3"-->Unknow<!--#endtr-->";
	}
}

function no_reboot()
{
	if (no_reboot_alt_location) {
		top.location.href = no_reboot_alt_location;
		return;
	}
}

function do_reboot()
{
	top.location = "/cgi-bin/systemreboot.cgi"
}

function disable_form_field(field, disable)
{
	if (disable != true && disable != false) {
		disable = !field.disabled;
	}
	if (disable) {
		add_class(field, "disabled");
	} else {
		remove_class(field, "disabled");
	}
	field.disabled = disable;
}

/*
 * has_class(element, class_name)
 *	Tests whether the specified HTML element has a particular CSS class.
 */
function has_class(element, class_name)
{
	if (!element.className) {
		element.className = "";
		return false;
	}

	/*
	 * This regex is similar to \bclassName\b, except that \b does not
	 * treat certain legal CSS characters as "word characters": notably,
	 * the . and - characters.
	 */
	var regex = new RegExp("(^|\\s)\\s*" + class_name + "\\s*(\\s|$)");
	return regex.test(element.className);
}

/*
 * remove_class(element, class_name)
 *	Remove the requested CSS class from an HTML element. If the element does not
 *	currently have the requested class, this function does nothing.
 */
function remove_class(element, class_name)
{
	if (!element.className) {
		element.className = "";
		return;
	}
	
	/*
	 * This regex is similar to \bclassName\b, except that \b does not
	 * treat certain legal CSS characters as "word characters": notably,
	 * the . and - characters.
	 */
	var regex = new RegExp("(^|\\s)\\s*" + class_name + "\\s*(\\s|$)");
	element.className = element.className.replace(regex, "$1$2");
}

/*
 * add_class(element, class_name)
 *	Add the requested CSS class from an HTML element. If the element 
 *	already has the requested class, this function does nothing.
 */
function add_class(element, class_name)
{
	if (has_class(element, class_name)) {
		return;
	}
	element.className += (element.className == "" ? "" : " ") + class_name;
}

/*
 * trim_string
 *	Remove leading and trailing blank spaces from a string.
 */
function trim_string(str)
{
	var trim = str + "";
	trim = trim.replace(/^\s*/, "");
	return trim.replace(/\s*$/, "");
}

function wan_mode_selector(mode)
{
	//var form_handle = wz_form_handles[3];
	//form_handle.wan_ip_mode.value = (mode == BIGPOND)? DHCP : mode;
	//form_handle.bigpond_enable.value = (mode == BIGPOND)? "true" : "false";
	set_radio(mf.wan_ip_mode_radio, mode);
	for (var i = 0; i < mf.wan_ip_mode_radio.length; i++) {
		document.getElementById("wan_ip_mode_box_" + i).style.display = (mode == i)? "block" : "none";
	}
}

/*
 * set_radio
 *	Sets the radio button whose value matches that give (unchecking all others in the group)
 * NOTE: Radio group 
 */
function set_radio(radio_group, value)
{
	/*
	 * Convert value to a string so that it will match properly on the radio.value property
	 */
	value = "" + value;

	/*
	 * Iterate through the radio groups radio buttons, activating the one with the matching value
	 */
	for (var i = 0; i < radio_group.length; i++) {
		if (radio_group[i].value == value) {
			radio_group[i].checked = true;
			return;
		}
	}
}

function initValue()
{
	var mode = "<% nvram_get("wan_proto"); %>";
	var l2tpMode = "<% nvram_get("wan_l2tp_static"); %>"; //Add for l2tp operation by Ricky Cao	
	var pptpMode = "<% nvram_get("wan_pptp_static"); %>";
	
	if (mode == "static") {
		document.wan.wan_proto.options.selectedIndex = 1;
		document.getElementById("wan_ip_mode_radio_0").checked = true;
		wan_mode_selector(0);
	}
	else if (mode == "dhcp") {
		document.wan.wan_proto.options.selectedIndex = 0;
		document.getElementById("wan_ip_mode_radio_1").checked = true;
		wan_mode_selector(1);
	}
	else if (mode == "pppoe") {
		document.wan.wan_proto.options.selectedIndex = 2;
		document.getElementById("wan_ip_mode_radio_2").checked = true;
		wan_mode_selector(2);
	}
	else if (mode == "l2tp") {
		document.wan.wan_proto.options.selectedIndex = 4;
		document.wan.wan_l2tp_static.options.selectedIndex = 1*l2tpMode; //Add for l2tp operation by Ricky Cao
		document.getElementById("wan_ip_mode_radio_3").checked = true;
		wan_mode_selector(3);
	}
	else if (mode == "pptp") {
		document.wan.wan_proto.options.selectedIndex = 3;
		document.wan.wan_pptp_static.options.selectedIndex = 1*pptpMode;
		document.getElementById("wan_ip_mode_radio_4").checked = true;
		wan_mode_selector(4);
	}
	else {
		document.wan.wan_proto.options.selectedIndex = 0;
		wan_mode_selector(0);
	}
	//connectionTypeSwitch();

	if (1*l2tpMode == 1) {
		document.getElementById("l2tpMode_select").selectedIndex = 1;
	} else {
		document.getElementById("l2tpMode_select").selectedIndex = 0;
	}
	l2tpModeSwitch();

	if (1*pptpMode == 1) {
		document.getElementById("pptpMode_select").selectedIndex = 1;
	} else {
		document.getElementById("pptpMode_select").selectedIndex = 0;
	}
	pptpModeSwitch();
}

function l2tpModeSwitch()
{
	if (document.getElementById("l2tpMode_select").selectedIndex == 1) {
		document.getElementById("l2tp_mode_ip").style.display = style_display_on_tr();
		document.getElementById("l2tp_mode_ip").style.visibility = "visible";	
		document.getElementById("l2tp_mode_mask").style.display = style_display_on_tr();
		document.getElementById("l2tp_mode_mask").style.visibility = "visible";	
		document.getElementById("l2tp_mode_gateway").style.display = style_display_on_tr();
		document.getElementById("l2tp_mode_gateway").style.visibility = "visible";	
	}
	else {
		document.getElementById("l2tp_mode_ip").style.display = "none";
		document.getElementById("l2tp_mode_ip").style.visibility = "hidden";
		document.getElementById("l2tp_mode_mask").style.display = "none";
		document.getElementById("l2tp_mode_mask").style.visibility = "hidden";	
		document.getElementById("l2tp_mode_gateway").style.display = "none";
		document.getElementById("l2tp_mode_gateway").style.visibility = "hidden";	
	}
}

function pptpModeSwitch()
{
	if (document.getElementById("pptpMode_select").selectedIndex == 1) {
		document.getElementById("pptp_mode_ip").style.display = style_display_on_tr();
		document.getElementById("pptp_mode_ip").style.visibility = "visible";	
		document.getElementById("pptp_mode_mask").style.display = style_display_on_tr();
		document.getElementById("pptp_mode_mask").style.visibility = "visible";	
		document.getElementById("pptp_mode_gateway").style.display = style_display_on_tr();
		document.getElementById("pptp_mode_gateway").style.visibility = "visible";	
		document.getElementById("pptp_mode_pridns").style.display = style_display_on_tr();
		document.getElementById("pptp_mode_pridns").style.visibility = "visible";	
		document.getElementById("pptp_mode_secdns").style.display = style_display_on_tr();
		document.getElementById("pptp_mode_secdns").style.visibility = "visible";	
	}
	else {
		document.getElementById("pptp_mode_ip").style.display = "none";
		document.getElementById("pptp_mode_ip").style.visibility = "hidden";
		document.getElementById("pptp_mode_mask").style.display = "none";
		document.getElementById("pptp_mode_mask").style.visibility = "hidden";	
		document.getElementById("pptp_mode_gateway").style.display = "none";
		document.getElementById("pptp_mode_gateway").style.visibility = "hidden";	
		document.getElementById("pptp_mode_pridns").style.display = "none";
		document.getElementById("pptp_mode_pridns").style.visibility = "hidden";	
		document.getElementById("pptp_mode_secdns").style.display = "none";
		document.getElementById("pptp_mode_secdns").style.visibility = "hidden";	
	}
}

// Ryan 2013.04.16 add to modify CatTitle abnormally  
function str_spacing()
{
	//case by case
	if (lang=="EN") {
		document.getElementById("wi_num1").style.margin = "0px 0px 0px 65px";
		document.getElementById("wi_num2").style.margin = "0px 0px 0px 65px";
		document.getElementById("wi_num3").style.margin = "-12px 0px 0px 65px";
		document.getElementById("wi_num4").style.margin = "0px 0px 0px 65px";
	} else if (lang=="DE") {
		document.getElementById("wi_num1").style.margin = "0px 0px 0px 65px";
		document.getElementById("wi_num2").style.margin = "0px 0px 0px 65px";
		document.getElementById("wi_num3").style.margin = "0px 0px 0px 65px";
		document.getElementById("wi_num4").style.margin = "0px 0px 0px 65px";
	} else if (lang=="FR") {
		document.getElementById("wi_num1").style.margin = "0px 0px 0px 65px";
		document.getElementById("wi_num2").style.margin = "0px 0px 0px 65px";
		document.getElementById("wi_num3").style.margin = "-12px 0px 0px 65px";
		document.getElementById("wi_num4").style.margin = "0px 0px 0px 65px";
	} else if (lang=="ESP") {
		document.getElementById("wi_num1").style.margin = "0px 0px 0px 65px";
		document.getElementById("wi_num2").style.margin = "-12px 0px 0px 65px";
		document.getElementById("wi_num3").style.margin = "-12px 0px 0px 65px";
		document.getElementById("wi_num4").style.margin = "0px 0px 0px 65px";
	} else if (lang=="RU") {
		document.getElementById("wi_num1").style.margin = "-12px 0px 0px 65px";
		document.getElementById("wi_num2").style.margin = "-12px 0px 0px 65px";
		document.getElementById("wi_num3").style.margin = "-12px 0px 0px 65px";
		document.getElementById("wi_num4").style.margin = "0px 0px 0px 65px";
	}
}

function update_wireless_summary()
{
	var ssid_2g = "<% getWirelessInfo("wl0"); %>";
	var ssid_5g = "<% getWirelessInfo("wl1"); %>";

	document.getElementById("wlan_summary_ssid_2g").innerHTML = transSSIDForInnerHtml(ssid_2g);
	document.getElementById("wlan_summary_ssid_5g").innerHTML = transSSIDForInnerHtml(ssid_5g);
}

function show_error()
{
	Alert.render("<!--#tr id="wi.alert.6"-->Command Injection<!--#endtr-->");
	top.location.href = "/wizard/wizard_internet.asp";
}
function page_load()
{
	// AnnieWeng @20130628: showing alert when having import error
	var strUrl = location.search;
	var ParaVal;
	var cgi_reply = "";
	if (strUrl.indexOf("?") != -1) {
		ParaVal = strUrl.split("=");
		//Get cgi_reply from nvramul.cgi
		cgi_reply = ParaVal[1];
	}
	// ~AnnieWeng @20130628
	mf = document.forms.mainform_submit;
	initValue();
	ddaccordion.expandone('expandable', 0);
	str_spacing(); //Tom.Hung 2013-7-30, need fix
	update_wireless_summary();
	// AnnieWeng @20130628: showing alert when having import error
	if (cgi_reply == "command_injection") {
		show_error();
	}
	// ~AnnieWeng @20130628
}
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
	revealtype: "none", //Reveal content when user clicks or onmouseover the header? Valid value: "click", "clickgo", or "mouseover"
	mouseoverdelay: 0, //if revealtype="mouseover", set delay in milliseconds before header expands onMouseover
	collapseprev: true, //Collapse previous content (so only one open at any time)? true/false 
	defaultexpanded: [], //index of content(s) open by default [index1, index2, etc]. [] denotes no content
	onemustopen: false, //Specify whether at least one header should be open always (so never all headers closed)
	animatedefault: false, //Should contents open by default be animated into view?
	persiststate: false, //persist state of opened contents within browser session?
	toggleclass: ["", "openheader"], //Two CSS classes to be applied to the header when it's collapsed and expanded, respectively ["class1", "class2"]
	togglehtml: ["src", "../images/but_wizard_0.png", "../images/but_wizard_1.png"], //Additional HTML added to the header when it's collapsed and expanded, respectively  ["position", "html1", "html2"] (see docs)
	animatespeed: 0, //speed of animation: integer in milliseconds (ie: 200), or keywords "fast", "normal", or "slow"
	oninit:function(headers, expandedindices){ //custom code to run when headers have initalized
		//do nothing
	},
	onopenclose:function(header, index, state, isuseractivated){ //custom code to run whenever a header is opened or closed
		//do nothing
	}
})

ddaccordion.init({ //2nd level headers initialization
	headerclass: "subexpandable", //Shared CSS class name of sub headers group that are expandable
	contentclass: "subcategoryitems", //Shared CSS class name of sub contents group
	revealtype: "click", //Reveal content when user clicks or onmouseover the header? Valid value: "click" or "mouseover
	mouseoverdelay: 500, //if revealtype="mouseover", set delay in milliseconds before header expands onMouseover
	collapseprev: true, //Collapse previous content (so only one open at any time)? true/false 
	defaultexpanded: [], //index of content(s) open by default [index1, index2, etc]. [] denotes no content
	onemustopen: false, //Specify whether at least one header should be open always (so never all headers closed)
	animatedefault: true, //Should contents open by default be animated into view?
	persiststate: false, //persist state of opened contents within browser session?
	toggleclass: ["opensubheader", "closedsubheader"], //Two CSS classes to be applied to the header when it's collapsed and expanded, respectively ["class1", "class2"]
	togglehtml: ["none", "", ""], //Additional HTML added to the header when it's collapsed and expanded, respectively  ["position", "html1", "html2"] (see docs)
	animatespeed: 250, //speed of animation: integer in milliseconds (ie: 200), or keywords "fast", "normal", or "slow"
	oninit:function(headers, expandedindices){ //custom code to run when headers have initalized
		//do nothing
	},
	onopenclose:function(header, index, state, isuseractivated){ //custom code to run whenever a header is opened or closed
		//do nothing
	}
})
</script>
<style>
.CatImage
{
	position:absolute;
	margin: -12px 5px 0px 12px;
}

.CatNumber
{
	font:bold 32px Arial;
	position:absolute;
	margin: -10px 0px 0px 14px;
	z-index:100;
	width:50px;
}

.CatTitle
{
	font:bold 18px Arial;
	position: absolute;
	margin: 0px 0px 5px 65px;
	z-index: 1000;
	width: 150px;
	text-indent:0px;
}
</style>
	<!-- InstanceBeginEditable name="Left Content" -->
<div class="arrowlistmenu" style="padding-top: 0px">
    <div class="homenav" style="margin-bottom:20px"> <img src="../images/but_setup_wizard<!--#tr id="image.lang.png"-->.png<!--#endtr-->" border="0"></div>
    <div class="borderbottom" > </div>

	<div class="menuheader expandable" style="cursor:auto"><img src="/images/but_wizard_0.png" class="CatImage"><span class="CatNumber">1</span><span id="wi_num1" class="CatTitle"><!--#tr id="wi.node.1"-->Welcome<!--#endtr--></span></div>
	<ul class="categoryitems">
		<li style="display:none;"></li>
	</ul>

	<div class="menuheader expandable" style="cursor:auto"><img src="/images/but_wizard_0.png" class="CatImage"><span class="CatNumber">2</span><span id="wi_num2" class="CatTitle"><!--#tr id="wi.node.2"-->Connection Type<!--#endtr--></span></div>
	<ul class="categoryitems">
		<li style="display:none;"></li>
	</ul>

	<div class="menuheader expandable" style="cursor:auto"><img src="/images/but_wizard_0.png" class="CatImage"><span class="CatNumber">3</span><span id="wi_num3" class="CatTitle"><!--#tr id="wi.node.3"-->Connection Setup<!--#endtr--></span></div>
	<ul class="categoryitems">
		<li style="display:none;"></li>
	</ul>

	<div class="menuheader expandable" style="cursor:auto"><img src="/images/but_wizard_0.png" class="CatImage"><span class="CatNumber">4</span><span id="wi_num4" class="CatTitle"><!--#tr id="wi.node.4"-->Complete<!--#endtr--></span></div>
	<ul class="categoryitems">
		<li style="display:none;"></li>
	</ul>
</div>
	<!-- InstanceEndEditable -->
						<!--END LEFT NAVIGATION --> 
<script type="text/javascript" src="../scripts/xpmenu.js"></script>
					</td>
					<td style="width:670px; padding: 10px 0px 0px 15px; " valign="top" class="txt_main">
<iframe class="rebootRedirect" name="rebootRedirect" id="rebootRedirect" frameborder="0" width="1" height="1" scrolling="no" src="" style="display:none">redirect</iframe>
<div id="waitform"></div>
<div id="mainform">
	<div id="main_content">
	<!-- InstanceBeginEditable name="Main Content" -->
	<form id="mainform_submit" action="" method="post">
	<div id="wz_page_1">
		<h1><!--#tr id="wi.1"-->Welcome to the Internet Connection Setup Wizard<!--#endtr--></h1>
		<div class="hr" ></div>
		<p class="header_desc"><!--#tr id="wi.2"-->This wizard will guide you through a step-by-step process to configure your router and connect to the Internet.<!--#endtr--></p>
		<table class="tbl_main" summary="wizard intro" width="100%">
			<tr><td>													
				<ul>
					<li><!--#tr id="wi.3"-->Step 1: Select your Internet Connection Type<!--#endtr--></li>
					<li><!--#tr id="wi.4"-->Step 2: Configure your Internet Connection<!--#endtr--></li>
					<li><!--#tr id="wi.5"-->Step 3: Save Settings and Connect<!--#endtr--></li>
				</ul>
			</td></tr>
		</table>
	</div><!-- wz_page_1 -->

	<div id="wz_page_2" style="display:none">
		<h1><!--#tr id="wi.3"-->Step 1: Select your Internet Connection Type<!--#endtr--></h1>
		<div class="hr" ></div>
		<p class="header_desc"><!--#tr id="wi.6"-->Please select the Internet connection type below:<!--#endtr--></p>
		<table id="wan_modes" class="tbl_main" summary="wizard wan mode select">
			<input type="hidden" id="internet_service_provider" name="config.internet_service_provider" value=""/>
			<input type="hidden" id="wan_ip_mode" name="config.wan_ip_mode" value=""/>
			<tr>
				<td class="CR2"><input type="radio" id="wan_ip_mode_radio_1" name="wan_ip_mode_radio" value="1" onchange="wan_mode_selector(this.value);"/></td>
				<td class="CR2">
					<label class="duple" for="wan_ip_mode_radio_1"><strong><!--#tr id="wi.9"-->DHCP Connection (Dynamic IP Address)<!--#endtr--></strong></label>
					<div class="itemhelp"><!--#tr id="wi.10"-->Choose this option if your Internet connection automatically provides you with an IP Address. Most Cable ISPs use this type of connection.<!--#endtr--></div>
				</td>
			</tr>
			<tr>
				<td class="CR2"><input type="radio" id="wan_ip_mode_radio_0" name="wan_ip_mode_radio" value="0" onchange="wan_mode_selector(this.value);"/></td>
				<td class="CR2">
					<label class="duple" for="wan_ip_mode_radio_0"><strong><!--#tr id="wi.7"-->Static IP Address Connection<!--#endtr--></strong></label>
					<div class="itemhelp"><!--#tr id="wi.8"-->Choose this option if your Internet service provider provided you with IP address information that has to be manually configured.<!--#endtr--></div>
				</td>
			</tr>
			<tr>
				<td class="CR2"><input type="radio" id="wan_ip_mode_radio_2" name="wan_ip_mode_radio" value="2" onchange="wan_mode_selector(this.value);"/></td>
				<td class="CR2">
					<label class="duple" for="wan_ip_mode_radio_2"><strong><!--#tr id="wi.11"-->Username / Password Connection (PPPoE)<!--#endtr--></strong></label>
					<div class="itemhelp"><!--#tr id="wi.12"-->Choose this option if your Internet connection requires a username and password to get online. Most DSL ISPs use this type of connection.<!--#endtr--></div>
				</td>
			</tr>
			<tr>
				<td class="CR2"><input type="radio" id="wan_ip_mode_radio_3" name="wan_ip_mode_radio" value="3" onchange="wan_mode_selector(this.value);"/></td>
				<td class="CR2">	
					<label class="duple" for="wan_ip_mode_radio_3"><strong><!--#tr id="wi.13"-->Username / Password Connection (L2TP)<!--#endtr--></strong></label>
					<div class="itemhelp"><!--#tr id="wi.14"-->L2TP client.<!--#endtr--></div>
				</td>
			</tr>
			<tr>
				<td class="CR2"><input type="radio" id="wan_ip_mode_radio_4" name="wan_ip_mode_radio" value="4" onchange="wan_mode_selector(this.value);"/></td>
				<td class="CR2">
					<label class="duple" for="wan_ip_mode_radio_4"><strong><!--#tr id="wi.15"-->Username / Password Connection (PPTP)<!--#endtr--></strong></label>
					<div class="itemhelp"><!--#tr id="wi.16"-->PPTP client.<!--#endtr--></div>
				</td>
			</tr>
		</table>
	</div><!-- wz_page_2 -->

	<div id="wz_page_3" style="display:none">
		<div id="wan_ip_mode_box_0" style="display:none">
			<h1><!--#tr id="wi.4-1"-->Step 2: Set Static IP Address Connection<!--#endtr--></h1>
			<div class="hr" ></div>
			<p class="header_desc"><!--#tr id="wi.17"-->To set up this connection you will need to have a complete list of IP information provided by your Internet Service Provider. If you have a Static IP connection and do not have this information, please contact your ISP.<!--#endtr--></p>
			<table class="tbl_main" summary="wizard wan mode">
				<tr>
					<td class="CL"><label class="duple" for="wan_ip_address"><!--#tr id="wi.18"-->IP Address<!--#endtr--></label></td>
					<td class="CR"><input type="text" id="wan_ip_address" name="config.wan_ip_address" size="20" maxlength="15" value="<% nvram_get("wan_ipaddr"); %>"/></td>
				</tr>
				<tr>
					<td class="CL"><label class="duple" for="wan_subnet_mask"><!--#tr id="wi.19"-->Subnet Mask<!--#endtr--></label></td>
					<td class="CR"><input type="text" id="wan_subnet_mask" name="config.wan_subnet_mask" size="20" maxlength="15" value="<% nvram_get("wan_netmask"); %>"/></td>
				</tr>
				<tr>
					<td class="CL"><label class="duple" for="wan_gateway"><!--#tr id="wi.20"-->Default Gateway<!--#endtr--></label></td>
					<td class="CR"><input type="text" id="wan_gateway" name="config.wan_gateway" size="20" maxlength="15" value="<% nvram_get("wan_gateway"); %>"/></td>
				</tr>
				<tr>
					<td class="CL"><label class="duple" for="wan_primary_dns"><!--#tr id="wi.21"-->Primary DNS Server<!--#endtr--></label></td>
					<td class="CR"><input type="text" id="wan_primary_dns" name="config.wan_primary_dns" size="20" maxlength="15" value="<% nvram_list("wan_dns", 0); %>"/></td>
				</tr>
				<tr>
					<td class="CL"><label class="duple" for="wan_secondary_dns"><!--#tr id="wi.22"-->Secondary DNS Server<!--#endtr--></label></td>
					<td class="CR"><input type="text" id="wan_secondary_dns" name="config.wan_secondary_dns" size="20" maxlength="15" value="<% nvram_list("wan_dns", 1); %>"/></td>
				</tr>
			</table>
		</div><!-- wan_ip_mode_box_0 -->

		<div id="wan_ip_mode_box_1" style="display:none">
			<h1><!--#tr id="wi.4-2"-->Step 2: DHCP Connection (Dynamic IP Address)<!--#endtr--></h1>
			<div class="hr" ></div>
			<p class="header_desc"><!--#tr id="wi.23"-->To set up DHCP connection, please make sure that you are connected to the router with the PC that was originally connected to your broadband connection. Then copy your computer's MAC Address to the router.<!--#endtr--></p>
			<p class="header_desc"><!--#tr id="wi.24"-->To set up DHCP connection, you may also need to provide a Host Name. If you do not have or know this information, please contact your ISP.<!--#endtr--></p>
			<table class="tbl_main" summary="wizard wan mode">
				<tr>
					<td class="CL"><label class="duple" for="mac_cloning_address"><!--#tr id="wi.25"-->MAC Address<!--#endtr--></label></td>
					<td class="CR"><input type="text" id="mac_cloning_address" name="config.mac_cloning_address" maxlength="17" size="20" value=""/> <!--#tr id="wi.26"-->(optional)<!--#endtr--></td>
				</tr>
				<tr style="display:none">
					<td class="CL"><label class="duple"></label></td>
						<input type="hidden" id="mac_cloning_enabled" name="config.mac_cloning_enabled" value=""/>
					<td class="CR"><input type="button" class="button_submit_NoWidth" value="<!--#tr id="wi.27"-->Clone Your PC's MAC Address<!--#endtr-->" onclick="macCloneMacFillSubmit();"/></td>
				</tr>
				<tr>
					<td class="CL"><label class="duple" for="wan_dhcp_gw_name"><!--#tr id="wi.28"-->Host Name<!--#endtr--></label></td>
					<td class="CR"><input type="text" id="wan_dhcp_gw_name" size="25" maxlength="39" value="<% nvram_get("wan_hostname"); %>" name="config.wan_dhcp_gw_name"/> <!--#tr id="wi.26"-->(optional)<!--#endtr--></td>
				</tr>
			</table>
		</div><!-- wan_ip_mode_box_1 -->
				
		<div id="wan_ip_mode_box_2" style="display:none">
			<h1><!--#tr id="wi.4-3"-->Step 2: Set Username and Password Connection (PPPoE)<!--#endtr--></h1>
			<div class="hr" ></div>
			<p class="header_desc"><!--#tr id="wi.29"-->To set up this connection you will need to have a Username and Password from your Internet Service Provider. If you do not have this information, please contact your ISP.<!--#endtr--></p>
			<table class="tbl_main" summary="wizard wan mode">
				<tr>
					<td class="CL"><label class="duple" for="pppoe_username"><!--#tr id="wi.30"-->User Name<!--#endtr--></label></td>
					<td class="CR"><input type="text" id="pppoe_username" name="config.pppoe_username" size="20" maxlength="64" value="<% nvram_get("wan_pppoe_username"); %>"/></td>
				</tr>
				<tr>
					<td class="CL"><label class="duple" for="pppoe_password"><!--#tr id="wi.31"-->Password<!--#endtr--></label></td>
					<td class="CR"><input type="password" id="pppoe_password" name="config.pppoe_password" size="20" maxlength="63" value="<% nvram_get("wan_pppoe_passwd"); %>" onfocus="select();"/></td>
				</tr>
				<tr>
					<td class="CL"><label class="duple" for="second_pppoe_password"><!--#tr id="wi.32"-->Verify Password<!--#endtr--></label></td>
					<td class="CR"><input type="password" id="second_pppoe_password" size="20" maxlength="63" value="<% nvram_get("wan_pppoe_passwd"); %>" onfocus="select();" /></td>
				</tr>
			</table>
		</div><!-- wan_ip_mode_box_2 -->
				
		<div id="wan_ip_mode_box_3" style="display:none">
			<h1><!--#tr id="wi.4-4"-->Step 2: Set Username and Password Connection (L2TP)<!--#endtr--></h1>
			<div class="hr" ></div>
			<p class="header_desc"><!--#tr id="wi.33"-->To set up this connection you will need to have a Username and Password from your Internet Service Provider. You also need L2TP IP address. If you do not have this information, please contact your ISP.<!--#endtr--></p>
			<table class="tbl_main" summary="wizard wan mode">
				<tr>
					<td class="CL"><label class="duple" for="wan_l2tp_server"><!--#tr id="wi.34"-->L2TP Server IP Address<!--#endtr--></label></td>
					<td class="CR"><input type="text" id="wan_l2tp_server" name="config.wan_l2tp_server" size="20" maxlength="64" value="<% nvram_get("wan_l2tp_server_name"); %>"/> <!--#tr id="wi.35"-->(may be same as gateway)<!--#endtr--></td>
				</tr>
				<tr>
					<td class="CL"><label class="duple" for="wan_l2tp_username"><!--#tr id="wi.30"-->User Name<!--#endtr--></label></td>
					<td class="CR"><input type="text" id="wan_l2tp_username" name="config.wan_l2tp_username" size="20" maxlength="64" value="<% nvram_get("wan_l2tp_username"); %>"/></td>
				</tr>
				<tr>
					<td class="CL"><label class="duple" for="wan_l2tp_password"><!--#tr id="wi.31"-->Password<!--#endtr--></label></td>
					<td class="CR"><input type="password" id="wan_l2tp_password" name="config.wan_l2tp_password" size="20" maxlength="63" value="<% nvram_get("wan_l2tp_passwd"); %>" onfocus="select();"/></td>
				</tr>
				<tr>
					<td class="CL"><label class="duple" for="second_wan_l2tp_password"><!--#tr id="wi.32"-->Verify Password<!--#endtr--></label></td>
					<td class="CR"><input type="password" id="second_wan_l2tp_password" size="20" maxlength="63" value="<% nvram_get("wan_l2tp_passwd"); %>" onfocus="select();" /></td>
				</tr>
				<tr>
					<td class="CL"><label class="duple"><!--#tr id="wi.36"-->WAN Interface IP Type<!--#endtr-->&nbsp;</label></td>
					<td class="CR">
						<select id="l2tpMode_select" name="l2tpMode_select" size="1" onChange="l2tpModeSwitch()">
							<option value="0"><!--#tr id="wi.38"-->Dynamic IP<!--#endtr--></option>
							<option value="1"><!--#tr id="wi.37"-->Static IP<!--#endtr--></option>
						</select>
					</td>
				</tr>
				<tr id="l2tp_mode_ip">
					<td class="CL"><label class="duple" for="wan_l2tp_ip_address"><!--#tr id="wan.8"-->L2TP<!--#endtr--> <!--#tr id="wi.18"-->IP Address<!--#endtr--></label></td>
					<td class="CR"><input type="text" id="wan_l2tp_ip_address" name="config.wan_l2tp_ip_address" size="20" maxlength="15" value="<% nvram_get("wan_l2tp_ipaddr"); %>"/></td>
				</tr>
				<tr id="l2tp_mode_mask">
					<td class="CL"><label class="duple" for="wan_l2tp_subnet_mask"><!--#tr id="wan.8"-->L2TP<!--#endtr--> <!--#tr id="wi.19"-->Subnet Mask<!--#endtr--></label></td>
					<td class="CR"><input type="text" id="wan_l2tp_subnet_mask" name="config.wan_l2tp_subnet_mask" size="20" maxlength="15" value="<% nvram_get("wan_l2tp_netmask"); %>"/></td>
				</tr>
				<tr id="l2tp_mode_gateway">
					<td class="CL"><label class="duple" for="wan_l2tp_gateway"><!--#tr id="wan.8"-->L2TP<!--#endtr--> <!--#tr id="wi.20"-->Default Gateway<!--#endtr--></label></td>
					<td class="CR"><input type="text" id="wan_l2tp_gateway" name="config.wan_l2tp_gateway" size="20" maxlength="15" value="<% nvram_get("wan_l2tp_gateway"); %>"/></td>
				</tr>
			</table>
		</div><!-- wan_ip_mode_box_3 -->
				
		<div id="wan_ip_mode_box_4" style="display:none">
			<h1><!--#tr id="wi.4-5"-->Step 2: Set Username and Password Connection (PPTP)<!--#endtr--></h1>
			<div class="hr" ></div>
			<p class="header_desc"><!--#tr id="wi.39"-->To set up this connection you will need to have a Username and Password from your Internet Service Provider. You also need PPTP IP address. If you do not have this information, please contact your ISP.<!--#endtr--></p>
			<table class="tbl_main" summary="wizard wan mode">
				<tr>
					<td class="CL"><label class="duple" for="wan_pptp_server"><!--#tr id="wi.40"-->PPTP Server IP Address<!--#endtr--></label></td>
					<td class="CR"><input type="text" id="wan_pptp_server" name="config.wan_pptp_server" size="20" maxlength="64" value="<% nvram_get("wan_pptp_server_name"); %>"/> <!--#tr id="wi.35"-->(may be same as gateway)<!--#endtr--></td>
				</tr>
				<tr>
					<td class="CL"><label class="duple" for="wan_pptp_username"><!--#tr id="wi.30"-->User Name<!--#endtr--></label></td>
					<td class="CR"><input type="text" id="wan_pptp_username" name="config.wan_pptp_username" size="20" maxlength="64" value="<% nvram_get("wan_pptp_username"); %>"/></td>
				</tr>
				<tr>
					<td class="CL"><label class="duple" for="wan_pptp_password"><!--#tr id="wi.31"-->Password<!--#endtr--></label></td>
					<td class="CR"><input type="password" id="wan_pptp_password" name="config.wan_pptp_password" size="20" maxlength="63" value="<% nvram_get("wan_pptp_passwd"); %>" onfocus="select();"/></td>
				</tr>
				<tr>
					<td class="CL"><label class="duple" for="second_wan_pptp_password"><!--#tr id="wi.32"-->Verify Password<!--#endtr--></label></td>
					<td class="CR"><input type="password" id="second_wan_pptp_password" size="20" maxlength="63" value="<% nvram_get("wan_pptp_passwd"); %>" onfocus="select();" /></td>
				</tr>
				<tr>
					<td class="CL"><label class="duple"><!--#tr id="wi.36"-->WAN Interface IP Type<!--#endtr-->&nbsp;</label></td>
					<td class="CR">
						<select id="pptpMode_select" name="pptpMode_select" size="1" onChange="pptpModeSwitch()">
							<option value="0"><!--#tr id="wi.38"-->Dynamic IP<!--#endtr--></option>
							<option value="1"><!--#tr id="wi.37"-->Static IP<!--#endtr--></option>
						</select>
					</td>
				</tr>
				<tr id="pptp_mode_ip">
					<td class="CL"><label class="duple" for="wan_pptp_ip_address"><!--#tr id="wan.9"-->PPTP<!--#endtr--> <!--#tr id="wi.18"-->IP Address<!--#endtr--></label></td>
					<td class="CR"><input type="text" id="wan_pptp_ip_address" name="config.wan_pptp_ip_address" size="20" maxlength="15" value="<% nvram_get("wan_pptp_localip"); %>"/></td>
				</tr>
				<tr id="pptp_mode_mask">
					<td class="CL"><label class="duple" for="wan_pptp_subnet_mask"><!--#tr id="wan.9"-->PPTP<!--#endtr--> <!--#tr id="wi.19"-->Subnet Mask<!--#endtr--></label></td>
					<td class="CR"><input type="text" id="wan_pptp_subnet_mask" name="config.wan_pptp_subnet_mask" size="20" maxlength="15" value="<% nvram_get("wan_pptp_netmask"); %>"/></td>
				</tr>
				<tr id="pptp_mode_gateway">
					<td class="CL"><label class="duple" for="wan_pptp_gateway"><!--#tr id="wan.9"-->PPTP<!--#endtr--> <!--#tr id="wi.20"-->Default Gateway<!--#endtr--></label></td>
					<td class="CR"><input type="text" id="wan_pptp_gateway" name="config.wan_pptp_gateway" size="20" maxlength="15" value="<% nvram_get("wan_pptp_gateway"); %>"/></td>
				</tr>
				<tr id="pptp_mode_pridns">
					<td class="CL"><label class="duple" for="wan_pptp_pridns"><!--#tr id="wan.9"-->PPTP<!--#endtr--> <!--#tr id="wi.21"-->Primary DNS<!--#endtr--></label></td>
					<td class="CR"><input type="text" id="wan_pptp_pridns" name="config.wan_pptp_pridns" size="20" maxlength="15" value="<% nvram_get("wan_pptp_dns0"); %>"/></td>
				</tr>
				<tr id="pptp_mode_secdns">
					<td class="CL"><label class="duple" for="wan_pptp_secdns"><!--#tr id="wan.9"-->PPTP<!--#endtr--> <!--#tr id="wi.22"-->Secondary DNS<!--#endtr--></label></td>
					<td class="CR"><input type="text" id="wan_pptp_secdns" name="config.wan_pptp_secdns" size="20" maxlength="15" value="<% nvram_get("wan_pptp_dns1"); %>"/></td>
				</tr>
			</table>
		</div><!-- wan_ip_mode_box_4 -->
				
	</div><!-- wz_page_3 -->

	<div id="wz_page_4" style="display:none">
		<h1><!--#tr id="wi.42"-->Setup Complete!<!--#endtr--></h1>
		<div class="hr" ></div>
		<p class="header_desc"><!--#tr id="wi.43"-->The Internet Connection Setup Wizard is complete. Click the Apply button to save and apply your settings.<!--#endtr--></p>
		<table class="tbl_main" summary="">
			<tr>
				<td class="CL"><label for="wan_summary_type"><!--#tr id="wi.44"-->Internet Connection Type<!--#endtr--></label></td>
				<td class="CR"><span id="wan_summary_type">&nbsp;</span></td>
			</tr>
		</table>
		<div id="wan_summary_0">
			<table class="tbl_main" summary="">
				<tr>
					<td class="CL"><label class="duple" for="wan_ip_address"><!--#tr id="wi.18"-->IP Address<!--#endtr--></label></td>
					<td class="CR" id="wan_summary_0_ip_address">&nbsp;</td>
				</tr>
				<tr>
					<td class="CL"><label class="duple" for="wan_subnet_mask"><!--#tr id="wi.19"-->Subnet Mask<!--#endtr--></label></td>
					<td class="CR" id="wan_summary_0_subnet_mask">&nbsp;</td>
				</tr>
				<tr>
					<td class="CL"><label class="duple" for="wan_gateway"><!--#tr id="wi.20"-->Default Gateway<!--#endtr--></label></td>
					<td class="CR" id="wan_summary_0_gateway">&nbsp;</td>
				</tr>
				<tr>
					<td class="CL"><label class="duple" for="wan_primary_dns"><!--#tr id="wi.21"-->Primary DNS<!--#endtr--></label></td>
					<td class="CR" id="wan_summary_0_primary_dns">&nbsp;</td>
				</tr>
				<tr>
					<td class="CL"><label class="duple" for="wan_secondary_dns"><!--#tr id="wi.22"-->Secondary DNS<!--#endtr--></label></td>
					<td class="CR" id="wan_summary_0_secondary_dns">&nbsp;</td>
				</tr>
			</table>
		</div>

		<div id="wan_summary_1">
			<table class="tbl_main" summary="" style="display:none">
				<tr>
					<td class="CL"><label class="duple" for="wan_dhcp_gw_name"><!--#tr id="wi.28"-->Host Name<!--#endtr--></label></td>
					<td class="CR" id="wan_summary_1_dhcp_gw_name">&nbsp;</td>
				</tr>
			</table>
		</div>

		<div id="wan_summary_2">
			<table class="tbl_main" summary="">
				<tr>
					<td class="CL"><label class="duple" for="pppoe_username"><!--#tr id="wi.30"-->User Name<!--#endtr--></label></td>
					<td class="CR" id="wan_summary_2_pppoe_username"></td>
				</tr>
				<tr>
					<td class="CL"><label class="duple" for="pppoe_password"><!--#tr id="wi.31"-->Password<!--#endtr--></label></td>
					<td class="CR" id="wan_summary_2_pppoe_password">********</td>
				</tr>
			</table>
		</div>

		<div id="wan_summary_3">
			<table class="tbl_main" summary="wizard wan mode">
				<tr>
					<td class="CL"><label class="duple" for="wan_l2tp_server"><!--#tr id="wi.34"-->L2TP Server IP Address<!--#endtr--></label></td>
					<td class="CR" id="wan_summary_3_l2tp_server"></td>
				</tr>
				<tr>
					<td class="CL"><label class="duple" for="wan_l2tp_username"><!--#tr id="wi.30"-->User Name<!--#endtr--></label></td>
					<td class="CR" id="wan_summary_3_l2tp_username"></td>
				</tr>
				<tr>
					<td class="CL"><label class="duple" for="wan_l2tp_password"><!--#tr id="wi.31"-->Password<!--#endtr--></label></td>
					<td class="CR" id="wan_summary_3_l2tp_password">********</td>
				</tr>
				<tr>
					<td class="CL"><label class="duple"><!--#tr id="wi.36"-->WAN Interface IP Type<!--#endtr-->&nbsp;</label></td>
					<td class="CR" id="wan_summary_3_l2tpmode"></td>
				</tr>
				<tbody id="wan_summary_3_l2tpmode_field">
				<tr>
					<td class="CL"><label class="duple" for="wan_l2tp_ip_address">L2TP <!--#tr id="wi.18"-->IP Address<!--#endtr--></label></td>
					<td class="CR" id="wan_summary_3_l2tp_ip_address"></td>
				</tr>
				<tr>
					<td class="CL"><label class="duple" for="wan_l2tp_subnet_mask">L2TP <!--#tr id="wi.19"-->Subnet Mask<!--#endtr--></label></td>
					<td class="CR" id="wan_summary_3_l2tp_subnet_mask"></td>
				</tr>
				<tr>
					<td class="CL"><label class="duple" for="wan_l2tp_gateway">L2TP <!--#tr id="wi.20"-->Default Gateway<!--#endtr--></label></td>
					<td class="CR" id="wan_summary_3_l2tp_gateway"></td>
				</tr>
				</tbody>
			</table>
		</div>

		<div id="wan_summary_4">
			<table class="tbl_main" summary="wizard wan mode">
				<tr>
					<td class="CL"><label class="duple" for="wan_pptp_server"><!--#tr id="wi.40"-->PPTP Server IP Address<!--#endtr--></label></td>
					<td class="CR" id="wan_summary_4_pptp_server"></td>
				</tr>
				<tr>
					<td class="CL"><label class="duple" for="wan_pptp_username"><!--#tr id="wi.30"-->User Name<!--#endtr--></label></td>
					<td class="CR" id="wan_summary_4_pptp_username"></td>
				</tr>
				<tr>
					<td class="CL"><label class="duple" for="wan_pptp_password"><!--#tr id="wi.31"-->Password<!--#endtr--></label></td>
					<td class="CR" id="wan_summary_4_pptp_password">********</td>
				</tr>
				<tr>
					<td class="CL"><label class="duple"><!--#tr id="wi.36"-->WAN Interface IP Type<!--#endtr-->&nbsp;</label></td>
					<td class="CR" id="wan_summary_4_pptpmode"></td>
				</tr>
				<tbody id="wan_summary_4_pptpmode_field">
				<tr>
					<td class="CL"><label class="duple" for="wan_pptp_ip_address">PPTP <!--#tr id="wi.18"-->IP Address<!--#endtr--></label></td>
					<td class="CR" id="wan_summary_4_pptp_ip_address"></td>
				</tr>
				<tr>
					<td class="CL"><label class="duple" for="wan_pptp_subnet_mask">PPTP <!--#tr id="wi.19"-->Subnet Mask<!--#endtr--></label></td>
					<td class="CR" id="wan_summary_4_pptp_subnet_mask"></td>
				</tr>
				<tr>
					<td class="CL"><label class="duple" for="wan_pptp_gateway">PPTP <!--#tr id="wi.20"-->Default Gateway<!--#endtr--></label></td>
					<td class="CR" id="wan_summary_4_pptp_gateway"></td>
				</tr>
				<tr>
					<td class="CL"><label class="duple" for="wan_pptp_pridns">PPTP <!--#tr id="wi.21"-->Primary DNS<!--#endtr--></label></td>
					<td class="CR" id="wan_summary_4_pptp_pridns"></td>
				</tr>
				<tr>
					<td class="CL"><label class="duple" for="wan_pptp_secdns">PPTP <!--#tr id="wi.22"-->Secondary DNS<!--#endtr--></label></td>
					<td class="CR" id="wan_summary_4_pptp_secdns"></td>
				</tr>
				</tbody>
			</table>
		</div>

		<table class="tbl_main" summary="">
			<tr>
				<td class="CL"><label for="wlan_summary_ssid"><!--#tr id="wireless.interface"-->Wireless Interface<!--#endtr--></label></td>
				<td class="CR"><!--#tr id="wireless.24g"-->Wireless 2.4GHz<!--#endtr--></td>
			</tr>
			<tr>
				<td class="CL"><label for="wlan_summary_ssid"><!--#tr id="status.net.name.ssid"-->Network Name (SSID1)<!--#endtr--> / <!--#tr id="status.security.mode"-->Security Mode<!--#endtr--></label></td>
				<td class="CR"><span id="wlan_summary_ssid_2g">&nbsp;</span></td>
			</tr>
		</table>

		<table class="tbl_main" summary="">
			<tr>
				<td class="CL"><label for="wlan_summary_ssid"><!--#tr id="wireless.interface"-->Wireless Interface<!--#endtr--></label></td>
				<td class="CR"><!--#tr id="wireless.5g"-->Wireless 5GHz<!--#endtr--></td>
			</tr>
			<tr>
				<td class="CL"><label for="wlan_summary_ssid"><!--#tr id="status.net.name.ssid"-->Network Name (SSID1)<!--#endtr--> / <!--#tr id="status.security.mode"-->Security Mode<!--#endtr--></label></td>
				<td class="CR"><span id="wlan_summary_ssid_5g">&nbsp;</span></td>
			</tr>
		</table>
	</div><!-- wz_page_4 -->

<p></p>
	<div align="center">
		<label class="duple"></label>
		<input type="button" width="70px" class="<!--#tr id="buttonWidth"-->button1<!--#endtr-->" id="wz_prev_b" value="<!--#tr id="prev"-->Prev<!--#endtr-->" onclick="wz_prev();" disabled="disabled"/>
		<input type="button" width="70px" class="<!--#tr id="buttonWidth"-->button1<!--#endtr-->" id="wz_next_b" value="<!--#tr id="next"-->Next<!--#endtr-->" onclick="wz_next();"/>
		<input type="button" width="70px" class="<!--#tr id="buttonWidth"-->button1<!--#endtr-->" id="wz_cancel_b" value="<!--#tr id="cancel"-->Cancel<!--#endtr-->" onclick="page_cancel();"/>
		<input type="button" width="70px" class="<!--#tr id="buttonWidth"-->button1<!--#endtr-->" id="wz_save_b" value="<!--#tr id="apply"-->Apply<!--#endtr-->" onclick="page_submit();" disabled="disabled"/>
	</div>
	</form>

<div style="display:none">
<form name="wan" method="post" action="/wan.asp" target="rebootRedirect">
	<input type="hidden" name="page" value="/internet/wan.asp">
	<input type="hidden" name="wizard_page" value="/wizard/wizard_internet.asp">
	<input type="hidden" name="token" value="<% genToken(); %>">
	<input type="hidden" name="WizardConfigured" value="1">

	<select name="wan_unit" onChange="submit();">
	  <% wan_list(); %>
	</select>
	<input type="submit" class="button1" name="action" value="New">
	<input type="submit" class="button1" name="action" value="Delete">
    <input name="wan_desc" value="<% nvram_get("wan_desc"); %>">
	<select name="wan_ifname" onChange="wan_ifname_change();">
	  <% wan_iflist(); %>
	</select>
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
	<select name="wan_primary">
	  <option value="1" <% nvram_match("wan_primary", "1", "selected"); %>><!--#tr id="yes"-->Yes<!--#endtr--></option>
	  <option value="0" <% nvram_match("wan_primary", "0", "selected"); %>><!--#tr id="no"-->No<!--#endtr--></option>
	</select>

    <input id="dhcpHostName" name="wan_hostname" maxlength="255" value="<% nvram_get("wan_hostname"); %>">
    <input id="staticDomainName" name="wan_domain" value="<% nvram_get("wan_domain"); %>">
    <input id="macAddress" name="wan_hwaddr" value="<% nvram_get("wan_hwaddr"); %>" size="17" maxlength="17">
    <input id="staticIPAddress" name="wan_ipaddr" value="<% nvram_get("wan_ipaddr"); %>" size="15" maxlength="15">
    <input id="staticSubnetMask" name="wan_netmask" value="<% nvram_get("wan_netmask"); %>" size="15" maxlength="15">
    <input id="staicDefaultGateway" name="wan_gateway" value="<% nvram_get("wan_gateway"); %>" size="15" maxlength="15">
	<input type="hidden" name="wan_dns" value="3">
    <input id="dnsSever1" name="wan_dns0" value="<% nvram_list("wan_dns", 0); %>" size="15" maxlength="15">
    <input id="dnsSever2" name="wan_dns1" value="<% nvram_list("wan_dns", 1); %>" size="15" maxlength="15">
    <input id="dnsSever3" name="wan_dns2" value="<% nvram_list("wan_dns", 2); %>" size="15" maxlength="15">
	<input type="hidden" name="wan_wins" value="3">
    <input name="wan_wins0" value="<% nvram_list("wan_wins", 0); %>" size="15" maxlength="15">
    <input name="wan_wins1" value="<% nvram_list("wan_wins", 1); %>" size="15" maxlength="15">
    <input name="wan_wins2" value="<% nvram_list("wan_wins", 2); %>" size="15" maxlength="15">
    <input id="pppoeUserName" name="wan_pppoe_username" maxlength="255" value="<% nvram_get("wan_pppoe_username"); %>">
    <input id="pppoePassword" name="wan_pppoe_passwd" maxlength="255" value="<% nvram_get("wan_pppoe_passwd"); %>" type="password">
   <input id="serviceName" name="wan_pppoe_service" maxlength="255" value="<% nvram_get("wan_pppoe_service"); %>">
    <input name="wan_pppoe_ac" maxlength="255" value="<% nvram_get("wan_pppoe_ac"); %>">
	<select id="pppoeDemandMode" name="wan_pppoe_demand" onChange="wan_pppoe_demand_change();">
	  <option value="1" <% nvram_match("wan_pppoe_demand", "1", "selected"); %>><!--#tr id="enabled"-->Enabled<!--#endtr--></option>
	  <option value="0" <% nvram_match("wan_pppoe_demand", "0", "selected"); %>><!--#tr id="disabled"-->Disabled<!--#endtr--></option>
	</select>
     <input id="pppoeMaxIdleTime" name="wan_pppoe_idletime" value="<% nvram_get("wan_pppoe_idletime"); %>" size="4" maxlength="4">
	<select id="pppoeKeepAliveMode" name="wan_pppoe_keepalive">
	  <option value="1" <% nvram_match("wan_pppoe_keepalive", "1", "selected"); %>><!--#tr id="enabled"-->Enabled<!--#endtr--></option>
	  <option value="0" <% nvram_match("wan_pppoe_keepalive", "0", "selected"); %>><!--#tr id="disabled"-->Disabled<!--#endtr--></option>
	</select>
    <input id="pppoeMru"  name="wan_pppoe_mru" value="<% nvram_get("wan_pppoe_mru"); %>" size="4" maxlength="4">
    <input id="pppoeMtu" name="wan_pppoe_mtu" value="<% nvram_get("wan_pppoe_mtu"); %>" size="4" maxlength="4">
    <input id="pppoeMacAddress" name="wan_pppoe_hwaddr" value="<% nvram_get("wan_hwaddr"); %>" size="17" maxlength="17">
 <!--
#ifdef __CONFIG_PPTP__
-->
    <input name="wan_pptp_server_name" maxlength="255" value="<% nvram_get("wan_pptp_server_name"); %>">
	<select id="pptpConnection" name="wan_pptp_static" onChange="wan_pptp_static_change();">
	  <option value="0" <% nvram_match("wan_pptp_static", "0", "selected"); %>><!--#tr id="wan.dhcp"-->DHCP<!--#endtr--></option>
	  <option value="1" <% nvram_match("wan_pptp_static", "1", "selected"); %>><!--#tr id="wan.static"-->Static<!--#endtr--></option>
	</select>
    <input id="pptpIPAddress" name="wan_pptp_localip" value="<% nvram_get("wan_pptp_localip"); %>" size="15" maxlength="15">
    <input id="pptpSubnetMask" name="wan_pptp_netmask" value="<% nvram_get("wan_pptp_netmask"); %>" size="15" maxlength="15">
    <input id="pptpDefaultGateway" name="wan_pptp_gateway" value="<% nvram_get("wan_pptp_gateway"); %>" size="15" maxlength="15">
	<input type="hidden" name="wan_pptp_dns" value="3">
    <input id="pptpDnsServer1" name="wan_pptp_dns0" value="<% nvram_get("wan_pptp_dns0"); %>" size="15" maxlength="15">
    <input id="pptpDnsServer2" name="wan_pptp_dns1" value="<% nvram_get("wan_pptp_dns1"); %>" size="15" maxlength="15">
    <input id="pptpDnsServer3" name="wan_pptp_dns2" value="<% nvram_get("wan_pptp_dns2"); %>" size="15" maxlength="15">
    <input id="pptpUserName" name="wan_pptp_username" maxlength="255" value="<% nvram_get("wan_pptp_username"); %>">
    <input id="pptpPassword" name="wan_pptp_passwd" maxlength="255" value="<% nvram_get("wan_pptp_passwd"); %>" type="password">
	<select id="pptpDemandMode" name="wan_pptp_demand" onChange="wan_pptp_demand_change();">
	  <option value="1" <% nvram_match("wan_pptp_demand", "1", "selected"); %>><!--#tr id="enabled"-->Enabled<!--#endtr--></option>
	  <option value="0" <% nvram_match("wan_pptp_demand", "0", "selected"); %>><!--#tr id="disabled"-->Disabled<!--#endtr--></option>
	</select>
    <input id="pptpMaxIdleTime" name="wan_pptp_idletime" value="<% nvram_get("wan_pptp_idletime"); %>" size="4" maxlength="4">
	<select name="wan_pptp_keepalive">
	  <option value="1" <% nvram_match("wan_pptp_keepalive", "1", "selected"); %>><!--#tr id="enabled"-->Enabled<!--#endtr--></option>
	  <option value="0" <% nvram_match("wan_pptp_keepalive", "0", "selected"); %>><!--#tr id="disabled"-->Disabled<!--#endtr--></option>
	</select>
    <input id="pptpMru" name="wan_pptp_mru" value="<% nvram_get("wan_pptp_mru"); %>" size="4" maxlength="4">
    <input id="pptpMtu" name="wan_pptp_mtu" value="<% nvram_get("wan_pptp_mtu"); %>" size="4" maxlength="4">
    <input id="pptpMacAddress" name="wan_pptp_hwaddr" value="<% nvram_get("wan_hwaddr"); %>" size="17" maxlength="17">
<!--
#endif
-->
<!--
#ifdef __CONFIG_L2TP__
-->
    <input name="wan_l2tp_server_name" value="<% nvram_get("wan_l2tp_server_name"); %>">
	<select id="l2tpConnection" name="wan_l2tp_static" onChange="wan_l2tp_static_change();">
	  <option value="0" <% nvram_match("wan_l2tp_static", "0", "selected"); %>><!--#tr id="wan.dhcp"-->DHCP<!--#endtr--></option>
	  <option value="1" <% nvram_match("wan_l2tp_static", "1", "selected"); %>><!--#tr id="wan.static"-->Static<!--#endtr--></option>
	</select>
    <input id="l2tpIPAddress" name="wan_l2tp_ipaddr" value="<% nvram_get("wan_l2tp_ipaddr"); %>" size="15" maxlength="15">
    <input id="l2tpSubnetMask" name="wan_l2tp_netmask" value="<% nvram_get("wan_l2tp_netmask"); %>" size="15" maxlength="15">
    <input id="l2tpDefaultGateway" name="wan_l2tp_gateway" value="<% nvram_get("wan_l2tp_gateway"); %>" size="15" maxlength="15">
	<input type="hidden" name="wan_l2tp_dns" value="3">
    <input id="l2tpDnsServer1" name="wan_l2tp_dns0" value="<% nvram_get("wan_l2tp_dns0"); %>" size="15" maxlength="15">
    <input id="l2tpDnsServer2" name="wan_l2tp_dns1" value="<% nvram_get("wan_l2tp_dns1"); %>" size="15" maxlength="15">
    <input id="l2tpDnsServer3" name="wan_l2tp_dns2" value="<% nvram_get("wan_l2tp_dns2"); %>" size="15" maxlength="15">
    <input id="l2tpUserName" name="wan_l2tp_username" value="<% nvram_get("wan_l2tp_username"); %>">
    <input id="l2tpPassword" name="wan_l2tp_passwd" value="<% nvram_get("wan_l2tp_passwd"); %>" type="password">
	<select id="l2tpDemandMode" name="wan_l2tp_demand" onChange="wan_l2tp_demand_change();">
	  <option value="1" <% nvram_match("wan_l2tp_demand", "1", "selected"); %>><!--#tr id="enabled"-->Enabled<!--#endtr--></option>
	  <option value="0" <% nvram_match("wan_l2tp_demand", "0", "selected"); %>><!--#tr id="disabled"-->Disabled<!--#endtr--></option>
	</select>
    <input id="l2tpMaxIdleTime" name="wan_l2tp_idletime" value="<% nvram_get("wan_l2tp_idletime"); %>" size="4" maxlength="4">
	<select name="wan_l2tp_keepalive">
	  <option value="1" <% nvram_match("wan_l2tp_keepalive", "1", "selected"); %>><!--#tr id="enabled"-->Enabled<!--#endtr--></option>
	  <option value="0" <% nvram_match("wan_l2tp_keepalive", "0", "selected"); %>><!--#tr id="disabled"-->Disabled<!--#endtr--></option>
	</select>
   <input id="l2tpMru" name="wan_l2tp_mru" value="<% nvram_get("wan_l2tp_mru"); %>" size="4" maxlength="4">
<input id="l2tpMtu" name="wan_l2tp_mtu" value="<% nvram_get("wan_l2tp_mtu"); %>" size="4" maxlength="4">
<input id="l2tpMacAddress" name="wan_l2tp_hwaddr" value="<% nvram_get("wan_hwaddr"); %>" size="17" maxlength="17">
<!--
#endif
-->

	<input type="submit" class="<!--#tr id="buttonWidth"-->button1<!--#endtr-->" name="action" value="<!--#tr id="apply"-->Apply<!--#endtr-->" id="wan_apply">
	<input type="reset" class="button1" name="action" value="<!--#tr id="cancel"-->Cancel<!--#endtr-->">

</form>
<form method="post" name="wizardset" action="/goform/wizardset">
	<input type="hidden" name="token" value="<% genToken(); %>">
	<input type=hidden name="WizardConfigured" value="1">
</form>
</div>

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
