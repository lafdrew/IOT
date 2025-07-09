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
	<script type="text/javascript" src="../scripts/update_info_timer.js"></script>
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
function updateStatusInfoHTML(str)
{
	document.getElementById("waitPad").style.display="none";
	location.reload();
}

function alertContents() {
	if (http_request.readyState == 4) {
		if (http_request.status == 200) {
			updateStatusInfoHTML( http_request.responseText );
		} else {
		    Alert.render("<!--#tr id="syslg.alert.2"-->There was a problem with the request.<!--#endtr-->");
		}
	}
}

function makeRequest(url, content) {
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
		Alert.render("<!--#tr id="syslg.alert.1" -->Giving up :( Cannot create an XMLHTTP instance<!--#endtr -->");
		return false;
	}
	http_request.onreadystatechange = function () {alertContents()};
	http_request.open('POST', url, true);
	http_request.send(content);
}

function pressStatusBtn(Btn){
	//document.getElementById("selectedBtn").value = Btn;
	//document.doStatusButton.submit();
	
	if(Btn == "IPv6Renew"){
		//document.getElementById("waitPad").style.display="block";
		//btnstatus_refresh = 2;
	}
	document.getElementById("waitPad").style.display="block";
	
	var parameter ="btn="+Btn;
	makeRequest("/uapply.cgi", parameter);
}

