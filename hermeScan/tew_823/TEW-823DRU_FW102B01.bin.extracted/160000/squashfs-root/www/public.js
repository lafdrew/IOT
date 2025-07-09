var subnet_mask = new Array(0, 128, 192, 224, 240, 248, 252, 254, 255);
var key_num_array = new Array("64", "128");
var Week = new Array(_Sun, _Mon, _Tue, _Wed, _Thu, _Fri, _Sat);
var month = new Array(tt_Jan, tt_Feb, tt_Mar, tt_Apr, tt_May, tt_Jun, tt_Jul, tt_Aug, tt_Sep, tt_Oct, tt_Nov, tt_Dec);
var sequence = new Array(tt_week_1, tt_week_2, tt_week_3, tt_week_4, tt_week_5, tt_week_6);
var name_word = new Array('#', '*', '/', ',', ';', '"', "'");
var name_word_psk = new Array('/', ',', ';', '"', "'", ' ');
var format_error_msg = new Array(FMT_INVALID_IPADDRESS,FMT_INVALID_IPRANGE,FMT_INVALID_IPNETWORK,FMT_INVALID_IPFORMAT,
FMT_INVALID_IPUSABLE,FMT_INVALID_ACCOUNT,FMT_INVALID_USERNAME);
var check_num_msg = new Array(check_num_msg1,check_num_msg2,check_num_msg3,check_num_msg4);

//adv_virtual.asp
var default_virtual = new Array(
	new rule_obj("TELNET", "6", 23, 23),
	new rule_obj("HTTP", "6", 80, 80),
	new rule_obj("HTTPS", "6", 443, 443),
	new rule_obj("FTP", "6", 21, 21),
	new rule_obj("DNS", "17", 53, 53),
	new rule_obj("SMTP", "6", 25, 25),
	new rule_obj("POP3", "6", 110, 110),
	new rule_obj("H.323", "6", 1720, 1720),
	new rule_obj("REMOTE DESKTOP", "6", 3389, 3389),
	new rule_obj("PPTP", "6", 1723, 1723),
	new rule_obj("L2TP", "17", 1701, 1701),
	new rule_obj("Wake-On-LAN", "17", 9, 9)
);

//adv_portfording.asp
var default_rule = new Array(
new rule_obj("Age of Empires", "TCP", "2302-2400,6073", "2302-2400,6073"),
new rule_obj("Aliens vs. Predator", "TCP", "80,2300-2400,8000-8999", "80,2300-2400,8000-8999"),
new rule_obj("America's Army", "TCP", "20045", "1716-1718,8777,27900"),
new rule_obj("Asheron's Call", "TCP", "9000-9013", "2001,9000-9013"),
new rule_obj("Battlefield 1942", "TCP", "", "14567,22000,23000-23009,27900,28900"),
new rule_obj("Battlefield 2", "TCP", "80,4711,29900,29901,29920,28910", "1500-4999,16567,27900,29900,29910,27901,55123,55124,55215"),
new rule_obj("Battlefield: Vietnam", "TCP", "", "4755,23000,22000,27243-27245"),
new rule_obj("BitTorrent", "TCP", "6881-6889", ""),
new rule_obj("Black and White", "TCP", "2611-2612,6500,6667,27900", "2611-2612,6500,6667,27900"),
new rule_obj("Call of Duty", "TCP", "28960", "20500,20510,28960"),
new rule_obj("Command and Conquer Generals", "TCP", "80,6667,28910,29900,29920", "4321,27900"),
new rule_obj("Command and Conquer Zero Hour", "TCP", "80,6667,28910,29900,29920", "4321,27900"),
new rule_obj("Counter Strike", "TCP", "27030-27039", "1200,27000-27015"),
new rule_obj("D-Link DVC-1000", "TCP", "1720,15328-15333", "15328-15333"),
new rule_obj("Dark Reign 2", "TCP", "26214", "26214"),
new rule_obj("Delta Force", "TCP", "3100-3999", "3568"),
new rule_obj("Diablo I and II", "TCP", "6112-6119,4000", "6112-6119"),
new rule_obj("Doom 3", "TCP", "", "27666"),
new rule_obj("Dungeon Siege", "TCP", "", "6073,2302-2400"),
new rule_obj("eDonkey", "TCP", "4661-4662", "4665"),
new rule_obj("eMule", "TCP", "4661-4662,4711", "4672,4665"),
new rule_obj("Everquest", "TCP", "1024-6000,7000", "1024-6000,7000"),
new rule_obj("Far Cry", "TCP", "", "49001,49002"),
new rule_obj("Final Fantasy XI (PC)", "TCP", "25,80,110,443,50000-65535", "50000-65535"),
new rule_obj("Final Fantasy XI (PS2)", "TCP", "1024-65535", "50000-65535"),
new rule_obj("Gamespy Arcade", "TCP", "", "6500"),
new rule_obj("Gamespy Tunnel", "TCP", "", "6700"),
new rule_obj("Ghost Recon", "TCP", "2346-2348", "2346-2348"),
new rule_obj("Gnutella", "TCP", "6346", "6346"),
new rule_obj("Half Life", "TCP", "6003,7002", "27005,27010,27011,27015"),
new rule_obj("Halo: Combat Evolved", "TCP", "", "2302,2303"),
new rule_obj("Heretic II", "TCP", "28910", "28910"),
new rule_obj("Hexen II", "TCP", "26900", "26900"),
new rule_obj("Jedi Knight II: Jedi Outcast", "TCP", "", "28060,28061,28062,28070-28081"),
new rule_obj("Jedi Knight III: Jedi Academy", "TCP", "", "28060,28061,28062,28070-28081"),
new rule_obj("KALI", "TCP", "", "2213,6666"),
new rule_obj("Links", "TCP", "2300-2400,47624", "2300-2400,6073"),
new rule_obj("Medal of Honor: Games", "TCP", "12203-12204", ""),
new rule_obj("MSN Game Zone", "TCP", "6667", "28800-29000"),
new rule_obj("MSN Game Zone (DX)", "TCP", "2300-2400,47624", "2300-2400"),
new rule_obj("Myth", "TCP", "3453", "3453"),
new rule_obj("Need for Speed", "TCP", "9442", "9442"),
new rule_obj("Need for Speed 3", "TCP", "1030", "1030"),
new rule_obj("Need for Speed: Hot Pursuit 2", "TCP", "8511,28900", "1230,8512,27900,61200-61230"),
new rule_obj("Neverwinter Nights", "TCP", "", "5120-5300,6500,27900,28900"),
new rule_obj("PainKiller", "TCP", "", "3455"),
new rule_obj("PlayStation2", "TCP", "4658,4659", "4658,4659"),
new rule_obj("Postal 2: Share the Pain", "TCP", "80", "7777-7779,27900,28900"),
new rule_obj("Quake 2", "TCP", "27910", "27910"),
new rule_obj("Quake 3", "TCP", "27660,27960", "27660,27960"),
new rule_obj("Rainbow Six", "TCP", "2346", "2346"),
new rule_obj("Rainbow Six: Raven Shield", "TCP", "", "7777-7787,8777-8787"),
new rule_obj("Return to Castle Wolfenstein", "TCP", "", "27950,27960,27965,27952"),
new rule_obj("Rise of Nations", "TCP", "", "34987"),
new rule_obj("Roger Wilco", "TCP", "3782", "27900,28900,3782-3783"),
new rule_obj("Rogue Spear", "TCP", "2346", "2346"),
new rule_obj("Serious Sam II", "TCP", "25600-25605", "25600-25605"),
new rule_obj("Shareaza", "TCP", "6346", "6346"),
new rule_obj("Silent Hunter II", "TCP", "3000", "3000"),
new rule_obj("Soldier of Fortune", "TCP", "", "28901,28910,38900-38910,22100-23000"),
new rule_obj("Soldier of Fortune II: Double Helix", "TCP", "", "20100-20112"),
new rule_obj("Splinter Cell: Pandora Tomorrow", "TCP", "40000-43000", "44000-45001,7776,8888"),
new rule_obj("Star Trek: Elite Force II", "TCP", "", "29250,29256"),
new rule_obj("Starcraft", "TCP", "6112-6119,4000", "6112-6119"),
new rule_obj("Starsiege Tribes", "TCP", "", "27999,28000"),
new rule_obj("Steam", "TCP", "27030-27039", "1200,27000-27015"),
new rule_obj("SWAT 4", "TCP", "", "10480-10483"),
new rule_obj("TeamSpeak", "TCP", "", "8767"),
new rule_obj("Tiberian Sun", "TCP", "1140-1234,4000", "1140-1234,4000"),
new rule_obj("Tiger Woods 2K4", "TCP", "80,443,1791-1792,13500,20801-20900,32768-65535", "80,443,1791-1792,13500,20801-20900,32768-65535"),
new rule_obj("Tribes of Vengeance", "TCP", "7777,7778,28910", "6500,7777,7778,27900"),
new rule_obj("Ubi.com", "TCP", "40000-42999", "41005"),
new rule_obj("Ultima", "TCP", "5001-5010,7775-7777,7875,8800-8900,9999", "5001-5010,7775-7777,7875,8800-8900,9999"),
new rule_obj("Unreal", "TCP", "7777,8888,27900", "7777-7781"),
new rule_obj("Unreal Tournament", "TCP", "7777-7783,8080,27900", "7777-7783,8080,27900"),
new rule_obj("Unreal Tournament 2004", "TCP", "28902", "7777-7778,7787-7788"),
new rule_obj("Vietcong", "TCP", "", "5425,15425,28900"),
new rule_obj("Warcraft II", "TCP", "6112-6119,4000", "6112-6119"),
new rule_obj("Warcraft III", "TCP", "6112-6119,4000", "6112-6119"),
new rule_obj("WinMX", "TCP", "6699", "6257"),
new rule_obj("Wolfenstein: Enemy Territory", "TCP", "", "27950,27960,27965,27952"),
new rule_obj("WON Servers", "TCP", "27000-27999", "15001,15101,15200,15400"),
new rule_obj("World of Warcraft", "TCP", "3724,6112,6881-6999", ""),
new rule_obj("Xbox Live", "TCP", "3074", "88,3074")
);

//adv_appl.asp
var default_appl = new Array(new appl_obj("AIM Talk", "TCP", "4099", "TCP", "5190"),
new appl_obj("BitTorrent", "TCP", "6969", "TCP", "6881-6889"),
new appl_obj("Calista IP phone", "TCP", "5190", "UDP", "3000"),
new appl_obj("ICQ", "UDP", "4000", "TCP", "20000,20019,20039,20059"),
new appl_obj("PalTalk", "TCP", "5001-5020", "Any", "2090,2091,2095")
);

//many pages will use the array.
var all_ip_addr_msg = new Array(
MSG006, MSG007, MSG002, MSG003, MSG004, MSG005, 
MSG026, MSG027, MSG028, MSG029, TEXT031, TEXT032,
TEXT030);

//many pages will use the array.
var subnet_mask_msg = new Array(
SUBMASK_0, SUBMASK_1, SUBMASK_2, SUBMASK_3, SUBMASK_4, 
SUBMASK_5, SUBMASK_6, SUBMASK_7, SUBMASK_8, SUBMASK_9);

//adv_routing.asp
var metric_msg = new Array( ROUTING_MSG0, ROUTING_MSG1, ROUTING_MSG2 );	

//IPV6
var all_ipv6_addr_msg = new Array(
MSG006,	MSG007,	MSG018, MSG019, MSG020, MSG021, MSG022, MSG023, MSG024, MSG025,
MSG026, MSG027, MSG028, MSG029, MSG030, MSG031, MSG032, MSG033, "",  "",	
MSG034, MSG035
);

var ip_addr_msg = new Array(INVALID_IP, ZERO_IP, FIRST_IP_ERROR, SECOND_IP_ERROR, 
THIRD_IP_ERROR, FOURTH_IP_ERROR, FIRST_RANGE_ERROR, SECOND_RANGE_ERROR, THIRD_RANGE_ERROR,
FOURTH_RANGE_ERROR, MULTICASE_IP_ERROR);
var time="<!--# echo session_timeout -->";

function time_out(){
	time=time-1;
	if(time<0){
		window.location.href="login_pic.asp";
	}
	setTimeout("time_out()",1000);
}

function rule_obj(name, prot, public_port, private_port){	
	this.name = name;
	this.prot = prot;		// TCP, UDP
	this.public_port = public_port;
	this.private_port = private_port;
} 

function appl_obj(name, trigger_prot, trigger_port, public_prot, public_port){
	this.name = name;
	this.trigger_prot = trigger_prot;		// TCP, UDP
	this.trigger_port = trigger_port;
	this.public_prot = public_prot;
	this.public_port = public_port;
}

function set_application_option(obj_value, obj_array){
	for (var i = 0; i < obj_array.length; i++){
		var temp_rule = obj_array[i];
		obj_value += "<option>" + temp_rule.name + "</option>";
	}
	return obj_value;
}

function addr_obj(addr, e_msg, allow_zero, is_network){
	this.addr = addr;
	this.e_msg = e_msg;
	this.allow_zero = allow_zero;		
	this.is_network = is_network;
}

function varible_obj(var_value, e_msg, min, max, is_even){
	this.var_value = var_value;
	this.e_msg = e_msg;
	this.min = min;
	this.max = max;		
	this.is_even = is_even;		
}

function raidus_obj(ip, port, secret){
	this.ip = ip;
	this.port = port;
	this.secret = secret;
}

function ip4_obj(ip, min_range, max_range, e_msg1, e_msg2){	
	this.ip = ip;	
	this.min_range = min_range;
	this.max_range = max_range;		
	this.e_msg1 =e_msg1;
	this.e_msg2 =e_msg2;	
}

function change_wan(){
    var html_file;
    var wan_value=get_by_id("wan_proto").value;
    if(wan_value=="static")
    	html_file="wan_static.asp";
    else if(wan_value=="dhcpc")
    	html_file="wan_dhcp.asp";
    else if(wan_value=="pppoe")
    	html_file="wan_poe.asp";
    else if(wan_value=="pptp")
    	html_file="wan_pptp.asp";
    else if(wan_value=="l2tp")
    	html_file="wan_l2tp.asp";
    else if(wan_value=="dslite")
    	html_file="wan_dslite.asp";
    else if(wan_value=="usb3g")
    	html_file="wan_3G.asp";
    else if(wan_value=="usb3g_phone")
    	html_file="wan_usb3G_phone.asp";
    else if(wan_value=="mpppoe")
    	html_file="wan_mpoe.asp";
	else if(wan_value=="rus_pppoe")
    	html_file="wan_rus_poe.asp";
    else if(wan_value=="rus_pptp")
    	html_file="wan_rus_pptp.asp";
    else if(wan_value=="rus_l2tp")
    	html_file="wan_rus_l2tp.asp";
    	
    location.href = html_file;
    /*switch(get_by_id("wan_proto").selectedIndex){
	case 0 :
	    	html_file = "wan_static.asp";
	    	break;	   	
	case 1 :
	    	html_file = "wan_dhcp.asp";
	    	break;
	case 2 :
	    	html_file = "wan_poe.asp";
	    	break;
	case 3 :
	    	html_file = "wan_pptp.asp";
	    	break;
	case 4 :
		html_file = "wan_l2tp.asp";
	    	break;*/
		/*
		//case 5 :
			//html_file = "wan_bigpond.asp";
	    	//break;
	    case 5 :
			html_file = "wan_rus_pptp.asp";
	    	break;
	    case 6 :
			html_file = "wan_rus_poe.asp";
	    	break;
	case 7 :
		html_file = "wan_rus_l2tp.asp";
	    	break;
		*/
	/*case 5 :
		html_file = "wan_dslite.asp";
	    	break;
	case 6 :
		html_file = "wan_3G.asp";
	    	break;
	case 7 :
		html_file = "wan_usb3G_phone.asp";
	    	break;
		
	}
	location.href = html_file;*/
}

function change_filter(which_filter){
    var html_file;
    
    switch(which_filter){
		case 0 :
	    	html_file = "adv_filters.asp";
	    	break;
		case 1 :
	    	html_file = "adv_filters_mac.asp";
	    	break;	    	
		case 2 :
	    	html_file = "adv_filters_url.asp";
	    	break;
		case 3 :
	    	html_file = "adv_filters_domain.asp";
	    	break;
	}
	
	location.href = html_file;
}

function change_routing(which_routing){
    var html_file;
    
    switch(which_routing){
        case 0 :
            html_file = "adv_routing.asp";
            break;
        case 1 :
            html_file = "adv_routing_dynamic.asp";
            break;
        case 2 :
            html_file = "adv_routing_table.asp";
            break;
    }
    
    location.href = html_file;
}

function check_DeviceName(tmp_hostName)
{
	var i;
	var error =false;
	var tmp_count=0;

	if (tmp_hostName.length <= 63){
		var tmp_stringlength = tmp_hostName.length - 1
		for(i = 0; i<tmp_hostName.length; i++) {
			var c = tmp_hostName.substring(i,i+1);
			if (("0" <= c && c <= "9")){
				tmp_count=tmp_count+1;
			}
			if((("0" <= c && c <= "9") || ("a" <= c && c <= "z") ||
			    ("A" <= c && c <= "Z") || (i!=0 && c=="-") &&
			    (i!=tmp_stringlength && c=="-")) && 
			    (tmp_count != tmp_hostName.length)) {
				continue;
			} else {
				alert(GW_LAN_DEVICE_NAME_INVALID);
				error= true;
				return error;
			}
		}
	} else {
		alert(GW_LAN_DEVICE_NAME_INVALID);
		error= true;
		return error;
	}
	return error;
}

function check_network_address(my_obj, mask_obj){
	var count_zero = 0;
	var ip = my_obj.addr;
	var mask;
	var allow_cast = false;

	if (my_obj.addr.length == 4){
		// check the ip is not multicast IP (127.x.x.x && 224.x.x.x ~ 239.x.x.x)
		if(my_obj.addr[0] == "127"){
			TEXT030=replaceAll(TEXT030, "%s", ip[0] + "." + ip[1] + "." + ip[2] + "." + ip[3]);
			alert(TEXT030); //MULTICASE_IP_ERROR
			return false;
		}
		
		// check the ip is "0.0.0.0" or not
		for(var i = 0; i < ip.length; i++){
			if (ip[i] == "0"){
				count_zero++;			
			}				
		}

		if (!my_obj.allow_zero && count_zero == 4){	// if the ip is not allowed to be 0.0.0.0
			alert(MSG046);			// but we check the ip is 0.0.0.0
			return false;
		}else if (count_zero != 4){		// when IP is not 0.0.0.0, checking range. Otherwise no need to check				
				mask = mask_obj.addr;
				for(var i = 0; i < mask.length; i++){
					if (mask[i] != "255"){
					if (ip[i] != (mask[i] & ip[i])){
						alert(my_obj.e_msg[6 + i] + (mask[i] & ip[i])); //FIRST_RANGE_ERROR
						return false;
					}
				}
			}
		}
	}else{	// if the length of ip is not correct, show invalid ip msg
		alert(my_obj.e_msg[0]); //INVALID_IP
		return false;
	}

	return true;
}

