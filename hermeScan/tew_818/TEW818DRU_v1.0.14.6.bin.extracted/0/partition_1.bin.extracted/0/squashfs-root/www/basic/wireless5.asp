<%@LANGUAGE="VBSCRIPT" CODEPAGE="950"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" style="background:none; background-color:transparent;">
<head>
<meta http-equiv="content-type" content="text/html; charset=utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE8"/>
<title>TRENDnet | TEW-818DRU | <!--#tr id="project.desc"-->AC1900 Dual Band Wireless Router<!--#endtr--></title>
<link href="../style/style.css" rel="stylesheet" type="text/css" media="screen" />
<link href="../style/frame.css" rel="stylesheet" type="text/css" media="screen" />
<script type="text/javascript" src="../scripts/jquery.min.js"></script>
<script type="text/javascript" src="../scripts/ddaccordion.js"></script>
<script type="text/javascript" src="../scripts/um.js?20120904<% nvram_get("Language"); %>"></script>
<script type="text/javascript" src="../scripts/func.js?20120904<% nvram_get("Language"); %>"></script>
<script type="text/javascript" src="../scripts/overlib.js"></script>
<script type="text/javascript" src="../scripts/wlssid_schedule.js"></script>
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
	if(noValue == "um_wps_wep_change_display" ) {
		document.radio.wl_wep.selectedIndex = 1;
	}
	else if(noValue == "wps_closed_check_display" )
		document.forms[0].wl_closed.value = "0";
}

