<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html lang="en-US" xmlns="http://www.w3.org/1999/xhtml" xml:lang="en-US">
<head>
<title>TRENDNET | modelName | Setup | IPv6</title>
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
    function onPageLoad(){
	  	var link_local ;
		var ipv6_advert_lifetime = document.getElementById("ipv6_ra_adv_valid_lifetime_l_one").value;
	  	get_by_id("ipv6_static_adver_lifetime").value = ipv6_advert_lifetime/60;
		link_local = document.getElementById("link_local_ip_l").value;
	  	document.getElementById("lan_link_local_ip").innerHTML= link_local.toUpperCase();
		set_checked(get_by_id("ipv6_use_link_local").value, get_by_id("ipv6_use_link_local_sel"));
		if (get_by_id("ipv6_use_link_local_sel").checked)
                        use_wan_link_local_selector(get_by_id("ipv6_use_link_local_sel").checked);
		set_checked(get_by_id("ipv6_autoconfig").value, get_by_id("ipv6_autoconfig_sel"));
		set_selectIndex("<!--# echo ipv6_autoconfig_type -->", get_by_id("ipv6_autoconfig_type"));
		set_ipv6_autoconfiguration_type();
		disable_autoconfig();
		set_ipv6_stateful_range();
		set_form_default_values("form1");
		var login_who= checksessionStorage();
		if(login_who== "user"){
			DisableEnableForm(document.form1,true);
		}
	}
	
	function disable_autoconfig(){
		var disable = get_by_id("ipv6_autoconfig_sel").checked;
		get_by_id("ipv6_autoconfig").value = get_checked_value(get_by_id("ipv6_autoconfig_sel"));
		get_by_id("ipv6_autoconfig_type").disabled = !disable;
		get_by_id("ipv6_addr_range_start_suffix").disabled = !disable;
		get_by_id("ipv6_addr_range_end_suffix").disabled = !disable;
		get_by_id("ipv6_dhcpd_lifetime").disabled = !disable;
		get_by_id("ipv6_static_adver_lifetime").disabled = !disable;
	}
	function set_ipv6_autoconf_range(){
		var ipv6_lan_ip = get_by_id("ipv6_static_lan_ip").value;
		var prefix_length = 64;
		var correct_ipv6="";
		if(ipv6_lan_ip != ""){
			correct_ipv6 = get_stateful_ipv6(ipv6_lan_ip);
			get_by_id("ipv6_addr_range_start_prefix").value  = get_stateful_prefix(correct_ipv6,prefix_length);
			get_by_id("ipv6_addr_range_end_prefix").value  = get_stateful_prefix(correct_ipv6,prefix_length);
		}
	}
	var static_wan_ip ;
	var static_prefix_length ;

    function use_wan_link_local_selector(value)
    {
		var link_local_w ;
		var ipv6_local_w_ip;
		
		if (value == true)
		{
			static_wan_ip =  get_by_id("ipv6_static_wan_ip").value;
			static_prefix_length = get_by_id("ipv6_static_prefix_length").value;
			ipv6_local_w_ip = get_by_id("link_local_ip_w").value.split("/");

			if (ipv6_local_w_ip != "") {
				get_by_id("ipv6_static_wan_ip").value = ipv6_local_w_ip[0].toUpperCase();
				get_by_id("ipv6_static_prefix_length").value = ipv6_local_w_ip[1];
			}
			get_by_id("ipv6_static_wan_ip").disabled = true;
			get_by_id("ipv6_static_prefix_length").disabled = true;
		} 
		else
		{
			get_by_id("ipv6_static_wan_ip").value = "<!--# echo ipv6_static_wan_ip -->";
			get_by_id("ipv6_static_prefix_length").value = "<!--# echo ipv6_static_prefix_length -->";
			get_by_id("ipv6_static_wan_ip").disabled = false;
			get_by_id("ipv6_static_prefix_length").disabled = false;
		}
    }

	function set_ipv6_stateful_range()
	{
		var prefix_length = 64;
		var ipv6_lan_ip = get_by_id("ipv6_static_lan_ip").value;
		var ipv6_dhcpd_start_range = get_by_id("ipv6_dhcpd_start").value;
		var ipv6_dhcpd_end_range = get_by_id("ipv6_dhcpd_end").value;
		var correct_ipv6="";
		if(ipv6_lan_ip != ""){
			correct_ipv6 = get_stateful_ipv6(ipv6_lan_ip);
			get_by_id("ipv6_addr_range_start_prefix").value  = get_stateful_prefix(correct_ipv6,prefix_length);
			//get_by_id("ipv6_addr_range_start_suffix").value  = get_stateful_suffix(ipv6_dhcpd_start_range);
			get_by_id("ipv6_addr_range_end_prefix").value  = get_stateful_prefix(correct_ipv6,prefix_length);
			//get_by_id("ipv6_addr_range_end_suffix").value  = get_stateful_suffix(ipv6_dhcpd_end_range);
		}
		get_by_id("ipv6_addr_range_start_suffix").value  = get_stateful_suffix(ipv6_dhcpd_start_range);
		get_by_id("ipv6_addr_range_end_suffix").value  = get_stateful_suffix(ipv6_dhcpd_end_range);
	}
	function set_ipv6_autoconfiguration_type(){
 		var mode = get_by_id("ipv6_autoconfig_type").selectedIndex;
		switch(mode){
		case 0:	//Stateless
			get_by_id("show_ipv6_addr_range_start").style.display = "none";
			get_by_id("show_ipv6_addr_range_end").style.display = "none";
			get_by_id("show_ipv6_addr_lifetime").style.display ="none";
			get_by_id("show_router_advert_lifetime").style.display = "";
			break;
		case 2: //Stateful DHCPv6
			set_ipv6_autoconf_range();
			get_by_id("ipv6_addr_range_start_prefix").disabled = true;
			get_by_id("ipv6_addr_range_end_prefix").disabled = true;
			get_by_id("show_ipv6_addr_range_start").style.display = "";
			get_by_id("show_ipv6_addr_range_end").style.display = "";
			get_by_id("show_ipv6_addr_lifetime").style.display ="";
			get_by_id("show_router_advert_lifetime").style.display = "none";
			break;
		default:
			get_by_id("show_ipv6_addr_range_start").style.display = "none";
			get_by_id("show_ipv6_addr_range_end").style.display = "none";
			get_by_id("show_ipv6_addr_lifetime").style.display ="none";
			get_by_id("show_router_advert_lifetime").style.display = "";
			break;
		}
  }
