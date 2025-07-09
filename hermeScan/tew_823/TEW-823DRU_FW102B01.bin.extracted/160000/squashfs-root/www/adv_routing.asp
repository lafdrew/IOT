<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html lang="en-US" xmlns="http://www.w3.org/1999/xhtml" xml:lang="en-US">
<head>
<title>TRENDNET | modelName | Advanced | Routing</title>
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
	var menu = new menuObject();

var submit_button_flag = 0;
var DataArray = new Array();
var TotalCnt=0;
var dDat = new Array();
var rDat = new Array();
var resert_rule = 0;
var DataArray = new Array();
var DataArray2 = new Array();
var DataArray_Sort = new Array();
var rule_max_num = 40;
var array_proto_name = new Array('LAN','WAN','WAN('+get_words('_physical_port')+')');

	function Data(enable, name, ip_addr, net_mask, gateway, _interface, metric, show_creator, show_type, onList)
	{
		this.Enable = enable;
		this.Name = name;
		this.Ip_addr = ip_addr;
		this.Net_mask = net_mask;
		this.Gateway = gateway;
		this.Interface = _interface;
		this.Metric = metric;
		this.Type = change_type(show_type);
		this.Creator = change_creator(show_creator);
		this.OnList = onList ;
	}	

	function onPageLoad()
	{
		var login_who= checksessionStorage();
		if(login_who== "user"){
			DisableEnableForm(document.form1,true);
		}	 

		//routingTable_list();
		setValueEnableRIP();
		setEventEnableRIP();
		setValueRIPmode();
		setEventRIPmode();
		setValueRIPv2Password();
		set_form_default_values("form1");
	}

function mapIface(idx)
{
	switch (idx) {
	case '1':
		return 'LAN';
	case '2':
		return 'Local Loopback';
	default:
		return 'WAN';
	}
}

function metric_sort(){
	// sorting ascending first
	var i=0,j=0;
	DataArray_tmp = new Data(0,0, 0, 0, 0, 0,0, 0, 0, 1);
	for (i=0; i<DataArray.length;i++){
		for(j=0; j < DataArray.length-1 ; j++){
			if(DataArray[j].Metric > DataArray[j+1].Metric){
				DataArray_tmp.Ip_addr = DataArray[j].Ip_addr;
				DataArray_tmp.Net_mask = DataArray[j].Net_mask;
				DataArray_tmp.Gateway = DataArray[j].Gateway;
				DataArray_tmp.Metric = DataArray[j].Metric;
				DataArray_tmp.Interface = DataArray[j].Interface;
				DataArray_tmp.Type = DataArray[j].Type;
				DataArray_tmp.Creator = DataArray[j].Creator;
				
				DataArray[j].Ip_addr = DataArray[j+1].Ip_addr;
				DataArray[j].Net_mask = DataArray[j+1].Net_mask;
				DataArray[j].Gateway = DataArray[j+1].Gateway;
				DataArray[j].Metric = DataArray[j+1].Metric;
				DataArray[j].Interface = DataArray[j+1].Interface;
				DataArray[j].Type = DataArray[j+1].Type;
				DataArray[j].Creator = DataArray[j+1].Creator;
				
				DataArray[j+1].Ip_addr = DataArray_tmp.Ip_addr;
				DataArray[j+1].Net_mask = DataArray_tmp.Net_mask;
				DataArray[j+1].Gateway = DataArray_tmp.Gateway;
				DataArray[j+1].Metric = DataArray_tmp.Metric;
				DataArray[j+1].Interface = DataArray_tmp.Interface;
				DataArray[j+1].Type = DataArray_tmp.Type;
				DataArray[j+1].Creator = DataArray_tmp.Creator;
			}
		}
	}
}

