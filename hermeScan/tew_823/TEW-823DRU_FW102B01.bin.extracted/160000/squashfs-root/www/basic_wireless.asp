<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html lang="en-US" xmlns="http://www.w3.org/1999/xhtml" xml:lang="en-US">
<head>
<title>TRENDNET | modelName | Basic | Wireless</title>
<meta http-equiv=Content-Type content="text/html; charset=UTF-8">
<!--<link rel="STYLESHEET" type="text/css" href="/css_router.css">-->
<link href="/css/style.css" rel="stylesheet" type="text/css" />
<link href="/css/css_router.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="/uk_<!--# echo language -->.js"></script>
<script type="text/javascript" src="public_tew.js"></script>
<script type="text/javascript" src="public_msg.js"></script>
<script type="text/javascript" src="public_ipv6.js"></script>
<!--<script lang="javascript" src="/jquery-1.6.1.min.js"></script>-->
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
	var submit_c	= "";
	var tmp_wlan0 = <!--# echo wlan0_vap0_enable -->;
	var tmp_wlan1 = <!--# echo wlan1_vap0_enable -->;
	var submit_button_flag = 0;
	var obj = new ccpObject();

	var wpsCfg = {
		'enable':            [<!--# echo wlan0_wps_enable -->, <!--# echo wlan1_wps_enable -->]
	};
	

	var is_wps = wpsCfg.enable[0];     /* wps enable or not */
	var is_wps_5 = wpsCfg.enable[1];   /* wps_5G enable or not */
	
	var schedule_cnt = 0;
	var schCfg = {
		'name':              ['<!--# echo schedule_rule_00 -->', '<!--# echo schedule_rule_01 -->', '<!--# echo schedule_rule_02 -->',
		                      '<!--# echo schedule_rule_03 -->', '<!--# echo schedule_rule_04 -->', '<!--# echo schedule_rule_05 -->',
		                      '<!--# echo schedule_rule_06 -->', '<!--# echo schedule_rule_07 -->', '<!--# echo schedule_rule_08 -->',
		                      '<!--# echo schedule_rule_09 -->', '<!--# echo schedule_rule_10 -->', '<!--# echo schedule_rule_11 -->',
		                      '<!--# echo schedule_rule_12 -->', '<!--# echo schedule_rule_13 -->', '<!--# echo schedule_rule_14 -->',
		                      '<!--# echo schedule_rule_15 -->', '<!--# echo schedule_rule_16 -->', '<!--# echo schedule_rule_17 -->',
		                      '<!--# echo schedule_rule_18 -->', '<!--# echo schedule_rule_19 -->', '<!--# echo schedule_rule_20 -->',
		                      '<!--# echo schedule_rule_21 -->', '<!--# echo schedule_rule_22 -->', '<!--# echo schedule_rule_23 -->',
		                      '<!--# echo schedule_rule_24 -->', '<!--# echo schedule_rule_25 -->', '<!--# echo schedule_rule_26 -->',
		                      '<!--# echo schedule_rule_27 -->', '<!--# echo schedule_rule_28 -->', '<!--# echo schedule_rule_29 -->',
		                      '<!--# echo schedule_rule_30 -->', '<!--# echo schedule_rule_31 -->'
		                     ]
	};

	if(schCfg.name != null)
		schedule_cnt = schCfg.name.length;

	for (var i = 0, tmp; i < schedule_cnt; ++i) {
		tmp = schCfg.name[i].split("/");

		if(tmp == "") {
			schedule_cnt = i;
			break;
		}

		schCfg.name[i] = tmp[0];
	}

	function add_option()
	{
		var obj = null;
		var arr = null;
		var nam = null;

		obj = schedule_cnt;
		nam = schCfg.name;

		if (obj == null)
			return;

		for (var i = 0; i < obj; i++)
			document.write("<option value=" + nam[i] + ">" + nam[i] + "</option>");
	}	

	function check_value()
	{
		var ssid_vs = $('input[name=wlan0_vap0_ssid_broadcast]:checked').val();
		var ssid_vs1 = $('input[name=wlan1_vap0_ssid_broadcast]:checked').val();
		var alert_st = 0;	// value != 0 not alert msg yet

		if (is_wps == 1)
		{
			if (ssid_vs == 0 && alert_st == 0)
			{
				alert_st = -1;
				if (confirm(get_words("msg_wps_sec_03")) == false)
					return false;
				else
					is_wps = 0;
			}
		}
		if (is_wps == 1)
		{
			if (ssid_vs1 == 0 && alert_st == 0)
			{
				alert_st = -1;
				if (confirm(get_words("msg_wps_sec_03")) == false)
					return false;
				else
					is_wps_5 = 0;
			}
		}
		/*
		** Date:	2013-05-03
		** Author:	Moa Chung
		** Reason:	Wireless 2.4G/5G → basic：When security mode is WEP/WPA-TKIP, you can not set 802.11n only.
		** Note:	TEW-810DR pretest no. 112,118,131
		**/

		var security_mode = $('security_mode').val();
		var security_mode1 = $('security_mode1').val();
		var wpa_cipher = $('input[name=cipher]:checked').val();
		var wpa_cipher1 = $('input[name=cipher1]:checked').val();
		
		if ($('#dot11_mode').val() == "11n") {
			if ((security_mode == "OPEN" || security_mode == "SHARED" || security_mode == "WEPAUTO") ||
			    wpa_cipher == 0) {
				alert(get_words('_wlan_11n_not_support_wep_wpa_tkip'));
				return false;
			}
		}
		if ($('#dot11_mode1').val() == "11n")	{
			if ((security_mode1 == "OPEN" || security_mode1 == "SHARED" || security_mode1 == "WEPAUTO") ||
			    wpa_cipher1 == 0) {
				alert(get_words('_wlan_11n_not_support_wep_wpa_tkip'));
				return false;
			}
		}
		if(!(check_ssid_0("show_ssid_0")))
			return false;
		if(!(check_ssid_0("show_ssid1_0")))
			return false;
		return true;
	}
	
  function check_psk(){
		var psk_value = get_by_id("passphrase").value;
		if (psk_value.length < 8){                   
			alert(get_words('YM116'));
				return false;
		}else if (psk_value.length > 63){
			if(!isHex(psk_value)){
				alert(get_words('GW_WLAN_WPA_PSK_HEX_STRING_INVALID'));
				return false;
			}
        }
        return true;         
  }
    
    
  function check_psk_1(){
		var psk_value = get_by_id("passphrase1").value;
		if (psk_value.length < 8){                   
			alert(get_words('YM116'));
				return false;
		}else if (psk_value.length > 63){
			if(!isHex(psk_value)){
				alert(get_words('GW_WLAN_WPA_PSK_HEX_STRING_INVALID'));
				return false;
			}
        }
        return true;         
  }	

	function check_apply()
	{
		obj.set_param_url('apply.cgi');
		obj.set_ccp_act('set');
		obj.add_param_event('wlan_concurrent');
		obj.set_param_next_page('basic_wireless.asp');
		obj.add_param_arg('reboot_type', 'wireless');

		var wlan1_dot11_mode = get_by_id("dot11_mode1").value;
		
		if(!(check_ssid_0("show_ssid_0"))){
				return false;
		}
		if(!(check_ssid_0("show_ssid1_0"))){
				return false;
		}
		
		<!--save wireless network setting-2.4G-->
		obj.add_param_arg('wlan0_vap0_enable',tmp_wlan0);
		var tmp_auto_channel = get_by_id("sel_wlan0_channel").value;
		if (tmp_auto_channel == "AutoSelect") {
			obj.add_param_arg('wlan0_auto_channel_enable','1');
		} else {		
			obj.add_param_arg('wlan0_auto_channel_enable','0');
			obj.add_param_arg('wlan0_channel',$('#sel_wlan0_channel').val());
		}
		
		obj.add_param_arg('wlan0_dot11_mode',$('#dot11_mode').val());
		obj.add_param_arg('wlan0_11n_protection', send_protection_value());		
		obj.add_param_arg('wlan0_vap0_wep_default_key',$('#wep_def_key').val());
		send_txrate_value();

		<!--save wireless network setting-5G-->
		obj.add_param_arg('wlan1_vap0_enable',tmp_wlan1);
		var tmp_auto_channel1 = get_by_id("sel_wlan1_channel").value;
		if (tmp_auto_channel1 == "AutoSelect") {
			obj.add_param_arg('wlan1_auto_channel_enable','1');
		} else {
			obj.add_param_arg('wlan1_auto_channel_enable','0');
			obj.add_param_arg('wlan1_channel',$('#sel_wlan1_channel').val());
		}

		obj.add_param_arg('wlan1_dot11_mode',$('#dot11_mode1').val());
		obj.add_param_arg('wlan1_11n_protection', send_protection_value1());
		obj.add_param_arg('wlan1_11ac_chwidth', ($('#sel_wlan1_channel').val() == 165 )? 0: get_radio_value(get_by_name("n_bandwidth1")));
		obj.add_param_arg('wlan1_vap0_wep_default_key',$('#wep_def_key1').val());
		send_txrate_value1();
		
		<!--save security -2.4G-->
	//check data
	if (checkData() == false)
		return false;
	
	//var idx = 2;
	var security_mode = $('#security_mode').val();
	
	if(security_mode == "Disable")
		obj.add_param_arg('wlan0_vap0_security','disable');
	else if(security_mode == "OPEN" || security_mode == "SHARED" ||security_mode == "WEPAUTO")//WEP_MODE
	{
		obj.add_param_arg('wlan0_vap0_wep_default_key',$('#wep_def_key').val());
		var security_wep_key_len = '';
		/* 
		** Date:	2012-03-29
		** Author:	Pascal Pai
		** Reason:	Saving each WEP key's key length
		**/	
		for(var i=1; i<=4; i++)
		{
			if ($('#WEP'+i+'Select').val() == 0)
				obj.add_param_arg('wlan0_vap0_wep_display_key_'+i, "hex");
			else
				obj.add_param_arg('wlan0_vap0_wep_display_key_'+i, "ascii");
			
			if($('#key'+i).val().length == 5 || $('#key'+i).val().length == 10)
			{
				security_wep_key_len = security_wep_key_len + '_64';
				obj.add_param_arg('wlan0_vap0_wep64_key_'+i,urlencode($('#key'+i).val()));
			}
			else
			{
				security_wep_key_len = security_wep_key_len + '_128';
				obj.add_param_arg('wlan0_vap0_wep128_key_'+i,urlencode($('#key'+i).val()));
			}
		}

		if(security_mode == "OPEN") {
			obj.add_param_arg('wlan0_vap0_security','wep_open' + security_wep_key_len);
			obj.add_param_arg('wlan0_vap0_security_wep','wep_open' + security_wep_key_len);
		} else if(security_mode == "SHARED") {
			obj.add_param_arg('wlan0_vap0_security','wep_share' + security_wep_key_len);
			obj.add_param_arg('wlan0_vap0_security_wep','wep_share' + security_wep_key_len);
		} else if(security_mode == "WEPAUTO") {
			obj.add_param_arg('wlan0_vap0_security','wep_auto' + security_wep_key_len);	
			obj.add_param_arg('wlan0_vap0_security_wep','wep_auto' + security_wep_key_len);	
		}
	}
	else
	{
		if(security_mode == "WPAPSK" || security_mode == "WPA2PSK" || security_mode == "WPAPSKWPA2PSK") //WPA_P
		{
			if(security_mode == "WPAPSKWPA2PSK")
				obj.add_param_arg('wlan0_vap0_security',"wpa2auto_psk");
			else if(security_mode == "WPA2PSK")
				obj.add_param_arg('wlan0_vap0_security',"wpa2_psk");
			else if(security_mode == "WPAPSK")
				obj.add_param_arg('wlan0_vap0_security',"wpa_psk");
			
			//obj.add_param_arg('wpaInfo_AuthenticationMode_','1.'+idx+'.1.0',0);
			obj.add_param_arg('wlan0_vap0_psk_pass_phrase',$("#passphrase").val());
		}
		else if(security_mode == "WPA" || security_mode == "WPA2" || security_mode == "WPA1WPA2") //WPA_E
		{
			if(security_mode == "WPA1WPA2")
				obj.add_param_arg('wlan0_vap0_security',"wpa2auto_eap");
			else if(security_mode == "WPA2")
				obj.add_param_arg('wlan0_vap0_security',"wpa2_eap");
			else if(security_mode == "WPA")
				obj.add_param_arg('wlan0_vap0_security',"wpa_eap");
			
			//obj.add_param_arg('wpaInfo_AuthenticationMode_','1.'+idx+'.1.0',1);
			
			obj.add_param_arg('wlan0_vap0_eap_radius_server_0',$("#RadiusServerIP").val()+'/'+$("#RadiusServerPort").val()+'/'+$("#RadiusServerSecret").val());
			//obj.add_param_arg('wpaEap_RadiusServerPort_','1.'+idx+'.1.1',$("#RadiusServerPort").val());
			//obj.add_param_arg('wpaEap_RadiusServerPSK_','1.'+idx+'.1.1',$("#RadiusServerSecret").val());
			//obj.add_param_arg('wpaEap_PreAuthentication_','1.'+idx+'.1.1',get_radio_value(get_by_name("PreAuthentication")));
			obj.add_param_arg('wlan0_vap0_eap_reauth_period',$('#PMKCachePeriod').val());
			//obj.add_param_arg('wpaEap_RadiusSessionTime_','1.'+idx+'.1.1',$('#RadiusServerSessionTimeout').val());
		}

		obj.add_param_arg('wlan0_vap0_psk_cipher_type', send_cipher_value());
		obj.add_param_arg('wlan0_vap0_gkey_rekey_time',$("#keyRenewalInterval").val());
	}

		<!--save security -5G-->
	//check data
	if (checkData1() == false)
		return false;
	
	//var idx = 3;
	var security_mode = $('#security_mode1').val();
	
	if(security_mode == "Disable")
		obj.add_param_arg('wlan1_vap0_security','disable');
	else if(security_mode == "OPEN" || security_mode == "SHARED" ||security_mode == "WEPAUTO")//WEP_MODE
	{
		obj.add_param_arg('wlan1_vap0_wep_default_key',$('#wep_def_key1').val());		
		var security_wep_key_len = '';
		/* 
		** Date:	2012-03-29
		** Author:	Pascal Pai
		** Reason:	Saving each WEP key's key length
		**/	
		for(var i=1; i<=4; i++)
		{
			if ($('#WEP'+i+'Select1').val() == 0)
				obj.add_param_arg('wlan1_vap0_wep_display_key_'+i, "hex");
			else
				obj.add_param_arg('wlan1_vap0_wep_display_key_'+i, "ascii");
			
			if($('#key'+(i+4)).val().length == 5 || $('#key'+(i+4)).val().length == 10)
			{
				security_wep_key_len = security_wep_key_len + '_64';
				obj.add_param_arg('wlan1_vap0_wep64_key_'+i,urlencode($('#key'+(i+4)).val()));
			}
			else
			{				
				security_wep_key_len = security_wep_key_len + '_128';					
				obj.add_param_arg('wlan1_vap0_wep128_key_'+i,urlencode($('#key'+(i+4)).val()));
			}
		}

		if(security_mode == "OPEN") {
			obj.add_param_arg('wlan1_vap0_security','wep_open' + security_wep_key_len);
			obj.add_param_arg('wlan1_vap0_security_wep','wep_open' + security_wep_key_len);
		} else if(security_mode == "SHARED") {
			obj.add_param_arg('wlan1_vap0_security','wep_share' + security_wep_key_len);
			obj.add_param_arg('wlan1_vap0_security_wep','wep_share' + security_wep_key_len);
		} else if(security_mode == "WEPAUTO") {
			obj.add_param_arg('wlan1_vap0_security','wep_auto' + security_wep_key_len);		
			obj.add_param_arg('wlan1-vap0_security_wep','wep_auto' + security_wep_key_len);		
		}
	}
	else
	{
		if(security_mode == "WPAPSK" || security_mode == "WPA2PSK" || security_mode == "WPAPSKWPA2PSK") //WPA_P
		{
			if(security_mode == "WPAPSKWPA2PSK")
				obj.add_param_arg('wlan1_vap0_security',"wpa2auto_psk");
			else if(security_mode == "WPA2PSK")
				obj.add_param_arg('wlan1_vap0_security',"wpa2_psk");
			else if(security_mode == "WPAPSK")
				obj.add_param_arg('wlan1_vap0_security',"wpa_psk");
			
			//obj.add_param_arg('wpaInfo_AuthenticationMode_','1.'+idx+'.1.0',0);
			obj.add_param_arg('wlan1_vap0_psk_pass_phrase',$("#passphrase1").val());
		}
		else if(security_mode == "WPA" || security_mode == "WPA2" || security_mode == "WPA1WPA2") //WPA_E
		{
			if(security_mode == "WPA1WPA2")
				obj.add_param_arg('wlan1_vap0_security',"wpa2auto_eap");
			else if(security_mode == "WPA2")
				obj.add_param_arg('wlan1_vap0_security',"wpa2_eap");
			else if(security_mode == "WPA")
				obj.add_param_arg('wlan1_vap0_security',"wpa_eap");

			//obj.add_param_arg('wpaInfo_AuthenticationMode_','1.'+idx+'.1.0',1);
			obj.add_param_arg('wlan1_vap0_eap_radius_server_0',$("#RadiusServerIP1").val()+'/'+$("#RadiusServerPort1").val()+'/'+$("#RadiusServerSecret1").val());
			//obj.add_param_arg('wpaEap_RadiusServerIP_','1.'+idx+'.1.1',$("#RadiusServerIP1").val());
			//obj.add_param_arg('wpaEap_RadiusServerPort_','1.'+idx+'.1.1',$("#RadiusServerPort1").val());
			//obj.add_param_arg('wpaEap_RadiusServerPSK_','1.'+idx+'.1.1',$("#RadiusServerSecret1").val());
			//obj.add_param_arg('wpaEap_PreAuthentication_','1.'+idx+'.1.1',get_radio_value(get_by_name("PreAuthentication1")));
			obj.add_param_arg('wlan1_vap0_eap_reauth_period',$('#PMKCachePeriod1').val());
			//obj.add_param_arg('wpaEap_RadiusSessionTime_','1.'+idx+'.1.1',$('#RadiusServerSessionTimeout1').val());
			
		}
		obj.add_param_arg('wlan1_vap0_psk_cipher_type', send_cipher_value_1());
		obj.add_param_arg('wlan1_vap0_gkey_rekey_time',$("#keyRenewalInterval1").val());
	}

		obj.add_param_arg('wlan0_vap0_ssid',$("#show_ssid_0").val());
		obj.add_param_arg('wlan1_vap0_ssid',$("#show_ssid1_0").val());				

		obj.add_param_arg('wlan0_vap0_schedule',$('#ssid_schedule :selected').val());
		obj.add_param_arg('wlan1_vap0_schedule',$('#ssid_schedule1 :selected').val());
		
		obj.add_param_arg('wlan0_vap0_ssid_broadcast', $('input[name=wlan0_vap0_ssid_broadcast]:checked').val());
		obj.add_param_arg('wlan1_vap0_ssid_broadcast', $('input[name=wlan1_vap0_ssid_broadcast]:checked').val());

		obj.add_param_arg('wlan0_wps_enable', is_wps);		
		obj.add_param_arg('wlan1_wps_enable', is_wps_5);

		var paramForm = obj.get_param();
		totalWaitTime = 20; //second
		redirectURL = location.pathname;
		wait_page();
		jq_ajax_post(paramForm.url, paramForm.arg);
	
	}

	function send_cipher_value()
	{
		var tmp_cipher = get_radio_value(get_by_name("cipher"));

		if (tmp_cipher == 0) 
			return "tkip";        //tkip
		else if (tmp_cipher == 1)	
			return "aes";    //aes
		else 
			return "both";                        //tkip and aes
	}
	function send_cipher_value_1()
	{
		var tmp_cipher = get_radio_value(get_by_name("cipher1"));

		if (tmp_cipher == 0) return "tkip";	       //tkip
		else if (tmp_cipher == 1) return "aes";    //aes
		else return "both";                        //tkip and aes
	}
	function send_protection_value() {
		var val = get_radio_value(get_by_name("n_bandwidth"));
		if (val == "0") return "20";
		else if (val == "1") return "auto";
		else return "auto";
	}
	function send_protection_value1() {
		var val = get_radio_value(get_by_name("n_bandwidth1"));
		var chan = $('#sel_wlan1_channel').val();		
		if (chan == "165") return "20";
		else if (val == "0") return "20";
		else if (val == "1") return "40";
		else if (val == "2") return "auto";
		else return "auto"
	}
	
	function send_txrate_value()
	{
		var dot11_mode_t = $('#dot11_mode :selected').val();
		var tmp_rate;
		
		switch(dot11_mode_t) {
			case '11bg':
				obj.add_param_arg('wlan0_11bg_txrate', $('#wlan0_vap0_11bg_txrate :selected').val());
				break;
			case '11n':
				obj.add_param_arg('wlan0_11n_txrate', "auto");
				break;
			case '11bgn':
				obj.add_param_arg('wlan0_11bgn_txrate', "auto");
				break;
		}
	}

	function send_txrate_value1()
	{
		var dot11_mode_t5 = $('#dot11_mode1 :selected').val();
		var tmp_rate;
		
		switch(dot11_mode_t5) {
			case '11a':
				obj.add_param_arg('wlan1_11a_txrate', $('#wlan1_vap0_11a_txrate :selected').val());
				break;
			case '11n':
				obj.add_param_arg('wlan1_11n_txrate', "auto");
				break;
			case '11na':
				obj.add_param_arg('wlan1_11na_txrate', "auto");
				break;
			case '11ac':
				obj.add_param_arg('wlan1_11ac_txrate', "auto");
				break;
		}
	}	

	var txrate_11a = new Array('6Mbps', '9Mbps', '12Mbps', '18Mbps', '24Mbps', '36Mbps', '48Mbps', '54Mbps');
	var txrate_11b = new Array('1Mbps', '2Mbps', '5.5Mbps', '11Mbps');
	var txrate_11g = new Array('6Mbps', '9Mbps', '12Mbps', '18Mbps', '24Mbps', '36Mbps', '48Mbps', '54Mbps');

	var txrate_11b_value = new Array("0x1b1b1b1b","0x1a1a1a1a","0x19191919","0x18181818");
	var txrate_11g_value = new Array("0x0b0b0b0b","0x0f0f0f0f","0x0a0a0a0a","0x0e0e0e0e",
	                                 "0x09090909","0x0d0d0d0d","0x08080808","0x0c0c0c0c");
	var txrate_11a_value = new Array("0x0b0b0b0b","0x0f0f0f0f","0x0a0a0a0a","0x0e0e0e0e",
	                                 "0x09090909","0x0d0d0d0d","0x08080808","0x0c0c0c0c");

	function set_11a_txrate(obj)
	{
		for (var i = 0; i < txrate_11a.length; i++) {
			var opt = document.createElement("option");
			
			obj.options[i+1] = null;
			opt.text = txrate_11a[i];
			opt.value = txrate_11a_value[i];
			obj.options[i+1] = opt;	
		}
	}

	function set_11bg_txrate(obj)
	{
		var count = 0;
		var legth = txrate_11b.length + txrate_11g.length;

		for (var bi=0, gi=0; bi+gi < legth;) {
			var opt = document.createElement("option");
			obj.options[bi+gi+1] = null;

			if (bi >= txrate_11b.length) {
				opt.text = txrate_11g[gi];
				opt.value = txrate_11g_value[gi];
				obj.options[bi+gi+1] = opt;
				gi++;
			} else {
				opt.text = txrate_11b[bi];
				opt.value = txrate_11b_value[bi];
				obj.options[bi+gi+1] = opt;
				bi++;
			}
		}
	}

	function switchRadio(isOn)
	{
		tmp_wlan0 = isOn;
		obj.add_param_arg('wlan0_vap0_enable',isOn);
		
		check_apply();
	}
	
	function switchRadio1(isOn)
	{
		tmp_wlan1 = isOn;
		obj.add_param_arg('wlan1_vap0_enable',isOn);
		
		check_apply();
	}
	
	function setValueWMode()
	{
		var dot11_mode_t = "bgn";
		var tmp_dot11_mode = "<!--# echo wlan0_dot11_mode -->";

		switch (tmp_dot11_mode) {
			case '11bg':
				dot11_mode_t = "bg";
				$('#wlan0_vap0_11bg_txrate').val("<!--# echo wlan0_11bg_txrate -->");
				break;
			default:
				break;
		}
		set_selectIndex("<!--# echo wlan0_dot11_mode -->", get_by_id("dot11_mode"));
	}
	
	function setValueWMode1()
	{
		var dot11_mode_t5 = "na";
		var tmp_dot11_mode1 = "<!--# echo wlan1_dot11_mode -->";

		switch (tmp_dot11_mode1) {
			case '11a':
				dot11_mode_t5 = "a";
				$('#wlan1_vap0_11a_txrate').val("<!--# echo wlan1_11a_txrate -->");
				break;
			default:
				break;
		}
		set_selectIndex("<!--# echo wlan1_dot11_mode -->", get_by_id("dot11_mode1"));
	}

	function setValueWirelessName()
	{
		var tmp_ssid = ssid_decode("wlan0_vap0_ssid");
		$('#show_ssid_0').val(tmp_ssid);
	}

	function setValueWirelessName1(){
		var tmp_ssid = ssid_decode("wlan1_vap0_ssid");
		$('#show_ssid1_0').val(tmp_ssid);
	}

	function setValueWirelessPskPassPhrase(){
		var tmp_wlan0_vap0_psk_pass_phras = ssid_decode("wlan0_vap0_psk_pass_phrase");
		var tmp_wlan1_vap0_psk_pass_phras = ssid_decode("wlan1_vap0_psk_pass_phrase");
		$('#passphrase').val(tmp_wlan0_vap0_psk_pass_phras);
		$('#passphrase1').val(tmp_wlan1_vap0_psk_pass_phras);
	}

	function setValueBoardcastSSID()
	{
		var chk_beacon = "<!--# echo wlan0_vap0_ssid_broadcast -->";
		$('input[name=wlan0_vap0_ssid_broadcast][value='+chk_beacon+']').attr('checked', true);
	}
	
	
	function setValueBoardcastSSID1(){
		var chk_beacon = "<!--# echo wlan1_vap0_ssid_broadcast -->";
		$('input[name=wlan1_vap0_ssid_broadcast][value='+chk_beacon+']').attr('checked', true);
	}

	function setValueFrequency()
	{
		var channel_list = "AutoSelect," + "<!--# exec cgi /bin/wlan channel list wlan0 -->";
		channel_list = ReplaceAll(channel_list, " ", "");
		var ch = channel_list.split(",");
		var obj = get_by_id("sel_wlan0_channel");
		var count = 0;

		if ("<!--# echo wlan0_auto_channel_enable -->" == 1)
			var current_channel = "AutoSelect";
		else
			var current_channel = trim_string("<!--# echo wlan0_channel -->");

		for (var i = 0; i < ch.length; i++) {
			var opt = document.createElement("option");
			var ch_text = (2412 + (ch[i] - 1) * 5) / 1000;

			if (ch[i] == "AutoSelect") 
				opt.text = ch[i];
			else
				opt.text = ch_text + " GHz - CH " + ch[i];

			opt.value = ch[i];
			obj.options[count++] = opt;

			if (ch[i] == current_channel)
				opt.selected = true;
		}
	}

	/* 2013.01.30 temporary, replace setValueFrequency later
	*/<!--5G-->
	function setValueFrequency1(){
		var channel_list = "AutoSelect," + "<!--# exec cgi /bin/wlan channel list wlan1 -->";
		channel_list = ReplaceAll(channel_list, " ", "");
		var ch = channel_list.split(",");
		var obj = get_by_id("sel_wlan1_channel");
		var count = 0;
		obj.options.length = 0;

		if ("<!--# echo wlan1_auto_channel_enable -->" == 1)
			var current_channel = "AutoSelect";
		else
			var current_channel = trim_string("<!--# echo wlan1_channel -->");

		for (var i = 0; i < ch.length; i++) {
			var opt = document.createElement("option");
      var ch_text = (ch[i] * 5 + 5000) / 1000;
			if (ch[i] == "AutoSelect")
				opt.text = ch[i];
			else
	     	opt.text = FormatNumber(ch_text,3) + " GHz - CH " + ch[i];

			opt.value = ch[i];
			obj.options[count++] = opt;

			if (ch[i] == current_channel)
				opt.selected = true;
		}
	}

	function FormatNumber(num,decimal){
		var tmpNumber1=num.toString();
		var numlen=tmpNumber1.length;
		var decimalIdx=tmpNumber1.indexOf('.');
		var Intlen;
		var decimallen;
		if(decimalIdx!=-1)
			decimallen=numlen-decimalIdx-1;
		else
			decimalIdx=0;
		var tmpNumber2;	
		if(decimal!=0)
		{
			tmpNumber2 = num*(Math.pow(10,decimal));
			tmpNumber2=Math.round(tmpNumber2)/(Math.pow(10,decimal));
		}
		else
			tmpNumber2 = tmpNumber1 + '.0';

		var decimalNum='';
		if(tmpNumber1.indexOf('.')!=-1)
			decimalNum = tmpNumber2.toString().substring(tmpNumber2.toString().indexOf('.')+1,tmpNumber2.toString().indexOf('.')+decimal+1);
	
		var rtndecimal=decimalNum;
		for(j=0;j<(decimal-decimalNum.length);j++)
			rtndecimal = rtndecimal + '0';

		var IntNum;

		IntNum=tmpNumber2.toString().substring(tmpNumber2.toString().indexOf('.'),0);
		if(tmpNumber2.toString().indexOf('.')==-1)
			IntNum = tmpNumber2.toString();
		if(tmpNumber2.toString().indexOf('.')==0)
			IntNum = '0';	
		var lpcnt = Math.floor(IntNum.length/3);
		if(IntNum.substring(0,1)=='-')
			lpcnt--;
		var tmpNumber3='';
		for(i=0;i<lpcnt;i++)
		{
			tmpNumber3=',' + IntNum.substring(IntNum.length,IntNum.length-3).toString() + tmpNumber3;
			IntNum=IntNum.substring(IntNum.length-3,0);
		}

		tmpNumber3 = IntNum + tmpNumber3;
		if(tmpNumber3.substring(0,1)==',')
			tmpNumber3 = tmpNumber3.substring(1,tmpNumber3.length);
		return tmpNumber3 + '.' + rtndecimal;	
	}

	function setEventWMode()
	{
		var func = function() {
			var sel_wmode = $('#dot11_mode option:selected').val();
			$('#show_11bg_txrate').hide();

			switch (sel_wmode) {
				case '11n':
					$('#show_11n_txrate').show();
					$('#bandwidth,#guard_interval,#ext_channel').show();
					break;
				case '11bgn':
					$('#show_11bgn_txrate').show();
					$('#bandwidth,#guard_interval,#ext_channel').show();
					break;
				case '11bg':
					$('#show_11bg_txrate').show();
					$('#bandwidth,#guard_interval,#ext_channel').hide();
					break;
				default:
			}
		};

		func();
		$('#dot11_mode').change(func);
	}

	function setEventWMode1()
	{
		var func = function() {
			var sel_wmode = $('#dot11_mode1 option:selected').val();			
			$('#show_11a_txrate1').hide();

			switch (sel_wmode) {
				case '11a':
					$('#show_11a_txrate1').show();
					$('#bandwidth1,#guard_interval1,#ext_channel1').hide();
					$('#bwl1_2040').show();
					$('#bwl1_204080').hide();
					break;
				case '11n':
					$('#show_11n_txrate1').show();
					$('#bandwidth1,#guard_interval1,#ext_channel1').show();
					$('#bwl1_2040').show();
					$('#bwl1_204080').hide();
					$('input[name=n_bandwidth1][value=1]').attr('checked', true);
					break;
				case '11na':
					$('#show_11na_txrate1').show();
					$('#bandwidth1,#guard_interval1,#ext_channel1').show();
					$('#bwl1_2040').show();
					$('#bwl1_204080').hide();
					$('input[name=n_bandwidth1][value=1]').attr('checked', true);
					break;
				case '11ac':
					$('#show_11ac_txrate1').show();
					$('#bandwidth1,#guard_interval1,#ext_channel1').show();
					$('#bwl1_2040').show();
					$('#bwl1_204080').show();
					$('input[name=n_bandwidth1][value=2]').attr('checked', true);
					break;
				default:
					alert('error: '+sel_wmode);
			}
		};

		func();
		$('#dot11_mode1').change(func);
	}

	function setEventFrequency()
	{
		var func = function(){
			var freqMap = new Array([0],[5],[6],[7],[8],[1,9],[2,10],[3,11],[4],[5],[6],[7],[8],[1]);
			var ch_text = new Array(get_words('_sel_autoselect'),"2412","2417","2422","2427","2432","2437","2442","2447","2452","2457","2462","2467","2472");
			var sel_freq = $('#sel_wlan0_channel').val();
			$('#n_extcha').children().remove();
			var tmp_channel = "<!--# echo wlan0_channel -->";
			
			var channel_i = freqMap[sel_freq];
			for(var i=0;i<channel_i.length;i++)
			{
				var opt = $('<option/>');
				opt.text(channel_i[i]==0?ch_text[channel_i[i]]:ch_text[channel_i[i]] + "MHz (Channel " + channel_i[i]+")");
				opt.val(channel_i[i]);
				if(lanCfg.exchannel[0]==channel_i[i])
					opt.attr('selected', true);//這裡之後要改為多判斷datamodel的值
				$('#n_extcha').append(opt);
			}
			if(sel_freq=='0')
			{
				$('#n_extcha').attr('disabled','disabled');
			}
			else if($('input[name=n_bandwidth]:checked').val()==1)
			{
				$('#n_extcha').attr('disabled','');
			}
		};
		func();
		$('#sel_wlan0_channel').change(func);
	}
	function setEventFrequency1(){
		var func = function(){
			$('#dot11_mode1').trigger('change');
			var freqMap = {'0':'0','36':'40','40':'36','44':'48','48':'44','52':'56','56':'52','60':'64','64':'60','149':'153','153':'149','157':'161','161':'157','165':'0'};
			var ch_text = {'0':get_words('_sel_autoselect'),'36':"5180",'40':"5200",'44':"5220",'48':"5240",'52':"5260",'56':"5280",'60':"5300",'64':"5320",'149':"5745",'153':"5765",'157':"5785",'161':"5805",'165':"5825"};
			var sel_freq = $('#sel_wlan1_channel').val();
			$('#n_extcha1').children().remove();
			
			var channel_i = freqMap[sel_freq];
			
			var opt = $('<option/>');
			opt.text(channel_i==0?ch_text[channel_i]:ch_text[channel_i] + "MHz (Channel " + channel_i+")");
			opt.val(channel_i);
			if(lanCfg.exchannel[0]==channel_i)
				opt.attr('selected', true);//這裡之後要改為多判斷datamodel的值
			$('#n_extcha1').append(opt);
			
			if(sel_freq=='0')
			{
				$('#n_extcha1').attr('disabled','disabled');
			}
			/*
			** Date:	2013-05-03
			** Author:	Moa Chung
			** Reason:	Wireless 5G → basic：Channel 165 bandwodth should be only 20MHz.
			** Note:	TEW-810DR pretest no. 115, 133
			**/
			else if(sel_freq=='165')
			{
				$('#bwl1_2040').hide();
				$('#bwl1_204080').hide();
				$('input[name=n_bandwidth1][value=0]').attr('checked', true);
			}
			else if($('input[name=n_bandwidth1]:checked').val()==1)
			{
				$('#n_extcha1').attr('disabled','');
			}
		};
		func();
		$('#sel_wlan1_channel').change(func);
	}

	function setValueOperatingMode(){
		var chk_op = htCfg.operating[0];
		$('input[name=n_opmode][value='+chk_op+']').attr('checked', true);
	}		
	function setValueOperatingMode1(){
//		$('#opmode1').show();
		var chk_op = htCfg.operating[4];
		$('input[name=n_opmode1][value='+chk_op+']').attr('checked', true);
	}
	function setValueChannelBandWidth()
	{		
		switch ("<!--# echo wlan0_11n_protection -->") {
			case "20":
				var chk_bw = 0;
				break;
			case "40":
			default:
				var chk_bw = 1;
				break;
		}
		$('input[name=n_bandwidth][value='+chk_bw+']').attr('checked', true);
	}
	function setValueChannelBandWidth1()
	{
		switch ("<!--# echo wlan1_11n_protection -->") {
			case "20":
				var chk_bw = 0;
				break;
			case "40":
				var chk_bw = 1;
				break;
			case "80":
			default:
				var chk_bw = 2;
				break;
		}		
		$('input[name=n_bandwidth1][value='+chk_bw+']').attr('checked', true);
	}
	function setEventChannelBandWidth(){
		var func = function(){
			var wmode = $('#dot11_mode option:selected').val();
			var rad_bw = $('input[name=n_bandwidth]:checked').val();
			if(rad_bw==0)//no MCS32 in 20MHz
			{
				$('#n_extcha').attr('disabled','disabled');
				$('#wlan0_vap0_11'+wmode+'_txrate option[value=1]').remove();
			}
			//2013.01.25 brian say not support MCS>15
/*			else//add MCS32 in 20/40MHz
			{
				$('#n_extcha').attr('disabled','');
				if($('#wlan0_vap0_11'+wmode+'_txrate option[value=1]').length==0)
				{
					var option = document.createElement("option");
					option.text = "MCS32: 6M";
					option.value = "1";
					$('#wlan0_vap0_11'+wmode+'_txrate').append(option);
				}
				
			}*/
		};
		func();
		$('input[name=n_bandwidth]').change(func);
	}
	function setEventChannelBandWidth1(){
		var func = function(){
			var wmode = $('#dot11_mode1 option:selected').val();
			var rad_bw = $('input[name=n_bandwidth1]:checked').val();
			if(rad_bw==0)//no MCS32 in 20MHz
			{
				$('#n_extcha1').attr('disabled','disabled');
				$('#wlan1_vap0_11'+wmode+'_txrate option[value=1]').remove();
			}
			//2013.01.25 brian say not support MCS>15
/*			else//add MCS32 in 20/40MHz
			{
				$('#n_extcha').attr('disabled','');
				if($('#wlan1_vap0_11'+wmode+'_txrate option[value=1]').length==0)
				{
					var option = document.createElement("option");
					option.text = "MCS32: 6M";
					option.value = "1";
					$('#wlan1_vap0_11'+wmode+'_txrate').append(option);
				}
				
			}*/
		};
		func();
		$('input[name=n_bandwidth1]').change(func);
	}
	function setValueFortyIntolerant(){
		var chk_f40mhz = otherCfg.f40mhz[0];
		$('input[name=f_40mhz][value='+chk_f40mhz+']').attr('checked', true);
	}
	function setValueFortyIntolerant1(){
		var chk_f40mhz = otherCfg.f40mhz[4];
		$('input[name=f_40mhz1][value='+chk_f40mhz+']').attr('checked', true);
	}
	function setValueWiFiOptimum(){
		var chk_wifiopt = otherCfg.wifiopt[0];
		$('input[name=wifi_opt][value='+chk_wifiopt+']').attr('checked', true);
	}
	function setValueWiFiOptimum1(){
		var chk_wifiopt = otherCfg.wifiopt[1];
		$('input[name=wifi_opt1][value='+chk_wifiopt+']').attr('checked', true);
	}
	function setValueHTTxStream(){
		var sel_tx = otherCfg.txstream[0];
		$('#tx_stream').val(sel_tx);
	}
	function setValueHTTxStream1(){
		var sel_tx = otherCfg.txstream[4];
		$('#tx_stream1').val(sel_tx);
	}
	function setValueHTRxStream(){
		var sel_rx = otherCfg.rxstream[0];
		$('#rx_stream').val(sel_rx);
	}
	function setValueHTRxStream1(){
		var sel_rx = otherCfg.rxstream[4];
		$('#rx_stream1').val(sel_rx);
	}
	
	//security start	
	function onWPAAlgorithmsClick(type)
	{
		var security_mode = $('#security_mode').val();
		var PhyMode = '8';
		if( PhyMode >= 5 && (security_mode == "WPA" || security_mode == "WPAPSK" || security_mode == "WPAPSKWPA2PSK" || security_mode == "WPA1WPA2"
		    || (security_mode == "WPA2" && type == 2) || (security_mode == "WPA2PSK" && type == 2)	))  
			$('#msgbox').show();
		else 
			$('#msgbox').hide();
	}
	function onWPAAlgorithmsClick1(type)
	{
		var security_mode = $('#security_mode1').val();
		var PhyMode = '8';
		if( PhyMode >= 5 && (security_mode == "WPA" || security_mode == "WPAPSK" || security_mode == "WPAPSKWPA2PSK" || security_mode == "WPA1WPA2"
		    || (security_mode == "WPA2" && type == 2) || (security_mode == "WPA2PSK" && type == 2)	))  
			$('#msgbox1').show();
		else 
			$('#msgbox1').hide();
	}

	function setValueSecurModeList()
	{
		var lstContent ="";

		lstContent += '<select name="security_mode" id="security_mode" size="1" onchange="securityMode();">';
		lstContent += '<option value="Disable">'+get_words('_disable')+'</option>';
		lstContent += '<option value="OPEN">'+get_words('_wifiser_mode0')+'</option>';
		lstContent += '<option value="SHARED">'+get_words('_wifiser_mode1')+'</option>';
		lstContent += '<option value="WEPAUTO">'+get_words('_wifiser_mode2')+'</option>';
		lstContent += '<option value="WPA">'+get_words('_WPA')+'</option>';
		lstContent += '<option value="WPAPSK">'+get_words('_wifiser_mode3')+'</option>';
		lstContent += '<option value="WPA2PSK">'+get_words('_wifiser_mode4')+'</option>';
		lstContent += '<option value="WPAPSKWPA2PSK">'+get_words('_wifiser_mode5')+'</option>';
		lstContent += '<option value="WPA2">'+get_words('_wifiser_mode6')+'</option>';
		lstContent += '<option value="WPA1WPA2">'+get_words('_wifiser_mode7')+'</option>';
		lstContent += '</select>';
		
		$('#SecurMode_list').html(lstContent)
	}
	function setValueSecurModeList1()
	{
		var lstContent ="";

		lstContent += '<select name="security_mode1" id="security_mode1" size="1" onchange="securityMode1();">';
		lstContent += '<option value="Disable">'+get_words('_disable')+'</option>';
		lstContent += '<option value="OPEN">'+get_words('_wifiser_mode0')+'</option>';
		lstContent += '<option value="SHARED">'+get_words('_wifiser_mode1')+'</option>';
		lstContent += '<option value="WEPAUTO">'+get_words('_wifiser_mode2')+'</option>';
		lstContent += '<option value="WPA">'+get_words('_WPA')+'</option>';
		lstContent += '<option value="WPAPSK">'+get_words('_wifiser_mode3')+'</option>';
		lstContent += '<option value="WPA2PSK">'+get_words('_wifiser_mode4')+'</option>';
		lstContent += '<option value="WPAPSKWPA2PSK">'+get_words('_wifiser_mode5')+'</option>';
		lstContent += '<option value="WPA2">'+get_words('_wifiser_mode6')+'</option>';
		lstContent += '<option value="WPA1WPA2">'+get_words('_wifiser_mode7')+'</option>';
		lstContent += '</select>';

		$('#SecurMode_list1').html(lstContent)
	}
	
	function MBSSIDChange(index)
	{
		LoadFields(index);
		fill_WEPkeys(index);
		fill_WPA(index);

		//show warning msg
		onWPAAlgorithmsClick(get_radio_value(get_by_name("cipher")));

		return true;
	}
	function MBSSIDChange1(index)
	{
		LoadFields1(index);
		fill_WEPkeys1(index);
		fill_WPA1(index);

		//show warning msg
		onWPAAlgorithmsClick1(get_radio_value(get_by_name("cipher1")));

		return true;
	}
	
function fill_WEPkeys(index)
{
	var val = "<!--# echo wlan0_vap0_security_wep -->";
	val = val.split("_");
	var infoAuthMode = val[1];
	var infokey = '<!--# echo wlan0_vap0_wep_default_key -->';
	var key128 =  [$(wlan0_vap0_wep128_key_1).text(), $(wlan0_vap0_wep128_key_2).text(),
	               $(wlan0_vap0_wep128_key_3).text(), $(wlan0_vap0_wep128_key_4).text()
		            ];
	var key64 =   [$(wlan0_vap0_wep64_key_1).text(), $(wlan0_vap0_wep64_key_2).text(),
                 $(wlan0_vap0_wep64_key_3).text(), $(wlan0_vap0_wep64_key_4).text()
	              ];
	var keyType = ["<!--# echo wlan0_vap0_wep_display_key_1 -->", "<!--# echo wlan0_vap0_wep_display_key_2 -->",
		             "<!--# echo wlan0_vap0_wep_display_key_3 -->", "<!--# echo wlan0_vap0_wep_display_key_4 -->"
	              ];

	set_selectIndex(infokey, $('#wep_def_key')[0]);
	
	for(var i=0; i<4; i++)
	{
		if (keyType[i] == "ascii")
			$('#WEP'+(i+1)+'Select').val(1);
		else
			$('#WEP'+(i+1)+'Select').val(0);
			
		if(val[i+2] == "128")
			$('#key'+(i+1)).val(key128[i]);
		else
			$('#key'+(i+1)).val(key64[i]);
	}
	if(infoAuthMode=="share") //shared
		$('#security_shared_mode').val(1);
	else
		$('#security_shared_mode').val(0);
}
function fill_WEPkeys1(index)
{
	var val = "<!--# echo wlan1_vap0_security_wep -->";
	val = val.split("_");
	var infoAuthMode = val[1];
	var infokey = '<!--# echo wlan1_vap0_wep_default_key -->';
	var key128 =  [$(wlan1_vap0_wep128_key_1).text(), $(wlan1_vap0_wep128_key_2).text(),
	               $(wlan1_vap0_wep128_key_3).text(), $(wlan1_vap0_wep128_key_4).text()
	              ];
	var key64 =   [$(wlan1_vap0_wep64_key_1).text(), $(wlan1_vap0_wep64_key_2).text(),
	               $(wlan1_vap0_wep64_key_3).text(), $(wlan1_vap0_wep64_key_4).text()
                ];
	var keyType = ["<!--# echo wlan1_vap0_wep_display_key_1 -->", "<!--# echo wlan1_vap0_wep_display_key_2 -->",
	               "<!--# echo wlan1_vap0_wep_display_key_3 -->", "<!--# echo wlan1_vap0_wep_display_key_4 -->"
	              ];

	set_selectIndex(infokey, $('#wep_def_key1')[0]);
	
	for(var i=0; i<4; i++)
	{
		if (keyType[i] == "ascii")
			$('#WEP'+(i+1)+'Select1').val(1);
		else
			$('#WEP'+(i+1)+'Select1').val(0);

		if(val[i+2] == "128")
			$('#key'+(i+5)).val(key128[i]);
		else
			$('#key'+(i+5)).val(key64[i]);
	}
	if(infoAuthMode=="share") //shared
		$('#security_shared_mode1').val(1);
	else
		$('#security_shared_mode1').val(0);
}

function fill_WPA(index)
{
		var tmp_wlan0_psk_pass_phrase = ssid_decode("wlan0_vap0_psk_pass_phrase");
		var tmp_wlan0_gkey_rekey_time= "<!--# echo wlan0_vap0_gkey_rekey_time -->";
		var wlan0_eap_reauth_period = "<!--# echo wlan0_vap0_eap_reauth_period -->";
		var tmp_wlan0_psk_cipher_type = "<!--# echo wlan0_vap0_psk_cipher_type -->";
		var tmp_cipher=0;

		if (tmp_wlan0_psk_cipher_type == "tkip"){
			tmp_cipher = 0;
		}else if (tmp_wlan0_psk_cipher_type == "aes"){
			tmp_cipher = 1;
		}else if (tmp_wlan0_psk_cipher_type == "both"){
			tmp_cipher = 2;
		}
		set_checked(tmp_cipher, get_by_name("cipher"));
		
		$('#passphrase').val(tmp_wlan0_psk_pass_phrase);
		$('#keyRenewalInterval').val(tmp_wlan0_gkey_rekey_time);
		$('#PMKCachePeriod').val(wlan0_eap_reauth_period);
		//set_checked(EapCfg.preauth[index*2], get_by_name("PreAuthentication"));
		
		//802.1x wep
		/*
		if(IEEE8021X[MBSSID] == "1"){
			if(EncrypType[MBSSID] == "WEP")
				document.security_form.ieee8021x_wep[1].checked = true;
			else
				document.security_form.ieee8021x_wep[0].checked = true;
		}
		*/
		
		var temp_r0 = get_by_id("wlan0_vap0_eap_radius_server_0").value;
		var Dr0 = temp_r0.split("/");
		
		if(Dr0.length > 1){
			$('#RadiusServerIP').val(Dr0[0]);
			$('#RadiusServerPort').val(Dr0[1]);
			$('#RadiusServerSecret').val(Dr0[2]);
			//$('#RadiusServerSessionTimeout').val(EapCfg.SessionT[index*2]);
		}
		
}
function fill_WPA1(index)
{
		//set_checked(wpaCfg.encrMode[index], get_by_name("cipher1"));
		var tmp_wlan1_psk_pass_phrase = ssid_decode("wlan1_vap0_psk_pass_phrase");
		var tmp_wlan1_gkey_rekey_time= "<!--# echo wlan1_vap0_gkey_rekey_time -->";
		var wlan1_eap_reauth_period = "<!--# echo wlan1_vap0_eap_reauth_period -->";
		var tmp_wlan1_psk_cipher_type = "<!--# echo wlan1_vap0_psk_cipher_type -->";
		var tmp_cipher1=0;
		
		if (tmp_wlan1_psk_cipher_type == "tkip"){
			tmp_cipher1 = 0;
		}else if (tmp_wlan1_psk_cipher_type == "aes"){
			tmp_cipher1 = 1;
		}else if (tmp_wlan1_psk_cipher_type == "both"){
			tmp_cipher1 = 2;
		}
		set_checked(tmp_cipher1, get_by_name("cipher1"));
		
		
		$('#passphrase1').val(tmp_wlan1_psk_pass_phrase);
		$('#keyRenewalInterval1').val(tmp_wlan1_gkey_rekey_time);
		$('#PMKCachePeriod1').val(wlan1_eap_reauth_period);
		
		//802.1x wep
		/*
		if(IEEE8021X[MBSSID] == "1"){
			if(EncrypType[MBSSID] == "WEP")
				document.security_form.ieee8021x_wep[1].checked = true;
			else
				document.security_form.ieee8021x_wep[0].checked = true;
		}
		*/
		
		var temp_r00 = get_by_id("wlan1_vap0_eap_radius_server_0").value;
		var Dr00 = temp_r00.split("/");
		
		if(Dr00.length > 1){
			$('#RadiusServerIP1').val(Dr00[0]);
			$('#RadiusServerPort1').val(Dr00[1]);
			$('#RadiusServerSecret1').val(Dr00[2]);
			//$('#RadiusServerSessionTimeout1').val(EapCfg.SessionT[index*2]);
		}
}
	
/*	
	function ShowAP(index)
	{
		for(var i=0; i<max_SSID; i++){
			set_selectIndex(MACAction[index], $('#apselect_'+i)[0]);
			if(index != i)
			{
				$('#AccessPolicy_'+i).hide();
				$('#AccessPolicy3_'+i).hide();
			}
			else
			{
				$('#AccessPolicy_'+i).show();
				$('#AccessPolicy3_'+i).show();
			}
		}
	}
	function ShowAP1(index)
	{
		for(var i=0; i<max_SSID; i++){
			set_selectIndex(MACAction[index], $('#apselect_'+i+'1')[0]);
			if(index != i)
			{
				$('#AccessPolicy_'+i+'1').hide();
				$('#AccessPolicy3_'+i+'1').hide();
			}
			else
			{
				$('#AccessPolicy_'+i+'1').show();
				$('#AccessPolicy3_'+i+'1').show();
			}
		}
	}
*/	

function LoadFields(index)
{
	var sec = "<!--# echo wlan0_vap0_security -->";
	sec = sec.split("_");
	var securMode = sec[0];
	var infoAuthMode = sec[1];
	var infoWPAMode = sec[1];
	var securIndex;

	if(securMode == "disable") //None
		securIndex = "Disable";
	else if(securMode == "wep") //WEP
	{
		switch(infoAuthMode){
		case "open":
			securIndex = "OPEN";
			break;
		case "share":
			securIndex = "SHARED";
			break;
		case "auto":
			securIndex = "WEPAUTO";
			break;
		}
	}
	else if(infoWPAMode == "psk") //WPA-P
	{
		switch(securMode){
		case "wpa2auto":
			securIndex = "WPAPSKWPA2PSK";
			break;
		case "wpa2":
			securIndex = "WPA2PSK";
			break;
		case "wpa":
			securIndex = "WPAPSK";
			break;
		}
	}
	else if(infoWPAMode == "eap") //WPA-E
	{
		switch(securMode){
		case "wpa2auto":
			securIndex = "WPA1WPA2";
			break;
		case "wpa2":
			securIndex = "WPA2";
			break;
		case "wpa":
			securIndex = "WPA";
			break;
		}
	}
	$('#security_mode').val(securIndex);
	securityMode();
}
function LoadFields1(index)
{
	var sec = "<!--# echo wlan1_vap0_security -->";
	sec = sec.split("_");
	var securMode = sec[0];
	var infoAuthMode = sec[1];
	var infoWPAMode = sec[1];
	var securIndex;

	if(securMode == "disable") //None
		securIndex = "Disable";
	else if(securMode == "wep") //WEP
	{
		switch(infoAuthMode){
		case "open":
			securIndex = "OPEN";
			break;
		case "share":
			securIndex = "SHARED";
			break;
		case "auto":
			securIndex = "WEPAUTO";
			break;
		}

	}
	else if(infoWPAMode == "psk") //WPA-P
	{
		switch(securMode){
		case "wpa2auto":
			securIndex = "WPAPSKWPA2PSK";
			break;
		case "wpa2":
			securIndex = "WPA2PSK";
			break;
		case "wpa":
			securIndex = "WPAPSK";
			break;
		}
	}
	else if(infoWPAMode == "eap") //WPA-E
	{
		switch(securMode){
		case "wpa2auto":
			securIndex = "WPA1WPA2";
			break;
		case "wpa2":
			securIndex = "WPA2";
			break;
		case "wpa":
			securIndex = "WPA";
			break;
		}
	}
	$('#security_mode1').val(securIndex);
	securityMode1();
}
	
function securityMode()
{
	var security_mode = $('#security_mode').val();
	$('#wep').hide();
	$('#security_shared_mode').hide();
	$('#wpa').hide();
	$('#wpa_algorithms').hide();
	$('#wpa_passphrase').hide();
	$('#wpa_key_renewal_interval').hide();
	$('#8021x_wep').hide();
	$('#radius_server').hide();
	$('#wpa_preAuthentication').hide();
	$('#wpa_PMK_Cache_Period').hide();
	set_checked(0, get_by_name("cipher"));

	if (security_mode == "OPEN" || security_mode == "SHARED" ||security_mode == "WEPAUTO")
		$('#wep').show();
	else if(security_mode == "WPAPSK" || security_mode == "WPA2PSK" || security_mode == "WPAPSKWPA2PSK") 
	{
		$('#wpa').show();
		$('#wpa_algorithms').show();
		$('#AES_cipher').hide();
		$('#TKIPAES_cipher').hide();
		$('#TKIP_cipher').show();
		set_checked(0, get_by_name("cipher"));
		
		//if(security_mode == "WPAPSK" && document.security_form.cipher[2].checked)
			//document.security_form.cipher[2].checked = false;
		
		if(security_mode == "WPA2PSK" || security_mode == "WPAPSKWPA2PSK") {
			if (security_mode == "WPAPSKWPA2PSK") {
				set_checked(2, get_by_name("cipher"));
				$('#TKIP_cipher').hide();
				$('#AES_cipher').hide();
				$('#TKIPAES_cipher').show();
			}
			else {
				set_checked(1, get_by_name("cipher"));
				$('#TKIP_cipher').hide();
				$('#AES_cipher').show();
				$('#TKIPAES_cipher').show();
			}
		}
		$('#wpa_passphrase').show();
		$('#wpa_key_renewal_interval').show();
	}
	else if (security_mode == "WPA" || security_mode == "WPA2" || security_mode == "WPA1WPA2") //wpa enterprise
	{
		$('#wpa').show();
		$('#wpa_algorithms').show();
		$('#wpa_key_renewal_interval').show();
		$('#radius_server').show();
		$('#AES_cipher').hide();
		$('#TKIPAES_cipher').hide();
		$('#TKIP_cipher').show();
		
		//if(security_mode == "WPA" && document.security_form.cipher[2].checked)
			//document.security_form.cipher[2].checked = false;
		
		if(security_mode == "WPA2"){
			set_checked(1, get_by_name("cipher"));
			$('#TKIP_cipher').hide();
			$('#AES_cipher').show();
			$('#TKIPAES_cipher').show();
			//$('#wpa_preAuthentication').show();
			//$('#wpa_PMK_Cache_Period').show();
			
		}
		if(security_mode == "WPA1WPA2"){
			set_checked(2, get_by_name("cipher"));
			$('#TKIP_cipher').hide();
			$('#AES_cipher').hide();
			$('#TKIPAES_cipher').show();
		}			
	}
	else if (security_mode == "IEEE8021X") // 802.1X-WEP
	{
		$('#8021x_wep').show();
		$('#radius_server').show();
	}
	
	var PhyMode = '8';
	if( PhyMode >= 5 && (security_mode == "WPA" || security_mode == "WPAPSK" || security_mode == "WPAPSKWPA2PSK" || security_mode == "WPA1WPA2"
		|| (security_mode == "WPA2" && get_radio_value(get_by_name("cipher")) == 2) || (security_mode == "WPA2PSK" && get_radio_value(get_by_name("cipher")) == 2))) 
		$('#msgbox').show();
	else 
		$('#msgbox').hide();
}
function securityMode1()
{
	var security_mode = $('#security_mode1').val();
	$('#wep1').hide();
	$('#security_shared_mode1').hide();
	$('#wpa1').hide();
	$('#wpa_algorithms1').hide();
	$('#wpa_passphrase1').hide();
	$('#wpa_key_renewal_interval1').hide();
	$('#8021x_wep1').hide();
	$('#radius_server1').hide();
	$('#wpa_preAuthentication1').hide();
	$('#wpa_PMK_Cache_Period1').hide();
	set_checked(0, get_by_name("cipher1"));
	
	if (security_mode == "OPEN" || security_mode == "SHARED" ||security_mode == "WEPAUTO")
		$('#wep1').show();
	else if(security_mode == "WPAPSK" || security_mode == "WPA2PSK" || security_mode == "WPAPSKWPA2PSK") 
	{
		$('#wpa1').show();
		$('#wpa_algorithms1').show();
		$('#AES_cipher1').hide();
		$('#TKIPAES_cipher1').hide();
		$('#TKIP_cipher1').show();
		set_checked(0, get_by_name("cipher1"));
		
		//if(security_mode == "WPAPSK" && document.security_form.cipher[2].checked)
			//document.security_form.cipher[2].checked = false;
		
		if(security_mode == "WPA2PSK" || security_mode == "WPAPSKWPA2PSK") {
			if (security_mode == "WPAPSKWPA2PSK") {
				set_checked(2, get_by_name("cipher1"));
				$('#TKIP_cipher1').hide();
				$('#AES_cipher1').hide();
				$('#TKIPAES_cipher1').show();
			}
			else {
				set_checked(1, get_by_name("cipher1"));
				$('#TKIP_cipher1').hide();
				$('#AES_cipher1').show();
				$('#TKIPAES_cipher1').show();
			}
		}
		$('#wpa_passphrase1').show();
		$('#wpa_key_renewal_interval1').show();
	}
	else if (security_mode == "WPA" || security_mode == "WPA2" || security_mode == "WPA1WPA2") //wpa enterprise
	{
		$('#wpa1').show();
		$('#wpa_algorithms1').show();
		$('#wpa_key_renewal_interval1').show();
		$('#radius_server1').show();
		$('#AES_cipher1').hide();
		$('#TKIPAES_cipher1').hide();
		$('#TKIP_cipher1').show();
		
		//if(security_mode == "WPA" && document.security_form.cipher[2].checked)
			//document.security_form.cipher[2].checked = false;
		
		if(security_mode == "WPA2"){
			set_checked(1, get_by_name("cipher1"));
			$('#TKIP_cipher1').hide();
			$('#AES_cipher1').show();
			$('#TKIPAES_cipher1').show();
			//$('#wpa_preAuthentication1').show();
			//$('#wpa_PMK_Cache_Period1').show();
			
		}
		if(security_mode == "WPA1WPA2"){
			set_checked(2, get_by_name("cipher1"));
			$('#TKIP_cipher1').hide();
			$('#AES_cipher1').hide();
			$('#TKIPAES_cipher1').show();
		}			
	}
	else if (security_mode == "IEEE8021X") // 802.1X-WEP
	{
		$('#8021x_wep1').show();
		$('#radius_server1').show();
	}
	
	var PhyMode = '8';
	if( PhyMode >= 5 && (security_mode == "WPA" || security_mode == "WPAPSK" || security_mode == "WPAPSKWPA2PSK" || security_mode == "WPA1WPA2"
		|| (security_mode == "WPA2" && get_radio_value(get_by_name("cipher1")) == 2) || (security_mode == "WPA2PSK" && get_radio_value(get_by_name("cipher1")) == 2))) 
		$('#msgbox1').show();
	else 
		$('#msgbox1').hide();
}
	
	function checkData()
	{
		var dot11_mode_value = $('#dot11_mode :selected').val();
		var wpa_cipher = $('input[name=cipher]:checked').val();
		var securitymode = $('#security_mode').val();
		var checkValue, flag=0;
		var ssid_vs = $('input[name=wlan0_vap0_ssid_broadcast]:checked').val();
                var alert_st = 0;       // value != 0 not alert msg yet

                if (is_wps == 1)
                {
                        if (ssid_vs == 0 && alert_st == 0)
                        {
                                alert_st = -1;
                                if (confirm(get_words("msg_wps_sec_03")) == false)
                                        return false;
                                else
                                        is_wps = 0;
                        }
                }
                

		if (securitymode == "OPEN" || securitymode == "SHARED" ||securitymode == "WEPAUTO")//WEP_MODE
		{
			if(!check_Wep(securitymode))
				return false;
			/* 
			** Date:	2012-02-04
			** Author:	Moa Chung
			** Reason:	add foolproof from old model(WEP)
			**/
			if (dot11_mode_value == "11n"){
				alert(get_words('MSG044'));
				return false;
			}

			if (wpsCfg.enable[0] == 1)
			{
				if (confirm(get_words("msg_wps_sec_01")) == false)
					return false;
				else
					is_wps = 0;
			}
			
		}
		else if (securitymode == "WPAPSK" || securitymode == "WPA2PSK" || securitymode == "WPAPSKWPA2PSK")//WPA_P
		{
			var keyvalue = $('#passphrase').val();
			if (keyvalue.length == 0){
				alert(get_words('_wifiser_mode37'));
				return false;
			}
			/* 
			** Date:	2012-02-04
			** Author:	Moa Chung
			** Reason:	add foolproof from old model(PSK)
			**/
			if ((dot11_mode_value == "11n") && (wpa_cipher == 0)){
					alert(get_words('MSG045'));
					return false;
			}

			if (wpsCfg.enable[0] == 1)
			{
				if (wpa_cipher == 0 && securitymode == "WPAPSK")
					if (confirm(get_words("msg_wps_sec_02")) == false)
						return false;
					else
						is_wps = 0;
				else if (securitymode == "WPAPSK")
					if (confirm(get_words("msg_wps_sec_04")) == false)
						return false;
					else
						is_wps = 0;
			}
			
			for (loopCount=0; loopCount<64; loopCount++)
			{
				checkValue = keyvalue.substr(loopCount, 1);
				if (!(parseInt(checkValue, 16) >= 0) && !(parseInt(checkValue, 16) <= 15)) {
					flag = 1;
					loopCount = 65;
				}
			}
			
			if (keyvalue.length == 64) //Hex
			{
				if (flag != 0){
					alert(get_words('_wifiser_mode36'));
					return false;
				}
			}
			else	//ASCII
			{
				if (keyvalue.length < 8){
					alert(get_words('_wifiser_mode35'));
					return false;
				}
				
				if (keyvalue.length >= 64){
					alert(get_words('_wifiser_mode34'));
					return false;
				}
			}
			if(check_wpa() == false)
				return false;	
		}
		else if (securitymode == "WPA" || securitymode == "WPA1WPA2") //WPA or WPA1WP2 mixed mode
		{
			if(check_wpa() == false)
				return false;
			if(chk_radius() == false)
				return false;
			/* 
			** Date:	2012-02-04
			** Author:	Moa Chung
			** Reason:	add foolproof from old model(EAP)
			**/
			if ((dot11_mode_value == "11n") && (wpa_cipher == 0)){
				alert(get_words('MSG045'));
				return false;
			}
			
			if (wpsCfg.enable[0] == 1)
			{
				if (confirm(get_words("msg_wps_sec_05")) == false)
					return false;
				else
					is_wps = 0;
			}
			
		}
		else if (securitymode == "WPA2") //WPA2
		{
			if(check_wpa() == false)
				return false;
			if($('#PMKCachePeriod').val() == "")
			{
				alert(get_words('_wifiser_mode33'));
				return false;
			}
			/* 
			** Date:	2012-02-04
			** Author:	Moa Chung
			** Reason:	add foolproof from old model(EAP)
			**/
			if ((dot11_mode_value == "11n") && (wpa_cipher == 0)){
				alert(get_words('MSG045'));
				return false;
			}

			if (wpsCfg.enable[0] == 1)
			{
				if (confirm(get_words("msg_wps_sec_05")) == false)
					return false;
				else
					is_wps = 0;
			}

			if(chk_radius() == false)
				return false;
		}
		
		return true;	
	}
	function checkData1()
	{
		var dot11_mode_value = $('#dot11_mode1 :selected').val();
		var wpa_cipher = $('input[name=cipher1]:checked').val();
		var securitymode = $('#security_mode1').val();
		var checkValue, flag=0;
		var ssid_vs1 = $('input[name=wlan1_vap0_ssid_broadcast]:checked').val();
                var alert_st = 0;       // value != 0 not alert msg yet
                if (is_wps_5 == 1)
                {
                        if (ssid_vs1 == 0 && alert_st == 0)
                        {
                                alert_st = -1;
                                if (confirm(get_words("msg_wps_sec_03")) == false)
                                        return false;
                                else
                                        is_wps_5 = 0;
                        }
                }
		if (securitymode == "OPEN" || securitymode == "SHARED" ||securitymode == "WEPAUTO")//WEP_MODE
		{
			if(!check_Wep1(securitymode) )
				return false;
			/* 
			** Date:	2012-02-04
			** Author:	Moa Chung
			** Reason:	add foolproof from old model(WEP)
			**/
			if (dot11_mode_value == "11n"){
				alert(get_words('MSG044'));
				return false;
			}

			if (wpsCfg.enable[1] == 1)
			{
				if (confirm(get_words("msg_wps_sec_01")) == false)
					return false;
				else
					is_wps_5 = 0;
			}

		}
		else if (securitymode == "WPAPSK" || securitymode == "WPA2PSK" || securitymode == "WPAPSKWPA2PSK")//WPA_P
		{
			var keyvalue = $('#passphrase1').val();
			if (keyvalue.length == 0){
				alert(get_words('_wifiser_mode37'));
				return false;
			}
			/* 
			** Date:	2012-02-04
			** Author:	Moa Chung
			** Reason:	add foolproof from old model(PSK)
			**/
			if ((dot11_mode_value == "11n") && (wpa_cipher == 0)){
					alert(get_words('MSG045'));
					return false;
			}

			if (wpsCfg.enable[1] == 1)
			{
				if (wpa_cipher == 0 && securitymode == "WPAPSK")
					if (confirm(get_words("msg_wps_sec_02")) == false)
						return false;
					else
						is_wps_5 = 0;
				else if (securitymode == "WPAPSK")
					if (confirm(get_words("msg_wps_sec_04")) == false)
						return false;
					else
						is_wps_5 = 0;
			}

			for (loopCount=0; loopCount<64; loopCount++)
			{
				checkValue = keyvalue.substr(loopCount, 1);
				if (!(parseInt(checkValue, 16) >= 0) && !(parseInt(checkValue, 16) <= 15)) {
					flag = 1;
					loopCount = 65;
				}
			}
			
			if (keyvalue.length == 64) //Hex
			{
				if (flag != 0){
					alert(get_words('_wifiser_mode36'));
					return false;
				}
			}
			else	//ASCII
			{
				if (keyvalue.length < 8){
					alert(get_words('_wifiser_mode35'));
					return false;
				}
				
				if (keyvalue.length >= 64){
					alert(get_words('_wifiser_mode34'));
					return false;
				}
			}
			if(check_wpa1() == false)
				return false;	
		}
		else if (securitymode == "WPA" || securitymode == "WPA1WPA2") //WPA or WPA1WP2 mixed mode
		{
			if(check_wpa1() == false)
				return false;
			if(chk_radius1() == false)
				return false;
			/* 
			** Date:	2012-02-04
			** Author:	Moa Chung
			** Reason:	add foolproof from old model(EAP)
			**/
			if ((dot11_mode_value == "11n") && (wpa_cipher == 0)){
				alert(get_words('MSG045'));
				return false;
			}

			if (wpsCfg.enable[1] == 1)
			{
				if (confirm(get_words("msg_wps_sec_05")) == false)
					return false;
				else
					is_wps_5 = 0;
			}

		}
		else if (securitymode == "WPA2") //WPA2
		{
			if(check_wpa1() == false)
				return false;
			if($('#PMKCachePeriod').val() == "")
			{
				alert(get_words('_wifiser_mode33'));
				return false;
			}
			/* 
			** Date:	2012-02-04
			** Author:	Moa Chung
			** Reason:	add foolproof from old model(EAP)
			**/
			if ((dot11_mode_value == "11n") && (wpa_cipher == 0)){
				alert(get_words('MSG045'));
				return false;
			}

			if (wpsCfg.enable[1] == 1)
			{
				if (confirm(get_words("msg_wps_sec_05")) == false)
					return false;
				else
					is_wps_5 = 0;
			}

			if(chk_radius1() == false)
				return false;
		}
		
		return true;
	}
	
	function check_Wep(securitymode)
	{
		var defaultid = $('#wep_def_key').val();
	
		if (defaultid == 1 )
			var keyvalue = $('#key1').val();
		else if (defaultid == 2)
			var keyvalue = $('#key2').val();
		else if (defaultid == 3)
			var keyvalue = $('#key3').val();
		else if (defaultid == 4)
			var keyvalue = $('#key4').val();

		if (keyvalue.length == 0 &&  (securitymode == "SHARED" || securitymode == "OPEN" || securitymode == "WEPAUTO")){ // shared wep  || md5
			alert(get_words('_wifiser_mode32')+" "+defaultid+' !');
			return false;
		}
		for(var i=1; i<=4; i++)
		{
			var keylength = $('#key'+i).val().length;
			var key = $('#key'+i).val();
			if(keylength != 0)
			{
				//ASCII
				if($('#WEP'+i+'Select').val() == 1)
				{
					if(keylength != 5 && keylength != 13) {
						alert(get_words('_wifiser_mode31')+" "+ i);
						return false;
					}
					for (var j = 0; j < keylength; j++){
						if (!is_ascii(key.substring(j, j+1))){
							alert(get_words('TEXT042_1')+" " + i + " "+get_words('TEXT041_2') + " " + get_words('_ascii'));
							return false;
						}
					}
				}
				
				//HEX
				if($('#WEP'+i+'Select').val() == 0)
				{
					if(keylength != 10 && keylength != 26) {
						alert(get_words('_wifiser_mode30')+" "+ i);
						return false;
					}
					for (var j = 0; j < keylength; j++){
						if (!check_hex(key.substring(j, j+1))){
							alert(get_words('TEXT042_1')+" " + i + " "+get_words('TEXT042_2'));	
							return false;
						}
					}
				}
			}
		}
		return true;
	}
	function check_Wep1(securitymode)
	{
		var defaultid = $('#wep_def_key1').val();
	
		if (defaultid == 1 )
			var keyvalue = $('#key5').val();
		else if (defaultid == 2)
			var keyvalue = $('#key6').val();
		else if (defaultid == 3)
			var keyvalue = $('#key7').val();
		else if (defaultid == 4)
			var keyvalue = $('#key8').val();

		if (keyvalue.length == 0 &&  (securitymode == "SHARED" || securitymode == "OPEN" || securitymode == "WEPAUTO")){ // shared wep  || md5
			alert(get_words('_wifiser_mode32')+" "+defaultid+' !');
			return false;
		}
		for(var i=1; i<=4; i++)
		{
			var keylength = $('#key'+(i+4)).val().length;
			var key = $('#key'+(i+4)).val();
			if(keylength != 0)
			{
				//ASCII
				if($('#WEP'+i+'Select1').val() == 1)
				{
					if(keylength != 5 && keylength != 13) {
						alert(get_words('_wifiser_mode31')+" "+ i);
						return false;
					}
					for (var j = 0; j < keylength; j++){
						if (!is_ascii(key.substring(j, j+1))){
							alert(get_words('TEXT042_1')+" " + i + " "+get_words('TEXT041_2') + " " + get_words('_ascii'));
							return false;
						}
					}
				}
				
				//HEX
				if($('#WEP'+i+'Select1').val() == 0)
				{
					if(keylength != 10 && keylength != 26) {
						alert(get_words('_wifiser_mode30')+" "+ i);
						return false;
					}
					for (var j = 0; j < keylength; j++){
						if (!check_hex(key.substring(j, j+1))){
							alert(get_words('TEXT042_1')+" " + i + " "+get_words('TEXT042_2'));	
							return false;
						}
					}
				}
			}
		}
		return true;
	}
	
	function check_wpa()
	{
		var keyvalue = $('#keyRenewalInterval').val();
		var PMKvalue = $('#PMKCachePeriod').val();
		if(isNaN(keyvalue))
		{
			alert(get_words('_wifiser_mode27'));
			return false;
		}
		if(keyvalue < 60)
		{
			alert(get_words('_wifiser_mode28'));
			return false;
		}
		if(isNaN(PMKvalue))
		{
			alert(get_words('_wifiser_mode29'));
			return false;
		}
		return true;
	}
	function check_wpa1()
	{
		var keyvalue = $('#keyRenewalInterval1').val();
		var PMKvalue = $('#PMKCachePeriod1').val();
		if(isNaN(keyvalue))
		{
			alert(get_words('_wifiser_mode27'));
			return false;
		}
		if(keyvalue < 60)
		{
			alert(get_words('_wifiser_mode28'));
			return false;
		}
		if(isNaN(PMKvalue))
		{
			alert(get_words('_wifiser_mode29'));
			return false;
		}
		return true;
	}
	
	function chk_radius()
	{
		
		var ip1 = $('#RadiusServerIP').val();		
		var radius1_msg = replace_msg(all_ip_addr_msg,get_words('bws_RIPA'));		
		var temp_ip1 = new addr_obj(ip1.split("."), radius1_msg, false, false);	
		var temp_radius1 = new raidus_obj(temp_ip1, $('#RadiusServerPort').val(), $('#RadiusServerSecret').val());

		if (!check_radius(temp_radius1)){
			return false;
		}
		
		/*
		if($('#RadiusServerIP').val()==""){
			alert('Please input the radius server IP address.');
			return false;		
		}
		if($('#RadiusServerPort').val()==""){
			alert('Please input the radius server port number.');
			return false;		
		}
		if($('#RadiusServerSecret').val()==""){
			alert('Please input the radius server shared secret.');
			return false;		
		}

		if(checkIpAddr(document.security_form.RadiusServerIP) == false){
			alert('Please input a valid radius server ip address.');
			return false;		
		}
		if( (checkRange(document.security_form.RadiusServerPort.value, 1, 65535)==false) ||
			(checkAllNum(document.security_form.RadiusServerPort.value)==false)){
			alert('Please input a valid radius server port number.');
			return false;		
		}
		if(checkInjection(document.security_form.RadiusServerSecret.value)==false){
			alert('The shared secret contains invalid characters.');
			return false;		
		}

		if(document.security_form.RadiusServerSessionTimeout.value.length){
			if(checkAllNum(document.security_form.RadiusServerSessionTimeout.value)==false){
				alert('Please input a valid session timeout number or u may left it empty.');
				return false;	
			}	
		}*/

		return true;
	}
	function chk_radius1()
	{
		
		var ip1 = $('#RadiusServerIP1').val();		
		var radius1_msg = replace_msg(all_ip_addr_msg,get_words('bws_RIPA'));		
		var temp_ip1 = new addr_obj(ip1.split("."), radius1_msg, false, false);	
		var temp_radius1 = new raidus_obj(temp_ip1, $('#RadiusServerPort1').val(), $('#RadiusServerSecret1').val());

		if (!check_radius(temp_radius1)){
			return false;
		}
		
		/*
		if($('#RadiusServerIP1').val()==""){
			alert('Please input the radius server IP address.');
			return false;		
		}
		if($('#RadiusServerPort1').val()==""){
			alert('Please input the radius server port number.');
			return false;		
		}
		if($('#RadiusServerSecret1').val()==""){
			alert('Please input the radius server shared secret.');
			return false;		
		}

		if(checkIpAddr(document.security_form.RadiusServerIP) == false){
			alert('Please input a valid radius server ip address.');
			return false;		
		}
		if( (checkRange(document.security_form.RadiusServerPort.value, 1, 65535)==false) ||
			(checkAllNum(document.security_form.RadiusServerPort.value)==false)){
			alert('Please input a valid radius server port number.');
			return false;		
		}
		if(checkInjection(document.security_form.RadiusServerSecret.value)==false){
			alert('The shared secret contains invalid characters.');
			return false;		
		}

		if(document.security_form.RadiusServerSessionTimeout.value.length){
			if(checkAllNum(document.security_form.RadiusServerSessionTimeout.value)==false){
				alert('Please input a valid session timeout number or u may left it empty.');
				return false;	
			}	
		}*/

		return true;
	}
	
//security end

function setValueRadioOnSchedule(obj)
{
	var val_sche = '<!--# echo wlan0_vap0_schedule -->';
	$('#ssid_schedule').val(val_sche);
}
function setValueRadioOnSchedule1(obj)
{
	var val_sche = '<!--# echo wlan1_vap0_schedule -->';
	$('#ssid_schedule1').val(val_sche);
}

$(function(){
	if(get_by_id("wlan0_vap0_enable").value==1)
		$('#radioOnField').show();
	else
		$('#radioOffField').show();
		
	//Wireless Network
	setValueRadioOnSchedule();
	setValueWMode();
	setValueWirelessName();
	setValueBoardcastSSID();
	setValueFrequency();
	setEventWMode();
	//setEventFrequency();
	
	//HT Physical Mode
	//setValueOperatingMode();
	setValueChannelBandWidth();
	//setEventChannelBandWidth();
	
	//Other
//	$('#div_11n_plugfest').show();//close
//	setValueFortyIntolerant();//close
//	setValueWiFiOptimum();//close
	//setValueHTTxStream();
	//setValueHTRxStream();
	
	//Security
	setValueSecurModeList();
	MBSSIDChange(0);
	
	
	if(get_by_id("wlan1_vap0_enable").value==1)
		$('#radioOnField1').show();
	else
		$('#radioOffField1').show();
	
	//Wireless Network
	setValueRadioOnSchedule1();
	setValueWMode1();
	setValueWirelessName1();
	setValueBoardcastSSID1();
	setValueFrequency1();
	setEventWMode1();
	setValueWirelessPskPassPhrase();
	//setEventFrequency1();
	
	//HT Physical Mode
	//setValueOperatingMode1();
	setValueChannelBandWidth1();
	setEventChannelBandWidth1();
	
	//Other
//	$('#div_11n_plugfest1').show();//close
//	setValueFortyIntolerant1();//close
//	setValueWiFiOptimum1();//close
	//setValueHTTxStream1();
	//setValueHTRxStream1();
	
	//Security
	setValueSecurModeList1();
	MBSSIDChange1(4);
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
							<script>document.write(menu.build_structure(0,1,-1))</script>
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
												<script>show_words('_basic_wireless_settings')</script>
												</div>
												<div class="hr"></div>
												<div class="section_content_border">
												<div class="header_desc" id="basicIntroduction">
													<script>show_words('_desc_basic')</script>
													<p></p>
										</div>

				<input type="hidden" id="wlan0_vap0_ssid" name="wlan0_vap0_ssid" value="<!--# echot wlan0_vap0_ssid -->">
				<input type="hidden" id="wlan1_vap0_ssid" name="wlan1_vap0_ssid" value="<!--# echot wlan1_vap0_ssid -->">
				<input type="hidden" id="wlan0_vap0_wep_display" name="wlan0_vap0_wep_display" value="<!--# echo wlan0_vap0_wep_display_key_1 -->">
				<input type="hidden" id="wlan1_vap0_wep_display" name="wlan1_vap0_wep_display" value="<!--# echo wlan1_vap0_wep_display_key_1 -->">
				<input type="hidden" id="wlan0_dot11_mode" name="wlan0_dot11_mode" value="<!--# echo wlan0_dot11_mode -->">
				<input type="hidden" id="wlan1_dot11_mode" name="wlan1_dot11_mode" value="<!--# echo wlan1_dot11_mode -->">
				<input type="hidden" id="wlan0_vap0_wep_default_key" name="wlan0_vap0_wep_default_key" value="<!--# echo wlan0_vap0_wep_default_key -->"> 
				<input type="hidden" id="wlan0_vap0_security" name="wlan0_vap0_security" value="<!--# echo wlan0_vap0_security -->">
				<input type="hidden" id="wlan0_vap0_psk_cipher_type" name="wlan0_vap0_psk_cipher_type" value="<!--# echo wlan0_vap0_psk_cipher_type -->">
				<input type="hidden" id="wlan0_vap0_eap_radius_server_0" name="wlan0_vap0_eap_radius_server_0" value="<!--# echo wlan0_vap0_eap_radius_server_0 -->">
				<input type="hidden" id="wlan0_vap0_enable" name="wlan0_vap0_enable" value="<!--# echo wlan0_vap0_enable -->"> 
				<input type="hidden" id="wlan1_vap0_wep_default_key" name="wlan1_vap0_wep_default_key" value="<!--# echo wlan1_vap0_wep_default_key -->"> 
				<input type="hidden" id="wlan1_vap0_security" name="wlan1_vap0_security" value="<!--# echo wlan1_vap0_security -->">
				<input type="hidden" id="wlan1_vap0_psk_cipher_type" name="wlan1_vap0_psk_cipher_type" value="<!--# echo wlan1_vap0_psk_cipher_type -->">
				<input type="hidden" id="wlan1_vap0_eap_radius_server_0" name="wlan1_vap0_eap_radius_server_0" value="<!--# echo wlan1_vap0_eap_radius_server_0 -->">
				<input type="hidden" id="wlan1_vap0_schedule" name="wlan1_vap0_schedule" value="<!--# echo wlan1_vap0_schedule -->">
				<input type="hidden" id="wlan1_vap0_enable" name="wlan1_vap0_enable" value="<!--# echo wlan1_vap0_enable -->"> 

				<span id="wlan0_vap0_wep64_key_1" style="display:none;"><!--# echo wlan0_vap0_wep64_key_1","hex --></span>
				<span id="wlan0_vap0_wep64_key_2" style="display:none;"><!--# echo wlan0_vap0_wep64_key_2","hex --></span>
				<span id="wlan0_vap0_wep64_key_3" style="display:none;"><!--# echo wlan0_vap0_wep64_key_3","hex --></span>
				<span id="wlan0_vap0_wep64_key_4" style="display:none;"><!--# echo wlan0_vap0_wep64_key_4","hex --></span>
				<span id="wlan0_vap0_wep128_key_1" style="display:none;"><!--# echo wlan0_vap0_wep128_key_1","hex --></span>
				<span id="wlan0_vap0_wep128_key_2" style="display:none;"><!--# echo wlan0_vap0_wep128_key_2","hex --></span>
				<span id="wlan0_vap0_wep128_key_3" style="display:none;"><!--# echo wlan0_vap0_wep128_key_3","hex --></span>
				<span id="wlan0_vap0_wep128_key_4" style="display:none;"><!--# echo wlan0_vap0_wep128_key_4","hex --></span>
				<span id="wlan1_vap0_wep64_key_1" style="display:none;"><!--# echo wlan1_vap0_wep64_key_1","hex --></span>
				<span id="wlan1_vap0_wep64_key_2" style="display:none;"><!--# echo wlan1_vap0_wep64_key_2","hex --></span>
				<span id="wlan1_vap0_wep64_key_3" style="display:none;"><!--# echo wlan1_vap0_wep64_key_3","hex --></span>
				<span id="wlan1_vap0_wep64_key_4" style="display:none;"><!--# echo wlan1_vap0_wep64_key_4","hex --></span>
				<span id="wlan1_vap0_wep128_key_1" style="display:none;"><!--# echo wlan1_vap0_wep128_key_1","hex --></span>
				<span id="wlan1_vap0_wep128_key_2" style="display:none;"><!--# echo wlan1_vap0_wep128_key_2","hex --></span>
				<span id="wlan1_vap0_wep128_key_3" style="display:none;"><!--# echo wlan1_vap0_wep128_key_3","hex --></span>
				<span id="wlan1_vap0_wep128_key_4" style="display:none;"><!--# echo wlan1_vap0_wep128_key_4","hex --></span>
				<input type="hidden" id="wlan0_vap0_gkey_rekey_time" name="wlan0_vap0_gkey_rekey_time" value="<!--# echo wlan0_vap0_gkey_rekey_time -->"> 
				<input type="hidden" id="wlan0_vap0_eap_reauth_period" name="wlan0_vap0_eap_reauth_period" value="<!--# echo wlan0_vap0_eap_reauth_period -->">
				<input type="hidden" id="wlan1_vap0_gkey_rekey_time" name="wlan1_vap0_gkey_rekey_time" value="<!--# echo wlan1_vap0_gkey_rekey_time -->"> 
				<input type="hidden" id="wlan1_vap0_eap_reauth_period" name="wlan1_vap0_eap_reauth_period" value="<!--# echo wlan1_vap0_eap_reauth_period -->">
				<input type="hidden" id="wlan0_vap0_psk_pass_phrase" name="wlan0_vap0_psk_pass_phrase" value="<!--# echot wlan0_vap0_psk_pass_phrase -->">
				<input type="hidden" id="wlan1_vap0_psk_pass_phrase" name="wlan1_vap0_psk_pass_phrase" value="<!--# echot wlan1_vap0_psk_pass_phrase -->">
       
		<div id="radioOnField" style="display:none;">
				<div class="box_tn">
					<div class="CT"><script>show_words('_wireless_2')</script></div>
					<table cellspacing="0" cellpadding="0" class="formarea">
					<tr>
						<td class="CL"><script>show_words('_lb_radio_onoff')</script></td>
						<td class="CR">
							<input type="button" id="radioButtonOff" name="radioButtonOff" class="button_inbox" value="" onclick="switchRadio(0)" /> &nbsp; 
							<script>$('#radioButtonOff').val(get_words('_btn_radio_off'));</script>
							<span id="scheduleField">
								<select id="ssid_schedule" name="ssid_schedule">
									<option value="Always"><script>show_words('_always');</script></option>
									<option value="Never"><script>show_words('_never');</script></option>
									<script>add_option();</script>
								</select>
							</span>
							<input type="button" id="sche_btn" onclick="location.assign('/adv_schedule.asp');" />
							<script>$('#sche_btn').val(get_words('tc_new_sch'));</script>
						</td>
					</tr>
					<tr> 
						<td class="CL"><script>show_words('WLANMODE')</script></td>
						<td class="CR">
							<select name="dot11_mode" id="dot11_mode" size="1">
					<!--			<option value="b"><script>show_words('m_bwl_Mode_1')</script></option>
								<option value="g"><script>show_words('m_bwl_Mode_2')</script></option> -->
								<option value="11bg"><script>show_words('m_bwl_Mode_3')</script></option>
								<option value="11n"><script>show_words('m_bwl_Mode_8')</script></option>
					<!--			<option value="ng"><script>show_words('m_bwl_Mode_10')</script></option> -->
								<option value="11bgn"><script>show_words('m_bwl_Mode_11')</script></option>
							</select>
							<input type="hidden" id="wlan0_dot11_mode" name="wlan0_dot11_mode" value='' />
						</td>
					</tr>
					<!-- 11b/g txrate -->
					<tr id="show_11bg_txrate" style="display:none">
						<td class="CL"><script>show_words('bwl_TxR')</script></td>
						<td class="CR">
							<select id="wlan0_vap0_11bg_txrate" name="wlan0_vap0_11bg_txrate">
								<option value="auto" selected><script>show_words('KR50')</script></option>
								<script>set_11bg_txrate(get_by_id("wlan0_vap0_11bg_txrate"));</script>
							</select>
						</td>
					</tr>
					<tr> 
						<td class="CL"><script>show_words('_wmode_ssid')</script></td>
						<td class="CR">
							<input name="submit_SSID0" type="text" id="show_ssid_0" size="32" maxlength="32" value="" />
						</td>
					</tr>
					
					<tr> 
						<td class="CL"><script>show_words('_lb_broadcast_ssid')</script></td>
						<td class="CR">
							<input type="radio" id="wlan0_vap0_ssid_broadcast" name="wlan0_vap0_ssid_broadcast" value="1" /><script>show_words('_enable');</script>&nbsp;
							<input type="radio" id="wlan0_vap0_ssid_broadcast" name="wlan0_vap0_ssid_broadcast" value="0" /><script>show_words('_disable');</script>
						</td>
					</tr>
					
					<tr style="display:none"> 
						<td class="CL"><script>show_words('_bssid');</script></td>
						<td class="CR">&nbsp;&nbsp;<script></script></td>
					</tr>
					<tr>
						<td class="CL"><script>show_words('_help_txt136')</script></td>
						<td class="CR">
							<select id="sel_wlan0_channel" name="sel_wlan0_channel">
							</select>
							<input type="hidden" id="wlan0_channel" name="wlan0_channel" value='' />
						</td>
					</tr>
					
					<tr id="opmode" style="display:none">
						<td class="CL"><script>show_words('_help_txt146');</script></td>
						<td class="CR">
							<input type="radio" name="n_opmode" value="0" /><script>show_words('_sel_mixed');</script>&nbsp;
							<input type="radio" name="n_opmode" value="1" /><script>show_words('_sel_greenfield');</script>
						</td>
					</tr>
					<tr id="bandwidth">
						<td class="CL"><script>show_words('_help_txt151')</script></td>
						<td class="CR" id="n_bandwidth">
							<input type="radio" name="n_bandwidth" value="0" /><script>show_words('bwl_ht20')</script>&nbsp;
							<input type="radio" name="n_bandwidth" value="1" /><script>show_words('bwl_ht2040')</script>
						</td>
					</tr>
					<tr style="display:none;">
						<td class="CL"><script>show_words('_lb_exten_channel');</script></td>
						<td class="CR">
							<select id="n_extcha" name="n_extcha" size="1" disabled="">
								<option value="0" selected=""><script>show_words('_sel_autoselect');</script></option>
							</select>
						</td>
					</tr>
					</table>
				</div>

				<div class="box_tn">
					<table width="100%" border="0" align="center" cellpadding="1" cellspacing="0" class="formarea">
					<tr><td colspan="2" class="CT"><script>show_words('ES_security')</script></td></tr>
					<tr style="display:">
						<td class="CL"><script>show_words('bws_SM')</script></td>
						<td class="CR">
							<span id="SecurMode_list"></span>
						</td>
					</tr>
					<tr style="display:none" id="security_shared_mode">
						<td class="CL"><script>show_words('_wifiser_mode8')</script></td>
						<td class="CR">
							<select name="shared_mode" id="shared_mode" size="1" onChange="securityMode(1)">
								<option value=WEP><script>show_words('LS321')</script></option>
								<option value=None><script>show_words('_none')</script></option>
							</select>
						</td>
					</tr>
					</table>
				</div>

				<div class="box_tn" id="msgbox" style="display:none">
					<table width="100%" border="0" align="center" cellpadding="1" cellspacing="0" class="formarea">
						<tr>
							<td colspan="2" class="CELL">
								<font color="red" id="NmodeMsg" name="NmodeMsg"><script>show_words('_wifiser_mode9')</script>
								</font>
							</td>
						</tr>
					</table>
				</div>
			
				<!-- WEP -->
				<div id="wep" class="box_tn" style="display:none;">
					<table width="100%" border="0" align="center" cellpadding="1" cellspacing="0" class="formarea">
					<tr><td colspan="3" class="CT"><script>show_words('_WEP')</script></td></tr>
											<tr>
						<td class="CL"><script>show_words('_wifiser_mode10')</script></td>
						<td class="CR" colspan="2">
							<select name="wep_def_key" id="wep_def_key" size="1">
								<option value="1"><script>show_words('_wifiser_mode11')</script> 1</option>
								<option value="2"><script>show_words('_wifiser_mode11')</script> 2</option>
								<option value="3"><script>show_words('_wifiser_mode11')</script> 3</option>
								<option value="4"><script>show_words('_wifiser_mode11')</script> 4</option>
							</select>
						</td>
					</tr>
					<tr>
						<td class="CL"><script>show_words('LW22')</script> 1 :</td>
						<td class="CELL"><input name="wep_key_1" id="key1" maxlength="26" value="" /></td>
												<td class="CELL">
							<select id="WEP1Select" name="WEP1Select"> 
								<option value="1"><script>show_words('help423')</script></option>
								<option value="0"><script>show_words('_wifiser_mode12')</script></option>
							</select>
						</td>
					</tr>
											<tr>
						<td class="CL"><script>show_words('LW22')</script> 2 :</td>
						<td class="CELL"><input name="wep_key_2" id="key2" maxlength="26" value="" /></td>
						<td class="CELL">
							<select id="WEP2Select" name="WEP2Select">
								<option value="1"><script>show_words('help423')</script></option>
								<option value="0"><script>show_words('_wifiser_mode12')</script></option>
							</select>
						</td>
					</tr>
											<tr>
						<td class="CL"><script>show_words('LW22')</script> 3 :</td>
						<td class="CELL"><input name="wep_key_3" id="key3" maxlength="26" value="" /></td>
						<td class="CELL">
							<select id="WEP3Select" name="WEP3Select">
								<option value="1"><script>show_words('help423')</script></option>
								<option value="0"><script>show_words('_wifiser_mode12')</script></option>
							</select>
						</td>
					</tr>
											<tr>
						<td class="CL"><script>show_words('LW22')</script> 4 :</td>
						<td class="CELL"><input name="wep_key_4" id="key4" maxlength="26" value="" /></td>
						<td class="CELL">
							<select id="WEP4Select" name="WEP4Select">
								<option value="1"><script>show_words('help423')</script></option>
								<option value="0"><script>show_words('_wifiser_mode12')</script></option>
							</select>
						</td>
					</tr>
					</table>
				</div>

				<!-- WPA -->
				<div id="wpa" class="box_tn" style="display:none;">
					<table width="100%" border="0" align="center" cellpadding="1" cellspacing="0" class="formarea">
					<tr><td colspan="4" class="CT"><script>show_words('help750')</script></td></tr>
					<tr id="wpa_algorithms" name="wpa_algorithms" style="display:none"> 
						<td class="CL"><script>show_words('_wifiser_mode13')</script></td>
						<td id="TKIP_cipher" class="CELL">
													<input name="cipher" id="cipher" value="0" type="radio" onClick="onWPAAlgorithmsClick(0)" />
							<script>show_words('bws_CT_1')</script> &nbsp;
						</td>
						<td id="AES_cipher" class="CELL">
													<input name="cipher" id="cipher" value="1" type="radio" onClick="onWPAAlgorithmsClick(1)" />
							<script>show_words('bws_CT_2')</script>  &nbsp;
						</td>
						<td id="TKIPAES_cipher" class="CELL">
													<input name="cipher" id="cipher" value="2" type="radio" onClick="onWPAAlgorithmsClick(2)" />
							<script>show_words('bws_CT_1')</script>/<script>show_words('bws_CT_2')</script> &nbsp;
						</td>
					</tr>
					<tr id="wpa_mode_algorithms" name="wpa_mode_algorithms" style="display:none"> 
						<td class="CL"><script>show_words('bws_WPAM')</script></td>
						<td id="auto" class="CELL">
							<input name="wpa_mode" id="wpa_mode" value="0" type="radio" />
							<script>show_words('KR50')</script> &nbsp;
						</td>
						<td id="wpa" class="CELL">
							<input name="wpa_mode" id="wpa_mode" value="1" type="radio" />
							<script>show_words('_WPA')</script>  &nbsp;
						</td>
						<td id="wpa2" class="CELL">
							<input name="wpa_mode" id="wpa_mode" value="2" type="radio" />
							<script>show_words('_wifiser_mode6')</script> &nbsp;
						</td>
					</tr>
					<tr id="wpa_passphrase" name="wpa_passphrase" style="display:none">
						<td class="CL"><script>show_words('help381')</script></td>
						<td colspan="3" class="CELL">
													<input name="passphrase" id="passphrase" size="28" maxlength="64" value="" />
						</td>
					</tr>
					<tr id="wpa_key_renewal_interval" name="wpa_key_renewal_interval" style="display:none">
						<td class="CL"><script>show_words('_wifiser_mode14')</script></td>
						<td colspan="3" class="CELL">
							<input name="keyRenewalInterval" id="keyRenewalInterval" size="6" maxlength="6" value="3600" />
							<script>show_words('_seconds')</script>
						</td>
					</tr>
					<tr id="wpa_PMK_Cache_Period" name="wpa_PMK_Cache_Period" style="display:none">
						<td class="CL"><script>show_words('_wifiser_mode15')</script></td>
						<td colspan="3" class="CELL">
							<input name="PMKCachePeriod" id="PMKCachePeriod" size="4" maxlength="4" value="" /> 
							<script>show_words('tt_Minute')</script>
						</td>
					</tr>
					<tr id="wpa_preAuthentication" name="wpa_preAuthentication" style="display:none">
						<td class="CL"><script>show_words('_wifiser_mode16')</script></td>
						<td colspan="3" class="CELL">
							<input name="PreAuthentication" id="PreAuthentication" value="0" type="radio" />
							<script>show_words('_disable')</script> &nbsp;
							<input name="PreAuthentication" id="PreAuthentication" value="1" type="radio" />
							<script>show_words('_enable')</script> &nbsp;
						</td>
					</tr>
					</table>
				</div>

				<!-- 802.1x -->
				<!-- WEP  -->
				<div id="8021x_wep" class="box_tn" style="display:none;">
					<table width="100%" border="0" align="center" cellpadding="1" cellspacing="0" class="formarea">
					<tr><td colspan="3" class="CT"><script>show_words('_wifiser_mode17')</script></td></tr>
					<tr id="wpa_algorithms" name="wpa_algorithms" style="display:none"> 
						<td class="CL"><script>show_words('_WEP')</script></td>
						<td colspan="2" class="CELL">
							<input name="ieee8021x_wep" id="ieee8021x_wep" value="0" type="radio" />
							<script>show_words('_disable')</script> &nbsp;
							<input name="ieee8021x_wep" id="ieee8021x_wep" value="1" type="radio" />
							<script>show_words('_enable')</script> &nbsp;
						</td>
					</tr>
					</table>
				</div>
			
				<div id="radius_server" class="box_tn" style="display:none;">
					<table width="100%" border="0" align="center" cellpadding="1" cellspacing="0" class="formarea">
					<tr><td colspan="3" class="CT"><script>show_words('_wifiser_mode18')</script></td></tr>
					<tr> 
						<td class="CL"><script>show_words('ES_IP_ADDR')</script></td>
						<td colspan="2" class="CELL">
							<input name="RadiusServerIP" id="RadiusServerIP" size="16" maxlength="32" value="" />
						</td>
					</tr>
					<tr> 
						<td class="CL"><script>show_words('sps_port')</script></td>
						<td colspan="2" class="CELL">
							<input name="RadiusServerPort" id="RadiusServerPort" size="5" maxlength="5" onkeyup="value=value.replace(/[^0-9]/g,'')" />
						</td>
					</tr>
					<tr> 
						<td class="CL"><script>show_words('_wifiser_mode19')</script></td>
						<td colspan="2" class="CELL">
							<input name="RadiusServerSecret" id="RadiusServerSecret" size="16" maxlength="64" value="" />
						</td>
					</tr>
					<tr style="display:none"> 
						<td class="CL"><script>show_words('_wifiser_mode20')</script></td>
						<td colspan="2" class="CELL">
							<input name="RadiusServerSessionTimeout" id="RadiusServerSessionTimeout" size="3" maxlength="4" value="0" />
						</td>
					</tr>
					<tr style="display:none"> 
						<td class="CL"><script>show_words('_wifiser_mode21')</script></td>
						<td colspan="2" class="CELL">
							<input name="RadiusServerIdleTimeout" id="RadiusServerIdleTimeout" size="3" maxlength="4" value="" readonly>
						</td>
					</tr>
					</table>
				</div>

				<div id="div_11n_plugfest" class="box_tn" style="display:none">
					<div class="CT">Other</div>
					<table name="div_11n_plugfest" cellspacing="0" cellpadding="0" class="formarea">
						<!--
						<tr>
							<td class="CL"><script>show_words('_lb_forty_into');</script></td>
							<td class="CR"><font color="#003366" face=arial><b>
								<input type=radio name=f_40mhz value="0" /><script>show_words('_disable');</script>&&nbsp;
								<input type=radio name=f_40mhz value="1" /><script>show_words('_enable');</script>
							</b></font></td>
						</tr>
						<tr>
							<td class="CL"><script>show_words('_lb_wifi_opt');</script></td>
							<td class="CR">
								<input type=radio name=wifi_opt value="0" /><script>show_words('_disable');</script>&&nbsp;
								<input type=radio name=wifi_opt value="1" /><script>show_words('_enable');</script>
							</td>
						</tr>
						-->
						<tr>
							<td class="CL"><script>show_words('_lb_ht_txstream');</script></td>
							<td class="CR">
								<select id="tx_stream" name="tx_stream" size="1">
									<option value="1">1</option>
									<option value="2">2</option>
									<option value="3">3</option>
								</select>
							</td>
						</tr>
						<tr>
							<td class="CL"><script>show_words('_lb_ht_rxstream');</script></td>
							<td class="CR">
								<select id="rx_stream" name="rx_stream" size="1">
									<option value="1">1</option>
									<option value="2">2</option>
									<option value="3">3</option>
								</select>
							</td>
						</tr>
					</table>
				</div>

				<div id="buttonField" class="box_tn">
					<table cellspacing="0" cellpadding="0" class="formarea">
					<tr align="center">
						<td colspan="2" class="btn_field">
							<input type="button" class="button_submit" id="btn_apply" value="Apply" onclick="return check_apply();" />
							<script>$('#btn_apply').val(get_words('_apply'));</script>
							<input type="reset" class="button_submit" id="btn_cancel" value="Cancel" onclick="window.location.reload()" />
							<script>$('#btn_cancel').val(get_words('_cancel'));</script>
						</td>
					</tr>
					</table>
				</div>
		</div>
		<!-- end of radioOnField  -->
		
		<div id="radioOffField" style="display:none;">
			<div class="box_tn">
				<div class="CT"><script>show_words('_wireless_2')</script></div>
				<table cellspacing="0" cellpadding="0" class="formarea">
				<tr>
					<td class="CL"><script>show_words('_lb_radio_onoff')</script></td>
					<td class="CR">
						<input type="button" id="radioButtonOn" name="radioButtonOn" style="{width:120px;}" value="" onclick="switchRadio(1);" /> &nbsp; &nbsp;
						<script>$('#radioButtonOn').val(get_words('_btn_radio_on'));</script>
						<input type="hidden" name="radiohiddenButton" value="2" />
					</td>
				</tr>
				<tr>
					<td colspan="2" align="center" class="CELL"><font color="red" id="Msg" name="Msg"><script>show_words('_MSG_woff');</script></font></td>
				</tr>
				</table>
			</div>
		</div>
		<!-- end of radioOffField  -->

		<div id="radioOnField1" style="display:none;">
			<div class="box_tn">
				<div class="CT"><script>show_words('_wireless_5')</script></div>
					<table cellspacing="0 "cellpadding="0" class="formarea">
						<tr>
							<td class="CL"><script>show_words('_lb_radio_onoff')</script></td>
							<td class="CR">
								<input type="button" id="radioButtonOff1" name="radioButtonOff1" class="button_inbox" value="" onclick="switchRadio1(0)" /> &nbsp; 
								<script>$('#radioButtonOff1').val(get_words('_btn_radio_off'));</script>
								<span id="scheduleField1">
								<select id="ssid_schedule1" name="ssid_schedule1">
									<option value="Always"><script>show_words('_always');</script></option>
									<option value="Never"><script>show_words('_never');</script></option>
									<script>add_option();</script>
								</select>
							</span>
							<input type="button" id="sche_btn1" onclick="location.assign('/adv_schedule.asp');" />
							<script>$('#sche_btn1').val(get_words('tc_new_sch'));</script>
							</td>
						</tr>
						<tr>
							<td class="CL"><script>show_words('WLANMODE')</script></td>
							<td class="CR">
								<select name="dot11_mode1" id="dot11_mode1" size="1">
									<option value="11a"><script>show_words('m_bwl_Mode5_1')</script></option>
									<option value="11n"><script>show_words('m_bwl_Mode5_2')</script></option>
									<option value="11na"><script>show_words('m_bwl_Mode5_3')</script></option>
									<option value="11ac"><script>show_words('m_bwl_Mode5_4')</script></option>
								</select>
								<input type="hidden" id="wlan1_dot11_mode" name="wlan0_dot11_mode" value='' />
							</td>
						</tr>
						<!-- 11a txrate -->
						<tr id="show_11a_txrate1" style="display:none">
							<td class="CL"><script>show_words('bwl_TxR')</script></td>
							<td class="CR">
								<select id="wlan1_vap0_11a_txrate" name="wlan1_vap0_11a_txrate">
									<option value="auto" selected><script>show_words('KR50')</script></option>
									<script>set_11a_txrate(get_by_id("wlan1_vap0_11a_txrate"));</script>
								</select>
							</td>
						</tr>
						<tr>
							<td class="CL"><script>show_words('_wmode_ssid')</script></td>
							<td class="CR">
								<input name="submit_SSID01" type="text" id="show_ssid1_0" size="32" maxlength="32" value="" />
							</td>
						</tr>
						<tr> 
							<td class="CL"><script>show_words('_lb_broadcast_ssid')</script></td>
							<td class="CR">
								<input type="radio" id="wlan1_vap0_ssid_broadcast" name="wlan1_vap0_ssid_broadcast" value="1" /><script>show_words('_enable');</script>&nbsp;
								<input type="radio" id="wlan1_vap0_ssid_broadcast" name="wlan1_vap0_ssid_broadcast" value="0" /><script>show_words('_disable');</script>
							</td>
						</tr>
						<tr style="display:none"> 
							<td class="CL"><script>show_words('_bssid');</script></td>
							<td class="CR">&nbsp;&nbsp;<script></script></td>
						</tr>
						<tr>
							<td class="CL"><script>show_words('_help_txt136')</script></td>
							<td class="CR">
								<select id="sel_wlan1_channel" name="sel_wlan1_channel">
								</select>
								<input type="hidden" id="wlan1_channel" name="wlan1_channel" value='' />
							</td>
						</tr>
						
						<tr id="opmode1" style="display:none">
							<td class="CL"><script>show_words('_help_txt146');</script></td>
							<td class="CR">
								<input type="radio" name="n_opmode1" value="0" /><script>show_words('_sel_mixed');</script>&nbsp;
								<input type="radio" name="n_opmode1" value="1" /><script>show_words('_sel_greenfield');</script>
							</td>
						</tr>
						<tr id="bandwidth1">
							<td class="CL"><script>show_words('_help_txt151')</script></td>
							<td class="CR" id="n_bandwidth1">
								<span id="bwl1_20"><input type="radio" name="n_bandwidth1" value="0" /><script>show_words('bwl_ht20')</script></span><br/>
								<span id="bwl1_2040"><input type="radio" name="n_bandwidth1" value="1" /><script>show_words('bwl_ht2040')</script></span><br/>
								<span id="bwl1_204080"><input type="radio" name="n_bandwidth1" value="2" /><script>show_words('bwl_ht204080')</script></span>
							</td>
						</tr>
						<tr style="display:none;">
							<td class="CL"><script>show_words('_lb_exten_channel');</script></td>
							<td class="CR">
								<select id="n_extcha1" name="n_extcha1" size="1" disabled="">
									<option value="0" selected=""><script>show_words('_sel_autoselect');</script></option>
								</select>
							</td>
						</tr>
					</table>
			</div>
		
			<div class="box_tn">
				<table width="100%" border="0" align="center" cellpadding="1" cellspacing="0" class="formarea">
				<tr><td colspan="2" class="CT"><script>show_words('ES_security')</script></td></tr>
				<tr>
					<td class="CL"><script>show_words('bws_SM')</script></td>
					<td class="CR">
						<span id="SecurMode_list1"></span>
					</td>
				</tr>
				<tr style="display:none" id="security_shared_mode1">
					<td class="CL"><script>show_words('_wifiser_mode8')</script></td>
					<td class="CR">
						<select name="shared_mode1" id="shared_mode1" size="1" onChange="securityMode1(1)">
							<option value=WEP><script>show_words('LS321')</script></option>
							<option value=None><script>show_words('_none')</script></option>
						</select>
					</td>
				</tr>
				</table>
			</div>
		
			<div class="box_tn" id="msgbox1" style="display:none">
				<table width="100%" border="0" align="center" cellpadding="1" cellspacing="0" class="formarea">
					<tr>
						<td colspan="2" class="CELL">
							<font color="red" id="NmodeMsg1" name="NmodeMsg1"><script>show_words('_wifiser_mode9')</script>
							</font>
						</td>
					</tr>
				</table>
			</div>
		
			<!-- WEP -->
			<div id="wep1" class="box_tn" style="display:none;">
				<table width="100%" border="0" align="center" cellpadding="1" cellspacing="0" class="formarea">
				<tr><td colspan="3" class="CT"><script>show_words('_WEP')</script></td></tr>
											<tr>
					<td class="CL"><script>show_words('_wifiser_mode10')</script></td>
					<td class="CR" colspan="2">
						<select name="wep_def_key1" id="wep_def_key1" size="1">
							<option value="1"><script>show_words('_wifiser_mode11')</script> 1</option>
							<option value="2"><script>show_words('_wifiser_mode11')</script> 2</option>
							<option value="3"><script>show_words('_wifiser_mode11')</script> 3</option>
							<option value="4"><script>show_words('_wifiser_mode11')</script> 4</option>
						</select>
					</td>
				</tr>
				<tr>
					<td class="CL"><script>show_words('LW22')</script> 1 :</td>
					<td class="CELL"><input name="wep_key_11" id="key5" maxlength="26" value="" /></td>
												<td class="CELL">
						<select id="WEP1Select1" name="WEP1Select1"> 
							<option value="1"><script>show_words('help423')</script></option>
							<option value="0"><script>show_words('_wifiser_mode12')</script></option>
						</select>
					</td>
				</tr>
											<tr>
					<td class="CL"><script>show_words('LW22')</script> 2 :</td>
					<td class="CELL"><input name="wep_key_21" id="key6" maxlength="26" value="" /></td>
					<td class="CELL">
						<select id="WEP2Select1" name="WEP2Select1">
							<option value="1"><script>show_words('help423')</script></option>
							<option value="0"><script>show_words('_wifiser_mode12')</script></option>
						</select>
					</td>
				</tr>
											<tr> 
					<td class="CL"><script>show_words('LW22')</script> 3 :</td>
					<td class="CELL"><input name="wep_key_31" id="key7" maxlength="26" value="" /></td>
					<td class="CELL">
						<select id="WEP3Select1" name="WEP3Select1">
							<option value="1"><script>show_words('help423')</script></option>
							<option value="0"><script>show_words('_wifiser_mode12')</script></option>
						</select>
					</td>
				</tr>
											<tr>
					<td class="CL"><script>show_words('LW22')</script> 4 :</td>
					<td class="CELL"><input name="wep_key_41" id="key8" maxlength="26" value="" /></td>
					<td class="CELL">
						<select id="WEP4Select1" name="WEP4Select1">
							<option value="1"><script>show_words('help423')</script></option>
							<option value="0"><script>show_words('_wifiser_mode12')</script></option>
						</select>
					</td>
				</tr>
				</table>
			</div>
		
			<!-- WPA -->
			<div id="wpa1" class="box_tn" style="display:none;">
				<table width="100%" border="0" align="center" cellpadding="1" cellspacing="0" class="formarea">
				<tr><td colspan="4" class="CT"><script>show_words('help750')</script></td></tr>
				<tr id="wpa_algorithms1" name="wpa_algorithms1" style="display:none"> 
					<td class="CL"><script>show_words('_wifiser_mode13')</script></td>
					<td id="TKIP_cipher1" class="CELL">
													<input name="cipher1" id="cipher1" value="0" type="radio" onClick="onWPAAlgorithmsClick1(0)" />
						<script>show_words('bws_CT_1')</script> &nbsp;
					</td>
					<td id="AES_cipher1" class="CELL">
													<input name="cipher1" id="cipher1" value="1" type="radio" onClick="onWPAAlgorithmsClick1(1)" />
						<script>show_words('bws_CT_2')</script>  &nbsp;
					</td>
					<td id="TKIPAES_cipher1" class="CELL">
													<input name="cipher1" id="cipher1" value="2" type="radio" onClick="onWPAAlgorithmsClick1(2)" />
						<script>show_words('bws_CT_1')</script>/<script>show_words('bws_CT_2')</script> &nbsp;
					</td>
				</tr>
				<tr id="wpa_mode_algorithms1" name="wpa_mode_algorithms1" style="display:none"> 
					<td class="CL"><script>show_words('bws_WPAM')</script></td>
					<td id="auto1" class="CELL">
						<input name="wpa_mode1" id="wpa_mode1" value="0" type="radio" />
						<script>show_words('KR50')</script> &nbsp;
					</td>
					<td id="wpa1" class="CELL">
						<input name="wpa_mode1" id="wpa_mode1" value="1" type="radio" />
						<script>show_words('_WPA')</script>  &nbsp;
					</td>
					<td id="wpa21" class="CELL">
						<input name="wpa_mode1" id="wpa_mode1" value="2" type="radio" />
						<script>show_words('_wifiser_mode6')</script> &nbsp;
					</td>
				</tr>		
				<tr id="wpa_passphrase1" name="wpa_passphrase1" style="display:none">
					<td class="CL"><script>show_words('help381')</script></td>
					<td colspan="3" class="CELL">
					<input name="passphrase1" id="passphrase1" size="28" maxlength="64" value="" />
					</td>
				</tr>
				<tr id="wpa_key_renewal_interval1" name="wpa_key_renewal_interval1" style="display:none">
					<td class="CL"><script>show_words('_wifiser_mode14')</script></td>
					<td colspan="3" class="CELL">
						<input name="keyRenewalInterval1" id="keyRenewalInterval1" size="6" maxlength="6" value="3600" />
						<script>show_words('_seconds')</script>
					</td>
				</tr>
				<tr id="wpa_PMK_Cache_Period1" name="wpa_PMK_Cache_Period1" style="display:none">
					<td class="CL"><script>show_words('_wifiser_mode15')</script></td>
					<td colspan="3" class="CELL">
						<input name="PMKCachePeriod1" id="PMKCachePeriod1" size="4" maxlength="4" value="" /> 
						<script>show_words('tt_Minute')</script>
					</td>
				</tr>
				<tr id="wpa_preAuthentication1" name="wpa_preAuthentication1" style="display:none">
					<td class="CL"><script>show_words('_wifiser_mode16')</script></td>
					<td colspan="3" class="CELL">
						<input name="PreAuthentication1" id="PreAuthentication1" value="0" type="radio" />
						<script>show_words('_disable')</script> &nbsp;
						<input name="PreAuthentication1" id="PreAuthentication1" value="1" type="radio" />
						<script>show_words('_enable')</script> &nbsp;
					</td>
				</tr>
				</table>
			</div>
		
			<!-- 802.1x -->
			<!-- WEP  -->
			<div id="8021x_wep1" class="box_tn" style="display:none;">
				<table width="100%" border="0" align="center" cellpadding="1" cellspacing="0" class="formarea">
				<tr><td colspan="3" class="CT"><script>show_words('_wifiser_mode17')</script></td></tr>
				<tr id="wpa_algorithms1" name="wpa_algorithms1" style="display:none"> 
					<td class="CL"><script>show_words('_WEP')</script></td>
					<td colspan="2" class="CELL">
						<input name="ieee8021x_wep1" id="ieee8021x_wep1" value="0" type="radio" />
						<script>show_words('_disable')</script> &nbsp;
						<input name="ieee8021x_wep1" id="ieee8021x_wep1" value="1" type="radio" />
						<script>show_words('_enable')</script> &nbsp;
					</td>
				</tr>
				</table>
			</div>
		
			<div id="radius_server1" class="box_tn" style="display:none;">
				<table width="100%" border="0" align="center" cellpadding="1" cellspacing="0" class="formarea">
				<tr><td colspan="3" class="CT"><script>show_words('_wifiser_mode18')</script></td></tr>
				<tr> 
					<td class="CL"><script>show_words('ES_IP_ADDR')</script></td>
					<td colspan="2" class="CELL">
						<input name="RadiusServerIP1" id="RadiusServerIP1" size="16" maxlength="32" value="" />
					</td>
				</tr>
				<tr> 
					<td class="CL"><script>show_words('sps_port')</script></td>
					<td colspan="2" class="CELL">
						<input name="RadiusServerPort1" id="RadiusServerPort1" size="5" maxlength="5" onkeyup="value=value.replace(/[^0-9]/g,'')" />
					</td>
				</tr>
				<tr> 
					<td class="CL"><script>show_words('_wifiser_mode19')</script></td>
					<td colspan="2" class="CELL">
						<input name="RadiusServerSecret1" id="RadiusServerSecret1" size="16" maxlength="64" value="" />
					</td>
				</tr>
				<tr style="display:none"> 
					<td class="CL"><script>show_words('_wifiser_mode20')</script></td>
					<td colspan="2" class="CELL">
						<input name="RadiusServerSessionTimeout1" id="RadiusServerSessionTimeout1" size="3" maxlength="4" value="0" />
					</td>
				</tr>
				<tr style="display:none"> 
					<td class="CL"><script>show_words('_wifiser_mode21')</script></td>
					<td colspan="2" class="CELL">
						<input name="RadiusServerIdleTimeout1" id="RadiusServerIdleTimeout1" size="3" maxlength="4" value="" readonly>
					</td>
				</tr>
				</table>
			</div>
		
			<div id="div_11n_plugfest1" class="box_tn" style="display:none">
				<div class="CT">Other</div>
				<table name="div_11n_plugfest1" cellspacing="0 "cellpadding="0" class="formarea">
					<!--
					<tr>
						<td class="CL" nowrap><script>show_words('_lb_forty_into');</script></td>
						<td class="CR"><font color="#003366" face=arial><b>
							<input type=radio name=f_40mhz1 value="0" /><script>show_words('_disable');</script>&&nbsp;
							<input type=radio name=f_40mhz1 value="1" /><script>show_words('_enable');</script>
						</b></font></td>
					</tr>
					<tr>
						<td class="CL"><script>show_words('_lb_wifi_opt');</script></td>
						<td class="CR">
							<input type=radio name=wifi_opt1 value="0" /><script>show_words('_disable');</script>&&nbsp;
							<input type=radio name=wifi_opt1 value="1" /><script>show_words('_enable');</script>
						</td>
					</tr>
					-->
					<tr>
						<td class="CL"><script>show_words('_lb_ht_txstream');</script></td>
						<td class="CR">
							<select id="tx_stream1" name="tx_stream1" size="1">
								<option value="1">1</option>
								<option value="2">2</option>
								<option value="3">3</option>
							</select>
						</td>
					</tr>
					<tr>
						<td class="CL"><script>show_words('_lb_ht_rxstream');</script></td>
						<td class="CR">
							<select id="rx_stream1" name="rx_stream1" size="1">
								<option value="1">1</option>
								<option value="2">2</option>
								<option value="3">3</option>
							</select>
						</td>
					</tr>
				</table>
			</div>
		
										<div id="buttonField1" class="box_tn">
											<table cellspacing="0 "cellpadding="0" class="formarea">
												<tr align="center">
												<td colspan="2" class="btn_field">
													<input type="button" class="button_submit" id="btn_apply1" value="Apply" onclick="return check_apply();" />
													<script>$('#btn_apply1').val(get_words('_apply'));</script>
													<input type="reset" class="button_submit" id="btn_cancel1" value="Cancel" onclick="window.location.reload()" />
													<script>$('#btn_cancel1').val(get_words('_cancel'));</script>
												</td>
												</tr>
											</table>
										</div>
									</div>

									<div id="radioOffField1" style="display:none;">
										<div class="box_tn">
											<div class="CT"><script>show_words('_wireless_5')</script></div>
											<table cellspacing="0" cellpadding="0" class="formarea">
											<tr>
												<td class="CL"><script>show_words('_lb_radio_onoff')</script></td>
												<td class="CR">
													<input type="button" id="radioButtonOn1" name="radioButtonOn1" style="{width:120px;}" value="" onclick="switchRadio1(1);" /> &nbsp; &nbsp;
													<script>$('#radioButtonOn1').val(get_words('_btn_radio_on'));</script>
													<input type="hidden" name="radiohiddenButton1" value="2" />
												</td>
											</tr>
											<tr>
												<td colspan="2" align="center" class="CELL"><font color="red" id="Msg" name="Msg"><script>show_words('_MSG_woff');</script></font></td>
											</tr>
											</table>
										</div>
									</div>
							</div>
		<!-- end of radioOnField1  -->
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
