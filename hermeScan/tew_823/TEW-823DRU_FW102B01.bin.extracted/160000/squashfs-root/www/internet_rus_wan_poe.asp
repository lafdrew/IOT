<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html lang="en-US" xmlns="http://www.w3.org/1999/xhtml" xml:lang="en-US">
<head>
<title>TRENDNET | modelName | Network | PPPoE</title>
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
	var submit_button_flag = 0;	
    
    function opendns_enable_selector(value)
    {
        if (value == true) {
            get_by_id("wan_specify_dns").value = "1";
            get_by_id("wan_primary_dns").value = "204.194.232.200";
            get_by_id("wan_secondary_dns").value = "204.194.234.200";
            get_by_id("wan_primary_dns").disabled = true;
            get_by_id("wan_secondary_dns").disabled = true;
        }
        else {
            get_by_id("wan_specify_dns").value ="0";
            get_by_id("wan_primary_dns").disabled = false;
            get_by_id("wan_secondary_dns").disabled = false;
            get_by_id("wan_primary_dns").value = "0.0.0.0";
            get_by_id("wan_secondary_dns").value =  "0.0.0.0";
        }
    }

function onPageLoad(){
	//OPENDNS
	set_checked(get_by_id("opendns_enable").value, get_by_id("opendns_enable_sel"));
	if(get_by_id("opendns_enable_sel").checked)
		opendns_enable_selector(get_by_id("opendns_enable_sel").checked);
	//OPENDNS

   //show_hnat();
   //show_AdvDns();
	set_selectIndex("<!--# echo wan_pppoe_dynamic_00 -->", get_by_id("wan_pppoe_dynamic_00"));
	set_selectIndex("<!--# echo wan_pppoe_connect_mode_00 -->", get_by_id("wan_pppoe_connect_mode_00"));
        if( "<!--# echo wan_rus_pppoe_dynamic -->" ){
                set_selectIndex(1 , get_by_id("wan_rus_pppoe_dynamic")); //select Dynamic
        }else{
                set_selectIndex(0 , get_by_id("wan_rus_pppoe_dynamic")); ////select Static
        }
              
	if (get_by_id("wan_mac").value === "<!--# echo sys_wan_mac -->") {
                get_by_id("wan_mac").value = "";
        }

	var login_who= checksessionStorage();
	if(login_who== "user"){
		DisableEnableForm(document.form1,true);
	}else{
		check_connectmode();
		disable_poe_ip();
		disable_rus_poe_ip();
	}
	set_form_default_values("form1");	
}

 function check_connectmode()
    {   
        var conn_mode = get_by_id("wan_pppoe_connect_mode_00").selectedIndex;
        var idle_time = get_by_id("wan_pppoe_max_idle_time_00");
         if(conn_mode != "1"){
          idle_time.disabled = true;
         }else{
          idle_time.disabled = false;
         }
    }

function clone_mac_action(){
		get_by_id("mac_clone_addr").value = get_by_id("mac_clone_addr2").value;
        get_by_id("wan_mac").value = get_by_id("mac_clone_addr").value;
}

function disable_poe_ip(){
		var fixIP = get_by_id("wan_pppoe_dynamic_00").selectedIndex;
					  
	  	if (fixIP=="0"){ //dynamic
	    	get_by_id("wan_pppoe_ipaddr_00").disabled = true;
	    	get_by_id("show_poeip").style.display = "none";
	  	}else{
	    	get_by_id("wan_pppoe_ipaddr_00").disabled = false;
	    	get_by_id("show_poeip").style.display = "";
	    }
	  	
	}

