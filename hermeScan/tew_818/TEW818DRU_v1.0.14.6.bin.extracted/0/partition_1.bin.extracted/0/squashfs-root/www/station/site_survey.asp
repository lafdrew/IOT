<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en"><!-- InstanceBegin template="/Templates/basic.dwt" codeOutsideHTMLIsLocked="false" -->
<head>
<meta http-equiv="content-type" content="text/html; charset=utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE8"/>

<title>TRENDnet | TEW-818DRU | <!--#tr id="project.desc"-->AC1900 Dual Band Wireless Router<!--#endtr--></title>
<!-- InstanceBeginEditable name="Page Title" -->

<!-- InstanceEndEditable -->

<link href="../style/style.css" rel="stylesheet" type="text/css" media="screen" />
<link href="../style/frame.css" rel="stylesheet" type="text/css" media="screen" />
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

function expand_path()
{
	if(dev_Wlmode == "psta") {
		//Expand menu by pathname
		var path = location.pathname;
		if(path.indexOf("/station/") > -1)
			ddaccordion.expandone('expandable', 0);
	
	} else {
		//Expand menu by pathname
		var path = location.pathname;
		if(path.indexOf("home.asp") > -1)
			ddaccordion.expandone('expandable', 0);
		if(path.indexOf("wireless.asp") > -1)
			ddaccordion.expandone('expandable', 1);
		if((path.indexOf("guestnetwork.asp") > -1 || path.indexOf("guest_lan.asp") > -1))
			ddaccordion.expandone('expandable', 2);
		if(path.indexOf("parental.asp") > -1)
			ddaccordion.expandone('expandable', 3);
	}
}