function check_domain(ip, mask, gateway){
	var temp_ip = ip.addr;
	var temp_mask = mask.addr;
	var temp_gateway = gateway.addr;
	var temp_str = "";
	
	for (var i = 0; i < 4; i++){
		temp_str += temp_gateway[i];
		
		if (i < 3){
			temp_str += ".";
		}
	}
	
	if (gateway.allow_zero && (temp_str == "0.0.0.0" || temp_str == "...")){
		return true;
	}

	for (var i = 0; i < temp_ip.length; i++){
		if ((temp_ip[i] & temp_mask[i]) != (temp_gateway[i] & temp_mask[i])){
			return false;		// when not in the same subnet mask, return false
		}
	}

	return true;
}

function check_ip_order(start_ip, end_ip){
	var temp_start_ip = start_ip.addr;
	var temp_end_ip = end_ip.addr;
	var total1 = ip_num(temp_start_ip);
	var total2 = ip_num(temp_end_ip);
    
    if(total1 > total2)
        return false;
	return true;
}

function check_lanip_order(ip,start_ip, end_ip){
	var temp_start_ip = start_ip.addr;
	var temp_end_ip = end_ip.addr;
	var temp_ip = ip.addr;
	var total1 = ip_num(temp_start_ip);
	var total2 = ip_num(temp_end_ip);
    var total3 = ip_num(temp_ip);
    if(total1 <= total3 && total3 <= total2)
         return true;
	return false;
}

function check_resip_order(reserved_ip,start_ip, end_ip){
	var temp_start_ip = start_ip.addr;
	var temp_end_ip = end_ip.addr;
	var temp_res_ip = reserved_ip.addr;
	var total1 = ip_num(temp_start_ip);
	var total2 = ip_num(temp_end_ip);
    var total3 = ip_num(temp_res_ip);
    if(total1 <= total3 && total3 <= total2)
        return false;
	return true;
}

function check_ip4(ip4){
	var temp_ip = (ip4.ip).split(" ");
	
	if (ip4.ip == ""){
		alert(ip4.e_msg1);
		return false;
	}else if (isNaN(ip4.ip) || temp_ip.length > 1 || parseInt(ip4.ip) < ip4.min_range || parseInt(ip4.ip) > ip4.max_range){
		alert(ip4.e_msg2);
		return false;
	}
	return true;
}

function check_5g_key(){
	var key;
	var def_key = get_by_id("wep_def_key_1").value;
	var wep_def_key = get_by_id("wep_def_key_1");
	var wep_key_len = parseInt(get_by_id("wep_key_len_1").value);
	var hex_len = wep_key_len * 2;

	for(var i = 1; i < 5; i++){
			key = get_by_id("key" + i).value;
			if (wep_def_key[i-1].selectedIndex){
		        if (key == ''){
		    	alert(aw_wep_msg0);
					return false;
    	        }
		  }else{
		    	if (key.length != wep_key_len && key.length != hex_len){
			    		alert(TEXT041_1 + " " + TEXT041_2 + " " + wep_key_len + " " + TEXT041_3 + " " + hex_len + " " + TEXT041_4);
			    		return false;
		    	}else if(key.length == hex_len){
			      	for (var j = 0; j < key.length; j++){
			      		if (!check_hex(key.substring(j, j+1))){
			      			alert(TEXT042_1 +" "+ i + " " + TEXT042_2);
			      			return false;
			      		}
			      	}
			      	if(i == def_key)
			      		get_by_id("wlan1_wep_display").value = "hex";
		    	}else{
		    			if(i == def_key)
		    				get_by_id("wlan1_wep_display").value = "ascii";
		    	}
		  }
	}
	return true;
}

function check_key(){
	var key;
	var def_key = get_by_id("wep_def_key").value;
	var wep_def_key = get_by_id("wep_def_key");
	var wep_key_len = parseInt(get_by_id("wep_key_len").value);
	var hex_len = wep_key_len * 2;

	for(var i = 1; i < 5; i++){
			key = get_by_id("key" + i).value;
			if (wep_def_key[i-1].selectedIndex){
		        if (key == ''){
				alert(aw_wep_msg0);
				return false;
			}
		  }else{
		    	if (key.length != wep_key_len && key.length != hex_len){
			    		alert(TEXT041_1 + " " + TEXT041_2 + " " + wep_key_len + " " + TEXT041_3 + " " + hex_len + " " + TEXT041_4);
			    		return false;
		    	}else if(key.length == hex_len){
			      	for (var j = 0; j < key.length; j++){
			      		if (!check_hex(key.substring(j, j+1))){
			      			alert(TEXT042_1 +" "+ i + " " + TEXT042_2);
			      			return false;
			      		}
			      	}
			      	if(i == def_key)
			      		get_by_id("wlan0_wep_display").value = "hex";
		    	}else{
		    			if(i == def_key)
		    				get_by_id("wlan0_wep_display").value = "ascii";
		    	}
		  }
	}
	return true;
}

function check_key_1(){
	var key;
	var def_key = get_by_id("wep_def_key_1").value;
	var wep_def_key = get_by_id("wep_def_key_1");
	var wep_key_len = parseInt(get_by_id("wep_key_len_1").value);
	var hex_len = wep_key_len * 2;

	for(var i = 1; i < 5; i++){
		key = get_by_id("key" + (i+4)).value;
		if (wep_def_key[i-1].selectedIndex){
			if (key == ''){
				alert(aw_wep_msg0);
				return false;
			}
		}else{
			if (key.length != wep_key_len && key.length != hex_len){
				alert(TEXT041_1 + " " + TEXT041_2 + " " + wep_key_len + " " + TEXT041_3 + " " + hex_len + " " + TEXT041_4);
				return false;
			}else if(key.length == hex_len){
				for (var j = 0; j < key.length; j++){
					if (!check_hex(key.substring(j, j+1))){
						alert(TEXT042_1 +" "+ i + " " + TEXT042_2);
						return false;
					}
				}
				if(i == def_key)
					get_by_id("wlan1_wep_display").value = "hex";
			}else{
				if(i == def_key)
					get_by_id("wlan1_wep_display").value = "ascii";
			}
		}
	}
	return true;
}


function check_vap1_key_1(){
	var key;
	var def_key = get_by_id("wep_def_key_1").value;
	var wep_def_key = get_by_id("wep_def_key_1");
	var wep_key_len = parseInt(get_by_id("wep_key_len_1").value);
	var hex_len = wep_key_len * 2;

	for(var i = 1; i < 5; i++){
		var tkey_idx = i+4;
		key = get_by_id("key" + tkey_idx).value;
		if (wep_def_key[i-1].selectedIndex){
			if (key == ''){
				alert(msg[WEP_KEY_EMPTY]);
				return false;
			}
		}else{
			if (key.length != wep_key_len && key.length != hex_len){
			alert(TEXT041_1+" " + i + " "+TEXT041_2+" " + wep_key_len + " "+TEXT041_3+" " + hex_len + " "+TEXT041_4);//TEXT041
			return false;
		}else if(key.length == hex_len){
			for (var j = 0; j < key.length; j++){
				if (!check_hex(key.substring(j, j+1))){
					alert(TEXT042_1+" " + i + " "+TEXT042_2);//TEXT042
					return false;
				}
			}
			if(i == def_key)
				get_by_id("wlan1_vap1_wep_display").value = "hex";
			}else{
				if(i == def_key)
					get_by_id("wlan1_vap1_wep_display").value = "ascii";
			}
		}
	}
	return true;
}


function check_vap1_key(){
	var key;
	var def_key = get_by_id("wep_def_key").value;
	var wep_def_key = get_by_id("wep_def_key");
	var wep_key_len = parseInt(get_by_id("wep_key_len").value);
	var hex_len = wep_key_len * 2;

	for(var i = 1; i < 5; i++){
		key = get_by_id("key" + i).value;
		if (wep_def_key[i-1].selectedIndex){
			if (key == ''){
				alert(msg[WEP_KEY_EMPTY]);
				return false;
			}
		}else{
			if (key.length != wep_key_len && key.length != hex_len){
			alert(TEXT041_1+" " + i + " "+TEXT041_2+" " + wep_key_len + " "+TEXT041_3+" " + hex_len + " "+TEXT041_4);//TEXT041
			return false;
		}else if(key.length == hex_len){
			for (var j = 0; j < key.length; j++){
				if (!check_hex(key.substring(j, j+1))){
					alert(TEXT042_1+" " + i + " "+TEXT042_2);//TEXT042
					return false;
				}
			}
			if(i == def_key)
				get_by_id("wlan0_vap1_wep_display").value = "hex";
			}else{
				if(i == def_key)
					get_by_id("wlan0_vap1_wep_display").value = "ascii";
			}
		}
	}
	return true;
}


function check_integer(which_value, min, max){	
	var temp_obj = (which_value).split(" ");
	
	if (temp_obj == "" || temp_obj.length > 1 || isNaN(which_value)){	
		return false;
	}else if (parseInt(which_value,10) < min || parseInt(which_value,10) > max){
		return false;
	}
	
	return true;
}

function get_seq(index){
	var seq;
	
	switch(index){
		case 0:
			seq = "1st";
			break;
		case 1:
			seq = "2nd";
			break;
		case 2:
			seq = "3rd";
			break;
		case 3:
			seq = "4th";
			break;
	}
	return seq;
}

function check_ip_range(order, my_obj, mask){
	var which_ip = (my_obj.addr[order]).split(" ");
	var start, end;

	if (isNaN(which_ip) || which_ip == "" || which_ip.length > 1 || (which_ip[0].length > 1 && which_ip[0].substring(0,1) == "0")){	// if the address is invalid
		alert(my_obj.e_msg[2 + order]);
		return false;
	}

	if (order == 0){				// the checking range of 1st address
		start = 1;
	}else{
				start = 0;
			}
		
	if (mask[order] != 255){		
		if (parseInt(which_ip) >= 0 && parseInt(which_ip) <= 255){	
			end = (~mask[order]+256);				
			start = mask[order] & which_ip;	
			end += start;
		
			if (end > 255){
				end = 255;
			}
		}else{
			end = 255;
		}
	}else{
		end = 255;
	}
	
	
	if (order == 3){
		if ((mask[0] == 255) && (mask[1] == 255) && (mask[2] == 255)){
			start += 1;
			end -= 1;
		}else{
			if (((mask[0] | (~my_obj.addr[0]+256)) == 255) && ((mask[1] | (~my_obj.addr[1]+256)) == 255) && ((mask[2] | (~my_obj.addr[2]+256)) == 255)){
				start += 1;
			}
			
			if (((mask[0] | my_obj.addr[0]) == 255) && ((mask[1] | my_obj.addr[1]) == 255) && ((mask[2] | my_obj.addr[2]) == 255)){			
				end -= 1;
			}				
		}
		}
		
	if (parseInt(which_ip) < start || parseInt(which_ip) > end){			
		alert(my_obj.e_msg[6 + order] + " " + start + " ~ " + end + "."); //FIRST_RANGE_ERROR=6
		return false;
	}

	return true;
}

function check_current_range(order, my_obj, checking_ip, mask){
	var which_ip = (my_obj.addr[order]).split(" ");
	var start, end;

	if (isNaN(which_ip) || which_ip == "" || which_ip.length > 1 || (which_ip[0].length > 1 && which_ip[0].substring(0,1) == "0")){	// if the address is invalid
		alert(my_obj.e_msg[2 + order]);
		return false;
	}
	
	if (order == 0){				// the checking range of 1st address
		start = 1;	
	}else{
		start = 0;				
	}
	
	if (mask[order] != 255){				
		if (parseInt(checking_ip[order]) >= 0 && parseInt(checking_ip[order]) <= 255){	
			end = (~mask[order]+256);				
			start = mask[order] & checking_ip[order];	
			end += start;
		
			if (end > 255){
				end = 255;
			}
		}else{
			end = 255;
		}
	}else{
		end = 255;
	}
	
	if (order == 3){
		if ((mask[0] == 255) && (mask[1] == 255) && (mask[2] == 255)){
			start += 1;
			end -= 1;
		}else{		
			if (((mask[0] | (~my_obj.addr[0]+256)) == 255) && ((mask[1] | (~my_obj.addr[1]+256)) == 255) && ((mask[2] | (~my_obj.addr[2]+256)) == 255)){
				start += 1;
			}
			
			if (((mask[0] | my_obj.addr[0]) == 255) && ((mask[1] | my_obj.addr[1]) == 255) && ((mask[2] | my_obj.addr[2]) == 255)){			
				end -= 1;
			}	
		}	
	}
		
	if (parseInt(which_ip) < start || parseInt(which_ip) > end){			
		alert(my_obj.e_msg[6 + order] + " " + start + " ~ " + end + ".");		
		return false;
	}
	
	return true;
}

function check_hex(data){
	data = data.toUpperCase();
	for (var i = 0; i < data.length; i++){	
		var temp_char = data.charAt(i);
		
		if (!(temp_char >= 'A' && temp_char <= 'F') && !(temp_char >= '0' && temp_char <= '9')){	
			return false;
		}
	}
	return true;
}										
				
function check_lan_setting(ip, mask, gateway, obj_word){				
	 if (!check_mask(mask)){
		return false;   // when subnet mask is not in the subnet mask range
	}else if (!check_address(ip, mask)){
		return false;		// when ip is invalid
	}else if (!check_address(gateway, mask, ip)){
		return false;	// when gateway is invalid
	}else if (!check_domain(ip, mask, gateway)){		// check if the ip and the gateway are in the same subnet mask or not
		var gateway_ipaddr_1 = gateway.addr[0]+"."+gateway.addr[1]+"."+gateway.addr[2]+"."+gateway.addr[3];
		alert(addstr(TEXT043, obj_word, gateway_ipaddr_1));
		return false;
	}
	return true;
}
function check_mac(mac){
    var temp_mac = mac.split(":");
    var error = true;
    var mac_val = parseInt(temp_mac[0],16);

    if (temp_mac.length == 6){
	     //if(temp_mac[0] != "00" && temp_mac[0] != "08"){
		 if(mac_val%=2){
	    	return false;
	    }
	    for (var i = 0; i < 6; i++){        
	        var temp_str = temp_mac[i];
	        
	        if (temp_str == ""){
	            error = false;
	        }else{        	
	            if (!check_hex(temp_str.substring(0,1)) || !check_hex(temp_str.substring(1))){
	                error = false;
	            }
	        }
	        
	        if (!error){
	            break;
	        }
	    }
	}else{
		error = false;
	}
    return error;
}
function check_mac_00(mac){
    var error = true;
    if((mac.indexOf(':') != -1)){
    	var temp_mac = mac.split(":");
    }else if((mac.indexOf('-') != -1)){
    	var temp_mac = mac.split("-");
    }
    
    if(mac.length != 17) {
        return false;
    }
    if(mac.substring(0,2) != "00"){
    	return false;
    }    
    
    if (temp_mac.length == 6){
    	var j=0;
	    for (var i = 0; i < 6; i++){        
	        var temp_str = temp_mac[i];
	        
	        if (temp_str == ""){
	            error = false;
	        }
	        else if(temp_str == "00"){
	        	j++;
	        }	
	        else{        	
	            if (!check_hex(temp_str.substring(0,1)) || !check_hex(temp_str.substring(1))){
	                error = false;
				}
			}
	        if (!error){
	            break;
			}
		}
		if(j==6)
			error = false;
	}else{
		error = false;
	}
    return error;
}


function check_servername(servicename)
{
        var regex = /[a-z]/;
        var result = servicename.match(regex);
        if(result != null){
                return true;
        }


// 	regex = /^(\d{1,3})\.(\d{1,3})\.(\d{1,3})\.(\d{1,3})$\W*/;
/*
        result = regex.exec(servicename);
        if(result != null)
        {
                var tmp_ip = servicename.split(".");
                if(parseInt(tmp_ip[0]) <= 0 || parseInt(tmp_ip[0]) >= 224 || parseInt(tmp_ip[0]) == 127){
                        return false;
                }
		if(parseInt(tmp_ip[1]) > 255 || parseInt(tmp_ip[2]) > 255){
                        return false;
                }
                if(parseInt(tmp_ip[3]) <= 0 || parseInt(tmp_ip[3]) >= 255){
                        return false;
                }
                return true;
        }
*/
        return false;
}

function check_address(my_obj, mask_obj, ip_obj){
	var count_zero = 0;
	var count_bcast = 0;	
	var ip = my_obj.addr;
	var mask;
	
	if (my_obj.addr.length == 4){
		// check the ip is not multicast IP (127.x.x.x && 224.x.x.x ~ 239.x.x.x)
		if((my_obj.addr[0] == "127") || ((my_obj.addr[0] >= 224) && (my_obj.addr[0] <= 239))){
			TEXT030=replaceAll(TEXT030, "%s", ip[0] + "." + ip[1] + "." + ip[2] + "." + ip[3]);
			alert(TEXT030); //MULTICASE_IP_ERROR
			return false;
		}

		// check the ip is not 240~255.x.x.x
		if (my_obj.addr[0] >= 240) {
			alert(FMT_INVALID_IPUSABLE);
			return false;
		}

		// check the ip is "0.0.0.0" or not
		for(var i = 0; i < ip.length; i++){
			if (ip[i] == "0"){
				count_zero++;			
			}
		}

		if (!my_obj.allow_zero && count_zero == 4){	// if the ip is not allowed to be 0.0.0.0
			alert(MSG046);			// but we check the ip is 0.0.0.0
			return false;
		}else if (count_zero != 4){		// when IP is not 0.0.0.0, checking range. Otherwise no need to check		
			count_zero = 0;
				
			if (check_address.arguments.length >= 2 && mask_obj != null){
				mask = mask_obj.addr;
			}else{
				mask = new Array(255,255,255,0);
			}
						
			for(var i = 0; i < ip.length; i++){
				
				if (check_address.arguments.length == 3 && ip_obj != null){
					if (!check_current_range(i, my_obj, ip_obj.addr, mask)){
						return false;
					}
				}else{					
					if (!check_ip_range(i, my_obj, mask)){
						return false;
					}
				}
			}		
							
			for (var i = 0; i < 4; i++){	// check the IP address is a network address or a broadcast address																							
				if (((~mask[i] + 256) & ip[i]) == 0){	// (~mask[i] + 256) = reverse mask[i]
					count_zero++;						
				}
								
				if ((mask[i] | ip[i]) == 255){
					count_bcast++;
				}
			}
		
			if ((count_zero == 4 && !my_obj.is_network) || (count_bcast == 4)){
				alert(ipaddr_msg0);			
				return false;
			}													
		}
	}else{	// if the length of ip is not correct, show invalid ip msg
		alert(ipaddr_msg0);
		return false;
	}

	return true;
}

