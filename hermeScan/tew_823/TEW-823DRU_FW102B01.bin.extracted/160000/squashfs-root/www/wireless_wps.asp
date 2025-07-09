<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html lang="en-US" xmlns="http://www.w3.org/1999/xhtml" xml:lang="en-US">
<head>
<title>TRENDNET | modelName | Wireless 2.4GHz | WPS</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<link href="/css/style.css" rel="stylesheet" type="text/css" />
<link href="/css/css_router.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="/uk_<!--# echo language -->.js"></script>
<script type="text/javascript" src="public_tew.js"></script>
<script type="text/javascript" src="public_msg.js"></script>
<script type="text/javascript" src="public_ipv6.js"></script>
<script type="text/javascript" src="pandoraBox.js"></script>
<script type="text/javascript" src="menu_all.js"></script>
<script type="text/javascript" src="js/jquery-1.3.2.min.js"></script>
<script type="text/javascript" src="js/xml.js"></script>
<script type="text/javascript" src="js/object.js"></script>
<script type="text/javascript" src="js/ddaccordion.js"></script>
<script type="text/javascript" src="js/ccpObject.js"></script>
<script type="text/javascript">
	var def_title = document.title;
	var model = "<!--# echo model_number -->";
	document.title = def_title.replace("modelName", model);

	var menu = new menuObject();
	var xmlhttp;

	var security;
	security = "<!--# echo wlan0_vap0_security -->";
	var sec_vap0 = security.split("_");
	security = "<!--# echo wlan0_vap2_security -->";
	var sec_vap2 = security.split("_");
	security = "<!--# echo wlan0_vap3_security -->";
	var sec_vap3 = security.split("_");

	var wlanCfg = {
	  'enable':          ['<!--# echo wlan0_vap0_enable -->', '<!--# echo wlan0_vap2_enable -->', '<!--# echo wlan0_vap3_enable -->'],
	  'standard':        ['<!--# echo wlan0_dot11_mode -->'],
	  'security':        [sec_vap0[0], sec_vap2[0], sec_vap3[0]],
	  'vs':              ['<!--# echo wlan0_vap0_ssid_broadcast -->']
	};
	var wpaCfg = {
	  'wpamode' :        [sec_vap0[1], sec_vap2[1], sec_vap3[1]],
	  'wpacipher':       ['<!--# echo wlan0_vap0_psk_cipher_type -->','<!--# echo wlan0_vap2_psk_cipher_type -->','<!--# echo wlan0_vap3_psk_cipher_type -->'],
	  'wpakey':          ['<!--# echot wlan0_vap0_psk_pass_phrase -->']
	};
	var wpsCfg = {
	  'enable':          '<!--# echo wlan0_wps_enable -->',
	  'state':           '<!--# echo wlan0_wps_configured_mode -->',
	  'locked':          '<!--# echo wlan0_wps_lock -->',
	  'selfpin':         '<!--# echo wps_pin -->'
	};
	var mac_filter_type = ["<!--# echo wlan0_vap0_mac_filter_type -->", "<!--# echo wlan0_vap1_mac_filter_type -->",
	                       "<!--# echo wlan0_vap2_mac_filter_type -->", "<!--# echo wlan0_vap3_mac_filter_type -->"];

	function check_pin()
	{
		var accum = 0;
		accum += 3 * Math.floor((PIN / 10000000) % 10);
		accum += 1 * Math.floor((PIN / 1000000) % 10);
		accum += 3 * Math.floor((PIN / 100000) % 10);
		accum += 1 * Math.floor((PIN / 10000) % 10);
		accum += 3 * Math.floor((PIN / 1000) % 10);
		accum += 1 * Math.floor((PIN / 100) % 10);
		accum += 3 * Math.floor((PIN / 10) % 10);
		accum += 1 * Math.floor((PIN / 1) % 10);
		return (0 == (accum % 10));
	}

	function chk_format() {
		//20120119 silvia add chk pin format - 0130 modify 8 num
		PIN = $('#PIN').val();
		var pins1 = PIN.split(' ');
		var pins2 = PIN.split('-');
		var pins3 = PIN.split('');
	
		if ((pins3[4] == '-') || (pins3[4] == ' ')) {
			if (pins1.length==2)
				PIN = pins1[0] +pins1[1];
			else if (pins2.length==2)
				PIN = pins2[0] +pins2[1];
			if(!_isNumeric(PIN) || pins3.length != 9)
			{
				alert(get_words('KR22_ww'));
				return false;
			}
		} else if ((pins3.length == 8)&&(_isNumeric(PIN))) {
			return;
		} else {
			alert(get_words('pin_f'));
			return false;
		}
	}

	function wps_apply()
	{
		var obj = new ccpObject();
		obj.set_param_url('apply.cgi');
		obj.set_ccp_act('set');
		obj.add_param_event('adv_wps');
		obj.set_param_next_page('wireless_wps.asp');
		obj.add_param_arg('reboot_type', 'wireless');

		//WPS Config
		obj.add_param_arg('wlan0_wps_enable',$('#WPSEnable').val());
		obj.add_param_arg('wlan0_wps_lock',$('#WPSEG').val());

		var paramForm = obj.get_param();

		totalWaitTime = 10; //second
		redirectURL = location.pathname;
		wait_page();
		jq_ajax_post(paramForm.url, paramForm.arg);
	}

	/* WPS common*/
	var count=120;
	
	var now = new Date();
	
	function do_count_down()
	{
		if (count <= 0) {
			var path = "wireless_wps.asp";
			window.location.href = path;
		}

		if (count > 0) {
			$('#WPSCurrentStatus').html(get_words('_processing'));
			$('#WPSCountdown').html('...'+count--);
			get_file();
			setTimeout('do_count_down()',1000);
		}
	}

	function createRequest() {
		var XMLhttpObject = false;
		if (window.XMLHttpRequest) {
			try {
				XMLhttpObject = new XMLHttpRequest();
			} catch (e) {
			}
		} else if (window.ActiveXObject) {
			try {
				XMLhttpObject = new ActiveXObject("Msxml2.XMLHTTP");
			} catch (e) {
				try {
					XMLhttpObject = new ActiveXObject("Microsoft.XMLHTTP");
				} catch (e) {
					return null;
				}
			}
		}
		return XMLhttpObject;
	}

	function get_file()
	{
		xmlhttp = new createRequest();
		if (xmlhttp) {
			var url = "";
			var temp_cURL = document.URL.split("/");
			for (var i = 0; i < temp_cURL.length-1; i++) {
				if (i == 1) continue;
				if (i == 0)
					url += temp_cURL[i] + "//";
				else
					url += temp_cURL[i] + "/";
			}
			url += "check_wps_connect.xml";
			xmlhttp.onreadystatechange = xmldoc;
			xmlhttp.open("GET", url, true);
			xmlhttp.send(null); 
		}
	}

	function xmldoc()
	{
		if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
			try {
				var wps_connected = xmlhttp.responseXML.getElementsByTagName("wps_connected")[0].firstChild.nodeValue;
			} catch (e) {
				var wps_connected = xmlhttp.responseXML.getElementsByTagName("wps_connected")[0].firstChild.nodeValue;
			}
		}

		if (wps_connected == "1")   /* successful to connect */
			count = 0;
	}

	function sendWPSPIN()
	{
		var time=new Date().getTime();
		var ajax_param = {
			type:   "POST",
			async:  false,
			url:    'apply.cgi',
			data:   'action=set_sta_enrollee_pin_24g'+
			        "&wps_sta_enrollee_pin="+$('#PIN').val()+
			        "&"+time+"="+time,

			success: function(data) {
			}
		};
		$.ajax(ajax_param);
	}

	function ConfigByPIN()
	{
		if(checkPIN())
		{
			grayOutButton(true);
			sendWPSPIN();
			do_count_down();
		}
	}

	function checkPIN()
	{
		var pinnum = $('#PIN').val();
		if (pinnum.length == 4)
		{
			if (!_isNumeric(pinnum))
			{
				alert(get_words('pin_f'));
				return false;
			}
			PIN = pinnum;
		}else{
			if (chk_format() == false)
				return false;
			if (!check_pin() || pinnum =='')
			{
				alert(get_words('KR22_ww'));
				return false;
			}
		}
		return true;
	}

	function sendWPSPBC()
	{
		var time=new Date().getTime();
		var ajax_param = {
			type:   "POST",
			async:  false,
			url:    'apply.cgi',
			data:   'action=virtual_push_button_24g'+
			        "&"+time+"="+time,

			success: function(data) {
			}
		};
		$.ajax(ajax_param);
	}

	function ConfigByPBC()
	{
		grayOutButton(true);
		sendWPSPBC();
		do_count_down();
	}

	function isWPS2_0(idx)
	{
		var secMode = wlanCfg.security[idx];
		var wpaMode = wpaCfg.wpamode[idx];
		var wpaEncrMode = wpaCfg.wpacipher[idx];
		if((secMode=='wep') || //WEP
		   ((secMode=='wpa') && ((wpaEncrMode=='tkip') || (wpaMode=='eap'))) ||
		   ((secMode=='wpa2' || secMode=='wpa2auto') && ((wpaMode=='eap')))
		  )
		{
			return true;
		}
		return false;
	}

	function setValueWPS()
	{
		var sel_enable = wpsCfg.enable;
		$('#WPSEnable').val(sel_enable);
		if((wlanCfg.enable[0]=='1' && isWPS2_0(0)) || // host
		  (wlanCfg.enable[1]=='1' && isWPS2_0(1))  || // multi0
		  (wlanCfg.enable[2]=='1' && isWPS2_0(2))     // multi1
		)
			$('#WPSEnable').attr('disabled', true);
		if(wlanCfg.vs[0]=='0')
			$('#WPSEnable').attr('disabled', true);

		if(mac_filter_type[0] != "disable" ||
		   mac_filter_type[1] != "disable" ||
		   mac_filter_type[2] != "disable" ||
		   mac_filter_type[3] != "disable"
		)
			$('#WPSEnable').attr('disabled', true);

		if(sel_enable=='1')
		{
			$('#APLock').show();
			$('#div_wps_status').show();
			$('#div_wps').show();
		}
	}

	function setValueWPSExternalRgistrarLock()
	{
		var sel_locked = wpsCfg.locked;
		$('#WPSEG').val(sel_locked);
	}

	function setValueWPSConfigured()
	{
		var val_conf = wpsCfg.state;
		$('#WPSConfigured').html((val_conf=='5'?get_words('_yes'):get_words('_unknown')));
	}

	function setValueWPSSecurityMode(){
		var val_mode = wlanCfg.security[0];
		var w_mode;
		switch(val_mode)
		{
			case "wpa":
				var wpamode = "";
				//var ciphermode = "";
				if(wpaCfg.wpamode[0] == "psk") {
					wpamode = get_words('bws_WPAM_1');
					w_mode = wpamode+ " - PSK"
				}
				if(wpaCfg.wpamode[0] == "eap") {
					wpamode = get_words('bws_WPAM_1');
					w_mode = (wpamode+ " - EAP");
				}
				break;
			case "wpa2":
				var wpamode = "";
				//var ciphermode = "";
				if(wpaCfg.wpamode[0] == "psk") {
					wpamode = get_words('bws_WPAM_3');
					w_mode = wpamode+ " - PSK"
				}
				if(wpaCfg.wpamode[0] == "eap") {
					wpamode = get_words('bws_WPAM_3');
					w_mode = (wpamode+ " - EAP");
				}
				break;
			case "wpa2auto":
				var wpamode = "";
				//var ciphermode = "";
				if(wpaCfg.wpamode[0] == "psk") {
					wpamode = get_words('bws_WPAM_2');
					w_mode = wpamode+ " - PSK"
				}
				if(wpaCfg.wpamode[0] == "eap") {
					wpamode = get_words('bws_WPAM_2');
					w_mode = (wpamode+ " - EAP");
				}
				break;
			case "disable":
				w_mode = get_words('_disable');
				break;
			default:
				w_mode = get_words('_disable');
				break;
		}
		$('#WPSAuthMode').html(w_mode);
	}

	function setValueWPSEncryptType()
	{
		var val_mode = wlanCfg.security[0];
		var w_type='';
		switch(val_mode)
		{
			case "disable":
				$('#wpsEncTypeField').hide();
			case "2":
			case "wpa":
				if(wpaCfg.wpamode[0] == "psk") {
					if(wpaCfg.wpacipher[0]=='tkip')
						w_type=get_words('bws_CT_1');
					else if(wpaCfg.wpacipher[0]=='aes')
						w_type=get_words('bws_CT_2');
					else if(wpaCfg.wpacipher[0]=='both')
						w_type=get_words('bws_CT_3');
				}
				break;
			case "wpa2":
				if(wpaCfg.wpamode[0] == "psk") {
					if(wpaCfg.wpacipher[0]=='tkip')
						w_type=get_words('bws_CT_1');
					else if(wpaCfg.wpacipher[0]=='aes')
						w_type=get_words('bws_CT_2');
					else if(wpaCfg.wpacipher[0]=='both')
						w_type=get_words('bws_CT_3');
				}
				break;
			case "wpa2auto":
				if(wpaCfg.wpamode[0] == "psk") {
					if(wpaCfg.wpacipher[0]=='tkip')
						w_type=get_words('bws_CT_1');
					else if(wpaCfg.wpacipher[0]=='aes')
						w_type=get_words('bws_CT_2');
					else if(wpaCfg.wpacipher[0]=='both')
						w_type=get_words('bws_CT_3');
				}
				break;
			default:
				break;
		}
		$('#WPSEncryptype').html(w_type);
	}

	function setValueWPSKeyType()
	{
		var w_keytype='';
		var val_mode = wlanCfg.security[0];
		var val_wps = wpaCfg.wpamode[0];
		switch(val_mode)
		{
			case 'disable':
				$('#wpsKeyField').hide();
				break;
			case 'wpa2':
			case 'wpa2auto':
				if (val_wps == "psk")
					w_keytype = get_words('_wps_key');
				break;
		}
		$('#WPSKeyType').html(w_keytype);
	}

	function setValueWPSKey()
	{
		var val_key='';
		var val_mode = wlanCfg.security[0];
		var val_wps = wpaCfg.wpamode[0];
		switch(val_mode)
		{
			case 'wpa2':
			case 'wpa2auto':
				if (val_wps == "psk")
					val_key = wpaCfg.wpakey[0];
				break;
		}
		$('#WPSKey').html(val_key);
	}

	function setValueAPPIN()
	{
		var val_ping = wpsCfg.selfpin;
		$('#APPIN').html(val_ping);
	}

	function setValueWPSSummary()
	{
		setValueWPSConfigured();
		setValueWPSSecurityMode();
		setValueWPSEncryptType();
		setValueWPSKeyType();
		setValueWPSKey();
		setValueAPPIN();
		setTimeout("setValueWPSSummary();", 5000);
	}

	function grayOutButton(isGray)
	{
		if(isGray)
		{
			$('#submitWPS_PIN').attr('disabled', 'disabled');
			$('#submitWPS_PBC').attr('disabled', 'disabled');
			$('#submitWPSEnable').attr('disabled', 'disabled');
		}
		else
		{
			$('#submitWPS_PIN').removeAttr('disabled');
			$('#submitWPS_PBC').removeAttr('disabled');
			$('#submitWPSEnable').removeAttr('disabled');
		}
	}

	$(function(){
		if(wlanCfg.enable[0]==1)
			$('#radioOnField').show();
		else
			$('#radioOffField').show();
		//WPS Config
		setValueWPS();
		setValueWPSExternalRgistrarLock();

		//WPS Summary
		setValueWPSSummary();
	});