function disable_rus_poe_ip(){
        var fixIP = get_by_name("wan_rus_pppoe_dynamic");
        var is_disabled;

        if (fixIP[0].value == 0){
                is_disabled = true;
        }else{
                is_disabled = false;
        }

        get_by_id("rus_wan_pppoe_ipaddr_00").disabled = is_disabled;
        get_by_id("rus_wan_pppoe_netmask").disabled = is_disabled;
        get_by_id("rus_wan_pppoe_gateway").disabled = is_disabled;
        //get_by_id("wan_pppoe_russia_primary_dns").disabled = is_disabled;
        //get_by_id("wan_pppoe_russia_secondary_dns").disabled = is_disabled;
}
		
    function set_poe_dynamic(type){
    	var fixIP = get_by_name("wan_pppoe_dynamic_00");
        if (type == 0){
            fixIP[0].checked = true;
            get_by_id("wan_pppoe_ipaddr_00").value = "0.0.0.0";	           
        }
    }
    
    
	function send_pppoe_request()
	{
    	get_by_id("asp_temp_52").value = get_by_id("wan_proto").value;
    	var is_modify = is_form_modified("form1");
    	if (!is_modify && !confirm(get_words('_ask_nochange'))) {
			return false;
		}

		connect_mode = $('#wan_pppoe_connect_mode_00').val();

		//add by Vic for check hw nat enable
		if(!check_hw_nat_enable())
			return false;
			
 		var fixIP = get_by_id("wan_pppoe_dynamic_00").selectedIndex;
    	var ip = get_by_id("wan_pppoe_ipaddr_00").value;
    	var dns1 = get_by_id("wan_primary_dns").value;
    	var dns2 = get_by_id("wan_secondary_dns").value;
    	var idle = get_by_id("wan_pppoe_max_idle_time_00").value;	    	
        var mtu = get_by_id("wan_pppoe_mtu").value;
        var user_name = get_by_id("wan_pppoe_username_00").value;
        
        var ip_addr_msg = replace_msg(all_ip_addr_msg,get_words('_ipaddr'));
		var primary_dns_msg = replace_msg(all_ip_addr_msg,get_words('lan_dns'));
		var second_dns_msg = replace_msg(all_ip_addr_msg,get_words('lan_dns2'));
        var max_idle_msg = replace_msg(check_num_msg, get_words('usb3g_max_idle_time'), 0, 9999);
        var mtu_msg = replace_msg(check_num_msg, get_words('bwn_MTU'), 1300, 1492);
                
        var temp_ip = new addr_obj(ip.split("."), ip_addr_msg, false, false);
        var temp_dns1 = new addr_obj(dns1.split("."), primary_dns_msg, true, false);
	    var temp_dns2 = new addr_obj(dns2.split("."), second_dns_msg, true, false);
        var temp_idle = new varible_obj(idle, max_idle_msg, 0, 9999, false);
        var temp_mtu = new varible_obj(mtu, mtu_msg, 1300, 1492, false);
        
        var rus_fixIP = get_by_name("wan_rus_pppoe_dynamic");
	var rus_ip = get_by_id("rus_wan_pppoe_ipaddr_00").value;
	var rus_mask = get_by_id("rus_wan_pppoe_netmask").value;
	var rus_gateway = get_by_id("rus_wan_pppoe_gateway").value;
//	var rus_dns1 = get_by_id("wan_pppoe_russia_primary_dns").value;
//	var rus_dns2 = get_by_id("wan_pppoe_russia_secondary_dns").value;

        var gateway_msg = replace_msg(all_ip_addr_msg,get_words('wwa_gw'));

	var temp_rus_ip = new addr_obj(rus_ip.split("."), ip_addr_msg, false, false);
	var temp_rus_mask = new addr_obj(rus_mask.split("."), subnet_mask_msg, false, false);
	var temp_rus_gateway = new addr_obj(rus_gateway.split("."), gateway_msg, false, false);
//	var temp_rus_dns1 = new addr_obj(rus_dns1.split("."), primary_dns_msg, true, false);
//	var temp_rus_dns2 = new addr_obj(rus_dns2.split("."), second_dns_msg, true, false);
        
		if (fixIP=="1"){
        	if (!check_address(temp_ip)){
        		return false;
        	}
        }
		var ipv6_wan_proto = "<!--# echo ipv6_wan_proto -->";
		var ipv6_6rd_dhcp = "<!--# echo ipv6_6rd_dhcp -->";

		if (ipv6_wan_proto == "ipv6_6rd" && ipv6_6rd_dhcp == "1"){
			alert(IPV6_6rd_v6wan);
			return false;
		}
        
    	if (dns2 != "" && dns2 != "0.0.0.0"){
    		if (!check_address(temp_dns2)){
    			return false;
    		}
    	}
    	
    	 if(user_name == ""){
			alert(get_words('GW_WAN_PPPOE_USERNAME_INVALID'));
    		return false;
	     }
    	
	     if (get_by_id("poe_pass_s").value == "" || get_by_id("poe_pass_v").value == ""){
		 	alert(get_words('GW_WAN_PPPOE_PASSWORD_INVALID'));//
			return false;
		}
		
    	if (!check_pwd("poe_pass_s", "poe_pass_v")){
       		return false;
       	}
       	
       	if (!check_varible(temp_idle)){
    		return false;
    	}
    	
    	if (!check_varible(temp_mtu)){
    		return false;
    	}
    	
    	/*
		 * Validate MAC and activate cloning if necessary
		 */		
		 
		  /* Mac should not be 00:00:00:00:00:00 or FF:FF:FF:FF:FF:FF*/
                if (!isInvalidMac(get_by_id("wan_mac").value)) {
                        alert(_clone_error);
                        return false;
                }		
	//	if($('#macCloneEnbl').val()=='1'){
			var clonemac = get_by_id("wan_mac").value;
			if (!check_mac_00(clonemac)){
				alert(get_words('KR3'));
				return false;
			} 
			
			var mac = trim_string(get_by_id("wan_mac").value);
			if(!is_mac_valid(mac, true)) {
				alert (get_words('KR3')+":" + mac + ".");
				return false;
			}else{
				get_by_id("wan_mac").value = mac;
			}
	//	}
		
		
        if (dns1 != "" && dns1 != "0.0.0.0"){
    		if (!check_address(temp_dns1)){
    			return false;
    		}
    	}
    	//OPENDNS
			get_by_id("opendns_enable").value = get_checked_value(get_by_id("opendns_enable_sel"));
			if(get_by_id("opendns_enable").value=="1"){
			get_by_id("dns_relay").value = "1";
			get_by_id("wan_primary_dns").disabled = false;
			get_by_id("wan_secondary_dns").disabled = false;
		}
		//OPENDNS
		if((get_by_id("wan_primary_dns").value =="" || get_by_id("wan_primary_dns").value =="0.0.0.0")&& ( get_by_id("wan_secondary_dns").value =="" || get_by_id("wan_secondary_dns").value =="0.0.0.0")){
			get_by_id("wan_specify_dns").value = 0;
		}else{
			get_by_id("wan_specify_dns").value = 1;
		}
		get_by_id("hnat_enable").value = get_checked_value(get_by_id("hnatEnable"));
		
        if (rus_fixIP[0].value == 1){
                if (!check_address(temp_rus_ip)){
                        return false;
                }
                if (!check_lan_setting(temp_rus_ip, temp_rus_mask, temp_rus_gateway, "PPPoE")){
                        return false;
                }
//                if (rus_dns1 != "" && rus_dns1 != "0.0.0.0"){		
//                        if (!check_address(temp_rus_dns1)){
//                              return false;
//                        }
//                }
//                if (rus_dns2 != "" && rus_dns2 != "0.0.0.0"){
//                        if (!check_address(temp_rus_dns2)){
//                                return false;
//                        }
//                }
//                get_by_id("wan_specify_dns").value = 1;
//        }else{
//                get_by_id("wan_specify_dns").value = 0;
        }
		
		if(submit_button_flag == 0){
			var obj = new ccpObject();
			obj.add_param_arg('wan_pppoe_username_00',get_by_id("wan_pppoe_username_00").value);
			if(get_by_id("poe_pass_s").value !="WDB8WvbXdH"){
				obj.add_param_arg('wan_pppoe_password_00',get_by_id("poe_pass_s").value);
			}
			obj.add_param_arg('wan_pppoe_russia_primary_dns',get_by_id("wan_primary_dns").value);
			obj.add_param_arg('wan_pppoe_russia_secondary_dns',get_by_id("wan_secondary_dns").value);
			obj.add_param_arg('wan_pppoe_max_idle_time_00',get_by_id("wan_pppoe_max_idle_time_00").value);

			obj.add_param_arg('wan_pppoe_connect_mode_00',get_by_id("wan_pppoe_connect_mode_00").value);
			obj.add_param_arg('wan_pppoe_dynamic_00',get_by_id("wan_pppoe_dynamic_00").value);
			obj.add_param_arg('wan_pppoe_ipaddr_00',get_by_id("wan_pppoe_ipaddr_00").value);
			obj.add_param_arg('opendns_enable',get_checked_value(get_by_id("opendns_enable_sel")));
			obj.add_param_arg('hnat_enable',get_checked_value(get_by_id("hnatEnable")));
			obj.add_param_arg('wan_pppoe_mtu',mtu);
			obj.add_param_arg('wan_proto', 'pppoe');
			obj.add_param_arg('wan_mac',get_by_id("wan_mac").value);
			obj.add_param_arg('wan_specify_dns',get_by_id("wan_specify_dns").value);
			if (rus_fixIP[0].value == 1){
			        obj.add_param_arg('wan_pppoe_russia_dynamic',0);
			}else{
			        obj.add_param_arg('wan_pppoe_russia_dynamic',1);
			}
                        obj.add_param_arg('wan_pppoe_russia_ipaddr',get_by_id("rus_wan_pppoe_ipaddr_00").value);
                        obj.add_param_arg('wan_pppoe_russia_netmask',get_by_id("rus_wan_pppoe_netmask").value);
                        obj.add_param_arg('wan_pppoe_russia_gateway',get_by_id("rus_wan_pppoe_gateway").value);

                        obj.add_param_arg('wan_pppoe_russia_enable',1);
                        obj.add_param_arg('wan_pptp_russia_enable',0);
                        obj.add_param_arg('wan_l2tp_russia_enable',0);

			obj.add_param_arg('reboot_type', 'wan');

			obj.set_param_url('apply.cgi');
			obj.set_ccp_act('set');
			obj.add_param_event('wan_rus_poe');
			obj.set_param_next_page('internet_rus_wan_poe.asp');

			var param = obj.get_param();			
			totalWaitTime = 25; //second
			redirectURL = location.pathname;
			wait_page();
			jq_ajax_post(param.url, param.arg);

			submit_button_flag = 1;
			return true;
		}else{
			return false;
		}
	}
	
	function reload_page()
	{
		if (is_form_modified("form1") && confirm (get_words('up_fm_dc_1'))) {
			onPageLoad();
		}
	}
	
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
				<script>document.write(menu.build_structure(1,1,1))</script>
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
								<div class="headerbg" id="setmanTitle">
								<script>show_words('_wan_setting_l');</script>
								</div>
								<div class="hr"></div>
								<div class="section_content_border">
								<div class="header_desc" id="wanIntroduction">
									<script>show_words('_DHCP_DESC');</script>
									<p></p>
								</div>
			<form id="form1" name="form1" method="post" action="apply.cgi">
				<input type="hidden" id="mac_clone_addr" name="mac_clone_addr" value="<!--# echo mac_clone_addr -->">
				<input type="hidden" id="mac_clone_addr2" name="mac_clone_addr2" value="<!--# exec cgi /bin/clone mac_clone_addr -->">
                <input type="hidden" id="wan_specify_dns" name="wan_specify_dns" value="<!--# echo wan_specify_dns -->">  
				<input type="hidden" id="wan_pppoe_password_00" name="wan_pppoe_password_00" value="<!--# echo wan_pppoe_password_00 -->">
				<input type="hidden" id="asp_temp_51" name="asp_temp_51" value="<!--# echo asp_temp_51 -->">
				<input type="hidden" id="asp_temp_52" name="asp_temp_52" value="<!--# echo wan_proto -->">
				<input type="hidden" id="usb_type" name="usb_type" value="<!--# echo usb_type -->"> 
			    	<input type="hidden" id="from_usb3g" name="from_usb3g" value="<!--# echo asp_temp_72 -->"> 
				<input type="hidden" id="ipv6_pppoe_share" name="ipv6_pppoe_share" value="<!--# echo ipv6_pppoe_share -->">
			