function check_route_mask(my_mask){
	var temp_mask = my_mask.addr;

	if (temp_mask.length == 4){
		for (var i = 0; i < temp_mask.length; i++){
			var which_ip = temp_mask[i].split(" ");
			var mask = parseInt(temp_mask[i]);
			var in_range = false;
			var j = 0;

			if (isNaN(which_ip) || which_ip == "" || which_ip.length > 1 || (which_ip[0].length > 1 && which_ip[0].substring(0,1) == "0")){	// if the address is invalid
				alert(my_mask.e_msg[2 + i]); //FIRST_IP_ERROR=2
				return false;
			}

			if (i == 0){	// when it's 1st address
				j = 1;		// the 1st address can't be 0
			}

			for (; j < subnet_mask.length; j++){
				if (mask == subnet_mask[j]){
					in_range = true;
					break;
				}else{
					in_range = false;
				}
			}

			if (!in_range){
				alert(my_mask.e_msg[6 + i]);
				return false;
			}

			if (i != 0 && mask != 0){ // when not the 1st range and the value is not 0
				if (parseInt(temp_mask[i-1]) != 255){  // check the previous value is 255 or not
					alert(ipaddr_msg0);
					return false;
				}
			}

			//if (i == 3 && (parseInt(mask) == 254 || parseInt(mask) == 255)){	// route mask don't check 4th mask=255 or 254
			//	alert(my_mask.e_msg[FOURTH_RANGE_ERROR]);
			//	return false;
			//}
		}
	}else{
		alert(ipaddr_msg0);
		return false;
	}

	return true;
}
function check_mask(my_mask){
	var temp_mask = my_mask.addr;

	if (temp_mask.length == 4){
		for (var i = 0; i < temp_mask.length; i++){
			var which_ip = temp_mask[i].split(" ");
			var mask = parseInt(temp_mask[i]);
			var in_range = false;
			var j = 0;

			if (isNaN(which_ip) || which_ip == "" || which_ip.length > 1 || (which_ip[0].length > 1 && which_ip[0].substring(0,1) == "0")){	// if the address is invalid
				alert(my_mask.e_msg[2 + i]);
				return false;
			}

			if (i == 0){	// when it's 1st address
				j = 1;		// the 1st address can't be 0
			}

			for (; j < subnet_mask.length; j++){
				if (mask == subnet_mask[j]){
					in_range = true;
					break;
				}else{
					in_range = false;
				}
			}

			if (!in_range){
				alert(my_mask.e_msg[6 + i]);
				return false;
			}

			if (i != 0 && mask != 0){ // when not the 1st range and the value is not 0
				if (parseInt(temp_mask[i-1]) != 255){  // check the previous value is 255 or not
					alert(ipaddr_msg0);
					return false;
				}
			}

			if (i == 3 && (parseInt(mask) == 254 || parseInt(mask) == 255)){	// when the last mask address is 255
				alert(subnet_mask_msg[9]);
				return false;
			}
		}
	}else{
		alert(my_mask.e_msg[0]);//INVALID_IP
		return false;
	}

	return true;
}

