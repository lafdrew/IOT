<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html lang="en-US" xmlns="http://www.w3.org/1999/xhtml" xml:lang="en-US">
<head>
<title>TRENDNET | modelName | Setup | IPv6</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<link href="/css/style.css" rel="stylesheet" type="text/css" />
<link href="/css/css_router.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="/uk_<!--# echo language -->.js"></script>
<script type="text/javascript" src="lang_en.js"></script>
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
    var ipv6_pppoe_lan_prefix;
	function onPageLoad(){ 
		var link_local ;
		var ipv6_advert_lifetime = document.getElementById("ipv6_ra_adv_valid_lifetime_l_one").value;
		get_by_id("ipv6_pppoe_adver_lifetime").value = ipv6_advert_lifetime/60;
		//ipv6_pppoe_lan_prefix ="<!--# echo 6to4_lan_address -->";
		//decide_pppoe_lan_ip();
		set_ipv6_stateful_range();
		link_local = document.getElementById("link_local_ip_l").value;
	  	document.getElementById("lan_link_local_ip").innerHTML= link_local.toUpperCase();
		set_checked(get_by_id("ipv6_autoconfig").value, get_by_id("ipv6_autoconfig_sel"));
		set_selectIndex("<!--# echo ipv6_pppoe_dynamic -->", get_by_id("ipv6_pppoe_dynamic"));
//		set_checked("<!--# echo ipv6_pppoe_connect_mode -->", get_by_name("ipv6_pppoe_connect_mode"));
		//check_ipv6_pppoe_connectmode();
		set_selectIndex("<!--# echo ipv6_pppoe_dns_enable -->", get_by_id("ipv6_dns_pppoe_enable"));
		set_checked("<!--# echo ipv6_dhcp_pd_enable -->", get_by_id("ipv6_dhcp_pd_chk"));
	//	set_checked(get_by_id("ipv6_dhcp_pd_enable_l").value, get_by_id("ipv6_dhcp_pd_lan"));
		set_checked(get_by_id("ipv6_dhcp_pd_hint_enable").value, get_by_id("ipv6_dhcp_pd_hint_chk"));
		/*var ipv6_wan_proto = "<!--# echo ipv6_wan_proto -->";
		if (ipv6_wan_proto == get_by_id("ipv6_w_proto").value){
			set_checked("<!--# echo ipv6_pppoe_dns_enable -->", get_by_name("ipv6_dns_pppoe_enable"));
			set_checked("<!--# echo ipv6_dhcp_pd_enable -->", get_by_id("ipv6_dhcp_pd_chk"));
		}else{
			set_checked("1", get_by_name("ipv6_dns_pppoe_enable"));
			set_checked("0", get_by_id("ipv6_dhcp_pd_chk"));
		}*/
		disable_autoconfig();
		disable_ipv6_pppoe_auto_dns();
		disable_ipv6_dhcp_pd_nochkDNS(); //spec 1.08
		set_selectIndex("<!--# echo ipv6_autoconfig_type -->", get_by_id("ipv6_autoconfig_type"));
		set_ipv6_autoconfiguration_type();
		set_ipv6_stateful_range();	
		set_checked("<!--# echo ipv6_pppoe_share -->", get_by_name("ipv6_pppoe_share"));
		clone_ipv4_pppoe();
		disable_ipv6_poe_ip();
		disable_ipv6_pppoe_auto_dns();
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
		if(get_by_id("ipv6_dhcp_pd_chk").checked){
			get_by_id("ipv6_dhcpd_lifetime").disabled = true;
			get_by_id("ipv6_pppoe_adver_lifetime").disabled = true;
			//get_by_id("ipv6_dhcp_pd_lan").disabled = !disable;
		}else{
			get_by_id("ipv6_dhcpd_lifetime").disabled = !disable;
			get_by_id("ipv6_pppoe_adver_lifetime").disabled = !disable;
		//	get_by_id("ipv6_dhcp_pd_lan").disabled = true;
		}
        }

	function clone_ipv4_pppoe(){
	//	var pppoe_connect_mode = get_by_name("ipv6_pppoe_connect_mode");
		var ipv6_pppoe_share = get_by_name("ipv6_pppoe_share");
		if(ipv6_pppoe_share[0].checked){
			get_by_id("ipv6_pppoe_username").value = "<!--# echo wan_pppoe_username_00 -->";
			get_by_id("ipv6_pppoe_password_s").value = "<!--# echo wan_pppoe_password_00 -->";
			get_by_id("ipv6_pppoe_password_v").value = "<!--# echo wan_pppoe_password_00 -->";
		//	get_by_id("ipv6_pppoe_service").value = "<!--# echo wan_pppoe_service_00 -->";
		//	set_checked("<!--# echo wan_pppoe_connect_mode_00 -->", get_by_name("ipv6_pppoe_connect_mode"));
			get_by_id("ipv6_pppoe_mtu").value = "<!--# echo wan_pppoe_mtu -->";
		//	get_by_id("ipv6_pppoe_idle_time").value = "<!--# echo wan_pppoe_max_idle_time_00 -->";

		//	pppoe_connect_mode[0].disabled = true;
		//	pppoe_connect_mode[1].disabled = true;
		//	pppoe_connect_mode[2].disabled = true;
			get_by_id("ipv6_pppoe_username").disabled = true;
			get_by_id("ipv6_pppoe_password").disabled = true;
			get_by_id("ipv6_pppoe_password_s").disabled = true;
			get_by_id("ipv6_pppoe_password_v").disabled = true;
			//get_by_id("ipv6_pppoe_service").disabled = true;
		//	get_by_id("ipv6_pppoe_idle_time").disabled = true;
			get_by_id("ipv6_pppoe_mtu").disabled = true;
			get_by_id("ipv6_pppoe_ipaddr").disabled = true;
			
		}else{
			get_by_id("ipv6_pppoe_username").value = "<!--# echo ipv6_pppoe_username -->";
			get_by_id("ipv6_pppoe_password_s").value = "<!--# echo ipv6_pppoe_password -->";
			get_by_id("ipv6_pppoe_password_v").value = "<!--# echo ipv6_pppoe_password -->";
		//	get_by_id("ipv6_pppoe_service").value = "<!--# echo ipv6_pppoe_service -->";
		//	set_checked("<!--# echo ipv6_pppoe_connect_mode -->", get_by_name("ipv6_pppoe_connect_mode"));
			get_by_id("ipv6_pppoe_mtu").value = "<!--# echo ipv6_pppoe_mtu -->";
			//get_by_id("ipv6_pppoe_idle_time").value = "<!--# echo ipv6_pppoe_idle_time -->";

	//		pppoe_connect_mode[0].disabled = false;
	//		pppoe_connect_mode[1].disabled = true;
	//		pppoe_connect_mode[2].disabled = false;
			get_by_id("ipv6_pppoe_username").disabled = false;
			get_by_id("ipv6_pppoe_password").disabled = false;
			get_by_id("ipv6_pppoe_password_s").disabled = false;
			get_by_id("ipv6_pppoe_password_v").disabled = false;
			//get_by_id("ipv6_pppoe_service").disabled = false;
			get_by_id("ipv6_pppoe_mtu").disabled = false;
			get_by_id("ipv6_pppoe_ipaddr").disabled = false;
		//	get_by_id("ipv6_pppoe_idle_time").disabled = false;
		}
		//check_ipv6_pppoe_connectmode();
	} 
	function disable_ipv6_poe_ip(){
		var fixIP = get_by_id("ipv6_pppoe_dynamic").value;
		var ipv6_pppoe_share = get_by_name("ipv6_pppoe_share");
		var is_disabled;
	  	if (fixIP == "0"){
	    	get_by_id("Ipv6pppoeStaticIp").style.display = "";
	    	if(ipv6_pppoe_share[0].checked){
	    		get_by_id("ipv6_pppoe_ipaddr").disabled = true;
	    	}else{
	    		get_by_id("ipv6_pppoe_ipaddr").disabled = false;
	    	}
	  	}else{
	    	get_by_id("Ipv6pppoeStaticIp").style.display = "none";
	    	get_by_id("ipv6_pppoe_ipaddr").disabled = true;
	    }
	  	//get_by_id("wan_pppoe_ipaddr_00").disabled = is_disabled;
	  //get_by_id("ipv6_pppoe_ipaddr").disabled = is_disabled;
	}
	function check_ipv6_pppoe_connectmode(){
		var conn_mode = get_by_name("ipv6_pppoe_connect_mode");
		var idle_time = get_by_id("ipv6_pppoe_idle_time");
        var ipv6_pppoe_share = get_by_name("ipv6_pppoe_share");
                if(ipv6_pppoe_share[1].checked)
			idle_time.disabled = !conn_mode[1].checked;
	}
	function disable_ipv6_pppoe_auto_dns(){
	    var fixIP = get_by_id("ipv6_dns_pppoe_enable").value;

	    var is_disabled;
	    if (fixIP == "0"){
	    	is_disabled = true;
	    }else{
	    	is_disabled = false;
	    }
	    get_by_id("ipv6_pppoe_primary_dns").disabled = is_disabled;
	    get_by_id("ipv6_pppoe_secondary_dns").disabled = is_disabled;
	}
	
	function disable_ipv6_dhcp_pd_nochkDNS(){
		get_by_id("ipv6_pppoe_lan_ip").disabled = get_by_id("ipv6_dhcp_pd_chk").checked;
		if(get_by_id("ipv6_autoconfig_sel").checked){
			//get_by_id("ipv6_dhcp_pd_lan").disabled = !get_by_id("ipv6_dhcp_pd_chk").checked;
			get_by_id("ipv6_dhcpd_lifetime").disabled = get_by_id("ipv6_dhcp_pd_chk").checked;
			get_by_id("ipv6_pppoe_adver_lifetime").disabled = get_by_id("ipv6_dhcp_pd_chk").checked;
			get_by_id("ipv6_dhcp_pd_hint_chk").disabled = !get_by_id("ipv6_dhcp_pd_chk").checked;
                        get_by_id("ipv6_dhcp_pd_hint_prefix").disabled = 
                                !get_by_id("ipv6_dhcp_pd_hint_chk").checked || !get_by_id("ipv6_dhcp_pd_chk").checked;
                        get_by_id("ipv6_dhcp_pd_hint_length").disabled = 
                                !get_by_id("ipv6_dhcp_pd_hint_chk").checked || !get_by_id("ipv6_dhcp_pd_chk").checked;
                        get_by_id("ipv6_dhcp_pd_hint_pltime").disabled = 
                                !get_by_id("ipv6_dhcp_pd_hint_chk").checked || !get_by_id("ipv6_dhcp_pd_chk").checked;
                        get_by_id("ipv6_dhcp_pd_hint_vltime").disabled = 
                                !get_by_id("ipv6_dhcp_pd_hint_chk").checked || !get_by_id("ipv6_dhcp_pd_chk").checked;
		}
	}
		
	function set_ipv6_autoconf_range(){
			var ipv6_lan_ip = get_by_id("ipv6_pppoe_lan_ip").value;
			var prefix_length = 64;
			var correct_ipv6="";		
			if(ipv6_lan_ip != ""){
				correct_ipv6 = get_stateful_ipv6(ipv6_lan_ip);
				get_by_id("ipv6_addr_range_start_prefix").value  = get_stateful_prefix(correct_ipv6,prefix_length);
				get_by_id("ipv6_addr_range_end_prefix").value  = get_stateful_prefix(correct_ipv6,prefix_length);										
			}		
	}
	function set_ipv6_stateful_range()
	{
			var prefix_length = 64;
			var ipv6_lan_ip = get_by_id("ipv6_pppoe_lan_ip").value;
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
		case 0:
			get_by_id("show_ipv6_addr_range_start").style.display = "none";
			get_by_id("show_ipv6_addr_range_end").style.display = "none";
			get_by_id("show_ipv6_addr_lifetime").style.display ="none";
			get_by_id("show_router_advert_lifetime").style.display = "";
			break;
		case 2:
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
   function decide_pppoe_lan_ip()
   {
   		var pppoe_lan_ip_prefix = ipv6_pppoe_lan_prefix.toUpperCase();
		var pppoe_lan_ip = "<!--# echo ipv6_pppoe_lan_ip -->";		
		var index ;
		if(pppoe_lan_ip == "")
		{
			get_by_id("ipv6_pppoe_lan_ip").value = pppoe_lan_ip_prefix + "0001::1";
		}else{
			index = count_colon_pos(pppoe_lan_ip,":",3);
			get_by_id("ipv6_pppoe_lan_ip").value = pppoe_lan_ip_prefix + pppoe_lan_ip.substring(index);
		}	
//   		get_by_id("ipv6_pppoe_lan_ip").value = temp;
   }
   function check_pppoe_lan_prefix()
   {
   		var current_pppoe_prefix;
   		var pppoe_lan_ip = get_by_id("ipv6_pppoe_lan_ip").value;
   		var index = count_colon_pos(pppoe_lan_ip,":",3);
   		current_pppoe_prefix = pppoe_lan_ip.substring(0,index);
   		current_pppoe_prefix = current_pppoe_prefix.toUpperCase();
   		ipv6_pppoe_lan_prefix = ipv6_pppoe_lan_prefix.toUpperCase();
		if( current_pppoe_prefix != ipv6_pppoe_lan_prefix ){   		
   				  return false;
   		}else{
   					return true;		  
   }                
   }                
function send_request(){
	var fixDNSIP = get_by_id("ipv6_dns_pppoe_enable").value;	
	var pppoe_dynamic = get_by_id("ipv6_pppoe_dynamic").value;
	//var pppoe_ip = get_by_id("wan_pppoe_ipaddr_00").value;
	var pppoe_ip = get_by_id("ipv6_pppoe_ipaddr").value;
	var pppoe_ip_msg = replace_msg(all_ip_addr_msg,get_words('IPV6_TEXT43'));
	var temp_pppoe_ip = new ipv6_addr_obj(pppoe_ip.split(":"), pppoe_ip_msg, false, false);
	var check_mode = get_by_id("ipv6_autoconfig_type").selectedIndex;
	get_by_id("ipv6_autoconfig").value = get_checked_value(get_by_id("ipv6_autoconfig_sel"));
	var enable_autoconfig = get_by_id("ipv6_autoconfig").value;
	var primary_dns = get_by_id("ipv6_pppoe_primary_dns").value;
	var v6_primary_dns_msg = replace_msg(all_ipv6_addr_msg,get_words('_dns1'));
	var secondary_dns = get_by_id("ipv6_pppoe_secondary_dns").value;
	var v6_secondary_dns_msg = replace_msg(all_ipv6_addr_msg,get_words('_dns2'));
	var ipv6_lan = get_by_id("ipv6_pppoe_lan_ip").value;
	var ipv6_lan_msg = replace_msg(all_ipv6_addr_msg,get_words('IPV6_TEXT46'));
	var temp_ipv6_lan = new ipv6_addr_obj(ipv6_lan.split(":"), ipv6_lan_msg, false, false);
	var addr_lifetime_msg = replace_msg(check_num_msg, get_words('IPV6_TEXT68'), 1, 999999);
	var addr_lifetime_obj = new varible_obj(get_by_id("ipv6_dhcpd_lifetime").value, addr_lifetime_msg, 1, 999999, false);
	var adver_lifetime_msg = replace_msg(check_num_msg, get_words('IPV6_TEXT69'), 1, 35791395);
	var adver_lifetime_obj = new varible_obj(get_by_id("ipv6_pppoe_adver_lifetime").value, adver_lifetime_msg , 1, 35791395, false);
	var ipv6_addr_s_suffix = get_by_id("ipv6_addr_range_start_suffix").value;
	var ipv6_addr_e_suffix = get_by_id("ipv6_addr_range_end_suffix").value;
	var ipv6_pppoe_share = get_by_name("ipv6_pppoe_share");
	var ipv6_static_msg = replace_msg(all_ipv6_addr_msg, get_words('IPV6_HINT_PREFIX'));
	var hint_prefix = get_by_id("ipv6_dhcp_pd_hint_prefix").value;
        var temp_hint_prefix = new ipv6_addr_obj(hint_prefix.split(":"), ipv6_static_msg, false, false);
        var prefix_length_msg = replace_msg(check_num_msg, get_words('IPV6_HINT_LENGTH'), 0, 64);
        var prefix_length_obj = new varible_obj(get_by_id("ipv6_dhcp_pd_hint_length").value, prefix_length_msg, 0, 64, false);
        var pltime_msg = replace_msg(check_num_msg, get_words('IPV6_HINT_PLTIME'), 1, 999999);
        var pltime_obj = new varible_obj(get_by_id("ipv6_dhcp_pd_hint_pltime").value, pltime_msg, 1, 999999, false);
        var vltime_msg = replace_msg(check_num_msg, get_words('IPV6_HINT_VLTIME'), 1, 999999);
        var vltime_obj = new varible_obj(get_by_id("ipv6_dhcp_pd_hint_vltime").value, vltime_msg, 1, 999999, false);

	get_by_id("ipv6_wan_proto").value = get_by_id("ipv6_w_proto").value;
	/*
        var is_modify = is_form_modified("form1");
        if (!is_modify && !confirm(get_words('up_jt_1')+"\n"+get_words('up_jt_2')+"\n"+get_words('up_jt_3'))) {
                        return false;
        }
        */
	//get_by_id("ipv6_dhcp_pd_enable").value = get_checked_value(get_by_id("ipv6_dhcp_pd_chk"));
	//get_by_id("ipv6_dhcp_pd_hint_enable").value = get_checked_value(get_by_id("ipv6_dhcp_pd_hint_chk"));
	//get_by_id("ipv6_dhcp_pd_enable_l").value = get_checked_value(get_by_id("ipv6_dhcp_pd_lan"));
//	get_by_id("ipv6_pppoe_dns_enable").value = get_checked_value(get_by_name("ipv6_dns_pppoe_enable"));
//	get_by_id("ipv6_wan_specify_dns").value= get_by_id("ipv6_pppoe_dns_enable").value;


	if (ipv6_pppoe_share[0].checked){
                var ipv4_wan_proto = "<!--# echo wan_proto -->";

                if( ipv4_wan_proto != "pppoe" ){
                        //alert("11"+get_words('IPV6_PPPoE_v4wan'));
                        alert(IPV6_PPPoE_v4wan);
                        return false;
                }
	}
	var mtu_msg = replace_msg(check_num_msg, bwn_MTU, 1300, 1500);
	var mtu_obj = new varible_obj(get_by_id("ipv6_pppoe_mtu").value, mtu_msg , 1300, 1500, false);
	var idle_time_msg = replace_msg(check_num_msg, get_words('IPV6_TEXT73'), 0, 9999);
   // var idle_time_obj = new varible_obj(get_by_id("ipv6_pppoe_idle_time").value, idle_time_msg , 0, 9999, false);
	//var conn_mode = get_by_name("ipv6_pppoe_connect_mode");
		if (!ipv6_pppoe_share[0].checked){
	if(!check_username(get_by_id("ipv6_pppoe_username").value)){
		alert(GW_WAN_PPPOE_USERNAME_INVALID);
		return false;
	}

	if (get_by_id("ipv6_pppoe_password_s").value == "") {
		alert(GW_WAN_PPPOE_PASSWORD_INVALID);
		return false;
	}

        if (!check_pwd("ipv6_pppoe_password_s", "ipv6_pppoe_password_v")){
	        return false;
        } 
		 }
       /*
        if(conn_mode[1].checked){               
	        if (!check_varible(idle_time_obj)){
                return false;
       		}
	}
	*/
        if (!check_varible(mtu_obj)){
	        return false;
        }
	//check the PPPoE IP Address
	if (pppoe_dynamic=="0"){
		if(check_ipv6_symbol(pppoe_ip,"::")==2){ // find two '::' symbol
			return false;
		}else if(check_ipv6_symbol(pppoe_ip,"::")==1){    // find one '::' symbol
			temp_pppoe_ip = new ipv6_addr_obj(pppoe_ip.split("::"), pppoe_ip_msg, false, false);
			if (!check_ipv6_address(temp_pppoe_ip ,"::")){
				return false;
			}
		}else{	//not find '::' symbol
			temp_pppoe_ip  = new ipv6_addr_obj(pppoe_ip.split(":"), pppoe_ip_msg, false, false);
			if (!check_ipv6_address(temp_pppoe_ip,":")){
			return false;
		}
	}
	}
    //check DNS Address
	if(fixDNSIP=="1"){
//	if (primary_dns != ""){
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
//	}	
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
	}

	if(get_by_id("ipv6_dhcp_pd_hint_chk").checked){
		if(check_ipv6_symbol(hint_prefix,"::") == 2){ // find two '::' symbol
			return false;
		}else if(check_ipv6_symbol(hint_prefix,"::") == 1){    // find one '::' symbol
			temp_hint_prefix = new ipv6_addr_obj(hint_prefix.split("::"), ipv6_static_msg, false, false);
			if(temp_hint_prefix.addr[temp_hint_prefix.addr.length-1].length == 0)
			temp_hint_prefix.addr[temp_hint_prefix.addr.length-1] = "1111";
			if (!check_ipv6_address(temp_hint_prefix,"::")){
				return false;
			}
		}else{  //not find '::' symbol
			temp_hint_prefix = new ipv6_addr_obj(hint_prefix.split(":"), ipv6_static_msg, false, false);
			if (!check_ipv6_address(temp_hint_prefix,":")){
				return false;
			}
		}
		if (!check_varible(prefix_length_obj))
			return false;
		if (!check_varible(pltime_obj))
			return false;
		if (get_by_id("ipv6_dhcp_pd_hint_vltime").value != "" && !check_varible(vltime_obj))
			return false;
	}

    //fool-proof for LAN IP Address
    if(!get_by_id("ipv6_pppoe_lan_ip").disabled) {
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
		}
		if((check_mode == 0 || check_mode == 1) && enable_autoconfig == 1){
    			//check the Router Advertisement Lifetime
    			if (!check_varible(adver_lifetime_obj)){
    				return false;
    			}  
    		 	//set Advertisement Lifetime	
			get_by_id("ipv6_ra_adv_valid_lifetime_l_one").value = get_by_id("ipv6_pppoe_adver_lifetime").value * 60 ;
                        get_by_id("ipv6_ra_adv_prefer_lifetime_l_one").value = get_by_id("ipv6_pppoe_adver_lifetime").value * 60 ;			 		
    }else if(check_mode == 2 && enable_autoconfig == 1){
    		  //check the suffix of Address Range(Start)
    		  if(!check_ipv6_address_suffix(ipv6_addr_s_suffix,get_words('IPV6_TEXT70'))){
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
					get_by_id("ipv6_dhcpd_start").value = get_by_id("ipv6_addr_range_start_prefix").value + "::" + get_by_id("ipv6_addr_range_start_suffix").value;
					get_by_id("ipv6_dhcpd_end").value = get_by_id("ipv6_addr_range_end_prefix").value + "::" + get_by_id("ipv6_addr_range_end_suffix").value;
    }		
		//set the wan_proto is pppoe	
		//get_by_id("wan_proto").value = "pppoe";
		//Set PPPoE LAN IP
//		get_pppoe_lan_ip_subnet();
		/*
		if(!check_pppoe_lan_prefix()){
				alert("The prefix of LAN IPv6 Address must be " + ipv6_pppoe_lan_prefix.toUpperCase());
				return false;
		}
		*/	
			var obj = new ccpObject();
		obj.set_param_url('apply.cgi');
		obj.set_ccp_act('set');
		obj.add_param_event('adv_ipv6_poe');
		obj.set_param_next_page('internet_ipv6_pppoe.asp');		
		
		obj.add_param_arg('ipv6_wan_proto',get_by_id("ipv6_w_proto").value);
		//obj.add_param_arg('ipv6_use_link_local',get_checked_value(get_by_id("ipv6_use_link_local_sel")));
		obj.add_param_arg('ipv6_autoconfig',get_checked_value(get_by_id("ipv6_autoconfig_sel")));	
		obj.add_param_arg('ipv6_autoconfig_type',get_by_id("ipv6_autoconfig_type").value);
		obj.add_param_arg('ipv6_pppoe_share',get_checked_value(get_by_name("ipv6_pppoe_share")));
		
		obj.add_param_arg('ipv6_dhcp_pd_enable',get_checked_value(get_by_id("ipv6_dhcp_pd_chk")));
		obj.add_param_arg('ipv6_dhcp_pd_hint_enable',get_checked_value(get_by_id("ipv6_dhcp_pd_hint_chk")));
		obj.add_param_arg('ipv6_pppoe_dns_enable',get_by_id("ipv6_dns_pppoe_enable").value);
		obj.add_param_arg('ipv6_wan_specify_dns',get_by_id("ipv6_pppoe_dns_enable").value);
		if (!ipv6_pppoe_share[0].checked) {
			obj.add_param_arg('ipv6_pppoe_username',get_by_id("ipv6_pppoe_username").value);
			obj.add_param_arg('ipv6_pppoe_password',get_by_id("ipv6_pppoe_password_s").value);
		}
		obj.add_param_arg('ipv6_pppoe_dynamic',get_by_id("ipv6_pppoe_dynamic").value);
		
		obj.add_param_arg('ipv6_pppoe_primary_dns',get_by_id("ipv6_pppoe_primary_dns").value);
		obj.add_param_arg('ipv6_pppoe_secondary_dns',get_by_id("ipv6_pppoe_secondary_dns").value);
		obj.add_param_arg('ipv6_pppoe_mtu',get_by_id("ipv6_pppoe_mtu").value);
		obj.add_param_arg('ipv6_pppoe_lan_ip',get_by_id("ipv6_pppoe_lan_ip").value);
		obj.add_param_arg('ipv6_pppoe_ipaddr',get_by_id("ipv6_pppoe_ipaddr").value);			
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
							<input type="hidden" id="ipv6_autoconfig" name="ipv6_autoconfig" value="<!--# echo ipv6_autoconfig -->">
							<input type="hidden" id="ipv6_dhcp_pd_enable" name="ipv6_dhcp_pd_enable" value="<!--# echo ipv6_dhcp_pd_enable -->">
							<input type="hidden" id="ipv6_dhcp_pd_hint_enable" name="ipv6_dhcp_pd_hint_enable" value="<!--# echo ipv6_dhcp_pd_hint_enable -->">
							<input type="hidden" id="ipv6_dhcp_pd_enable_l" name="ipv6_dhcp_pd_enable_l" value="<!--# echo ipv6_dhcp_pd_enable_l -->">
							<input type="hidden" id="ipv6_pppoe_dns_enable" name="ipv6_pppoe_dns_enable" value="<!--# echo ipv6_pppoe_dns_enable -->">
							<input type="hidden" id="ipv6_pppoe_password" name="ipv6_pppoe_password" value="WDB8WvbXdHtZyM8Ms2RENgHlacJghQyG">
							<input type="hidden" id="ipv6_dhcpd_start" name="ipv6_dhcpd_start" value="<!--# echo ipv6_dhcpd_start -->">
							<input type="hidden" id="ipv6_dhcpd_end" name="ipv6_dhcpd_end" value="<!--# echo ipv6_dhcpd_end -->">				
							<input type="hidden" id="ipv6_wan_proto" name="ipv6_wan_proto" value="<!--# echo ipv6_wan_proto -->">
							<input type="hidden" id="ipv6_ra_adv_valid_lifetime_l_one" name="ipv6_ra_adv_valid_lifetime_l_one" value="<!--# echo ipv6_ra_adv_valid_lifetime_l_one -->">
							<input type="hidden" id="ipv6_ra_adv_prefer_lifetime_l_one" name="ipv6_ra_adv_prefer_lifetime_l_one" value="<!--# echo ipv6_ra_adv_prefer_lifetime_l_one -->">
							<input type="hidden" maxLength=80 size=80 name="link_local_ip_l" id="link_local_ip_l" value="<!--# exec cgi /bin/ipv6 link_local_ip_l -->">
							<input type="hidden" id="wan_proto" name="wan_proto" value="<!--# echo wan_proto -->">
							<input type="hidden" id="page_type" name="page_type" value="IPv6">
							<input type="hidden" id="ipv6_wan_specify_dns" name="ipv6_wan_specify_dns" value="<!--# echo ipv6_wan_specify_dns -->">
								<p>
								
								
								<div class="box_tn">
									<div class="CT"><script>show_words('IPV6_TEXT29a');</script></div>
									<table cellspacing="0" cellpadding="0" class="formarea">
									<tr>
										<td class="CL"><script>show_words('IPV6_TEXT29a')</script></td>
										<td class="CR">
												<select name="ipv6_w_proto" id="ipv6_w_proto" onChange=select_ipv6_wan_page(get_by_id("ipv6_w_proto").value);>
												<option value="ipv6_static"><script>show_words('_net_ipv6_12')</script></option>	<!--Static-->
												<option value="ipv6_autoconfig"><script>show_words('IPV6_TEXT107')</script></option>	<!--Autoconfiguration-->
						<!--					<option value="1"><script>show_words('_help_txt82')</script></option>		Stateless DHCPv6-->
						<!--					<option value="2"><script>show_words('_help_txt84')</script></option>		DHCPv6(Stateful)-->
												<option value="link_local"><script>show_words('_help_txt110')</script></option>	<!--Link-Local-->
												<option value="ipv6_pppoe" selected><script>show_words('_PPPoE')</script></option>			<!--PPPoE-->
												<option value="ipv6_6to4"><script>show_words('IPV6_TEXT36')</script></option>		<!--6to4-->
											</select>
										</td>
									</tr>
									</table>
								</div>
								<br>

						<!-------------- pppoe Settings -------------->
								<div class="box_tn" id="pppoe_setting">
									<div class="CT"><script>show_words('_net_ipv6_08');</script></div>
									<table cellspacing="0" cellpadding="0" class="formarea">
									<tr>
										<td class="CL"><script>show_words('TEXT077')</script></td>
										<td class="CR">
											<input type="radio" name="ipv6_pppoe_share" value="1" onClick="clone_ipv4_pppoe()" checked>
											<script>show_words('IPV6_TEXT129')</script>
											<input type="radio" name="ipv6_pppoe_share" value="0" onClick="clone_ipv4_pppoe()" />
											<script>show_words('TEXT078')</script>
										</td>
									</tr>
									<tr>
										<td class="CL"><script>show_words('_username')</script></td>
										<td class="CR">
											<input type="text" id="ipv6_pppoe_username" name="ipv6_pppoe_username" size="20" maxlength="63" value="<!--# echo ipv6_pppoe_username -->" />
										</td>
									</tr>
									<tr>
										<td class="CL"><script>show_words('_password')</script></td>
										<td class="CR">
											<input type="password" id="ipv6_pppoe_password_s" name="ipv6_pppoe_password_00_s" size="20" maxlength="63" value="<!--# echo ipv6_pppoe_password -->" onfocus="select();" />
										</td>
									</tr>
									<tr>
										<td class="CL"><script>show_words('_verifypw')</script></td>
										<td class="CR">
											<input type="password" id="ipv6_pppoe_password_v" name="ipv6_pppoe_password_00_v" size="20" maxlength="63" value="<!--# echo ipv6_pppoe_password -->" onfocus="select();" />
										</td>
									</tr>
									<tr>
										<td class="CL"><script>show_words('bwn_AM');</script></td>
										<td class="CR">
											<select id="ipv6_pppoe_dynamic" name="ipv6_pppoe_dynamic" onchange="disable_ipv6_poe_ip()">
												<option value="0"><script>show_words('_static');</script></option>
												<option value="1"><script>show_words('KR50');</script></option>
											</select>
										</td>
									</tr>
									
									<tr id="Ipv6pppoeStaticIp">
										<td class="CL"><script>show_words('TEXT071')</script></td>
										<td class="CR">
											<input type="text" id="ipv6_pppoe_ipaddr" name="ipv6_pppoe_ipaddr" size="45" maxlength="45" value='<!--# echo ipv6_pppoe_ipaddr -->' />
										</td>
									</tr>
									<tr id="Ipv6pppoePrefixLen" style="display:none">
										<td class="CL"><script>show_words('IPV6_TEXT74')</script></td>
										<td class="CR">
											<input type="text" id="ipv6_pppoe_prefixlen" name="ipv6_pppoe_prefixlen" size="3" maxlength="3" value='' />
										</td>
									</tr>
									
									<!--tr>
										<td class="CL"><script>show_words('_net_ipv6_09');</script></td>
										<td class="CR">
											<select id="useDefMTU_Select" name="useDefMTU_Select" onchange="useDefMTU(this.value);">
												<option value="0"><script>show_words('_disable');</script></option>
												<option value="1"><script>show_words('_enable');</script></option>
											</select>
										</td>
									</tr-->
									<tr>
										<td class="CL"><script>show_words('_net_ipv6_10')</script></td>
										<td class="CR">
											<input type="text" id="ipv6_pppoe_mtu" name="ipv6_pppoe_mtu" size="10" maxlength="5" value='<!--# echo ipv6_pppoe_mtu -->' />
											<script>show_words('bwn_bytes')</script>
											<script>show_words('_308')</script> 1492
										</td>
									</tr>			
									</table>
								</div>
						<!-------------- End of pppoe Settings -------------->

								<div class="box_tn" id="dns_setting">	<!--Ipv6DNSServer-->
									<div class="CT"><script>show_words('_help_txt94');</script></div>
									<table cellspacing="0" cellpadding="0" class="formarea">
									<tr id="DNSSelect_tr">
										<td class="CL"><script>show_words('_net_ipv6_11')</script></td>
										<td class="CR">
											<select name="ipv6_dns_pppoe_enable" id="ipv6_dns_pppoe_enable" size="1" onChange="disable_ipv6_pppoe_auto_dns()">
												<option value="0"><script>show_words('_disable');</script></option>
												<option value="1"><script>show_words('_enable');</script></option>
											</select></td>
									</tr>
									<tr id="DnsPri_tr">
										<td class="CL"><script>show_words('_dns1')</script></td>
										<td class="CR">
											<input type="text" id="ipv6_pppoe_primary_dns" name="ipv6_pppoe_primary_dns" size="45" maxlength="39" value="<!--# echo ipv6_pppoe_primary_dns -->" />
										</td>
									</tr>
									<tr id="DnsSec_tr">
										<td class="CL"><script>show_words('_dns2')</script></td>
										<td class="CR">
											<input type="text" id="ipv6_pppoe_secondary_dns" name="ipv6_pppoe_secondary_dns" size="45" maxlength="39" value="<!--# echo ipv6_pppoe_secondary_dns -->" />
										</td>
									</tr>
									</table>
								</div>

								<div class="box_tn" id="lan_ip_setting">		<!--LanIpv6-->
									<div class="CT"><script>show_words('_help_txt96');</script></div>
									<table cellspacing="0" cellpadding="0" class="formarea">
									<tr id="LanIpEnDhcpPD_tr">
										<td class="CL"><script>show_words('DHCP_PD_ENABLE')</script></td>
										<td class="CR">
											<input type="checkbox" id="ipv6_dhcp_pd_chk" name="ipv6_dhcp_pd_chk" value="1" onClick="disable_ipv6_dhcp_pd_nochkDNS();" />
										</td>
									</tr>
										<tr id="tr_dhcp_pd_hint_chk" style="display:none ">
					<td class="CL"><script>show_words('IPV6_HINT_CONF');</script> :</td>
					<td class="CR">&nbsp;<input type=checkbox id="ipv6_dhcp_pd_hint_chk" name="ipv6_dhcp_pd_hint_chk" value="1" onclick="disable_ipv6_dhcp_pd_chk();"></td>
  	                    </tr>
			<tr id="tr_dhcp_pd_hint_prefix" style="display:none ">
			<td class="CL"><b><script>show_words('IPV6_HINT_PREFIX');</script> :</b></td>
			<td class="CR">&nbsp;<b>
	                      	<input type=text id="ipv6_dhcp_pd_hint_prefix" name="ipv6_dhcp_pd_hint_prefix" size="39" maxlength="39" value="<!--# echo ipv6_dhcp_pd_hint_prefix -->">/
	                      	<input type=text id="ipv6_dhcp_pd_hint_length" name="ipv6_dhcp_pd_hint_length" size="3" maxlength="3" value="<!--# echo ipv6_dhcp_pd_hint_length -->">
	                      </b></td>
			    </tr> 
			<tr id="tr_dhcp_pd_hint_pltime" style="display:none ">
			<td class="CL"><b><script>show_words('IPV6_HINT_PLTIME');</script> :</b></td>
			<td class="CR">&nbsp;<b>
	                      	<input type=text id="ipv6_dhcp_pd_hint_pltime" name="ipv6_dhcp_pd_hint_pltime" size="10" maxlength="15" value="<!--# echo ipv6_dhcp_pd_hint_pltime -->">
				<script>show_words('_minutes');</script></td>
			</b></td>
			<tr id="tr_dhcp_pd_hint_vltime" style="display:none ">
			<td class="CL"><b><script>show_words('IPV6_HINT_VLTIME');</script> :</b></td>
			<td class="CR">&nbsp;<b>
	                      	<input type=text id="ipv6_dhcp_pd_hint_vltime" name="ipv6_dhcp_pd_hint_vltime" size="10" maxlength="15" value="<!--# echo ipv6_dhcp_pd_hint_vltime -->">
				<script>show_words('_minutes');</script><script>show_words('_optional');</script>
	                      </b></td>
			    </tr>
									<tr id="LanIpAddr_tr">
										<td class="CL"><script>show_words('IPV6_TEXT46')</script></td>
										<td class="CR">
											<input type="text" id="ipv6_pppoe_lan_ip" name="ipv6_pppoe_lan_ip" size="45" maxlength="63" value="<!--# echo ipv6_pppoe_lan_ip -->" onChange="set_ipv6_autoconf_range()">
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
									<tr id="LanIpULAIp_tr" style="display:none">
										<td class="CL"><script>show_words('IPV6_ULA_TEXT08')</script></td>
										<td class="CR">
											<b><span id="lan_ula_ip"></span></b>
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
											<input type="text" id="ipv6_pppoe_adver_lifetime" name="ipv6_pppoe_adver_lifetime" size="20" maxlength="15" value="" />
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
