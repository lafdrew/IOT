<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html lang="en-US" xmlns="http://www.w3.org/1999/xhtml" xml:lang="en-US">
<head>
<title>TRENDNET | modelName | Network | Lan Setting</title>
<meta http-equiv=Content-Type content="text/html; charset=UTF-8">
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
	var obj = new ccpObject();
	var menu = new menuObject();
	var DHCPL_DataArray = new Array();	
	var submit_button_flag = 0;	

	var reserveCnt 	= 0;
	//if(reservedHost.name != null)
		//reserveCnt = reservedHost.name.length;

	var rule_max_num = 25;
	var resert_rule = rule_max_num;
	var ReadyGroupArray = [null];
	var ListArray = [null];
	var DataArray = new Array();

//1/dddd/192.168.55.55/112255448877
function Data(enable, name, ip, mac, onList, index)
{
	this.Enable = enable;
	this.CName = name;
	this.IP = ip;
	this.MAC = mac;
	this.OnList = onList;
	this.INDEX = index;
	this.del = false;
}
	
function DHCP_Data(name, ip, mac, Exp_time, onList) 
{
	this.Name = name;
	this.IP = ip;
	this.MAC = mac;
	this.EXP_T = Exp_time;
	this.OnList = onList;
}
	
	
	function ReservationsObj(enable,name,ip,mac){
		this.no;
		this.enable = enable;
		this.name = name;
		this.ip = ip;
		this.mac = mac;
		this.del = false;
	};
	
function set_lan_dhcp_list(){
	var index = 0;
	var temp_dhcp_list = get_by_id("dhcp_list").value.split(",");
	for (var i = 0; i < temp_dhcp_list.length; i++){	
		var temp_data = temp_dhcp_list[i].split("/");
		if(temp_data.length > 1){
			DHCPL_DataArray[DHCPL_DataArray.length++] = new DHCP_Data(temp_data[0], temp_data[1], temp_data[2], temp_data[3], index);
			index++;
		}
	}
}

	
function add_reserved(){
	//check value
	
	var ip = $('#lanIp').val();
	var mask = $('#lanNetmask').val();
	var reserved_enable = $('#reserved_enable').attr('checked');
	var reserved_name = $('#reserved_name').val();
	var reserved_ip = $('#reserved_ip').val();
	var reserved_mac = $('#reserved_mac').val();
	var start_ip = $('#dhcpStart').val();
	var end_ip = $('#dhcpEnd').val();
	
	var ip_addr_msg = replace_msg(all_ip_addr_msg,get_words('_ipaddr'));
	var Res_ip_addr_msg = replace_msg(all_ip_addr_msg,get_words('lan_reserveIP')); 
	var start_ip_addr_msg = replace_msg(all_ip_addr_msg,get_words('TEXT035')); 
	var end_ip_addr_msg = replace_msg(all_ip_addr_msg,get_words('end_ip'));
	
	var temp_ip_obj = new addr_obj(ip.split("."), ip_addr_msg, false, false);
	var temp_mask_obj = new addr_obj(mask.split("."), subnet_mask_msg, false, false);
	var temp_res_ip_obj = new addr_obj(reserved_ip.split("."), Res_ip_addr_msg, false, false);
	var start_obj = new addr_obj(start_ip.split("."), start_ip_addr_msg, false, false);
	var end_obj = new addr_obj(end_ip.split("."), end_ip_addr_msg, false, false);
	
	var temp_res_ip2_obj = new addr_obj(reserved_ip.split("."), Res_ip_addr_msg, false, false);
	if(reserved_enable == true){
		if (!check_domain(temp_res_ip2_obj, temp_mask_obj, temp_ip_obj)){
			alert(get_words('TEXT033')+" " + reserved_ip + " "+get_words('GW_DHCP_SERVER_RESERVED_IP_IN_POOL_INVALID_a'));
			return false;
		}	
	}
	
	if(reserved_name == ""){
		//alert(msg[STATIC_DHCP_NAME]);
		alert(get_words('GW_INET_ACL_NAME_INVALID'));
		return false;
	}else if(!check_LAN_ip(temp_ip_obj.addr, temp_res_ip_obj.addr, get_words('TEXT033'))){
		return false;
	}else if (!check_address(temp_res_ip_obj, temp_mask_obj, temp_ip_obj)) {
		return false;
	}else if (!check_domain(temp_res_ip_obj, temp_mask_obj, temp_ip_obj)){
		alert(get_words('TEXT033')+" " + reserved_ip + " "+get_words('GW_DHCP_SERVER_RESERVED_IP_IN_POOL_INVALID_a'));
		return false;
	}else if (!check_mac(reserved_mac)){
		alert(get_words('KR3'));
		return false;
	}

	if (check_resip_order(temp_res_ip_obj,start_obj, end_obj)) {
		alert(get_words('TEXT033')+" " + reserved_ip + " "+get_words('GW_DHCP_SERVER_RESERVED_IP_IN_POOL_INVALID_a'));
		return false;
	}
	//check ReadyGroupArray
	for(var i=1;i<ReadyGroupArray.length;i++){
		if(ReadyGroupArray[i].name == reserved_name){
			var alt_msg = addstr1(get_words('GW_QOS_RULES_NAME_ALREADY_USED'), reserved_name);
			alert(alt_msg);
			return false;
		}
		if(ReadyGroupArray[i].ip == reserved_ip){
			var alt_msg = addstr1(get_words('GW_DHCP_SERVER_RESERVED_IP_UNIQUENESS_INVALID'), " ("+ reserved_ip +") ");
			alert(alt_msg);
			return false;
		}
		
		var temp_mac = reserved_mac.toLowerCase(); 
		var X_mac = ReadyGroupArray[i].mac.toLowerCase(); 
		if(X_mac == temp_mac){
			var alt_msg = addstr1(get_words('GW_DHCP_SERVER_RESERVED_MAC_UNIQUENESS_INVALID'), reserved_mac);
			alert(alt_msg);
			return false;
		}
	}
	//check ListArray
	for(var i=1;i<ListArray.length;i++){
		if(ListArray[i].name == reserved_name){
			var alt_msg = addstr1(get_words('GW_QOS_RULES_NAME_ALREADY_USED'), reserved_name);
			alert(alt_msg);
			return false;
		}
		if(ListArray[i].ip == reserved_ip){
			var alt_msg = addstr1(get_words('GW_DHCP_SERVER_RESERVED_IP_UNIQUENESS_INVALID'), " ("+ reserved_ip +") ");
			alert(alt_msg);
			return false;
		}
		var XX_mac = ListArray[i].mac.toLowerCase(); 
		if(XX_mac == temp_mac){
			var alt_msg = addstr1(get_words('GW_DHCP_SERVER_RESERVED_MAC_UNIQUENESS_INVALID'), reserved_mac);
			alert(alt_msg);
			return false;
		}
	}
	
	var obj = new ReservationsObj(
		$('#reserved_enable').attr('checked'),
		$('#reserved_name').val(),
		$('#reserved_ip').val(),
		$('#reserved_mac').val()
		
	);
	ReadyGroupArray.push(obj);
	$('#reserved_enable').attr('checked',false);
	$('#reserved_name').val('');
	$('#reserved_ip').val('');
	$('#reserved_mac').val('');
	$('#readyreserv').show();
	
	Paint_ReadyTable();
}
function Paint_ReadyTable(){
	var RT_header = '<tr>\
<td class="CTS" style="width:20">'+get_words('_item_no')+'</td>\
<td class="CTS" style="width:40">'+get_words('_enable')+'</td>\
<td class="CTS" style="width:121">'+get_words('bd_CName')+'</td>\
<td class="CTS" style="width:87">'+get_words('_ipaddr')+'</td>\
<td class="CTS" style="width:99">'+get_words('_macaddr')+'</td>\
<td class="CTS" style="width:40">'+get_words('_delete')+'</td>\
</tr>';
	$('#ReadyTable').children().remove();
	$('#ReadyTable').append(RT_header);
	for(var i=1;i<ReadyGroupArray.length;i++){
		ReadyGroupArray[i].no = i;
		var obj = 
'<tr name="rg_list">\
<td class="CELL">'+ReadyGroupArray[i].no+'</td>\
<td class="CELL"><input type="checkbox" disabled="" '+(ReadyGroupArray[i].enable?'checked="checked"':'')+' /></td>\
<td class="CELL">'+ReadyGroupArray[i].name+'</td>\
<td class="CELL">'+ReadyGroupArray[i].ip+'</td>\
<td class="CELL">'+ReadyGroupArray[i].mac+'</td>\
<td class="CELL"><input type="checkbox" id="sel_tr'+i+'" name="sel_tr" value="ON" onchange="change_rg_del('+i+');" '+(ReadyGroupArray[i].del?'checked="checked"':'')+' /></td>\
</tr>';
		$('#ReadyTable').append(obj);
	}
}
function change_rg_del(idx){
	ReadyGroupArray[idx].del = $('#sel_tr'+idx).attr('checked');
}