function check_username(name) {
	var re = /[^A-Za-z0-9_.#@-]/;
	if(name == "" || re.test(name))
		return false;
	else
		return true;
}

function check_pwd(pwd1, pwd2){
	if (get_by_id(pwd1).value != get_by_id(pwd2).value){
		 alert(TEXT051);
		return false;
	}
	return true;
}

function check_port(port){
    var temp_port = port.split(" ");
    
    if (isNaN(port) || port == "" || temp_port.length > 1 
    		|| (parseInt(port) < 1 || parseInt(port) > 65535)){
		 return false;
	}
	return true;
}

function check_radius(radius){
	if (!check_address(radius.ip)){
		return false;
	}else if (!check_port(radius.port)){
	MSG008=replaceAll(MSG008, "%s", radius.port);
        alert(MSG008);
        return false;
    }else if (radius.secret == ""){
	MSG009=replaceAll(MSG009, "%s", radius.secret);
        alert(MSG009);
        return false;               
	}
	
	return true;
}

function check_ssid(id){
	if (get_by_id(id).value == ""){
	    alert(_badssid);
	    return false;
	}

	var tssid = get_by_id(id).value;
	for (var i = 0; i < 32; i++) {
		var ssid_hex = tssid.charCodeAt(i).toString(10);
		if (ssid_hex < 32 || ssid_hex > 126) {
			alert(WIFI_INVALID_SSID);
			return false;
		}
	}

	return true;        
}

function check_varible(obj){
	var temp_obj = obj.var_value.split(" ");
    
	if (temp_obj == "" || temp_obj.length > 1){
//		alert(MSG012);
		alert(obj.e_msg[0]);//EMPTY_VARIBLE_ERROR
		return false;
	}else if (isNaN(obj.var_value) || Find_word(obj.var_value,".")){
//		alert(MSG013);
		alert(obj.e_msg[1]);//INVALID_VARIBLE_ERROR
		return false;
	}else if (parseInt(obj.var_value) < obj.min || parseInt(obj.var_value) > obj.max){
//		alert(MSG014);
		alert(obj.e_msg[2]);//VARIBLE_RANGE_ERROR
		return false;
	}else if (obj.is_even && (parseInt(obj.var_value) % 2 != 0)){
//		alert(MSG015);
		alert(obj.e_msg[3]); //EVEN_NUMBER_ERROR
        return false;
    }
    return true;
}

function check_pf_port(port){
    var temp_port = port.split(" ");
    
    if (isNaN(port) || port == "" || temp_port.length > 1 
    		|| (parseInt(port) <= 0 || parseInt(port) > 65535)){
        return false;
    }
    return true;
}

function check_multi_port(remote_port, obj_port){
	//multi-port: 25,80,110,443,50000-65535
	var port_info = obj_port + ",";
	var port = port_info.split(",");
	
	for(var i = 0; i < port.length; i++){
		var port_range = port[i].split("-");
		if(port_range.length > 1){
			if(parseInt(port_range[0]) <= parseInt(remote_port) && parseInt(port_range[1]) >= parseInt(remote_port)){
				return false;
			}
		}else{
			if(port[i] == remote_port){
				return false;
			}
		}
	}
	return true;
}
	
function change_color(table_name, row){
    var obj = get_by_id(table_name);
    for (var i = 1; i < obj.rows.length; i++){
        if (row == i){
            obj.rows[i].style.backgroundColor = "#FFFF00";
        }else{
            obj.rows[i].style.backgroundColor = "#FFFFFF";
        }
    }       
}

function exit_wizard(){
    if (confirm(_wizquit)){
        window.close();
    }
}

function exit_access(){
    if (confirm(_wizquit)){
        window.location.href = "adv_access_control.asp";
    }
}

function get_by_id(id){
	with(document){
		return getElementById(id);
	}
}

function get_by_name(name){
	with(document){
		return getElementsByName(name);
	}
}

function openwin(url,w,h) {
	var winleft = (screen.width - w) / 2;
	var wintop = (screen.height - h) / 2;
	window.open(url,"popup",'width='+w+',height='+h+',top='+wintop+',left='+winleft+',scrollbars=yes,status=no,location=no,resizable=yes')
}	

function send_submit(which_form){
	get_by_id(which_form).submit();
}

function set_server(is_enable){
	var enable = get_by_id("enable");
	
    if (is_enable == "1"){
        enable[0].checked = true;
    }else{
        enable[1].checked = true;
    }
}

function set_protocol(which_value, obj){
    for (var i = 0; i < 3; i++){    
        if (which_value == obj.options[i].value){
            obj.selectedIndex = i;
            break;
        }
    }
}

function set_schedule(data, index){ 
	var schd = get_by_name("schd");  
	
    if (data[index] == "0"){
        schd[0].checked = true;      
    }else{
        schd[1].checked = true;        
    }
    
    get_by_id("hour1").selectedIndex = data[index+1];
    get_by_id("min1").selectedIndex = data[index+2];
    get_by_id("am1").selectedIndex = data[index+3];
    get_by_id("hour2").selectedIndex = data[index+4];
    get_by_id("min2").selectedIndex = data[index+5];
    get_by_id("am2").selectedIndex = data[index+6];
    get_by_id("day1").selectedIndex = data[index+7];
    get_by_id("day2").selectedIndex = data[index+8];
}

function set_selectIndex_forwan(which_value, obj){
	if(which_value.slice(0,3)==100){
		obj.selectedIndex = 1;
	}
	else if(which_value.slice(0,2)==10){
		obj.selectedIndex = 0;
	}
	else
	{
		for (var pp=2; pp<obj.options.length; pp++){
			if (which_value == obj.options[pp].value){
				obj.selectedIndex = pp;
				break;
			}
		}
    	}
}

function set_selectIndex(which_value, obj){
    for (var pp=0; pp<obj.options.length; pp++){
        if (which_value == obj.options[pp].value){
            obj.selectedIndex = pp;
            break;
        }
    }
}
	
function set_checked(which_value, obj){
	if(obj.length > 1){
		obj[0].checked = true;
		for(var pp=0;pp<obj.length;pp++){
			if(obj[pp].value == which_value){
				obj[pp].checked = true;
			}
		}
	}else{
		obj.checked = false;
		if(obj.value == which_value){
			obj.checked = true;
		}
	}
}

function get_checked_value(obj){
	if(obj.length > 1){
		for(var pp=0;pp<obj.length;pp++){
			if(obj[pp].checked){
				return obj[pp].value;
			}
		}
	}else{
		if(obj.checked){
			return obj.value;
		}else{
			return 0;
		}
	}	
	return 0;
}

function set_schedule_option(){
	for (var i = 0; i < 32; i++){
		var temp_sch = get_by_id("schedule_rule_" + i).value;
		var temp_data = temp_sch.split("/");
		
		if (temp_data.length > 1){
			document.write("<option value='" + temp_data[0] + "'>" + temp_data[0] + "</option>");
		}
	}
}

function set_inbound_option(obj_value, idx){
	for (var i = 0; i < 24; i++){
		var k=i;
		if(parseInt(i,10)<10){
			k="0"+i;
		}
		var temp_inb = get_by_id("inbound_filter_name_" + k).value;
		var temp_data = temp_inb.split("/");
		
		if (temp_data.length > 1){
			obj_value += "<option value='" + temp_data[0] + "'>" + temp_data[0] + "</option>";
			load_inbound_used(k, temp_data, idx);
		}else{
			break;
		}
	}
	return obj_value;
}

function load_inbound_used(jj, obj_array, idx){
	if(obj_array[2].charAt(idx) == "1"){
		var is_used = "";
		if(idx == 0){
			is_used = "0"+ obj_array[2].substring(1,obj_array[2].length);
		}else if(idx == 1){
			is_used = obj_array[2].charAt(0) + "0"+ obj_array[2].substring(2,obj_array[2].length);
		}else if(idx == 2){
			is_used = obj_array[2].substring(0,2) + "0"+ obj_array[2].charAt(obj_array[2].length-1);
		}else if(idx == 3){
			is_used = obj_array[2].substr(0,obj_array[2].length-1) + "0";
		}
		get_by_id("inbound_filter_name_" + jj).value = obj_array[0] +"/"+ obj_array[1] +"/"+ is_used;
	}
}

function save_inbound_used(chk_value, idx){
	for (var i = 0; i < 24; i++){
		var k=i;
		if(parseInt(i,10)<10){
			k="0"+i;
		}
		var temp_inb = get_by_id("inbound_filter_name_" + k).value;
		var temp_data = temp_inb.split("/");
		
		if (temp_data.length > 1){
			var is_used = temp_data[2];
			if(temp_data[0] == chk_value){
				if(idx == 0){
					is_used = "1"+ temp_data[2].substring(1,temp_data[2].length);
				}else if(idx == 1){
					is_used = temp_data[2].charAt(0) + "1"+ temp_data[2].substring(2,temp_data[2].length);
				}else if(idx == 2){
					is_used = temp_data[2].substring(0,2) + "1"+ temp_data[2].charAt(temp_data[2].length-1);
				}else if(idx == 3){
					is_used = temp_data[2].substr(0,temp_data[2].length-1) + "1";
				}
			}
			get_by_id("inbound_filter_name_" + k).value = temp_data[0] +"/"+ temp_data[1] +"/"+ is_used;
		}else{
			break;
		}
	}
}

function set_dhcp_list(){
	var temp_dhcp_list = get_by_id("dhcp_list").value.split(",");
	
	for (var i = 0; i < temp_dhcp_list.length; i++){	
		var temp_data = temp_dhcp_list[i].split("/");
		if(temp_data.length > 1){		
		document.write("<option value='" + temp_data[1] + "'>" + temp_data[0] + "</option>");	
		}
	}
}

function set_mac_list(parameter){
	var temp_dhcp_list = get_by_id("dhcp_list").value.split(",");
	
	for (var i = 0; i < temp_dhcp_list.length; i++){	
		var temp_data = temp_dhcp_list[i].split("/");
		if(temp_data.length > 1){		
			if(parameter == "mac"){
				document.write("<option value='" + temp_data[2] + "'>" + temp_data[0] + " (" + temp_data[2] + " )" + "</option>");		
			}else if(parameter == "ip"){
				document.write("<option value='" + temp_data[1] + "'>" + temp_data[0] + " (" + temp_data[1] + " )" + "</option>");		
			}else{
				document.write("<option value='" + temp_data[2] + "'>" + temp_data[0] + "</option>");
			}
		}
	}
}

function set_mac(mac){
	var temp_mac = mac.split(":");
	for (var i = 0; i < 6; i++){
		var obj = get_by_id("mac" + (i+1));
		obj.value = temp_mac[i];
	}
}

function show_words(word)
{
	with(document){
		return write(word);
	}
}

function show_words_replace(word,strFind,strReplace){
	var index = 0;
	while(word.indexOf(strFind,index) != -1){
			word = word.replace(strFind,strReplace);
			index = word.indexOf(strFind,index);
	}

	with(document){
		return write(word);
	}
}

function show_dns(type){
    if (type){
        get_by_id("dns1").value = "0.0.0.0";
        get_by_id("dns2").value = "0.0.0.0";
    }
}

function show_wizard(name){
	window.open(name,"Wizard","width=450,height=370");
}

function show_window(name){
	window.open(name,"Window","width=500,height=600,scrollbar=yes");
}

function show_schedule_detail(idx){
	var temp_rule, detail;
	temp_rule = get_by_id("schedule_rule_" + idx).value;

	var rule = temp_rule.split("/");					
	var s = new Array();
	
	for(var j = 0; j < 8; j++){
		if(rule[1].charAt(j) == "1"){
			s[j] = "1";
		}else{
			s[j] = "0";
		}
	}

	var s_day = "", count = 0;
	for(var j = 0; j < 8; j++){			
		if(s[j] == "1"){
			s_day = s_day + " " + Week[j];
			count++;
		}
	}

	if(count == 7){
		s_day = tsc_AllWk;
	}
			
	var temp_time_array = rule[2] + "~" + rule[3];
	if(rule[2] == "00:00" && rule[3] == "24:00"){
		temp_time_array = tsc_AllDay;
	}
	
	detail = s_day + " " + temp_time_array;
	return detail;
}

function get_row_data(obj, index){	
		
    try {
    	return obj.cells[index].childNodes[0].data;
    }catch(e) {
        return ("");
    }
}

function copy_virtual(index){
	var data;
	
	if (get_by_id("application" + index).selectedIndex > 0){
		data = default_virtual[get_by_id("application" + index).selectedIndex - 1];		
		get_by_id("name" + index).value = data.name;
		get_by_id("public_portS" + index).value = data.public_port;
		get_by_id("private_portS" + index).value = data.private_port;
		get_by_id("protocol" + index).value = data.prot;
		set_vs_protocol(index, data.prot, get_by_id("protocol_select" + index));	
	}else{
		alert(TEXT052);
	}		
}

function copy_portforward(index){
	var data;
	
	if (get_by_id("application" + index).selectedIndex > 0){
		data = default_rule[get_by_id("application" + index).selectedIndex - 1];		
		get_by_id("name" + index).value = data.name;
		get_by_id("tcp_ports" + index).value = data.public_port;
		//get_by_id("public_portE" + index).value = data.public_port;
		get_by_id("udp_ports" + index).value = data.private_port;
		//get_by_id("private_portE" + index).value = data.private_port;
		//set_protocol(data.prot, get_by_id("protocol" + index));	
	}else{
		alert(TEXT052);
	}		
}

function copy_special_appl(index){
	var name = get_by_id("name" + index);
	var trigger_port = get_by_id("trigger_port" + index);
	var trigger_type = get_by_id("trigger" + index);
	var public_port = get_by_id("public_port" + index);
	var public_type = get_by_id("public" + index);
	var application = get_by_id("application" + index);		
	var data;
	
	if (application.selectedIndex > 0){
		data = default_appl[application.selectedIndex - 1];
		name.value = data.name;		
		trigger_port.value = data.trigger_port;			
		public_port.value = data.public_port;				
		set_protocol(data.trigger_prot, trigger_type);   
		set_protocol(data.public_prot, public_type);    		
	}else{
		alert(TEXT052);
	}
	
}

function copy_ip(index){
	if (get_by_id("ip_list" + index).selectedIndex > 0){
		get_by_id("ip" + index).value = get_by_id("ip_list" + index).options[get_by_id("ip_list" + index).selectedIndex].value;
	}else{
		alert(TEXT044);
	}
}

function get_random_char(){
	var number_list = "1234567890ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz";
	var number = Math.round(Math.random()*62);
	
	return(number_list.substring(number, number + 1));
}

function generate_psk(key){
	var i = key.length;
	
	if (key.length < 8){
		for (; i < 8; i++){
			key += get_random_char();
		}
	}

	return key;
}

function create_wep_key128(passpharse, pharse_len){
    var pseed2 = "";
   	var md5_str = "";
   	var count;
   	
   	
    for(var i = 0; i < 64; i++){
        count = i % pharse_len;
        pseed2 += passpharse.substring(count, count+1);
    }
    
    md5_str = calcMD5(pseed2);   
    
    return md5_str.substring(0, 26).toUpperCase(); 
}

function check_ascii_key_fun(data){	

	if (!(data >= 'A' && data <= 'Z') && !(data >= '0' && data <= '9') && !(data >= 'a' && data <= 'z')){	
		return false;
	}	
	return true;
}

function check_name_key_fun(data){
	if (!(data >= 'A' && data <= 'Z') && !(data >= '0' && data <= '9') && !(data >= 'a' && data <= 'z') && !(data == "-") && !(data == "_")){
		return false;
	}	
	return true;
}

function _isNumeric(str) {
	    var i;
	    for(i = 0; i<str.length; i++) {
	        var c = str.substring(i, i+1);
	        if("0" <= c && c <= "9") {
	            continue;
	        }
	        return false;
	    }
	    return true;
	}

function check_name_word_fun(obj,word){
	for(var k=0;k<obj.length;k++){
		if (!check_name_key_fun(obj.substring(k, k+1))){
			alert(word+" " + check_name_invalid);
			return false;
		}
	}
	return true;
}

function Find_word(strOrg,strFind){
	var index = 0;
	index = strOrg.indexOf(strFind,index);
	if (index > -1){
		return true;
	}
	return false;
}

function a_to_hex(inValue) {
	var outValue = "";
	if (inValue) {
		for (i = 0; i < inValue.length; i++) {
			if(inValue.charCodeAt(i).toString(16) < 10)
				outValue += 0;
			if(inValue.charCodeAt(i).toString(16) > 'a' && inValue.charCodeAt(i).toString(16) <= 'f')
				if(inValue.charCodeAt(i).toString(16).length == 1)
					outValue += 0;
			outValue += inValue.charCodeAt(i).toString(16);
		}
	}
	return outValue;
}

function hex_to_a(inValue){
	outValue = "";
	var k = '';
	for (i = 0; i < inValue.length; i++) {
		l = i % 2;
		if (l == 0)
			k += "%";
		k += inValue.substr(i, 1);
	}
	outValue = unescape(k);
	return outValue;
}

function change_word(inValue,strFind,strAdd){
	var outValue = "";
	for(var i=0;i<inValue.length;i++){
		if(inValue.substr(i,1) == strFind)
			outValue = outValue + strAdd;
		outValue += inValue.substr(i,1);
	}
	return outValue;
}

function ReplaceAll(strOrg,strFind,strReplace){
	var index = 0;
	while(strOrg.indexOf(strFind,index) != -1){
			strOrg = strOrg.replace(strFind,strReplace);
			index = strOrg.indexOf(strFind,index);
	}
	return strOrg
}

function addstr(input_msg)
{
	var last_msg = "";
	var str_location;
	var temp_str_1 = "";
	var temp_str_2 = "";
	var str_num = 0;
	temp_str_1 = addstr.arguments[0];
	while(1)
	{
		str_location = temp_str_1.indexOf("%s");
		if(str_location >= 0)
		{
			str_num++;
			temp_str_2 = temp_str_1.substring(0,str_location);
			last_msg += temp_str_2 + addstr.arguments[str_num];
			temp_str_1 = temp_str_1.substring(str_location+2,temp_str_1.length);
			continue;
		}
		if(str_location < 0)
		{
			last_msg += temp_str_1;
			break;
		}
	}
	return last_msg;
}

function replace_msg(obj_S){
	obj_D = new Array();
	for (i=0;i<obj_S.length;i++){
		obj_D[i] = addstr(obj_S[i], replace_msg.arguments[1]);
		obj_D[i] = obj_D[i].replace("%1n", replace_msg.arguments[2]);
		obj_D[i] = obj_D[i].replace("%2n", replace_msg.arguments[3]);
	}
	return obj_D;
}
function ip_num(IP_array){
	var total1 = 0;
	if(IP_array.length > 1){
   		total1 += parseInt(IP_array[3],10);
	    total1 += parseInt(IP_array[2],10)*256;
	    total1 += parseInt(IP_array[1],10)*256*256;
	    total1 += parseInt(IP_array[0],10)*256*256*256;
	}
	return total1;
}

function check_LAN_ip(LAN_IP, CHK_IP, obj_name){
	if(ip_num(LAN_IP) == ip_num(CHK_IP)){
		alert(addstr(TEXT010_a, obj_name));
		return false;
	}
	return true;
}

function isHex(str) {
    var i;
    for(i = 0; i<str.length; i++) {
        var c = str.substring(i, i+1);
        if(("0" <= c && c <= "9") || ("a" <= c && c <= "f") || ("A" <= c && c <= "F")) {
            continue;
        }
        return false;
    }
    return true;
}

/*
function open_more(rule_num, num, is_hidden, obj){
	var open_word = "none";
	get_by_id("show_more_word").style.display = "";
	get_by_id("show_less_word").style.display = "none";
	if(is_hidden){
		get_by_id("show_more_word").style.display = "none";
		get_by_id("show_less_word").style.display = "";
		open_word = "";
	}
	var start_num = parseInt(rule_num-1,10);
	for(j=start_num;j>=num;j--){
		get_by_id(obj+j).style.display = open_word;
	}
}
*/

/*Date Used, copy by Netgear*/
function getDaysInMonth(mon,year)
{
	var days;
	if (mon==1 || mon==3 || mon==5 || mon==7 || mon==8 || mon==10 || mon==12) days=31;
	else if (mon==4 || mon==6 || mon==9 || mon==11) days=30;
	else if (mon==2)
	{
		if (isLeapYear(year)) { days=29; }
		else { days=28; }
	}
	return (days);
}

function isLeapYear (Year)
{
	if (((Year % 4)==0) && ((Year % 100)!=0) || ((Year % 400)==0)) {
		return (true);
	} else { return (false); }
}

function key_word(newobj,obj){
	get_by_id(obj).value = newobj.value;
}

/*
 * is_form_modified
 *	Check if a form's current values differ from saved values in custom attribute.
 *	Function skips elements with attribute: 'modified'= 'ignore'. 
 */
function is_form_modified(form_id)
{
	var df = document.forms[form_id];
	if (!df) {
		return false;
	}
	if (df.getAttribute('modified') == "true") {
		return true;
	}
	if (df.getAttribute('saved') != "true") {
		return false;
	}
	for (var i = 0, k = df.elements.length; i < k; i++) {
		var obj = df.elements[i];
		if (obj.getAttribute('modified') == 'ignore') {
			continue;
		}
		var name = obj.tagName.toLowerCase();
		if (name == 'input') {
			var type = obj.type.toLowerCase();
			if (((type == 'text') || (type == 'textarea') || (type == 'password') || (type == 'hidden')) &&
					!are_values_equal(obj.getAttribute('default'), obj.value)) {
				return true;
			} else if (((type == 'checkbox') || (type == 'radio')) && !are_values_equal(obj.getAttribute('default'), obj.checked)) {
				return true;
			}
		} else if (name == 'select') {
			var opt = obj.options;
			for (var j = 0; j < opt.length; j++) {
				if (!are_values_equal(opt[j].getAttribute('default'), opt[j].selected)) {
					return true;
				}
			}
		}
	}
	return false;
}


/*
 * Disable All Form Elements
 *  
*/
function DisableEnableForm(xForm,xHow){
  objElems = xForm.elements;
  for(i=0;i<objElems.length;i++){
    objElems[i].disabled = xHow;
  }
}


/*
 * set_form_default_values
 *	Save a form's current values to a custom attribute.
 */
function set_form_default_values(form_id)
{
	var df = document.forms[form_id];
	if (!df) {
		return;
	}
	for (var i = 0, k = df.elements.length; i < k; i++) {
		var obj = df.elements[i];
		if (obj.getAttribute('modified') == 'ignore') {
			continue;
		}
		var name = obj.tagName.toLowerCase();
		if (name == 'input') {
			var type = obj.type.toLowerCase();
			if ((type == 'text') || (type == 'textarea') || (type == 'password') || (type == 'hidden')) {
				obj.setAttribute('default', obj.value);
				/* Workaround for FF error when calling focus() from an input text element. */
				if (type == 'text') {
					obj.setAttribute('autocomplete', 'off');
				}
			} else if ((type == 'checkbox') || (type == 'radio')) {
				obj.setAttribute('default', obj.checked);
			}
		} else if (name == 'select') {
			var opt = obj.options;
			for (var j = 0; j < opt.length; j++) {
				opt[j].setAttribute('default', opt[j].selected);
			}
		}
	}
	df.setAttribute('saved', "true");
}

/*
 * are_values_equal()
 *	Compare values of types boolean, string and number. The types may be different.
 *	Returns true if values are equal.
 */
function are_values_equal(val1, val2)
{
	/* Make sure we can handle these values. */
	switch (typeof(val1)) {
	case 'boolean':
	case 'string':
	case 'number':
		break;
	default:
		// alert("are_values_equal does not handle the type '" + typeof(val1) + "' of val1 '" + val1 + "'.");
		return false;
	}

	switch (typeof(val2)) {
	case 'boolean':
		switch (typeof(val1)) {
		case 'boolean':
			return (val1 == val2);
		case 'string':
			if (val2) {
				return (val1 == "1" || val1.toLowerCase() == "true" || val1.toLowerCase() == "on");
			} else {
				return (val1 == "0" || val1.toLowerCase() == "false" || val1.toLowerCase() == "off");
			}
			break;
		case 'number':
			return (val1 == val2 * 1);
		}
		break;
	case 'string':
		switch (typeof(val1)) {
		case 'boolean':
			if (val1) {
				return (val2 == "1" || val2.toLowerCase() == "true" || val2.toLowerCase() == "on");
			} else {
				return (val2 == "0" || val2.toLowerCase() == "false" || val2.toLowerCase() == "off");
			}
			break;
		case 'string':
			if (val2 == "1" || val2.toLowerCase() == "true" || val2.toLowerCase() == "on") {
				return (val1 == "1" || val1.toLowerCase() == "true" || val1.toLowerCase() == "on");
			}
			if (val2 == "0" || val2.toLowerCase() == "false" || val2.toLowerCase() == "off") {
				return (val1 == "0" || val1.toLowerCase() == "false" || val1.toLowerCase() == "off");
			}
			return (val2 == val1);
		case 'number':
			if (val2 == "1" || val2.toLowerCase() == "true" || val2.toLowerCase() == "on") {
				return (val1 == 1);
			}
			if (val2 == "0" || val2.toLowerCase() == "false" || val2.toLowerCase() == "off") {
				return (val1 === 0);
			}
			return (val2 == val1 + "");
		}
		break;
	case 'number':
		switch (typeof(val1)) {
		case 'boolean':
			return (val1 * 1 == val2);
		case 'string':
			if (val1 == "1" || val1.toLowerCase() == "true" || val1.toLowerCase() == "on") {
				return (val2 == 1);
			}
			if (val1 == "0" || val1.toLowerCase() == "false" || val1.toLowerCase() == "off") {
				return (val2 === 0);
			}
			return (val1 == val2 + "");
		case 'number':
			return (val2 == val1);
		}
		break;
	default:
		return false;
	}
	return false;
}

function jump_if(){
	for (var i = 0; i < document.forms.length; i++) {
		if (is_form_modified(document.forms[i].id)) {
			if (!confirm (up_jt_1+ "\n" +up_jt_2 +"\n"+ up_jt_3)) {
				return false;
			}
		}
	}
	return true;
}

function jump_3g_if(){
	get_by_id("asp_temp_72").value = get_by_id("usb_type").value
	//send_submit('wwan_form');
	for (var i = 0; i < document.forms.length; i++) {
		if (is_form_modified(document.forms[i].id)) {
			if (!confirm(up_jt_1+"\n"+up_jt_2+"\n"+up_jt_3)){
				return false;
			}
		}
	}
	return true;
}

/*
 * Cancel and reset changes to the page.
 */
function page_cancel(form_name, redirect_url){
	if (is_form_modified(form_name) && confirm (LS4)) {
		window.location.href=redirect_url;
	}
	return false;
}

function page_reboot(){
	jump_if();
	window.location.href='reboot.asp'
}

/*
 * trim_string
 *	Remove leading and trailing blank spaces from a string.
 */
function trim_string(str)
{
	var trim = str + "";
	trim = trim.replace(/^\s*/, "");
	return trim.replace(/\s*$/, "");
}

/*
 * is_mac_valid()
 *	Check if a MAC address is in a valid form.
 *	Allow 00:00:00:00:00:00 and FF:FF:FF:FF:FF:FF if optional argument is_full_range is true.
 */
function is_mac_valid(mac, is_full_range)
{
	var macstr = mac + "";
	var got = macstr.match(/^[0-9a-fA-F]{2}[:-]?[0-9a-fA-F]{2}[:-]?[0-9a-fA-F]{2}[:-]?[0-9a-fA-F]{2}[:-]?[0-9a-fA-F]{2}[:-]?[0-9a-fA-F]{2}$/);
	if (!got) {
		return false;
	}
	macstr = macstr.replace (/[:-]/g, '');
	if (!is_full_range && (macstr.match(/^0{12}$/) || macstr.match(/^[fF]{12}$/))) {
		return false;
	}

	return true;
}

function isInvalidMac(mac)
{
	var tmp_mac = (mac.replace(/[:-]/g, '')).toLowerCase();
	if (tmp_mac === "" && tmp_mac.length == 0) {
		get_by_id("wan_mac").value = "<!--# echo sys_wan_mac -->";
		return true;
	}
	if (tmp_mac.length != 12)
		return false;
	var invalid_bit = tmp_mac.substring(1,2);
	if (invalid_bit.match(/[1,3,5,7,9,b,d,f]/g))
		return false;
	if (tmp_mac === "000000000000")
		get_by_id("wan_mac").value = "<!--# echo sys_wan_mac -->";

	return true;
}

/*
 * is_ascii()
 *      Returns true if value is made of printable ASCII characters (or blank).
 */
function is_ascii(value)
{
    value += "";
    return value.match(/^[\x20-\x7E]*$/) ? true : false;
}

/*
 * is_number()
 *	Returns true if a value represents a number, else return false.
 */
function is_number(value)
{
	value += "";
	return value.match(/^-?\d*\.?\d+$/) ? true : false;
}

/*
 * is_ipv4_valid
 *	Check is an IP address dotted string is valid.
 */
function is_ipv4_valid(ipaddr)
{
	var ip = ipv4_to_bytearray(ipaddr);
	if (ip === 0) {
		return false;
	}
	return true;
}

/*
 * ipv4_to_bytearray
 *	Convert an IPv4 address dotted string to a byte array
 */
function ipv4_to_bytearray(ipaddr)
{
	var ip = ipaddr + "";
	var got = ip.match (/^\s*(\d{1,3})\s*[.]\s*(\d{1,3})\s*[.]\s*(\d{1,3})\s*[.]\s*(\d{1,3})\s*$/);
	if (!got) {
		return 0;
	}
	var a = [];
	var q = 0;
	for (var i = 1; i <= 4; i++) {
		q = parseInt(got[i],10);
		if (q < 0 || q > 255) {
			return 0;
		}
		a[i-1] = q;
	}
	return a;
} 
  
function check_ipv4_symbol(strOrg,strFind){
	/* Search ipv4_address has "." symbol */	
	/*if false return 0, otherwises return 1 */
	var index = 0;
	index = strOrg.indexOf(strFind,index);
		
	if(index == -1)
			return 0;
	else
			return 1;				
} 

function check_ipv6_relay_address(my_obj, mask_obj, ip_obj){
	var count_zero = 0;
	var count_bcast = 0;	
	var ip = my_obj.addr;
	var mask;
	var which_ip = (my_obj.addr[0]).split(" ");		
	
	if (!(isNaN(which_ip) || which_ip == "" || which_ip.length > 1 || 
		(which_ip[0].length > 1 && which_ip[0].substring(0,1) == "0"))){	// if the address is invalid
	if (my_obj.addr.length == 4){
		/* check the ip is not multicast IP (127.x.x.x && 224.x.x.x ~ 239.x.x.x) */
		if((my_obj.addr[0] == "127") || ((my_obj.addr[0] >= 224) && (my_obj.addr[0] <= 239))){
			alert(my_obj.e_msg[12]);//MULTICASE_IP_ERROR
			return false;
		}
		/* check the ip is not broadcast IP (255.x.x.x) 2009.8.10 graceyang add. */
		if((my_obj.addr[0] == "255")){
			alert(my_obj.e_msg[0]);//INVALID_IP
			return false;
		}
		/* check the ip is "0.0.0.0" or not */
		for(var i = 0; i < ip.length; i++){
			if (ip[i] == "0"){
				count_zero++;			
			}
		}

		if (!my_obj.allow_zero && count_zero == 4){	// if the ip is not allowed to be 0.0.0.0
			alert(my_obj.e_msg[1]);	//ZERO_IP		// but we check the ip is 0.0.0.0
			return false;
		}else if (count_zero != 4){		// when IP is not 0.0.0.0, checking range. Otherwise no need to check		
			count_zero = 0;
				
			if (check_ipv6_relay_address.arguments.length >= 2 && mask_obj != null){
				mask = mask_obj.addr;
			}else{
				mask = new Array(255,255,255,0);
			}

			for(var i = 0; i < ip.length; i++){
				if (check_ipv6_relay_address.arguments.length == 3 && ip_obj != null){
					if (!check_current_range(i, my_obj, ip_obj.addr, mask)){
						return false;
					}
				}else{
					if (!check_ip_range(i, my_obj, mask)){
						return false;
					}
				}
			}		

			for (var i = 0; i < 4; i++){	// check the IP address is a network address or a broadcast address																							
				if (((~mask[i] + 256) & ip[i]) == 0){	// (~mask[i] + 256) = reverse mask[i]
					count_zero++;						
				}
								
				if ((mask[i] | ip[i]) == 255){
					count_bcast++;
				}
			}

			if ((count_zero == 4 && !my_obj.is_network) || (count_bcast == 4)){
				alert(my_obj.e_msg[0]);			//INVALID_IP
				return false;
			}													
		}
		return true;
	}else{
		return false;
	}
}else{
	return true
}
}

 
function transValue(data)
{
	var value =0;
	data = data.toUpperCase();
	
	if(data == "0")
		value =0;
	else if(data =="1")
		value = 1;
	else if(data =="2")
		value = 2;
	else if(data =="3")
		value = 3;
	else if(data =="4")
		value = 4;	
	else if(data =="5")
		value = 5;
	else if(data =="6")
		value = 6;
	else if(data =="7")
		value = 7;
	else if(data =="8")
		value = 8;
	else if(data =="9")
		value = 9;
	else if(data =="A")
		value = 10;
	else if(data =="B")
		value = 11;
	else if(data =="C")
		value = 12;
	else if(data =="D")
		value = 13;
	else if(data =="E")
		value = 14;
	else if(data =="F")
		value = 15;				
	else
		value = 0;
	return value ;				
}
 
function check_symbol(strOrg,strFind){
	var index = 0;
	index = strOrg.indexOf(strFind,index);
	return index;
}

function find_colon(strOrg,strFind)
{
        var index=0;
        var colon=0;
        index = strOrg.indexOf(strFind,index);
        while(index != -1)
        {
                colon++;
                index++;
                index = strOrg.indexOf(strFind,index);
        }
        return colon;                
}
 
function count_colon_pos(strOrg,strFind,count)
{
        var index =0;
        var i=0;
        
        for(i=0;i<count;i++){
                index = strOrg.indexOf(strFind,index);
                index++;        
        }
        return index;                
}

function count_last_colon_pos(strOrg,strFind)
{
				var index =0;
				var pos=0;
        
        while(1){
                index = strOrg.indexOf(strFind,index);
                if(index == -1)
                		break;
                pos = index;		
                index++;		        
        }
        return pos;     	
}
function compare_suffix(start_suffix,end_suffix)
{
	var start_suffix_length = start_suffix.length;
	var end_suffix_length = end_suffix.length;
	
	var start_suffix_value =0;
	var end_suffix_value=0;
	
	//calculate the start_suffix
	if(start_suffix_length == 1){
		start_suffix_value = transValue(start_suffix.charAt(0)) * 1;
	}else if(start_suffix_length == 2){
		start_suffix_value = transValue(start_suffix.charAt(0)) * 16;
		start_suffix_value += transValue(start_suffix.charAt(1)) * 1;
	}else if(start_suffix_length == 3){
		start_suffix_value = transValue(start_suffix.charAt(0)) * 256;
		start_suffix_value += transValue(start_suffix.charAt(1)) * 16;
		start_suffix_value += transValue(start_suffix.charAt(2)) * 1;
	}else if(start_suffix_length == 4){
		start_suffix_value = transValue(start_suffix.charAt(0)) * 4096;
		start_suffix_value += transValue(start_suffix.charAt(1)) * 256;
		start_suffix_value += transValue(start_suffix.charAt(2)) * 16;
		start_suffix_value += transValue(start_suffix.charAt(3)) * 1;
	}
	
	//calculate the end_suffix
	if(end_suffix_length == 1){
		end_suffix_value = transValue(end_suffix.charAt(0)) * 1;
	}else if(end_suffix_length == 2){
		end_suffix_value = transValue(end_suffix.charAt(0)) * 16;
		end_suffix_value += transValue(end_suffix.charAt(1)) * 1;
	}else if(end_suffix_length == 3){
		end_suffix_value = transValue(end_suffix.charAt(0)) * 256;
		end_suffix_value += transValue(end_suffix.charAt(1)) * 16;
		end_suffix_value += transValue(end_suffix.charAt(2)) * 1;
	}else if(end_suffix_length == 4){
		end_suffix_value = transValue(end_suffix.charAt(0)) * 4096;
		end_suffix_value += transValue(end_suffix.charAt(1)) * 256;
		end_suffix_value += transValue(end_suffix.charAt(2)) * 16;
		end_suffix_value += transValue(end_suffix.charAt(3)) * 1;
	}
		
	if(start_suffix_value >= end_suffix_value){
		alert(compare_suffix_error);
		return false;	
	}
	return true;
}

function open_more(rule_num, num, is_hidden, obj){
	var open_word = "none";
	get_by_id("show_more_word").style.display = "";
	get_by_id("show_less_word").style.display = "none";
	if(is_hidden){
		get_by_id("show_more_word").style.display = "none";
		get_by_id("show_less_word").style.display = "";
		open_word = "";
	}
	var start_num = parseInt(rule_num-1,10);
	for(j=start_num;j>=num;j--){
		get_by_id(obj+j).style.display = open_word;
	}
}


//Get schedule value - Tina Tsao 20090420
function get_schedule_value(idx){
	var tmp_schedule_index = get_by_id("schedule" + idx).selectedIndex;
	var schedule,schedule_a;
	if (tmp_schedule_index > 1){
		schedule = get_by_id("schedule_rule_" + (tmp_schedule_index-2)).value;
  		schedule_a = get_by_id("schedule_rule_" + (tmp_schedule_index-2)).value.split("/");
  		schedule = schedule_a[0];
	}else if (tmp_schedule_index == 0){
		schedule = "Always";
	}else if (tmp_schedule_index == 1){
		schedule = "Never";
	}
	return schedule;
}
              
//Get schedule index - Tina Tsao 20090410
function get_schedule_index(which_value){
	var idx;
	for (var j = 0; j < 32; j++){
		var temp_sch = get_by_id("schedule_rule_" + j).value;
		var temp = temp_sch.split("/");
		if(which_value == temp[0]){
	  		idx = j;
		}
	}	
	return idx;
}

function netmask2bit(mask){
	var ipstr = mask.split(".");
	var i, b, e = 0, bit = 0;

	for (i = 0; i < 4; i++) {
		for (b = 7;b >= 0; b--) {
			if ((ipstr[i] >> b) & 0x1) {
				if (e == 1)
					return -1; //illegal netmask
				bit++;
			} else
				e = 1;
		}
	}
	//alert("bit: " + bit);
	return bit;
}

function bit2netmask(bit){
	var i, c, b;
	ip = new Array(4);

	if (bit >= 32)
		return -1;
	for (i = 0; i < 4; i++) {
		for (c = 7, b = 0; c >= 0; c--){
			if (bit-- <= 0)
				break;
			b |= 1 << c;
		}
		ip[i] = b;
	}
	//alert("Netmask: " + ip[0] + "." + ip[1] + "." + ip[2] + "." + ip[3]);
	return ip[0] + "." + ip[1] + "." + ip[2] + "." + ip[3];
}

function get_netip(ip, mask, mask_bit){
	var tmp_ip = ip.split(".");
	var tmp_mask = mask.split(".");
	var netip = (parseInt(tmp_ip[0]) & parseInt(tmp_mask[0])) + "." + (parseInt(tmp_ip[1]) & parseInt(tmp_mask[1])) + "." + (parseInt(tmp_ip[2]) & parseInt(tmp_mask[2])) + "." + (parseInt(tmp_ip[3]) & parseInt(tmp_mask[3]));
	return netip;
}

function check_legal_name(name){
	for(var i = 0; i < name_word.length; i++){
		if(Find_word(name, name_word[i]))
			return true;
	}
	return false;
}
 
function check_hex_length(keys, minlength, maxlength)
{
	for (var i = 0; i < keys.length; i++)
		if (!check_hex(keys.substring(i, i + 1)))
			return false;

	if (keys.length < minlength || keys.length > maxlength)
		return false;

	return true;
}

function check_psk_length(keys, minlength, maxlength)
{
	if (keys.length < minlength || keys.length > maxlength)
		return false;

	return true;
}

function check_psk_valid(keys)
{
	if (!check_hex_length(keys, 16, 128) && !check_psk_length(keys, 8, 64))
		return false;

	return true;
}

function check_legal_name_psk(name)
{
	for (var i = 0; i < name_word_psk.length; i++) {
		if (Find_word(name, name_word_psk[i]))
			return true;
	}

	return false;
}

function ip2network(ip, mask){
        var temp_ip = ip.split(".");
        var temp_mask = mask.split(".");
        var temp_lan = (temp_ip[0] & temp_mask[0]);
        for (var i = 1; i < temp_ip.length; i++){
                temp_lan = temp_lan + "." + (temp_ip[i] & temp_mask[i]);
        }
        return temp_lan;
}

function set_schedule_list(data, obj){

        for (var i = 0; i < obj.options.length; i++){
                if (data == obj.options[i].value){
                        obj.selectedIndex = i;
                        break;
                }
        }
}

var ap_top = {
        item : {
                0 : "setup",
                1 : "adv",
                2 : "tools",
                3 : "status",
                4 : "help"
               },
        value :{
		"setup" : _setup,
		"adv" : _advanced,
		"tools" : _maintenance,
		"status" : _status,
		"help" : _support
		},
        link : {
                0 : "index.asp",
                1 : "adv_filters_mac.asp",
                2 : "tools_admin.asp",
                3 : "st_device.asp",
                4 : "support_men.asp"
        },
        len : 5
};


var ap_left = {
	"Setup" : {
	  item : {
	    0 : "setup_wizard",
	    1 : "Wireless",
	    2 : "Network",
	    3 : "PLC"
	  },
	  value : {
	    "setup_wizard" : wwa_setupwiz,
	    "Wireless" : _wirelesst,
	    "Network" : _lanst,
	    "PLC" : _plcst
	  },
	  link : {
	    0 : "index.asp",
	    1 : "wireless.asp",
	    2 : "lan.asp",
	    3 : "lan_plc.asp"
	  },
	  len : 4
	},
	"Advance" : {
	  item : {
	    0 : "network_filter",
	    1 : "adv_wlan",
	    2 : "wps",
	    3 : "user_limit"
	  },
	  value : {
	    "network_filter" : _macfilt,
	    "adv_wlan" : _advwls,
	    "wps" :  _Wifi_protected_setup,
	    "user_limit" : _user_limit
	  },
	  link : {
	    0 : "adv_filters_mac.asp",
	    1 : "adv_wlan_perform.asp",
	    2 : "adv_wps_setting.asp",
	    3 : "adv_user_limit.asp"
	  },
	  len : 4
	},
	"tools" : {
	  item : {
	    0 : "admin",
	    1 : "system",
	    2 : "firmware",
	    3 : "time",
	    4 : "system_check",
	    5 : "schedule"
	},
	  value : {
	    "admin" : _admin,
	    "system" : _system,
	    "firmware" : _firmware,
	    "time" : _time,
	    "system_check" : _syscheck,
	    "schedule" : _scheds
	},
	  link : {
	    0 : "tools_admin.asp",
	    1 : "tools_system.asp",
	    2 : "tools_firmw.asp",
	    3 : "tools_time.asp",
	    4 : "tools_vct.asp",
	    5 : "tools_schedules.asp"
	},
	  len : 6
	},
	"Status" : {
	  item : {
	    0 : "device",
	    1 : "log",
	    2 : "stats",
	    3 : "wlan",
	    4 : "ipv6"
	},
	  value : {
	    "device" : _devinfo,
	    "log" : _logs,
	    "stats" : _stats,
	    "wlan" : _wireless,
	    "ipv6" : "IPv6"
	},
	  link : {
	    0 : "st_device.asp",
	    1 : "st_log.asp",
	    2 : "st_stats.asp",
	    3 : "st_wireless.asp",
	    4 : "st_ipv6.asp"
	},
	  len : 5
	},
	"Help" : {
	  item : {
	    0 : "menu",
	    1 : "setup",
	    2 : "adv",
	    3 : "tools",
	    4 : "status"
	  },
	  value : {
	    "menu" : ish_menu,
	    "setup" : _setup,
	    "adv" : _advanced,
	    "tools" : _tools,
	    "status" : _status
	  },
	  link : {
	    0 : "support_men.asp",
	    1 : "support_internet.asp",
	    2 : "support_adv.asp",
	    3 : "support_tools.asp",
	    4 : "support_status.asp"
	  },
	  len : 5
	}
};

var ap_support_item = {
	"Setup" : {
	  item : {
	    0 : "setup_wizard",
	    1 : "Wireless",
	    2 : "Network",
	    3 : "PLC"
	  },
	  value : {
	    "setup_wizard" : wwa_setupwiz,
	    "Wireless" : _wirelesst,
	    "Network" : _lanst,
	    "PLC" : _plcst
	  },
	  link : "support_internet.asp",
	  len : 4
	},
	"Advance" : {
	  item : {
	    0 : "network_filter",
	    1 : "adv_wlan",
	    2 : "wps",
	    3 : "user_limit"
	  },
	  value : {
	    "network_filter" : _netfilt,
	    "adv_wlan" : _advwls,
	    "wps" :  _Wifi_protected_setup,
	    "user_limit" : _user_limit
	  },
	  link : "support_adv.asp",
	  len : 4
	},
	"tools" : {
	  item : {
	    0 : "admin",
	    1 : "time",
	    2 : "system",
	    3 : "firmware",
	    4 : "system_check",
	    5 : "schedule"
	},
	  value : {
	    "admin" : _admin,
	    "time" : _time,
	    "system" : _system,
	    "firmware" : _firmware,
	    "system_check" : _syscheck,
	    "schedule" : _scheds
	},
	  link : "support_tools.asp",
	  len : 6
	},
	"Status" : {
	  item : {
	    0 : "device",
	    1 : "log",
	    2 : "stats",
	    3 : "wlan",
	    4 : "ipv6"
	},
	  value : {
	    "device" : _devinfo,
	    "log" : _logs,
	    "stats" : _stats,
	    "wlan" : _wireless,
	    "ipv6" : "IPv6"
	},
	  link : "support_status.asp",
	  len : 5
	}
}

function show_ap_support(type)
{
	var li = "";
	for (var i = 0; i < ap_support_item[type].len; i++) {
		var item = ap_support_item[type].item[i];
		var value = ap_support_item[type].value[item];
		if (control_link(type, item) === -1)
			continue;
		li += "<li><a href="+ap_support_item[type].link;
		li += "#"+item+">";
		li += value+"</a></li>";
	}
	document.write(li);
}


var _top = {
        item : {
                0 : "setup",
                1 : "adv",
                2 : "tools",
                3 : "status",
                4 : "help"
               },
        value :{
		"setup" : _setup,
		"adv" : _advanced,
		"tools" : _tools,
		"status" : _status,
		"help" : _support
		},
        link : {
                0 : "index.asp",
                1 : "adv_virtual.asp",
                2 : "tools_admin.asp",
                3 : "st_device.asp",
                4 : "support_men.asp"
        },
        len : 5
};



var left = {
	"Setup" : {
	  item : {
	    0 : "Internet",
	    1 : "Wireless",
	    2 : "Network",
	    3 : "Media",
	    4 : "USB",
	    5 : "VPN",
	    6 : "VLAN",
	    7 : "Storage",
	    8 : "parental_control",
	    9 : "ipv6",
	    10 : "PLC",
	    11 : "mydlink"
	  },
	  value : {
	    "Internet" : _internet,
	    "Wireless" : _wirelesst,
	    "Network" : bln_title_NetSt,
	    "Media" : MEDIA_SERVER,
	    "USB" : bln_title_usb,
	    "VPN" : vpn_setting,
	    "VLAN" : VLAN_SETTINGS,
	    "Storage" : STORAGE_title,
	    "parental_control" : PARENTAL_CTRL,
	    "ipv6" : "IPv6",
	    "PLC" : _plcst,
	    "mydlink" : my_dlink	    
	  },
	  link : {
	    0 : "index.asp",
	    1 : "wizard_wireless.asp",
	    2 : "lan.asp",
	    3 : "media_server.asp",
	    4 : "usb_setting.asp",
	    5 : "vpn.asp",
	    6 : "vlan.asp",
	    7 : "http_storage.asp",
	    8 : "parental_ctrl.asp",
	    9 : "ipv6.asp",
	    10: "lan_plc.asp",
	    11: "mydlink_setting.asp"
	  },
	  len : 12
	},
	"Advance" : {
	  item : {
	    0 : "virtual",
	    1 : "portfw",
	    2 : "appl",
	    3 : "qos",
	    4 : "network_filter",
	    5 : "access_ctl",
	    6 : "website_filter",
	    7 : "inbound",
	    8 : "firewall",
	    9 : "routing",
	    10 : "certi",
	    11 : "usergroup",
	    12 : "adv_wlan",
	    13 : "wish",
	    14 : "wps",
	    15 : "adv_network",
	    16 : "guestzone",
	    17 : "MBSSID",
	    18 : "ipv6_firewall",
	    19 : "ipv6_routing",
	    20 : "opendns"
	  },
	  value : {
	    "virtual" : _virtserv,
	    "portfw" : _pf,
	    "appl" : APP_RULES,
	    "qos" : YM48,
	    "network_filter" : _netfilt,
	    "access_ctl" : ACCESS_CONTROL,
	    "website_filter" : _websfilter,
	    "inbound" : _inboundfilter,
	    "firewall" : _firewalls,
	    "routing" : _routing,
	    "adv_wlan" : _advwls,
	    "wish" : YM63,
	    "certi" : _certification,
	    "usergroup" : _user_group,
	    "ipv6_firewall" : IPV6_firewall,
	    "ipv6_routing" : IPV6_routing,
	    "guestzone" : _guestzone,
	    "MBSSID" : mbssid,
	    "wps" :  _Wifi_protected_setup,
	    "adv_network" : _advnetwork,
	    "opendns" : "OpenDNS"
	  },
	  link : {
	    0 : "adv_virtual.asp",
	    1 : "adv_portforward.asp",
	    2 : "adv_appl.asp",
	    3 : "adv_qos.asp",
	    4 : "adv_filters_mac.asp",
	    5 : "adv_access_control.asp",
	    6 : "adv_filters_url.asp",
	    7 : "Inbound_Filter.asp",
	    8 : "adv_dmz.asp",
	    9 : "adv_routing.asp",
	    10 : "adv_certificate.asp",
	    11 : "adv_usergroup.asp",
	    12 : "adv_wlan_perform.asp",
	    13 : "adv_wish.asp",
	    14 : "adv_wps_setting.asp",
	    15 : "adv_network.asp",
	    16 : "guest_zone.asp",
	    17 : "adv_mbssid.asp",
	    18 : "adv_ipv6_firewall.asp",
	    19 : "adv_ipv6_routing.asp",
	    20 : "adv_opendns.asp"
	  },
	  len : 21
	},
	"tools" : {
	  item : {
	    0 : "admin",
	    1 : "time",
	    2 : "syslog",
	    3 : "email",
	    4 : "system",
	    5 : "firmware",
	    6 : "ddns",
	    7 : "syscheck",
	    8 : "schedule"
	},
	  value : {
	    "admin" : _admin,
	    "time" : _time,
	    "syslog" : help704,
	    "email" : te_EmSt,
	    "system" : _system,
	    "firmware" : _firmware,
	    "ddns" : _dyndns,
	    "syscheck" : _syscheck,
	    "schedule" : _scheds
	},
	  link : {
	    0 : "tools_admin.asp",
	    1 : "tools_time.asp",
	    2 : "tools_syslog.asp",
	    3 : "tools_email.asp",
	    4 : "tools_system.asp",
	    5 : "tools_firmw.asp",
	    6 : "tools_ddns.asp",
	    7 : "tools_vct.asp",
	    8 : "tools_schedules.asp"
	},
	  len : 9
	},
	"Status" : {
	  item : {
	    0 : "device",
	    1 : "log",
	    2 : "stats",
	    3 : "session",
	    4 : "routing",
	    5 : "wlan",
	    6 : "VPN",
	    7 : "ipv6",
	    8 : "routing6",
	    9 : "link",
	    10 : "acl",
	    11 : "realtime"
	},
	  value : {
	    "device" : _devinfo,
	    "log" : _logs,
	    "stats" : _stats,
	    "session" : YM157,
	    "routing" : _routing,
	    "wlan" : _wireless,
	    "VPN"  : "VPN",
	    "ipv6" : "IPv6",
	    "routing6" : IPV6_routing,
	    "link" : link_info,
	    "acl" : acl_info,
	    "realtime" : "Realtime Traffic"
	},
	  link : {
	    0 : "st_device.asp",
	    1 : "st_log.asp",
	    2 : "st_stats.asp",
	    3 : "internet_sessions.asp",
	    4 : "st_routing.asp",
	    5 : "st_wireless.asp",
	    6 : "st_vpn.asp",
	    7 : "st_ipv6.asp",
	    8 : "st_routing6.asp",
	    9 : "st_link.asp",
	    10 : "st_acl.asp",
	    11 : "st_realtime.asp"
	},
	  len : 12
	},
	"Help" : {
	  item : {
	    0 : "menu",
	    1 : "setup",
	    2 : "adv",
	    3 : "tools",
	    4 : "status"
	  },
	  value : {
	    "menu" : ish_menu,
	    "setup" : _setup,
	    "adv" : _advanced,
	    "tools" : _tools,
	    "status" : _status
	  },
	  link : {
	    0 : "support_men.asp",
	    1 : "support_internet.asp",
	    2 : "support_adv.asp",
	    3 : "support_tools.asp",
	    4 : "support_status.asp"
	  },
	  len : 5
	}
};

var support_item = {
	"Setup" : {
		item : {
			0 : "Internet",
			1 : "WAN",
			2 : "Wireless",
			3 : "Network",
			4 : "USB",
			5 : "VPN",
			6 : "SSLVPN",
			7 : "ipv6",
			8 : "PLC"
		},
		value : {
			"Internet" : sa_Internet,
			"WAN" : WAN,
			"Wireless" : _wirelesst,
			"Network" : bln_title,
			"USB" : "USB",
			"VPN" : vpn_setting,
			"SSLVPN" : vpn_settings_op3,
			"ipv6" : "IPV6",
			"PLC" : _plcst
		},
		link : "support_internet.asp",
		len : 9
	},
	"Advance" : {
		item : {
			0 : "virtual",
			1 : "portfw",
			2 : "appl",
			3 : "qos",
			4 : "network_filter",
			5 : "access_ctl",
			6 : "website_filter",
			7 : "inbound",
			8 : "firewall",
			9 : "routing",
			10 : "adv_wlan",
			11 : "wish",
			12 : "wps",
			13 : "adv_network",
			14 : "guestzone",
			15 : "certi",
			16 : "usergroup",
			17 : "MBSSID",
			18 : "ipv6_firewall",
			19 : "ipv6_routing"
			},
		value : {
			"virtual" : _virtserv,
			"portfw" : _pf,
			"appl" : APP_RULES,
			"qos" : YM48,
			"network_filter" : _netfilt,
			"access_ctl" : ACCESS_CONTROL,
			"website_filter" : _websfilter,
			"inbound" : INBOUND_FILTER,
			"firewall" : _firewalls,
			"routing" : _routing,
			"adv_network" : _advnetwork,
			"adv_wlan" : _advwls,
			"wish" : "WISH",
			"wps" : LW2,
			"guestzone" : _guestzone,
			"certi" : _certification,
			"usergroup" : _user_group,
			"MBSSID" : "MBSSID",
			"ipv6_firewall" : "IPV6" + _firewall,
			"ipv6_routing" : IPV6_routing
			},
		link : "support_adv.asp",
		len : 20
	},
	"tools" : {
		item : {
			0 : "admin",
			1 : "time",
			2 : "syslog",
			3 : "email",
			4 : "system",
			5 : "firmware",
			6 : "ddns",
			7 : "syscheck",
			8 : "schedule"
			},
		value : {
			"admin" : ADMIN,
			"time" : _time,
			"syslog" : help704,
			"email" : te_EmSt,
			"system" : _system,
			"firmware" : _firmware,
			"ddns" : _dyndns,
			"syscheck" : _syscheck,
			"schedule" : _scheds
			},
		link : "support_tools.asp",
		len : 9
	},
	"Status" : {
		item : {
			0 : "Device_Info",
			1 : "Logs",
			2 : "Statistics",
			3 : "Internet_Sessions",
			4 : "Routing",
			5 : "Wireless",
			6 : "VPN",
			7 : "ipv6",
			8 : "routing6",
			9 : "link",
			10 : "acl"
			},
		value : {
			"Device_Info" : _devinfo,
			"Logs" : _logs,
			"Statistics" : _stats,
			"Internet_Sessions" : YM157,
			"Routing" : _routing,
			"Wireless" : _wireless,
			"VPN" : vpn,
			"ipv6" : "IPV6",
			"routing6" : IPV6_routing,
			"link" : link_info,
			"acl" : acl_info
			},
		link : "support_status.asp",
		len : 11
	}
};

function show_support(type)
{
	var li = "";
	for (var i = 0; i < support_item[type].len; i++) {
		var item = support_item[type].item[i];
		var value = support_item[type].value[item];
		if (control_link(type, item) === -1)
			continue;
		li += "<li><a href="+support_item[type].link;
		li += "#"+item+">";
		li += value+"</a></li>";
	}
	document.write(li);
}
function check_usb(){
		var str="";
                    	if ("<!--# echo feature_usb_silex -->" === "1")
                    		str+="<option value="+0+"><script>show_words(_share_port)</script></option>";
                    	if ("<!--# echo feature_usb_wcn -->" === "1")
                    		str+="<option value="+1+"><script>show_words(usb_wcn)</script></option>";
                    	if ("<!--# echo feature_usb_3g -->" === "1")
                    		str+="<option value="+2+"><script>show_words(usb_3g)</script></option>";
                    	if ("<!--# echo feature_usb_3g_phone -->" === "1")
                    		str+="<option value="+3+"><script>show_words(usb_3g_phone)</script></option>";
                    	document.write(str);
}
function check_setup (item)
{
	if (item === "VPN") {
		if ("<!--# echo feature_vpn -->" !== "1")
			return -1;
	}

	if (item === "USB") {
		//if ("<!--# echo feature_usb -->" !== "1")
		return -1;
	}

	if (item === "SSLVPN") {
		if ("<!--# echo feature_vpn -->" !== "1")
			return -1;
	}

	if (item === "PLC") {
		if ("<!--# echo feature_plc -->" !== "1")
			return -1;
	}
	
	if (item === "Wireless") {
		if ("<!--# echo feature_mbssid -->" == "y")
 			return -1;
	}

	if (item === "VLAN") {
		if ("<!--# echo feature_vlan -->" !== "1")
 			return -1;
	}

	if (item === "Storage") {
		if ("<!--# echo feature_storage -->" !== "1")
 			return -1;
	}

	if (item === "Media") {
		if ("<!--# echo feature_media_server -->" !== "1")
 			return -1;
	}
	
	if (item === "parental_control") {
		if ("<!--# echo feature_parental_control -->" !== "1")
 			return -1;
	}

	if (item === "ipv6") {
		if ("<!--# echo feature_ipv6 -->" !== "1")
 			return -1;
	}

	if (item === "mydlink") {
		if ("<!--# echo feature_mydlink -->" !== "1")
 			return -1;
	}
	return 0;
}

function check_adv (item)
{
	if (item === "appl" || item === "routing" || item === "adv_network" || item === "virtual") {
		if ("<!--# echo feature_ntt -->" === "1")
			return -1;
	}	

	if (item === "certi") {
		if ("<!--# echo feature_certi -->" !== "1")
			return -1;
	}

	if (item === "usergroup") {
		if ("<!--# echo feature_usergroup -->" !== "1")
			return -1;
	}

 	if (item === "guestzone") {
 		if ("<!--# echo feature_mbssid -->" == "y" || "<!--# echo feature_guestzone -->" == "0")
 			return -1;
 	}
 
 	if (item === "MBSSID") {
 		if ("<!--# echo feature_mbssid -->" !== "y")
 			return -1;
 	}

	if (item === "wish" || item === "WISH") {
		if ("<!--# echo feature_wish -->" !== "1")
			return -1;
	}

	if (item === "adv_wlan" || item === "Advanced_Wireless") {
 		if ("<!--# echo feature_mbssid -->" == "y")
 			return -1;
	}

	if (item === "qos" || item === "access_ctl" || item === "website_filter" || item === "wps") {
		if ("<!--# echo feature_mbssid -->" == "y")
			return -1;
	}

	if (item == "opendns") {
		return -1;
	}

 	if (item === "ipv6_firewall" || item =="ipv6_routing") {
 		if ("<!--# echo feature_ipv6 -->" !== "1")
 			return -1;
 	}

	return 0;
}

function check_tools (item)
{
	if (item === "time" || item === "syslog" || item === "email" || item === "syscheck" || item === "schedule") {
		if ("<!--# echo feature_ntt -->" === "1")
			return -1;
	}
	return 0;
}

function check_st (item) 
{
	if (item === "VPN") {
		if ("<!--# echo feature_vpn -->" !== "1")
			return -1;
	}
 	if (item === "ipv6" || item =="routing6") {
 		if ("<!--# echo feature_ipv6 -->" !== "1")
 			return -1;
 	}
 	if (item === "link" || item =="acl") {
 		if ("<!--# echo feature_ntt -->" !== "1")
 			return -1;
 	}
	return 0;
}

/* if return -1, it express it did not need the link. */
function control_link(type, item) {
	if (type === "Setup") {
		return check_setup(item);
	}

	if (type === "Advance") {
		return check_adv(item);
	}

	if (type === "Tools" || type === "tools") {
		return check_tools(item);
	}

	if (type === "Status") {
		return check_st(item);
	}

	return 0;
}

function check_reboot(){
	var str="";
	if ("<!--# echo reboot_type -->" != "") {
		str += "<input name=\"reboot_now\" id=\"reboot_now\" type=\"button\" class=button_submit value=\"\" onclick=\"return jump_reboot();\">";
		str += "<script>get_by_id(\"reboot_now\").value = YM3<\/script>";
		document.write(str);
	}
	
}
function jump_reboot(){
	send_submit("form_reboot");
	//get_by_id("form_reboot").submit();
}
function reboot_needed(url)
{
  var str = "";
  if ("<!--# echo reboot_type -->" != "") {
  	str = "<form id=\"form_reboot\" name=\"form_reboot\" method=\"post\" action=\"apply.cgi\">";
	str += "<input type=\"hidden\" name=\"html_response_page\" value=\"count_down.asp\">";
	str += "<input type=\"hidden\" name=\"html_response_return_page\" value=\"index.asp\">";
	str += "<script>document.form_reboot.html_response_return_page.value = \"" + url + "\";<\/script>";
	str += "<input type=\"hidden\" id=\"html_response_message\" name=\"html_response_message\" value=\"\">";
	if ("<!--# echo reboot_type -->" === "reboot")
		str += "<script>document.form_reboot.html_response_message.value = _reboot_running;</script>";
	else
		str += "<script>document.form_reboot.html_response_message.value = sc_intro_sv;</script>";
	str += "<input type=\"hidden\" name=\"action\" value=\"reboot_needed\">";
	str += "</form>";
	document.write(str);
  }
}

function disable_redirect(type, num)
{
	var item = ap_left[type].item[num];
	if ( item == "device")
		return false;
	return true;
}

function show_ap_left(type,num)
{
  var str = "<ul>";
  document.write(str);
  for(var i = 0; i < ap_left[type].len; i++){
	str = "";
	var item = ap_left[type].item[i];
	var value = ap_left[type].value[item];
	var link = ap_left[type].link[i];
	
	if(control_link(type, item) === -1)
		continue;
	
	if(parseInt(num) === i){
		str = "<li><div id=\"sidenavoff\" >"+ value +"</div></li>";
	}else{
		str = "<li><div id=\"sidenavon\" onclick=\"return jump_if();\"><a href=\""+ link +"\">"+ value +"</a></div></li>";
	}
	document.write(str);
  }
  str = "</ul>";
  document.write(str);
  if (disable_redirect(type, num))
	  time_out();
}

function show_left(type, num)
{
  var str = "<ul>";
  document.write(str);
  for(var i = 0; i < left[type].len; i++){
	str = "";
	var item = left[type].item[i];
	var value = left[type].value[item];
	var link = left[type].link[i];
	if(control_link(type, item) === -1)
		continue;
	
	if(parseInt(num) === i){
		str = "<li><div id=\"sidenavoff\" >"+ value +"</div></li>";
	}else{
		str = "<li><div id=\"sidenavon\" onclick=\"return jump_if();\"><a href=\""+ link +"\">"+ value +"</a></div></li>";
	}
	document.write(str);
  }
  str = "</ul>";
  document.write(str);
  if (disable_redirect(type, num))
	  time_out();
}

function show_ap_top(type){
  for(var i = 0; i < ap_top.len; i++){
    var str = "";
    var item = ap_top.item[i];
    var link = ap_top.link[i];
    if(type === item){
      var value = ap_top.value[type];
      str = "<td id=\"topnavon\"><a href=\"" + link + "\">" + value + "</a></td>";
    }else{
      var value = ap_top.value[item];
      str = "<td id=\"topnavoff\" onclick=\"return jump_if();\"><a href=\""+ link +"\">" + value + "</a></td>";
    }
    document.write(str);
  }
}

function show_top(type){
  for(var i = 0; i < _top.len; i++){
    var str = "";
    var item = _top.item[i];
    var link = _top.link[i];
    if(type === item){
      var value = _top.value[type];
      str = "<td id=\"topnavon\"><a href=\"" + link + "\">" + value + "</a></td>";
    }else{
      var value = _top.value[item];
	if(item === "adv"){
		for(var j = 0; j < left["Advance"].len; j++){
			if (check_adv(left["Advance"].item[j]) !== -1) {
				link = left["Advance"].link[j];
				break;
			}
		}
	}
	if(item === "help" && "<!--# echo feature_ntt -->" === "1")
		str = "<td id=\"topnavoff\"></td>";
	else{
		str = "<td id=\"topnavoff\" onclick=\"return jump_if();\"><a href=\""+ link +"\">" + value + "</a></td>";
	}
    }
    document.write(str);
  }
}

function check_rule_limitation()
{
        var vpn_total = 0;

        for (var i = 1; i <= 25; i++) {
                if (get_by_id("vpn_conn" + i).value != "")
                        vpn_total++;
                if (get_by_id("pptpd_conn_" + i).value != "")
                        vpn_total++;
                if (get_by_id("l2tpd_conn_" + i).value != "")
                        vpn_total++;
        }

        for (var i = 1; i <= 6; i++) {
                if (get_by_id("sslvpn" + i).value != "")
                        vpn_total++;
        }

        if (vpn_total >= 25)
                return true;

        return false;
}

function base64Encode(str) {
    var c, d, e, end = 0;
    var u, v, w, x;
    var ptr = -1;
    var input = str.split("");
    var output = "";
    while(end == 0) {
        c = (typeof input[++ptr] != "undefined") ? input[ptr].charCodeAt(0) :
            ((end = 1) ? 0 : 0);
        d = (typeof input[++ptr] != "undefined") ? input[ptr].charCodeAt(0) :
            ((end += 1) ? 0 : 0);
        e = (typeof input[++ptr] != "undefined") ? input[ptr].charCodeAt(0) :
            ((end += 1) ? 0 : 0);
        u = enc64List[c >> 2];
        v = enc64List[(0x00000003 & c) << 4 | d >> 4];
        w = enc64List[(0x0000000F & d) << 2 | e >> 6];
        x = enc64List[e & 0x0000003F];

        // handle padding to even out unevenly divisible string lengths
        if (end >= 1) {x = "=";}
        if (end == 2) {w = "=";}

        if (end < 3) {output += u + v + w + x;}
    }
    // format for 76-character line lengths per RFC
    var formattedOutput = "";
    var lineLength = 76;
    while (output.length > lineLength) {
        formattedOutput += output.substring(0, lineLength) + "\n";
        output = output.substring(lineLength);
    }
    formattedOutput += output;
    return formattedOutput;
}
function base64Decode(str) {
    var c=0, d=0, e=0, f=0, i=0, n=0;
    var input = str.split("");
    var output = "";
    var ptr = 0;
    do {
        f = input[ptr++].charCodeAt(0);
        i = dec64List[f];
        if ( f >= 0 && f < 128 && i != -1 ) {
            if ( n % 4 == 0 ) {
                c = i << 2;
            } else if ( n % 4 == 1 ) {
                c = c | ( i >> 4 );
                d = ( i & 0x0000000F ) << 4;
            } else if ( n % 4 == 2 ) {
                d = d | ( i >> 2 );
            } else {
                e = e | i;
            }
            n++;
            if ( n % 4 == 0 ) {
                output += String.fromCharCode(c) +
                          String.fromCharCode(d) +
                          String.fromCharCode(e);
            }
        }
    }
    while (typeof input[ptr] != "undefined");
    output += (n % 4 == 3) ? String.fromCharCode(c) + String.fromCharCode(d) :
              ((n % 4 == 2) ? String.fromCharCode(c) : "");
    return output;
}

var enc64List, dec64List;
function initBase64() {
    enc64List = new Array();
    dec64List = new Array();
    var i;
    for (i = 0; i < 26; i++) {
        enc64List[enc64List.length] = String.fromCharCode(65 + i);
    }
    for (i = 0; i < 26; i++) {
        enc64List[enc64List.length] = String.fromCharCode(97 + i);
    }
    for (i = 0; i < 10; i++) {
        enc64List[enc64List.length] = String.fromCharCode(48 + i);
    }
    enc64List[enc64List.length] = "+";
    enc64List[enc64List.length] = "/";
    for (i = 0; i < 128; i++) {
        dec64List[dec64List.length] = -1;
    }
    for (i = 0; i < 64; i++) {
        dec64List[enc64List[i].charCodeAt(0)] = i;
    }
}

// Self-initialize the global variables
initBase64();

/* Matt add - 2010/11/17 */
function check_wep_enabled(idx)
{
    var idx_t = 0;
    var wep_value = /wep/gi;

    var wlan_value = typeof($("#wlan0_security").val()) !== "undefined" ? 
		$("#wlan0_security").val() : $("#wlan1_security").val();
    var wlan_en = typeof($("#wlan0_enable").val()) !== "undefined" ? 
		$("#wlan0_enable").val() : $("#wlan1_enable").val();
    if(wlan_value.match(wep_value) && parseInt(wlan_en) == 1 && idx != 0) { 
	    alert(unique_set_wep);
	    return false;
    }

    wlan_vap_value = typeof($("#wlan0_vap1_security").val()) !== "undefined" ? 
		$("#wlan0_vap1_security").val() : $("#wlan1_vap1_security").val();
    wlan_vap_en = typeof($("#wlan0_vap1_enable").val()) !== "undefined" ? 
		$("#wlan0_vap1_enable").val() : $("#wlan1_vap1_enable").val();

    if(wlan_value.match(wep_value) && parseInt(wlan_vap_en) == 1 && idx != idx_t) {
	    alert(unique_set_wep);
	    return false;
    }
    return true;
}
/*-----------------------*/

/* Matt add - 2010/11/22 */
function ssid_decode(key)
{
	var ssid = get_by_id(key).value;
	var ssid_tmp = "";
	for (var i = 0; i < ssid.length; i++) {
		if (encodeURI(ssid.charAt(i)) === "%C2%A0") {
			ssid_tmp += decodeURI("%20");
		} else {
			ssid_tmp += ssid.charAt(i);
		}
	}
	return ssid_tmp
}
/*-----------------------*/

function replaceAll(src, src_rep, new_str)
{
	var index = 0;
	while(src.indexOf(src_rep, index) != -1) {
		src = src.replace(src_rep, new_str);
		index = src.indexOf(src_rep, index);
	}
	return src
}

/* from format.js */
function fmt_error_msg(error_msg_idx)
{
        alert(format_error_msg[error_msg_idx]);
        return -1;
}

function fmt_account_verify(ui_element)
{
        var usr = get_by_id(ui_element).value;

        if (usr == "")
                return fmt_error_msg(5);//FMT_INVALID_ACCOUNT

        return 0;
}

function fmt_username_verify(ui_element)
{
        var usr = get_by_id(ui_element).value;

        if (usr == "")
                return fmt_error_msg(6);//FMT_INVALID_USERNAME

        return 0;
}

/* @ip is valid IP format, we don't need to verify @ip is valid or not */
function fmt_ip_useable_verify(ip)
{
        var ip_ary = ip.split(".");

        if (parseInt(ip_ary[0]) < 1 || parseInt(ip_ary[0]) > 224)
                return fmt_error_msg(4);//FMT_INVALID_IPUSABLE

        return 0;
}

function iprange_singal_check(singal_ip_fmt)
{
        var ip_obj = new addr_obj(singal_ip_fmt.split("."), ip_addr_msg, false, false);

        return (check_address(ip_obj) == true)?0:-1;
}

function iprange_range_check(range_ip_fmt)
{
        var ip_range_list = range_ip_fmt.split("-");

        if (ip_range_list.length != 2)
                return fmt_error_msg(1);//FMT_INVALID_IPRANGE

        if (iprange_singal_check(ip_range_list[0]) == -1 ||
                iprange_singal_check(ip_range_list[1]) == -1)
                return -1;

        return 0;
}

function iprange_network_check(network_ip_fmt)
{
        if(network_ip_fmt != "0.0.0.0/0") {
                if(!check_ip_data(network_ip_fmt))
                        return -1;
        }

        return 0;
}

function iprange_fmt_check(ip_fmt)
{
        var ip_entry_fmt, ip_entry_list;

        if (ip_fmt == "*")
                return true;

        ip_entry_fmt = ip_fmt.replace(/;/, ",");
        ip_entry_list = ip_entry_fmt.split(",");

        for (var i = 0; i < ip_entry_list.length; i++) {
                if (ip_entry_list[i].search(/-/) == -1 && ip_entry_list[i].search(/\//) == -1)
                        ret = iprange_singal_check(ip_entry_list[i]);
                else if (ip_entry_list[i].search(/-/) != -1)
                        ret = iprange_range_check(ip_entry_list[i]);
                else
                        ret = iprange_network_check(ip_entry_list[i]);

                if (ret == -1)
                        return false;
        }

        return true;
}

/* end : fromat.js */

/* start : md5.js */
/* 
* A JavaScript implementation of the RSA Data Security, Inc. MD5 Message 
* Digest Algorithm, as defined in RFC 1321. 
* Copyright (C) Paul Johnston 1999 - 2000. 
* Updated by Greg Holt 2000 - 2001. * See http://pajhome.org.uk/site/legal.html for details. 
*/ 
/* 
* Convert a 32-bit number to a hex string with ls-byte first 
*/ 
var hex_chr = "0123456789abcdef"; 
function rhex(num) 
{ 
	var str = ""; 
	for(var j = 0; j <= 3; j++) 
		str += hex_chr.charAt((num >> (j * 8 + 4)) & 0x0F) + hex_chr.charAt((num >> (j * 8)) & 0x0F); 
	return str; 
} 
/* 
* Convert a string to a sequence of 16-word blocks, stored as an array. 
* Append padding bits and the length, as described in the MD5 standard. 
*/ 
function str2blks_MD5(str) 
{ 
	var nblk = ((str.length + 8) >> 6) + 1; 
	var blks = new Array(nblk * 16); 
	for(var i = 0; i < nblk * 16; i++) blks[i] = 0; 
	for(var i = 0; i < str.length; i++) 
		blks[i >> 2] |= str.charCodeAt(i) << ((i % 4) * 8); 
	blks[i >> 2] |= 0x80 << ((i % 4) * 8); 
	blks[nblk * 16 - 2] = str.length * 8; 
	return blks; 
} 
/* 
* Add integers, wrapping at 2^32. This uses 16-bit operations internally 
* to work around bugs in some JS interpreters. 
*/ 
function safe_add(x, y) 
{ 
	var lsw = (x & 0xFFFF) + (y & 0xFFFF); 
	var msw = (x >> 16) + (y >> 16) + (lsw >> 16); 
	return (msw << 16) | (lsw & 0xFFFF); 
} 
/* 
* Bitwise rotate a 32-bit number to the left 
*/ 
function rol(num, cnt) 
{ 
	return (num << cnt) | (num >>> (32 - cnt)); 
} 
/* 
* These functions implement the basic operation for each round of the 
* algorithm. 
*/ 
function cmn(q, a, b, x, s, t) 
{ 
	return safe_add(rol(safe_add(safe_add(a, q), safe_add(x, t)), s), b); 
} 
function ff(a, b, c, d, x, s, t) 
{ 
	return cmn((b & c) | ((~b) & d), a, b, x, s, t); 
} 
function gg(a, b, c, d, x, s, t) 
{ 
	return cmn((b & d) | (c & (~d)), a, b, x, s, t); 
} 
function hh(a, b, c, d, x, s, t) 
{ 
	return cmn(b ^ c ^ d, a, b, x, s, t); 
} 
function ii(a, b, c, d, x, s, t) 
{ 
	return cmn(c ^ (b | (~d)), a, b, x, s, t); 
} 
/* 
* Take a string and return the hex representation of its MD5. 
*/ 
function calcMD5(str) 
{ 
var x = str2blks_MD5(str); 
var a = 1732584193; 
var b = -271733879; 
var c = -1732584194; 
var d = 271733878; 
for(i = 0; i < x.length; i += 16) 
{ 
var olda = a; 
var oldb = b; 
var oldc = c; 
var oldd = d; 
a = ff(a, b, c, d, x[i+ 0], 7 , -680876936); 
d = ff(d, a, b, c, x[i+ 1], 12, -389564586); 
c = ff(c, d, a, b, x[i+ 2], 17, 606105819); 
b = ff(b, c, d, a, x[i+ 3], 22, -1044525330); 
a = ff(a, b, c, d, x[i+ 4], 7 , -176418897); 
d = ff(d, a, b, c, x[i+ 5], 12, 1200080426); 
c = ff(c, d, a, b, x[i+ 6], 17, -1473231341); 
b = ff(b, c, d, a, x[i+ 7], 22, -45705983); 
a = ff(a, b, c, d, x[i+ 8], 7 , 1770035416); 
d = ff(d, a, b, c, x[i+ 9], 12, -1958414417); 
c = ff(c, d, a, b, x[i+10], 17, -42063); 
b = ff(b, c, d, a, x[i+11], 22, -1990404162); 
a = ff(a, b, c, d, x[i+12], 7 , 1804603682); 
d = ff(d, a, b, c, x[i+13], 12, -40341101); 
c = ff(c, d, a, b, x[i+14], 17, -1502002290); 
b = ff(b, c, d, a, x[i+15], 22, 1236535329); 
a = gg(a, b, c, d, x[i+ 1], 5 , -165796510); 
d = gg(d, a, b, c, x[i+ 6], 9 , -1069501632); 
c = gg(c, d, a, b, x[i+11], 14, 643717713); 
b = gg(b, c, d, a, x[i+ 0], 20, -373897302); 
a = gg(a, b, c, d, x[i+ 5], 5 , -701558691); 
d = gg(d, a, b, c, x[i+10], 9 , 38016083); 
c = gg(c, d, a, b, x[i+15], 14, -660478335); 
b = gg(b, c, d, a, x[i+ 4], 20, -405537848); 
a = gg(a, b, c, d, x[i+ 9], 5 , 568446438); 
d = gg(d, a, b, c, x[i+14], 9 , -1019803690); 
c = gg(c, d, a, b, x[i+ 3], 14, -187363961); 
b = gg(b, c, d, a, x[i+ 8], 20, 1163531501); 
a = gg(a, b, c, d, x[i+13], 5 , -1444681467); 
d = gg(d, a, b, c, x[i+ 2], 9 , -51403784); 
c = gg(c, d, a, b, x[i+ 7], 14, 1735328473); 
b = gg(b, c, d, a, x[i+12], 20, -1926607734); 
a = hh(a, b, c, d, x[i+ 5], 4 , -378558); 
d = hh(d, a, b, c, x[i+ 8], 11, -2022574463); 
c = hh(c, d, a, b, x[i+11], 16, 1839030562); 
b = hh(b, c, d, a, x[i+14], 23, -35309556); 
a = hh(a, b, c, d, x[i+ 1], 4 , -1530992060); 
d = hh(d, a, b, c, x[i+ 4], 11, 1272893353); 
c = hh(c, d, a, b, x[i+ 7], 16, -155497632); 
b = hh(b, c, d, a, x[i+10], 23, -1094730640); 
a = hh(a, b, c, d, x[i+13], 4 , 681279174); 
d = hh(d, a, b, c, x[i+ 0], 11, -358537222); 
c = hh(c, d, a, b, x[i+ 3], 16, -722521979); 
b = hh(b, c, d, a, x[i+ 6], 23, 76029189); 
a = hh(a, b, c, d, x[i+ 9], 4 , -640364487); 
d = hh(d, a, b, c, x[i+12], 11, -421815835); 
c = hh(c, d, a, b, x[i+15], 16, 530742520); 
b = hh(b, c, d, a, x[i+ 2], 23, -995338651); 
a = ii(a, b, c, d, x[i+ 0], 6 , -198630844); 
d = ii(d, a, b, c, x[i+ 7], 10, 1126891415); 
c = ii(c, d, a, b, x[i+14], 15, -1416354905); 
b = ii(b, c, d, a, x[i+ 5], 21, -57434055); 
a = ii(a, b, c, d, x[i+12], 6 , 1700485571); 
d = ii(d, a, b, c, x[i+ 3], 10, -1894986606); 
c = ii(c, d, a, b, x[i+10], 15, -1051523); 
b = ii(b, c, d, a, x[i+ 1], 21, -2054922799); 
a = ii(a, b, c, d, x[i+ 8], 6 , 1873313359); 
d = ii(d, a, b, c, x[i+15], 10, -30611744); 
c = ii(c, d, a, b, x[i+ 6], 15, -1560198380); 
b = ii(b, c, d, a, x[i+13], 21, 1309151649); 
a = ii(a, b, c, d, x[i+ 4], 6 , -145523070); 
d = ii(d, a, b, c, x[i+11], 10, -1120210379); 
c = ii(c, d, a, b, x[i+ 2], 15, 718787259); 
b = ii(b, c, d, a, x[i+ 9], 21, -343485551); 
a = safe_add(a, olda); 
b = safe_add(b, oldb); 
c = safe_add(c, oldc); 
d = safe_add(d, oldd); 
} 
return rhex(a) + rhex(b) + rhex(c) + rhex(d); 
}

/* end : md5.js */

/* start : public_ipv6.js */
function select_ipv6_wan_page(ipv6_sel_wan){ 
	location.href = "adv_"+ipv6_sel_wan+".asp";
}

function ipv6_addr_obj(addr, e_msg, allow_zero, is_network){
	this.addr = addr;
	this.e_msg = e_msg;
	this.allow_zero = allow_zero;	
	this.is_network = is_network;	
}

function check_ipv6_symbol(strOrg,strFind){
	/*For fitting old check_ipv6_address function use*/	
	/*if false return 2, if have double-colon return 1, completely IPv6 address return 0*/
	var symbol_count=0; 
	var _index = 0;
	var current_index =-1;
	var dc_flag=0; 
	strFind = ":";	
	for (_index=0;_index<strOrg.length;_index++) {
		_index = strOrg.indexOf(strFind,_index);	
		if(_index<=-1)	
			break;
		else{
			if(_index == -1){
				return -1;
			}else{
				symbol_count++;
				if((_index-current_index)==1){
					dc_flag++;
					if(dc_flag>1){
						alert(ipv6_ip_double_colon);
						return 2;
					}
				}	
				current_index = _index;	
			}	
		}	
	}
	if(symbol_count<2 || symbol_count>7){ 
		alert(ipv6_ip_illegal_arr);
		return 2;	
	}	
	if(symbol_count>=2 && symbol_count<7 && dc_flag==0){	
		alert(ipv6_ip_illegal_arr);
		return 2;	
	}	
	if(symbol_count>7 && dc_flag>0){ 
		alert(ipv6_ip_illegal_arr);
		return 2;
	}	
	return dc_flag;
} 

function check_ipv6_address(my_obj,strFind){
	var ip = my_obj.addr;
	var count_zero=0; 
	var ip_temp;
	var sum = 0;
	var ipv6_field_number = 0;
	if(strFind == "::"){ 
		if (my_obj.addr.length == 2){ 
		if(ip[0].charAt(0) =="f" || ip[0].charAt(0) =="F"){
			if(ip[0].charAt(1) =="f" || ip[0].charAt(1) =="F"){
				alert(my_obj.e_msg[21]);//IPv6_MULTICASE_IP_ERROR
				return false;
			}	
		}	
		for(var i = 0; i < 2; i++){	
			ip_temp = ip[i].split(":");
			for(var index =0; index < ip_temp.length; index++){
				if(ip_temp[index].length == 0 || ip_temp[index].length > 4){
					alert(my_obj.e_msg[0]); //IPv6_INVALID_IP
					return false;
				}
				for(var pos =0; pos < ip_temp[index].length ;pos++){
					if(!check_hex(ip_temp[index].charAt(pos))){
						alert(my_obj.e_msg[2+ipv6_field_number]); //IPv6_FIRST_IP_ERROR
						return false;
					}
					sum += transValue(ip_temp[index].charAt(pos))*(pos+1);	
				}
				ipv6_field_number++;	
			}
		}
		if(sum == 0){ 
			alert(my_obj.e_msg[1]);//IPv6_ZERO_IP
			return false; 
		}
		}else{	
			alert(my_obj.e_msg[0]); //IPv6_INVALID_IP
			return false;
		}
	} else{	
	if (my_obj.addr.length == 8){ 
		if(ip[0].charAt(0) =="f" || ip[0].charAt(0) =="F"){
			if(ip[0].charAt(1) =="f" || ip[0].charAt(1) =="F"){
				alert(my_obj.e_msg[21]);//IPv6_MULTICASE_IP_ERROR
				return false;
			}	
		}	
		for(var i = 0; i < ip.length; i++){
			if (ip[i] == "0"){
				count_zero++;
			}else if((ip[i].charAt(0) =="0") && (ip[i].charAt(1) =="0")){
				count_zero++;	
			}else if((ip[i].charAt(0) =="0") && (ip[i].charAt(1) =="0") && (ip[i].charAt(2) =="0")){
				count_zero++;	
			}else if((ip[i].charAt(0) =="0") && (ip[i].charAt(1) =="0") && (ip[i].charAt(2) =="0") && (ip[i].charAt(3) =="0")){
				count_zero++;	
			}
		} 
		if (!my_obj.allow_zero && count_zero == 8){	
			alert(my_obj.e_msg[1]);	//IPv6_ZERO_IP
			return false; 
		}else{
			count_zero=0;
			for(var i = 0; i < ip.length; i++){
				if(ip[i].length > 4 || ip[i].length == 0){
					alert(my_obj.e_msg[0]);//IPv6_INVALID_IP
					return false;
				}
				for(var index =0; index < ip[i].length ;index++){
					if(!check_hex(ip[i].charAt(index))){
						alert(my_obj.e_msg[2+i]); //IPv6_FIRST_IP_ERROR
						return false;
					}
				}
			}
		}
	}else{	
		alert(my_obj.e_msg[0]);//IPv6_INVALID_IP
		return false;
	}	
	}
	return true;
} 

function get_stateful_ipv6(ipv6_addr)
{
	var ipv6_addr_prefix=""; 
	var ipv6_addr_suffix="";
	var index=0;
	var string_len=0;
	var colon=0;
	var total_colon=0;
	var fields=0;
	var zero_ipv6_addr="";
	var i=0;
	string_len = ipv6_addr.length;
	index = check_symbol(ipv6_addr,"::"); 
	if(index != -1){
		ipv6_addr_prefix = ipv6_addr.substring(0,index);
		ipv6_addr_suffix = ipv6_addr.substring(index+2,string_len);	
		colon = find_colon(ipv6_addr_prefix,":");
		total_colon = colon;
		colon = find_colon(ipv6_addr_suffix,":");
		total_colon += colon;
		fields = total_colon+2;
		for(i=0;i<(8-fields);i++){
			zero_ipv6_addr += ":0"; 
		}
		ipv6_addr = ipv6_addr_prefix+ zero_ipv6_addr +":"+ ipv6_addr_suffix;
	}	
	return ipv6_addr;
}

function get_stateful_prefix(ipv6_addr,length){
	var index=0;
	var ipv6_addr_prefix="";
	if(length == 64)
		index = count_colon_pos(ipv6_addr,":",4);
	if(length == 112)
		index = count_colon_pos(ipv6_addr,":",7);
	ipv6_addr_prefix = ipv6_addr.substring(0,index-1);
	return ipv6_addr_prefix; 
}

function get_stateful_suffix(ipv6_addr){
	var index=0;
	var ipv6_addr_suffix="";
	var string_len=0;
	string_len = ipv6_addr.length; 
	index = count_last_colon_pos(ipv6_addr,":");
	ipv6_addr_suffix = ipv6_addr.substring(index+1,string_len);	
	return ipv6_addr_suffix; 
} 

function check_ipv6_address_suffix(strOrg,tag){
	if( strOrg.length > 0 && strOrg.length < 5){
		for(var index =0; index < strOrg.length ;index++){
			if(!check_hex(strOrg.charAt(index))){
				ipv6_be_hex=replaceAll(ipv6_be_hex, "tag", tag);
				alert(ipv6_be_hex);
				return false;
			}	
		}
	}else{
		ipv6_suffix_invalid=replaceAll(ipv6_suffix_invalid, "tag", tag);
		alert(ipv6_suffix_invalid);
		return false;	
	}
	return true;	
}

function check_lan_ipv6_subnet(strOrg,tag){
	if( strOrg.length > 0 && strOrg.length < 5){
		for(var index =0; index < strOrg.length ;index++){
			if(!check_hex(strOrg.charAt(index))){
				ipv6_be_hex=replaceAll(ipv6_be_hex, "tag", tag);
				alert(ipv6_be_hex);
				return false;
			}	
		}
	}else{
		ipv6_suffix_invalid=replaceAll(ipv6_suffix_invalid, "tag", tag);
		alert(ipv6_suffix_invalid);
		return false;	
	}
	return true;	
}

/* end : public_ipv6.js */

function checksessionStorage()
{
        /* Because old browsers (it's likes IE5.5, IE6, ...etcs.) not support HTML5 function, we just do it with old arch. */
        if (typeof(sessionStorage) === "undefined") {
                return "<!--# exec cgi /bin/get_web_auth_record authorization get_identity -->";
        } else {
                return sessionStorage.getItem("account");
        }
}


/* WPS 2.0 Spec */
/* 
 * Verify Key exists or not
 */

function isExist_var(obj)
{
	return ((get_by_id(obj) != null ) ? true : false); 
}

function getVal(obj)
{
	/* maybe need to justify obj type */
	return get_by_id(obj).value;
}

function wps_behavior(security, cipher, broadcast)
{
	var dis_wps_pin = isExist_var("disable_wps_pin") ? getVal("disable_wps_pin") : "-1";
	var wps_lock = isExist_var("wps_lock") ? getVal("wps_lock") : "-1";

	if (broadcast === "0" || broadcast === true) {
		get_by_id("wps_enable").value = "0";
		if (dis_wps_pin != "-1")
			get_by_id("disable_wps_pin").value = "0";
		if (wps_lock != "-1")
			get_by_id("wps_lock").value = "0";
		return true;
	}

	if (security.match(/wep/g)) {
		get_by_id("wps_enable").value = "0";
		if (dis_wps_pin != "-1")
			get_by_id("disable_wps_pin").value = "0";
		if (wps_lock != "-1")
			get_by_id("wps_lock").value = "0";
		return true;
	}
		
	if (security.match(/wpa_psk/g)) {
		get_by_id("wps_enable").value = "0";
                if (dis_wps_pin != "-1")
                        get_by_id("disable_wps_pin").value = "0";
                if (wps_lock != "-1")
                        get_by_id("wps_lock").value = "0";
		return true;
	}

	if (security.match(/wpa2_psk/g) && cipher === "tkip") {
		get_by_id("wps_enable").value = "0";
                if (dis_wps_pin != "-1")
                        get_by_id("disable_wps_pin").value = "0";
                if (wps_lock != "-1")
                        get_by_id("wps_lock").value = "0";
		return true;
	}
	
	if (security.match(/wpa2auto_psk/g) && cipher === "tkip") {
		get_by_id("wps_enable").value = "0";
                if (dis_wps_pin != "-1")
                        get_by_id("disable_wps_pin").value = "0";
                if (wps_lock != "-1")
                        get_by_id("wps_lock").value = "0";
		return true;
	}

	if (security.match(/_eap/g)) {			//WPA-Enterprise
		get_by_id("wps_enable").value = "0";
                if (dis_wps_pin != "-1")
                        get_by_id("disable_wps_pin").value = "0";
                if (wps_lock != "-1")
                        get_by_id("wps_lock").value = "0";
		return true;
	}

	return false;
}

function getNames(obj)
{
	var gnames = get_by_name(obj);
	if (gnames[0].checked == true && gnames[1].checked == false) {
		return false;
	} else {
		return true;
	}
}

function wps_WarrMsg(w_en , w_en_1)
{
	if ("<!--# echo wps_enable -->" == "1") {
		var wlan0_en = isExist_var("wlan0_enable") ? getVal("wlan0_enable") : "-1";
		var wlan1_en = isExist_var("wlan1_enable") ? getVal("wlan1_enable") : "-1";
		var wlan0_sec = isExist_var("wlan0_security") ? getVal("wlan0_security") : "-1";
		var wlan1_sec = isExist_var("wlan1_security") ? getVal("wlan1_security") : "-1";
		var wlan0_cipher =  isExist_var("wlan0_psk_cipher_type") ? getVal("wlan0_psk_cipher_type") : "-1";
		var wlan1_cipher =  isExist_var("wlan1_psk_cipher_type") ? getVal("wlan1_psk_cipher_type") : "-1";
		var vflag = false, vflag1 = false;

		// 2.4G 
		if (w_en) {
			if (get_by_id("wps_configured_mode").value !== "1" && wlan0_sec.match(/disable/g)) {
 	               		alert(WPS_WARR_OPEN_CONFIG);
			}

			if (wlan0_sec.match(/wep/g) && !confirm(WPS_WARR_WEP)) {
				return false;
                	}

			if (wlan0_cipher == "tkip" && wlan0_sec.match(/wpa/g) && !confirm(WPS_WARR_TKIP)) {
				return false;
			}

			if ((wlan0_sec.match(/disable/g) == null) && (wlan0_cipher.match(/tkip/g) == null) &&
			      (wlan0_sec.match(/wpa2/g) == null) && (wlan0_sec.match(/wep/g) == null) && 
			      (wlan0_sec.match(/eap/g) == null ) && !confirm(WPS_WARR_WPAPSKONLY)) {
				return false;
			}

			if (wlan0_sec.match(/eap/g) && !confirm(WPS_WARR_WPAEAP)) {
				return false;
			}

			vflag = getNames("wlan0_ssid_broadcast");
		
			if (vflag && !confirm(WPS_WARR_SSID_BROADCAST))
					return false;
		}


		// 5G 
		if (w_en_1) {
			if (get_by_id("wps_configured_mode").value !== "1" && wlan1_sec.match(/disable/g)) {
 	               		alert(WPS_WARR_OPEN_CONFIG);
			}

			if (wlan1_sec.match(/wep/g) && !confirm(WPS_WARR_WEP)) {
				return false;
                	}

			if (wlan1_cipher == "tkip" && wlan1_sec.match(/wpa/g) && !confirm(WPS_WARR_TKIP)) {
				return false;
			}

			if ((wlan1_sec.match(/disable/g) == null) && (wlan1_cipher.match(/tkip/g) == null) &&
			      (wlan1_sec.match(/wpa2/g) == null) && (wlan1_sec.match(/wep/g) == null) && 
			      (wlan1_sec.match(/eap/g) == null ) && !confirm(WPS_WARR_WPAPSKONLY)) {
				return false;
			}

			if (wlan1_sec.match(/eap/g) && !confirm(WPS_WARR_WPAEAP)) {
				return false;
			}

			vflag1 = getNames("wlan1_ssid_broadcast");
		
			if (vflag1 && !confirm(WPS_WARR_SSID_BROADCAST))
					return false;
		}
	}
	return true;
}
 
function wps_guestzone_WarrMsg(w_en , w_en_1)
{
	//FIXME: If the strings is update ,please fix it. 
	var wep_warrmsg = TEXT024.replace("key 2, 3, 4", "");

	if ("<!--# echo wps_enable -->" == "1") {
		var wlan0_en = isExist_var("wlan0_enable") ? getVal("wlan0_enable") : "-1";
		var wlan1_en = isExist_var("wlan1_enable") ? getVal("wlan1_enable") : "-1";
		var wlan0_sec = isExist_var("wlan0_vap1_security") ? getVal("wlan0_vap1_security") : "-1";
		var wlan1_sec = isExist_var("wlan1_vap1_security") ? getVal("wlan1_vap1_security") : "-1";
		var wlan0_cipher =  isExist_var("c_type") ? getVal("c_type") : "-1";
		var wlan1_cipher =  isExist_var("c_type_1") ? getVal("c_type_1") : "-1";
		var vflag = false, vflag1 = false;
		//1=wep, 2=psk, 3=eap		

		// 2.4G 
		if (w_en) {
			if (get_by_id("wps_configured_mode").value !== "1" && wlan0_sec.match(/disable/g)) {
 	               		alert(WPS_WARR_OPEN_CONFIG);
			}

			if (wlan0_sec.match(/wep/g) && !alert(wep_warrmsg)) {
				return false;
                	}

			if (wlan0_cipher == "tkip" && wlan0_sec.match(/wpa/g) && !alert(TEXT025)) {
				return false;
			}

			if ((wlan0_sec.match(/disable/g) == null) && (wlan0_cipher.match(/tkip/g) == null) &&
			      (wlan0_sec.match(/wpa2/g) == null) && (wlan0_sec.match(/wep/g) == null) && 
			      (wlan0_sec.match(/eap/g) == null ) && !alert(TEXT026)) {
				return false;
			}

			if (wlan0_sec.match(/eap/g) && !alert(TEXT026)) {
				return false;
			}

		}

		// 5G 
		if (w_en_1) {
			if (get_by_id("wps_configured_mode").value !== "1" && wlan1_sec.match(/disable/g)) {
 	               		alert(WPS_WARR_OPEN_CONFIG);
			}

			if (wlan1_sec.match(/wep/g) && !alert(wep_warrmsg)) {
				return false;
                	}

			if (wlan1_cipher == "tkip" && wlan1_sec.match(/wpa/g) && !alert(TEXT025)) {
				return false;
			}

			if ((wlan1_sec.match(/disable/g) == null) && (wlan1_cipher.match(/tkip/g) == null) &&
			      (wlan1_sec.match(/wpa2/g) == null) && (wlan1_sec.match(/wep/g) == null) && 
			      (wlan1_sec.match(/eap/g) == null ) && !alert(TEXT026)) {
				return false;
			}

			if (wlan1_sec.match(/eap/g) && !alert(TEXT026)) {
				return false;
			}

		}
	}
	return true;
}

function WPS()
{
	var wlan0_en = isExist_var("wlan0_enable") ? getVal("wlan0_enable") : "-1";
	var wlan1_en = isExist_var("wlan1_enable") ? getVal("wlan1_enable") : "-1";

	var wlan0_sec = isExist_var("wlan0_security") ? getVal("wlan0_security") : "-1";
	var wlan1_sec = isExist_var("wlan1_security") ? getVal("wlan1_security") : "-1";

	var wlan0_cipher =  isExist_var("wlan0_psk_cipher_type") ? getVal("wlan0_psk_cipher_type") : "-1";
	var wlan1_cipher =  isExist_var("wlan1_psk_cipher_type") ? getVal("wlan1_psk_cipher_type") : "-1";

	if (wlan0_en != -1 && wlan0_en == "1")
		wps_behavior(wlan0_sec, wlan0_cipher, getNames("wlan0_ssid_broadcast"));

	if (wlan1_en != -1 && wlan1_en == "1")
		wps_behavior(wlan1_sec, wlan1_cipher, getNames("wlan1_ssid_broadcast"));
}       

function isWpsGrayOut(obj)
{
	var wlan0_en = isExist_var("wlan0_enable") ? getVal("wlan0_enable") : "-1";
	var wlan1_en = isExist_var("wlan1_enable") ? getVal("wlan1_enable") : "-1";

	var wlan0_sec = isExist_var("wlan0_security") ? getVal("wlan0_security") : "-1";
	var wlan1_sec = isExist_var("wlan1_security") ? getVal("wlan1_security") : "-1";

	var wlan0_cipher =  isExist_var("wlan0_psk_cipher_type") ? getVal("wlan0_psk_cipher_type") : "-1";
	var wlan1_cipher =  isExist_var("wlan1_psk_cipher_type") ? getVal("wlan1_psk_cipher_type") : "-1";

	var wlan0_bcast = isExist_var("wlan0_ssid_broadcast") ?  getVal("wlan0_ssid_broadcast") : "-1";
	var wlan1_bcast = isExist_var("wlan1_ssid_broadcast") ?  getVal("wlan1_ssid_broadcast") : "-1";

	var  rset_unconfig = isExist_var("reset_to_unconfigured") ?  getVal("reset_to_unconfigured") : "-1";
	
	var vflag = false;
	if (wlan0_en != "-1" && wlan0_en == "1") {
		 if (wps_behavior(wlan0_sec, wlan0_cipher, wlan0_bcast)) {
			vflag = true;
		 }
	}

	if (wlan1_en != "-1" && wlan1_en == "1") {
		if (wps_behavior(wlan1_sec, wlan1_cipher, wlan1_bcast)) {
			vflag = true;
		}
	}

	get_by_id(obj).disabled = vflag;

	if (vflag) {
		get_by_id("wpsLock").checked = false;
		if (rset_unconfig != -1)
			get_by_id("reset_to_unconfigured").disabled = false;
	} 

	if(get_by_id("wps_enable").value === "0")
		get_by_id("wpsLock").checked = false;
}

function isWepConflict()
{
	var wlan0_sec = isExist_var("wlan0_security") ? getVal("wlan0_security") : "-1";
	var wlan0_gsec = "<!--# echo wlan0_vap1_security -->";
        var wlan1_sec = isExist_var("wlan1_security") ? getVal("wlan1_security") : "-1";
	var wlan1_gsec = "<!--# echo wlan1_vap1_security -->";

	if (wlan0_sec != "-1") {
		if (wlan0_sec.match(/wep/g) && wlan0_gsec.match(/wep/g)) {
			alert(WIFI_WEP_CONFLICT);
			return false;
		}
	}
	
	if (wlan1_sec != "-1") {
		if (wlan1_sec.match(/wep/g) && wlan1_gsec.match(/wep/g)) {
			alert(WIFI_WEP_CONFLICT);
			return false;
		}
	}
	return true;
}

function check_hnat(name)
{
	var spi=get_by_id("spi_enable").value;
	var qos=get_by_id("traffic_shaping").value;
	var hnat=get_by_id("hnat_enable").value;
	
	if(name == "hnat_enable"){
		if(spi == "1" || qos == "1"){
			if(hnat == "1"){
				var msg1=HNAT_WAR4.replace(/%s1/, HNAT_HELP_TITLE);
				var msg2=msg1.replace(/%s2/, "SPI and QoS engine");
				if(confirm(msg2)){
					get_by_id("spi_enable").value = "0";		
					get_by_id("traffic_shaping").value = "0";
					return true;
				}else{
					return false;
				}
			}
		}		
	}
	if(name == "spi_enable") {
		if(spi == "1" && hnat == "1"){
			var msg1=HNAT_WAR4.replace(/%s1/, "SPI");
			var msg2=msg1.replace(/%s2/, HNAT_HELP_TITLE);
			if(confirm(msg2)){
				get_by_id("hnat_enable").value = "0";
				return true;
			}else{
				return false;
			}
		}
	}
	if(name == "traffic_shaping") {
		if(qos == "1" && hnat == "1"){
			var msg1=HNAT_WAR4.replace(/%s1/, YM48);
			var msg2=msg1.replace(/%s2/, HNAT_HELP_TITLE);
			if(confirm(msg2)){
				get_by_id("hnat_enable").value = "0";
				return true;
			}else{
				return false;
			}
		}
	}
	return true;		
}

function disable_all_btn(is_disable){
	var input_objs = document.getElementsByTagName("input");

	if (input_objs != null){
		for (var i = 0; i < input_objs.length; i++){
			if (input_objs[i].type == "button" || input_objs[i].type == "submit" || input_objs[i].type == "reset"){
				input_objs[i].disabled = is_disable;
			}
		}
	}
}

function remove_array(which_array, index){
	var result = new Array();
	var count = 0;
	
	for (var i = 0; i < which_array.length; i++){
		if (i == index){	// when we find the obj we want to remove in which_array
			continue;		// don't copy to the result array
		}
		
		result[count++] = which_array[i];	// copy the obj to the result array
	}
	
	return result;
}

function update_array(which_array, new_array, index){
	var result = new Array();
	var count = 0;
	
	for (var i = 0; i < which_array.length; i++){
		if (i == index){	// when we find the obj we want to update in which_array
			result[count++] = new_array;
			continue;
		}
		result[count++] = which_array[i];	// copy the obj to the result array
	}
	return result;
}
