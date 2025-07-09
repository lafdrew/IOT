<html>
<head>
<link rel="STYLESHEET" type="text/css" href="css_router.css">
<title>D-LINK CORPORATION, INC | WIRELESS ROUTER | HOME</title>
<meta http-equiv=Content-Type content="text/html; charset=UTF-8">
<script type="text/javascript" src="/lang_<!--# echo language -->.js"></script>
<script type="text/javascript" src="/lang.js"></script>
<script language="JavaScript" src="public.js"></script>
<script language="JavaScript" src="public_msg.js"></script>
<script language="javascript" src="./jquery-1.6.1.min.js"></script>
<script language="JavaScript"> 
var submit_button_flag = 0;
var radius_button_flag = 0;
var radius_button_flag_1 = 0;

	function onPageLoad(){
		set_checked(get_by_id("wlan0_enable").value, get_by_id("w_enable"));
		set_checked(get_by_id("wlan1_enable").value, get_by_id("w_enable_1"));
		
		get_by_id("show_ssid").value = ssid_decode("wlan0_ssid");
		get_by_id("show_ssid_1").value = ssid_decode("wlan1_ssid");
		
		set_checked(get_by_id("wlan0_auto_channel_enable").value, get_by_id("auto_channel"));
		set_checked(get_by_id("wlan1_auto_channel_enable").value, get_by_id("auto_channel_1"));
		set_checked("<!--# echo wlan0_ssid_broadcast -->", get_by_name("wlan0_ssid_broadcast"));
		set_checked("<!--# echo wlan1_ssid_broadcast -->", get_by_name("wlan1_ssid_broadcast"));
		
		get_by_id("sel_wlan0_channel").disabled = true;
		get_by_id("sel_wlan1_channel").disabled = true;
		
		set_selectIndex("<!--# echo wlan0_dot11_mode -->", get_by_id("dot11_mode"));
		set_selectIndex("<!--# echo wlan1_dot11_mode -->", get_by_id("dot11_mode_1"));
		set_selectIndex("<!--# echo wlan0_11n_protection -->", get_by_id("11n_protection"));
		set_selectIndex("<!--# echo wlan1_11n_protection -->", get_by_id("11a_protection"));
		
	    var temp_sch_0 = get_by_id("wlan0_schedule").value;
	    var temp_sch_1 = get_by_id("wlan1_schedule").value;
		var temp_data_0 = temp_sch_0.split("/");	
		var temp_data_1 = temp_sch_1.split("/");
		
	  	//2009/4/17 Tina modify:Fixed schedule can't selected.
		//set_selectIndex(temp_data_0[0], get_by_id("wlan0_schedule_select"));
		//set_selectIndex(temp_data_1[0], get_by_id("wlan1_schedule_select"));
		
	  	if((temp_sch_0 == "Always") || (temp_sch_0 == "Never") || (temp_sch_0 == "")){
	   		set_selectIndex(temp_data_0[0], get_by_id("wlan0_schedule_select"));
	    }else{
	  	var temp_index_0 = get_schedule_index(temp_data_0[0]);
	   		get_by_id("wlan0_schedule_select").selectedIndex=temp_index_0+2;
	     }
  
		  if((temp_sch_1 == "Always") || (temp_sch_1 == "Never")|| (temp_sch_1 == "")){
		   	set_selectIndex(temp_data_1[0], get_by_id("wlan1_schedule_select"));
		  }else{
		     var temp_index_1 = get_schedule_index(temp_data_1[0]);
	   		 get_by_id("wlan1_schedule_select").selectedIndex=temp_index_1+2;
		  }
  
		
		var wlan0_psk_cipher_type= "<!--# echo wlan0_psk_cipher_type -->";
		var wlan1_psk_cipher_type= "<!--# echo wlan1_psk_cipher_type -->";
		var temp_r0 = get_by_id("wlan0_eap_radius_server_0").value;
		var temp_r00 = get_by_id("wlan1_eap_radius_server_0").value;
		var Dr0 = temp_r0.split("/");
		var Dr00 = temp_r00.split("/");
		
		if(Dr0.length > 1){
			get_by_id("radius_ip1").value=Dr0[0];
			get_by_id("radius_port1").value=Dr0[1];
			get_by_id("radius_pass1").value=Dr0[2];
		}
		if(Dr00.length > 1){
			get_by_id("radius_ip1_1").value=Dr00[0];
			get_by_id("radius_port1_1").value=Dr00[1];
			get_by_id("radius_pass1_1").value=Dr00[2];
		}
		
		var temp_r1 = get_by_id("wlan0_eap_radius_server_1").value;
		var temp_r11 = get_by_id("wlan1_eap_radius_server_1").value;
		var Dr1 = temp_r1.split("/");
		var Dr11 = temp_r11.split("/");
		if(Dr1.length > 1){
			get_by_id("radius_ip2").value=Dr1[0];
			get_by_id("radius_port2").value=Dr1[1];
			get_by_id("radius_pass2").value=Dr1[2];
		}
		if(Dr11.length > 1){
			get_by_id("radius_ip2_1").value=Dr11[0];
			get_by_id("radius_port2_1").value=Dr11[1];
			get_by_id("radius_pass2_1").value=Dr11[2];
		}
		
		var wlan0_eap_mac_auth = get_by_id("wlan0_eap_mac_auth").value;
		var wlan1_eap_mac_auth = get_by_id("wlan1_eap_mac_auth").value;
		if(wlan0_eap_mac_auth == 0){
			get_by_id("radius_auth_mac1").checked = false;
			get_by_id("radius_auth_mac2").checked = false;
		}else if(wlan0_eap_mac_auth == 1){
			get_by_id("radius_auth_mac1").checked = true;
			get_by_id("radius_auth_mac2").checked = false;
		}else if(wlan0_eap_mac_auth == 2){
			get_by_id("radius_auth_mac1").checked = false;
			get_by_id("radius_auth_mac2").checked = true;
		}else{
			get_by_id("radius_auth_mac1").checked = true;
			get_by_id("radius_auth_mac2").checked = true;
		}
		
		if(wlan1_eap_mac_auth == 0){
			get_by_id("radius_auth_mac1_1").checked = false;
			get_by_id("radius_auth_mac2_1").checked = false;
		}else if(wlan1_eap_mac_auth == 1){
			get_by_id("radius_auth_mac1_1").checked = true;
			get_by_id("radius_auth_mac2_1").checked = false;
		}else if(wlan1_eap_mac_auth == 2){
			get_by_id("radius_auth_mac1_1").checked = false;
			get_by_id("radius_auth_mac2_1").checked = true;
		}else{
			get_by_id("radius_auth_mac1_1").checked = true;
			get_by_id("radius_auth_mac2_1").checked = true;
		}
		
		set_selectIndex(get_by_id("wlan0_wep_default_key").value, get_by_id("wep_def_key"));
		set_selectIndex(get_by_id("wlan1_wep_default_key").value, get_by_id("wep_def_key_1"));

		var wlan0_security= "<!--# echo wlan0_security -->";
		var wlan1_security= "<!--# echo wlan1_security -->";
		var security = wlan0_security.split("_");
		var security1 = wlan1_security.split("_");
		
		//2.4G
		if(wlan0_security == "disable"){				//Disabled
			set_selectIndex(0, get_by_id("wep_type"));
		}else if(security[0] == "wep"){					//WEP
			get_by_id("show_wep").style.display = "";
			set_selectIndex(1, get_by_id("wep_type"));
			//check auth_type is open
			if (security[1] == "open"||security[1] =="auto"){
				security[1] = "auto";	
			set_selectIndex(security[1], get_by_id("auth_type"));
			}else{
			        set_selectIndex(security[1], get_by_id("auth_type"));
			}
			if(security[2] == "64"){
				set_selectIndex(5, get_by_id("wep_key_len"));
			}else{
				set_selectIndex(13, get_by_id("wep_key_len"));
			}
		}else{
			if(security[1] == "psk"){					//PSK
			    get_by_id("show_wpa_psk").style.display = "";
				set_selectIndex(2, get_by_id("wep_type"));
			}else if(security[1] == "eap"){				//EAP
			    get_by_id("show_wpa_eap").style.display = "";
				set_selectIndex(3, get_by_id("wep_type"));
			}
			//set wpa_mode
			if(security[0] == "wpa2auto"){
				get_by_id("show_wpa").style.display = "";	
				set_selectIndex(2, get_by_id("wpa_mode"));
			}else{
				get_by_id("wpa_mode").value = security[0];
			}
		}
		//5G
		if(wlan1_security == "disable"){				//Disabled
			set_selectIndex(0, get_by_id("wep_type_1"));
		}else if(security1[0] == "wep"){					//WEP
			get_by_id("show_wep_1").style.display = "";
			set_selectIndex(1, get_by_id("wep_type_1"));
                        //check auth_type is open
			if (security1[1] == "open"||security1[1] =="auto"){
				security[1] = "auto";	
				set_selectIndex(security1[1], get_by_id("auth_type_1"));
			}else{
			set_selectIndex(security1[1], get_by_id("auth_type_1"));
			}
			
			if(security1[2] == "64"){
				set_selectIndex(5, get_by_id("wep_key_len_1"));
			}else{
				set_selectIndex(13, get_by_id("wep_key_len_1"));
			}
		}else{
			if(security1[1] == "psk"){					//PSK
				get_by_id("show_wpa_psk_1").style.display = "";
				set_selectIndex(2, get_by_id("wep_type_1"));
			}else if(security1[1] == "eap"){				//EAP
				get_by_id("show_wpa_eap_1").style.display = "";
				set_selectIndex(3, get_by_id("wep_type_1"));
			}
			//set wpa_mode
			if(security1[0] == "wpa2auto"){
				get_by_id("show_wpa_1").style.display = "";	
				set_selectIndex(2, get_by_id("wpa_mode_1"));
			}else{
				get_by_id("wpa_mode_1").value = security1[0];
			}
		}

		change_wep_key_fun();
		change_wep_key_fun_1();
		set_selectIndex("<!--# echo wlan0_psk_cipher_type -->",get_by_id("c_type"));
		set_selectIndex("<!--# echo wlan1_psk_cipher_type -->",get_by_id("c_type_1"));
		//show_buttons();
		//change_mode();
		var login_who= checksessionStorage();
		if(login_who== "user"){
			DisableEnableForm(document.form1,true);	
		}else{
			disable_wireless();
			disable_wireless_1();
			disable_channel();
			disable_channel_1();
			show_chan_width();
			show_chan_width_1();
		}
		    set_form_default_values("form1");
	}

	function change_wep_key_fun(){
		var length = parseInt(get_by_id("wep_key_len").value) * 2;
		var key_length = get_by_id("wep_key_len").selectedIndex;
		var key_type = get_by_id("wlan0_wep_display").value;
		var key1 = get_by_id("wlan0_wep" + key_num_array[key_length] + "_key_1").value;
		var key2 = get_by_id("wlan0_wep" + key_num_array[key_length] + "_key_1").value;
		var key3 = get_by_id("wlan0_wep" + key_num_array[key_length] + "_key_1").value;
		var key4 = get_by_id("wlan0_wep" + key_num_array[key_length] + "_key_1").value;
		
		get_by_id("show_resert1").innerHTML = "<input type=\"password\" id=\"key1\" name=\"key1\" maxlength=" + length + " size=\"31\" value=" + key1 + " >"
		get_by_id("show_resert2").innerHTML = "<input type=\"hidden\" id=\"key2\" name=\"key2\" maxlength=" + length + " size=\"31\" value=" + key2 + " >"
		get_by_id("show_resert3").innerHTML = "<input type=\"hidden\" id=\"key3\" name=\"key3\" maxlength=" + length + " size=\"31\" value=" + key3 + " >"
		get_by_id("show_resert4").innerHTML = "<input type=\"hidden\" id=\"key4\" name=\"key4\" maxlength=" + length + " size=\"31\" value=" + key4 + " >"		
	}
	function change_wep_key_fun_1(){
		var length_1 = parseInt(get_by_id("wep_key_len_1").value) * 2;
		var key_length_1 = get_by_id("wep_key_len_1").selectedIndex;
		var key_type_1 = get_by_id("wlan1_wep_display").value;
		var key5 = get_by_id("wlan1_wep" + key_num_array[key_length_1] + "_key_1").value;
		var key6 = get_by_id("wlan1_wep" + key_num_array[key_length_1] + "_key_1").value;
		var key7 = get_by_id("wlan1_wep" + key_num_array[key_length_1] + "_key_1").value;
		var key8 = get_by_id("wlan1_wep" + key_num_array[key_length_1] + "_key_1").value;
		
		get_by_id("show_resert5").innerHTML = "<input type=\"password\" id=\"key5\" name=\"key5\" maxlength=" + length_1 + " size=\"31\" value=" + key5 + " >"
		get_by_id("show_resert6").innerHTML = "<input type=\"hidden\" id=\"key6\" name=\"key6\" maxlength=" + length_1 + " size=\"31\" value=" + key6 + " >"
		get_by_id("show_resert7").innerHTML = "<input type=\"hidden\" id=\"key7\" name=\"key7\" maxlength=" + length_1 + " size=\"31\" value=" + key7 + " >"
		get_by_id("show_resert8").innerHTML = "<input type=\"hidden\" id=\"key8\" name=\"key8\" maxlength=" + length_1 + " size=\"31\" value=" + key8 + " >"		
	}

    function check_8021x(){
	var pattern = /[0-9]/;
    	var ip1 = get_by_id("radius_ip1").value;
    	var ip2 = get_by_id("radius_ip2").value;
	var port1 = get_by_id("radius_port1").value;
	var port2 = get_by_id("radius_port2").value;
	var time = get_by_id("wlan0_eap_reauth_period").value;
		
	if(pattern.test(port1) == false || pattern.test(port2) == false) {
		alert(MSG008);
		return false;
	}
	
	if(pattern.test(time) == false) {
		alert(YM119);
		return false;
	}
        
        var radius1_msg = replace_msg(all_ip_addr_msg,"Radius Server 1");
    	var radius2_msg = replace_msg(all_ip_addr_msg,"Radius Server 2");
        
        var temp_ip1 = new addr_obj(ip1.split("."), radius1_msg, false, false);
        var temp_ip2 = new addr_obj(ip2.split("."), radius2_msg, true, false);
	var temp_radius1 = new raidus_obj(temp_ip1, port1, get_by_id("radius_pass1").value);
        var temp_radius2 = new raidus_obj(temp_ip2, port2, get_by_id("radius_pass2").value);
        
        if (!check_radius(temp_radius1)){
    		return false;        	               
    	}else if (ip2 != "" && ip2 != "0.0.0.0"){
    		if (!check_radius(temp_radius2)){
    			return false;        	               
    		}
    	}	
    	return true;	    
    }
    function check_8021x_1(){
	var pattern = /[0-9]/;
    	var ip1 = get_by_id("radius_ip1_1").value;
    	var ip2 = get_by_id("radius_ip2_1").value;
	var port1 = get_by_id("radius_port1_1").value;
	var port2 = get_by_id("radius_port2_1").value;
	var time = get_by_id("wlan1_eap_reauth_period").value;

	if(pattern.test(port1) == false || pattern.test(port2) == false) {
		alert(MSG008);
		return false;
	}
	
	if(pattern.test(time) == false) {
		alert(YM119);
		return false;
	}
        
        var radius1_msg = replace_msg(all_ip_addr_msg,"Radius Server 1");
    	var radius2_msg = replace_msg(all_ip_addr_msg,"Radius Server 2");
        
        var temp_ip1 = new addr_obj(ip1.split("."), radius1_msg, false, false);
        var temp_ip2 = new addr_obj(ip2.split("."), radius2_msg, true, false);
        var temp_radius1 = new raidus_obj(temp_ip1, port1, get_by_id("radius_pass1_1").value);
        var temp_radius2 = new raidus_obj(temp_ip2, port2, get_by_id("radius_pass2_1").value);
         
        if (!check_radius(temp_radius1)){
    		return false;        	               
    	}else if (ip2 != "" && ip2 != "0.0.0.0"){
    		if (!check_radius(temp_radius2)){
    			return false;        	               
    		}
    	}	
    	return true;	    
    }
	    
    function check_psk(){
		var psk_value = get_by_id("wlan0_psk_pass_phrase").value;
		if (psk_value.length < 8){                   
			alert(YM116);
				return false;
		}else if (psk_value.length > 63){
			if(!isHex(psk_value)){
				alert(GW_WLAN_WPA_PSK_HEX_STRING_INVALID);
				return false;
			}
        }
        return true;         
    }
    function check_psk_1(){
		var psk_value = get_by_id("wlan1_psk_pass_phrase").value;
		if (psk_value.length < 8){                   
			alert(YM116);
				return false;
		}else if (psk_value.length > 63){
			if(!isHex(psk_value)){
				alert(GW_WLAN_WPA_PSK_HEX_STRING_INVALID);
				return false;
			}
        }
        return true;         
    }
   
	function show_wpa_wep(){			
		var wep_type = get_by_id("wep_type").value;	
		
		get_by_id("show_wep").style.display = "none";
		get_by_id("show_wpa").style.display = "none";	
	    get_by_id("show_wpa_psk").style.display = "none";
	    get_by_id("show_wpa_eap").style.display = "none";
			
		if (wep_type == 1){			//WEP
			get_by_id("show_wep").style.display = "";
		}else if(wep_type == 2){	//WPA-Personal
			check_wps_psk_eap();
			get_by_id("show_wpa").style.display = "";	
			get_by_id("show_wpa_psk").style.display = "";	
		}else if(wep_type == 3){	//WPA-Enterprise
			if(check_wps_psk_eap()){
			get_by_id("show_wpa").style.display = "";	
			get_by_id("show_wpa_eap").style.display = "";
		}
    }
    }
    function show_wpa_wep_1(){			
		var wep_type = get_by_id("wep_type_1").value;	
		
		get_by_id("show_wep_1").style.display = "none";
		get_by_id("show_wpa_1").style.display = "none";	
	    get_by_id("show_wpa_psk_1").style.display = "none";
	    get_by_id("show_wpa_eap_1").style.display = "none";
			
		if (wep_type == 1){			//WEP
			get_by_id("show_wep_1").style.display = "";
		}else if(wep_type == 2){	//WPA-Personal
			check_wps_psk_eap_1();
			get_by_id("show_wpa_1").style.display = "";	
			get_by_id("show_wpa_psk_1").style.display = "";	
		}else if(wep_type == 3){	//WPA-Enterprise
			if(check_wps_psk_eap_1()){
			get_by_id("show_wpa_1").style.display = "";	
			get_by_id("show_wpa_eap_1").style.display = "";
		}
    }
    }
       function show_chan_width(){
 		var mode = get_by_id("dot11_mode").selectedIndex;	
		
		switch(mode){
		case 0:
		case 1:
		case 3:
			get_by_id("show_channel_width").style.display = "none";
			get_by_id("11n_protection").value ="20";
			break;			
		default:
			get_by_id("show_channel_width").style.display = "";
			break;	
		}  	  
       }
       
       function show_chan_width_1(){
 		var mode = get_by_id("dot11_mode_1").selectedIndex;	
		
		switch(mode){
		case 1:
			get_by_id("show_channel_width_1").style.display = "none";
			get_by_id("11a_protection").value ="20";
			break;
		default:
			get_by_id("show_channel_width_1").style.display = "";
			break;	
		}  	  
       }

	function disable_channel(){		
		if(get_by_id("w_enable").checked)
		get_by_id("sel_wlan0_channel").disabled = get_by_id("auto_channel").checked;
	}
	function disable_channel_1(){		
		if(get_by_id("w_enable_1").checked) {
			get_by_id("sel_wlan1_channel").disabled = get_by_id("auto_channel_1").checked;
			set_channel_1();
		}
	}

	function disable_wireless(){
		var is_display = "";
		get_by_id("auto_channel").disabled = !get_by_id("w_enable").checked;
		get_by_id("show_ssid").disabled = !get_by_id("w_enable").checked;
		get_by_id("dot11_mode").disabled = !get_by_id("w_enable").checked;
		get_by_id("sel_wlan0_channel").disabled = !get_by_id("w_enable").checked;
		get_by_id("11n_protection").disabled = !get_by_id("w_enable").checked;
		get_by_name("wlan0_ssid_broadcast")[0].disabled = !get_by_id("w_enable").checked;
		get_by_name("wlan0_ssid_broadcast")[1].disabled = !get_by_id("w_enable").checked;
		get_by_id("add_new_schedule").disabled = !get_by_id("w_enable").checked;
		get_by_id("wlan0_schedule_select").disabled = !get_by_id("w_enable").checked;
		disable_channel();
		if(!get_by_id("w_enable").checked){
			get_by_id("show_security").style.display = "none";
			get_by_id("show_wep").style.display = "none";;
			get_by_id("show_wpa").style.display = "none";;	
			get_by_id("show_wpa_psk").style.display = "none";;
			get_by_id("show_wpa_eap").style.display = "none";;		
		}else{
			get_by_id("show_security").style.display = "";
			show_wpa_wep();
		}
	}
	
	function disable_wireless_1(){
		var is_display = "";
		get_by_id("auto_channel_1").disabled = !get_by_id("w_enable_1").checked;
		get_by_id("show_ssid_1").disabled = !get_by_id("w_enable_1").checked;
		get_by_id("dot11_mode_1").disabled = !get_by_id("w_enable_1").checked;
		get_by_id("sel_wlan1_channel").disabled = !get_by_id("w_enable_1").checked;
		get_by_id("11a_protection").disabled = !get_by_id("w_enable_1").checked;
		get_by_name("wlan1_ssid_broadcast")[0].disabled = !get_by_id("w_enable_1").checked;
		get_by_name("wlan1_ssid_broadcast")[1].disabled = !get_by_id("w_enable_1").checked;
		get_by_id("add_new_schedule2").disabled = !get_by_id("w_enable_1").checked;
		get_by_id("wlan1_schedule_select").disabled = !get_by_id("w_enable_1").checked;
		disable_channel_1();
		if(!get_by_id("w_enable_1").checked){
			get_by_id("show_security_1").style.display = "none";
			get_by_id("show_wep_1").style.display = "none";;
			get_by_id("show_wpa_1").style.display = "none";;	
			get_by_id("show_wpa_psk_1").style.display = "none";;
			get_by_id("show_wpa_eap_1").style.display = "none";;		
		}else{
			get_by_id("show_security_1").style.display = "";
			show_wpa_wep_1();
		}
	}

	function show_radius(){
		get_by_id("radius2").style.display = "none";
		get_by_id("none_radius2").style.display = "none";
		get_by_id("show_radius2").style.display = "none";
		if(radius_button_flag){
			get_by_id("radius2").style.display = "";
			radius_button_flag = 0;
		}else{
			get_by_id("none_radius2").style.display = "";
			get_by_id("show_radius2").style.display = "";
			radius_button_flag = 1;
		}
	}
	function show_radius_1(){
		get_by_id("radius2_1").style.display = "none";
		get_by_id("none_radius2_1").style.display = "none";
		get_by_id("show_radius2_1").style.display = "none";
		if(radius_button_flag_1){
			get_by_id("radius2_1").style.display = "";
			radius_button_flag_1 = 0;
		}else{
			get_by_id("none_radius2_1").style.display = "";
			get_by_id("show_radius2_1").style.display = "";
			radius_button_flag_1 = 1;
		}
	}

	function send_key_value(key_length){
		var key_type = get_by_id("wlan0_wep_display").value;

		for(var i = 1; i < 5; i++){
			get_by_id("wlan0_wep" + key_length + "_key_" + i).value = get_by_id("key" + i).value;
		}
		
		get_by_id("asp_temp_37").value = get_by_id("wlan0_wep"+ key_length +"_key_1").value;
		get_by_id("asp_temp_38").value = get_by_id("wlan0_wep"+ key_length +"_key_1").value;
		get_by_id("asp_temp_39").value = get_by_id("wlan0_wep"+ key_length +"_key_1").value;
		get_by_id("asp_temp_40").value = get_by_id("wlan0_wep"+ key_length +"_key_1").value;
                
                get_by_id("wlan0_wep"+ key_length +"_key_1").value = get_by_id("asp_temp_37").value;
		get_by_id("wlan0_wep"+ key_length +"_key_2").value = get_by_id("asp_temp_37").value;
		get_by_id("wlan0_wep"+ key_length +"_key_3").value = get_by_id("asp_temp_37").value;
		get_by_id("wlan0_wep"+ key_length +"_key_4").value = get_by_id("asp_temp_37").value;  
	}
	function send_key_value_1(key_length_1){
		var key_type_1 = get_by_id("wlan1_wep_display").value;

		for(var i = 1; i < 5; i++){
				get_by_id("wlan1_wep" + key_length_1 + "_key_" + i).value = get_by_id("key" + (i+4)).value;
		}
		
		get_by_id("asp_temp_53").value = get_by_id("wlan1_wep"+ key_length_1 +"_key_1").value;
		get_by_id("asp_temp_54").value = get_by_id("wlan1_wep"+ key_length_1 +"_key_1").value;
		get_by_id("asp_temp_55").value = get_by_id("wlan1_wep"+ key_length_1 +"_key_1").value;
		get_by_id("asp_temp_56").value = get_by_id("wlan1_wep"+ key_length_1 +"_key_1").value;
               
                get_by_id("wlan1_wep"+ key_length_1 +"_key_1").value = get_by_id("asp_temp_53").value;
		get_by_id("wlan1_wep"+ key_length_1 +"_key_2").value = get_by_id("asp_temp_53").value;
		get_by_id("wlan1_wep"+ key_length_1 +"_key_3").value = get_by_id("asp_temp_53").value;
		get_by_id("wlan1_wep"+ key_length_1 +"_key_4").value = get_by_id("asp_temp_53").value;  	
	}
	
	
	function send_cipher_value(){
		if(get_by_id("c_type").selectedIndex == 0){
			get_by_id("wlan0_psk_cipher_type").value = "tkip";
		}else if(get_by_id("c_type").selectedIndex == 1){
			get_by_id("wlan0_psk_cipher_type").value = "aes";
		}else{
			get_by_id("wlan0_psk_cipher_type").value = "both";
		}
	}
	function send_cipher_value_1(){
		if(get_by_id("c_type_1").selectedIndex == 0){
			get_by_id("wlan1_psk_cipher_type").value = "tkip";
		}else if(get_by_id("c_type_1").selectedIndex == 1){
			get_by_id("wlan1_psk_cipher_type").value = "aes";
		}else{
			get_by_id("wlan1_psk_cipher_type").value = "both";
		}
	}
        
	function send_request(){	
		if (!is_form_modified("form1") && !confirm(_ask_nochange)) {
			return false;
		}
				
		//2.4G
		var wlan_ssid = get_by_id("show_ssid").value
		var wep_type_value = get_by_id("wep_type").value;
		var key_length =get_by_id("wep_key_len").selectedIndex;
		var wlan0_dot11_mode = get_by_id("dot11_mode").value;
		var c_type_value = get_by_id("c_type").value;

		var rekey_msg = replace_msg(check_num_msg, bws_GKUI, 30, 65535);
		var temp_rekey = new varible_obj(get_by_id("wlan0_gkey_rekey_time").value, rekey_msg, 30, 65535, false);
		
		//5G
		var wlan_ssid_1 = get_by_id("show_ssid_1").value
		var wep_type_value_1 = get_by_id("wep_type_1").value;
		var key_length_1 =get_by_id("wep_key_len_1").selectedIndex;		
		var rekey_msg_1 = replace_msg(check_num_msg, bws_GKUI, 30, 65535);
		var temp_rekey_1 = new varible_obj(get_by_id("wlan1_gkey_rekey_time").value, rekey_msg, 30, 65535, false);
		var wlan1_dot11_mode = get_by_id("dot11_mode_1").value;
		var c_type_1_value = get_by_id("c_type_1").value;
		
		if(!(check_ssid("show_ssid"))){
				return false;
		}
		if(!(check_ssid("show_ssid_1"))){
				return false;
		}

		if(!(ischeck_wps("auto"))){
				return false;
		}
		//2.4G
		if(get_by_id("w_enable").checked)
		{ 
			if(wep_type_value == 1){		//WEP
				if (wlan0_dot11_mode == "11n"){
					alert(MSG044);
					return false;
				}else{
					if(!check_key()){
						return false;
					}
				}
			}else if(wep_type_value == 2){	//PSK
				if ((wlan0_dot11_mode == "11n") && (c_type_value == "tkip")){
					alert(MSG045);
					return false;
				}else{
					if (!check_varible(temp_rekey)){
						return false;
					}
					if(!check_psk()){
						return false;
					}
				}
			}else if(wep_type_value == 3){	//EAP
				if ((wlan0_dot11_mode == "11n") && (c_type_value == "tkip")){
						alert(MSG045);
						return false;
					}
				if (!check_varible(temp_rekey)){
					return false;
				}
				if(!check_8021x()){
					return false;
				}
			}
		}
		//5G
		if(get_by_id("w_enable_1").checked)
		{
			if(wep_type_value_1 == 1){		//WEP
				if (wlan1_dot11_mode == "11n"){
					alert(MSG044);
					return false;
				}else{
					if(!check_key_1()){
						return false;
					}
				}
			}else if(wep_type_value_1 == 2){	//PSK
				if ((wlan1_dot11_mode == "11n") && (c_type_1_value == "tkip")){
					alert(MSG045);
					return false;
				}else{
					if (!check_varible(temp_rekey_1)){
						return false;
					}
					if(!check_psk_1()){
						return false;
					}
				}
			}else if(wep_type_value_1 == 3){	//EAP
				if ((wlan1_dot11_mode == "11n") && (c_type_1_value == "tkip")){
					alert(MSG045);
					return false;
				}
				if (!check_varible(temp_rekey_1)){
					return false;
				}
				
				if(!check_8021x_1()){
					return false;
				}
			}
		}	
		<!--save wireless network setting-2.4G-->
		get_by_id("wlan0_enable").value = get_checked_value(get_by_id("w_enable"));
		get_by_id("wlan0_auto_channel_enable").value = get_checked_value(get_by_id("auto_channel"));
		get_by_id("wlan0_channel").value = get_by_id("sel_wlan0_channel").value;
		get_by_id("wlan0_dot11_mode").value = get_by_id("dot11_mode").value;
		get_by_id("wlan0_11n_protection").value = get_by_id("11n_protection").value;
		
		get_by_id("wlan0_wep_default_key").value = get_by_id("wep_def_key").value;
		var wpa_mode = get_by_id("wpa_mode").value;
				
		<!--save wireless network setting-5G-->
		get_by_id("wlan1_enable").value = get_checked_value(get_by_id("w_enable_1"));
		get_by_id("wlan1_auto_channel_enable").value = get_checked_value(get_by_id("auto_channel_1"));
		get_by_id("wlan1_channel").value = get_by_id("sel_wlan1_channel").value;
		get_by_id("wlan1_dot11_mode").value = get_by_id("dot11_mode_1").value;
		get_by_id("wlan1_11n_protection").value = get_by_id("11a_protection").value;
		
		get_by_id("wlan1_wep_default_key").value = get_by_id("wep_def_key_1").value;
		var wpa_mode_1 = get_by_id("wpa_mode_1").value;
		
		<!--save security -2.4G-->

		if(wep_type_value == 1){			//WEP
			get_by_id("wlan0_security").value = "wep_"+ get_by_id("auth_type").value +"_"+ key_num_array[key_length];
			//save wep key
			send_key_value(key_num_array[key_length]);
		}else if(wep_type_value == 2){		//PSK
			if(wpa_mode == "auto"){
				get_by_id("wlan0_security").value = "wpa2auto_psk";
			}else{
				get_by_id("wlan0_security").value = wpa_mode + "_psk";
			}
			send_cipher_value();
			//save psk value
			get_by_id("asp_temp_37").value = get_by_id("wlan0_psk_pass_phrase").value;
		}else if(wep_type_value == 3){		//EAP
			if(wpa_mode == "auto"){
				get_by_id("wlan0_security").value = "wpa2auto_eap";
			}else{
				get_by_id("wlan0_security").value = wpa_mode + "_eap";
			}
			if(get_by_id("w_enable").checked){
				get_by_id("wps_enable").value = "0";//wps enable=0 if EAP mode
			}
			send_cipher_value();
			//save radius server
			var r_ip_0 = get_by_id("radius_ip1").value;
			var r_port_0 = get_by_id("radius_port1").value;
			var r_pass_0 = get_by_id("radius_pass1").value;
			var dat0 =r_ip_0 +"/"+ r_port_0 +"/"+ r_pass_0;
			get_by_id("wlan0_eap_radius_server_0").value = dat0;
			
			if(radius_button_flag){
				var r_ip_1 = get_by_id("radius_ip2").value;
				var r_port_1 = get_by_id("radius_port2").value;
				var r_pass_1 = get_by_id("radius_pass2").value;
				var dat1 =r_ip_1 +"/"+ r_port_1 +"/"+ r_pass_1;
				get_by_id("wlan0_eap_radius_server_1").value = dat1;
			}

			if((get_by_id("radius_auth_mac1").checked == false) && (get_by_id("radius_auth_mac2").checked = false))
			get_by_id("wlan0_eap_mac_auth").value = 0;
			else if((get_by_id("radius_auth_mac1").checked == true) && (get_by_id("radius_auth_mac2").checked = false))
			get_by_id("wlan0_eap_mac_auth").value = 1;
			else if((get_by_id("radius_auth_mac1").checked == false) && (get_by_id("radius_auth_mac2").checked = true))
				get_by_id("wlan0_eap_mac_auth").value = 2;
			else
				get_by_id("wlan0_eap_mac_auth").value = 3;

		}else{								//DISABLED
			get_by_id("wlan0_security").value = "disable";
		}
		
		<!--save security -5G-->
		if(wep_type_value_1 == 1){			//WEP
			get_by_id("wlan1_security").value = "wep_"+ get_by_id("auth_type_1").value +"_"+ key_num_array[key_length_1];
			//save wep key
			send_key_value_1(key_num_array[key_length_1]);
		}else if(wep_type_value_1 == 2){		//PSK
			if(wpa_mode_1 == "auto"){
				get_by_id("wlan1_security").value = "wpa2auto_psk";
			}else{
				get_by_id("wlan1_security").value = wpa_mode_1 + "_psk";
			}
			send_cipher_value_1();
			//save psk value
			get_by_id("asp_temp_53").value = get_by_id("wlan1_psk_pass_phrase").value;
		}else if(wep_type_value_1 == 3){		//EAP
			if(wpa_mode_1 == "auto"){
				get_by_id("wlan1_security").value = "wpa2auto_eap";
			}else{
				get_by_id("wlan1_security").value = wpa_mode_1 + "_eap";
			}
			if(get_by_id("w_enable_1").checked){
				get_by_id("wps_enable").value = "0";//wps enable=0 if EAP mode
			}
			send_cipher_value_1();
			//save radius server
			var r_ip_00 = get_by_id("radius_ip1_1").value;
			var r_port_00 = get_by_id("radius_port1_1").value;
			var r_pass_00 = get_by_id("radius_pass1_1").value;
			var dat00 =r_ip_00 +"/"+ r_port_00 +"/"+ r_pass_00;
			get_by_id("wlan1_eap_radius_server_0").value = dat00;
			
			if(radius_button_flag_1){
				var r_ip_11 = get_by_id("radius_ip2_1").value;
				var r_port_11 = get_by_id("radius_port2_1").value;
				var r_pass_11 = get_by_id("radius_pass2_1").value;
				var dat11 =r_ip_11 +"/"+ r_port_11 +"/"+ r_pass_11;
				get_by_id("wlan1_eap_radius_server_1").value = dat11;
			}

			if((get_by_id("radius_auth_mac1_1").checked == false) && (get_by_id("radius_auth_mac2_1").checked = false))
				get_by_id("wlan1_eap_mac_auth").value = 0;
			else if((get_by_id("radius_auth_mac1_1").checked == true) && (get_by_id("radius_auth_mac2_1").checked = false))
				get_by_id("wlan1_eap_mac_auth").value = 1;
			else if((get_by_id("radius_auth_mac1_1").checked == false) && (get_by_id("radius_auth_mac2_1").checked = true))
				get_by_id("wlan1_eap_mac_auth").value = 2;
			else
				get_by_id("wlan1_eap_mac_auth").value = 3;

		}else{								//DISABLED
			get_by_id("wlan1_security").value = "disable";
		}
			
		//save wps_configured_mode  -- >only check SSID / Security
		var org_ssid_2g = ssid_decode("wlan0_ssid");
                var org_ssid_5g = ssid_decode("wlan1_ssid");


                if (get_by_id("show_ssid").value != org_ssid_2g || 
		    get_by_id("show_ssid_1").value != org_ssid_5g || 
		    get_by_id("wlan0_security").value !== "<!--# echo wlan0_security -->" || 
		    get_by_id("wlan1_security").value !== "<!--# echo wlan1_security -->" ||
		    get_by_id("wlan0_psk_cipher_type").value != "<!--# echo wlan0_psk_cipher_type -->" ||
		    get_by_id("wlan1_psk_cipher_type").value != "<!--# echo wlan1_psk_cipher_type -->" ||
		    get_by_id("wlan0_psk_pass_phrase").value != "<!--# echot wlan0_psk_pass_phrase -->" ||
		    get_by_id("wlan1_psk_pass_phrase").value != "<!--# echot wlan1_psk_pass_phrase -->"
		    ){
                        get_by_id("wps_configured_mode").value = 5;
			//if ("<!--# echo wps_configured_mode -->" === "1" && get_by_id("wps_enable").value === "1")
			//get_by_id("disable_wps_pin").value = 1;
                        //get_by_id("wps_lock").value = 1;
                }

 		//get_by_id("wps_configured_mode").value = 5;	//save wps_configured_mode when setting wireless
		
		var gues_enable = "<!--# echo wlan0_vap1_enable -->";
		
		if(get_by_id("w_enable").checked &&  gues_enable ==1)
		{
			if (!isWepConflict())
				return false;
		}		

		if (!wps_WarrMsg(get_by_id("w_enable").checked , get_by_id("w_enable_1").checked))
			return false;

		if(submit_button_flag == 0){
			submit_button_flag = 1;
			get_by_id("wlan0_ssid").value = get_by_id("show_ssid").value;
			get_by_id("wlan1_ssid").value = get_by_id("show_ssid_1").value;
			WPS();
			return true;
		}else{
			return false;
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
  
	<!--2.4G-->
//Display DFS channel  
	function iniRangeOption() {
		var options = document.getElementById("sel_wlan1_channel").getElementsByTagName("option");
		for (var i = 0; i < options.length; i++) {
			options[i].disabled=false;
			options[i].style.backgroundColor = '';
			options[i].style.color = '';
		}
	}

	function disableRange(sIndex, eIndex) {
		iniRangeOption();
		var options = get_by_id("sel_wlan1_channel").getElementsByTagName("option");
		for (var i = sIndex; i <= eIndex; i++) {
			for (var j = 0; j < options.length; j++) {
				if (options[j].value == i) {
					options[j].disabled=true;
					options[j].style.backgroundColor = '#ccc';
					options[j].style.color = '';
				}
			}
		}
	}	
	function RemoveRange(sIndex, eIndex) {
		var removeOptions = document.getElementById("sel_wlan1_channel");
		var options = removeOptions.getElementsByTagName("option");
		for (var i = sIndex; i <= eIndex; i++) {
			for (var j = 0; j < options.length; j++) {
				if (options[j].value == i) {
					removeOptions.remove(j);
					break;
				}
			}
		}
	} 

	function set_channel(){
		var channel_list = "<!--# exec cgi /bin/wlan channel list wlan0 -->";
		channel_list = ReplaceAll(channel_list, " ", "");
		var current_channel = trim_string("<!--# echo wlan0_channel -->");
		var ch = channel_list.split(",");
		var obj = get_by_id("sel_wlan0_channel");
		var count = 0;
		
		for (var i = 0; i < ch.length; i++){			
			var ooption = document.createElement("option");						
			var ch_text = (2412+(ch[i]-1)*5)/1000;           
			ooption.text = ch_text + " GHz - CH " + ch[i];
			ooption.value = ch[i];				
			obj.options[count++] = ooption;

			if (ch[i] == current_channel){
				ooption.selected = true;
			}        		
		}
	}

	function reset_channel(ch)
	{
		var domain = new Array("0x14", "0x23", "0x3C", "0x3A", "0x3B", "0x52", "0x5B", "0x37", "0x10", "0x51");
		var region = "<!--# exec cgi /bin/wlan domain number -->";
		var en_auto_chan = get_checked_value(get_by_id("auto_channel_1"));
		var pt_11a = $("#11a_protection").val();

		if (region == "0x50" && en_auto_chan == "0" && pt_11a == "auto") {
			var tmp_ch = new Array();
			for (var i = 0; i < ch.length; i++) {
				if (ch[i] == "52")
					continue;
				if (ch[i] == "165")
					continue;
				tmp_ch.push(ch[i]);
			}
			ch = tmp_ch;
			return ch;
		}

		for (var i = 0; i < domain.length; i++) {
			if (region.toLowerCase() == domain[i].toLowerCase()) {
				var tmp_ch = new Array();
				if (pt_11a == "auto") {
					for (var i = 0; i < ch.length; i++) {
						if (ch[i] == "165")
							continue;
						tmp_ch.push(ch[i]);
					}
				} else {
					for (var i = 0; i < ch.length; i++) {
						tmp_ch.push(ch[i]);
					}
				}
				ch = tmp_ch;
				break;
			}
		}
		return ch;
	}

	<!--5G-->
	function set_channel_1(){
		var channel_list = "<!--# exec cgi /bin/wlan channel list wlan1 -->";
		channel_list = ReplaceAll(channel_list, " ", "");
		var current_channel = trim_string("<!--# echo wlan1_channel -->");
		var ch = channel_list.split(",");
		var obj = get_by_id("sel_wlan1_channel");
		var count = 0;
		var w11n_protection = "<!--# echo wlan1_11n_protection -->";
		obj.options.length = 0;	
		ch = reset_channel(ch);
		for (var i = 0; i < ch.length; i++){			
			var ooption = document.createElement("option");						
      			var ch_text = (ch[i]*5+5000)/1000;
     			ooption.text = FormatNumber(ch_text,3) + " GHz - CH " + ch[i];
			ooption.value = ch[i];	
			obj.options[count++] = ooption;
								
			if (ch[i] == current_channel){
				ooption.selected = true;
			}        		
			
			//get browser userAgent
			var Sys = {};
			var ua = navigator.userAgent.toLowerCase();
			var s;
			//detect browser
			(s = ua.match(/msie ([\d.]+)/)) ? Sys.ie = s[0] :
			(s = ua.match(/firefox\/([\d.]+)/)) ? Sys.firefox = s[0] :
			(s = ua.match(/chrome\/([\d.]+)/)) ? Sys.chrome = s[0] :
			(s = ua.match(/opera.([\d.]+)/)) ? Sys.opera = s[0] :
			(s = ua.match(/version\/([\d.]+).*safari/)) ? Sys.safari = s[0] : 0;
			var IEbrowser = s[0].split(" ");
			var IEbb = IEbrowser[0];
			var browser = s[0].split("/");
			var bb = browser[0];
			var version = s[1].split(".");
			var vv = version[0];
		
			//detect version
			(s = ua.match(/msie ([\d.]+)/)) ? Sys.ie = s[1] :
			(s = ua.match(/firefox\/([\d.]+)/)) ? Sys.firefox = s[1] :
			(s = ua.match(/chrome\/([\d.]+)/)) ? Sys.chrome = s[1] :
			(s = ua.match(/opera.([\d.]+)/)) ? Sys.opera = s[1] :
			(s = ua.match(/version\/([\d.]+).*safari/)) ? Sys.safari = s[1] : 0;
	
			if (( IEbb=="msie" && version[0] >="10") || (bb=="firefox" && version[0] >="12") || (bb=="chrome" && version[0] >="20") || (bb=="safari" && version[0] >="4")){
				var cty = "<!--# exec cgi /bin/wlan domain region -->";
				if (cty === "TW") {
					/* Does not disable chanel */
				} else if (cty === "RU") {
					/* Does not disable chanel */
				} else
					disableRange(52, 140);
			}else{
				RemoveRange(52,140);
			}
		   		
		}
	}

function add_24G_channel(){
	var obj = get_by_id("sel_wlan0_channel");        
	var len = obj.length - 1;
	var region = "<!--# exec cgi /bin/wlan domain number -->";
	/* The list domain channels have more than 11 */
	var domain = new Array("0x07", "0x21", "0x23", "0x3C", "0x37", "0x41", "0x52", "0x5B", "0x5E", "0x36", "0x3B");
	var protection = get_by_id("11n_protection").value;
/*
	for (var i = 0; i < domain.length; i++) {
		if (region == domain[i]) {
			if (protection == "auto") {
				if (obj.length > 11) {
					obj.remove(len - 1);
					obj.remove(len - 1);
				}
			} else {
				if (obj.length < 12) {
					try {
						obj.add(new Option("2.467 GHz - CH 12", len+1), null);
						obj[len+1].value = 12;
						obj.add(new Option("2.472 GHz - CH 13", len+1), null);
						obj[len+1].value = 13;
					} catch(e) {
						obj.add(new Option("2.467 GHz - CH 12", len+1));
						obj[len+1].value = 12;
						obj.add(new Option("2.472 GHz - CH 13", len+1));
						obj[len+1].value = 13;
					}
				}
			}
			break;
		}
	}
*/
}



    //channel 165
    function add_channel(){
        var obj = get_by_id("sel_wlan1_channel");
	var len = obj.length - 1;
	var region = "<!--# exec cgi /bin/wlan domain number -->";
        /* The list domain channels have 140 and 165 channel */
        var domain = new Array("0x14", "0x23", "0x3C", "0x3A", "0x3B", "0x50", "0x52", "0x5B", "0x37", "0x10", "0x51");
        var protection = get_by_id("11a_protection").value;
        for (var i = 0; i < domain.length; i++) {
                if (region.toLowerCase() == domain[i].toLowerCase()) {
                        var t_channel = obj[len].value;
                        if (protection == "auto") {
                                if (t_channel == "140" || t_channel == "165") {
                                      obj.remove(obj.length-1);
                                }
                        } else {
                                if (t_channel == "136" ) {
                                        try {
                                                obj.add(new Option("5.700 GHz - CH 140", len+1), null);
                                                obj[len+1].value = 140;
                                        } catch(e) {
                                                obj.add(new Option("5.700 GHz - CH 140", len+1));
                                                obj[len+1].value = 140;
                                        }

                                }
                                else if (t_channel == "161") {
                                        try {
                                                obj.add(new Option("5.825 GHz - CH 165", len+1), null);
                                                obj[len+1].value = 165;
                                        } catch(e) {
                                                obj.add(new Option("5.825 GHz - CH 165", len+1));
                                                obj[len+1].value = 165;
                                        }
                                }
                        }
                        break;
                }
        }
    }

<!--tx rate setting-->
var txrate_11b = new Array(11, 5.5, 2, 1);
var txrate_11g = new Array(54, 48, 36, 24, 18, 12, 9, 6);
var txrate_11n = new Array('MCS 15 - 130 [270]', 'MCS 14 - 117 [243]', 'MCS 13 - 104 [216]', 'MCS 12 - 78 [162]', 'MCS 11 - 52 [108]', 'MCS 10 - 39 [81]', 'MCS 9 - 26 [54]', 'MCS 8 - 13 [27]', 'MCS 7 - 65 [135]', 'MCS 6 - 58.5 [121.5]', 'MCS 5 - 52 [108]', 'MCS 4 - 39 [81]', 'MCS 3 - 26 [54]', 'MCS 2 - 19.5 [40.5]', 'MCS 1 - 13 [27]', 'MCS 0 - 6.5 [13.5]');
	function set_11b_txrate(obj){
		for(var i = 0; i < txrate_11b.length; i++){
			var ooption = document.createElement("option");
			
			obj.options[i] = null;
			ooption.text = txrate_11b[i];
			ooption.value = txrate_11b[i];				
			obj.options[i] = ooption;	
		}
	}

	function set_11g_txrate(obj){
		for(var i = 0; i < txrate_11g.length; i++){
			var ooption = document.createElement("option");
			
			obj.options[i] = null;
			ooption.text = txrate_11g[i];
			ooption.value = txrate_11g[i];				
			obj.options[i] = ooption;	
		}
	}

	function set_11n_txrate(obj){
		for(var i = 0; i < txrate_11n.length; i++){
			var ooption = document.createElement("option");
			
			obj.options[i] = null;
			ooption.text = txrate_11n[i];
			ooption.value = txrate_11n[i];				
			obj.options[i] = ooption;	
		}
	}

	function set_11bg_txrate(obj){
		var count = 0;
		var legth = txrate_11b.length + txrate_11g.length
		for(var i = 0; i < legth; i++){
			var ooption = document.createElement("option");
			obj.options[i] = null;
			if(i > txrate_11g.length){
				ooption.text = txrate_11b[count];
				ooption.value = txrate_11b[count];
				count++;		
			}else{
				ooption.text = txrate_11g[i];
				ooption.value = txrate_11g[i];				
			}
			obj.options[i] = ooption;	
		}
	}

	function set_11gn_txrate(obj){
		var count = 0;
		var legth = txrate_11g.length + txrate_11n.length
		for(var i = 0; i < legth; i++){
			var ooption = document.createElement("option");
			obj.options[i] = null;
			if(i > txrate_11n.length){
				ooption.text = txrate_11g[count];
				ooption.value = txrate_11g[count];
				count++;		
			}else{
				ooption.text = txrate_11n[i];
				ooption.value = txrate_11n[i];				
			}
			obj.options[i] = ooption;	
		}
	}

	function set_11bgn_txrate(obj){
		var count_b = 0, count_g = 0;
		var legth = txrate_11b.length + txrate_11g.length + txrate_11n.length
		for(var i = 0; i < legth; i++){
			var ooption = document.createElement("option");
			obj.options[i] = null;
			if(i > txrate_11n.length){
				ooption.text = txrate_11g[count_g];
				ooption.value = txrate_11g[count_g];
				count_g++;		
			}else if(i > (txrate_11n.length + txrate_11g.length)){
				ooption.text = txrate_11b[count_b];
				ooption.value = txrate_11b[count_b];
				count_b++;				
			}else{
				ooption.text = txrate_11n[i];
				ooption.value = txrate_11n[i];				
			}
			obj.options[i] = ooption;	
		}
	}
	

	function change_mode(){
		var mode = get_by_id("dot11_mode").selectedIndex;

		get_by_id("show_11b_txrate").style.display = "none";
		get_by_id("show_11g_txrate").style.display = "none";
		get_by_id("show_11n_txrate").style.display = "none";
		get_by_id("show_11bg_txrate").style.display = "none";
		get_by_id("show_11gn_txrate").style.display = "none";
		get_by_id("show_11bgn_txrate").style.display = "none";
		get_by_id("show_channel_width").style.display = "none";
		switch(mode){
		case 0:
			get_by_id("show_11b_txrate").style.display = "";
			break;
		case 1:
			get_by_id("show_11g_txrate").style.display = "";
			break;
		case 2:
			get_by_id("show_11n_txrate").style.display = "";
			get_by_id("show_channel_width").style.display = "";
			break;
		case 3:
			get_by_id("show_11bg_txrate").style.display = "";
			break;
		case 4:
			get_by_id("show_11gn_txrate").style.display = "";
			break;
		case 5:
			get_by_id("show_11bgn_txrate").style.display = "";
			get_by_id("show_channel_width").style.display = "";
			break;
		}
	}	
<!--tx rate setting end-->
	function check_wps_psk_eap(){
		if(get_by_id("wps_enable").value =="1"){
			if((get_by_id("wep_type").value == "1") && (get_by_id("wep_def_key").value != "1")){
				alert(TEXT024);//Can't choose WEP key 2, 3, 4 when WPS is enable
				return false;
			}
		}
		return true;
	}

	function check_wps_psk_eap_1(){
		if(get_by_id("wps_enable").value =="1"){
			if((get_by_id("wep_type_1").value == "1") && (get_by_id("wep_def_key_1").value != "1")){
				alert(TEXT024);
				return false;
			}
		}
		return true;
	}

	function ischeck_wps(obj){
		var is_true = false;
		if(get_by_id("wps_enable").value =="1"){
			if(!check_wps_psk_eap()){
				is_true = true;
			}else if(get_by_id("auth_type").value == "share"){
				alert(TEXT027);	//Can't choose shared key when WPS is enable
				is_true = true;
				if(obj == "auto"){
					set_selectIndex("open", get_by_id("auth_type"));
				}
			}
			if(!check_wps_psk_eap_1()){
				is_true = true;
			}else if(get_by_id("auth_type_1").value == "share"){
				alert(TEXT027);	//Can't choose shared key when WPS is enable
				is_true = true;
				if(obj == "auto"){
					set_selectIndex("open", get_by_id("auth_type_1"));
				}
			}
		}
		if(is_true){
			if(obj == "wps"){
				get_by_id("wps_enable").value =="0";
			}
			return false;
		}
		return true;
		
	}
	
	 function do_add_new_schedule(){
            window.location.href = "tools_schedules.asp";
     }
     
    function get_wlan0_schedule(obj){
	    var tmp_schedule = obj.options[obj.selectedIndex].value;
	    var schedule_val;
	    var tmp_schedule_index = obj.selectedIndex;

	    if(tmp_schedule == "Always"){
		    schedule_val = "Always";
	    }else if(tmp_schedule == "Never"){
		    schedule_val = "Never";
	    }else{
		    var tmp_sch = (get_by_id("schedule_rule_" + (tmp_schedule_index-2)).value).split("/");
		    schedule_val = tmp_sch[0];
	    }

	    get_by_id("wlan0_schedule").value = schedule_val;
	}
	
	function get_wlan1_schedule(obj){
		var tmp_schedule = obj.options[obj.selectedIndex].value;
		var schedule_val;
		var tmp_schedule_index = obj.selectedIndex;

		if(tmp_schedule == "Always"){
			schedule_val = "Always";
		}else if(tmp_schedule == "Never"){
			schedule_val = "Never";
		}else{
			var tmp_sch = (get_by_id("schedule_rule_" + (tmp_schedule_index-2)).value).split("/");
			schedule_val = tmp_sch[0];
		}
		get_by_id("wlan1_schedule").value = schedule_val;

	}
	
</script>
<style type="text/css">
<!--
.style1 {font-size: 11px}
-->
</style>
</head>
<body topmargin="1" leftmargin="0" rightmargin="0" bgcolor="#757575">
	<table id="header_container" border="0" cellpadding="5" cellspacing="0" width="838" align="center">
      <tr>
        <td width="100%">&nbsp;&nbsp;<script>show_words(TA2)</script>: <a href="http://support.dlink.com.tw/"><!--# echo model_number --></a></td>
        
		<td align="right" nowrap><script>show_words(TA3)</script>: <!--# echo sys_hw_version --> &nbsp;</td>
		<td align="right" nowrap><script>show_words(sd_FWV)</script>: <!--# echo sys_fw_version --><!--# echox sys_region NA --></td>
		<td>&nbsp;</td>
      </tr>
    </table>
	<table id="topnav_container" border="0" cellpadding="0" cellspacing="0" width="838" align="center">
		<tr>
			<td align="center" valign="middle"><img src="wlan_masthead.gif" width="836" height="92"></td>
		</tr>
	</table>
	<table border="0" cellpadding="2" cellspacing="1" width="838" align="center" bgcolor="#FFFFFF">
		<tr id="topnav_container">
			<td><img src="short_modnum.gif" width="125" height="25"></td>
			<script>show_top("setup");</script>
		</tr>
	</table>
	<table border="1" cellpadding="2" cellspacing="0" width="838" height="100%" align="center" bgcolor="#FFFFFF" bordercolordark="#FFFFFF">
		<tr>
		  <td id="sidenav_container" valign="top" width="125" align="right">
				<table border="0" cellpadding="0" cellspacing="0">
					<tr>
						<td id="sidenav_container">
							<div id="sidenav">
								<ul>
									<script>show_left("Setup", 1);</script>
								</ul>
							</div>
						</td>			
					</tr>
				</table>			
		  </td>
			
			<form id="form1" name="form1" method="post" action="apply.cgi">
				<input type="hidden" id="html_response_page" name="html_response_page" value="back.asp">
				<input type="hidden" id="html_response_message" name="html_response_message" value="">
				<script>get_by_id("html_response_message").value = sc_intro_sv;</script>
				<input type="hidden" id="html_response_return_page" name="html_response_return_page" value="wireless.asp">
				<input type="hidden" id="reboot_type" name="reboot_type" value="wireless">
				<input type="hidden" id="action" name="action" value="wlan_concurrent">
				<input type="hidden" id="wlan0_ssid" name="wlan0_ssid" value="<!--# echot wlan0_ssid -->">
				<input type="hidden" id="wlan1_ssid" name="wlan1_ssid" value="<!--# echot wlan1_ssid -->">
				<input type="hidden" id="wps_pin" name="wps_pin" value="<!--# echo wps_pin -->">
				<!-- input type="hidden" id="disable_wps_pin" name="disable_wps_pin" value="" -->
				<input type="hidden" id="wps_configured_mode" name="wps_configured_mode" value="<!--# echo wps_configured_mode -->">
				<input type="hidden" id="wlan0_wep_display" name="wlan0_wep_display" value="<!--# echo wlan0_wep_display -->">
				<input type="hidden" id="wlan1_wep_display" name="wlan1_wep_display" value="<!--# echo wlan1_wep_display -->">
				<input type="hidden" id="wps_enable" name="wps_enable" value="<!--# echo wps_enable -->">
				<input type="hidden" id="wlan0_schedule" name="wlan0_schedule" value="<!--# echo wlan0_schedule -->">
				<input type="hidden" id="wlan1_schedule" name="wlan1_schedule" value="<!--# echo wlan1_schedule -->">
				<input type="hidden" id="wps_lock" name="wps_lock" value="<!--# echo wps_lock -->">
				<input type="hidden" id="apply" name="apply" value="0">                                    
				
				<input type="hidden" id="schedule_rule_0" name="schedule_rule_0" value="<!--# echo schedule_rule_00 -->">
				<input type="hidden" id="schedule_rule_1" name="schedule_rule_1" value="<!--# echo schedule_rule_01 -->">
                <input type="hidden" id="schedule_rule_2" name="schedule_rule_2" value="<!--# echo schedule_rule_02 -->">
                <input type="hidden" id="schedule_rule_3" name="schedule_rule_3" value="<!--# echo schedule_rule_03 -->">
                <input type="hidden" id="schedule_rule_4" name="schedule_rule_4" value="<!--# echo schedule_rule_04 -->">
                <input type="hidden" id="schedule_rule_5" name="schedule_rule_5" value="<!--# echo schedule_rule_05 -->">
                <input type="hidden" id="schedule_rule_6" name="schedule_rule_6" value="<!--# echo schedule_rule_06 -->">
                <input type="hidden" id="schedule_rule_7" name="schedule_rule_7" value="<!--# echo schedule_rule_07 -->">
                <input type="hidden" id="schedule_rule_8" name="schedule_rule_8" value="<!--# echo schedule_rule_08 -->">
                <input type="hidden" id="schedule_rule_9" name="schedule_rule_9" value="<!--# echo schedule_rule_09 -->">
                <input type="hidden" id="schedule_rule_10" name="schedule_rule_10" value="<!--# echo schedule_rule_10 -->">
                <input type="hidden" id="schedule_rule_11" name="schedule_rule_11" value="<!--# echo schedule_rule_11 -->">
                <input type="hidden" id="schedule_rule_12" name="schedule_rule_12" value="<!--# echo schedule_rule_12 -->">
                <input type="hidden" id="schedule_rule_13" name="schedule_rule_13" value="<!--# echo schedule_rule_13 -->">
                <input type="hidden" id="schedule_rule_14" name="schedule_rule_14" value="<!--# echo schedule_rule_14 -->">
                <input type="hidden" id="schedule_rule_15" name="schedule_rule_15" value="<!--# echo schedule_rule_15 -->">
                <input type="hidden" id="schedule_rule_16" name="schedule_rule_16" value="<!--# echo schedule_rule_16 -->">
                <input type="hidden" id="schedule_rule_17" name="schedule_rule_17" value="<!--# echo schedule_rule_17 -->">
                <input type="hidden" id="schedule_rule_18" name="schedule_rule_18" value="<!--# echo schedule_rule_18 -->">
                <input type="hidden" id="schedule_rule_19" name="schedule_rule_19" value="<!--# echo schedule_rule_19 -->">
								<input type="hidden" id="schedule_rule_20" name="schedule_rule_20" value="<!--# echo schedule_rule_20 -->">
								<input type="hidden" id="schedule_rule_21" name="schedule_rule_21" value="<!--# echo schedule_rule_21 -->">
								<input type="hidden" id="schedule_rule_22" name="schedule_rule_22" value="<!--# echo schedule_rule_22 -->">
								<input type="hidden" id="schedule_rule_23" name="schedule_rule_23" value="<!--# echo schedule_rule_23 -->">
								<input type="hidden" id="schedule_rule_24" name="schedule_rule_24" value="<!--# echo schedule_rule_24 -->">
								<input type="hidden" id="schedule_rule_25" name="schedule_rule_25" value="<!--# echo schedule_rule_25 -->">
								<input type="hidden" id="schedule_rule_26" name="schedule_rule_26" value="<!--# echo schedule_rule_26 -->">
								<input type="hidden" id="schedule_rule_27" name="schedule_rule_27" value="<!--# echo schedule_rule_27 -->">
								<input type="hidden" id="schedule_rule_28" name="schedule_rule_28" value="<!--# echo schedule_rule_28 -->">
								<input type="hidden" id="schedule_rule_29" name="schedule_rule_29" value="<!--# echo schedule_rule_29 -->">
								<input type="hidden" id="schedule_rule_30" name="schedule_rule_30" value="<!--# echo schedule_rule_30 -->">
								<input type="hidden" id="schedule_rule_31" name="schedule_rule_31" value="<!--# echo schedule_rule_31 -->">
		                                
              
              <td valign="top" id="maincontent_container">
				  <div id="box_header"> 
						<h1><script>show_words(_wireless)</script></h1>
						<p><script>show_words(bwl_Intro_1)</script></p>
						<input name="button" id="button" type="submit" class=button_submit value="" onClick="return send_request()">
						<input name="button2" id="button2" type=button class=button_submit value="" onclick="page_cancel('form1', 'wireless.asp');">
						<script>get_by_id("button").value = _savesettings;</script>
						<script>get_by_id("button2").value = _dontsavesettings;</script>
						<script>check_reboot();</script>
					</div>
					
					<div class="box"> 
						<h2><script>show_words(bwl_title_1)</script></h2>
							
          <table cellpadding="1" cellspacing="1" border="0" width="525">
            <tr> 
              <td class="duple"><script>show_words(wwl_band)</script> :</td>
              <td>&nbsp;&nbsp;<strong><script>show_words(GW_WLAN_RADIO_0_NAME)</script></strong></td>
            </tr>
            <tr> 
              <td class="duple"><script>show_words(bwl_EW)</script> :</td>
              <td width="340">&nbsp; <input id="w_enable" name="w_enable" type="checkbox" value="1" onClick="disable_wireless();" checked> 
                <input type="hidden" id="wlan0_enable" name="wlan0_enable" value="<!--# echo wlan0_enable -->"> 
                <select id="wlan0_schedule_select" name="wlan0_schedule_select" onChange="get_wlan0_schedule(this);">
                 <option value="Always" selected><script>show_words(_always)</script></option>
				 <option value="Never"><script>show_words(_never)</script></option>
					<script>document.write(set_schedule_option());</script>
               </select>
                <input name="add_new_schedule" type="button" class="button_submit" id="add_new_schedule" onclick="do_add_new_schedule(true)" value=""> 
				<script>get_by_id("add_new_schedule").value = dlink_1_add_new;</script>
              </td>
            </tr>
            <tr> 
              <td class="duple"><script>show_words(bwl_NN)</script> :</td>
              <td width="340">&nbsp;&nbsp;&nbsp; <input name="show_ssid" type="text" id="show_ssid" size="20" maxlength="32" value="">
                <script>show_words(bwl_AS)</script> </td>
            </tr>
            <tr> 
              <td class="duple"><script>show_words(bwl_Mode)</script> :</td>
              <td width="340">&nbsp;&nbsp; 
			  <select id="dot11_mode" name="dot11_mode" onClick="show_chan_width();">
                <option value="11b"><script>show_words(bwl_Mode_1)</script></option>
				<option value="11g"><script>show_words(bwl_Mode_2)</script></option>
				<option value="11n"><script>show_words(bwl_Mode_n)</script></option>
				<option value="11bg"><script>show_words(bwl_Mode_3)</script></option>
				<option value="11gn"><script>show_words(bwl_Mode_10)</script></option>
				<option value="11bgn"><script>show_words(bwl_Mode_11)</script></option>
               </select> <input type="hidden" id="wlan0_dot11_mode" name="wlan0_dot11_mode" value="<!--# echo wlan0_dot11_mode -->"> 
              </td>
            </tr>
            <tr> 
              <td class="duple"><script>show_words(ebwl_AChan)</script> :</td>
              <td width="340">&nbsp; <input type="checkbox" id="auto_channel" name="auto_channel" value="1" onClick="disable_channel();"> 
                <input type="hidden" id="wlan0_auto_channel_enable" name="wlan0_auto_channel_enable" value="<!--# echo wlan0_auto_channel_enable -->"> 
              </td>
            </tr>
            <tr> 
              <td class="duple"><script>show_words(_wchannel)</script> :</td>
              <td width="340">&nbsp;&nbsp; <select name="sel_wlan0_channel" id="sel_wlan0_channel">
                  <script>
					set_channel();
				</script>
                </select> <input type="hidden" id="wlan0_channel" name="wlan0_channel" value="<!--# echo wlan0_channel -->"> 
              </td>
            </tr>
            <!-- 11b txrate -->
            <tr id="show_11b_txrate" style="display:none"> 
              <td class="duple"><script>show_words(bwl_TxR)</script> :</td>
              <td width="340">&nbsp;&nbsp; <select id="wlan0_11b_txrate" name="wlan0_11b_txrate">
                  <option value="" selected><script>show_words(bwl_TxR_0)</script></option>
                  <script>set_11b_txrate(get_by_id("wlan0_11b_txrate"));</script>
                </select> </td>
            </tr>
            <!-- 11g txrate -->
            <tr id="show_11g_txrate" style="display:none"> 
              <td class="duple"><script>show_words(bwl_TxR)</script> :</td>
              <td width="340">&nbsp;&nbsp; <select id="wlan0_11g_txrate" name="wlan0_11g_txrate">
                  <option value="" selected><script>show_words(bwl_TxR_0)</script></option>
                  <script>set_11g_txrate(get_by_id("wlan0_11g_txrate"));</script>
                </select> </td>
            </tr>
            <!-- 11n txrate -->
            <tr id="show_11n_txrate" style="display:none"> 
              <td class="duple"><script>show_words(bwl_TxR)</script> :</td>
              <td width="340">&nbsp;&nbsp; <select id="wlan0_11n_txrate" name="wlan0_11n_txrate">
                  <option value="" selected><script>show_words(bwl_TxR_0)</script></option>
                  <script>set_11n_txrate(get_by_id("wlan0_11n_txrate"));</script>
                </select> </td>
            </tr>
            <!-- 11b/g txrate -->
            <tr id="show_11bg_txrate" style="display:none"> 
              <td class="duple"><script>show_words(bwl_TxR)</script> :</td>
              <td width="340">&nbsp;&nbsp; <select id="wlan0_11bg_txrate" name="wlan0_11bg_txrate">
                  <option value="" selected><script>show_words(bwl_TxR_0)</script></option>
                  <script>set_11bg_txrate(get_by_id("wlan0_11bg_txrate"));</script>
                </select> </td>
            </tr>
            <!-- 11g/n txrate -->
            <tr id="show_11gn_txrate" style="display:none"> 
              <td class="duple"><script>show_words(bwl_TxR)</script> :</td>
              <td width="340">&nbsp;&nbsp; <select id="wlan0_11gn_txrate" name="wlan0_11gn_txrate">
                  <option value="" selected><script>show_words(bwl_TxR_0)</script></option>
                  <script>set_11gn_txrate(get_by_id("wlan0_11gn_txrate"));</script>
                </select> </td>
            </tr>
            <!-- 11b/g/n txrate -->
            <tr id="show_11bgn_txrate" style="display:none"> 
              <td class="duple"><script>show_words(bwl_TxR)</script> :</td>
              <td width="340">&nbsp;&nbsp; <select id="wlan0_11bgn_txrate" name="wlan0_11bgn_txrate">
                  <option value="" selected><script>show_words(bwl_TxR_0)</script></option>
                  <script>set_11bgn_txrate(get_by_id("wlan0_11bgn_txrate"));</script>
                </select> </td>
            </tr>
            <tr id="show_channel_width"> 
              <td class="duple"><script>show_words(bwl_CWM)</script> :</td>
              <td width="340">&nbsp;&nbsp; <select id="11n_protection" name="11n_protection" onChange="add_24G_channel()">
                  <option value="20"><script>show_words(bwl_ht20)</script></option>
                  <option value="auto"><script>show_words(bwl_ht2040)</script></option>
                </select> <input type="hidden" id="wlan0_11n_protection" name="wlan0_11n_protection" value="<!--# echo wlan0_11n_protection -->"> 
              </td>
            </tr>
            <tr> 
              <td class="duple"><script>show_words(bwl_VS)</script> :</td>
              <td width="340">&nbsp; <input type="radio" name="wlan0_ssid_broadcast" value="1">
                <script>show_words(bwl_VS_0)</script> 
                <input type="radio" name="wlan0_ssid_broadcast" value="0">
                <script>show_words(bwl_VS_1)</script> </td>
            </tr>
          </table>
					</div>
							<input type="hidden" id="wlan0_security" name="wlan0_security" value="<!--# echo wlan0_security -->">
							<input type="hidden" id="asp_temp_37" name="asp_temp_37" value="<!--# echo asp_temp_37","hex -->">
							<input type="hidden" id="asp_temp_38" name="asp_temp_38" value="<!--# echo asp_temp_38","hex -->">
							<input type="hidden" id="asp_temp_39" name="asp_temp_39" value="<!--# echo asp_temp_39","hex -->">
							<input type="hidden" id="asp_temp_40" name="asp_temp_40" value="<!--# echo asp_temp_40","hex -->">
					<div class="box" id="show_security"> 
						<h2><script>show_words(bws_WSMode)</script></h2>
						
          <script>show_words(bws_intro_WlsSec)</script>
          <br><br>
				            <table cellpadding="1" cellspacing="1" border="0" width="525">
                              <tr>
                                <td class="duple"><script>show_words(bws_SM)</script> :</td>
                                <td width="340">&nbsp;
                                    <select id="wep_type" name="wep_type" onChange="show_wpa_wep()">
                                     <option value="0" selected><script>show_words(_none)</script></option>
                                      <option value="1"><script>show_words(_WEP)</script></option>
                                      <option value="2"><script>show_words(_WPApersonal)</script></option>
                                      <option value="3"><script>show_words(_WPAenterprise)</script></option>
                                    </select>
                                </td>
                              </tr>
                            </table>
				</div>
					
        <div class="box" id="show_wep" style="display:none"> 
          <h2>
            <script>show_words(_WEP)</script>
          </h2>
						
          <p> 
            <script>show_words(bws_msg_WEP_1)</script>
          </p>
          <p> 
            <script>show_words(bws_msg_WEP_2)</script>
          </p>
          <p> 
            <script>show_words(bws_msg_WEP_3)</script>
          </p>
                  			
          <table cellpadding="1" cellspacing="1" border="0" width="525">
            <input type="hidden" id="wlan0_wep64_key_1" name="wlan0_wep64_key_1" value="<!--# echo wlan0_wep64_key_1","hex -->">
            <input type="hidden" id="wlan0_wep128_key_1" name="wlan0_wep128_key_1" value="<!--# echo wlan0_wep128_key_1","hex -->">
            <input type="hidden" id="wlan0_wep64_key_2" name="wlan0_wep64_key_2" value="<!--# echo wlan0_wep64_key_2","hex -->">
            <input type="hidden" id="wlan0_wep128_key_2" name="wlan0_wep128_key_2" value="<!--# echo wlan0_wep128_key_2","hex -->">
            <input type="hidden" id="wlan0_wep64_key_3" name="wlan0_wep64_key_3" value="<!--# echo wlan0_wep64_key_3","hex -->">
            <input type="hidden" id="wlan0_wep128_key_3" name="wlan0_wep128_key_3" value="<!--# echo wlan0_wep128_key_3","hex -->">
            <input type="hidden" id="wlan0_wep64_key_4" name="wlan0_wep64_key_4" value="<!--# echo wlan0_wep64_key_4","hex -->">
            <input type="hidden" id="wlan0_wep128_key_4" name="wlan0_wep128_key_4" value="<!--# echo wlan0_wep128_key_4","hex -->">
            <tr>
              <td class="duple"> <script>show_words(bws_WKL)</script> :</td>
              <td width="340">&nbsp; <select id="wep_key_len" name="wep_key_len" size=1 onChange="change_wep_key_fun();">
                  <option value="5"><script>show_words(bws_WKL_0)</script></option>
				  <option value="13"><script>show_words(bws_WKL_1)</script></option>
                </select>
                 <script>show_words(bws_length)</script> </td>
            </tr>
            <tr id=show_wlan0_wep style="display:none">
              <td class="duple"><script>show_words(bws_DFWK)</script>
                :</td>
              <td width="340">&nbsp; <select id="wep_def_key" name="wep_def_key" onChange="ischeck_wps('wep');">
                <option value="1"><script>show_words(wepkey1)</script></option>
		<option value="2"><script>show_words(wepkey2)</script></option>
		<option value="3"><script>show_words(wepkey3)</script></option>
		<option value="4"><script>show_words(wepkey4)</script></option>
		</select>
                  <input type="hidden" id="wlan0_wep_default_key" name="wlan0_wep_default_key" value="<!--# echo wlan0_wep_default_key -->"> 
              </td>
            </tr>
            <tr>
              <td class="duple"> <script>show_words(auth)</script>
                :</td>
              <td width="340">&nbsp; <select name="auth_type" id="auth_type" onChange="ischeck_wps('auto');">
                   <option value="auto"><script>show_words(_both)</script></option>
				  <option value="share"><script>show_words(bws_Auth_2)</script></option>
		      </select> </td>
            </tr>
            <tr>
              <td class="duple"><script>show_words(_wepkey1)</script> :</td>
              <td width="340">&nbsp; <span id="show_resert1"></span> </td>
            </tr>
            <span id="show_resert2"></span>
			<span id="show_resert3"></span>
			<span id="show_resert4"></span>
            <!--tr>
              <td class="duple"><script>show_words(_wepkey2)</script> :</td>
              <td width="340">&nbsp; <span id="show_resert2"></span> </td>
            </tr>
            <tr>
              <td class="duple"><script>show_words(_wepkey3)</script> :</td>
              <td width="340">&nbsp; <span id="show_resert3"></span> </td>
            </tr>
            <tr>
              <td class="duple"><script>show_words(_wepkey4)</script> :</td>
              <td width="340">&nbsp; <span id="show_resert4"></span> </td>
            </tr-->
          </table>
					</div>
					
        <div class="box" id="show_wpa"  style="display:none"> 
          <h2><script>show_words(_WPA)</script></h2>
          <p><script>show_words(bws_msg_WPA)</script></p>
          <p><script>show_words(bws_msg_WPA_2)</script></p>
			<input type="hidden" id="wlan0_psk_cipher_type" name="wlan0_psk_cipher_type" value="<!--# echo wlan0_psk_cipher_type -->">
                  			
          <table cellpadding="1" cellspacing="1" border="0" width="525">
            <tr>
              <td class="duple"> <script>show_words(bws_WPAM)</script> :</td>
              <td width="340">&nbsp; <select id="wpa_mode" name="wpa_mode">
                <option value="auto"><script>show_words(bws_WPAM_2)</script></option>
				<option value="wpa2"><script>show_words(bws_WPAM_3)</script></option>
				<option value="wpa"><script>show_words(bws_WPAM_1)</script></option>
				</select></td>

            </tr>
            <tr>
              <td class="duple"> <script>show_words(bws_CT)</script> :</td>
              <td width="340">&nbsp; <select id="c_type" name="c_type" onChange="check_wps_psk_eap()">
				<option value="tkip"><script>show_words(bws_CT_1)</script></option>
				<option value="aes"><script>show_words(bws_CT_2)</script></option>
				<option value="both"><script>show_words(bws_CT_3)</script></option>
				</select> </td>
            </tr>
            <tr>
              <td class="duple"> <script>show_words(bws_GKUI)</script> :</td>
              <td width="340">&nbsp; <input type="text" id="wlan0_gkey_rekey_time" name="wlan0_gkey_rekey_time" size="8" maxlength="5" value="<!--# echo wlan0_gkey_rekey_time -->">
                <script>show_words(bws_secs)</script></td>
            </tr>
          </table>
					</div>
					<div class="box" id="show_wpa_psk" style="display:none"> 
						 <h2><script>show_words(_psk)</script></h2>
						
          <p class="box_msg"> 
            <script>show_words(KR18)</script>
            <script>show_words(KR19)</script>
          </p>
                  			<table cellpadding="1" cellspacing="1" border="0" width="525">
								<tr>
									<td class="duple"><script>show_words(_psk)</script> :</td>
									<td width="340">&nbsp;<input type="password" id="wlan0_psk_pass_phrase" name="wlan0_psk_pass_phrase" size="40" maxlength="64" value="<!--# echot wlan0_psk_pass_phrase -->"></td>
					  			</tr>
							</table>
					</div>
					<div class="box" id="show_wpa_eap" style="display:none"> 
						<h2><script>show_words(bws_EAPx)</script></h2>
						
          <p class="box_msg">
            <script>show_words(bws_msg_EAP)</script>
          </p>
                  			
          <table cellpadding="1" cellspacing="1" border="0" width="525">
            <tr>
              <td class="duple"> <script>show_words(bwsAT_)</script> :</td>
              <input type="hidden" id="wlan0_eap_radius_server_0" name="wlan0_eap_radius_server_0" value="<!--# echo wlan0_eap_radius_server_0 -->">
              <input type="hidden" id="wlan0_eap_mac_auth" name="wlan0_eap_mac_auth" value="<!--# echo wlan0_eap_mac_auth -->">
              <td width="340">&nbsp;
                <input id="wlan0_eap_reauth_period" name="wlan0_eap_reauth_period" size=10 value="<!--# echo wlan0_eap_reauth_period -->">
                <script>show_words(_minutes)</script></td>
            </tr>
            <tr>
              <td class="duple"> <script>show_words(bws_RIPA)</script> :</td>
              <td width="340">&nbsp;
                <input id="radius_ip1" name="radius_ip1" maxlength=15 size=15></td>
            </tr>
            <tr>
              <td class="duple"> <script>show_words(bws_RSP)</script> :</td>
              <td width="340">&nbsp;
                <input type="text" id="radius_port1" name="radius_port1" size="8" maxlength="5" value="1812"></td>
            </tr>
            <tr>
              <td class="duple"> <script>show_words(bws_RSSs)</script> :</td>
              <td width="340">&nbsp;
                <input type="password" id="radius_pass1" name="radius_pass1" size="32" maxlength="64"></td>
            </tr>
            <tr>
              <td class="duple"> <script>show_words(bws_RMAA)</script> :</td>
              <td width="340">&nbsp;
                <input type="checkbox" id="radius_auth_mac1" name="radius_auth_mac1"></td>
            </tr>
            <tr id="radius2"> 
              <td colspan="2"><input type="button" id="advanced" name="advanced" value="" onClick="show_radius();">
                <script>get_by_id("advanced").value = _advanced+">>";</script> 
              </td>
            </tr>
            <tr id="none_radius2" style="display:none"> 
              <td colspan="2"><input type="button" id="advanced0" name="advanced0" value="" onClick="show_radius();">
			  <script>get_by_id("advanced0").value = "<<"+_advanced;</script></td>
            </tr>
          </table>
                  			
          <table id="show_radius2" cellpadding="1" cellspacing="1" border="0" width="525" style="display:none">
            <tr> 
              <input type="hidden" id="wlan0_eap_radius_server_1" name="wlan0_eap_radius_server_1" value="<!--# echo wlan0_eap_radius_server_1 -->">
              <td class="box_msg" colspan="2"><script>show_words(bws_ORAD)</script>
                :</td>
            </tr>
            <tr>
              <td class="duple"> <script>show_words(bws_2RIPA)</script> :</td>
              <td width="340">&nbsp;
                <input id="radius_ip2" name="radius_ip2" maxlength=15 size=15></td>
            </tr>
            <tr>
              <td class="duple"> <script>show_words(bws_2RSP)</script> :</td>
              <td width="340">&nbsp;
                <input type="text" id="radius_port2" name="radius_port2" size="8" maxlength="5" value="1812"></td>
            </tr>
            <tr>
              <td class="duple"> <script>show_words(bws_2RSSS)</script> :</td>
              <td width="340">&nbsp;
                <input type="password" id="radius_pass2" name="radius_pass2" size="32" maxlength="64"></td>
            </tr>
            <tr>
              <td class="duple"> <script>show_words(bws_2RMAA)</script> :</td>
              <td width="340">&nbsp;
                <input type="checkbox" id="radius_auth_mac2" name="radius_auth_mac2"></td>
            </tr>
          </table>         
			</div>
			
			 <div class="box">
            <h2><script>show_words(bwl_title_1)</script></h2>
            <table cellpadding="1" cellspacing="1" border="0" width="525">
              <tr> 
                <td class="duple"><script>show_words(wwl_band)</script> :</td>
                <td><strong>&nbsp;&nbsp;<script>show_words(GW_WLAN_RADIO_1_NAME)</script></strong></td>
              </tr>
              <tr> 
                <td class="duple"><script>show_words(bwl_EW)</script> :</td>
                <td width="340">&nbsp; <input id="w_enable_1" name="w_enable_1" type="checkbox" value="1" onClick="disable_wireless_1();" checked> 
                  <input type="hidden" id="wlan1_enable" name="wlan1_enable" value="<!--# echo wlan1_enable -->"> 
                <select id="wlan1_schedule_select" name="wlan1_schedule_select" onChange="get_wlan1_schedule(this);">
                  <option value="Always" selected><script>show_words(_always)</script></option>
                  <option value="Never"><script>show_words(_never)</script></option>
				   <script>document.write(set_schedule_option());</script>
                </select> 
				<input name="add_new_schedule2" type="button" class="button_submit" id="add_new_schedule2" onclick="do_add_new_schedule(true)" value=""> 
                <script>get_by_id("add_new_schedule2").value = dlink_1_add_new;</script>
				</td>
              </tr>
              <tr> 
                <td class="duple"><script>show_words(bwl_NN)</script> :</td>
                <td width="340">&nbsp;&nbsp;&nbsp; <input name="show_ssid_1" type="text" id="show_ssid_1" size="20" maxlength="32" value="">
                  <script>show_words(bwl_AS)</script> </td>
              </tr>
              <tr> 
                <td class="duple"><script>show_words(bwl_Mode)</script> :</td>
                <td width="340">&nbsp;&nbsp; <select id="dot11_mode_1" name="dot11_mode_1" onClick="show_chan_width_1();">
                    <option value="11n"><script>show_words(bwl_Mode_n)</script></option>
                    <option value="11a"><script>show_words(bwl_Mode_a)</script></option>
                    <option value="11na"><script>show_words(bwl_Mode_5)</script></option>
                  </select> <input type="hidden" id="wlan1_dot11_mode" name="wlan1_dot11_mode" value="<!--# echo wlan1_dot11_mode -->"> 
                </td>
              </tr>
              <tr> 
                <td class="duple"><script>show_words(ebwl_AChan)</script> :</td>
                <td width="340">&nbsp; <input type="checkbox" id="auto_channel_1" name="auto_channel_1" value="1" onClick="disable_channel_1();"> 
                  <input type="hidden" id="wlan1_auto_channel_enable" name="wlan1_auto_channel_enable" value="<!--# echo wlan1_auto_channel_enable -->"> 
                </td>
              </tr>
              <tr> 
                <td class="duple"><script>show_words(_wchannel)</script> :</td>
                <td width="340">&nbsp;&nbsp; <select name="sel_wlan1_channel" id="sel_wlan1_channel" style="height:auto;">
                    <script>
										set_channel_1();
									</script>
                  </select> <input type="hidden" id="wlan1_channel" name="wlan1_channel" value="<!--# echo wlan1_channel -->"> 
                </td>
              </tr>
              <!-- 11b txrate -->
              <tr id="show_11b_txrate1" style="display:none"> 
                <td class="duple"><script>show_words(bwl_TxR)</script> :</td>
                <td width="340">&nbsp;&nbsp; <select id="wlan1_11b_txrate" name="wlan1_11b_txrate">
                    <option value="" selected><script>show_words(bwl_TxR_0)</script></option>
                    <script>set_11b_txrate(get_by_id("wlan1_11b_txrate"));</script>
                  </select> </td>
              </tr>
              <!-- 11g txrate -->
              <tr id="show_11g_txrate1" style="display:none"> 
                <td height="24" class="duple"><script>show_words(bwl_TxR)</script> :</td>
                <td width="340">&nbsp;&nbsp; <select id="wlan1_11g_txrate" name="wlan1_11g_txrate">
                    <option value="" selected><script>show_words(bwl_TxR_0)</script></option>
                    <script>set_11g_txrate(get_by_id("wlan1_11g_txrate"));</script>
                  </select> </td>
              </tr>
              <!-- 11n txrate -->
              <tr id="show_11n_txrate1" style="display:none"> 
                <td class="duple"><script>show_words(bwl_TxR)</script> :</td>
                <td width="340">&nbsp;&nbsp; <select id="wlan1_11n_txrate" name="wlan1_11n_txrate">
                    <option value="" selected><script>show_words(bwl_TxR_0)</script></option>
                    <script>set_11n_txrate(get_by_id("wlan1_11n_txrate"));</script>
                  </select> </td>
              </tr>
              <!-- 11b/g txrate -->
              <tr id="show_11bg_txrate1" style="display:none"> 
                <td class="duple"><script>show_words(bwl_TxR)</script> :</td>
                <td width="340">&nbsp;&nbsp; <select id="wlan1_11bg_txrate" name="wlan1_11bg_txrate">
                    <option value="" selected><script>show_words(bwl_TxR_0)</script></option>
                    <script>set_11bg_txrate(get_by_id("wlan1_11bg_txrate"));</script>
                  </select> </td>
              </tr>
              <!-- 11g/n txrate -->
              <tr id="show_11gn_txrate1" style="display:none"> 
                <td class="duple"><script>show_words(bwl_TxR)</script> :</td>
                <td width="340">&nbsp;&nbsp; <select id="wlan1_11gn_txrate" name="wlan1_11gn_txrate">
                    <option value="" selected><script>show_words(bwl_TxR_0)</script></option>
                    <script>set_11gn_txrate(get_by_id("wlan1_11gn_txrate"));</script>
                  </select> </td>
              </tr>
              <!-- 11b/g/n txrate -->
              <tr id="show_11bgn_txrate1" style="display:none"> 
                <td class="duple"><script>show_words(bwl_TxR)</script> :</td>
                <td width="340">&nbsp;&nbsp; <select id="wlan1_11bgn_txrate" name="wlan1_11bgn_txrate">
                    <option value="" selected><script>show_words(bwl_TxR_0)</script></option>
                    <script>set_11bgn_txrate(get_by_id("wlan1_11bgn_txrate"));</script>
                  </select> </td>
              </tr>
              <tr id="show_channel_width_1"> 
                <td class="duple"><script>show_words(bwl_CWM)</script> :</td>
                <td width="340">&nbsp;&nbsp; <select id="11a_protection" name="11a_protection" onChange="add_channel()">
                    <option value="20"><script>show_words(bwl_ht20)</script></option>
                    <option value="auto"><script>show_words(bwl_ht2040)</script></option>
                  </select> <input type="hidden" id="wlan1_11n_protection" name="wlan1_11n_protection" value="<!--# echo wlan1_11n_protection -->"> 
                </td>
              </tr>
              <tr> 
                <td class="duple"><script>show_words(bwl_VS)</script> :</td>
                <td width="340">&nbsp; <input type="radio" name="wlan1_ssid_broadcast" value="1">
                  <script>show_words(bwl_VS_0)</script> 
                  <input type="radio" name="wlan1_ssid_broadcast" value="0">
                  <script>show_words(bwl_VS_1)</script> </td>
              </tr>
            </table>
          </div>
          <input type="hidden" id="wlan1_security" name="wlan1_security" value="<!--# echo wlan1_security -->">
          <input type="hidden" id="asp_temp_53" name="asp_temp_53" value="<!--# echo asp_temp_53","hex -->">
          <input type="hidden" id="asp_temp_54" name="asp_temp_54" value="<!--# echo asp_temp_54","hex -->">
          <input type="hidden" id="asp_temp_55" name="asp_temp_55" value="<!--# echo asp_temp_55","hex -->">
          <input type="hidden" id="asp_temp_56" name="asp_temp_56" value="<!--# echo asp_temp_56","hex -->">
          <div class="box" id="show_security_1"> 
            <h2><script>show_words(bws_WSMode)</script></h2>
            
          <script>show_words(bws_intro_WlsSec)</script>
          <br>
            <br>
            <table cellpadding="1" cellspacing="1" border="0" width="525">
              <tr> 
                <td class="duple"><script>show_words(bws_SM)</script> :</td>
                <td width="340">&nbsp; <select id="wep_type_1" name="wep_type_1" onChange="show_wpa_wep_1()">
                    <option value="0" selected><script>show_words(_none)</script></option>
				  <option value="1"><script>show_words(_WEP)</script></option>
				  <option value="2"><script>show_words(_WPApersonal)</script></option>
				  <option value="3"><script>show_words(_WPAenterprise)</script></option>
                  </select> </td>
              </tr>
            </table>
          </div>
          
        <div class="box" id="show_wep_1" style="display:none"> 
          <h2>
            <script>show_words(_WEP)</script>
          </h2>
            
          <p> 
            <script>show_words(bws_msg_WEP_1)</script>
          </p>
          <p> 
            <script>show_words(bws_msg_WEP_2)</script>
          </p>
          <p> 
            <script>show_words(bws_msg_WEP_3)</script>
          </p>
                  			
          <table cellpadding="1" cellspacing="1" border="0" width="525">
            <input type="hidden" id="wlan1_wep64_key_1" name="wlan1_wep64_key_1" value="<!--# echo wlan1_wep64_key_1","hex -->">
            <input type="hidden" id="wlan1_wep128_key_1" name="wlan1_wep128_key_1" value="<!--# echo wlan1_wep128_key_1","hex -->">
            <input type="hidden" id="wlan1_wep64_key_2" name="wlan1_wep64_key_2" value="<!--# echo wlan1_wep64_key_2","hex -->">
            <input type="hidden" id="wlan1_wep128_key_2" name="wlan1_wep128_key_2" value="<!--# echo wlan1_wep128_key_2","hex -->">
            <input type="hidden" id="wlan1_wep64_key_3" name="wlan1_wep64_key_3" value="<!--# echo wlan1_wep64_key_3","hex -->">
            <input type="hidden" id="wlan1_wep128_key_3" name="wlan1_wep128_key_3" value="<!--# echo wlan1_wep128_key_3","hex -->">
            <input type="hidden" id="wlan1_wep64_key_4" name="wlan1_wep64_key_4" value="<!--# echo wlan1_wep64_key_4","hex -->">
            <input type="hidden" id="wlan1_wep128_key_4" name="wlan1_wep128_key_4" value="<!--# echo wlan1_wep128_key_4","hex -->">
            <tr>
              <td class="duple"> <script>show_words(bws_WKL)</script>
                :</td>
              <td width="340">&nbsp; <select id="wep_key_len_1" name="wep_key_len_1" size=1 onChange="change_wep_key_fun_1();">
                  <option value="5"><script>show_words(bws_WKL_0)</script></option>
				  <option value="13"><script>show_words(bws_WKL_1)</script></option>
                </select>
                 <script>show_words(bws_length)</script> </td>
            </tr>
            <tr id=show_wlan1_wep style="display:none">
              <td class="duple"> <script>show_words(bws_DFWK)</script>
                :</td>
              <td width="340">&nbsp; <select id="wep_def_key_1" name="wep_def_key_1" onChange="ischeck_wps('wep');">
                  <option value="1"><script>show_words(wepkey1)</script></option>
		  <option value="2"><script>show_words(wepkey2)</script></option>
		  <option value="3"><script>show_words(wepkey3)</script></option>
		  <option value="4"><script>show_words(wepkey4)</script></option>
		</select> <input type="hidden" id="wlan1_wep_default_key" name="wlan1_wep_default_key" value="<!--# echo wlan1_wep_default_key -->"> 
              </td>
            </tr>
            <tr>
              <td class="duple"> <script>show_words(auth)</script>
                :</td>
              <td width="340">&nbsp; <select name="auth_type_1" id="auth_type_1" onChange="ischeck_wps('auto');">
                  <option value="auto"><script>show_words(_both)</script></option>
				  <option value="share"><script>show_words(bws_Auth_2)</script></option>
		      </select> </td>
            </tr>
            <tr>
              <td class="duple"><script>show_words(_wepkey1)</script>
                :</td>
              <td width="340">&nbsp; <span id="show_resert5"></span> </td>
            </tr>
            <span id="show_resert6"></span>
			<span id="show_resert7"></span>
			<span id="show_resert8"></span>
            <!--tr>
              <td class="duple"><script>show_words(_wepkey2)</script>
                :</td>
              <td width="340">&nbsp; <span id="show_resert6"></span> </td>
            </tr>
            <tr>
              <td class="duple"><script>show_words(_wepkey3)</script>
                :</td>
              <td width="340">&nbsp; <span id="show_resert7"></span> </td>
            </tr>
            <tr>
              <td class="duple"><script>show_words(_wepkey4)</script>
                :</td>
              <td width="340">&nbsp; <span id="show_resert8"></span> </td>
            </tr-->
          </table>
          </div>
          
        <div class="box" id="show_wpa_1"  style="display:none"> 
          <h2>
            <script>show_words(_WPA)</script>
          </h2>
            
          <p> 
            <script>show_words(bws_msg_WPA)</script>
          </p>
          <p> 
            <script>show_words(bws_msg_WPA_2)</script>
          </p>
							<input type="hidden" id="wlan1_psk_cipher_type" name="wlan1_psk_cipher_type" value="<!--# echo wlan1_psk_cipher_type -->">
            
          <table cellpadding="1" cellspacing="1" border="0" width="525">
            <tr>
              <td class="duple"> <script>show_words(bws_WPAM)</script>
                :</td>
              <td width="340">&nbsp; <select id="wpa_mode_1" name="wpa_mode_1">
				<option value="auto"><script>show_words(bws_WPAM_2)</script></option>
				<option value="wpa2"><script>show_words(bws_WPAM_3)</script></option>
				<option value="wpa"><script>show_words(bws_WPAM_1)</script></option>
				</select></td>
            </tr>
            <tr>
              <td class="duple"> <script>show_words(bws_CT)</script>
                :</td>
              <td width="340">&nbsp; <select id="c_type_1" name="c_type_1" onChange="check_wps_psk_eap_1()">
                  <option value="tkip"><script>show_words(bws_CT_1)</script></option>
				<option value="aes"><script>show_words(bws_CT_2)</script></option>
				<option value="both"><script>show_words(bws_CT_3)</script></option>
                </select> </td>
            </tr>
            <tr>
              <td class="duple"> <script>show_words(bws_GKUI)</script>
                :</td>
              <td width="340">&nbsp; <input type="text" id="wlan1_gkey_rekey_time" name="wlan1_gkey_rekey_time" size="8" maxlength="5" value="<!--# echo wlan1_gkey_rekey_time -->">
                <script>show_words(bws_secs)</script></td>
            </tr>
          </table>
          </div>
          
        <div class="box" id="show_wpa_psk_1" style="display:none"> 
          <h2>
            <script>show_words(_psk)</script>
          </h2>
						
          <p class="box_msg"> 
            <script>show_words(KR18)</script>
            <script>show_words(KR19)</script>
          </p>
            <table cellpadding="1" cellspacing="1" border="0" width="525">
              <tr> 
                <td class="duple"><script>show_words(_psk)</script> :</td>
                <td width="340">&nbsp;
                  <input type="password" id="wlan1_psk_pass_phrase" name="wlan1_psk_pass_phrase" size="40" maxlength="64" value="<!--# echot wlan1_psk_pass_phrase -->"></td>
              </tr>
            </table>
          </div>
          <div class="box" id="show_wpa_eap_1" style="display:none"> 
            <h2><script>show_words(bws_EAPx)</script></h2>
            <p class="box_msg"><script>show_words(bws_msg_EAP)</script></p>
            
          <table cellpadding="1" cellspacing="1" border="0" width="525">
            <tr>
              <td class="duple"> <script>show_words(bwsAT_)</script>
                :</td>
              <input type="hidden" id="wlan1_eap_radius_server_0" name="wlan1_eap_radius_server_0" value="<!--# echo wlan1_eap_radius_server_0 -->">
              <input type="hidden" id="wlan1_eap_mac_auth" name="wlan1_eap_mac_auth" value="<!--# echo wlan1_eap_mac_auth -->">
              <td width="340">&nbsp; <input id="wlan1_eap_reauth_period" name="wlan1_eap_reauth_period" size=10 value="<!--# echo wlan1_eap_reauth_period -->">
                <script>show_words(_minutes)</script></td>
            </tr>
            <tr>
              <td class="duple"> <script>show_words(bws_RIPA)</script>
                :</td>
              <td width="340">&nbsp; <input id="radius_ip1_1" name="radius_ip1_1" maxlength=15 size=15></td>
            </tr>
            <tr>
              <td class="duple"> <script>show_words(bws_RSP)</script>
                :</td>
              <td width="340">&nbsp; <input type="text" id="radius_port1_1" name="radius_port1_1" size="8" maxlength="5" value="1812"></td>
            </tr>
            <tr>
              <td class="duple"> <script>show_words(bws_RSSs)</script>
                :</td>
              <td width="340">&nbsp; <input type="password" id="radius_pass1_1" name="radius_pass1_1" size="32" maxlength="64"></td>
            </tr>
            <tr>
              <td class="duple"> <script>show_words(bws_RMAA)</script>
                :</td>
              <td width="340">&nbsp; <input type="checkbox" id="radius_auth_mac1_1" name="radius_auth_mac1_1"></td>
            </tr>
            <tr id="radius2_1"> 
              <td colspan="2"><input type="button" id="advanced_1" name="advanced_1" value="" onClick="show_radius_1();">
			  <script>get_by_id("advanced_1").value = _advanced+">>";</script></td>
            </tr>
            <tr id="none_radius2_1" style="display:none"> 
              <td colspan="2"><input type="button" id="advanced_2" name="advanced_2" value="" onClick="show_radius_1();">
			  <script>get_by_id("advanced_2").value = "<<"+_advanced;</script></td>
            </tr>
          </table>
            
          <table id="show_radius2_1" cellpadding="1" cellspacing="1" border="0" width="525" style="display:none">
            <tr> 
              <input type="hidden" id="wlan1_eap_radius_server_1" name="wlan1_eap_radius_server_1" value="<!--# echo wlan1_eap_radius_server_1 -->">
              <td class="box_msg" colspan="2"><script>show_words(bws_ORAD)</script>
                :</td>
            </tr>
            <tr>
              <td class="duple"> <script>show_words(bws_2RIPA)</script>
                :</td>
              <td width="340">&nbsp; <input id="radius_ip2_1" name="radius_ip2_1" maxlength=15 size=15></td>
            </tr>
            <tr>
              <td class="duple"> <script>show_words(bws_2RSP)</script>
                :</td>
              <td width="340">&nbsp; <input type="text" id="radius_port2_1" name="radius_port2_1" size="8" maxlength="5" value="1812"></td>
            </tr>
            <tr>
              <td class="duple"> <script>show_words(bws_2RSSS)</script>
                :</td>
              <td width="340">&nbsp; <input type="password" id="radius_pass2_1" name="radius_pass2_1" size="32" maxlength="64"></td>
            </tr>
            <tr>
              <td class="duple"> <script>show_words(bws_2RMAA)</script>
                :</td>
              <td width="340">&nbsp; <input type="checkbox" id="radius_auth_mac2_1" name="radius_auth_mac2_1"></td>
            </tr>
          </table>
          </div>
			</form>
            
    <td valign="top" width="150" id="sidehelp_container" align="left"> <table cellSpacing=0 cellPadding=2 bgColor=#ffffff border=0>
        <tbody>
          <tr> 
            <td id=help_text><strong> 
              <script>show_words(_hints)</script>
              &hellip;</strong> <p> 
                <script>show_words(YM123)</script>
              </p>
              <p> 
                <script>show_words(YM124)</script>
              </p>
              <p> 
                <script>show_words(YM125)</script>
              </p>
              <p> 
                <script>show_words(YM126)</script>
              </p>
              <p><a href="support_internet.asp#Wireless" onclick="return jump_if();">
                <script>show_words(_more)</script>
                &hellip;</a></p></td>
          </tr>
        </tbody>
      </table></td>
		</tr>
	</table>
	<table id="footer_container" border="0" cellpadding="0" cellspacing="0" width="838" align="center">
		<tr>
			<td width="125" align="center">&nbsp;&nbsp;<img src="wireless_tail.gif" width="114" height="35"></td>
			<td width="10">&nbsp;</td>
			<td>&nbsp;</td>
		</tr>
	</table>
<script>
onPageLoad();
</script>    
<br>
<div id="copyright">Copyright &copy; 2004-2010 D-Link Corporation, Inc.</div>
<br>
</body>
<script>reboot_needed(left["Setup"].link[1]);</script>
</html>
