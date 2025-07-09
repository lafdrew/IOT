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
	var selectIDArray = new Array("", "schedule");

	var menu = new menuObject();

	var array_enable = [], array_name = [], array_intnlip = [], array_mac = [],  array_Schdule = [];
	var array_sch_inst = [];

	var main = new ccpObject();
	var rule_max_num = 25;
	var DataArray_access_website = new Array();
    var DataArray_schedule = new Array();
    var url_edit_control_list="", strGet_url = "";
    var acGlobalEnable 	= "1";	
    
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
	var sch_obj = {
		"cnt":0,"inst":null,"name":null,"allweek":null,"days":null,"allday":null,"timeformat":null,"start_h":null,"start_mi":null,"start_me":null,"end_h":null,"end_mi":null,"end_me":null
	};		
	
	var schedule_cnt = 0;
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
	}		
	
		
	function Data_schedule(onList, name)
	{
		this.OnList = onList ;
		this.Name = name;
	}	
	
	function Data_access_website(enable, name, website_url, schedule, onList)
	{
		this.Enable = enable;
		this.Name = name;
		this.Website_url = website_url;
		this.Schedule = schedule;
		this.OnList = onList ;
	}	
	
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
		html+='<option value="-1"'+(1==selectIdx?' selected="selected"':'')+'>'+get_words('_always')+'</option>';
		html+='<option value="254"'+(254==selectIdx?' selected="selected"':'')+'>'+get_words('_never')+'</option>';
		for(var idx=0 ; idx< sch_obj.cnt ; idx++)
		{
			html+= '<option value=' + (idx+1) + ' ' + (idx+1==selectIdx?'selected="selected"':'') + ' >' + DataArray_schedule.name[idx] + '</option>';
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
				html+= '<option value=' + i + '>' + nam[i] + '</option>';		
			}
			html += '</select>';
			return html;
		}		
	}
		var url_action = "<!--# echo acl_url_filter_enable -->";	
		
		//var acElements = new Array("URLBlock_Action","addNewURLBlock","URLList");	
		
		
		function show_url_enable(){
			if(get_by_id("url_domain_filter_type").value=="0"){
				get_by_id("addNewURLBlock").style.display ="none";
				get_by_id("editURLBlock").style.display ="none";				
				get_by_id("URLList").style.display ="none";
				
			}else{
				url_domain_action();
			}
		}
		function switchAccessControl(val, isPageLoad){
				
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
		$('#sch_URLEdit').val(DataArray_access_website[rowIdx-1].Schedule);
		$("#editURLBlock").show();
		$("#addNewURLBlock").hide();
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
		function url_deleteRow(rowIdx)
	{
	
			if(!confirm(get_words('YM25') + ": " + DataArray_access_website[rowIdx-1].Name + "?"))
			return;
			
		DataArray_access_website[rowIdx-1].Enable= "-1";
		DataArray_access_website[rowIdx-1].Name= "";
		DataArray_access_website[rowIdx-1].Schedule= "";
		DataArray_access_website[rowIdx-1].Website_url= "";
		url_edit_control_list = "";
		url_submitEidt(rowIdx-1);
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
			
			if(DataArray_access_website[i].Enable =="1"){
				obj.add_param_arg('acl_enable','1');
				//get_by_id("acl_enable").value="1";
			}else{
				obj.add_param_arg('acl_enable',get_by_id("acl_enable").value);
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
		
		//Save parent data
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
			
			if(DataArray[i].Enable =="1"){
				obj.add_param_arg('acl_enable','1');
				//get_by_id("acl_enable").value="1";
			}else{
				obj.add_param_arg('acl_enable',get_by_id("acl_enable").value);
			}	
		}
		
		obj.add_param_arg('acl_url_filter_enable',tmp_sel_action);
		obj.add_param_arg('reboot_type','filter');
		var param = obj.get_param();
		totalWaitTime = 20; //second
		redirectURL = location.pathname;
		wait_page();
		jq_ajax_post(param.url, param.arg);
	}
	
	function url_cancelEdit()
	{
		$("#editURLIdx").val(-1);
		$("#editURLBlock").hide();
		$("#addNewURLBlock").show();
	}
	
	function showURLLists()
	{
		var inHtml = '';
		for(var idx=0 ; idx < rule_max_num ; idx++)
		{
			if(idx < 10){
				var temp_rule = get_by_id("acl_url_filter_0" + idx).value;
			}else{
				var temp_rule = get_by_id("acl_url_filter_" + idx).value;
			}
			var rule = temp_rule.split("/");
			if(rule[0]!="" && temp_rule!="")
			{
				var checked = "checked";
				DataArray_access_website[DataArray_access_website.length++] = new Data_access_website(rule[0], rule[1], rule[2], rule[3], idx);

				var schdule_val;			
				if(DataArray_access_website[idx].Schedule == "-1"){
					schdule_val = get_words('_always');
				}else if(DataArray_access_website[idx].Schedule == "254"){
					schdule_val = get_words('_never');
				}else{
					schdule_val = schCfg.name[DataArray_access_website[idx].Schedule];
				}
				if(DataArray_access_website[idx].Enable == "0")
					checked = "";		
			
				inHtml += '' +
					'<tr align="center">'+
						'<td align="center" class="CELL">'+
							'<input disabled="disabled" type="checkbox" id="urlFilterEnable_' + idx + '" ' + checked +'/></td>' +
						'<td align="center" class="CELL" id="urlFilterName_' + idx +'">' + DataArray_access_website[idx].Name + '</td>'+
						'<td align="center" class="CELL" id="urlFilterURL">' + DataArray_access_website[idx].Website_url + '</td>'+
						'<td align="center" class="CELL" id="urlFilterSchedule">' + schdule_val + '</td>' +
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
		obj.set_param_next_page('basic_parental_control.asp');
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
			
			if(DataArray_access_website[i].Enable =="1"){
				obj.add_param_arg('acl_enable','1');
				//get_by_id("acl_enable").value="1";
			}else{
				obj.add_param_arg('acl_enable',get_by_id("acl_enable").value);
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
		//Save parent data
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
			
			if(DataArray[i].Enable =="1"){
				obj.add_param_arg('acl_enable','1');
				//get_by_id("acl_enable").value="1";
			}else{
				obj.add_param_arg('acl_enable',get_by_id("acl_enable").value);
			}			
		}
		
		
		obj.add_param_arg('acl_url_filter_enable',tmp_sel_action);
		obj.add_param_arg('reboot_type','filter');
	//	obj.add_param_arg('acl_enable','1');
		var param = obj.get_param();
		totalWaitTime = 20; //second
		redirectURL = location.pathname;
		wait_page();
		jq_ajax_post(param.url, param.arg);
	
	}
	
		function reset_URLRule()
	{
		$("#URLEnable")[0].checked = false;
		$("#URLName").val("");
		$("#URLRule").val("");
		$("#URLscheduleField").html(makeScheduleHTML("sch_URL"),0);
	}
	
	function url_domain_action(){
		var sel_action = $('#url_domain_filter_type').val();
	//	if($('input[name=AccessControlEnable][value=1]').attr('checked'))
	//	{
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
		//}
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
		obj.set_param_next_page('basic_parental_control.asp');

		for (var i = 0; i < DataArray_access_website.length; i++)
		{
			control_list = DataArray_access_website[i].Enable + "/" + DataArray_access_website[i].Name + "/" + DataArray_access_website[i].Website_url + "/" + DataArray_access_website[i].Schedule;
						 
			if(count < 10)
			{
				obj.add_param_arg('acl_url_filter_0'+ count, control_list);
			}else{
				obj.add_param_arg('acl_url_filter_'+ count, control_list);
			}		
			
			if(DataArray_access_website[i].Enable =="1"){
				obj.add_param_arg('acl_enable','1');
			}else{
				obj.add_param_arg('acl_enable',get_by_id("acl_enable").value);
			}
			
			count++;				 
		}
		//Save parent data
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
			
			if(DataArray[i].Enable =="1"){
				obj.add_param_arg('acl_enable','1');
				//get_by_id("acl_enable").value="1";
			}else{
				obj.add_param_arg('acl_enable',get_by_id("acl_enable").value);
			}			
		}
		
		obj.add_param_arg('acl_url_filter_enable',tmp_sel_action);
		obj.add_param_arg('reboot_type','filter');
		//obj.add_param_arg('acl_enable','1');
		var param = obj.get_param();
		totalWaitTime = 20; //second
		redirectURL = location.pathname;
		wait_page();
		jq_ajax_post(param.url, param.arg);
	}
		
	function onPageLoad()
	{
		var rule_value;
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
			//schedule_cnt++;
		}
/*
		var Application_list = set_application_option(Application_list, default_rule);
		var table_str = '';
			table_str += '<select style=\"width:150px\" id=application name=application onchange="copy_portforward();">';
			table_str += '<option>'+get_words('gw_SelVS')+'</option>';
			table_str += Application_list;
			table_str += '</select>';
			$('#app_list').html(table_str);
			*/
		var table_str = '';
			table_str += "<select id=schedule name=schedule style='width:80px;'>";
			table_str += '<option value=\"-1\">'+get_words('_always')+'</option>';
			table_str += '<option value=\"254\">'+get_words('_never')+'</option>';
			table_str += add_option('Schedule', array_Schdule);
			table_str += "</select>";
			$('#sche_list').html(table_str);
/*		
		var table_str = '';
			table_str += "<select id=inbound_filter name=inbound_filter style='width:80px;'>";
			table_str += '<option value=\"Allow_All\">'+get_words('_allowall')+'</option>';
			table_str += '<option value=\"Deny_All\">'+get_words('_denyall')+'</option>';
			table_str += add_option('Inbound', array_Policy);
			table_str += "</select>";
			$('#pol_list').html(table_str);
		*/
		set_portforward();
		paintTable();
		change_mode();
		//show_url_enable();
		switchAccessControl(acGlobalEnable, true);
		
		}

	//function Data(enable, name, ip_addr, tcpPort, udpPort, schdule, policy, onList)
	function Data(enable, name, ip_addr, mac, schdule, onList)
	{
		this.Enable = enable;
		this.Name = name;
		this.Ip_addr = ip_addr;
		this.MAC = mac; 
		this.Schdule = schdule;
		this.OnList = onList ;
		/*
		var Schdule = _always;
		if(schdule =="-1"){
			Schdule = _always;
		}else if(schdule =="0"){
			Schdule = _never;
		}
		this.Schdule = Schdule;
		*/
	}

	function set_portforward()
	{
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
			DataArray[i].MAC = DataArray[i+1].MAC;
			DataArray[i].Schdule = DataArray[i+1].Schdule;
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
		//DataArray[index] = new Data(is_chk, $('#name').val(), $('#ip').val(), $('#tcp_ports').val(), $('#udp_ports').val(), $('#schedule').val(), $('#inbound_filter').val(), index+1);		
			DataArray[index] = new Data(is_chk, $('#name').val(), $('#ip').val(), $('#mac').val(), $('#schedule').val(), index+1);				
		}else if (index != -1){			
			DataArray[index].Enable = is_chk;
			DataArray[index].Name = $('#name').val();
			DataArray[index].Ip_addr = $('#ip').val();
			DataArray[index].MAC = $('#mac').val();
			DataArray[index].Schdule = $('#schedule').val();
			DataArray[index].OnList = index;
		}
	}

	function clear_reserved()
	{
		$("input[name=sel_del]").each(function () { this.checked = false; });
		set_checked(0, $('#enable')[0]);
		$('#name').val("");
		$('#ip').val("");
		$('#mac').val("");
		$('#schedule').val("-1");//Always
		$('#edit').val(-1);
		$('#add').attr('disabled', '');
        $('#clear').attr('disabled', true);
	}

	function edit_row(idx)
    {
		set_checked(DataArray[idx].Enable, $('#enable')[0]);
        $('#name').val(DataArray[idx].Name);
        $('#ip').val(DataArray[idx].Ip_addr);
        $('#mac').val(DataArray[idx].MAC);
        set_checked(DataArray[idx].Schdule == 255 ? 0 : 1, $('#sch_enable_2')[0]);
		$('#schedule').val(DataArray[idx].Schdule);
		//set_checked(DataArray[idx].Policy == 255 ? 0 : 1, $('#inb_enable_1')[0]);
		//$('#inbound_filter').val(DataArray[idx].Policy);
		$('#edit').val(idx);
		$('#add').val(get_words('_save'));
		$('#clear').attr('disabled', '');
		//setEnable("inb_enable_1");
		setEnable("sch_enable_2");
		
		var ip_val= DataArray[idx].Ip_addr;
		var mac_val= DataArray[idx].MAC;
		if(ip_val != ''){
			set_checked("0", get_by_name("ar_group"));
		}
		if(mac_val !=''){
			set_checked("1", get_by_name("ar_group"));
		}
		change_mode();
    }

	function AddPFtoDatamodel()
	{
		var obj = new ccpObject();
		obj.set_param_url('apply.cgi');
		obj.set_ccp_act('set');
		obj.add_param_event('adv_filters_url');
		obj.set_param_next_page('basic_parental_control.asp');
		obj.add_param_arg('reboot_type', 'filter');
		
		//save url data start
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
		var count = 0;
		for (var i = 0; i < DataArray_access_website.length; i++)
		{
			
				url_edit_control_list = DataArray_access_website[i].Enable + "/" + DataArray_access_website[i].Name + "/" + DataArray_access_website[i].Website_url + "/" + DataArray_access_website[i].Schedule;
				if(count < 10){
					obj.add_param_arg('acl_url_filter_0'+ count, url_edit_control_list);
				}else{
					obj.add_param_arg('acl_url_filter_'+ count, url_edit_control_list);
				}
				
				if(DataArray_access_website[i].Enable =="1"){
				obj.add_param_arg('acl_enable','1');
				//get_by_id("acl_enable").value="1";
				}else{
					obj.add_param_arg('acl_enable',get_by_id("acl_enable").value);
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


			if(DataArray[i].Enable =="1"){
				obj.add_param_arg('acl_enable','1');
			}else{
				obj.add_param_arg('acl_enable',get_by_id("acl_enable").value);
			}
		
			value = DataArray[i].Enable + "/" + DataArray[i].Name + "/" + DataArray[i].Ip_addr + "/" +
					DataArray[i].MAC + "/" + DataArray[i].Schdule;
			
			obj.add_param_arg(key,value);
			
			
		
		}
		
		obj.add_param_arg('acl_url_filter_enable',tmp_sel_action);
		var paramStr = obj.get_param();		
		totalWaitTime = 10; //second
		redirectURL = location.pathname;
		wait_page();
		jq_ajax_post(paramStr.url, paramStr.arg);
	}
	
	function send_request()
	{
	/*	if (!is_form_modified("form3") && !confirm(get_words('_ask_nochange'))) {
			return false;
		}
		*/
		var count = 0;
		
		var tmp_name = $('#name').val();
		var mode = get_checked_value(get_by_name("ar_group"));
		if (tmp_name != "")
		{
			for (var j = 0; j < DataArray.length; j++)
			{
				if($('#edit').val()!=j){
					if (tmp_name == DataArray[j].Name){
						alert(get_words('TEXT060'));
						return false;
					}
					if (mode == "0"){
						if(get_by_id("ip").value == DataArray[j].Ip_addr){
							alert(KR2);
							return false;
						}
					}else{
						if(get_by_id("mac").value == DataArray[j].MAC){
							alert(LS47);
							return false;
						}
					}
				}
				
			}
		}

		var ip = $('#ip').val();
		var mac = $('#mac').val();
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
				//alert(get_words('_pf') + addstr(get_words('_adv_txt_02'), check_name));
				alert(addstr(get_words('up_ai_se_2'), get_words('_adv_txt_01')));
				return false;
			}
			if (mode == "0"){
				if (!check_address(temp_ip_obj)){
					return false;
				}
			}else{
				if (!check_mac(mac)){
				alert(get_words('KR3'));
				return false;
				}
			
			}
		
			
			//if port value have blank, replace to ""
			$('#mac').val($('#mac').val().replace(/ /,""));
		//	$('#udp_ports').val($('#udp_ports').val().replace(/ /,""));
		
			var mode = get_checked_value(get_by_name("ar_group"));
			if (mode == "0"){
				get_by_id("mac").value = "";
			}else{
				get_by_id("ip").value = "";
			}
			
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
			var str_sel = '';
			if (id == 'Schedule') {
				if (def_val == arr[i])
					str_sel = 'selected';
					
				//str += ("<option value=" + arr[i] + " " + str_sel + ">" + arr[i] + "</option>");
				str += ("<option value=" + i + ">" + arr[i] + "</option>");
			} else if (id == 'Inbound') {
				if (def_val == arr[i])
					str_sel = 'selected';
					
				//str +=("<option value=" + arr[i] + " " + str_sel + ">" + arr[i] + "</option>");
				str +=("<option value=" + arr[i] + ">" + arr[i] + "</option>");
			}
		}
		return str;
	}	
	
	function paintTable()
	{
		var contain = '<div class="box_tn">';
			contain += '<div class="CT">'+get_words('_ha_rule_list')+'</div>';
			contain += '<table cellspacing="0" cellpadding="0" class="formarea">';
			contain += '<tr><td class="CTS" style="word-break:break-all;">'+get_words('_enable')+'</td>';
			contain += '<td class="CTS" style="word-break:break-all;">'+get_words('_adv_txt_01')+'</td>';
			contain += '<td class="CTS" style="word-break:break-all;">'+get_words('_address')+'</td>';
		//	contain += '<td class="CTS" style="word-break:break-all;">'+get_words('_sched')+'</td>';
		//contain += '<td width="50" height="22" align="center" class="CTS"><b>'+get_words('INBOUND_FILTER')+'</b></td>';
			contain += '<td width="51" height="22" align="center" class="CTS">'+get_words('_sched')+'</td>';
			contain += '<td class="CTS" style="word-break:break-all;">'+get_words('_edit')+'</td>';
			contain += '<td class="CTS" style="word-break:break-all;">'+get_words('_delete')+'</td>';
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
			var schdule_val;
			
			if(DataArray[i].Schdule == "-1"){
				schdule_val = get_words('_always');
			}else if(DataArray[i].Schdule == "254"){
				schdule_val = get_words('_never');
			}else{
				schdule_val = array_sch_inst[DataArray[i].Schdule];
			}
			contain += '<td align="center" class="CELL">'+(i+1)+'<input type="checkbox" id="sel_enable" name="sel_enable" disabled ' +is_chk+' />'+
					'</td><td align="center" class="CELL">' + DataArray[i].Name +
					'</td><td align="center" class="CELL">' + DataArray[i].Ip_addr + DataArray[i].MAC + 
					//'</td><td align="center" class="CELL">' + DataArray[i].MAC + 
					//'</td><td align="center" class="CELL">' + DataArray[i].Policy +
					'</td><td align="center" class="CELL">' + schdule_val +
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

$(function(){
//	setEnable("inb_enable_1");
	setEnable("sch_enable_2");
});

	function change_mode(){
		var mode = get_checked_value(get_by_name("ar_group"));
		if (mode == "0"){
			get_by_id("ar_ip_field").style.display = "";
			get_by_id("ar_mac_field").style.display = "none";
			get_by_id("mac").disabled = true;
			get_by_id("ip").disabled = false;
		}else{
			get_by_id("ar_ip_field").style.display = "none";
			get_by_id("ar_mac_field").style.display = "";
			get_by_id("ip").disabled = true;
			get_by_id("mac").disabled = false;
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
				<script>document.write(menu.build_structure(0,3,-1));</script>
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
								<script>show_words('_parental_control');</script>
								</div>
								<div class="hr"></div>
								<div class="section_content_border">
								<div class="header_desc" id="lanIntroduction">
									<!--script>show_words('_add_ha_rule');</script-->
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

							<input type="hidden" id="acl_url_filter_enable" name="acl_url_filter_enable" value="<!--# echo acl_url_filter_enable -->">
							
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
							<!--access control-->						         
        					<input type="hidden" id="acl_enable" name="acl_enable" value="<!--# echo acl_enable -->" /> 
		
							<input type="hidden" id="dhcp_list" name="dhcp_list" value="<!--# exec cgi /bin/cmo_get_list dhcpd_leased_table -->">
						    <input type="hidden" id="mac_clone_addr" name="mac_clone_addr" value="<!--# exec cgi /bin/clone mac_clone_addr -->">
							<input type="hidden" id="del" name="del" value="-1" />
							<input type="hidden" id="edit" name="edit" value="-1" />
							<input type="hidden" id="max_row" name="max_row" value="-1" />
			


<form id="form3">
<div class="box_tn">
	<div class="CT"><script>show_words('_add_ha_rule');</script></div>
	<table cellspacing="0" cellpadding="0" class="formarea">
	<tr>
		<td class="CL"><script>show_words('_adv_txt_00');</script></td>
		<td class="CR">
			<input type="checkbox" id="enable" name="enable" value="1" />
		</td>
	</tr>
	<tr>
		<td class="CL"><script>show_words('_adv_txt_01');</script></td>
		<td class="CR">
			<input type="text" id="name" name="name" size="16" maxlength="20" />
			

		</td>
	</tr>
	<!--tr>
		<td class="CL"><script>show_words('_ipaddr');</script></td>
		<td class="CR">
			<input type="text" id="AR_IP" name="AR_IP" size="16" maxlength="15" />&nbsp;<<&nbsp;
				<!--		<input id=copy_app name=copy_app type=button value="<<" style="width: 23;" /> ->
			<select id="ip_list" name="ip_list" onChange="key_word(this,'ip');">
								<option value=""><script>show_words('_hostname');</script></option>
								<script>
								set_mac_list("ip");
								</script>
							</select>
		</td>
	</tr-->
		<tr>
		<td class="CL">
			<script>show_words('aa_AT');</script></td>
		<td colspan="2" class="CR">
			<input type="radio" id="ar_ip" name="ar_group" value="0" onchange="change_mode();">
			<script>show_words('aa_AT_0');</script>
			<input type="radio" id="ar_mac" name="ar_group" value="1" onchange="change_mode();"  checked>
			<script>show_words('aa_AT_1');</script>
		</td>
	</tr>
		<tr id="ar_ip_field" style="display:none;">
		<td class="CL">
			<script>show_words('_ipaddr');</script></td>
		<td colspan="2" class="CR">
			<input type="text" id="ip" maxlength="15" size="20" value=""/>&nbsp;<<&nbsp;
			<!--		<input id=copy_app name=copy_app type=button value="<<" style="width: 23;" /> -->
			<select id="ip_list" name="ip_list" onChange="key_word(this,'ip');">
				<option value=""><script>show_words('_hostname');</script></option>
				<script>
				set_mac_list("ip");
				</script>
			</select>
		</td>
	</tr>
	<tr id="ar_mac_field" style="display:none;">
		<td class="CL">
			<script>show_words('_macaddr');</script></td>
		<td colspan="2" class="CR">
			<input type="text" id="mac" maxlength="17" size="20" value=""/>&nbsp;<<&nbsp;
			<!--		<input id=copy_app name=copy_app type=button value="<<" style="width: 23;" /> -->
			<select id="ip_list" name="ip_list" onChange="key_word(this,'mac');">
				<option value=""><script>show_words('_hostname');</script></option>
				<script>
				set_mac_list("mac");
				</script>
			</select>
		</td>
	</tr>
	<tr>
		<td class="CL">
			<a href="adv_schedule.asp"><span style="font: normal 14px verdana,arial,sans-serif;"><script>show_words('_sched');</script></span></a></td>
		<td class="CR">
			<input type="hidden" id="sch_enable_2" value="1" />
			<span id="sche_list"></span>
			<!--input type="button" id="ln_btn_2" onclick="location.assign('/adv_schedule.asp');" />
			<script>$('#ln_btn_2').val(get_words('tc_new_sch'));</script-->
		</td>
		</tr>
	<tr align="center">
		<td colspan="2" class="btn_field">
			<input name="add" type="button" class="ButtonSmall" id="add" onClick="return send_request()" />
			<script>$('#add').val(get_words('_add'));</script>
			<input name="clear" type="button" class="ButtonSmall" id="clear" onClick="document.location.reload();" />
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

<!-- url filter start -->
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
				$("#URLscheduleField").html(makeScheduleHTML("sch_URL"),0);</script>
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
<!-- url filter end -->

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