function check_dhcp_value(){
	var start_obj, end_obj;
	var temp_mac = "";
	var ip = get_by_id("lanIp").value;
	var mask = get_by_id("lanNetmask").value;
	
	var ip_addr_msg = replace_msg(all_ip_addr_msg,get_words('_ipaddr'));
	var wan_ip_addr_msg = replace_msg(all_ip_addr_msg,get_words('_ipaddr'));
	var temp_ip_obj = new addr_obj(ip.split("."), ip_addr_msg, false, false);
	var temp_mask_obj = new addr_obj(mask.split("."), subnet_mask_msg, false, false);
	var dhcp_les = get_by_id("dhcpLease").value;
	
	var wan_proto 			= "<!--# echo wan_proto -->";
	var wan_port_status 	= "<!--# echo wan_port_status -->";
	var wan_ip_addr;
	
	if(wan_proto == "static"){
		wan_ip_addr= "<!--# echo wan_static_ipaddr -->";
	}else if(wan_proto == "pppoe"){
		wan_ip_addr= "<!--# echo wan_pppoe_ipaddr_00 -->";
	}else if(wan_proto == "pptp"){
		wan_ip_addr= "<!--# echo wan_pptp_ipaddr -->";
	}else if(wan_proto == "l2tp"){
		wan_ip_addr= "<!--# echo wan_l2tp_ipaddr -->";
	}else{
		var wan_ip_addr1 = get_by_id("wan_current_ipaddr").value.split("/");
		wan_ip_addr = wan_ip_addr1[0];
	}	        
	
	var wan_ip_addr_obj 	= new addr_obj(wan_ip_addr.split("."), wan_ip_addr_msg, false, false); 
	
	if (!check_mask(temp_mask_obj) || !check_address(temp_ip_obj, temp_mask_obj)) {
		return false;
	}
	var dhcpsvr = $('#lanDhcpType').val();

   if(wan_proto == "static" && wan_ip_addr != "0.0.0.0"){ // when wan static ip doesn't empty
		if (check_domain(temp_ip_obj, temp_mask_obj, wan_ip_addr_obj)){
			//alert("LAN and WAN IP Address cann't be set to the same subnet.");
			alert(get_words('bln_alert_3'));
			return false;
		}
		
	/*}else if(wan_proto != "static" && get_by_id("wan_current_ipaddr").value != "0.0.0.0/0.0.0.0/0.0.0.0/0.0.0.0/0.0.0.0"){ // /PPTP/L2TP/PPPoE plug in WAN port
		if (check_domain(temp_ip_obj, temp_mask_obj, wan_ip_addr_obj)){
			//alert("LAN and WAN IP Address cann't be set to the same subnet.");
			alert(get_words('bln_alert_3'));
			return false;
		}*/
	}else if(wan_proto == "pppoe" && wan_ip_addr != "0.0.0.0"){ // when wan pppoe ip doesn't empty
		if (check_domain(temp_ip_obj, temp_mask_obj, wan_ip_addr_obj)){
			//alert("LAN and WAN IP Address cann't be set to the same subnet.");
			alert(get_words('bln_alert_3'));
			return false;
		}
	}else if(wan_proto == "pptp" && wan_ip_addr != "0.0.0.0"){ // when wan pptp ip doesn't empty
		if (check_domain(temp_ip_obj, temp_mask_obj, wan_ip_addr_obj)){
			//alert("LAN and WAN IP Address cann't be set to the same subnet.");
			alert(get_words('bln_alert_3'));
			
			return false;
		}
	}else if(wan_proto == "l2tp" && wan_ip_addr != "0.0.0.0"){ // when wan l2tp ip doesn't empty
		if (check_domain(temp_ip_obj, temp_mask_obj, wan_ip_addr_obj)){
			//alert("LAN and WAN IP Address cann't be set to the same subnet.");
			alert(get_words('bln_alert_3'));
			return false;
		}
	}
	

	//if ((dhcpsvr=='1') && (dev_mode == "0")){			//add dev_mode check by vic, 2010/11/08
	if (dhcpsvr=='1'){
		var start_ip = get_by_id("dhcpStart").value;
		var end_ip = get_by_id("dhcpEnd").value;
		
		var start_ip_addr_msg = replace_msg(all_ip_addr_msg,get_words('TEXT035'));
		var end_ip_addr_msg = replace_msg(all_ip_addr_msg,get_words('end_ip'));

		var start_obj = new addr_obj(start_ip.split("."), start_ip_addr_msg, false, false);
		var end_obj = new addr_obj(end_ip.split("."), end_ip_addr_msg, false, false);

		//check dhcp ip range equal to lan-ip or not?
		if(!check_LAN_ip(temp_ip_obj.addr, start_obj.addr, "Start IP address")){
			return false;
		}

		if(!check_LAN_ip(temp_ip_obj.addr, end_obj.addr, "End IP Address")){
			return false;
		}
		
		//check dhcp ip range and lan ip the same mask or not?
		if (!check_address(start_obj, temp_mask_obj, temp_ip_obj) || !check_address(end_obj, temp_mask_obj, temp_ip_obj)){
			return false;
		}

		if (!check_domain(temp_ip_obj, temp_mask_obj, start_obj)){
			//alert(msg[START_INVALID_DOMAIN]);
			alert(get_words('TEXT037'));
			return false;
		}

		if (!check_domain(temp_ip_obj, temp_mask_obj, end_obj)){
			//alert(msg[END_INVALID_DOMAIN]);
			alert(get_words('TEXT038'));
			return false;
		}
		
		if (!check_ip_order(start_obj, end_obj)){
			//alert(msg[IP_RANGE_ERROR]);
			alert(get_words('TEXT039'));
			return false;
		}
		
		if (check_lanip_order(temp_ip_obj,start_obj, end_obj)){
			alert(get_words('network_dhcp_ip_in_server'));
			//alert(msg[NETWORK_DHCP_IP_IN_SERVER]);
			return false;
		}
		var less_msg = replace_msg(check_num_msg, get_words('bd_DLT'), 1, 999999);
		var temp_less = new varible_obj(dhcp_les, less_msg, 1, 999999, false);
		if (!check_varible(temp_less)){
			return false;
		}
	}
	return true;
}
function dhcp_apply(){
	
	obj.set_param_url('apply.cgi');
	obj.set_ccp_act('set');
	obj.add_param_event('lan');
	obj.set_param_next_page('internet_lan.asp');
	
	if(check_dhcp_value()){
		var tmp_ip =  "<!--# echo lan_ipaddr -->";
		var tmp_mask =  "<!--# echo lan_netmask -->";
		var tmp_dhcp_enable =  "<!--# echo dhcpd_enable -->";
		var ip = $('#lanIp').val();
		
		var dhcpsvr = get_by_id("dhcpsvr");

		if(tmp_ip != ip){
			var change_ip = ip.split("."), source_ip = tmp_ip.split(".");
			if ((change_ip[0] != source_ip[0]) ||
			    (change_ip[1] != source_ip[1]) ||
			    (change_ip[2] != source_ip[2])){
				alert(get_words('_LAN_CHK_REBOOT_MSG'));
			}
			get_by_id("change_lan_ip").value = "1";
			obj.add_param_arg('change_lan_ip','1');			
		}		
		
		var form = get_by_id("form1");
		form.elements["html_response_message"].value = get_words('sc_intro_sv') + "<count_down>" + get_words('rb_change');
		get_by_id("lan_ipaddr").value = $('#lanIp').val();
		get_by_id("lan_netmask").value = $('#lanNetmask').val();
		get_by_id("dhcpd_enable").value = $('#lanDhcpType').val();
		get_by_id("dhcpd_start").value = $('#dhcpStart').val();
		get_by_id("dhcpd_end").value = $('#dhcpEnd').val();
		get_by_id("dhcpd_lease_time").value = parseInt($('#dhcpLease').val());

		obj.add_param_arg('lan_ipaddr',$('#lanIp').val());			
		obj.add_param_arg('lan_netmask',$('#lanNetmask').val());			
		obj.add_param_arg('dhcpd_enable',$('#lanDhcpType').val());			
		obj.add_param_arg('dhcpd_start',$('#dhcpStart').val());			
		obj.add_param_arg('dhcpd_end',$('#dhcpEnd').val());			
		obj.add_param_arg('dhcpd_lease_time',parseInt($('#dhcpLease').val()));			
              obj.add_param_arg('reboot_type','lan');	//lan need reboot ? for test issue? jacky add for issue 49 / 50
		var paramForm = obj.get_param();
		totalWaitTime = 40; //second
             	redirectURL = $('#lanIp').val();
		//wait_page();
                reboot_page();
		jq_ajax_post(paramForm.url, paramForm.arg);


	}else{
		return false;
	}		
}
function ready_apply(){
	var max_row = parseInt(get_by_id("max_row").value) + 1;
	var tmp_index = 0, has_data = 0;
	for(var ii = 0; ii < rule_max_num; ii++){
		if (ii < 10){
			if (get_by_id("dhcpd_reserve_0" + ii).value != ""){
				tmp_index = ii;
				has_data = 1;
			}else{
				get_by_id("dhcpd_reserve_0" + ii).value = "";
				obj.add_param_arg('dhcpd_reserve_0'+ii, '');
			}
		}else{
			if (get_by_id("dhcpd_reserve_" + ii).value != ""){
				tmp_index = ii;
				has_data = 1;
			}else{
				get_by_id("dhcpd_reserve_" + ii).value = "";
				obj.add_param_arg('dhcpd_reserve_'+ii, '');
			}
		}
	}

	for(var ii = 1; ii < ReadyGroupArray.length; ii++){
		if(ReadyGroupArray[ii].Name != ""){
			var dat = ReadyGroupArray[ii].enable +"/"+ ReadyGroupArray[ii].name +"/"+ ReadyGroupArray[ii].ip +"/"+ ReadyGroupArray[ii].mac;
			var tmp_ip = (ReadyGroupArray[ii].ip).toString();
			var ip = get_by_id("lan_ipaddr").value;

			var tmp2_ip = tmp_ip.split(".");
			var ip2 = ip.split(".");
			var mask = get_by_id("lan_netmask").value;
		  var temp_mask_obj = new addr_obj(mask.split("."), subnet_mask_msg, false, false);
		  var is_enable = "0";

			tmp_ip="";
			for(var i =0; i< 4;i++) {
				if (( parseInt(tmp2_ip[i]) & parseInt(temp_mask_obj.addr[i])) != 
					(parseInt(ip2[i]) & parseInt(temp_mask_obj.addr[i])))

					tmp_ip +=ip2[i];
				else
					tmp_ip +=tmp2_ip[i];

				if(i < 3)
					tmp_ip += ".";
			}
			if(ReadyGroupArray[ii].enable){
				is_enable = "1";
			}else{
				is_enable = "0";
			}
			dat = is_enable +"/"+ ReadyGroupArray[ii].name +"/"+ tmp_ip +"/"+ ReadyGroupArray[ii].mac;
	
			var ip_addr_msg = replace_msg(all_ip_addr_msg, get_words('_ipaddr'));
			var Res_ip_addr_msg = replace_msg(all_ip_addr_msg, get_words('_res_ipaddr'));
			var temp_res_ip_obj = new addr_obj(tmp_ip.split("."), Res_ip_addr_msg, false, false);
			var temp_ip_obj = new addr_obj(ip.split("."), ip_addr_msg, false, false);

			if(!check_address(temp_res_ip_obj, temp_mask_obj, temp_ip_obj)){
				return false;
			}

			if (has_data ==1 )
				tmp_index++;
				
			if (parseInt(tmp_index) < 10){
				get_by_id("dhcpd_reserve_0" + (tmp_index).toString()).value = dat;
				obj.add_param_arg('dhcpd_reserve_0'+(tmp_index).toString(), dat);
				tmp_index++;
			}else{
				get_by_id("dhcpd_reserve_" + (tmp_index)).value = dat;
				obj.add_param_arg('dhcpd_reserve_'+(tmp_index).toString(), dat);
				tmp_index++;
			}
		}
	}
	dhcp_apply();


/*	var obj = new ccpObject();
	obj.set_param_url('get_set.ccp');
	obj.set_ccp_act('set');
	obj.add_param_event('CCP_SUB_WEBPAGE_APPLY');
	obj.set_param_next_page('internet_lan.asp');


	for(var i=1;i<ReadyGroupArray.length;i++){
		obj.add_param_arg('reserveDHCP_Enable_','1.1.'+(reserveCnt+i)+'.0',(ReadyGroupArray[i].enable?"1":"0"));
		obj.add_param_arg('reserveDHCP_HostName_','1.1.'+(reserveCnt+i)+'.0',ReadyGroupArray[i].name);
		obj.add_param_arg('reserveDHCP_Yiaddr_','1.1.'+(reserveCnt+i)+'.0',ReadyGroupArray[i].ip);
		obj.add_param_arg('reserveDHCP_Chaddr_','1.1.'+(reserveCnt+i)+'.0',ReadyGroupArray[i].mac);
	}

	var param = obj.get_param();
	
	totalWaitTime = 18; //second
	redirectURL = location.pathname;
	wait_page();
	jq_ajax_post(param.url, param.arg);
*/
}
function delete_ready(){
	var deleted_objs = $('tr[name=rg_list]>td>input[name=sel_tr]:checked');
	if(deleted_objs.length>0){
	if(!confirm(get_words('YM25') + "?"))
		return;
		
	}else{
		alert(get_words('TEXT044'));
	}
	for(var i=0;i<deleted_objs.length;i++){
		var i_id = parseInt($(deleted_objs[i]).attr('id').replace('sel_tr',''));
		 ReadyGroupArray.splice(i_id, 1, 0);

	}
	for(var i=0; i<ReadyGroupArray.length; i++){
		if(ReadyGroupArray[i] == 0){
			ReadyGroupArray.splice(i, 1);
			i--;
		}
	}
	Paint_ReadyTable();
}

