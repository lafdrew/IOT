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
<script type="text/javascript" src="../scripts/wlssid_schedule.js"></script>

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
var nmode_enabled = <% wl_nmode_enabled(); %>;

function wl_key_update()
{
	var mode = document.radio.wl_auth_mode[document.radio.wl_auth_mode.selectedIndex].value;
	var wep = document.radio.wl_wep[document.radio.wl_wep.selectedIndex].value;
	var wpa= document.radio.wl_akm_wpa[document.radio.wl_akm_wpa.selectedIndex].value;
	var psk = document.radio.wl_akm_psk[document.radio.wl_akm_psk.selectedIndex].value;
	var wl_ibss = <% wl_ibss_mode(); %>;
	var wpa2 = document.radio.wl_akm_wpa2[document.radio.wl_akm_wpa2.selectedIndex].value;
	var psk2 = document.radio.wl_akm_psk2[document.radio.wl_akm_psk2.selectedIndex].value;
	var brcm_psk = document.radio.wl_akm_brcm_psk[document.radio.wl_akm_brcm_psk.selectedIndex].value;
	var i, cur, algos;

	/* enable network key 1 to 4 */
	if (wep == "enabled") {
		if (document.radio.wl_akm_wpa.disabled == 0 && wpa == "enabled" ||
			document.radio.wl_akm_psk.disabled == 0 && psk == "enabled"
			|| document.radio.wl_akm_wpa2.disabled == 0 && wpa2 == "enabled"
			|| document.radio.wl_akm_psk2.disabled == 0 && psk2 == "enabled"
			|| document.radio.wl_akm_brcm_psk.disabled == 0 && brcm_psk == "enabled"
			|| mode == "radius") {
			document.radio.wl_key1.disabled = 1;
			document.radio.wl_key4.disabled = 1;
		}
		else {
			document.radio.wl_key1.disabled = 0;
			document.radio.wl_key4.disabled = 0;
		}
		document.radio.wl_key2.disabled = 0;
		document.radio.wl_key3.disabled = 0;
	}
	else {
		document.radio.wl_key1.disabled = 1;
		document.radio.wl_key2.disabled = 1;
		document.radio.wl_key3.disabled = 1;
		document.radio.wl_key4.disabled = 1;
	}

	/* Save current network key index */
	for (i = 0; i < document.radio.wl_key.length; i++) {
		if (document.radio.wl_key[i].selected) {
			cur = document.radio.wl_key[i].value;
			break;
		}
	}

	/* Define new network key indices */
	/* Tom.Hung 2012-11-29, don't remove 1 4 index when select other security
	if (mode == "radius" ||
		document.radio.wl_akm_wpa.disabled == 0 && wpa == "enabled" ||
		document.radio.wl_akm_psk.disabled == 0 && psk == "enabled"
		|| document.radio.wl_akm_wpa2.disabled == 0 && wpa2 == "enabled"
		|| document.radio.wl_akm_psk2.disabled == 0 && psk2 == "enabled"
		|| document.radio.wl_akm_brcm_psk.disabled == 0 && brcm_psk == "enabled"
		)
		algos = new Array("2", "3");
	else
	*/
		algos = new Array("1", "2", "3", "4");

	/* Reconstruct network key indices array from new network key indices */
	document.radio.wl_key.length = algos.length;
	for (var i in algos) {
		document.radio.wl_key[i] = new Option(algos[i], algos[i]);
		document.radio.wl_key[i].value = algos[i];
		if (document.radio.wl_key[i].value == cur)
			document.radio.wl_key[i].selected = true;
	}

	/* enable key index */
	if (wep == "enabled")
		document.radio.wl_key.disabled = 0;
	else
		document.radio.wl_key.disabled = 1;

	/* enable gtk rotation interval */
	if ((wep == "enabled") || (wl_ibss == "1"))
		document.radio.wl_wpa_gtk_rekey.disabled = 1;
	else {
		if (document.radio.wl_akm_wpa.disabled == 0 && wpa == "enabled" ||
			document.radio.wl_akm_psk.disabled == 0 && psk == "enabled"
			|| document.radio.wl_akm_wpa2.disabled == 0 && wpa2 == "enabled"
			|| document.radio.wl_akm_psk2.disabled == 0 && psk2 == "enabled"
			|| document.radio.wl_akm_brcm_psk.disabled == 0 && brcm_psk == "enabled"
			)
			document.radio.wl_wpa_gtk_rekey.disabled = 0;
		else
			document.radio.wl_wpa_gtk_rekey.disabled = 1;
	}
}

function wl_auth_change()
{
	var auth = document.radio.wl_auth[document.radio.wl_auth.selectedIndex].value;
	var wl_ure = <% wl_ure_enabled(); %>;
	var wl_ibss = <% wl_ibss_mode(); %>;

	if (auth == "1") {
		document.radio.wl_akm_wpa.disabled = 1;
		document.radio.wl_akm_psk.disabled = 1;
		document.radio.wl_akm_wpa2.disabled = 1;
		document.radio.wl_akm_psk2.disabled = 1;
		document.radio.wl_akm_brcm_psk.disabled = 1;
		document.radio.wl_preauth.disabled = 1;
/*
#ifdef BCMWAPI_WAI
*/
		document.radio.wl_akm_wapi.disabled = 1;
		document.radio.wl_akm_wapi_psk.disabled = 1;
/*
#endif
*/
		document.radio.wl_wpa_psk.disabled = 1;
		document.radio.wl_crypto.disabled = 1;

	}
	else {
		if ((wl_ure == "1") || (wl_ibss == "1")) {
			document.radio.wl_akm_wpa.disabled = 1;
    		}
	  	else {
			document.radio.wl_akm_wpa.disabled = 0;

    		}
		if (wl_ibss == "1") {
			document.radio.wl_akm_psk.disabled = 1;
		}
		else {
			document.radio.wl_akm_psk.disabled = 0;
		}
		if (wl_ure == "1") {
			document.radio.wl_akm_wpa2.disabled = 1;
			document.radio.wl_preauth.disabled = 1;
			document.radio.wl_akm_brcm_psk.disabled = 1;
		} else if (wl_ibss == "1") {
			document.radio.wl_akm_wpa2.disabled = 1;
			document.radio.wl_preauth.disabled = 1;
			document.radio.wl_akm_psk2.disabled = 1;
			document.radio.wl_akm_brcm_psk.disabled = 0;

	  	} else {
			document.radio.wl_akm_wpa2.disabled = 0;
			document.radio.wl_akm_psk2.disabled = 0;
			document.radio.wl_preauth.disabled = 0;
			document.radio.wl_akm_brcm_psk.disabled = 1;
		}
/*
#ifdef BCMWAPI_WAI
*/
		if ((wl_ure == "1") || (wl_ibss == "1")) {
			document.radio.wl_akm_wapi.disabled = 1;
			document.radio.wl_akm_wapi_psk.disabled = 1;
    	}
	  	else {
			document.radio.wl_akm_wapi.disabled = 0;
			document.radio.wl_akm_wapi_psk.disabled = 0;
   		}
/*
#endif
*/
		document.radio.wl_wpa_psk.disabled = 0;
		document.radio.wl_crypto.disabled = 0;
	}

	wl_key_update();
}

function wl_auth_mode_change()
{
	var mode = document.radio.wl_auth_mode[document.radio.wl_auth_mode.selectedIndex].value;
	var wpa = document.radio.wl_akm_wpa[document.radio.wl_akm_wpa.selectedIndex].value;
	var psk = document.radio.wl_akm_psk[document.radio.wl_akm_psk.selectedIndex].value;
	var wl_nmode = <% wl_nmode_enabled(); %>;
	var wpa2 = document.radio.wl_akm_wpa2[document.radio.wl_akm_wpa2.selectedIndex].value;
	var psk2 = document.radio.wl_akm_psk2[document.radio.wl_akm_psk2.selectedIndex].value;

	/* enable radius IP, port, password */
	if (mode == "radius" ||
		document.radio.wl_akm_wpa.disabled == 0 && wpa == "enabled"
		|| document.radio.wl_akm_wpa2.disabled == 0 && wpa2 == "enabled"
		) {
		document.radio.wl_radius_ipaddr.disabled = 0;
		document.radio.wl_radius_port.disabled = 0;
		document.radio.wl_radius_key.disabled = 0;
	} else {
		document.radio.wl_radius_ipaddr.disabled = 1;
		document.radio.wl_radius_port.disabled = 1;
		document.radio.wl_radius_key.disabled = 1;
	}

	/* enable network re-auth interval */
	if (mode == "radius" ||
		document.radio.wl_akm_wpa.disabled == 0 && wpa == "enabled"
		|| document.radio.wl_akm_wpa2.disabled == 0 && wpa2 == "enabled"
		)
		document.radio.wl_net_reauth.disabled = 0;
	else
		document.radio.wl_net_reauth.disabled = 1;

	wl_key_update();
}

