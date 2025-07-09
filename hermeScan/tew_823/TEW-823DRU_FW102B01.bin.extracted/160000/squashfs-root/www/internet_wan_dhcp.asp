<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html lang="en-US" xmlns="http://www.w3.org/1999/xhtml" xml:lang="en-US">
<head>
<title>TRENDNET | modelName | Network | DHCP</title>
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
            get_by_id("wan_specify_dns").value ="1";
            get_by_id("wan_primary_dns").value ="204.194.232.200";
            get_by_id("wan_secondary_dns").value="204.194.234.200";
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
	set_checked(get_by_id("opendns_enable").value, get_by_id('opendns_enable_sel'));
	if (get_by_id("opendns_enable").value == '1') {
		opendns_enable_selector(true);
	}
//	show_hnat();
 // show_AdvDns();
	if (get_by_id("wan_mac").value === "<!--# echo sys_wan_mac -->") {
		get_by_id("wan_mac").value = "";
	}
	set_form_default_values("form1");
	var login_who= checksessionStorage();
	if(login_who== "user"){
		DisableEnableForm(document.form1,true);
	} 
}

function show_hnat(){
	if("<!--# echo hnat_enable -->" != ""){
		get_by_id("show_hnat").style.display = "";
		set_checked(get_by_id("hnat_enable").value, get_by_id("hnatEnable"));
	}else{
		get_by_id("show_hnat").style.display = "none";
	}
}
function show_AdvDns() {
	if("<!--# echo feature_parental_control -->" == "1"){
		get_by_id("show_AdvDns").style.display = "none";
	}else{
		get_by_id("show_AdvDns").style.display = "";
	}
}