<div class="box_tn">
	<div class="CT"><script>show_words('_wan_conn_type');</script></div>
	<table cellspacing="0" cellpadding="0" class="formarea">
		<tr>
			<td class="CL"><script>show_words('_contype');</script></td>
			<td class="CR">
				<select name="wan_proto" id="wan_proto" onChange="change_wan()">
					<option value="static">STATIC</option>
					<option value="dhcpc">DHCP</option>
					<option value="pppoe">PPPoE</option>
					<option value="l2tp">L2TP</option>
					<option value="pptp">PPTP</option>
					<option value="rus_pppoe"  selected>Russia PPPoE</option>
					<option value="rus_l2tp">Russia L2TP</option>
					<option value="rus_pptp">Russia PPTP</option>
					<!-- <option value="10"><script>show_words('IPV6_TEXT140')</script></option> -->
					<!--option value="bigpond">BigPond (Australia)</option-->
				</select>
			</td>
		</tr>
	</table>
</div>

<div id="pppoe" class="box_tn" style="display: block;">
	<div id="wPppoeMode" class="CT"><script>show_words('_net_ipv6_08');</script></div>
	<table cellpadding="0" cellspacing="0" class="formarea">
		<tr id="show_AdvDns" style="display:none">
			<input type="hidden" id="opendns_enable" name="opendns_enable" value="<!--# echo opendns_enable -->">
			<input type="hidden" id="dns_relay" name="dns_relay" value="<!--# echo dns_relay -->">
		<td class="CL"><script>show_words('_en_AdvDns')</script></td>
		<td class="CR">
			<input type="checkbox" id="opendns_enable_sel" name="opendns_enable_sel" value="1" onclick="opendns_enable_selector(this.checked);" />
		</td>
		</tr>
		<tr id="show_hnat" style="display:none">
		<td class="CL"><script>show_words('HW_NAT_enable')</script></td>
		<td class="CR">
			<input type="checkbox" id="hnatEnable" name="hnatEnable" value="1" />
			<input type="hidden" id="hnat_enable" name="hnat_enable" value="<!--# echo hnat_enable -->">
		</td>
		</tr>
	<div id="show_poe">
		<tr>
			<td class="CL"><script>show_words('bwn_AM');</script></td>
			<td class="CR">
				<select id="wan_pppoe_dynamic_00" name="wan_pppoe_dynamic_00" size="1" onChange="disable_poe_ip()">
					<option value="1"><script>show_words('carriertype_ct_0');</script></option>
					<option value="0"><script>show_words('_sdi_staticip');</script></option>
				</select>
			</td>
		</tr>
