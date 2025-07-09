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

function applyCheck()
{
    //MAC Filters
	document.getElementById("filter_macmode").value = document.getElementById("parental_macmode").value;
	document.getElementById("wl_macmode").value = document.getElementById("parental_macmode").value;
    for (var i = 0; i < 48; i++)
    {
        var macAddressElement = document.getElementById("parentalmacFilter" + i);
        if (!isBlankString(macAddressElement.value) && !checkMac(macAddressElement.value)) 
        {
            macAddressElement.focus();
            Alert.render("<!--#tr id="mac.address.error"-->Invalid MAC address! Please enter a valid MAC address.<!--#endtr-->");
            return false;
        }
		if(document.getElementById("parental_macif" + i).value == "both") {
			document.getElementById("macFilter" + i).value = macAddressElement.value;
			document.getElementById("macAddressInput" + i).value = macAddressElement.value;
		} else if (document.getElementById("parental_macif" + i).value == "lan") {
			document.getElementById("macFilter" + i).value = macAddressElement.value;
			document.getElementById("macAddressInput" + i).value = "";
		} else if (document.getElementById("parental_macif" + i).value == "wlan") {
			document.getElementById("macFilter" + i).value = "";
			document.getElementById("macAddressInput" + i).value = macAddressElement.value;
		}
    }

	totalWaitTime = 25;
	wait_page();
	document.getElementById("waitPad").style.display="block";
	scroll(0,0);
	return true;
}

