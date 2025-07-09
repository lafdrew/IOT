<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html lang="en-US" xmlns="http://www.w3.org/1999/xhtml" xml:lang="en-US">
<head>
<title>TRENDNET | modelName | Advanced | DMZ</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<link href="/css/style.css" rel="stylesheet" type="text/css" />
<link href="/css/css_router.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="/lang_<!--# echo language -->.js"></script>
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
	var selectIDArray = new Array("", "schedule");

	var menu = new menuObject();
//	menu.setSupportUSB(dev_info.KCode_USB);

	var main = new ccpObject();

	var dev_mode = main.config_val("igd_DeviceMode_");

	var array_enable = [], array_name = [], array_tgport = [], array_fwport = [],
		array_tgprotocol = [], array_fwprotocol = [], array_Schdule = [];
	var array_vs_enable = [], array_vs_proto = [], array_vs_ports = [];
	var array_pf_enable = [], array_pf_ports_tcp = [], array_pf_ports_udp = [];
	var array_sch_inst = [], array_ib_inst = [];

	var wa_http_en 			= main.config_val("igdStorage_Http_Remote_Access_Enable_");
	var wa_https_en 		= main.config_val("igdStorage_Https_Remote_Access_Enable_");
	var wa_http_port 		= main.config_val("igdStorage_Http_Remote_Access_Port_");
	var wa_https_port		= main.config_val("igdStorage_Https_Remote_Access_Port_");

	var schedule_cnt = 0;

	var submit_button_flag = 0;
	var rule_max_num = 24;
	var DataArray = new Array();
	var TotalCnt=0;

	function onPageLoad()
	{
		var rule_value;

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
			array_enable[j] = temp[0];
			array_name[j] = temp[1];
			array_tgprotocol[j] = temp[2];
			array_tgport[j] = temp[3];
			array_fwprotocol[j] = temp[4];
			array_fwport[j] = temp[5];
			array_Schdule[j] = temp[6];
		}

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
			array_pf_enable[j] = temp[0];
			array_pf_ports_tcp[j] = temp[3];
			array_pf_ports_udp[j] = temp[4];
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

		var table_str = '';
			table_str += "<select id=schedule name=schedule style='width:80'>";
			table_str += '<option value=\"Always\">'+get_words('_always')+'</option>';
			table_str += '<option value=\"Never\">'+get_words('_never')+'</option>';
			table_str += add_option('Schedule', array_Schdule);
			table_str += "</select>";
			$('#sche_list').html(table_str);

		set_application();
		paintTable();

		trigger_st();
	}
	
	function Data(enable, name, tgprotocol, tgport, fwprotocol, fwport, schdule, onList)
	{
		this.Enable = enable;
		this.Name = name;
		this.TGprotocol = tgprotocol;
		this.TGport = tgport;
		this.FWprotocol = fwprotocol;
		this.FWport = fwport;
		this.Schdule = schdule;
		this.OnList = onList ;
	}

	function set_application()
	{
		var index = 0;
		for (var i = 0; i < rule_max_num; i++) {
			if(array_name[i] != "" && array_name[i])
			{
				TotalCnt++;
				DataArray[DataArray.length++] =
					new Data(array_enable[i], array_name[i], array_tgprotocol[i], array_tgport[i], array_fwprotocol[i], array_fwport[i], array_Schdule[i], i);
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
			DataArray[i].TGprotocol = DataArray[i+1].TGprotocol;
			DataArray[i].TGport = DataArray[i+1].TGport;
			DataArray[i].FWprotocol = DataArray[i+1].FWprotocol;
			DataArray[i].FWport = DataArray[i+1].FWport;
			DataArray[i].Schdule = DataArray[i+1].Schdule;
			DataArray[i].OnList = DataArray[i+1].OnList;
		}

		if(DataArray.length > 0)
			DataArray.length -- ;

		paintTable();
		clear_reserved();

		AddApptoDatamodel();
	}

	function update_DataArray(st)
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
			DataArray[index] = new Data(is_chk, $('#name').val(), $('#trigger').val(), $('#trigger_port').val(), $('#public').val(), $('#public_port').val(), $('#schedule').val(), index+1);			
		}else if (index != -1){			
			DataArray[index].Enable = is_chk;
			DataArray[index].Name = $('#name').val();
			DataArray[index].TGprotocol = $('#trigger').val();
			DataArray[index].TGport = $('#trigger_port').val();
			DataArray[index].FWprotocol = $('#public').val();
			DataArray[index].FWport = $('#public_port').val();
			DataArray[index].Schdule = $('#schedule').val();
			DataArray[index].OnList = index;
		}
	}

	function clear_reserved()
	{
		$("input[name=sel_del]").each(function () { this.checked = false; });
		set_checked(0, $('#enable')[0]);
		$('#name').val("");
		$('#application').val(0);
		$('#trigger').val(0);
		$('#trigger_port').val("");
		$('#public').val(0);
		$('#public_port').val("");
		$('#schedule').val(255);
		$('#edit').val(-1);
		$('#add').attr('disabled', '');
        $('#clear').attr('disabled', true);
	}

	function edit_row(idx)
    {
		set_checked(DataArray[idx].Enable, $('#enable')[0]);
        $('#name').val(DataArray[idx].Name);
		$('#trigger').val(DataArray[idx].TGprotocol);
        $('#trigger_port').val(DataArray[idx].TGport);
		$('#public').val(DataArray[idx].FWprotocol);
		$('#public_port').val(DataArray[idx].FWport);
		$('#schedule').val(DataArray[idx].Schdule);
		$('#edit').val(idx);
		$('#add').val(get_words('_save'));

		$('#clear').attr('disabled', '');
    }

	function AddApptoDatamodel(st)
	{
		var obj = new ccpObject();
		obj.set_param_url('apply.cgi');
		obj.set_ccp_act('set');
		obj.add_param_event('adv_appl');
		obj.set_param_next_page('adv_port_trigger.asp');
		obj.add_param_arg('reboot_type', 'filter');

		if (st)
			obj.add_param_arg("application_enable",st);

		for(var i=0; i<rule_max_num; i++)
		{
			var key, value;
			if (i<10)
				key = "application_0" + i;
			else
				key = "application_" + i;
			if (i<DataArray.length) {
				value = DataArray[i].Enable + "/" + DataArray[i].Name + "/" +
						DataArray[i].TGprotocol + "/" +	DataArray[i].TGport + "/" +
						DataArray[i].FWprotocol + "/" + DataArray[i].FWport + "/" + 
						DataArray[i].Schdule;
			} else {
				value = ""
			}
			obj.add_param_arg(key,value);
		}

		var paramStr = obj.get_param();
		
		totalWaitTime = 10; //second
		redirectURL = location.pathname;
		wait_page();
		jq_ajax_post(paramStr.url, paramStr.arg);
	}
	
	function set_porttrigger_st()
	{
		var sel = $("#trigger_enable option:selected").val();
		if (!is_form_modified("form3") && !confirm(get_words('_ask_nochange'))) {
			return false;
		}

		if(submit_button_flag == 0){
			update_DataArray();
			paintTable();
			clear_reserved();
			AddApptoDatamodel(sel);
			submit_button_flag = 1;
		}
	}
	
	function send_request()
	{
		var tcp_timeline = '';
		var udp_timeline = '';

		if (!is_form_modified("form3") && !confirm(get_words('_ask_nochange'))) {
			return false;
		}
		
		// add virtual server ports into timeline
		try {
			for (var i=0; i<array_vs_enable.length; i++) {
				if (array_vs_enable[i] == '0')
					continue;
				var vs_ports = array_vs_ports[i].split(',');
				for (var j=0; j<vs_ports.length; j++) {
					var range = vs_ports[j].split('-');
					if (array_vs_proto[i] == '0') {
						tcp_timeline = add_into_timeline(tcp_timeline, range[0], range[1]);
					} else if (array_vs_proto[i] == '1') {
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
		
		// add port forward ports into timeline
		try {
			for (var i=0; i<array_pf_enable.length; i++)
			{
				if (array_pf_enable[i] == '0')
					continue;
				var pf_tcp_ports = array_pf_ports_tcp[i].split(',');
				for (var j=0; j<pf_tcp_ports.length; j++) {
					var range = pf_tcp_ports[j].split('-');
					tcp_timeline = add_into_timeline(tcp_timeline, range[0], range[1]);
				}
				var pf_udp_ports = array_pf_ports_udp[i].split(',');
				for (var j=0; j<pf_udp_ports.length; j++) {
					var range = pf_udp_ports[j].split('-');
					udp_timeline = add_into_timeline(udp_timeline, range[0], range[1]);
				}
			}
		} catch (e) {
			alert('error occur in adding port forward ports into timeline');
		}

		var remote_port_enable="<!--# echo remote_http_management_enable -->";
		var remote_config="<!--# echo https_config -->".split("/");
		var remote_https_en=remote_config[1];
		var reg = /[^0-9\-\,\s]/;
		//add Remote management port to time line
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
//		if(dev_info.KCode_USB && (kcode_ftp_wan=='1'))
//			tcp_timeline = add_into_timeline(tcp_timeline, '21', null);
		
		var count = 0;
		var check_name = $('#name').val();
		var proto_type = $("#public option:selected").val();// $('#public').val();
		var trigger_port = $('#trigger_port').val().split("-");
		var public_port = $('#public_port').val().split(",");
		var is_enable = 0;
		var temp_appl;

		if (check_name != "")
		{
			if (!chk_chars(check_name))
			{
				alert(get_words('_specappsr') + addstr(get_words('_adv_txt_02'), check_name));
				return false;
			}

			var chk_trigger_port="";
			if ($('#trigger_port').val() == ""){
				alert(get_words('TRIGGER_PORT_ERROR', LangMap.msg));
				return false;
			}else if ($('#public_port').val() == ""){
				alert(get_words('PUBLIC_PORT_ERROR', LangMap.msg));
				return false;
			}else if (reg.test($('#trigger_port').val()) == true){
				alert(get_words('APT001'));
				return false;
			}else if (reg.test($('#public_port').val()) == true){
				alert(get_words('APT002'));
				return false;
			}
			
			if(is_number($('#trigger_port').val()))
				$('#trigger_port').val(parseInt($('#trigger_port').val(),10));
			if(is_number($('#public_port').val()))
				$('#public_port').val(parseInt($('#public_port').val(),10));
				
			if (!check_port(trigger_port[0])){
				alert(get_words('TRIGGER_PORT_ERROR', LangMap.msg));
				return false;
			}		  
				chk_trigger_port += parseInt(trigger_port[0],10);
			if (trigger_port.length > 1){
				if (!check_port(trigger_port[1])){
					alert(get_words('TRIGGER_PORT_ERROR', LangMap.msg));
					return false;
				}	
				chk_trigger_port += "-" + parseInt(trigger_port[1],10);
			}
			$('#trigger_port').val(chk_trigger_port);
			
			var tmp_public = $('#public_port').val().split("-");
			if (tmp_public.length ==2 && tmp_public[0] == ""){
				alert(get_words('TRIGGER_PORT_ERROR', LangMap.msg));
				return false;
			}
			
			var chk_public_port="";
			for (var j = 0; j < public_port.length; j++)
			{
				var port = public_port[j].split("-");
				for(var k=0; k<port.length; k++)
				{
					if(port[k]=="")
					{
						alert(get_words('ac_alert_invalid_port'));
						return false;
					}
				}
				
				var temp_port1 = "";
				var temp_port2 = "";
				temp_port1 = port[0];
				
				if (port.length > 1)
					temp_port2 = port[1];
				
				if (temp_port1 != ""){
					if (!check_port(temp_port1)){
						alert(get_words('TRIGGER_PORT_ERROR', LangMap.msg));
						return false;
					}
					chk_public_port += parseInt(temp_port1,10);
				}
				if (temp_port2 != ""){
					if (!check_port(temp_port2)){
						alert(get_words('TRIGGER_PORT_ERROR', LangMap.msg));
						return false;
					}
					chk_public_port += "-" + parseInt(temp_port2,10);
				}
				if(public_port.length>1 && j<public_port.length-1)
					chk_public_port += ",";
			}
			
			$('#public_port').val(chk_public_port);

			//check application firewall port and remote management port conflict problem
			var remote_port = "";
			var remote_port_enable = "";
			if (proto_type == 0) {
				var tcp_ports = $('#public_port').val().split(',');
				for (var j=0; j<tcp_ports.length; j++) {
					var range = tcp_ports[j].split('-');
					tcp_timeline = add_into_timeline(tcp_timeline, range[0], range[1]);
				}
			} else if (proto_type == 1) {
				var udp_ports = $('#public_port').val().split(',');
				for (var j=0; j<udp_ports.length; j++) {
					var range = udp_ports[j].split('-');
					udp_timeline = add_into_timeline(udp_timeline, range[0], range[1]);
				}
			} else {
				var tcp_ports = $('#public_port').val().split(',');
				for (var j=0; j<tcp_ports.length; j++) {
					var range = tcp_ports[j].split('-');
					tcp_timeline = add_into_timeline(tcp_timeline, range[0], range[1]);
				}
				var udp_ports = $('#public_port').val().split(',');
				for (var j=0; j<udp_ports.length; j++) {
					var range = udp_ports[j].split('-');
					udp_timeline = add_into_timeline(udp_timeline, range[0], range[1]);
				}
			}

			for(jj=0;jj<DataArray.length;jj++)
			{
				if($('#edit').val()!=jj){
					if(DataArray[jj].Name==$('#name').val()){
						alert(get_words('ag_inuse'));
						return false;
						break;
					}
					if(DataArray[jj].TGprotocol == $('#trigger').val()){
						if(DataArray[jj].TGport==$('#trigger_port').val()){
							alert(get_words('TEXT057'));	
							return false;
						}
					}
					if(DataArray[jj].FWprotocol == $('#public').val()){
						if(DataArray[jj].FWport == $('#public_port').val()){
							alert(get_words('TEXT057'));	
							return false;
						}
					}
				}
			}
			if (check_timeline(tcp_timeline) == false) {
				alert(addstr(get_words('ag_conflict5'), 'Firewall', $('#public_port').val()));
				return false;
			}
		
			if (check_timeline(udp_timeline) == false) {
				alert(addstr(get_words('ag_conflict5'), 'Trigger', $('#public_port').val()));
				return false;
			}
			count++;
		}  else {
			alert(get_words('pt_name_empty'));
			//change tag from pf_name_empty to pt_name_empty
			return false;
		}
		
		if(submit_button_flag == 0){
			update_DataArray();
			paintTable();
			clear_reserved();
			AddApptoDatamodel();
			submit_button_flag = 1;
		}
		
		return false;
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
				str += ("<option value=" + arr[i] + " >" + arr[i] + "</option>");
			}
		}

		return str;
	}

	function trigger_st()
	{
		if ($("#trigger_enable option:selected").val() == 0)
		{
			$('#table1').hide();
			$('#tb_addrule').hide();
		} else {
			$('#table1').show();
			$('#tb_addrule').show();
		}
	}
			
	function paintTable()
	{
		var get_chk_counts = 0;
		var contain = '<div class="box_tn" id="table1">';
			contain += '<div class="CT">'+get_words('_adv_txt_19')+'</div>';
			contain += '<table align="center" cellpadding="0" cellspacing="0" class="formarea">';
			contain += '<tr class="break_word"><td height="22" align="center" class="CTS" nowrap="nowrap">'+get_words('_enable')+'</td>';
			contain += '<td height="22" align="center" class="CTS" nowrap="nowrap">'+get_words('_adv_txt_01')+'</td>';
			contain += '<td height="22" align="center" class="CTS" nowrap="nowrap">'+get_words('_adv_txt_21')+get_words('_adv_txt_22')+'</td>';
			contain += '<td height="22" align="center" class="CTS" nowrap="nowrap">'+get_words('_adv_txt_22_1')+get_words('_adv_txt_22')+'</td>';
			contain += '<td height="22" align="center" class="CTS" nowrap="nowrap">'+get_words('_sched')+'</td>';
			contain += '<td height="22" align="center" class="CTS" nowrap="nowrap">'+get_words('_edit')+'</td>';
			contain += '<td height="22" align="center" class="CTS" nowrap="nowrap">'+get_words('_delete')+'</td>';
			contain += '</tr>';

		for(var i = 0; i < DataArray.length; i++)
		{
			var is_chk='';
			if (DataArray[i].Enable == 1)
			{
				is_chk = "checked";
				get_chk_counts++;
			}
			contain += '<tr align="center" class="break_word">'+
					'<td align="center" class="CELL"><input type=checkbox id=sel_enable name=sel_enable disabled ' +is_chk+' />'+
					'</td><td align="center" class="CELL">' + DataArray[i].Name +
					'</td><td align="center" class="CELL">' + DataArray[i].FWprotocol + ' - ' + DataArray[i].FWport +
					'</td><td align="center" class="CELL">' + DataArray[i].TGprotocol + ' - ' + DataArray[i].TGport +
					'</td><td align="center" class="CELL">' + DataArray[i].Schdule +
					'</td><td align="center" class="CELL">' +
					'<a href="javascript:edit_row('+ i +')"><img src="edit.gif" border="0" title="'+get_words('_edit')+'" /></a>'+
					'</td><td align="center" class="CELL">' +
					'<a href="javascript:del_row(' + i +')"><img src="delete.gif"  border="0" title="'+get_words('_delete')+'" /></a>'+
					'</td>';
		}
		contain += '</tr>';
		contain += '</table>';
		contain += '</div>';
		$('#PFTable').html(contain);
		
		var set_trigger_enable = <!--# echo application_enable -->;
		set_selectIndex(set_trigger_enable, $('#trigger_enable')[0]);

		set_form_default_values("form3");
	}

	function changeSense()
	{
		if( $('input[name=enable]').attr('checked') != false ||
			$('#name').val() != '' ||
			$('#trigger').val() != 'TCP' ||
			$('#trigger_port').val() != '' ||
			$('#public').val() != 'TCP' ||
			$('#public_port').val() != '')
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
				<script>document.write(menu.build_structure(1,5,2))</script>
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
								<script>show_words('_specapps');</script>
								</div>
								<div class="hr"></div>
								<div class="section_content_border">
								<div class="header_desc" id="introduction">
									<script>show_words('_adv_txt_13');</script>
									<p></p>
								</div>

			<form id="form1" name="form1" method="post" action="get_set.ccp">
				<input type="hidden" id="del" name="del" value="-1" />
				<input type="hidden" id="edit" name="edit" value="-1" />
				<input type="hidden" id="max_row" name="max_row" value="-1" />
			</form>
<form id="form3">
<div class="box_tn">
	<div class="CT"><script>show_words('_adv_txt_15');</script></div>
	<table cellspacing="0" cellpadding="0" class="formarea">
	<tr>
		<td class="CL"><script>show_words('_adv_txt_18');</script></td>
		<td class="CR">
			<select id="trigger_enable" name="trigger_enable" onchange="trigger_st()">
				<option value="0"><script>show_words('_disable');</script></option>
				<option value="1"><script>show_words('_enable');</script></option>
			</select>
		</td>
	</tr>
	<tr align="center">
			<td colspan="2" class="btn_field">
		<input name="apply" type="button" class="ButtonSmall" id="apply" onClick="set_porttrigger_st()" />
			<script>$('#apply').val(get_words('_adv_txt_17'));</script>
		</td>
	</tr>
	</table>
</div>

<div class="box_tn">
	<div class="CT"><script>show_words('_adv_txt_16');</script></div>
	<table cellspacing="0" cellpadding="0" class="formarea">
	<tr>
		<td class="CL"><script>show_words('_adv_txt_00')</script></td>
		<td class="CR" width="340">
			<input type="checkbox" id="enable" name="enable" value="1" onclick="changeSense()" />
		</td>
	</tr>
	<tr>
		<td class="CL"><script>show_words('_adv_txt_01');</script></td>
		<td class="CR">
			<input type="text" id="name" name="name" size="16" maxlength="15" onchange="changeSense()" />
		</td>
	</tr>
	<tr>
		<td class="CL"><script>show_words('_adv_txt_20');</script></td>
		<td class="CR">
			<select class="wordstyle" id="public" onchange="changeSense()">
			<option value="TCP"><script>show_words('_TCP');</script></option>
			<option value="UDP"><script>show_words('_UDP');</script></option>
			<option value="ANY"><script>show_words('at_Any');</script></option>
			</select>
		</td>
	</tr>
	<tr>
		<td class="CL"><script>show_words('_adv_txt_21');</script></td>
		<td class="CR">
			<input type="text" id="public_port" name="public_port" style="width:150;" size="16" maxlength="15" onchange="changeSense()" />
		</td>
	</tr>
	<tr>
		<td class="CL"><script>show_words('as_TPR');</script></td>
		<td class="CR">
			<select class="wordstyle" id="trigger" onchange="changeSense()">
			<option value="TCP"><script>show_words('_TCP');</script></option>
			<option value="UDP"><script>show_words('_UDP');</script></option>
			<option value="ANY"><script>show_words('at_Any');</script></option>
			</select>
		</td>
	</tr>
	<tr>
		<td class="CL"><script>show_words('GW_NAT_TRIGGER_PORT');</script></td>
		<td class="CR">
			<input type="text" id="trigger_port" name="trigger_port" style="width:150;" size="16" maxlength="15" onchange="changeSense()" />
		</td>
	</tr>
	<tr>
		<td class="CL">
			<script>show_words('_sched');</script></td>
		<td class="CR">
			<span id="sche_list"></span>
			<input type="button" id="ln_btn_1" onclick="location.assign('/adv_schedule.asp');" />
			<script>$('#ln_btn_1').val(get_words('tc_new_sch'));</script>
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
	<br/>
	<span id="PFTable"></span>
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
<script>
	onPageLoad();
</script>
</html>