function clone_mac_action(){
    get_by_id("mac_clone_addr").value = get_by_id("mac_clone_addr2").value;
	get_by_id("wan_mac").value = get_by_id("mac_clone_addr").value;
}

    function send_dhcp_request()
    {
   		var ipv6_pppoe_share = "<!--# echo ipv6_pppoe_share -->";
        var ipv6_wan_proto = "<!--# echo ipv6_wan_proto -->";
			if (ipv6_wan_proto == "3" && ipv6_pppoe_share == "0"){
			alert(get_words('IPV6_TEXT161a'));
			return false;
		}
		
		get_by_id("asp_temp_52").value = get_by_id("wan_proto").value;
		var is_modify = is_form_modified("form1");
    	if (!is_modify && !confirm(get_words('_ask_nochange'))) {
            return false;
        }
		
		//add by Vic for check hw nat enable
		if(!check_hw_nat_enable())
			return false;

        var dns1 = get_by_id("wan_primary_dns").value;
        var dns2 = get_by_id("wan_secondary_dns").value;
        var mtu = get_by_id("wan_mtu").value;
        var c_hostname=get_by_id("hostname").value;

	    var dns1_addr_msg = replace_msg(all_ip_addr_msg,get_words('wwa_pdns'));
		var dns2_addr_msg = replace_msg(all_ip_addr_msg,get_words('wwa_sdns'));
		var mtu_msg = replace_msg(check_num_msg, get_words('bwn_MTU'), 1300, 1500);

        var temp_dns1_obj = new addr_obj(dns1.split("."), dns1_addr_msg, false, false);
        var temp_dns2_obj = new addr_obj(dns2.split("."), dns2_addr_msg, true, false);
        var temp_mtu = new varible_obj(mtu, mtu_msg, 1300, 1500, false);

		if(Find_word(c_hostname,"'") || Find_word(c_hostname,'"') || Find_word(c_hostname,"/") || _isNumeric(c_hostname)){
			//alert("Host name invalid. the legal characters can not enter ',/,''");
			alert(get_words('GW_DHCP_CLIENT_CLIENT_NAME_INVALID'));
			return false;
		}
		
		//Tina Tsao add 2009/10/28
		//Check Host name cannot entry  ~!@#$%^&*()_+}{[]\|"?></-
		var re = /[^A-Za-z0-9_\-]/;
		if(re.test(c_hostname)){
			alert(get_words('GW_DHCP_CLIENT_CLIENT_NAME_INVALID'));
			return false;
		}
		//Tina Tsao add 2009/11/19
		//Host name cannot empty
		var data_tmp;
		for (var i = 0; i < c_hostname.length; i++){ 
        	data_tmp = c_hostname.substring(i,i+1); 
            if(data_tmp == " "){ 
				alert(get_words('GW_DHCP_CLIENT_CLIENT_NAME_INVALID'));
				return false;
			}
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
		//}

	    if (dns1 != "" && dns1 != "0.0.0.0"){
    		if (!check_address(temp_dns1_obj)){
    			return false;
    		}
    	}
    	
    	if (dns2 != "" && dns2 != "0.0.0.0"){
    		if (!check_address(temp_dns2_obj)){
    			return false;
    		}
    	}
    	
    	if (!check_varible(temp_mtu)){
    		return false;
    	}
		
		if((get_by_id("wan_primary_dns").value =="" || get_by_id("wan_primary_dns").value =="0.0.0.0")&& ( get_by_id("wan_secondary_dns").value =="" || get_by_id("wan_secondary_dns").value =="0.0.0.0")){
			get_by_id("wan_specify_dns").value = 0;
		}else{
			get_by_id("wan_specify_dns").value = 1;
		}
		//2009/4/29 Tina add OPENDNS
		get_by_id("opendns_enable").value = get_checked_value(get_by_id("opendns_enable_sel"));
		if(get_by_id("opendns_enable").value=="1"){
			//get_by_id("dns_relay").value = "1";
			get_by_id("wan_primary_dns").disabled = false;
			get_by_id("wan_secondary_dns").disabled = false;
		}
		//OPENDNS
		var obj = new ccpObject();
		obj.add_param_arg('wan_mtu',get_by_id("wan_mtu").value);
		obj.add_param_arg('wan_mac',mac);
		obj.add_param_arg('hostname',c_hostname);
		obj.add_param_arg('wan_primary_dns',get_by_id("wan_primary_dns").value);
		obj.add_param_arg('wan_secondary_dns',get_by_id("wan_secondary_dns").value);
		obj.add_param_arg('opendns_enable',get_checked_value(get_by_id("opendns_enable_sel")));
		obj.add_param_arg('hnat_enable',get_checked_value(get_by_id("hnatEnable")));
		obj.add_param_arg('wan_mac',get_by_id("wan_mac").value);
		obj.add_param_arg('wan_specify_dns',get_by_id("wan_specify_dns").value);
		obj.add_param_arg('wan_proto', 'dhcpc');

                obj.add_param_arg('wan_pppoe_russia_enable',0);
                obj.add_param_arg('wan_pptp_russia_enable',0);
                obj.add_param_arg('wan_l2tp_russia_enable',0);
		
		obj.set_param_url('apply.cgi');
		obj.set_ccp_act('set');
                obj.add_param_event('wan_dhcp');
		obj.set_param_next_page('internet_wan_dhcp.asp');

		obj.add_param_arg('reboot_type', 'wan');
		
			var param = obj.get_param();			
			totalWaitTime = 25; //second
			redirectURL = location.pathname;
			wait_page();
			jq_ajax_post(param.url, param.arg);
			
			if(submit_button_flag == 0){
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

				<form id="form2" name="form2" method="post" action="apply.cgi">
					<input type="hidden" name="ccp_act" value="set" />
					<input type="hidden" name="ccpSubEvent" value="CCP_SUB_WEBPAGE_APPLY" />
					<input type="hidden" name="nextPage" value="internet_wan.asp" />
					
					<span id="forAPMode"></span>
				</form>

				<form id="form1" name="form1" method="post" action="apply.cgi">		
				<input type="hidden" id="action" name="action" value="wan_dhcp">
							
				<input type="hidden" id="mac_clone_addr" name="mac_clone_addr" value="<!--# echo mac_clone_addr -->">			
				<input type="hidden" id="mac_clone_addr2" name="mac_clone_addr2" value="<!--# exec cgi /bin/clone mac_clone_addr -->">
                <input type="hidden" id="wan_specify_dns" name="wan_specify_dns" value="<!--# echo wan_specify_dns -->">
				<input type="hidden" id="dhcpc_use_ucast" name="dhcpc_use_ucast" value="<!--# echo dhcpc_use_ucast -->">
				<input type="hidden" id="classless_static_route" name="classless_static_route" value="<!--# echo classless_static_route -->">
				<input type="hidden" id="asp_temp_51" name="asp_temp_51" value="<!--# echo asp_temp_51 -->">
				<input type="hidden" id="asp_temp_52" name="asp_temp_52" value="<!--# echo wan_proto -->">
				<input type="hidden" id="usb_type" name="usb_type" value="<!--# echo usb_type -->">
				<input type="hidden" id="from_usb3g" name="from_usb3g" value="<!--# echo asp_temp_72 -->"> 
				<input type="hidden" id="wan_pppoe_russia_enable" name="wan_pppoe_russia_enable" value="0">
			    <input type="hidden" id="wan_pptp_russia_enable" name="wan_pptp_russia_enable" value="0">
			    <input type="hidden" id="wan_l2tp_russia_enable" name="wan_l2tp_russia_enable" value="0">
					
<div class="box_tn">
	<div class="CT"><script>show_words('_wan_conn_type');</script></div>
	<table cellspacing="0" cellpadding="0" class="formarea">
	<tr>
		<td class="CL"><script>show_words('_contype');</script></td>
		<td class="CR">
			<select name="wan_proto" id="wan_proto" onChange="change_wan()">
				<option value="static">STATIC</option>
				<option value="dhcpc" selected>DHCP</option>
				<option value="pppoe">PPPoE</option>
				<option value="l2tp">L2TP</option>
				<option value="pptp">PPTP</option>
				<option value="rus_pppoe">Russia PPPoE</option>
				<option value="rus_l2tp">Russia L2TP</option>
				<option value="rus_pptp">Russia PPTP</option>
				<!-- <option value="10"><script>show_words('IPV6_TEXT140')</script></option> -->
				<!--option value="bigpond">BigPond (Australia)</option-->
			</select>
		</td>
	</tr>
	</table>
</div>

<div id="dhcp" class="box_tn" style="display: block;">
	<div id="wDhcpMode" class="CT"><script>show_words('_dhcp_setting');</script></div>
	<table id="dhcp" cellspacing="0" cellpadding="0" class="formarea">
		<tr id="show_AdvDns" style="display:none">
		<td class="CL"><script>show_words('_en_AdvDns')</script></td>
		<td class="CR">
			<input type="hidden" id="opendns_enable" name="opendns_enable" value="<!--# echo opendns_enable -->">
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
	<tr>
		<td class="CL"><script>show_words('_hostname');</script> (<script>show_words('LT124');</script>)</td>
		<td class="CR">
			<input type="text" id="hostname" name="hostname" size="28" maxlength="32" value="<!--# echo hostname -->" />
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
	</table>
</div>

<div id="DNSServer" class="box_tn"><!--  style="display:none;" -->
	<div id="wStaticMode" class="CT"><script>show_words('_dns_server_setting');</script></div>
	<table cellspacing="0" cellpadding="0" class="formarea">
	<tr>
		<td class="CL" id="wStaticPriDns"><script>show_words('_dns1');</script></td>
		<td class="CR"><input type="text" id="wan_primary_dns" name="wan_primary_dns" size="20" maxlength="15" value="<!--# echo wan_primary_dns -->" /></td>
	</tr>
	<tr>
		<td class="CL" id="wStaticSecDns"><script>show_words('_dns2');</script></td>
		<td class="CR"><input type="text" id="wan_secondary_dns" name="wan_secondary_dns" size="20" maxlength="15" value="<!--# echo wan_secondary_dns -->" /></td>
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
			<input type="text" id="wan_mtu" name="wan_mtu" maxlength="4" value="<!--# echo wan_mtu -->" /><script>document.write(get_words('_mtu_default_byte').replace('%s', 1500));</script>
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
			<input name="clone" id="clone" type="button" class="button_submit_NoWidth" value="" onClick="clone_mac_action()" />
			<script>get_by_id("clone").value = get_words('_clone');</script>
		</td>
	</tr>
	</table>
</div>

<div class="box_tn">
	<table cellspacing="0" cellpadding="0" class="formarea">
	<tr align="center">
		<td colspan="2" class="btn_field">
		<input name="button" type="button" class="ButtonSmall" id="button" onClick="return send_dhcp_request()" value="" />
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