function save_reserved(){
	//check value
	obj.set_param_url('apply.cgi');
	obj.set_ccp_act('set');
	obj.add_param_event('lan');
	obj.set_param_next_page('internet_lan.asp');

	var ip = $('#lanIp').val();
	var mask = $('#lanNetmask').val();
	var reserved_enable = $('#ruleEnable').attr('checked');
	var reserved_name = $('#ruleName').val();
	var reserved_ip = $('#ipaddress').val();
	var reserved_mac = $('#macaddress').val();
	var start_ip = $('#dhcpStart').val();
	var end_ip = $('#dhcpEnd').val();
	
	var ip_addr_msg = replace_msg(all_ip_addr_msg,get_words('_ipaddr'));
	var Res_ip_addr_msg = replace_msg(all_ip_addr_msg,get_words('lan_reserveIP')); 
	var start_ip_addr_msg = replace_msg(all_ip_addr_msg,get_words('TEXT035')); 
	var end_ip_addr_msg = replace_msg(all_ip_addr_msg,get_words('end_ip'));
	
	var temp_ip_obj = new addr_obj(ip.split("."), ip_addr_msg, false, false);
	var temp_mask_obj = new addr_obj(mask.split("."), subnet_mask_msg, false, false);
	var temp_res_ip_obj = new addr_obj(reserved_ip.split("."), Res_ip_addr_msg, false, false);
	var start_obj = new addr_obj(start_ip.split("."), start_ip_addr_msg, false, false);
	var end_obj = new addr_obj(end_ip.split("."), end_ip_addr_msg, false, false);
	
	var temp_res_ip2_obj = new addr_obj(reserved_ip.split("."), Res_ip_addr_msg, false, false);
	if(reserved_enable == true){
		if (!check_domain(temp_res_ip2_obj, temp_mask_obj, temp_ip_obj)){
			alert(get_words('TEXT033')+" " + reserved_ip + " "+get_words('GW_DHCP_SERVER_RESERVED_IP_IN_POOL_INVALID_a'));
			return false;
		}	
	}
	
	if(reserved_name == ""){
		//alert(msg[STATIC_DHCP_NAME]);
		alert(get_words('GW_INET_ACL_NAME_INVALID'));
		return false;
	}else if(!check_LAN_ip(temp_ip_obj.addr, temp_res_ip_obj.addr, get_words('TEXT033'))){
		return false;
	}else if (!check_address(temp_res_ip_obj, temp_mask_obj, temp_ip_obj)) {
		return false;
	}else if (!check_domain(temp_res_ip_obj, temp_mask_obj, temp_ip_obj)){
		alert(get_words('TEXT033')+" " + reserved_ip + " "+get_words('GW_DHCP_SERVER_RESERVED_IP_IN_POOL_INVALID_a'));
		return false;
	}else if (!check_mac(reserved_mac)){
		alert(get_words('KR3'));
		return false;
	}
	if (check_resip_order(temp_res_ip_obj,start_obj, end_obj)) {
		alert(get_words('TEXT033')+" " + reserved_ip + " "+get_words('GW_DHCP_SERVER_RESERVED_IP_IN_POOL_INVALID_a'));
		return false;
	}
	//check ListArray
	var cur_idx = parseInt($('#ruleID').val());
	for(var i=1;i<ListArray.length;i++){
		if(i==cur_idx)
			continue;
		if(reserved_name.length>0 && ListArray[i].name == reserved_name){
			var alt_msg = addstr1(get_words('GW_QOS_RULES_NAME_ALREADY_USED'), reserved_name);
			alert(alt_msg);
			return false;
		}
		if(reserved_ip.length>0 && ListArray[i].ip == reserved_ip){
			var alt_msg = addstr1(get_words('GW_DHCP_SERVER_RESERVED_IP_UNIQUENESS_INVALID'), " ("+ reserved_ip +") ");
			alert(alt_msg);
			return false;
		}
		if(reserved_mac.length>0 && ListArray[i].mac == reserved_mac){
			var alt_msg = addstr1(get_words('GW_DHCP_SERVER_RESERVED_MAC_UNIQUENESS_INVALID'), reserved_mac);
			alert(alt_msg);
			return false;
		}
	}
	ListArray[cur_idx].enable = $('#ruleEnable').attr('checked');
	ListArray[cur_idx].name = $('#ruleName').val();
	ListArray[cur_idx].ip = $('#ipaddress').val();
	ListArray[cur_idx].mac = $('#macaddress').val();

	if(ListArray[cur_idx].enable){
		var is_enable = "1";
	}else{
		var is_enable = "0";
	}

	var dat = is_enable +"/"+ ListArray[cur_idx].name +"/"+ ListArray[cur_idx].ip +"/"+ ListArray[cur_idx].mac;
	
	if (parseInt(cur_idx-1) < 10){
		get_by_id("dhcpd_reserve_0" + (cur_idx-1).toString()).value = dat;
		obj.add_param_arg('dhcpd_reserve_0'+(cur_idx-1).toString(), dat);
	}else{
		get_by_id("dhcpd_reserve_" + (cur_idx-1)).value = dat;
		obj.add_param_arg('dhcpd_reserve_'+(cur_idx-1).toString(), dat);
	}
	
		var form = get_by_id("form1");
		form.elements["html_response_message"].value = get_words('sc_intro_sv') + "<count_down>" + get_words('rb_change');

	var param = obj.get_param();
	totalWaitTime = 18; //second
	redirectURL = location.pathname;
	wait_page();
	jq_ajax_post(param.url, param.arg);
			
	

/*	
	var obj = new ccpObject();
	obj.set_param_url('get_set.ccp');
	obj.set_ccp_act('set');
	obj.add_param_event('CCP_SUB_WEBPAGE_APPLY');
	obj.set_param_next_page('internet_lan.asp');
	
	obj.add_param_arg('reserveDHCP_Enable_','1.1.'+cur_idx+'.0',(ListArray[cur_idx].enable?"1":"0"));
	obj.add_param_arg('reserveDHCP_HostName_','1.1.'+cur_idx+'.0',ListArray[cur_idx].name);
	obj.add_param_arg('reserveDHCP_Yiaddr_','1.1.'+cur_idx+'.0',ListArray[cur_idx].ip);
	obj.add_param_arg('reserveDHCP_Chaddr_','1.1.'+cur_idx+'.0',ListArray[cur_idx].mac);
*/	

}
function deleteAll_reserved(){
	
	for(var ii = 0; ii < rule_max_num; ii++){
		if (ii < 10){
			get_by_id("dhcpd_reserve_0" + ii).value = "";
			obj.add_param_arg('dhcpd_reserve_0'+ii, '');
		}else{
			get_by_id("dhcpd_reserve_" + ii).value = "";
			obj.add_param_arg('dhcpd_reserve_'+ii, '');
		}
	}
	
	var form = get_by_id("form1");
	form.elements["html_response_message"].value = get_words('sc_intro_sv') + "<count_down>" + get_words('rb_change');
	
	dhcp_apply();

}
function delete_sel_reserved(){
	
	if($('[name=del_select]:checked').length==0)
	{
		//alert(get_words('_lan_dr'));
		alert('no select');
		return;
	}
	for(var ii = 0; ii < rule_max_num; ii++){
		if (ii < 10){
			get_by_id("dhcpd_reserve_0" + ii).value = "";
			obj.add_param_arg('dhcpd_reserve_0'+ii, '');
		}else{
			get_by_id("dhcpd_reserve_" + ii).value = "";
			obj.add_param_arg('dhcpd_reserve_'+ii, '');
		}
	}
	
	//if(confirm(get_words('YM25') + " " + DataArray[idx].IP)){
		var j = 0;
		for(var i=1;i<ListArray.length;i++){
				if(!ListArray[i].del){
					var dat = ListArray[i].enable +"/"+ ListArray[i].name +"/"+ ListArray[i].ip +"/"+ ListArray[i].mac;			
					if(ListArray[i].enable){
						is_enable = "1";
					}else{
						is_enable = "0";
					}
					dat = is_enable +"/"+ ListArray[i].name +"/"+ ListArray[i].ip +"/"+ ListArray[i].mac;		
										
					if (parseInt(j) < 10){
						get_by_id("dhcpd_reserve_0" + (j).toString()).value = dat;
						obj.add_param_arg('dhcpd_reserve_0'+j.toString(), dat);
					}else{
						get_by_id("dhcpd_reserve_" + (j)).value = dat;
						obj.add_param_arg('dhcpd_reserve_'+j.toString(), dat);
					}
					j++;
				}
			}
			
		var form = get_by_id("form1");
		form.elements["html_response_message"].value = get_words('sc_intro_sv') + "<count_down>" + get_words('rb_change');

		dhcp_apply();			
	/*
	
	for(var i=1;i<ListArray.length;i++){
		if(!ListArray[i].del){
			//alert(ListArray[i].mac);
			obj.add_param_arg('reserveDHCP_Enable_','1.1.'+counter+'.0',(ListArray[i].enable?"1":"0"));
			obj.add_param_arg('reserveDHCP_HostName_','1.1.'+counter+'.0',ListArray[i].name);
			obj.add_param_arg('reserveDHCP_Yiaddr_','1.1.'+counter+'.0',ListArray[i].ip);
			obj.add_param_arg('reserveDHCP_Chaddr_','1.1.'+counter+'.0',ListArray[i].mac);
			counter++;
		}
	}
	*/
}
function reset_reserved(){
	$('input[name=del_select]').attr('checked', false);
setTimeout('window.location.reload()', 500);
}
function change_re_del(idx){
	ListArray[idx].del = $('#select'+idx).attr('checked');
}

