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

function updateStatus()
{
	if(document.remoteManagement.remote_en.options.selectedIndex == 1){
		enableTextField(document.remoteManagement.http_wanport);
	}else{
		disableTextField(document.remoteManagement.http_wanport);
	}
}
// u-media(rh001)-Griffin Wang-TEW691GR ([+Add Device URL check function])
function checkDeviceURL()
{
	if( document.DeviceNameURL.DeviceURL.value == "" ){
		Alert.render("<!--#tr id="mg.alert.12"-->Please specify Device URL.<!--#endtr-->");
		return false;
	}

	var re2 = /^[\w\-\.]+$/;  
	if (!re2.test(document.DeviceNameURL.DeviceURL.value)) {
		Alert.render("<!--#tr id="mg.alert.13"-->Device URL only accept [0-9a-zA-Z_-.] characters.<!--#endtr-->");
		return false;
	}
	
	totalWaitTime = 25; //second
	wait_page();
	document.getElementById("waitPad").style.display="block";
	parent
	scroll(0,0);
	return true;
}

function DDNSFormCheck()
{
	if(  document.DDNS.DDNSProvider.value != "none" && 
		(document.DDNS.Account.value == "" ||
		 document.DDNS.Password.value == "" ||
		 document.DDNS.DDNS.value == "")){
		Alert.render("<!--#tr id="mg.alert.1"-->Please specify account, password, and DDNS.<!--#endtr-->");
		return false;
	}
	
	if (document.DDNS.DDNSProvider.length > 256) {
		Alert.render("<!--#tr id="mg.alert.15"-->The DDNS words more than 256.<!--#endtr-->");
		return false;
	}

	//Tom.Hung 2010-1-14, add Account, Password, and Host Name check function.
	if (document.DDNS.DDNSProvider.options.selectedIndex != 0) {
	var re = /^[\w\~\`\!\@\#\$\%\^\&\*\(\)\_\+\-\=\\\|\[\{\]\}\;\:\'\"\/\?\.\>\,\<\ ]+$/;  
	var re2 = /^[\w\-\.]+$/;  
	if (!re2.test(document.DDNS.DDNS.value)) {
		Alert.render("<!--#tr id="mg.alert.2"-->Host Name only accept [0-9a-zA-Z_-.] characters.<!--#endtr-->");
		return false;
	}
	if (!re.test(document.DDNS.Account.value)) {
		Alert.render("<!--#tr id="mg.alert.3"-->Account have invalid characters.<!--#endtr-->");
		return false;
	}
	if (document.DDNS.Password.value.indexOf("\"") > -1) {
		Alert.render("<!--#tr id="mg.alert.4"-->Password have invalid characters<!--#endtr--> \".");
		return false; 
	}
	}
	//Tom.Hung 2010-1-14
	
	totalWaitTime = 25; //second
	wait_page();
	document.getElementById("waitPad").style.display="block";
	scroll(0,0);
	return true;
}

function disableTextField (field)
{
  if(document.all || document.getElementById){
    field.disabled = true;
  }else {
    field.oldOnFocus = field.onfocus;
    field.onfocus = skip;
  }
}

function enableTextField (field)
{
  if(document.all || document.getElementById)
    field.disabled = false;
  else {
    field.onfocus = field.oldOnFocus;
  }
}

function DDNSupdateState()
{
	if(document.DDNS.DDNSProvider.options.selectedIndex != 0){
		enableTextField(document.DDNS.Account);
		enableTextField(document.DDNS.Password);
		enableTextField(document.DDNS.DDNS);
	}else{
		disableTextField(document.DDNS.Account);
		disableTextField(document.DDNS.Password);
		disableTextField(document.DDNS.DDNS);
	}
	
	if(document.DDNS.DDNSProvider.options.selectedIndex != 1){
		document.getElementById("mail_ex").style.display = "none";
		document.getElementById("backup_mx").style.display = "none";
	}else{
		document.getElementById("mail_ex").style.display = "";
		document.getElementById("backup_mx").style.display = "";
	}
}

function RemoteManagement()
{
	var rm = "<% nvram_get("remote_en"); %>";
	var RemotePort = "<% nvram_get("http_wanport"); %>";
	document.remoteManagement.http_wanport.value = RemotePort;
	if(rm*1 == 1)
		document.remoteManagement.remote_en.options.selectedIndex = 1;
	else
		document.remoteManagement.remote_en.options.selectedIndex = 0;
	
	updateStatus();
}

function checkDeviceName()
{
	var re = /^[\w\-]+$/;  
	if (!re.test(document.getElementById("device_name").value)) {
		Alert.render("<!--#tr id="mg.alert.5"-->Device Name only accept [0-9a-zA-Z_-] characters.<!--#endtr-->");
		return false;
	}
	checkValue();
}

function checkValue()
{
	var reg = /^0$|^[1-9][0-9]*$/; //user could only input 0(only 1 digit) or a number which fist digit is not 0
	
	// 1. Check TimeOut
	var timeOut = document.getElementById("AuthTimeout").value;
	if (!reg.test(timeOut)) {
		Alert.render("<!--#tr id="mg.alert.14"-->The Idle Timeout must be an integer!<!--#endtr-->");
		return false;
	}
	if (!is_number(timeOut) || !checkInteger(timeOut) || !checkRange(timeOut, 120, 3600)) {
		Alert.render("<!--#tr id="mg.alert.6"-->The Idle Timeout must big then 120 seconds and small then 3600 seconds.<!--#endtr-->");
		return false;
	}	

    // 2. Check Password
    var admnPass = document.getElementById("admpass").value;
	/* Tom.Hung 2013-6-26, Remove check function because customer want to support some special characters.
	if( alphanumeric(admnPass) == false ) {
		Alert.render("<!--#tr id="mg.alert.7"-->Only Alphanumeric characters accepted for Admin Password.<!--#endtr-->");
		return false;
	}
	*/

	// 3. Tom.Hung 2009-12-24, add Account, Password, and Device name check function.
	var re = /^[\w\-]+$/; 
	if (document.getElementById("admuser").value == "") {
		Alert.render("<!--#tr id="mg.alert.8"-->Account should not be empty!<!--#endtr-->");
		return false;
	}
	if (!re.test(document.getElementById("admuser").value)) {
		Alert.render("<!--#tr id="mg.alert.9"-->Account only accept [0-9a-zA-Z_-] characters.<!--#endtr-->");
		return false;
	}
	if (document.getElementById("admpass").value.indexOf("\"") > -1 ||
		document.getElementById("admpass").value.indexOf("~") > -1) {
		Alert.render("<!--#tr id="mg.alert.4"-->Password have invalid characters.<!--#endtr-->");
		return false; 
	}
	//Tom.Hung 2009-12-24
	
	// 4. Check Remote Port
	if (document.getElementById("remotePortSelector").selectedIndex == 1) {
	    var remotePortElement = document.getElementById("http_wanport");
	    if (!is_port_valid(remotePortElement.value)) {
	        remotePortElement.focus();
	        Alert.render("<!--#tr id="port.error"-->Please input a correct port between 0 and 65535<!--#endtr-->");
	        return false;
	    }
	}

	totalWaitTime = 25; //second
	wait_page();
	document.getElementById("waitPad").style.display="block";
	scroll(0,0);
	return true;
}

function checkPort()
{
	var portNum = document.getElementById("http_wanport").value;
	if (!is_number(portNum) || !checkInteger(portNum) || !checkRange(portNum, 1, 65535)) {
		Alert.render("<!--#tr id="mg.alert.11"-->The Remote port value must a integer number (1~65535).<!--#endtr-->");
		return false;
	}

	totalWaitTime = 25; //second
	wait_page();
	document.getElementById("waitPad").style.display="block";
	scroll(0,0);

	return true;
}

function ddnsInitial()
{
	var ddns_provider = "<% nvram_get("DDNS_Provider"); %>";
	if (ddns_provider == "none")
		document.DDNS.DDNSProvider.options.selectedIndex = 0;
	else if (ddns_provider == "dyndns.org")
		document.DDNS.DDNSProvider.options.selectedIndex = 1;
	else if (ddns_provider == "freedns.afraid.org")
		document.DDNS.DDNSProvider.options.selectedIndex = 4;
	else if (ddns_provider == "zoneedit.com")
		document.DDNS.DDNSProvider.options.selectedIndex = 3;
	else if (ddns_provider == "no-ip.com")
		document.DDNS.DDNSProvider.options.selectedIndex = 2;
}

function page_load()
{
	var psta_tag="";
	var ap_tag="";
	if(dev_Wlmode == "psta") {
		$(".psta_tag").removeClass("hiddentr");
		$(".ap_tag").addClass("hiddentr");
	} else {
		$(".psta_tag").addClass("hiddentr");
		$(".ap_tag").removeClass("hiddentr");
	}
	
	var projectName = "<% getProjectName(); %>";

	document.getElementById("admpass").value = "_dummy-password_";

	//Ricky Cao: Below line is added for predefined URL
	document.getElementById("box_deviceUrlSettings").style.display="<% isBrPredefUrlEn(); %>"
	ddnsInitial();
	DDNSupdateState();
	RemoteManagement();

    // TypeError: document.getElementById("tb_main") is null. 
    // Doesn't find document.getElementById("tb_main") in this page, so disable two lines temporarily.
	// After all GUI are processed, show main content here
	//document.getElementById("tb_main").style.display = style_display_on();
	//document.getElementById("tb_main").style.visibility = "visible";
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
<h1><!--#tr id="mg.title"-->System Management<!--#endtr--></h1>
<div class="hr" ></div>
<p>
	<script>
		if(dev_Wlmode == "psta") {
			document.write("<!--#tr id="mg.desc.psta"-->This section displays allows you to change your administrator password.<!--#endtr-->");
		} else {
			document.write("<!--#tr id="mg.desc"-->This section allows you to change your administrator password, set up and enable dynamic DNS, and enable remote management to allow access to your router from the Internet. Since most ISPs constantly change your home IP address, providing access to devices on your home or small office Local Area Network (such as IP Cameras) from the Internet requires setting up a Dynamic DNS service and entering the parameters into this management area. Dynamic DNS services allow your router to confirm its location to the given Dynamic DNS service, thereby providing the Dynamic DNS service with the ability to provide a virtual fixed IP address for your network. This means that even though your ISP is always changing your IP address, the Dynamic DNS service will be able to identify your network using a fixed address.<!--#endtr-->");
		}
	</script>
</p>

<!-- ----------------- Adm Settings ----------------- -->
<form method="post" name="Adm" action="/setSysAdm.cgi" onsubmit="return checkValue();" target="rebootRedirect">
<input type="hidden" name="page" value="/adm/management.asp">
<input type="hidden" name="token" value="<% genToken(); %>">
<table width="100%" class="tbl_main">
	<tr>
		<td class="CT" colspan="2"><!--#tr id="mg.1"-->Administrator Settings<!--#endtr--></td>
	</tr>
	<tr>
		<td class="CL"><!--#tr id="mg.2"-->Account<!--#endtr--></td>
		<td class="CR">
			<input type="hidden" id="admuser" name="admuser" size="16" maxlength="16" value="<% nvram_get("http_username"); %>">
			<input type="text" name="admuser_show" size="16" maxlength="16" disabled="disabled" value="<% nvram_get("http_username"); %>">
		</td>
	</tr>
	<tr>
		<td class="CL"><!--#tr id="mg.3"-->Password<!--#endtr--></td>
		<td class="CR"><input type="password" id="admpass" name="admpass" size="16" maxlength="16" value="" onClick="this.select()" onkeydown="return prevent_press_enter(event);"> <!--#tr id="mg.4"-->(Max Length: 16 characters)<!--#endtr--></td>
	</tr>
	<tr>
		<td class="CL"><!--#tr id="mg.5"-->Idle Timeout<!--#endtr--></td>
		<td class="CR"><input type="text" id="AuthTimeout" name="AuthTimeout" size="4" maxlength="4" value="<% nvram_get("http_timeout"); %>" onkeydown="return prevent_press_enter(event);"> <!--#tr id="mg.6"-->(120-3600 seconds)<!--#endtr--></td>
	</tr>
</table>
<table width="100%" class="tbl_main">
	<tr align="center">
		<td>
			<input type="submit" class="button1" value="<!--#tr id="apply"-->Apply<!--#endtr-->"> &nbsp; &nbsp;
			<input type="reset"  class="button1" value="<!--#tr id="cancel"-->Cancel<!--#endtr-->" onClick="window.location.reload()">
		</td>
	</tr>
</table>
</form>

<form class="ap_tag" method="post" name="DeviceNameSet" action="/uapply.cgi" onsubmit="return checkDeviceName();" target="rebootRedirect">
<input type="hidden" name="page" value="/adm/management.asp">
<input type="hidden" name="token" value="<% genToken(); %>">
<table width="100%" class="tbl_main">
	<tr>
		<td class="CT" colspan="2"><!--#tr id="mg.7"-->Device Name Settings<!--#endtr--></td>
	</tr>
	<tr>
		<td class="CL"><!--#tr id="mg.8"-->Device Name<!--#endtr--></td>
		<td class="CR"><input type="text" name="device_name" id="device_name" size="16" maxlength="16" value="<% nvram_get("device_name"); %>" onkeydown="return prevent_press_enter(event);"></td>
	</tr>
</table>
<table width="100%" class="tbl_main">
	<tr align="center">
		<td>
			<input type="submit" class="button1" value="<!--#tr id="apply"-->Apply<!--#endtr-->"> &nbsp; &nbsp;
			<input type="reset"  class="button1" value="<!--#tr id="cancel"-->Cancel<!--#endtr-->" onClick="window.location.reload()">
			<input type="hidden" class="button1" name="action" value="Apply">   
	</td>
	</tr>
</table>
</form>

<!-- Ricky Cao: Below is added for predefined URL function -->
<form class="ap_tag" method="post" name="DeviceNameURL" action="/uapply.cgi" onsubmit="return checkDeviceURL();" target="rebootRedirect">
<input type="hidden" name="page" value="/adm/management.asp">
<input type="hidden" name="token" value="<% genToken(); %>">
<div id="box_deviceUrlSettings">
<table width="100%" class="tbl_main">
	<tr>
		<td class="CT" colspan="2"><!--#tr id="mg.17"-->Device URL Settings<!--#endtr--></td>
	</tr>
	<tr>
		<td class="CL"><!--#tr id="mg.18"-->Device URL<!--#endtr--></td>
		<!-- Ricky Cao: Exactly, the length of predefned URL has not be limited in kernel level (bridge code) -->
		<td class="CR"><input type="text" name="DeviceURL" id="DeviceURL" size="32" maxlength="64" value="<% nvram_get("DeviceURL"); %>" onkeydown="return prevent_press_enter(event);"></td>
	</tr>
</table>
<table width="100%" class="tbl_main">
	<tr align="center">
		<td>
			<input type="submit" class="button1" value="<!--#tr id="apply"-->Apply<!--#endtr-->" /> &nbsp; &nbsp;
			<input type="reset"  class="button1" value="<!--#tr id="cancel"-->Cancel<!--#endtr-->" onclick="window.location.reload()" />
			<input type="hidden" class="button1" name="action" value="Apply">	  
			<input type="hidden" name="apply_do" value="setDeviceURL">    
		</td>
	</tr>
</table>
</div>
</form>
<!-- Ricky Cao: Below is added for predefined URL function -->

<form class="ap_tag" method="post" name="DDNS" action="/setDDNS.cgi" onsubmit="return DDNSFormCheck();">
<input type="hidden" name="page" value="/adm/management.asp">
<input type="hidden" name="token" value="<% genToken(); %>">
<table width="100%" class="tbl_main">
	<tr>
		<td class="CT" colspan="2"><!--#tr id="mg.9"-->DDNS Settings<!--#endtr--></td>
	</tr>
	<tr>
		<td class="CL"><!--#tr id="mg.10"-->Dynamic DNS Provider<!--#endtr--></td>
		<td class="CR">
			<select onChange="DDNSupdateState()" name="DDNSProvider">
			<option value="none"><!--#tr id="none"-->None<!--#endtr--></option>
			<option value="dyndns.org"> Dyndns.com </option>
			<!-- can't update it, so removed
			<option value="freedns.afraid.org"> freedns.afraid.org </option>
			<option value="zoneedit.com"> www.zoneedit.com </option>-->
			<option value="no-ip.com"> www.no-ip.com </option>
			</select>
		</td>
	</tr>
	<tr>
		<td class="CL"><!--#tr id="mg.11"-->Host Name<!--#endtr--></td>
		<td class="CR"><input size="32" maxlength="256" name="DDNS" value="<% nvram_get("DDNS_host_name"); %>" type="text" onkeydown="return prevent_press_enter(event);"> </td>
	</tr>
	<tr>
		<td class="CL"><!--#tr id="mg.12"-->Account<!--#endtr--></td>
		<td class="CR"><input size="16" name="Account" value="<% nvram_get("DDNS_Account"); %>" type="text" onkeydown="return prevent_press_enter(event);"> </td>
	</tr>
	<tr>
		<td class="CL"><!--#tr id="mg.13"-->Password<!--#endtr--></td>
		<td class="CR"><input size="16" name="Password" value="<% nvram_get("DDNS_Password"); %>" type="password" onkeydown="return prevent_press_enter(event);"> </td>
	</tr>
	<tr id="mail_ex">
		<td class="CL"><!--#tr id="mg.19"-->Mail Exchange (Optional)<!--#endtr--></td>
		<td class="CR"><input size="16" name="MX" value="<% nvram_get("DDNS_mx"); %>" type="text" onkeydown="return prevent_press_enter(event);"> </td>
	</tr>
	<tr id="backup_mx">
		<td class="CL"><!--#tr id="mg.20"-->Backup MX<!--#endtr-->
		</td>
		<td class="CR">
			<select name="Backmx">
				<option value="YES" <% nvram_match("DDNS_backmx", "YES", "selected"); %>><!--#tr id="enabled"-->Enabled<!--#endtr--></option>
				<option value="NO" <% nvram_match("DDNS_backmx", "NO", "selected"); %>><!--#tr id="disabled"-->Disabled<!--#endtr--></option>
			</select>
		</td>
	</tr>
</table>
<table width="100%" class="tbl_main">
<tr align="center">
	<td>
		<input type="submit" class="button1" value="<!--#tr id="apply"-->Apply<!--#endtr-->" /> &nbsp; &nbsp;
		<input type="reset" class="button1" value="<!--#tr id="cancel"-->Cancel<!--#endtr-->" onClick="window.location.reload()">    </td>
</tr>
</table>
</form>

<form class="ap_tag" method="post" name="remoteManagement" action="/uapply.cgi" onsubmit="return checkPort();" target="rebootRedirect">
<input type="hidden" name="page" value="/adm/management.asp">
<input type="hidden" name="token" value="<% genToken(); %>">
<table width="100%" class="tbl_main">
	<tr>
		<td class="CT" colspan="2"><!--#tr id="mg.14"-->Remote Management<!--#endtr--></td>
	</tr>
	<tr>
		<td class="CL"><!--#tr id="mg.15"-->Remote Control (via WAN)<!--#endtr--></td>
		<td class="CR">
			<select id="remotePortSelector" name="remote_en" size="1" onchange="updateStatus();">
				<option value=0><!--#tr id="disable"-->Disable<!--#endtr--></option>
				<option value=1><!--#tr id="enable"-->Enable<!--#endtr--></option>
			</select>
		</td>
	</tr>
	<tr>
		<td class="CL"><!--#tr id="mg.16"-->Remote Port<!--#endtr--></td>
		<td class="CR">
			<input type="text" name="http_wanport" id="http_wanport" value="<% nvram_get(1, "http_wanport"); %>" onkeydown="return prevent_press_enter(event);">
		</td>
	</tr>
</table>
<table width="100%" class="tbl_main">
	<tr align="center">
		<td>
			<input type="submit" class="button1" value="<!--#tr id="apply"-->Apply<!--#endtr-->"> &nbsp; &nbsp;
			<input type="reset" class="<!--#tr id="buttonWidth"-->button1<!--#endtr-->" value="<!--#tr id="reset"-->Reset<!--#endtr-->">
			<input type="hidden" class="button1" name="action" value="Apply">
			<input type="hidden" name="apply_do" value="setRemoteManagement"> 		
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