function wl_akm_change()
{
	var mode = document.radio.wl_auth_mode[document.radio.wl_auth_mode.selectedIndex].value;
	var wpa = document.radio.wl_akm_wpa[document.radio.wl_akm_wpa.selectedIndex].value;
	var psk = document.radio.wl_akm_psk[document.radio.wl_akm_psk.selectedIndex].value;
	var wpa2 = document.radio.wl_akm_wpa2[document.radio.wl_akm_wpa2.selectedIndex].value;
	var psk2 = document.radio.wl_akm_psk2[document.radio.wl_akm_psk2.selectedIndex].value;
	var brcm_psk = document.radio.wl_akm_brcm_psk[document.radio.wl_akm_brcm_psk.selectedIndex].value;
/*
#ifdef BCMWAPI_WAI
*/
	var wapi = document.radio.wl_akm_wapi[document.radio.wl_akm_wapi.selectedIndex].value;
	var wapi_psk = document.radio.wl_akm_wapi_psk[document.radio.wl_akm_wapi_psk.selectedIndex].value;
/*
#endif
*/
	var wl_nmode = <% wl_nmode_enabled(); %>;
	var i;

	/* enable Pre-shared Key */
	if (psk == "enabled"
		|| psk2 == "enabled" || brcm_psk == "enabled"
/*
#ifdef BCMWAPI_WAI
*/
		|| wapi_psk == "enabled"
/*
#endif
*/
		)
		document.radio.wl_wpa_psk.disabled = 0;
	else
		document.radio.wl_wpa_psk.disabled = 1;

	/* enable radius options */
	if (mode == "radius" || wpa == "enabled"
		|| wpa2 == "enabled"
		) {
		document.radio.wl_radius_ipaddr.disabled = 0;
		document.radio.wl_radius_port.disabled = 0;
		document.radio.wl_radius_key.disabled = 0;
	}
	else {
		document.radio.wl_radius_ipaddr.disabled = 1;
		document.radio.wl_radius_port.disabled = 1;
		document.radio.wl_radius_key.disabled = 1;
	}

	/* enable crypto */
	if (wpa == "enabled" || psk == "enabled"
		|| wpa2 == "enabled" || psk2 == "enabled" || brcm_psk == "enabled"
/*
#ifdef BCMWAPI_WAI
*/
		|| wapi == "enabled" || wapi_psk == "enabled"
/*
#endif
*/
		)
		document.radio.wl_crypto.disabled = 0;
	else
		document.radio.wl_crypto.disabled = 1;

	/* enable re-auth interval */
	if (mode == "radius" || wpa == "enabled"
		|| wpa2 == "enabled"
		)
		document.radio.wl_net_reauth.disabled = 0;
	else
		document.radio.wl_net_reauth.disabled = 1;

		if (wpa2 == "enabled")
			document.radio.wl_preauth.disabled = 0;
		else
			document.radio.wl_preauth.disabled = 1;

		if ((wpa2 == "enabled") || (psk2 == "enabled") || (brcm_psk == "enabled") ||
		    (wpa == "enabled") || (psk == "enabled") || (wl_nmode == "1")) {
			document.radio.wl_wep.selectedIndex = 1;
			document.radio.wl_wep.disabled = 1;
		} else {
			document.radio.wl_wep.disabled = 0;
		}

/*
#ifdef BCMWAPI_WAI
*/

	if (wapi_psk == "enabled" || wapi == "enabled") {
		document.radio.wl_auth.disabled = 1;
		document.radio.wl_auth_mode.disabled = 1;
		document.radio.wl_auth_mode.value = "none";
		document.radio.wl_akm_wpa.disabled = 1;
		document.radio.wl_akm_wpa.value = "disabled";
		document.radio.wl_akm_psk.disabled = 1;
		document.radio.wl_akm_psk.value = "disabled";
		document.radio.wl_akm_wpa2.disabled = 1;
		document.radio.wl_akm_wpa2.value = "disabled";
		document.radio.wl_akm_psk2.disabled = 1;
		document.radio.wl_akm_psk2.value = "disabled";
		document.radio.wl_wep.disabled = 1;
		document.radio.wl_wep.value = "disabled";
		document.getElementById('wl_wapi_encrypt_div').style.display="";
		document.getElementById('wl_wpa_encrypt_div').style.display="none";


		if (wapi == "enabled") {
			document.radio.wl_wai_as_ip.disabled = 0;
			document.radio.wl_wai_as_port.disabled = 0;
		}
		else {
			document.radio.wl_wai_as_ip.disabled = 1;
			document.radio.wl_wai_as_port.disabled = 1;
		}


		if (wapi_psk == "enabled") {
			document.getElementById('wl_wapi_psk_div').style.display="";
			document.getElementById('wl_wpa_psk_div').style.display="none";
		}

		/* Save current crypto algorithm */
		for (i = 0; i < document.radio.wl_crypto.length; i++) {
			if (document.radio.wl_crypto[i].value == "sms4") {
				document.radio.wl_crypto[i].disabled = 0;
				document.radio.wl_crypto[i].selected = true;
			}
			else
				document.radio.wl_crypto[i].disabled = 1;
		}

		/* Unicast/Multicast rekeying */
		document.radio.wl_wai_uck_rekey.disabled = 0;
		document.radio.wl_wai_mck_rekey.disabled = 0;
	}
	else {
		document.radio.wl_auth.disabled = 0;
		document.radio.wl_auth_mode.disabled = 0;
		document.radio.wl_akm_wpa.disabled = 0;
		document.radio.wl_akm_psk.disabled = 0;
		document.radio.wl_akm_wpa2.disabled = 0;
		document.radio.wl_akm_psk2.disabled = 0;
		if (wl_nmode != "1")
			document.radio.wl_wep.disabled = 0;
		document.getElementById('wl_wapi_encrypt_div').style.display="none";
		document.getElementById('wl_wpa_encrypt_div').style.display="";
		document.getElementById('wl_wapi_psk_div').style.display="none";
		document.getElementById('wl_wpa_psk_div').style.display="";

		document.radio.wl_wai_as_ip.disabled = 1;
		document.radio.wl_wai_as_port.disabled = 1;

		/* Save current crypto algorithm */
		for (i = 0; i < document.radio.wl_crypto.length; i++) {
			if (document.radio.wl_crypto[i].value == "sms4") {
				document.radio.wl_crypto[i].disabled = 1;
				if (document.radio.wl_crypto[i].selected == true)
					document.radio.wl_crypto[0].selected = true;
			}
			else {
				document.radio.wl_crypto[i].disabled = 0;
			}
		}

		/* Unicast/Multicast rekeying */
		document.radio.wl_wai_uck_rekey.disabled = 1;
		document.radio.wl_wai_mck_rekey.disabled = 1;
	}
/*
#endif
*/
	wl_key_update();
}

function confirmNoCheck(noValue) {
	if(noValue == "um_wps_wep_change_display" )
		document.radio.wl_wep.selectedIndex = 1;
}

function confirmYesCheck(yesValue) {
	if(yesValue == "um_wps_wep_change_display" )
		document.radio.wl_wps_mode.value = "disabled";
}

function wl_wep_change()
{
/*
#ifdef BCMWPS
*/
<% wps_um_wep_change_display(); %>
/*
#endif
*/

	wl_key_update();
}