function edit_list(idx){
	idx = idx;
	$('#addDHCPReserveField').show();
	var obj = ListArray[idx];
	$('#ruleID').val(idx);
	$('#ruleEnable').attr('checked', obj.enable);
	$('#ruleName').val(obj.name);
	$('#ipaddress').val(obj.ip);
	$('#macaddress').val(obj.mac);
}
function CopyMyPCsMAC(){
	//$('#'+id).val(cli_mac);
	get_by_id("reserved_mac").value = get_by_id("mac_clone_addr").value;
}
/**
 * auto change dhcp range on router ip changed.
 */
function check_dhcp_range()
{
	var lan_ip = $('#lanIp').val().split(".");
	var start_ip3 = $('#dhcpStart').val().split(".");
	var end_ip3 = $('#dhcpEnd').val().split(".");
	var enrty_IP = lan_ip[2];
	$('#dhcpStart').val(lan_ip[0] +"."+lan_ip[1]+"." + enrty_IP +"." + start_ip3[3]);
	$('#dhcpEnd').val(lan_ip[0] +"."+lan_ip[1]+"." + enrty_IP +"." + end_ip3[3]);
}

function setValueHostname(){
	var val_name = "<!--# echo lan_device_name -->";
	$('#hostname').val(val_name);
}
function setValueIPAddress(){
	var val_ip = "<!--# echo lan_ipaddr -->";
	$('#lanIp').val(val_ip);
}
function setValueSubnetMask(){
	var val_mask = "<!--# echo lan_netmask -->";
	$('#lanNetmask').val(val_mask);
}
function setValueDefaultGateway(){
	//var val_gw = lhostCfg.lanAPGateway;
	//$('#lanGateway').val(val_gw);
}
function setValuePrimaryDNSServer(){
	//var val_dns1 = lhostCfg.lanAPDNS1;
	//$('#lanPriDns').val(val_dns1);
}
function setValueSecondaryDNSServer(){
	//var val_dns2 = lhostCfg.lanAPDNS2;
	//$('#lanSecDns').val(val_dns2);
}
function setValueMACAddress(){
	var val_mac = "<!--# echo lan_mac -->";
	$('#lanMac').html(val_mac);
}
function setValueDHCPServer(){
	var sel_dhcp = "<!--# echo dhcpd_enable -->";
	$('#lanDhcpType').val(sel_dhcp);
}
function setValueDHCPStartIP(){
	var val_min = "<!--# echo dhcpd_start -->";
	$('#dhcpStart').val(val_min);
}
function setValueDHCPEndIP(){
	var val_max = "<!--# echo dhcpd_end -->";
	$('#dhcpEnd').val(val_max);
}
function setValueDHCPLeaseTime(){
	var val_lease_min = "<!--# echo dhcpd_lease_time -->";
	$('#dhcpLease').val(val_lease_min);
}
function setEventDHCPServer(){
	var func = function(){
		var sel_dhcp = $('#lanDhcpType option:selected').val();
			if(sel_dhcp == '0')
			{
				$('#start').hide();
				$('#end').hide();
				$('#lease').hide();
			}
			else
			{
				$('#start').show();
				$('#end').show();
				$('#lease').show();
			}
	};
	func();
	$('#lanDhcpType').change(func);
}