function data_sort(){
	//sorting group
	var j = DataArray_Sort.length;
	// Grouping Type = INTERNET, Creator = System, 
	for (var i=0; i<DataArray.length;i++){
		if((DataArray[i].Type == get_words('sa_Internet')) && (DataArray[i].Creator == get_words('_system'))){
			DataArray_Sort[j] = new Data(0,0, 0, 0, 0, 0,0, 0, 0, 1);
			DataArray_Sort[j].Ip_addr = DataArray[i].Ip_addr;
			DataArray_Sort[j].Net_mask = DataArray[i].Net_mask;
			DataArray_Sort[j].Gateway = DataArray[i].Gateway;
			DataArray_Sort[j].Metric = DataArray[i].Metric;
			DataArray_Sort[j].Interface = DataArray[i].Interface;
			DataArray_Sort[j].Type = DataArray[i].Type;
			DataArray_Sort[j].Creator = DataArray[i].Creator;
			j++;
		}
	}
	// Grouping Type = DHCP Option, Creator = System, 
	for (var i=0; i<DataArray.length;i++){
		if((DataArray[i].Type == get_words('_dhcpop')) && (DataArray[i].Creator == get_words('_system'))){
			DataArray_Sort[j] = new Data(0,0, 0, 0, 0, 0,0, 0, 0, 1);
			DataArray_Sort[j].Ip_addr = DataArray[i].Ip_addr;
			DataArray_Sort[j].Net_mask = DataArray[i].Net_mask;
			DataArray_Sort[j].Gateway = DataArray[i].Gateway;
			DataArray_Sort[j].Metric = DataArray[i].Metric;
			DataArray_Sort[j].Interface = DataArray[i].Interface;
			DataArray_Sort[j].Type = DataArray[i].Type;
			DataArray_Sort[j].Creator = DataArray[i].Creator;
			j++;
		}
	}
	// Grouping Type = INTRANET, Creator = System, 
	for (var i=0; i<DataArray.length;i++){
		if((DataArray[i].Type == get_words('sa_Internal')) && (DataArray[i].Creator == get_words('_system'))){
			DataArray_Sort[j] = new Data(0,0, 0, 0, 0, 0,0, 0, 0, 1);
			DataArray_Sort[j].Ip_addr = DataArray[i].Ip_addr;
			DataArray_Sort[j].Net_mask = DataArray[i].Net_mask;
			DataArray_Sort[j].Gateway = DataArray[i].Gateway;
			DataArray_Sort[j].Metric = DataArray[i].Metric;
			DataArray_Sort[j].Interface = DataArray[i].Interface;
			DataArray_Sort[j].Type = DataArray[i].Type;
			DataArray_Sort[j].Creator = DataArray[i].Creator;
			j++;
		}
	}
	// Grouping Type = LOCAL, Creator = System, 
	for (var i=0; i<DataArray.length;i++){
		if((DataArray[i].Type == get_words('_local')) && (DataArray[i].Creator == get_words('_system'))){
			DataArray_Sort[j] = new Data(0,0, 0, 0, 0, 0,0, 0, 0, 1);
			DataArray_Sort[j].Ip_addr = DataArray[i].Ip_addr;
			DataArray_Sort[j].Net_mask = DataArray[i].Net_mask;
			DataArray_Sort[j].Gateway = DataArray[i].Gateway;
			DataArray_Sort[j].Metric = DataArray[i].Metric;
			DataArray_Sort[j].Interface = DataArray[i].Interface;
			DataArray_Sort[j].Type = DataArray[i].Type;
			DataArray_Sort[j].Creator = DataArray[i].Creator;
			j++;
		}
	}
	// Grouping Type = STATIC, Creator = ADMIN, 
	for (var i=0; i<DataArray.length;i++){
		if((DataArray[i].Type == get_words('_static')) && (DataArray[i].Creator == get_words('_admin'))){
			DataArray_Sort[j] = new Data(0,0, 0, 0, 0, 0,0, 0, 0, 1);
			DataArray_Sort[j].Ip_addr = DataArray[i].Ip_addr;
			DataArray_Sort[j].Net_mask = DataArray[i].Net_mask;
			DataArray_Sort[j].Gateway = DataArray[i].Gateway;
			DataArray_Sort[j].Metric = DataArray[i].Metric;
			DataArray_Sort[j].Interface = DataArray[i].Interface;
			DataArray_Sort[j].Type = DataArray[i].Type;
			DataArray_Sort[j].Creator = DataArray[i].Creator;
			j++;
		}
	}
	
	DataArray_Sort.length = j;
}

function set_routes(){
	var index = 1;
	for (var i=0;i<rule_max_num;i++){
		var temp_st;
		var k=i;
		if(parseInt(i,10)<10){
			k="0"+i;
		}
		temp_st = (get_by_id("static_routing_" + k).value).split("/");
		if (temp_st.length > 1){
			if(temp_st[1] != "" && temp_st[0] != "0"){ //only show enabled static routing rules
				DataArray[DataArray.length++] = new Data(temp_st[0],temp_st[1], temp_st[2], temp_st[3], temp_st[4], temp_st[5], temp_st[6], 1, 2, index);
				index++;
			}
		}
	}
	
	var myData = get_by_id("routing_table").value.split(",");
	var temp_data;
	for (var i=0 ; i<myData.length;i++){
		temp_data = myData[i].split("/");
		if(temp_data.length > 1){				
			var is_not_check= true;
			for(var j=0;j<DataArray.length;j++){
				if(temp_data[0] == DataArray[j].Ip_addr && temp_data[1] == DataArray[j].Net_mask && temp_data[2] == DataArray[j].Gateway){
					is_not_check = false;
					break;
				}
			}
			if(is_not_check){
				DataArray[DataArray.length++] = new Data(0, i , temp_data[0], temp_data[1], temp_data[2], temp_data[3], temp_data[4], temp_data[5], temp_data[6], index);
				index++;
			}
		}	
			
	}
}	