</script>
</head>
<body>
<div class="wrapper"> 
<table border="0" width="950" cellpadding="0" cellspacing="0" align="center">
<!-- banner and model description-->
<tr>
	<td class="header_1">
		<table border="0" cellpadding="0" cellspacing="0" style="position:relative;width:920px;top:8px;" class="maintable">
		<tr>
			<td valign="top"><img src="/image/logo.png" /></td>
			<td align="right" valign="middle" nowrap="nowrap" class="description" style="width:600px;line-height:1.5em;">
			<script>show_words('PRODUCT_DESC')</script>
			<br><script>document.write(model);</script></br></td>
		</tr>
		</table>
	</td>
</tr>
<!-- End of banner and model description-->

<tr>
	<td>
		<table border="0" cellpadding="0" cellspacing="0" style="position:relative;width:950px;top:10px;margin-left:5px;" class="maintable">
		<!-- upper frame -->
		<tr>
			<td><img src="/image/bg_topl.gif" width="270" height="7" /></td>
			<td><img src="/image/bg_topr_01.gif" width="680" height="7" /></td>
		</tr>
		<!-- End of upper frame -->

		<tr>
			<!-- left menu -->
			<td style="background-image:url('/image/bg_l.gif');background-repeat:repeat-y;vertical-align:top;" width="270">
				<div style="padding-left:6px;">
				<script>document.write(menu.build_structure(1,2,3))</script>
				<p>&nbsp;</p>
				</div>
				<img src="/image/bg_l.gif" width="270" height="5" />
			</td>
			<!-- End of left menu -->

			<td style="background-image:url('/image/bg_r.gif');background-repeat:repeat-y;vertical-align:top;" width="680">
				<img src="/image/bg_topr_02.gif" width="680" height="5" />
				<table border="0" cellpadding="0" cellspacing="0">
				<tr>
					<td valign="top" style="width:650px;padding-left:10px;">
						<table width="100%" border="0" cellpadding="0" cellspacing="0">
						<tr>
							<td valign="top">
							<iframe class="rebootRedirect" name="rebootRedirect" id="rebootRedirect" frameborder="0" width="1" height="1" scrolling="no" src="" style="visibility: hidden;">redirect</iframe>
							<div id="waitform"></div>
							<div id="waitPad" style="display: none;"></div>
							<div id="mainform">
								<!-- main content -->
									<div class="headerbg" id="basicTitle">
									<script>show_words('LW65')</script>
									</div>
									<div class="hr"></div>
									<div class="section_content_border">
									<div class="header_desc" id="basicIntroduction">
										<script>show_words('_desc_wps')</script>
										<p></p>
									</div>