function menu_adjust() {
	if (lang=="DE") {
	} else	if (lang=="FR") {
	} else	if (lang=="ESP") {
	} else	if (lang=="RU") {
		if(dev_Wlmode != "psta")
			document.getElementById("mainmenu_4").style.margin = "-12px 0px 0px 5px";
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
var waitCount=0;
var stopToWait;
var Channel=0;
var security=0;
var DeviceURL = "<% nvram_get("DeviceURL"); %>";

function makeRequest(url, content, fieldID, disableFieldID) {
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
		//alert("Giving up :( Cannot create an XMLHTTP instance");
		return false;
	}
	http_request.onreadystatechange = function () {alertContents(fieldID, disableFieldID)};
	http_request.open('POST', url, true);
	http_request.send(content);
}

function alertContents(fieldID, disableFieldID) {
	if (http_request.readyState == 4) {
		if (http_request.status == 200) {
			reWirteList(fieldID, disableFieldID, http_request.responseText);
		} else {
			//Alert.render("There was a problem with the request.");
		}
	}
}
function reWirteList(fieldID, disableFieldID, str)
{
	stopToWait = true;
	
	if (disableFieldID != "" && str != "")
		document.getElementById(disableFieldID).style.display = "none";
	if (fieldID != "") {
		document.getElementById(fieldID).innerHTML = str;
		// Annie.Weng @20150522: 
		// Fix garbage line caused by repeated background image. Use larger image for large table.
		//alert($('#td_scanField_2').height());
		if ($('#td_scanField_2').height() > 900) {
			document.getElementById("td_scanField_2").style.backgroundImage = "url(../images/cell-1_ext.gif)";
		}
	}
}

function updateSiteSurvey(){
	makeRequest("/updateSiteSurvey.cgi", "", "listSiteSurvey", "waitMsg");
}

function scanFieldDisplay(value)
{
	if(value == "none")
	{
		document.getElementById("scanField_1").style.display = "none";
		document.getElementById("scanField_2").style.display = "none";
		document.getElementById("scanField_3").style.display = "none";
		document.getElementById("scanField_4").style.display = "none";
	}
	else
	{
		document.getElementById("scanField_1").style.display = "";
		document.getElementById("scanField_2").style.display = "";
		document.getElementById("scanField_3").style.display = "";
		document.getElementById("scanField_4").style.display = "";
	}
}

function WEPDisplay(value) {
	if(value == "none")
	{
		document.getElementById("WEPKey0Field").style.display = "none";
		document.getElementById("defaultWEPKeyField").style.display = "none";
		document.getElementById("WEPAuthField").style.display = "none";
	}
	else
	{
		document.getElementById("WEPKey0Field").style.display = "";
		document.getElementById("defaultWEPKeyField").style.display = "";
		document.getElementById("WEPAuthField").style.display = "";
	}
	document.getElementById("wepPassphraseField").style.display = "none";
	document.getElementById("WEPKey1Field").style.display = "none";
	document.getElementById("WEPKey2Field").style.display = "none";
	document.getElementById("WEPKey3Field").style.display = "none";
	document.getElementById("WEPKeyLengthField").style.display = "none";
}

function WPAPersonalDisplay(value) {
	document.getElementById("WPAPersonalEncryptionField").style.display = "none";
	if(value == "none")
	{
		document.getElementById("WPAPSKField").style.display = "none";
	}
	else
	{
		document.getElementById("WPAPSKField").style.display = "";
	}
}

function selectSecurityMode(mode) {
	WEPDisplay("none");
	WPAPersonalDisplay("none");
	
	if (mode == 1) {
	
	}
	else if (mode == 2) {
		WEPDisplay("block");
	}
	else if (mode == 3) {
		WPAPersonalDisplay("block");
	}
	else {
		Alert.render("<!--#tr id="wl.alert.5" -->Can't get mode.<!--#endtr -->");
	}
}

function confirmCheck(confirmvalue) {
	document.securityform.wl_ssid.value = document.getElementById("Ssid").value;
	var band;
	band = document.getElementById("Freq").value;
	if (band=="5") {
		document.securityform.wl_unit.value = "1";
		document.securityform.wl_nband.value = "1";
	} else {
		document.securityform.wl_unit.value = "0";
		document.securityform.wl_nband.value = "2";
	}	
	//for securitymode == 2
	document.securityform.wl_akm_wpa.selectedIndex = 1;
	document.securityform.wl_akm_psk.selectedIndex = 0;
	document.securityform.wl_akm_wpa2.selectedIndex = 1;
	document.securityform.wl_akm_psk2.selectedIndex = 1;
	document.securityform.wl_akm_brcm_psk.selectedIndex = 1;
	document.securityform.wl_akm_wapi.selectedIndex = 1;
	document.securityform.wl_akm_wapi_psk.selectedIndex = 1;
	document.securityform.wl_wep.selectedIndex = 1;
	document.securityform.wl_auth.selectedIndex = 2;
	if(security == 11)
		document.securityform.wl_crypto.value = "tkip";
	else
		document.securityform.wl_crypto.value = "aes";
	document.securityform.wl_wpa_psk.value = document.getElementById("display_WPAPSK").value;

	document.getElementById("waitPad").style.display="";
	totalWaitTime = 30; //second
	//redirectURL = "/station/site_survey.asp";
	redirectURL = "http://" + DeviceURL;
	wait_page();
	//document.modeOption.submit();
	document.securityform.submit();
}

function checkValue() {
	var applyValue = true;
	var checkValue, keyLenCount;
	var securityMode = document.getElementById("securityMode").value;

//	if(document.getElementById("display_ESSID").value.length == 0) {
//		Alert.render("<!--#tr id="wl.alert.4" -->Please specify Network Name (SSID).<!--#endtr -->");
//		applyValue = false;
//	}
	if (applyValue && (securityMode == 1)) { //WEP
		for (loopCount=1; loopCount<=1; loopCount++) { //Only use key 1
			docTemp = document.getElementById("wep_key_"+loopCount).value;

			if (docTemp.length != 0) {
				/*if (docTemp.length == 5 || docTemp.length == 13)	//ASCII
				{
					applyValue = false;
				}
				else*/ if (docTemp.length == 10 || docTemp.length == 26)	//HEX 64bit
				{
					for (keyLenCount=0; keyLenCount<docTemp.length; keyLenCount++)
					{
						checkValue = docTemp.substr(keyLenCount, 1);
						if (!(parseInt(checkValue, 16) >= 0) && !(parseInt(checkValue, 16) <= 15)) {
							if(docTemp.length == 10) {
								Alert.render("<!--#tr id="wl.alert.1" -->Please input 10 Hex characters for the key<!--#endtr -->" + " " + loopCount + "!");
							} else if(docTemp.length == 26) {
								Alert.render("<!--#tr id="wl.alert.2" -->Please input 26 Hex characters for the key<!--#endtr -->" + " " + loopCount + "!");
							}
							applyValue = false;
							loopCount = 5;
							keyLenCount = 26;
						}
					}
				} else {
					Alert.render("<!--#tr id="wl.alert.3" -->Please input 10 or 26 Hex characters for the key<!--#endtr -->" + " " + loopCount + "!");
					applyValue = false;
					loopCount = 5;
				}
			}
		}
	}
	
	if (applyValue && securityMode == 2) {
			Confirm.render("<!--#tr id="HT.confirm" -->WARNING: Your Wireless-N devices will only operate at Wireless-G data rates with the encryption type you have chosen. Please select WPA2-Personal encryption if you would like to have your Wireless-N devices operating at full data rates. Click OK to continue with this selection, or Cancel to choose another type of encryption.<!--#endtr -->","confirmCheck","","","");
	}
	else {
		if (applyValue && securityMode == 3) {
			if (applyValue && !checkWPAPSK(document.getElementById("display_WPAPSK").value)){
				applyValue = false;
			}
		}
		if (applyValue) {
			document.securityform.wl_ssid.value = document.getElementById("Ssid").value;
			var band;
			band = document.getElementById("Freq").value;
			if (band=="5") {
				document.securityform.wl_unit.value = "1";
				document.securityform.wl_nband.value = "1";
			} else {
				document.securityform.wl_unit.value = "0";
				document.securityform.wl_nband.value = "2";
			}	
			if(securityMode == 0) {
				document.securityform.wl_akm_wpa.selectedIndex = 1;
				document.securityform.wl_akm_psk.selectedIndex = 1;
				document.securityform.wl_akm_wpa2.selectedIndex = 1;
				document.securityform.wl_akm_psk2.selectedIndex = 1;
				document.securityform.wl_akm_brcm_psk.selectedIndex = 1;
				document.securityform.wl_akm_wapi.selectedIndex = 1;
				document.securityform.wl_akm_wapi_psk.selectedIndex = 1;
				document.securityform.wl_wep.selectedIndex = 1;
				document.securityform.wl_auth.selectedIndex = 2;
			} else if(securityMode == 1) {
				document.securityform.wl_akm_wpa.selectedIndex = 1;
				document.securityform.wl_akm_psk.selectedIndex = 1;
				document.securityform.wl_akm_wpa2.selectedIndex = 1;
				document.securityform.wl_akm_psk2.selectedIndex = 1;
				document.securityform.wl_akm_brcm_psk.selectedIndex = 1;
				document.securityform.wl_akm_wapi.selectedIndex = 1;
				document.securityform.wl_akm_wapi_psk.selectedIndex = 1;
				document.securityform.wl_wep.selectedIndex = 0;
				document.securityform.wl_key1.value = document.getElementById("wep_key_1").value;
				document.securityform.wl_key.selectedIndex = 0;
				if(document.getElementById("wl_auth").value == "0")
					document.securityform.wl_auth.selectedIndex = 2;
				else if(document.getElementById("wl_auth").value == "1")
					document.securityform.wl_auth.selectedIndex = 1;
				else if(document.getElementById("wl_auth").value == "2")
					document.securityform.wl_auth.selectedIndex = 0;
			} else if(securityMode == 3) {
				document.securityform.wl_akm_wpa.selectedIndex = 1;
				document.securityform.wl_akm_psk.selectedIndex = 1;
				document.securityform.wl_akm_wpa2.selectedIndex = 1;
				document.securityform.wl_akm_psk2.selectedIndex = 0;
				document.securityform.wl_akm_brcm_psk.selectedIndex = 1;
				document.securityform.wl_akm_wapi.selectedIndex = 1;
				document.securityform.wl_akm_wapi_psk.selectedIndex = 1;
				document.securityform.wl_wep.selectedIndex = 1;
				document.securityform.wl_auth.selectedIndex = 2;
				document.securityform.wl_crypto.value = "aes";
				document.securityform.wl_wpa_psk.value = document.getElementById("display_WPAPSK").value;
			}		
			document.getElementById("waitPad").style.display="";
			totalWaitTime = 50; //second
			//redirectURL = "/station/site_survey.asp";
			redirectURL = "http://" + DeviceURL;
			wait_page();
			//document.modeOption.submit();
			document.securityform.submit();
		}
	}
}

function displaySecurityField(value) {
	if(value == "none")
	{
		document.getElementById("securityField").style.display = "none";
		document.getElementById("ESSIDFeild").style.display = "none";
		document.getElementById("FreqBandFeild").style.display = "none";
		document.getElementById("securityModeField").style.display = "none";
		document.getElementById("connectField").style.display = "none";
	}
	else
	{
		document.getElementById("securityTbl").style.display = "";
		document.getElementById("securityField").style.display = "";
		document.getElementById("ESSIDFeild").style.display = "";
		document.getElementById("FreqBandFeild").style.display = "";
		document.getElementById("securityModeField").style.display = "";
		document.getElementById("connectField").style.display = "";
	}
	WEPDisplay(value);
	WPAPersonalDisplay(value);
}

function displayTitle(value) {
	if(value == "security")
	{
		document.getElementById("title1").style.display = "none";
		document.getElementById("title2").style.display = "";
	}
	else
	{
		document.getElementById("title1").style.display = "";
		document.getElementById("title2").style.display = "none";
	}
}

function setSecurity() {
	var applyValue = true;
	var selectCount=0;

	
	applyValue = false;
	for (loopCount=0; loopCount<document.getElementById("arrayCount").value; loopCount++) {
		if (document.getElementById("setRadio_"+loopCount)) {
			if (document.getElementById("setRadio_"+loopCount).checked == true) {
				applyValue = true;
				selectCount = loopCount;
			}
		}
	}
	if (!applyValue)
		Alert.render("<!--#tr id="wl.alert.6" -->Please select one AP/Router that you want to connect and push Connect again.<!--#endtr -->");

	if (applyValue) {
		var tmp = "<!--#getStaNewProfileName -->";
		//document.stationScan.profile_name.value = tmp;
		displayTitle("security");
		scanFieldDisplay("none");
		displaySecurityField("block");

		if (document.getElementById("setRadio_"+selectCount).checked == true) {
			var getESSID = hexToString(document.getElementById("ESSID_hex_"+selectCount).value);
			var getBSSID = document.getElementById("BSSID_"+selectCount).value;
			var getChannel = document.getElementById("channel_"+selectCount).value;
			var getEncryType = document.getElementById("encryType_"+selectCount).value;
			var getFreqBand = document.getElementById("freqBand_"+selectCount).innerHTML;
			var getSecurity = document.getElementById("security_"+selectCount).value;
			document.getElementById("BSSID").value = getBSSID;
			Channel = getChannel;
			security = getSecurity;

			if (getESSID != "") {
				document.getElementById("ESSIDFeildText").innerHTML = getESSID;
				document.getElementById("Ssid").value = getESSID;
				document.getElementById("FreqBandFeildText").innerHTML = getFreqBand;
				document.getElementById("Freq").value = getFreqBand;
				
			}
			else {
				document.getElementById("display_ESSID").readOnly = false;
				document.getElementById("rebootNeed").value = 1;
			}
		
			if (getEncryType == "disabled") { //Disabled
				//document.getElementById("securityMode").options[0].selected = true;
				document.getElementById("securityMode").value = 0;
				document.getElementById("securityModeText").innerHTML = "<!--#tr id="disabled" -->Disabled<!--#endtr -->";
				selectSecurityMode(1);
				document.getElementById("security_infra_mode").value = "0";
			}
			else if (getEncryType == "wep") { //WEP
				//document.getElementById("securityMode").options[1].selected = true;
				document.getElementById("securityMode").value = 1;
				document.getElementById("securityModeText").innerHTML = "<!--#tr id="security.36" -->WEP<!--#endtr -->";
				selectSecurityMode(2);
				document.getElementById("security_infra_mode").value = "2";
			}
			else if (getEncryType == "psk") { //WPA-Personal
				//document.getElementById("securityMode").options[2].selected = true;
				document.getElementById("securityMode").value = 2;
				document.getElementById("securityModeText").innerHTML = "<!--#tr id="wl.wpa.p" -->WPA Personal<!--#endtr -->";
				selectSecurityMode(3);
				//document.getElementById("WPAPersonalMode").options[0].selected = true;
				selectWPAMode(1);
				document.getElementById("WPAPersonalEncryptionField").style.display = "none";
				document.getElementById("security_infra_mode").value = "4";
			}
			else if (getEncryType == "psk2") { //WPA2-Personal
				//document.getElementById("securityMode").options[2].selected = true;
				document.getElementById("securityMode").value = 3;
				document.getElementById("securityModeText").innerHTML = "<!--#tr id="wl.wpa2.p" -->WPA2 Personal<!--#endtr -->";
				selectSecurityMode(3);
				//document.getElementById("WPAPersonalMode").options[1].selected = true;
				selectWPAMode(2);
				document.getElementById("WPAPersonalEncryption").options[0].selected = true;
				document.getElementById("security_infra_mode").value = "7";
			}
			else if (getEncryType == "psk2") { //WPA2-Personal Mixed
				//document.getElementById("securityMode").options[2].selected = true;
				document.getElementById("securityMode").value = 3;
				document.getElementById("securityModeText").innerHTML = "<!--#tr id="wl.wpa2.p" -->WPA2 Personal<!--#endtr -->";
				selectSecurityMode(3);
				//document.getElementById("WPAPersonalMode").options[2].selected = true;
				selectWPAMode(2);
				document.getElementById("WPAPersonalEncryption").options[1].selected = true;
				document.getElementById("security_infra_mode").value = "7";
			}
			else if (getEncryType == "wpa") {
				scanFieldDisplay("block");
				displaySecurityField("none");
				alert("<!--#tr id="wl.alert.7" -->We don't support WPA-Enterprise security mode!<!--#endtr -->");
				return;
			}
			else if (getEncryType == "wpa2") {
				scanFieldDisplay("block");
				displaySecurityField("none");
				alert("<!--#tr id="wl.alert.8" -->We don't support WPA2-Enterprise security mode!<!--#endtr -->");
				return;
			}
			else if (getEncryType == "wpa2") {
				scanFieldDisplay("block");
				displaySecurityField("none");
				alert("<!--#tr id="wl.alert.8" -->We don't support WPA2-Enterprise security mode!<!--#endtr -->");
				return;
			}
			else { //Not in list, set to Disabled
				//document.getElementById("securityMode").options[0].selected = true;
				document.getElementById("securityMode").value = 0;
				document.getElementById("securityModeText").innerHTML = "Disabled";
				selectSecurityMode(1);
				document.getElementById("security_infra_mode").value = "0";
			}
		}

		if(Channel <= 14)
			document.securityform.wl_unit.value = "0";
		else if(Channel > 14 && Channel < 149)
			document.securityform.wl_unit.value = "1";
		else if(Channel >= 149)
			document.securityform.wl_unit.value = "1";
	}
}

function reScan() {
	document.getElementById("activeMode").value = "reScan";
	//stationScan.submit();
	document.location.reload();
}


function waitStatus()
{
	var addMsg=".";
	
	waitCount++;
	document.getElementById("waitPad").style.display = "";
	document.getElementById("waitMsg").style.display = "";
	document.getElementById("scanField_3").style.display = "none";
	document.getElementById("waitMsg").innerHTML += addMsg;
	
	if (stopToWait)
	{
		document.getElementById("waitMsg").innerHTML = "";
		document.getElementById("waitPad").style.display = "none";
		document.getElementById("waitMsg").style.display = "none";
		scanFieldDisplay("block");
	}
	else if (!stopToWait && (waitCount < 70))
		window.setTimeout("waitStatus()", 500);
	else if (waitCount >= 70)
	{
		document.getElementById("waitMsg").innerHTML = "<!--#tr id="wl.wait" -->Please wait<!--#endtr -->";
		waitCount = 0;
		window.setTimeout("waitStatus()", 500);
	}	
}

function page_load() {
	//fwUpgraceStatus("<% getFWUpgrade(); %>", "<% getCurrectLanIP(); %>");
	//wpsStatus("<% getWPSStatus(); %>", "");
	displayTitle("survey");
	displaySecurityField("none");
	document.getElementById("waitMsg").innerHTML = "<!--#tr id="wl.wait" -->Please wait<!--#endtr -->";
	waitStatus();
	updateSiteSurvey();
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
												"<a href=\"../basic/home.asp?expandable=0\"><img src=\"../images/but_basic_1<!--#tr id="image.lang.png"-->.png<!--#endtr-->\" style=\"float:left\" border=\"0\" /></a><a href=\"../adm/status.asp?expandable2=0\"><img src=\"../images/but_advance_0<!--#tr id="image.lang.png"-->.png<!--#endtr-->\" class=\"img-swap\" border=\"0\" /></a>"+
											"</div>"+
											"<div class=\"borderbottom\"> </div>"+
											"<div class=\"menuheader expandable\" onclick=\"location.href='../basic/home.asp'\" >"+
												"<img class=\"CatImage\" src=\"../images/but_network_status_0.png\" /><span class=\"CatTitle\" id=\"mainmenu_1\"><!--#tr id="basic.menu.networkstatus"-->Network Status<!--#endtr--></span>"+
											"</div>"+
											"<ul class=\"categoryitems\" >"+
												"<li style=\"display:none;\"></li>"+
											"</ul>"+
											"<div class=\"menuheader expandable\" onclick=\"location.href='../basic/wireless.asp?wl_unit=0'\">"+
												"<img class=\"CatImage\" src=\"../images/but_wireless_0.png\" /><span class=\"CatTitle\" id=\"mainmenu_2\"><!--#tr id="basic.menu.wireless"-->Wireless<!--#endtr--></span>"+
											"</div>"+
											"<ul class=\"categoryitems\" >"+
												"<li style=\"display:none;\"></li>"+
											"</ul>"+
											"<div class=\"menuheader expandable\" onclick=\"location.href='../basic/guestnetwork.asp?wl_unit=0.3'\">"+
												"<img class=\"CatImage\" src=\"../images/but_guest_network_0.png\" /><span class=\"CatTitle\" id=\"mainmenu_3\"><!--#tr id="basic.menu.guestnetwork"-->Guest Network<!--#endtr--></span>"+
											"</div>"+
											"<ul class=\"categoryitems\" >"+
												"<li style=\"display:none;\"></li>"+
											"</ul>"+
											"<div class=\"menuheader expandable\" onclick=\"location.href='../basic/parental.asp'\">"+
												"<img class=\"CatImage\" src=\"../images/but_parental_control_0.png\" /><span class=\"CatTitle\" id=\"mainmenu_4\"><!--#tr id="basic.menu.parental"-->Parental Control<!--#endtr--></span>"+
											"</div>"+
											"<ul class=\"categoryitems\" >"+
												"<li style=\"display:none;\"></li>"+
											"</ul>");
	}
	else{
			document.write("<div class=\"homenav\" style=\"margin-bottom:20px\">"+
												"<a href=\"../station/link_status.asp?expandable=0\"><img src=\"../images/but_basic_1<!--#tr id="image.lang.png"-->.png<!--#endtr-->\" style=\"float:left\" border=\"0\" /></a><a href=\"../adm/status.asp?expandable2=0\"><img src=\"../images/but_advance_0<!--#tr id="image.lang.png"-->.png<!--#endtr-->\" class=\"img-swap\" border=\"0\" /></a>"+
											"</div>"+
											"<div class=\"borderbottom\"> </div>"+
											"<div class=\"menuheader expandable\" onclick=\"location.href='../station/link_status.asp'\">"+
												"<img class=\"CatImage\" src=\"../images/but_wireless_0.png\" /><span class=\"CatTitle\" id=\"mainmenu_1\"><!--#tr id="basic.menu.wireless"-->Wireless<!--#endtr--></span>"+
											"</div>"+
											"<ul class=\"categoryitems\" >"+
												"<li><a onclick=\"location.href='../station/site_survey.asp'\"><!--#tr id="wireless.node.ss"-->Site Survey<!--#endtr--></a></li>"+
												"<li><a onclick=\"location.href='../station/wireless_basic.asp'\"><!--#tr id="wireless.node.bws"-->Manual Configuration<!--#endtr--></a></li>"+
												"<li><a onclick=\"location.href='../station/link_status.asp'\"><!--#tr id="wl.status"-->Link Status<!--#endtr--></a></li>"+
											"</ul>");
	}
