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
	var submit_button_flag = 0;

	var menu = new menuObject();
	var obj = new ccpObject();

	var wpsCfg = {
		'enable':            ['<!--# echo wlan0_wps_enable -->', '<!--# echo wlan1_wps_enable -->']
	};

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

	var is_wps = (wpsCfg.enable[0] ? "1" : "0");        //wps enable or not
	var is_wps_5 = (wpsCfg.enable[1] ? "1" : "0");      //wps_5G enable or not	
	
function check_value(){
	if($('#gz_enable').attr('checked') && !(check_ssid_0("gz_ssid")))
		return false;
	if($('#gz_enable1').attr('checked') && !(check_ssid_0("gz_ssid1")))
		return false;
	return true;
}
function check_apply()
{
	obj.set_param_url('apply.cgi');
	obj.set_ccp_act('set');
	obj.add_param_event('gzone_concurrent');
	obj.set_param_next_page('basic_guest.asp');
	obj.add_param_arg('reboot_type', 'wireless');

	if(get_by_id("gz_enable").checked && (!(check_ssid("gz_ssid")))){
		return false;
	}
	if(get_by_id("gz_enable1").checked &&(!(check_ssid("gz_ssid1")))){
		return false;
	}

	/* security 2.4G MSSID1*/
	//check data
	if (checkData() == false)
		return false;
	
	//var idx = 2;
	var security_mode = $('#security_mode').val();
	
	if(security_mode == "Disable")
		obj.add_param_arg('wlan0_vap1_security','disable');
	else if(security_mode == "OPEN" || security_mode == "SHARED" ||security_mode == "WEPAUTO")//WEP_MODE
	{
		obj.add_param_arg('wlan0_vap1_wep_default_key',$('#wep_def_key').val());
		var security_wep_key_len = '';
		/* 
		** Date:	2012-03-29
		** Author:	Pascal Pai
		** Reason:	Saving each WEP key's key length
		**/	
		for(var i=1; i<=4; i++)
		{
			if ($('#WEP'+i+'Select').val() == 0)
				obj.add_param_arg('wlan0_vap1_wep_display_key_'+i, "hex");
			else
				obj.add_param_arg('wlan0_vap1_wep_display_key_'+i, "ascii");
			
			if($('#key'+i).val().length == 5 || $('#key'+i).val().length == 10)
			{
				security_wep_key_len = security_wep_key_len + '_64';
				obj.add_param_arg('wlan0_vap1_wep64_key_'+i,urlencode($('#key'+i).val()));
			}
			else
			{
				security_wep_key_len = security_wep_key_len + '_128';
				obj.add_param_arg('wlan0_vap1_wep128_key_'+i,urlencode($('#key'+i).val()));
			}
		}

		if(security_mode == "OPEN") {
			obj.add_param_arg('wlan0_vap1_security','wep_open' + security_wep_key_len);
			obj.add_param_arg('wlan0_vap1_security_wep','wep_open' + security_wep_key_len);
		} else if(security_mode == "SHARED") {
			obj.add_param_arg('wlan0_vap1_security','wep_share' + security_wep_key_len);
			obj.add_param_arg('wlan0_vap1_security_wep','wep_share' + security_wep_key_len);
  		} else if(security_mode == "WEPAUTO") {
			obj.add_param_arg('wlan0_vap1_security','wep_auto' + security_wep_key_len);	
			obj.add_param_arg('wlan0_vap1_security_wep','wep_auto' + security_wep_key_len);	
		}
	}
	else
	{
		if(security_mode == "WPAPSK" || security_mode == "WPA2PSK" || security_mode == "WPAPSKWPA2PSK") //WPA_P
		{
			if(security_mode == "WPAPSKWPA2PSK")
				obj.add_param_arg('wlan0_vap1_security',"wpa2auto_psk");
			else if(security_mode == "WPA2PSK")
				obj.add_param_arg('wlan0_vap1_security',"wpa2_psk");
			else if(security_mode == "WPAPSK")
				obj.add_param_arg('wlan0_vap1_security',"wpa_psk");
			
			//obj.add_param_arg('wpaInfo_AuthenticationMode_','1.'+idx+'.1.0',0);
			obj.add_param_arg('wlan0_vap1_psk_pass_phrase',$("#passphrase").val());
		}
		else if(security_mode == "WPA" || security_mode == "WPA2" || security_mode == "WPA1WPA2") //WPA_E
		{
			if(security_mode == "WPA1WPA2")
				obj.add_param_arg('wlan0_vap1_security',"wpa2auto_eap");
			else if(security_mode == "WPA2")
				obj.add_param_arg('wlan0_vap1_security',"wpa2_eap");
			else if(security_mode == "WPA")
				obj.add_param_arg('wlan0_vap1_security',"wpa_eap");
			
			//obj.add_param_arg('wpaInfo_AuthenticationMode_','1.'+idx+'.1.0',1);
			
			obj.add_param_arg('wlan0_vap1_eap_radius_server_0',$("#RadiusServerIP").val()+'/'+$("#RadiusServerPort").val()+'/'+$("#RadiusServerSecret").val());
			//obj.add_param_arg('wpaEap_RadiusServerPort_','1.'+idx+'.1.1',$("#RadiusServerPort").val());
			//obj.add_param_arg('wpaEap_RadiusServerPSK_','1.'+idx+'.1.1',$("#RadiusServerSecret").val());
			//obj.add_param_arg('wpaEap_PreAuthentication_','1.'+idx+'.1.1',get_radio_value(get_by_name("PreAuthentication")));
			obj.add_param_arg('wlan0_vap1_eap_reauth_period',$('#PMKCachePeriod').val());
			//obj.add_param_arg('wpaEap_RadiusSessionTime_','1.'+idx+'.1.1',$('#RadiusServerSessionTimeout').val());
		}

		obj.add_param_arg('wlan0_vap1_psk_cipher_type', send_cipher_value());
		obj.add_param_arg('wlan0_vap1_gkey_rekey_time',$("#keyRenewalInterval").val());
		obj.add_param_arg('wlan1_wps_enable', is_wps);
	}
	
	/* security 5G */
	//check data
	if (checkData1() == false)
		return false;
	
	//var idx = 3;
	var security_mode = $('#security_mode1').val();
	
	if(security_mode == "Disable")
		obj.add_param_arg('wlan1_vap1_security','disable');
	else if(security_mode == "OPEN" || security_mode == "SHARED" ||security_mode == "WEPAUTO")//WEP_MODE
	{
		obj.add_param_arg('wlan1_vap1_wep_default_key',$('#wep_def_key1').val());		
		var security_wep_key_len = '';
		/* 
		** Date:	2012-03-29
		** Author:	Pascal Pai
		** Reason:	Saving each WEP key's key length
		**/	
		for(var i=1; i<=4; i++)
		{
			if ($('#WEP'+i+'Select1').val() == 0)
				obj.add_param_arg('wlan1_vap1_wep_display_key_'+i, "hex");
			else
				obj.add_param_arg('wlan1_vap1_wep_display_key_'+i, "ascii");
			
			if($('#key'+(i+4)).val().length == 5 || $('#key'+(i+4)).val().length == 10)
			{
				security_wep_key_len = security_wep_key_len + '_64';
				obj.add_param_arg('wlan1_vap1_wep64_key_'+i,urlencode($('#key'+(i+4)).val()));
			}
			else
			{				
				security_wep_key_len = security_wep_key_len + '_128';					
				obj.add_param_arg('wlan1_vap1_wep128_key_'+i,urlencode($('#key'+(i+4)).val()));
			}
		}

		if(security_mode == "OPEN") {
			obj.add_param_arg('wlan1_vap1_security','wep_open' + security_wep_key_len);
			obj.add_param_arg('wlan1_vap1_security_wep','wep_open' + security_wep_key_len);
		} else if(security_mode == "SHARED") {
			obj.add_param_arg('wlan1_vap1_security','wep_share' + security_wep_key_len);
			obj.add_param_arg('wlan1_vap1_security_wep','wep_share' + security_wep_key_len);
                } else if(security_mode == "WEPAUTO") {
			obj.add_param_arg('wlan1_vap1_security','wep_auto' + security_wep_key_len);		
			obj.add_param_arg('wlan1_vap1_security_wep','wep_auto' + security_wep_key_len);		
		}
	}
	else
	{
		if(security_mode == "WPAPSK" || security_mode == "WPA2PSK" || security_mode == "WPAPSKWPA2PSK") //WPA_P
		{
			if(security_mode == "WPAPSKWPA2PSK")
				obj.add_param_arg('wlan1_vap1_security',"wpa2auto_psk");
			else if(security_mode == "WPA2PSK")
				obj.add_param_arg('wlan1_vap1_security',"wpa2_psk");
			else if(security_mode == "WPAPSK")
				obj.add_param_arg('wlan1_vap1_security',"wpa_psk");
			
			//obj.add_param_arg('wpaInfo_AuthenticationMode_','1.'+idx+'.1.0',0);
			obj.add_param_arg('wlan1_vap1_psk_pass_phrase',$("#passphrase1").val());
		}
		else if(security_mode == "WPA" || security_mode == "WPA2" || security_mode == "WPA1WPA2") //WPA_E
		{
			if(security_mode == "WPA1WPA2")
				obj.add_param_arg('wlan1_vap1_security',"wpa2auto_eap");
			else if(security_mode == "WPA2")
				obj.add_param_arg('wlan1_vap1_security',"wpa2_eap");
			else if(security_mode == "WPA")
				obj.add_param_arg('wlan1_vap1_security',"wpa_eap");

			//obj.add_param_arg('wpaInfo_AuthenticationMode_','1.'+idx+'.1.0',1);
			obj.add_param_arg('wlan1_vap1_eap_radius_server_0',$("#RadiusServerIP1").val()+'/'+$("#RadiusServerPort1").val()+'/'+$("#RadiusServerSecret1").val());
			//obj.add_param_arg('wpaEap_RadiusServerIP_','1.'+idx+'.1.1',$("#RadiusServerIP1").val());
			//obj.add_param_arg('wpaEap_RadiusServerPort_','1.'+idx+'.1.1',$("#RadiusServerPort1").val());
			//obj.add_param_arg('wpaEap_RadiusServerPSK_','1.'+idx+'.1.1',$("#RadiusServerSecret1").val());
			//obj.add_param_arg('wpaEap_PreAuthentication_','1.'+idx+'.1.1',get_radio_value(get_by_name("PreAuthentication1")));
			obj.add_param_arg('wlan1_vap1_eap_reauth_period',$('#PMKCachePeriod1').val());
			//obj.add_param_arg('wpaEap_RadiusSessionTime_','1.'+idx+'.1.1',$('#RadiusServerSessionTimeout1').val());
			
		}
		obj.add_param_arg('wlan1_vap1_psk_cipher_type', send_cipher_value_1());
		obj.add_param_arg('wlan1_vap1_gkey_rekey_time',$("#keyRenewalInterval1").val());
		obj.add_param_arg('wlan1_wps_enable', is_wps_5);
	}
		
	<!--save wireless network setting-2.4G-->
	get_by_id("wlan0_vap1_enable").value = get_checked_value(get_by_id("gz_enable"));
	obj.add_param_arg('wlan0_vap1_enable',($('#gz_enable').attr('checked')?1:0));
	obj.add_param_arg('wlan0_vap1_ssid',urlencode($('#gz_ssid').val()));
	obj.add_param_arg('wlan0_vap1_partition',($('#gz_wlan_partition').attr('checked')?1:0));	
	obj.add_param_arg('wlan0_vap1_gzone_enable',($('#gz_inet_access_only').attr('checked')?1:0));	
			
	<!--save wireless network setting-5G-->
	get_by_id("wlan1_vap1_enable").value = get_checked_value(get_by_id("gz_enable1"));
	obj.add_param_arg('wlan1_vap1_enable',($('#gz_enable1').attr('checked')?1:0));
	obj.add_param_arg('wlan1_vap1_ssid',urlencode($('#gz_ssid1').val()));
	obj.add_param_arg('wlan1_vap1_partition',($('#gz_wlan_partition1').attr('checked')?1:0));
	obj.add_param_arg('wlan1_vap1_gzone_enable',($('#gz_inet_access_only1').attr('checked')?1:0));		
	
		<!--save Wi-Fi value-->		
		//if(get_by_id("wps_enable").value != get_checked_value(get_by_id("wpsEnable"))){
		//get_by_id("wps_enable").value = get_checked_value(get_by_id("wpsEnable"));
			//get_by_id("reboot_type").value = "wlanapp";
		//}
		//save wps_configured_mode
		//if (get_by_id("wps_configured_mode").value == "1" && is_form_modified("form1") && !is_wps_modified()){
		//	get_by_id("wps_configured_mode").value = 5;
		//}
		
		//get_by_id("wps_configured_mode").value = 5;	//save wps_configured_mode when setting wireless
/*		if (get_by_id("dhcpsvr").checked){
			var start_ip = get_by_id("gzone_dhcpd_start").value;
			var end_ip = get_by_id("gzone_dhcpd_end").value;
			var start_ip_addr_msg = replace_msg(all_ip_addr_msg,"Start IP Address");
			var end_ip_addr_msg = replace_msg(all_ip_addr_msg,"End IP Address");
			var start_obj = new addr_obj(start_ip.split("."), start_ip_addr_msg, false, false);
			var end_obj = new addr_obj(end_ip.split("."), end_ip_addr_msg, false, false);
			var dhcp_les = get_by_id("gzone_dhcpd_lease_time").value;		
			var less_msg = replace_msg(check_num_msg, bd_DLT, 1, 999999);
			var temp_less = new varible_obj(dhcp_les, less_msg, 1, 999999, false);
			var guest_ip = ip;

			if(guest_ip == lanip){
				alert(LW1);
				return false;
			}

			if (!check_domain(temp_ip_obj, temp_mask_obj, start_obj)){
				alert(TEXT037);
				return false;
			}

			if (!check_domain(temp_ip_obj, temp_mask_obj, end_obj)){
				alert(TEXT038);
				return false;
			}

			if(!check_LAN_ip(temp_ip_obj.addr, start_obj.addr, TEXT035))
				return false;
			
			if(!check_LAN_ip(temp_ip_obj.addr, end_obj.addr, TEXT036))
				return false;

			if (!check_address(start_obj, temp_mask_obj, temp_ip_obj) || !check_address(end_obj, temp_mask_obj, temp_ip_obj))
				return false;

			if (!check_ip_order(start_obj, end_obj)){
				alert(TEXT039);
				return false;
			}

			if (check_lanip_order(temp_ip_obj,start_obj, end_obj)){
				alert(network_dhcp_ip_in_server);
				return false;
			}

			if (!check_varible(temp_less))
				return false;
		
			get_by_id("gzone_dhcpd_enable").value = 1;
		}else{
			get_by_id("gzone_dhcpd_enable").value = 0;
		}
*/

		obj.add_param_arg('wlan0_vap1_schedule',$('#gz_schedule :selected').val());
		obj.add_param_arg('wlan1_vap1_schedule',$('#gz_schedule1 :selected').val());

		if (!isWepConflict())
			return false;		

		
		var paramForm = obj.get_param();
		totalWaitTime = 20; //second
		redirectURL = location.pathname;
		wait_page();
		jq_ajax_post(paramForm.url, paramForm.arg);
		
/*		if(submit_button_flag == 0){
			submit_button_flag = 1;
			get_by_id("wlan0_vap1_ssid").value = get_by_id("gz_ssid").value;
			get_by_id("wlan1_vap1_ssid").value = get_by_id("gz_ssid1").value;
			return true;
		}else{
			return false;
		}
*/		
}
	