function wl_security_update()
{
	var i, cur, algos;
	var wl_ure = <% wl_ure_enabled(); %>;
	var wl_ibss = <% wl_ibss_mode(); %>;
	var wl_nmode = <% wl_nmode_enabled(); %>;

	/* Save current crypto algorithm */
	for (i = 0; i < document.radio.wl_crypto.length; i++) {
		if (document.radio.wl_crypto[i].selected) {
			cur = document.radio.wl_crypto[i].value;
			break;
		}
	}

	/* Define new crypto algorithms */
	
	var wpaSecurity = "<% wl_corerev(); %>";
	if (isBlankString(wpaSecurity))
	    wpaSecurity = 0;
	    
	if ( wpaSecurity >= 3) {
		if (wl_ibss == "1") {
			algos = new Array("AES");
		}
		else if (wl_nmode == "1") {
			algos = new Array("AES", "TKIP+AES");
/*
#ifdef BCMWAPI_WAI
*/
			algos = new Array("AES", "TKIP+AES"/*, "SMS4"*/);
/*
#endif
*/
		}
		else {
			algos = new Array("TKIP", "AES", "TKIP+AES");
/*
#ifdef BCMWAPI_WAI
*/
			algos = new Array("TKIP", "AES", "TKIP+AES"/*, "SMS4"*/);
/*
#endif
*/
		}
	} else {
		if (wl_ibss == "0")
			algos = new Array("TKIP");
		else
			algos = new Array("");
	}

	/* Reconstruct algorithm array from new crypto algorithms */
	document.radio.wl_crypto.length = algos.length;
	for (var i in algos) {
		document.radio.wl_crypto[i] = new Option(algos[i], algos[i].toLowerCase());
		document.radio.wl_crypto[i].value = algos[i].toLowerCase();
		if (document.radio.wl_crypto[i].value == cur)
			document.radio.wl_crypto[i].selected = true;
	}

       /* If nmode then disable WEP */
        if (<% wl_corerev(); %> >= 3 && wl_nmode == "1") {
        	document.radio.wl_wep.selectedIndex = 1;
		document.radio.wl_wep.disabled = 1;
        }

	wl_auth_change();
	wl_auth_mode_change();
	wl_akm_change();
	wl_wep_change();

	if ((wl_ure == "1") || (wl_ibss == "1")) {
		document.radio.wl_auth_mode.disabled = 1;
	}
	else {
		document.radio.wl_auth_mode.disabled = 0;
	}

/*
#ifdef BCMWAPI_WAI
*/
	if (document.radio.wl_akm_wapi[document.radio.wl_akm_wapi.selectedIndex].value == "enabled" ||
		document.radio.wl_akm_wapi_psk[document.radio.wl_akm_wapi_psk.selectedIndex].value == "enabled") {
		document.radio.wl_auth_mode.disabled = 1;
		document.radio.wl_auth_mode.value = "none";
	}
/*
#endif
*/
}

function checkHex(targetString)
{
    // Do a case-insensitive search
    return /^([A-F0-9])*$/i.test(targetString);
}