function routingTable_list()
{
	set_routes();
	metric_sort();
	data_sort();
	for (var i=0; i<DataArray_Sort.length-1;i++){
		var iface = "";
		if (DataArray_Sort[i].Interface === "<!--# echo wan_eth -->" || DataArray_Sort[i].Interface.match("ppp")) {
			iface = "WAN";
		} else {
			iface = DataArray_Sort[i].Interface;
		}
		document.write("<tr align=\"center\">");
		document.write("<td class=\"CELL\"><font face=\"Arial\" size=\"2\">"+ DataArray_Sort[i].Ip_addr +"</font></td>");
		document.write("<td class=\"CELL\"><font face=\"Arial\" size=\"2\">"+ DataArray_Sort[i].Net_mask +"</font></td>");
		document.write("<td class=\"CELL\"><font face=\"Arial\" size=\"2\">"+ DataArray_Sort[i].Gateway +"</font></td>");
		document.write("<td class=\"CELL\"><font face=\"Arial\" size=\"2\">"+ DataArray_Sort[i].Metric +"</font></td>");
		document.write("<td class=\"CELL\"><font face=\"Arial\" size=\"2\">"+ change_inter(iface) +"</font></td>");
		document.write("</tr>\n");
	}
}

	
	function change_inter(obj_value){
		var return_word = obj_value;
		if(obj_value == "br0" || obj_value == "<!--# echo gzone_bridge -->") {
			return_word = get_words('_LAN');
		}else if((obj_value == "eth1.2")|| (obj_value == "WAN")){
			return_word = get_words('WAN');
		}else if(obj_value == "lo"){
			return_word = get_words('_locakloopback');
		}
		return return_word;
	}

	function change_creator(obj_value){
		var return_word = obj_value;
		if(obj_value == "0"){
			return_word = get_words('_system');
		}else if(obj_value == "1"){
			return_word = get_words('_admin');
		}
		return return_word;
	}

	function change_type(obj_value){
		var return_word = obj_value;
		if(obj_value == "0"){
			return_word = get_words('sa_Internet');
		}else if(obj_value == "1"){
			return_word = get_words('_dhcpop');
		}else if(obj_value == "2"){
			return_word = get_words('_static');
		}else if(obj_value == "3"){
			return_word = get_words('sa_Internal');
		}else if(obj_value == "4"){
			return_word = get_words('_local');
		}
		return return_word;
	}

	function set_route()
	{
		var index = 0;
		for (var i = 0; i < rule_max_num; i++) {
			if (i< 10){
				var temp_rule = get_by_id("static_routing_0" + i).value;
			}else{
				var temp_rule = get_by_id("static_routing_" + i).value;
			}
			var rule = temp_rule.split("/");
			if(rule[0]=="1")
			{
				TotalCnt++;
				DataArray2[DataArray2.length++] = new Data("1", rule[1], rule[2], rule[3], rule[4], rule[5], rule[6], i);
			}
		}
		$('#max_row').val(TotalCnt);
	}
	
	function deleteRedundentDatamodel()
	{
		var delCnt = 0;
		var idx = TotalCnt;
		if(TotalCnt > DataArray.length)
			delCnt = TotalCnt - DataArray.length;

		if(delCnt == 0)
			return;

		var obj = new ccpObject();
		obj.set_param_url('get_set.ccp');
		obj.set_ccp_act('del');
		obj.add_param_event('CCP_SUB_WEBPAGE_APPLY');

		while(delCnt > 0)
		{
			obj.add_param_arg('IGD_Layer3Forwarding_Forwarding_i_','1.1.'+idx+'.0');
			delCnt --;
			idx --;
		}

		obj.ajax_submit();
	}


	function update_DataArray(){
		var index = parseInt(get_by_id("edit").value);
		var insert = false;

		if(index == "-1"){      //save
			if(DataArray2.length == rule_max_num){
				alert(get_words('TEXT015'));
			}else{
				index = DataArray2.length;
				$('#max_row').val(index);
				insert = true;
			}
		}

		if(insert){
			DataArray2[index] = new Data("1", $('#name').val(), $('#Destination').val(), $('#Sub_Mask').val(), $('#Sub_gateway').val(), $('#interface').val(), $('#metric').val(), index+1);			
		}else if (index != -1){			
			DataArray2[index].Enable = "1";
			DataArray2[index].Name = index;
			DataArray2[index].Ip_addr = $('#Destination').val();
			DataArray2[index].Net_mask = $('#Sub_Mask').val();
			DataArray2[index].Gateway = $('#Sub_gateway').val();
			DataArray2[index].Interface = $('#interface').val();
			DataArray2[index].Metric = $('#metric').val();
			DataArray2[index].OnList = index;
		}
	}


	function clear_reserved(){
		
		$("input[name=sel_del]").each(function () { this.checked = false; });
		$('#name').val("");
		$('#Destination').val("0.0.0.0");
		$('#Sub_Mask').val("0.0.0.0");
		$('#Sub_gateway').val("0.0.0.0");
		$('#interface').val(1);
		$('#metric').val("1");
		$('#edit').val(-1);
		get_by_id("add").disabled = false;
	}


	function my_chk_addr(addrObj, maskObj)
	{
		var mask = new Array(255,255,255,0);
		if (addrObj == null || addrObj.addr.length != 4) {
			alert(addrObj.e_msg[INVALID_IP]);
			return false;
		}
		
		if((addrObj.addr[0] == "127") || ((addrObj.addr[0] >= 224) && (addrObj.addr[0] <= 239))){
			alert(addrObj.e_msg[MULTICASE_IP_ERROR]);
			return false;
		}
		
		// check the ip is "0.0.0.0"
		if (!addrObj.allow_zero && addrObj.addr[0] == '0' && addrObj.addr[1] == '0' && addrObj.addr[2] == '0' && addrObj.addr[3] == '0') {
			alert(addrObj.e_msg[ZERO_IP]);
			return false;
		}
		
		if (maskObj != null){
			mask = maskObj.addr;
		}
					
		var ip = addrObj.addr;
		var count_zero = 0;
		var count_bcast = 0;
		for (var i = 0; i < 4; i++){	// check the IP address is a network address or a broadcast address																							
			if (((~mask[i] + 256) & ip[i]) == 0){	// (~mask[i] + 256) = reverse mask[i]
				count_zero++;						
			}
			
			if ((mask[i] | ip[i]) == 255){
				count_bcast++;
			}							
		}
	
		if ((count_zero == 4 && !addrObj.is_network) || (count_bcast == 4)){
			alert(addrObj.e_msg[INVALID_IP]);
			return false;
		}
		return true;
	}

	//20130111 Silvia add, chk Dest ip is the same with subnet or not
	function check_subnet(ip_obj,mask_obj)
	{
		var tmp_ip = ip_obj.split(".");
		var tmp_mask = mask_obj.split(".");
		var tmp_subnet;
		var array_range = new Array(ip_obj.length);

		for (var i = 0; i < tmp_ip.length; i++)
		{
			array_range[i] = tmp_ip[i].toString(2) & tmp_mask[i].toString(2);
		}

		tmp_subnet = array_range[0]+"."+array_range[1]+"."+array_range[2]+"."+array_range[3];
		if (ip_obj != tmp_subnet)
		{
			alert(addstr(get_words('GW_ROUTES_DESTINATION_IP_ADDRESS_INVALID'),ip_obj));
			return false;
		}
		return true;
	}
	
	function send_request()
	{
		if (!is_form_modified("form1") && !confirm(get_words('_ask_nochange'))) {
			return false;
		}
		var count = 0;
		for (var i = 0; i < rule_max_num; i++) {

			if (get_by_id("Destination").value == "" )
					get_by_id("Destination").value="0.0.0.0";
			if (get_by_id("Sub_Mask").value == "" )
					get_by_id("Sub_Mask").value="0.0.0.0";
			if (get_by_id("Sub_gateway").value == "")
					get_by_id("Sub_gateway").value="0.0.0.0";

					var static_ip = get_by_id("Destination").value;
					var static_mask = get_by_id("Sub_Mask").value;
					var static_gateway = get_by_id("Sub_gateway").value;
					var metric = get_by_id("metric").value;
    			
					var ip_addr_msg = replace_msg(all_ip_addr_msg,get_words('help256'));
					var gateway_msg = replace_msg(all_ip_addr_msg,get_words('wwa_gw'));

					var static_ip_obj = new addr_obj(static_ip.split("."), ip_addr_msg, false, true);
					var static_mask_obj = new addr_obj(static_mask.split("."), subnet_mask_msg, false, false);
					var static_gateway_obj = new addr_obj(static_gateway.split("."), gateway_msg, false, true);
					var temp_metric = new varible_obj(metric, metric_msg, 1, 16, false);
					$('#name').val($('#max_row').val());
					var check_name = get_by_id("name").value;
				
					if (!check_route_address(static_ip_obj))
						return false;
					if(!check_route_mask(static_mask_obj))
						return false;

					if (!check_address(static_gateway_obj))
						return false;	// when gateway is invalid
					if (!check_varible(temp_metric))
						return false;
					if (!check_subnet(static_ip,static_mask))
						return false;

					if(trim_string(get_by_id("name").value) == ""){
						alert(get_words('aa_alert_9'));
						return false;
					}else {
						if(Find_word(check_name,"'") || Find_word(check_name,'"') || Find_word(check_name,"/"))
						{				
							alert(get_words('TEXT003').replace("+ i +","'" + check_name + "'"));
							return false;
						}
					
					for (jj=0; jj<DataArray2.length; jj++) {
					if($('#edit').val()!=jj){
						if (get_by_id("Destination").value != "0.0.0.0") {
							if ((DataArray2[jj].Ip_addr == static_ip) && (DataArray2[jj].Interface == get_by_id("interface").value)) {
								alert(get_words('_r_alert_new1')+", '"+ get_by_id("name").value + "'" + get_words('help264') +" '" + DataArray2[jj].Name + "'." );
								return false;
							}
						}
							    /*if(get_by_id("name").value == DataArray2[jj].Name){
							        alert(addstr(get_words('av_alert_16'),get_by_id("name"+i).value));
							        return false;
							    }
							    */
							}
						}
					}					
					count++;			
		}

		if (submit_button_flag == 0) {
			update_DataArray();
			paintTable();
			clear_reserved();
			AddRoutetoDatamodel();
			//send_submit("form2");
			
			submit_button_flag = 1;
			return true;
		}

		return false;
	}
	
	function paintTable()
	{
		var contain = ""
			contain += '<div class="CT">'+get_words('_static_route_list')+'</div>'
			contain += '<table align="center" cellpadding="0" cellspacing="0" id="table1" class="formarea">';
			contain += '<tr class="break_word">';
			contain += '<td height="22" align="center" class="CTS"><b>'+get_words('_item_no')+'</b></td>';
			contain += '<td height="22" align="center" class="CTS"><b>'+get_words('aa_AT_0')+'</b></td>';
			contain += '<td height="22" align="center" class="CTS"><b>'+get_words('_netmask')+'</b></td>';
			contain += '<td height="22" align="center" class="CTS"><b>'+get_words('_gateway')+'</b></td>';
			contain += '<td height="22" align="center" class="CTS"><b>'+get_words('_metric')+'</b></td>';
			contain += '<td height="22" align="center" class="CTS"><b>'+get_words('_interface')+'</b></td>';
			contain += '</tr>';
			
		for(var i = 0; i < DataArray2.length; i++){
		if(DataArray2[i].Enable=="1"){
			contain += '<tr align="center" class="break_word">'+
					"<td class=\"CELL\">"+(i+1)+"<input type='checkbox' id='sel_del' name='sel_del' value='"+ i +"' />&nbsp;&nbsp;"+
					"</td><td align=center class=\"CELL\">" + DataArray2[i].Ip_addr +
					"</td><td align=center class=\"CELL\">" + DataArray2[i].Net_mask +
					"</td><td align=center class=\"CELL\">" + DataArray2[i].Gateway +
					"</td><td align=center class=\"CELL\">"+ DataArray2[i].Metric +
					"</td><td align=center class=\"CELL\">"+ DataArray2[i].Interface +
					"</td>";
			contain += '</tr>';
		}
		}
			
		contain += '<tr>';
		contain += '<td colspan="6" align="center" class="btn_field">';
		contain += '<input name="delete" type="button" class="ButtonSmall" id="delete" onClick="return del_row()" value="'+get_words("_delete")+'" />';
		contain += '</td>';
		contain += '</tr>';
		contain += '</table>';
		$('#StaticRoutingTable').html(contain);
		
		if(DataArray2.length==0)
			$('#delete').attr('disabled',true);
	}
	
	/**
	 * RIP setting
	 */
	 function setValueEnableRIP(){
		var val_t = "<!--# echo rip_enable -->";
			$('#rip_enable').val(val_t);
	 }
	 function setEventEnableRIP(){
		var func = function(){
			var sel_e = $('#rip_enable').val();
			if(sel_e=='0'){
				$('#rip_mode').hide();
				$('#ripv2_password').hide();
			}
			else{
				$('#rip_mode').show();
				setEventRIPmode();
			}
		};
		func();
		$('#rip_enable').change(func);
	 }
	 function setValueRIPmode(){
		var val_t = "<!--# echo rip_rx_version -->";
		if(val_t!='0')
			$('#ripv'+val_t).attr('checked', 'checked');
	 }
	 function setEventRIPmode(){
		var func = function(){
			var sel_v = $('input[name=rip_ver]:checked').val();
			if(sel_v=='2')
				$('#ripv2_password').show();
			else
			{
				/*
				** Date:	2013-03-18
				** Author:	Moa Chung
				** Reason:	Advanced → Routing：RIP can not be enabled.
				** Note:	TEW-810DR pre-test no.85
				**/
				$('#ripv1').attr('checked', true);
				$('#ripv2_password').hide();
			}
		};
		func();
		$('input[name=rip_ver]').change(func);
		
	 }
	 function setValueRIPv2Password(){
		var val_pwd = "<!--# echo rip_v2_password -->";;
			$('#rip_pwd').val(val_pwd);
	 }
	 function rip_apply(){
		var obj = new ccpObject();
		obj.set_param_url('apply.cgi');
		obj.set_ccp_act('set');
		obj.add_param_event('dynamic_route');
		obj.set_param_next_page('adv_routing.asp');
		
		var rip_enable = $('#rip_enable').val();
		var rip_version = $('input[name=rip_ver]:checked').val();
		var rip_pwd = $('#rip_pwd').val();
		if(rip_enable=='0'){
			obj.add_param_arg('rip_rx_version','0');
			obj.add_param_arg('rip_tx_version','0');
		}
		else if(rip_version=='1'){
			obj.add_param_arg('rip_rx_version','1');
			obj.add_param_arg('rip_tx_version','1');
		}
		else if(rip_version=='2'){
			obj.add_param_arg('rip_rx_version','2');
			obj.add_param_arg('rip_tx_version','2');
		}
		obj.add_param_arg('rip_v2_password',rip_pwd);		
		obj.add_param_arg('rip_enable',rip_enable);		
		obj.add_param_arg('reboot_type','filter');	
		
		
		var paramForm = obj.get_param();
		totalWaitTime = 30; //second
		redirectURL = location.pathname;
		wait_page();
		jq_ajax_post(paramForm.url, paramForm.arg);
	 }
	 
	function del_row()
	{
		var del_idx = [];
		var checked_row = $('input[name=sel_del]:checked');
		if(checked_row.length==0)
		{
			alert(get_words('_adv_rtd'));
			return;
		}
		for(var i=0;i<checked_row.length;i++){
			del_idx.push(parseInt($(checked_row[i]).val(),10));
		}
		del_idx.reverse();
		for(var di in del_idx){
			var idx = del_idx[di];
			DataArray2[idx].Enable = "0";
			DataArray2[idx].Name = "";
			DataArray2[idx].Ip_addr = "";
			DataArray2[idx].Net_mask = "";
			DataArray2[idx].Gateway = "";
			DataArray2[idx].Interface = "";
			DataArray2[idx].Metric = "";
		}
		AddRoutetoDatamodel();
	}

	function AddRoutetoDatamodel()
	{
		var obj = new ccpObject();
		obj.set_param_url('apply.cgi');
		obj.set_ccp_act('set');
		obj.add_param_event('static_route_edit');
		obj.set_param_next_page('adv_routing.asp');

		var count = 0;
		var tmp_name = 1;
		for (var i = 0; i < DataArray2.length; i++)
		{
			var temp_mac;
			if (DataArray2[i].Enable == "0"){
				temp_mac = '';
			}else{
				temp_mac = DataArray2[i].Enable+"/"+ tmp_name +"/"
								+ DataArray2[i].Ip_addr + "/"+ DataArray2[i].Net_mask +"/"
								+ DataArray2[i].Gateway +"/"+ DataArray2[i].Interface + "/"+DataArray2[i].Metric;
				if (count > 9){
					obj.add_param_arg('static_routing_'+count, temp_mac);
				}else{
					obj.add_param_arg('static_routing_0'+count, temp_mac);
				}
				count++;
				tmp_name++;
			}
		}
		obj.add_param_arg('reboot_type','filter');	
		var paramStr = obj.get_param();
		totalWaitTime = 30; //second
		redirectURL = location.pathname;
		wait_page();
		jq_ajax_post(paramStr.url, paramStr.arg);
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
				<script>document.write(menu.build_structure(1,1,2))</script>
				<p>&nbsp;</p>
				</div>
				<img src="/image/bg_l.gif" width="270" height="5" />
			</td>
			<!-- End of left menu -->


				<input type="hidden" id="static_routing_00" name="static_routing_00" value="<!--# echo static_routing_00 -->">
				<input type="hidden" id="static_routing_01" name="static_routing_01" value="<!--# echo static_routing_01 -->">
				<input type="hidden" id="static_routing_02" name="static_routing_02" value="<!--# echo static_routing_02 -->">
				<input type="hidden" id="static_routing_03" name="static_routing_03" value="<!--# echo static_routing_03 -->">
				<input type="hidden" id="static_routing_04" name="static_routing_04" value="<!--# echo static_routing_04 -->">
				<input type="hidden" id="static_routing_05" name="static_routing_05" value="<!--# echo static_routing_05 -->">
				<input type="hidden" id="static_routing_06" name="static_routing_06" value="<!--# echo static_routing_06 -->">
				<input type="hidden" id="static_routing_07" name="static_routing_07" value="<!--# echo static_routing_07 -->">
				<input type="hidden" id="static_routing_08" name="static_routing_08" value="<!--# echo static_routing_08 -->">
				<input type="hidden" id="static_routing_09" name="static_routing_09" value="<!--# echo static_routing_09 -->">
				<input type="hidden" id="static_routing_10" name="static_routing_10" value="<!--# echo static_routing_10 -->">
				<input type="hidden" id="static_routing_11" name="static_routing_11" value="<!--# echo static_routing_11 -->">
				<input type="hidden" id="static_routing_12" name="static_routing_12" value="<!--# echo static_routing_12 -->">
				<input type="hidden" id="static_routing_13" name="static_routing_13" value="<!--# echo static_routing_13 -->">
				<input type="hidden" id="static_routing_14" name="static_routing_14" value="<!--# echo static_routing_14 -->">
				<input type="hidden" id="static_routing_15" name="static_routing_15" value="<!--# echo static_routing_15 -->">
				<input type="hidden" id="static_routing_16" name="static_routing_16" value="<!--# echo static_routing_16 -->">
				<input type="hidden" id="static_routing_17" name="static_routing_17" value="<!--# echo static_routing_17 -->">
				<input type="hidden" id="static_routing_18" name="static_routing_18" value="<!--# echo static_routing_18 -->">
				<input type="hidden" id="static_routing_19" name="static_routing_19" value="<!--# echo static_routing_19 -->">
				<input type="hidden" id="static_routing_20" name="static_routing_20" value="<!--# echo static_routing_20 -->">
				<input type="hidden" id="static_routing_21" name="static_routing_21" value="<!--# echo static_routing_21 -->">
				<input type="hidden" id="static_routing_22" name="static_routing_22" value="<!--# echo static_routing_22 -->">
				<input type="hidden" id="static_routing_23" name="static_routing_23" value="<!--# echo static_routing_23 -->">
				<input type="hidden" id="static_routing_24" name="static_routing_24" value="<!--# echo static_routing_24 -->">
				<input type="hidden" id="static_routing_25" name="static_routing_25" value="<!--# echo static_routing_25 -->">
				<input type="hidden" id="static_routing_26" name="static_routing_26" value="<!--# echo static_routing_26 -->">
				<input type="hidden" id="static_routing_27" name="static_routing_27" value="<!--# echo static_routing_27 -->">
				<input type="hidden" id="static_routing_28" name="static_routing_28" value="<!--# echo static_routing_28 -->">
				<input type="hidden" id="static_routing_29" name="static_routing_29" value="<!--# echo static_routing_29 -->">
				<input type="hidden" id="static_routing_30" name="static_routing_30" value="<!--# echo static_routing_30 -->">
				<input type="hidden" id="static_routing_31" name="static_routing_31" value="<!--# echo static_routing_31 -->">
				<input type="hidden" id="static_routing_32" name="static_routing_32" value="<!--# echo static_routing_32 -->">
				<input type="hidden" id="static_routing_33" name="static_routing_33" value="<!--# echo static_routing_33 -->">
				<input type="hidden" id="static_routing_34" name="static_routing_34" value="<!--# echo static_routing_34 -->">
				<input type="hidden" id="static_routing_35" name="static_routing_35" value="<!--# echo static_routing_35 -->">
				<input type="hidden" id="static_routing_36" name="static_routing_36" value="<!--# echo static_routing_36 -->">
				<input type="hidden" id="static_routing_37" name="static_routing_37" value="<!--# echo static_routing_37 -->">
				<input type="hidden" id="static_routing_38" name="static_routing_38" value="<!--# echo static_routing_38 -->">
				<input type="hidden" id="static_routing_39" name="static_routing_39" value="<!--# echo static_routing_39 -->">
				<input type="hidden" id="static_routing_40" name="static_routing_40" value="<!--# echo static_routing_40 -->">
				<input type="hidden" id="static_routing_41" name="static_routing_41" value="<!--# echo static_routing_41 -->">
				<input type="hidden" id="static_routing_42" name="static_routing_42" value="<!--# echo static_routing_42 -->">
				<input type="hidden" id="static_routing_43" name="static_routing_43" value="<!--# echo static_routing_43 -->">
				<input type="hidden" id="static_routing_44" name="static_routing_44" value="<!--# echo static_routing_44 -->">
				<input type="hidden" id="static_routing_45" name="static_routing_45" value="<!--# echo static_routing_45 -->">
				<input type="hidden" id="static_routing_46" name="static_routing_46" value="<!--# echo static_routing_46 -->">
				<input type="hidden" id="static_routing_47" name="static_routing_47" value="<!--# echo static_routing_47 -->">
				<input type="hidden" id="static_routing_48" name="static_routing_48" value="<!--# echo static_routing_48 -->">
				<input type="hidden" id="static_routing_49" name="static_routing_49" value="<!--# echo static_routing_49 -->">
				<input type="hidden" id="routing_table" name="routing_table" value="<!--# exec cgi /bin/get_route_table routing_table -->">
        <input type="hidden" id="wan_pppoe_russia_enable" name="wan_pppoe_russia_enable" value="<!--# echo wan_pppoe_russia_enable -->">
				<input type="hidden" id="wan_pptp_russia_enable" name="wan_pptp_russia_enable" value="<!--# echo wan_pptp_russia_enable -->">
				<input type="hidden" id="wan_l2tp_russia_enable" name="wan_l2tp_russia_enable" value="<!--# echo wan_l2tp_russia_enable -->">
				


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
							<script>show_words('_static_routing_settings');</script>
							</div>
							<div class="hr"></div>
							<div class="section_content_border">
							<div class="header_desc" id="acIntroduction">
								<script>show_words('_ROUTING_DESC');</script>
								<p></p>
							</div>

			<input type="hidden" id="dhcp_list" name="dhcp_list" value="" />
			<form id="form2" name="form2" method="post" action="get_set.ccp">
				<input type="hidden" name="ccp_act" value="set" />
				<input type="hidden" name="ccpSubEvent" value="CCP_SUB_WEBPAGE_APPLY" />
				<input type="hidden" name="nextPage" value="adv_routing.asp" />
				<script>
					var str = "";
					for(var i=1; i<=rule_max_num; i++)
					{
						var inst = '1.1.'+i+'.0';
						str += '<input type="hidden" name="fwdRule_Enable_'+inst+'" id="fwdRule_Enable_'+inst+'" value="" />';
						str += '<input type="hidden" name="fwdRule_Name_'+inst+'" id="fwdRule_Name_'+inst+'" value="" />';
						str += '<input type="hidden" name="fwdRule_DestIPAddress_'+inst+'" id="fwdRule_DestIPAddress_'+inst+'" value="" />';
						str += '<input type="hidden" name="fwdRule_DestSubnetMask_'+inst+'" id="fwdRule_DestSubnetMask_'+inst+'" value="" />';
						str += '<input type="hidden" name="fwdRule_SourceInterface_'+inst+'" id="fwdRule_SourceInterface_'+inst+'" value="1" />';
						str += '<input type="hidden" name="fwdRule_GatewayIPAddress_'+inst+'" id="fwdRule_GatewayIPAddress_'+inst+'" value="" />';
						str += '<input type="hidden" name="fwdRule_ForwardingMetric_'+inst+'" id="fwdRule_ForwardingMetric_'+inst+'" value="" />';
					}
					document.write(str);
				</script>
			</form>
			<form id="form1" name="form1" method="post" action="">
				<input type="hidden" id="html_response_page" name="html_response_page" value="back.asp" />
				<input type="hidden" id="html_response_message" name="html_response_message" value="" />
				<script>get_by_id("html_response_message").value = get_words('sc_intro_sv');</script>
				<input type="hidden" id="html_response_return_page" name="html_response_return_page" value="adv_routing.asp" />
				<input type="hidden" id="reboot_type" name="reboot_type" value="filter" />
				<input type="hidden" id="del" name="del" value="-1" />
				<input type="hidden" id="edit" name="edit" value="-1" />
				<input type="hidden" id="max_row" name="max_row" value="-1" />
			<p></p>
			<a name="show_list"></a>
<div class="box_tn">
	<div class="CT"><script>show_words('_add_static_route');</script></div>
	<table cellspacing="0" cellpadding="0" class="formarea">
	<tr style="display:none;">
		<td class="CL"><del><script>show_words('_name');</script></del></td>
		<td class="CR"><input type="text" id="name" name="name" size="16" maxlength="15" /></td>
	</tr>
	<tr>
		<td class="CL"><script>show_words('_dest_ip_addr');</script> :</td>
		<td class="CR"><input type="text" id="Destination" name="Destination" size="16" maxlength="15" value="0.0.0.0" /></td>
	</tr>
	<tr>
		<td class="CL"><script>show_words('_dest_ip_mask');</script> :</td>
		<td class="CR"><input type="text" id="Sub_Mask" name="Sub_Mask" size="16" maxlength="15" value="0.0.0.0" /></td>
	</tr>
	<tr>
		<td class="CL"><script>show_words('_gateway');</script> :</td>
		<td class="CR"><input type="text" id="Sub_gateway" name="Sub_gateway" size="16" maxlength="15" value="0.0.0.0" /></td>
	</tr>
	<tr>
		<td class="CL"><script>show_words('_metric');</script> :</td>
		<td class="CR"><input type="text" id="metric" name="metric" size="3" maxlength="2" value="1" /></td>
	</tr>
	<tr>
		<td class="CL"><script>show_words('_interface');</script> :</td>
		<td class="CR"><select size="1" id="interface" name="interface">
			<script>
				document.write("<option value=\"WAN\">WAN</option>");
				if ("<!--# echo feature_russsia -->" == "1")
					if(get_by_id("wan_pptp_russia_enable").value == "1" ||get_by_id("wan_l2tp_russia_enable").value == "1" || get_by_id("wan_pppoe_russia_enable").value == "1"){
						document.write("<option value=\"WAN_PHY\">WAN(Physical Port)</option>");
				}	
			</script>
		</select>
		</td>
	</tr>
	<tr>
		<td align="center" colspan="2" class="btn_field">
		<input name="add" type="button" class="ButtonSmall" id="add" onClick="return send_request()" value="" />
		<script>$('#add').val(get_words('_add'));</script>
		<input name="cancel" type="button" class="ButtonSmall" id="cancel" onClick="clear_reserved()" value="" />
		<script>$('#cancel').val(get_words('_cancel'));</script>
		</td>
	</tr>
	</table>
</div>
			</form>
			
<div class="box_tn">
	<span id="StaticRoutingTable"></span>
</div>
<script>set_route();paintTable();</script>
<!-- RIP -->
<div class="box_tn">
	<div class="CT"><script>show_words('help670');</script></div>
	<table cellspacing="0" cellpadding="0" class="formarea">
	<tr>
		<td class="CL"><script>show_words('_enable_rip');</script></td>
		<td class="CR">
			<select id="rip_enable">
				<option value="0"><script>show_words('_disable');</script></option>
				<option value="1"><script>show_words('_enable');</script></option>
			</select>
		</td>
	</tr>
	<tr id="rip_mode" style="display:none;">
		<td class="CL"><script>show_words('_rip_mode');</script></td>
		<td class="CR">
			<input type="radio" id="ripv1" name="rip_ver" size="16" maxlength="15" value="1" />v1
			<input type="radio" id="ripv2" name="rip_ver" size="16" maxlength="15" value="2" />v2
		</td>
	</tr>
	<tr id="ripv2_password" style="display:none;">
		<td class="CL"><script>show_words('_password');</script></td>
		<td class="CR"><input type="password" id="rip_pwd" name="rip_pwd" size="16" maxlength="15" /></td>
	</tr>
	<tr>
		<td align="center" colspan="2" class="btn_field">
			<input type="button" class="button_submit" id="btn_rip_apply" value="Apply" onclick="rip_apply();" />&nbsp;&nbsp;
			<script>$('#btn_rip_apply').val(get_words('_apply'));</script>
			<input type="reset" class="button_submit" id="btn_rip_cancel" value="Cancel" onclick="window.location.reload()" />
			<script>$('#btn_rip_cancel').val(get_words('_cancel'));</script>
		</td>
	</tr>
	</table>
</div>
<!-- Routing Table -->
<div class="box_tn">
	<div class="CT"><script>show_words('sr_RTable');</script></div>
	<table id="routing_table1" align="center" cellpadding="0" cellspacing="0" class="formarea">
	<tr>
		<td class="CTS"><script>show_words('aa_AT_0');</script></td>
		<td class="CTS"><script>show_words('_netmask');</script></td>
		<td class="CTS"><script>show_words('_gateway');</script></td>
		<td class="CTS"><script>show_words('_metric');</script></td>
		<td class="CTS"><script>show_words('_interface');</script></td>
	</tr>
	<script>
  	routingTable_list(); 
	</script>
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