</script>
</div>
						<!--END LEFT NAVIGATION --> 
<script type="text/javascript" src="../scripts/xpmenu.js"></script>
					</td>
					<td style="width:670px; padding: 10px 0px 0px 15px; " valign="top" class="txt_main">
<iframe class="rebootRedirect" name="rebootRedirect" id="rebootRedirect" frameborder="0" width="1" height="1" scrolling="no" src="" style="display:none">redirect</iframe>
<div id="waitform"></div>
<div id="mainform">
	<div id="main_content">
	<!-- InstanceBeginEditable name="Main Content" -->
<table class="body"><tr><td>
<h1><!--#tr id="wl.2"-->Wireless Network Site Survey<!--#endtr--></h1>
<div class="hr" ></div>
<p id="title1">
	<!--#tr id="site_survey.desc"-->Select your wireless network in the list and click Connect.<!--#endtr-->
</p>
<p id="title2">
	<!--#tr id="site_survey.desc2"-->If required, enter your WiFi key or password to connect to your wireless network.<!--#endtr-->
</p>

	<!------------------- Site Survey Info ------------------->
<form method="post" id="stationScan" name="stationScan" action="/goform/staConnectBySiteSurvey">
	<input type="hidden" name="token" value="<% genToken(); %>">
	<input type="hidden" id="nowMode" name="nowMode" value="">
	<input type="hidden" id="activeMode" name="activeMode" value="">
	<input type="hidden" id="securityMode" name="securityMode" value="">
	<input type="hidden" id="rebootNeed" name="rebootNeed" value="0">
	<input type="hidden" id="BSSID" name="BSSID" value="0">

	<table id="mainform2" width="100%" class="tbl_main">
		<tr id="scanField_1" style="display">
			<td class="CT" colspan="2"><!--#tr id="wl.2" -->Wireless Network Site Survey<!--#endtr --></td>
		</tr>
		<tr id="scanField_2" style="display">
			<td id="td_scanField_2" class="CL" colspan="2" style="background-repeat:no-repeat">
				<span style="font-size:14px; font-weight:bold;" id="waitMsg"></span>
				<span id="listSiteSurvey"></span>
			</td>
		</tr>
		<tr id="scanField_3" style="display:none">
			<td width="50%" align="right" style="vertical-align:middle">
				<input type="button" name"scanButton" class="<!--#tr id="buttonWidth2"-->button1<!--#endtr-->" value="<!--#tr id="refresh" -->Rescan<!--#endtr -->" onclick="reScan();">&nbsp;&nbsp;&nbsp;
			</td>
			<td width="50%" align="left" valign="middle" style="vertical-align:middle">	
				<input type="button" name="activateButton" class="<!--#tr id="buttonWidth2"-->button1<!--#endtr-->" value="<!--#tr id="connect" -->Connect<!--#endtr -->" onclick="setSecurity();">
			</td>
		</tr>
		<tr id="scanField_4" style="display:none">
			<td class="blankContent" colspan="2">&nbsp;</td>
		</tr>
	</table>
		<!-------------------------Wireless Security detail-------------------------->
	<table id="securityTbl" style="display:none">	
		<tr id="securityField">
			<td class="CT" colspan="2"><!--#tr id="wl.5" -->Wireless Security<!--#endtr --></td>
			<td colspan="2" class="blankContent"></td>
		</tr>
		<tr id="div_profile_name" style="display:none">
			<td class="CL">Profile Name</td>
			<td class="CR">
				<input type="text" id="profile_name" name="profile_name" maxlength="16">
			</td>
		</tr>
		<tr id="ESSIDFeild" style="display:none">
			<td class="CL"><!--#tr id="status.net.name.ssid" -->Network Name (SSID)<!--#endtr --></td>
			<td class="CR">
				<span id="ESSIDFeildText"></span>
				<input type=hidden id="Ssid" name="Ssid"value="">
			</td>
		</tr>
		<tr id="FreqBandFeild" style="display:none">
			<td class="CL"><!--#tr id="wl.status.2" -->Radio Band<!--#endtr --></td>
			<td class="CR">
				<span id="FreqBandFeildText"></span>
				<input type=hidden id="Freq" name="Freq" value="">&nbsp;<!--#tr id="wl.ghz" -->GHz<!--#endtr -->
			</td>
		</tr>
		<tr id="div_network_type" style="display:none">
			<td class="CL">Network Type</td>
			<td class="CR">
				<select id="network_type" name="network_type" size="1" onChange="networkTypeChange()">
					<!--<option value=0>802.11 Ad Hoc</option>-->
					<option value="1" selected>Infrastructure</option>
				</select>
			</td>
		</tr>
		<tr id="div_power_saving_mode" name="div_power_saving_mode" style="display:none">
			<td class="CL">Power Saving Mode</td>
			<td class="CR">
				<input type="radio" name="power_saving_mode" value="0" checked>CAM (Constantly Awake Mode)
				<br>
				<input type="radio" name="power_saving_mode" value="1">Power Saving Mode
			</td>
		</tr>
		<tr id="div_b_premable_type" name="div_b_premable_type" style="display:none">
			<td class="CL">11B Premable Type</td>
			<td class="CR">
				<select name="b_premable_type" size="1">
					<option value="0" selected>Auto</option>
					<option value="1">Long</option>
				</select>
			</td>
		</tr>
		<tr id="div_rts_threshold" style="display:none">
			<td class="CL"> RTS Threshold </td>
			<td class="CR">
				<input type="checkbox" name="rts_threshold" onClick="RTSThresholdChange()"> Used &nbsp;&nbsp;
				<input type="text" name="rts_thresholdvalue" id="rts_thresholdvalue" value="2347" maxlength="4"> (range 1 - 2347)
			</td>
		</tr>
		<tr id="div_fragment_threshold" style="display:none">
			<td class="CL"> Fragement Threshold </td>
			<td class="CR">
				<input type="checkbox" name="fragment_threshold" onClick="FragmentThresholdChange()"> Used &nbsp;&nbsp;
				<input type="text" name="fragment_thresholdvalue" id="fragment_thresholdvalue" value="2346" maxlength="4"> (range 256 - 2346)
			</td>
		</tr>
		<tr id="securityModeField" style="display:none">
			<td class="CL"><!--#tr id="security.mode" -->Security Mode<!--#endtr -->:</td>
			<td class="CR">
				<!--We can't use disabled="disabled" to disable this field, becasue the api will can't get this value!!!!-->
				<!--<select id="securityMode" name="securityMode" onchange="selectSecurityMode(this.value)" disabled="disabled">-->
				<!--<select id="securityMode" name="securityMode">
					<option value="1">Open</option>
					<option value="2">WEP</option>
					<option value="3">WPA/WPA2 Personal</option>
					<option value="4">WPA/WPA2 Enterprise</option>
				</select>-->
				<span id="securityModeText"></span>
				<input type=hidden name="security_infra_mode" id="security_infra_mode" value="0">
			</td>
		</tr>
		<tr id="WEPKeyLengthField" style="display:none">
			<td class="CL"><!--#tr id="ww.29" -->Encryption<!--#endtr -->:</td>
			<td class="CR">
				<select id="WEPKeyLength" name="WEPKeyLength" onchange="selectWEPKeyLength(this.value);">
					<option value="128"><!--#tr id="wl.6" -->104 / 128-bit (26 hex digits)<!--#endtr --></option>
					<option value="64" selected><!--#tr id="wl.7" -->40 / 64-bit (10 hex digits)<!--#endtr --></option>
				</select>
				<input type=hidden name="wep_key_length" id="wep_key_length" value="0">
				<input type=hidden name="wep_key_entry_method" id="wep_key_entry_method" value="0">
				<input type=hidden name="wep_default_key" id="wep_default_key" value="1"> <!-- always use key 1 -->
			</td>
		</tr>
		<tr id="wepPassphraseField" style="display:none">
			<td class="CL"><!--#tr id="wl.passphrase" -->WiFi Key/Password<!--#endtr -->:</td>
			<td class="CR"><input type="password" id="wepPassphrase" name="wepPassphrase" size="32" maxlength="32" value="" onkeyup="Update_WEPKey(this.value);"></td>
		</tr>
		<tr id="WEPKey0Field" style="display:none">
			<td class="CL"><!--#tr id="wl.key.1" -->Key 1<!--#endtr -->:</td>
			<td class="CR"><input type="password" id="wep_key_1" name="wep_key_1" size="27" maxlength="26" value=""></td>
		</tr>
		<tr id="WEPKey1Field" style="display:none">
			<td class="CL">Key 2:</td>
			<td class="CR"><input type="password" id="wep_key_2" name="wep_key_2" size="27" maxlength="26" value=""></td>
		</tr>
		<tr id="WEPKey2Field" style="display:none">
			<td class="CL">Key 3:</td>
			<td class="CR"><input type="password" id="wep_key_3" name="wep_key_3" size="27" maxlength="26" value=""></td>
		</tr>
		<tr id="WEPKey3Field" style="display:none">
			<td class="CL">Key 4:</td>
			<td class="CR"><input type="password" id="wep_key_4" name="wep_key_4" size="27" maxlength="26" value=""></td>
		</tr>
		<tr id="defaultWEPKeyField" style="display:none">
			<td class="CL"><!--#tr id="wl.key.tx" -->Tx Key<!--#endtr -->:</td>
			<td class="CR"><input type="hidden" id="defaultWEPKey" name="defaultWEPKey" value="0">
				<!--#tr id="wl.key.1" -->Key 1<!--#endtr -->
				<!--<select id="defaultWEPKey" name="defaultWEPKey" onchange="">
					<option value="0" selected>Key 1</option>
					<option value="1">Key 2</option>
					<option value="2">Key 3</option>
					<option value="3">Key 4</option>
				</select>-->
			</td>
		</tr>
		<tr id="WEPAuthField" style="display:none">
			<td class="CL"><!--#tr id="ww.26" -->Authentication<!--#endtr -->:</td>
			<td class="CR">
				<select id="wl_auth" name="wl_auth" onchange="">
					<option value="0"><!--#tr id="wl.open" -->Open<!--#endtr --></option>
					<option value="1"><!--#tr id="wl.shared" -->Shared<!--#endtr --></option>
					<option value="2" ><!--#tr id="auto" -->Auto<!--#endtr --></option>
				</select>						
			</td>
		</tr>
		<tr id="WPAPersonalEncryptionField" style="display:none">
			<td class="CL"><!--#tr id="ww.29" -->Encryption<!--#endtr -->:</td>
			<td class="CR">
				<select id="WPAPersonalEncryption" name="WPAPersonalEncryption" onchange="">
					<option value="0">TKIP</option>
					<option value="1">AES</option>
				</select>
				<input type=hidden name="cipher" id="cipher" value=""> <!-- always use key 1 -->
			</td>
		</tr>
		<tr id="WPAPSKField" style="display:none">
			<td class="CL"><!--#tr id="wl.passphrase" -->WiFi Key/Password<!--#endtr -->:</td>
			<td class="CR">
				<!--<input type="text" id="WPAPSK" name="WPAPSK" size="48" maxlength="64" value="">-->
				<input type="hidden" id="passphrase" name="passphrase" value="">
				<input type="hidden" id="submit_WPAPSK" name="submit_WPAPSK" value="">
				<input type="password" id="display_WPAPSK" name="WPAPSK" size="48" maxlength="64" value="">
			</td>
		</tr>
		<tr id="connectField" style="display:none">
			<td width="50%" align="right" style="vertical-align:middle">
				<input type="button" name"scanButton" class="<!--#tr id="buttonWidth2"-->button1<!--#endtr-->" value="<!--#tr id="refresh" -->Rescan<!--#endtr -->" onclick="reScan();">&nbsp;&nbsp;&nbsp;
			</td>
			<td width="50%" align="left" valign="middle" style="vertical-align:middle">	
				<input type="button" name="connectButton" class="<!--#tr id="buttonWidth2"-->button1<!--#endtr-->" value="<!--#tr id="connect" -->Connect<!--#endtr -->" onclick="checkValue();">
			</td>
		</tr>
