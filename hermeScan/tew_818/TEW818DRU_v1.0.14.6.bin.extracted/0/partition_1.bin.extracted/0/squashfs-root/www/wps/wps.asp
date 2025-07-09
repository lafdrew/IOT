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
#ifdef BCMWFI
*/
var staListWl0 = "<% wl_invite_list(); %>".split('\t');

var interval = 30;
var nvinterval = "<% nvram_get("wfi_refresh_interval"); %>" ;
var wfi = "<% nvram_match("wl_wfi_enable", "1", "1"); %>";
var wps_enable = "<% nvram_get("wl_wps_mode"); %>";

if(nvinterval)
{
	interval = parseInt(nvinterval);
}

function printTable()
{
	if(wfi == 1){
		for(var i=0; i<staListWl0.length; i++){
			if(staListWl0[i].length < 17){
				continue;
			}
		
			document.writeln("<tr align=\"center\" id=\"trRow" + i + "\">");
	    		document.writeln("<td class=\"label\">");
	 
	    		document.writeln("<input type=\"submit\" style=\"height: 25px; width: 100px\" name=\"action\" value=\"Invite\" OnClick=\"invite(" + i + ");\">");
	   		
	   		document.writeln("</td>");
	   		document.writeln("<td class=\"label\">");
	   	
	   		if(staListWl0[i].length > 17){
	   			document.writeln(staListWl0[i].substring(17,(staListWl0[i].length)));
	   		}
	   		else{
	   			document.writeln ("&nbsp");
	   		}
	   		document.writeln("</td>");
	   		document.writeln("<td class=\"label\">");
	   		document.writeln(staListWl0[i].substring(0,17));
	   		document.writeln("</td>");
	   		document.writeln("</tr>");
 		}
 	}
	return;
}

function invite(index)
{
	
	if(staListWl0[index].length > 17){
		document.wps.invite_name.value = staListWl0[index].substring(17,(staListWl0[index].length));
	}
	else{
		document.wps.invite_name.value = "";
	}
	
	document.wps.invite_mac.value = staListWl0[index].substring(0,17);

}

function wfi_enable_change()
{
	if(document.wps.wl_wfi_enable.value == 1){
		//document.wps.wl_unit.disabled = 0;
		document.wps.wl_wfi_pinmode.disabled = 0;
		document.wps.refresh_button.disabled = 0;
	}
	else{
		//gray out
		//document.wps.wl_unit.disabled = 1;
		document.wps.wl_wfi_pinmode.disabled = 1;
		document.wps.refresh_button.disabled = 1;
	}
}

function autoRefresh()
{
	if(wfi == 1){
		setTimeout("doRefresh()", interval * 1000 );
	}
}

function doRefresh()
{

	document.wps.action.value = "Select";
	document.wps.submit();
}
function writeStrRefres()
{
	if(wfi == 1){
		document.writeln("Auto refreshing every 30 seconds");
	}
}
/*	
#endif
*/

function confirmNoCheck(noValue){
	
	if(noVlaue == "wps_config_change_display")
		document.forms[0].wl_wps_mode.value = "disabled";
}

function confirmYesCheck(yesValue){
	
//	if(yesVlaue == "wps_config_change_display")
//		applyCheck();
}

function wps_config_change()
{
<% wps_config_change_display(); %>
}

function wps_current_psk_window() 
{
	var key = "<% nvram_get("wl_wpa_psk"); %>";
<% wps_current_psk_window_display(); %>
}

function wps_psk_window() 
{
	var key = "<% nvram_get("wl_wpa_psk"); %>";
<% wps_psk_window_display(); %>
}

function wps_akm_change()
{
	var akm = document.wps.wps_akm[document.wps.wps_akm.selectedIndex].value;
	var action = document.wps.wps_action.value;
	
	if (action == "ConfigAP" || action == "AddEnrollee") {
		if (akm == 0) {
			document.wps.wps_crypto.disabled = 1;
			document.wps.wps_crypto.value = "0";
			document.wps.wps_psk.disabled = 1;
		}
		else {
			document.wps.wps_crypto.disabled = 0;
			document.wps.wps_psk.disabled = 0;
		}
	}
}

function wps_get_ap_config_submit()
{
	<% wps_get_ap_config_submit_display(); %>
}

