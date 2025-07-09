<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html lang="en-US" xmlns="http://www.w3.org/1999/xhtml" xml:lang="en-US">
<head>
<script>
var mywinopen = window.open;
</script>
<title>TRENDNET | modelName | Wireless 5GHz | Advanced</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<link href="/css/style.css" rel="stylesheet" type="text/css" />
<link href="/css/css_router.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="/uk_<!--# echo language -->.js"></script>
<script type="text/javascript" src="public_tew.js"></script>
<script type="text/javascript" src="public_msg.js"></script>
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
	var obj = new ccpObject();
	
	var lanCfg = {
		'enable':        ['<!--# echo wlan1_vap0_enable -->'],   //gz_enable
		'channel':       ['<!--# echo wlan1_channel -->'],
		'exchannel':     [1],
		'coexi':         ['<!--# echo wlan1_disablecoext -->'],
		'chanwidth':     ['<!--# echo wlan1_channel_bandwith -->'],
		'standard5G':    ['<!--# echo wlan1_dot11_mode -->']
	}

	var advCfg = {
		'bgprotection':  '1',
		'beaconperiod':  ['<!--# echo wlan1_beacon_interval -->'],
		'dtim':          ['<!--# echo wlan1_dtim -->'],
		'fragthres':     ['<!--# echo wlan1_fragmentation -->'],
		'rtsthres':      ['<!--# echo wlan1_rts_threshold -->'],
		'txpower':       ['<!--# echo wlan1_txpower -->'],
		'spreamble':     ['<!--# echo wlan1_short_preamble -->'],
		'txburst':       ['<!--# echo wlan1_burst_enable -->'],
		'pktaggregate':  [1],
		'ieee11h':       [1]
	}
	
	var qosCfg = {
		'wmmenable':     ['<!--# echo wlan1_wmm_enable -->'],
		'apsd':          [1],
		'dls':           [1]
	}
	var mediaCfg = {
		'turbine':       [1]
	}
	var m2uCfg = {
		'm2u':           ['<!--# echo wlan1_multicast_stream_enable -->']
	}

	var wpsCfg = {
		'enable':        ['<!--# echo wps_enable -->'],
	}

	var htCfg = {
		'operating':     [1],
		'shortgi':       ['<!--# echo wlan1_short_gi -->'],
		'rdg':           [1],
		'amsdu':         [1],
		'autoba':        [1],
		'declineba':     [1],
		'ampdu':         ['<!--# echo wlan1_enable_ampdu -->']
	}

	function open_wmm_window()
	{
		mywinopen("wireless_wmm.asp","WMM_Parameters_List","toolbar=no, location=yes, scrollbars=yes, resizable=no, width=640, height=480");
	}

	function check_value()
	{
		/*
		** Date:	2013-03-18
		** Author:	Moa Chung
		** Reason:	Wireless 5G ??advanced：Do not check the value of Beacon interval, DTIM, Fragment threshold and RTS threshold.
		** Note:	TEW-810DR pre-test no.73
		**/
		if(!check_integer($('#beacon').val(), 100, 1000)){
			alert(get_words('YM27'));
			return;
		}
		if(!check_integer($('#dtim').val(), 1, 255)){
			alert(get_words('GW_WLAN_DTIM_INVALID'));
			return;
		}
		if(!check_integer($('#fragment').val(), 256, 2346)){
			alert(get_words('GW_WLAN_FRAGMENT_THRESHOLD_INVALID'));
			return;
		}
		if(!check_integer($('#rts').val(), 1, 2347)){
			alert(get_words('GW_WLAN_RTS_THRESHOLD_INVALID'));
			return;
		}
		obj.set_param_url('apply.cgi');
		obj.set_ccp_act('set');
		obj.add_param_event('adv_wlan1_perform');
		obj.set_param_next_page('wireless2_advanced.asp');
		obj.add_param_arg('reboot_type', 'wireless');
		
		var arrIns = [5,6,7,8];
		for(var v in arrIns)
		{
			var i = arrIns[v];
			//Advanced Wireless
			obj.add_param_arg('wlanCfg_BGProtection_','1.'+i+'.0.0',$('#bg_protection').val());
			obj.add_param_arg('wlan1_beacon_interval',$('#beacon').val());
			obj.add_param_arg('wlan1_dtim',$('#dtim').val());
			obj.add_param_arg('wlan1_fragmentation',$('#fragment').val());
			obj.add_param_arg('wlan1_rts_threshold',$('#rts').val());
			obj.add_param_arg('wlan1_txpower',$('#tx_power').val());
			obj.add_param_arg('wlan1_short_preamble',$('input[name=short_preamble]:checked').val());
			obj.add_param_arg('wlan1_burst_enable',$('input[name=n_tx_burst]:checked').val());
			obj.add_param_arg('wlanCfg_PktAggregate_','1.'+i+'.0.0',$('input[name=pkt_aggregate]:checked').val());
			obj.add_param_arg('wlanCfg_IEEE11H_','1.'+i+'.0.0',$('input[name=ieee_80211h]:checked').val());

			//Qos Setting
			obj.add_param_arg('wlanCfg_WMMEnable_','1.'+i+'.0.0',$('input[name=wmm_capable]:checked').val());
			obj.add_param_arg('wlanCfg_APSD_','1.'+i+'.0.0',$('input[name=apsd_capable]:checked').val());
			obj.add_param_arg('wlanCfg_DLS_','1.'+i+'.0.0',$('input[name=dls_capable]:checked').val());

			//WiFi Multimedia
			obj.add_param_arg('wlanCfg_VideoTurbine_','1.'+i+'.0.0',$('input[name=wifi_video_turbine]:checked').val());

			//Multicast-to-Unicast
			obj.add_param_arg('wlan1_multicast_stream_enable',$('input[name=m2u_enable]:checked').val());

			//HT Physical Mode
			obj.add_param_arg('wlan1_disablecoext',$('input[name=n_coexistence1]:checked').val());
			obj.add_param_arg('wlan1_short_gi',$('input[name=n_gi1]:checked').val());
			obj.add_param_arg('wlanCfg_ReverseDirectionGrant_','1.'+i+'.0.0',$('input[name=n_rdg]:checked').val());
			obj.add_param_arg('wlanCfg_ExChannel_','1.'+i+'.0.0',$('#n_extcha1').val());
			obj.add_param_arg('wlanCfg_AMSDU_','1.'+i+'.0.0',$('input[name=n_amsdu1]:checked').val());
			obj.add_param_arg('wlanCfg_AutoBlockACK_','1.'+i+'.0.0',$('input[name=n_autoba1]:checked').val());
			obj.add_param_arg('wlanCfg_DeclineBA_','1.'+i+'.0.0',$('input[name=n_declineba1]:checked').val());
			obj.add_param_arg('wlan1_enable_ampdu',$('input[name=n_ampdu1]:checked').val());
			send_txrate_value1();
		}

		var paramForm = obj.get_param();
		
		totalWaitTime = 20; //second
		redirectURL = location.pathname;
		wait_page();
		jq_ajax_post(paramForm.url, paramForm.arg);
	}
	
	function send_txrate_value1()
	{
		var dot11_mode_t5 = lanCfg.standard5G[0];
		var tmp_rate;

		switch(dot11_mode_t5) {
			case '11n':
				obj.add_param_arg('wlan1_11n_txrate', $('#wlan1_11n_txrate :selected').val());
				break;
			case '11na':
				obj.add_param_arg('wlan1_11na_txrate', $('#wlan1_11na_txrate :selected').val());
				break;
			case '11ac':
				obj.add_param_arg('wlan1_11ac_txrate', $('#wlan1_11acna_txrate :selected').val());
				break;
		}
	}

	var txrate_11n = new Array('MCS0: 6.5M(13.5M)', 'MCS1: 13M(27M)', 'MCS2: 19.5M(40.5M)',
	                           'MCS3: 26M(54M)', 'MCS4: 39M(81M)', 'MCS5: 52M(108M)',
	                           'MCS6: 58.5M(121.5M)', 'MCS7: 65M(135M)', 'MCS8: 13M(27M)',
	                           'MCS9: 26M(54M)', 'MCS10: 39M(81M)', 'MCS11: 52M(108M)',
	                           'MCS12: 78M(162M)', 'MCS13: 104M(216M)', 'MCS14: 117M(243M)',
	                           'MCS15: 130M(270M)', 'MCS16: 19.5M(40.5M)', 'MCS17: 39M(81M)',
	                           'MCS18: 58.5M(121.5M)', 'MCS19: 78M(162M)', 'MCS20: 117M(243M)',
	                           'MCS21: 156M(324M)', 'MCS22: 175.5M(364.5M)', 'MCS23: 195M(405M)'
	                          );
	var txrate_11n_shortgi = new Array('MCS0: 7.2M(15M)', 'MCS1: 14.4M(30M)', 'MCS2: 21.7M(45M)',
	                                   'MCS3: 28.9M(60M)', 'MCS4: 43.3M(90M)', 'MCS5: 57.8M(120M)',
	                                   'MCS6: 65M(135M)', 'MCS7: 72M(150M)', 'MCS8: 14.4M(30M)',
	                                   'MCS9: 28.9M(60M)', 'MCS10: 43.3M(90M)', 'MCS11: 57.8M(120M)',
	                                   'MCS12: 86.7M(180M)', 'MCS13: 115.6M(240M)', 'MCS14: 130M(270M)',
	                                   'MCS15: 144.4M(300M)', 'MCS16: 21.70M(45M)', 'MCS17: 43.3M(90M)',
	                                   'MCS18: 65M(135M)', 'MCS19: 86.7M(180M)', 'MCS20: 130M(270M)',
	                                   'MCS21: 173M(360M)', 'MCS22: 195M(405M)', 'MCS23: 216.7M(450M)'
	                                  );
	var txrate_11ac = new Array('MCS0: 19.5M (40.5M / 87.75M)', 'MCS1: 39M (81M / 175.5M)',
	                            'MCS2: 39M (81M / 175.5M)', 'MCS3: 58.5M (121.5M / 263.25M)',
	                            'MCS4: 117M (243M / 526.5M)', 'MCS5: 156M (324M / 702M)',
	                            'MCS6: 175.5M (364.5M / 798.75M)', 'MCS7: 195M (405M / 877.5M)',
	                            'MCS8: 234M (486M / 1.053G)', 'MCS9: 260.25M (540M / 1.17G)');
	var txrate_11ac_shortgi = new Array('MCS0: 21.7M (45M / 97.5M)', 'MCS1: 43.3M (90M / 195M)',
	                                    'MCS2: 65M (135M / 292.5M)', 'MCS3: 86.7M (180M / 390M)',
	                                    'MCS4: 130M (270M / 585M)', 'MCS5: 173.3M (360M / 780M)',
	                                    'MCS6: 195M (405M / 877.5M)', 'MCS7: 216.7M (450M / 975M)',
	                                    'MCS8: 260M (540M / 1.17G)', 'MCS9: 289.2M (600M / 1.3G)');
	var txrate_11n_value = new Array("0x80808080","0x81818181","0x82828282","0x83838383",
	                                 "0x84848484","0x85858585","0x86868686","0x87878787",
	                                 "0x88888888","0x89898989","0x8a8a8a8a","0x8b8b8b8b",
	                                 "0x8c8c8c8c","0x8d8d8d8d","0x8e8e8e8e","0x8f8f8f8f",
	                                 "0x90909090","0x91919191","0x92929292","0x93939393",
	                                 "0x94949494","0x95959595","0x96969696","0x97979797");
	var txrate_11ac_value = new Array(0, 1, 2, 3, 4, 5, 6, 7, 8, 9);

	function set_11n_txrate()
	{
		var obj = get_by_id("wlan1_11n_txrate");

		for (var i = 0; i < txrate_11n.length; i++) {
			var opt = document.createElement("option");

			obj.options[i+1] = null;

			if ($('input[name=n_gi1]:checked').val() == '1')
				opt.text = txrate_11n_shortgi[i];
			else
				opt.text = txrate_11n[i];

			opt.value = txrate_11n_value[i];
			obj.options[i+1] = opt;	
		}
	}

	function set_11na_txrate(obj)
	{
		var obj = get_by_id("wlan1_11na_txrate");

		for (var i = 0; i < txrate_11n.length; i++) {
			var opt = document.createElement("option");
			
			obj.options[i+1] = null;

			if ($('input[name=n_gi1]:checked').val() == '1')
				opt.text = txrate_11n_shortgi[i];
			else
				opt.text = txrate_11n[i];

			opt.text = txrate_11n[i];
			opt.value = txrate_11n_value[i];
			obj.options[i+1] = opt;	
		}
	}

	function set_11acna_txrate(obj)
	{
		var obj = get_by_id("wlan1_11acna_txrate");

		for (var i = 0; i < txrate_11ac.length; i++) {
			var opt = document.createElement("option");

			obj.options[i+1] = null;

			if ($('input[name=n_gi1]:checked').val() == '1')
				opt.text = txrate_11ac_shortgi[i];
			else
				opt.text = txrate_11ac[i];

			opt.value = txrate_11ac_value[i];
			obj.options[i+1] = opt;	
		}
	}