</table>
</form>
	<!-------------------End Site Survey Info ------------------->
	
	<!-------------------connect Info ------------------->
<form method="post" name="securityform" action="/setWirelessBasic.cgi" target="rebootRedirect">
	<table style="display:none"><tr><td>
		<input type="hidden" name="page" value="/status/sta_link_status.asp">
		<input type="hidden" name="token" value="<% genToken(); %>">
		<input type="hidden" name="wl_wps_mode" value="<% nvram_get("wl_wps_mode"); %>">
		<input type="hidden" name="wl_ssid" value="<% nvram_get("wl_ssid"); %>">
		<input type="hidden" name="wl_unit" value="">
		<input type="hidden" name="wl_nband" value="">
		<select name="wl_auth">
		  <% wl_auth_display(); %>
		</select>
		<select name="wl_auth_mode">
		  <option value="radius" <% nvram_match("wl_auth_mode", "radius", "selected"); %>>Enabled</option>
		  <option value="none" <% nvram_invmatch("wl_auth_mode", "radius", "selected"); %>>Disabled</option>
		</select>
		<input type="hidden" name="wl_akm" value="">
		<select name="wl_akm_wpa">
		  <option value="enabled" <% nvram_inlist("wl_akm", "wpa", "selected"); %>>Enabled</option>
		  <option value="disabled" <% nvram_invinlist("wl_akm", "wpa", "selected"); %>>Disabled</option>
		</select>
		<select name="wl_akm_psk">
		  <option value="enabled" <% nvram_inlist("wl_akm", "psk", "selected"); %>>Enabled</option>
		  <option value="disabled" <% nvram_invinlist("wl_akm", "psk", "selected"); %>>Disabled</option>
		</select>
		<select name="wl_akm_wpa2">
		  <option value="enabled" <% nvram_inlist("wl_akm", "wpa2", "selected"); %>>Enabled</option>
		  <option value="disabled" <% nvram_invinlist("wl_akm", "wpa2", "selected"); %>>Disabled</option>
		</select>
		<select name="wl_akm_psk2">
		  <option value="enabled" <% nvram_inlist("wl_akm", "psk2", "selected"); %>>Enabled</option>
		  <option value="disabled" <% nvram_invinlist("wl_akm", "psk2", "selected"); %>>Disabled</option>
		</select>
		<select name="wl_akm_brcm_psk">
		  <option value="enabled" <% nvram_inlist("wl_akm", "brcm_psk", "selected"); %>>Enabled</option>
		  <option value="disabled" <% nvram_invinlist("wl_akm", "brcm_psk", "selected"); %>>Disabled</option>
		</select>
		<select name="wl_preauth">
		  <option value="disabled" <% nvram_match("wl_preauth", "0", "selected"); %>>Disabled</option>
		  <option value="enabled" <% nvram_invmatch("wl_preauth", "0", "selected"); %>>Enabled</option>
		</select>
		<input type="hidden" name="wl_wai_cert_index" value="<% nvram_get("wl_wai_cert_index"); %>">
		<input type="hidden" name="wl_wai_cert_status" value="<% nvram_get("wl_wai_cert_status"); %>">
		<select name="wl_akm_wapi">
		  <option value="enabled" <% nvram_inlist("wl_akm", "wapi", "selected"); %>>Enabled</option>
		  <option value="disabled" <% nvram_invinlist("wl_akm", "wapi", "selected"); %>>Disabled</option>
		</select>
		<select name="wl_akm_wapi_psk">
		  <option value="enabled" <% nvram_inlist("wl_akm", "wapi_psk", "selected"); %>>Enabled</option>
		  <option value="disabled" <% nvram_invinlist("wl_akm", "wapi_psk", "selected"); %>>Disabled</option>
		</select>
		<select name="wl_wep">
		  <option value="enabled" <% nvram_match("wl_wep", "enabled", "selected"); %>>Enabled</option>
		  <option value="disabled" <% nvram_invmatch("wl_wep", "enabled", "selected"); %>>Disabled</option>
		</select>
		<select name="wl_crypto">
		  <option value="tkip" <% nvram_match("wl_crypto", "tkip", "selected"); %>>TKIP</option>
		  <option value="aes" <% nvram_match("wl_crypto", "aes", "selected"); %>>AES</option>
		  <option value="tkip+aes" <% nvram_match("wl_crypto", "tkip+aes", "selected"); %>>TKIP+AES</option>
