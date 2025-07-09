<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html lang="en-US" xmlns="http://www.w3.org/1999/xhtml" xml:lang="en-US">
<head>
<title>TRENDNET | modelName | Wireless 5GHz | Security</title>
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
	var lanCfg = {
	    'enable':   ['<!--# echo wlan1_vap0_enable -->']
	};
	var wpsCfg = {
	    'enable':   ['<!--# echo wlan1_wps_enable -->']
	};
	var MACAction = ['<!--# echo wlan1_vap0_mac_filter_type -->','<!--# echo wlan1_vap1_mac_filter_type -->','<!--# echo wlan1_vap2_mac_filter_type -->','<!--# echo wlan1_vap3_mac_filter_type -->'];
	var MACFilter = new Array();
		
	var changed = 0;
	var old_MBSSID;
	var max_SSID = 4;
	var max_MACrule = 24;
	var MACarray0 = new Array();
	var MACarray1 = new Array();
	var MACarray2 = new Array();
	var MACarray3 = new Array();
	
	function onPageLoad()
	{
		if(lanCfg.enable[0]==1)
			$('#radioOnField').show();
		else
			$('#radioOffField').show();
		//SSID List
		var total_ssid=0;
		for(var i=0; i<max_SSID; i++)
		{
			if($("#wlan1_vap"+ i +"_ssid").text() != "")
			{
				$('#ssidIndex').append('<option value='+i+'>' + $("#wlan1_vap"+ i +"_ssid").html() + '</option>');
				total_ssid++;
			}
		}

		set_mac_filter();
		//Set MAC address into four array for checking value
		arrayMAC();
		//MAC address List for 4 SSID
		paintTable();
		//show one SSID and content
		selectMBSSIDChanged();
		set_form_default_values("form1");
	}
	
	//check which SSID is selected right now
	function set_mac_filter()
	{
		for(var i = 0; i < max_SSID; i++) {
			for (var j = 0; j < max_MACrule; j++) {
				MACFilter[i * max_MACrule + j] = get_by_id("wlan1_vap" + i + "_mac_filter_" + j ).value;
			}
		}
	}

	//check which SSID is selected right now
	function selectMBSSIDChanged()
	{
		if(changed){
			ret = confirm(get_words('_wifiser_mode39'));
			if(!ret){
				$('#ssidIndex').val(old_MBSSID);
				return false;
			}
			else
				changed = 0;
			}
		old_MBSSID = $('#ssidIndex').val();
		MBSSIDChange($('#ssidIndex').val());
	}
	
	function MBSSIDChange(index)
	{
		// update Access Policy for MBSSID[selected]
		ShowAP(index);
		
		// clear all new access policy list field
		for(i=0; i<max_SSID; i++)
			$("#newap_text_"+i).val("");
		
		return true;
	}
	
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

	function setChange(c){
		changed = c;
	}
	
	function del_row(row){

		var mac_string = MACFilter[row].split("/");

		if(!confirm(get_words('YM35')+" "+ mac_string[2] +"?"))
			return;

		var obj = new ccpObject();
		obj.set_param_url('apply.cgi');
		obj.set_ccp_act('set');
		obj.add_param_event('wlan_mac_filters');
		obj.set_param_next_page('wireless2_security.asp');
		var idx = $('#ssidIndex').val();

		for (i = parseInt(row) % max_MACrule; (i + 1) < max_MACrule; i++)
			obj.add_param_arg("wlan1_vap" + idx + "_mac_filter_" + i, get_by_id("wlan1_vap" + idx + "_mac_filter_" + (i + 1)).value);

		obj.add_param_arg("wlan1_vap"+ idx +"_mac_filter_" + i, "0/0/00:00:00:00:00:00");

		var param = obj.get_param();

		totalWaitTime = 20; //second
		redirectURL = location.pathname;
		wait_page();
		jq_ajax_post(param.url, param.arg);
	}

	function paintTable()
	{
		//MACFilter
		var aptable;
		for(aptable=0; aptable < max_SSID; aptable++){
			var contain = "";
			contain += "<div class='box_tn' style='display:none' id='AccessPolicy3_"+ aptable +"'><table width='100%' border='0' align='center' cellpadding='0' cellspacing='0' class='formarea'>";	
			contain += "<tr><td colspan='2' class='CT'>"+get_words('_wifiser_mode40')+"</td></tr>"
			contain += "<tr align=\"center\">";
			contain += "<td width=\"80%\" class='CTS'>"+get_words('aa_AT_1')+"</td>";
			contain += "<td width=\"20%\" class='CTS'>"+get_words('_delete')+"</td>";	
			contain += "</tr>";	
			
			for(var i=(aptable*max_MACrule); i < (aptable*max_MACrule+max_MACrule); i++){
				if(MACFilter[i]!="0/0/00:00:00:00:00:00"){
					var entry = MACFilter[i];
					entry = entry.split("/");
					contain += "<tr align=center>"+
							"<td align=center class='CELL'>"+ entry[2] +
							"</td><td class='CELL'><center><a href=\"javascript:del_row(" + i +")\"><img src=\"/image/delete.gif\"  border=\"0\" title=\""+get_words('_delete')+"\" /></a></center>" +
							"</td></tr>";
				}
			}
			contain += "</table></div>";
			$('#WSTable'+aptable).html(contain);
		}
	}

	function arrayMAC()
	{
		//Each SSID has 24 MAC address
		for(var i=0; i<max_SSID; i++)
		{
			var temMAC = new Array();

			for(var j=0; j<max_MACrule; j++)
			{
				if((MACFilter[i*max_MACrule+j] != "") && (MACFilter[i*max_MACrule+j] != "0/0/00:00:00:00:00:00"))
					temMAC[temMAC.length++] = MACFilter[i*max_MACrule+j];
			}
			if (i == 0)	MACarray0 = temMAC;
			if (i == 1) MACarray1 = temMAC
			if (i == 2) MACarray2 = temMAC;
			if (i == 3) MACarray3 = temMAC;
		}
	}

	function send_request()
	{
		var idx = $('#ssidIndex').val();
		var count = 0;

		//check data
		if (!checkData())
			return false;

		var obj = new ccpObject();
		obj.set_param_url('apply.cgi');
		obj.set_ccp_act('set');
		obj.add_param_event('wlan_mac_filters');
		obj.set_param_next_page('wireless_security.asp');
		obj.add_param_arg('reboot_type', 'wireless');
		var tmp_mac;

		if (idx == "0")	tmp_mac = MACarray0;
		if (idx == "1") tmp_mac = MACarray1;
		if (idx == "2") tmp_mac = MACarray2;
		if (idx == "3") tmp_mac = MACarray3;

		obj.add_param_arg("wlan1_vap" + idx + "_mac_filter_type", $("#apselect_" + (idx)).val());

		if (wpsCfg.enable[0] == "1" && $("#apselect_" + (idx)).val() != "disable") {
			if (confirm(get_words("amaf_alert_3")) == false)
				return false;
			else
				obj.add_param_arg("wlan1_wps_enable", 0);
		}

		if($('#newap_text_' + (idx)).val() != "")
			tmp_mac[tmp_mac.length++] = "1/0/" + $('#newap_text_'+(idx)).val();

		for (var i = 0; i < max_MACrule; i++) {
			if (tmp_mac[i] != null)
				obj.add_param_arg("wlan1_vap" + idx +"_mac_filter_" + i, tmp_mac[i].toUpperCase());
			else
				obj.add_param_arg("wlan1_vap" + idx +"_mac_filter_" + i, "0/0/00:00:00:00:00:00");
		}
                
		var paramForm = obj.get_param();
		
		totalWaitTime = 20; //second
		redirectURL = location.pathname;
		wait_page();
		jq_ajax_post(paramForm.url, paramForm.arg);
	}

	function checkData()
	{
		//Check Access Policy
		if(!chkMACPolicy())
			return false;
		
		return true;
	}
	
	function chkMACPolicy()
	{
		var idx = $('#ssidIndex :selected').val();
		var chkMAC;

		if (idx == "0")	chkMAC = MACarray0;
		if (idx == "1") chkMAC = MACarray1;
		if (idx == "2") chkMAC = MACarray2;
		if (idx == "3") chkMAC = MACarray3;

		var keyvalue = $('#newap_text_'+idx).val();

		if(keyvalue == "")
			return true;

		if(chkMAC.length >= max_MACrule)
		{
			alert(get_words('_wifiser_mode26'));
			return false;
		}
		if (!check_mac(keyvalue))
		{
			alert(get_words('LS47'));
			return false;
		}
		if(keyvalue.toUpperCase() == "FF:FF:FF:FF:FF:FF")
		{
			alert(get_words('_wifiser_mode25'));
			return false;
		}
		if(chkMAC.indexOf("1/0/" + keyvalue.toUpperCase())>=0)
		{
			alert(addstr(get_words('GW_MAC_FILTER_MAC_UNIQUENESS_INVALID'), keyvalue.toUpperCase()));
			return false;
		}
		/*
		if( broadcastMAC(apMacObj) == true || multicastMAC(apMacObj) == true ) {
			alert("Multicast/Broadcast MAC address is not allowed.");
			return false;
		}
		*/

		return true;
	}
