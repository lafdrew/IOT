<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html lang="en-US" xmlns="http://www.w3.org/1999/xhtml" xml:lang="en-US">
<head>
<title>TRENDNET | modelName | Advanced | DMZ</title>
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
<script lang="javascript" src="/jquery.sparkline.min.js"></script>
<script type="text/javascript">
	var def_title = document.title;
	var model = "<!--# echo model_number -->";
	document.title = def_title.replace("modelName", model);
	var selectIDArray = new Array("", "inbound_filter", "schedule");

	var menu = new menuObject();
//	menu.setSupportUSB(dev_info.KCode_USB);
	var array_enable = [], array_name = [], array_intnlip = [], array_TCPPort = [], 
	    array_UDPPort = [], array_Schdule = [], array_Policy = [];
	var array_vs_enable = [], array_vs_proto = [], array_vs_ports = [];
	var array_pt_enable = [], array_pt_proto = [], array_pt_ports = [];
	var array_sch_inst = [], array_ib_inst = [];

	var main = new ccpObject();
//	main.set_param_url('get_set.ccp');
//	main.set_ccp_act('get');
//	main.add_param_arg('IGD_WANDevice_i_PortFwd_i_',1100);
//	main.add_param_arg('IGD_ScheduleRule_i_',1000);
//	main.add_param_arg('IGD_WANDevice_i_InboundFilter_i_',1100);
//	main.add_param_arg('IGD_LANDevice_i_ConnectedAddress_i_',1100);
//	main.add_param_arg('IGD_',1000);
//	main.add_param_arg('IGD_WANDevice_i_VirServRule_i_',1100);
//	main.add_param_arg('IGD_WANDevice_i_PortTriggerRule_i_',1100);
//	main.add_param_arg('IGD_AdministratorSettings_',1100);
//	main.add_param_arg('IGD_Storage_',1000);
//	if(dev_info.KCode_USB)
//		main.add_param_arg('IGD_FTPServer_',1100);
//	main.get_config_obj();

	var rule_max_num = 24;

	var wa_http_en 			= main.config_val("igdStorage_Enable_");
	var wa_https_en 		= main.config_val("igdStorage_Https_Remote_Access_Enable_");
	var wa_http_port 		= main.config_val("igdStorage_Http_Remote_Access_Port_");
	var wa_https_port		= main.config_val("igdStorage_Https_Remote_Access_Port_");
//	if(dev_info.KCode_USB)
//		var kcode_ftp_wan	= main.config_val("igdFTPServer_AccessWanEnable_");
	var schedule_cnt = 0;
	
//	if(array_schedule_name != null)
//		schedule_cnt = array_schedule_name.length;

	var inbound_cnt = 0;
	