function confirmYesCheck(yesValue) {
	var crypto = document.radio.wl_crypto[document.radio.wl_crypto.selectedIndex].value;
	var tkip_str = "<!--#tr id="security.alert.10"-->WPS does not support TKIP only WPA encryption. Configure this setting to TKIP only WPA encryption will automatically disable WPS.<!--#endtr-->";
	
	if (yesValue == "um_wps_wep_change_display" )
		document.radio.wl_wps_mode.value = "disabled";
	else if (yesValue == "OPEN_security")
		do_submit();
	else if (yesValue == "Shared_mode")
		do_submit();		
	else if (yesValue == "akm_psk2") {
		if (crypto == "tkip")
			Confirm.render(tkip_str,"confirmYesCheck","akm_tkip","","");
		else 
			do_submit();
	}
	else if (yesValue == "akm_tkip")
		do_submit();
	else if (yesValue == "wep_enable")
		do_submit();
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

function applyCheck()
{
	var re3 = /^[\w\~\`\!\@\#\$\%\^\&\*\(\)\_\+\-\=\\\|\[\{\]\}\;\:\'\"\/\?\.\>\,\<\ ]+$/;
	
	//Tom.Hung 2009-2-12, SSID can't include invalid characters.
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

		var radiusKeyElement = document.getElementById("radiusKey");
		if (!radiusKeyElement.disabled && isBlankString(radiusKeyElement.value))
		{
			radiusKeyElement.focus();
			Alert.render("<!--#tr id="security.alert.14"-->Invalid radius key.<!--#endtr-->");
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
    
    // 8. Check Mac address
    for (var i = 0; i < 48; i++)
    {
        var macAddressElement = document.getElementById("macAddressInput" + i);
        if (!isBlankString(macAddressElement.value) && !checkMac(macAddressElement.value)) 
        {
            macAddressElement.focus();
            Alert.render("<!--#tr id="mac.address.error"-->Invalid MAC address! Please enter a valid MAC address.<!--#endtr-->");
            return false;
        }
    }

	return true;
	
	//totalWaitTime = 25;
	//wait_page();
	//document.getElementById("waitPad").style.display="block";
	//scroll(0,0);
	//window.parent.apply_5g();
	//document.getElementById("radio").submit();
}

function do_submit()
{
	window.parent.apply_5g();
	document.getElementById("radio").submit();
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

function check_submit()
{
	if(applyCheck() == false) {
		return false;
	}
	else {
		pre_submit();
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
	resize();
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

function wl_basic_rateset_change()
{
	var phytype = document.radio.wl_phytype[document.radio.wl_phytype.selectedIndex].value;
	var i, cur, defrs;

	/* Define new rateset */
	if (phytype == "a")
		defrs = new Array("Default", "All");
	else
		defrs = new Array("Default", "All", "12");

	/* Save current rateset */
	for (i = 0; i < document.radio.wl_rateset.length; i++) {
		if (document.radio.wl_rateset[i].selected) {
			cur = document.radio.wl_rateset[i].value;
			break;
		}
	}

	/* Reconstruct rateset array from new rateset */
	document.radio.wl_rateset.length = defrs.length;
	for (var i in defrs) {
		if (defrs[i].toLowerCase() == "12")
			document.radio.wl_rateset[i] = new Option("1 & 2 Mbps", defrs[i].toLowerCase());
		else
			document.radio.wl_rateset[i] = new Option(defrs[i], defrs[i].toLowerCase());
		document.radio.wl_rateset[i].value = defrs[i].toLowerCase();
		if (defrs[i].toLowerCase() == cur)
			document.radio.wl_rateset[i].selected = true;
	}
}

function wl_rate_change()
{
 	var nphy_set = "<% wl_nphy_set(); %>";
	var phytype;
	var gmode = document.radio.wl_gmode[document.radio.wl_gmode.selectedIndex].value;
	var country = document.radio.wl_country_code[document.radio.wl_country_code.selectedIndex].value;
	var chanspec;
	var channel;
	var band;
	var i, cur, mcur, rates, rate;
	var radioid;
	var nmode;

	if (nphy_set == "1") {
		phytype = "n";
		band = document.radio.wl_nband[document.radio.wl_nband.selectedIndex].value;
		nmode = document.radio.wl_nmode[document.radio.wl_nmode.selectedIndex].value;
	} else {
		phytype =  document.radio.wl_phytype[document.radio.wl_phytype.selectedIndex].value;
		nmode = "0";
	}
	/* Save current rate */
	for (i = 0; i < document.radio.wl_rate.length; i++) {
		if (document.radio.wl_rate[i].selected) {
			cur = document.radio.wl_rate[i].value;
			break;
		}
	}

	if (document.radio.wl_chanspec.length > 0)
		chanspec = document.radio.wl_chanspec[document.radio.wl_chanspec.selectedIndex].value;
	else
		chanspec = 0;


	/* Save current mcast rate */
	for (i = 0; i < document.radio.wl_mrate.length; i++) {
		if (document.radio.wl_mrate[i].selected) {
			mcur = document.radio.wl_mrate[i].value;
			break;
		}
	}

	/* Define new rates */
	if (phytype == "b") {
		/* XXX BCM2051/BCM2053 cannot transmit at 5.5 and 11 Mbps in Japan on channel 14 */
		radioid = "<% wl_radioid("b"); %>";
		if (radioid != "BCM2050" && country == "JP" && chanspec == "14")
			rates = new Array(0, 1, 2);
		else
			rates = new Array(0, 1, 2, 5.5, 11);
	} else if (phytype == "g") {
		/* Japan does not allow OFDM rates on channel 14 */
		if ((country == "JP" && chanspec == "14") || gmode == "0")
			rates = new Array(0, 1, 2, 5.5, 11);
		else
			rates = new Array(0, 1, 2, 5.5, 6, 9, 11, 12, 18, 24, 36, 48, 54);
	} else if (phytype == "a") {
		rates = new Array(0, 6, 9, 12, 18, 24, 36, 48, 54);
	} else if (phytype == "n") {
		/* Exclude auto for unicast legacy rates */
		/* 5 Ghz */
		if (band == "1") {
			rates = new Array(6, 9, 12, 18, 24, 36, 48, 54);
		} else if (band == "2") {
			/* Japan does not allow OFDM rates on channel 14 */
			if (country == "JP" && chanspec == "14")
				rates = new Array(1, 2, 5.5, 11);
			else	
				rates = new Array(1, 2, 5.5, 6, 9, 11, 12, 18, 24, 36, 48, 54);
		}
		/* Add auto back if nmode is disabled */
		if (nmode == "0")
			rates.unshift(0);
		if (<% nvram_get("wl_rate"); %> == 0)
			cur = 0;
	} else
		return;

	/* Reconstruct rate array from new rates */
	document.radio.wl_rate.length = rates.length;
	for (var i in rates) {
		rate = rates[i] * 1000000;
		if (rates[i] == 0)
			document.radio.wl_rate[i] = new Option("<!--#tr id="auto"-->Auto<!--#endtr-->", rate);
		else
			document.radio.wl_rate[i] = new Option(rates[i] + " Mbps", rate);
		document.radio.wl_rate[i].value = rate;
		if (rate == cur)
			document.radio.wl_rate[i].selected = true;
	}

	/* Add auto for multicast. Unshift adds element to the beginning! */
	if (phytype == "n" && nmode != "0")
		rates.unshift(0);

	/* Reconstruct multicast rate array from new rates */
	document.radio.wl_mrate.length = rates.length;
	for (var i in rates) {
		rate = rates[i] * 1000000;
		if (rates[i] == 0)
			document.radio.wl_mrate[i] = new Option("<!--#tr id="auto"-->Auto<!--#endtr-->", rate);
		else
			document.radio.wl_mrate[i] = new Option(rates[i] + " Mbps", rate);
		document.radio.wl_mrate[i].value = rate;
		if (rate == mcur)
			document.radio.wl_mrate[i].selected = true;
	}
}

function wl_country_list_change(nphy_set)
{
	var phytype;
	var band;
	var cur = 0;
	var sel = 0;

	if (nphy_set == "1") {
		phytype = "n";
		band  = document.radio.wl_nband[document.radio.wl_nband.selectedIndex].value;
	} else
		phytype =  document.radio.wl_phytype[document.radio.wl_phytype.selectedIndex].value;

	/* Save current country */
	for (i = 0; i < document.radio.wl_country_code.length; i++) {
		if (document.radio.wl_country_code[i].selected) {
			cur = document.radio.wl_country_code[i].value;
			break;
		}
	}

	if (phytype == "a") {
		<% wl_um_country_list("a"); %>
	} else if (phytype == "n") {
		if (band == "1") {
			<% wl_um_country_list("n", 1); %>
		} else if (band == "2") {
			<% wl_um_country_list("n", 2); %>
		}
	} else {
		<% wl_um_country_list("b"); %>
	}

	/* Reconstruct country_code array from new countries */
	document.radio.wl_country_code.length = countries.length;
	for (var i in countries) {
		document.radio.wl_country_code[i].value = countries[i];
		if (countries[i] == cur) {
			document.radio.wl_country_code[i].selected = true;
			sel = 1;
		}
	}

	if (sel == 0)
		document.radio.wl_country_code[0].selected = true;
}

function wl_country_rev_list_change(nphy_set)
{
	var phytype;
	var band;
	var country = document.radio.wl_country_code[document.radio.wl_country_code.selectedIndex].value;
	var country_revs = new Array(0);
	var cur = 0;
	var sel = 0;

	if (nphy_set == "1") {
		phytype = "n";
		band  = document.radio.wl_nband[document.radio.wl_nband.selectedIndex].value;
	} else
		phytype =  document.radio.wl_phytype[document.radio.wl_phytype.selectedIndex].value;

	/* Save current country_rev */
	for (i = 0; i < document.radio.wl_country_rev.length; i++) {
		if (document.radio.wl_country_rev[i].selected) {
			cur = document.radio.wl_country_rev[i].value;
			break;
		}
	}

	if (phytype == "a") {
		<% wl_um_country_rev_list("a"); %>
	} else if (phytype == "n") {
		if (band == "1") {
			<% wl_um_country_rev_list("n", 1); %>
		} else if (band == "2") {
			<% wl_um_country_rev_list("n", 2); %>
		}
	} else {
		<% wl_um_country_rev_list("b"); %>
	}

	/* Reconstruct country_rev array from new selected */
	document.radio.wl_country_rev.length = country_revs.length;
	for (var i in country_revs) {
		document.radio.wl_country_rev[i] = new Option(country_revs[i], country_revs[i]);
		document.radio.wl_country_rev[i].value = country_revs[i];
		if (country_revs[i] == cur) {
			document.radio.wl_country_rev[i].selected = true;
			sel = 1;
		}
	}

	if (sel == 0)
		document.radio.wl_country_rev[0].selected = true;

}

//Tom.Hung 2012-11-6, Sort option list
function each(object, callback) { 
    if (undefined === object.length) { 
        for ( var name in object) { 
            if (false === callback(object[name], name, object)) 
                break; 
        } 
    } else { 
        for ( var i = 0, len = object.length; i < len; i++) { 
            if (i in object) { 
                if (false === callback(object[i], i, object)) 
                    break; 
            } 
        } 
    } 
} 

function addOption(object, object2) { 
    each(object2, function(o, index) { 
        object.options[index] = o; 
    }) 
} 

function map(object, callback, thisp) { 
    var ret = []; 
    each.call(thisp, object, function() { 
        ret.push(callback.apply(thisp, arguments)); 
    }); 
    return ret; 
} 

function sortlist(sortName,isDesc) { 
    var what = sortName; 
    this._options = map(what.options, function(o) { 
        return o; 
    }); 
    this._options.sort( function(a, b) { 
        if (a.text*1 < b.text*1 || a.text == "<!--#tr id="auto"-->Auto<!--#endtr-->") { 
            return isDesc == true ? 1 : -1; 
        } else { 
            return isDesc == true ? -1 : 1; 
        } 
    }); 
    what.options.length = 0;// clear current options 
    addOption(what, this._options); 
} 
//Tom.Hung 2012-11-6 end

function wl_chanspec_list_change(nphy_set)
{
	var phytype;
	var band;
	var bw_cap;
	var country = document.radio.wl_country_code[document.radio.wl_country_code.selectedIndex].value;
	var chanspecs = new Array(0);
	var cur = 0;
	var cur_text;
	var sel = 0;
	var nmode;

	if (nphy_set == "1") {
		phytype = "n";
		band  = document.radio.wl_nband[document.radio.wl_nband.selectedIndex].value;
		nmode = document.radio.wl_nmode[document.radio.wl_nmode.selectedIndex].value;
		if (nmode == "0") {
			document.radio.wl_bw_cap.selectedIndex = 0;
			document.radio.wl_bw_cap.disabled = true;
		} else {
			document.radio.wl_bw_cap.disabled = false;
		}		
		bw_cap = document.radio.wl_bw_cap[document.radio.wl_bw_cap.selectedIndex].value;

	} else {
		phytype =  document.radio.wl_phytype[document.radio.wl_phytype.selectedIndex].value;
	}

	/* Save current chanspec */
	for (i = 0; i < document.radio.wl_chanspec.length; i++) {
		if (document.radio.wl_chanspec[i].selected) {
			cur = document.radio.wl_chanspec[i].value;
			cur_text = document.radio.wl_chanspec[i].text
			break;
		}
	}

	if (phytype == "a") {
		<% wl_chanspec_list("a"); %>
	} else if (phytype == "n") {
		if (band == "1") {
			/* 5 GHz */
			if (bw_cap == "1") {
				<% wl_chanspec_list("n", "1", 20); %>
			} else if (bw_cap == "3") {
				<% wl_chanspec_list("n", "1", 40); %>
			} else {
				<% wl_chanspec_list("n", "1", 80); %>
			}
		} else if (band == "2") {
			/* 2.4 GHz */
			if (bw_cap == "1") {
				<% wl_chanspec_list("n", "2", 20 ); %>
			} else if (bw_cap == "3") {
				<% wl_chanspec_list("n", "2", 40 ); %>
			}
		}
	} else {
		<% wl_chanspec_list("b"); %>
	}

	/* Reconstruct channel array from new chanspecs */
	document.radio.wl_chanspec.length = chanspecs.length;
	for (var i in chanspecs) {
		//Tom.Hung 2012-11-6, Don't show 36u,36l,36/80.
		var reg = /(u|l|(\/80))?/gi;
		var str = chanspecs[i].toString();
		var ch_display = str.replace(reg, "");
		//Tom.Hung 2012-11-6 end
		if (chanspecs[i] == 0)
			document.radio.wl_chanspec[i] = new Option("<!--#tr id="auto"-->Auto<!--#endtr-->", chanspecs[i]);
		else
			document.radio.wl_chanspec[i] = new Option(ch_display, chanspecs[i]);
		document.radio.wl_chanspec[i].value = chanspecs[i];
		if (chanspecs[i] == cur || document.radio.wl_chanspec[i].text == cur_text) {
			document.radio.wl_chanspec[i].selected = true;
			sel = 1;
		}
	}

	//Tom.Hung 2012-11-6, Sort option list
	//Remove same chanspec
	var chanspec_select = document.radio.wl_chanspec;
	//Tom.Hung 2012-11-7, work around to hide 5G DFS channel (52~140)
	for(i=0;i<chanspec_select.length;i++) {
		if(chanspec_select[i].text != "<!--#tr id="auto"-->Auto<!--#endtr-->" &&
			(parseInt(chanspec_select[i].text, 10) > 48 && parseInt(chanspec_select[i].text, 10) < 149)) {
			chanspec_select.remove(i);
			i--;
		}
	}
	//Tom.Hung 2012-11-7 end
	for(i=0;i<chanspec_select.length;i++) {
		for(j=i+1;j<chanspec_select.length;j++) {
			if(chanspec_select[i].text == chanspec_select[j].text) {
				chanspec_select.remove(j);
				j--;
			}
		}
	}
	//Sort chanspec
	sortlist(chanspec_select, false);
	//Keep cur chanspec
	for(i=0;i<chanspec_select.length;i++) {
		if(chanspec_select[i].value == cur || chanspec_select[i].text == cur_text) {
			chanspec_select[i].selected = true;
			sel = 1;
		}
	}
	//Tom.Hung 2012-11-6 end

	if (sel == 0 && document.radio.wl_chanspec.length > 0)
		document.radio.wl_chanspec[0].selected = true;
}

function wl_ewc_options(nphy_set)
{
	var bw;
	var bw_cap;
	var band;
	var frameburst;
	var chanspec;
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

	if (document.radio.wl_chanspec.length > 0)
		chanspec = document.radio.wl_chanspec[document.radio.wl_chanspec.selectedIndex].value;
	else
		chanspec = 0;
	nmode = document.radio.wl_nmode[document.radio.wl_nmode.selectedIndex].value;
	if (chanspec == "0" && nmode != "0") {
		<% wl_um_nphyrates("0"); %>
		document.radio.wl_nmcsidx.disabled = false;
		document.radio.wl_gmode.disabled = true;
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

	document.radio.wl_chanspec.disabled = 0;
	if (document.radio.wl_nphyrate != null)
		document.radio.wl_nphyrate.disabled = 0;
	document.radio.wl_bw_cap.disabled = 0;

	frameburst = document.radio.wl_frameburst[document.radio.wl_frameburst.selectedIndex].value;
/*
#ifdef BCMINTERNAL
*/
	/* Disable RIFS when frameburst is off */
	if (frameburst == "on") {
		document.radio.wl_rifs.disabled = 0;
	}  else {
		document.radio.wl_rifs.disabled = 1;
	}
/*
#endif
*/
	/* If nmode is disabled, allow only 20Mhz selection */
        if (nmode == "0") {
		document.radio.wl_bw_cap.selectedIndex = 0;
		document.radio.wl_bw_cap.disabled = 1;
	}

	band = document.radio.wl_nband[document.radio.wl_nband.selectedIndex].value;
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
		if (band == "1")
			document.radio.wl_gmode.disabled = true;
		else if (band == "2")
			document.radio.wl_gmode.disabled = false;
	} else {
		document.radio.wl_nmcsidx.disabled = false;
		document.radio.wl_gmode.disabled = true;
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

function wl_phytype_change()
{
	var phytype = document.radio.wl_phytype[document.radio.wl_phytype.selectedIndex].value;
	var gmode = document.radio.wl_gmode[document.radio.wl_gmode.selectedIndex].value;

	if (phytype == "g") {
		document.radio.wl_gmode.disabled = 0;
		document.radio.wl_gmode_protection.disabled = 0;
	} else {
		document.radio.wl_gmode.disabled = 1;
	}

	if (phytype == "b" || (phytype == "g" && (gmode == "0" || gmode == "1")))
		document.radio.wl_plcphdr.disabled = 0;
	else
		document.radio.wl_plcphdr.disabled = 1;

	wl_basic_rateset_change();
}

function wl_nband_change()
{

	var bandtype = document.radio.wl_nband[document.radio.wl_nband.selectedIndex].value;

	if (bandtype == "2")
		document.radio.wl_plcphdr.disabled = 0;
	else 
		document.radio.wl_plcphdr.disabled = 1;

	/*
	 * This block of code checks to see if 80 MHz is listed. If it is
	 * and the band selected is 2.4 GHz, then hide the 80 MHz selection
	 * since it is not a valid option for that band.
	 */
	if (document.radio.wl_bw_cap.length == 3) {
		if (bandtype == "2") {
			if (document.radio.wl_bw_cap[2].selected) {
				document.radio.wl_bw_cap[0].selectedIndex = 0;
				/* document.radio.wl_bw_cap[0].selected = true; */
			}
			document.radio.wl_bw_cap[2].style.display = 'none';
		} else {
			document.radio.wl_bw_cap[2].style.display = '';
		}
	}
}

function wl_mode_onchange()
{
	//The following variable is set when the user changes wl_mode
	document.radio.wl_mode_changed = 1;
	wl_mode_change();
}

function wl_mode_change()
{
	var mode = document.radio.wl_mode[document.radio.wl_mode.selectedIndex].value;
	var ure = document.radio.wl_ure[document.radio.wl_ure.selectedIndex].value;

	if (mode == "sta" || mode == "wet" || mode == "psta" || mode == "psr") {
		document.radio.wl_infra.disabled = 0;
/*
#ifdef BCMINTERNAL
*/
		document.radio.wl_lazywds.disabled = 1;
		document.radio.wl_wds0.disabled = 1;
		document.radio.wl_wds1.disabled = 1;
		document.radio.wl_wds2.disabled = 1;
		document.radio.wl_wds3.disabled = 1;
		document.radio.wl_wds_timeout.disabled = 1;
/* 
#endif
*/
		document.radio.wl_sta_retry_time.disabled = 0;
    // Provide an intelligent setting when URE or WL mode is changed
		if( document.radio.wl_mode_changed == 1 || 
		    document.radio.wl_ure_changed == 1 ) {
			if( mode == "psta" || mode == "psr" ) { // Proxy or Repeater
				document.radio.wl_sta_retry_time.value = 5;
				document.radio.wl_ure[0].disabled = 1;
				document.radio.wl_ure[1].disabled = 1;
			} else if( mode == "wet" )  // WET or RangeExtender
				document.radio.wl_sta_retry_time.value = 5;
			else if ( ure == "1" )    // Travel Router
				document.radio.wl_sta_retry_time.value = 300;
			else //STA
				document.radio.wl_sta_retry_time.value = 0;

			document.radio.wl_mode_changed = 0;
			document.radio.wl_ure_changed = 0;
		}
	}
	else {
		document.radio.wl_infra.disabled = 1;
/*
#ifdef BCMINTERNAL
*/
		document.radio.wl_lazywds.disabled = 0;
		document.radio.wl_wds0.disabled = 0;
		document.radio.wl_wds1.disabled = 0;
		document.radio.wl_wds2.disabled = 0;
		document.radio.wl_wds3.disabled = 0;
		document.radio.wl_wds_timeout.disabled = 0;
/* 
#endif
*/
		document.radio.wl_sta_retry_time.disabled = 1;
	}
}

function wl_ure_onchange()
{
	//The following variable is set when the user changes wl_ure
	document.radio.wl_ure_changed = 1;
	wl_ure_change();
}

function wl_ure_change()
{
	var mode = document.radio.wl_ure[document.radio.wl_ure.selectedIndex].value;
	var router_disable = "<% nvram_get("router_disable"); %>";

	if( mode == "1" ) {
		if (router_disable == "1") {
			document.radio.wl_mode.value = "wet";
		}
		else {
			document.radio.wl_mode.value = "sta";
		}
		document.radio.wl_mode.disabled=1;
		document.radio.wl_infra.disabled = 0;
		document.radio.wl_lazywds.disabled = 0;
		document.radio.wl_wds0.disabled = 0;
		document.radio.wl_wds1.disabled = 0;
		document.radio.wl_wds2.disabled = 0;
		document.radio.wl_wds3.disabled = 0;
		document.radio.wl_wds_timeout.disabled = 0;
	}
	else {
	  document.radio.wl_mode.disabled=0;
	}
	wl_mode_change();
	document.radio.wl_ure_changed = 0;
}

function wl_gmode_options(nphy_set)
{
	var gmode = "<% nvram_get("wl_gmode"); %>";
	var index;

	if (nphy_set == "1")
		document.radio.wl_gmode.disabled = 1;
	else
		document.radio.wl_gmode.disabled = 0;

	if (gmode == "2") {
		index = document.radio.wl_gmode.length;
		document.radio.wl_gmode[index] = new Option("54g Only", "2");
		document.radio.wl_gmode[index].selected = true;
	}
}
function wl_amsdu_options(nphy_set)
{
	var amsdu;

        if (nphy_set == "0")
                return;

	amsdu = "<% wl_inlist("cap", "amsdu"); %>";
/*
#ifdef BCMINTERNAL
*/
	if (amsdu != "1")
		document.radio.wl_amsdu.disabled = 1;
	else
		document.radio.wl_amsdu.disabled = 0;
/*
#endif
*/
}

function wl_wme_options(nphy_set)
{
	var w_ind = document.radio.wl_wme.selectedIndex;
	var w_val = document.radio.wl_wme[w_ind].value;

	document.radio.wl_wme.disabled = 0;

	if (w_val == "off") {
		document.radio.wl_wme_no_ack.disabled = 1;
		document.radio.wl_wme_apsd.disabled = 1;
	} else {
		document.radio.wl_wme_no_ack.disabled = 0;
		document.radio.wl_wme_apsd.disabled = 0;
	}
}

function wl_ure_modes()
{
	var isap = "<% wl_inlist("cap", "ap"); %>";
	var issta = "<% wl_inlist("cap", "sta"); %>";

	if (isap != "1" || issta != "1") {
		document.radio.wl_ure[0].selected = 1;
		document.radio.wl_ure[1].disabled = 1;
	} else {
		document.radio.wl_ure[1].disabled = 0;
	}
}

function wl_mcs_onchange()
{
 	var nphy_set = "<% wl_nphy_set(); %>";
	var mcs_val;
	var nmode;
	if (nphy_set == "0")
		return;
	mcs_val =  document.radio.wl_nmcsidx[document.radio.wl_nmcsidx.selectedIndex].value;
	nmode = document.radio.wl_nmode[document.radio.wl_nmode.selectedIndex].value;

	/* If using 'legacy rate' then enable */
	if (mcs_val == "-2" || nmode == "0")
		document.radio.wl_rate.disabled = 0;
	else
		document.radio.wl_rate.disabled = 1;
}

function wl_nmode_change()
{
<% wl_nphy_comment_beg(); %>
	var crypto = "<% wl_crypto(); %>";
	var wep = "<% wl_wep(); %>";
	var wl_akm_wpa = "<% nvram_inlist("wl_akm", "wpa", "1"); %>"*1;
	var wl_akm_psk = "<% nvram_inlist("wl_akm", "psk", "1"); %>"*1;
	var wl_akm_wpa2 = "<% nvram_inlist("wl_akm", "wpa2", "1"); %>"*1;
	var wl_akm_psk2 = "<% nvram_inlist("wl_akm", "psk2", "1"); %>"*1;
	var i, cur, options;

	/* Save current selected nmode option */
	cur = document.radio.wl_nmode[document.radio.wl_nmode.selectedIndex].value;

	if (((wl_akm_wpa == 1 || wl_akm_psk == 1 || wl_akm_wpa2 == 1 || wl_akm_psk2 == 1) && crypto == "tkip") || wep == "enabled") {
		document.radio.wl_nmode.length = 1;
		document.radio.wl_nmode[0] = new Option("<!--#tr id="off"-->Off<!--#endtr-->", "0");
		document.radio.wl_nmode[0].value = "0";
		if (document.radio.wl_nmode[0].value == cur)
			document.radio.wl_nmode[0].selected = true;
	} else {
		document.radio.wl_nmode.length = 2;
		document.radio.wl_nmode[0] = new Option("<!--#tr id="auto"-->Auto<!--#endtr-->", "-1");
		document.radio.wl_nmode[0].value = "-1";
		if (document.radio.wl_nmode[0].value == cur)
			document.radio.wl_nmode[0].selected = true;
		document.radio.wl_nmode[1] = new Option("<!--#tr id="off"-->Off<!--#endtr-->", "0");
		document.radio.wl_nmode[1].value = "0";
		if (document.radio.wl_nmode[1].value == cur)
			document.radio.wl_nmode[1].selected = true;
	}
<% wl_nphy_comment_end(); %>
}

function wl_recalc()
{
 	var nphy_set = "<% wl_nphy_set(); %>";

	if (nphy_set != "1")
		wl_phytype_change();
	else
		wl_nband_change();
	wl_country_list_change(nphy_set);
	wl_country_rev_list_change(nphy_set);
	wl_chanspec_list_change(nphy_set);
	wl_mode_change();
	wl_gmode_options(nphy_set);
	wl_nmode_change();
	wl_rate_change();
	wl_ewc_options(nphy_set);
	wl_amsdu_options(nphy_set);
	wl_wme_options(nphy_set);
	wl_ure_change();
	wl_ure_modes();
	wl_mcs_onchange(); /* This has to be after wl_ewc_options */
}

function wl_closed_check()
{
/*
*/
<% wps_closed_check_display(); %>
/*
*/
}

function resize()
{
	//resize parent height
	if(myBrowser() == "Chrome") {
		var sct = parent.document.body.scrollTop;
		parent.document.getElementById("frame5").height=0;
		parent.document.getElementById("frame5").height=document.body.scrollHeight;
		parent.document.body.scrollTop = sct;
	} else {
		parent.document.getElementById("frame5").height=document.body.scrollHeight;
	}
}

function wireless_enable_change()
{
	if(document.radio.wireless_enable.checked == true)
		document.radio.wl_bss_enabled.value = "1";
	else
		document.radio.wl_bss_enabled.value = "0";
}

function page_load() {
	wl_security_update();
	dyn_add_wlssid_sched_option();
	load_security_mode();
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

	wl_recalc();
	//Tom.Hung 2012-11-19, Keep cur MCS index
	var cur_mcsidx = "<% nvram_get("wl_nmcsidx"); %>";
	var nmcsidx = document.radio.wl_nmcsidx;
	for(i=0;i<nmcsidx.length;i++) {
		if(nmcsidx[i].value == cur_mcsidx) {
			nmcsidx[i].selected = true;
			break;
		}
	}
	//Tom.Hung 2012-11-19 end

	//Enabled
	if(document.radio.wl_bss_enabled.value == "1")
		document.radio.wireless_enable.checked = true;
	else
		document.radio.wireless_enable.checked = false;

	//Tom.Hung 2013-3-15, Hide fourth ssid because it used for guest network
	document.radio.wl_bssid.remove(3);
	//Tom.Hung 2013-3-15 end
	document.radio.wl_bssid.remove(2);
	document.radio.wl_bssid.remove(1);
}
//-->
</script>
</head>
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

<body onload="page_load()" bgcolor="transparent">
<div class="dialog" style="margin-left:auto; margin-right:auto; margin-top:auto;">
<div id="mainform">
	<div id="main_content">
<table class="body"><tr><td>
<form name="radio" id="radio" method="post" action="/basic/wireless5.asp" >
<input type="hidden" name="page" value="/redirect.asp?url=/basic/wireless.asp%3Fwl_unit%3D0">
<input type="hidden" name="token" value="<% genToken(); %>">
<!--
#ifdef BCMWPS
-->
<input type="hidden" name="wl_wps_mode" value="<% nvram_get("wl_wps_mode"); %>" Disabled>
<!--
#endif
-->

<table width="100%" class="tbl_main">
	<tr>
		<td class="CT" colspan="2"><!--#tr id="basic.wireless.5g"-->5GHz AC Wireless Network (802.11ac/a/n)<!--#endtr--></td>
	</tr>
	<tr style="display:none">
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
	<tr style="display:none">
		<td class="CL"
		onMouseOver="return overlib('Selects desired BSS to configure.', LEFT);"
		onMouseOut="return nd();">
		<!--#tr id="basic.4"-->Multiple SSID<!--#endtr-->
		</td>
		<td class="CR">
			<select name="wl_bssid" onChange="submit();">
				<% wl_bssid_list(); %>
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
			<input type="checkbox" name="wireless_enable" onChange="wireless_enable_change();" onkeydown="return prevent_press_enter(event);">
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
		onMouseOver="return overlib('Enable/Disable 802.11N support.', LEFT);"
		onMouseOut="return nd();">
		<!--#tr id="basic.6"-->802.11 n-mode<!--#endtr-->
		</td>
		<td class="CR">
			<select name="wl_nmode" onChange="wl_recalc();">
				<option value="-1" <% nvram_match("wl_nmode", "-1", "selected"); %>><!--#tr id="auto"-->Auto<!--#endtr--> </option>
				<option value="0" <% nvram_match("wl_nmode", "0", "selected"); %>><!--#tr id="off"-->Off<!--#endtr--> </option>
			</select>
		</td>
	</tr>
	<tr>
		<td class="CL"
		onMouseOver="return overlib('Selecting <b>Closed</b> hides the network from active scans. Selecting <b>Open</b> reveals the network to active scans.', LEFT);"
		onMouseOut="return nd();">
		<!--#tr id="basic.8"-->Broadcast Network Name (SSID)<!--#endtr-->
		</td>
		<td class="CR">
			<select name="wl_closed" onChange="wl_closed_check();">
				<option value="0" <% nvram_match("wl_closed", "0", "selected"); %>><!--#tr id="enabled"-->Enabled<!--#endtr--></option>
				<option value="1" <% nvram_match("wl_closed", "1", "selected"); %>><!--#tr id="disabled"-->Disabled<!--#endtr--></option>
			</select>
		</td>
	</tr>
	<tr>
		<td class="CL"
		onMouseOver="return overlib('Selects a channel specification.', LEFT);"
		onMouseOut="return nd();">
		<!--#tr id="basic.9"-->Frequency (Channel)<!--#endtr--></td>
		<td class="CR">
			<select name="wl_chanspec" onChange="wl_recalc();">
			<option	 value="<% nvram_get("wl_chanspec"); %>" selected></option>
			</select>&nbsp;&nbsp;<!--<% wl_cur_chanspec(); %>-->
		</td>
	</tr>
	<tr>
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
		<td class="CL"><!--#tr id="schedule"-->Schedule<!--#endtr--></td>
		<td class="CR">
			<select name="wl_schedule" id="wl_schedule">
				<option value="0" selected><!--#tr id="always"-->Always<!--#endtr--></option>
			</select>
			<input type="button" value="<!--#tr id="new.schedule"-->Add New<!--#endtr-->" onclick="open_schedule()">
		</td>
	</tr>
</table>

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
			<input id="radiusKey" name="wl_radius_key" maxlength="255" value="<% nvram_get("wl_radius_key"); %>" type="password" onkeydown="return prevent_press_enter(event);">
		</td>
	</tr>
</table>
</div>

<div style="display:none">
<table width="100%" class="tbl_main">
<% wl_nphy_comment_beg(); %>
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
    <td class="CR"><input id="unicastRekeyingInterval" name="wl_wai_uck_rekey" value="<% nvram_get("wl_wai_uck_rekey"); %>" size="10" maxlength="10" onkeydown="return prevent_press_enter(event);"></td>
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
    <td class="CR"><input name="wl_nas_dbg" value="<% nvram_get("wl_nas_dbg"); %>" size="10" maxlength="10" onkeydown="return prevent_press_enter(event);"></td>
  </tr>
</table>
</div>

<!--
#endif
-->

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
			<select name="wl_macmode" onChange="wl_macmode_check();">
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
			<input type="hidden" name="action" value="Apply" />
			<input type="button" class="<!--#tr id="buttonWidth"-->button1<!--#endtr-->" value="<!--#tr id="apply"-->Apply<!--#endtr-->" onClick="check_submit();">
			<input type="reset"  class="button1" name="action" value="<!--#tr id="cancel"-->Cancel<!--#endtr-->">
		</td>
	</tr>
</table>

<div style="display:none">
<table width="100%" class="tbl_main">
 <tr>
    <td class="CL"
	onMouseOver="return overlib('Restricts the channel set based on country requirements.', LEFT);"
	onMouseOut="return nd();">
	Country</td>
    <td class="CR">
	<select name="wl_country_code" onChange="wl_recalc();">
	  <option value="<% wl_cur_country(); %>" selected></option>
	</select>
	&nbsp;&nbsp;Current: <% wl_cur_country(); %>    </td>
  </tr>
  <tr>
    <td class="CL"
	onMouseOver="return overlib('Country regulatory revision index.', LEFT);"
	onMouseOut="return nd();">
	Regulatory Revision</td>
    <td class="CR">
	<select name="wl_country_rev" onChange="wl_recalc();">
	  <option value="<% wl_cur_regrev(); %>" selected></option>
	</select>
	&nbsp;&nbsp;Current: <% wl_cur_regrev(); %>    </td>
  </tr>
</table>
</div>

<div style="display:none">
<table width="100%" class="tbl_main">
  <tr>
    <td class="CL"
	onMouseOver="return overlib('Enables or disables the wireless Interface.', LEFT);"
	onMouseOut="return nd();">
	Interface</td>
    <td class="CR">
	<select name="wl_radio">
	  <option value="0" <% nvram_match("wl_radio", "0", "selected"); %>>Disabled</option>
	  <option value="1" <% nvram_match("wl_radio", "1", "selected"); %>>Enabled</option>
	</select>    </td>
  </tr>
  <tr>
    <td class="CL"
	onMouseOver="return overlib('Selects 802.11 Band to use.', LEFT);"
	onMouseOut="return nd();">
	802.11 Band</td>
    <td class="CR">
	<select name=<% wl_phytype_name(); %>  onChange="wl_recalc();">
	  <% wl_phytypes(); %>
	</select>
	&nbsp;&nbsp;<% wl_cur_phytype(); %>    </td>
  </tr>
<% wl_nphy_comment_beg(); %>
  <tr>
    <td class="CL"
	onMouseOver="return overlib('Select number of transmit chains to use', LEFT);"
	onMouseOut="return nd();">
	NPHY TxChains</td>
    <td class="CR">
	<select name="wl_txchain" onChange="wl_recalc();">
<% wl_txchains_list();%>
	</select>    </td>
  </tr>
  <tr>
    <td class="CL"
	onMouseOver="return overlib('Select number of receive chains to support', LEFT);"
	onMouseOut="return nd();">
	NPHY RxChains</td>
    <td class="CR">
	<select name="wl_rxchain">
<% wl_rxchains_list();%>
	</select>    </td>
  </tr>
<% wl_nphy_comment_end(); %>
  <tr>
    <td class="CL"
	onMouseOver="return overlib('Set the mode to 54g Auto for the widest compatibility. Set the mode to 54g Performance for the fastest performance among 54g certified equipment. Set the mode to 54g LRS if you are experiencing difficulty with legacy 802.11b equipment.', LEFT);"
	onMouseOut="return nd();">
	54g&#8482; Mode</td>
    <td class="CR">
	<select name="wl_gmode" onChange="wl_recalc();">
	  <option value="1" <% nvram_match("wl_gmode", "1", "selected"); %>>54g Auto</option>
	  <option value="4" <% nvram_match("wl_gmode", "4", "selected"); %>>54g Performance</option>
	  <option value="5" <% nvram_match("wl_gmode", "5", "selected"); %>>54g LRS</option>
	  <option value="0" <% nvram_match("wl_gmode", "0", "selected"); %>>802.11b Only</option>
	</select>    </td>
  </tr>
  <tr>
	<% wl_protection(); %>
  </tr>
  <tr>
        <% wl_mimo_preamble(); %>
  </tr>
  <tr>
    <td class="CL"
	onMouseOver="return overlib('Advertise packet priority using VLAN tag.', LEFT);"
	onMouseOut="return nd();">
	VLAN Priority Support</td>
    <td class="CR">
	<select name="wl_vlan_prio_mode">
	  <option value="off" <% nvram_match("wl_vlan_prio_mode", "off", "selected"); %>>Off </option>
	  <option value="on" <% nvram_match("wl_vlan_prio_mode", "on", "selected"); %>>On </option>
	</select>    </td>
  </tr>
  <tr>
    <td class="CL"
	onMouseOver="return overlib('Forces the transmission rate for the AP to a particular speed.', LEFT);"
	onMouseOut="return nd();">
	<% wl_legacy_string(); %> Rate</td>
    <td class="CR">
	<select name="wl_rate">
	  <!-- All a/b/g rates -->
	  <option value="0" <% nvram_match("wl_rate", "0", "selected"); %>>Auto</option>
	  <option value="1000000" <% nvram_match("wl_rate", "1000000", "selected"); %>>1 Mbps</option>
	  <option value="2000000" <% nvram_match("wl_rate", "2000000", "selected"); %>>2 Mbps</option>
	  <option value="5500000" <% nvram_match("wl_rate", "5500000", "selected"); %>>5.5 Mbps</option>
	  <option value="6000000" <% nvram_match("wl_rate", "6000000", "selected"); %>>6 Mbps</option>
	  <option value="9000000" <% nvram_match("wl_rate", "9000000", "selected"); %>>9 Mbps</option>
	  <option value="11000000" <% nvram_match("wl_rate", "11000000", "selected"); %>>11 Mbps</option>      
	  <option value="12000000" <% nvram_match("wl_rate", "12000000", "selected"); %>>12 Mbps</option>
	  <option value="18000000" <% nvram_match("wl_rate", "18000000", "selected"); %>>18 Mbps</option>
	  <option value="24000000" <% nvram_match("wl_rate", "24000000", "selected"); %>>24 Mbps</option>
	  <option value="36000000" <% nvram_match("wl_rate", "36000000", "selected"); %>>36 Mbps</option>
	  <option value="48000000" <% nvram_match("wl_rate", "48000000", "selected"); %>>48 Mbps</option>
	  <option value="54000000" <% nvram_match("wl_rate", "54000000", "selected"); %>>54 Mbps</option>
	</select>    </td>
  </tr>
  <tr>
    <td class="CL"
	onMouseOver="return overlib('Selects the basic rates that wireless clients must support.', LEFT);"
	onMouseOut="return nd();">
	Basic Rate Set</td>
    <td class="CR">
	<select name="wl_rateset">
	  <option value="default" <% nvram_match("wl_rateset", "default", "selected"); %>>Default</option>
	  <option value="all" <% nvram_match("wl_rateset", "all", "selected"); %>>All</option>
	  <option value="12" <% nvram_match("wl_rateset", "12", "selected"); %>>1 & 2 Mbps</option>
	</select>    </td>
  </tr>
  <tr>
    <td class="CL"
	onMouseOver="return overlib('Forces the multicast/broadcast transmission rate for the AP to a particular speed.', LEFT);"
	onMouseOut="return nd();">
	Multicast Rate</td>
    <td class="CR">
	<select name="wl_mrate">
	  <!-- All a/b/g rates -->
	  <option value="0" <% nvram_match("wl_mrate", "0", "selected"); %>>Auto</option>
	  <option value="1000000" <% nvram_match("wl_mrate", "1000000", "selected"); %>>1 Mbps</option>
	  <option value="2000000" <% nvram_match("wl_mrate", "2000000", "selected"); %>>2 Mbps</option>
	  <option value="5500000" <% nvram_match("wl_mrate", "5500000", "selected"); %>>5.5 Mbps</option>
	  <option value="6000000" <% nvram_match("wl_mrate", "6000000", "selected"); %>>6 Mbps</option>
	  <option value="9000000" <% nvram_match("wl_mrate", "9000000", "selected"); %>>9 Mbps</option>
	  <option value="11000000" <% nvram_match("wl_mrate", "11000000", "selected"); %>>11 Mbps</option>      
	  <option value="12000000" <% nvram_match("wl_mrate", "12000000", "selected"); %>>12 Mbps</option>
	  <option value="18000000" <% nvram_match("wl_mrate", "18000000", "selected"); %>>18 Mbps</option>
	  <option value="24000000" <% nvram_match("wl_mrate", "24000000", "selected"); %>>24 Mbps</option>
	  <option value="36000000" <% nvram_match("wl_mrate", "36000000", "selected"); %>>36 Mbps</option>
	  <option value="48000000" <% nvram_match("wl_mrate", "48000000", "selected"); %>>48 Mbps</option>
	  <option value="54000000" <% nvram_match("wl_mrate", "54000000", "selected"); %>>54 Mbps</option>
	</select>    </td>
  </tr>
<!--
#ifdef BCMINTERNAL
-->
  <tr>
    <td class="CL"
	onMouseOver="return overlib('Broadcom Dynamic Channel Selection Support.', LEFT);"
	onMouseOut="return nd();">
	Broadcom DCS</td>
    <td class="CR">
	<select name="wl_bcmdcs">
	  <option value="off" <% nvram_match("wl_bcmdcs", "off", "selected"); %>>Off </option>
	  <option value="on" <% nvram_match("wl_bcmdcs", "on", "selected"); %>>On </option>
	</select>    </td>
  </tr>	
  <tr>
    <td class="CL"
	onMouseOver="return overlib('Selects the transmitting antenna.', LEFT);"
	onMouseOut="return nd();">
	Antenna Diversity</td>
    <td class="CR">
	<select name="wl_antdiv">
	  <option value="-1" <% nvram_match("wl_antdiv", "-1", "selected"); %>>Default</option>
	  <option value="0" <% nvram_match("wl_antdiv", "0", "selected"); %>>Use Antenna 0</option>
	  <option value="1" <% nvram_match("wl_antdiv", "1", "selected"); %>>Use Antenna 1</option>
	  <option value="3" <% nvram_match("wl_antdiv", "3", "selected"); %>>Auto Select</option>
	</select>    </td>
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
	onMouseOver="return overlib('Selects a regulatory mode to use.', LEFT);"
	onMouseOut="return nd();">
	Regulatory Mode</td>
    <td class="CR">
	<select name="wl_reg_mode" onChange="wl_recalc();">
	  <option value="off" <% nvram_match("wl_reg_mode", "off", "selected"); %>>Off</option>
	  <option value="h" <% nvram_match("wl_reg_mode", "h", "selected"); %>>802.11H Loose</option>
	  <option value="strict_h" <% nvram_match("wl_reg_mode", "strict_h", "selected"); %>>802.11H Strict</option>
	  <option value="d" <% nvram_match("wl_reg_mode", "d", "selected"); %>>802.11D</option>
	</select>    </td>
  </tr>
  <tr>
    <td class="CL"
	onMouseOver="return overlib('Power Mitigation factor (in db)', LEFT);"
	onMouseOut="return nd();">
	TPC Mitigation (db)</td>
    <td class="CR">
	<select name="wl_tpc_db">
	  <option value="0" <% nvram_match("wl_tpc_db", "off", "selected"); %>>0 (Off)</option>
	  <option value="2" <% nvram_match("wl_tpc_db", "2", "selected"); %>>2</option>
	  <option value="3" <% nvram_match("wl_tpc_db", "3", "selected"); %>>3</option>
	  <option value="4" <% nvram_match("wl_tpc_db", "4", "selected"); %>>4</option>
	</select>    </td>
  </tr>
</table>
</div>

<% wl_nphy_comment_beg(); %>
<div style="display:none">
<table width="100%" class="tbl_main">
  <tr>
    <td class="CL"
	onMouseOver="return overlib('Enable/Disable Overlapping BSS Coexisistence aka 20/40 Coex.', LEFT);"
	onMouseOut="return nd();">
	OBSS Coexistence</td>
    <td class="CR">
	<select name="wl_obss_coex">
	  <option value="0" <% nvram_match("wl_obss_coex", "0", "selected"); %>>Off</option>
	  <option value="1" <% nvram_match("wl_obss_coex", "1", "selected"); %>>On</option>
	</select>    </td>
  </tr>
</table>
</div>
<% wl_nphy_comment_end(); %>  

<div style="display:none">
<table width="100%" class="tbl_main">
  <tr>
    <td class="CL"
	onMouseOver="return overlib('Sets the fragmentation threshold.', LEFT);"
	onMouseOut="return nd();">
	Fragmentation Threshold</td>
    <td class="CR"><input name="wl_frag" value="<% nvram_get("wl_frag"); %>" size="4" maxlength="4" onkeydown="return prevent_press_enter(event);"></td>
  </tr>
  <tr>
    <td class="CL"
	onMouseOver="return overlib('Sets the RTS threshold.', LEFT);"
	onMouseOut="return nd();">
	RTS Threshold</td>
    <td class="CR"><input name="wl_rts" value="<% nvram_get("wl_rts"); %>" size="4" maxlength="4" onkeydown="return prevent_press_enter(event);"></td>
  </tr>
  <tr>
    <td class="CL"
	onMouseOver="return overlib('Sets the wakeup interval for clients in power-save mode.', LEFT);"
	onMouseOut="return nd();">
	DTIM Interval</td>
    <td class="CR"><input name="wl_dtim" value="<% nvram_get("wl_dtim"); %>" size="4" maxlength="4" onkeydown="return prevent_press_enter(event);"></td>
  </tr>
  <tr>
    <td class="CL"
	onMouseOver="return overlib('Sets the beacon interval for the AP.', LEFT);"
	onMouseOut="return nd();">
	Beacon Interval</td>
    <td class="CR"><input name="wl_bcn" value="<% nvram_get("wl_bcn"); %>" size="4" maxlength="4" onkeydown="return prevent_press_enter(event);"></td>
  </tr>
  <tr>
    <td class="CL"
	onMouseOver="return overlib('Enable/Disable rotation of beacon order when running in MultiBSS mode.', LEFT);"
	onMouseOut="return nd();">
	Beacon Rotation:</td>
    <td class="CR">
	<select name="wl_bcn_rotate">
	  <option value="1" <% nvram_match("wl_bcn_rotate", "1", "selected"); %>>Enabled</option>
	  <option value="0" <% nvram_match("wl_bcn_rotate", "0", "selected"); %>>Disabled</option>
	</select>    </td>
  </tr>
  <tr>
    <td class="CL"
	onMouseOver="return overlib('Sets whether short or long preambles are used. Short preambles improve throughput but all clients in the wireless network must support this capability if selected.', LEFT);"
	onMouseOut="return nd();">
	Preamble Type</td>
    <td class="CR">
	<select name="wl_plcphdr">
	  <option value="long" <% nvram_match("wl_plcphdr", "long", "selected"); %>>Long</option>
	  <option value="short" <% nvram_match("wl_plcphdr", "short", "selected"); %>>Short</option>
	</select>    </td>
  </tr>
  <tr>
    <td class="CL"
	onMouseOver="return overlib('Sets the Associations the Driver Should Accept.', LEFT);"
	onMouseOut="return nd();">
	Max Associations Limit</td>
    <td class="CR"><input name="wl_maxassoc" value="<% nvram_get("wl_maxassoc"); %>" size="4" maxlength="4" onkeydown="return prevent_press_enter(event);"></td>
</table>
</div>

<div style="display:none">
<table width="100%" class="tbl_main">
  <tr>
    <td class="CL"
	onMouseOver="return overlib('Enable/Disable XPress mode', LEFT);"
	onMouseOut="return nd();">
	XPress&#8482; Technology</td>
    <td class="CR">
	<select name="wl_frameburst" onChange="wl_recalc();">
	  <option value="off" <% nvram_match("wl_frameburst", "off", "selected"); %>>Off</option>
	  <option value="on" <% nvram_match("wl_frameburst", "on", "selected"); %>>On</option>
	</select>    </td>
  </tr>  
</table>
</div>
<% wl_nphy_comment_beg(); %>
<div style="display:none">
<table width="100%" class="tbl_main">
<% wl_nphy_comment_end(); %>
<!--
#ifdef BCMINTERNAL
-->
<% wl_nphy_comment_beg(); %>
  <tr>
    <td class="CL"
	onMouseOver="return overlib('Enable/Disable A-MSDU mode.  Fragmentation must be disabled when A-MSDU mode is enabled', LEFT);"
	onMouseOut="return nd();">
	A-MSDU Technology</td>
    <td class="CR">
	<select name="wl_amsdu">
	  <option value="auto" <% nvram_match("wl_amsdu", "auto", "selected"); %>>Auto</option>
	  <option value="off" <% nvram_match("wl_amsdu", "off", "selected"); %>>Off</option>
	  <option value="on" <% nvram_match("wl_amsdu", "on", "selected"); %>>On</option>
	</select>    </td>
  </tr>  
  <tr>
    <td class="CL"
	onMouseOver="return overlib('Enable/Disable A-MPDU mode.', LEFT);"
	onMouseOut="return nd();">
	A-MPDU Technology</td>
    <td class="CR">
	<select name="wl_ampdu">
	  <option value="auto" <% nvram_match("wl_ampdu", "auto", "selected"); %>>Auto</option>
	  <option value="off" <% nvram_match("wl_ampdu", "off", "selected"); %>>Off</option>
	  <option value="on" <% nvram_match("wl_ampdu", "on", "selected"); %>>On</option>
	</select>    </td>
  </tr>  
  <tr>
    <td class="CL"
	onMouseOver="return overlib('Enable/Disable RIFS transmissions (Need to have Framebursting).', LEFT);"
	onMouseOut="return nd();">
	RIFS mode</td>
    <td class="CR">
	<select name="wl_rifs">
	  <option value="auto" <% nvram_match("wl_rifs", "auto", "selected"); %>>Auto</option>
	  <option value="off" <% nvram_match("wl_rifs", "off", "selected"); %>>Off</option>
	  <option value="on" <% nvram_match("wl_rifs", "on", "selected"); %>>On</option>
	</select>    </td>
  </tr>
<% wl_nphy_comment_end(); %>
<!--
#endif
-->
<% wl_nphy_comment_beg(); %>	
  <tr>
    <td class="CL"
	onMouseOver="return overlib('RIFS mode to advertise in beacons and probe responses.', LEFT);"
	onMouseOut="return nd();">
	RIFS Mode Advertisement</td>
    <td class="CR">
	<select name="wl_rifs_advert">
	  <option value="auto" <% nvram_match("wl_rifs_advert", "auto", "selected"); %>>Auto</option>
	  <option value="off" <% nvram_match("wl_rifs_advert", "off", "selected"); %>>Off</option>
	</select>    </td>
  </tr>
<% wl_nphy_comment_end(); %>
<!--
#ifdef BCMINTERNAL
-->
<% wl_nphy_comment_beg(); %>	
  <tr>
    <td class="CL"
	onMouseOver="return overlib('Enable/Disable STBC for transmissions.', LEFT);"
	onMouseOut="return nd();">
	STBC Tx</td>
    <td class="CR">
	<select name="wl_stbc_tx">
	  <option value="auto" <% nvram_match("wl_stbc_tx", "auto", "selected"); %>>Auto</option>
	  <option value="on" <% nvram_match("wl_stbc_tx", "on", "selected"); %>>On</option>
	  <option value="off" <% nvram_match("wl_stbc_tx", "off", "selected"); %>>Off</option>
	</select>    </td>
  </tr>
<% wl_nphy_comment_end(); %>
<!--
#endif
-->
<% wl_nphy_comment_beg(); %>	
</table>
</div>
<% wl_nphy_comment_end(); %>

<div style="display:none">
<table width="100%" class="tbl_main">
  <tr>
    <td class="CL"
	onMouseOver="return overlib('Enable/Disable WMM support', LEFT);"
	onMouseOut="return nd();">
	WMM Support</td>
    <td class="CR">
	<select name="wl_wme" onChange="wl_recalc();">
	  <option value="auto" <% nvram_match("wl_wme", "auto", "selected"); %>>Auto</option>
	  <option value="off" <% nvram_match("wl_wme", "off", "selected"); %>>Off</option>
	  <option value="on" <% nvram_match("wl_wme", "on", "selected"); %>>On</option>
	</select>    </td>
  </tr>
  <tr>
    <td class="CL"
	onMouseOver="return overlib('Enable/Disable WMM No-Acknowledgment', LEFT);"
	onMouseOut="return nd();">
	No-Acknowledgement</td>
    <td class="CR">
	<select name="wl_wme_no_ack">
	  <option value="off" <% nvram_match("wl_wme_no_ack", "off", "selected"); %>>Off</option>
	  <option value="on" <% nvram_match("wl_wme_no_ack", "on", "selected"); %>>On</option>
	</select>    </td>
  </tr>
  <tr>
    <td class="CL"
	onMouseOver="return overlib('Enable/Disable Automatic Power Save Delivery', LEFT);"
	onMouseOut="return nd();">
	APSD Support</td>
    <td class="CR">
	<select name="wl_wme_apsd">
	  <option value="off" <% nvram_match("wl_wme_apsd", "off", "selected"); %>>Off</option>
	  <option value="on" <% nvram_match("wl_wme_apsd", "on", "selected"); %>>On</option>
	</select>    </td>
  </tr>
  <tr>
    <td class="CL" valign="top" rowspan="1"
	onMouseOver="return overlib('WMM EDCA Parameters for AP.  CW value should be one less than a power of 2.  TXOP value should be a multiple of 32.', LEFT);"
	onMouseOut="return nd();">
	<input type="hidden" name="wme_ap" value="8">
	EDCA AP Parameters</td>
    <td class="label">CWmin</td>
    <td class="label">CWmax</td>
    <td class="label">AIFSN</td>
    <td class="label">TXOP(b)<br>Limit (usec)</td>
    <td class="label">TXOP(a/g)<br>Limit (usec)</td>
    <td class="label">Admission<br>Control</td>
    <td class="label">Discard<br>Oldest First</td>
  </tr>
  <tr>	
    <td class="CL" valign="top" rowspan="1"
	onMouseOver="return overlib('AP AC_BE parameters', LEFT);"
	onMouseOut="return nd();">
	<input type="hidden" name="wl_wme_ap_be" value="5">
	AC_BE</td>
	<td><input name="wl_wme_ap_be0" value="<% nvram_list("wl_wme_ap_be", 0); %>" size="6" maxlength="6" onkeydown="return prevent_press_enter(event);"></td>
	<td><input name="wl_wme_ap_be1" value="<% nvram_list("wl_wme_ap_be", 1); %>" size="6" maxlength="6" onkeydown="return prevent_press_enter(event);"></td>
	<td><input name="wl_wme_ap_be2" value="<% nvram_list("wl_wme_ap_be", 2); %>" size="6" maxlength="6" onkeydown="return prevent_press_enter(event);"></td>
	<td><input name="wl_wme_ap_be3" value="<% nvram_list("wl_wme_ap_be", 3); %>" size="6" maxlength="6" onkeydown="return prevent_press_enter(event);"></td>
	<td><input name="wl_wme_ap_be4" value="<% nvram_list("wl_wme_ap_be", 4); %>" size="6" maxlength="6" onkeydown="return prevent_press_enter(event);"></td>
	<td>
          <select name="wl_wme_ap_be5">
	    <option value="off" <% nvram_indexmatch("wl_wme_ap_be", 5, "off", "selected"); %>>Off</option>
	    <option value="on" <% nvram_indexmatch("wl_wme_ap_be", 5, "on", "selected"); %>>On</option>
	  </select>	</td>
	<td>
          <select name="wl_wme_ap_be6">
	    <option value="off" <% nvram_indexmatch("wl_wme_ap_be", 6, "off", "selected"); %>>Off</option>
	    <option value="on" <% nvram_indexmatch("wl_wme_ap_be", 6, "on", "selected"); %>>On</option>
	  </select>	</td>
  </tr>
  <tr>	
    <td class="CL" valign="top" rowspan="1"
	onMouseOver="return overlib('AP AC_BK parameters', LEFT);"
	onMouseOut="return nd();">
	<input type="hidden" name="wl_wme_ap_bk" value="5">
	AC_BK</td>
	<td><input name="wl_wme_ap_bk0" value="<% nvram_list("wl_wme_ap_bk", 0); %>" size="6" maxlength="6" onkeydown="return prevent_press_enter(event);"></td>
	<td><input name="wl_wme_ap_bk1" value="<% nvram_list("wl_wme_ap_bk", 1); %>" size="6" maxlength="6" onkeydown="return prevent_press_enter(event);"></td>
	<td><input name="wl_wme_ap_bk2" value="<% nvram_list("wl_wme_ap_bk", 2); %>" size="6" maxlength="6" onkeydown="return prevent_press_enter(event);"></td>
	<td><input name="wl_wme_ap_bk3" value="<% nvram_list("wl_wme_ap_bk", 3); %>" size="6" maxlength="6" onkeydown="return prevent_press_enter(event);"></td>
	<td><input name="wl_wme_ap_bk4" value="<% nvram_list("wl_wme_ap_bk", 4); %>" size="6" maxlength="6" onkeydown="return prevent_press_enter(event);"></td>
	<td>
          <select name="wl_wme_ap_bk5">
	    <option value="off" <% nvram_indexmatch("wl_wme_ap_bk", 5, "off", "selected"); %>>Off</option>
	    <option value="on" <% nvram_indexmatch("wl_wme_ap_bk", 5, "on", "selected"); %>>On</option>
	  </select>	</td>
	<td>
          <select name="wl_wme_ap_bk6">
	    <option value="off" <% nvram_indexmatch("wl_wme_ap_bk", 6, "off", "selected"); %>>Off</option>
	    <option value="on" <% nvram_indexmatch("wl_wme_ap_bk", 6, "on", "selected"); %>>On</option>
	  </select>	</td>
  </tr>
  <tr>	
    <td class="CL" valign="top" rowspan="1"
	onMouseOver="return overlib('AP AC_VI parameters', LEFT);"
	onMouseOut="return nd();">
	<input type="hidden" name="wl_wme_ap_vi" value="5">
	AC_VI</td>
	<td><input name="wl_wme_ap_vi0" value="<% nvram_list("wl_wme_ap_vi", 0); %>" size="6" maxlength="6" onkeydown="return prevent_press_enter(event);"></td>
	<td><input name="wl_wme_ap_vi1" value="<% nvram_list("wl_wme_ap_vi", 1); %>" size="6" maxlength="6" onkeydown="return prevent_press_enter(event);"></td>
	<td><input name="wl_wme_ap_vi2" value="<% nvram_list("wl_wme_ap_vi", 2); %>" size="6" maxlength="6" onkeydown="return prevent_press_enter(event);"></td>
	<td><input name="wl_wme_ap_vi3" value="<% nvram_list("wl_wme_ap_vi", 3); %>" size="6" maxlength="6" onkeydown="return prevent_press_enter(event);"></td>
	<td><input name="wl_wme_ap_vi4" value="<% nvram_list("wl_wme_ap_vi", 4); %>" size="6" maxlength="6" onkeydown="return prevent_press_enter(event);"></td>
	<td>
          <select name="wl_wme_ap_vi5">
	    <option value="off" <% nvram_indexmatch("wl_wme_ap_vi", 5, "off", "selected"); %>>Off</option>
	    <option value="on" <% nvram_indexmatch("wl_wme_ap_vi", 5, "on", "selected"); %>>On</option>
	  </select>	</td>
	<td>
          <select name="wl_wme_ap_vi6">
	    <option value="off" <% nvram_indexmatch("wl_wme_ap_vi", 6, "off", "selected"); %>>Off</option>
	    <option value="on" <% nvram_indexmatch("wl_wme_ap_vi", 6, "on", "selected"); %>>On</option>
	  </select>	</td>
  </tr>
  <tr>	
    <td class="CL" valign="top" rowspan="1"
	onMouseOver="return overlib('AP AC_VO parameters', LEFT);"
	onMouseOut="return nd();">
	<input type="hidden" name="wl_wme_ap_vo" value="5">
	AC_VO</td>
	<td><input name="wl_wme_ap_vo0" value="<% nvram_list("wl_wme_ap_vo", 0); %>" size="6" maxlength="6" onkeydown="return prevent_press_enter(event);"></td>
	<td><input name="wl_wme_ap_vo1" value="<% nvram_list("wl_wme_ap_vo", 1); %>" size="6" maxlength="6" onkeydown="return prevent_press_enter(event);"></td>
	<td><input name="wl_wme_ap_vo2" value="<% nvram_list("wl_wme_ap_vo", 2); %>" size="6" maxlength="6" onkeydown="return prevent_press_enter(event);"></td>
	<td><input name="wl_wme_ap_vo3" value="<% nvram_list("wl_wme_ap_vo", 3); %>" size="6" maxlength="6" onkeydown="return prevent_press_enter(event);"></td>
	<td><input name="wl_wme_ap_vo4" value="<% nvram_list("wl_wme_ap_vo", 4); %>" size="6" maxlength="6" onkeydown="return prevent_press_enter(event);"></td>
	<td>
          <select name="wl_wme_ap_vo5">
	    <option value="off" <% nvram_indexmatch("wl_wme_ap_vo", 5, "off", "selected"); %>>Off</option>
	    <option value="on" <% nvram_indexmatch("wl_wme_ap_vo", 5, "on", "selected"); %>>On</option>
	  </select>	</td>
	<td>
          <select name="wl_wme_ap_vo6">
	    <option value="off" <% nvram_indexmatch("wl_wme_ap_vo", 6, "off", "selected"); %>>Off</option>
	    <option value="on" <% nvram_indexmatch("wl_wme_ap_vo", 6, "on", "selected"); %>>On</option>
	  </select>	</td>
  </tr>
  <tr>
    <td class="CL" valign="top" rowspan="1"
	onMouseOver="return overlib('WMM EDCA Parameters for STA.  CW value should be one less than a power of two.  TXOP limit should be a multiple of 32.', LEFT);"
	onMouseOut="return nd();">
	<input type="hidden" name="wme_sta" value="8">
	EDCA STA Parameters</td>
  </tr>
  <tr>	
    <td class="CL" valign="top" rowspan="1"
	onMouseOver="return overlib('STA AC_BE parameters', LEFT);"
	onMouseOut="return nd();">
	<input type="hidden" name="wl_wme_sta_be" value="5">
	AC_BE</td>
	<td><input name="wl_wme_sta_be0" value="<% nvram_list("wl_wme_sta_be", 0); %>" size="6" maxlength="6" onkeydown="return prevent_press_enter(event);"></td>
	<td><input name="wl_wme_sta_be1" value="<% nvram_list("wl_wme_sta_be", 1); %>" size="6" maxlength="6" onkeydown="return prevent_press_enter(event);"></td>
	<td><input name="wl_wme_sta_be2" value="<% nvram_list("wl_wme_sta_be", 2); %>" size="6" maxlength="6" onkeydown="return prevent_press_enter(event);"></td>
	<td><input name="wl_wme_sta_be3" value="<% nvram_list("wl_wme_sta_be", 3); %>" size="6" maxlength="6" onkeydown="return prevent_press_enter(event);"></td>
	<td><input name="wl_wme_sta_be4" value="<% nvram_list("wl_wme_sta_be", 4); %>" size="6" maxlength="6" onkeydown="return prevent_press_enter(event);"></td>
	<td><input name="wl_wme_sta_be5" value="<% nvram_list("wl_wme_sta_be", 5); %>" type="hidden"></td>
	<td><input name="wl_wme_sta_be6" value="<% nvram_list("wl_wme_sta_be", 6); %>" type="hidden"></td>
  </tr>
  <tr>	
    <td class="CL" valign="top" rowspan="1"
	onMouseOver="return overlib('STA AC_BK parameters', LEFT);"
	onMouseOut="return nd();">
	<input type="hidden" name="wl_wme_sta_bk" value="5">
	AC_BK</td>
	<td><input name="wl_wme_sta_bk0" value="<% nvram_list("wl_wme_sta_bk", 0); %>" size="6" maxlength="6" onkeydown="return prevent_press_enter(event);"></td>
	<td><input name="wl_wme_sta_bk1" value="<% nvram_list("wl_wme_sta_bk", 1); %>" size="6" maxlength="6" onkeydown="return prevent_press_enter(event);"></td>
	<td><input name="wl_wme_sta_bk2" value="<% nvram_list("wl_wme_sta_bk", 2); %>" size="6" maxlength="6" onkeydown="return prevent_press_enter(event);"></td>
	<td><input name="wl_wme_sta_bk3" value="<% nvram_list("wl_wme_sta_bk", 3); %>" size="6" maxlength="6" onkeydown="return prevent_press_enter(event);"></td>
	<td><input name="wl_wme_sta_bk4" value="<% nvram_list("wl_wme_sta_bk", 4); %>" size="6" maxlength="6" onkeydown="return prevent_press_enter(event);"></td>
	<td><input name="wl_wme_sta_bk5" value="<% nvram_list("wl_wme_sta_bk", 5); %>" type="hidden"></td>
	<td><input name="wl_wme_sta_bk6" value="<% nvram_list("wl_wme_sta_bk", 6); %>" type="hidden"></td>
  </tr>
  <tr>	
    <td class="CL" valign="top" rowspan="1"
	onMouseOver="return overlib('STA AC_VI parameters', LEFT);"
	onMouseOut="return nd();">
	<input type="hidden" name="wl_wme_sta_vi" value="5">
	AC_VI</td>
	<td><input name="wl_wme_sta_vi0" value="<% nvram_list("wl_wme_sta_vi", 0); %>" size="6" maxlength="6" onkeydown="return prevent_press_enter(event);"></td>
	<td><input name="wl_wme_sta_vi1" value="<% nvram_list("wl_wme_sta_vi", 1); %>" size="6" maxlength="6" onkeydown="return prevent_press_enter(event);"></td>
	<td><input name="wl_wme_sta_vi2" value="<% nvram_list("wl_wme_sta_vi", 2); %>" size="6" maxlength="6" onkeydown="return prevent_press_enter(event);"></td>
	<td><input name="wl_wme_sta_vi3" value="<% nvram_list("wl_wme_sta_vi", 3); %>" size="6" maxlength="6" onkeydown="return prevent_press_enter(event);"></td>
	<td><input name="wl_wme_sta_vi4" value="<% nvram_list("wl_wme_sta_vi", 4); %>" size="6" maxlength="6" onkeydown="return prevent_press_enter(event);"></td>
	<td><input name="wl_wme_sta_vi5" value="<% nvram_list("wl_wme_sta_vi", 5); %>" type="hidden"></td>
	<td><input name="wl_wme_sta_vi6" value="<% nvram_list("wl_wme_sta_vi", 6); %>" type="hidden"></td>
  </tr>
  <tr>	
    <td class="CL" valign="top" rowspan="1"
	onMouseOver="return overlib('STA AC_VO parameters', LEFT);"
	onMouseOut="return nd();">
	<input type="hidden" name="wl_wme_sta_vo" value="5">
	AC_VO</td>
	<td><input name="wl_wme_sta_vo0" value="<% nvram_list("wl_wme_sta_vo", 0); %>" size="6" maxlength="6" onkeydown="return prevent_press_enter(event);"></td>
	<td><input name="wl_wme_sta_vo1" value="<% nvram_list("wl_wme_sta_vo", 1); %>" size="6" maxlength="6" onkeydown="return prevent_press_enter(event);"></td>
	<td><input name="wl_wme_sta_vo2" value="<% nvram_list("wl_wme_sta_vo", 2); %>" size="6" maxlength="6" onkeydown="return prevent_press_enter(event);"></td>
	<td><input name="wl_wme_sta_vo3" value="<% nvram_list("wl_wme_sta_vo", 3); %>" size="6" maxlength="6" onkeydown="return prevent_press_enter(event);"></td>
	<td><input name="wl_wme_sta_vo4" value="<% nvram_list("wl_wme_sta_vo", 4); %>" size="6" maxlength="6" onkeydown="return prevent_press_enter(event);"></td>
	<td><input name="wl_wme_sta_vo5" value="<% nvram_list("wl_wme_sta_vo", 5); %>" type="hidden"></td>
	<td><input name="wl_wme_sta_vo6" value="<% nvram_list("wl_wme_sta_vo", 6); %>" type="hidden"></td>
  </tr>

  <tr>
    <td class="CL" valign="top" rowspan="1"
	onMouseOver="return overlib('WMM Tx retry limits, fallback limits and max rate parameters.', LEFT);"
	onMouseOut="return nd();">
	<input type="hidden" name="wme_txp" value="8">
	WMM TX Parameters</td>
    <td class="label">Short Retry<br>Limit</td>
    <td class="label">Short Fallbk<br>Limit</td>
    <td class="label">Long Retry<br>Limit</td>
    <td class="label">Long Fallbk<br>Limit</td>
    <td class="label">Max Rate<br>In 500 kbps<br>Disabled when 0<br></td>
  </tr>
  <tr>	
    <td class="CL" valign="top" rowspan="1"
	onMouseOver="return overlib('AC_BE Tx parameters', LEFT);"
	onMouseOut="return nd();">
	<input type="hidden" name="wl_wme_txp_be" value="5">
	AC_BE</td>
	<td><input name="wl_wme_txp_be0" value="<% nvram_list("wl_wme_txp_be", 0); %>" size="6" maxlength="6" onkeydown="return prevent_press_enter(event);"></td>
	<td><input name="wl_wme_txp_be1" value="<% nvram_list("wl_wme_txp_be", 1); %>" size="6" maxlength="6" onkeydown="return prevent_press_enter(event);"></td>
	<td><input name="wl_wme_txp_be2" value="<% nvram_list("wl_wme_txp_be", 2); %>" size="6" maxlength="6" onkeydown="return prevent_press_enter(event);"></td>
	<td><input name="wl_wme_txp_be3" value="<% nvram_list("wl_wme_txp_be", 3); %>" size="6" maxlength="6" onkeydown="return prevent_press_enter(event);"></td>
	<td><input name="wl_wme_txp_be4" value="<% nvram_list("wl_wme_txp_be", 4); %>" size="6" maxlength="6" onkeydown="return prevent_press_enter(event);"></td>
  </tr>
  <tr>	
    <td class="CL" valign="top" rowspan="1"
	onMouseOver="return overlib('AC_BK Tx parameters', LEFT);"
	onMouseOut="return nd();">
	<input type="hidden" name="wl_wme_txp_bk" value="5">
	AC_BK</td>
	<td><input name="wl_wme_txp_bk0" value="<% nvram_list("wl_wme_txp_bk", 0); %>" size="6" maxlength="6" onkeydown="return prevent_press_enter(event);"></td>
	<td><input name="wl_wme_txp_bk1" value="<% nvram_list("wl_wme_txp_bk", 1); %>" size="6" maxlength="6" onkeydown="return prevent_press_enter(event);"></td>
	<td><input name="wl_wme_txp_bk2" value="<% nvram_list("wl_wme_txp_bk", 2); %>" size="6" maxlength="6" onkeydown="return prevent_press_enter(event);"></td>
	<td><input name="wl_wme_txp_bk3" value="<% nvram_list("wl_wme_txp_bk", 3); %>" size="6" maxlength="6" onkeydown="return prevent_press_enter(event);"></td>
	<td><input name="wl_wme_txp_bk4" value="<% nvram_list("wl_wme_txp_bk", 4); %>" size="6" maxlength="6" onkeydown="return prevent_press_enter(event);"></td>
  </tr>
  <tr>	
    <td class="CL" valign="top" rowspan="1"
	onMouseOver="return overlib('AC_VI Tx parameters', LEFT);"
	onMouseOut="return nd();">
	<input type="hidden" name="wl_wme_txp_vi" value="5">
	AC_VI</td>
	<td><input name="wl_wme_txp_vi0" value="<% nvram_list("wl_wme_txp_vi", 0); %>" size="6" maxlength="6" onkeydown="return prevent_press_enter(event);"></td>
	<td><input name="wl_wme_txp_vi1" value="<% nvram_list("wl_wme_txp_vi", 1); %>" size="6" maxlength="6" onkeydown="return prevent_press_enter(event);"></td>
	<td><input name="wl_wme_txp_vi2" value="<% nvram_list("wl_wme_txp_vi", 2); %>" size="6" maxlength="6" onkeydown="return prevent_press_enter(event);"></td>
	<td><input name="wl_wme_txp_vi3" value="<% nvram_list("wl_wme_txp_vi", 3); %>" size="6" maxlength="6" onkeydown="return prevent_press_enter(event);"></td>
	<td><input name="wl_wme_txp_vi4" value="<% nvram_list("wl_wme_txp_vi", 4); %>" size="6" maxlength="6" onkeydown="return prevent_press_enter(event);"></td>
  </tr>
  <tr>	
    <td class="CL" valign="top" rowspan="1"
	onMouseOver="return overlib('AC_VO Tx parameters', LEFT);"
	onMouseOut="return nd();">
	<input type="hidden" name="wl_wme_txp_vo" value="5">
	AC_VO</td>
	<td><input name="wl_wme_txp_vo0" value="<% nvram_list("wl_wme_txp_vo", 0); %>" size="6" maxlength="6" onkeydown="return prevent_press_enter(event);"></td>
	<td><input name="wl_wme_txp_vo1" value="<% nvram_list("wl_wme_txp_vo", 1); %>" size="6" maxlength="6" onkeydown="return prevent_press_enter(event);"></td>
	<td><input name="wl_wme_txp_vo2" value="<% nvram_list("wl_wme_txp_vo", 2); %>" size="6" maxlength="6" onkeydown="return prevent_press_enter(event);"></td>
	<td><input name="wl_wme_txp_vo3" value="<% nvram_list("wl_wme_txp_vo", 3); %>" size="6" maxlength="6" onkeydown="return prevent_press_enter(event);"></td>
	<td><input name="wl_wme_txp_vo4" value="<% nvram_list("wl_wme_txp_vo", 4); %>" size="6" maxlength="6" onkeydown="return prevent_press_enter(event);"></td>
  </tr>
</table>
</div>

<div style="display:none">
<table width="100%" class="tbl_main">
  <tr>
    <td class="CL"
	onMouseOver="return overlib('Selecting <b>Wireless Bridge</b> disables access point functionality. Only wireless bridge (also known as Wireless Distribution System or WDS) functionality will be available. Selecting <b>Access Point</b> enables access point functionality. Wireless bridge functionality will still be available and wireless stations will be able to associate to the AP.', LEFT);"
	onMouseOut="return nd();">
	Mode</td>
    <td>
	<select name="wl_mode" onChange="wl_mode_onchange();">
	<% wl_mode_list();%>
	</select>    </td>
  </tr>
  <tr>
    <td class="CL"
	onMouseOver="return overlib('Sets Network.', LEFT);"
	onMouseOut="return nd();">
	Network</td>
    <td>
	<select name="wl_infra">
	  <option value="1" <% nvram_match("wl_infra", "1", "selected"); %>>BSS</option>
	  <option value="0" <% nvram_match("wl_infra", "0", "selected"); %>>IBSS</option>
	</select>    </td>
  </tr>
  <tr>
    <td class="CL"
	  onMouseOver="return overlib('Enable AP & Station functions for a single radio.  If the Router Mode (on the Basic page) is Router, then this makes the product into a Travel Router. If the Router Mode is AP, then this setting turns the product into a Range Extender.', LEFT);"
	onMouseOut="return nd();">
	URE Mode</td>
    <td>
	   <select name="wl_ure" onChange="wl_ure_onchange();">
	    <option value="0" <% wl_ure_list(0); %> >OFF</option>

	    <option value="1" <% wl_ure_list(1); %> >ON</option>
	   </select>    </td>
  </tr>
</table>
</div>

<div style="display:none">
<table width="100%" class="tbl_main">
  <tr>
    <td class="CL"
	onMouseOver="return overlib('Controls the STA behavior for the first assocaiation.  This parameter sets the time to wait between attempts to associate with the Access Point for the initial association.  Setting this to 0 seconds will cause the STA to only attempt association once.  Once the initial association is successful, the STA will always attempt re-associations.', LEFT);"
	onMouseOut="return nd();">
	STA Retry Time(sec)</td>
    <td>
	    <input name="wl_sta_retry_time" value="<% nvram_get("wl_sta_retry_time"); %>" size="4" maxlength="4" onkeydown="return prevent_press_enter(event);">    </td>
  </tr>
</table>
</div>

<div style="display:none">
<table width="100%" class="tbl_main">
	<tr>
		<td class="CL"
		onMouseOver="return overlib('Selects desired Bridge br0 or br1 .', LEFT);"
		onMouseOut="return nd();">
		Network Bridge:
		</td>
		<td class="CR">
			<!-- Tom.Hung 2013-3-21, fix the bridge to LAN -->
			<select name="wl_bridge" id="wl_bridge"><option value=0 selected>LAN</option></select>
		</td>
	</tr>  
</table>
</div>

<div style="display:none">
<table width="100%" class="tbl_main">
	<tr>
		<td class="CT" colspan="2"><!--#tr id="basic.10"-->Wireless Distribution System (WDS)<!--#endtr--></td>
	</tr>
	<tr>
		<td class="CL" valign="top" rowspan="5"
		onmouseover="return overlib('Enter the peer wireless MAC addresses of any wireless bridges that should be part of the wireless distribution system (WDS).', LEFT);"
		onmouseout="return nd();">
		<input type="hidden" name="wl_wds" value="4" />
		<!--#tr id="basic.11"-->AP MAC Address<!--#endtr-->
		</td>
	</tr>
	<tr>
		<td class="CR">
			<input id="macAddress0" name="wl_wds0" value="<% nvram_list("wl_wds", 0); %>" size="17" maxlength="17" onkeydown="return prevent_press_enter(event);" />
			&nbsp;&nbsp;<!--<% wl_wds_status(0); %>-->
		</td>
	</tr>
	<tr>
		<td class="CR">
			<input id="macAddress1" name="wl_wds1" value="<% nvram_list("wl_wds", 1); %>" size="17" maxlength="17" onkeydown="return prevent_press_enter(event);" />
			&nbsp;&nbsp;<!--<% wl_wds_status(1); %>-->
		</td>
	</tr>
	<tr>
		<td class="CR">
			<input id="macAddress2" name="wl_wds2" value="<% nvram_list("wl_wds", 2); %>" size="17" maxlength="17" onkeydown="return prevent_press_enter(event);" />
			&nbsp;&nbsp;<!--<% wl_wds_status(2); %>-->
		</td>
	</tr>
	<tr>
		<td class="CR">
			<input id="macAddress3" name="wl_wds3" value="<% nvram_list("wl_wds", 3); %>" size="17" maxlength="17" onkeydown="return prevent_press_enter(event);" />
			&nbsp;&nbsp;<!--<% wl_wds_status(3); %>-->
		</td>
	</tr>
	<tr style="display:none">
		<td class="CL"
		onmouseover="return overlib('Selecting <b>Disabled</b> disables wireless bridge restriction. Any wireless bridge (including the ones listed in <b>Remote Bridges</b>) will be granted access. Selecting <b>Enabled</b> enables wireless bridge restriction. Only those bridges listed in <b>Remote Bridges</b> will be granted access.', LEFT);"
		onmouseout="return nd();"> Bridge Restriction</td>
		<td class="CR">
			<select name="wl_lazywds">
				<option value="0" <% nvram_match("wl_lazywds", "0", "selected"); %>>Enabled</option>
				<option value="1" <% nvram_match("wl_lazywds", "1", "selected"); %>>Disabled</option>
			</select>
		</td>
	</tr>
	<tr style="display:none">
		<td class="CL"
		onmouseover="return overlib('Sets the Wireless bridge link detection interval in seconds. Leave blank or set to zero to disable the detection', LEFT);"
		onmouseout="return nd();"> Bridge Link Detection Interval</td>
		<td class="CR">
			<input name="wl_wds_timeout" value="<% nvram_get("wl_wds_timeout"); %>" size="10" maxlength="10" onkeydown="return prevent_press_enter(event);" />
		</td>
	</tr>
<!--
#ifdef BCMPLC
-->
	<tr style="display:none">
		<td class="CL"
		onmouseover="return overlib('When this option is enabled, PLC network is supported. When this option is disabled, PLC network is not supported.', LEFT);"
		onmouseout="return nd();"> PLC Support</td>
		<td class="CR">
			<select name="wl_plc">
				<option value="0" <% nvram_match("wl_plc", "0", "selected"); %>>Disabled</option>
				<option value="1" <% nvram_match("wl_plc", "1", "selected"); %>>Enabled</option>
			</select>
		</td>
	</tr>
<!--
#endif
-->
</table>
</div>
</form>

<!--
#ifdef BCMWAPI_WAI
-->
<form name="cert" method="post" action="../wireless/cert_ul.cgi" enctype="multipart/form-data">
<div style="display:none">
<table width="100%" class="tbl_main">
  <tr>
    <td class="CL"
	onMouseOver="return overlib('Displays the current installed certificate status.', LEFT);"
	onMouseOut="return nd();">
	<!--#tr id="security.30"-->Certificate Status<!--#endtr-->
    </td>
    <td class="CR">
		<% nvram_match("wl_wai_cert_status", "1", "Valid"); %>
		<% nvram_match("wl_wai_cert_status", "2", "Invalid"); %>
	</td>
  </tr>
  <tr>
    <td class="CL"
	onMouseOver="return overlib('Below push button to install X.509 certificate', LEFT);"
	onMouseOut="return nd();">
	<!--#tr id="security.31"-->Install Certificate<!--#endtr-->
	</td>
  </tr>
  <tr>
    <td class="CL"
	onMouseOver="return overlib('Enter filename of ASU ceritificate here.', LEFT);"
	onMouseOut="return nd();">
	<!--#tr id="security.32"-->ASU Certificate File<!--#endtr-->
    </td>
    <td class="CR"><input type="file" name="as_cerfile"></td>
  </tr>
  <tr>
    <td class="CL"
	onMouseOver="return overlib('Enter filename of user ceritificate here.', LEFT);"
	onMouseOut="return nd();">
	<!--#tr id="security.33"-->User Certificate File<!--#endtr-->
    </td>
    <td class="CR"><input type="file" name="user_cerfile"></td>
  </tr>
  <tr>
    <td class="CL">
	</td>
	<td class="CR"><input type="submit" value="<!--#tr id="security.34"-->Install X.509 Certificate<!--#endtr-->" onClick="submit()"></td>
  </tr>
</table>
</div>
</form>
<!--
#endif
-->


</td></tr></table>
	</div>
</div>
</div>
</body>
</html>