<div id="radioOnField" style="display:none;">
<div class="box_tn">
	<div class="CT"><script>show_words('_wps_config')</script></div>
	<table cellspacing="0" cellpadding="0" class="formarea">
		<tr>
			<td class="CL"><script>show_words('_WPS');</script></td>
			<td class="CR">
				<select id="WPSEnable" name="WPSEnable" size="1">
					<option value="0"><script>show_words('_disable');</script></option>
					<option value="1"><script>show_words('_enable');</script></option>
				</select>
			</td>
		</tr>
		<tr id="APLock" style="display: none;">
			<td class="CL"><script>show_words('_lb_wps_ext_reg_lock');</script></td>
			<td class="CR">
				<select id="WPSEG" name="WPSEG" size="1"><!-- onchange="checkWPSLock()" -->
					<option value="0"><script>show_words('_disable');</script></option>
					<option value="1"><script>show_words('_enable');</script></option>
				</select>
			</td>
		</tr>
		<tr align="center">
			<td colspan="2" class="btn_field">
			<input type="button" class="button_submit" value="Apply" id="submitWPSEnable" name="submitWPSEnable" onclick="wps_apply();" /></td>
			<script>$('#submitWPSEnable').val(get_words('_apply'));</script>
		</tr>
	</table>
</div>