</script>
</head>
<body onload="onPageLoad();">
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
				<script>document.write(menu.build_structure(1,3,2))</script>
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
								<div class="headerbg" id="tabBigTitle">
								<script>show_words('_wifiser_title');</script>
								</div>
								<div class="hr"></div>
								<div class="section_content_border">
								<div class="header_desc" id="basicIntroduction">
									<script>show_words('_wifiser_mode42');</script>
									<p></p>
								</div>
			<form id="form1" name="form1" method="post" action="apply.cgi">
				<input type="hidden" id="html_response_return_page" name="html_response_return_page" value="wireless_security.asp" />
				<input type="hidden" id="action" name="action" value="wlan_mac_filters">
				<span id="wlan1_vap0_ssid" style="display:none;"><!--# echot wlan1_vap0_ssid --></span>
				<span id="wlan1_vap1_ssid" style="display:none;"><!--# echot wlan1_vap1_ssid --></span>
				<span id="wlan1_vap2_ssid" style="display:none;"><!--# echot wlan1_vap2_ssid --></span>
				<span id="wlan1_vap3_ssid" style="display:none;"><!--# echot wlan1_vap3_ssid --></span>
				<input type="hidden" id="wlan1_vap0_mac_filter_0" name="wlan1_vap0_mac_filter_0" value="<!--# echo wlan1_vap0_mac_filter_0 -->">
				<input type="hidden" id="wlan1_vap0_mac_filter_1" name="wlan1_vap0_mac_filter_1" value="<!--# echo wlan1_vap0_mac_filter_1 -->">
				<input type="hidden" id="wlan1_vap0_mac_filter_2" name="wlan1_vap0_mac_filter_2" value="<!--# echo wlan1_vap0_mac_filter_2 -->">
				<input type="hidden" id="wlan1_vap0_mac_filter_3" name="wlan1_vap0_mac_filter_3" value="<!--# echo wlan1_vap0_mac_filter_3 -->">
				<input type="hidden" id="wlan1_vap0_mac_filter_4" name="wlan1_vap0_mac_filter_4" value="<!--# echo wlan1_vap0_mac_filter_4 -->">
				<input type="hidden" id="wlan1_vap0_mac_filter_5" name="wlan1_vap0_mac_filter_5" value="<!--# echo wlan1_vap0_mac_filter_5 -->">
				<input type="hidden" id="wlan1_vap0_mac_filter_6" name="wlan1_vap0_mac_filter_6" value="<!--# echo wlan1_vap0_mac_filter_6 -->">
				<input type="hidden" id="wlan1_vap0_mac_filter_7" name="wlan1_vap0_mac_filter_7" value="<!--# echo wlan1_vap0_mac_filter_7 -->">
				<input type="hidden" id="wlan1_vap0_mac_filter_8" name="wlan1_vap0_mac_filter_8" value="<!--# echo wlan1_vap0_mac_filter_8 -->">
				<input type="hidden" id="wlan1_vap0_mac_filter_9" name="wlan1_vap0_mac_filter_9" value="<!--# echo wlan1_vap0_mac_filter_9 -->">
				<input type="hidden" id="wlan1_vap0_mac_filter_10" name="wlan1_vap0_mac_filter_10" value="<!--# echo wlan1_vap0_mac_filter_10 -->">
				<input type="hidden" id="wlan1_vap0_mac_filter_11" name="wlan1_vap0_mac_filter_11" value="<!--# echo wlan1_vap0_mac_filter_11 -->">
				<input type="hidden" id="wlan1_vap0_mac_filter_12" name="wlan1_vap0_mac_filter_12" value="<!--# echo wlan1_vap0_mac_filter_12 -->">
				<input type="hidden" id="wlan1_vap0_mac_filter_13" name="wlan1_vap0_mac_filter_13" value="<!--# echo wlan1_vap0_mac_filter_13 -->">
				<input type="hidden" id="wlan1_vap0_mac_filter_14" name="wlan1_vap0_mac_filter_14" value="<!--# echo wlan1_vap0_mac_filter_14 -->">
				<input type="hidden" id="wlan1_vap0_mac_filter_15" name="wlan1_vap0_mac_filter_15" value="<!--# echo wlan1_vap0_mac_filter_15 -->">
				<input type="hidden" id="wlan1_vap0_mac_filter_16" name="wlan1_vap0_mac_filter_16" value="<!--# echo wlan1_vap0_mac_filter_16 -->">
				<input type="hidden" id="wlan1_vap0_mac_filter_17" name="wlan1_vap0_mac_filter_17" value="<!--# echo wlan1_vap0_mac_filter_17 -->">
				<input type="hidden" id="wlan1_vap0_mac_filter_18" name="wlan1_vap0_mac_filter_18" value="<!--# echo wlan1_vap0_mac_filter_18 -->">
				<input type="hidden" id="wlan1_vap0_mac_filter_19" name="wlan1_vap0_mac_filter_19" value="<!--# echo wlan1_vap0_mac_filter_19 -->">
				<input type="hidden" id="wlan1_vap0_mac_filter_20" name="wlan1_vap0_mac_filter_20" value="<!--# echo wlan1_vap0_mac_filter_20 -->">
				<input type="hidden" id="wlan1_vap0_mac_filter_21" name="wlan1_vap0_mac_filter_21" value="<!--# echo wlan1_vap0_mac_filter_21 -->">
				<input type="hidden" id="wlan1_vap0_mac_filter_22" name="wlan1_vap0_mac_filter_22" value="<!--# echo wlan1_vap0_mac_filter_22 -->">
				<input type="hidden" id="wlan1_vap0_mac_filter_23" name="wlan1_vap0_mac_filter_23" value="<!--# echo wlan1_vap0_mac_filter_23 -->">
				<input type="hidden" id="wlan1_vap1_mac_filter_0" name="wlan1_vap1_mac_filter_0" value="<!--# echo wlan1_vap1_mac_filter_0 -->">
				<input type="hidden" id="wlan1_vap1_mac_filter_1" name="wlan1_vap1_mac_filter_1" value="<!--# echo wlan1_vap1_mac_filter_1 -->">
				<input type="hidden" id="wlan1_vap1_mac_filter_2" name="wlan1_vap1_mac_filter_2" value="<!--# echo wlan1_vap1_mac_filter_2 -->">
				<input type="hidden" id="wlan1_vap1_mac_filter_3" name="wlan1_vap1_mac_filter_3" value="<!--# echo wlan1_vap1_mac_filter_3 -->">
				<input type="hidden" id="wlan1_vap1_mac_filter_4" name="wlan1_vap1_mac_filter_4" value="<!--# echo wlan1_vap1_mac_filter_4 -->">
				<input type="hidden" id="wlan1_vap1_mac_filter_5" name="wlan1_vap1_mac_filter_5" value="<!--# echo wlan1_vap1_mac_filter_5 -->">
				<input type="hidden" id="wlan1_vap1_mac_filter_6" name="wlan1_vap1_mac_filter_6" value="<!--# echo wlan1_vap1_mac_filter_6 -->">
				<input type="hidden" id="wlan1_vap1_mac_filter_7" name="wlan1_vap1_mac_filter_7" value="<!--# echo wlan1_vap1_mac_filter_7 -->">
				<input type="hidden" id="wlan1_vap1_mac_filter_8" name="wlan1_vap1_mac_filter_8" value="<!--# echo wlan1_vap1_mac_filter_8 -->">
				<input type="hidden" id="wlan1_vap1_mac_filter_9" name="wlan1_vap1_mac_filter_9" value="<!--# echo wlan1_vap1_mac_filter_9 -->">
				<input type="hidden" id="wlan1_vap1_mac_filter_10" name="wlan1_vap1_mac_filter_10" value="<!--# echo wlan1_vap1_mac_filter_10 -->">
				<input type="hidden" id="wlan1_vap1_mac_filter_11" name="wlan1_vap1_mac_filter_11" value="<!--# echo wlan1_vap1_mac_filter_11 -->">
				<input type="hidden" id="wlan1_vap1_mac_filter_12" name="wlan1_vap1_mac_filter_12" value="<!--# echo wlan1_vap1_mac_filter_12 -->">
				<input type="hidden" id="wlan1_vap1_mac_filter_13" name="wlan1_vap1_mac_filter_13" value="<!--# echo wlan1_vap1_mac_filter_13 -->">
				<input type="hidden" id="wlan1_vap1_mac_filter_14" name="wlan1_vap1_mac_filter_14" value="<!--# echo wlan1_vap1_mac_filter_14 -->">
				<input type="hidden" id="wlan1_vap1_mac_filter_15" name="wlan1_vap1_mac_filter_15" value="<!--# echo wlan1_vap1_mac_filter_15 -->">
				<input type="hidden" id="wlan1_vap1_mac_filter_16" name="wlan1_vap1_mac_filter_16" value="<!--# echo wlan1_vap1_mac_filter_16 -->">
				<input type="hidden" id="wlan1_vap1_mac_filter_17" name="wlan1_vap1_mac_filter_17" value="<!--# echo wlan1_vap1_mac_filter_17 -->">
				<input type="hidden" id="wlan1_vap1_mac_filter_18" name="wlan1_vap1_mac_filter_18" value="<!--# echo wlan1_vap1_mac_filter_18 -->">
				<input type="hidden" id="wlan1_vap1_mac_filter_19" name="wlan1_vap1_mac_filter_19" value="<!--# echo wlan1_vap1_mac_filter_19 -->">
				<input type="hidden" id="wlan1_vap1_mac_filter_20" name="wlan1_vap1_mac_filter_20" value="<!--# echo wlan1_vap1_mac_filter_20 -->">
				<input type="hidden" id="wlan1_vap1_mac_filter_21" name="wlan1_vap1_mac_filter_21" value="<!--# echo wlan1_vap1_mac_filter_21 -->">
				<input type="hidden" id="wlan1_vap1_mac_filter_22" name="wlan1_vap1_mac_filter_22" value="<!--# echo wlan1_vap1_mac_filter_22 -->">
				<input type="hidden" id="wlan1_vap1_mac_filter_23" name="wlan1_vap1_mac_filter_23" value="<!--# echo wlan1_vap1_mac_filter_23 -->">
				<input type="hidden" id="wlan1_vap2_mac_filter_0" name="wlan1_vap2_mac_filter_0" value="<!--# echo wlan1_vap2_mac_filter_0 -->">
				<input type="hidden" id="wlan1_vap2_mac_filter_1" name="wlan1_vap2_mac_filter_1" value="<!--# echo wlan1_vap2_mac_filter_1 -->">
				<input type="hidden" id="wlan1_vap2_mac_filter_2" name="wlan1_vap2_mac_filter_2" value="<!--# echo wlan1_vap2_mac_filter_2 -->">
				<input type="hidden" id="wlan1_vap2_mac_filter_3" name="wlan1_vap2_mac_filter_3" value="<!--# echo wlan1_vap2_mac_filter_3 -->">
				<input type="hidden" id="wlan1_vap2_mac_filter_4" name="wlan1_vap2_mac_filter_4" value="<!--# echo wlan1_vap2_mac_filter_4 -->">
				<input type="hidden" id="wlan1_vap2_mac_filter_5" name="wlan1_vap2_mac_filter_5" value="<!--# echo wlan1_vap2_mac_filter_5 -->">
				<input type="hidden" id="wlan1_vap2_mac_filter_6" name="wlan1_vap2_mac_filter_6" value="<!--# echo wlan1_vap2_mac_filter_6 -->">
				<input type="hidden" id="wlan1_vap2_mac_filter_7" name="wlan1_vap2_mac_filter_7" value="<!--# echo wlan1_vap2_mac_filter_7 -->">
				<input type="hidden" id="wlan1_vap2_mac_filter_8" name="wlan1_vap2_mac_filter_8" value="<!--# echo wlan1_vap2_mac_filter_8 -->">
				<input type="hidden" id="wlan1_vap2_mac_filter_9" name="wlan1_vap2_mac_filter_9" value="<!--# echo wlan1_vap2_mac_filter_9 -->">
				<input type="hidden" id="wlan1_vap2_mac_filter_10" name="wlan1_vap2_mac_filter_10" value="<!--# echo wlan1_vap2_mac_filter_10 -->">
				<input type="hidden" id="wlan1_vap2_mac_filter_11" name="wlan1_vap2_mac_filter_11" value="<!--# echo wlan1_vap2_mac_filter_11 -->">
				<input type="hidden" id="wlan1_vap2_mac_filter_12" name="wlan1_vap2_mac_filter_12" value="<!--# echo wlan1_vap2_mac_filter_12 -->">
				<input type="hidden" id="wlan1_vap2_mac_filter_13" name="wlan1_vap2_mac_filter_13" value="<!--# echo wlan1_vap2_mac_filter_13 -->">
				<input type="hidden" id="wlan1_vap2_mac_filter_14" name="wlan1_vap2_mac_filter_14" value="<!--# echo wlan1_vap2_mac_filter_14 -->">
				<input type="hidden" id="wlan1_vap2_mac_filter_15" name="wlan1_vap2_mac_filter_15" value="<!--# echo wlan1_vap2_mac_filter_15 -->">
				<input type="hidden" id="wlan1_vap2_mac_filter_16" name="wlan1_vap2_mac_filter_16" value="<!--# echo wlan1_vap2_mac_filter_16 -->">
				<input type="hidden" id="wlan1_vap2_mac_filter_17" name="wlan1_vap2_mac_filter_17" value="<!--# echo wlan1_vap2_mac_filter_17 -->">
				<input type="hidden" id="wlan1_vap2_mac_filter_18" name="wlan1_vap2_mac_filter_18" value="<!--# echo wlan1_vap2_mac_filter_18 -->">
				<input type="hidden" id="wlan1_vap2_mac_filter_19" name="wlan1_vap2_mac_filter_19" value="<!--# echo wlan1_vap2_mac_filter_19 -->">
				<input type="hidden" id="wlan1_vap2_mac_filter_20" name="wlan1_vap2_mac_filter_20" value="<!--# echo wlan1_vap2_mac_filter_20 -->">
				<input type="hidden" id="wlan1_vap2_mac_filter_21" name="wlan1_vap2_mac_filter_21" value="<!--# echo wlan1_vap2_mac_filter_21 -->">
				<input type="hidden" id="wlan1_vap2_mac_filter_22" name="wlan1_vap2_mac_filter_22" value="<!--# echo wlan1_vap2_mac_filter_22 -->">
				<input type="hidden" id="wlan1_vap2_mac_filter_23" name="wlan1_vap2_mac_filter_23" value="<!--# echo wlan1_vap2_mac_filter_23 -->">
				<input type="hidden" id="wlan1_vap3_mac_filter_0" name="wlan1_vap3_mac_filter_0" value="<!--# echo wlan1_vap3_mac_filter_0 -->">
				<input type="hidden" id="wlan1_vap3_mac_filter_1" name="wlan1_vap3_mac_filter_1" value="<!--# echo wlan1_vap3_mac_filter_1 -->">
				<input type="hidden" id="wlan1_vap3_mac_filter_2" name="wlan1_vap3_mac_filter_2" value="<!--# echo wlan1_vap3_mac_filter_2 -->">
				<input type="hidden" id="wlan1_vap3_mac_filter_3" name="wlan1_vap3_mac_filter_3" value="<!--# echo wlan1_vap3_mac_filter_3 -->">
				<input type="hidden" id="wlan1_vap3_mac_filter_4" name="wlan1_vap3_mac_filter_4" value="<!--# echo wlan1_vap3_mac_filter_4 -->">
				<input type="hidden" id="wlan1_vap3_mac_filter_5" name="wlan1_vap3_mac_filter_5" value="<!--# echo wlan1_vap3_mac_filter_5 -->">
				<input type="hidden" id="wlan1_vap3_mac_filter_6" name="wlan1_vap3_mac_filter_6" value="<!--# echo wlan1_vap3_mac_filter_6 -->">
				<input type="hidden" id="wlan1_vap3_mac_filter_7" name="wlan1_vap3_mac_filter_7" value="<!--# echo wlan1_vap3_mac_filter_7 -->">
				<input type="hidden" id="wlan1_vap3_mac_filter_8" name="wlan1_vap3_mac_filter_8" value="<!--# echo wlan1_vap3_mac_filter_8 -->">
				<input type="hidden" id="wlan1_vap3_mac_filter_9" name="wlan1_vap3_mac_filter_9" value="<!--# echo wlan1_vap3_mac_filter_9 -->">
				<input type="hidden" id="wlan1_vap3_mac_filter_10" name="wlan1_vap3_mac_filter_10" value="<!--# echo wlan1_vap3_mac_filter_10 -->">
				<input type="hidden" id="wlan1_vap3_mac_filter_11" name="wlan1_vap3_mac_filter_11" value="<!--# echo wlan1_vap3_mac_filter_11 -->">
				<input type="hidden" id="wlan1_vap3_mac_filter_12" name="wlan1_vap3_mac_filter_12" value="<!--# echo wlan1_vap3_mac_filter_12 -->">
				<input type="hidden" id="wlan1_vap3_mac_filter_13" name="wlan1_vap3_mac_filter_13" value="<!--# echo wlan1_vap3_mac_filter_13 -->">
				<input type="hidden" id="wlan1_vap3_mac_filter_14" name="wlan1_vap3_mac_filter_14" value="<!--# echo wlan1_vap3_mac_filter_14 -->">
				<input type="hidden" id="wlan1_vap3_mac_filter_15" name="wlan1_vap3_mac_filter_15" value="<!--# echo wlan1_vap3_mac_filter_15 -->">
				<input type="hidden" id="wlan1_vap3_mac_filter_16" name="wlan1_vap3_mac_filter_16" value="<!--# echo wlan1_vap3_mac_filter_16 -->">
				<input type="hidden" id="wlan1_vap3_mac_filter_17" name="wlan1_vap3_mac_filter_17" value="<!--# echo wlan1_vap3_mac_filter_17 -->">
				<input type="hidden" id="wlan1_vap3_mac_filter_18" name="wlan1_vap3_mac_filter_18" value="<!--# echo wlan1_vap3_mac_filter_18 -->">
				<input type="hidden" id="wlan1_vap3_mac_filter_19" name="wlan1_vap3_mac_filter_19" value="<!--# echo wlan1_vap3_mac_filter_19 -->">
				<input type="hidden" id="wlan1_vap3_mac_filter_20" name="wlan1_vap3_mac_filter_20" value="<!--# echo wlan1_vap3_mac_filter_20 -->">
				<input type="hidden" id="wlan1_vap3_mac_filter_21" name="wlan1_vap3_mac_filter_21" value="<!--# echo wlan1_vap3_mac_filter_21 -->">
				<input type="hidden" id="wlan1_vap3_mac_filter_22" name="wlan1_vap3_mac_filter_22" value="<!--# echo wlan1_vap3_mac_filter_22 -->">
				<input type="hidden" id="wlan1_vap3_mac_filter_23" name="wlan1_vap3_mac_filter_23" value="<!--# echo wlan1_vap3_mac_filter_23 -->">