function page_load() {
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
<h1><!--#tr id="filter.title"-->MAC Filters<!--#endtr--></h1>
<div class="hr" ></div>
<p>
<!--#tr id="filter.desc"-->Filter packets from LAN/WLAN machines with the specified MAC addresses.<!--#endtr-->
</p>

<form method="post" action="/uapply.cgi" onSubmit="return applyCheck();" target="rebootRedirect">
<input type="hidden" name="page" value="/advanced/filter.asp">
<input type="hidden" name="token" value="<% genToken(); %>">

<table width="100%" class="tbl_main">
	<tr>
		<td class="CT" colspan="2">MAC Filters</td>
	</tr>

  <tr>
    <td class="CL"
	onMouseOver="return overlib('Selects whether clients with the specified MAC address are allowed or denied access to the router and the WAN.', LEFT);"
	onMouseOut="return nd();">
	MAC Filter Mode
    </td>
    <td class="CR">
	<select name="parental_macmode" id="parental_macmode">
	  <option value="disabled" <% nvram_match("filter_macmode", "disabled", "selected"); %>><!--#tr id="disabled"-->Disabled<!--#endtr--></option>
	  <option value="allow" <% nvram_match("filter_macmode", "allow", "selected"); %>><!--#tr id="allow"-->Allow<!--#endtr--></option>
	  <option value="deny" <% nvram_match("filter_macmode", "deny", "selected"); %>><!--#tr id="deny"-->Deny<!--#endtr--></option>
	</select>
	<input type="hidden" name="parental_maclist" id="parental_maclist" value="48">
	<input type="hidden" name="parental_macif" id="parental_macif" value="48">
    </td>
  </tr>
	<tr>
		<td colspan="2">
			<table width="100%" class="tbl_main2">
				<tr>
					<td class="form_list_title" width="70%">MAC Filters</td>
					<td class="form_list_title">Interface</td>
				</tr>
				<tr>
					<td class="form_list_content"><input id="parentalmacFilter0" name="parental_maclist0" value="<% nvram_list("parental_maclist", 0); %>" size="17" maxlength="17"></td>
					<td class="form_list_content">
						<select name="parental_macif0" id="parental_macif0">
							<option value="lan" <% nvram_indexmatch("parental_macif", 0, "lan", "selected"); %>>LAN</option>
							<option value="wlan" <% nvram_indexmatch("parental_macif", 0, "wlan", "selected"); %>>WLAN</option>
							<option value="both" <% nvram_indexmatch("parental_macif", 0, "both", "selected"); %>>Both</option>
						</select>
					</td>
				</tr>
				<tr>
					<td class="form_list_content"><input id="parentalmacFilter1" name="parental_maclist1" value="<% nvram_list("parental_maclist", 1); %>" size="17" maxlength="17"></td>
					<td class="form_list_content">
						<select name="parental_macif1" id="parental_macif1">
							<option value="lan" <% nvram_indexmatch("parental_macif", 1, "lan", "selected"); %>>LAN</option>
							<option value="wlan" <% nvram_indexmatch("parental_macif", 1, "wlan", "selected"); %>>WLAN</option>
							<option value="both" <% nvram_indexmatch("parental_macif", 1, "both", "selected"); %>>Both</option>
						</select>
					</td>
				</tr>
				<tr>
					<td class="form_list_content"><input id="parentalmacFilter2" name="parental_maclist2" value="<% nvram_list("parental_maclist", 2); %>" size="17" maxlength="17"></td>
					<td class="form_list_content">
						<select name="parental_macif2" id="parental_macif2">
							<option value="lan" <% nvram_indexmatch("parental_macif", 2, "lan", "selected"); %>>LAN</option>
							<option value="wlan" <% nvram_indexmatch("parental_macif", 2, "wlan", "selected"); %>>WLAN</option>
							<option value="both" <% nvram_indexmatch("parental_macif", 2, "both", "selected"); %>>Both</option>
						</select>
					</td>
				</tr>
				<tr>
					<td class="form_list_content"><input id="parentalmacFilter3" name="parental_maclist3" value="<% nvram_list("parental_maclist", 3); %>" size="17" maxlength="17"></td>
					<td class="form_list_content">
						<select name="parental_macif3" id="parental_macif3">
							<option value="lan" <% nvram_indexmatch("parental_macif", 3, "lan", "selected"); %>>LAN</option>
							<option value="wlan" <% nvram_indexmatch("parental_macif", 3, "wlan", "selected"); %>>WLAN</option>
							<option value="both" <% nvram_indexmatch("parental_macif", 3, "both", "selected"); %>>Both</option>
						</select>
					</td>
				</tr>
				<tr>
					<td class="form_list_content"><input id="parentalmacFilter4" name="parental_maclist4" value="<% nvram_list("parental_maclist", 4); %>" size="17" maxlength="17"></td>
					<td class="form_list_content">
						<select name="parental_macif4" id="parental_macif4">
							<option value="lan" <% nvram_indexmatch("parental_macif", 4, "lan", "selected"); %>>LAN</option>
							<option value="wlan" <% nvram_indexmatch("parental_macif", 4, "wlan", "selected"); %>>WLAN</option>
							<option value="both" <% nvram_indexmatch("parental_macif", 4, "both", "selected"); %>>Both</option>
						</select>
					</td>
				</tr>
				<tr>
					<td class="form_list_content"><input id="parentalmacFilter5" name="parental_maclist5" value="<% nvram_list("parental_maclist", 5); %>" size="17" maxlength="17"></td>
					<td class="form_list_content">
						<select name="parental_macif5" id="parental_macif5">
							<option value="lan" <% nvram_indexmatch("parental_macif", 5, "lan", "selected"); %>>LAN</option>
							<option value="wlan" <% nvram_indexmatch("parental_macif", 5, "wlan", "selected"); %>>WLAN</option>
							<option value="both" <% nvram_indexmatch("parental_macif", 5, "both", "selected"); %>>Both</option>
						</select>
					</td>
				</tr>
				<tr>
					<td class="form_list_content"><input id="parentalmacFilter6" name="parental_maclist6" value="<% nvram_list("parental_maclist", 6); %>" size="17" maxlength="17"></td>
					<td class="form_list_content">
						<select name="parental_macif6" id="parental_macif6">
							<option value="lan" <% nvram_indexmatch("parental_macif", 6, "lan", "selected"); %>>LAN</option>
							<option value="wlan" <% nvram_indexmatch("parental_macif", 6, "wlan", "selected"); %>>WLAN</option>
							<option value="both" <% nvram_indexmatch("parental_macif", 6, "both", "selected"); %>>Both</option>
						</select>
					</td>
				</tr>
				<tr>
					<td class="form_list_content"><input id="parentalmacFilter7" name="parental_maclist7" value="<% nvram_list("parental_maclist", 7); %>" size="17" maxlength="17"></td>
					<td class="form_list_content">
						<select name="parental_macif7" id="parental_macif7">
							<option value="lan" <% nvram_indexmatch("parental_macif", 7, "lan", "selected"); %>>LAN</option>
							<option value="wlan" <% nvram_indexmatch("parental_macif", 7, "wlan", "selected"); %>>WLAN</option>
							<option value="both" <% nvram_indexmatch("parental_macif", 7, "both", "selected"); %>>Both</option>
						</select>
					</td>
				</tr>
				<tr>
					<td class="form_list_content"><input id="parentalmacFilter8" name="parental_maclist8" value="<% nvram_list("parental_maclist", 8); %>" size="17" maxlength="17"></td>
					<td class="form_list_content">
						<select name="parental_macif8" id="parental_macif8">
							<option value="lan" <% nvram_indexmatch("parental_macif", 8, "lan", "selected"); %>>LAN</option>
							<option value="wlan" <% nvram_indexmatch("parental_macif", 8, "wlan", "selected"); %>>WLAN</option>
							<option value="both" <% nvram_indexmatch("parental_macif", 8, "both", "selected"); %>>Both</option>
						</select>
					</td>
				</tr>
				<tr>
					<td class="form_list_content"><input id="parentalmacFilter9" name="parental_maclist9" value="<% nvram_list("parental_maclist", 9); %>" size="17" maxlength="17"></td>
					<td class="form_list_content">
						<select name="parental_macif9" id="parental_macif9">
							<option value="lan" <% nvram_indexmatch("parental_macif", 9, "lan", "selected"); %>>LAN</option>
							<option value="wlan" <% nvram_indexmatch("parental_macif", 9, "wlan", "selected"); %>>WLAN</option>
							<option value="both" <% nvram_indexmatch("parental_macif", 9, "both", "selected"); %>>Both</option>
						</select>
					</td>
				</tr>
				<tr>
					<td class="form_list_content"><input id="parentalmacFilter10" name="parental_maclist10" value="<% nvram_list("parental_maclist", 10); %>" size="17" maxlength="17"></td>
					<td class="form_list_content">
						<select name="parental_macif10" id="parental_macif10">
							<option value="lan" <% nvram_indexmatch("parental_macif", 10, "lan", "selected"); %>>LAN</option>
							<option value="wlan" <% nvram_indexmatch("parental_macif", 10, "wlan", "selected"); %>>WLAN</option>
							<option value="both" <% nvram_indexmatch("parental_macif", 10, "both", "selected"); %>>Both</option>
						</select>
					</td>
				</tr>
				<tr>
					<td class="form_list_content"><input id="parentalmacFilter11" name="parental_maclist11" value="<% nvram_list("parental_maclist", 11); %>" size="17" maxlength="17"></td>
					<td class="form_list_content">
						<select name="parental_macif11" id="parental_macif11">
							<option value="lan" <% nvram_indexmatch("parental_macif", 11, "lan", "selected"); %>>LAN</option>
							<option value="wlan" <% nvram_indexmatch("parental_macif", 11, "wlan", "selected"); %>>WLAN</option>
							<option value="both" <% nvram_indexmatch("parental_macif", 11, "both", "selected"); %>>Both</option>
						</select>
					</td>
				</tr>
				<tr>
					<td class="form_list_content"><input id="parentalmacFilter12" name="parental_maclist12" value="<% nvram_list("parental_maclist", 12); %>" size="17" maxlength="17"></td>
					<td class="form_list_content">
						<select name="parental_macif12" id="parental_macif12">
							<option value="lan" <% nvram_indexmatch("parental_macif", 12, "lan", "selected"); %>>LAN</option>
							<option value="wlan" <% nvram_indexmatch("parental_macif", 12, "wlan", "selected"); %>>WLAN</option>
							<option value="both" <% nvram_indexmatch("parental_macif", 12, "both", "selected"); %>>Both</option>
						</select>
					</td>
				</tr>
				<tr>
					<td class="form_list_content"><input id="parentalmacFilter13" name="parental_maclist13" value="<% nvram_list("parental_maclist", 13); %>" size="17" maxlength="17"></td>
					<td class="form_list_content">
						<select name="parental_macif13" id="parental_macif13">
							<option value="lan" <% nvram_indexmatch("parental_macif", 13, "lan", "selected"); %>>LAN</option>
							<option value="wlan" <% nvram_indexmatch("parental_macif", 13, "wlan", "selected"); %>>WLAN</option>
							<option value="both" <% nvram_indexmatch("parental_macif", 13, "both", "selected"); %>>Both</option>
						</select>
					</td>
				</tr>
				<tr>
					<td class="form_list_content"><input id="parentalmacFilter14" name="parental_maclist14" value="<% nvram_list("parental_maclist", 14); %>" size="17" maxlength="17"></td>
					<td class="form_list_content">
						<select name="parental_macif14" id="parental_macif14">
							<option value="lan" <% nvram_indexmatch("parental_macif", 14, "lan", "selected"); %>>LAN</option>
							<option value="wlan" <% nvram_indexmatch("parental_macif", 14, "wlan", "selected"); %>>WLAN</option>
							<option value="both" <% nvram_indexmatch("parental_macif", 14, "both", "selected"); %>>Both</option>
						</select>
					</td>
				</tr>
				<tr>
					<td class="form_list_content"><input id="parentalmacFilter15" name="parental_maclist15" value="<% nvram_list("parental_maclist", 15); %>" size="17" maxlength="17"></td>
					<td class="form_list_content">
						<select name="parental_macif15" id="parental_macif15">
							<option value="lan" <% nvram_indexmatch("parental_macif", 15, "lan", "selected"); %>>LAN</option>
							<option value="wlan" <% nvram_indexmatch("parental_macif", 15, "wlan", "selected"); %>>WLAN</option>
							<option value="both" <% nvram_indexmatch("parental_macif", 15, "both", "selected"); %>>Both</option>
						</select>
					</td>
				</tr>
				<tr>
					<td class="form_list_content"><input id="parentalmacFilter16" name="parental_maclist16" value="<% nvram_list("parental_maclist", 16); %>" size="17" maxlength="17"></td>
					<td class="form_list_content">
						<select name="parental_macif16" id="parental_macif16">
							<option value="lan" <% nvram_indexmatch("parental_macif", 16, "lan", "selected"); %>>LAN</option>
							<option value="wlan" <% nvram_indexmatch("parental_macif", 16, "wlan", "selected"); %>>WLAN</option>
							<option value="both" <% nvram_indexmatch("parental_macif", 16, "both", "selected"); %>>Both</option>
						</select>
					</td>
				</tr>
				<tr>
					<td class="form_list_content"><input id="parentalmacFilter17" name="parental_maclist17" value="<% nvram_list("parental_maclist", 17); %>" size="17" maxlength="17"></td>
					<td class="form_list_content">
						<select name="parental_macif17" id="parental_macif17">
							<option value="lan" <% nvram_indexmatch("parental_macif", 17, "lan", "selected"); %>>LAN</option>
							<option value="wlan" <% nvram_indexmatch("parental_macif", 17, "wlan", "selected"); %>>WLAN</option>
							<option value="both" <% nvram_indexmatch("parental_macif", 17, "both", "selected"); %>>Both</option>
						</select>
					</td>
				</tr>
				<tr>
					<td class="form_list_content"><input id="parentalmacFilter18" name="parental_maclist18" value="<% nvram_list("parental_maclist", 18); %>" size="17" maxlength="17"></td>
					<td class="form_list_content">
						<select name="parental_macif18" id="parental_macif18">
							<option value="lan" <% nvram_indexmatch("parental_macif", 18, "lan", "selected"); %>>LAN</option>
							<option value="wlan" <% nvram_indexmatch("parental_macif", 18, "wlan", "selected"); %>>WLAN</option>
							<option value="both" <% nvram_indexmatch("parental_macif", 18, "both", "selected"); %>>Both</option>
						</select>
					</td>
				</tr>
				<tr>
					<td class="form_list_content"><input id="parentalmacFilter19" name="parental_maclist19" value="<% nvram_list("parental_maclist", 19); %>" size="17" maxlength="17"></td>
					<td class="form_list_content">
						<select name="parental_macif19" id="parental_macif19">
							<option value="lan" <% nvram_indexmatch("parental_macif", 19, "lan", "selected"); %>>LAN</option>
							<option value="wlan" <% nvram_indexmatch("parental_macif", 19, "wlan", "selected"); %>>WLAN</option>
							<option value="both" <% nvram_indexmatch("parental_macif", 19, "both", "selected"); %>>Both</option>
						</select>
					</td>
				</tr>
				<tr>
					<td class="form_list_content"><input id="parentalmacFilter20" name="parental_maclist20" value="<% nvram_list("parental_maclist", 20); %>" size="17" maxlength="17"></td>
					<td class="form_list_content">
						<select name="parental_macif20" id="parental_macif20">
							<option value="lan" <% nvram_indexmatch("parental_macif", 20, "lan", "selected"); %>>LAN</option>
							<option value="wlan" <% nvram_indexmatch("parental_macif", 20, "wlan", "selected"); %>>WLAN</option>
							<option value="both" <% nvram_indexmatch("parental_macif", 20, "both", "selected"); %>>Both</option>
						</select>
					</td>
				</tr>
				<tr>
					<td class="form_list_content"><input id="parentalmacFilter21" name="parental_maclist21" value="<% nvram_list("parental_maclist", 21); %>" size="17" maxlength="17"></td>
					<td class="form_list_content">
						<select name="parental_macif21" id="parental_macif21">
							<option value="lan" <% nvram_indexmatch("parental_macif", 21, "lan", "selected"); %>>LAN</option>
							<option value="wlan" <% nvram_indexmatch("parental_macif", 21, "wlan", "selected"); %>>WLAN</option>
							<option value="both" <% nvram_indexmatch("parental_macif", 21, "both", "selected"); %>>Both</option>
						</select>
					</td>
				</tr>
				<tr>
					<td class="form_list_content"><input id="parentalmacFilter22" name="parental_maclist22" value="<% nvram_list("parental_maclist", 22); %>" size="17" maxlength="17"></td>
					<td class="form_list_content">
						<select name="parental_macif22" id="parental_macif22">
							<option value="lan" <% nvram_indexmatch("parental_macif", 22, "lan", "selected"); %>>LAN</option>
							<option value="wlan" <% nvram_indexmatch("parental_macif", 22, "wlan", "selected"); %>>WLAN</option>
							<option value="both" <% nvram_indexmatch("parental_macif", 22, "both", "selected"); %>>Both</option>
						</select>
					</td>
				</tr>
				<tr>
					<td class="form_list_content"><input id="parentalmacFilter23" name="parental_maclist23" value="<% nvram_list("parental_maclist", 23); %>" size="17" maxlength="17"></td>
					<td class="form_list_content">
						<select name="parental_macif23" id="parental_macif23">
							<option value="lan" <% nvram_indexmatch("parental_macif", 23, "lan", "selected"); %>>LAN</option>
							<option value="wlan" <% nvram_indexmatch("parental_macif", 23, "wlan", "selected"); %>>WLAN</option>
							<option value="both" <% nvram_indexmatch("parental_macif", 23, "both", "selected"); %>>Both</option>
						</select>
					</td>
				</tr>
				<tr style="display:none">
					<td class="form_list_content"><input id="parentalmacFilter24" name="parental_maclist24" value="<% nvram_list("parental_maclist", 24); %>" size="17" maxlength="17"></td>
					<td class="form_list_content">
						<select name="parental_macif24" id="parental_macif24">
							<option value="lan" <% nvram_indexmatch("parental_macif", 24, "lan", "selected"); %>>LAN</option>
							<option value="wlan" <% nvram_indexmatch("parental_macif", 24, "wlan", "selected"); %>>WLAN</option>
							<option value="both" <% nvram_indexmatch("parental_macif", 24, "both", "selected"); %>>Both</option>
						</select>
					</td>
				</tr>
				<tr style="display:none">
					<td class="form_list_content"><input id="parentalmacFilter25" name="parental_maclist25" value="<% nvram_list("parental_maclist", 25); %>" size="17" maxlength="17"></td>
					<td class="form_list_content">
						<select name="parental_macif25" id="parental_macif25">
							<option value="lan" <% nvram_indexmatch("parental_macif", 25, "lan", "selected"); %>>LAN</option>
							<option value="wlan" <% nvram_indexmatch("parental_macif", 25, "wlan", "selected"); %>>WLAN</option>
							<option value="both" <% nvram_indexmatch("parental_macif", 25, "both", "selected"); %>>Both</option>
						</select>
					</td>
				</tr>
				<tr style="display:none">
					<td class="form_list_content"><input id="parentalmacFilter26" name="parental_maclist26" value="<% nvram_list("parental_maclist", 26); %>" size="17" maxlength="17"></td>
					<td class="form_list_content">
						<select name="parental_macif26" id="parental_macif26">
							<option value="lan" <% nvram_indexmatch("parental_macif", 26, "lan", "selected"); %>>LAN</option>
							<option value="wlan" <% nvram_indexmatch("parental_macif", 26, "wlan", "selected"); %>>WLAN</option>
							<option value="both" <% nvram_indexmatch("parental_macif", 26, "both", "selected"); %>>Both</option>
						</select>
					</td>
				</tr>
				<tr style="display:none">
					<td class="form_list_content"><input id="parentalmacFilter27" name="parental_maclist27" value="<% nvram_list("parental_maclist", 27); %>" size="17" maxlength="17"></td>
					<td class="form_list_content">
						<select name="parental_macif27" id="parental_macif27">
							<option value="lan" <% nvram_indexmatch("parental_macif", 27, "lan", "selected"); %>>LAN</option>
							<option value="wlan" <% nvram_indexmatch("parental_macif", 27, "wlan", "selected"); %>>WLAN</option>
							<option value="both" <% nvram_indexmatch("parental_macif", 27, "both", "selected"); %>>Both</option>
						</select>
					</td>
				</tr>
				<tr style="display:none">
					<td class="form_list_content"><input id="parentalmacFilter28" name="parental_maclist28" value="<% nvram_list("parental_maclist", 28); %>" size="17" maxlength="17"></td>
					<td class="form_list_content">
						<select name="parental_macif28" id="parental_macif28">
							<option value="lan" <% nvram_indexmatch("parental_macif", 28, "lan", "selected"); %>>LAN</option>
							<option value="wlan" <% nvram_indexmatch("parental_macif", 28, "wlan", "selected"); %>>WLAN</option>
							<option value="both" <% nvram_indexmatch("parental_macif", 28, "both", "selected"); %>>Both</option>
						</select>
					</td>
				</tr>
				<tr style="display:none">
					<td class="form_list_content"><input id="parentalmacFilter29" name="parental_maclist29" value="<% nvram_list("parental_maclist", 29); %>" size="17" maxlength="17"></td>
					<td class="form_list_content">
						<select name="parental_macif29" id="parental_macif29">
							<option value="lan" <% nvram_indexmatch("parental_macif", 29, "lan", "selected"); %>>LAN</option>
							<option value="wlan" <% nvram_indexmatch("parental_macif", 29, "wlan", "selected"); %>>WLAN</option>
							<option value="both" <% nvram_indexmatch("parental_macif", 29, "both", "selected"); %>>Both</option>
						</select>
					</td>
				</tr>
				<tr style="display:none">
					<td class="form_list_content"><input id="parentalmacFilter30" name="parental_maclist30" value="<% nvram_list("parental_maclist", 30); %>" size="17" maxlength="17"></td>
					<td class="form_list_content">
						<select name="parental_macif30" id="parental_macif30">
							<option value="lan" <% nvram_indexmatch("parental_macif", 30, "lan", "selected"); %>>LAN</option>
							<option value="wlan" <% nvram_indexmatch("parental_macif", 30, "wlan", "selected"); %>>WLAN</option>
							<option value="both" <% nvram_indexmatch("parental_macif", 30, "both", "selected"); %>>Both</option>
						</select>
					</td>
				</tr>
				<tr style="display:none">
					<td class="form_list_content"><input id="parentalmacFilter31" name="parental_maclist31" value="<% nvram_list("parental_maclist", 31); %>" size="17" maxlength="17"></td>
					<td class="form_list_content">
						<select name="parental_macif31" id="parental_macif31">
							<option value="lan" <% nvram_indexmatch("parental_macif", 31, "lan", "selected"); %>>LAN</option>
							<option value="wlan" <% nvram_indexmatch("parental_macif", 31, "wlan", "selected"); %>>WLAN</option>
							<option value="both" <% nvram_indexmatch("parental_macif", 31, "both", "selected"); %>>Both</option>
						</select>
					</td>
				</tr>
				<tr style="display:none">
					<td class="form_list_content"><input id="parentalmacFilter32" name="parental_maclist32" value="<% nvram_list("parental_maclist", 32); %>" size="17" maxlength="17"></td>
					<td class="form_list_content">
						<select name="parental_macif32" id="parental_macif32">
							<option value="lan" <% nvram_indexmatch("parental_macif", 32, "lan", "selected"); %>>LAN</option>
							<option value="wlan" <% nvram_indexmatch("parental_macif", 32, "wlan", "selected"); %>>WLAN</option>
							<option value="both" <% nvram_indexmatch("parental_macif", 32, "both", "selected"); %>>Both</option>
						</select>
					</td>
				</tr>
				<tr style="display:none">
					<td class="form_list_content"><input id="parentalmacFilter33" name="parental_maclist33" value="<% nvram_list("parental_maclist", 33); %>" size="17" maxlength="17"></td>
					<td class="form_list_content">
						<select name="parental_macif33" id="parental_macif33">
							<option value="lan" <% nvram_indexmatch("parental_macif", 33, "lan", "selected"); %>>LAN</option>
							<option value="wlan" <% nvram_indexmatch("parental_macif", 33, "wlan", "selected"); %>>WLAN</option>
							<option value="both" <% nvram_indexmatch("parental_macif", 33, "both", "selected"); %>>Both</option>
						</select>
					</td>
				</tr>
				<tr style="display:none">
					<td class="form_list_content"><input id="parentalmacFilter34" name="parental_maclist34" value="<% nvram_list("parental_maclist", 34); %>" size="17" maxlength="17"></td>
					<td class="form_list_content">
						<select name="parental_macif34" id="parental_macif34">
							<option value="lan" <% nvram_indexmatch("parental_macif", 34, "lan", "selected"); %>>LAN</option>
							<option value="wlan" <% nvram_indexmatch("parental_macif", 34, "wlan", "selected"); %>>WLAN</option>
							<option value="both" <% nvram_indexmatch("parental_macif", 34, "both", "selected"); %>>Both</option>
						</select>
					</td>
				</tr>
				<tr style="display:none">
					<td class="form_list_content"><input id="parentalmacFilter35" name="parental_maclist35" value="<% nvram_list("parental_maclist", 35); %>" size="17" maxlength="17"></td>
					<td class="form_list_content">
						<select name="parental_macif35" id="parental_macif35">
							<option value="lan" <% nvram_indexmatch("parental_macif", 35, "lan", "selected"); %>>LAN</option>
							<option value="wlan" <% nvram_indexmatch("parental_macif", 35, "wlan", "selected"); %>>WLAN</option>
							<option value="both" <% nvram_indexmatch("parental_macif", 35, "both", "selected"); %>>Both</option>
						</select>
					</td>
				</tr>
				<tr style="display:none">
					<td class="form_list_content"><input id="parentalmacFilter36" name="parental_maclist36" value="<% nvram_list("parental_maclist", 36); %>" size="17" maxlength="17"></td>
					<td class="form_list_content">
						<select name="parental_macif36" id="parental_macif36">
							<option value="lan" <% nvram_indexmatch("parental_macif", 36, "lan", "selected"); %>>LAN</option>
							<option value="wlan" <% nvram_indexmatch("parental_macif", 36, "wlan", "selected"); %>>WLAN</option>
							<option value="both" <% nvram_indexmatch("parental_macif", 36, "both", "selected"); %>>Both</option>
						</select>
					</td>
				</tr>
				<tr style="display:none">
					<td class="form_list_content"><input id="parentalmacFilter37" name="parental_maclist37" value="<% nvram_list("parental_maclist", 37); %>" size="17" maxlength="17"></td>
					<td class="form_list_content">
						<select name="parental_macif37" id="parental_macif37">
							<option value="lan" <% nvram_indexmatch("parental_macif", 37, "lan", "selected"); %>>LAN</option>
							<option value="wlan" <% nvram_indexmatch("parental_macif", 37, "wlan", "selected"); %>>WLAN</option>
							<option value="both" <% nvram_indexmatch("parental_macif", 37, "both", "selected"); %>>Both</option>
						</select>
					</td>
				</tr>
				<tr style="display:none">
					<td class="form_list_content"><input id="parentalmacFilter38" name="parental_maclist38" value="<% nvram_list("parental_maclist", 38); %>" size="17" maxlength="17"></td>
					<td class="form_list_content">
						<select name="parental_macif38" id="parental_macif38">
							<option value="lan" <% nvram_indexmatch("parental_macif", 38, "lan", "selected"); %>>LAN</option>
							<option value="wlan" <% nvram_indexmatch("parental_macif", 38, "wlan", "selected"); %>>WLAN</option>
							<option value="both" <% nvram_indexmatch("parental_macif", 38, "both", "selected"); %>>Both</option>
						</select>
					</td>
				</tr>
				<tr style="display:none">
					<td class="form_list_content"><input id="parentalmacFilter39" name="parental_maclist39" value="<% nvram_list("parental_maclist", 39); %>" size="17" maxlength="17"></td>
					<td class="form_list_content">
						<select name="parental_macif39" id="parental_macif39">
							<option value="lan" <% nvram_indexmatch("parental_macif", 39, "lan", "selected"); %>>LAN</option>
							<option value="wlan" <% nvram_indexmatch("parental_macif", 39, "wlan", "selected"); %>>WLAN</option>
							<option value="both" <% nvram_indexmatch("parental_macif", 39, "both", "selected"); %>>Both</option>
						</select>
					</td>
				</tr>
				<tr style="display:none">
					<td class="form_list_content"><input id="parentalmacFilter40" name="parental_maclist40" value="<% nvram_list("parental_maclist", 40); %>" size="17" maxlength="17"></td>
					<td class="form_list_content">
						<select name="parental_macif40" id="parental_macif40">
							<option value="lan" <% nvram_indexmatch("parental_macif", 40, "lan", "selected"); %>>LAN</option>
							<option value="wlan" <% nvram_indexmatch("parental_macif", 40, "wlan", "selected"); %>>WLAN</option>
							<option value="both" <% nvram_indexmatch("parental_macif", 40, "both", "selected"); %>>Both</option>
						</select>
					</td>
				</tr>
				<tr style="display:none">
					<td class="form_list_content"><input id="parentalmacFilter41" name="parental_maclist41" value="<% nvram_list("parental_maclist", 41); %>" size="17" maxlength="17"></td>
					<td class="form_list_content">
						<select name="parental_macif41" id="parental_macif41">
							<option value="lan" <% nvram_indexmatch("parental_macif", 41, "lan", "selected"); %>>LAN</option>
							<option value="wlan" <% nvram_indexmatch("parental_macif", 41, "wlan", "selected"); %>>WLAN</option>
							<option value="both" <% nvram_indexmatch("parental_macif", 41, "both", "selected"); %>>Both</option>
						</select>
					</td>
				</tr>
				<tr style="display:none">
					<td class="form_list_content"><input id="parentalmacFilter42" name="parental_maclist42" value="<% nvram_list("parental_maclist", 42); %>" size="17" maxlength="17"></td>
					<td class="form_list_content">
						<select name="parental_macif42" id="parental_macif42">
							<option value="lan" <% nvram_indexmatch("parental_macif", 42, "lan", "selected"); %>>LAN</option>
							<option value="wlan" <% nvram_indexmatch("parental_macif", 42, "wlan", "selected"); %>>WLAN</option>
							<option value="both" <% nvram_indexmatch("parental_macif", 42, "both", "selected"); %>>Both</option>
						</select>
					</td>
				</tr>
				<tr style="display:none">
					<td class="form_list_content"><input id="parentalmacFilter43" name="parental_maclist43" value="<% nvram_list("parental_maclist", 43); %>" size="17" maxlength="17"></td>
					<td class="form_list_content">
						<select name="parental_macif43" id="parental_macif43">
							<option value="lan" <% nvram_indexmatch("parental_macif", 43, "lan", "selected"); %>>LAN</option>
							<option value="wlan" <% nvram_indexmatch("parental_macif", 43, "wlan", "selected"); %>>WLAN</option>
							<option value="both" <% nvram_indexmatch("parental_macif", 43, "both", "selected"); %>>Both</option>
						</select>
					</td>
				</tr>
				<tr style="display:none">
					<td class="form_list_content"><input id="parentalmacFilter44" name="parental_maclist44" value="<% nvram_list("parental_maclist", 44); %>" size="17" maxlength="17"></td>
					<td class="form_list_content">
						<select name="parental_macif44" id="parental_macif44">
							<option value="lan" <% nvram_indexmatch("parental_macif", 44, "lan", "selected"); %>>LAN</option>
							<option value="wlan" <% nvram_indexmatch("parental_macif", 44, "wlan", "selected"); %>>WLAN</option>
							<option value="both" <% nvram_indexmatch("parental_macif", 44, "both", "selected"); %>>Both</option>
						</select>
					</td>
				</tr>
				<tr style="display:none">
					<td class="form_list_content"><input id="parentalmacFilter45" name="parental_maclist45" value="<% nvram_list("parental_maclist", 45); %>" size="17" maxlength="17"></td>
					<td class="form_list_content">
						<select name="parental_macif45" id="parental_macif45">
							<option value="lan" <% nvram_indexmatch("parental_macif", 45, "lan", "selected"); %>>LAN</option>
							<option value="wlan" <% nvram_indexmatch("parental_macif", 45, "wlan", "selected"); %>>WLAN</option>
							<option value="both" <% nvram_indexmatch("parental_macif", 45, "both", "selected"); %>>Both</option>
						</select>
					</td>
				</tr>
				<tr style="display:none">
					<td class="form_list_content"><input id="parentalmacFilter46" name="parental_maclist46" value="<% nvram_list("parental_maclist", 46); %>" size="17" maxlength="17"></td>
					<td class="form_list_content">
						<select name="parental_macif46" id="parental_macif46">
							<option value="lan" <% nvram_indexmatch("parental_macif", 46, "lan", "selected"); %>>LAN</option>
							<option value="wlan" <% nvram_indexmatch("parental_macif", 46, "wlan", "selected"); %>>WLAN</option>
							<option value="both" <% nvram_indexmatch("parental_macif", 46, "both", "selected"); %>>Both</option>
						</select>
					</td>
				</tr>
				<tr style="display:none">
					<td class="form_list_content"><input id="parentalmacFilter47" name="parental_maclist47" value="<% nvram_list("parental_maclist", 47); %>" size="17" maxlength="17"></td>
					<td class="form_list_content">
						<select name="parental_macif47" id="parental_macif47">
							<option value="lan" <% nvram_indexmatch("parental_macif", 47, "lan", "selected"); %>>LAN</option>
							<option value="wlan" <% nvram_indexmatch("parental_macif", 47, "wlan", "selected"); %>>WLAN</option>
							<option value="both" <% nvram_indexmatch("parental_macif", 47, "both", "selected"); %>>Both</option>
						</select>
					</td>
				</tr>
			</table>
		</td>

	</tr>
</table>

<table width="100%" class="tbl_main" style="display:none">
	<tr>
		<td class="CT" colspan="2"><!--#tr id="filter.lan.mac.filter"-->LAN MAC Filters<!--#endtr--></td>
	</tr>

  <tr>
    <td class="CL"
	onMouseOver="return overlib('Selects whether clients with the specified MAC address are allowed or denied access to the router and the WAN.', LEFT);"
	onMouseOut="return nd();">
	<!--#tr id="filter.lan.mac.filter.mode"-->LAN MAC Filter Mode<!--#endtr-->
    </td>
    <td class="CR">
	<select name="filter_macmode" id="filter_macmode">
	  <option value="disabled" <% nvram_match("filter_macmode", "disabled", "selected"); %>><!--#tr id="disabled"-->Disabled<!--#endtr--></option>
	  <option value="allow" <% nvram_match("filter_macmode", "allow", "selected"); %>><!--#tr id="allow"-->Allow<!--#endtr--></option>
	  <option value="deny" <% nvram_match("filter_macmode", "deny", "selected"); %>><!--#tr id="deny"-->Deny<!--#endtr--></option>
	</select>
    </td>
  </tr>
  <tr>
    <td class="CL" valign="top" rowspan="16"
	onMouseOver="return overlib('Filter packets from LAN machines with the specified MAC addresses. The MAC address format is XX:XX:XX:XX:XX:XX.', LEFT);"
	onMouseOut="return nd();">
	<input type="hidden" name="filter_maclist" value="48">
	<!--#tr id="filter.lan.mac.filter"-->LAN MAC Filters<!--#endtr-->
    </td>
		<td class="CR">
			<table width="100%" class="tbl_main2" style="border-collapse: separate;">
				<tr>
					<td><input id="macFilter0" name="filter_maclist0" value="<% nvram_list("filter_maclist", 0); %>" size="17" maxlength="17"></td>
					<td><input id="macFilter1" name="filter_maclist1" value="<% nvram_list("filter_maclist", 1); %>" size="17" maxlength="17"></td>
					<td><input id="macFilter2" name="filter_maclist2" value="<% nvram_list("filter_maclist", 2); %>" size="17" maxlength="17"></td>
				</tr>
				<tr>
					<td><input id="macFilter3" name="filter_maclist3" value="<% nvram_list("filter_maclist", 3); %>" size="17" maxlength="17"></td>
					<td><input id="macFilter4" name="filter_maclist4" value="<% nvram_list("filter_maclist", 4); %>" size="17" maxlength="17"></td>
					<td><input id="macFilter5" name="filter_maclist5" value="<% nvram_list("filter_maclist", 5); %>" size="17" maxlength="17"></td>
				</tr>
				<tr>
					<td><input id="macFilter6" name="filter_maclist6" value="<% nvram_list("filter_maclist", 6); %>" size="17" maxlength="17"></td>
					<td><input id="macFilter7" name="filter_maclist7" value="<% nvram_list("filter_maclist", 7); %>" size="17" maxlength="17"></td>
					<td><input id="macFilter8" name="filter_maclist8" value="<% nvram_list("filter_maclist", 8); %>" size="17" maxlength="17"></td>
				</tr>
				<tr>
					<td><input id="macFilter9" name="filter_maclist9" value="<% nvram_list("filter_maclist", 9); %>" size="17" maxlength="17"></td>
					<td><input id="macFilter10" name="filter_maclist10" value="<% nvram_list("filter_maclist", 10); %>" size="17" maxlength="17"></td>
					<td><input id="macFilter11" name="filter_maclist11" value="<% nvram_list("filter_maclist", 11); %>" size="17" maxlength="17"></td>
				</tr>
				<tr>
					<td><input id="macFilter12" name="filter_maclist12" value="<% nvram_list("filter_maclist", 12); %>" size="17" maxlength="17"></td>
					<td><input id="macFilter13" name="filter_maclist13" value="<% nvram_list("filter_maclist", 13); %>" size="17" maxlength="17"></td>
					<td><input id="macFilter14" name="filter_maclist14" value="<% nvram_list("filter_maclist", 14); %>" size="17" maxlength="17"></td>
				</tr>
				<tr>
					<td><input id="macFilter15" name="filter_maclist15" value="<% nvram_list("filter_maclist", 15); %>" size="17" maxlength="17"></td>
					<td><input id="macFilter16" name="filter_maclist16" value="<% nvram_list("filter_maclist", 16); %>" size="17" maxlength="17"></td>
					<td><input id="macFilter17" name="filter_maclist17" value="<% nvram_list("filter_maclist", 17); %>" size="17" maxlength="17"></td>
				</tr>
				<tr>
					<td><input id="macFilter18" name="filter_maclist18" value="<% nvram_list("filter_maclist", 18); %>" size="17" maxlength="17"></td>
					<td><input id="macFilter19" name="filter_maclist19" value="<% nvram_list("filter_maclist", 19); %>" size="17" maxlength="17"></td>
					<td><input id="macFilter20" name="filter_maclist20" value="<% nvram_list("filter_maclist", 20); %>" size="17" maxlength="17"></td>
				</tr>
				<tr>
					<td><input id="macFilter21" name="filter_maclist21" value="<% nvram_list("filter_maclist", 21); %>" size="17" maxlength="17"></td>
					<td><input id="macFilter22" name="filter_maclist22" value="<% nvram_list("filter_maclist", 22); %>" size="17" maxlength="17"></td>
					<td><input id="macFilter23" name="filter_maclist23" value="<% nvram_list("filter_maclist", 23); %>" size="17" maxlength="17"></td>
				</tr>
				<tr>
					<td><input id="macFilter24" name="filter_maclist24" value="<% nvram_list("filter_maclist", 24); %>" size="17" maxlength="17"></td>
					<td><input id="macFilter25" name="filter_maclist25" value="<% nvram_list("filter_maclist", 25); %>" size="17" maxlength="17"></td>
					<td><input id="macFilter26" name="filter_maclist26" value="<% nvram_list("filter_maclist", 26); %>" size="17" maxlength="17"></td>
				</tr>
				<tr>
					<td><input id="macFilter27" name="filter_maclist27" value="<% nvram_list("filter_maclist", 27); %>" size="17" maxlength="17"></td>
					<td><input id="macFilter28" name="filter_maclist28" value="<% nvram_list("filter_maclist", 28); %>" size="17" maxlength="17"></td>
					<td><input id="macFilter29" name="filter_maclist29" value="<% nvram_list("filter_maclist", 29); %>" size="17" maxlength="17"></td>
				</tr>
				<tr>
					<td><input id="macFilter30" name="filter_maclist30" value="<% nvram_list("filter_maclist", 30); %>" size="17" maxlength="17"></td>
					<td><input id="macFilter31" name="filter_maclist31" value="<% nvram_list("filter_maclist", 31); %>" size="17" maxlength="17"></td>
					<td><input id="macFilter32" name="filter_maclist32" value="<% nvram_list("filter_maclist", 32); %>" size="17" maxlength="17"></td>
				</tr>
				<tr>
					<td><input id="macFilter33" name="filter_maclist33" value="<% nvram_list("filter_maclist", 33); %>" size="17" maxlength="17"></td>
					<td><input id="macFilter34" name="filter_maclist34" value="<% nvram_list("filter_maclist", 34); %>" size="17" maxlength="17"></td>
					<td><input id="macFilter35" name="filter_maclist35" value="<% nvram_list("filter_maclist", 35); %>" size="17" maxlength="17"></td>
				</tr>
				<tr>
					<td><input id="macFilter36" name="filter_maclist36" value="<% nvram_list("filter_maclist", 36); %>" size="17" maxlength="17"></td>
					<td><input id="macFilter37" name="filter_maclist37" value="<% nvram_list("filter_maclist", 37); %>" size="17" maxlength="17"></td>
					<td><input id="macFilter38" name="filter_maclist38" value="<% nvram_list("filter_maclist", 38); %>" size="17" maxlength="17"></td>
				</tr>
				<tr>
					<td><input id="macFilter39" name="filter_maclist39" value="<% nvram_list("filter_maclist", 39); %>" size="17" maxlength="17"></td>
					<td><input id="macFilter40" name="filter_maclist40" value="<% nvram_list("filter_maclist", 40); %>" size="17" maxlength="17"></td>
					<td><input id="macFilter41" name="filter_maclist41" value="<% nvram_list("filter_maclist", 41); %>" size="17" maxlength="17"></td>
				</tr>
				<tr>
					<td><input id="macFilter42" name="filter_maclist42" value="<% nvram_list("filter_maclist", 42); %>" size="17" maxlength="17"></td>
					<td><input id="macFilter43" name="filter_maclist43" value="<% nvram_list("filter_maclist", 43); %>" size="17" maxlength="17"></td>
					<td><input id="macFilter44" name="filter_maclist44" value="<% nvram_list("filter_maclist", 44); %>" size="17" maxlength="17"></td>
				</tr>
				<tr>
					<td><input id="macFilter45" name="filter_maclist45" value="<% nvram_list("filter_maclist", 45); %>" size="17" maxlength="17"></td>
					<td><input id="macFilter46" name="filter_maclist46" value="<% nvram_list("filter_maclist", 46); %>" size="17" maxlength="17"></td>
					<td><input id="macFilter47" name="filter_maclist47" value="<% nvram_list("filter_maclist", 47); %>" size="17" maxlength="17"></td>
				</tr>
			</table>
		</td>
	</tr>
</table>

<table width="100%" class="tbl_main" style="display:none">
	<tr>
		<td class="CT" colspan="4"><!--#tr id="security.44"-->Wireless MAC Filter<!--#endtr--></td>
	</tr>
	<tr>
		<td class="CL"
		onMouseOver="return overlib('Selects whether clients with the specified MAC address are allowed or denied wireless access.', LEFT);"
		onMouseOut="return nd();">
		<!--#tr id="security.41"-->Filter Mode<!--#endtr-->
		</td>
		<td class="CR" colspan="3">
			<select name="wl_macmode" id="wl_macmode">
				<option value="disabled" <% nvram_match("wl_macmode", "disabled", "selected"); %>><!--#tr id="disabled"-->Disabled<!--#endtr--></option>
				<option value="allow" <% nvram_match("wl_macmode", "allow", "selected"); %>><!--#tr id="allow"-->Allow<!--#endtr--></option>
				<option value="deny" <% nvram_match("wl_macmode", "deny", "selected"); %>><!--#tr id="deny"-->Deny<!--#endtr--></option>
			</select>
		</td>
	</tr>
	<tr>
		<td class="CL" valign="top" rowspan="16"
		onMouseOver="return overlib('Allows or denies wireless access to clients with the specified MAC addresses. The MAC address format is XX:XX:XX:XX:XX:XX.', LEFT);"
		onMouseOut="return nd();">
		<input type="hidden" name="wl_maclist" value="48">
		<!--#tr id="mac.address"-->MAC Address<!--#endtr-->
		</td>
		<td class="CR2"><input id="macAddressInput0" name="wl_maclist0" value="<% nvram_list("wl_maclist", 0); %>" size="17" maxlength="17"></td>
		<td class="CR2"><input id="macAddressInput1" name="wl_maclist1" value="<% nvram_list("wl_maclist", 1); %>" size="17" maxlength="17"></td>
		<td class="CR2"><input id="macAddressInput2" name="wl_maclist2" value="<% nvram_list("wl_maclist", 2); %>" size="17" maxlength="17"></td>
	</tr>
	<tr>
		<td class="CR2"><input id="macAddressInput3" name="wl_maclist3" value="<% nvram_list("wl_maclist", 3); %>" size="17" maxlength="17"></td>
		<td class="CR2"><input id="macAddressInput4" name="wl_maclist4" value="<% nvram_list("wl_maclist", 4); %>" size="17" maxlength="17"></td>
		<td class="CR2"><input id="macAddressInput5" name="wl_maclist5" value="<% nvram_list("wl_maclist", 5); %>" size="17" maxlength="17"></td>
	</tr>
	<tr>
		<td class="CR2"><input id="macAddressInput6" name="wl_maclist6" value="<% nvram_list("wl_maclist", 6); %>" size="17" maxlength="17"></td>
		<td class="CR2"><input id="macAddressInput7" name="wl_maclist7" value="<% nvram_list("wl_maclist", 7); %>" size="17" maxlength="17"></td>
		<td class="CR2"><input id="macAddressInput8" name="wl_maclist8" value="<% nvram_list("wl_maclist", 8); %>" size="17" maxlength="17"></td>
	</tr>
	<tr>
		<td class="CR2"><input id="macAddressInput9" name="wl_maclist9" value="<% nvram_list("wl_maclist", 9); %>" size="17" maxlength="17"></td>
		<td class="CR2"><input id="macAddressInput10" name="wl_maclist10" value="<% nvram_list("wl_maclist", 10); %>" size="17" maxlength="17"></td>
		<td class="CR2"><input id="macAddressInput11" name="wl_maclist11" value="<% nvram_list("wl_maclist", 11); %>" size="17" maxlength="17"></td>
	</tr>
	<tr>
		<td class="CR2"><input id="macAddressInput12" name="wl_maclist12" value="<% nvram_list("wl_maclist", 12); %>" size="17" maxlength="17"></td>
		<td class="CR2"><input id="macAddressInput13" name="wl_maclist13" value="<% nvram_list("wl_maclist", 13); %>" size="17" maxlength="17"></td>
		<td class="CR2"><input id="macAddressInput14" name="wl_maclist14" value="<% nvram_list("wl_maclist", 14); %>" size="17" maxlength="17"></td>
	</tr>
	<tr>
		<td class="CR2"><input id="macAddressInput15" name="wl_maclist15" value="<% nvram_list("wl_maclist", 15); %>" size="17" maxlength="17"></td>
		<td class="CR2"><input id="macAddressInput16" name="wl_maclist16" value="<% nvram_list("wl_maclist", 16); %>" size="17" maxlength="17"></td>
		<td class="CR2"><input id="macAddressInput17" name="wl_maclist17" value="<% nvram_list("wl_maclist", 17); %>" size="17" maxlength="17"></td>
	</tr>
	<tr>
		<td class="CR2"><input id="macAddressInput18" name="wl_maclist18" value="<% nvram_list("wl_maclist", 18); %>" size="17" maxlength="17"></td>
		<td class="CR2"><input id="macAddressInput19" name="wl_maclist19" value="<% nvram_list("wl_maclist", 19); %>" size="17" maxlength="17"></td>
		<td class="CR2"><input id="macAddressInput20" name="wl_maclist20" value="<% nvram_list("wl_maclist", 20); %>" size="17" maxlength="17"></td>
	</tr>
	<tr>
		<td class="CR2"><input id="macAddressInput21" name="wl_maclist21" value="<% nvram_list("wl_maclist", 21); %>" size="17" maxlength="17"></td>
		<td class="CR2"><input id="macAddressInput22" name="wl_maclist22" value="<% nvram_list("wl_maclist", 22); %>" size="17" maxlength="17"></td>
		<td class="CR2"><input id="macAddressInput23" name="wl_maclist23" value="<% nvram_list("wl_maclist", 23); %>" size="17" maxlength="17"></td>
	</tr>
	<tr>
		<td class="CR2"><input id="macAddressInput24" name="wl_maclist24" value="<% nvram_list("wl_maclist", 24); %>" size="17" maxlength="17"></td>
		<td class="CR2"><input id="macAddressInput25" name="wl_maclist25" value="<% nvram_list("wl_maclist", 25); %>" size="17" maxlength="17"></td>
		<td class="CR2"><input id="macAddressInput26" name="wl_maclist26" value="<% nvram_list("wl_maclist", 26); %>" size="17" maxlength="17"></td>
	</tr>
	<tr>
		<td class="CR2"><input id="macAddressInput27" name="wl_maclist27" value="<% nvram_list("wl_maclist", 27); %>" size="17" maxlength="17"></td>
		<td class="CR2"><input id="macAddressInput28" name="wl_maclist28" value="<% nvram_list("wl_maclist", 28); %>" size="17" maxlength="17"></td>
		<td class="CR2"><input id="macAddressInput29" name="wl_maclist29" value="<% nvram_list("wl_maclist", 29); %>" size="17" maxlength="17"></td>
	</tr>
	<tr>
		<td class="CR2"><input id="macAddressInput30" name="wl_maclist30" value="<% nvram_list("wl_maclist", 30); %>" size="17" maxlength="17"></td>
		<td class="CR2"><input id="macAddressInput31" name="wl_maclist31" value="<% nvram_list("wl_maclist", 31); %>" size="17" maxlength="17"></td>
		<td class="CR2"><input id="macAddressInput32" name="wl_maclist32" value="<% nvram_list("wl_maclist", 32); %>" size="17" maxlength="17"></td>
	</tr>
	<tr>
		<td class="CR2"><input id="macAddressInput33" name="wl_maclist33" value="<% nvram_list("wl_maclist", 33); %>" size="17" maxlength="17"></td>
		<td class="CR2"><input id="macAddressInput34" name="wl_maclist34" value="<% nvram_list("wl_maclist", 34); %>" size="17" maxlength="17"></td>
		<td class="CR2"><input id="macAddressInput35" name="wl_maclist35" value="<% nvram_list("wl_maclist", 35); %>" size="17" maxlength="17"></td>
	</tr>
	<tr>
		<td class="CR2"><input id="macAddressInput36" name="wl_maclist36" value="<% nvram_list("wl_maclist", 36); %>" size="17" maxlength="17"></td>
		<td class="CR2"><input id="macAddressInput37" name="wl_maclist37" value="<% nvram_list("wl_maclist", 37); %>" size="17" maxlength="17"></td>
		<td class="CR2"><input id="macAddressInput38" name="wl_maclist38" value="<% nvram_list("wl_maclist", 38); %>" size="17" maxlength="17"></td>
	</tr>
	<tr>
		<td class="CR2"><input id="macAddressInput39" name="wl_maclist39" value="<% nvram_list("wl_maclist", 39); %>" size="17" maxlength="17"></td>
		<td class="CR2"><input id="macAddressInput40" name="wl_maclist40" value="<% nvram_list("wl_maclist", 40); %>" size="17" maxlength="17"></td>
		<td class="CR2"><input id="macAddressInput41" name="wl_maclist41" value="<% nvram_list("wl_maclist", 41); %>" size="17" maxlength="17"></td>
	</tr>
	<tr>
		<td class="CR2"><input id="macAddressInput42" name="wl_maclist42" value="<% nvram_list("wl_maclist", 42); %>" size="17" maxlength="17"></td>
		<td class="CR2"><input id="macAddressInput43" name="wl_maclist43" value="<% nvram_list("wl_maclist", 43); %>" size="17" maxlength="17"></td>
		<td class="CR2"><input id="macAddressInput44" name="wl_maclist44" value="<% nvram_list("wl_maclist", 44); %>" size="17" maxlength="17"></td>
	</tr>
	<tr>
		<td class="CR2"><input id="macAddressInput45" name="wl_maclist45" value="<% nvram_list("wl_maclist", 45); %>" size="17" maxlength="17"></td>
		<td class="CR2"><input id="macAddressInput46" name="wl_maclist46" value="<% nvram_list("wl_maclist", 46); %>" size="17" maxlength="17"></td>
		<td class="CR2"><input id="macAddressInput47" name="wl_maclist47" value="<% nvram_list("wl_maclist", 47); %>" size="17" maxlength="17"></td>
	</tr>
</table>

<table width="100%" class="tbl_main">
	<tr align="center">
		<td>
			<input type="submit" class="button1" name="action" value="<!--#tr id="apply"-->Apply<!--#endtr-->">
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
