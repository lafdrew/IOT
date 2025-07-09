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
var survey_flag=0;
var survey_str=2;
var stopToWait;

function makeRequest2(url, content) {
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
		//Alert.render("Giving up :( Cannot create an XMLHTTP instance");
		return false;
	}
	http_request.onreadystatechange = function () {alertContents2()};
	http_request.open('POST', url, true);
	http_request.send(content);
}

function alertContents2() {
	if (http_request.readyState == 4) {
		if (http_request.status == 200) {
			survey_flag=1;
			survey_str = http_request.responseText;
		} else {
			//Alert.render("There was a problem with the request.");
		}
	}
}



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
		//Alert.render("Giving up :( Cannot create an XMLHTTP instance");
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
	if (fieldID != "")
		document.getElementById(fieldID).innerHTML = str;
}
var LanIP = "<% nvram_get("lan_ipaddr"); %>";
var updateStatusCount=0;
var redirectUrlPath;
var security = 0;
var DeviceURL = "<% nvram_get("DeviceURL"); %>";

function basicDisplay(value) {
	if(value == "block")
	{
		document.getElementById("freqBand").style.display = "";
		document.getElementById("ESSIDFeild").style.display = "";
		document.getElementById("securityModeField").style.display = "";
		document.getElementById("RFSetSeparate").style.display = "";
		document.getElementById("manualTitle").style.display = "";
		document.getElementById("manualTitle2").style.display = "";
	}
	else
	{
		document.getElementById("freqBand").style.display = "none";
		document.getElementById("ESSIDFeild").style.display = "none";
		document.getElementById("securityModeField").style.display = "none";
		document.getElementById("RFSetSeparate").style.display = "none";
		document.getElementById("manualTitle").style.display = "none";
		document.getElementById("manualTitle2").style.display = "none";
	}
}

function WPSDisplay(value) {
	if(value == "block")
	{
		document.getElementById("WPSTitleField").style.display = "";
		document.getElementById("WPSAPPBCField").style.display = "";
		document.getElementById("WPSAPPINField").style.display = "";
		document.getElementById("WPSStatusField").style.display = "";
	}
	else
	{
		document.getElementById("WPSTitleField").style.display = "none";
		document.getElementById("WPSAPPBCField").style.display = "none";
		document.getElementById("WPSAPPINField").style.display = "none";
		document.getElementById("WPSStatusField").style.display = "none";
	}
}

function mainDisplay(value) {
	if(value == "block")
	{
		document.getElementById("configTypeField").style.display = "none";
		document.getElementById("configTypeField2").style.display = "none";
		document.getElementById("configTypeSeparate").style.display = "";
		document.getElementById("freqBand").style.display = "";
		document.getElementById("ESSIDFeild").style.display = "";
		document.getElementById("securityModeField").style.display = "";
		document.getElementById("RFSetSeparate").style.display = "";
		document.getElementById("manualTitle").style.display = "";
		document.getElementById("manualTitle2").style.display = "";
	}
	else
	{
		document.getElementById("configTypeField").style.display = "none";
		document.getElementById("configTypeField2").style.display = "none";
		document.getElementById("configTypeSeparate").style.display = "none";
		document.getElementById("freqBand").style.display = "none";
		document.getElementById("ESSIDFeild").style.display = "none";
		document.getElementById("securityModeField").style.display = "";
		document.getElementById("RFSetSeparate").style.display = "";
		document.getElementById("manualTitle").style.display = "";
		document.getElementById("manualTitle2").style.display = "";
	}
}

function WEPDisplay(value) {
	if(value == "block")
	{
		document.getElementById("WEPKey0Field").style.display = "";
		document.getElementById("WEPKey1Field").style.display = "none";
		document.getElementById("WEPKey2Field").style.display = "none";
		document.getElementById("WEPKey3Field").style.display = "none";
		document.getElementById("defaultWEPKeyField").style.display = "";
		document.getElementById("WEPKeyLengthField").style.display = "none";
		document.getElementById("wl_authField").style.display = "";
	}
	else
	{
		document.getElementById("WEPKey0Field").style.display = "none";
		document.getElementById("WEPKey1Field").style.display = "none";
		document.getElementById("WEPKey2Field").style.display = "none";
		document.getElementById("WEPKey3Field").style.display = "none";
		document.getElementById("defaultWEPKeyField").style.display = "none";
		document.getElementById("WEPKeyLengthField").style.display = "none";
		document.getElementById("wl_authField").style.display = "none";
	}
}

function WPAPersonalDisplay(value) {
	if(value == "block")
	{
		document.getElementById("WPAPersonalEncryptionField").style.display = "";
		document.getElementById("WPAPSKField").style.display = "";
	}
	else
	{
		document.getElementById("WPAPersonalEncryptionField").style.display = "none";
		document.getElementById("WPAPSKField").style.display = "none";

	}
}