<!--
	<tr>
		<td class="CL"><script>show_words('bwn_AM')</script></td>
		<td class="CR">
			<input type="radio" name="wan_pppoe_dynamic_00" value="0" onClick="disable_poe_ip()" checked />
			<script>show_words('carriertype_ct_0')</script>
			<input type="radio" name="wan_pppoe_dynamic_00" value="1" onClick="disable_poe_ip()" />
			<script>show_words('_sdi_staticip')</script>
		</td>
	</tr>
	-->
	<tr id="show_poeip">
		<td class="CL"><script>show_words('_ipaddr')</script></td>
		<td class="CR">
			<input type=text id="wan_pppoe_ipaddr_00" name="wan_pppoe_ipaddr_00" size="20" maxlength="15" value="<!--# echo wan_pppoe_ipaddr_00 -->" />
		</td>
	</tr>

	<tr>
		<td class="CL"><script>show_words('bwn_UN')</script></td>
		<td class="CR">
			<input type="text" id="wan_pppoe_username_00" name="wan_pppoe_username_00" size="20" maxlength="63" value="<!--# echo wan_pppoe_username_00 -->" />
		</td>
	</tr>
	<tr>
		<td class="CL"><script>show_words('_password')</script></td>
		<td class="CR">
			<input type="password" id="poe_pass_s" name="poe_pass_s" size="20" maxlength="63" value="WDB8WvbXdH" onfocus="select();" />
		</td>
	</tr>
	<tr>
		<td class="CL"><script>show_words('_verifypw')</script></td>
		<td class="CR">
			<input type="password" id="poe_pass_v" name="poe_pass_v" size="20" maxlength="63" value="WDB8WvbXdH" onfocus="select();" />
		</td>
	</tr>