function pre_submit()
{
	var action = document.wps.wps_action.value;
	var akm = document.wps.wps_akm[document.wps.wps_akm.selectedIndex].value;

	if (action == "ConfigAP" || action == "AddEnrollee") {
		/* Check WPS in OPEN security */
		if (akm == "0")
			return confirm("<!--#tr id="wps.confirm.1"-->Are you sure you want to configure WPS with Open security?<!--#endtr-->");
	}
	if (action == "GetAPConfig")
		return wps_get_ap_config_submit();
	return true;
}

function wps_onLoad()
{
/*	
#ifdef BCMWFI
*/
	wfi_enable_change();
	autoRefresh();
/*	
#endif
*/
	if(wps_enable == "enabled")
		wps_akm_change();
}

function ValidateChecksum(PIN)
{
    var accum = 0;

    accum += 3 * (parseInt(PIN / 10000000) % 10);
    accum += 1 * (parseInt(PIN / 1000000) % 10);
    accum += 3 * (parseInt(PIN / 100000) % 10);
    accum += 1 * (parseInt(PIN / 10000) % 10);
    accum += 3 * (parseInt(PIN / 1000) % 10);
    accum += 1 * (parseInt(PIN / 100) % 10);
    accum += 3 * (parseInt(PIN / 10) % 10);
    accum += 1 * (parseInt(PIN / 1) % 10);

    return ((accum % 10) == 0);
}

function applyCheck()
{
	if(wps_enable == "enabled") {
		var pin = document.wps.wps_sta_pin;
		if(pin.value != "" || pin.value.length != 0) {
			//Tom.Hung 2013-4-17, Support 4 & 9 digital PIN
			if(pin.value.length == 4) {
				//check nothing
			}
			else if(pin.value.length == 9) {
				if(pin.value.charAt(4) == "-" || pin.value.charAt(4) == " ") {
					var realpin;
					realpin = pin.value.substring(0,4);
					realpin += pin.value.substring(5,9);
					if(!ValidateChecksum(realpin)) {
						alert("<!--#tr id="wps.alert.1"-->PIN number is invalid!<!--#endtr-->");
						pin.focus();
						pin.select();
						return false;
					}
				} else {
					alert("<!--#tr id="wps.alert.1"-->PIN number is invalid!<!--#endtr-->");
					pin.focus();
					pin.select();
					return false;
				}
			} else
			//Tom.Hung 2013-4-17 end
			if(!ValidateChecksum(pin.value)) {
				alert("<!--#tr id="wps.alert.1"-->PIN number is invalid!<!--#endtr-->");
				pin.focus();
				pin.select();
				return false;
			}
		}
	}

	//Set redirect location
	var unit = "<% nvram_get("wl_unit"); %>";
	var redirect_page = document.getElementById("page");
	var redirect_value = "/redirect.asp?url=/wps/wps.asp%3Fwl_unit%3D"+unit;
	redirect_page.value = redirect_value;
	
	totalWaitTime = 25;
	wait_page();
	document.getElementById("waitPad").style.display="block";
	scroll(0,0);
	return true;
}