function changeImage(position){
	if (position == "moveIn")
		document.getElementById("wpsPBCImage").src = "../images/WFA_WPS_Mark_Solo1.png";
	else if (position == "moveOut")
		document.getElementById("wpsPBCImage").src = "../images/WFA_WPS_Mark_Solo.png";
	else if (position == "moveDown")
	{
		document.getElementById("wpsPBCImage").src = "../images/wps_nonselectable.png";
		checkWPS("getPBC");
	}
}

function selectConfigType(control){
	if (control =="submit")
	{
		if (document.getElementById("selectManual").checked == true)
			document.getElementById("wirelessConfigType").value = "manual";
		else if (document.getElementById("selectWPS").checked == true)
			document.getElementById("wirelessConfigType").value = "wps";
			
		document.getElementById("waitPad").style.display="block";
		document.wirelessTypeSet.submit();
	}
	else
	{
		WEPDisplay("none");
		WPAPersonalDisplay("none");
		
		if (document.getElementById("selectManual").checked == true)
		{
			document.getElementById("wirelessType").innerHTML = "<!--#tr id="wireless.node.bws" -->Manual Configuration<!--#endtr -->";
			document.getElementById("wirelessConfigType").value = "manual";
			WPSDisplay("none");
			basicDisplay("block");
		
		}
		else if (document.getElementById("selectWPS").checked == true)
		{
			// Annie.Weng: WPS is not supported
			document.getElementById("wirelessType").innerHTML = "Wi-Fi Protected Setup";
			document.getElementById("wirelessConfigType").value = "wps";
			basicDisplay("none");
			WPSDisplay("block");
		}
	}	
}

function selectSecurityMode(mode) {
	WEPDisplay("none");
	WPAPersonalDisplay("none");

	//var selectedIndex = document.getElementById("securityMode").selectedIndex;
	//var modeName = document.getElementById("securityMode").options[selectedIndex].id;

	if (mode == "0") { //Disabled
	
	}
	else if (mode == "wep") { //WEP
		WEPDisplay("block");
	}
	else if (mode == "psk") { //WPA Personal
		WPAPersonalDisplay("block");
		selectWPAMode(1);
		document.getElementById("WPAPersonalEncryptionField").style.display = "";
	}
	else if (mode == "psk2") { //WPA2 Personal
		WPAPersonalDisplay("block");
		selectWPAMode(2);
		document.getElementById("WPAPersonalEncryptionField").style.display = "none";
	}
	else if (mode == "wpa") { //WPA Enterprise

	}
	else if (mode == "wpa2") { //WPA2 Enterprise

	}
}
function checkCancel(){
	document.location.reload(true)
}
function confirmCheck(confirmvalue) {
	document.securityform.wl_ssid.value = document.getElementById("display_ESSID").value;
		
	// below is auto run site survey. Ryan add 
	/*
	var survey_ssid = document.getElementById("display_ESSID").value;
	var parameter ="survey_ssid="+survey_ssid;
	makeRequest2("/chanspec.cgi", parameter);
	*/
	if (document.getElementById("Band_51").checked == true) {
		document.securityform.wl_unit.value = "1";
		document.securityform.wl_nband.value = "1";
	} else {
		document.securityform.wl_unit.value = "0";
		document.securityform.wl_nband.value = "2";
	}	
	//for securitymode == psk
	document.securityform.wl_akm_wpa.selectedIndex = 1;
	document.securityform.wl_akm_psk.selectedIndex = 0;
	document.securityform.wl_akm_wpa2.selectedIndex = 1;
	document.securityform.wl_akm_psk2.selectedIndex = 1;
	document.securityform.wl_akm_brcm_psk.selectedIndex = 1;
	document.securityform.wl_akm_wapi.selectedIndex = 1;
	document.securityform.wl_akm_wapi_psk.selectedIndex = 1;
	document.securityform.wl_wep.selectedIndex = 1;
	document.securityform.wl_auth.selectedIndex = 2;
	if (document.getElementById("WPAPersonalEncryption").value == 0)
		document.securityform.wl_crypto.value = "tkip";
	else
		document.securityform.wl_crypto.value = "aes";
	document.securityform.wl_wpa_psk.value = document.getElementById("display_WPAPSK").value;
	document.getElementById("waitPad").style.display="block";
	totalWaitTime = 30; //second
	redirectURL = "http://" + DeviceURL;
	wait_page();
	//document.modeOption.submit();
		
	document.securityform.submit();
	// below is get radioband to select wl_unit and wl_nband value. Rayn add 
		//securityform_sumbit();
}