<!--	<tr>
		<td class="CL"><script>show_words('_srvname')</script></td>
		<td class="CR">
			<input type="text" id="wan_pppoe_service_00" name="wan_pppoe_service_00" size="30" maxlength="39" value="" />
			<script>show_words('_optional')</script>
		</td>
	</tr>
-->
	<tr>
		<td class="CL" rowspan="2" id="wPppoeOPMode"><script>show_words('_opeartion_mode');</script></td>
		<td class="CR">
			<select id="wan_pppoe_connect_mode_00" name="wan_pppoe_connect_mode_00" size="1"  onChange="check_connectmode()">
				<option value="always_on"><script>show_words('_keep_alive');</script></option>
				<option value="on_demand"><script>show_words('bwn_RM_1');</script></option>
				<option value="manual"><script>show_words('bwn_RM_2');</script></option>
			</select>
		</td>
	</tr>
	<tr>
		<td colspan="2" class="CELL">
			<!--script>show_words('_keep_alive_mode_redial');</script>
			<input type="text" id="pppoeRedialPeriod" name="pppoeRedialPeriod" maxlength="5" size="3" value="10" />
			<script>show_words('_seconds');</script>
			<br-->
			<script>show_words('_on_demand_mode_idle_time');</script>
			<input type="text" id="wan_pppoe_max_idle_time_00" name="wan_pppoe_max_idle_time_00" maxlength="3" size="2" value="<!--# echo wan_pppoe_max_idle_time_00 -->"/>
			<script>show_words('_mintues_lower');</script>
		</td>
	</tr>
	<!--tr>
		<td class="CL"><script>show_words('_net_ipv6_11');</script></td>
		<td class="CR">
			<select name="dhcpDNSSelect" id="dhcpDNSSelect" size="1">
			<option id="dhcpDNSDisabled" value="0" selected="selected"><script>show_words('_disable');</script></option>
			<option id="dhcpDNSEnabled" value="1"><script>show_words('_enable');</script></option>
			</select>
		</td>
	</tr-->
	</div>
	</table>