function page_load() {
	wps_onLoad();
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
<h1><!--#tr id="wps.title"-->WPS<!--#endtr--></h1>
<div class="hr" ></div>
<p>
<!--#tr id="wps.desc"-->This page allows you to configure WPS.<!--#endtr-->
</p>

<form name="wps" method="post" action="/wps/wps.asp" onsubmit="return applyCheck();">
<input name="page" id="page" value="/wps/wps.asp" type="hidden">
<input type="hidden" name="token" value="<% genToken(); %>">
<input name="invite_name" value="0" type="hidden">
<input name="invite_mac" value="0" type="hidden">
<div style="display:none">
<table width="100%" class="tbl_main">
	<tr>
		<td class="CT" colspan="2"><!--#tr id="wireless.interface"-->Wireless Interface<!--#endtr--></td>
	</tr>
	<tr>
		<td class="CL"
		onMouseOver="return overlib('Selects which wireless interface to configure.', LEFT);"
		onMouseOut="return nd();">
		<!--#tr id="wireless.interface"-->Wireless Interface<!--#endtr-->
		</td>
		<td class="CR">
			<select name="wl_unit" onChange="submit();">
				<% wl_um_list(); %>
			</select>
		</td>
	</tr>
</table>
</div>

<% wps_um_display(); %>

<!--
#ifdef BCMWFI
-->
<div style="display:none">
<table width="100%" class="tbl_main">
	<tr>
		<td class="CL"
		onMouseOver="return overlib('Enables or disable Wifi-Invite feature.', LEFT);"
		onMouseOut="return nd();">
		<!--#tr id="wps.1"-->Wifi-Invite<!--#endtr-->
		</td>
		<td class="CR">
			<select name="wl_wfi_enable" onChange="wfi_enable_change();">
				<option value="1" <% nvram_match("wl_wfi_enable", "1", "selected"); %>><!--#tr id="enabled"-->Enabled<!--#endtr--></option>
				<option value="0" <% nvram_invmatch("wl_wfi_enable", "1", "selected"); %>><!--#tr id="disabled"-->Disabled<!--#endtr--></option>
			</select>
		</td>
	</tr>
	<tr>
		<td class="CL"
		onMouseOver="return overlib('Set the Wifi-Invite PIN Mode to auto or manual.', LEFT);"
		onMouseOut="return nd();">
		<!--#tr id="wps.2"-->Wifi-Invite PIN Mode<!--#endtr-->
		</td>
		<td class="CR">
			<select name="wl_wfi_pinmode">
				<option value="0" <% nvram_match("wl_wfi_pinmode", "0", "selected"); %>><!--#tr id="auto"-->Auto<!--#endtr--></option>
				<option value="1" <% nvram_match("wl_wfi_pinmode", "1", "selected"); %>><!--#tr id="manual"-->Manual<!--#endtr--></option>
			</select>
		</td>
	</tr>
</table>
</div>
<!--
#endif
-->

<table width="100%" class="tbl_main">
	<tr align="center">
		<td>
			<input type="submit" class="<!--#tr id="buttonWidth"-->button1<!--#endtr-->" name="action" value="<!--#tr id="apply"-->Apply<!--#endtr-->" onClick="wps_config_change()";>
			<input type="reset" class="button1" name="action" value="<!--#tr id="cancel"-->Cancel<!--#endtr-->">
		</td>
	</tr>
</table>

<!--
#ifdef BCMWFI
-->
<div style="display:none">
<table width="100%" class="tbl_main">
	<tr>
		<td class="CL"
		onMouseOver="return overlib('Scan to find Wifi-Invite enabled STAs.', LEFT);"
		onMouseOut="return nd();">
		<!--#tr id="wps.3"-->List Wifi-Invite enabled STAs<!--#endtr-->
		</td>
		<td class="CR2">
			<input type="button" name="refresh_button" value="<!--#tr id="refresh"-->Refresh<!--#endtr-->" style="height: 25px; width: 100px" onClick="doRefresh()">
		</td>
		<td class="CR2">
			<SCRIPT LANGUAGE="JavaScript">
				writeStrRefres();
			</SCRIPT>
		</td>
	</tr>
</table>
</div>

<div style="display:none">
<table width="100%" class="tbl_main">
	<tr>
		<td class="CL" valign="top"
		onMouseOver="return overlib('The list of Wifi-Invite enabled STAs.', LEFT);"
		onMouseOut="return nd();">
		<!--#tr id="wps.4"-->Wifi-Invite enabled STAs<!--#endtr-->
		</td>
		<td>
			<table width="100%" class="tbl_main2">
				<tr align="center" HEIGHT=35>
					<td class="label" WIDTH=100 HEIGHT=35 align="center"><!--#tr id="wps.5"-->Action<!--#endtr--></td>
					<td class="label" WIDTH=100 align="center"><!--#tr id="wps.6"-->Friendly Name<!--#endtr--></td>
					<td class="label" WIDTH=100 align="center"><!--#tr id="mac.address"-->MAC Address<!--#endtr--></td>
					<!-- <td class="label" WIDTH=100 align="center">Status</td> -->
				</tr>
				<script language="JavaScript" type="text/javascript">
					printTable();
				</script>
			</table>
		</td>
	</tr>
</table>
</div>
<!--
#endif
-->
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
