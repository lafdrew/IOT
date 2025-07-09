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
function wl_ewc_options(nphy_set)
{
	var bw;
	var bw_cap;
	var frameburst;
	var nmode;

	//Tom.Hung 2012-12-4, Keep cur MCS index
	var cur_mcsidx;
	var nmcsidx = document.radio.wl_nmcsidx;
	for(i=0;i<nmcsidx.length;i++) {
		if(nmcsidx[i].selected == true) {
			cur_mcsidx = nmcsidx[i].value;
			break;
		}
	}
	//Tom.Hung 2012-12-4 end

	if (nphy_set == "0")
		return;

	nmode = document.radio.wl_nmode[document.radio.wl_nmode.selectedIndex].value;
	if (nmode != "0") {
		<% wl_um_nphyrates("0"); %>
		document.radio.wl_nmcsidx.disabled = false;
		//Tom.Hung 2012-12-4, Keep cur MCS index
		for(i=0;i<nmcsidx.length;i++) {
			if(nmcsidx[i].value == cur_mcsidx) {
				nmcsidx[i].selected = true;
				break;
			}
		}
		//Tom.Hung 2012-12-4 end
		return;
	}

	document.radio.wl_bw_cap.disabled = 0;

	/* If nmode is disabled, allow only 20Mhz selection */
	if (nmode == "0") {
		document.radio.wl_bw_cap.selectedIndex = 0;
		document.radio.wl_bw_cap.disabled = 1;
	}

	bw_cap = document.radio.wl_bw_cap[document.radio.wl_bw_cap.selectedIndex].value;

	/* TODO: Need to add 80 MHz phy rates... */
	if (bw_cap == "7")
		bw = "40";
	else if (bw_cap == "3")
		bw = "40";
	else
		bw = "20";

	if (bw == "40") {
		<% wl_um_nphyrates("40"); %>
	} else if (bw == "20") {
		<% wl_um_nphyrates("20"); %>
	}

	if (nmode == "0") {
		document.radio.wl_nmcsidx.disabled = true;
	} else {
		document.radio.wl_nmcsidx.disabled = false;
	}

	//Tom.Hung 2012-12-4, Keep cur MCS index
	for(i=0;i<nmcsidx.length;i++) {
		if(nmcsidx[i].value == cur_mcsidx) {
			nmcsidx[i].selected = true;
			break;
		}
	}
	//Tom.Hung 2012-12-4 end
}

function checkValue()
{
	var reg = /^0$|^[1-9][0-9]*$/; //user could only input 0(only 1 digit) or a number which fist digit is not 0

	var bci = document.radio.wl_bcn;
	if (bci.value == "" )
	{
		Alert.render("<!--#tr id="wa.alert.1"-->Please specify Beacon Interval.<!--#endtr-->");
		bci.focus();
		bci.select();
		return false;
	}
	if (!reg.test(bci.value)) {
		Alert.render("<!--#tr id="wa.alert.11"-->The Beacon Interval must be an integer!<!--#endtr-->");
		return false;
	}
	if (isNaN(bci.value) || bci.value < 20 || bci.value > 1000 || !checkInteger(bci.value))
	{
		Alert.render("<!--#tr id="wa.alert.2"-->Invalid Beacon Interval.<!--#endtr-->");
		bci.focus();
		bci.select();
		return false;
	}

	var dtim = document.radio.wl_dtim;
	if (dtim.value == "")
	{
		Alert.render("<!--#tr id="wa.alert.3"-->Please specify DTIM Interval.<!--#endtr-->");
		dtim.focus();
		dtim.select();
		return false;
	}
	
	if (!reg.test(dtim.value)) {
		Alert.render("<!--#tr id="wa.alert.12"-->The DTIM must be an integer!<!--#endtr-->");
		return false;
	}

	if (isNaN(dtim.value) || dtim.value < 1 || dtim.value > 255 || !checkInteger(dtim.value))
	{
		Alert.render("<!--#tr id="wa.alert.4"-->Invalid DTIM Interval.<!--#endtr-->");
		dtim.focus();
		dtim.select();
		return false;
	}

	var ft = document.radio.wl_frag;
	if (ft.value == "" )
	{
		Alert.render("<!--#tr id="wa.alert.5"-->Please specify Fragmentation Length.<!--#endtr-->");
		ft.focus();
		ft.select();
		return false;
	}
	
	if (!reg.test(ft.value)) {
		Alert.render("<!--#tr id="wa.alert.13"-->The Fragment Threshold must be an integer!<!--#endtr-->");
		return false;
	}

	if (isNaN(ft.value) || ft.value < 256 || ft.value > 2346)
	{
		Alert.render("<!--#tr id="wa.alert.6"-->Invalid Fragmentation Length.<!--#endtr-->");
		ft.focus();
		ft.select();
		return false;
	}
	
	if (ft.value.indexOf(".") >=  0) {
		Alert.render("<!--#tr id="wa.alert.7"-->The Fragement Threshold value must be an integer!<!--#endtr-->")
		return false;
	}
	
	var rts = document.radio.wl_rts;
	if (rts.value == "" )
	{
		Alert.render("<!--#tr id="wa.alert.8"-->Please specify RTS Threshold.<!--#endtr-->");
		rts.focus();
		rts.select();
		return false;
	}
	
	if (!reg.test(rts.value)) {
		Alert.render("<!--#tr id="wa.alert.14"-->The RTS Threshold vale must be an integer!<!--#endtr-->");
		return false;
	}

	if (isNaN(rts.value) || rts.value < 1 || rts.value > 2347)
	{
		Alert.render("<!--#tr id="wa.alert.9"-->Invalid RTS Threshold.<!--#endtr-->");
		rts.focus();
		rts.select();
		return false;
	}
	
	if (rts.value.indexOf(".") >=  0) {
		Alert.render("<!--#tr id="wa.alert.10"-->The RTS Threshold. value must be an integer!<!--#endtr-->")
		return false;
	}

	//Set redirect location
	var unit = "<% nvram_get("wl_unit"); %>";
	var redirect_page = document.getElementById("page");
	var redirect_value = "/redirect.asp?url=/wireless/advanced.asp%3Fwl_unit%3D"+unit;
	redirect_page.value = redirect_value;
	
	redirectURL = ".." + location.pathname;
	totalWaitTime = 25; //second
	wait_page();
	document.getElementById("waitPad").style.display="block";
	scroll(0,0);
	return true;
}