<div id="radioOnField" style="display: none;">
	<div class="box_tn">
		<div class="CT"><script>show_words('_wifiser_title0');</script></div>
		<table cellspacing="0" cellpadding="0" class="formarea">
		<tr>
			<td class="CL"><script>show_words('_wifiser_title1')</script></td>
			<td class="CR">
				<select id="ssidIndex" name="ssidIndex" size="1" onchange="selectMBSSIDChanged()"></select>
			</td>
		</tr>
		</table>
	</div>

<!--	AccessPolicy for mbssid 		-->
	<div class="box_tn">
		<span id="mac_filter"></span>
		<script>
		var aptable;
		var contain = ""

		for(aptable = 0; aptable < max_SSID; aptable++){
			contain += "<table style='display:none;' id=AccessPolicy_"+ aptable +" width='100%' border='0' align='center' cellpadding='0' cellspacing='0' class='formarea'>";	
			contain += "<tr><td colspan='2' class='CT'>"+get_words('_wifiser_mode22')+"</td></tr>"
			contain += "<input type=\"hidden\" id=newap_"+ aptable + "_num name=newap_"+ aptable + "_num value=0>";
			contain += "<tr><td class=\"CL\">"+get_words('_wifiser_mode23')+"</td>";
			contain += "<td class=\"CR\"><select name=apselect_"+ aptable + " id=apselect_"+aptable+" size=1 onchange=setChange(1) >";
			contain += "<option value=disable >"+get_words('_disable')+"</option>";
			contain += "<option value=list_allow >"+get_words('_wifiser_mode43')+"</option>";
			contain += "<option value=list_deny >"+get_words('_wifiser_mode24')+"</option>";
			contain += "</select> </td>";
			contain += "</tr>";	
			contain += "<tr><td class=\"CL\">"+get_words('_macaddr')+"</td>";
			contain += "<td class=\"CR\"><input name=newap_text_"+aptable+" id=newap_text_"+aptable+" size=16 maxlength=20>&nbsp;(Ex: 00:11:22:33:44:55)</td>";
			contain += "</tr>";
			contain += "</table>";
		}

		$('#mac_filter').html(contain);

		</script>
	</div>

	<div class="box_tn">
		<table cellspacing="0" cellpadding="0" class="formarea">
		<tr align="center">
			<td colspan="2" class="btn_field">
			<input name="button" type="button" class="ButtonSmall" id="button" onClick="return send_request()" value="" />
			<script>$('#button').val(get_words('_apply'));</script>
			<input name="button2" type="button" class="ButtonSmall" id="button2" onclick="page_cancel('form1', 'wireless2_security.asp');" value="" />
			<script>$('#button2').val(get_words('ES_cancel'));</script>
			</td>
		</tr>
		</table>
	</div>

	<span id="WSTable0"></span>
	<span id="WSTable1"></span>
	<span id="WSTable2"></span>
	<span id="WSTable3"></span>
</div>
</form>
			
<div id="radioOffField" class="box_tn" style="display: none;">
	<table cellspacing="0" cellpadding="0" class="formarea">
		<tr>
			<td colspan="2" align="center" class="CELL"><font color="red" id="Msg" name="Msg"><script>show_words('_wifiser_mode41');</script></font></td>
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
