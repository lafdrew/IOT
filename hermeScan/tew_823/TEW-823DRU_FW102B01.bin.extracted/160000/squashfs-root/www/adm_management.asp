<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html lang="en-US" xmlns="http://www.w3.org/1999/xhtml" xml:lang="en-US">
<head>
<title>TRENDNET | modelName | Administrator | Management</title>
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
	var submit_button_flag = 0;
	var rule_max_num = 10;
	var vs_rule_max = 24;
	var inbound_used = 3;
	var DataArray = new Array();
	var menu = new menuObject();
	var obj = new ccpObject();
	//var array_vs_enable = 		main.config_str_multi("vsRule_Enable_");
	
function decode_to_html(val)
{
	var html_val = document.createElement("textarea");
	html_val.innerHTML = val;

	return html_val.innerText;
}

function all_apply(){
	obj.set_param_url('apply.cgi');
	obj.set_ccp_act('set');
	obj.add_param_event('tools_admin');
	obj.set_param_next_page('login.asp');
	obj.add_param_arg('reboot_type', 'application+filter');
	//admin_apply();
	//device_apply();
	//ddns_apply();
	//remote_apply();
	
	var param = obj.get_param();
	totalWaitTime = 40; //second
	redirectURL = location.pathname;
	wait_page();
	jq_ajax_post(param.url, param.arg);
	
}


