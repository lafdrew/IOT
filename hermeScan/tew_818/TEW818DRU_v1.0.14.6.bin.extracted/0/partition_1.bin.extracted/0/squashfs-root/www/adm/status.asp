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
var currectSysUptime = "<% sysuptime(); %>";
var updays, upminutes, uphours;
var deviceSysTime;
//var UTCSecond ="<% localtime();  %>";
var weekday=new Array("Sun","Mon","Tue","Wed","Thu","Fri","Sat");
var monthname=new Array("Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec");
var http_request = false;
var nowhrs,nowmins,nowsecs;
var btnstatus_refresh = 2;
function st31_fr(){
	return "Connecte";
}

function st31_esp(){
	return "Conectado";
}

function st32_fr(){
	return "Deconnecte";
}

function st32_esp(){
	return "Desconectado";
}

function st33_fr(){
	return "Connexion en cours";
}

function st33_esp(){
	return "Conectando";
}

function sysTime(){
	deviceSysTime = new Date();
	deviceSysTime.setTime(UTCSecond++ + "000");
	nowhrs = deviceSysTime.getUTCHours();
	nowmins = deviceSysTime.getUTCMinutes();
	nowsecs = deviceSysTime.getUTCSeconds();

	if (nowhrs<=9) nowhrs="0"+nowhrs;
	if (nowmins<=9) nowmins="0"+nowmins;
	if (nowsecs<=9) nowsecs="0"+nowsecs;

	document.getElementById("sysTime").innerHTML = weekday[deviceSysTime.getUTCDay()] + " " + monthname[deviceSysTime.getUTCMonth()] + " " + deviceSysTime.getUTCDate() + " " + nowhrs + ":" + nowmins + ":" + nowsecs + " " + deviceSysTime.getUTCFullYear();
	window.setTimeout("sysTime()", 1000);
}

function sysUptime()
{	
	updays = parseInt(currectSysUptime / (60*60*24));
	upminutes = parseInt(currectSysUptime / 60);
	uphours = parseInt(upminutes / 60) % 24;
	upsec = currectSysUptime % 60;
	upminutes = parseInt(currectSysUptime / 60) % 60;

	if (uphours<=9) uphours="0"+uphours;
	if (upminutes<=9) upminutes="0"+upminutes;
	if (upsec<=9) upsec="0"+upsec;
	
	if (updays)
	{
		if(uphours)
			document.getElementById("sysUptime").innerHTML = updays + " day " + uphours + ":" + upminutes + ":" + upsec;
		else
			document.getElementById("sysUptime").innerHTML = updays + " day " + uphours + ":" + upminutes + ":" + upsec;
	}
	else
	{
		if(uphours)
			document.getElementById("sysUptime").innerHTML = uphours + ":" + upminutes + ":" + upsec;
		else
			document.getElementById("sysUptime").innerHTML = uphours + ":" + upminutes + ":" + upsec;
	}
	currectSysUptime++;
	window.setTimeout("sysUptime()", 1000);
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
		alert("<!--#tr id="syslg.alert.1" -->Giving up :( Cannot create an XMLHTTP instance<!--#endtr -->");
		return false;
	}
	http_request.onreadystatechange = function () {alertContents()};
	http_request.open('POST', url, true);
	http_request.send(content);
}

function pressStatusBtn(Btn){
	//document.getElementById("selectedBtn").value = Btn;
	//document.doStatusButton.submit();
	
	if(Btn == "Renew"){
		document.getElementById("waitPad").style.display="block";
		btnstatus_refresh = 2;
	}	
	var parameter ="btn="+Btn;
	makeRequest("/uapply.cgi", parameter,  false);

}

function changeSecurityStr(SSID_AuthMode, SSID_EncrypType)
{
	if (SSID_AuthMode == "OPEN")
	{
		if (SSID_EncrypType == "NONE")
			return "Disabled";
		else if (SSID_EncrypType == "WEP")
			return "WEP-OPEN";
	}
	else if (SSID_AuthMode == "SHARED")
	{
		if (SSID_EncrypType == "WEP")
			return "WEP-SHARED";
	}
	else if (SSID_AuthMode == "WEPAUTO")
	{
		if (SSID_EncrypType == "WEP")
			return "WEP-AUTO";
	}
	else if (SSID_AuthMode == "WPA")
	{
		return "WPA";
	}
	else if (SSID_AuthMode == "WPAPSK")
	{
		return "WPA-PSK";
	}
	else if (SSID_AuthMode == "WPA2PSK")
	{
		return "WPA2-PSK";
	}
	else if (SSID_AuthMode == "WPAPSKWPA2PSK")
	{
		return "WPA2-PSK Mixed";
	}
	else if (SSID_AuthMode == "WPA2")
	{
		return "WPA2";
	}
	else if (SSID_AuthMode == "WPA1WPA2")
	{
		return "WPA2 Mixed";
	}
}