<!--
#ifdef BCMWAPI_WAI
-->
		  <option value="sms4" <% nvram_match("wl_crypto", "sms4", "selected"); %>>SMS4</option>
<!--
#endif
-->
	 	</select>
		<input name="wl_wai_as_ip" value="<% nvram_get("wl_wai_as_ip"); %>" size="15" maxlength="15">
		<input name="wl_wai_as_port" value="<% nvram_get("wl_wai_as_port"); %>" size="5" maxlength="5">
		<input name="wl_radius_ipaddr" value="<% nvram_get("wl_radius_ipaddr"); %>" size="15" maxlength="15">
		<input name="wl_radius_port" value="<% nvram_get("wl_radius_port"); %>" size="5" maxlength="5">
		<input name="wl_radius_key" value="<% nvram_get("wl_radius_key"); %>" type="password">
		<input name="wl_wpa_psk" value="<% nvram_get("wl_wpa_psk"); %>" type="password">
		<input name="wl_key1" value="<% nvram_get("wl_key1"); %>" size="26" maxlength="26" type="password">
		<input name="wl_key2" value="<% nvram_get("wl_key2"); %>" size="26" maxlength="26" type="password">
		<input name="wl_key3" value="<% nvram_get("wl_key3"); %>" size="26" maxlength="26" type="password">
		<input name="wl_key4" value="<% nvram_get("wl_key4"); %>" size="26" maxlength="26" type="password">
		<select name="wl_key">
		  <option value="1" <% nvram_match("wl_key", "1", "selected"); %>>1</option>
		  <option value="2" <% nvram_match("wl_key", "2", "selected"); %>>2</option>
		  <option value="3" <% nvram_match("wl_key", "3", "selected"); %>>3</option>
		  <option value="4" <% nvram_match("wl_key", "4", "selected"); %>>4</option>
		</select>
		<input name="wl_wpa_gtk_rekey" value="<% nvram_get("wl_wpa_gtk_rekey"); %>" size="10" maxlength="10">
		<input name="wl_wai_uck_rekey" value="<% nvram_get("wl_wai_uck_rekey"); %>" size="10" maxlength="10">
		<input name="wl_wai_mck_rekey" value="<% nvram_get("wl_wai_mck_rekey"); %>" size="10" maxlength="10">
		<input name="wl_net_reauth" value="<% nvram_get("wl_net_reauth"); %>" size="10" maxlength="10">
		<input name="wl_nas_dbg" value="<% nvram_get("wl_nas_dbg"); %>" size="10" maxlength="10">
		<input type="hidden" name="action" value="Apply">
	</td></tr></table>
</form>
	<!-------------------connect Info ------------------->
	
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