function admin_apply(){
	if ($('#admpass').val() != 'WDB8WvbXdH'){
		obj.add_param_arg('admin_password',urlencode($('#admpass').val()));
	}
    obj.add_param_arg('admin_username',urlencode($('#admuser_show').val()));
	obj.add_param_arg('session_timeout',urlencode($('#AuthTimeout').val()));
	//save device name
	obj.add_param_arg('lan_device_name',$('#lan_device_name').val());
	//save ddns
	obj.add_param_arg('ddns_enable',"<!--# echo ddns_enable -->");
	obj.add_param_arg('ddns_type',"<!--# echo ddns_type -->");
	obj.add_param_arg('ddns_hostname',decode_to_html("<!--# echot ddns_hostname -->"));
	obj.add_param_arg('ddns_username',decode_to_html("<!--# echot ddns_username -->"));
	obj.add_param_arg('ddns_password',decode_to_html("<!--# echot ddns_password -->"));
	//save remote
	obj.add_param_arg('remote_http_management_enable',"<!--# echo remote_http_management_enable -->");
	obj.add_param_arg('remote_http_management_port',"<!--# echo remote_http_management_port -->");
	all_apply();
}
function device_apply(){
	var c_hostname = $('#lan_device_name').val();
	if (c_hostname == "")
	{
		alert(get_words('GW_NAT_NAME_INVALID'));
		return;
	}
	if(Find_word(c_hostname,"'") || Find_word(c_hostname,'"') || Find_word(c_hostname,"/") || _isNumeric(c_hostname)){
		alert(get_words('GW_LAN_DEVICE_NAME_INVALID'));
		return;
	}
	var re = /[^A-Za-z0-9_\-]/;
	if(re.test(c_hostname)){
		alert(get_words('GW_LAN_DEVICE_NAME_INVALID'));
		return;
	}
	var data_tmp;
	for (var i = 0; i < c_hostname.length; i++){
		data_tmp = c_hostname.substring(i,i+1);
		if(data_tmp == " "){
			alert(get_words('GW_LAN_DEVICE_NAME_INVALID'));
			return;
		}
	}
	
	obj.add_param_arg('lan_device_name',$('#lan_device_name').val());
	
	//save session timeout
	obj.add_param_arg('session_timeout',"<!--# echo session_timeout -->");
	//save ddns
	obj.add_param_arg('ddns_enable',"<!--# echo ddns_enable -->");
	obj.add_param_arg('ddns_type',"<!--# echo ddns_type -->");
	obj.add_param_arg('ddns_hostname',decode_to_html("<!--# echot ddns_hostname -->"));
	obj.add_param_arg('ddns_username',decode_to_html("<!--# echot ddns_username -->"));
	obj.add_param_arg('ddns_password',decode_to_html("<!--# echot ddns_password -->"));
	//save remote
	obj.add_param_arg('remote_http_management_enable',"<!--# echo remote_http_management_enable -->");
	obj.add_param_arg('remote_http_management_port',"<!--# echo remote_http_management_port -->");
       all_apply();
}
function check_url_value()
{
	if($('#DeviceURL').val()=='') {
		alert(get_words('_specify_url'));
		return false;
	}
	if(check_dev_name($('#DeviceURL').val()) == false){
		alert(get_words('GW_LAN_DEVICE_NAME_INVALID'));
		return false;
	}
	return true;
}
function url_apply(){
	if(!check_url_value())
		return;
	var obj = new ccpObject();
	obj.set_param_url('get_set.ccp');
	obj.set_ccp_act('set');
	obj.add_param_event('CCP_SUB_WEBPAGE_APPLY');
	obj.set_param_next_page('adm_management.asp');
	obj.add_param_arg('reboot_type', 'application+filter');
	obj.add_param_arg('lanHostCfg_DeviceName_','1.1.1.0',$('#DeviceURL').val());
	
	var param = obj.get_param();
	
	totalWaitTime = 10; //second
	redirectURL = location.pathname;
	wait_page();
	jq_ajax_post(param.url, param.arg);
}
function check_ddns_value(){
	if ($('#DDNSProvider').val()=='')
		return true;
	
	// host name cannot be empty
	if (get_by_id('DDNS').value == '') {
		alert(get_words('GW_DYNDNS_HOST_NAME_INVALID'));
		return false;
	}
	
	// user name cannot be empty
	if (get_by_id('ddns_Account').value == '') {
		alert(get_words('GW_DYNDNS_USER_NAME_INVALID'));
		return false;
	}
	
	// password cannot be empty
	if (get_by_id('ddns_Password').value == '') {
		alert(get_words('GW_DYNDNS_PASSWORD_INVALID'));
		return false;
	}
	/*
	** Date:	2013-03-19
	** Author:	Moa Chung
	** Reason:	Administrator → Management：DDNS password should not be space.
	** Note:	TEW-810DR pre-test no.101
	**/
	if (isContainSpace(get_by_id('ddns_Password').value)) {
		alert(get_words('_TAG00840'));
		return false;
	}
	return true;
}
function ddns_apply(){
	if(check_ddns_value()){
		if($('#DDNSProvider').val()==''){
			obj.add_param_arg('ddns_enable',0);
			obj.add_param_arg('ddns_type','');
			obj.add_param_arg('ddns_hostname','');
			obj.add_param_arg('ddns_username','');
			obj.add_param_arg('ddns_password','');
		}
		else{
			obj.add_param_arg('ddns_enable',1);
			obj.add_param_arg('ddns_type',$('#DDNSProvider').val());
			obj.add_param_arg('ddns_hostname',$('#DDNS').val());
			obj.add_param_arg('ddns_username',$('#ddns_Account').val());
			if($('#ddns_Password').val()!='WDB8WvbXdH')
				obj.add_param_arg('ddns_password',$('#ddns_Password').val());
		}
			//save session timeout
			obj.add_param_arg('session_timeout',"<!--# echo session_timeout -->");
			//save device name
			obj.add_param_arg('lan_device_name',$('#lan_device_name').val());
			//save remote
			obj.add_param_arg('remote_http_management_enable',"<!--# echo remote_http_management_enable -->");
			obj.add_param_arg('remote_http_management_port',"<!--# echo remote_http_management_port -->");
			
            obj.add_param_arg('reboot_type','application+filter');	//lan need reboot ? for test issue? jacky add for issue 63
             all_apply();
	}
}
function check_remote_value(){
	var remote_port = $('#portNumber').val();
	var tcp_timeline = null;
	var udp_timeline = null;
	var remote_port_msg = replace_msg(check_num_msg, get_words('ta_RAP'), 1, 65535);
	var remote_port_obj = new varible_obj(remote_port, remote_port_msg, 1, 65535, false);
	
	if($('#remoteManagementEnabled').val()=='1')
	{
		var tcp_ports = get_by_id("portNumber").value;
		tcp_timeline = add_into_timeline(tcp_timeline, tcp_ports, null);
	}
	//check if virtual server conflict or not
	try {
		for (var i=0; i<vs_rule_max; i++) 
		{
			if (array_vs_enable[i] == '0')
				continue;
			
			var vs_ports = array_vs_ports[i].split(',');
			for (var j=0; j<vs_ports.length; j++) 
			{
				var range = vs_ports[j].split('-');
				if (array_vs_proto[i] == '0') 
				{
					tcp_timeline = add_into_timeline(tcp_timeline, range[0], range[1]);
					if (check_timeline(tcp_timeline) == false) 
					{
						//alert("TCP 通訊埠[" + get_by_id("public_port" + i).value+ "]和遠端管理的通訊埠衝突");	//ag_conflict4
						//alert(addstr(get_words('ag_conflict4'), 'Virtual Server TCP', get_by_id("remote_http_management_port").value));
						alert(get_words('vs_http_port'));
						return false;
					}
				} 
				else if (array_vs_proto[i] == '1') 
				{
					udp_timeline = add_into_timeline(udp_timeline, range[0], range[1]);
				} 
				else 
				{
					tcp_timeline = add_into_timeline(tcp_timeline, range[0], range[1]);
					udp_timeline = add_into_timeline(udp_timeline, range[0], range[1]);
				}
			}
		}
	}
	catch (e) 
	{
		alert('error occur in adding port trigger ports into timeline');
	}
	//check if porf forward conflict or not
	try 
	{
		for (var i=0; i<array_pf_enable.length; i++) 
		{
			if (array_pf_enable[i] == '0')
				continue;
			
			var pf_tcp_ports = array_pf_ports_tcp[i].split(',');
			for (var j=0; j<pf_tcp_ports.length; j++) 
			{
				var range = pf_tcp_ports[j].split('-');
				tcp_timeline = add_into_timeline(tcp_timeline, range[0], range[1]);
				if (check_timeline(tcp_timeline) == false) 
				{
					//alert("TCP 通訊埠[" + get_by_id("public_port" + i).value+ "]和遠端管理的通訊埠衝突");	//ag_conflict4
					alert(addstr(get_words('ag_conflict4'), 'Port forwarding TCP', get_by_id("remote_http_management_port").value));
					return false;
				}
			}
			var pf_udp_ports = array_pf_ports_udp[i].split(',');
			for (var j=0; j<pf_udp_ports.length; j++) 
			{
				var range = pf_udp_ports[j].split('-');
				udp_timeline = add_into_timeline(udp_timeline, range[0], range[1]);
			}
		}
	} 
	catch (e) 
	{
		alert('error occur in adding port forward ports into timeline');
	}
	//check if porf trigger conflict or not
	try {
		for (var i=0; i<array_pt_enable.length; i++) {
			if (array_pt_enable[i] == '0')
				continue;
			var pt_ports = array_pt_ports[i].split(',');
			for (var j=0; j<pt_ports.length; j++) {
				var range = pt_ports[j].split('-');
				if (array_pt_proto[i] == '0') {
					tcp_timeline = add_into_timeline(tcp_timeline, range[0], range[1]);
					if (check_timeline(tcp_timeline) == false) 
					{
						//alert("TCP 通訊埠[" + get_by_id("public_port" + i).value+ "]和遠端管理的通訊埠衝突");	//ag_conflict4
						alert(addstr(get_words('ag_conflict4'), 'Application Rule Firewall', get_by_id("remote_http_management_port").value));
						return false;
					}
				} else if (array_pt_proto[i] == '1') {
					udp_timeline = add_into_timeline(udp_timeline, range[0], range[1]);
				} else {
					tcp_timeline = add_into_timeline(tcp_timeline, range[0], range[1]);
					udp_timeline = add_into_timeline(udp_timeline, range[0], range[1]);
				}
			}
		}
	} catch (e) {
		alert('error occur in adding port trigger ports into timeline');
	}
	
	if($('#remoteManagementEnabled').val()=='1')
	{
		if (!check_varible(remote_port_obj))
			return false;
	}
	
	return true;
}
function remote_apply(){
	//if(check_remote_value()){
	//	obj.add_param_arg('remote_http_management_enable',$('#remoteManagementEnabled').val());
	//	obj.add_param_arg('remote_http_management_port',$('#portNumber').val());
        //      obj.add_param_arg('reboot_type','shutdown');	
	//}
       var remote_port = $('#portNumber').val();
	var remote_port_msg = replace_msg(check_num_msg, get_words('ta_RAP'), 1, 65535);
	var remote_port_obj = new varible_obj(remote_port, remote_port_msg, 1, 65535, false);
	if($('#remoteManagementEnabled').val()=='1')
	{
		if (!check_varible(remote_port_obj)){
			return ;
                    }else{
			obj.add_param_arg('remote_http_management_enable',"1");
			obj.add_param_arg('remote_http_management_port',$('#portNumber').val());			
            obj.add_param_arg('reboot_type','application+filter');	
         }
	}else{
	 	obj.add_param_arg('remote_http_management_enable',"0");
			obj.add_param_arg('remote_http_management_port',$('#portNumber').val());
	}
			//save session timeout
			obj.add_param_arg('session_timeout',"<!--# echo session_timeout -->");
			//save device name
			obj.add_param_arg('lan_device_name',$('#lan_device_name').val());
			//save ddns
			obj.add_param_arg('ddns_enable',"<!--# echo ddns_enable -->");
			obj.add_param_arg('ddns_type',"<!--# echo ddns_type -->");
			obj.add_param_arg('ddns_hostname',decode_to_html("<!--# echot ddns_hostname -->"));
			obj.add_param_arg('ddns_username',decode_to_html("<!--# echot ddns_username -->"));
			obj.add_param_arg('ddns_password',decode_to_html("<!--# echot ddns_password -->"));
    all_apply();
}
function setValueAccount(){
	var val_uname = checksessionStorage();
	$('#admuser_show').val(val_uname);
}
function setValueIdleTimeout(){
	var val_idle = "<!--# echo session_timeout -->";
	$('#AuthTimeout').val(val_idle);
}
function setEventIdleTimeout(){
	$('#AuthTimeout').blur(function(){
		var dec = parseInt($(this).val());
		if(isNaN(dec))
			dec = adminCfg.idleTime;
		else if(dec<120)
			dec = 120;
		else if (dec>3600)
			dec = 3600;
		$(this).val(dec);
	});
}
function setValueDeviceName(){
	var val_sysname = "<!--# echo lan_device_name -->";
	$('#lan_device_name').val(val_sysname);
}