function parseAllData(str)
{
	var all_str = new Array();
	all_str = str.split("\n");

	defaultShownMBSSID = parseInt(all_str[0]);

	for (var i=0; i<all_str.length-2; i++) {
		var fields_str = new Array();
		fields_str = all_str[i+1].split("\r");
		
		switch (i)
		{
			case 0: document.getElementById("display_SSID1").innerHTML = fields_str[0] + " / " + changeSecurityStr(fields_str[2], fields_str[3]);
					break;
			case 1: document.getElementById("display_Mutliple1").innerHTML = fields_str[0] + " / " + changeSecurityStr(fields_str[2], fields_str[3]);
					break;
			case 2: document.getElementById("display_Mutliple2").innerHTML = fields_str[0] + " / " + changeSecurityStr(fields_str[2], fields_str[3]);
					break;
			case 3: document.getElementById("display_Mutliple3").innerHTML = fields_str[0] + " / " + changeSecurityStr(fields_str[2], fields_str[3]);
					break;	
		}
	}
}

function change_status_Lang(str)
{
	str = str.replace(/Disable$/, "<!--#tr id="disabled" -->Disable<!--#endtr -->");
  str = str.replace(/WPA-PSK$/, "<!--#tr id="security.5" -->WPA-PSK<!--#endtr -->");
  str = str.replace(/WPA2-PSK&nbsp;Mixed$/, "<!--#tr id="security.42" -->WPA2-PSK Mixed<!--#endtr -->");
  str = str.replace(/WPA2-PSK$/, "<!--#tr id="security.7" -->WPA2-PSK<!--#endtr -->");
  str = str.replace(/WPA2&nbsp;Mixed$/, "<!--#tr id="security.43" -->WPA2 Mixed<!--#endtr -->");
  str = str.replace(/WPA2$/, "<!--#tr id="security.6" -->WPA2<!--#endtr -->");
  str = str.replace(/WPA$/, "<!--#tr id="security.37" -->WPA<!--#endtr -->");
  return str;
}
function page_load() {
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
	
	//Griffin -move get SSID function from HTML to javascript can avoid &nbsp; be compress.
	var SSID1_2G = "<% getWirelessInfo("wl0"); %>";
	var SSIDM1_2G = "<% getWirelessInfo("wl0.1"); %>";
	var SSIDM2_2G = "<% getWirelessInfo("wl0.2"); %>";
	var SSIDM3_2G = "<% getWirelessInfo("wl0.3"); %>";
	var SSID2_2G = "<% getWirelessInfo("wl1"); %>";
	var SSID2M1_2G = "<% getWirelessInfo("wl1.1"); %>";
	var SSID2M2_2G = "<% getWirelessInfo("wl1.2"); %>";
	var SSID2M3_2G = "<% getWirelessInfo("wl1.3"); %>";

	document.getElementById("display_SSID1").innerHTML = change_status_Lang(transSSIDForInnerHtml(SSID1_2G));
	document.getElementById("display_Mutliple1").innerHTML = change_status_Lang(transSSIDForInnerHtml(SSIDM1_2G));
	document.getElementById("display_Mutliple2").innerHTML = change_status_Lang(transSSIDForInnerHtml(SSIDM2_2G));
	document.getElementById("display_Mutliple3").innerHTML = change_status_Lang(transSSIDForInnerHtml(SSIDM3_2G));
	document.getElementById("display2_SSID1").innerHTML = change_status_Lang(transSSIDForInnerHtml(SSID2_2G));
	document.getElementById("display2_Mutliple1").innerHTML = change_status_Lang(transSSIDForInnerHtml(SSID2M1_2G));
	document.getElementById("display2_Mutliple2").innerHTML = change_status_Lang(transSSIDForInnerHtml(SSID2M2_2G));
	document.getElementById("display2_Mutliple3").innerHTML = change_status_Lang(transSSIDForInnerHtml(SSID2M3_2G));
	
	
	
	//tz = "<% nvram_get("time_zone"); %>"; // Ryan 2013.04.15 remove, because I have to change the system time to apply time_zone
	tz="";
	if(tz == "") tz = "0";
	index = tz.indexOf("_");
	tz = parseInt(tz.substr(index+1), 10);
	UTCSecond = <% localtime();  %>;
	UTCSecond = UTCSecond + ((tz)*60*60);
	//Alert.render("tz=" + tz + ", localTZ=" + (checkLocalTZ.getTimezoneOffset()/60) + ", UTCSecond=" + UTCSecond);
	sysTime();
	sysUptime();	

	//WAN
	var wanConnType = "<% nvram_get("wan_proto"); %>";

	var wanNetworkStatus = "<% getGatewayWanNetworkStatus(); %>";
	/*	
	var wanIP = "<% getWanIp(); %>";
	var wanNetmask = "<% getWanNetmask(); %>";
	var wanGateway = "<% getWanGateway(); %>";
	var wanDNS1 = "<% getDns(1); %>";
	var wanDNS2 = "<% getDns(2); %>";
	*/
	if (wanConnType == "static") {
		document.getElementById("connectiontype").innerHTML = "<!--#tr id="wi.37"-->Static IP<!--#endtr-->";
		document.getElementById("box_statusButton").style.display = "none";
	} else if (wanConnType == "dhcp") {
		document.getElementById("connectiontype").innerHTML = "<!--#tr id="dcl.1"-->DHCP Client<!--#endtr-->";
		document.getElementById("box_statusButton").style.display = style_display_on();
		document.getElementById("statusButton1").value = "<!--#tr id="renew"-->Renew<!--#endtr-->";
		document.getElementById("statusButton2").value = "<!--#tr id="release"-->Release<!--#endtr-->";
	} else {
		if (wanConnType == "pppoe")
			document.getElementById("connectiontype").innerHTML = "PPPoE";
		else if (wanConnType == "pptp")
			document.getElementById("connectiontype").innerHTML = "PPTP";
		else if (wanConnType == "l2tp")
			document.getElementById("connectiontype").innerHTML = "L2TP";
		else
			document.getElementById("connectiontype").innerHTML = "<%  nvram_get("wan0_proto"); %>";
		document.getElementById("box_statusButton").style.display = style_display_on();
		document.getElementById("statusButton1").value = "<!--#tr id="connect"-->Connect<!--#endtr-->";
		document.getElementById("statusButton2").value = "<!--#tr id="disconnect"-->Disconnect<!--#endtr-->";
	}


	if(wanNetworkStatus == "Connected"){
		document.getElementById("wanIP").innerHTML = wanIP==""?"0.0.0.0":wanIP;
		document.getElementById("wanNetmask").innerHTML = wanNetmask==""?"0.0.0.0":wanNetmask;
		document.getElementById("wanGateway").innerHTML = wanGateway==""?"0.0.0.0":wanGateway;
		if(wanIP == "")//Griffin -avoid display default DNS ip 192.95.1.1
		{
			document.getElementById("wanDNS1").innerHTML = "";
			document.getElementById("wanDNS2").innerHTML = "";
		}
		else
		{
			document.getElementById("wanDNS1").innerHTML = wanDNS1==""?"":wanDNS1;
			document.getElementById("wanDNS2").innerHTML = wanDNS2==""?"":wanDNS2;
		}
		if(wanConnType != "STATIC" /*&& wanConnType != "DHCP"*/){
			document.getElementById("statusButton1").disabled = true;
			document.getElementById("statusButton2").disabled = false;
		}
	}else{ //wan status is "Disconnected"
		document.getElementById("wanIP").innerHTML = "0.0.0.0";
		document.getElementById("wanNetmask").innerHTML = "0.0.0.0";
		document.getElementById("wanGateway").innerHTML = "0.0.0.0";
		document.getElementById("wanDNS1").innerHTML = "0.0.0.0";
		document.getElementById("wanDNS2").innerHTML = "0.0.0.0";
		if(wanConnType != "STATIC" && wanConnType != "DHCP"){
			if(wanNetworkStatus == "Connecting"){
				document.getElementById("statusButton1").disabled = true;
				document.getElementById("statusButton2").disabled = false;
			}else{ //disconnected
				document.getElementById("statusButton1").disabled = false;
				document.getElementById("statusButton2").disabled = true;
			}
		}else{ //the release button of DHCP mode need be disabled
			document.getElementById("statusButton1").disabled = false;
			document.getElementById("statusButton2").disabled = true;
		}
	}

	var str, reg;
	reg = /(u|l|(\/80))?/gi;
	str = "<% wl_um_cur_chanspec(0); %>";
	var wl24gChan = str.replace(reg, "");
	if (wl24gChan == "0")
		document.getElementById("channel").innerHTML = "<!--#tr id="auto"-->Auto<!--#endtr-->";
	else
		document.getElementById("channel").innerHTML = wl24gChan;

	str = "<% wl_um_cur_chanspec(1); %>";
	var wl5gChan = str.replace(reg, "");
	if (wl5gChan == "0")
		document.getElementById("channel2").innerHTML = "<!--#tr id="auto"-->Auto<!--#endtr-->";
	else
		document.getElementById("channel2").innerHTML = wl5gChan;

	updateStatusInfo();
	InitializeTimer(3);			

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

function updateStatusInfoHTML(str)
{
	var wanConnType = "<% nvram_get("wan_proto"); %>";
	var all_str = new Array();
	var all_str = str.split(",");
	if(all_str[0]*1==1){
		document.getElementById("waitPad").style.display="none";
		document.getElementById("wanIP").innerHTML = all_str[1];
		document.getElementById("wanNetmask").innerHTML = all_str[2];
		document.getElementById("wanGateway").innerHTML = all_str[3];
		if(all_str[1] == "")//Griffin -avoid display default DNS ip 192.95.1.1
		{
			document.getElementById("wanDNS1").innerHTML = "";
			document.getElementById("wanDNS2").innerHTML = "";
		}
		else
		{
			document.getElementById("wanDNS1").innerHTML = all_str[4] == ""?"":all_str[4];
			document.getElementById("wanDNS2").innerHTML = all_str[5] == ""?"":all_str[5];
		}
		
		if(wanConnType != "STATIC" /*&& wanConnType != "DHCP"*/){
			document.getElementById("statusButton1").disabled = true;
			document.getElementById("statusButton2").disabled = false;
		}
		if(all_str[1] == "" && wanConnType == "DHCP"){	// Kevin Lin add for DHCP client without WAN IP
			document.getElementById("statusButton1").disabled = false;
			document.getElementById("statusButton2").disabled = true;
			document.getElementById("wanIP").innerHTML = "0.0.0.0";
			document.getElementById("wanNetmask").innerHTML = "0.0.0.0";
			document.getElementById("wanGateway").innerHTML = "0.0.0.0";
			document.getElementById("wanDNS1").innerHTML = "0.0.0.0";
			document.getElementById("wanDNS2").innerHTML = "0.0.0.0";
		}
	}else{ //wan status is "Disconnected"
		document.getElementById("wanIP").innerHTML = "0.0.0.0";
		document.getElementById("wanNetmask").innerHTML = "0.0.0.0";
		document.getElementById("wanGateway").innerHTML = "0.0.0.0";
		document.getElementById("wanDNS1").innerHTML = "0.0.0.0";
		document.getElementById("wanDNS2").innerHTML = "0.0.0.0";
		if(wanConnType != "STATIC" && wanConnType != "DHCP"){
			if(all_str[0]*1==3){
				document.getElementById("statusButton1").disabled = true;
				document.getElementById("statusButton2").disabled = false;
			}else{ //disconnected
				document.getElementById("statusButton1").disabled = false;
				document.getElementById("statusButton2").disabled = true;
			}
		}else{ //the release button of DHCP mode need be disabled
			document.getElementById("statusButton1").disabled = false;
			document.getElementById("statusButton2").disabled = true;
		}
	}
}

function updateStatusInfo(){
	makeRequest("../updateInfoForStatusPage.cgi", "", alertContents);
	
	if (btnstatus_refresh <= 0) {
		document.getElementById("waitPad").style.display="none";
		btnstatus_refresh = 2;
	} else {
		btnstatus_refresh = btnstatus_refresh-1;
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
<h1><!--#tr id="status.title"-->Status<!--#endtr--></h1>
<div class="hr" ></div>
<p>
	<script>
	if(dev_Wlmode == "psta") {
		document.write("<!--#tr id="status.desc.psta"-->This section displays your router system information.<!--#endtr-->");
	} else {
		document.write("<!--#tr id="status.desc"-->This section displays your router system information such as WAN (Internet) settings, interface MAC address and IP address information, general wireless status information, and router firmware version.<!--#endtr-->");
	}
	</script>
</p>

<!-- ----------------- System Info ----------------- -->
<table width="100%" class="tbl_main">
	<tr>
		<td class="CT" colspan="2"><!--#tr id="status.system.info"-->System Info<!--#endtr--></td>
	</tr>
	<tr>
		<td class="CL"><!--#tr id="status.fw.version"-->Firmware Version<!--#endtr--></td>
		<td class="CR"><% getProjectFullFirmwareVersion(); %></td>
	</tr>
	<tr>
		<td class="CL"><!--#tr id="status.system.time"-->System Time<!--#endtr--></td>
		<td class="CR"><span id="sysTime">&nbsp;</span></td>
	</tr>
	<tr>
		<td class="CL"><!--#tr id="status.sys.up.time"-->System Up Time<!--#endtr--></td>
		<td class="CR"><span id="sysUptime">&nbsp;</span></td>
	</tr>
</table>

<!-- ================= Internet Configurations ================= -->
<div class="ap_tag">
<div class="greybluebg"></div>
<table width="100%" class="tbl_main">
	<tr>
		<td class="CT" colspan="2"><!--#tr id="status.internet.config"-->Internet Configuration<!--#endtr--></td>
	</tr>
	<tr>
		<td class="CL"><!--#tr id="status.connect.type"-->Connected Type<!--#endtr--></td>
		<td class="CR"><span id="connectiontype">&nbsp;</span></td>
	</tr>
	<tr>
		<td class="CL"><!--#tr id="status.wan.ip.address"-->WAN IP Address<!--#endtr--></td>
		<td class="CR"><span id="wanIP">&nbsp;</span></td>
	</tr>
	<tr>
		<td class="CL"><!--#tr id="subnet.mask"-->Subnet Mask<!--#endtr--></td>
		<td class="CR"><span id="wanNetmask">&nbsp;</span></td>
	</tr>
	<tr>
		<td class="CL"><!--#tr id="default.gateway"-->Default Gateway<!--#endtr--></td>
		<td class="CR"><span id="wanGateway">&nbsp;</span></td>
	</tr>
	<tr>
		<td class="CL"><!--#tr id="status.primary.dns"-->Primary Domain Name Server<!--#endtr--></td>
		<td class="CR"><span id="wanDNS1">&nbsp;</span></td>
	</tr>
	<tr>
		<td class="CL"><!--#tr id="status.second.dns"-->Secondary Domain Name Server<!--#endtr--></td>
		<td class="CR"><span id="wanDNS2">&nbsp;</span></td>
	</tr>
	<tr style="display:none">
		<td class="CL">MAC Address</td>
		<td class="CR"><% getWanMac(); %></td>
	</tr>
</table>
<table id="box_statusButton" width="100%" class="tbl_main">
<form method="post" name="doStatusButton" action="/uapply.cgi">	
<input type="hidden" name="page" value="/adm/status.asp">								
<input type="hidden" name="token" value="<% genToken(); %>">
<input type="hidden" name="action" id="selectedBtn" value="">	  
	<tr>
		<td width="50%" align="right" style="vertical-align:middle">
			<div><input type="button" class="<!--#tr id="buttonWidth2"-->button1<!--#endtr-->" id="statusButton1" value="" onclick="pressStatusBtn('Renew');" style="width:100px;"></div>
		</td>
		<td width="50%" align="left" valign="middle" style="vertical-align:middle">
			<div><input type="button" class="<!--#tr id="buttonWidth2"-->button1<!--#endtr-->" id="statusButton2" value="" onclick="pressStatusBtn('Release');" style="width:100px;"></div>
		</td>
	</tr>
</form>				
</table>
</div>

<table width="100%" class="tbl_main ap_tag">
	<tr>
		<td class="CT" colspan="2"><!--#tr id="lan"-->LAN<!--#endtr--></td>
	</tr>
	<tr>
		<td class="CL"><!--#tr id="mac.address"-->MAC Address<!--#endtr--></td>
		<td class="CR"><% nvram_get("lan_hwaddr"); %></td>
	</tr>
	<tr>
		<td class="CL"><!--#tr id="ip.address"-->IP Address<!--#endtr--></td>
		<td class="CR"><% nvram_get("lan_ipaddr"); %></td>
	</tr>
	<tr>
		<td class="CL"><!--#tr id="subnet.mask"-->Subnet Mask<!--#endtr--></td>
		<td class="CR"><% nvram_get("lan_netmask"); %></td>
	</tr>
</table>

<table width="100%" class="tbl_main ap_tag">
	<tr>
		<td class="CT" colspan="2"><!--#tr id="status.24g.wireless"-->2.4GHz Wireless<!--#endtr--></td>
	</tr>
	<tr>
		<td class="CL"><!--#tr id="mac.address"-->MAC Address<!--#endtr--></td>
		<td class="CR"><% nvram_get("wl0_hwaddr"); %></td>
	</tr>
	<tr>
		<td class="CL"><!--#tr id="channel"-->Channel<!--#endtr--></td>
		<td class="CR"><span id="channel"></span></td>
	</tr>
	<tr>
		<td class="CL"><!--#tr id="status.net.name.ssid"-->Network Name (SSID1)<!--#endtr--> / <!--#tr id="status.security.mode"-->Security Mode<!--#endtr--></td>
		<td class="CR"><!-- getWirelessInfo("wl0");--><span id="display_SSID1"></span></td>
	</tr>
	<tr>
		<td class="CL"><!--#tr id="multiple"-->Multiple<!--#endtr--> SSID2 / <!--#tr id="status.security.mode"-->Security Mode<!--#endtr--></td>
		<td class="CR"><!-- getWirelessInfo("wl0.1");--><span id="display_Mutliple1"></span></td>
	</tr>
	<tr>
		<td class="CL"><!--#tr id="multiple"-->Multiple<!--#endtr--> SSID3 / <!--#tr id="status.security.mode"-->Security Mode<!--#endtr--></td>
		<td class="CR"><!-- getWirelessInfo("wl0.2");--><span id="display_Mutliple2"></span></td>
	</tr>
	<tr>
		<td class="CL"><!--#tr id="status.net.name.guest.ssid"-->Guest SSID<!--#endtr--> / <!--#tr id="status.security.mode"-->Security Mode<!--#endtr--></td>
		<td class="CR"><!-- getWirelessInfo("wl0.3");--><span id="display_Mutliple3"></span></td>
	</tr>
</table>

<table width="100%" class="tbl_main ap_tag">
	<tr>
		<td class="CT" colspan="2"><!--#tr id="status.5g.wireless"-->5GHz Wireless<!--#endtr--></td>
	</tr>
	<tr>
		<td class="CL"><!--#tr id="mac.address"-->MAC Address<!--#endtr--></td>
		<td class="CR"><% nvram_get("wl1_hwaddr"); %></td>
	</tr>
	<tr>
		<td class="CL"><!--#tr id="channel"-->Channel<!--#endtr--></td>
		<td class="CR"><span id="channel2"></span></td>
	</tr>
	<tr>
		<td class="CL"><!--#tr id="status.net.name.ssid"-->Network Name (SSID1)<!--#endtr--> / <!--#tr id="status.security.mode"-->Security Mode<!--#endtr--></td>
		<td class="CR"><!-- getWirelessInfo("wl1");--><span id="display2_SSID1"></span></td>
	</tr>
	<tr>
		<td class="CL"><!--#tr id="multiple"-->Multiple<!--#endtr--> SSID2 / <!--#tr id="status.security.mode"-->Security Mode<!--#endtr--></td>
		<td class="CR"><!-- getWirelessInfo("wl1.1");--><span id="display2_Mutliple1"></span></td>
	</tr>
	<tr>
		<td class="CL"><!--#tr id="multiple"-->Multiple<!--#endtr--> SSID3 / <!--#tr id="status.security.mode"-->Security Mode<!--#endtr--></td>
		<td class="CR"><!-- getWirelessInfo("wl1.2");--><span id="display2_Mutliple2"></span></td>
	</tr>
	<tr>
		<td class="CL"><!--#tr id="status.net.name.guest.ssid"-->Guest SSID<!--#endtr--> / <!--#tr id="status.security.mode"-->Security Mode<!--#endtr--></td>
		<td class="CR"><!-- getWirelessInfo("wl1.3");--><span id="display2_Mutliple3"></span></td>
	</tr>
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