function check_host_zone()
	{
		if (get_by_id("wlan0_vap0_enable").value == "0" && 
		    get_by_id("gz_enable").checked) {
			alert(get_words('TEXT028'));
			get_by_id("gz_enable").checked = false;
			return false;
		}
	}

	function check_host_zone1()
	{
		if (get_by_id("wlan1_vap0_enable").value == "0" && 
		    get_by_id("gz_enable1").checked) {
			alert(get_words('TEXT028'));
			get_by_id("gz_enable1").checked = false;
			return false;
		}
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
  
	function send_cipher_value(){
		var tmp_cipher = get_radio_value(get_by_name("cipher"));
		if(tmp_cipher == 0){	//tkip
			return "tkip";
		}else if(tmp_cipher == 1){	//aes
			return "aes";
		}else{	//tkip and aes
			return "both";
		}
	}
	function send_cipher_value_1(){
		var tmp_cipher = get_radio_value(get_by_name("cipher1"));
		if(tmp_cipher == 0){	//tkip
			return "tkip";
		}else if(tmp_cipher == 1){	//aes
			return "aes";
		}else{	//tkip and aes
			return "both";
		}
	}
  
/*
function check_gz_inet_access_only()
	{
		if (get_by_id("wlan0_vap0_enable").value == "0" && 
		    get_by_id("gz_enable").checked) {
			alert(get_words('TEXT028'));
			get_by_id("gz_enable").checked = false;
			return false;
		}
	}
	
*/

function setValueGuestZoneEnable()
{
	var chk_part = get_by_id("wlan0_vap1_enable").value;
	//$('#gz_enable').attr('checked', chk_part=='on');
	$('#gz_enable').attr('checked', (chk_part=='1'?true:false));
}
function setEventGuestZoneEnable()
{
	var func = function(){
		var gz_enable = $('#gz_enable').attr('checked');
		if(gz_enable)
		{
			$('#gz_schedule, #sche_btn').removeAttr('disabled');
		}
		else
		{
			$('#gz_schedule, #sche_btn').attr('disabled','disabled');
		}
	};
	func();
	$('#gz_enable').change(func);
}
function setValueWirelessNameSSID()
{
  get_by_id("gz_ssid").value = ssid_decode("wlan0_vap1_ssid");;
}
function setValueRadioOnSchedule()
{
	var val_sche = '<!--# echo wlan0_vap1_schedule -->';
	$('#gz_schedule').val(val_sche);
}
function setValueWlanPartition()
{
	var chk_part = get_by_id("wlan0_vap1_partition").value;
	$('#gz_wlan_partition').attr('checked', (chk_part=='1'?true:false));
}
function setValueInternetAccessOnly() {
	var chk_part = get_by_id("wlan0_vap1_guest_zone").value;
	$('#gz_inet_access_only').attr('checked', (chk_part=='1'?true:false));
}


function setValueGuestZoneEnable5G()
{
	var chk_part = get_by_id("wlan1_vap1_enable").value;
	//$('#gz_enable1').attr('checked', chk_part=='on');
	$('#gz_enable1').attr('checked', (chk_part=='1'?true:false));
}
function setEventGuestZoneEnable5G()
{
	var func = function(){
		var gz_enable = $('#gz_enable1').attr('checked');
		if(gz_enable)
		{
			$('#gz_schedule1, #sche_btn1').removeAttr('disabled');
		}
		else
		{
			$('#gz_schedule1, #sche_btn1').attr('disabled','disabled');
		}
	};
	func();
	$('#gz_enable1').change(func);
}
function setValueWirelessNameSSID5G()
{
  get_by_id("gz_ssid1").value = ssid_decode("wlan1_vap1_ssid");;
}
function setValueRadioOnSchedule5G()
{
	var val_sche = '<!--# echo wlan1_vap1_schedule -->';
	$('#gz_schedule1').val(val_sche);
}
function setValueWlanPartition5G()
{
	var chk_part = get_by_id("wlan1_vap1_partition").value;
	$('#gz_wlan_partition1').attr('checked', (chk_part=='1'?true:false));
}
function setValueInternetAccessOnly5G() {
	var chk_part = get_by_id("wlan1_vap1_guest_zone").value;
	$('#gz_inet_access_only1').attr('checked', (chk_part=='1'?true:false));
}

function setValueWirelessPskPassPhrase(){
	var tmp_wlan0_vap1_psk_pass_phras = ssid_decode("wlan0_vap1_psk_pass_phrase");
	var tmp_wlan1_vap1_psk_pass_phras = ssid_decode("wlan1_vap1_psk_pass_phrase");
	$('#passphrase').val(tmp_wlan0_vap1_psk_pass_phras);
	$('#passphrase1').val(tmp_wlan1_vap1_psk_pass_phras);
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
	var val = "<!--# echo wlan0_vap1_security_wep -->";
	val = val.split("_");
	var infoAuthMode = val[1];
	var infokey = '<!--# echo wlan0_vap1_wep_default_key -->';
	var key128 =  [$(wlan0_vap1_wep128_key_1).text(), $(wlan0_vap1_wep128_key_2).text(),
	               $(wlan0_vap1_wep128_key_3).text(), $(wlan0_vap1_wep128_key_4).text()
		            ];
	var key64 =   [$(wlan0_vap1_wep64_key_1).text(), $(wlan0_vap1_wep64_key_2).text(),
                 $(wlan0_vap1_wep64_key_3).text(), $(wlan0_vap1_wep64_key_4).text()
	              ];
	var keyType = ["<!--# echo wlan0_vap1_wep_display_key_1 -->", "<!--# echo wlan0_vap1_wep_display_key_2 -->",
		             "<!--# echo wlan0_vap1_wep_display_key_3 -->", "<!--# echo wlan0_vap1_wep_display_key_4 -->"
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
	var val = "<!--# echo wlan1_vap1_security_wep -->";
	val = val.split("_");
	var infoAuthMode = val[1];
	var infokey = '<!--# echo wlan1_vap1_wep_default_key -->';
	var key128 =  [$(wlan1_vap1_wep128_key_1).text(), $(wlan1_vap1_wep128_key_2).text(),
	               $(wlan1_vap1_wep128_key_3).text(), $(wlan1_vap1_wep128_key_4).text()
	              ];
	var key64 =   [$(wlan1_vap1_wep64_key_1).text(), $(wlan1_vap1_wep64_key_2).text(),
	               $(wlan1_vap1_wep64_key_3).text(), $(wlan1_vap1_wep64_key_4).text()
                ];
	var keyType = ["<!--# echo wlan1_vap1_wep_display_key_1 -->", "<!--# echo wlan1_vap1_wep_display_key_2 -->",
	               "<!--# echo wlan1_vap1_wep_display_key_3 -->", "<!--# echo wlan1_vap1_wep_display_key_4 -->"
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
		var tmp_wlan0_psk_pass_phrase = ssid_decode("wlan0_vap1_psk_pass_phrase");
		var tmp_wlan0_gkey_rekey_time= "<!--# echo wlan0_vap1_gkey_rekey_time -->";
		var wlan0_eap_reauth_period = "<!--# echo wlan0_vap1_eap_reauth_period -->";
		var tmp_wlan0_psk_cipher_type = "<!--# echo wlan0_vap1_psk_cipher_type -->";
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
		
		var temp_r0 = get_by_id("wlan0_vap1_eap_radius_server_0").value;
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
		var tmp_wlan1_psk_pass_phrase = ssid_decode("wlan1_vap1_psk_pass_phrase");
		var tmp_wlan1_gkey_rekey_time= "<!--# echo wlan1_vap1_gkey_rekey_time -->";
		var wlan1_eap_reauth_period = "<!--# echo wlan1_vap1_eap_reauth_period -->";
		var tmp_wlan1_psk_cipher_type = "<!--# echo wlan1_vap1_psk_cipher_type -->";
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
		
		var temp_r00 = get_by_id("wlan1_vap1_eap_radius_server_0").value;
		var Dr00 = temp_r00.split("/");
		
		if(Dr00.length > 1){
			$('#RadiusServerIP1').val(Dr00[0]);
			$('#RadiusServerPort1').val(Dr00[1]);
			$('#RadiusServerSecret1').val(Dr00[2]);
			//$('#RadiusServerSessionTimeout1').val(EapCfg.SessionT[index*2]);
		}
}

function LoadFields(index)
{
	var sec = "<!--# echo wlan0_vap1_security -->";
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
	var sec = "<!--# echo wlan1_vap1_security -->";
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
	var dot11_mode_value = "<!--# echo wlan0_dot11_mode -->";
	var wpa_cipher = $('input[name=cipher]:checked').val();
	var securitymode = $('#security_mode').val();
	var checkValue, flag=0;
	if (securitymode == "OPEN" || securitymode == "SHARED" ||securitymode == "WEPAUTO")//WEP_MODE
	{
		if(!check_Wep(securitymode) )
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
			alert(get_words('TEXT024_1'));
			return false;
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
			if (wpa_cipher == 0 && securitymode == "WPAPSK") {
				alert(get_words('TEXT025'));
				return false;
			}
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
			alert(get_words('TEXT026'));
			return false;
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
			alert(get_words('TEXT026'));
			return false;
		}
		if(chk_radius() == false)
			return false;
	}
	
	return true;	
}
function checkData1()
{
	var dot11_mode_value = "<!--# echo wlan0_dot11_mode -->";
	var wpa_cipher = $('input[name=cipher1]:checked').val();
	var securitymode = $('#security_mode1').val();
	var checkValue, flag=0;
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
			alert(get_words('TEXT024_1'));
			return false;
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
			if (wpa_cipher == 0 && securitymode == "WPAPSK") {
				alert(get_words('TEXT025'));
				return false;
			}
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
			alert(get_words('TEXT026'));
			return false;
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
			alert(get_words('TEXT026'));
			return false;
		}
		if(chk_radius1() == false)
			return false;
	}
	
	return true;
}