function setValueBGProtectionMode() {
//	$('#tr_bg_protection').show();
	var sel_bgpro = advCfg.bgprotection[0];
	$('#bg_protection').val(sel_bgpro);
}
function setValueBeaconInterval() {
	var val_bi = advCfg.beaconperiod[0];
	$('#beacon').val(val_bi);
}
function setValueDTIM() {
	var val_dtim = advCfg.dtim[0];
	$('#dtim').val(val_dtim);
}
function setValueFragThres() {
	var val_frag = advCfg.fragthres[0];
	$('#fragment').val(val_frag);
}
function setValueRTSThres() {
	var val_rts = advCfg.rtsthres[0];
	$('#rts').val(val_rts);
}
function setValueTXPower() {
	var sel_txpower = advCfg.txpower[0];
	$('#tx_power').val(sel_txpower);
}
function setValueShortPreamble() {
	var chk_sp = advCfg.spreamble[0];
	$('input[name=short_preamble][value='+chk_sp+']').attr('checked', true);
}
function setValueTxBurst() {
//	$('#tx_burst').show();
	var chk_txburst = advCfg.txburst[0];
	$('input[name=n_tx_burst][value='+chk_txburst+']').attr('checked', true);
}
function setValuePktAggregate() {
//	$('#pkt_aggr').show();
	var chk_pkt = advCfg.pktaggregate[0];
	$('input[name=pkt_aggregate][value='+chk_pkt+']').attr('checked', true);
}
function setValue80211HSupport() {
//	$('#11hsupport').show();
	var chk_11h = advCfg.ieee11h[0];
	$('input[name=ieee_80211h][value='+chk_11h+']').attr('checked', true);
}
function setValueCountryCode() {
//	$('#country').show();
	var sel_country = RF_Domain_A;
	$('#country_code').val(sel_country).attr('disabled','disabled');
}
function setValueWMMCapable() {
//	$('#div_wmm_capable').show();
	var chk_wmm = qosCfg.wmmenable[0];
	$('input[name=wmm_capable][value='+chk_wmm+']').attr('checked', true);
}
function setValueAPSDCapable() {
//	$('#div_apsd_capable').show();
	var chk_apsd = qosCfg.apsd[0];
	$('input[name=apsd_capable][value='+chk_apsd+']').attr('checked', true);
}
function setValueDLSCapable() {
//	$('#div_dls_capable').show();
	var chk_dls = qosCfg.dls[0];
	$('input[name=dls_capable][value='+chk_dls+']').attr('checked', true);
}
function setValueVideoTurbine() {
	var chk_turbine = mediaCfg.turbine[0];
	$('input[name=wifi_video_turbine][value='+chk_turbine+']').attr('checked', true);
}
function setValueM2UConverter() {
	var chk_m2u = m2uCfg.m2u[0];
	$('input[name=m2u_enable][value='+chk_m2u+']').attr('checked', true);
}
	function setValue2040Coexistence(){
//		$('#2040coexi1').show();
		var chk_coexi = lanCfg.coexi[0];
		$('input[name=n_coexistence1][value='+chk_coexi+']').attr('checked', true);
	}
	function setValueGuardInterval(){
		var chk_gi = htCfg.shortgi[0];
		$('input[name=n_gi1][value='+chk_gi+']').attr('checked', true);
	}
	function setValueReverseDirectionGrant(){
//		$('#rdg1').show();
		var chk_rdg = htCfg.rdg[0];
		$('input[name=n_rdg1][value='+chk_rdg+']').attr('checked', true);
	}
	function setValueAggregationMSDU(){
//		$('#amsdu1').show();
		var chk_amsdu = htCfg.amsdu[0];
		$('input[name=n_amsdu1][value='+chk_amsdu+']').attr('checked', true);
	}
	function setValueAutoBlockACK(){
//		$('#autoba1').show();
		var chk_autoba = htCfg.autoba[0];
		$('input[name=n_autoba1][value='+chk_autoba+']').attr('checked', true);
	}
	function setValueDeclineBARequest(){
//		$('#declineba1').show();
		var chk_declineba = htCfg.declineba[0];
		$('input[name=n_declineba1][value='+chk_declineba+']').attr('checked', true);
	}
	function setValueAggregationMPDU(){
//		$('#ampdu1').show();
		var chk_ampdu = htCfg.ampdu[0];
		$('input[name=n_ampdu1][value='+chk_ampdu+']').attr('checked', true);
	}
	function setValueMCS()
	{
		set_11n_txrate();
		set_11na_txrate();
		set_11acna_txrate();

		switch (lanCfg.standard5G[0]) {
			case '11n': /* n mode */
				$('#wlan1_11n_txrate').val("<!--# echo wlan1_11n_txrate -->");
				break;
			case '11na': /* na mixed mode */
				$('#wlan1_11na_txrate').val("<!--# echo wlan1_11na_txrate -->");
				break;
			case '11ac': /* acna mixed mode */
				$('#wlan1_11acna_txrate').val("<!--# echo wlan1_11ac_txrate -->");
				break;
		}
	}
	function setValueExtensionChannel(){
		var val_channel = lanCfg.channel[0];
		var freqMap = {'0':'0','36':'40','40':'36','44':'48','48':'44','52':'56','56':'52','60':'64','64':'60','149':'153','153':'149','157':'161','161':'157','165':'0'};
		var ch_text = {'0':get_words('_sel_autoselect'),'36':"5180",'40':"5200",'44':"5220",'48':"5240",'52':"5260",'56':"5280",'60':"5300",'64':"5320",'149':"5745",'153':"5765",'157':"5785",'161':"5805",'165':"5825"};
		
		$('#n_extcha1').children().remove();
		var channel_i = freqMap[val_channel];
		
		var opt = $('<option/>');
		opt.text(channel_i==0?ch_text[channel_i]:ch_text[channel_i] + "MHz (Channel " + channel_i+")");
		opt.val(channel_i);
		if(lanCfg.exchannel[0]==channel_i)
			opt.attr('selected', true);
		$('#n_extcha1').append(opt);
		
		if(val_channel=='0')
		{
			$('#n_extcha1').attr('disabled','disabled');
		}
		else if(lanCfg.chanwidth[0]==1)
		{
			$('#n_extcha1').attr('disabled','');
		}
	}
	function setVisibleHTPhysicalMode()
	{
		var val_wmode = lanCfg.standard5G[0];

		switch (val_wmode) {
			case '11n': /* n mode */
				$('#show_11n_txrate1').show();
				$('#div_11n1').show();
				break;
			case '11na': /* na mixed mode */
				$('#show_11na_txrate1').show();
				$('#div_11n1').show();
				break;
			case '11ac': /* acna mixed mode */
				$('#show_11ac_txrate1').show();
				$('#div_11n1').show();
				break;
			default:
				break;
		}
	}