</div>

<div id="Phy" class="box_tn"><!--  style="display:none;" -->
	<div id="wStaticMode" class="CT"><script>show_words('rus_wan_pppoe_03');</script></div>
	<table cellspacing="0" cellpadding="0" class="formarea">
		<tr>
			<td class="CL" id="wpppoeAddrMode"><script>show_words('bwn_AM');</script></td>
			<td class="CR">
				<select id="wan_rus_pppoe_dynamic" name="wan_rus_pppoe_dynamic" size="1" onChange="disable_rus_poe_ip()">
					<option value="0"><script>show_words('_dynamic');</script></option>
					<option value="1"><script>show_words('_static');</script></option>
				</select>
			</td>
		</tr>
		<tr id="rpppoeIp">
			<td class="CL"><script>show_words('_ipaddr')</script>:</td>
			<td class="CR">
				<input type="text" id="rus_wan_pppoe_ipaddr_00" name="rus_wan_pppoe_ipaddr_00" size="20" maxlength="15" value="<!--# echo wan_pppoe_russia_ipaddr -->">
			</td>
		</tr>
		<tr id="rpppoeNetmask">
			<td class="CL"><script>show_words('_subnet')</script>:</td>
			<td class="CR">
				<input type="text" id="rus_wan_pppoe_netmask" name="rus_wan_pppoe_netmask" size="20" maxlength="15" value="<!--# echo wan_pppoe_russia_netmask -->">
			</td>
		</tr>
		<tr id="rpppoeGateway">
			<td class="CL"><script>show_words('_gateway')</script>:</td>
			<td class="CR">
				<input type="text" id="rus_wan_pppoe_gateway" name="rus_wan_pppoe_gateway" size="20" maxlength="15" value="<!--# echo wan_pppoe_russia_gateway -->">
			</td>
		</tr>
	</table>