function check_Wep(securitymode)
{
	var defaultid = $('#wep_def_key').val();

	if (defaultid == 1)
		var keyvalue = $('#key1').val();
	else if (defaultid == 2)
		var keyvalue = $('#key2').val();
	else if (defaultid == 3)
		var keyvalue = $('#key3').val();
	else if (defaultid == 4)
		var keyvalue = $('#key4').val();

	if (keyvalue.length == 0 &&  (securitymode == "1")){ // shared wep  || md5
		alert(get_words('_wifiser_mode32')+" "+defaultid+' !');
		return false;
	}
	
	for(var i=1; i<=4; i++)
	{
		var keylength = $('#key'+i).val().length;
		var key = $('#key'+i).val();
		if(keylength != 0)
		{
			// ASCII
			if ($('#WEP'+i+'Select').val() == 1)
			{
				if (keylength != 5 && keylength != 13) {
					alert(get_words('_wifiser_mode31')+" "+ i);
					return false;
				}
				for (var j = 0; j < keylength; j++) {
					if (!is_ascii(key.substring(j, j+1))) {
						alert(get_words('TEXT042_1')+" " + i + " "+get_words('TEXT041_2') + " " + get_words('_ascii'));
						return false;
					}
				}
			}
			
			// HEX
			if ($('#WEP'+i+'Select').val() == 0)
			{
				if (keylength != 10 && keylength != 26) {
					alert(get_words('_wifiser_mode30')+" "+ i);
					return false;
				}
				for (var j = 0; j < keylength; j++) {
					if (!check_hex(key.substring(j, j+1))) {
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

	if (defaultid == 1)
		var keyvalue = $('#key5').val();
	else if (defaultid == 2)
		var keyvalue = $('#key6').val();
	else if (defaultid == 3)
		var keyvalue = $('#key7').val();
	else if (defaultid == 4)
		var keyvalue = $('#key8').val();

	if (keyvalue.length == 0 &&  (securitymode == "1")){ // shared wep  || md5
		alert(get_words('_wifiser_mode32')+" "+defaultid+' !');
		return false;
	}
	for(var i=1; i<5; i++)
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
				for (var j = 0; j < keylength; j++) {
					if (!is_ascii(key.substring(j, j+1))) {
						alert(get_words('TEXT042_1')+" " + i + " "+get_words('TEXT041_2') + " " + get_words('_ascii'));
						return false;
					}
				}
			}
			
			//HEX
			if ($('#WEP'+i+'Select1').val() == 0)
			{
				if (keylength != 10 && keylength != 26) {
					alert(get_words('_wifiser_mode30')+" "+ i);
					return false;
				}
				for (var j = 0; j < keylength; j++){
					if (!check_hex(key.substring(j, j+1))) {
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
// security end

$(function(){
	if(get_by_id("wlan0_vap0_enable").value==1)
		$('#radioOnField').show();
	else
		$('#radioOffField').show();
	
	//Guest Network
	setValueGuestZoneEnable();
	setEventGuestZoneEnable();
	setValueWirelessNameSSID();
	setValueRadioOnSchedule();
	setValueWlanPartition();
	setValueInternetAccessOnly();
	setValueWirelessPskPassPhrase();
	//Security
	setValueSecurModeList();
	MBSSIDChange(3);
	
	if(get_by_id("wlan1_vap0_enable").value==1)
		$('#radioOnField1').show();
	else
		$('#radioOffField1').show();
	
	setValueGuestZoneEnable5G();
	setEventGuestZoneEnable5G();
	setValueWirelessNameSSID5G();
	setValueRadioOnSchedule5G();
	setValueWlanPartition5G();
	setValueInternetAccessOnly5G();
	
	//Security
	setValueSecurModeList1();
	MBSSIDChange1(7);
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
				<script>document.write(menu.build_structure(0,2,-1));</script>
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
								<div class="headerbg" id="manStatusTitle">
								<script>show_words('_guest_network');</script>
								</div>
								<div class="hr"></div>
								<div class="section_content_border">
									<div class="header_desc" id="basicIntroduction">
										<script>show_words('_guest_text1')</script>
										<p></p>
									</div>
	
	
								<form id="form1" name="form1" method="post" action="apply.cgi">
									<input type="hidden" id="wlan0_vap1_ssid" name="wlan0_vap1_ssid" value="<!--# echot wlan0_vap1_ssid -->">
									<input type="hidden" id="wlan1_vap1_ssid" name="wlan1_vap1_ssid" value="<!--# echot wlan1_vap1_ssid -->">
									<input type="hidden" id="wlan0_vap1_wep_display" name="wlan0_vap1_wep_display" value="<!--# echo wlan0_vap1_wep_display -->">
									<input type="hidden" id="wlan1_vap1_wep_display" name="wlan1_vap1_wep_display" value="<!--# echo wlan1_vap1_wep_display -->">
									<input type="hidden" id="wlan0_vap1_schedule" name="wlan0_vap1_schedule" value="<!--# echo wlan0_vap1_schedule -->">
									<input type="hidden" id="wlan1_vap1_schedule" name="wlan1_vap1_schedule" value="<!--# echo wlan1_vap1_schedule -->">

									<input type="hidden" id="wlan0_vap0_enable" name="wlan0_vap0_enable" value="<!--# echo wlan0_vap0_enable -->">
									<input type="hidden" id="wlan1_vap0_enable" name="wlan1_vap0_enable" value="<!--# echo wlan1_vap0_enable -->">

									<span id="wlan0_vap1_wep64_key_1" style="display:none;"><!--# echot wlan0_vap1_wep64_key_1 --></span>
									<span id="wlan0_vap1_wep128_key_1" style="display:none;"><!--# echot wlan0_vap1_wep128_key_1 --></span>
									<span id="wlan0_vap1_wep64_key_2" style="display:none;"><!--# echot wlan0_vap1_wep64_key_2 --></span>
									<span id="wlan0_vap1_wep128_key_2" style="display:none;"><!--# echot wlan0_vap1_wep128_key_2 --></span>
									<span id="wlan0_vap1_wep64_key_3" style="display:none;"><!--# echot wlan0_vap1_wep64_key_3 --></span>
									<span id="wlan0_vap1_wep128_key_3" style="display:none;"><!--# echot wlan0_vap1_wep128_key_3 --></span>
									<span id="wlan0_vap1_wep64_key_4" style="display:none;"><!--# echot wlan0_vap1_wep64_key_4 --></span>
									<span id="wlan0_vap1_wep128_key_4" style="display:none;"><!--# echot wlan0_vap1_wep128_key_4 --></span>
									<span id="wlan1_vap1_wep64_key_1" style="display:none;"><!--# echot wlan1_vap1_wep64_key_1 --></span>
									<span id="wlan1_vap1_wep128_key_1" style="display:none;"><!--# echot wlan1_vap1_wep128_key_1 --></span>
									<span id="wlan1_vap1_wep64_key_2" style="display:none;"><!--# echot wlan1_vap1_wep64_key_2 --></span>
									<span id="wlan1_vap1_wep128_key_2" style="display:none;"><!--# echot wlan1_vap1_wep128_key_2 --></span>
									<span id="wlan1_vap1_wep64_key_3" style="display:none;"><!--# echot wlan1_vap1_wep64_key_3 --></span>
									<span id="wlan1_vap1_wep128_key_3" style="display:none;"><!--# echot wlan1_vap1_wep128_key_3 --></span>
									<span id="wlan1_vap1_wep64_key_4" style="display:none;"><!--# echot wlan1_vap1_wep64_key_4 --></span>
									<span id="wlan1_vap1_wep128_key_4" style="display:none;"><!--# echot wlan1_vap1_wep128_key_4 --></span>

									<input type="hidden" id="wlan0_vap1_partition" name="wlan0_vap1_partition" value="<!--# echo wlan0_vap1_partition -->">            
									<input type="hidden" id="wlan1_vap1_partition" name="wlan1_vap1_partition" value="<!--# echo wlan1_vap1_partition -->">						
									
									<input type="hidden" id="wlan0_vap1_enable" name="wlan0_vap1_enable" value="<!--# echo wlan0_vap1_enable -->">
									<input type="hidden" id="wlan0_vap1_security" name="wlan0_vap1_security" value="<!--# echo wlan0_vap1_security -->">
									<input type="hidden" id="wlan0_vap1_psk_cipher_type" name="wlan0_vap1_psk_cipher_type" value="<!--# echo wlan0_vap1_psk_cipher_type -->">
									<input type="hidden" id="wlan0_vap1_eap_radius_server_0" name="wlan0_vap1_eap_radius_server_0" value="<!--# echo wlan0_vap1_eap_radius_server_0 -->">
									<input type="hidden" id="wlan0_vap1_eap_mac_auth" name="wlan0_vap1_eap_mac_auth" value="<!--# echo wlan0_vap1_eap_mac_auth -->">
									<input type="hidden" id="wlan0_vap1_eap_radius_server_1" name="wlan0_vap1_eap_radius_server_1" value="<!--# echo wlan0_vap1_eap_radius_server_1 -->">
				          <input type="hidden" id="wlan1_vap1_security" name="wlan1_vap1_security" value="<!--# echo wlan1_vap1_security -->">
				          <input type="hidden" id="wlan1_vap1_enable" name="wlan1_vap1_enable" value="<!--# echo wlan1_vap1_enable -->">
									<input type="hidden" id="wlan1_vap1_psk_cipher_type" name="wlan1_vap1_psk_cipher_type" value="<!--# echo wlan1_vap1_psk_cipher_type -->">
									<input type="hidden" id="wlan1_vap1_eap_radius_server_0" name="wlan1_vap1_eap_radius_server_0" value="<!--# echo wlan1_vap1_eap_radius_server_0 -->">
									<input type="hidden" id="wlan1_vap1_eap_mac_auth" name="wlan1_vap1_eap_mac_auth" value="<!--# echo wlan1_vap1_eap_mac_auth -->">
									<input type="hidden" id="wlan1_vap1_eap_radius_server_1" name="wlan1_vap1_eap_radius_server_1" value="<!--# echo wlan1_vap1_eap_radius_server_1 -->">
									<input type="hidden" id="wlan0_vap0_wep_default_key" name="wlan0_vap0_wep_default_key" value="<!--# echo wlan0_vap0_wep_default_key_1 -->"> 
									<input type="hidden" id="wlan1_vap0_wep_default_key" name="wlan1_vap0_wep_default_key" value="<!--# echo wlan1_vap0_wep_default_key_1 -->"> 
	                <input type="hidden" id="wlan0_vap1_guest_zone" name="wlan0_vap1_guest_zone" value="<!--# echo wlan0_vap1_gzone_enable -->">
	                <input type="hidden" id="wlan1_vap1_guest_zone" name="wlan1_vap1_guest_zone" value="<!--# echo wlan1_vap1_gzone_enable -->">
									<input type="hidden" id="wlan0_vap1_gkey_rekey_time" name="wlan0_vap1_gkey_rekey_time" value="<!--# echo wlan0_vap1_gkey_rekey_time -->"> 
	                <input type="hidden" id="wlan0_vap1_eap_reauth_period" name="wlan0_vap1_eap_reauth_period" value="<!--# echo wlan0_vap1_eap_reauth_period -->">
									<input type="hidden" id="wlan1_vap1_gkey_rekey_time" name="wlan1_vap1_gkey_rekey_time" value="<!--# echo wlan1_vap1_gkey_rekey_time -->"> 
	                <input type="hidden" id="wlan1_vap1_eap_reauth_period" name="wlan1_vap1_eap_reauth_period" value="<!--# echo wlan1_vap1_eap_reauth_period -->">
				<input type="hidden" id="wlan0_vap1_psk_pass_phrase" name="wlan0_vap1_psk_pass_phrase" value="<!--# echot wlan0_vap1_psk_pass_phrase -->">
			       <input type="hidden" id="wlan1_vap1_psk_pass_phrase" name="wlan1_vap1_psk_pass_phrase" value="<!--# echot wlan1_vap1_psk_pass_phrase -->">
	                
									<div id="radioOnField" style="display: none;">
									<div class="box_tn">
										<div class="CT"><script>show_words('_guest_network')</script> - <script>show_words('KR16');</script></div>
										<table cellspacing="0" cellpadding="0" class="formarea">
											<tr>
												<td class="CL"><script>show_words('_lb_radio_onoff')</script></td>
												<td class="CR">
													<input type="checkbox" id="gz_enable" onclick="check_host_zone()" /> &nbsp;
													<span id="scheduleField">
														<select id="gz_schedule" name="gz_schedule">
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
												<td class="CL"><script>show_words('_wmode_ssid');</script></td>
												<td class="CR">
													<input type="text" id="gz_ssid" size="32" maxlength="32"/>
												</td>
											</tr>
											<tr id="gz_networkbridge" style="display:none;">
												<td class="CL"><script>show_words('_network_bridge');</script></td>
												<td class="CR">
													<select id="gz_network_bridge" size="1" disabled>
														<option value="0"><script>show_words('_LAN');</script></option>
														<option value="1"><script>show_words('_guest');</script></option>
													</select>
												</td>
											</tr>
											<tr>
												<td class="CL"><script>show_words('_inet_access_only');</script></td>
												<td class="CR">
													<input type="checkbox" id="gz_inet_access_only" /> &nbsp;
													(<script>show_words('_inet_access_only_txt');</script>)
												</td>
											</tr>
											<tr>
												<td class="CL"><script>show_words('guest_isolation');</script></td>
												<td class="CR">
													<!--input type="radio" name="gz_wlan_partition" value="0" /><script>show_words('_disable');</script> &nbsp;
													<input type="radio" name="gz_wlan_partition" value="1" /><script>show_words('_enable');</script-->
													<input type="checkbox" id="gz_wlan_partition" /> &nbsp;
													<script>show_words('guest_isolation_txt');</script>
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
													<input name="keyRenewalInterval" id="keyRenewalInterval" size="4" maxlength="4" value="3600" />
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
													<input name="RadiusServerPort" id="RadiusServerPort" size="5" maxlength="5" value="" />
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

									<div id="radioOffField" class="box_tn" style="display: none;">
										<table cellspacing="0" cellpadding="0" class="formarea">
											<tr>
												<td colspan="2" align="center" class="CELL"><font color="red" id="Msg" name="Msg"><script>show_words('_MSG_woff');</script></font></td>
											</tr>
										</table>
									</div>

									<div id="radioOnField1" style="display:none;">
									<div class="box_tn">
										<div class="CT"><script>show_words('_guest_network')</script> - <script>show_words('KR17');</script></div>
										<table cellspacing="0" cellpadding="0" class="formarea">
											<tr>
												<td class="CL"><script>show_words('_lb_radio_onoff')</script></td>
												<td class="CR">
													<input type="checkbox" id="gz_enable1" onclick="check_host_zone1()"/> &nbsp;
													<span id="scheduleField1">
														<select id="gz_schedule1" name="gz_schedule1">
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
												<td class="CL"><script>show_words('_wmode_ssid');</script></td>
												<td class="CR">
													<input type="text" id="gz_ssid1" size="32" maxlength="32"/>
												</td>
											</tr>
											<tr id="gz_networkbridge1" style="display:none;">
												<td class="CL"><script>show_words('_network_bridge');</script></td>
												<td class="CR">
													<select id="gz_network_bridge1" size="1" disabled>
														<option value="0"><script>show_words('_LAN');</script></option>
														<option value="1"><script>show_words('_guest');</script></option>
													</select>
												</td>
											</tr>
											<tr>
												<td class="CL"><script>show_words('_inet_access_only');</script></td>
												<td class="CR">
													<input type="checkbox" id="gz_inet_access_only1" /> &nbsp;
													(<script>show_words('_inet_access_only_txt');</script>)
												</td>
											</tr>
											<tr>
												<td class="CL"><script>show_words('guest_isolation');</script></td>
												<td class="CR">
													<input type="checkbox" id="gz_wlan_partition1" /> &nbsp;
													(<script>show_words('guest_isolation_txt');</script>)
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
													<input name="keyRenewalInterval1" id="keyRenewalInterval1" size="4" maxlength="4" value="3600" />
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
													<input name="RadiusServerPort1" id="RadiusServerPort1" size="5" maxlength="5" value="" />
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

									<div id="radioOffField1" class="box_tn" style="display: none;">
										<table cellspacing="0" cellpadding="0" class="formarea">
											<tr>
												<td colspan="2" align="center" class="CELL"><font color="red" id="Msg" name="Msg"><script>show_words('_MSG_woff');</script></font></td>
											</tr>
										</table>
									</div>
								</form>
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