<div id="div_wps_status" class="box_tn" style="display: none;">
	<div class="CT"><script>show_words('_wps_summary');</script></div>
	<table name="div_wps_status" cellspacing="0" cellpadding="0" class="formarea">
	<!--------------------  WPS Summary  -------------------------- -->
		<tr>
			<td class="CL"><script>show_words('_wps_cur_state');</script></td>
			<td class="CR"><span id="WPSCurrentStatus"><script>show_words('psIdle');</script></span><span id="WPSCountdown"></span></td>
		</tr>
		<tr>
			<td class="CL"><script>show_words('_wps_configed');</script></td>
			<td class="CR"><span id="WPSConfigured"></span></td>
		</tr>
		<tr class="break_word">
			<td class="CL"><script>show_words('_wps_ssid');</script></td>
			<td class="CR"><!--# echot wlan0_vap0_ssid --></td>
		</tr>
		<tr>
			<td class="CL"><script>show_words('_wps_sec_mode');</script></td>
			<td class="CR"><span id="WPSAuthMode"></span></td>
		</tr>
		<tr id="wpsEncTypeField">
			<td class="CL"><script>show_words('_wps_enc_type');</script></td>
			<td class="CR"><span id="WPSEncryptype"></span></td>
		</tr>
		<tr id="wpsKeyField" class="break_word">
			<td class="CL"><span id="WPSKeyType"></span></td>
			<td class="CR"><span id="WPSKey"><br></span></td>
		</tr>
		<tr>
			<td class="CL"><script>show_words('_ap_pin');</script></td>
			<td class="CR"><span id="APPIN"></span></td>
		</tr>
	</table>