function send_request(){
	var ipv6_static = get_by_id("ipv6_static_wan_ip").value;
	var ipv6_static_msg = replace_msg(all_ipv6_addr_msg, get_words('IPV6_TEXT0'));
	var temp_ipv6_static = new ipv6_addr_obj(ipv6_static.split(":"), ipv6_static_msg, false, false);
	var prefix_length_msg = replace_msg(check_num_msg, get_words('IPV6_TEXT74'), 1, 126);
	var prefix_length_obj = new varible_obj(get_by_id("ipv6_static_prefix_length").value, prefix_length_msg, 1, 126, false);
	var ipv6_static_gw = get_by_id("ipv6_static_default_gw").value;
	var ipv6_static_gw_msg = replace_msg(all_ipv6_addr_msg, get_words('IPV6_TEXT75'));
	var temp_ipv6_static_gw = new ipv6_addr_obj(ipv6_static_gw.split(":"), ipv6_static_gw_msg, false, false);
	var primary_dns = get_by_id("ipv6_static_primary_dns").value;	
	var v6_primary_dns_msg = replace_msg(all_ipv6_addr_msg, get_words('_dns1'));	
	var secondary_dns = get_by_id("ipv6_static_secondary_dns").value;	
	var v6_secondary_dns_msg = replace_msg(all_ipv6_addr_msg,get_words('_dns2'));	
	var ipv6_lan = get_by_id("ipv6_static_lan_ip").value;
	var ipv6_lan_msg = replace_msg(all_ipv6_addr_msg, get_words('IPV6_TEXT46'));
	var temp_ipv6_lan = new ipv6_addr_obj(ipv6_lan.split(":"), ipv6_lan_msg, false, false);
	var check_mode = get_by_id("ipv6_autoconfig_type").selectedIndex;
	get_by_id("ipv6_autoconfig").value = get_checked_value(get_by_id("ipv6_autoconfig_sel"));
	var enable_autoconfig = get_by_id("ipv6_autoconfig").value;
	var addr_lifetime_msg = replace_msg(check_num_msg, get_words('IPV6_TEXT68'), 1, 999999);
	var addr_lifetime_obj = new varible_obj(get_by_id("ipv6_dhcpd_lifetime").value, addr_lifetime_msg, 1, 999999, false);
	var adver_lifetime_msg = replace_msg(check_num_msg, get_words('IPV6_TEXT69'), 1, 35791395);
	var adver_lifetime_obj = new varible_obj(get_by_id("ipv6_static_adver_lifetime").value, adver_lifetime_msg , 1, 35791395, false);
	var ipv6_addr_s_suffix = get_by_id("ipv6_addr_range_start_suffix").value;
	var ipv6_addr_e_suffix = get_by_id("ipv6_addr_range_end_suffix").value;
	var link_local_gw;
	//get_by_id("ipv6_wan_proto").value = get_by_id("ipv6_w_proto").value;
       /*
        var is_modify = is_form_modified("form1");
        if (!is_modify && !confirm(get_words('up_jt_1')+"\n"+get_words('up_jt_2')+"\n"+get_words('up_jt_3'))) {
                        return false;
        }
		*/
	get_by_id("ipv6_use_link_local").value = get_checked_value(get_by_id("ipv6_use_link_local_sel"));

	// check the ipv6 address
	if((get_by_id("ipv6_use_link_local").value) != 1){
		if(check_ipv6_symbol(ipv6_static,"::")==2){ // find two '::' symbol
			return false;
		}else if(check_ipv6_symbol(ipv6_static,"::")==1){    // find one '::' symbol
			temp_ipv6_static = new ipv6_addr_obj(ipv6_static.split("::"), ipv6_static_msg, false, false);
			if (!check_ipv6_address(temp_ipv6_static,"::")){
				return false;
			}
		}else{	//not find '::' symbol
			temp_ipv6_static = new ipv6_addr_obj(ipv6_static.split(":"), ipv6_static_msg, false, false);
			if (!check_ipv6_address(temp_ipv6_static,":")){
				return false;
			}
		}
		//check the Subnet Prefix Length
		if (!check_varible(prefix_length_obj)){
  			return false;
		}
	}else{
		link_local_gw = ipv6_static_gw.split(":");
		if(link_local_gw[0].toUpperCase() != "FE80"){
			alert(get_words('YM127'));
			return false
		}

	}
    //check Default Gateway
    if(check_ipv6_symbol(ipv6_static_gw,"::")==2){ // find two '::' symbol
				return false;
		}else if(check_ipv6_symbol(ipv6_static_gw,"::")==1){    // find one '::' symbol
				temp_ipv6_static_gw = new ipv6_addr_obj(ipv6_static_gw.split("::"), ipv6_static_gw_msg, false, false);
				if (!check_ipv6_address(temp_ipv6_static_gw,"::")){
					return false;
				}
		}else{	//not find '::' symbol
				temp_ipv6_static_gw = new ipv6_addr_obj(ipv6_static_gw.split(":"), ipv6_static_gw_msg, false, false);
				if (!check_ipv6_address(temp_ipv6_static_gw,":")){
					return false;
				}
		}
		//check DNS Address
		if (primary_dns != ""){
			if(check_ipv6_symbol(primary_dns,"::")==2){ // find two '::' symbol
				return false;
			}else if(check_ipv6_symbol(primary_dns,"::")==1){    // find one '::' symbol
				temp_ipv6_primary_dns = new ipv6_addr_obj(primary_dns.split("::"), v6_primary_dns_msg, false, false);
				if (!check_ipv6_address(temp_ipv6_primary_dns ,"::")){
					return false;
				}
			}else{	//not find '::' symbol
				temp_ipv6_primary_dns  = new ipv6_addr_obj(primary_dns.split(":"), v6_primary_dns_msg, false, false);
				if (!check_ipv6_address(temp_ipv6_primary_dns,":")){
					return false;
				}
			}
		}
		
		if (secondary_dns != ""){
			if(check_ipv6_symbol(secondary_dns,"::")==2){ // find two '::' symbol
						return false;
			}else if(check_ipv6_symbol(secondary_dns,"::")==1){    // find one '::' symbol
						temp_ipv6_secondary_dns = new ipv6_addr_obj(secondary_dns.split("::"), v6_secondary_dns_msg, false, false);
	  				if (!check_ipv6_address(temp_ipv6_secondary_dns ,"::")){
								return false;
						}
			}else{	//not find '::' symbol
						temp_ipv6_secondary_dns  = new ipv6_addr_obj(secondary_dns.split(":"), v6_secondary_dns_msg, false, false);
						if (!check_ipv6_address(temp_ipv6_secondary_dns,":")){
							return false;
						}
			}
		}		
		//check LAN IP Address
		if(check_ipv6_symbol(ipv6_lan,"::")==2){ // find two '::' symbol
			return false;
		}else if(check_ipv6_symbol(ipv6_lan,"::")==1){    // find one '::' symbol
			temp_ipv6_lan = new ipv6_addr_obj(ipv6_lan.split("::"), ipv6_lan_msg, false, false);
			if (!check_ipv6_address(temp_ipv6_lan ,"::")){
				return false;
			}
		}else{	//not find '::' symbol
			temp_ipv6_lan  = new ipv6_addr_obj(ipv6_lan.split(":"), ipv6_lan_msg, false, false);
			if (!check_ipv6_address(temp_ipv6_lan,":")){
				return false;
			}
		}
    if((check_mode == 0 || check_mode == 1) && enable_autoconfig == 1){
    			//check the Router Advertisement Lifetime
    			if (!check_varible(adver_lifetime_obj)){
    				return false;
    			}
    		 	//set Advertisement Lifetime
                        get_by_id("ipv6_ra_adv_valid_lifetime_l_one").value = get_by_id("ipv6_static_adver_lifetime").value * 60 ;
                        get_by_id("ipv6_ra_adv_prefer_lifetime_l_one").value = get_by_id("ipv6_static_adver_lifetime").value * 60 ;
    }else if(check_mode == 2 && enable_autoconfig == 1){
    		  //check the suffix of Address Range(Start)
    		  if(!check_ipv6_address_suffix(ipv6_addr_s_suffix, get_words('IPV6_TEXT70'))){
							return false;
					}
					//check the suffix of Address Range(End)
					if(!check_ipv6_address_suffix(ipv6_addr_e_suffix,get_words('IPV6_TEXT71'))){
							return false;
					}
					//compare the suffix of start and the suffix of end
					if(!compare_suffix(ipv6_addr_s_suffix,ipv6_addr_e_suffix)){
    				return false;
    			}
    			//check the IPv6 Address Lifetime
    			if (!check_varible(addr_lifetime_obj)){
    				return false;
    			}
    			//set autoconfiguration range value
					get_by_id("ipv6_dhcpd_start").value = get_by_id("ipv6_addr_range_start_prefix").value + ":" +	get_by_id("ipv6_addr_range_start_suffix").value;
					get_by_id("ipv6_dhcpd_end").value = get_by_id("ipv6_addr_range_end_prefix").value + ":" +	get_by_id("ipv6_addr_range_end_suffix").value;
    }
		var obj = new ccpObject();
		obj.set_param_url('apply.cgi');
		obj.set_ccp_act('set');
		obj.add_param_event('adv_ipv6_static');
		obj.set_param_next_page('internet_ipv6_static.asp');		
		obj.add_param_arg('ipv6_wan_proto',get_by_id("ipv6_w_proto").value);
		obj.add_param_arg('ipv6_use_link_local',get_checked_value(get_by_id("ipv6_use_link_local_sel")));
		obj.add_param_arg('ipv6_autoconfig',get_checked_value(get_by_id("ipv6_autoconfig_sel")));	
		obj.add_param_arg('ipv6_autoconfig_type',get_by_id("ipv6_autoconfig_type").value);
		if (get_by_id("ipv6_static_wan_ip").disabled==false) {
			obj.add_param_arg('ipv6_static_wan_ip',get_by_id("ipv6_static_wan_ip").value);
		}
		obj.add_param_arg('ipv6_static_prefix_length',get_by_id("ipv6_static_prefix_length").value);
		obj.add_param_arg('ipv6_static_default_gw',get_by_id("ipv6_static_default_gw").value);
		obj.add_param_arg('ipv6_wan_specify_dns','1');
		obj.add_param_arg('ipv6_static_primary_dns',get_by_id("ipv6_static_primary_dns").value);
		obj.add_param_arg('ipv6_static_secondary_dns',get_by_id("ipv6_static_secondary_dns").value);
		obj.add_param_arg('ipv6_static_lan_ip',get_by_id("ipv6_static_lan_ip").value);
		obj.add_param_arg('ipv6_dhcpd_lifetime',get_by_id("ipv6_dhcpd_lifetime").value);
		
		obj.add_param_arg('ipv6_dhcpd_start',get_by_id("ipv6_dhcpd_start").value);
		obj.add_param_arg('ipv6_dhcpd_end',get_by_id("ipv6_dhcpd_end").value);
		obj.add_param_arg('ipv6_ra_adv_valid_lifetime_l_one',get_by_id("ipv6_ra_adv_valid_lifetime_l_one").value);
		obj.add_param_arg('ipv6_ra_adv_prefer_lifetime_l_one',get_by_id("ipv6_ra_adv_prefer_lifetime_l_one").value);
	    obj.add_param_arg('reboot_type', 'wan');
		var param = obj.get_param();

		totalWaitTime = 20; //second
		redirectURL = location.pathname;
		wait_page();
		jq_ajax_post(param.url, param.arg);
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
			<br><script>document.write(model);</script></br>
			</td>
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
				<script>document.write(menu.build_structure(1,1,3))</script>
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
								<script>show_words('_net_ipv6_01');</script>
								</div>
								<div class="hr"></div>
								<div class="section_content_border">
								<div class="header_desc" id="wanIntroduction">
									<script>show_words('_net_ipv6_02');</script>
									<p></p>
								</div>

							<form id="form1" name="form1" method="post" action="">
							<input type="hidden" id="ipv6_use_link_local" name="ipv6_use_link_local" value="<!--# echo ipv6_use_link_local -->">
							<input type="hidden" id="ipv6_autoconfig" name="ipv6_autoconfig" value="<!--# echo ipv6_autoconfig -->">
							<input type="hidden" id="ipv6_dhcpd_start" name="ipv6_dhcpd_start" value="<!--# echo ipv6_dhcpd_start -->">
							<input type="hidden" id="ipv6_dhcpd_end" name="ipv6_dhcpd_end" value="<!--# echo ipv6_dhcpd_end -->">
							<input type="hidden" id="ipv6_wan_proto" name="ipv6_wan_proto" value="<!--# echo ipv6_wan_proto -->">
							<input type="hidden" id="ipv6_ra_adv_valid_lifetime_l_one" name="ipv6_ra_adv_valid_lifetime_l_one" value="<!--# echo ipv6_ra_adv_valid_lifetime_l_one -->">
							<input type="hidden" id="ipv6_ra_adv_prefer_lifetime_l_one" name="ipv6_ra_adv_prefer_lifetime_l_one" value="<!--# echo ipv6_ra_adv_prefer_lifetime_l_one -->">
							<input type="hidden" maxLength=80 size=80 name="link_local_ip_l" id="link_local_ip_l" value="<!--# exec cgi /bin/ipv6 link_local_ip_l -->">
							<input type="hidden" maxLength=80 size=80 name="link_local_ip_w" id="link_local_ip_w" value="<!--# exec cgi /bin/ipv6 link_local_ip_w -->">
							<input type="hidden" id="ipv6_wan_specify_dns" name="ipv6_wan_specify_dns" value="1">
							<input type="hidden" id="page_type" name="page_type" value="IPv6">
								<p>
								
								
								<div class="box_tn">
									<div class="CT"><script>show_words('IPV6_TEXT29a');</script></div>
									<table cellspacing="0" cellpadding="0" class="formarea">
									<tr>
										<td class="CL"><script>show_words('IPV6_TEXT29a')</script></td>
										<td class="CR">
											<select name="ipv6_w_proto" id="ipv6_w_proto" onChange=select_ipv6_wan_page(get_by_id("ipv6_w_proto").value);>
												<option value="ipv6_static" selected><script>show_words('_net_ipv6_12')</script></option>	<!--Static-->
												<option value="ipv6_autoconfig"><script>show_words('IPV6_TEXT107')</script></option>	<!--Autoconfiguration-->
						<!--					<option value="1"><script>show_words('_help_txt82')</script></option>		Stateless DHCPv6-->
						<!--					<option value="2"><script>show_words('_help_txt84')</script></option>		DHCPv6(Stateful)-->
												<option value="link_local"><script>show_words('_help_txt110')</script></option>	<!--Link-Local-->
												<option value="ipv6_pppoe"><script>show_words('_PPPoE')</script></option>			<!--PPPoE-->
												<option value="ipv6_6to4"><script>show_words('IPV6_TEXT36')</script></option>		<!--6to4-->
											</select>
										</td>
									</tr>
									</table>
								</div>
								<br>

						<!-------------- static Settings -------------->
								<div class="box_tn" id="static_setting">
									<div class="CT"><script>show_words('_net_ipv6_03');</script></div>
									<table cellspacing="0" cellpadding="0" class="formarea">
									<tr>
										<td class="CL"><script>show_words('IPV6_TEXT104')</script></td>
										<td class="CR">
											<input name="ipv6_use_link_local_sel" type="checkbox" id="ipv6_use_link_local_sel" value="1" onClick="use_wan_link_local_selector(this.checked);" />
										</td>
									</tr>
									<tr>
										<td class="CL"><script>show_words('TEXT071')</script></td>
										<td class="CR">
											<input type="text" id="ipv6_static_wan_ip" name="ipv6_static_wan_ip" size="45" maxlength="63" value="<!--# echo ipv6_static_wan_ip -->" />
										</td>
									</tr>
									<tr>
										<td class="CL"><script>show_words('IPV6_TEXT74')</script></td>
										<td class="CR">
											<input type="text" id="ipv6_static_prefix_length" name="ipv6_static_prefix_length" size="5" maxlength="63" value="<!--# echo ipv6_static_prefix_length -->" />
										</td>
									</tr>
									<tr>
										<td class="CL"><script>show_words('_defgw')</script></td>
										<td class="CR">
											<input type="text" id="ipv6_static_default_gw" name="ipv6_static_default_gw" size="45" maxlength="39" value="<!--# echo ipv6_static_default_gw -->" />
										</td>
									</tr>
									</table>
								</div>
						<!-------------- End of static Settings -------------->

						
								<div class="box_tn" id="dns_setting">	<!--Ipv6DNSServer-->
									<div class="CT"><script>show_words('_help_txt94');</script></div>
									<table cellspacing="0" cellpadding="0" class="formarea">
									<!--tr id="DNSSelect_tr">
										<td class="CL"><script>show_words('_net_ipv6_11')</script></td>
										<td class="CR">
											<select name="DNSSelect" id="DNSSelect" size="1" onChange="ManuallyDNS()">
												<option id="DNSDisabled" value="0"><script>show_words('_disable');</script></option>
												<option id="DNSEnabled" value="1"><script>show_words('_enable');</script></option>
											</select></td>
									</tr-->
									<tr id="DnsPri_tr">
										<td class="CL"><script>show_words('_dns1')</script></td>
										<td class="CR">
											<input type="text" id="ipv6_static_primary_dns" name="ipv6_static_primary_dns" size="45" maxlength="39" value="<!--# echo ipv6_static_primary_dns -->" />
										</td>
									</tr>
									<tr id="DnsSec_tr">
										<td class="CL"><script>show_words('_dns2')</script></td>
										<td class="CR">
											<input type="text" id="ipv6_static_secondary_dns" name="ipv6_static_secondary_dns" size="45" maxlength="39" value="<!--# echo ipv6_static_secondary_dns -->" />
										</td>
									</tr>
									</table>
								</div>

								<div class="box_tn" id="lan_ip_setting">		<!--LanIpv6-->
									<div class="CT"><script>show_words('_help_txt96');</script></div>
									<table cellspacing="0" cellpadding="0" class="formarea">
								
									<tr id="LanIpAddr_tr">
										<td class="CL"><script>show_words('IPV6_TEXT46')</script></td>
										<td class="CR">
											<input type="text" id="ipv6_static_lan_ip" name="ipv6_static_lan_ip" size="45" maxlength="63" value="<!--# echo ipv6_static_lan_ip -->" onChange="set_ipv6_autoconf_range()">
											
										</td>
									</tr>
									<tr id="LanIpPrefixLen_tr">
										<td class="CL"><script>show_words('_net_ipv6_05')</script></td>
										<td class="CR">
											<span id="lan_ipv6_ip_prefix">&nbsp;64</span>
										</td>
									</tr>

									<tr id="LanIpLinkLocalIp_tr">
										<td class="CL"><script>show_words('IPV6_TEXT47')</script></td>
										<td class="CR">
											<span id="lan_link_local_ip"></span>
										</td>
									</tr>
								
									</table>
								</div>

								<div class="box_tn" id="autoconf_setting">	<!--LanIPv6Auto-->
									<div class="CT"><script>show_words('_help_txt98');</script></div>
									<table cellspacing="0" cellpadding="0" class="formarea">
									<tr>
                                  	<td class="CL"><script>show_words('IPV6_TEXT50');</script> :</td>
                                  	<td class="CR">&nbsp;<input name="ipv6_autoconfig_sel" type=checkbox id="ipv6_autoconfig_sel" value="1" onClick="disable_autoconfig()"></td>
                                	</tr>
									<tr>
										<td class="CL"><script>show_words('IPV6_TEXT51')</script></td>
										<td class="CR">
											<select id="ipv6_autoconfig_type" name="ipv6_autoconfig_type" onChange="set_ipv6_autoconfiguration_type()">
												<option value="stateless"><script>show_words('_net_ipv6_04')</script></option>
												<option value="stateless_dhcp"><script>show_words('_help_txt82')</script></option>
												<option value="stateful"><script>show_words('_help_txt84')</script></option>
											</select>
										</td>
									</tr>
									<tr id="show_ipv6_addr_range_start" style="display:none">	<!--LanIpv6DhcpStart_tr-->
										<td class="CL"><script>show_words('IPV6_TEXT54')</script></td>
										<td class="CR"><input type=text id="ipv6_addr_range_start_prefix" name="ipv6_addr_range_start_prefix" size="20" maxlength="19">
											::<input type="text" id="ipv6_addr_range_start_suffix" name="ipv6_addr_range_start_suffix" size="5" maxlength="4" />
										</td>
									</tr>
									<tr id="show_ipv6_addr_range_end" style="display:none">		<!--LanIpv6DhcpEnd_tr-->
										<td class="CL"><script>show_words('IPV6_TEXT55')</script></td>
										<td class="CR"><input type=text id="ipv6_addr_range_end_prefix" name="ipv6_addr_range_end_prefix" size="20" maxlength="19">
											::<input type="text" id="ipv6_addr_range_end_suffix" name="ipv6_addr_range_end_suffix" size="5" maxlength="4" />
										</td>
									</tr>
									<tr id="show_ipv6_addr_lifetime" style="display:none">		<!--LanIpv6LifeTime_tr-->
										<td class="CL"><script>show_words('IPV6_TEXT56')</script></td>
										<td class="CR">
											<input type="text" id="ipv6_dhcpd_lifetime" name="ipv6_dhcpd_lifetime" size="20" maxlength="6" value="<!--# echo ipv6_dhcpd_lifetime -->" />
											<script>show_words('_minutes')</script>
										</td>
									</tr>
									<tr id="show_router_advert_lifetime">
										<td class="CL"><script>show_words('IPV6_TEXT57')</script></td>
										<td class="CR">
											<input type="text" id="ipv6_static_adver_lifetime" name="ipv6_static_adver_lifetime" size="20" maxlength="15" value="" />
											<script>show_words('_minutes')</script>
										</td>
									</tr>	
									</table>
								</div>

								<div class="box_tn">
								<table cellspacing="0" cellpadding="0" class="formarea">
									<tr align="center">
										<td colspan="2" class="btn_field">
											<input name="button" type="button" class="ButtonSmall" id="button" onClick="return send_request()" />
											<script>$('#button').val(get_words('_adv_txt_17'));</script>
											<input name="button2" type="button" class="ButtonSmall" id="button2" onClick="page_cancel('form1', 'internet_ipv6.asp');" />
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