function checkValue()
{
	var re3 = /^[\w\~\`\!\@\#\$\%\^\&\*\(\)\_\+\-\=\\\|\[\{\]\}\;\:\'\"\/\?\.\>\,\<\ ]+$/;

	if(document.radio.guest_enable.checked == true && document.radio.wl_ssid.value == "") {
		Alert.render("<!--#tr id="ww.alert.1"-->The SSID field can not be blank!<!--#endtr-->");
		return false;
	}

	if (!re3.test(document.radio.wl_ssid.value) && document.radio.wl_ssid.value != "") {
		Alert.render("<!--#tr id="ssid.error"-->Invalid characters in SSID!<!--#endtr-->");
		return false;
	}

	var security_mode = document.getElementById("security_mode").value;
	var reg = /^0$|^[1-9][0-9]*$/; //user could only input 0(only 1 digit) or a number which fist digit is not 0
	
	if (!reg.test(document.radio.wl_wpa_gtk_rekey.value)) {//Fix 1042
		Alert.render("<!--#tr id="security.alert.6"-->The rotation interval must be an integer!<!--#endtr-->");
		return false;
	}

	if (security_mode == "Disable") { //Disable
		// check nothing
	}
	else if (security_mode == "OPEN" || security_mode == "SHARED") { //WEP
		// 6. Check Network Key 1 ~ 4
		for (var i = 0; i < 4; i++)
		{
			var networkKeyElement = document.getElementById("networkKey" + i);
			var keyLength = networkKeyElement.value.length;
			if (networkKeyElement.disabled)
			{
				continue;
			}
			//Tom.Hung 2012-11-29, ignore empty key if the key is not current
			var keyid = document.radio.wl_key.value;
			if(keyid != (i+1) && keyLength == 0) {
				continue;
			}
			//Tom.Hung 2012-11-29 end
	
			if (keyLength == 5 || keyLength == 13)
			{
				// Do nothing. length = 5 or 13 -> It is OK.
			}
			else if (keyLength == 10 || keyLength == 26)
			{
				if (!checkHex(networkKeyElement.value))
				{
					networkKeyElement.focus();
					Alert.render("<!--#tr id="security.alert.3"-->Invalid Network key. It is not a hexadecimal digit.<!--#endtr-->" + " --- " + networkKeyElement.value);
					return false;
				}
			}
			else
			{
				Alert.render("<!--#tr id="security.alert.4"-->Invalid Network key : must be 5 or 13 ASCII characters or 10 or 26 hexadecimal digits<!--#endtr-->");
				return false;
			}
		}
	}
	else if (security_mode == "WPAPSK" || security_mode == "WPA2PSK" || security_mode == "WPAPSKWPA2PSK") { //Personal
		// 5. Check WPA passphrase
		// A wireless network with WPA-PSK encryption requires a passphrase (the pre-shared key) to be entered to get access to the network.
		// Most wireless drivers accept the passphrase as a string of at most 63 characters, and internally convert the passphrase to a 256-bit key.
		// However, some software also allows the key to be entered directly in the form of 64 hexadecimal digits.
		var wpaPassphraseElement = document.getElementById("wpaPassphrase");
		if (!wpaPassphraseElement.disabled)
		{
			if (wpaPassphraseElement.value.length == 64)
			{
				if (!checkHex(wpaPassphraseElement.value))
				{
					wpaPassphraseElement.focus();
					Alert.render("<!--#tr id="security.alert.1"-->Invalid WPA passphrase. It is not a hexadecimal digit.<!--#endtr-->" + " --- " + wpaPassphraseElement.value);
					return false;
				}
			}
			else if (wpaPassphraseElement.value.length < 8 || wpaPassphraseElement.value.length > 63)
			{
				wpaPassphraseElement.focus();
				Alert.render("<!--#tr id="security.alert.2"-->Invalid WPA passphrase : must be between 8 and 63 ASCII characters or 64 hexadecimal digits<!--#endtr-->");
				return false;
			}
		}

		// 7. Check Network Key Rotation interval
		var intervalList = ["rotationInterval"];
		var intervalNameList = ["Network Key Rotation interval"];
		for (var i = 0; i < intervalList.length; i++)
		{
			var intervalElement = document.getElementById(intervalList[i]);
			if (!intervalElement.disabled && !is_number(intervalElement.value))
			{
				intervalElement.focus();
				Alert.render("<!--#tr id="security.alert.5"-->Please input an integer value.<!--#endtr-->");
				return false;
			}
		}
	}
	else if (security_mode == "WPA" || security_mode == "WPA2" || security_mode == "WPA1WPA2") { //Enterprise
		// 3. Check RADIUS Server
		var radiusServerElement = document.getElementById("radiusServer");
		if (!radiusServerElement.disabled && !checkIpAddr(radiusServerElement, false))
		{
			radiusServerElement.focus();
			Alert.render("<!--#tr id="ip.address.error"-->Invalid IP address! Please enter a valid IP address.<!--#endtr-->");
			return false;
		}
	
		// 4. Check RADIUS Port
		var radiusPortElement = document.getElementById("radiusPort");
		if (!radiusPortElement.disabled && !is_port_valid(radiusPortElement.value))
		{
			radiusPortElement.focus();

			Alert.render("<!--#tr id="port.error"-->Please input a correct port between 0 and 65535<!--#endtr-->");
			return false;
		}

		// 7. Check Network Key Rotation interval
		var intervalList = ["rotationInterval"];
		var intervalNameList = ["Network Key Rotation interval"];
		for (var i = 0; i < intervalList.length; i++)
		{
			var intervalElement = document.getElementById(intervalList[i]);
			if (!intervalElement.disabled && !is_number(intervalElement.value))
			{
				intervalElement.focus();
				Alert.render("<!--#tr id="security.alert.5"-->Please input an integer value.<!--#endtr-->");
				return false;
			}
		}
	} else {
		// 1. Check WAPI AS Server
		var wapiAsServerElement = document.getElementById("wapiAsServer");
		if (!wapiAsServerElement.disabled && !checkIpAddr(wapiAsServerElement, false))
		{
			wapiAsServerElement.focus();
			Alert.render("<!--#tr id="ip.address.error"-->Invalid IP address! Please enter a valid IP address.<!--#endtr-->");
			return false;
		}
	
		// 2. Check WAPI AS port
		var wapiAsPortElement = document.getElementById("wapiAsPort");
		if (!wapiAsPortElement.disabled && !is_port_valid(wapiAsPortElement.value))
		{
			wapiAsPortElement.focus();
			Alert.render("<!--#tr id="port.error"-->Please input a correct port between 0 and 65535<!--#endtr-->");
			return false;
		}

		// 7. Check Network Key Rotation interval, WAPI Unicast Rekeying interval,
		// WAPI Multicast Rekeying interval, Network Re-auth interval
		var intervalList = ["rotationInterval", "unicastRekeyingInterval", "unicastRekeyingInterval", "reauthInterval"];
		var intervalNameList = ["Network Key Rotation interval", "WAPI Unicast Rekeying interval",
			"WAPI Multicast Rekeying interval", "Network Re-auth interval"]
		for (var i = 0; i < intervalList.length; i++)
		{
			var intervalElement = document.getElementById(intervalList[i]);
			if (!intervalElement.disabled && !is_number(intervalElement.value))
			{
				intervalElement.focus();
				Alert.render("<!--#tr id="security.alert.5"-->Please input an integer value.<!--#endtr-->");
				return false;
			}
		}
	}

	redirectURL = ".." + location.pathname;
	totalWaitTime = 25; //second
	wait_page();
	document.getElementById("waitPad").style.display="block";
	scroll(0,0);
	return true;
}

function wpapsk_window()
{
	Alert.render("<!--#tr id="ebd.wps.40"-->The WPA passphrase is<!--#endtr--> " + document.getElementById("wpaPassphrase").value);
}

function wep_window(n)
{
	switch(n) {
		case 1:
			Alert.render("<!--#tr id="security.20"-->Network Key<!--#endtr--> 1:" + document.getElementById("networkKey0").value);
			break;
		case 2:
			Alert.render("<!--#tr id="security.20"-->Network Key<!--#endtr--> 2:" + document.getElementById("networkKey1").value);
			break;
		case 3:
			Alert.render("<!--#tr id="security.20"-->Network Key<!--#endtr--> 3:" + document.getElementById("networkKey2").value);
			break;
		case 4:
			Alert.render("<!--#tr id="security.20"-->Network Key<!--#endtr--> 4:" + document.getElementById("networkKey3").value);
			break;
	}
}

function pre_submit()
{
/*
#ifdef BCMWPS
*/
<% wps_um_security_pre_submit_display(); %>
/*
#endif
*/
	return true;
}

function wl_macmode_check()
{
/*
#ifdef BCMWPS
*/

/*
#endif
*/
}

function change_security_mode()
{
	var security_mode = document.getElementById("security_mode").value;

	if (security_mode == "Disable") { //Disable
		document.radio.wl_auth.value = "0";
		document.radio.wl_auth_mode.value = "none";
		document.radio.wl_akm_wpa.value = "disabled";
		document.radio.wl_akm_psk.value = "disabled";
		document.radio.wl_akm_wpa2.value = "disabled";
		document.radio.wl_akm_psk2.value = "disabled";
		document.radio.wl_akm_brcm_psk.value = "disabled";
		document.radio.wl_preauth.value = "disabled";
		document.radio.wl_akm_wapi.value = "disabled";
		document.radio.wl_akm_wapi_psk.value = "disabled";
		document.radio.wl_wep.value = "disabled";
		document.getElementById("wep_field").style.display = "none";
		document.getElementById("wpa_field").style.display = "none";
		document.getElementById("psk_field").style.display = "none";
		document.getElementById("radius_field").style.display = "none";
	}
	else if (security_mode == "OPEN" || security_mode == "SHARED") { //WEP
		if (security_mode == "OPEN") {
			document.radio.wl_auth.value = "0";
		} else if (security_mode == "SHARED") {
			document.radio.wl_auth.value = "1";
		}
		document.radio.wl_auth_mode.value = "none";
		document.radio.wl_akm_wpa.value = "disabled";
		document.radio.wl_akm_psk.value = "disabled";
		document.radio.wl_akm_wpa2.value = "disabled";
		document.radio.wl_akm_psk2.value = "disabled";
		document.radio.wl_akm_brcm_psk.value = "disabled";
		document.radio.wl_preauth.value = "disabled";
		document.radio.wl_akm_wapi.value = "disabled";
		document.radio.wl_akm_wapi_psk.value = "disabled";
		document.radio.wl_wep.value = "enabled";
		document.getElementById("wep_field").style.display = "block";
		document.getElementById("wpa_field").style.display = "none";
		document.getElementById("psk_field").style.display = "none";
		document.getElementById("radius_field").style.display = "none";
	}
	else if (security_mode == "WPAPSK" || security_mode == "WPA2PSK" || security_mode == "WPAPSKWPA2PSK") { //Personal
		document.radio.wl_auth.value = "0";
		document.radio.wl_auth_mode.value = "none";
		document.radio.wl_akm_wpa.value = "disabled";
		document.radio.wl_akm_wpa2.value = "disabled";
		if (security_mode == "WPAPSK") {
			document.radio.wl_akm_psk.value = "enabled";
			document.radio.wl_akm_psk2.value = "disabled";
			//Tom.Hung 2012-11-23, WPA-PSK use tkip in default, and tkip+aes if n mode support.
			var wl_crypto = document.radio.wl_crypto;
			for(i=0;i<wl_crypto.options.length;i++) {
				if((wl_crypto.options[i].value == "tkip" && nmode_enabled == "0") ||
					(wl_crypto.options[i].value == "tkip+aes" && nmode_enabled == "1")) {
					wl_crypto.options[i].selected = true;
				}
			}
			//Tom.Hung 2012-11-23 end
		} else if (security_mode == "WPA2PSK") {
			document.radio.wl_akm_psk.value = "disabled";
			document.radio.wl_akm_psk2.value = "enabled";
			//Tom.Hung 2012-11-23, WPA2-PSK use aes in default
			var wl_crypto = document.radio.wl_crypto;
			for(i=0;i<wl_crypto.options.length;i++) {
				if(wl_crypto.options[i].value == "aes") {
					wl_crypto.options[i].selected = true;
				}
			}
			//Tom.Hung 2012-11-23 end
		} else if (security_mode == "WPAPSKWPA2PSK") {
			document.radio.wl_akm_psk.value = "enabled";
			document.radio.wl_akm_psk2.value = "enabled";
			//Tom.Hung 2012-11-23, WPA-PSK mixed use tkip+aes in default
			var wl_crypto = document.radio.wl_crypto;
			for(i=0;i<wl_crypto.options.length;i++) {
				if(wl_crypto.options[i].value == "tkip+aes") {
					wl_crypto.options[i].selected = true;
				}
			}
			//Tom.Hung 2012-11-23 end
		}
		document.radio.wl_akm_brcm_psk.value = "disabled";
		document.radio.wl_preauth.value = "disabled";
		document.radio.wl_akm_wapi.value = "disabled";
		document.radio.wl_akm_wapi_psk.value = "disabled";
		document.radio.wl_wep.value = "disabled";
		document.getElementById("wep_field").style.display = "none";
		document.getElementById("wpa_field").style.display = "block";
		document.getElementById("psk_field").style.display = style_display_on_tr();
		document.getElementById("radius_field").style.display = "none";
	}
	else if (security_mode == "WPA" || security_mode == "WPA2" || security_mode == "WPA1WPA2") { //Enterprise
		document.radio.wl_auth.value = "0";
		document.radio.wl_auth_mode.value = "none";
		document.radio.wl_akm_psk.value = "disabled";
		document.radio.wl_akm_psk2.value = "disabled";
		if (security_mode == "WPA") {
			document.radio.wl_akm_wpa.value = "enabled";
			document.radio.wl_akm_wpa2.value = "disabled";
			//Tom.Hung 2012-11-23, WPA use tkip in default, and tkip+aes if n mode support.
			var wl_crypto = document.radio.wl_crypto;
			for(i=0;i<wl_crypto.options.length;i++) {
				if((wl_crypto.options[i].value == "tkip" && nmode_enabled == "0") ||
					(wl_crypto.options[i].value == "tkip+aes" && nmode_enabled == "1")) {
					wl_crypto.options[i].selected = true;
				}
			}
			//Tom.Hung 2012-11-23 end
		} else if (security_mode == "WPA2") {
			document.radio.wl_akm_wpa.value = "disabled";
			document.radio.wl_akm_wpa2.value = "enabled";
			//Tom.Hung 2012-11-23, WPA2 use aes in default
			var wl_crypto = document.radio.wl_crypto;
			for(i=0;i<wl_crypto.options.length;i++) {
				if(wl_crypto.options[i].value == "aes") {
					wl_crypto.options[i].selected = true;
				}
			}
			//Tom.Hung 2012-11-23 end
		} else if (security_mode == "WPA1WPA2") {
			document.radio.wl_akm_wpa.value = "enabled";
			document.radio.wl_akm_wpa2.value = "enabled";
			//Tom.Hung 2012-11-23, WPA-mixed use tkip+aes in default
			var wl_crypto = document.radio.wl_crypto;
			for(i=0;i<wl_crypto.options.length;i++) {
				if(wl_crypto.options[i].value == "tkip+aes") {
					wl_crypto.options[i].selected = true;
				}
			}
			//Tom.Hung 2012-11-23 end
		}
		document.radio.wl_akm_brcm_psk.value = "disabled";
		document.radio.wl_preauth.value = "disabled";
		document.radio.wl_akm_wapi.value = "disabled";
		document.radio.wl_akm_wapi_psk.value = "disabled";
		document.radio.wl_wep.value = "disabled";
		document.getElementById("wep_field").style.display = "none";
		document.getElementById("wpa_field").style.display = "block";
		document.getElementById("psk_field").style.display = "none";
		document.getElementById("radius_field").style.display = "block";
	}
	wl_auth_change();
	wl_auth_mode_change();
	wl_akm_change();
	wl_wep_change();
}

function load_security_mode()
{
	var wl_auth = "<% nvram_get("wl_auth"); %>"*1;
	var wl_wep = "<% nvram_match("wl_wep", "enabled", "1"); %>"*1;
	var wl_akm_wpa = "<% nvram_inlist("wl_akm", "wpa", "1"); %>"*1;
	var wl_akm_psk = "<% nvram_inlist("wl_akm", "psk", "1"); %>"*1;
	var wl_akm_wpa2 = "<% nvram_inlist("wl_akm", "wpa2", "1"); %>"*1;
	var wl_akm_psk2 = "<% nvram_inlist("wl_akm", "psk2", "1"); %>"*1;
	var security_mode = document.getElementById("security_mode");
	var mode;

	if(wl_auth == 0 && wl_wep == 0 && wl_akm_wpa == 0 && wl_akm_psk == 0 && wl_akm_wpa2 == 0 && wl_akm_psk2 == 0) {
		mode = "Disable";
	}
	else if(wl_auth == 0 && wl_wep == 1 && wl_akm_wpa == 0 && wl_akm_psk == 0 && wl_akm_wpa2 == 0 && wl_akm_psk2 == 0) {
		mode = "OPEN";
	}
	else if(wl_auth == 1 && wl_wep == 1 && wl_akm_wpa == 0 && wl_akm_psk == 0 && wl_akm_wpa2 == 0 && wl_akm_psk2 == 0) {
		mode = "SHARED";
	}
	else if(wl_auth == 0 && wl_wep == 0 && wl_akm_wpa == 1 && wl_akm_psk == 0 && wl_akm_wpa2 == 0 && wl_akm_psk2 == 0) {
		mode = "WPA";
	}
	else if(wl_auth == 0 && wl_wep == 0 && wl_akm_wpa == 0 && wl_akm_psk == 0 && wl_akm_wpa2 == 1 && wl_akm_psk2 == 0) {
		mode = "WPA2";
	}
	else if(wl_auth == 0 && wl_wep == 0 && wl_akm_wpa == 1 && wl_akm_psk == 0 && wl_akm_wpa2 == 1 && wl_akm_psk2 == 0) {
		mode = "WPA1WPA2";
	}
	else if(wl_auth == 0 && wl_wep == 0 && wl_akm_wpa == 0 && wl_akm_psk == 1 && wl_akm_wpa2 == 0 && wl_akm_psk2 == 0) {
		mode = "WPAPSK";
	}
	else if(wl_auth == 0 && wl_wep == 0 && wl_akm_wpa == 0 && wl_akm_psk == 0 && wl_akm_wpa2 == 0 && wl_akm_psk2 == 1) {
		mode = "WPA2PSK";
	}
	else if(wl_auth == 0 && wl_wep == 0 && wl_akm_wpa == 0 && wl_akm_psk == 1 && wl_akm_wpa2 == 0 && wl_akm_psk2 == 1) {
		mode = "WPAPSKWPA2PSK";
	}
	//Change select option
	for (var i = 0; i < security_mode.options.length; i++) {
		if (security_mode.options[i].value == mode) {
			security_mode.options[i].selected = true;
			break;
		}
	}
	change_security_mode();
}

function guest_enable_change()
{
	if(document.radio.guest_enable.checked == true)
		document.radio.wl_bss_enabled.value = "1";
	else
		document.radio.wl_bss_enabled.value = "0";
}

function guest_bridge_change()
{
	if(document.radio.guest_bridge.checked == true)
		document.radio.wl_bridge.value = "1";
	else
		document.radio.wl_bridge.value = "0";
}

function guest_isolate_change()
{
	if(document.radio.guest_isolate.checked == true)
		document.radio.wl_ap_isolate.value = "1";
	else
		document.radio.wl_ap_isolate.value = "0";
}

function apply_5g()
{
	totalWaitTime = 25;
	wait_page();
	document.getElementById("waitPad").style.display="block";
	scroll(0,0);
}

function page_load() {
	if (document.getElementById("wl_bssid").value == 0) {
		// SSID 1 always locked at LAN
		document.getElementById("wl_bridge").disabled = 1;
	}
	//Enabled
	if(document.radio.wl_bss_enabled.value == "1")
		document.radio.guest_enable.checked = true;
	else
		document.radio.guest_enable.checked = false;

	//Bridge
	if(document.radio.wl_bridge.value == "1")
		document.radio.guest_bridge.checked = true;
	else
		document.radio.guest_bridge.checked = false;

	//Isolate
	if(document.radio.wl_ap_isolate.value == "1")
		document.radio.guest_isolate.checked = true;
	else
		document.radio.guest_isolate.checked = false;

	//Security
	wl_security_update();
	load_security_mode();
	dyn_add_wlssid_sched_option();
	change_wlschedule();

	//Tom.Hung 2012-11-23, read current setting when page_load
	var crypto = "<% nvram_get("wl_crypto"); %>";
	var wl_crypto = document.radio.wl_crypto;
	for(i=0;i<wl_crypto.options.length;i++) {
		if(wl_crypto.options[i].value == crypto) {
			wl_crypto.options[i].selected = true;
		}
	}
	//Tom.Hung 2012-11-23
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
<h1><!--#tr id="guest.title"-->Guest Network<!--#endtr--></h1>
<div class="hr" ></div>
<p>
<!--#tr id="guest.desc"-->This page allows you to configure the Guest Network.<!--#endtr-->
</p>

<form name="radio" method="post" action="/basic/guestnetwork.asp" onsubmit="return checkValue();" target="rebootRedirect">
<input type="hidden" name="page" id="page" value="/redirect.asp?url=/basic/guestnetwork.asp%3Fwl_unit%3D0.3">
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
			<select name="wl_unit" onChange="submit();">
				<% wl_um_list(); %>
			</select>
		</td>
	</tr>
	<tr>
		<td class="CL"
		onMouseOver="return overlib('Selects desired BSS to configure.', LEFT);"
		onMouseOut="return nd();">
		<!--#tr id="wireless.name.ssid"-->Wireless Name (SSID)<!--#endtr-->
		</td>
		<td class="CR">
			<select name="wl_bssid" id="wl_bssid" onChange="submit();">
				<% wl_bssid_list(); %>
			</select>
		</td>
	</tr>
</table>
</div>

<table width="100%" class="tbl_main">
	<tr>
		<td class="CT" colspan="2"><!--#tr id="basic.guest.2.4g"-->2.4GHz Guest Network<!--#endtr--></td>
	</tr>
	<tr style="display:none">
		<td class="CL">
			<!--#tr id="wireless.interface"-->Wireless Interface<!--#endtr-->
		</td>
		<td class="CR">
			<select name="wl_unit" onChange="submit();">
			  <% wl_um_list(); %>
			</select>
		</td>
	</tr>
	<tr>
		<td class="CL"
		onMouseOver="return overlib('Enables or disables this SSID .', LEFT);"
		onMouseOut="return nd();">
		<!--#tr id="enabled"-->Enabled<!--#endtr-->
		</td>
		<td class="CR">
			<input type="checkbox" name="guest_enable" onChange="guest_enable_change();" onkeydown="return prevent_press_enter(event);">
			<select name="wl_bss_enabled" style="display:none">
				<option value="0" <% nvram_match("wl_bss_enabled", "0", "selected"); %>><!--#tr id="off"-->Off<!--#endtr--></option> 
				<option value="1" <% nvram_match("wl_bss_enabled", "1", "selected"); %>><!--#tr id="on"-->On<!--#endtr--></option>
			</select>
		</td>
	</tr>  
	<tr>
		<td class="CL"
		onMouseOver="return overlib('Sets the Network Name (also known as SSID) of this network.', LEFT);"
		onMouseOut="return nd();">
		<!--#tr id="wireless.name.ssid"-->Wireless Name (SSID)<!--#endtr-->
		</td>
		<td class="CR">
			<input name="wl_ssid" value="<% nvram_get("wl_ssid"); %>" size="32" maxlength="32" onkeydown="return prevent_press_enter(event);">
		</td>
	</tr>  
	<tr>
		<td class="CL"
		onMouseOver="return overlib('Selects desired Bridge br0 or br1 .', LEFT);"
		onMouseOut="return nd();">
		<!--#tr id="guest.2"-->Internet Access Only<!--#endtr-->
		</td>
		<td class="CR">
			<input type="checkbox" name="guest_bridge" onChange="guest_bridge_change();" onkeydown="return prevent_press_enter(event);">
			<select name="wl_bridge" id="wl_bridge" style="display:none">  <% wl_get_bridge(); %> </select>
			&nbsp;<!--#tr id="guest.5"-->(prevents guests from accessing the private LAN network)<!--#endtr-->
		</td>
	</tr>  
	<tr>
		<td class="CL"
		onMouseOver="return overlib('Selecting <b>On</b> enables AP isolation mode.  When enabled, STAs associated to the AP will not be able to communicate with each other.', LEFT);"
		onMouseOut="return nd();">
		<!--#tr id="guest.4"-->Wireless Client Isolation<!--#endtr-->
		</td>
		<td class="CR">
			<input type="checkbox" name="guest_isolate" onChange="guest_isolate_change();" onkeydown="return prevent_press_enter(event);">
			<select name="wl_ap_isolate" style="display:none">
				<option value="0" <% nvram_match("wl_ap_isolate", "0", "selected"); %>><!--#tr id="off"-->Off<!--#endtr--></option>
				<option value="1" <% nvram_match("wl_ap_isolate", "1", "selected"); %>><!--#tr id="on"-->On<!--#endtr--></option>
			</select>
			&nbsp;<!--#tr id="guest.6"-->(isolate guests from each other)<!--#endtr-->
		</td>
	</tr>
	<tr>
		<td class="CL"><!--#tr id="schedule"-->Schedule<!--#endtr--></td>
		<td class="CR">
			<select name="wl_schedule" id="wl_schedule">
				<option value="0" selected><!--#tr id="always"-->Always<!--#endtr--></option>
			</select>
			<input type="button" value="<!--#tr id="new.schedule"-->Add New<!--#endtr-->" onclick="open_schedule()">
		</td>
	</tr>
</table>

<!--
#ifdef BCMWPS
-->
<input type="hidden" name="wl_wps_mode" value="<% nvram_get("wl_wps_mode"); %>">
<!--
#endif
-->

<table width="100%" class="tbl_main">
	<tr>
		<td class="CT" colspan="2"><!--#tr id="security.35"-->Security Policy<!--#endtr--></td>
	</tr>
	<tr>
		<td class="CL"><!--#tr id="security.mode" -->Security Mode<!--#endtr --></td>
		<td class="CR">
			<select name="security_mode" id="security_mode" onchange="change_security_mode()">
				<option value="Disable"><!--#tr id="disable" -->Disable<!--#endtr --></option>
<script>
var wl_nmode = <% wl_nmode_enabled(); %>;
if(wl_nmode == "0") {
	document.write("<option value=\"OPEN\">WEP-OPEN</option>");
	document.write("<option value=\"SHARED\">WEP-SHARED</option>");
}
</script>
				<option value="WPA"><!--#tr id="security.37"-->WPA<!--#endtr--></option>
				<option value="WPAPSK"><!--#tr id="security.5"-->WPA-PSK<!--#endtr--></option>
				<option value="WPA2PSK"><!--#tr id="security.7"-->WPA2-PSK<!--#endtr--></option>
				<option value="WPAPSKWPA2PSK"><!--#tr id="security.42"-->WPA2-PSK Mixed<!--#endtr--></option>
				<option value="WPA2"><!--#tr id="security.6"-->WPA2<!--#endtr--></option>
				<option value="WPA1WPA2"><!--#tr id="security.43"-->WPA2 Mixed<!--#endtr--></option>
			</select>
		</td>
	</tr>
</table>

<div style="display:none">
<table width="100%" class="tbl_main">
  <tr>
    <td class="CL"
	onMouseOver="return overlib('Selects 802.11 authentication method. Open or Shared.', LEFT);"
	onMouseOut="return nd();">
	<!--#tr id="security.2"-->802.11 Authentication<!--#endtr-->
    </td>
    <td class="CR">
	<select name="wl_auth" onChange="wl_auth_change();">
	  <% wl_auth_display(); %>
	</select>
    </td>
  </tr>
  <tr>
    <td class="CL"
	onMouseOver="return overlib('Selects Network authentication type.', LEFT);"
	onMouseOut="return nd();">
	<!--#tr id="security.3"-->802.1X Authentication<!--#endtr-->
    </td>
    <td class="CR">
	<select name="wl_auth_mode" onChange="wl_auth_mode_change();">
	  <option value="radius" <% nvram_match("wl_auth_mode", "radius", "selected"); %>><!--#tr id="enabled"-->Enabled<!--#endtr--></option>
	  <option value="none" <% nvram_invmatch("wl_auth_mode", "radius", "selected"); %>><!--#tr id="disabled"-->Disabled<!--#endtr--></option>
 	</select>
    </td>
  </tr>
  <tr>
    <td class="CL"
	onMouseOver="return overlib('Enables or disables WEP data encryption. Selecting <b>Enabled</b> enables WEP data encryption and requires that a valid network key be set and selected unless <b>802.1X</b> is enabled.', LEFT);"
	onMouseOut="return nd();">
	<!--#tr id="security.12"-->WEP Encryption<!--#endtr-->
    </td>
    <td class="CR">
	<select name="wl_wep" onChange="wl_wep_change();">
	  <option value="enabled" <% nvram_match("wl_wep", "enabled", "selected"); %>><!--#tr id="enabled"-->Enabled<!--#endtr--></option>
	  <option value="disabled" <% nvram_invmatch("wl_wep", "enabled", "selected"); %>><!--#tr id="disabled"-->Disabled<!--#endtr--></option>
 	</select>
    </td>
  </tr>
  <tr>
    <td class="CL"
	onMouseOver="return overlib('Enables/Disables WPA Authenticated Key Management suite.', LEFT);"
	onMouseOut="return nd();">
	<input type="hidden" name="wl_akm" value="">
	<!--#tr id="security.4"-->WPA<!--#endtr-->
    </td>
    <td class="CR">
	<select name="wl_akm_wpa" onChange="wl_akm_change();">
	  <option value="enabled" <% nvram_inlist("wl_akm", "wpa", "selected"); %>><!--#tr id="enabled"-->Enabled<!--#endtr--></option>
	  <option value="disabled" <% nvram_invinlist("wl_akm", "wpa", "selected"); %>><!--#tr id="disabled"-->Disabled<!--#endtr--></option>
	</select>
    </td>
  </tr>
  <tr>
    <td class="CL"
	onMouseOver="return overlib('Enables/Disables WPA-PSK Authenticated Key Management suite.', LEFT);"
	onMouseOut="return nd();">

	<!--#tr id="security.5"-->WPA-PSK<!--#endtr-->
    </td>
    <td class="CR">
	<select name="wl_akm_psk" onChange="wl_akm_change();">
	  <option value="enabled" <% nvram_inlist("wl_akm", "psk", "selected"); %>><!--#tr id="enabled"-->Enabled<!--#endtr--></option>
	  <option value="disabled" <% nvram_invinlist("wl_akm", "psk", "selected"); %>><!--#tr id="disabled"-->Disabled<!--#endtr--></option>
	</select>
    </td>
  </tr>
  <tr>
    <td class="CL"
	onMouseOver="return overlib('Enables/Disables WPA2 Authenticated Key Management suite.', LEFT);"
	onMouseOut="return nd();">
	<!--#tr id="security.6"-->WPA2<!--#endtr-->
    </td>
    <td class="CR">
	<select name="wl_akm_wpa2" onChange="wl_akm_change();">
	  <option value="enabled" <% nvram_inlist("wl_akm", "wpa2", "selected"); %>><!--#tr id="enabled"-->Enabled<!--#endtr--></option>
	  <option value="disabled" <% nvram_invinlist("wl_akm", "wpa2", "selected"); %>><!--#tr id="disabled"-->Disabled<!--#endtr--></option>
	</select>
    </td>
  </tr>
  <tr>
    <td class="CL"
	onMouseOver="return overlib('Enables/Disables WPA2-PSK Authenticated Key Management suite.', LEFT);"
	onMouseOut="return nd();">
	<!--#tr id="security.7"-->WPA2-PSK<!--#endtr-->
    </td>
    <td class="CR">
	<select name="wl_akm_psk2" onChange="wl_akm_change();">
	  <option value="enabled" <% nvram_inlist("wl_akm", "psk2", "selected"); %>><!--#tr id="enabled"-->Enabled<!--#endtr--></option>
	  <option value="disabled" <% nvram_invinlist("wl_akm", "psk2", "selected"); %>><!--#tr id="disabled"-->Disabled<!--#endtr--></option>
	</select>
    </td>
  </tr>
  <tr>
    <td class="CL"
	onMouseOver="return overlib('Enables/Disables BRCM-PSK Authenticated Key Management suite.', LEFT);"
	onMouseOut="return nd();">
	<!--#tr id="security.8"-->BRCM-PSK<!--#endtr-->
    </td>
    <td class="CR">
	<select name="wl_akm_brcm_psk" onChange="wl_akm_change();">
	  <option value="enabled" <% nvram_inlist("wl_akm", "brcm_psk", "selected"); %>><!--#tr id="enabled"-->Enabled<!--#endtr--></option>
	  <option value="disabled" <% nvram_invinlist("wl_akm", "brcm_psk", "selected"); %>><!--#tr id="disabled"-->Disabled<!--#endtr--></option>
	</select>
    </td>
  </tr>
  <tr>
    <td class="CL"><!--#tr id="security.9"-->WPA2 Preauthentication<!--#endtr--></td>
    <td class="CR">
	<select name="wl_preauth">
	  <option value="disabled" <% nvram_match("wl_preauth", "0", "selected"); %>><!--#tr id="disabled"-->Disabled<!--#endtr--></option>
	  <option value="enabled" <% nvram_invmatch("wl_preauth", "0", "selected"); %>><!--#tr id="enabled"-->Enabled<!--#endtr--></option>
 	</select>
    </td>
  </tr>
<!--
#ifdef BCMWAPI_WAI
-->
  <input type="hidden" name="wl_wai_cert_index" value="<% nvram_get("wl_wai_cert_index"); %>">
  <input type="hidden" name="wl_wai_cert_status" value="<% nvram_get("wl_wai_cert_status"); %>">
  <tr>
    <td class="CL"
	onMouseOver="return overlib('Enables/Disables WAPI Authenticated Key Management suite.', LEFT);"
	onMouseOut="return nd();">
	<!--#tr id="security.10"-->WAPI<!--#endtr-->
    </td>
    <td class="CR">
	<select name="wl_akm_wapi" onChange="wl_akm_change();">
	  <option value="enabled" <% nvram_inlist("wl_akm", "wapi", "selected"); %>><!--#tr id="enabled"-->Enabled<!--#endtr--></option>
	  <option value="disabled" <% nvram_invinlist("wl_akm", "wapi", "selected"); %>><!--#tr id="disabled"-->Disabled<!--#endtr--></option>
	</select>
    </td>
  </tr>
  <tr class="CR">
    <td class="CL"
	onMouseOver="return overlib('Enables/Disables WAPI-PSK Authenticated Key Management suite.', LEFT);"
	onMouseOut="return nd();">
	<!--#tr id="security.11"-->WAPI-PSK<!--#endtr-->
    </td>
    <td class="CR">
	<select name="wl_akm_wapi_psk" onChange="wl_akm_change();">
	  <option value="enabled" <% nvram_inlist("wl_akm", "wapi_psk", "selected"); %>><!--#tr id="enabled"-->Enabled<!--#endtr--></option>
	  <option value="disabled" <% nvram_invinlist("wl_akm", "wapi_psk", "selected"); %>><!--#tr id="disabled"-->Disabled<!--#endtr--></option>

	</select>
    </td>
  </tr>
<!--
#endif
-->
</table>
</div>

<div id="wep_field" style="display:none">
<table width="100%" class="tbl_main">
	<tr>
		<td class="CT" colspan="2"><!--#tr id="security.36"-->WEP<!--#endtr--></td>
	</tr>
	<tr>
		<td class="CL"
		onMouseOver="return overlib('Selects which network key is used for encrypting outbound data and/or authenticating clients.', LEFT);"
		onMouseOut="return nd();">
		<!--#tr id="security.21"-->Current Network Key<!--#endtr-->
		</td>
		<td class="CR">
			<select name="wl_key">
				<option value="1" <% nvram_match("wl_key", "1", "selected"); %>>1</option>
				<option value="2" <% nvram_match("wl_key", "2", "selected"); %>>2</option>
				<option value="3" <% nvram_match("wl_key", "3", "selected"); %>>3</option>
				<option value="4" <% nvram_match("wl_key", "4", "selected"); %>>4</option>
			</select>
		</td>
	</tr>
	<tr>
		<td class="CL"
		onMouseOver="return overlib('Enter 5 ASCII characters or 10 hexadecimal digits for a 64-bit key. Enter 13 ASCII characters or 26 hexadecimal digits for a 128-bit key.', LEFT);"
		onMouseOut="return nd();">
		<!--#tr id="security.20"-->Network Key<!--#endtr--> 1
		</td>
		<td class="CR">
			<input id="networkKey0" name="wl_key1" value="<% nvram_get("wl_key1"); %>" size="26" maxlength="26" type="password" onkeydown="return prevent_press_enter(event);">
			<A HREF="javascript:wep_window(1)"><!--#tr id="clicktodispay"-->Click here to display<!--#endtr--></A>
		</td>
	</tr>
	<tr>
		<td class="CL"
		onMouseOver="return overlib('Enter 5 ASCII characters or 10 hexadecimal digits for a 64-bit key. Enter 13 ASCII characters or 26 hexadecimal digits for a 128-bit key.', LEFT);"
		onMouseOut="return nd();">
		<!--#tr id="security.20"-->Network Key<!--#endtr--> 2
		</td>
		<td class="CR">
			<input id="networkKey1" name="wl_key2" value="<% nvram_get("wl_key2"); %>" size="26" maxlength="26" type="password" onkeydown="return prevent_press_enter(event);">
			<A HREF="javascript:wep_window(2)"><!--#tr id="clicktodispay"-->Click here to display<!--#endtr--></A>
		</td>
	</tr>
	<tr>
		<td class="CL"
		onMouseOver="return overlib('Enter 5 ASCII characters or 10 hexadecimal digits for a 64-bit key. Enter 13 ASCII characters or 26 hexadecimal digits for a 128-bit key.', LEFT);"
		onMouseOut="return nd();">
		<!--#tr id="security.20"-->Network Key<!--#endtr--> 3
		</td>
		<td class="CR">
			<input id="networkKey2" name="wl_key3" value="<% nvram_get("wl_key3"); %>" size="26" maxlength="26" type="password" onkeydown="return prevent_press_enter(event);">
			<A HREF="javascript:wep_window(3)"><!--#tr id="clicktodispay"-->Click here to display<!--#endtr--></A>
		</td>
	</tr>
	<tr>
		<td class="CL"
		onMouseOver="return overlib('Enter 5 ASCII characters or 10 hexadecimal digits for a 64-bit key. Enter 13 ASCII characters or 26 hexadecimal digits for a 128-bit key.', LEFT);"
		onMouseOut="return nd();">
		<!--#tr id="security.20"-->Network Key<!--#endtr--> 4
		</td>
		<td class="CR">
			<input id="networkKey3" name="wl_key4" value="<% nvram_get("wl_key4"); %>" size="26" maxlength="26" type="password" onkeydown="return prevent_press_enter(event);">
			<A HREF="javascript:wep_window(4)"><!--#tr id="clicktodispay"-->Click here to display<!--#endtr--></A>
		</td>
	</tr>
</table>
</div>

<div id="wpa_field" style="display:none">
<table width="100%" class="tbl_main">
	<tr>
		<td class="CT" colspan="2"><!--#tr id="security.37"-->WPA<!--#endtr--></td>
	</tr>
	<tr>
		<td class="CL"
		onMouseOver="return overlib('Selects the WPA data encryption algorithm.', LEFT);"
		onMouseOut="return nd();">
<!--
#ifdef BCMWAPI_WAI
-->
			<div id="wl_wapi_encrypt_div">
			<!--#tr id="security.38"-->WAPI Encryption<!--#endtr-->
			</div>
<!--
#endif
-->
			<div id="wl_wpa_encrypt_div">
			<!--#tr id="security.13"-->WPA Encryption<!--#endtr-->
			</div>
		</td>
		<td class="CR">
			<select name="wl_crypto">
				<option value="tkip" <% nvram_match("wl_crypto", "tkip", "selected"); %>>TKIP</option>
				<option value="aes" <% nvram_match("wl_crypto", "aes", "selected"); %>>AES</option>
				<option value="tkip+aes" <% nvram_match("wl_crypto", "tkip+aes", "selected"); %>>TKIP+AES</option>
<!--
#ifdef BCMWAPI_WAI
-->
				<option value="sms4" <% nvram_match("wl_crypto", "sms4", "selected"); %> style="display:none">SMS4</option>
<!--
#endif
-->
			</select>
		</td>
	</tr>
	<tr id="psk_field">
		<td class="CL"
		onMouseOver="return overlib('Sets the WPA passphrase.', LEFT);"
		onMouseOut="return nd();">
<!--
#ifdef BCMWAPI_WAI
-->
			<div id="wl_wapi_psk_div">
			<!--#tr id="security.39"-->WAPI passphrase<!--#endtr-->
			</div>
<!--
#endif
-->
			<div id="wl_wpa_psk_div">
			<!--#tr id="security.19"-->WPA passphrase<!--#endtr-->
			</div>
	    </td>
		<td class="CR">
			<input id="wpaPassphrase" name="wl_wpa_psk" value="<% nvram_get("wl_wpa_psk"); %>" type="password" onkeydown="return prevent_press_enter(event);">
			<A HREF="javascript:wpapsk_window()"><!--#tr id="clicktodispay"-->Click here to display<!--#endtr--></A>
		</td>
	</tr>
	<tr>
		<td class="CL"
		onMouseOver="return overlib('Sets the Network Key Rotation interval in seconds. Leave blank or set to zero to disable the rotation.', LEFT);"
		onMouseOut="return nd();">
		<!--#tr id="security.22"-->Network Key Rotation Interval<!--#endtr-->
		</td>
		<td class="CR">
			<input id="rotationInterval" name="wl_wpa_gtk_rekey" value="<% nvram_get("wl_wpa_gtk_rekey"); %>" size="10" maxlength="10" onkeydown="return prevent_press_enter(event);">&nbsp;<!--#tr id="lan.11"-->(seconds)<!--#endtr-->
		</td>
	</tr>
</table>
</div>

<!--
#ifdef BCMWAPI_WAI
-->
<div id="radius_field" style="display:none">
<table width="100%" class="tbl_main">
	<tr>
		<td class="CT" colspan="2"><!--#tr id="security.40"-->Radius Server<!--#endtr--></td>
	</tr>
	<tr>
		<td class="CL"
		onMouseOver="return overlib('Sets the IP address of the RADIUS server to use for authentication and dynamic key derivation.', LEFT);"
		onMouseOut="return nd();">
		<!--#tr id="security.16"-->RADIUS Server<!--#endtr-->
		</td>
		<td class="CR">
			<input id="radiusServer" name="wl_radius_ipaddr" value="<% nvram_get("wl_radius_ipaddr"); %>" size="15" maxlength="15" onkeydown="return prevent_press_enter(event);">
		</td>
	</tr>
	<tr>
		<td class="CL"
		onMouseOver="return overlib('Sets the UDP port number of the RADIUS server. The port number is usually 1812 or 1645 and depends upon the server.', LEFT);"
		onMouseOut="return nd();">
		<!--#tr id="security.17"-->RADIUS Port<!--#endtr-->
		</td>
		<td class="CR">
			<input id="radiusPort" name="wl_radius_port" value="<% nvram_get("wl_radius_port"); %>" size="5" maxlength="5" onkeydown="return prevent_press_enter(event);">
		</td>
	</tr>
	<tr>
		<td class="CL"
		onMouseOver="return overlib('Sets the shared secret for the RADIUS connection.', LEFT);"
		onMouseOut="return nd();">
		<!--#tr id="security.18"-->RADIUS Key<!--#endtr-->
		</td>
		<td class="CR">
			<input name="wl_radius_key" maxlength="255" value="<% nvram_get("wl_radius_key"); %>" type="password" onkeydown="return prevent_press_enter(event);">
		</td>
	</tr>
</table>
</div>

<div style="display:none">
<table width="100%" class="tbl_main">
	<tr>
		<td class="CL"
		onMouseOver="return overlib('Sets the IP address of the WAPI AS server to use for authentication and dynamic key derivation.', LEFT);"
		onMouseOut="return nd();">
		<!--#tr id="security.14"-->WAPI AS Server<!--#endtr-->
		</td>
		<td class="CR">
			<input id="wapiAsServer" name="wl_wai_as_ip" value="<% nvram_get("wl_wai_as_ip"); %>" size="15" maxlength="15" onkeydown="return prevent_press_enter(event);">
		</td>
	</tr>
	<tr>
		<td class="CL"
		onMouseOver="return overlib('Sets the UDP port number of the WAPI AS server. The port number is usually 3810 and depends upon the server.', LEFT);"
		onMouseOut="return nd();">
		<!--#tr id="security.15"-->WAPI AS Port<!--#endtr-->
		</td>
		<td class="CR">
			<input id="wapiAsPort" name="wl_wai_as_port" value="<% nvram_get("wl_wai_as_port"); %>" size="5" maxlength="5" onkeydown="return prevent_press_enter(event);">
		</td>
	</tr>
</table>
</div>
<!--
#endif
-->

<div style="display:none">
<table width="100%" class="tbl_main">
<!--
#ifdef BCMWAPI_WAI
-->
  <tr>
    <td class="CL"
	onMouseOver="return overlib('Sets the Station unicast rekeying interval in seconds. Leave blank or set to zero to disable the rekeying.', LEFT);"
	onMouseOut="return nd();">
	<!--#tr id="security.23"-->WAPI Unicast Rekeying Interval<!--#endtr-->
    </td>
    <td class="CR"><input id="unicastRekeyingInterval" name="wl_wai_uck_rekey" value="<% nvram_get("wl_wai_uck_rekey"); %>" size="10" maxlength="10"></td>
  </tr>
  <tr>
    <td class="CL"
	onMouseOver="return overlib('Sets the Station multicast rekeying interval in seconds. Leave blank or set to zero to disable the rekeying.', LEFT);"
	onMouseOut="return nd();">
	<!--#tr id="security.24"-->WAPI Multicast Rekeying Interval<!--#endtr-->
    </td>
    <td class="CR"><input id="multicastRekeyingInterval" name="wl_wai_mck_rekey" value="<% nvram_get("wl_wai_mck_rekey"); %>" size="10" maxlength="10" onkeydown="return prevent_press_enter(event);"></td>
  </tr>
<!--
#endif
-->
</table>
</div>

<div style="display:none">
<table width="100%" class="tbl_main">
  <tr>
    <td class="CL"
	onMouseOver="return overlib('Sets the Network Re-authentication interval in seconds. Leave blank or set to zero to disable periodic network re-authentication.', LEFT);"
	onMouseOut="return nd();">
	<!--#tr id="security.25"-->Network Re-auth Interval<!--#endtr-->
    </td>
    <td class="CR"><input id= "reauthInterval" name="wl_net_reauth" value="<% nvram_get("wl_net_reauth"); %>" size="10" maxlength="10" onkeydown="return prevent_press_enter(event);"></td>
  </tr>
</table>
</div>

<!--
#ifdef BCMDBG
-->

<div style="display:none">
<table width="100%" class="tbl_main">
  <tr>
    <td class="CL"
	onMouseOver="return overlib('Enables/Disables NAS debugging. 0:Disable | 1:Enable.', LEFT);"
	onMouseOut="return nd();">
	<!--#tr id="security.26"-->NAS debugging<!--#endtr-->
    </td>
    <td class="CR"><input name="wl_nas_dbg" value="<% nvram_get("wl_nas_dbg"); %>" size="10" maxlength="10"></td>
  </tr>
</table>
</div>

<!--
#endif
-->

<a href="guest_lan.asp" style="text-decoration: underline;"><!--#tr id="guest.7"-->Advanced Guest Network Settings<!--#endtr--></a>

<table width="100%" class="tbl_main">
	<tr align="center">
		<td>
			<input type="submit" class="<!--#tr id="buttonWidth"-->button1<!--#endtr-->" name="action" value="<!--#tr id="apply"-->Apply<!--#endtr-->">
			<input type="reset" class="button1" name="action" value="<!--#tr id="cancel"-->Cancel<!--#endtr-->">
		</td>
	</tr>
</table>
</form>

<iframe name="frame5" id="frame5" frameborder="0" width="100%" height="200" scrolling="no" allowTransparency="true" src="/basic/guestnetwork5.asp?wl_unit=1.3" style="background:none; background-color:rgba(0,0,0,0);">redirect</iframe>


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