</div>

<div id="div_wps" class="box_tn" style="display: none;">
	<div class="CT"><script>show_words('_wps_action');</script></div>
	<table name="div_wps" cellspacing="0" cellpadding="0" class="formarea">
	<tr><td colspan="2" class="CELL"><script>show_words('_desc_wps_action');</script></td></tr>
		<tr>
			<td class="CL">PIN</td>
			<td class="CR">
				<input value="" name="PIN" id="PIN" size="9" maxlength="9" type="text" />
				<input type="button" class="button_submit_NoWidth" value="Configure via PIN" id="submitWPS_PIN" name="submitWPS" onclick="ConfigByPIN();" />
				<script>$('#submitWPS_PIN').val(get_words('_config_via_pin'));</script>
			</td>
		</tr>
		<tr>
			<td class="CL">PBC</td>
			<td class="CR">
				<input type="button" class="button_submit_NoWidth" value="Configure via PBC" id="submitWPS_PBC" name="submitWPS" onclick="ConfigByPBC();" />
				<script>$('#submitWPS_PBC').val(get_words('_config_via_pbc'));</script>
			</td>
		</tr>
	</table>
</div>

<div id="div_11n_plugfest" class="box_tn" style="display:none">
	<div class="CT"><script>show_words('at_Prot_1');</script></div>
	<table name="div_11n_plugfest" cellspacing="0" cellpadding="0" class="formarea">
	</table>