function checkValue() {
	var applyValue = true;
	var checkValue, keyLenCount;
	var securityMode = document.getElementById("securityMode").value;
	var regex = /^[\w\~\`\!\@\#\$\%\^\&\*\(\)\_\+\-\=\\\|\[\{\]\}\;\:\'\"\/\?\.\>\,\<\ ]+$/;
	
	if(!regex.test(document.getElementById("display_ESSID").value) || document.getElementById("display_ESSID").value.length == 0) {
		Alert.render("<!--#tr id="wl.alert.4" -->Please specify Network Name (SSID).<!--#endtr -->");
		applyValue = false;
	}
	//Tom.Hung 2012-6-27, check full width
	if (/[^\x00-\xff]/g.test(document.getElementById("display_ESSID").value)){   
		Alert.render("<!--#tr id="wl.alert.4" -->Please specify Network Name (SSID).<!--#endtr -->");
		applyValue = false;
	}
	//Tom.Hung 2012-6-27 end	
	document.getElementById("submit_ESSID").value = document.getElementById("display_ESSID").value;

	if (applyValue && (securityMode == "wep")) { //WEP
		for (loopCount=1; loopCount<=1; loopCount++) { //Only use key 1
			docTemp = document.getElementById("WEPKey"+loopCount).value;

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
	
	if (applyValue && securityMode == "psk")
	{
		Confirm.render("<!--#tr id="HT.confirm" -->WARNING: Your Wireless-N devices will only operate at Wireless-G data rates with the encryption type you have chosen. Please select WPA2-Personal encryption if you would like to have your Wireless-N devices operating at full data rates. Click OK to continue with this selection, or Cancel to choose another type of encryption.<!--#endtr -->","confirmCheck","","","");
	}
	else {
		if (applyValue && securityMode == "psk2") {
			if (applyValue && !checkWPAPSK(document.getElementById("display_WPAPSK").value)){
				applyValue = false;
			}
		}
		if (applyValue) {
			document.securityform.wl_ssid.value = document.getElementById("display_ESSID").value;
		
		// below is auto run site survey. Ryan add 
		/*
		var survey_ssid = document.getElementById("display_ESSID").value;
		var parameter ="survey_ssid="+survey_ssid;
		makeRequest2("/chanspec.cgi", parameter);
		*/
		if (document.getElementById("Band_51").checked == true) {
			document.securityform.wl_unit.value = "1";
			document.securityform.wl_nband.value = "1";
		} else {
			document.securityform.wl_unit.value = "0";
			document.securityform.wl_nband.value = "2";
		}	
		
		if(securityMode == "0") {
			document.securityform.wl_akm_wpa.selectedIndex = 1;
			document.securityform.wl_akm_psk.selectedIndex = 1;
			document.securityform.wl_akm_wpa2.selectedIndex = 1;
			document.securityform.wl_akm_psk2.selectedIndex = 1;
			document.securityform.wl_akm_brcm_psk.selectedIndex = 1;
			document.securityform.wl_akm_wapi.selectedIndex = 1;
			document.securityform.wl_akm_wapi_psk.selectedIndex = 1;
			document.securityform.wl_wep.selectedIndex = 1;
			document.securityform.wl_auth.selectedIndex = 2;
		} else if(securityMode == "wep") {
			document.securityform.wl_akm_wpa.selectedIndex = 1;
			document.securityform.wl_akm_psk.selectedIndex = 1;
			document.securityform.wl_akm_wpa2.selectedIndex = 1;
			document.securityform.wl_akm_psk2.selectedIndex = 1;
			document.securityform.wl_akm_brcm_psk.selectedIndex = 1;
			document.securityform.wl_akm_wapi.selectedIndex = 1;
			document.securityform.wl_akm_wapi_psk.selectedIndex = 1;
			document.securityform.wl_wep.selectedIndex = 0;
			document.securityform.wl_key1.value = document.getElementById("WEPKey1").value;
			document.securityform.wl_key.selectedIndex = 0;
			if(document.getElementById("wl_auth").value == "0")
				document.securityform.wl_auth.selectedIndex = 2;
			else if(document.getElementById("wl_auth").value == "1")
				document.securityform.wl_auth.selectedIndex = 1;
			else if(document.getElementById("wl_auth").value == "2")
				document.securityform.wl_auth.selectedIndex = 0;
		} else if(securityMode == "psk") {
			document.securityform.wl_akm_wpa.selectedIndex = 1;
			document.securityform.wl_akm_psk.selectedIndex = 0;
			document.securityform.wl_akm_wpa2.selectedIndex = 1;
			document.securityform.wl_akm_psk2.selectedIndex = 1;
			document.securityform.wl_akm_brcm_psk.selectedIndex = 1;
			document.securityform.wl_akm_wapi.selectedIndex = 1;
			document.securityform.wl_akm_wapi_psk.selectedIndex = 1;
			document.securityform.wl_wep.selectedIndex = 1;
			document.securityform.wl_auth.selectedIndex = 2;
			document.securityform.wl_crypto.value = "aes";
			document.securityform.wl_wpa_psk.value = document.getElementById("display_WPAPSK").value;
		} else if(securityMode == "psk2") {
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
		document.getElementById("waitPad").style.display="block";
		totalWaitTime = 50; //second
		redirectURL = "http://" + DeviceURL;
		wait_page();
		//document.modeOption.submit();
		
		document.securityform.submit();
		// below is get radioband to select wl_unit and wl_nband value. Rayn add 
		//securityform_sumbit();
		}
	}
}
/*
function securityform_sumbit(){

	if (survey_flag == 1) {
	
		if (survey_str != "2"){
			document.securityform.wl_unit.value = survey_str;
			if (survey_str == "1") {
				document.securityform.wl_nband.value = "1";  //5G
			} else {
				document.securityform.wl_nband.value = "2";  //2.4G
			}	
			document.securityform.submit();
		} else {
			process_stop = 1;
			var msg = document.getElementById("display_ESSID").value + " " + "<!--#tr id="wl.alert.9" -->cannot be found, please check SSID name and setting again<!--#endtr -->";
			Alert.render(msg);
		}		
		
	} else{
		window.setTimeout("securityform_sumbit()", 100);
	}
}	
*/	

function checkWPS(funcName) {
	if (funcName == "getPIN") {
		document.startWPS.wps_method.value = "PIN";
		document.getElementById("waitPad").style.display="block";
		//document.startWPS.submit();
		/*
		if (document.getElementById("WPS_Band_5").checked == true) {
			document.wpsform.wl_unit.value = "1";
			document.wpsform.wl_nband.value = "1";
		} else {
			document.wpsform.wl_unit.value = "0";
			document.wpsform.wl_nband.value = "2";
		}
		*/
		document.wpsform.wl_unit.value = "1";
		document.wpsform.wl_nband.value = "1";
		document.wpsform.wps_method.selectedIndex = 1;
		document.wpsform.wps_ap_list.selectedIndex = document.getElementById("wps_pin_ap").selectedIndex;
		document.wpsform.submit();
	}
	else if (funcName == "getPBC") {
		document.startWPS.wps_method.value = "PBC";
		document.getElementById("waitPad").style.display="block";
		//document.startWPS.submit();
		
		/* select radio band*/
		/*
		if (document.getElementById("WPS_Band_5").checked == true) {
			document.wpsform.wl_unit.value = "1";
			document.wpsform.wl_nband.value = "1";
		} else {
			document.wpsform.wl_unit.value = "0";
			document.wpsform.wl_nband.value = "2";
		}
		*/
		
		document.wpsform.wl_unit.value = "1";
		document.wpsform.wl_nband.value = "1";
		document.wpsform.wps_method.selectedIndex = 0;
		document.wpsform.submit();
	}
	totalWaitTime=12;
	wait_restart();
	//document.startWPS.submit();
}
function waitStatus()
{	
	if (stopToWait)
	{
		//if (document.getElementById("listWPSStatus").innerHTML == "Connected")
		/*if (document.getElementById("listWPSStatus").innerHTML.indexOf("Connected") != -1)
		{
			//objectDisplay("WPSStatusESSID", "block");
			//objectDisplay("WPSStatusSecurity", "block");
		}*/
		
	}
	else
	{ 
		window.setTimeout("waitStatus()", 1000);
		//objectDisplay("WPSStatusESSID", "none");
		//objectDisplay("WPSStatusSecurity", "none");
	}

}

function updateWPSStatus(){
	makeRequest("/updateWPSStatus.cgi", "something", "listWPSStatus", "listWPSTemp");
}

function CopySelect(from,to) 
{ 
	for(var i=0;i<from.options.length;i++) 
	{ 
		var op = from.options[i]; 
		to.options.add(new Option(op.text, op.value)); 
	} 
}

function page_load() {
	//fwUpgraceStatus("<% getFWUpgrade(); %>", "<% getCurrectLanIP(); %>");
	//wpsStatus("<% getWPSStatus(); %>", "");
	
	var wirelessConfigType = "manual";
	security = "<% nvram_get("wl_crypto"); %>";
	var unit_band = "<% nvram_get("prev_connect_unit_psta"); %>";
	if (unit_band == "1") {   //ryan 2013.06.27 modify for show correct information after wps processing
		var ESSID = "<% nvram_hex("wl1_ssid"); %>";
		var securityMode = "<% nvram_get("wl1_akm"); %>";
		securityMode = securityMode.replace(/(\s*$)/g, ""); //remove right space
		var wep = "<% nvram_get("wl1_wep"); %>";
		var WEPKey1 = "<% nvram_get("wl1_key1"); %>";
		var WEPKey2 = "<% nvram_get("wl1_key2"); %>";
		var WEPKey3 = "<% nvram_get("wl1_key3"); %>";
		var WEPKey4 = "<% nvram_get("wl1_key4"); %>";
		var defaultWEPKey = "<% nvram_get("wl1_key"); %>";
		var WPAPSK = "<% nvram_hex("wl1_wpa_psk"); %>";
		var crypto = "<% nvram_get("wl1_crypto"); %>";
	} else if (unit_band == "0") {
		var ESSID = "<% nvram_hex("wl0_ssid"); %>";
		var securityMode = "<% nvram_get("wl0_akm"); %>";
		securityMode = securityMode.replace(/(\s*$)/g, ""); //remove right space
		var wep = "<% nvram_get("wl0_wep"); %>";
		var WEPKey1 = "<% nvram_get("wl0_key1"); %>";
		var WEPKey2 = "<% nvram_get("wl0_key2"); %>";
		var WEPKey3 = "<% nvram_get("wl0_key3"); %>";
		var WEPKey4 = "<% nvram_get("wl0_key4"); %>";
		var defaultWEPKey = "<% nvram_get("wl0_key"); %>";
		var WPAPSK = "<% nvram_hex("wl0_wpa_psk"); %>";
		var crypto = "<% nvram_get("wl0_crypto"); %>";
	} else {		
		var ESSID = "<% nvram_hex("wl2_ssid"); %>";
		var securityMode = "<% nvram_get("wl2_akm"); %>";
		securityMode = securityMode.replace(/(\s*$)/g, ""); //remove right space
		var wep = "<% nvram_get("wl2_wep"); %>";
		var WEPKey1 = "<% nvram_get("wl2_key1"); %>";
		var WEPKey2 = "<% nvram_get("wl2_key2"); %>";
		var WEPKey3 = "<% nvram_get("wl2_key3"); %>";
		var WEPKey4 = "<% nvram_get("wl2_key4"); %>";
		var defaultWEPKey = "<% nvram_get("wl2_key"); %>";
		var WPAPSK = "<% nvram_hex("wl2_wpa_psk"); %>";
		var crypto = "<% nvram_get("wl2_crypto"); %>";
	}	
	
	mainDisplay("block");
	WEPDisplay("none");
	WPAPersonalDisplay("none");
	selectConfigType(wirelessConfigType);
	
	if (wirelessConfigType == "manual")
	{
		document.getElementById("selectManual").checked = true;
		document.getElementById("wirelessType").innerHTML = "<!--#tr id="wireless.node.bws" -->Manual Configuration<!--#endtr -->";
		document.getElementById("wirelessConfigType").value = "manual";
		WPSDisplay("none");
		basicDisplay("block");
		
		if (unit_band == "1")
			document.getElementById("Band_51").checked = true;
		else
			document.getElementById("Band_24").checked = true;
		
		if(ESSID == "6C696E6B7379735F3230313230353037") //fake SSID "linksys_20120507"
			document.getElementById("display_ESSID").value = "";
		else
			document.getElementById("display_ESSID").value = transSSID(ESSID);

		document.getElementById("WEPKey1").value = WEPKey1;
		document.getElementById("WEPKey2").value = WEPKey2;
		document.getElementById("WEPKey3").value = WEPKey3;
		document.getElementById("WEPKey4").value = WEPKey4;
		document.getElementById("defaultWEPKey").value = defaultWEPKey;
		document.getElementById("display_WPAPSK").value = transSSID(WPAPSK);
		
		if (securityMode == "0" || (securityMode == "" && wep == "disabled")) { //Disabled
			document.getElementById("securityMode").selectedIndex = 3;
		}
		else if (securityMode == "" && wep == "enabled") { //WEP
			document.getElementById("securityMode").selectedIndex = 2;
			securityMode = "wep";

			var wep_auth = "<% nvram_get("wl_auth"); %>";

			if(wep_auth == "0"){
				document.getElementById("wl_auth").selectedIndex = 0;
			}
			else if(wep_auth == "1"){
				document.getElementById("wl_auth").selectedIndex = 1;
			}
			else if(wep_auth == "2"){
				document.getElementById("wl_auth").selectedIndex = 2;
			}
			else{
				document.getElementById("wl_auth").selectedIndex = 0;
			}
		}
		else if (securityMode == "psk") { //WPA Personal

			document.getElementById("securityMode").selectedIndex = 1;
		}
		else if (securityMode == "psk2") { //WPA2 Personal
			document.getElementById("securityMode").selectedIndex = 0;
		}
		else if (securityMode == "wpa") { //WPA Enterprise
			//document.getElementById("securityMode").selectedIndex = 4;
		}
		else if (securityMode == "wpa2") { //WPA2 Enterprise
			//document.getElementById("securityMode").selectedIndex = 5;
		}

		selectSecurityMode(securityMode);
	}
	else
	{
		//WPS
		waitStatus();
		updateWPSStatus();
		var WPAPersonalMode = ""; //not use 

		var pinCode = "<% nvram_get("wps_device_pin"); %>";
		document.getElementById("selectWPS").checked = true;
		// Annie.Weng: WPS is not supported
		document.getElementById("wirelessType").innerHTML = "Wi-Fi Protected Setup";
		document.getElementById("wirelessConfigType").value = "wps";
		basicDisplay("none");
		WPSDisplay("block");
		if (unit_band == "2")
			document.getElementById("Band_51").checked = true;
		else
			document.getElementById("Band_24").checked = true;
		document.getElementById("saveField").style.display = "none";
	
		document.getElementById("WPSDevicePIN").innerHTML = pinCode;
		CopySelect(document.wpsform.wps_ap_list, document.getElementById("wps_pin_ap"));
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
<h1 id="wirelessType"><!--#tr id="wireless.node.bws"-->Manual Configuration<!--#endtr --></h1>
<div class="hr" ></div>
<p>
	<!--#tr id="parental.desc"-->This section allows you to manually define the wireless network to connect instead of discovering under Site Survey. This can be used if your WiFi Network Name/SSID is set to hidden or SSID broadcast is disabled.<!--#endtr-->
</p>

	<!---------------------------------setting info-------------------------->
<div style="display:none">	
	<table id="mainform" width="100%" class="tbl_main">
		<!-------------------------------mode select--------------------------->
		<form method="post" name="wirelessTypeSet" action="/setWirelessConfigType.cgi">
		<tr id="configTypeField">
			<td class="CT" colspan="2"><!--#tr id="wl.3" -->Configuration Option<!--#endtr -->: </td>
		</tr>
		<tr id="configTypeField2">
			<td class="CR" width="100%">
				<input type="hidden" name="token" value="<% genToken(); %>">
				<input type="hidden" id="wirelessConfigType" name="wirelessConfigType">
				<table width="100%"><tr>
					<td width="50%">
						<input type="radio" id="selectManual" name="configType" onclick="selectConfigType('submit');">&nbsp;<!--#tr id="manual" -->Manual<!--#endtr -->
					</td>
					<td width="50%">	
						<input type="radio" id="selectWPS"  name="configType" onclick="selectConfigType('submit');">&nbsp;Wi-Fi Protected Setup
					</td>
				</tr></table>
			</td>
		</tr>
		</form>
		<tr id="configTypeSeparate">
			<td class="blankContent" colspan="2"></td>
		</tr>
	</table>
</div>
	<!--------------------------------Manual----------------------------------->
	<table width="100%" class="tbl_main">
	<form method="post" name="modeOption" action="/setWirelessBasic.cgi">
	<input type="hidden" name="token" value="<% genToken(); %>">
		<tr id="manualTitle2">
			<td class="CT" colspan="2"><!--#tr id="wireless.network" -->Wireless Network<!--#endtr --></td>
		</tr>
		<tr id="freqBand" style="display:none">
			<td class="CL"><!--#tr id="wl.4" -->Frequency Band<!--#endtr --></td>
			<td class="CR">
				<table width="100%"><tr>
						<td width="50%">
							<input type="radio" id="Band_24" name="radioBand">&nbsp;2.4<!--#tr id="wl.ghz" -->GHz<!--#endtr -->
						</td>
						<td width="50%">	
							<input type="radio" id="Band_51"  name="radioBand">&nbsp;5<!--#tr id="wl.ghz" -->GHz<!--#endtr -->
						</td>
				</tr></table>
			</td>
		</tr>
		<tr id="ESSIDFeild" style="display:none">
			<td class="CL"><!--#tr id="status.net.name.ssid" -->Network Name (SSID)<!--#endtr --></td>
			<td class="CR" colspan="2">
				<input type="hidden" id="submit_ESSID" name="submit_ESSID" value="">
				<input type="text" id="display_ESSID" name="ESSID" size="33" maxlength="32" value="">
			</td>
		</tr>
		<tr id="RFSetSeparate" style="display:none">
			<td class="blankContent" colspan="2" height="15px"></td>
		</tr>
		<tr id="manualTitle" style="display">
			<td class="CT" colspan="2"><!--#tr id="wl.5" -->Wireless Security<!--#endtr --></td>
		</tr>
		<tr id="securityModeField" style="display:none">
			<td class="CL"><!--#tr id="security.mode" -->Security Mode<!--#endtr --></td>
			<td class="CR" colspan="2">
				<select id="securityMode" name="securityMode" onchange="selectSecurityMode(this.value)">
					<option id="wpa2" value="psk2"><!--#tr id="wl.wpa2.p" -->WPA2 Personal<!--#endtr --></option>
					<option id="wpa" value="psk"><!--#tr id="wl.wpa.p" -->WPA Personal<!--#endtr --></option>
					<option id="wep" value="wep"><!--#tr id="security.36" -->WEP<!--#endtr --></option>
					<option id="open" value="0" selected> <!--#tr id="disabled" -->Disabled<!--#endtr --></option>
					<!--
					<option id="wpa" value="wpa">WPA Enterprise</option>
					<option id="wpa2" value="wpa2">WPA2 Enterprise</option>
					-->
				</select>
			</td>
		</tr>
		<tr id="WEPKeyLengthField" style="display:none">
			<td class="CL"><!--#tr id="ww.29" -->Encryption<!--#endtr --></td>
			<td class="CR" colspan="2">
				<select id="WEPKeyLength" name="WEPKeyLength" onchange="selectWEPKeyLength_WET610N(this.value);">
					<option value="1"><!--#tr id="wl.6" -->104 / 128-bit (26 hex digits)<!--#endtr --></option>
					<option value="0" selected><!--#tr id="wl.7" -->40 / 64-bit (10 hex digits)<!--#endtr --></option>
				</select>						
			</td>
		</tr>
		<tr id="WEPKey0Field" style="display:none">
			<td class="CL"><!--#tr id="wl.key.1" -->Key 1<!--#endtr --></td>
			<td class="CR" colspan="2"><input type="password" id="WEPKey1" name="WEPKey1" size="27" maxlength="26" value="" /></td>
		</tr>
		<tr id="WEPKey1Field" style="display:none">
			<td class="CL">Key 2</td>
			<td class="CR" colspan="2"><input type="password" id="WEPKey2" name="WEPKey2" size="27" maxlength="26" value=""></td>
		</tr>
		<tr id="WEPKey2Field" style="display:none">
			<td class="CL">Key 3</td>
			<td class="CR" colspan="2"><input type="password" id="WEPKey3" name="WEPKey3" size="27" maxlength="26" value=""></td>
		</tr>
		<tr id="WEPKey3Field" style="display:none">
			<td class="CL">Key 4</td>
			<td class="CR" colspan="2"><input type="password" id="WEPKey4" name="WEPKey4" size="27" maxlength="26" value=""></td>
		</tr>
		<tr id="defaultWEPKeyField" style="display:none">
			<td class="CL"><!--#tr id="wl.key.tx" -->Tx Key<!--#endtr --></td>
			<td class="CR" colspan="2"><input type="hidden" id="defaultWEPKey" name="defaultWEPKey" value="1">
				<!--#tr id="wl.key.1" -->Key 1<!--#endtr -->
				<!--<select id="defaultWEPKey" name="defaultWEPKey" onchange="">
					<option value="0" selected>Key 1</option>
					<option value="1">Key 2</option>
					<option value="2">Key 3</option>
					<option value="3">Key 4</option>
				</select>-->
			</td>
		</tr>
		<tr id="wl_authField" style="display:none">
			<td class="CL"><!--#tr id="ww.26" -->Authentication<!--#endtr --></td>
			<td class="CR" colspan="2">
				<select id="wl_auth" name="wl_auth" onchange="">
					<option value="0"><!--#tr id="wl.open" -->Open<!--#endtr --></option>
					<option value="1"><!--#tr id="wl.shared" -->Shared<!--#endtr --></option>
					<option value="2" ><!--#tr id="auto" -->Auto<!--#endtr --></option>
				</select>						
			</td>
		</tr>
		<tr id="WPAPersonalEncryptionField" style="display:none">
			<td class="CL"><!--#tr id="ww.29" -->Encryption<!--#endtr --></td>
			<td class="CR" colspan="2">
				<select id="WPAPersonalEncryption" name="WPAPersonalEncryption" onchange="">
					<option value="0">TKIP</option>
					<option value="1">AES</option>
					<option value="2" selected>TKIP or AES</option>
				</select>
			</td>
		</tr>
		<tr id="WPAPSKField" style="display:none">
			<td class="CL"><!--#tr id="wl.passphrase" -->WiFi Key/Password<!--#endtr --></td>
			<td class="CR" colspan="2">
				<!--<input type="text" id="WPAPSK" name="WPAPSK" size="48" maxlength="64" value="">-->
				<input type="hidden" id="submit_WPAPSK" name="submit_WPAPSK" value="">
				<input type="password" id="display_WPAPSK" name="WPAPSK" size="48" maxlength="64" value="">
			</td>
		</tr>
		</form>
	</table>
		<!------------------------------- WPS -------------------------------------------->
<div style="display:none">	
	<table width="100%" class="tbl_main">
		<form method="get" name="startWPS" action="/wps.asp">
		<input type="hidden" name="token" value="<% genToken(); %>">
		<input type="hidden" id="action" name="action" value="Start">
		<input type="hidden" id="wps_action" name="wps_action" value="Enroll">
		<input type="hidden" id="wps_method" name="wps_method" value="">
		<tr id="WPSTitleField" style="display">
			<td class="CT" colspan="2">Wi-Fi Protected Setup</td>
		</tr>
		<tr id="WPSfreqBand" style="display:none">
			<td class="CL"><!--#tr id="wl.4" -->Frequency Band<!--#endtr --></td>
			<td class="CR">
				<table width="100%"><tr>
					<td width="50%">
						<input type="radio" id="WPS_Band_24" name="WPS_Band">2.4<!--#tr id="wl.ghz" -->GHz<!--#endtr -->
					</td>
					<td width="50%">	
						<input type="radio" id="WPS_Band_5"  name="WPS_Band">5<!--#tr id="wl.ghz" -->GHz<!--#endtr -->
					</td>
				</tr></table>
			</td>
		</tr>

		<tr id="WPSAPPBCField" height="65px">
			<td class="CR" width="100%" colspan="2">
				<table width="100%"><tr>
					<td width="70%">
						1. If your router has a Wi-Fi Protected Setup button, click or press that button, and then click the button on the right.
					</td>
					<td align="center">
						<img id="wpsPBCImage" src="../images/WFA_WPS_Mark_Solo.png" onmousemove="changeImage('moveIn');" onmouseout="changeImage('moveOut');" onmousedown="changeImage('moveDown');">
					</td>
				</tr></table>
			</td>	
		</tr>
		<tr id="WPSAPPINField" height="65px">
			<td class="CR" width="100%" colspan="2">
				<table width="100%"><tr>
					<td width="70%">
						2. If your router asks for the client device's PIN number, enter this number in your router and then click:&nbsp;<strong><span id="WPSDevicePIN"></span></strong>&nbsp;
						<div style="display:none"><!-- Open this if want to select WPS AP list -->
							, select your router SSID in below list
							<br />
							<select id="wps_pin_ap" name="wps_pin_ap"></select>
							and then click
						</div>
					</td>		
					<td align="center">
						<input type="button" id="Get_configured_via_pin" name="Get_configured_via_pin" value="OK" onclick="checkWPS('getPIN');" />
					</td>
				</tr></table>
			</td>				
		</tr>
	</form>
	</table>
</div>
	<!-------------------------------link status info------------------------------------->		
	<div id="WPSStatusField" style="display:none">	
	<div id="listWPSStatus"></div>	
	<table width="100%" class="tbl_main" id="listWPSTemp" >
		<tr>
			<td class="CL"><!--#tr id="wl.status" -->Link Status<!--#endtr --></td>
			<td class="CR"><!--#tr id="ipv6.disconnected" -->Disconnected<!--#endtr --></td>
		</tr>
		<tr>
			<td class="CL"><!--#tr id="status.net.name.ssid" -->Network Name (SSID)<!--#endtr --></td>
			<td class="CR"><span id="WPSStatusESSID"></span></td>
		</tr>
		<tr>
			<td class="CL"><!--#tr id="wl.status.7" -->Security<!--#endtr --></td>
			<td class="CR"><span id="WPSStatusSecurity"></span></td>
		</tr>
	</table>
	</div>

	<table id="saveField" class="tbl_main" width="100%">
		<tr>				
			<td width="50%" align="right" style="vertical-align:middle">
				<input type="button" name"scanButton" class="button1_NoWidth" value="<!--#tr id="apply" -->Apply<!--#endtr -->" onclick="checkValue();">&nbsp;&nbsp;&nbsp;
			</td>
			<td width="50%" align="left" valign="middle" style="vertical-align:middle">	
				<input type="button" name="connectButton" class="button1_NoWidth" value="<!--#tr id="cancel" -->Cancel<!--#endtr -->" onclick="checkCancel();">
			</td>
		</tr>
	</table>
	<!---------------------------------end setting info-------------------------->

	<table style="display:none"><tr><td>
	<form method="post" name="securityform" action="/setWirelessBasic.cgi" target="rebootRedirect">
		<input type="hidden" name="page" value="/status/sta_link_status.asp">
		<input type="hidden" name="token" value="<% genToken(); %>">
		<input type="hidden" name="wl_wps_mode" value="<% nvram_get("wl_wps_mode"); %>">
		<input type="hidden" name="wl_unit" value="">
		<input type="hidden" name="wl_ssid" value="<% nvram_get("wl_ssid"); %>">
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
	</form>
	<form method="post" name="wpsform" action="/runWPS.cgi" target="rebootRedirect">
		<input type="hidden" name="page" value="/station/wps_status.asp">
		<input type="hidden" name="token" value="<% genToken(); %>">
		<input type="hidden" name="action" value="Start">
		<input name="invite_name" value="0" type="hidden">
		<input name="invite_mac" value="0" type="hidden">
		<input type="hidden" name="wl_unit" value="">
		<input type="hidden" name="wl_nband" value="">
		<% wps_display(); %>
		<select name="wl_wfi_enable">
		  <option value="1" <% nvram_match("wl_wfi_enable", "1", "selected"); %>>Enabled</option>
		  <option value="0" <% nvram_invmatch("wl_wfi_enable", "1", "selected"); %>>Disabled</option>
		</select>
		<select name="wl_wfi_pinmode">
		  <option value="0" <% nvram_match("wl_wfi_pinmode", "0", "selected"); %>>Auto</option>
		  <option value="1" <% nvram_match("wl_wfi_pinmode", "1", "selected"); %>>Manual</option>
		</select>
		<input type="button" name="refresh_button" value="Refresh" style="height: 25px; width: 100px" onClick="doRefresh()">
	</form>
	</td></tr></table>
			

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