</div>

<div id="DNSServer" class="box_tn"><!--  style="display:none;" -->
	<div id="wStaticMode" class="CT"><script>show_words('_dns_server_setting');</script></div>
	<table cellspacing="0" cellpadding="0" class="formarea">
		<tr>
			<td class="CL" id="wStaticPriDns"><script>show_words('_dns1');</script></td>
			<td class="CR"><input type="text" id="wan_primary_dns" name="wan_primary_dns" size="20" maxlength="15" value="<!--# echo wan_pppoe_russia_primary_dns -->" /></td>
		</tr>
		<tr>
			<td class="CL" id="wStaticSecDns"><script>show_words('_dns2');</script></td>
			<td class="CR"><input type="text" id="wan_secondary_dns" name="wan_secondary_dns" size="20" maxlength="15" value="<!--# echo wan_pppoe_russia_secondary_dns -->" /></td>
		</tr>
	</table>
</div>
<!-- MTU -->
<div class="box_tn" id="mtu_field" style="display: block;">
	<div class="CT"><script>show_words('_help_txt37');</script></div>
	<table cellspacing="0" cellpadding="0" class="formarea">
		<!--tr>
			<td class="CL"><script>show_words('_net_ipv6_09');</script></td>
			<td class="CR">
				<select id="useDefaultMTU_Select" name="useDefaultMTU" size="1">
					<option value="0"><script>show_words('_disable');</script></option>
					<option value="1"><script>show_words('_enable');</script></option>
				</select>
			</td>
		</tr-->
		<tr>
			<td class="CL"><script>show_words('_net_ipv6_10');</script></td>
			<td class="CR">
				<input type="text" id="wan_pppoe_mtu" name="wan_pppoe_mtu" maxlength="4" value="<!--# echo wan_pppoe_mtu -->" /><script>document.write(get_words('_mtu_default_byte').replace('%s', 1492));</script>
			</td>
		</tr>
	
	</table>
</div>
<!-- MAC Clone -->
<div class="box_tn">
	<div id="wMacClone" class="CT"><script>show_words('_mac_addr_clone');</script></div>
	<table cellspacing="0" cellpadding="0" class="formarea">
		<!--tr>
			<td class="CL"><script>show_words('_mac_clone');</script></td>
			<td class="CR">
				<select id="macCloneEnbl" name="macCloneEnbl" size="1">
					<option value="0"><script>show_words('_disable');</script></option>
					<option value="1"><script>show_words('_enable');</script></option>
				</select>
			</td>
		</tr-->
		<tr id="macCloneMacRow">
			<td class="CL"><script>show_words('_macaddr')</script></td>
			<td class="CR">
				<input type="text" id="wan_mac" name="wan_mac" size="20" maxlength="17" value="<!--# echo wan_mac -->" />&nbsp;&nbsp;(Ex: 00:11:22:33:44:55)<br>
				&nbsp;<input name="clone" id="clone" type="button" class="button_submit_NoWidth" value="" onClick="clone_mac_action()" />
				<script>get_by_id("clone").value = get_words('_clone');</script>
			</td>
		</tr>
		</table>
</div>

<div class="box_tn">
	<table cellspacing="0" cellpadding="0" class="formarea">
		<tr align="center">
	  		<td colspan="2" class="btn_field">
				<input name="button" type="button" class="ButtonSmall" id="button" onClick="return send_pppoe_request()" value="" />
				<script>$('#button').val(get_words('_apply'));</script>
				<input name="button2" type="button" class="ButtonSmall" id="button2" onclick="page_cancel('form1', 'internet_wan.asp');" value="" />
				<script>$('#button2').val(get_words('ES_cancel'));</script>
	  		</td>
		</tr>
	</table>
</div>
			</form>
									<br/>
								</div>
								<!-- End of main content -->

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
<script> 
	onPageLoad();
</script>
</html>