</div>
</div>

<div id="radioOffField" class="box_tn" style="display: none;">
	<table cellspacing="0" cellpadding="0" class="formarea">
		<tr>
			<td colspan="2" align="center" class="CELL"><font color="red" id="Msg" name="Msg"><script>show_words('_MSG_woff');</script></font></td>
		</tr>
	</table>
</div>
</div>
								<!-- End of main content -->
							<br/>
							</div>
							</td>
						</tr>
						</table>
					</td>
				</tr>
				</table>
			</td>
		</tr>
		<!-- lower frame -->
		<tr>
			<td><img src="/image/bg_butl.gif" width="270" height="12" /></td>
			<td><img src="/image/bg_butr.gif" width="680" height="12" /></td>
		</tr>
		<!-- End of lower frame -->

		</table>
		<!-- footer -->
		<div class="footer">
			<table border="0" cellpadding="0" cellspacing="0" style="width:920px;" class="maintable">
			<tr>
				<td align="left" valign="top" class="txt_footer">
				<br><script>show_words("_copyright");</script></td>
				<td align="right" valign="top" class="txt_footer">
				<br><a href="http://www.trendnet.com/register" target="_blank"><img src="/image/icons_warranty_1.png" style="border:0px;vertical-align:middle;padding-right:10px;" border="0" /><script>show_words("_warranty");</script></a></td>
			</tr>
			</table>
		</div>
		<!-- end of footer -->

	</td>
</tr>
</table><br/>
</div>
</body>
</html>
