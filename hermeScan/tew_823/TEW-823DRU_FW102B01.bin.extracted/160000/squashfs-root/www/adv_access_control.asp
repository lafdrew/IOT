<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html lang="en-US" xmlns="http://www.w3.org/1999/xhtml" xml:lang="en-US">
<head>
<script>
	var funcWinOpen = window.open;
</script>
<title>TRENDNET | modelName | Advanced | Access Control</title>
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
	
	var isok=true;
	var maxACRule = 24;
	var total_page = 8;
	var pfRuleMax = 8;
	var editRow = -1;
	var editPageLoad = 0;
	var pPage = 1;
	var p5MachList = null;
	var is_modified = 0;
	var rule_max_num = 25;
	var DataArray_schedule = new Array();
	var DataArray_access_pre = new Array();
	var DataArray_access = new Array();
	var DataArray_access_all = new Array();
	var DataArray_access_website = new Array();
	var DataArray = new Array();
	var user_define = 0;
	var port_edit_control_list="", ip_edit_control_list="", url_edit_control_list="", strGet_url = "";
	var array_enable = [], array_name = [], array_intnlip = [], array_mac = [],  array_Schdule = [];
	
		function Data(enable, name, ip_addr, mac, schdule, onList)
	{
		this.Enable = enable;
		this.Name = name;
		this.Ip_addr = ip_addr;
		this.MAC = mac; 
		this.Schdule = schdule;
		this.OnList = onList ;
	
	}


	function Data_schedule(onList, name)
	{
		this.OnList = onList ;
		this.Name = name;
	}	
	
	function Data_access(enable, name, schedule, src_ip_start, src_ip_end, tcp_port, udp_port, onList)
	{
		this.Enable = enable;
		this.Name = name;
		this.Schedule = schedule;
		this.Src_ip_start = src_ip_start;
		this.Src_ip_end = src_ip_end;
		this.Tcp_port = tcp_port;
		this.Udp_port = udp_port;
		this.OnList = onList ;
	}	
	
	function Data_access_all(enable, name, src_ip, schedule, onList)
	{
		this.Enable = enable;
		this.Name = name;
		this.Src_ip = src_ip;
		this.Schedule = schedule;
		this.OnList = onList ;
	}	

	function Data_access_website(enable, name, website_url, schedule, onList)
	{
		this.Enable = enable;
		this.Name = name;
		this.Website_url = website_url;
		this.Schedule = schedule;
		this.OnList = onList ;
	}	


	/** misc functions */
	function get_by_name(name){
		return document.getElementsByName(name);
	}
	
	function mySqrt(num, base)
	{
		if(num % base != 0)
			return -1;
		var ret = 1;
		
		while(num / base != 1)
		{
			ret++;
			num = num / base;
		}
		return ret;
	}
	
	function calculate_ipMask(maskBit)
	{
		/** calculate the mask ip */
		var ipMask = new Array(0,0,0,0);
		
		for(var idx=0 ; idx<4 ; idx++)
		{
			if(maskBit<=0)
				continue;
			
			if(maskBit>=8)
			{
				ipMask[idx] = 255;
			}
			else
			{
				maskBit = 8 - maskBit;
				ipMask[idx] = 256 - Math.pow(2,maskBit);
			}
			maskBit -= 8;
		}
		
		return ipMask[0] + "." + ipMask[1] + "." + ipMask[2] + "." + ipMask[3];
	}
	
	function ipMast_to_Num(mask)
	{
		if(mask==null || mask.length==0)
			return 0;
			
		var masks = mask.split(".");
		
		if(masks.length != 4)
			return 0;
		
		var maskBit = 0;
		
		for(var idx=0 ; idx<masks.length ; idx++)
		{
			if(masks[idx].length==0)
				return 0;
			
			var intMask = parseInt(masks[idx]);
			
			if(intMask == 255)
				maskBit += 8;
			else
			{
				maskBit += (8 - mySqrt(256- intMask,2));
			}
		}
		
		return maskBit;
	}
	/*
	** Date:	2013-05-10
	** Author:	Moa Chung
	** Reason:	schedule option to Always and Never
	**/
	function makeScheduleHTML(schId, selectIdx)
	{
		var tmp_schedule_rule = "";
		for (var i = 0; i < 32; i++) {
			if(i < 10){
				var temp_rule = get_by_id("schedule_rule_0" + i).value;
			}else{
				var temp_rule = get_by_id("schedule_rule_" + i).value;
			}
			var rule = temp_rule.split("/");
			if(rule[0]!="")
			{
				DataArray_schedule[DataArray_schedule.length++] = new Data_schedule(i, rule[1]);
			}
		}
		
		var html='<select id="' + schId + '" name="' + schId + '">';
		html+='<option value="255"'+(255==selectIdx?' selected="selected"':'')+'>'+get_words('_always')+'</option>';
		html+='<option value="254"'+(254==selectIdx?' selected="selected"':'')+'>'+get_words('_never')+'</option>';
		for(var idx=0 ; idx< sch_obj.cnt ; idx++)
		{
		
			html+= '<option value=' + (idx+1) + ' ' + (idx+1==selectIdx?'selected="selected"':'') + ' >' + DataArray_schedule.OnList[idx] + '</option>';
		}
		
		var obj = null;
		var arr = null;
		var nam = null;
	
		obj = schedule_cnt;
		nam = schCfg.name;
	
		if (obj == null){
			html += '</select>';
			return html;
		}else{
			for (var i = 0; i < obj; i++){
				if(i<10){
					html+= '<option value=0' + schedule_index[i] + '>' + nam[i]  + '</option>';		
				}else{
					html+= '<option value=' + schedule_index[i] + '>' + nam[i]  + '</option>';		
				}
			}
			html += '</select>';
			return html;
		}		
	}
	
	/** misc function End */
	
	var acGlobalEnable 	= "<!--# echo acl_enable -->";	
	var PortRangeObj = {
		"count":10,"enable":["0","0","0","0","0","0","0","0","0","0"],"name":["","","","","","","","","",""],"schedule":["255","255","255","255","255","255","255","255","255","255"],"ipStart":["0.0.0.0","0.0.0.0","0.0.0.0","0.0.0.0","0.0.0.0","0.0.0.0","0.0.0.0","0.0.0.0","0.0.0.0","0.0.0.0"],"ipEnd":["0.0.0.0","0.0.0.0","0.0.0.0","0.0.0.0","0.0.0.0","0.0.0.0","0.0.0.0","0.0.0.0","0.0.0.0","0.0.0.0"],"isUser":["0","0","0","0","0","0","0","0","0","0"],"tcpPorts":["","","","","","","","","",""],"udpPorts":["","","","","","","","","",""],"WWWEnable":["0","0","0","0","0","0","0","0","0","0"],"SMTPEnable":["0","0","0","0","0","0","0","0","0","0"],"POP3Enable":["0","0","0","0","0","0","0","0","0","0"],"FTPEnable":["0","0","0","0","0","0","0","0","0","0"],"TELNETEnable":["0","0","0","0","0","0","0","0","0","0"],"DNSEnable":["0","0","0","0","0","0","0","0","0","0"],"TCPEnable":["0","0","0","0","0","0","0","0","0","0"],"UDPEnable":["0","0","0","0","0","0","0","0","0","0"]
	};

	var IPRuleObj = {
		"count":10,"enable":["0","0","0","0","0","0","0","0","0","0"],"name":["","","","","","","","","",""],"ipStart":["0.0.0.0","0.0.0.0","0.0.0.0","0.0.0.0","0.0.0.0","0.0.0.0","0.0.0.0","0.0.0.0","0.0.0.0","0.0.0.0"],"ipEnd":["0.0.0.0","0.0.0.0","0.0.0.0","0.0.0.0","0.0.0.0","0.0.0.0","0.0.0.0","0.0.0.0","0.0.0.0","0.0.0.0"],"ipMask":["0.0.0.0","0.0.0.0","0.0.0.0","0.0.0.0","0.0.0.0","0.0.0.0","0.0.0.0","0.0.0.0","0.0.0.0","0.0.0.0"],"schedule":["255","255","255","255","255","255","255","255","255","255"]
	};
	
	var sch_obj = {
		"cnt":0,"inst":null,"name":null,"allweek":null,"days":null,"allday":null,"timeformat":null,"start_h":null,"start_mi":null,"start_me":null,"end_h":null,"end_mi":null,"end_me":null
	};	
	
	var schedule_cnt = 0;
	var schedule_index=[];
	var schCfg = {
		'name':              ['<!--# echo schedule_rule_00 -->', '<!--# echo schedule_rule_01 -->', '<!--# echo schedule_rule_02 -->',
		                      '<!--# echo schedule_rule_03 -->', '<!--# echo schedule_rule_04 -->', '<!--# echo schedule_rule_05 -->',
		                      '<!--# echo schedule_rule_06 -->', '<!--# echo schedule_rule_07 -->', '<!--# echo schedule_rule_08 -->',
		                      '<!--# echo schedule_rule_09 -->', '<!--# echo schedule_rule_10 -->', '<!--# echo schedule_rule_11 -->',
		                      '<!--# echo schedule_rule_12 -->', '<!--# echo schedule_rule_13 -->', '<!--# echo schedule_rule_14 -->',
		                      '<!--# echo schedule_rule_15 -->', '<!--# echo schedule_rule_16 -->', '<!--# echo schedule_rule_17 -->',
		                      '<!--# echo schedule_rule_18 -->', '<!--# echo schedule_rule_19 -->', '<!--# echo schedule_rule_20 -->',
		                      '<!--# echo schedule_rule_21 -->', '<!--# echo schedule_rule_22 -->', '<!--# echo schedule_rule_23 -->',
		                      '<!--# echo schedule_rule_24 -->', '<!--# echo schedule_rule_25 -->', '<!--# echo schedule_rule_26 -->',
		                      '<!--# echo schedule_rule_27 -->', '<!--# echo schedule_rule_28 -->', '<!--# echo schedule_rule_29 -->',
		                      '<!--# echo schedule_rule_30 -->', '<!--# echo schedule_rule_31 -->'
		                     ]
	};	
	
	//user define schedule		
	if(schCfg.name != null)
		schedule_cnt = schCfg.name.length;
		
	for (var i = 0, tmp; i < schedule_cnt; ++i) {
		tmp = schCfg.name[i].split("/");
		
		if(tmp == "") {
			schedule_cnt = i;
			break;
		}
		
		schCfg.name[i] = tmp[0];
		schedule_index[i] = i;
	}		
		
	$(document).ready( function () {
		/** Hide all elements first if disable */
		switchAccessControl(acGlobalEnable, true);
		
		
		var rule_value;
		var TotalCnt=0;
		// get acl_parent_XX value
		for (j=0; j<rule_max_num; j++) {
			if (j > 9){
				rule_value = (get_by_id("acl_parent_" + j).value);
			}else{
				rule_value = (get_by_id("acl_parent_0" + j).value);				
			}				  
			
			if (rule_value == ""){
				break;
			}
			
			temp = rule_value.split("/");
			array_enable[j] = temp[0];
			array_name[j] = temp[1];
			array_intnlip[j] = temp[2]; //ip
			array_mac[j] = temp[3]; //mac			
			array_Schdule[j] = temp[4];
		}
			var index = 0;
		for (var i = 0; i < rule_max_num; i++) {
			if(array_name[i] != "" && array_name[i])
			{
				TotalCnt++;
				//DataArray[DataArray.length++] = new Data(array_enable[i], array_name[i], array_intnlip[i], array_TCPPort[i], array_UDPPort[i], array_Schdule[i], array_Policy[i], i);
				DataArray[DataArray.length++] = new Data(array_enable[i], array_name[i], array_intnlip[i], array_mac[i], array_Schdule[i], i);
			}
		}

		$('#max_row').val(index-1);	  
		
	});
	
	var url_action = "<!--# echo acl_url_filter_enable -->";	

	/** Define of specialService list */
	/** spsName, spsDesp content can use get from language table and fill in */
	var spsName = new Array(get_words('_www'),get_words('_email_sending'),get_words('_email_receiving'),get_words('_file_transfer_l'),get_words('_telnet_service'),get_words('_dns_query'),get_words('_tcp_protocol'),get_words('_udp_protocol'));
	var spsDesp = new Array("HTTP, TCP Port80","SMTP, TCP Port 25","POP3, TCP Port 110","FTP, TCP Port 21","TCP Port 23","UDP Port 53","All TCP Port","All UDP Port");
	var spsPort = [{"TCP":"80","UDP":""},{"TCP":"25","UDP":""},{"TCP":"110","UDP":""},{"TCP":"21","UDP":""},{"TCP":"23","UDP":""},{"TCP":"","UDP":"53"},{"TCP":"0-65535","UDP":""},{"TCP":"","UDP":"0-65535"}];
	var spsChkId = new Array("WWWEnable","SMTPEnable","POP3Enable","FTPEnable","TELNETEnable","DNSEnable","TCPEnable","UDPEnable");
	
	function showSpecialService()
	{
		var inHtml = "";
		
		for(var idx=0 ; idx<spsName.length ; idx++)
		{
			inHtml += "<tr id=\"specianRule_" + idx + "\">";			
			inHtml += "<td class=\"CELL\">" + spsName[idx] + "</td>";
			inHtml += "<td class=\"CELL\">" + spsDesp[idx] + "</td>";
			inHtml += "<td class=\"CELL\"><input type=\"checkbox\" id=\"" + spsChkId[idx] + "\" /></td>";
			inHtml += "</tr>";
		}
		document.write(inHtml);
	}
	
	function edit_showSpecialService()
	{
		var inHtml = "";
		
		for(var idx=0 ; idx<spsName.length ; idx++)
		{
			inHtml += "<tr id=\"edit_specianRule_" + idx + "\">";			
			inHtml += "<td class=\"CELL\">" + spsName[idx] + "</td>";
			inHtml += "<td class=\"CELL\">" + spsDesp[idx] + "</td>";
			inHtml += "<td class=\"CELL\"><input type=\"checkbox\" id=\"edit_" + spsChkId[idx] + "\" /></td>";
			inHtml += "</tr>";
		}
		document.write(inHtml);
	}
	
	
	
	/** Radio switch functions */
	
	/** This array can't contain "Edit" elements */
	var acElements = new Array("addNewPolicyMain","policyList"
		,"addNewIPBlock","ipList"
		,"URLBlock_Action"
		,"addNewURLBlock_Allow","URLList_Allow"
		,"addNewURLBlock","URLList");
	
	function switchAccessControl(val, isPageLoad)
	{
		if(!isPageLoad)
			$("#status_menu").show();
		get_by_name("AccessControlEnable")[1-val].checked = true;
		for(var idx=0 ; idx<acElements.length ; idx++)
		{
			if(val==1)
				$("#" + acElements[idx]).show(); 
			else
				$("#" + acElements[idx]).hide();
		}
		
		//load IGD_URLFilter_Action
		var tmp_url_action = url_action.split("/");
		if (tmp_url_action[0] == "0"){ //disable
			$('#url_domain_filter_type').val(tmp_url_action[0]);
		}else{
			if (tmp_url_action[1] == "list_deny"){
				$('#url_domain_filter_type').val(1);
			}else if (tmp_url_action[1] == "list_allow"){
				$('#url_domain_filter_type').val(2);
			}
		}
		
		url_domain_action();
	}
	
	function switchPortRule(val)
	{
		/** 1=User Define, 0=Special Service */
		if(val==1)
		{
			/** display TCP/UDP setting */
			$("#userDefineTCP").show();
			$("#userDefineUDP").show();
			
			/** Hide others */
			for(var idx=0 ; idx<spsName.length ; idx++)
				$("#specianRule_"+idx+"").hide();
			
			$("#specialServiceTitle").hide();
		}
		else
		{
			$("#userDefineTCP").hide();
			$("#userDefineUDP").hide();
			for(var idx=0 ; idx<spsName.length ; idx++)			
				$("#specianRule_"+idx+"").show();
			
			$("#specialServiceTitle").show();
		}
	}
	
	function edit_switchPortRule(val)
	{
		/** 1=User Define, 0=Special Service */
		if(val==1)
		{
			/** display TCP/UDP setting */
			$("#edit_userDefineTCP").show();
			$("#edit_userDefineUDP").show();
			
			/** Hide others */
			for(var idx=0 ; idx<spsName.length ; idx++)
				$("#edit_specianRule_"+idx+"").hide();
			
			$("#edit_specialServiceTitle").hide();
		}
		else
		{
			$("#edit_userDefineTCP").hide();
			$("#edit_userDefineUDP").hide();
			for(var idx=0 ; idx<spsName.length ; idx++)			
				$("#edit_specianRule_"+idx+"").show();
			
			$("#edit_specialServiceTitle").show();
		}
	}
	
	/** Edit functions */
	function url_editRow_Allow(rowIdx)
	{
		$("#editURLIdx_Allow").val(rowIdx-1);
		/** Fill edit data */
		if(DataArray_access_website[rowIdx-1].Enable=="1")
			$("#edit_URLEnable_Allow")[0].checked = true;
		else
			$("#edit_URLEnable_Allow")[0].checked = false;
		
		$("#edit_URLscheduleField_Allow").html(makeScheduleHTML("sch_URLEdit_Allow",DataArray_access_website[rowIdx-1].Schedule));
		$("#edit_URLName_Allow").val(DataArray_access_website[rowIdx-1].Name);
		$("#edit_URLRule_Allow").val(DataArray_access_website[rowIdx-1].Website_url);
		$('#urlFilterSchedule').val(DataArray_access_website[rowIdx-1].Schedule);
		$("#editURLBlock_Allow").show();
		$("#addNewURLBlock_Allow").hide();
	}
	function url_editRow(rowIdx)
	{
		$("#editURLIdx").val(rowIdx-1);

		/** Fill edit data */		
		if(DataArray_access_website[rowIdx-1].Enable=="1")
			$("#edit_URLEnable")[0].checked = true;
		else
			$("#edit_URLEnable")[0].checked = false;
		
		$("#edit_URLscheduleField").html(makeScheduleHTML("sch_URLEdit",DataArray_access_website[rowIdx-1].Schedule));
		$("#edit_URLName").val(DataArray_access_website[rowIdx-1].Name);
		$("#edit_URLRule").val(DataArray_access_website[rowIdx-1].Website_url);
		$('#urlFilterSchedule').val(DataArray_access_website[rowIdx-1].Schedule);
		$("#editURLBlock").show();
		$("#addNewURLBlock").hide();
	}
	
	function url_setEdit_Allow()
	{
		var row = $("#editURLIdx_Allow").val();
		if(!check_URL_filter($("#edit_URLName_Allow").val(), $("#edit_URLRule_Allow").val(), row))
			return;
		
		/** TODO : Set schedule */
		var tmp_sch ="";
		if ($("#sch_URLEdit").val() == "255")
			tmp_sch="-1";
		else
			tmp_sch=$("#sch_URLEdit").val();
		
		DataArray_access_website[row].Enable = ($("#edit_URLEnable")[0].checked? "1":"0");
		DataArray_access_website[row].Name = $("#edit_URLName").val();
		DataArray_access_website[row].Website_url= $("#edit_URLRule").val();
		DataArray_access_website[row].Schedule = tmp_sch;
		DataArray_access_website[row].OnList = row;
		url_submitEidt_Allow(row);
	}
	
	function url_setEdit()
	{
		var row = $("#editURLIdx").val();
		if(!check_URL_filter($("#edit_URLName").val(), $("#edit_URLRule").val(), row))
			return;

		/** TODO : Set schedule */
		var tmp_sch ="";
		if ($("#sch_URLEdit").val() == "255")
			tmp_sch="-1";
		else
			tmp_sch=$("#sch_URLEdit").val();
		
		DataArray_access_website[row].Enable = ($("#edit_URLEnable")[0].checked? "1":"0");
		DataArray_access_website[row].Name = $("#edit_URLName").val();
		DataArray_access_website[row].Website_url= $("#edit_URLRule").val();
		DataArray_access_website[row].Schedule = tmp_sch;
		DataArray_access_website[row].OnList = row;
		url_submitEidt(row);
	}
	
	function url_deleteRow_Allow(rowIdx)
	{
		DataArray_access_website[rowIdx-1].Enable= "-1";
		DataArray_access_website[rowIdx-1].Name= "";
		DataArray_access_website[rowIdx-1].Schedule= "";
		DataArray_access_website[rowIdx-1].Website_url= "";
		url_edit_control_list = "";
		url_submitEidt_Allow(rowIdx-1);
	}
	
	function url_deleteRow(rowIdx)
	{
		DataArray_access_website[rowIdx-1].Enable= "-1";
		DataArray_access_website[rowIdx-1].Name= "";
		DataArray_access_website[rowIdx-1].Schedule= "";
		DataArray_access_website[rowIdx-1].Website_url= "";
		url_edit_control_list = "";
		url_submitEidt(rowIdx-1);
	}
	
	function url_submitEidt_Allow(row)
	{
		var obj = new ccpObject();
		obj.set_param_url('apply.cgi');
		obj.set_ccp_act('set');
		obj.set_param_next_page('adv_access_control.asp');
		obj.add_param_event('adv_filters_url');
		var count = 0;
		for (var i = 0; i < DataArray_access_website.length; i++)
		{
			if (DataArray_access_website[i].Enable != "-1")
			{
				url_edit_control_list = DataArray_access_website[i].Enable + "/" + DataArray_access_website[i].Name + "/" + DataArray_access_website[i].Website_url + "/" + DataArray_access_website[i].Schedule;
				if(count < 10){
					obj.add_param_arg('acl_url_filter_0'+ count, url_edit_control_list);
				}else{
					obj.add_param_arg('acl_url_filter_'+ count, url_edit_control_list);
				}
			count++;
			}
		}
		
		obj.add_param_arg('reboot_type','filter');
		var sel_action = $('#url_domain_filter_type').val();
		var tmp_sel_action="";
		switch (sel_action) {
		case "0":
		default:
				tmp_sel_action = "0/list_deny";
				break;
		case "1":
				tmp_sel_action = "1/list_deny";
				break;
		case "2":
				tmp_sel_action = "1/list_allow";
				break;
		}
		//save url data end
		for(var i=0; i<DataArray.length; i++)
		{
			var key, value;
			if (i<10)
				key = "acl_parent_0" + i;
			else
				key = "acl_parent_" + i;

			value = DataArray[i].Enable + "/" + DataArray[i].Name + "/" + DataArray[i].Ip_addr + "/" +
					DataArray[i].MAC + "/" + DataArray[i].Schdule;
			obj.add_param_arg(key,value);
		}
		obj.add_param_arg('acl_url_filter_enable',tmp_sel_action);
		var param = obj.get_param();
		totalWaitTime = 20; //second
		redirectURL = location.pathname;
		wait_page();
		jq_ajax_post(param.url, param.arg);
	}
	
	function url_submitEidt(row)
	{
		var obj = new ccpObject();
		obj.set_param_url('apply.cgi');
		obj.set_ccp_act('set');
		obj.set_param_next_page('adv_access_control.asp');
		obj.add_param_event('adv_filters_url');
		var count = 0;
		for (var i = 0; i < DataArray_access_website.length; i++)
		{
			if (DataArray_access_website[i].Enable != "-1")
			{
				url_edit_control_list = DataArray_access_website[i].Enable + "/" + DataArray_access_website[i].Name + "/" + DataArray_access_website[i].Website_url + "/" + DataArray_access_website[i].Schedule;
				if(count < 10){
					obj.add_param_arg('acl_url_filter_0'+ count, url_edit_control_list);
				}else{
					obj.add_param_arg('acl_url_filter_'+ count, url_edit_control_list);
				}
			count++;
			}
		}
		
		var sel_action = $('#url_domain_filter_type').val();
		var tmp_sel_action="";
		switch (sel_action) {
		case "0":
		default:
				tmp_sel_action = "0/list_deny";
				break;
		case "1":
				tmp_sel_action = "1/list_deny";
				break;
		case "2":
				tmp_sel_action = "1/list_allow";
				break;
		}
		
		//save url data end
		for(var i=0; i<DataArray.length; i++)
		{
			var key, value;
			if (i<10)
				key = "acl_parent_0" + i;
			else
				key = "acl_parent_" + i;

			value = DataArray[i].Enable + "/" + DataArray[i].Name + "/" + DataArray[i].Ip_addr + "/" +
					DataArray[i].MAC + "/" + DataArray[i].Schdule;
			obj.add_param_arg(key,value);
		}
		
		obj.add_param_arg('acl_url_filter_enable',tmp_sel_action);
		obj.add_param_arg('reboot_type','filter');
		var param = obj.get_param();
		totalWaitTime = 20; //second
		redirectURL = location.pathname;
		wait_page();
		jq_ajax_post(param.url, param.arg);
	}
	
	function url_cancelEdit_Allow()
	{
		$("#editURLIdx_Allow").val(-1);
		$("#editURLBlock_Allow").hide();
		$("#addNewURLBlock_Allow").show();
	}
	
	function url_cancelEdit()
	{
		$("#editURLIdx").val(-1);
		$("#editURLBlock").hide();
		$("#addNewURLBlock").show();
	}
	
	/** Edit - Port */
	function cleanPortServices(edit)
	{
		$("#" + edit +"WWWEnable")[0].checked = false;
		$("#" + edit +"SMTPEnable")[0].checked = false;	
		$("#" + edit +"POP3Enable")[0].checked = false;	
		$("#" + edit +"FTPEnable")[0].checked = false;	
		$("#" + edit +"TELNETEnable")[0].checked = false;	
		$("#" + edit +"DNSEnable")[0].checked = false;	
		$("#" + edit +"TCPEnable")[0].checked = false;	
		$("#" + edit +"UDPEnable")[0].checked = false;
	}
	
	function cleanUserDef(edit)
	{
		$("#" + edit + "edit_portRuleTCP").val("");
		$("#" + edit + "edit_portRuleUDP").val("");
	}
	
	function port_editRow(rowIdx)
	{
		$("#editPortIdx").val(rowIdx-1);
		user_define = 1;
		
		/** Fill edit data */		
		if(DataArray_access[rowIdx-1].Enable=="1")
			$("#edit_ruleEnable")[0].checked = true;
		else
			$("#edit_ruleEnable")[0].checked = false;
		
		$("#edit_ruleName").val(DataArray_access[rowIdx-1].Name);
		$("#edit_ipaddr_start").val(DataArray_access[rowIdx-1].Src_ip_start);
		$("#edit_ipaddr_end").val(DataArray_access[rowIdx-1].Src_ip_end);
		
		get_by_name("edit_ruleDefine")[1].checked = true;
		edit_switchPortRule(1);

		// clear checkbox
		$("#edit_portRuleTCP").val(DataArray_access[rowIdx-1].Tcp_port);
		$("#edit_portRuleUDP").val(DataArray_access[rowIdx-1].Udp_port);
		
		$('#sch_PortEdit').val(DataArray_access[rowIdx-1].Schedule);
		$("#edit_scheduleField").html(makeScheduleHTML("sch_PortEdit",DataArray_access[rowIdx-1].Schedule));
		$("#editPolicyMain").show();
		$("#addNewPolicyMain").hide();
	}
		
	
	function port_editRow_pre(rowIdx)
	{
		$("#editPortIdx").val(rowIdx-1);
		user_define = 0;
		
		/** Fill edit data */		
		if(DataArray_access_pre[rowIdx-1].Enable=="1")
			$("#edit_ruleEnable")[0].checked = true;
		else
			$("#edit_ruleEnable")[0].checked = false;
		
		$("#edit_ruleName").val(DataArray_access_pre[rowIdx-1].Name);
		$("#edit_ipaddr_start").val(DataArray_access_pre[rowIdx-1].Src_ip_start);
		$("#edit_ipaddr_end").val(DataArray_access_pre[rowIdx-1].Src_ip_end);
		
		get_by_name("edit_ruleDefine")[0].checked = true;
		edit_switchPortRule(0);

		// clear checkbox
		for(var i=0 ; i<spsChkId.length ; i++)
		{
			$("#edit_"+spsChkId[i]).attr('checked','');
		}
		
		/** Fill in service enable */
		//edit_
		var tmp_tcp = DataArray_access_pre[rowIdx-1].Tcp_port.split(",");
		var tmp_udp = DataArray_access_pre[rowIdx-1].Udp_port.split(",");
		for (i=0; i<tmp_tcp.length; i++)
		{
			if (tmp_tcp[i] == "80")
				$("#edit_WWWEnable")[0].checked = true;
			if (tmp_tcp[i] == "25")
				$("#edit_SMTPEnable")[0].checked = true;
			if (tmp_tcp[i] == "110")
				$("#edit_POP3Enable")[0].checked = true;
			if (tmp_tcp[i] == "21")
				$("#edit_FTPEnable")[0].checked = true;
			if (tmp_tcp[i] == "23")
				$("#edit_TELNETEnable")[0].checked = true;
			if (tmp_udp[i] == "53")
				$("#edit_DNSEnable")[0].checked = true;
			if (tmp_udp[i] == "0-65535"){
				$("#edit_DNSEnable")[0].checked = true;
				$("#edit_UDPEnable")[0].checked = false;
			}
			if (tmp_tcp[i] == "0-65535"){
				$("#edit_TCPEnable")[0].checked = true;
				$("#edit_WWWEnable")[0].checked = false;
				$("#edit_SMTPEnable")[0].checked = false
				$("#edit_POP3Enable")[0].checked = false;
				$("#edit_FTPEnable")[0].checked = false;
				$("#edit_TELNETEnable")[0].checked = false;
			}
		}
		
		
		$("#edit_scheduleField").html(makeScheduleHTML("sch_PortEdit",DataArray_access_pre[rowIdx-1].Schedule));
		$('#sch_PortEdit').val(DataArray_access_pre[rowIdx-1].Schedule);
		$("#editPolicyMain").show();
		$("#addNewPolicyMain").hide();
	}
	
	function port_setEdit()
	{
		var ip_addr_msgs = replace_msg(all_ip_addr_msg,get_words('IPv6_addrSr'));
		var ip_addr_msge = replace_msg(all_ip_addr_msg,get_words('IPv6_addrEr'));
		var temp_start_ip = new addr_obj($("#edit_ipaddr_start").val().split("."), ip_addr_msgs, false, false);
		var temp_end_ip = new addr_obj($("#edit_ipaddr_end").val().split("."), ip_addr_msge, false, false);
		if (!check_ip_order(temp_start_ip, temp_end_ip)){
			alert(get_words('TEXT039'));
			return;
		}
		
		var row = $("#editPortIdx").val();
		var tmp_sch ="";
		if ($("#sch_PortEdit").val() == "255")
			tmp_sch="-1";
		else
			tmp_sch=$("#sch_PortEdit").val();
		
		if(user_define == 0)//Special define
		{
			var tcp = [];
			var udp = [];
			
			for(var i=0 ; i<spsChkId.length-2 ; i++)
			{
				if($("#edit_"+spsChkId[i]).attr('checked'))
				{
					if(spsPort[i].TCP!='')
						tcp.push(spsPort[i].TCP);
					if(spsPort[i].UDP!='')
						udp.push(spsPort[i].UDP);
				}
			}
			/*last 2 are special case,so handle it independently.*/
			if($("#edit_"+spsChkId[6]).attr('checked'))
				tcp = [spsPort[6].TCP];
			if($("#edit_"+spsChkId[7]).attr('checked'))
				udp = [spsPort[7].UDP];
				
			DataArray_access_pre[row].Enable = ($("#edit_ruleEnable")[0].checked? "1":"0");
			DataArray_access_pre[row].Name = $("#edit_ruleName").val();
			DataArray_access_pre[row].Schedule = tmp_sch;
			DataArray_access_pre[row].Src_ip_start = $("#edit_ipaddr_start").val();
			DataArray_access_pre[row].Src_ip_end = $("#edit_ipaddr_end").val();
			DataArray_access_pre[row].Tcp_port = (tcp.length==0?'':tcp.join(","));
			DataArray_access_pre[row].Udp_port = (udp.length==0?'':udp.join(","));
			DataArray_access_pre[row].OnList = row;
		}
		else//user define
		{
			DataArray_access[row].Enable = ($("#edit_ruleEnable")[0].checked? "1":"0");
			DataArray_access[row].Name = $("#edit_ruleName").val();
			DataArray_access[row].Schedule = tmp_sch;
			DataArray_access[row].Src_ip_start = $("#edit_ipaddr_start").val();
			DataArray_access[row].Src_ip_end = $("#edit_ipaddr_end").val();
			DataArray_access[row].Tcp_port = $("#edit_portRuleTCP").val();
			DataArray_access[row].Udp_port = $("#edit_portRuleUDP").val();
			DataArray_access[row].OnList = row+1;			
		}

		port_submitEidt(row);
	}
	
	function port_deleteRow(rowIdx)
	{				
			DataArray_access[rowIdx-1].Enable= "-1";
			DataArray_access[rowIdx-1].Name= "";
			DataArray_access[rowIdx-1].Schedule= "";
			DataArray_access[rowIdx-1].Src_ip_start= "";
			DataArray_access[rowIdx-1].Src_ip_end= "";
			DataArray_access[rowIdx-1].Tcp_port= "";
			DataArray_access[rowIdx-1].Udp_port= "";

		user_define=1;
		port_edit_control_list = "";
		port_submitEidt(rowIdx-1);
	}

	function port_deleteRow_pre(rowIdx)
	{				
			DataArray_access_pre[rowIdx-1].Enable= "-1";
			DataArray_access_pre[rowIdx-1].Name= "";
			DataArray_access_pre[rowIdx-1].Schedule= "";
			DataArray_access_pre[rowIdx-1].Src_ip_start= "";
			DataArray_access_pre[rowIdx-1].Src_ip_end= "";
			DataArray_access_pre[rowIdx-1].Tcp_port= "";
			DataArray_access_pre[rowIdx-1].Udp_port= "";
			
		user_define=0;
		port_edit_control_list = "";
		port_submitEidt(rowIdx-1);
	}

	
	function port_submitEidt(row)
	{
		var obj = new ccpObject();
		obj.set_param_url('apply.cgi');
		obj.set_ccp_act('set');
		obj.set_param_next_page('adv_access_control.asp');
		
		//Port range
		if(user_define == 0)//Special define
		{
			obj.add_param_event('acl_service_block');
			var count = 0;
			for (var i = 0; i < DataArray_access_pre.length; i++)
			{
				if (DataArray_access_pre[i].Enable != "-1")
				{
						port_edit_control_list = DataArray_access_pre[i].Enable + "/" + DataArray_access_pre[i].Name + "/" + DataArray_access_pre[i].Schedule
						 + "/" + DataArray_access_pre[i].Src_ip_start + "/" + DataArray_access_pre[i].Src_ip_end + "/" + DataArray_access_pre[i].Tcp_port + "/" + DataArray_access_pre[i].Udp_port;

					if(count < 10){
						obj.add_param_arg('acl_service_block_rule_pre_0'+ count, port_edit_control_list);
					}else{
						obj.add_param_arg('acl_service_block_rule_pre_'+ count, port_edit_control_list);
					}
				count++;
				}
			}
			
			//Port rang-user define
			count = 0;
			control_list="";
			for (var i = 0; i < DataArray_access.length; i++)
			{
						control_list = DataArray_access[i].Enable + "/" + DataArray_access[i].Name + "/" + DataArray_access[i].Schedule
				 		+ "/" + DataArray_access[i].Src_ip_start + "/" + DataArray_access[i].Src_ip_end + "/" + DataArray_access[i].Tcp_port + "/" + DataArray_access[i].Udp_port;
	
					if(count < 10)
					{
						obj.add_param_arg('acl_service_block_rule_0'+ count, control_list);
					}else{
						obj.add_param_arg('acl_service_block_rule_'+ count, control_list);
					}						 
					count++;
			}	
		}else{//user define
			obj.add_param_event('acl_service_block');
			var count = 0;
			for (var i = 0; i < DataArray_access.length; i++)
			{
				if (DataArray_access[i].Enable != "-1")
				{
						port_edit_control_list = DataArray_access[i].Enable + "/" + DataArray_access[i].Name + "/" + DataArray_access[i].Schedule
				 		+ "/" + DataArray_access[i].Src_ip_start + "/" + DataArray_access[i].Src_ip_end + "/" + DataArray_access[i].Tcp_port + "/" + DataArray_access[i].Udp_port;

					if(count < 10)
					{
						obj.add_param_arg('acl_service_block_rule_0'+ count, port_edit_control_list);
					}else{
						obj.add_param_arg('acl_service_block_rule_'+ count, port_edit_control_list);
					}						 
					count++;
				}
			}
			
			//Port rang-special define
			count = 0;
			control_list="";
			for (var i = 0; i < DataArray_access_pre.length; i++)
			{
				if (DataArray_access_pre[i].Enable != "-1")
				{
						control_list = DataArray_access_pre[i].Enable + "/" + DataArray_access_pre[i].Name + "/" + DataArray_access_pre[i].Schedule
						 + "/" + DataArray_access_pre[i].Src_ip_start + "/" + DataArray_access_pre[i].Src_ip_end + "/" + DataArray_access_pre[i].Tcp_port + "/" + DataArray_access_pre[i].Udp_port;
	
					if(count < 10){
						obj.add_param_arg('acl_service_block_rule_pre_0'+ count, control_list);
					}else{
						obj.add_param_arg('acl_service_block_rule_pre_'+ count, control_list);
					}
				count++;
				}
			}
		}

		//IP range
		count = 0;
		var control_list = "";
		for (var i = 0; i < DataArray_access_all.length; i++)
		{
			control_list = DataArray_access_all[i].Enable + "/" + DataArray_access_all[i].Name + "/" + DataArray_access_all[i].Src_ip + "/" + DataArray_access_all[i].Schedule;
						 
			if(count < 10)
			{
				obj.add_param_arg('acl_service_block_all_rule_0'+ count, control_list);
			}else{
				obj.add_param_arg('acl_service_block_all_rule'+ count, control_list);
			}		
			count++;				 
		}


		obj.add_param_arg('reboot_type','filter');
		obj.add_param_arg('acl_enable',(get_by_name("AccessControlEnable")[0].checked?"1":"0"));
		var param = obj.get_param();
		totalWaitTime = 20; //second
		redirectURL = location.pathname;
		wait_page();
		jq_ajax_post(param.url, param.arg);
	}
	
	function port_cancelEdit()
	{
		cleanPortServices("edit_");
		cleanUserDef("edit_");
		
		$("#editPolicyMain").hide();
		$("#addNewPolicyMain").show();
	}
	
	/** IP Rules */
	function ip_editRow(rowIdx)
	{
		$("#editIPIdx").val(rowIdx-1);
		
		/** Fill edit data */		
		$("#edit_IPscheduleField").html(makeScheduleHTML("sch_IPEdit",DataArray_access_all[rowIdx-1].Schedule));
		
		if(DataArray_access_all[rowIdx-1].Enable=="1")
			$("#edit_IPEnable")[0].checked = true;
		else
			$("#edit_IPEnable")[0].checked = false;
		
		$("#edit_IPName").val(DataArray_access_all[rowIdx-1].Name);
		
		if(DataArray_access_all[rowIdx-1].Src_ip.indexOf("@")!= -1)
		{
			DataArray_access_all[rowIdx-1].Src_ip = DataArray_access_all[rowIdx-1].Src_ip.replace("@","/");
		}
/*		var inHtml = IPRuleObj.ipStart[rowIdx-1];
		if(IPRuleObj.ipEnd[rowIdx-1] != null && IPRuleObj.ipEnd[rowIdx-1] != IPRuleObj.ipStart[rowIdx-1])
			inHtml += '-' + IPRuleObj.ipEnd[rowIdx-1] + '';
		else if(IPRuleObj.ipMask[rowIdx-1] != "0.0.0.0")
			inHtml += '/' + ipMast_to_Num(IPRuleObj.ipMask[rowIdx-1])
		
		$("#edit_ipRule").val(inHtml);
	*/	
		$("#edit_ipRule").val(DataArray_access_all[rowIdx-1].Src_ip);
		$('#sch_IPEdit').val(DataArray_access_all[rowIdx-1].Schedule);
		$("#edit_IPBlock").show();
		$("#addNewIPBlock").hide();
	}
	
	function ip_setEdit()
	{
		var row = $("#editIPIdx").val();
		var ipRule = $("#edit_ipRule").val();
		var ipStart = ipRule;
		var ipEnd = ipRule;
		var ipMask = "0.0.0.0";
		var maskBit = 0;
		if(ipRule.indexOf("/")!= -1)
		{
			ipRule = ipRule.replace("/","@");
		}		
		
		
		/** Check for mask input */
		if(ipRule.indexOf("/")!= -1 && ipRule.indexOf("-")!= -1)
		{
			alert("IP Address format error");
			return;
		}
		
		if(ipRule.indexOf("/")!= -1)
		{
			var ipArr = ipRule.split("/");
			ipStart = ipArr[0];
			ipEnd = ipStart;
			maskBit = parseInt(ipArr[1],10);
			
			if(ipArr[1].length==0 || maskBit>32 || maskBit==0)
			{
				alert("IP Mask Error");
				return;
			}
			
			ipMask = calculate_ipMask(maskBit);
			
		}
		else if(ipRule.indexOf("-")!= -1)
		{
			var ipArr = ipRule.split("-");			
			ipStart = ipArr[0];
			ipEnd = ipArr[1];
			if(ipStart.length == 0 || ipEnd.length ==0)
			{
				alert("Input format error");
				return;
			}
			var start_ip_addr_msg = replace_msg(all_ip_addr_msg,get_words('TEXT035'));
			var end_ip_addr_msg = replace_msg(all_ip_addr_msg,get_words('end_ip'));
			var start_obj = new addr_obj(ipStart.split("."), start_ip_addr_msg, false, false);
			var end_obj = new addr_obj(ipEnd.split("."), end_ip_addr_msg, false, false);
			if (!check_ip_order(start_obj, end_obj)){
				alert(get_words('IP_RANGE_ERROR', msg));
				return;
			}
		}
		var tmp_sch ="";
		if ($("#sch_IPEdit").val() == "255")
			tmp_sch="-1";
		else
			tmp_sch=$("#sch_IPEdit").val();
		
		DataArray_access_all[row].Enable = ($("#edit_IPEnable")[0].checked? "1":"0");
		DataArray_access_all[row].Name = $("#edit_IPName").val();
		DataArray_access_all[row].Src_ip= ipRule;
		DataArray_access_all[row].Schedule = tmp_sch;
		DataArray_access_all[row].OnList = row;
		ip_submitEidt(row);
	}
	
	function ip_deleteRow(rowIdx)
	{
		DataArray_access_all[rowIdx-1].Enable= "-1";
		DataArray_access_all[rowIdx-1].Name= "";
		DataArray_access_all[rowIdx-1].Schedule= "";
		DataArray_access_all[rowIdx-1].Src_ip= "";
		ip_edit_control_list = "";
		ip_submitEidt(rowIdx-1);
	}
	
	function ip_submitEidt(row)
	{
		var obj = new ccpObject();
		obj.set_param_url('apply.cgi');
		obj.set_ccp_act('set');
		obj.set_param_next_page('adv_access_control.asp');
		obj.add_param_event('acl_service_block');
		var count = 0;
		
		//Ip range
		for (var i = 0; i < DataArray_access_all.length; i++)
		{
			if (DataArray_access_all[i].Enable != "-1")
			{
				ip_edit_control_list = DataArray_access_all[i].Enable + "/" + DataArray_access_all[i].Name + "/" + DataArray_access_all[i].Src_ip + "/" + DataArray_access_all[i].Schedule;
				if(count < 10){
					obj.add_param_arg('acl_service_block_all_rule_0'+ count, ip_edit_control_list);
				}else{
					obj.add_param_arg('acl_service_block_all_rule_'+ count, ip_edit_control_list);
				}
			count++;
			}
		}
		
		//Port rang-special define
		count = 0;
		var control_list="";
		for (var i = 0; i < DataArray_access_pre.length; i++)
		{
			if (DataArray_access_pre[i].Enable != "-1")
			{
					control_list = DataArray_access_pre[i].Enable + "/" + DataArray_access_pre[i].Name + "/" + DataArray_access_pre[i].Schedule
					 + "/" + DataArray_access_pre[i].Src_ip_start + "/" + DataArray_access_pre[i].Src_ip_end + "/" + DataArray_access_pre[i].Tcp_port + "/" + DataArray_access_pre[i].Udp_port;

				if(count < 10){
					obj.add_param_arg('acl_service_block_rule_pre_0'+ count, control_list);
				}else{
					obj.add_param_arg('acl_service_block_rule_pre_'+ count, control_list);
				}
			count++;
			}
		}

		//Port rang-user define
		count = 0;
		control_list="";
		for (var i = 0; i < DataArray_access.length; i++)
		{
					control_list = DataArray_access[i].Enable + "/" + DataArray_access[i].Name + "/" + DataArray_access[i].Schedule
			 		+ "/" + DataArray_access[i].Src_ip_start + "/" + DataArray_access[i].Src_ip_end + "/" + DataArray_access[i].Tcp_port + "/" + DataArray_access[i].Udp_port;

				if(count < 10)
				{
					obj.add_param_arg('acl_service_block_rule_0'+ count, control_list);
				}else{
					obj.add_param_arg('acl_service_block_rule_'+ count, control_list);
				}						 
				count++;
		}				
		
		obj.add_param_arg('reboot_type','filter');
		obj.add_param_arg('acl_enable',(get_by_name("AccessControlEnable")[0].checked?"1":"0"));
		var param = obj.get_param();
		totalWaitTime = 20; //second
		redirectURL = location.pathname;
		wait_page();
		jq_ajax_post(param.url, param.arg);
	}
	
	function ip_cancelEdit()
	{
		$("#edit_IPBlock").hide();
		$("#addNewIPBlock").show();
	}
	
	/** IP Rules End */
	
	/** Edit functions End */
	
	/** Display table functions */	
	function showURLLists_Allow()
	{
		var inHtml = '';
		var tmp_schedule_rule = "";
		for(var idx=0 ; idx < rule_max_num ; idx++)
		{
			if(idx < 10){
				var temp_rule = get_by_id("acl_url_filter_0" + idx).value;
			}else{
				var temp_rule = get_by_id("acl_url_filter_" + idx).value;
			}
			var rule = temp_rule.split("/");
			var sche_name=[];
			if(rule[0]!="" && temp_rule!="")
			{
				//get schedule rule name
				for (var i = 0; i < 32; i++) {
				if(i < 10){
					var temp_sche_rule = get_by_id("schedule_rule_0" + i).value;
				}else{
					var temp_sche_rule = get_by_id("schedule_rule_" + i).value;
				}
				var sche_rule = temp_sche_rule.split("/");
				sche_name[i] =  sche_rule[0];
				}
				//get schedule rule name
				//covert schedule index 00 to 0 , 01 to 1
				if(rule[3]!=""){
					 if(rule[3]=="-1"){
						var sche_val = "-1";
					}else if (rule[3]=="254"){
						var sche_val = "254";
					}else if( rule[3] < 10){
						var sche_val = parseInt(rule[3].slice(1),10);
					}else{
						var sche_val = parseInt(rule[3],10);
					}
				
				}
				// get name by schedule index
				if(sche_val=="-1"){
					var tmp_sche_name = get_words('_always');
				}else if (sche_val=="254"){
					var tmp_sche_name =  get_words('_never');
				}else{
					var tmp_sche_name = sche_name[sche_val];
				}
		
				var checked = "checked";
				DataArray_access_website[DataArray_access_website.length++] = new Data_access_website(rule[0], rule[1], rule[2], rule[3], idx);
				var tmp_url_sche = (DataArray_access_website[idx].Schedule=='-1'?get_words('_always'):(DataArray_access_website[idx].Schedule=='254'?get_words('_never'):DataArray_access_website[idx].Schedule));
				if(DataArray_access_website[idx].Enable == "0")
					checked = "";		
			
				inHtml += '' +
					'<tr align="center">'+
						'<td align="center" class="CELL">'+
							'<input disabled="disabled" type="checkbox" id="urlFilterEnable_' + idx + '" ' + checked +'/></td>' +
						'<td align="center" class="CELL" id="urlFilterName_' + idx +'">' + DataArray_access_website[idx].Name + '</td>'+
						'<td align="center" class="CELL" id="urlFilterURL">' + DataArray_access_website[idx].Website_url + '</td>'+
						'<td align="center" class="CELL" id="urlFilterSchedule">' + tmp_sche_name + '</td>' +
						'<td align="center" class="CELL" id="urlFilterEdit">'+
							'<a href="javascript:url_editRow('+ (idx+1) +')"><img src="edit.gif" border="0" title="'+get_words('_edit')+'" /></a></td>' +
						'<td align="center" class="CELL" id="urlFilterDelete">'+
							'<a href="javascript:url_deleteRow('+ (idx+1) +')"><img src="delete.gif" border="0" title="'+get_words('_delete')+'" /></a></td>' +
							'</td>'
					'</tr>';
				}
		}
		document.write(inHtml);
	}
	
	
	function showURLLists()
	{
		var inHtml = '';
		var tmp_schedule_rule = "";
		for(var idx=0 ; idx < rule_max_num ; idx++)
		{
			if(idx < 10){
				var temp_rule = get_by_id("acl_url_filter_0" + idx).value;
			}else{
				var temp_rule = get_by_id("acl_url_filter_" + idx).value;
			}
			var rule = temp_rule.split("/");
			var sche_name=[];
			if(rule[0]!="" && temp_rule!="")
			{
			
				//get schedule rule name
				for (var i = 0; i < 32; i++) {
				if(i < 10){
					var temp_sche_rule = get_by_id("schedule_rule_0" + i).value;
				}else{
					var temp_sche_rule = get_by_id("schedule_rule_" + i).value;
				}
				var sche_rule = temp_sche_rule.split("/");
				sche_name[i] =  sche_rule[0];
				}
				//get schedule rule name
			    //covert schedule index 00 to 0 , 01 to 1
				if(rule[3]!=""){
					 if(rule[3]=="-1"){
						var sche_val = "-1";
					}else if (rule[3]=="254"){
						var sche_val = "254";
					}else if( rule[3] < 10){
						var sche_val = parseInt(rule[3].slice(1),10);
					}else{
						var sche_val = parseInt(rule[3],10);
					}
				
				}
				// get name by schedule index
				if(sche_val=="-1"){
					var tmp_sche_name = get_words('_always');
				}else if (sche_val=="254"){
					var tmp_sche_name =  get_words('_never');
				}else{
					var tmp_sche_name = sche_name[sche_val];
				}
				var checked = "checked";
				DataArray_access_website[DataArray_access_website.length++] = new Data_access_website(rule[0], rule[1], rule[2], rule[3], idx);
				var tmp_url_sche = (DataArray_access_website[idx].Schedule=='-1'?get_words('_always'):(DataArray_access_website[idx].Schedule=='254'?get_words('_never'):DataArray_access_website[idx].Schedule));
				if(DataArray_access_website[idx].Enable == "0")
					checked = "";		
			
				inHtml += '' +
					'<tr align="center">'+
						'<td align="center" class="CELL">'+
							'<input disabled="disabled" type="checkbox" id="urlFilterEnable_' + idx + '" ' + checked +'/></td>' +
						'<td align="center" class="CELL" id="urlFilterName_' + idx +'">' + DataArray_access_website[idx].Name + '</td>'+
						'<td align="center" class="CELL" id="urlFilterURL">' + DataArray_access_website[idx].Website_url + '</td>'+
						'<td align="center" class="CELL" id="urlFilterSchedule">' + tmp_sche_name + '</td>' +
						'<td align="center" class="CELL" id="urlFilterEdit">'+
							'<a href="javascript:url_editRow('+ (idx+1) +')"><img src="edit.gif" border="0" title="'+get_words('_edit')+'" /></a></td>' +
						'<td align="center" class="CELL" id="urlFilterDelete">'+
							'<a href="javascript:url_deleteRow('+ (idx+1) +')"><img src="delete.gif" border="0" title="'+get_words('_delete')+'" /></a></td>' +
							'</td>'
					'</tr>';
				}
		}
		document.write(inHtml);
	}
	
	function showPortRangList()
	{//PortRangeObj
		var inHtml = '';
		var TotalCnt = 0;

		for(var idx=0 ; idx < rule_max_num ; idx++)
		{
			if(idx < 10){
				var temp_rule = get_by_id("acl_service_block_rule_0" + idx).value;
			}else{
				var temp_rule = get_by_id("acl_service_block_rule_" + idx).value;
			}
			var rule = temp_rule.split("/");
			var sche_name=[];
			if(rule[0]!="" && temp_rule!="")
			{
				//get schedule rule name
				for (var i = 0; i < 32; i++) {
				if(i < 10){
					var temp_sche_rule = get_by_id("schedule_rule_0" + i).value;
				}else{
					var temp_sche_rule = get_by_id("schedule_rule_" + i).value;
				}
				var sche_rule = temp_sche_rule.split("/");
				sche_name[i] =  sche_rule[0];
				}
				//get schedule rule name
				
				//covert schedule index 00 to 0 , 01 to 1
				if(rule[2]!=""){
					 if(rule[2]=="-1"){
						var sche_val = "-1";
					}else if (rule[2]=="254"){
						var sche_val = "254";
					}else if( rule[2] < 10){
						var sche_val = parseInt(rule[2].slice(1),10);
					}else{
						var sche_val = parseInt(rule[2],10);
					}
				}
				// get name by schedule index
				if(sche_val=="-1"){
					var tmp_sche_name = get_words('_always');
				}else if (sche_val=="254"){
					var tmp_sche_name =  get_words('_never');
				}else{
					var tmp_sche_name = sche_name[sche_val];
				}
					
				DataArray_access[DataArray_access.length++] = new Data_access(rule[0], rule[1], rule[2], rule[3], rule[4], rule[5], rule[6], idx);

				var checked = "checked";
				var tmp_port_sche = (DataArray_access[idx].Schedule=='-1'?get_words('_always'):(DataArray_access[idx].Schedule=='254'?get_words('_never'):DataArray_access[idx].Schedule));
				if(DataArray_access[idx].Enable == "0")
					checked = "";
				
				inHtml += '' +
					'<tr align="center">'+
						'<td align="center" class="CELL">'+
							'<input disabled="disabled" type="checkbox" id="portEnable_' + idx + '" ' + checked +'/></td>' +
						'<td align="center" class="CELL" id="portName_' + idx +'">' + DataArray_access[idx].Name + '</td>'+
						'<td align="center" class="CELL" id="portSchedule">' + tmp_sche_name + '</td>'+
						'<td align="center" class="CELL" id="portIPRange">' + DataArray_access[idx].Src_ip_start + '-' + DataArray_access[idx].Src_ip_end + '</td>'+
						'<td align="center" class="CELL" id="portEdit">'+
							'<a href="javascript:port_editRow('+ (idx+1) +')"><img src="edit.gif" border="0" title="'+get_words('_edit')+'" /></a></td>' +
						'<td align="center" class="CELL" id="portDelete">'+
							'<a href="javascript:port_deleteRow('+ (idx+1) +')"><img src="delete.gif" border="0" title="'+get_words('_delete')+'" /></a></td>' +
						'</td>'
						'</tr>';
			}			
		}
		
		for(var idx=0 ; idx < rule_max_num ; idx++)
		{
			if(idx < 10){
				var temp_rule = get_by_id("acl_service_block_rule_pre_0" + idx).value;
			}else{
				var temp_rule = get_by_id("acl_service_block_rule_pre_" + idx).value;
			}
			var rule = temp_rule.split("/");
			var sche_name=[];
			if(rule[0]!="" && temp_rule!="")
			{
				//get schedule rule name
				for (var i = 0; i < 32; i++) {
				if(i < 10){
					var temp_sche_rule = get_by_id("schedule_rule_0" + i).value;
				}else{
					var temp_sche_rule = get_by_id("schedule_rule_" + i).value;
				}
				var sche_rule = temp_sche_rule.split("/");
				sche_name[i] =  sche_rule[0];
				}
				//get schedule rule name
				
				//covert schedule index 00 to 0 , 01 to 1
				if(rule[2]!=""){
					 if(rule[2]=="-1"){
						var sche_val = "-1";
					}else if (rule[2]=="254"){
						var sche_val = "254";
					}else if( rule[2] < 10){
						var sche_val = parseInt(rule[2].slice(1),10);
					}else{
						var sche_val = parseInt(rule[2],10);
					}
				
				}
				// get name by schedule index
				if(sche_val=="-1"){
					var tmp_sche_name = get_words('_always');
				}else if (sche_val=="254"){
					var tmp_sche_name =  get_words('_never');
				}else{
					var tmp_sche_name = sche_name[sche_val];
				}
					
				DataArray_access_pre[DataArray_access_pre.length++] = new Data_access(rule[0], rule[1], rule[2], rule[3], rule[4], rule[5], rule[6], idx);
				
				var checked = "checked";
				var tmp_port_sche = (DataArray_access_pre[idx].Schedule=='-1'?get_words('_always'):(DataArray_access_pre[idx].Schedule=='254'?get_words('_never'):DataArray_access_pre[idx].Schedule));
				if(DataArray_access_pre[idx].Enable == "0")
					checked = "";
				
				inHtml += '' +
					'<tr align="center">'+
						'<td align="center" class="CELL">'+
							'<input disabled="disabled" type="checkbox" id="portEnable_' + idx + '" ' + checked +'/></td>' +
						'<td align="center" class="CELL" id="portName_' + idx +'">' + DataArray_access_pre[idx].Name + '</td>'+
						'<td align="center" class="CELL" id="portSchedule">' + tmp_sche_name + '</td>'+
						'<td align="center" class="CELL" id="portIPRange">' + DataArray_access_pre[idx].Src_ip_start + '-' + DataArray_access_pre[idx].Src_ip_end + '</td>'+
						'<td align="center" class="CELL" id="portEdit">'+
							'<a href="javascript:port_editRow_pre('+ (idx+1) +')"><img src="edit.gif" border="0" title="'+get_words('_edit')+'" /></a></td>' +
						'<td align="center" class="CELL" id="portDelete">'+
							'<a href="javascript:port_deleteRow_pre('+ (idx+1) +')"><img src="delete.gif" border="0" title="'+get_words('_delete')+'" /></a></td>' +
							'</td>'
					'</tr>';
			}
		}		
		document.write(inHtml);
	}
	
	function showIPRuleList()
	{
		var inHtml = '';

		var tmp_schedule_rule = "";
	
		for(var idx=0 ; idx < rule_max_num ; idx++)
		{
			if(idx < 10){
				var temp_rule = get_by_id("acl_service_block_all_rule_0" + idx).value;
			}else{
				var temp_rule = get_by_id("acl_service_block_all_rule_" + idx).value;
			}
			var rule = temp_rule.split("/");
			var sche_name=[];
			if(rule[0]!="" && temp_rule!="")
			{
				//get schedule rule name
				for (var i = 0; i < 32; i++) {
				if(i < 10){
					var temp_sche_rule = get_by_id("schedule_rule_0" + i).value;
				}else{
					var temp_sche_rule = get_by_id("schedule_rule_" + i).value;
				}
				var sche_rule = temp_sche_rule.split("/");
				sche_name[i] =  sche_rule[0];
				}
				//get schedule rule name
				
				//covert schedule index 00 to 0 , 01 to 1
				if(rule[3]!=""){
					 if(rule[3]=="-1"){
						var sche_val = "-1";
					}else if (rule[3]=="254"){
						var sche_val = "254";
					}else if( rule[3] < 10){
						var sche_val = parseInt(rule[3].slice(1),10);
					}else{
						var sche_val = parseInt(rule[3],10);
					}
				}
				// get name by schedule index
				if(sche_val=="-1"){
					var tmp_sche_name = get_words('_always');
				}else if (sche_val=="254"){
					var tmp_sche_name =  get_words('_never');
				}else{
					var tmp_sche_name = sche_name[sche_val];
				}
			
				DataArray_access_all[DataArray_access_all.length++] = new Data_access_all(rule[0], rule[1], rule[2], rule[3], idx);
			
				if(DataArray_access_all[idx].Name.length==0)
					continue;
				var checked = "checked";
				var tmp_ip_sche = (DataArray_access_all[idx].Schedule=='-1'?get_words('_always'):(DataArray_access_all[idx].Schedule=='254'?get_words('_never'):DataArray_access_all[idx].Schedule));
				var tmp_ip = DataArray_access_all[idx].Src_ip;
				if(tmp_ip.indexOf("@")!= -1)
					tmp_ip = tmp_ip.replace("@","/");
				
				if(DataArray_access_all[idx].Enable == "0")
					checked = "";
				
				inHtml += '' +
					'<tr align="center">'+
						'<td align="center" class="CELL">'+
							'<input disabled="disabled" type="checkbox" id="ipEnable_' + idx + '" ' + checked +'/></td>' +
						'<td align="center" class="CELL" id="ipName_' + idx +'">' + DataArray_access_all[idx].Name + '</td>'+					
						'<td align="center" class="CELL" id="ipIPRange">' + tmp_ip;
						
						/*
						if(IPRuleObj.ipEnd[idx] != null && IPRuleObj.ipEnd[idx] != IPRuleObj.ipStart[idx])
							inHtml += '-' + IPRuleObj.ipEnd[idx] + '';
						else if(IPRuleObj.ipMask[idx] != "0.0.0.0")
							inHtml += '/' + ipMast_to_Num(IPRuleObj.ipMask[idx])
							*/
				
				inHtml +='</td><td align="center" class="CELL" id="ipSchedule">' + tmp_sche_name + '</td>'+
							'<td align="center" class="CELL" id="ipEdit">'+
							'<a href="javascript:ip_editRow('+ (idx+1) +')"><img src="edit.gif" border="0" title="'+get_words('_edit')+'" /></a></td>' +
						'<td align="center" class="CELL" id="portDelete">'+
							'<a href="javascript:ip_deleteRow('+ (idx+1) +')"><img src="delete.gif" border="0" title="'+get_words('_delete')+'" /></a></td>' +
							'</td>'
					'</tr>';
			}
		}
		document.write(inHtml);
	}
	
	/** Display table functions End*/	
	
	/** Submit functions */
	function addPortRuls()
	{
		var ip_addr_msgs = replace_msg(all_ip_addr_msg,get_words('IPv6_addrSr'));
		var ip_addr_msge = replace_msg(all_ip_addr_msg,get_words('IPv6_addrEr'));
		var start_ip = $("#ipaddr_start").val();
		var end_ip = $("#ipaddr_end").val();
		var temp_start_ip = new addr_obj(start_ip.split("."), ip_addr_msgs, false, false);
		var temp_end_ip = new addr_obj(end_ip.split("."), ip_addr_msge, false, false);
		var control_list = "";
		var ruleDefine_checked = 0;

		if($("#ruleName").val()=='')
		{
			alert(addstr(get_words('up_ai_se_2'), get_words('_policy_name')));
			return false;
		}
		
		for (var i = 0; i < DataArray_access_pre.length; i++)
		{
			if($("#ruleName").val()== DataArray_access_pre[i].Name){
				alert(get_words('aa_alert_8'));
				return false;
			}
		}		
		
		if (DataArray_access_pre.length == rule_max_num){
			alert(get_words('TEXT015'));
			return;
		}
		
		if(is_ipv4_valid($("#ipaddr_start").val())==false || is_ipv4_valid($("#ipaddr_end").val())==false)
		{
			alert(get_words('LS46'));
			return;
		}
		
		/* check start ip must less than end ip*/
		if (!check_ip_order(temp_start_ip, temp_end_ip)){
			alert(get_words('TEXT039'));
			return ;
		}
		
		if(get_by_name("ruleDefine")[0].checked) {
			for(var i=0 ; i<spsChkId.length ; i++) {
				if($("#"+spsChkId[i]).attr('checked')) {
					ruleDefine_checked = 1;
				}
			}
			if( ruleDefine_checked == 0 ) {
				alert(get_words('_specapps_ipr'));
				return ;
			}
		}
		
		var obj = new ccpObject();
		obj.set_param_url('apply.cgi');
		obj.set_ccp_act('set');
		obj.set_param_next_page('adv_access_control.asp');
		var TotalCnt = 0, TotalCnt_pre = 0;

		for (var i = 0; i < rule_max_num; i++) {
			if(i < 10){
				var temp_rule = get_by_id("acl_service_block_rule_0" + i).value;
			}else{
				var temp_rule = get_by_id("acl_service_block_rule_" + i).value;
			}
			var rule = temp_rule.split("/");
			if(rule[0]!="")
			{
				TotalCnt++;
			}
		}

		for (var i = 0; i < rule_max_num; i++) {
			if(i < 10){
				var temp_rule_pre = get_by_id("acl_service_block_rule_pre_0" + i).value;
			}else{
				var temp_rule_pre = get_by_id("acl_service_block_rule_pre_" + i).value;
			}
			var rule_pre = temp_rule_pre.split("/");
			if(rule_pre[0]!="")
			{
				TotalCnt_pre++;
			}
		}

		
		var tmp_sch ="";
		if ($("#sch_Port").val() == "255")
			tmp_sch="-1";
		else
			tmp_sch=$("#sch_Port").val();
		
		//Port range
		if(get_by_name("ruleDefine")[0].checked)
		{
			var tcp = [];
			var udp = [];
			
			for(var i=0 ; i<spsChkId.length-2 ; i++)
			{
					if($("#"+spsChkId[i]).attr('checked'))
					{
						if(spsPort[i].TCP!='')
							tcp.push(spsPort[i].TCP);
						if(spsPort[i].UDP!='')
							udp.push(spsPort[i].UDP);
					}
			}
			/*last 2 are special case,so handle it independently.*/
			if($("#"+spsChkId[6]).attr('checked'))
				tcp = [spsPort[6].TCP];
			if($("#"+spsChkId[7]).attr('checked'))
				udp = [spsPort[7].UDP];

			DataArray_access_pre[TotalCnt_pre] = new Data_access(($("#ruleEnable")[0].checked? "1":"0"), $('#ruleName').val(), tmp_sch, $('#ipaddr_start').val(), $('#ipaddr_end').val(), (tcp.length==0?'':tcp.join(",")), (udp.length==0?'':udp.join(",")), TotalCnt_pre+1);			
			var count = 0;
			for (var i = 0; i < DataArray_access_pre.length; i++)
			{
				control_list = DataArray_access_pre[i].Enable + "/" + DataArray_access_pre[i].Name + "/" + DataArray_access_pre[i].Schedule
							 + "/" + DataArray_access_pre[i].Src_ip_start + "/" + DataArray_access_pre[i].Src_ip_end + "/" + DataArray_access_pre[i].Tcp_port + "/" + DataArray_access_pre[i].Udp_port;
							 
				if(count < 10)
				{
					obj.add_param_arg('acl_service_block_rule_pre_0'+ count, control_list);
				}else{
					obj.add_param_arg('acl_service_block_rule_pre_'+ count, control_list);
				}		
				count++;				 
			}
			
			//Port rang-user define
			count = 0;
			control_list="";
			for (var i = 0; i < DataArray_access.length; i++)
			{
						control_list = DataArray_access[i].Enable + "/" + DataArray_access[i].Name + "/" + DataArray_access[i].Schedule
				 		+ "/" + DataArray_access[i].Src_ip_start + "/" + DataArray_access[i].Src_ip_end + "/" + DataArray_access[i].Tcp_port + "/" + DataArray_access[i].Udp_port;
	
					if(count < 10)
					{
						obj.add_param_arg('acl_service_block_rule_0'+ count, control_list);
					}else{
						obj.add_param_arg('acl_service_block_rule_'+ count, control_list);
					}						 
					count++;
			}							
			
			obj.add_param_event('acl_service_block');
		}
		else
		{
			DataArray_access[TotalCnt] = new Data_access(($("#ruleEnable")[0].checked? "1":"0"), $('#ruleName').val(), tmp_sch, $('#ipaddr_start').val(), $('#ipaddr_end').val(), $("#portRuleTCP").val(), $("#portRuleUDP").val(), TotalCnt+1);
			var count = 0;
			for (var i = 0; i < DataArray_access.length; i++)
			{
				control_list = DataArray_access[i].Enable + "/" + DataArray_access[i].Name + "/" + DataArray_access[i].Schedule
							 + "/" + DataArray_access[i].Src_ip_start + "/" + DataArray_access[i].Src_ip_end + "/" + DataArray_access[i].Tcp_port + "/" + DataArray_access[i].Udp_port;
			
				if(count < 10){
					obj.add_param_arg('acl_service_block_rule_0'+ count, control_list);
				}else{
					obj.add_param_arg('acl_service_block_rule_'+ count, control_list);
				}
				count++;
			}
			
			//Port rang-special define
			count = 0;
			control_list="";
			for (var i = 0; i < DataArray_access_pre.length; i++)
			{
				if (DataArray_access_pre[i].Enable != "-1")
				{
						control_list = DataArray_access_pre[i].Enable + "/" + DataArray_access_pre[i].Name + "/" + DataArray_access_pre[i].Schedule
						 + "/" + DataArray_access_pre[i].Src_ip_start + "/" + DataArray_access_pre[i].Src_ip_end + "/" + DataArray_access_pre[i].Tcp_port + "/" + DataArray_access_pre[i].Udp_port;
	
					if(count < 10){
						obj.add_param_arg('acl_service_block_rule_pre_0'+ count, control_list);
					}else{
						obj.add_param_arg('acl_service_block_rule_pre_'+ count, control_list);
					}
				count++;
				}
			}
			
			obj.add_param_event('acl_service_block');
		}
		
		//IP range
		var count = 0;
		control_list = "";
		for (var i = 0; i < DataArray_access_all.length; i++)
		{
			control_list = DataArray_access_all[i].Enable + "/" + DataArray_access_all[i].Name + "/" + DataArray_access_all[i].Src_ip + "/" + DataArray_access_all[i].Schedule;
						 
			if(count < 10)
			{
				obj.add_param_arg('acl_service_block_all_rule_0'+ count, control_list);
			}else{
				obj.add_param_arg('acl_service_block_all_rule'+ count, control_list);
			}		
			count++;				 
		}		
		
		
		obj.add_param_arg('reboot_type','filter');
		obj.add_param_arg('acl_enable',(get_by_name("AccessControlEnable")[0].checked?"1":"0"));
		var param = obj.get_param();
		totalWaitTime = 20; //second
		redirectURL = location.pathname;
		wait_page();
		jq_ajax_post(param.url, param.arg);
	}
	
	function check_URL_filter(name, url, idx)
	{
		if(name=='')
		{
			alert(addstr(get_words('up_ai_se_2'), get_words('_adv_txt_01')));
			return false;
		}
		if(url=='')
		{
			alert(addstr(get_words('up_ai_se_2'), get_words('help725')));
			return false;
		}
		for(var i=0 ; i<DataArray_access_website.length ; i++)
		{
			if(DataArray_access_website[i].Name==name && idx!=i)
			{
				alert(addstr(get_words('_webfilterrule_dup'), name));
				return false;
			}
			if(DataArray_access_website[i].Website_url==url && idx!=i)
			{
				alert(addstr(get_words('awf_alert_5'), url));
				return false;
			}
		}
		var tmp_url = url;
		var pos = tmp_url.indexOf("http://");  
		var pos1 = tmp_url.indexOf("https://");  
		var lpos = tmp_url.lastIndexOf("/"); 

		if(pos != -1){     
   			if(lpos < 7){
				strGet_url = tmp_url.substring(pos+7);
				//alert("http://"+strGet_url);
			}else{	    
		    	strGet_url = tmp_url.substring(pos+7,lpos);  
		    }
    	}else{
    		if(pos1 != -1){ 
				//alert("?定的URL?效");
				alert(get_words('GW_URL_INVALID'));
				return false;
    		}else{
		    	if(lpos != -1){
					strGet_url = tmp_url.substring(0,lpos);
					//alert(strGet_url);
				}else{	    
			    	strGet_url = tmp_url; 
			    }
			}
		}
		return true;
	}
	
	function addURL_Allow()
	{
		var temp_rule="";
		var TotalCnt = 0, TotalCnt_pre = 0;
		
		if(!check_URL_filter($("#URLName_Allow").val(), $("#URLRule_Allow").val()))
			return;
		//apply_action();
		for(var idx=0 ; idx<rule_max_num ; idx++)
		{
			//find empty one
			if(idx < 10){
				temp_rule = get_by_id("acl_url_filter_0" + idx).value;
			}else{
				temp_rule = get_by_id("acl_url_filter_" + idx).value;
			}
			if((temp_rule=="///")||(temp_rule==""))
				break;
		}
		if(idx == rule_max_num)
		{
			alert(get_words('_rule_full'));
			//can't find empty one
			return;
		}
		
		var obj = new ccpObject();
		obj.set_param_url('apply.cgi');
		obj.set_ccp_act('set');
		obj.add_param_event('adv_filters_url');
		obj.set_param_next_page('adv_access_control.asp');
		var tmp_sch ="", control_list="";
		
		for(var idx=0 ; idx<rule_max_num ; idx++)
		{
			//find empty one
			if(idx < 10){
				temp_rule = get_by_id("acl_url_filter_0" + idx).value;
			}else{
				temp_rule = get_by_id("acl_url_filter_" + idx).value;
			}
			var rule = temp_rule.split("/");
			if(rule[0]!="")
			{
				TotalCnt++;
			}
		}
		
		if ($("#sch_URL_Allow").val() == "255")
			tmp_sch="-1";
		else
			tmp_sch=$("#sch_URL_Allow").val();
			
		DataArray_access_website[TotalCnt] = new Data_access_website(($("#URLEnable_Allow")[0].checked? "1":"0"), $("#URLName_Allow").val(), strGet_url, tmp_sch, TotalCnt+1);			
		var count = 0;
		for (var i = 0; i < DataArray_access_website.length; i++)
		{
			control_list = DataArray_access_website[i].Enable + "/" + DataArray_access_website[i].Name + "/" + DataArray_access_website[i].Website_url + "/" + DataArray_access_website[i].Schedule;
						 
			if(count < 10)
			{
				obj.add_param_arg('acl_url_filter_0'+ count, control_list);
			}else{
				obj.add_param_arg('acl_url_filter_'+ count, control_list);
			}		
			count++;				 
		}
		
		var sel_action = $('#url_domain_filter_type').val();
		var tmp_sel_action="";
		switch (sel_action) {
		case "0":
		default:
				tmp_sel_action = "0/list_deny";
				break;
		case "1":
				tmp_sel_action = "1/list_deny";
				break;
		case "2":
				tmp_sel_action = "1/list_allow";
				break;
		}
		
		//save url data end
		for(var i=0; i<DataArray.length; i++)
		{
			var key, value;
			if (i<10)
				key = "acl_parent_0" + i;
			else
				key = "acl_parent_" + i;

			value = DataArray[i].Enable + "/" + DataArray[i].Name + "/" + DataArray[i].Ip_addr + "/" +
					DataArray[i].MAC + "/" + DataArray[i].Schdule;
			obj.add_param_arg(key,value);
		}
		
		obj.add_param_arg('acl_url_filter_enable',tmp_sel_action);
		obj.add_param_arg('reboot_type','filter');
		obj.add_param_arg('acl_enable',(get_by_name("AccessControlEnable")[0].checked?"1":"0"));
		var param = obj.get_param();
		totalWaitTime = 20; //second
		redirectURL = location.pathname;
		wait_page();
		jq_ajax_post(param.url, param.arg);
		
	}
	function addURL()
	{
		var TotalCnt = 0;
		if(!check_URL_filter($("#URLName").val(), $("#URLRule").val()))
			return;
		//apply_action();
		
		for(var idx=0 ; idx<rule_max_num ; idx++)
		{
			//find empty one
			if(idx < 10){
				temp_rule = get_by_id("acl_url_filter_0" + idx).value;
			}else{
				temp_rule = get_by_id("acl_url_filter_" + idx).value;
			}
			if((temp_rule=="///")||(temp_rule==""))
				break;
		}
		if(idx == rule_max_num)
		{
			alert(get_words('_rule_full'));
			//can't find empty one
			return;
		}
		
		var obj = new ccpObject();
		obj.set_param_url('apply.cgi');
		obj.set_ccp_act('set');
		obj.add_param_event('adv_filters_url');
		obj.set_param_next_page('adv_access_control.asp');
		var tmp_sch ="", control_list="";

		for(var idx=0 ; idx<rule_max_num ; idx++)
		{
			//find empty one
			if(idx < 10){
				temp_rule = get_by_id("acl_url_filter_0" + idx).value;
			}else{
				temp_rule = get_by_id("acl_url_filter_" + idx).value;
			}
			var rule = temp_rule.split("/");
			if(rule[0]!="")
			{
				TotalCnt++;
			}
		}
		
		if ($("#sch_URL").val() == "255")
			tmp_sch="-1";
		else
			tmp_sch=$("#sch_URL").val();
			
		DataArray_access_website[TotalCnt] = new Data_access_website(($("#URLEnable")[0].checked? "1":"0"), $("#URLName").val(), strGet_url, tmp_sch, TotalCnt+1);			
		var count = 0;
		for (var i = 0; i < DataArray_access_website.length; i++)
		{
			control_list = DataArray_access_website[i].Enable + "/" + DataArray_access_website[i].Name + "/" + DataArray_access_website[i].Website_url + "/" + DataArray_access_website[i].Schedule;
						 
			if(count < 10)
			{
				obj.add_param_arg('acl_url_filter_0'+ count, control_list);
			}else{
				obj.add_param_arg('acl_url_filter_'+ count, control_list);
			}		
			count++;				 
		}
		
		var sel_action = $('#url_domain_filter_type').val();
		var tmp_sel_action="";
		switch (sel_action) {
		case "0":
		default:
				tmp_sel_action = "0/list_deny";
				break;
		case "1":
				tmp_sel_action = "1/list_deny";
				break;
		case "2":
				tmp_sel_action = "1/list_allow";
				break;
		}
		
		//save url data end
		for(var i=0; i<DataArray.length; i++)
		{
			var key, value;
			if (i<10)
				key = "acl_parent_0" + i;
			else
				key = "acl_parent_" + i;

			value = DataArray[i].Enable + "/" + DataArray[i].Name + "/" + DataArray[i].Ip_addr + "/" +
					DataArray[i].MAC + "/" + DataArray[i].Schdule;
			obj.add_param_arg(key,value);
		}
		
		obj.add_param_arg('acl_url_filter_enable',tmp_sel_action);
		obj.add_param_arg('reboot_type','filter');
		obj.add_param_arg('acl_enable',(get_by_name("AccessControlEnable")[0].checked?"1":"0"));
		var param = obj.get_param();
		totalWaitTime = 20; //second
		redirectURL = location.pathname;
		wait_page();
		jq_ajax_post(param.url, param.arg);
	
	}
	
	function add_IPRule()
	{
		var ipRule = $("#ipRule").val();
		
		if(ipRule==null || ipRule.length==0){
			alert("IP Address can't be empty");
			return;
		}
	
		if($("#IPName").val().length == 0)
		{
			alert("Rule Name can't be empty");
			return;
		}
		
		var ipStart = ipRule;
		var ipEnd = ipRule;
		var ipMask = "0.0.0.0";
		var maskBit=0;
		
		
		/** Check for mask input */
		if(ipRule.indexOf("/")!= -1 && ipRule.indexOf("-")!= -1)
		{
			alert(get_words('_err_ip_addr_format'));
			return;
		}
		
		if(ipRule.indexOf("/")!= -1)
		{
			var ipArr = ipRule.split("/");
			ipStart = ipArr[0];
			ipEnd = ipStart;
			maskBit = parseInt(ipArr[1],10);
			
			if(ipArr[1].length==0 || maskBit>32 || maskBit==0)
			{
				alert(get_words('_err_ip_mask'));
				return;
			}
			
			ipMask = calculate_ipMask(maskBit);
			
		}
		else if(ipRule.indexOf("-")!= -1)
		{
			var ipArr = ipRule.split("-");			
			ipStart = ipArr[0];
			ipEnd = ipArr[1];
			if(ipStart.length == 0 || ipEnd.length ==0)
			{
				alert(get_words('_err_input_format'));
				return;
			}
			var start_ip_addr_msg = replace_msg(all_ip_addr_msg,get_words('TEXT035'));
			var end_ip_addr_msg = replace_msg(all_ip_addr_msg,get_words('end_ip'));
			var start_obj = new addr_obj(ipStart.split("."), start_ip_addr_msg, false, false);
			var end_obj = new addr_obj(ipEnd.split("."), end_ip_addr_msg, false, false);
			if (!check_ip_order(start_obj, end_obj)){
				alert(get_words('IP_RANGE_ERROR', msg));
				return;
			}
		}
		
		if(is_ipv4_valid(ipStart)==false || is_ipv4_valid(ipEnd)==false)
		{
			alert(get_words('_err_ip_addr'));
			return;
		}
		
		for(var idx=0 ; idx<IPRuleObj.count ; idx++)
		{
			//find empty one
			if(IPRuleObj.name[idx].length==0)
				break;
		}
		if(idx==IPRuleObj.count)
		{
			alert(get_words('_rule_full'));
			return;
		}
		
		var obj = new ccpObject();
		obj.set_param_url('apply.cgi');
		obj.set_ccp_act('set');
		obj.add_param_event('acl_service_block');
		obj.set_param_next_page('adv_access_control.asp');
		var tmp_sch ="", control_list="";
		var TotalCnt = 0, TotalCnt_pre = 0;
		
		if(ipRule.indexOf("/")!= -1)
		{
			ipRule = ipRule.replace("/","@");
		}		

		//Ip range
		for (var i = 0; i < rule_max_num; i++) {
			if(i < 10){
				var temp_rule = get_by_id("acl_service_block_all_rule_0" + i).value;
			}else{
				var temp_rule = get_by_id("acl_service_block_all_rule_" + i).value;
			}
			var rule = temp_rule.split("/");
			if(rule[0]!="")
			{
				TotalCnt++;
			}
		}

		if (DataArray_access_all.length == 10){
			alert(get_words('TEXT015'));
			return;
		}
	
		
		if ($("#sch_IP").val() == "255")
			tmp_sch="-1";
		else
			tmp_sch=$("#sch_IP").val();
			
		DataArray_access_all[TotalCnt] = new Data_access_all(($("#IPEnable")[0].checked? "1":"0"), $("#IPName").val(), ipRule, tmp_sch, TotalCnt+1);			
		var count = 0;
		for (var i = 0; i < DataArray_access_all.length; i++)
		{
			control_list = DataArray_access_all[i].Enable + "/" + DataArray_access_all[i].Name + "/" + DataArray_access_all[i].Src_ip + "/" + DataArray_access_all[i].Schedule;
						 
			if(count < 10)
			{
				obj.add_param_arg('acl_service_block_all_rule_0'+ count, control_list);
			}else{
				obj.add_param_arg('acl_service_block_all_rule'+ count, control_list);
			}		
			count++;				 
		}
		
		//Port rang-special define
		count = 0;
		control_list="";
		for (var i = 0; i < DataArray_access_pre.length; i++)
		{
			if (DataArray_access_pre[i].Enable != "-1")
			{
					control_list = DataArray_access_pre[i].Enable + "/" + DataArray_access_pre[i].Name + "/" + DataArray_access_pre[i].Schedule
					 + "/" + DataArray_access_pre[i].Src_ip_start + "/" + DataArray_access_pre[i].Src_ip_end + "/" + DataArray_access_pre[i].Tcp_port + "/" + DataArray_access_pre[i].Udp_port;

				if(count < 10){
					obj.add_param_arg('acl_service_block_rule_pre_0'+ count, control_list);
				}else{
					obj.add_param_arg('acl_service_block_rule_pre_'+ count, control_list);
				}
			count++;
			}
		}

		//Port rang-user define
		count = 0;
		control_list="";
		for (var i = 0; i < DataArray_access.length; i++)
		{
					control_list = DataArray_access[i].Enable + "/" + DataArray_access[i].Name + "/" + DataArray_access[i].Schedule
			 		+ "/" + DataArray_access[i].Src_ip_start + "/" + DataArray_access[i].Src_ip_end + "/" + DataArray_access[i].Tcp_port + "/" + DataArray_access[i].Udp_port;

				if(count < 10)
				{
					obj.add_param_arg('acl_service_block_rule_0'+ count, control_list);
				}else{
					obj.add_param_arg('acl_service_block_rule_'+ count, control_list);
				}						 
				count++;
		}				
		
		obj.add_param_arg('reboot_type','filter');
		obj.add_param_arg('acl_enable',(get_by_name("AccessControlEnable")[0].checked?"1":"0"));
		var param = obj.get_param();
		totalWaitTime = 20; //second
		redirectURL = location.pathname;
		wait_page();
		jq_ajax_post(param.url, param.arg);
	}
	
	function saveStatus()
	{
		var obj = new ccpObject();
		obj.set_param_url('apply.cgi');
		obj.set_ccp_act('set');
		obj.add_param_event('acl_service_block');
		obj.set_param_next_page('adv_access_control.asp');
		var tmp_sch ="", control_list="";
		var count = 0;
		
		//IP range
		for (var i = 0; i < DataArray_access_all.length; i++)
		{
			control_list = DataArray_access_all[i].Enable + "/" + DataArray_access_all[i].Name + "/" + DataArray_access_all[i].Src_ip + "/" + DataArray_access_all[i].Schedule;
						 
			if(count < 10)
			{
				obj.add_param_arg('acl_service_block_all_rule_0'+ count, control_list);
			}else{
				obj.add_param_arg('acl_service_block_all_rule'+ count, control_list);
			}		
			count++;				 
		}
		
		//Port rang-special define
		count = 0;
		control_list="";
		for (var i = 0; i < DataArray_access_pre.length; i++)
		{
			if (DataArray_access_pre[i].Enable != "-1")
			{
					control_list = DataArray_access_pre[i].Enable + "/" + DataArray_access_pre[i].Name + "/" + DataArray_access_pre[i].Schedule
					 + "/" + DataArray_access_pre[i].Src_ip_start + "/" + DataArray_access_pre[i].Src_ip_end + "/" + DataArray_access_pre[i].Tcp_port + "/" + DataArray_access_pre[i].Udp_port;

				if(count < 10){
					obj.add_param_arg('acl_service_block_rule_pre_0'+ count, control_list);
				}else{
					obj.add_param_arg('acl_service_block_rule_pre_'+ count, control_list);
				}
			count++;
			}
		}

		//Port rang-user define
		count = 0;
		control_list="";
		for (var i = 0; i < DataArray_access.length; i++)
		{
					control_list = DataArray_access[i].Enable + "/" + DataArray_access[i].Name + "/" + DataArray_access[i].Schedule
			 		+ "/" + DataArray_access[i].Src_ip_start + "/" + DataArray_access[i].Src_ip_end + "/" + DataArray_access[i].Tcp_port + "/" + DataArray_access[i].Udp_port;

				if(count < 10)
				{
					obj.add_param_arg('acl_service_block_rule_0'+ count, control_list);
				}else{
					obj.add_param_arg('acl_service_block_rule_'+ count, control_list);
				}						 
				count++;
		}		
		
		obj.add_param_arg('reboot_type','filter');
		obj.add_param_arg('acl_enable',(get_by_name("AccessControlEnable")[0].checked?"1":"0"));
		var param = obj.get_param();
		totalWaitTime = 20; //second
		redirectURL = location.pathname;
		wait_page();
		jq_ajax_post(param.url, param.arg);
	}
	
	/** Reset functions */
	
	function reset_PortRule()
	{
		$("#ruleEnable")[0].checked = false;
		$("#ruleName").val("");
		$("#ipaddr_start").val("");
		$("#ipaddr_end").val("");
		get_by_name("ruleDefine")[0].checked = true;
		switchPortRule(0);
		$("#scheduleField").html(makeScheduleHTML("sch_Port"),0);
	}
	
	function reset_IPRule()
	{
		$("#IPEnable")[0].checked = false;
		$("#IPName").val("");
		$("#ipRule").val("");
		$("#IPscheduleField").html(makeScheduleHTML("sch_IP"),0);
	}
	
	function reset_URLRule_Allow()
	{
		$("#URLEnable_Allow")[0].checked = false;
		$("#URLName_Allow").val("");
		$("#URLRule_Allow").val("");
		$("#URLscheduleField_Allow").html(makeScheduleHTML("sch_URL"),0);
	}
	
	function reset_URLRule()
	{
		$("#URLEnable")[0].checked = false;
		$("#URLName").val("");
		$("#URLRule").val("");
		$("#URLscheduleField").html(makeScheduleHTML("sch_URL"),0);
	}
	
	/** Reset functions End */
	
	function check_modified()
	{
		if ((is_modified==1) && is_form_modified("form1") && confirm (get_words('up_fm_dc_1')))
			window.location.href='adv_access_control.asp';
	}
	function url_domain_action(){
		var sel_action = $('#url_domain_filter_type').val();
		if($('input[name=AccessControlEnable][value=1]').attr('checked'))
		{
			if(sel_action=='1')
			{
				$('#addNewURLBlock_Allow, #URLList_Allow').hide();
				$('#addNewURLBlock, #URLList').show();
			}
			else if(sel_action=='2')
			{
				//$('#addNewURLBlock_Allow, #URLList_Allow').show();
				//$('#addNewURLBlock, #URLList').hide();
				$('#addNewURLBlock_Allow, #URLList_Allow').hide();
				$('#addNewURLBlock, #URLList').show();
			}
			else
			{
				$('#addNewURLBlock_Allow, #URLList_Allow').hide();
				$('#addNewURLBlock, #URLList').hide();
			}
			$('#editURLBlock_Allow, #editURLBlock').hide();
		}
	}
	function apply_action(){
		var sel_action = $('#url_domain_filter_type').val();
		var tmp_sel_action="";
		var count=0;
		switch (sel_action) {
		case "0":
		default:
				tmp_sel_action = "0/list_deny";
				break;
		case "1":
				tmp_sel_action = "1/list_deny";
				break;
		case "2":
				tmp_sel_action = "1/list_allow";
				break;
		}
		
		var obj = new ccpObject();
		obj.set_param_url('apply.cgi');
		obj.set_ccp_act('set');
		obj.add_param_event('adv_filters_url');
		obj.set_param_next_page('adv_access_control.asp');

		for (var i = 0; i < DataArray_access_website.length; i++)
		{
			control_list = DataArray_access_website[i].Enable + "/" + DataArray_access_website[i].Name + "/" + DataArray_access_website[i].Website_url + "/" + DataArray_access_website[i].Schedule;
						 
			if(count < 10)
			{
				obj.add_param_arg('acl_url_filter_0'+ count, control_list);
			}else{
				obj.add_param_arg('acl_url_filter_'+ count, control_list);
			}		
			count++;				 
		}
		
		//save url data end
		for(var i=0; i<DataArray.length; i++)
		{
			var key, value;
			if (i<10)
				key = "acl_parent_0" + i;
			else
				key = "acl_parent_" + i;

			value = DataArray[i].Enable + "/" + DataArray[i].Name + "/" + DataArray[i].Ip_addr + "/" +
					DataArray[i].MAC + "/" + DataArray[i].Schdule;
			obj.add_param_arg(key,value);
		}
		
		obj.add_param_arg('acl_url_filter_enable',tmp_sel_action);
		obj.add_param_arg('reboot_type','filter');
		obj.add_param_arg('acl_enable',(get_by_name("AccessControlEnable")[0].checked?"1":"0"));
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
				<script>document.write(menu.build_structure(1,4,0))</script>
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
							<script>show_words('_acccon');</script>
							</div>
							<div class="hr"></div>
							<div class="section_content_border">
							<div class="header_desc" id="acIntroduction">
								<script>show_words('_AC_DESC');</script>
								<p></p>
							</div>

<div id="status_menu" class="box_tn" style="display:none;">
	<table cellpadding="0" cellspacing="0" align="center" class="formarea">
	<tr>
		<td align="center" class="btn_field">
			<!-- Save / Cancel Button here -->
			<input type="button" id="btnSave" value="Save Status" onClick="saveStatus();"  class="button_submit" />
			<input type="button" id="btnCancel" value="Cancel"  class="button_submit" onClick="window.location.reload()"/>
			<script>
				/** Change button value here */
				$("#btnSave").val(get_words('_save_status'));
				$("#btnCancel").val(get_words('_cancel'));
			</script>
		</td>
	</tr>
	</table>
</div>

		<input type="hidden" id="access_control_filter_type" name="access_control_filter_type" value="<!--# echo access_control_filter_type -->">
		
		<input type="hidden" id="acl_service_block_all_rule_00" name="acl_service_block_all_rule_00" value="<!--# echo acl_service_block_all_rule_00 -->">
		<input type="hidden" id="acl_service_block_all_rule_01" name="acl_service_block_all_rule_01" value="<!--# echo acl_service_block_all_rule_01 -->">
		<input type="hidden" id="acl_service_block_all_rule_02" name="acl_service_block_all_rule_02" value="<!--# echo acl_service_block_all_rule_02 -->">
		<input type="hidden" id="acl_service_block_all_rule_03" name="acl_service_block_all_rule_03" value="<!--# echo acl_service_block_all_rule_03 -->">
		<input type="hidden" id="acl_service_block_all_rule_04" name="acl_service_block_all_rule_04" value="<!--# echo acl_service_block_all_rule_04 -->">
		<input type="hidden" id="acl_service_block_all_rule_05" name="acl_service_block_all_rule_05" value="<!--# echo acl_service_block_all_rule_05 -->">
		<input type="hidden" id="acl_service_block_all_rule_06" name="acl_service_block_all_rule_06" value="<!--# echo acl_service_block_all_rule_06 -->">
		<input type="hidden" id="acl_service_block_all_rule_07" name="acl_service_block_all_rule_07" value="<!--# echo acl_service_block_all_rule_07 -->">
		<input type="hidden" id="acl_service_block_all_rule_08" name="acl_service_block_all_rule_08" value="<!--# echo acl_service_block_all_rule_08 -->">
		<input type="hidden" id="acl_service_block_all_rule_09" name="acl_service_block_all_rule_09" value="<!--# echo acl_service_block_all_rule_09 -->">
		<input type="hidden" id="acl_service_block_all_rule_10" name="acl_service_block_all_rule_10" value="<!--# echo acl_service_block_all_rule_10 -->">
		<input type="hidden" id="acl_service_block_all_rule_11" name="acl_service_block_all_rule_11" value="<!--# echo acl_service_block_all_rule_11 -->">
		<input type="hidden" id="acl_service_block_all_rule_12" name="acl_service_block_all_rule_12" value="<!--# echo acl_service_block_all_rule_12 -->">
		<input type="hidden" id="acl_service_block_all_rule_13" name="acl_service_block_all_rule_13" value="<!--# echo acl_service_block_all_rule_13 -->">
		<input type="hidden" id="acl_service_block_all_rule_14" name="acl_service_block_all_rule_14" value="<!--# echo acl_service_block_all_rule_14 -->">
		<input type="hidden" id="acl_service_block_all_rule_15" name="acl_service_block_all_rule_15" value="<!--# echo acl_service_block_all_rule_15 -->">
		<input type="hidden" id="acl_service_block_all_rule_16" name="acl_service_block_all_rule_16" value="<!--# echo acl_service_block_all_rule_16 -->">
		<input type="hidden" id="acl_service_block_all_rule_17" name="acl_service_block_all_rule_17" value="<!--# echo acl_service_block_all_rule_17 -->">
		<input type="hidden" id="acl_service_block_all_rule_18" name="acl_service_block_all_rule_18" value="<!--# echo acl_service_block_all_rule_18 -->">
		<input type="hidden" id="acl_service_block_all_rule_19" name="acl_service_block_all_rule_19" value="<!--# echo acl_service_block_all_rule_19 -->">
		<input type="hidden" id="acl_service_block_all_rule_20" name="acl_service_block_all_rule_20" value="<!--# echo acl_service_block_all_rule_20 -->">
		<input type="hidden" id="acl_service_block_all_rule_21" name="acl_service_block_all_rule_21" value="<!--# echo acl_service_block_all_rule_21 -->">
		<input type="hidden" id="acl_service_block_all_rule_22" name="acl_service_block_all_rule_22" value="<!--# echo acl_service_block_all_rule_22 -->">
		<input type="hidden" id="acl_service_block_all_rule_23" name="acl_service_block_all_rule_23" value="<!--# echo acl_service_block_all_rule_23 -->">
		<input type="hidden" id="acl_service_block_all_rule_24" name="acl_service_block_all_rule_24" value="<!--# echo acl_service_block_all_rule_24 -->">

		<input type="hidden" id="acl_service_block_rule_00" name="acl_service_block_rule_00" value="<!--# echo acl_service_block_rule_00 -->">
		<input type="hidden" id="acl_service_block_rule_01" name="acl_service_block_rule_01" value="<!--# echo acl_service_block_rule_01 -->">
		<input type="hidden" id="acl_service_block_rule_02" name="acl_service_block_rule_02" value="<!--# echo acl_service_block_rule_02 -->">
		<input type="hidden" id="acl_service_block_rule_03" name="acl_service_block_rule_03" value="<!--# echo acl_service_block_rule_03 -->">
		<input type="hidden" id="acl_service_block_rule_04" name="acl_service_block_rule_04" value="<!--# echo acl_service_block_rule_04 -->">
		<input type="hidden" id="acl_service_block_rule_05" name="acl_service_block_rule_05" value="<!--# echo acl_service_block_rule_05 -->">
		<input type="hidden" id="acl_service_block_rule_06" name="acl_service_block_rule_06" value="<!--# echo acl_service_block_rule_06 -->">
		<input type="hidden" id="acl_service_block_rule_07" name="acl_service_block_rule_07" value="<!--# echo acl_service_block_rule_07 -->">
		<input type="hidden" id="acl_service_block_rule_08" name="acl_service_block_rule_08" value="<!--# echo acl_service_block_rule_08 -->">
		<input type="hidden" id="acl_service_block_rule_09" name="acl_service_block_rule_09" value="<!--# echo acl_service_block_rule_09 -->">
		<input type="hidden" id="acl_service_block_rule_10" name="acl_service_block_rule_10" value="<!--# echo acl_service_block_rule_10 -->">
		<input type="hidden" id="acl_service_block_rule_11" name="acl_service_block_rule_11" value="<!--# echo acl_service_block_rule_11 -->">
		<input type="hidden" id="acl_service_block_rule_12" name="acl_service_block_rule_12" value="<!--# echo acl_service_block_rule_12 -->">
		<input type="hidden" id="acl_service_block_rule_13" name="acl_service_block_rule_13" value="<!--# echo acl_service_block_rule_13 -->">
		<input type="hidden" id="acl_service_block_rule_14" name="acl_service_block_rule_14" value="<!--# echo acl_service_block_rule_14 -->">
		<input type="hidden" id="acl_service_block_rule_15" name="acl_service_block_rule_15" value="<!--# echo acl_service_block_rule_15 -->">
		<input type="hidden" id="acl_service_block_rule_16" name="acl_service_block_rule_16" value="<!--# echo acl_service_block_rule_16 -->">
		<input type="hidden" id="acl_service_block_rule_17" name="acl_service_block_rule_17" value="<!--# echo acl_service_block_rule_17 -->">
		<input type="hidden" id="acl_service_block_rule_18" name="acl_service_block_rule_18" value="<!--# echo acl_service_block_rule_18 -->">
		<input type="hidden" id="acl_service_block_rule_19" name="acl_service_block_rule_19" value="<!--# echo acl_service_block_rule_19 -->">
		<input type="hidden" id="acl_service_block_rule_20" name="acl_service_block_rule_20" value="<!--# echo acl_service_block_rule_20 -->">
		<input type="hidden" id="acl_service_block_rule_21" name="acl_service_block_rule_21" value="<!--# echo acl_service_block_rule_21 -->">
		<input type="hidden" id="acl_service_block_rule_22" name="acl_service_block_rule_22" value="<!--# echo acl_service_block_rule_22 -->">
		<input type="hidden" id="acl_service_block_rule_23" name="acl_service_block_rule_23" value="<!--# echo acl_service_block_rule_23 -->">
		<input type="hidden" id="acl_service_block_rule_24" name="acl_service_block_rule_24" value="<!--# echo acl_service_block_rule_24 -->">
         
        <input type="hidden" id="acl_service_block_enable" name="acl_service_block_enable" value="<!--# echo acl_service_block_enable -->" /> 
		<input type="hidden" id="acl_service_block_rule_pre_00" name="acl_service_block_rule_pre_00" value="<!--# echo acl_service_block_rule_pre_00 -->">
		<input type="hidden" id="acl_service_block_rule_pre_01" name="acl_service_block_rule_pre_01" value="<!--# echo acl_service_block_rule_pre_01 -->">
		<input type="hidden" id="acl_service_block_rule_pre_02" name="acl_service_block_rule_pre_02" value="<!--# echo acl_service_block_rule_pre_02 -->">
		<input type="hidden" id="acl_service_block_rule_pre_03" name="acl_service_block_rule_pre_03" value="<!--# echo acl_service_block_rule_pre_03 -->">
		<input type="hidden" id="acl_service_block_rule_pre_04" name="acl_service_block_rule_pre_04" value="<!--# echo acl_service_block_rule_pre_04 -->">
		<input type="hidden" id="acl_service_block_rule_pre_05" name="acl_service_block_rule_pre_05" value="<!--# echo acl_service_block_rule_pre_05 -->">
		<input type="hidden" id="acl_service_block_rule_pre_06" name="acl_service_block_rule_pre_06" value="<!--# echo acl_service_block_rule_pre_06 -->">
		<input type="hidden" id="acl_service_block_rule_pre_07" name="acl_service_block_rule_pre_07" value="<!--# echo acl_service_block_rule_pre_07 -->">
		<input type="hidden" id="acl_service_block_rule_pre_08" name="acl_service_block_rule_pre_08" value="<!--# echo acl_service_block_rule_pre_08 -->">
		<input type="hidden" id="acl_service_block_rule_pre_09" name="acl_service_block_rule_pre_09" value="<!--# echo acl_service_block_rule_pre_09 -->">
		<input type="hidden" id="acl_service_block_rule_pre_10" name="acl_service_block_rule_pre_10" value="<!--# echo acl_service_block_rule_pre_10 -->">
		<input type="hidden" id="acl_service_block_rule_pre_11" name="acl_service_block_rule_pre_11" value="<!--# echo acl_service_block_rule_pre_11 -->">
		<input type="hidden" id="acl_service_block_rule_pre_12" name="acl_service_block_rule_pre_12" value="<!--# echo acl_service_block_rule_pre_12 -->">
		<input type="hidden" id="acl_service_block_rule_pre_13" name="acl_service_block_rule_pre_13" value="<!--# echo acl_service_block_rule_pre_13 -->">
		<input type="hidden" id="acl_service_block_rule_pre_14" name="acl_service_block_rule_pre_14" value="<!--# echo acl_service_block_rule_pre_14 -->">
		<input type="hidden" id="acl_service_block_rule_pre_15" name="acl_service_block_rule_pre_15" value="<!--# echo acl_service_block_rule_pre_15 -->">
		<input type="hidden" id="acl_service_block_rule_pre_16" name="acl_service_block_rule_pre_16" value="<!--# echo acl_service_block_rule_pre_16 -->">
		<input type="hidden" id="acl_service_block_rule_pre_17" name="acl_service_block_rule_pre_17" value="<!--# echo acl_service_block_rule_pre_17 -->">
		<input type="hidden" id="acl_service_block_rule_pre_18" name="acl_service_block_rule_pre_18" value="<!--# echo acl_service_block_rule_pre_18 -->">
		<input type="hidden" id="acl_service_block_rule_pre_19" name="acl_service_block_rule_pre_19" value="<!--# echo acl_service_block_rule_pre_19 -->">
		<input type="hidden" id="acl_service_block_rule_pre_20" name="acl_service_block_rule_pre_20" value="<!--# echo acl_service_block_rule_pre_20 -->">
		<input type="hidden" id="acl_service_block_rule_pre_21" name="acl_service_block_rule_pre_21" value="<!--# echo acl_service_block_rule_pre_21 -->">
		<input type="hidden" id="acl_service_block_rule_pre_22" name="acl_service_block_rule_pre_22" value="<!--# echo acl_service_block_rule_pre_22 -->">
		<input type="hidden" id="acl_service_block_rule_pre_23" name="acl_service_block_rule_pre_23" value="<!--# echo acl_service_block_rule_pre_23 -->">
		<input type="hidden" id="acl_service_block_rule_pre_24" name="acl_service_block_rule_pre_24" value="<!--# echo acl_service_block_rule_pre_24 -->">

		<input type="hidden" id="acl_parent_00" name="acl_parent_00" value="<!--# echo acl_parent_00 -->">
		<input type="hidden" id="acl_parent_01" name="acl_parent_01" value="<!--# echo acl_parent_01 -->">
		<input type="hidden" id="acl_parent_02" name="acl_parent_02" value="<!--# echo acl_parent_02 -->">
		<input type="hidden" id="acl_parent_03" name="acl_parent_03" value="<!--# echo acl_parent_03 -->">
		<input type="hidden" id="acl_parent_04" name="acl_parent_04" value="<!--# echo acl_parent_04 -->">
		<input type="hidden" id="acl_parent_05" name="acl_parent_05" value="<!--# echo acl_parent_05 -->">
		<input type="hidden" id="acl_parent_06" name="acl_parent_06" value="<!--# echo acl_parent_06 -->">
		<input type="hidden" id="acl_parent_07" name="acl_parent_07" value="<!--# echo acl_parent_07 -->">
		<input type="hidden" id="acl_parent_08" name="acl_parent_08" value="<!--# echo acl_parent_08 -->">
		<input type="hidden" id="acl_parent_09" name="acl_parent_09" value="<!--# echo acl_parent_09 -->">
		<input type="hidden" id="acl_parent_10" name="acl_parent_10" value="<!--# echo acl_parent_10 -->">
		<input type="hidden" id="acl_parent_11" name="acl_parent_11" value="<!--# echo acl_parent_11 -->">
		<input type="hidden" id="acl_parent_12" name="acl_parent_12" value="<!--# echo acl_parent_12 -->">
		<input type="hidden" id="acl_parent_13" name="acl_parent_13" value="<!--# echo acl_parent_13 -->">
		<input type="hidden" id="acl_parent_14" name="acl_parent_14" value="<!--# echo acl_parent_14 -->">
		<input type="hidden" id="acl_parent_15" name="acl_parent_15" value="<!--# echo acl_parent_15 -->">
		<input type="hidden" id="acl_parent_16" name="acl_parent_16" value="<!--# echo acl_parent_16 -->">
		<input type="hidden" id="acl_parent_17" name="acl_parent_17" value="<!--# echo acl_parent_17 -->">
		<input type="hidden" id="acl_parent_18" name="acl_parent_18" value="<!--# echo acl_parent_18 -->">
		<input type="hidden" id="acl_parent_19" name="acl_parent_19" value="<!--# echo acl_parent_19 -->">
		<input type="hidden" id="acl_parent_20" name="acl_parent_20" value="<!--# echo acl_parent_20 -->">
		<input type="hidden" id="acl_parent_21" name="acl_parent_21" value="<!--# echo acl_parent_21 -->">
		<input type="hidden" id="acl_parent_22" name="acl_parent_22" value="<!--# echo acl_parent_22 -->">
		<input type="hidden" id="acl_parent_23" name="acl_parent_23" value="<!--# echo acl_parent_23 -->">
		<input type="hidden" id="acl_parent_24" name="acl_parent_24" value="<!--# echo acl_parent_24 -->">
							
		<input type="hidden" id="acl_url_filter_00" name="acl_url_filter_00" value="<!--# echo acl_url_filter_00 -->">
		<input type="hidden" id="acl_url_filter_01" name="acl_url_filter_01" value="<!--# echo acl_url_filter_01 -->">
		<input type="hidden" id="acl_url_filter_02" name="acl_url_filter_02" value="<!--# echo acl_url_filter_02 -->">
		<input type="hidden" id="acl_url_filter_03" name="acl_url_filter_03" value="<!--# echo acl_url_filter_03 -->">
		<input type="hidden" id="acl_url_filter_04" name="acl_url_filter_04" value="<!--# echo acl_url_filter_04 -->">
		<input type="hidden" id="acl_url_filter_05" name="acl_url_filter_05" value="<!--# echo acl_url_filter_05 -->">
		<input type="hidden" id="acl_url_filter_06" name="acl_url_filter_06" value="<!--# echo acl_url_filter_06 -->">
		<input type="hidden" id="acl_url_filter_07" name="acl_url_filter_07" value="<!--# echo acl_url_filter_07 -->">
		<input type="hidden" id="acl_url_filter_08" name="acl_url_filter_08" value="<!--# echo acl_url_filter_08 -->">
		<input type="hidden" id="acl_url_filter_09" name="acl_url_filter_09" value="<!--# echo acl_url_filter_09 -->">
		<input type="hidden" id="acl_url_filter_10" name="acl_url_filter_10" value="<!--# echo acl_url_filter_10 -->">
		<input type="hidden" id="acl_url_filter_11" name="acl_url_filter_11" value="<!--# echo acl_url_filter_11 -->">
		<input type="hidden" id="acl_url_filter_12" name="acl_url_filter_12" value="<!--# echo acl_url_filter_12 -->">
		<input type="hidden" id="acl_url_filter_13" name="acl_url_filter_13" value="<!--# echo acl_url_filter_13 -->">
		<input type="hidden" id="acl_url_filter_14" name="acl_url_filter_14" value="<!--# echo acl_url_filter_14 -->">
		<input type="hidden" id="acl_url_filter_15" name="acl_url_filter_15" value="<!--# echo acl_url_filter_15 -->">
		<input type="hidden" id="acl_url_filter_16" name="acl_url_filter_16" value="<!--# echo acl_url_filter_16 -->">
		<input type="hidden" id="acl_url_filter_17" name="acl_url_filter_17" value="<!--# echo acl_url_filter_17 -->">
		<input type="hidden" id="acl_url_filter_18" name="acl_url_filter_18" value="<!--# echo acl_url_filter_18 -->">
		<input type="hidden" id="acl_url_filter_19" name="acl_url_filter_19" value="<!--# echo acl_url_filter_19 -->">
		<input type="hidden" id="acl_url_filter_20" name="acl_url_filter_20" value="<!--# echo acl_url_filter_20 -->">
		<input type="hidden" id="acl_url_filter_21" name="acl_url_filter_21" value="<!--# echo acl_url_filter_21 -->">
		<input type="hidden" id="acl_url_filter_22" name="acl_url_filter_22" value="<!--# echo acl_url_filter_22 -->">
		<input type="hidden" id="acl_url_filter_23" name="acl_url_filter_23" value="<!--# echo acl_url_filter_23 -->">
		<input type="hidden" id="acl_url_filter_24" name="acl_url_filter_24" value="<!--# echo acl_url_filter_24 -->">


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
		<input type="hidden" id="max_row" name="max_row" value="-1" />

<div id="AC_Main" class="box_tn">
	<div class="CT"><script>show_words('_acccon');</script></div>
	<table cellspacing="0" cellpadding="0" class="formarea">
		<tr>
			<td class="CL">
				<script>show_words('aa_EAC');</script></td>
			<td class="CR">
				<input type="radio" name="AccessControlEnable" value="1" onClick="switchAccessControl(this.value,false);"/>
				<script>show_words('_enable');</script>&nbsp;
				<input type="radio" name="AccessControlEnable" value="0" onClick="switchAccessControl(this.value,false);"/>
				<script>show_words('_disable')</script>
			</td>
		</tr>
	</table>
</div>

<div id="addNewPolicyMain" class="box_tn">
	<div id="addPortRangeAndService" class="CT">
		<script>show_words('_add_port_block_rule');</script>
	</div>
	<table cellspacing="0" cellpadding="0" class="formarea">
	<tr>
		<td class="CL">
			<script>show_words('_policy_enable');</script></td>
		<td colspan="2" class="CR">
			<input type="checkbox" id="ruleEnable" />
		</td></tr>
	<tr>
		<td class="CL">
			<script>show_words('_policy_name');</script></td>
		<td colspan="2" class="CR">
			<input type="text" id="ruleName" maxlength="15" value=""/>
		</td></tr>
	<tr>
		<td class="CL">
			<a href="adv_schedule.asp"><span style="font: normal 14px verdana,arial,sans-serif;"><script>show_words('_sched');</script></span></a></td>
		<td colspan="2" class="CR">
			<span id="scheduleField"></span>
			<script>
				/** Make schedule select */
				$("#scheduleField").html(makeScheduleHTML("sch_Port"),0);
			</script>
		</td></tr>
	<tr>
		<td class="CL">
			<script>show_words('_client_ip_addr');</script></td>
		<td colspan="2" class="CR">
			<input type="text" id="ipaddr_start" maxlength="20" value=""/>
			~<input type="text" id="ipaddr_end" maxlength="20" value=""/>
		</td></tr>
	<tr>
		<td class="CL">
			<script>show_words('_rule_define');</script></td>
		<td colspan="2" class="CR">
			<input type="radio" name="ruleDefine" value="0" onClick="switchPortRule(this.value);" checked />
			<script>show_words('_special_service');</script>&nbsp;
			<input type="radio" name="ruleDefine" value="1" onClick="switchPortRule(this.value);" />
			<script>show_words('_user_define');</script>
		</td></tr>
	<tr id="userDefineTCP" style="display:none" >
		<td class="CL">
			<script>show_words('_tcp_ports');</script></td>
		<td colspan="2" class="CR">
			<input type="text" id="portRuleTCP" value="" />
			<script>show_words('_ex_21_or_3_500');</script>
		</td></tr>
	<tr id="userDefineUDP" style="display:none" >
		<td class="CL">
			<script>show_words('_udp_ports');</script></td>
		<td colspan="2" class="CR">
			<input type="text" id="portRuleUDP" value="" />
			<script>show_words('_ex_21_or_3_500');</script>
		</td></tr>
	<tr id="specialServiceTitle">
		<td class="CTS"><script>show_words('_service');</script>
			<script> /** Add which_lang here */</script></td>
		<td class="CTS"><script>show_words('_description');</script>
			<script> /** Add which_lang here */</script></td>
		<td class="CTS"><script>show_words('_enabled');</script>
			<script> /** Add which_lang here */</script></td>
		</tr>
	<script>showSpecialService();</script>
	<tr align="center">
		<td colspan="3" class="btn_field">
			<!-- Add / Cancel Button here -->
			<input type="button" id="btnAddPortRule" value="Add" onClick="addPortRuls();" class="button_submit"/>
			<input type="button" id="btnCancelPortRule" value="Cancel" onCLick="reset_PortRule();" class="button_submit"/>
			<script>/** change button value here */ 
				$("#btnAddPortRule").val(get_words('_add'));
				$("#btnCancelPortRule").val(get_words('_cancel'));
			</script>
		</td>
	</tr>
	</table>
</div>

<div id="editPolicyMain" class="box_tn" style="display:none;">
	<div id="editPortRangeAndService" class="CT">
		<script>show_words('_edit_port_block_rule');</script>
	</div>
	<input type="hidden" id="editPortIdx" />
	<table cellspacing="0" cellpadding="0" class="formarea">
	<tr>
		<td class="CL">
			<script>show_words('_policy_enable');</script></td>
		<td colspan="2" class="CR">
			<input type="checkbox" id="edit_ruleEnable" />
		</td></tr>
	<tr>
		<td class="CL">
			<script>show_words('_policy_name');</script></td>
		<td colspan="2" class="CR">
			<input type="text" id="edit_ruleName" maxlength="15" value=""/>
		</td></tr>
	<tr>
		<td class="CL">
			<a href="adv_schedule.asp"><span style="font: normal 14px verdana,arial,sans-serif;"><script>show_words('_sched');</script></span></a></td>
		<td colspan="2" class="CR">
			<span id="edit_scheduleField"></span>														
		</td></tr>
	<tr>
		<td class="CL">
			<script>show_words('_client_ip_addr');</script></td>
		<td colspan="2" class="CR">
			<input type="text" id="edit_ipaddr_start" maxlength="20" value=""/>
			~<input type="text" id="edit_ipaddr_end" maxlength="20" value=""/>
		</td></tr>
	<tr>
		<td class="CL">
			<script>show_words('_rule_define');</script></td>
		<td colspan="2" class="CR">
			<input type="radio" name="edit_ruleDefine" value="0" onClick="edit_switchPortRule(this.value);" checked />
			<script>show_words('_special_service');</script>&nbsp;
			<input type="radio" name="edit_ruleDefine" value="1" onClick="edit_switchPortRule(this.value);" />
			<script>show_words('_user_define');</script>
		</td></tr>
	<tr id="edit_userDefineTCP" style="display:none" >
		<td class="CL">
			<script>show_words('_tcp_ports');</script></td>
		<td colspan="2" class="CR">
			<input type="text" id="edit_portRuleTCP" value="" />
			<script>show_words('_ex_21_or_3_500');</script>
		</td></tr>
	<tr id="edit_userDefineUDP" style="display:none" >
		<td class="CL">
			<script>show_words('_udp_ports');</script></td>
		<td colspan="2" class="CR">
			<input type="text" id="edit_portRuleUDP" value="" />
			<script>show_words('_ex_21_or_3_500');</script>
		</td></tr>
	<tr id="edit_specialServiceTitle">
		<td class="CTS"><script>show_words('_service');</script>
			<script> /** Add which_lang here */</script></td>
		<td class="CTS"><script>show_words('_description');</script>
			<script> /** Add which_lang here */</script></td>
		<td class="CTS"><script>show_words('_enabled');</script>
			<script> /** Add which_lang here */</script></td>
		</tr>
	<script>edit_showSpecialService();</script>
	<tr align="center">
		<td colspan="3" class="btn_field">
			<!-- Add / Cancel Button here -->
			<input type="button" id="btnSavePortRule" value="Save" onClick="port_setEdit();" class="button_submit"/>
			<input type="button" id="btnCancelEditPortRule" onClick="port_cancelEdit();" value="Cancel" class="button_submit"/>
			<script>/** change button value here */ 
				//$("#btnSavePortRule").val(get_words('_add'));
				$("#btnCancelEditPortRule").val(get_words('_cancel'));
			</script>
		</td>
	</tr>
	</table>
</div>

<div id="policyList" class="box_tn">
	<div class="CT"><script>show_words('_port_block_rule');</script></div>
	<table cellspacing="0" cellpadding="0" class="formarea">
	<tr align="center">
		<td class="CTS" style="word-break:break-all;">
			<script>show_words('_enable');</script></td>
		<td class="CTS" style="word-break:break-all;">
			<script>show_words('_policy_name');</script></td>
		<td class="CTS" style="word-break:break-all;">
			<script>show_words('_sched');</script></td>
		<td class="CTS" style="word-break:break-all;">
			<script>show_words('IPv6_fw_ipr');</script></td>
		<td class="CTS" style="word-break:break-all;">
			<script>show_words('_edit');</script></td>
		<td class="CTS" style="word-break:break-all;">
			<script>show_words('_delete');</script></td>
	</tr>
	<script>
		showPortRangList();/** display Rules */
	</script>
	</table>
</div>

<div id="addNewIPBlock" class="box_tn">
	<div id="addNewIPB" class="CT">
		<script>show_words('_add_ip_block_rule');</script>
	</div>
	<table cellspacing="0" cellpadding="0" class="formarea">
	<tr>
		<td class="CL">
			<script>show_words('_adv_txt_00');</script></td>
		<td colspan="2" class="CR">
			<input type="checkbox" id="IPEnable" />
		</td></tr>
	<tr>
		<td class="CL">
			<script>show_words('_adv_txt_01');</script></td>
		<td colspan="2" class="CR">
			<input type="text" id="IPName" maxlength="20" size="25" value=""/>
		</td></tr>
	<tr>
		<td class="CL">
			<script>show_words('_ipaddr');</script></td>
		<td colspan="2" class="CR">
			<input type="text" id="ipRule" maxlength="31" size="35" value=""/>														
			<br/>
			(ex: 192.168.10.1, 192.168.10.0/24, 192.168.10.1-192.168.10.20)
			<script> /** example text */ </script>
		</td></tr>
	<tr>
		<td class="CL">
			<a href="adv_schedule.asp"><span style="font: normal 14px verdana,arial,sans-serif;"><script>show_words('_sched');</script></span></a></td>
		<td colspan="2" class="CR">
			<span id="IPscheduleField"></span>
			<script>
				/** Make schedule select */
				$("#IPscheduleField").html(makeScheduleHTML("sch_IP"),0);
			
			</script>
		</td></tr>
	<tr align="center">
		<td colspan="3" class="btn_field">
			<!-- Add / Cancel Button here -->
			<input type="button" id="btnAddIPRule" value="Add" onClick="add_IPRule();" class="button_submit"/>
			<input type="button" id="btnCancelIPRule" value="Reset" onClick="reset_IPRule();" class="button_submit"/>
			<script> /** change button value here */ 
				$("#btnAddIPRule").val(get_words('_add'));
				$("#btnCancelIPRule").val(get_words('_reset'));
			</script>
		</td>
	</tr>
	</table>
</div>

<div id="edit_IPBlock" class="box_tn" style="display:none">
	<div id="edit_IPB" class="CT">
		<script>show_words('_edit_ip_block_rule');</script>
		</div>
	<input type="hidden" id="editIPIdx" />
	<table cellspacing="0" cellpadding="0" class="formarea">
	<tr>
		<td class="CL">
			<script>show_words('_adv_txt_00');</script></td>
		<td colspan="2" class="CR">
			<input type="checkbox" id="edit_IPEnable" />
		</td></tr>
	<tr>
		<td class="CL">
			<script>show_words('_adv_txt_01');</script></td>
		<td colspan="2" class="CR">
			<input type="text" id="edit_IPName" maxlength="20" size="25" value=""/>
		</td></tr>
	<tr>
		<td class="CL">
			<script>show_words('_ipaddr');</script></td>
		<td colspan="2" class="CR">
			<input type="text" id="edit_ipRule" maxlength="31" size="35" value=""/>														
			<br/>
			(ex: 192.168.0.1, 192.168.0.0/24, 192.168.0.1-192.168.0.20)
			<script> /** example text */ </script>
		</td></tr>
	<tr>
		<td class="CL">
			<a href="adv_schedule.asp"><span style="font: normal 14px verdana,arial,sans-serif;"><script>show_words('_sched');</script></span></a></td>
		<td colspan="2" class="CR">
			<span id="edit_IPscheduleField"></span>														
		</td></tr>
	<tr align="center">
		<td colspan="3" class="btn_field">
			<!-- Add / Cancel Button here -->
			<input type="button" id="btnEditIPRule" value="Edit" onClick="ip_setEdit();" class="button_submit"/>
			<input type="button" id="btnCancelEditIPRule" value="Cancel" onClick="ip_cancelEdit();" class="button_submit"/>
			<script> /** change button value here */ 
				$("#btnEditIPRule").val(get_words('_edit'));
				$("#btnCancelEditIPRule").val(get_words('_cancel'));
			</script>
		</td>
	</tr>
	</table>
</div>

<div id="ipList" class="box_tn">
	<div class="CT"><script>show_words('_ip_block_rule_list');</script></div>
	<table cellspacing="0" cellpadding="0" class="formarea">
	<tr align="center">
		<td class="CTS" style="word-break:break-all;">
			<script>show_words('_enable');</script></td>
		<td class="CTS" style="word-break:break-all;">
			<script>show_words('_adv_txt_01');</script></td>
		<td class="CTS" style="word-break:break-all;">
			<script>show_words('_ipaddr');</script></td>
		<td class="CTS" style="word-break:break-all;">
			<script>show_words('_sched');</script></td>
		<td class="CTS" style="word-break:break-all;">
			<script>show_words('_edit');</script></td>
		<td class="CTS" style="word-break:break-all;">
			<script>show_words('_delete');</script></td>
	</tr>
	<script>
		showIPRuleList();/** display Rules */
	</script>
	</table>
</div>

<div id="URLBlock_Action" class="box_tn">
	<div id="URL_Action" class="CT">
		<script>show_words('_websfilter');</script>
	</div>
	<table cellspacing="0" cellpadding="0" class="formarea">
	<tr>
		<td class="CL">
			<script>show_words('dlink_wf_intro')</script>
		</td>
		<td colspan="2" class="CR">
			<select id="url_domain_filter_type" name="url_domain_filter_type" onchange="url_domain_action()">
				<option value="0"><script>show_words('_disable')</script></option>
				<option value="1"><script>show_words('dlink_wf_op_0')</script></option>
				<option value="2"><script>show_words('dlink_wf_op_1')</script></option>
			</select>
		</td>
	</tr>
	<tr align="center">
		<td colspan="3" class="btn_field">
			<input type="button" id="btnURLAction" value="Add" onClick="apply_action();" class="button_submit"/>
			<script> /** change button value here */ 
				$("#btnURLAction").val(get_words('_apply'));
			</script>
		</td>
	</tr>
	</table>
</div>

<div id="addNewURLBlock_Allow" class="box_tn" style="display: none;">
	<div id="addNewURL_Allow" class="CT">
		<script>show_words('_add_weburl_rule');</script>
	</div>
	<table cellspacing="0" cellpadding="0" class="formarea">
	<tr>
		<td class="CL">
			<script>show_words('_adv_txt_00');</script></td>
		<td colspan="2" class="CR">
			<input type="checkbox" id="URLEnable_Allow" />
		</td>
	</tr>
	<tr>
		<td class="CL">
			<script>show_words('_adv_txt_01');</script></td>
		<td colspan="2" class="CR">
			<input type="text" id="URLName_Allow" maxlength="20" size="25" value=""/>
		</td>
	</tr>
	<tr>
		<td class="CL">
			<script>show_words('help725');</script></td>
		<td colspan="2" class="CR">
			<input type="text" id="URLRule_Allow" maxlength="32" size="40" value=""/>
		</td>
	</tr>
	<tr>
		<td class="CL">
			<a href="adv_schedule.asp"><span style="font: normal 14px verdana,arial,sans-serif;"><script>show_words('_sched');</script></span></a></td>
		<td colspan="2" class="CR">
			<span id="URLscheduleField_Allow"></span>
			<script>
				/** Make schedule select */
				$("#URLscheduleField_Allow").html(makeScheduleHTML("sch_URL_Allow"),0);
			
			</script>
		</td>
	</tr>
	<tr align="center">
		<td colspan="3" class="btn_field">
			<!-- Add / Cancel Button here -->
			<input type="button" id="btnAddURLRule_Allow" value="Add" onClick="addURL_Allow();" class="button_submit"/>
			<input type="button" id="btnCancelURLRule_Allow" value="Reset" onCLick="reset_URLRule_Allow();" class="button_submit"/>
			<script> /** change button value here */ 
				$("#btnAddURLRule_Allow").val(get_words('_add'));
				$("#btnCancelURLRule_Allow").val(get_words('_reset'));
			</script>
		</td>
	</tr>
	</table>
</div>

<div id="editURLBlock_Allow" class="box_tn" style="display:none;">
	<div id="editNewURL_Allow" class="CT">
		<script>show_words('_edit_weburl_rule');</script>
	</div>
	<input type="hidden" id="editURLIdx_Allow" value="-1" />
	<table cellspacing="0" cellpadding="0" class="formarea">
	<tr>
		<td class="CL">
			<script>show_words('_adv_txt_00');</script></td>
		<td colspan="2" class="CR">
			<input type="checkbox" id="edit_URLEnable_Allow" />
		</td>
	</tr>
	<tr>
		<td class="CL">
			<script>show_words('_adv_txt_01');</script></td>
		<td colspan="2" class="CR">
			<input type="text" id="edit_URLName_Allow" maxlength="20" size="25" value=""/>
		</td>
	</tr>
	<tr>
		<td class="CL">
			<script>show_words('help725');</script></td>
		<td colspan="2" class="CR">
			<input type="text" id="edit_URLRule_Allow" maxlength="32" size="40" value=""/>
		</td>
	</tr>
	<tr>
		<td class="CL">
			<a href="adv_schedule.asp"><span style="font: normal 14px verdana,arial,sans-serif;"><script>show_words('_sched');</script></span></a></td>
		<td colspan="2" class="CR">
			<span id="edit_URLscheduleField_Allow"></span>														
		</td>
	</tr>
	<tr align="center">
		<td colspan="3" class="btn_field">
			<!-- Add / Cancel Button here -->
			<input type="button" id="btnEditURLRule_Allow" value="Add" onClick="url_setEdit_Allow();" class="button_submit"/>
			<input type="button" id="btnCancelEditURLRule_Allow" value="Cancel" onClick="url_cancelEdit_Allow();" class="button_submit"/>
			<script> /** change button value here */ 
				$("#btnEditURLRule_Allow").val(get_words('_edit'));
				$("#btnCancelEditURLRule_Allow").val(get_words('_cancel'));
			</script>
		</td>
	</tr>
	</table>
</div>

<div id="URLList_Allow" class="box_tn" style="display: none;">
	<div class="CT"><script>show_words('_weburl_rule_list');</script></div>
	<table cellspacing="0" cellpadding="0" class="formarea">
	<tr align="center">
		<td class="CTS" style="word-break:break-all;">
			<script>show_words('_enable');</script></td>
		<td class="CTS" style="word-break:break-all;">
			<script>show_words('_adv_txt_01');</script></td>
		<td class="CTS" style="word-break:break-all;">
			<script>show_words('help725');</script></td>
		<td class="CTS" style="word-break:break-all;">
			<script>show_words('_sched');</script></td>
		<td class="CTS" style="word-break:break-all;">
			<script>show_words('_edit');</script></td>
		<td class="CTS" style="word-break:break-all;">
			<script>show_words('_delete');</script></td>
	</tr>
	<script>
		/** display Rules */
		//showURLLists_Allow();
		//showURLLists();
	</script>
	</table>
</div>

<div id="addNewURLBlock" class="box_tn">
	<div id="addNewURL" class="CT">
		<script>show_words('_add_weburl_rule');</script>
	</div>
	<table cellspacing="0" cellpadding="0" class="formarea">
	<tr>
		<td class="CL">
			<script>show_words('_adv_txt_00');</script></td>
		<td colspan="2" class="CR">
			<input type="checkbox" id="URLEnable" />
		</td>
	</tr>
	<tr>
		<td class="CL">
			<script>show_words('_adv_txt_01');</script></td>
		<td colspan="2" class="CR">
			<input type="text" id="URLName" maxlength="20" size="25" value=""/>
		</td>
	</tr>
	<tr>
		<td class="CL">
			<script>show_words('help725');</script></td>
		<td colspan="2" class="CR">
			<input type="text" id="URLRule" maxlength="32" size="40" value=""/>
		</td>
	</tr>
	<tr>
		<td class="CL">
			<a href="adv_schedule.asp"><span style="font: normal 14px verdana,arial,sans-serif;"><script>show_words('_sched');</script></span></a></td>
		<td colspan="2" class="CR">
			<span id="URLscheduleField"></span>
			<script>
				/** Make schedule select */
				$("#URLscheduleField").html(makeScheduleHTML("sch_URL"),0);
			</script>
		</td>
	</tr>
	<tr align="center">
		<td colspan="3" class="btn_field">
			<!-- Add / Cancel Button here -->
			<input type="button" id="btnAddURLRule" value="Add" onClick="addURL();" class="button_submit"/>
			<input type="button" id="btnCancelURLRule" value="Reset" onCLick="reset_URLRule();" class="button_submit"/>
			<script> /** change button value here */ 
				$("#btnAddURLRule").val(get_words('_add'));
				$("#btnCancelURLRule").val(get_words('_reset'));
			</script>
		</td>
	</tr>
	</table>
</div>

<div id="editURLBlock" class="box_tn" style="display:none;">
	<div id="editNewURL" class="CT">
		<script>show_words('_edit_weburl_rule');</script>
	</div>
	<input type="hidden" id="editURLIdx" value="-1" />
	<table cellspacing="0" cellpadding="0" class="formarea">
	<tr>
		<td class="CL">
			<script>show_words('_adv_txt_00');</script></td>
		<td colspan="2" class="CR">
			<input type="checkbox" id="edit_URLEnable" />
		</td>
	</tr>
	<tr>
		<td class="CL">
			<script>show_words('_adv_txt_01');</script></td>
		<td colspan="2" class="CR">
			<input type="text" id="edit_URLName" maxlength="20" size="25" value=""/>
		</td>
	</tr>
	<tr>
		<td class="CL">
			<script>show_words('help725');</script></td>
		<td colspan="2" class="CR">
			<input type="text" id="edit_URLRule" maxlength="32" size="40" value=""/>
		</td>
	</tr>
	<tr>
		<td class="CL">
			<a href="adv_schedule.asp"><span style="font: normal 14px verdana,arial,sans-serif;"><script>show_words('_sched');</script></span></a></td>
		<td colspan="2" class="CR">
			<span id="edit_URLscheduleField"></span>														
		</td>
	</tr>
	<tr align="center">
		<td colspan="3" class="btn_field">
			<!-- Add / Cancel Button here -->
			<input type="button" id="btnEditURLRule" value="Add" onClick="url_setEdit();" class="button_submit"/>
			<input type="button" id="btnCancelEditURLRule" value="Cancel" onClick="url_cancelEdit();" class="button_submit"/>
			<script> /** change button value here */ 
				$("#btnEditURLRule").val(get_words('_edit'));
				$("#btnCancelEditURLRule").val(get_words('_cancel'));
			</script>
		</td>
	</tr>
	</table>
</div>

<div id="URLList" class="box_tn">
	<div class="CT">
		<script>show_words('_weburl_rule_list');</script>
	</div>
	<table cellspacing="0" cellpadding="0" class="formarea">
	<tr align="center">
		<td class="CTS" style="word-break:break-all;">
			<script>show_words('_enable');</script></td>
		<td class="CTS" style="word-break:break-all;">
			<script>show_words('_adv_txt_01');</script></td>
		<td class="CTS" style="word-break:break-all;">
			<script>show_words('help725');</script></td>
		<td class="CTS" style="word-break:break-all;">
			<script>show_words('_sched');</script></td>
		<td class="CTS" style="word-break:break-all;">
			<script>show_words('_edit');</script></td>
		<td class="CTS" style="word-break:break-all;">
			<script>show_words('_delete');</script></td>
	</tr>
	<script>
		/** display Rules */
		showURLLists();
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