function setValueDHCPRComputerNameSelE(){
	var obj = $('#name_select');
	for(var i=0;i<lanHostInfo.name.length;i++){
		var option = document.createElement("option");
		option.text = lanHostInfo.name[i];
		option.value = i+1;
		obj.append(option);
	}
}

function setValueDHCPReservationsList(){
	var index = 0;
	for (var i = 0; i < rule_max_num; i++){
		var temp_dhcp;
		var k = i;
		if(parseInt(i) < 10){
			k = "0" + i;
		}
		temp_dhcp = (get_by_id("dhcpd_reserve_" + k).value).split("/");
		if (temp_dhcp.length > 1){
			if(temp_dhcp[1].length > 0){
				DataArray[index] = new Data(temp_dhcp[0],temp_dhcp[1], temp_dhcp[2], temp_dhcp[3], index);
				index++;
			}
		}
	}
	
	var reserveCnt = DataArray.length;
	
	
	for(var i=0;i<reserveCnt;i++){
		var obj = new ReservationsObj(
			(DataArray[i].Enable=="1"?true:false),
			DataArray[i].CName,
			DataArray[i].IP,
			DataArray[i].MAC
		);
		obj.no = i+1;
		ListArray.push(obj);
		
	var list = '<tr name="re_list">\
<td class="CELL" align="left" style="word-break : break-all;"> '+(i+1)+'&nbsp; <input type="checkbox" id="delRule'+i+'" name="delRule'+i+'" disabled="disabled" '+(obj.enable?'checked="checked"':"")+' /> </td>\
<td id="ruleName'+i+'" class="CELL" align="center" style="word-break : break-all;">'+obj.name+'</td>\
<td id="ipaddress'+i+'" class="CELL" align="center" style="word-break : break-all;">'+obj.ip+'</td>\
<td id="macaddress'+i+'" class="CELL" align="center" style="word-break : break-all;">'+obj.mac+'</td>\
<td align="center" class="CELL"><a href="javascript:edit_list('+(i+1)+');"><img src="edit.gif" /></a></td>\
<td align="center" class="CELL"><input type="checkbox" id="select'+(i+1)+'" name="del_select" onchange="change_re_del('+(i+1)+');" /></td>\
</tr>';
	$('#ListTable').append(list);
	}
}

function set_reserved(){
	var idx = parseInt(get_by_id("reserved_list").selectedIndex);
	
	if (typeof (DHCPL_DataArray[idx - 1]) !== "undefined") {
		get_by_id("reserved_enable").checked = true;
		get_by_id("reserved_name").value = DHCPL_DataArray[idx - 1].Name;
		get_by_id("reserved_ip").value = DHCPL_DataArray[idx - 1].IP;
		get_by_id("reserved_mac").value = DHCPL_DataArray[idx - 1].MAC;
	}
	get_by_id("reserved_list").selectedIndex = "0";
}