$(function(){
	if(lanCfg.enable[0]==1)
		$('#radioOnField').show();
	else
		$('#radioOffField').show();
	//Advanced Wireless
	setValueBGProtectionMode();
	setValueBeaconInterval();
	setValueDTIM();
	setValueFragThres();
	setValueRTSThres();
	setValueTXPower();
	setValueShortPreamble();
	setValueTxBurst();
	setValuePktAggregate();
	setValue80211HSupport();
	//setValueCountryCode();
	
	//HT Physical Mode
	setVisibleHTPhysicalMode()
	setValue2040Coexistence();
	setValueGuardInterval();
	//Extension Channel is in setEventFrequency();
	setValueReverseDirectionGrant();
	setValueAggregationMSDU();
	setValueAutoBlockACK();
	setValueDeclineBARequest();
	setValueAggregationMPDU();
	setValueMCS();
	setValueExtensionChannel();
	
	//Qos Setting
	//$('#qos_setting').show();//close
	setValueWMMCapable();
	setValueAPSDCapable();
	setValueDLSCapable();
	//$('#wmm_param').show();//close
	//setValueWMMParameters();//close
	
	//Wi-Fi Multimedia
	//$('#wifi_multimedia').show();//close
	setValueVideoTurbine();
	
	//Multicast-to-Unicast Converter
	setValueM2UConverter();
	
//	setValue();
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
				<script>document.write(menu.build_structure(1,3,0))</script>
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
								<div class="headerbg" id="advancedTitle">
								<script>show_words('aw_title_2')</script>
								</div>
								<div class="hr"></div>
								<div class="section_content_border">
								<div class="header_desc" id="advancedIntroduction">
									<script>show_words('_desc_advanced')</script>
									<p></p>
								</div>
<div id="radioOnField" style="display: none;">
<form method="post" name="wireless_basic" action="/goform/wirelessBasic" onsubmit="return CheckValue();">
	<div class="box_tn">
		<div class="CT"><script>show_words('_advwls')</script></div>
		<table cellspacing="0" cellpadding="0" class="formarea">
			<tr id="tr_bg_protection" style="display:none"> 
				<td class="CL"><script>show_words('_lb_bg_protection');</script></td>
				<td class="CR">
					<select id="bg_protection" name="bg_protection" size="1">
						<option value="0"><script>show_words('_auto');</script></option>
						<option value="1"><script>show_words('_on');</script></option>
						<option value="2"><script>show_words('_off');</script></option>
					</select>
				</td>
			</tr>
			
			<tr> 
				<td class="CL"><script>show_words('aw_BP');</script></td>
				<td class="CR">
					<input type="text" id="beacon" name="beacon" size="5" maxlength="4" onkeyup="value=value.replace(/[^0-9]/g,'')"/> ms <font color="#808080"><script>show_words('_hint_beacon');</script></font>
				</td>
			</tr>
			<tr> 
				<td class="CL"><script>show_words('_help_txt164');</script></td>
				<td class="CR">
					<input type="text" id="dtim" name="dtim" size="5" maxlength="3" onkeyup="value=value.replace(/[^0-9]/g,'')"/><font color="#808080"><script>show_words('_hint_dtim');</script></font>
				</td>
			</tr>
			<tr> 
				<td class="CL"><script>show_words('_lb_frag_thres');</script></td>
				<td class="CR">
					<input type="text" id="fragment" name="fragment" size="5" maxlength="4" onkeyup="value=value.replace(/[^0-9]/g,'')"/> <font color="#808080"><script>show_words('_hint_frag_thres');</script></font>
				</td>
			</tr>
			<tr> 
				<td class="CL"><script>show_words('aw_RT');</script></td>
				<td class="CR">
					<input type="text" id="rts" name="rts" size="5" maxlength="4" onkeyup="value=value.replace(/[^0-9]/g,'')"/> <font color="#808080"><script>show_words('_hint_rts_thres');</script></font>
				</td>
			</tr>
			<tr>
				<td class="CL"><script>show_words('_lb_txpower');</script></td>
				<td class="CR">
					<!--<input type=text name=tx_power size=5 maxlength=3 value="100" /> <font color="#808080">(range 1 - 100, default 100)</font>-->
					<select id="tx_power" name="tx_power">
					<option value="0" selected=""><script>show_words('_pwr_full');</script></option>
					<option value="1"><script>show_words('_pwr_half');</script></option>
					<option value="2"><script>show_words('_pwr_low');</script></option>
					</select>
				</td>
			</tr>
			<tr>
				<td class="CL"><script>show_words('_lb_short_preamble');</script></td>
				<td class="CR">
					<input type="radio" name="short_preamble" value="1" /><script>show_words('_enable');</script> &nbsp;
					<input type="radio" name="short_preamble" value="0" /><script>show_words('_disable');</script>
				</td>
			</tr>
			<tr id="tx_burst" style="display:none"> 
				<td class="CL"><script>show_words('_lb_tx_burst');</script></td>
				<td class="CR">
					<input type="radio" name="n_tx_burst" value="1" /><script>show_words('_enable');</script> &nbsp;
					<input type="radio" name="n_tx_burst" value="0" /><script>show_words('_disable');</script>
				</td>
			</tr>
			<tr id="pkt_aggr" style="display:none"> 
				<td class="CL"><script>show_words('_lb_pkt_aggregate');</script></td>
				<td class="CR">
					<input type="radio" name="pkt_aggregate" value="1" /><script>show_words('_enable');</script> &nbsp;
					<input type="radio" name="pkt_aggregate" value="0" /><script>show_words('_disable');</script>
				</td>
			</tr>
			<tr id="11hsupport" style="display:none"> 
				<td class="CL"><script>show_words('_lb_80211h_support');</script></td>
				<td class="CR">
					<input type="radio" name="ieee_80211h" value="1" /><script>show_words('_enable');</script> &nbsp;
					<input type="radio" name="ieee_80211h" value="0" /><script>show_words('_disable');</script> <font color="#808080">(<script>show_words('_hint_only_a_band');</script>)</font>
				</td>
			</tr>
			<tr id="country" style="display:none"> 
				<td class="CL"><script>show_words('_lb_country_code');</script></td>
				<td class="CR">
					<select id="country_code" name="country_code">
						<option value="6">US (United States)</option>
						<option value="11">JP (Japan)</option>
						<option value="15">FR (France)</option>
						<option value="5">TW (Taiwan)</option>
						<option value="IE">IE (Ireland)</option>
						<option value="HK">HK (Hong Kong)</option>
						<option value="0" selected="">NONE</option>
					</select>
				</td>
			</tr>
		</table>
	</div>

<div id="div_11n1" class="box_tn" style="display:none;">
	<div class="CT"><script>show_words('_help_txt144')</script></div>
	<table cellspacing="0" cellpadding="0" class="formarea">
		<tr id="2040coexi1" style="display:none">
			<td class="CL"><script>show_words('_lb_coexistence');</script></td>
			<td class="CR">
				<input type="radio" name="n_coexistence1" value="0" /><script>show_words('_disable')</script>
				<input type="radio" name="n_coexistence1" value="1" /><script>show_words('_enable')</script>
			</td>
		</tr>
		<tr id="guard_interval1">
			<td class="CL"><script>show_words('_help_txt155')</script></td>
			<td class="CR">
				<input type="radio" name="n_gi1" value="0" onClick="setValueMCS()" /><script>show_words('_long');</script>&nbsp;
				<input type="radio" name="n_gi1" value="1" onClick="setValueMCS()" /><script>show_words('KR50');</script>
			</td>
		</tr>
		<!-- 11n txrate -->
		<tr id="show_11n_txrate1" style="display:none">
			<td class="CL"><script>show_words('_lb_mcs')</script></td>
			<td class="CR">
				<select id="wlan1_11n_txrate" name="wlan1_11n_txrate">
					<option value="auto" selected><script>show_words('KR50')</script></option>
				</select>
			</td>
		</tr>
		<!-- 11n/a txrate -->
		<tr id="show_11na_txrate1" style="display:none;">
			<td class="CL"><script>show_words('_lb_mcs')</script></td>
			<td class="CR">
				<select id="wlan1_11na_txrate" name="wlan1_11na_txrate">
					<option value="auto" selected><script>show_words('KR50')</script></option>
				</select>
			</td>
		</tr>
		<!-- 11ac/n/a txrate -->
		<tr id="show_11ac_txrate1" style="display:none;">
			<td class="CL"><script>show_words('_lb_mcs')</script></td>
			<td class="CR">
				<select id="wlan1_11acna_txrate" name="wlan1_11acna_txrate">
					<option value="auto" selected><script>show_words('KR50')</script></option>
				</select>
			</td>
		</tr>
		<tr id="rdg1" style="display:none;">
			<td class="CL"><script>show_words('_lb_rdg');</script></td>
			<td class="CR">
				<input type="radio" name="n_rdg1" value="0" /><script>show_words('_disable');</script>&nbsp;
				<input type="radio" name="n_rdg1" value="1" /><script>show_words('_enable');</script>
			</td>
		</tr>
		<tr id="ext_channel1" style="display: none;">
			<td class="CL" style="display: none;"><script>show_words('_lb_exten_channel');</script></td>
			<td class="CR" style="display: none;">
				<select id="n_extcha1" name="n_extcha1" size="1" disabled="">
					<option value="0" selected=""><script>show_words('_sel_autoselect');</script></option>
				</select>
			</td>
		</tr>
		<tr id="amsdu1" style="display:none">
			<td class="CL"><script>show_words('_lb_a_msdu');</script></td>
			<td class="CR">
				<input type="radio" name="n_amsdu1" value="0" /><script>show_words('_disable');</script>&nbsp;
				<input type="radio" name="n_amsdu1" value="1" /><script>show_words('_enable');</script>
			</td>
		</tr>
		<tr id="autoba1" style="display:none">
			<td class="CL"><script>show_words('_lb_autoba');</script></td>
			<td class="CR">
				<input type="radio" name="n_autoba1" value="0" /><script>show_words('_disable');</script>&nbsp;
				<input type="radio" name="n_autoba1" value="1" /><script>show_words('_enable');</script>
			</td>
		</tr>
		<tr id="declineba1" style="display:none">
			<td class="CL"><script>show_words('_lb_declineba');</script></td>
			<td class="CR">
				<input type="radio" name="n_declineba1" value="0" /><script>show_words('_disable');</script>&nbsp;
				<input type="radio" name="n_declineba1" value="1" /><script>show_words('_enable');</script>
			</td>
		</tr>
		<tr id="ampdu1">
			<td class="CL"><script>show_words('_lb_a_mpdu');</script></td>
			<td class="CR">
				<input type="radio" name="n_ampdu1" value="1" /><script>show_words('_enable');</script>&nbsp;
				<input type="radio" name="n_ampdu1" value="0" /><script>show_words('_disable');</script>
			</td>
		</tr>
	</table>
</div>

	<div id="qos_setting" class="box_tn" style="display:none"><!--  -->
		<div class="CT"><script>show_words('_bx_advanced_2');</script></div>
		<table cellspacing="0" cellpadding="0" class="formarea">
			<tr id="div_wmm_capable"> 
				<td class="CL"><script>show_words('_lb_wmm_capable');</script></td>
				<td class="CR">
					<input type="radio" name="wmm_capable" value="1" /><script>show_words('_enable');</script> &nbsp;
					<input type="radio" name="wmm_capable" value="0" /><script>show_words('_disable');</script>
				</td>
			</tr>
			<tr id="div_apsd_capable" name="div_apsd_capable" style="display: none;">
				<td class="CL"><script>show_words('_lb_apsd_capable');</script></td>
				<td class="CR">
					<input type="radio" name="apsd_capable" value="1" /><script>show_words('_enable');</script> &nbsp;
					<input type="radio" name="apsd_capable" value="0" /><script>show_words('_disable');</script>
				</td>
			</tr>
			<tr id="div_dls_capable" name="div_dls_capable">
				<td class="CL"><script>show_words('_lb_dls_capable');</script></td>
				<td class="CR">
					<input type="radio" name="dls_capable" value="1" /><script>show_words('_enable');</script> &nbsp;
					<input type="radio" name="dls_capable" value="0" /><script>show_words('_disable');</script>
				</td>
			</tr>
		<!-- -->
			<tr id="wmm_param" style="display:none"> 
				<td class="CL"><script>show_words('_lb_wmm_param');</script></td>
				<td class="CR">
					<input type="button" id="wmm_list" name="wmm_list" value="" onclick="open_wmm_window()" />
					<script>$('#wmm_list').val(get_words('_lb_wmm_config'));</script>
				</td>
			</tr>
			<input type="hidden" name="rebootAP" value="0" />
		</table>
	</div>

	<div class="box_tn" id="wifi_multimedia" style="display:none">
		<div class="CT"><script>show_words('_bx_advanced_3');</script></div>
		<table name="div_wfvt" cellspacing="0" cellpadding="0" class="formarea">
		<tr> 
			<td class="CL"><script>show_words('_lb_video_turbine');</script></td>
			<td class="CR">
				<input type="radio" name="wifi_video_turbine" value="1" /><script>show_words('_enable');</script> &nbsp;
				<input type="radio" name="wifi_video_turbine" value="0" /><script>show_words('_disable');</script>
				<input type="radio" name="wifi_video_turbine" value="2" /><script>show_words('_auto');</script>
			</td>
		</tr>
		</table>
	</div>

	<div id="div_m2u" class="box_tn">
		<div class="CT"><script>show_words('_bx_advanced_4')</script></div>
		<table cellspacing="0" cellpadding="0" class="formarea">
			<tr> 
				<td class="CL"><script>show_words('_lb_multi_uni');</script></td>
				<td class="CR">
					<input type="radio" name="m2u_enable" value="2" /><script>show_words('_enable');</script> &nbsp;
					<input type="radio" name="m2u_enable" value="0" /><script>show_words('_disable');</script>
				</td>
			</tr>
		</table>
	</div>
	
	<div id="buttonField" class="box_tn">
		<table cellspacing="0" cellpadding="0" class="formarea">
			<tr align="center">
				<td colspan="2" class="btn_field">
					<input type="button" class="button_submit" id="btn_apply" value="Apply" onclick="check_value();" />
					<script>$('#btn_apply').val(get_words('_apply'));</script>
					<input type="reset" class="button_submit" id="btn_cancel" value="Cancel" onclick="window.location.reload()" />
					<script>$('#btn_cancel').val(get_words('_cancel'));</script>
				</td>
			</tr>
		</table>
	</div>
</form>
</div>

<div id="radioOffField" class="box_tn" style="display: none;">
	<table cellspacing="0" cellpadding="0" class="formarea">
		<tr>
			<td colspan="2" align="center" class="CELL"><font color="red" id="Msg" name="Msg"><script>show_words('_MSG_woff');</script></font></td>
		</tr>
	</table>
</div>

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