//	if(array_ib_name != null)
//		inbound_cnt = array_ib_name.length;
		
	var submit_button_flag = 0;
	var rule_max_num = 24;
	var inbound_used = 1;
	
	var DataArray = new Array();
	var TotalCnt=0;
		
	function onPageLoad()
	{
		var rule_value;
		// get port_forward_both_XX value
		for (j=0; j<rule_max_num; j++) {
			if (j > 9){
				rule_value = (get_by_id("port_forward_both_" + j).value);
			}else{
				rule_value = (get_by_id("port_forward_both_0" + j).value);				
			}				  
			
			if (rule_value == ""){
				break;
			}
			
			temp = rule_value.split("/");
			array_enable[j] = temp[0];
			array_name[j] = temp[1];
			array_intnlip[j] = temp[2];
			array_TCPPort[j] = temp[3];
			array_UDPPort[j] = temp[4];
			array_Schdule[j] = temp[5];
			array_Policy[j] = temp[6];
		}

		// get vs_rule_XX value
		for (j=0; j<rule_max_num; j++) {
			if (j > 9){
				rule_value = (get_by_id("vs_rule_" + j).value);
			}else{
				rule_value = (get_by_id("vs_rule_0" + j).value);				
			}
			
			if (rule_value == ""){
				break;
			}
			
			temp = rule_value.split("/");
			array_vs_enable[j] = temp[0];
			array_vs_proto[j] = temp[2];
			array_vs_ports[j] = temp[3];
		}

		// get application_XX value
		for (j=0; j<rule_max_num; j++) {
			if (j > 9){
				rule_value = (get_by_id("application_" + j).value);
			}else{
				rule_value = (get_by_id("application_0" + j).value);				
			}
			
			if (rule_value == ""){
				break;
			}
			
			temp = rule_value.split("/");
			array_pt_enable[j] = temp[0];
			array_pt_proto[j] = temp[2];
			array_pt_ports[j] = temp[3];
		}

		// get schedule_rule_XX value
		for (j=0; j<rule_max_num; j++) {
			if (j > 9){
				rule_value = (get_by_id("schedule_rule_" + j).value);
			}else{
				rule_value = (get_by_id("schedule_rule_0" + j).value);				
			}
			
			if (rule_value == ""){
				break;
			}
			
			temp = rule_value.split("/");
			array_sch_inst[j] = temp[0];
			schedule_cnt++;
		}

		// get inbound_filter_name_XX value
		for (j=0; j<rule_max_num; j++) {
			if (j > 9){
				rule_value = (get_by_id("inbound_filter_name_" + j).value);
			}else{
				rule_value = (get_by_id("inbound_filter_name_0" + j).value);				
			}
			
			if (rule_value == ""){
				break;
			}
			
			temp = rule_value.split("/");
			array_ib_inst[j] = temp[0];
			inbound_cnt++;
		}
		var Application_list = set_application_option(Application_list, default_rule);
		var table_str = '';
			table_str += '<select style=\"width:150px\" id=application name=application onchange="copy_portforward(); changeSense();">';
			table_str += '<option>'+get_words('gw_SelVS')+'</option>';
			table_str += Application_list;
			table_str += '</select>';
			$('#app_list').html(table_str);
		var table_str = '';
			table_str += "<select id=schedule name=schedule style='width:80px;'>";
			table_str += '<option value=\"Always\">'+get_words('_always')+'</option>';
			table_str += '<option value=\"Never\">'+get_words('_never')+'</option>';
			table_str += add_option('Schedule', array_Schdule);
			table_str += "</select>";
			$('#sche_list').html(table_str);
		
		var table_str = '';
			table_str += "<select id=inbound_filter name=inbound_filter style='width:80px;'>";
			table_str += '<option value=\"Allow_All\">'+get_words('_allowall')+'</option>';
			table_str += '<option value=\"Deny_All\">'+get_words('_denyall')+'</option>';
			table_str += add_option('Inbound', array_Policy);
			table_str += "</select>";
			$('#pol_list').html(table_str);
		
		set_portforward();
		paintTable();
	}

	function Data(enable, name, ip_addr, tcpPort, udpPort, schdule, policy, onList)
	{
		this.Enable = enable;
		this.Name = name;
		this.Ip_addr = ip_addr;
		this.TCPPort = tcpPort;
		this.UDPPort = udpPort;
		this.Schdule = schdule;
		this.Policy = policy;
		this.OnList = onList ;
	}

	function set_portforward()
	{
		var index = 0;
		for (var i = 0; i < rule_max_num; i++) {
			if(array_name[i] != "" && array_name[i])
			{
				TotalCnt++;
				DataArray[DataArray.length++] = new Data(array_enable[i], array_name[i], array_intnlip[i], array_TCPPort[i], array_UDPPort[i], array_Schdule[i], array_Policy[i], i);
			}
		}

		$('#max_row').val(index-1);
	}

	function del_row(idx)
	{
		if(!confirm(get_words('YM25') + ": " + DataArray[idx].Name + "?"))
			return;

		for(var i=idx; i<(DataArray.length-1); i++)
		{
			DataArray[i].Enable = DataArray[i+1].Enable;
			DataArray[i].Name = DataArray[i+1].Name;
			DataArray[i].Ip_addr = DataArray[i+1].Ip_addr;
			DataArray[i].TCPPort = DataArray[i+1].TCPPort;
			DataArray[i].UDPPort = DataArray[i+1].UDPPort;
			DataArray[i].Schdule = DataArray[i+1].Schdule;
			DataArray[i].Policy = DataArray[i+1].Policy;
			DataArray[i].OnList = DataArray[i+1].OnList;			
		}

		if(DataArray.length > 0)
			DataArray.length -- ;

		paintTable();
		clear_reserved();

		AddPFtoDatamodel();
	}

	function update_DataArray()
	{
		var index = parseInt($('#edit').val());
		var insert = false;
		var is_chk = get_checked_value($('#enable')[0]);

		if(index == "-1"){      //save
			if(DataArray.length == rule_max_num){
				alert(get_words('TEXT015'));
			}else{
				index = DataArray.length;
				$('#max_row').val(index);
				insert = true;
			}
		}

		if(insert){
			DataArray[index] = new Data(is_chk, $('#name').val(), $('#ip').val(), $('#tcp_ports').val(), $('#udp_ports').val(), $('#schedule').val(), $('#inbound_filter').val(), index+1);			
		}else if (index != -1){			
			DataArray[index].Enable = is_chk;
			DataArray[index].Name = $('#name').val();
			DataArray[index].Ip_addr = $('#ip').val();
			DataArray[index].TCPPort = $('#tcp_ports').val();
			DataArray[index].UDPPort = $('#udp_ports').val();
			DataArray[index].Schdule = $('#schedule').val();
			DataArray[index].Policy = $('#inbound_filter').val();
			DataArray[index].OnList = index;
		}
	}

	function clear_reserved()
	{
		$("input[name=sel_del]").each(function () { this.checked = false; });
		set_checked(0, $('#enable')[0]);
		$('#name').val("");
		$('#ip').val("");
		$('#tcp_ports').val("");
		$('#udp_ports').val("");
		$('#schedule').val("Always");
		$('#inbound_filter').val("Allow_All");
		$('#edit').val(-1);
		$('#add').attr('disabled', '');
        $('#clear').attr('disabled', true);
	}

	function edit_row(idx)
    {
		set_checked(DataArray[idx].Enable, $('#enable')[0]);
        $('#name').val(DataArray[idx].Name);
        $('#ip').val(DataArray[idx].Ip_addr);
        $('#tcp_ports').val(DataArray[idx].TCPPort);
		$('#udp_ports').val(DataArray[idx].UDPPort);
		$('#schedule').val(DataArray[idx].Schdule);
		$('#inbound_filter').val(DataArray[idx].Policy);
		$('#edit').val(idx);
		$('#add').val(get_words('_save'));
		$('#clear').attr('disabled', '');
    }

	function AddPFtoDatamodel()
	{
		var obj = new ccpObject();
		obj.set_param_url('apply.cgi');
		obj.set_ccp_act('set');
		obj.add_param_event('adv_portforward');
		obj.set_param_next_page('adv_port_range.asp');
		obj.add_param_arg('reboot_type', 'filter');

		for(var i=0; i<DataArray.length; i++)
		{
			var key, value;
			if (i<10)
				key = "port_forward_both_0" + i;
			else
				key = "port_forward_both_" + i;

			value = DataArray[i].Enable + "/" + DataArray[i].Name + "/" + DataArray[i].Ip_addr + "/" +
					DataArray[i].TCPPort + "/" + DataArray[i].UDPPort + "/" + 
					DataArray[i].Schdule + "/" + DataArray[i].Policy;
			obj.add_param_arg(key,value);
		}
		var paramStr = obj.get_param();

		totalWaitTime = 10; //second
		redirectURL = location.pathname;
		wait_page();
		jq_ajax_post(paramStr.url, paramStr.arg);
	}
	
	function send_request()
	{
		var tcp_timeline = '';
		var udp_timeline = '';
		var reg = /[^0-9\-\,\s]/;
		if (!is_form_modified("form3") && !confirm(get_words('_ask_nochange'))) {
			return false;
		}
		var count = 0;
		
		var tmp_name = $('#name').val();
		if (tmp_name != "")
		{
			for (var j = 0; j < DataArray.length; j++)
			{
				if($('#edit').val()!=j){
					if (tmp_name == DataArray[j].Name){
						alert(get_words('TEXT060'));
						return false;
					}
				}
			}
		}
	
		// add port forward ports into timeline
		try {
			for (var i=0; i<array_enable.length; i++)
			{
				if (array_enable[i] == '0' || i == $('#edit').val())
					continue;
				var pf_tcp_ports = array_TCPPort[i].split(',');
				for (var j=0; j<pf_tcp_ports.length; j++) {
					var range = pf_tcp_ports[j].split('-');
					tcp_timeline = add_into_timeline(tcp_timeline, range[0], range[1]);
				}
				var pf_udp_ports = array_UDPPort[i].split(',');
				for (var j=0; j<pf_udp_ports.length; j++) {
					var range = pf_udp_ports[j].split('-');
					udp_timeline = add_into_timeline(udp_timeline, range[0], range[1]);
				}
			}
		} catch (e) {
			alert('error occur in adding port forward ports into timeline');
		}

	
		// add virtual server ports into timeline
		try {
			for (var i=0; i<array_vs_enable.length; i++)
			{
				if (array_vs_enable[i] == '0')
					continue;
				var vs_ports = array_vs_ports[i].split(',');
				for (var j=0; j<vs_ports.length; j++) {
					var range = vs_ports[j].split('-');
					if (array_vs_proto[i] == 'TCP') {
						tcp_timeline = add_into_timeline(tcp_timeline, range[0], range[1]);
					} else if (array_vs_proto[i] == 'UDP') {
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
		
		// add port trigger ports into timeline
		try {
			for (var i=0; i<array_pt_enable.length; i++) {
				if (array_pt_enable[i] == '0')
					continue;
				var pt_ports = array_pt_ports[i].split(',');
				for (var j=0; j<pt_ports.length; j++) {
					var range = pt_ports[j].split('-');
					if (array_pt_proto[i] == 'TCP') {
						tcp_timeline = add_into_timeline(tcp_timeline, range[0], range[1]);
					} else if (array_pt_proto[i] == 'UDP') {
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

		//add Remote management port to time line
		var remote_port_enable="<!--# echo remote_http_management_enable -->";
		var remote_config="<!--# echo https_config -->".split("/");
		var remote_https_en=remote_config[1];

		try
		{
			if(remote_port_enable == '1')
			{
				var tcp_ports = remote_config[3];
				tcp_timeline = add_into_timeline(tcp_timeline, tcp_ports, null);
			}
			if(remote_https_en == '1')
			{
				var tcp_ports = remote_config[2];
				tcp_timeline = add_into_timeline(tcp_timeline, tcp_ports, null);
			}
		}
		catch (e)
		{
			alert('error occur in adding port trigger ports into timeline');
		}

		//add web access ports into timeline
		if(wa_http_en == 1)
		{
			tcp_timeline = add_into_timeline(tcp_timeline, wa_http_port, null);
			tcp_timeline = add_into_timeline(tcp_timeline, wa_https_port, null);
		}
		
		//add kcode-ftp access from wan into timeline
		if('<!--# echo accwan_enable -->'=='1')
			tcp_timeline = add_into_timeline(tcp_timeline, '21', null);
		
		var ip = $('#ip').val();
		var lan_ip = "";
		var check_name = $('#name').val();

		var ip_addr_msg = replace_msg(all_ip_addr_msg, get_words('ES_IP_ADDR'));
		var temp_ip_obj = new addr_obj(ip.split("."), ip_addr_msg, false, false);
		var temp_lan_ip_obj = new addr_obj(lan_ip.split("."), ip_addr_msg, false, false);
		var temp_pf;
			
		if (check_name != "")
		{
			if(Find_word(check_name,'"') || Find_word(check_name,"/"))
			{
				alert(get_words('_pf') + addstr(get_words('_adv_txt_02'), check_name));
				return false;
			}

			if (!check_address(temp_ip_obj)){
				return false;
			}
									
			if ($('#tcp_ports').val() == "0" && $('#udp_ports').val() == "0"){
				alert(get_words('TEXT061'));
				return false;
			}
			
			//check dhcp ip range equal to lan-ip or not?
//			if(!check_LAN_ip(dev_info.lanIP.split('.'), temp_ip_obj.addr, get_words('help256'))){
//				return false;
//			}
				
			//check port forwarding tcp port and remote management port conflict problem
			if(( $('#tcp_ports').val() == "" || $('#tcp_ports').val() == 0 ) &&
				( $('#udp_ports').val() == ""|| $('#udp_ports').val() == 0))
			{
				alert(get_words('TEXT061'));
				return false;
			}
			else
			{
				if ( $('#tcp_ports').val() != "" && $('#tcp_ports').val() != 0)
				{
					var tcp_ports = $('#tcp_ports').val().split(',');
					var chk_tcp_ports="";
					var check_index=0;

					for (var j=0; j<tcp_ports.length; j++)
					{
						var range = tcp_ports[j].split('-');
							

						if(range[0] == "" || !check_port(range[0]))
						{
							alert(get_words('ac_alert_invalid_port'));
							return false;
						}
						if(reg.test(range[0]) == true)
						{
							alert(get_words('YM120'));
							return false;					
						}
						if(range.length>1 && !check_port(range[1],10))
						{
							alert(get_words('ac_alert_invalid_port'));
							return false;
						}
						if(range.length>1 && reg.test(range[1]) == true)
						{
							alert(get_words('YM120'));
							return false;		
						}
						tcp_timeline = add_into_timeline(tcp_timeline, range[0], range[1]);
						chk_tcp_ports += parseInt(range[0],10);
						if(range.length>1)
							chk_tcp_ports += "-" + parseInt(range[1],10);
						if(tcp_ports.length>1 && j<tcp_ports.length-1)
							chk_tcp_ports += ",";
					}
					$('#tcp_ports').val(chk_tcp_ports);
				}

				if ( $('#udp_ports').val() != "" && $('#udp_ports').val() != 0)
				{
					var udp_ports = $('#udp_ports').val().split(',');
					var chk_tcp_ports="";
					for (var j=0; j<udp_ports.length; j++)
					{
						var range = udp_ports[j].split('-');
						if(range[0] == "" || !check_port(range[0]))
						{
							alert(get_words('ac_alert_invalid_port'));
							return false;
						}
						if(reg.test(range[0]) == true)
						{
							alert(get_words('YM120'));
							return false;					
						}
						if(range.length>1 && !check_port(range[1],10))
						{
							alert(get_words('ac_alert_invalid_port'));
							return false;
						}
						if(range.length>1 && reg.test(range[1]) == true)
						{
							alert(get_words('YM120'));
							return false;		
						}
						udp_timeline = add_into_timeline(udp_timeline, range[0], range[1]);
						chk_tcp_ports += parseInt(range[0],10);
						if(range.length>1)
							chk_tcp_ports += "-" + parseInt(range[1],10);
						if(udp_ports.length>1 && j<udp_ports.length-1)
							chk_tcp_ports += ","
					}
					$('#udp_ports').val(chk_tcp_ports);
				}
			}
			
			if (check_timeline(tcp_timeline) == false) {
				alert(addstr(get_words('ag_conflict5'), 'TCP', $('#tcp_ports').val()));
				return false;
			}
			
			if (check_timeline(udp_timeline) == false) {
				alert(addstr(get_words('ag_conflict5'), 'UDP', $('#udp_ports').val()));
				return false;
			}
			
			//if port value have blank, replace to ""
			$('#tcp_ports').val($('#tcp_ports').val().replace(/ /,""));
			$('#udp_ports').val($('#udp_ports').val().replace(/ /,""));
			
			count++;
		} else {
			alert(get_words('pf_name_empty'));
			return false;
		}

		if(submit_button_flag == 0){
			update_DataArray();
			paintTable();
			clear_reserved();
			AddPFtoDatamodel();
			
			submit_button_flag = 1;
		}
	}

	function add_option(id, def_val)
	{
		var obj = null;
		var arr = null;
		var nam = null;
		var str = '';
		
		if (id == 'Schedule') {
			obj = schedule_cnt;
			arr = array_sch_inst;
		} else if (id == 'Inbound') {
			obj = inbound_cnt;
			arr = array_ib_inst;
		}
		
		if (obj == null)
			return;

		for (var i = 0; i < obj; i++){		
			if (id == 'Schedule') {
				str += ("<option value=" + arr[i] + " >" + arr[i] + "</option>");
			} else if (id == 'Inbound') {
				str +=("<option value=" + arr[i] + " >" + arr[i] + "</option>");
			}
		}
		return str;
	}	
	
	function paintTable()
	{
		var contain = '<div class="box_tn">';
			contain += '<div class="CT">'+get_words('_adv_txt_10')+'</div>';
			contain += '<table cellspacing="0" cellpadding="0" class="formarea">';
			contain += '<tr class="break_word"><td height="22" align="center" class="CTS" nowrap="nowrap">'+get_words('_enable')+'</td>';
			contain += '<td height="22" align="center" class="CTS" nowrap="nowrap">'+get_words('_name')+'</td>';
			contain += '<td height="22" align="center" class="CTS" nowrap="nowrap">'+get_words('_ipaddr')+'</td>';
			contain += '<td height="22" align="center" class="CTS" nowrap="nowrap">'+get_words('_ports')+'</td>';
			contain += '<td height="22" align="center" class="CTS" nowrap="nowrap">'+get_words('INBOUND_FILTER')+'</td>';
			contain += '<td height="22" align="center" class="CTS" nowrap="nowrap">'+get_words('_sched')+'</td>';
			contain += '<td height="22" align="center" class="CTS" nowrap="nowrap">'+get_words('_edit')+'</td>';
			contain += '<td height="22" align="center" class="CTS" nowrap="nowrap">'+get_words('_delete')+'</td>';
			contain += '</tr>';
		
		for(var i = 0; i < DataArray.length; i++)
		{
			var is_chk='';
			if (DataArray[i].Enable == 1)
//			{
				is_chk = "checked";
//				contain += '<tr align="center" style="background-color:rgb(255,255,0);">';
//			}else{
				contain += '<tr align="center" class="break_word">';
//			}
			contain += '<td align="center" class="CELL">'+(i+1)+'<input type="checkbox" id="sel_enable" name="sel_enable" disabled ' +is_chk+' />'+
					'</td><td align="center" class="CELL">' + DataArray[i].Name +
					'</td><td align="center" class="CELL">' + DataArray[i].Ip_addr +
					'</td><td align="center" class="CELL">' + DataArray[i].TCPPort + '/ ' + DataArray[i].UDPPort +
					'</td><td align="center" class="CELL">' + DataArray[i].Policy +
					'</td><td align="center" class="CELL">' + DataArray[i].Schdule +
					'</td><td align="center" class="CELL">' +
					'<a href="javascript:edit_row('+ i +')"><img src="edit.gif" border="0" title="'+get_words('_edit')+'" /></a>'+
					'</td><td align="center" class="CELL">'+
					'<a href="javascript:del_row(' + i +')"><img src="delete.gif" border="0" title="'+get_words('_delete')+'" /></a>'+
					'</td>';

			contain += '</tr>';
		}
		contain += '</table>';
		contain += '</div>';
		$('#PFTable').html(contain);

		set_form_default_values("form3");
	}	

	function changeSense()
	{
		if( $('input[name=enable]').attr('checked') != false ||
			$('#name').val() != '' ||
			$('#ip').val() != '' ||
			$('#tcp_ports').val() != '' ||
			$('#udp_ports').val() != '')
		{
			$('#clear').attr('disabled', '');
		} else {
			$('#clear').attr('disabled', true);
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
				<script>document.write(menu.build_structure(1,5,3))</script>
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
								<script>show_words('_adv_txt_06');</script>
								</div>
								<div class="hr"></div>
								<div class="section_content_border">
								<div class="header_desc" id="lanIntroduction">
									<script>show_words('_adv_txt_07');</script>
									<p></p>
								</div>
				<input type="hidden" id="schedule_rule_00" name="schedule_rule_00" value="<!--# echo schedule_rule_00 -->">
				<input type="hidden" id="schedule_rule_01" name="schedule_rule_01" value="<!--# echo schedule_rule_01 -->">
				<input type="hidden" id="schedule_rule_02" name="schedule_rule_02" value="<!--# echo schedule_rule_02 -->">
				<input type="hidden" id="schedule_rule_03" name="schedule_rule_03" value="<!--# echo schedule_rule_03 -->">
				<input type="hidden" id="schedule_rule_04" name="schedule_rule_04" value="<!--# echo schedule_rule_04 -->">
				<input type="hidden" id="schedule_rule_05" name="schedule_rule_05" value="<!--# echo schedule_rule_05 -->">
				<input type="hidden" id="schedule_rule_06" name="schedule_rule_06" value="<!--# echo schedule_rule_06 -->">
				<input type="hidden" id="schedule_rule_07" name="schedule_rule_07" value="<!--# echo schedule_rule_07 -->">
				<input type="hidden" id="schedule_rule_08" name="schedule_rule_08" value="<!--# echo schedule_rule_08 -->">
				<input type="hidden" id="schedule_rule_09" name="schedule_rule_09" value="<!--# echo schedule_rule_09 -->">
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
                
				<input type="hidden" id="vs_rule_00" name="vs_rule_00" value="<!--# echo vs_rule_00 -->">
				<input type="hidden" id="vs_rule_01" name="vs_rule_01" value="<!--# echo vs_rule_01 -->">
				<input type="hidden" id="vs_rule_02" name="vs_rule_02" value="<!--# echo vs_rule_02 -->">
				<input type="hidden" id="vs_rule_03" name="vs_rule_03" value="<!--# echo vs_rule_03 -->">
				<input type="hidden" id="vs_rule_04" name="vs_rule_04" value="<!--# echo vs_rule_04 -->">
				<input type="hidden" id="vs_rule_05" name="vs_rule_05" value="<!--# echo vs_rule_05 -->">
				<input type="hidden" id="vs_rule_06" name="vs_rule_06" value="<!--# echo vs_rule_06 -->">
				<input type="hidden" id="vs_rule_07" name="vs_rule_07" value="<!--# echo vs_rule_07 -->">
				<input type="hidden" id="vs_rule_08" name="vs_rule_08" value="<!--# echo vs_rule_08 -->">
				<input type="hidden" id="vs_rule_09" name="vs_rule_09" value="<!--# echo vs_rule_09 -->">
				<input type="hidden" id="vs_rule_10" name="vs_rule_10" value="<!--# echo vs_rule_10 -->">
				<input type="hidden" id="vs_rule_11" name="vs_rule_11" value="<!--# echo vs_rule_11 -->">
				<input type="hidden" id="vs_rule_12" name="vs_rule_12" value="<!--# echo vs_rule_12 -->">
				<input type="hidden" id="vs_rule_13" name="vs_rule_13" value="<!--# echo vs_rule_13 -->">
				<input type="hidden" id="vs_rule_14" name="vs_rule_14" value="<!--# echo vs_rule_14 -->">
				<input type="hidden" id="vs_rule_15" name="vs_rule_15" value="<!--# echo vs_rule_15 -->">
				<input type="hidden" id="vs_rule_16" name="vs_rule_16" value="<!--# echo vs_rule_16 -->">
				<input type="hidden" id="vs_rule_17" name="vs_rule_17" value="<!--# echo vs_rule_17 -->">
				<input type="hidden" id="vs_rule_18" name="vs_rule_18" value="<!--# echo vs_rule_18 -->">
				<input type="hidden" id="vs_rule_19" name="vs_rule_19" value="<!--# echo vs_rule_19 -->">
				<input type="hidden" id="vs_rule_20" name="vs_rule_20" value="<!--# echo vs_rule_20 -->">
				<input type="hidden" id="vs_rule_21" name="vs_rule_21" value="<!--# echo vs_rule_21 -->">
				<input type="hidden" id="vs_rule_22" name="vs_rule_22" value="<!--# echo vs_rule_22 -->">
				<input type="hidden" id="vs_rule_23" name="vs_rule_23" value="<!--# echo vs_rule_23 -->">
				
				<input type="hidden" id="application_00" name="application_00" value="<!--# echo application_00 -->">
                <input type="hidden" id="application_01" name="application_01" value="<!--# echo application_01 -->">
                <input type="hidden" id="application_02" name="application_02" value="<!--# echo application_02 -->">
                <input type="hidden" id="application_03" name="application_03" value="<!--# echo application_03 -->">
                <input type="hidden" id="application_04" name="application_04" value="<!--# echo application_04 -->">
                <input type="hidden" id="application_05" name="application_05" value="<!--# echo application_05 -->">
                <input type="hidden" id="application_06" name="application_06" value="<!--# echo application_06 -->">
                <input type="hidden" id="application_07" name="application_07" value="<!--# echo application_07 -->">
                <input type="hidden" id="application_08" name="application_08" value="<!--# echo application_08 -->">
                <input type="hidden" id="application_09" name="application_09" value="<!--# echo application_09 -->">
                <input type="hidden" id="application_10" name="application_10" value="<!--# echo application_10 -->">
                <input type="hidden" id="application_11" name="application_11" value="<!--# echo application_11 -->">
                <input type="hidden" id="application_12" name="application_12" value="<!--# echo application_12 -->">
                <input type="hidden" id="application_13" name="application_13" value="<!--# echo application_13 -->">
                <input type="hidden" id="application_14" name="application_14" value="<!--# echo application_14 -->">
                <input type="hidden" id="application_15" name="application_15" value="<!--# echo application_15 -->">
                <input type="hidden" id="application_16" name="application_16" value="<!--# echo application_16 -->">
                <input type="hidden" id="application_17" name="application_17" value="<!--# echo application_17 -->">
                <input type="hidden" id="application_18" name="application_18" value="<!--# echo application_18 -->">
                <input type="hidden" id="application_19" name="application_19" value="<!--# echo application_19 -->">
                <input type="hidden" id="application_20" name="application_20" value="<!--# echo application_20 -->">
                <input type="hidden" id="application_21" name="application_21" value="<!--# echo application_21 -->">
                <input type="hidden" id="application_22" name="application_22" value="<!--# echo application_22 -->">
                <input type="hidden" id="application_23" name="application_23" value="<!--# echo application_23 -->">

				<input type="hidden" id="port_forward_both_00" name="port_forward_both_00" value="<!--# echo port_forward_both_00 -->">
				<input type="hidden" id="port_forward_both_01" name="port_forward_both_01" value="<!--# echo port_forward_both_01 -->">
				<input type="hidden" id="port_forward_both_02" name="port_forward_both_02" value="<!--# echo port_forward_both_02 -->">
				<input type="hidden" id="port_forward_both_03" name="port_forward_both_03" value="<!--# echo port_forward_both_03 -->">
				<input type="hidden" id="port_forward_both_04" name="port_forward_both_04" value="<!--# echo port_forward_both_04 -->">
				<input type="hidden" id="port_forward_both_05" name="port_forward_both_05" value="<!--# echo port_forward_both_05 -->">
				<input type="hidden" id="port_forward_both_06" name="port_forward_both_06" value="<!--# echo port_forward_both_06 -->">
				<input type="hidden" id="port_forward_both_07" name="port_forward_both_07" value="<!--# echo port_forward_both_07 -->">
				<input type="hidden" id="port_forward_both_08" name="port_forward_both_08" value="<!--# echo port_forward_both_08 -->">
				<input type="hidden" id="port_forward_both_09" name="port_forward_both_09" value="<!--# echo port_forward_both_09 -->">
				<input type="hidden" id="port_forward_both_10" name="port_forward_both_10" value="<!--# echo port_forward_both_10 -->">
				<input type="hidden" id="port_forward_both_11" name="port_forward_both_11" value="<!--# echo port_forward_both_11 -->">
				<input type="hidden" id="port_forward_both_12" name="port_forward_both_12" value="<!--# echo port_forward_both_12 -->">
				<input type="hidden" id="port_forward_both_13" name="port_forward_both_13" value="<!--# echo port_forward_both_13 -->">
				<input type="hidden" id="port_forward_both_14" name="port_forward_both_14" value="<!--# echo port_forward_both_14 -->">
				<input type="hidden" id="port_forward_both_15" name="port_forward_both_15" value="<!--# echo port_forward_both_15 -->">
				<input type="hidden" id="port_forward_both_16" name="port_forward_both_16" value="<!--# echo port_forward_both_16 -->">
				<input type="hidden" id="port_forward_both_17" name="port_forward_both_17" value="<!--# echo port_forward_both_17 -->">
				<input type="hidden" id="port_forward_both_18" name="port_forward_both_18" value="<!--# echo port_forward_both_18 -->">
				<input type="hidden" id="port_forward_both_19" name="port_forward_both_19" value="<!--# echo port_forward_both_19 -->">
				<input type="hidden" id="port_forward_both_20" name="port_forward_both_20" value="<!--# echo port_forward_both_20 -->">
				<input type="hidden" id="port_forward_both_21" name="port_forward_both_21" value="<!--# echo port_forward_both_21 -->">
				<input type="hidden" id="port_forward_both_22" name="port_forward_both_22" value="<!--# echo port_forward_both_22 -->">
				<input type="hidden" id="port_forward_both_23" name="port_forward_both_23" value="<!--# echo port_forward_both_23 -->">
				
				<input type="hidden" id="inbound_filter_name_00" name="inbound_filter_name_00" value="<!--# echo inbound_filter_name_00 -->">
				<input type="hidden" id="inbound_filter_name_01" name="inbound_filter_name_01" value="<!--# echo inbound_filter_name_01 -->">
				<input type="hidden" id="inbound_filter_name_02" name="inbound_filter_name_02" value="<!--# echo inbound_filter_name_02 -->">
				<input type="hidden" id="inbound_filter_name_03" name="inbound_filter_name_03" value="<!--# echo inbound_filter_name_03 -->">
				<input type="hidden" id="inbound_filter_name_04" name="inbound_filter_name_04" value="<!--# echo inbound_filter_name_04 -->">
				<input type="hidden" id="inbound_filter_name_05" name="inbound_filter_name_05" value="<!--# echo inbound_filter_name_05 -->">
				<input type="hidden" id="inbound_filter_name_06" name="inbound_filter_name_06" value="<!--# echo inbound_filter_name_06 -->">
				<input type="hidden" id="inbound_filter_name_07" name="inbound_filter_name_07" value="<!--# echo inbound_filter_name_07 -->">
				<input type="hidden" id="inbound_filter_name_08" name="inbound_filter_name_08" value="<!--# echo inbound_filter_name_08 -->">
				<input type="hidden" id="inbound_filter_name_09" name="inbound_filter_name_09" value="<!--# echo inbound_filter_name_09 -->">
				<input type="hidden" id="inbound_filter_name_10" name="inbound_filter_name_10" value="<!--# echo inbound_filter_name_10 -->">
				<input type="hidden" id="inbound_filter_name_11" name="inbound_filter_name_11" value="<!--# echo inbound_filter_name_11 -->">
				<input type="hidden" id="inbound_filter_name_12" name="inbound_filter_name_12" value="<!--# echo inbound_filter_name_12 -->">
				<input type="hidden" id="inbound_filter_name_13" name="inbound_filter_name_13" value="<!--# echo inbound_filter_name_13 -->">
				<input type="hidden" id="inbound_filter_name_14" name="inbound_filter_name_14" value="<!--# echo inbound_filter_name_14 -->">
				<input type="hidden" id="inbound_filter_name_15" name="inbound_filter_name_15" value="<!--# echo inbound_filter_name_15 -->">
				<input type="hidden" id="inbound_filter_name_16" name="inbound_filter_name_16" value="<!--# echo inbound_filter_name_16 -->">
				<input type="hidden" id="inbound_filter_name_17" name="inbound_filter_name_17" value="<!--# echo inbound_filter_name_17 -->">
				<input type="hidden" id="inbound_filter_name_18" name="inbound_filter_name_18" value="<!--# echo inbound_filter_name_18 -->">
				<input type="hidden" id="inbound_filter_name_19" name="inbound_filter_name_19" value="<!--# echo inbound_filter_name_19 -->">
				<input type="hidden" id="inbound_filter_name_20" name="inbound_filter_name_20" value="<!--# echo inbound_filter_name_20 -->">
				<input type="hidden" id="inbound_filter_name_21" name="inbound_filter_name_21" value="<!--# echo inbound_filter_name_21 -->">
				<input type="hidden" id="inbound_filter_name_22" name="inbound_filter_name_22" value="<!--# echo inbound_filter_name_22 -->">
				<input type="hidden" id="inbound_filter_name_23" name="inbound_filter_name_23" value="<!--# echo inbound_filter_name_23 -->">

				<input type="hidden" id="dhcp_list" name="dhcp_list" value="<!--# exec cgi /bin/cmo_get_list dhcpd_leased_table -->">
				<input type="hidden" id="html_response_page" name="html_response_page" value="back.asp" />
				<input type="hidden" id="html_response_return_page" name="html_response_return_page" value="adv_port_range.asp" />

				<input type="hidden" id="dhcp_list" name="dhcp_list" value="" />
				<input type="hidden" id="del" name="del" value="-1" />
				<input type="hidden" id="edit" name="edit" value="-1" />
				<input type="hidden" id="max_row" name="max_row" value="-1" />


<form id="form3">
<div class="box_tn">
	<div class="CT"><script>show_words('_adv_txt_09');</script></div>
	<table cellspacing="0" cellpadding="0" class="formarea">
	<tr>
		<td class="CL"><script>show_words('_adv_txt_00')</script></td>
		<td class="CR">
			<input type="checkbox" id="enable" name="enable" value="1" onclick="changeSense()" />
		</td>
	</tr>
	<tr>
		<td class="CL"><script>show_words('_adv_txt_01');</script></td>
		<td class="CR">
			<input type="text" id="name" name="name" size="16" maxlength="20" onchange="changeSense()" />&nbsp;<<&nbsp;
			
	<!--		<input id=copy_app name=copy_app type=button value="<<" style="width: 23;" /> -->
			<span id="app_list"></span>
		</td>
	</tr>
	<tr>
		<td class="CL"><script>show_words('_ipaddr');</script></td>
		<td class="CR">
			<input type="text" id="ip" name="ip" size="16" maxlength="15" onchange="changeSense()" />
		</td>
	</tr>
	<tr>
		<td class="CL"><script>show_words('help67');</script></td>
		<td class="CR"><input type="text" id="tcp_ports" name="tcp_ports" size="16" onchange="changeSense()" />
		&nbsp;(ex. 80, 689, 50-60, 1020-5000)</td>
	</tr>
	<tr>
		<td class="CL"><script>show_words('help69');</script></td>
		<td class="CR"><input type="text" id="udp_ports" name="udp_ports" size="16" onchange="changeSense()" />
		&nbsp;(ex. 80, 689, 50-60, 1020-5000)</td>
	</tr>
	<tr class="formarea">
		<td class="CL">
			<script>show_words('INBOUND_FILTER');</script></td>
		<td class="CR">
			<span id="pol_list"></span>
			<input type="button" id="ln_btn_1" onclick="location.assign('/adv_inbound_filter.asp');" />
			<script>$('#ln_btn_1').val(get_words('tc_new_inb'));</script>
		</td>
	</tr>
	<tr class="formarea">
		<td class="CL">
			<script>show_words('_sched');</script></td>
		<td class="CR">
			<span id="sche_list"></span>
			<input type="button" id="ln_btn_2" onclick="location.assign('/adv_schedule.asp');" />
			<script>$('#ln_btn_2').val(get_words('tc_new_sch'));</script>
		</td>
		</tr>
	<tr align="center">
		<td colspan="2" class="btn_field">
			<input name="add" type="button" class="ButtonSmall" id="add" onClick="return send_request()" />
			<script>$('#add').val(get_words('_add'));</script>
			<input name="clear" type="button" disabled class="ButtonSmall" id="clear" onClick="document.location.reload();" />
			<script>$('#clear').val(get_words('_clear'));</script>
		</td>
	</tr>
	</table>
</div>
</form>

<div class="box_tn">
	<span id="PFTable"></span>
	<script>

	</script>
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
<script>
		onPageLoad();
</script>
</body>
</html>