$(function(){
	//LAN Interface Setting
	set_lan_dhcp_list();
	setValueHostname();
	setValueIPAddress();
	setValueSubnetMask();
	//setValueDefaultGateway();
	//setValuePrimaryDNSServer();
	//setValueSecondaryDNSServer();
	setValueMACAddress();
	
//	setEventIPAddress();

	//DHCP Server Setting
	setValueDHCPServer();
	setEventDHCPServer();
	setValueDHCPStartIP();
	setValueDHCPEndIP();
	setValueDHCPLeaseTime();
	
	//Others Setting
	//$('#other_setting').show();
	//setValue8021DSpanningTree();
	//setValueLLTD();
	//setValueIGMPproxy();
	//setValueUPNP();
	//setValuePPPOErelay();
	//setValueDNSproxy();
	
	//Add DHCP Reservation
	//setValueDHCPRComputerNameSelA();
	//setEventDHCPRComputerNameA();
	//setValueDHCPRComputerNameSelE();
	//setEventDHCPRComputerNameE();
	
	//DHCP Reservations List
	setValueDHCPReservationsList();
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
				<script>document.write(menu.build_structure(1,1,0))</script>
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
							<div class="headerbg" id="lanTitle">
							<script>show_words('_lan_setting_l');</script>
							</div>
							<div class="hr"></div>
							<div class="section_content_border">
							<div class="header_desc" id="lanIntroduction">
								<script>show_words('_LAN_DESC');</script>
								<p></p>
							</div>

       		<form id="form1" name="form1" method="post" action="apply.cgi">
						<input type="hidden" id="dhcp_list" name="dhcp_list" value="<!--# exec cgi /bin/cmo_get_list dhcpd_leased_table -->">
					   <input type="hidden" id="html_response_page" name="html_response_page" value="count_down.asp">
					   <input type="hidden" id="html_response_message" name="html_response_message" value=""><script>get_by_id("html_response_message").value = get_words('sc_intro_sv');</script>
					   <input type="hidden" id="html_response_return_page" name="html_response_return_page" value="internet_lan.asp">
					   <input type="hidden" id="action" name="action" value="lan">
			       <input type="hidden" id="reboot_type" name="reboot_type" value="lan">
			       <input type="hidden" id="del" name="del" value="-1">
					   <input type="hidden" id="edit" name="edit" value="-1">
					   <input type="hidden" id="max_row" name="max_row" value="-1">
					   <input type="hidden" id="opendns_enable" name="opendns_enable" value="<!--# echo opendns_enable -->">
					   <input type="hidden" id="mac_clone_addr" name="mac_clone_addr" value="<!--# exec cgi /bin/clone mac_clone_addr -->">
					   <input type="hidden" id="dhcpd_reserve_00" name="dhcpd_reserve_00" value="<!--# echo dhcpd_reserve_00 -->">				
					   <input type="hidden" id="dhcpd_reserve_01" name="dhcpd_reserve_01" value="<!--# echo dhcpd_reserve_01 -->">
					   <input type="hidden" id="dhcpd_reserve_02" name="dhcpd_reserve_02" value="<!--# echo dhcpd_reserve_02 -->">		
					   <input type="hidden" id="dhcpd_reserve_03" name="dhcpd_reserve_03" value="<!--# echo dhcpd_reserve_03 -->">				
					   <input type="hidden" id="dhcpd_reserve_04" name="dhcpd_reserve_04" value="<!--# echo dhcpd_reserve_04 -->">
					   <input type="hidden" id="dhcpd_reserve_05" name="dhcpd_reserve_05" value="<!--# echo dhcpd_reserve_05 -->">
					   <input type="hidden" id="dhcpd_reserve_06" name="dhcpd_reserve_06" value="<!--# echo dhcpd_reserve_06 -->">				
					   <input type="hidden" id="dhcpd_reserve_07" name="dhcpd_reserve_07" value="<!--# echo dhcpd_reserve_07 -->">
					   <input type="hidden" id="dhcpd_reserve_08" name="dhcpd_reserve_08" value="<!--# echo dhcpd_reserve_08 -->">	
					   <input type="hidden" id="dhcpd_reserve_09" name="dhcpd_reserve_09" value="<!--# echo dhcpd_reserve_09 -->">
					   <input type="hidden" id="dhcpd_reserve_10" name="dhcpd_reserve_10" value="<!--# echo dhcpd_reserve_10 -->">				
					   <input type="hidden" id="dhcpd_reserve_11" name="dhcpd_reserve_11" value="<!--# echo dhcpd_reserve_11 -->">
					   <input type="hidden" id="dhcpd_reserve_12" name="dhcpd_reserve_12" value="<!--# echo dhcpd_reserve_12 -->">		
					   <input type="hidden" id="dhcpd_reserve_13" name="dhcpd_reserve_13" value="<!--# echo dhcpd_reserve_13 -->">				
					   <input type="hidden" id="dhcpd_reserve_14" name="dhcpd_reserve_14" value="<!--# echo dhcpd_reserve_14 -->">
					   <input type="hidden" id="dhcpd_reserve_15" name="dhcpd_reserve_15" value="<!--# echo dhcpd_reserve_15 -->">
					   <input type="hidden" id="dhcpd_reserve_16" name="dhcpd_reserve_16" value="<!--# echo dhcpd_reserve_16 -->">				
					   <input type="hidden" id="dhcpd_reserve_17" name="dhcpd_reserve_17" value="<!--# echo dhcpd_reserve_17 -->">
					   <input type="hidden" id="dhcpd_reserve_18" name="dhcpd_reserve_18" value="<!--# echo dhcpd_reserve_18 -->">	
					   <input type="hidden" id="dhcpd_reserve_19" name="dhcpd_reserve_19" value="<!--# echo dhcpd_reserve_19 -->">
					   <input type="hidden" id="dhcpd_reserve_20" name="dhcpd_reserve_20" value="<!--# echo dhcpd_reserve_20 -->">
					   <input type="hidden" id="dhcpd_reserve_21" name="dhcpd_reserve_21" value="<!--# echo dhcpd_reserve_21 -->">				
					   <input type="hidden" id="dhcpd_reserve_22" name="dhcpd_reserve_22" value="<!--# echo dhcpd_reserve_22 -->">
					   <input type="hidden" id="dhcpd_reserve_23" name="dhcpd_reserve_23" value="<!--# echo dhcpd_reserve_23 -->">	
					   <input type="hidden" id="dhcpd_reserve_24" name="dhcpd_reserve_24" value="<!--# echo dhcpd_reserve_24 -->">	
					   <input type="hidden" id="wan_current_ipaddr" name="wan_current_ipaddr" value="<!--# echo wan_current_ipaddr_00 -->">
					   <input type="hidden" id="dhcp_list" name="dhcp_list" value="<!--# exec cgi /bin/cmo_get_list dhcpd_leased_table -->">
					   <input type="hidden" id="multi_ssid_lan1" name="multi_ssid_lan1" value="<!--# echo multi_ssid_lan1 -->">
					   <input type="hidden" id="multi_ssid_lan2" name="multi_ssid_lan2" value="<!--# echo multi_ssid_lan2 -->">
					   <input type="hidden" id="multi_ssid_lan3" name="multi_ssid_lan3" value="<!--# echo multi_ssid_lan3 -->">
					   <input type="hidden" id="gzone_ipaddr" name="gzone_ipaddr" value="<!--# echo gzone_ipaddr -->">
					   <input type="hidden" id="gzone_netmask" name="gzone_netmask" value="<!--# echo gzone_netmask -->">
					   <input type="hidden" id="change_lan_ip" name="change_lan_ip" value="<!--# echo change_lan_ip -->">				
					   <input type="hidden" id="dhcpd_enable" name="dhcpd_enable" value="<!--# echo dhcpd_enable -->">			
					   <input type="hidden" id="lan_ipaddr" name="lan_ipaddr" value="<!--# echo lan_ipaddr -->">			
					   <input type="hidden" id="lan_netmask" name="lan_netmask" value="<!--# echo lan_netmask -->">			
					   <input type="hidden" id="dhcpd_start" name="dhcpd_start" value="<!--# echo dhcpd_start -->">			
					   <input type="hidden" id="dhcpd_end" name="dhcpd_end" value="<!--# echo dhcpd_end -->">			
					   <input type="hidden" id="dhcpd_lease_time" name="dhcpd_lease_time" value="<!--# echo dhcpd_lease_time -->">			

						<div class="box_tn">
							<div class="CT"><script>show_words('_help_txt39');</script></div>
							<table cellspacing="0" cellpadding="0" class="formarea">
							<tr style="display:none">
								<td class="CL" id="lHostname"><script>show_words('LS424');</script></td>
								<td class="CR"><input id="hostname" name="hostname" maxlength="16" value="" /></td>
							</tr>
							<tr>
								<td class="CL" id="lIp"><script>show_words('_ipaddr');</script></td>
								<td class="CR"><input id="lanIp" name="lanIp" maxlength="15" value="" onchange="check_dhcp_range();" /></td>
							</tr>
							<tr>
								<td class="CL" id="lNetmask"><script>show_words('_subnet');</script></td>
								<td class="CR"><input id="lanNetmask" name="lanNetmask" maxlength="15" value="" onChange="change(document.lanCfg.dhcpMask,this.value)" /></td>
							</tr>
							<tr id="brGateway" style="display:none;">
								<td class="CL" id="lGateway"><script>show_words('_defgw');</script></td>
								<td class="CR"><input id="lanGateway" name="lanGateway" maxlength="15" value="" /></td>
							</tr>
							<tr id="brPriDns" style="display:none;">
								<td class="CL" id="lPriDns"><script>show_words('_dns1');</script></td>
								<td class="CR"><input id="lanPriDns" name="lanPriDns" maxlength="15" value="" /></td>
							</tr>
							<tr id="brSecDns" style="display:none;">
								<td class="CL" id="lSecDns"><script>show_words('_dns2');</script></td>
								<td class="CR"><input id="lanSecDns" name="lanSecDns" maxlength="15" value="" /></td>
							</tr>
							<tr>
								<td class="CL" id="lMac"><script>show_words('_macaddr');</script></td>
								<td class="CR" id="lanMac"></td>
							</tr>
							</table>
						</div>
						
						<div class="box_tn">
							<div class="CT"><script>show_words('_dhcp_server_setting');</script></div>
							<table cellspacing="0" cellpadding="0" class="formarea">
							<tr>
								<td class="CL"><script>show_words('_dhcpsrv');</script></td>
								<td class="CR">
								<select id="lanDhcpType" name="lanDhcpType" size="1">
									<option value="0"><script>show_words('_disable');</script></option>
									<option value="1"><script>show_words('_enable');</script></option>
								</select>
								</td>
							</tr>
							<tr id="start" style="visibility: visible; display: table-row;">
								<td class="CL" id="lDhcpStart"><script>show_words('_dhcp_start_ip');</script></td>
								<td class="CR"><input id="dhcpStart" name="dhcpStart" maxlength="18" value="" /></td>
							</tr>
							<tr id="end" style="visibility: visible; display: table-row;">
								<td class="CL" id="lDhcpEnd"><script>show_words('_dhcp_end_ip');</script></td>
								<td class="CR"><input id="dhcpEnd" name="dhcpEnd" maxlength="18" value="" /></td>
							</tr>
							<!--<tr id="mask">
								<td class="CL" id="lDhcpNetmask" align="right">DHCP Subnet Mask</td>
								<td class="CR"><input name="dhcpMask" maxlength="15" value="255.255.255.0" onchange="change(document.lanCfg.lanNetmask,this.value)" /></td>
							</tr>
							<tr id="pridns">
								<td class="CL" id="lDhcpPriDns" align="right">DHCP Primary DNS</td>
								<td class="CR"><input name="dhcpPriDns" maxlength="15" value="" /></td>
							</tr>
							<tr id="secdns">
								<td class="CL" id="lDhcpSecDns" align="right">DHCP Secondary DNS</td>
								<td class="CR"><input name="dhcpSecDns" maxlength="15" value="" /></td>
							</tr>
							<tr id="gateway">
								<td class="CL" id="lDhcpGateway" align="right">DHCP Default Gateway</td>
								<td class="CR"><input name="dhcpGateway" maxlength="15" value="192.168.20.1" onchange="changeSubnet(this.value);change(document.lanCfg.lanIp,this.value)" /></td>
							</tr>-->
							<tr id="lease" style="visibility: visible; display: table-row;">
								<td class="CL" id="lDhcpLease"><script>show_words('bd_DLT');</script></td>
								<td class="CR"><input id="dhcpLease" name="dhcpLease" maxlength="8" value="" /> (<script>show_words('_mintues_lower');</script>)
								</td>
							</tr>
							</table>
						</div>
						
						<div id="other_setting" class="box_tn" style="display:none">
							<div class="CT"><script>show_words('_other_setting');</script></div>
							<table cellspacing="0" cellpadding="0" class="formarea">
								<tr id="80211d" style="display:none">
									<td class="CL"><script>show_words('_8021d_spanning_tree');</script></td>
									<td class="CR">
										<select name="stpEnbl" size="1">
											<option value="0"><script>show_words('_disable');</script></option>
											<option value="1"><script>show_words('_enable');</script></option>
										</select>
									</td>
								</tr>
								<tr id="lltd" style="display:none">
									<td class="CL"><script>show_words('_lltd');</script></td>
									<td class="CR">
										<select name="lltdEnbl" size="1">
											<option value="0"><script>show_words('_disable');</script></option>
											<option value="1"><script>show_words('_enable');</script></option>
										</select>
									</td>
								</tr>
								<tr id="igmpProxy" style="display: table-row; visibility: visible;">
									<td class="CL"><script>show_words('_igmp_proxy');</script></td>
									<td class="CR">
										<select name="igmpEnbl" size="1">
											<option value="0"><script>show_words('_disable');</script></option>
											<option value="1"><script>show_words('_enable');</script></option>
										</select>
									</td>
								</tr>
								<tr id="upnp">
									<td class="CL"><script>show_words('ta_upnp');</script></td>
									<td class="CR">
										<select name="upnpEnbl" size="1">
											<option value="0"><script>show_words('_disable');</script></option>
											<option value="1"><script>show_words('_enable');</script></option>
										</select>
									</td>
								</tr>
								<tr id="pppoerelay" style="display:none">
									<td class="CL"><script>show_words('_pppoe_relay');</script></td>
									<td class="CR">
										<select name="pppoeREnbl" size="1">
											<option value="0"><script>show_words('_disable');</script></option>
											<option value="1"><script>show_words('_enable');</script></option>
										</select>
									</td>
								</tr>
								<tr id="dnsproxy" style="display:none">
									<td class="CL"><script>show_words('_dns_proxy');</script></td>
									<td class="CR">
										<select name="dnspEnbl" size="1">
											<option value="0"><script>show_words('_disable');</script></option>
											<option value="1"><script>show_words('_enable');</script></option>
										</select>
									</td>
								</tr>
							</table>
						</div>
						
						<div class="box_tn">
							<table cellspacing="0" cellpadding="0" class="formarea">
								<tr align="center">
								<td colspan="2" class="btn_field">
									<input type="button" class="button_submit" id="dhcp_apply_bt" value="Apply" onclick="dhcp_apply();" />
									<script>$('#dhcp_apply_bt').val(get_words('_apply'));</script>
									<input type="reset" class="button_submit" id="dhcp_cancel" value="Cancel" onclick="window.location.reload()" />
									<script>$('#dhcp_cancel').val(get_words('_cancel'));</script>
								</td>
							</tr>
							</table>
						</div>
						
						<div class="box_tn" id="addDHCPReserveFieldG">
							<div class="CT"><script>show_words('_add_dhcp_reservation');</script></div>
							<table cellspacing="0" cellpadding="0" class="formarea">
								<tr>
									<td class="CL"><script>show_words('_enable');</script></td>
									<td class="CR">
									<input type="checkbox" id="reserved_enable" name="reserved_enable" />
									</td>
								</tr>
								<tr>
									<td class="CL"><script>show_words('bd_CName');</script></td>
									<td class="CR">
										<input type="text" id="reserved_name" name="reserved_name" maxlength="15" value="" />
										<span> &lt;&lt; </span>
										<select name="reserved_list" id="reserved_list" onChange="set_reserved()">
											<option value=-1><script>show_words('_hostname');</script></option>
											<script>
											set_mac_list("name");
											</script>
											
										</select>
									</td>
								</tr>
								<tr>
									<td class="CL"><script>show_words('_ipaddr');</script></td>
									<td class="CR"><input type="text" id="reserved_ip" name="reserved_ip" maxlength="20" value="" /></td>
								</tr>
								<tr>
									<td class="CL"><script>show_words('_macaddr');</script></td>
									<td class="CR"><input type="text" id="reserved_mac" name="reserved_mac" maxlength="17" value="" />&nbsp;&nbsp;(Ex: 00:11:22:33:44:55)</td>
								</tr>
								<tr>
									<td class="CL"><script>show_words('_copy_pc_mac');</script></td>
									<td class="CR"><input type="button" class="button_inbox" id="mac_copyG" name="mac_copyG" value="Copy" onclick="CopyMyPCsMAC('macaddressG')" /> &nbsp; &nbsp;</td>
									<script>$('#mac_copyG').val(get_words('_copy'));</script>
								</tr>
							</table>
							<table cellspacing="0" cellpadding="0" class="formarea">
								<tr align="center">
									<td colspan="2" class="btn_field">
										<input type="button" class="button_submit" id="add_res" value="Add" onclick="add_reserved()" />
										<script>$('#add_res').val(get_words('_add'));</script>
										<input type="reset" class="button_submit" id="clear_res" value="Clear" onclick="window.location.reload()" />
										<script>$('#clear_res').val(get_words('_clear'));</script>
									</td>
								</tr>
							</table>
							<div id="readyreserv" style="display:none"> 
							<div class="CT"><script>show_words('_dhcp_reservation_ready_group');</script></div>
							<table cellspacing="0" cellpadding="0" class="formarea" id="ReadyTable">
								<tr>
									<td class="CTS" style="width:20px;"><script>show_words('_item_no');</script></td>
									<td class="CTS" style="width:40px;"><script>show_words('_enable');</script></td>
									<td class="CTS" style="width:121px;"><script>show_words('bd_CName');</script></td>
									<td class="CTS" style="width:87px;"><script>show_words('_ipaddr');</script></td>
									<td class="CTS" style="width:99px;"><script>show_words('_macaddr');</script></td>
									<td class="CTS" style="width:40px;"><script>show_words('_delete');</script></td>
								</tr>
							</table>
							<table cellspacing="0" cellpadding="0" class="formarea">
								<tr align="center">
									<td colspan="6" class="btn_field">
										<input type="button" class="button_submit" id="btn_ready_apply" value="Apply" onclick="ready_apply()" />
										<script>$('#btn_ready_apply').val(get_words('_apply'));</script>
										<input type="reset" class="button_submit" id="btn_ready_reset" value="Reset" onclick="window.location.reload()" />
										<script>$('#btn_ready_reset').val(get_words('_reset'));</script>
										<input type="button" class="button_submit" id="btn_ready_delete" value="Delete" onclick="delete_ready()" />
										<script>$('#btn_ready_delete').val(get_words('_delete'));</script>
									</td>
								</tr>
							</table>
							</div>
						</div>
						
						<div class="box_tn" id="addDHCPReserveField" style="display:none;">
							<div class="CT"><script>show_words('_edit_dhcp_reservation');</script></div>
							<table cellspacing="0" cellpadding="0" class="formarea">
								<tr>
									<td class="CL"><script>show_words('_enable');</script></td>
									<td class="CR">
										<input type="checkbox" id="ruleEnable" name="ruleEnable" />
									</td>
								</tr>
								<tr>
									<td class="CL"><script>show_words('bd_CName');</script></td>
									<td class="CR"><input type="text" id="ruleName" name="ruleName" maxlength="15" value="" />
									<span> &lt;&lt; </span>
									<select name="select" id="name_select">
										<option value="0"><script>show_words('_hostname');</script></option>
									</select>
									</td>
								</tr>
								<tr>
									<td class="CL"><script>show_words('_ipaddr');</script></td>
									<td class="CR"><input type="text" id="ipaddress" name="ipaddress" maxlength="20" value="" /></td>
								</tr>
								<tr>
									<td class="CL"><script>show_words('_macaddr');</script></td>
									<td class="CR"><input type="text" id="macaddress" name="macaddress" maxlength="17" value="" />&nbsp;&nbsp;(Ex: 00:11:22:33:44:55)</td>
								</tr>
								<tr>
									<td class="CL"><script>show_words('_copy_pc_mac');</script></td>
									<td class="CR"><input type="button" class="button_inbox" id="mac_copy" name="mac_copy" value="Copy" onclick="CopyMyPCsMAC('macaddress')" /> &nbsp; &nbsp;</td>
										<script>$('#mac_copy').val(get_words('_copy'));</script>
								</tr>
								<input type="hidden" id="ruleID" value="" />
							</table>
							<table cellspacing="0" cellpadding="0" class="formarea">
								<tr align="center">
									<td colspan="2" class="btn_field">
										<input type="button" class="button_submit" id="AddEditButton" value="Save" onclick="save_reserved();" />
										<script>$('#AddEditButton').val(get_words('_save'));</script>
										<input type="reset" class="button_submit" id="btn_edit_clear" value="Clear" onclick="window.location.reload()" />
										<script>$('#btn_edit_clear').val(get_words('_clear'));</script>
									</td>
								</tr>
							</table>
						</div>


<div class="box_tn" id="addDHCPReserveList" style="display: block;">
	<div class="CT"><script>show_words('bd_title_list');</script></div>
	<table id="ListTable" cellspacing="0" cellpadding="0" class="formarea">
		<tr align="center">
			<td class="CTS"><script>show_words('_enable');</script></td>
			<td class="CTS"><script>show_words('bd_CName');</script></td>
			<td class="CTS"><script>show_words('_ipaddr');</script></td>
			<td class="CTS"><script>show_words('_macaddr');</script></td>
			<td class="CTS"><script>show_words('_edit');</script></td>
			<td class="CTS"><script>show_words('_delete');</script></td>
		</tr>
	</table>
	<table cellspacing="0" cellpadding="0" class="formarea" id="finaltable">
		<tr align="center">
			<td colspan="6" class="btn_field">
				<input type="button" class="button_submit" value="Delete Selected" id="deleteSelRsvIP" name="deleteSelRsvIP" onclick="delete_sel_reserved()" />
				<script>$('#deleteSelRsvIP').val(get_words('_delete'));</script>
				<input type="button" class="button_submit" value="Delete All" id="deleteAllRsvIP" name="deleteAllRsvIP" onclick="deleteAll_reserved();" />
				<script>$('#deleteAllRsvIP').val(get_words('_delete_all'));</script>
				<input type="reset" class="button_submit" value="Reset" id="reset" name="reset" onclick="reset_reserved();" />
				<script>$('#reset').val(get_words('_reset'));</script>
			</td>
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