function page_load() 
{
	var ipv6_mode, connected;

	document.getElementById("label1").style.display = "none";
	document.getElementById("label2").style.display = "none";
	document.getElementById("label3").style.display = "none";
	document.getElementById("label4").style.display = "none";
	document.getElementById("box_statusButton").style.display = "none";

	ipv6_mode = "<% nvram_get("wan_ipv6_mode"); %>";

	if (ipv6_mode == "1" || ipv6_mode == "5") { //auto configuration
		document.getElementById("box_statusButton").style.display = style_display_on();
		document.getElementById("label1").style.display = style_display_on_tr();
		document.getElementById("label2").style.display = style_display_on_tr();
		document.getElementById("label3").style.display = style_display_on_tr();
		document.getElementById("label4").style.display = style_display_on_tr();
	}
	else if (ipv6_mode == "0" | ipv6_mode == "2") { //static 
		document.getElementById("label1").style.display = style_display_on_tr();
		document.getElementById("label2").style.display = style_display_on_tr();
		document.getElementById("label3").style.display = style_display_on_tr();
		document.getElementById("label4").style.display = style_display_on_tr();
	}

	if (ipv6_mode == "0") {
		connected = "<% getWanIPv6Connected(0); %>";
		document.getElementById("connectiontype").innerHTML = "<!--#tr id="ipv6.link.local"-->Link Local<!--#endtr-->";

		if (connected == "1") {
			document.getElementById("networkstatus").innerHTML = "<!--#tr id="ipv6.connected"-->Connected<!--#endtr-->";
		}
		else {
			document.getElementById("networkstatus").innerHTML = "<!--#tr id="ipv6.disconnected"-->Disconnected<!--#endtr-->";
		}
		
		document.getElementById("laniplinkaddress").innerHTML = "<% getLanV6_Addr(0); %>";
	}
	else if (ipv6_mode == "1" || ipv6_mode == "5") {
		connected = "<% getWanIPv6Connected(1); %>";
		if (ipv6_mode == "1") {
			document.getElementById("connectiontype").innerHTML = "<!--#tr id="ipv6.auto.conf"-->Auto Configuration (SLAAC/DHCPv6)<!--#endtr-->";
		}
		else {
			document.getElementById("connectiontype").innerHTML = "<!--#tr id="wan.pppoe"-->PPPoE<!--#endtr-->";
		}

		if (connected == "1") {
			document.getElementById("networkstatus").innerHTML = "<!--#tr id="ipv6.connected"-->Connected<!--#endtr-->";
		}
		else {
			document.getElementById("networkstatus").innerHTML = "<!--#tr id="ipv6.disconnected"-->Disconnected<!--#endtr-->";
		}

		document.getElementById("lanipaddress").innerHTML = "<% getLanV6_Addr(1); %>";
		document.getElementById("laniplinkaddress").innerHTML = "<% getLanV6_Addr(0); %>";
		document.getElementById("lanipprefix").innerHTML = "<% getLanIPv6Prefix(); %>";
		document.getElementById("wangateway").innerHTML = "<% getLanIPv6Gw(); %>";
		document.getElementById("wanipaddress").innerHTML = "<% getWanIPv6Addr(); %>";
		document.getElementById("wanprimarydns").innerHTML = "<% getWanIPv6DNS(0); %>";
		document.getElementById("wansecondarydns").innerHTML = "<% getWanIPv6DNS(1); %>";
	}
	else if (ipv6_mode == "2") {
		connected = "<% getWanIPv6Connected(2); %>";
		document.getElementById("connectiontype").innerHTML = "<!--#tr id="wan.static"-->Static<!--#endtr-->";

		if (connected == "1") {
			document.getElementById("networkstatus").innerHTML = "<!--#tr id="ipv6.connected"-->Connected<!--#endtr-->";
		}
		else {
			document.getElementById("networkstatus").innerHTML = "<!--#tr id="ipv6.disconnected"-->Disconnected<!--#endtr-->";
		}

		document.getElementById("lanipaddress").innerHTML = "<% getLanV6_Addr(1); %>";
		document.getElementById("laniplinkaddress").innerHTML = "<% getLanV6_Addr(0); %>";
		document.getElementById("lanipprefix").innerHTML = "<% getLanIPv6Prefix(); %>";
		document.getElementById("wangateway").innerHTML = "<% getLanIPv6Gw(); %>";
		document.getElementById("wanipaddress").innerHTML = "<% getWanIPv6Addr(); %>";
		document.getElementById("wanprimarydns").innerHTML = "<% getWanIPv6DNS(0); %>";
		document.getElementById("wansecondarydns").innerHTML = "<% getWanIPv6DNS(1); %>";
	}
	else if (ipv6_mode == "3") {
		connected = "<% getWanIPv6Connected(3); %>";
		document.getElementById("connectiontype").innerHTML = "<!--#tr id="ipv6.6to4"-->6to4 Tunnel<!--#endtr-->";

		if (connected == "1") {
			document.getElementById("networkstatus").innerHTML = "<!--#tr id="ipv6.connected"-->Connected<!--#endtr-->";
		}
		else {
			document.getElementById("networkstatus").innerHTML = "<!--#tr id="ipv6.disconnected"-->Disconnected<!--#endtr-->";
		}

		document.getElementById("lanipaddress").innerHTML = "<% getLanV6_Addr(1); %>";
		document.getElementById("laniplinkaddress").innerHTML = "<% getLanV6_Addr(0); %>";
		document.getElementById("lanipprefix").innerHTML = "<% getLanIPv6Prefix(); %>";
	}
	else if (ipv6_mode == "4") {
		connected = "<% getWanIPv6Connected(4); %>";
		document.getElementById("connectiontype").innerHTML = "<!--#tr id="ipv6.6rd"-->6rd Tunnel<!--#endtr-->";

		if (connected == "1") {
			document.getElementById("networkstatus").innerHTML = "<!--#tr id="ipv6.connected"-->Connected<!--#endtr-->";
		}
		else if (connected == "2") {
			document.getElementById("networkstatus").innerHTML = "<!--#tr id="ipv6.undetermined"-->Undetermined<!--#endtr-->";
		}
		else {
			document.getElementById("networkstatus").innerHTML = "<!--#tr id="ipv6.disconnected"-->Disconnected<!--#endtr-->";
		}

		document.getElementById("lanipaddress").innerHTML = "<% getLanV6_Addr(1); %>";
		document.getElementById("laniplinkaddress").innerHTML = "<% getLanV6_Addr(0); %>";
		document.getElementById("lanipprefix").innerHTML = "<% getLanIPv6Prefix(); %>";
	}

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
<h1><!--#tr id="ipv6.status.title"-->IPv6 Status<!--#endtr--></h1>
<div class="hr" ></div>
<p>
<!--#tr id="ipv6.status.desc"-->This section displays your router system IPv6 status information.<!--#endtr-->
</p>

<!-- ================= IPv6 Internal Network Connection Information ================= -->
<table width="100%" class="tbl_main">
	<tr>
		<td class="CT" colspan="2"><!--#tr id="ipv6.status.internal"-->IPv6 Internal Network Configuration<!--#endtr--></td>
	</tr>
	<tr>
		<td class="CL" id="ConnectionType"><!--#tr id="ipv6.status.connection.type"-->Connected Type<!--#endtr--></td>
		<td class="CR"><span id="connectiontype">&nbsp;</span></td>
	</tr>
	<tr>
		<td class="CL" id="NetworkStatus"><!--#tr id="ipv6.status.network"-->Network Status<!--#endtr--></td>
		<td class="CR"><span id="networkstatus">&nbsp;</span></td>
	</tr>
	<tr id="label1" style="display:none">
		<td class="CL" id="WanIPv6Address"><!--#tr id="ipv6.wan.ip"-->WAN IPv6 Address<!--#endtr--></td>
		<td class="CR"><span id="wanipaddress">&nbsp;</span></td>
	</tr>
	<tr id="label2" style="display:none">
		<td class="CL" id="WanIPv6DefaultGateway"><!--#tr id="ipv6.wan.gw"-->IPv6 Default Gateway<!--#endtr--></td>
		<td class="CR"><span id="wangateway">&nbsp;</span></td>
	</tr>
	<tr id="label3" style="display:none">
		<td class="CL" id="WanIPv6PrimaryDNS"><!--#tr id="ipv6.wan.pri.dns"-->Primary IPv6 DNS Server<!--#endtr--></td>
		<td class="CR"><span id="wanprimarydns">&nbsp;</span></td>
	</tr>
	<tr id="label4" style="display:none">
		<td class="CL" id="WanIPv6SecondaryDNS"><!--#tr id="ipv6.wan.sec.dns"-->Secondary IPv6 DNS Server<!--#endtr--></td>
		<td class="CR"><span id="wansecondarydns">&nbsp;</span></td>
	</tr>
	<tr>
		<td class="CL" id="LanIPv6Address"><!--#tr id="ipv6.status.lan.address"-->LAN IPv6 Address<!--#endtr--></td>
		<td class="CR"><span id="lanipaddress">&nbsp;</span></td>
	</tr>
	<tr>
		<td class="CL" id="LanIPv6LinkAddress"><!--#tr id="ipv6.status.lan.link.address"-->LAN IPv6 Link-Local Address<!--#endtr--></td>
		<td class="CR"><span id="laniplinkaddress">&nbsp;</span></td>
	</tr>
	<tr>
		<td class="CL" id="LanIPv6Prefix"><!--#tr id="ipv6.lan.prefix"-->LAN IPv6 Prefix<!--#endtr--></td>
		<td class="CR"><span id="lanipprefix">&nbsp;</span></td>
	</tr>
</table>

<table id="box_statusButton" width="100%" class="tbl_main" style="display:none">
	<form method="post" name="doStatusButton" action="/uapply.cgi">	
		<input type="hidden" name="page" value="/adm/ipv6status.asp">								
		<input type="hidden" name="token" value="<% genToken(); %>">
	<input type="hidden" name="action" id="selectedBtn" value="">
		<tr>
			<td width="50%" align="right" style="vertical-align:middle">
				<div><input type="button" class="<!--#tr id="buttonWidth2"-->button1<!--#endtr-->" id="statusButton1" value="<!--#tr id="renew"-->Renew<!--#endtr-->" onclick="pressStatusBtn('IPv6Renew');" style="width:100px;"></div>
			</td>
			<td width="50%" align="left" valign="middle" style="vertical-align:middle">
				<div><input type="button" class="<!--#tr id="buttonWidth2"-->button1<!--#endtr-->" id="statusButton2" value="<!--#tr id="release"-->Release<!--#endtr-->" onclick="pressStatusBtn('IPv6Release');" style="width:100px;"></div>
			</td>
		</tr>
	</form>				
</table>

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