function page_load() {
	var nphy_set = "<% wl_nphy_set(); %>";
	wl_ewc_options(nphy_set);

	if (document.getElementById("wl_unit").value == 0)
		document.getElementById("tr_obss_coex").style.display = style_display_on_tr();
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
<h1><!--#tr id="adv.title" -->Advanced Wireless Settings<!--#endtr --></h1>
<div class="hr" ></div>
<p>
<!--#tr id="adv.desc" -->Use the Advanced Setup page to make detailed settings for the Wireless. Advanced Setup includes items that are not available from the Basic Setup page, such as Beacon Interval, etc.<!--#endtr -->
</p>

<form name="radio" method="post" action="/wireless/advanced.asp" onsubmit="return checkValue();" target="rebootRedirect">
<input type="hidden" name="page" id="page" value="/wireless/advanced.asp">
<input type="hidden" name="token" value="<% genToken(); %>">
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
			<select name="wl_unit" id="wl_unit" onChange="submit();">
				<% wl_um_list(); %>
			</select>
		</td>
	</tr>
</table>
</div>

<table width="100%" class="tbl_main">
	<tr>
		<td class="CT" colspan="2"><!--#tr id="adv.1"-->Advanced Wireless<!--#endtr--></td>
	</tr>
	<tr>
		<td class="CL"
		onMouseOver="return overlib('Sets the beacon interval for the AP.', LEFT);"
		onMouseOut="return nd();">
		<!--#tr id="adv.2"-->Beacon Interval<!--#endtr-->
		</td>
		<td class="CR">
			<input name="wl_bcn" value="<% nvram_get("wl_bcn"); %>" size="4" maxlength="4" onkeydown="return prevent_press_enter(event);"> ms <font color="#808080"><!--#tr id="5gwa.3"-->(range 20 - 1000, default 100)<!--#endtr--></font>
		</td>
	</tr>
	<tr>
		<td class="CL"
		onMouseOver="return overlib('Sets the wakeup interval for clients in power-save mode.', LEFT);"
		onMouseOut="return nd();">
		<!--#tr id="adv.3"-->DTIM<!--#endtr-->
		</td>
		<td class="CR">
			<input name="wl_dtim" value="<% nvram_get("wl_dtim"); %>" size="4" maxlength="4" onkeydown="return prevent_press_enter(event);"> <font color="#808080"><!--#tr id="5gwa.5"-->(range 1 - 255, default 3)<!--#endtr--></font>
		</td>
	</tr>
	<tr>
		<td class="CL"
		onMouseOver="return overlib('Sets the fragmentation threshold.', LEFT);"
		onMouseOut="return nd();">
		<!--#tr id="adv.4"-->Fragment Threshold<!--#endtr-->
		</td>
		<td class="CR">
			<input name="wl_frag" value="<% nvram_get("wl_frag"); %>" size="4" maxlength="4" onkeydown="return prevent_press_enter(event);"> <font color="#808080"><!--#tr id="5gwa.7"-->(range 256 - 2346, default 2346)<!--#endtr--></font>
		</td>
	</tr>
	<tr>
		<td class="CL"
		onMouseOver="return overlib('Sets the RTS threshold.', LEFT);"
		onMouseOut="return nd();">
		<!--#tr id="adv.5"-->RTS Threshold<!--#endtr-->
		</td>
		<td class="CR">
			<input name="wl_rts" value="<% nvram_get("wl_rts"); %>" size="4" maxlength="4" onkeydown="return prevent_press_enter(event);"> <font color="#808080"><!--#tr id="5gwa.9"-->(range 1 - 2347, default 2347)<!--#endtr--></font>
		</td>
	</tr>
	<tr style="display:none">
		<td class="CL"
		onMouseOver="return overlib('Enable/Disable rotation of beacon order when running in MultiBSS mode.', LEFT);"
		onMouseOut="return nd();">
		Beacon Rotation
		</td>
		<td class="CR">
			<select name="wl_bcn_rotate">
				<option value="1" <% nvram_match("wl_bcn_rotate", "1", "selected"); %>>Enabled</option>
				<option value="0" <% nvram_match("wl_bcn_rotate", "0", "selected"); %>>Disabled</option>
			</select>
		</td>
	</tr>
	<tr>
		<td class="CL"
		onMouseOver="return overlib('Sets whether short or long preambles are used. Short preambles improve throughput but all clients in the wireless network must support this capability if selected.', LEFT);"
		onMouseOut="return nd();">
		<!--#tr id="adv.6"-->Short Preamble<!--#endtr-->
		</td>
		<td class="CR">
			<select name="wl_plcphdr">
				<option value="short" <% nvram_match("wl_plcphdr", "short", "selected"); %>><!--#tr id="enabled"-->Enabled<!--#endtr--></option>
				<option value="long" <% nvram_match("wl_plcphdr", "long", "selected"); %>><!--#tr id="disabled"-->Disabled<!--#endtr--></option>
			</select>
		</td>
	</tr>
	<tr style="display:none">
		<td class="CL"
		onMouseOver="return overlib('Sets the Associations the Driver Should Accept.', LEFT);"
		onMouseOut="return nd();">
		Max Associations Limit
		</td>
		<td class="CR">
			<input name="wl_maxassoc" value="<% nvram_get("wl_maxassoc"); %>" size="4" maxlength="4" onkeydown="return prevent_press_enter(event);">
		</td>
	</tr>
	<tr id="tr_obss_coex" style="display:none">
		<td class="CL"
		onMouseOver="return overlib('Enable/Disable Overlapping BSS Coexisistence aka 20/40 Coex.', LEFT);"
		onMouseOut="return nd();">
		<!--#tr id="adv.7"-->20/40 MHz Coexistence<!--#endtr-->
		</td>
		<td class="CR">
			<select name="wl_obss_coex">
				<option value="0" <% nvram_match("wl_obss_coex", "0", "selected"); %>><!--#tr id="off"-->Off<!--#endtr--></option>
				<option value="1" <% nvram_match("wl_obss_coex", "1", "selected"); %>><!--#tr id="on"-->On<!--#endtr--></option>
			</select>
		</td>
	</tr>
	<tr>
		<td class="CL"
		onMouseOver="return overlib('Enable/Disable XPress mode', LEFT);"
		onMouseOut="return nd();">
		XPress&#8482; Technology
		</td>
		<td class="CR">
			<select name="wl_frameburst" onChange="wl_recalc();">
				<option value="off" <% nvram_match("wl_frameburst", "off", "selected"); %>><!--#tr id="off"-->Off<!--#endtr--></option>
				<option value="on" <% nvram_match("wl_frameburst", "on", "selected"); %>><!--#tr id="on"-->On<!--#endtr--></option>
			</select>
		</td>
	</tr>  
	<tr style="display:none">
		<td class="CL"
		onMouseOver="return overlib('Enable/Disable 802.11N support.', LEFT);"
		onMouseOut="return nd();">
		<!--#tr id="basic.6"-->802.11 n-mode<!--#endtr-->
		</td>
		<td class="CR">
			<select name="wl_nmode">
				<option value="-1" <% nvram_match("wl_nmode", "-1", "selected"); %>><!--#tr id="auto"-->Auto<!--#endtr--> </option>
				<option value="0" <% nvram_match("wl_nmode", "0", "selected"); %>><!--#tr id="off"-->Off<!--#endtr--> </option>
			</select>
		</td>
	</tr>
	<tr style="display:none">
		<td class="CL"
		onMouseOver="return overlib('Select number of transmit chains to use', LEFT);"
		onMouseOut="return nd();">
			NPHY TxChains
		</td>
		<td class="CR">
			<select name="wl_txchain" onChange="wl_recalc();">
				<% wl_txchains_list();%>
			</select>
		</td>
	</tr>
<% wl_nphy_comment_beg(); %>
	<tr style="display:none">
		<td class="CL"
		onMouseOver="return overlib('Selects Channel Bandwidth', LEFT);"
		onMouseOut="return nd();">
		<!--#tr id="basic.15"-->Channel Bandwidth<!--#endtr--></td>
		<td class="CR">
			<select name="wl_bw_cap" onChange="wl_recalc();">
			  <% wl_bw_cap_list(); %>
			</select>
			&nbsp;&nbsp;<!--<% wl_cur_bw(); %>-->
		</td>
	</tr>
	<tr>
		<td class="CL"
		onMouseOver="return overlib('Select NPHY Rate (MCS Index)', LEFT);"
		onMouseOut="return nd();">
		<!--#tr id="basic.16"-->MCS<!--#endtr--></td>
		<td class="CR">
			<select name="wl_nmcsidx" onChange="wl_mcs_onchange();">
			</select>
		</td>
	</tr>
<% wl_nphy_comment_end(); %>
</table>

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