function setValueDevicURL(){
	var val_devurl = adminCfg.devURL;
	$('#DeviceURL').val(val_devurl);
}

function setValueDynamicDNSProvider(){
	var sel_ddnsenable = "<!--# echo ddns_enable -->";
	
	var sel_ddnsserver = "<!--# echo ddns_type -->";
	if(sel_ddnsenable==''){
		$('#DDNSProvider').val('');
	}
	else{
		$('#DDNSProvider').val(sel_ddnsserver);
	}
}
function setEventDynamicDNSProvider(){
	var func = function(){
		if($('#DDNSProvider').val()!=''){
			$('#DDNS').removeAttr('disabled');
			$('#ddns_Account').removeAttr('disabled');
			$('#ddns_Password').removeAttr('disabled');
		}
		else{
			$('#DDNS').attr('disabled', 'disabled');
			$('#ddns_Account').attr('disabled', 'disabled');
			$('#ddns_Password').attr('disabled', 'disabled');
		}
	};
	func();
	$('#DDNSProvider').change(func);
}
function setValueDDNSHostName(){
	var val_sysname = decode_to_html("<!--# echot ddns_hostname -->");
	$('#DDNS').val(val_sysname);
}
function setValueDDNSAccount(){
	var val_uname = decode_to_html("<!--# echot ddns_username -->");
	$('#ddns_Account').val(val_uname);
}
function setValueRemoteControl(){
	var sel_rme = "<!--# echo remote_http_management_enable -->";
	$('#remoteManagementEnabled').val(sel_rme);
}
function setEventRemoteControl(){
	var func = function(){
		var sel_rme = $('#remoteManagementEnabled').val();
		if(sel_rme=='0'){
			$('#portNumber').attr('disabled', 'disabled');
		}
		else{
			$('#portNumber').removeAttr('disabled');
		}
	};
	func();
	$('#remoteManagementEnabled').change(func);
}
function setValueRemotePort(){
	var sel_rmPort = "<!--# echo remote_http_management_port -->";
	$('#portNumber').val(sel_rmPort);
}
$(function(){
	//Administrator Settings
	setValueAccount();
	setValueIdleTimeout();
	setEventIdleTimeout()
	
	//Device Name Settings
	setValueDeviceName();
	
	//Device URL Settings
	//===not suppot
	//setValueDevicURL();
	//===
	
	//DDNS Settings
	setValueDynamicDNSProvider();
	setEventDynamicDNSProvider();
	setValueDDNSHostName();
	setValueDDNSAccount();
	
	//Remote Management
	setValueRemoteControl();
	setEventRemoteControl();
	setValueRemotePort();
	
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
			<td align="right" valign="middle" class="description" style="width:600px;line-height:1.5em;">
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
				<script>document.write(menu.build_structure(1,1,6))</script>
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
								<div class="headerbg" id="manTitle">
								<script>show_words('_system_management');</script>
								</div>
								<div class="hr"></div>
								<div class="section_content_border">
								<div class="header_desc" id="manIntroduction">
									<script>show_words('_SYS_MANGER_DESC');</script>
									<p></p>
								</div>

				<input type="hidden" id="ddns_password" name="ddns_password" value="<!--# echo ddns_password -->">
				<input type="hidden" id="ddns_dyndns_kinds" name="ddns_dyndns_kinds" value="<!--# echo ddns_dyndns_kinds -->">
				<input type="hidden" id="ddns_type" name="ddns_type" value="<!--# echo ddns_type -->">


<div class="box_tn">
<div class="CT"><script>show_words('ta_AdmSt');</script></div>
<!-- ----------------- Adm Settings ----------------- -->

<table cellspacing="0" cellpadding="0" class="formarea">
	<tr>
		<td class="CL"><script>show_words('_help_txt208');</script></td>
		<td class="CR">
		<input type="hidden" id="admuser" name="admuser" size="16" maxlength="16" value="admin" />
		<input type="text" id="admuser_show" size="16" maxlength="16" value="" />
		</td>
	</tr>
	<tr>
		<td class="CL"><script>show_words('_password');</script></td>
		<td class="CR"><input type="password" id="admpass" name="admpass" size="16" maxlength="16" value="WDB8WvbXdH" /> (<script>document.write(get_words('_max_length_characters').replace('%s','16'));</script>)</td>
	</tr>
	<tr>
		<td class="CL"><script>show_words('_wifiser_mode21');</script></td>
		<td class="CR"><input type="text" id="AuthTimeout" name="AuthTimeout" size="4" maxlength="4" value="" onkeyup="value=value.replace(/[^0-9]/g,'')"/> (120-3600 <script>show_words('_seconds');</script>)</td>
	</tr>
</table>
<table cellspacing="0" cellpadding="0" class="formarea">
	<tr align="center">
		<td colspan="2" class="btn_field">
			<input type="button" class="button_submit" id="admin_apply" value="Apply" onclick="admin_apply();" />
			<script>$('#admin_apply').val(get_words('_apply'));</script>
			<input type="reset" class="button_submit" id="admin_cancel" value="Cancel" onclick="window.location.reload()" />
			<script>$('#admin_cancel').val(get_words('_cancel'));</script>
		</td>
	</tr>
</table>
</div>

<div class="box_tn" id="box_deviceUrlSettings" style="display:none">
<div class="CT"><script>show_words('_device_url_settings');</script></div>
<table cellspacing="0" cellpadding="0" class="formarea" border="0">
	<tr>
		<td class="CL"><script>show_words('_device_url');</script></td>
		<td class="CR"><input type="text" name="DeviceURL" id="DeviceURL" size="32" maxlength="64" value="" /></td>
	</tr>
</table>
<table cellspacing="0" cellpadding="0" class="formarea">
	<tr align="center">
		<td colspan="2" class="btn_field">
			<input type="submit" class="button_submit" id="url_apply" value="Apply" onclick="url_apply();" />
			<script>$('#url_apply').val(get_words('_apply'));</script>
			<input type="reset" class="button_submit" id="url_cancel" value="Cancel" onclick="window.location.reload()" />
			<script>$('#url_cancel').val(get_words('_cancel'));</script>
		</td>
	</tr>
</table>
</div>

<div class="box_tn">
<div class="CT"><script>show_words('_device_name_settings');</script></div>
<table cellspacing="0" cellpadding="0" class="formarea">
	<tr>
		<td class="CL"><script>show_words('DEVICE_NAME');</script></td>
		<td class="CR"><input type="text" name="lan_device_name" id="lan_device_name" size="16" maxlength="16" value="<!--# echo lan_device_name -->" /></td>
	</tr>
</table>
<table cellspacing="0" cellpadding="0" class="formarea">
	<tr align="center">
		<td colspan="2" class="btn_field">
			<input type="button" class="button_submit" id="device_apply" value="Apply" onclick="device_apply();" />
			<script>$('#device_apply').val(get_words('_apply'));</script>
			<input type="reset" class="button_submit" id="device_cancel" value="Cancel" onclick="window.location.reload()" />
			<script>$('#device_cancel').val(get_words('_cancel'));</script>
		</td>
	</tr>
</table>
</div>

<div class="box_tn">
<div class="CT"><script>show_words('_ddns_settings');</script></div>
<table cellspacing="0" cellpadding="0" class="formarea">
	<tr>
		<td class="CL"><script>show_words('_help_txt205');</script></td>
		<td class="CR">
			<select id="DDNSProvider">
			<option value=""><script>show_words('_none');</script></option>
			<option value="DynDns.org"> Dyndns.com </option>
			<option value="EasyDns.com"> EasyDns.com </option>
			<option value="dynupdate.no-ip.com"> www.no-ip.com </option>
			</select>
		</td>
	</tr>
	<tr>
		<td class="CL"><script>show_words('_hostname');</script></td>
		<td class="CR"><input size="32" id="DDNS" value="" type="text" disabled="" /> </td>
	</tr>
	<tr>
		<td class="CL"><script>show_words('_help_txt208');</script></td>
		<td class="CR"><input size="16" id="ddns_Account" value="" type="text" disabled="" /> </td>
	</tr>
	<tr>
		<td class="CL"><script>show_words('_password');</script></td>
		<td class="CR"><input size="16" id="ddns_Password" value="WDB8WvbXdH" type="password" disabled="" /> </td>
	</tr>
</table>

<table cellspacing="0" cellpadding="0" class="formarea">
	<tr align="center">
		<td colspan="2" class="btn_field">
			<input type="button" class="button_submit" id="ddns_apply" value="Apply" onclick="ddns_apply();" />
			<script>$('#ddns_apply').val(get_words('_apply'));</script>
			<input type="reset" class="button_submit" id=ddns_cancel value="Cancel" onclick="window.location.reload()" />
			<script>$('#ddns_cancel').val(get_words('_cancel'));</script>
		</td>
	</tr>
</table>
</div>

<div class="box_tn">
<div class="CT"><script>show_words('_remote_management');</script></div>
<table cellspacing="0" cellpadding="0" class="formarea">
	<tr>
		<td class="CL" id="sysfwRemoteManagementHead">
			<script>show_words('_remote_control_via_wan');</script>
		</td>
		<td class="CR">
			<select id="remoteManagementEnabled" size="1">
			<option value="0"><script>show_words('_disable');</script></option>
			<option value="1"><script>show_words('_enable');</script></option>
			</select>
		</td>
	</tr>
	<tr>
		<td class="CL"><script>show_words('_remote_port');</script></td>
		<td class="CR"><input type="text" name="portNumber" id="portNumber" disabled="" /></td>
	</tr>
</table>
<table cellspacing="0" cellpadding="0" class="formarea">
	<tr align="center">
		<td colspan="2" class="btn_field">
			<input type="button" class="button_submit" id="remote_apply" value="Apply" onclick="remote_apply();" />
			<script>$('#remote_apply').val(get_words('_apply'));</script>
			<input type="reset" class="button_submit" id="remote_reset" value="Reset" onclick="window.location.reload()" />
			<script>$('#remote_reset').val(get_words('_reset'));</script>
		</td>
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
