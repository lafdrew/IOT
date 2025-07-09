<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html lang="en-US" xmlns="http://www.w3.org/1999/xhtml" xml:lang="en-US">
<head>
<title>TRENDNET | modelName | Tools | Schedule</title>
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
	
	//var usedSchd = schd.config_val("usedSchd");

	var submit_button_flag = 0;
	var DataArray_schedule = new Array();
	var rule_max_num = 32;
	var rule_max_num_app = 24;
	var from_edit = 0;
	var non_update_name = "";	// GraceYang 2009.06.23 added
	
	var cur_edit_index = -1;
	var cur_edit_inst = 0;
	var arrayIdx = -1;
	var router_tz = "<!--# exec cgi /bin/date +%z-->";
	var router_tz_offset_sign = router_tz.substring(0,1);
	var router_tz_offset_hour = parseInt(router_tz_offset_sign + router_tz.substring(1,3), 10);
	var router_tz_offset_min = parseInt(router_tz_offset_sign + router_tz.substring(3), 10);
	var router_tz_offset = (router_tz_offset_hour*60) + router_tz_offset_min;

function Data_schedule(enable, name, days, start_time, end_time, ampm, onList)
{
	this.Enable = enable;
	this.Name = name;
	this.Days = days;
	this.Start_time = start_time;
	this.End_time = end_time
	this.Ampm = ampm;
	this.OnList = onList ;
}

function time_hour(hour)
{
	var hour_c = hour;
	var time_format = 24;
	if ((parseInt(hour,10) >= 12) && (time_format == "1")){
    		hour_c = 00;
	}
	return hour_c;
}

function check_value(){
	var time_type = get_by_id("allhrs");
	var temp_obj = get_by_id("ruleName").value;
	//var time_format = parseInt(get_by_id("time_format").value,10);
	var time_format = 24;
	var all_week = get_by_name("allWeek");

	if(!all_week[1].checked) {
		var check_day = 0;
		for (var i = 0; i < 7; i++){
			if(get_by_id("week_"+ i).checked== true){
				check_day = 1
				break;
			}
		}

		if(check_day == 0) {
			alert(get_words('GW_SCHEDULES_DAY_INVALID'));
			return false;
		}				
	}
	
	//Remove.  Let user can set overnight.
	/*
	if(!$('#allhrs').attr('checked') && parseInt($('#start_hour').val())*60+parseInt($('#start_min').val()) >= parseInt($('#end_hour').val()*60)+parseInt($('#end_min').val())){
		alert(get_words('GW_SCHEDULES_TIME_INVALID').replace('%s', $('#ruleName').val()));
		return false;
	}
	*/
		
	if(get_by_id("del_row").value == "-1"){	
		if (get_by_id("ruleName").value.length <= 0){
			alert(get_words('GW_SCHEDULES_NAME_INVALID'));
			return false;

		}else if (Find_word(temp_obj,'"') || Find_word(temp_obj,"/")) {
			alert(get_words('tsc_SchRuLs_name') + " " + get_words('illegal_characters') + " " + temp_obj);
			return false;

		}else{
			//var temp_obj = get_by_id("name").value;
			var space_num = 0;
			for (i=0;i<temp_obj.length;i++){
				if (temp_obj.charAt(i)==" "){	
					space_num++
				}
			}
			if(parseInt(space_num,10) >= parseInt(temp_obj.length,10)){
				alert(get_words('GW_INET_ACL_SCHEDULE_NAME_INVALIDa'));
				return false;
			}

			if((temp_obj == "Always")||(temp_obj == "Never") ){
				alert(get_words('GW_SCHEDULES_NAME_RESERVED_INVALIDa'));
				return false;
			}
			for (i = 0; i < rule_max_num; i++){
				if (i < 10){
					var temp_rule = get_by_id("schedule_rule_0" + i).value;
				}else{
					var temp_rule = get_by_id("schedule_rule_" + i).value;
				}
				var rule = temp_rule.split("/");


				if (rule[0] != "" && !from_edit){			
					if (temp_obj == rule[0]){
						alert(get_words('TEXT066'));
						return false;
					}						
				}
			}
		}
		if (!time_type.checked){
			if(time_format == 12){
				//12hr
				if (!check_integer(get_by_id("start_hour").value, 1, 12) || !check_integer(get_by_id("start_min").value, 0, 59)){
					alert(YM184);
					return false;
				}

				if (!check_integer(get_by_id("end_hour").value, 1, 12) || !check_integer(get_by_id("end_min").value, 0, 59)){
					alert(YM184);
					return false;
				}
			}else{
				//24hr
				if (!check_integer(get_by_id("start_hour").value, 0, 23) || !check_integer(get_by_id("start_min").value, 0, 59)){
					alert(YM184);
					return false;
				}

				if (!check_integer(get_by_id("end_hour").value, 0, 23) || !check_integer(get_by_id("end_min").value, 0, 59)){
					alert(YM184);
					return false;
				}
			}
		}
	}
	return true;
}

function padLeft(str,lenght){
	str = String(str);
	if(str.length >= lenght)
		return str;
	else
		return padLeft("0" + str, lenght);
}

function left_shift(str) {
	if (str.length > 0)
		return str.substring(1) + str.charAt(0);
	else
		return "";
}

function right_shift(str) {
	if (str.length > 0)
		return str.charAt(str.length-1) + str.substring(0, str.length-1);
	else
		return "";
}

function add_sche(){
	if(check_value()){
		var obj = new ccpObject();		
		obj.set_param_url('apply.cgi');
		obj.set_ccp_act('set');
		obj.add_param_event('tools_schedules');
		obj.set_param_next_page('adv_schedule.asp');

		//check max row full
		if(get_by_id("edit").value == -1){ //add new row
			if(get_by_id("max_row").value >= parseInt(rule_max_num-1,10)){
				alert(get_words('TEXT015'));
				return;
			}	
		}

		var days_in_week="";
		var start_time_total,end_time_total;
		var p_all_week = get_by_name("allWeek");
		if(p_all_week[1].checked == true){
			days_in_week = "1111111"
		}else{
			for(var i=0;i<7;i++){
				if(get_by_id("week_"+ i).checked== true){
					days_in_week += "1";
				}else{
					days_in_week += "0"
				}
			}	
		}
		var p_all_day = get_by_id("allhrs");
		var time_format = 24;

		var s_hour,s_min;
		var e_hour,e_min;
		var shour, smin, ehour, emin;

		if (p_all_day.checked == true){			
			s_hour = "00"
			e_hour = "23"
			s_min = "00"
			e_min = "59"
		}else{
			//start hour & end hour	
			//24hr
			s_hour = get_digit_number(get_by_id("start_hour").value);
			e_hour = get_digit_number(get_by_id("end_hour").value);

			s_min = get_digit_number(get_by_id("start_min").value);
			e_min = get_digit_number(get_by_id("end_min").value);
		}

		shour = parseInt(s_hour, 10);
		smin = parseInt(s_min, 10);
		ehour = parseInt(e_hour, 10);
		emin = parseInt(e_min, 10);

//add_sche
		var start_total_min = parseInt((shour*60 + smin) - router_tz_offset);
		var end_total_min = parseInt((ehour*60 + emin) - router_tz_offset);
		var set_start_time;
		var set_end_time;
		
		if (start_total_min < 0 ){
			set_start_time = parseInt(start_total_min + 1440);
			days_in_week_offset = left_shift(days_in_week);
		}
		else if (start_total_min >= 1440) {
			set_start_time = parseInt(start_total_min - 1440);
			days_in_week_offset = right_shift(days_in_week);
		} else {
			set_start_time = parseInt(start_total_min);
			days_in_week_offset = days_in_week;
		}
		var set_start_time_hr = parseInt(set_start_time / 60);
		var set_start_time_min = parseInt(set_start_time % 60);
		start_time_total = padLeft(set_start_time_hr, 2) + ":" + padLeft(set_start_time_min, 2);

		if (end_total_min < 0)
			set_end_time = parseInt(end_total_min + 1440);	
		else if (end_total_min >= 1440 )
			set_end_time = parseInt(end_total_min - 1440);
		else
			set_end_time = parseInt(end_total_min);

		var set_end_time_hr = parseInt(set_end_time/60);
		var set_end_time_min = parseInt(set_end_time%60);
		end_time_total = padLeft(set_end_time_hr, 2) + ":" + padLeft(set_end_time_min, 2);
	}

	var dat = get_by_id("ruleName").value +"/"+ days_in_week_offset +"/"+ start_time_total +"/"+ end_time_total +"/"+ time_format;

	//alert(dat);

	var num;
	if(get_by_id("edit").value != -1){	//edit row
		num = parseInt(get_by_id("edit").value,10);
	}else{ //add new row
		num = parseInt(get_by_id("max_row").value,10) + 1;
	}

	for(i=0;i<rule_max_num;i++){
		if (i< 10){
			var temp_rule = get_by_id("schedule_rule_0" + i).value;
		}else{
			var temp_rule = get_by_id("schedule_rule_" + i).value;
		}
		if (temp_rule == ""){
			if (num < 10){
				get_by_id("schedule_rule_0" + num).value = dat;
				obj.add_param_arg('schedule_rule_0'+num, dat);
			}else{
				get_by_id("schedule_rule_" + num).value = dat;
				obj.add_param_arg('schedule_rule_'+num, dat);
			}
			break;
		}else{
			if (i< 10){
				obj.add_param_arg('schedule_rule_0'+i, temp_rule);
			}else{
				obj.add_param_arg('schedule_rule_'+i, temp_rule);
			}
		}
	}		
	//save application rule start
	for(var i=0; i<rule_max_num_app; i++)
	{
		if (i< 10){
			var temp_rule = get_by_id("application_0" + i).value;
		}else{
			var temp_rule = get_by_id("application_" + i).value;
		}
		if (i< 10){
			obj.add_param_arg('application_0'+i, temp_rule);
		}else{
			obj.add_param_arg('application_'+i, temp_rule);
		}
	}
	//save application rule end
	
	//save application rule start
	for(var i=0; i<rule_max_num_app; i++)
	{
		if (i< 10){
			var port_temp_rule = get_by_id("port_forward_both_0" + i).value;
		}else{
			var port_temp_rule = get_by_id("port_forward_both_" + i).value;
		}
		if (i< 10){
			obj.add_param_arg('port_forward_both_0'+i, port_temp_rule);
		}else{
			obj.add_param_arg('port_forward_both_'+i, port_temp_rule);
		}
	}
	//save application rule end

	obj.add_param_arg('reboot_type', 'application+filter');
	var paramForm = obj.get_param();
	totalWaitTime = 20; //second
	redirectURL = location.pathname;
	wait_page();
	jq_ajax_post(paramForm.url, paramForm.arg);
}
	
function get_digit_number(num){
	var tmp_num = parseInt(num, 10);
	if (tmp_num <= 9){
		return "0" + tmp_num;
	}
	return tmp_num;
}

function edit_row(index){
	$('#SaveEditButton').show();
	$('#AddEditButton').hide();
	
	if (index < 10){
		var temp_rule = get_by_id("schedule_rule_0" + index).value;
	}else{
		var temp_rule = get_by_id("schedule_rule_" + index).value;
	}

	var rule = temp_rule.split("/");					
	var is_related = 0;

	for (var l=0 ;l <=rule_max_num ;l++){
		if(l<10){
			var temp_vs_rule = get_by_id("vs_rule_0" + l).value;
			var temp_port_rule = get_by_id("port_forward_both_0" + l).value;
			var temp_application_rule = get_by_id("application_0"+l).value;
			var temp_access_control_rule = get_by_id("access_control_0"+l).value;
		}else{
			if(l<24){
				var temp_rule = get_by_id("schedule_rule_" + l).value;
				var temp_vs_rule = get_by_id("vs_rule_" + l).value;
				var temp_port_rule = get_by_id("port_forward_both_" + l).value;
				var temp_application_rule = get_by_id("application_"+l).value;	
				var temp_access_control_rule = get_by_id("access_control_"+l).value;
			}
		}

		var vs_rule = temp_vs_rule.split("/");	
		var port_rule = temp_port_rule.split("/");
		var application_rule = temp_application_rule.split("/");
		var access_control_rule = temp_access_control_rule.split("/");

		var email_rule = get_by_id("log_email_schedule").value.split("/");
		var access_rule = get_by_id("asp_temp_01").value;

		var vs_rule_schedule = vs_rule[6];			
		var port_rule_schedule = port_rule[5];
		var application_rule_schedule = application_rule[6];
		var access_control_rule_schedule = access_control_rule[5];

		var email_rule_schedule = email_rule[3];
		var temp_wlan0_rule = get_by_id("wlan0_schedule").value;
		var temp_wlan0_vap1_rule = get_by_id("wlan0_vap1_schedule").value; 
		var wlan0_rule = temp_wlan0_rule.split("/");	
		var wlan0_vap1_rule = temp_wlan0_vap1_rule.split("/");	
		var wlan0_rule_schedule = wlan0_rule[0];
		var wlan0_vap1_rule_schedule = wlan0_vap1_rule[0];

		if((rule[0] == email_rule_schedule)||(rule[0] == access_rule)||(rule[0] == vs_rule_schedule)||(rule[0] == port_rule_schedule)||(rule[0] == application_rule_schedule)||(rule[0] == wlan0_rule_schedule)||(rule[0] == wlan0_vap1_rule_schedule)||(rule[0] == access_control_rule_schedule)){
			is_related = 1;
		}
	}

	if(is_related == 1){
		get_by_id("ruleName").disabled = true;	
	}else{
		get_by_id("ruleName").disabled = false;		
	}

	var time_format = rule[4];
	var st_hour, st_min, en_hour, en_min;

//Edit GMT TIME: GraceYang Added 2014/1/22
	var localGMTHours = 0;
	var localGMTmin = 0;
	var dateLocal = new Date();

	localGMTHours = parseInt(dateLocal.getTimezoneOffset()/60) ; // offset
	localGMTmin = dateLocal.getTimezoneOffset()%60 ;
	var ts_year,ts_month,ts_day,te_year,te_month,te_day;
	
	ts_year = dateLocal.getFullYear();
    	ts_month = dateLocal.getMonth()+1;
    	ts_day = dateLocal.getDate();
	te_year = dateLocal.getFullYear();
	te_month = dateLocal.getMonth()+1;
	te_day = dateLocal.getDate();
	
	var ts_hour_min = rule[2].split(":");
	var te_hour_min = rule[3].split(":");
	var tsyear = parseInt(ts_year); 
	var tsmonth = parseInt(ts_month) - 1; 
	var tsday = parseInt(ts_day); 
	var tshour = parseInt(ts_hour_min[0]); 
	var tsmin = parseInt(ts_hour_min[1]); 

	var teyear = parseInt(te_year); 
	var temonth = parseInt(te_month) - 1; 
	var teday = parseInt(te_day); 
	var tehour = parseInt(te_hour_min[0]); 
	var temin = parseInt(te_hour_min[1]); 
//edit_row
	var start_total_min = parseInt((tshour*60 + tsmin) + router_tz_offset);
	var end_total_min = parseInt((tehour*60 + temin) + router_tz_offset);
	var set_start_time;
	var set_end_time;
	var days_in_week_offset="";
	
	if (start_total_min < 0 ){
		set_start_time = parseInt(start_total_min + 1440);
		days_in_week_offset = left_shift(rule[1]);
	}				
	else if (start_total_min >= 1440 ){
		set_start_time = parseInt(start_total_min - 1440) ;
		days_in_week_offset = right_shift(rule[1]);
	
	}else{
		set_start_time = parseInt(start_total_min);
		days_in_week_offset = rule[1];
	}
	
	var set_start_time_hr = parseInt(set_start_time/60);
	var set_start_time_min = parseInt(set_start_time%60);
	
	
	if (end_total_min < 0 )
		set_end_time = parseInt(end_total_min + 1440);
	else if (end_total_min >= 1440 )
		set_end_time = parseInt(end_total_min - 1440) ;
	else
		set_end_time = parseInt(end_total_min);
	
	var set_end_time_hr = parseInt(set_end_time/60);
	var set_end_time_min = parseInt(set_end_time%60);

	rule[2] = padLeft(set_start_time_hr, 2) + ":" + padLeft(set_start_time_min, 2);
	rule[3] = padLeft(set_end_time_hr, 2) + ":" + padLeft(set_end_time_min, 2);

	get_by_id("start_hour").value = set_start_time_hr;
	get_by_id("end_hour").value = set_end_time_hr;
	get_by_id("start_min").value = set_start_time_min;
	get_by_id("end_min").value = set_end_time_min;

	if(rule[2] == "00:00" && rule[3] == "23:59") 
	{
		$('#allhrs').attr('checked', true);
		$('#start_hour').val(0);
		$('#start_min').val(0);
		$('#end_hour').val(0);
		$('#end_min').val(0);
	}

	var week_str = new Array(7);
	var num=0;
	var tmp_allweek = 0;
	
	for (var i = 0; i < 7; i++){
		if (days_in_week_offset.charAt(i) == "1"){
			week_str[i] = 1;
		}else{
			week_str[i] = 0;
		}
	}
	
	if(days_in_week_offset == "1111111"){
		tmp_allweek = 1;
		for(var j=0;j<7;j++){
			$('#week_'+j).attr('checked', false);
		}
	}else{
		for(var j=0;j<7;j++){
			if(week_str[j]== 1){
				$('#week_'+j).attr('checked', true);
			}else{
				$('#week_'+j).attr('checked', false);
			}
		}
	}
	
	$('#ruleName').val(rule[0]);
	$('input[name=allWeek][value='+tmp_allweek+']').attr('checked', true);
	setEventDays();
	setEventAllDay();
	get_by_id("edit").value = index;
	change_color("rule_list", index+1);
	from_edit = 1;
}


function del_row(row){	
	if (row < 10){
		var temp_rule = get_by_id("schedule_rule_0" + row).value;
	}else{
		var temp_rule = get_by_id("schedule_rule_" + row).value;
	}		
	var rule = temp_rule.split("/");

	for (var l=0 ;l <=rule_max_num ;l++){
		if(l<10){
			var temp_vs_rule = get_by_id("vs_rule_0" + l).value;
			var temp_port_rule = get_by_id("port_forward_both_0" + l).value;
			var temp_application_rule = get_by_id("application_0"+l).value;
			var temp_access_control_rule = get_by_id("access_control_0"+l).value;
		}else{
			if(l<24){
				var temp_rule = get_by_id("schedule_rule_" + l).value;
				var temp_vs_rule = get_by_id("vs_rule_" + l).value;
				var temp_port_rule = get_by_id("port_forward_both_" + l).value;
				var temp_application_rule = get_by_id("application_"+l).value;	
				var temp_access_control_rule = get_by_id("access_control_"+l).value;
			}
		}

		var vs_rule = temp_vs_rule.split("/");	
		var port_rule = temp_port_rule.split("/");
		var application_rule = temp_application_rule.split("/");
		var access_control_rule = temp_access_control_rule.split("/");

		var email_rule = get_by_id("log_email_schedule").value.split("/");
		var access_rule = get_by_id("asp_temp_01").value;

		var vs_rule_schedule = vs_rule[6];			
		var port_rule_schedule = port_rule[5];
		var application_rule_schedule = application_rule[6];
		var access_control_rule_schedule = access_control_rule[5];

		var email_rule_schedule = email_rule[3];
		var temp_wlan0_rule = get_by_id("wlan0_schedule").value;
		var temp_wlan0_vap1_rule = get_by_id("wlan0_vap1_schedule").value; 
		var wlan0_rule = temp_wlan0_rule.split("/");	
		var wlan0_vap1_rule = temp_wlan0_vap1_rule.split("/");
		var wlan0_rule_schedule = wlan0_rule[0];
		var wlan0_vap1_rule_schedule = wlan0_vap1_rule[0];

		if((rule[0] == email_rule_schedule)||(rule[0] == access_rule)||(rule[0] == vs_rule_schedule)||(rule[0] == port_rule_schedule)||(rule[0] == application_rule_schedule)||(rule[0] == wlan0_rule_schedule)||(rule[0] == wlan0_vap1_rule_schedule)||(rule[0] == access_control_rule_schedule) ){
			alert(get_words('TEXT063'));
			return;
		}
	}

	if (confirm(get_words('YM35') + ": " + DataArray_schedule[row].Name + "?")){
		DataArray_schedule[row].Enable= "-1";
		DataArray_schedule[row].Name= "";
		DataArray_schedule[row].Days= "";
		DataArray_schedule[row].Start_time= "";
		DataArray_schedule[row].End_time= "";
		DataArray_schedule[row].Ampm= "";
		get_by_id("del_row").value = row;
		delete_data();
		//get_by_id("button").click();
	}else{
		return ;
	}
}

function delete_data(){
	var obj = new ccpObject();
	obj.set_param_url('apply.cgi');
	obj.set_ccp_act('set');
	obj.add_param_event('tools_schedules');
	obj.set_param_next_page('adv_schedule.asp');

	var tmp_schedule_rule_list;
	var count=0;
	
	for (var i = 0; i < DataArray_schedule.length; i++)
	{
		if (DataArray_schedule[i].Enable != "-1")
		{
		
		
			if (i < 10){
				var tmp_schedule_rule_list = get_by_id("schedule_rule_0" + i).value;
			}else{
				var tmp_schedule_rule_list = get_by_id("schedule_rule_" + i).value;
			}
					
//				tmp_schedule_rule_list = DataArray_schedule[i].Name + "/" + DataArray_schedule[i].Days + "/" + DataArray_schedule[i].Start_time
//				 + "/" + DataArray_schedule[i].End_time + "/" + DataArray_schedule[i].Ampm;

			if(count < 10){
				obj.add_param_arg('schedule_rule_0'+ count, tmp_schedule_rule_list);
			}else{
				obj.add_param_arg('schedule_rule_'+ count, tmp_schedule_rule_list);
			}
		count++;
		}
	}
	
	get_by_id("schedule_rule_09").value = "";
	obj.add_param_arg("schedule_rule_09","");	
	
	obj.add_param_arg('reboot_type', 'application+filter');
	var paramForm = obj.get_param();
	totalWaitTime = 20; //second
	redirectURL = location.pathname;
	wait_page();
	jq_ajax_post(paramForm.url, paramForm.arg);
	
}

function setEventDays(){
		var func = function(){
			var chk_allweek = $('input[name=allWeek]:checked').val();
			if(chk_allweek=='1'){
				$('#week_0,#week_1,#week_2,#week_3,#week_4,#week_5,#week_6').attr('disabled','disabled');
			}
			else{
				$('#week_0,#week_1,#week_2,#week_3,#week_4,#week_5,#week_6').attr('disabled','');
			}
		};
		func();
		$('input[name=allWeek]').change(func);
		$('input[name=allWeek]').click(func);
}
function setEventAllDay(){
		var func = function(){
			var chk_allday = $('#allhrs').attr('checked');
			if(chk_allday){
				$('#start_hour,#end_hour,#start_min,#end_min').attr('disabled','disabled');
			}
			else{
				$('#start_hour,#end_hour,#start_min,#end_min').attr('disabled','');
			}
		};
		func();
		$('#allhrs').change(func);
}

function week2word(week){
	var word = [get_words('_Sun'),get_words('_Mon'),get_words('_Tue'),get_words('_Wed'),get_words('_Thu'),get_words('_Fri'),get_words('_Sat')];
	return word[parseInt(week)];
}

function getdays(idx){
	if(scheCfg.allweek[idx]=='1')
		return get_words('tsc_AllWk');
	else{
		var w=[];
		for(var i=0;i<7;i++)
			if(scheCfg.days[idx].substring(i,i+1)=='1')
			w.push(week2word(i));
		return w.join(', ');
	}
}
	/* 
	 * 在字串前補0到給定長度
	 */
function p02l(word, length){
	if(length==undefined)
		length=2;
	while(word.length<length){
		word = '0'+word;
	}
	return word;
}

function gettimeRanges(idx){
	if(scheCfg.allday[idx]=='1')
		return get_words('_24hr');
	else{
		var w=p02l(scheCfg.start_h[idx])+':'+p02l(scheCfg.start_mi[idx])+'~'+p02l(scheCfg.end_h[idx])+':'+p02l(scheCfg.end_mi[idx]);
		return w;
	}
}

function setValueScheduleRuleList(){
	var obj = $('#rule_list');
	
	for(i=0;i<rule_max_num;i++){
		if (i< 10){
			var temp_rule = get_by_id("schedule_rule_0" + i).value;
		}else{
			var temp_rule = get_by_id("schedule_rule_" + i).value;
		}
		if (temp_rule == ""){edit_row
			break;					
		}
		get_by_id("max_row").value = i;
		
		var rule = temp_rule.split("/");
		var temp_time_array = rule[2]+ "~" + rule[3];
		var tstime = rule[2].split(":");
		var tetime = rule[3].split(":");

		var start_total_min = (parseInt(tstime[0], 10) * 60 + parseInt(tstime[1], 10) + router_tz_offset);
		var end_total_min = (parseInt(tetime[0], 10) * 60 + parseInt(tetime[1], 10) + router_tz_offset);
		var set_start_time;
		var set_end_time;
		var day_in_week = rule[1];
		var days_in_week_offset="";

		if (start_total_min < 0 ) {
			set_start_time = parseInt(start_total_min + 1440);
			days_in_week_offset = left_shift(day_in_week);
		}
		else if (start_total_min >= 1440 ) {
			set_start_time = parseInt(start_total_min -1440) ;
			days_in_week_offset = right_shift(day_in_week);
		} else {
			set_start_time = parseInt(start_total_min);
			days_in_week_offset = day_in_week;
		}

		var set_start_time_hr = parseInt(set_start_time/60);
		var set_start_time_min = parseInt(set_start_time%60);

		if (end_total_min < 0 ){
			set_end_time = parseInt(end_total_min + 1440);
		}				
		else if (end_total_min >= 1440 ){
			set_end_time = parseInt(end_total_min -1440) ;
		}else
			set_end_time = parseInt(end_total_min);
	
		var set_end_time_hr = parseInt(set_end_time/60);
		var set_end_time_min = parseInt(set_end_time%60);

	    	rule[2] = padLeft(set_start_time_hr, 2) + ":" + padLeft(set_start_time_min, 2);
		rule[3] = padLeft(set_end_time_hr, 2) + ":" + padLeft(set_end_time_min, 2);

		if (rule[2] == "00:00" && rule[3] == "23:59")
			temp_time_array = get_words('tsc_AllDay');
		else
			temp_time_array = rule[2] +"~"+rule[3];

		var s = new Array();	

		for(var j = 0; j < 8; j++){
			if(days_in_week_offset.charAt(j) == "1"){
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
			s_day = get_words('tsc_AllWk');
		}

		DataArray_schedule[DataArray_schedule.length++] = new Data_schedule("1", rule[0], rule[1], rule[2], rule[3], rule[4], i);
				
		var child='<tr>\
								<td id="ruleName'+i+'" align="center" class="CELL">'+rule[0]+'</td>\
								<td id="days'+i+'" align="center" class="CELL">'+s_day+'</td>\
								<td id="timeRanges'+i+'" align="center" class="CELL">'+temp_time_array+'</td>\
								<td align="center" class="CELL"><a href="javascript:edit_row('+i+');"><img src="edit.gif" /></a></td>\
								<td align="center" class="CELL"><a href="javascript:del_row('+i+');"><img src="delete.gif" /></a></td>\
							</tr>';
		obj.append(child);
	}	
}

$(function(){
	//Add Schedule Rule
	setEventDays();
	setEventAllDay();
	
	//Schedule Rule List
	setValueScheduleRuleList();
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
				<script>document.write(menu.build_structure(1,1,4))</script>
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
							<div class="headerbg" id="scheduleTitle">
							<script>show_words('_schedule_rules');</script>
							</div>
							<div class="hr"></div>
							<div class="section_content_border">
							<div class="header_desc" id="scheduleIntroduction">
								<script>show_words('_SCHEDULE_DESC');</script>
								<p></p>
							</div>

					<form id="form1" name="form1" method="post" action="apply.cgi">
						<input type="hidden" id="html_response_page" name="html_response_page" value="count_down.asp">
						<input type="hidden" id="html_response_message" name="html_response_message" value=""><script>get_by_id("html_response_message").value = get_words('sc_intro_sv');</script>
						<input type="hidden" id="html_response_return_page" name="html_response_return_page" value="tools_schedules.asp">
						<!--input type="hidden" id="reboot_type" name="reboot_type" value="application"-->
						<input type="hidden" id="action" name="action" value="tools_schedules">
						<input type="hidden" id="edit" name="edit" value="-1">
						<input type="hidden" id="del_row" name="del_row" value="-1">
						<input type="hidden" id="max_row" name="max_row" value="-1">
						
						<input type="hidden" id="log_email_schedule" name="log_email_schedule" value="<!--# echo log_email_schedule -->"> <!-- email -->
						<input type="hidden" id="asp_temp_01" name="asp_temp_01" value="<!--# echo asp_temp_01 -->">	<!-- schedule -->
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
						<input type="hidden" id="wlan0_schedule" name="wlan0_schedule" value="<!--# echo wlan0_schedule -->">
						<input type="hidden" id="wlan0_vap1_schedule" name="wlan0_vap1_schedule" value="<!--# echo wlan0_vap1_schedule -->">
						
						<input type="hidden" id="access_control_00" name="access_control_00" value="<!--# echo access_control_00 -->">
						<input type="hidden" id="access_control_01" name="access_control_01" value="<!--# echo access_control_01 -->">
						<input type="hidden" id="access_control_02" name="access_control_02" value="<!--# echo access_control_02 -->">
						<input type="hidden" id="access_control_03" name="access_control_03" value="<!--# echo access_control_03 -->">
						<input type="hidden" id="access_control_04" name="access_control_04" value="<!--# echo access_control_04 -->">
						<input type="hidden" id="access_control_05" name="access_control_05" value="<!--# echo access_control_05 -->">
						<input type="hidden" id="access_control_06" name="access_control_06" value="<!--# echo access_control_06 -->">
						<input type="hidden" id="access_control_07" name="access_control_07" value="<!--# echo access_control_07 -->">
						<input type="hidden" id="access_control_08" name="access_control_08" value="<!--# echo access_control_08 -->">
						<input type="hidden" id="access_control_09" name="access_control_09" value="<!--# echo access_control_09 -->">
						<input type="hidden" id="access_control_10" name="access_control_10" value="<!--# echo access_control_10 -->">
						<input type="hidden" id="access_control_11" name="access_control_11" value="<!--# echo access_control_11 -->">
						<input type="hidden" id="access_control_12" name="access_control_12" value="<!--# echo access_control_12 -->">
						<input type="hidden" id="access_control_13" name="access_control_13" value="<!--# echo access_control_13 -->">
						<input type="hidden" id="access_control_14" name="access_control_14" value="<!--# echo access_control_14 -->">
						<input type="hidden" id="access_control_15" name="access_control_15" value="<!--# echo access_control_15 -->">
						<input type="hidden" id="access_control_16" name="access_control_16" value="<!--# echo access_control_16 -->">
						<input type="hidden" id="access_control_17" name="access_control_17" value="<!--# echo access_control_17 -->">
						<input type="hidden" id="access_control_18" name="access_control_18" value="<!--# echo access_control_18 -->">
						<input type="hidden" id="access_control_19" name="access_control_19" value="<!--# echo access_control_19 -->">
						<input type="hidden" id="access_control_20" name="access_control_20" value="<!--# echo access_control_20 -->">
						<input type="hidden" id="access_control_21" name="access_control_21" value="<!--# echo access_control_21 -->">
						<input type="hidden" id="access_control_22" name="access_control_22" value="<!--# echo access_control_22 -->">
						<input type="hidden" id="access_control_23" name="access_control_23" value="<!--# echo access_control_23 -->">

							<div id="AccessControlMain" class="box_tn">
								<div class="CT"><script>show_words('_add_sche_rule');</script></div>
								<table cellspacing="0" cellpadding="0" class="formarea">
								<tr>
									<td class="CL"><script>show_words('_adv_txt_01');</script></td>
									<td class="CR"><input type="text" name="ruleName" id="ruleName" maxlength="15" value="" /></td>
								</tr>
								<tr>
									<td class="CL"><script>show_words('_days');</script></td>
									<td class="CR"><input type="radio" name="allWeek" value="0"><script>show_words('tsc_sel_days');</script>&nbsp;
										<input type="radio" name="allWeek" value="1" checked><script>show_words('tsc_AllWk');</script></td>
								</tr>
								<tr>
									<td class="CL">&nbsp;</td>
									<td class="CR">
										<input type="checkbox" id="week_0" name="week_0" /><script>show_words('_Sun');</script>
										<input type="checkbox" id="week_1" name="week_1" /><script>show_words('_Mon');</script>
										<input type="checkbox" id="week_2" name="week_2" /><script>show_words('_Tue');</script>
										<input type="checkbox" id="week_3" name="week_3" /><script>show_words('_Wed');</script>
										<input type="checkbox" id="week_4" name="week_4" /><script>show_words('_Thu');</script>
										<input type="checkbox" id="week_5" name="week_5" /><script>show_words('_Fri');</script>
										<input type="checkbox" id="week_6" name="week_6" /><script>show_words('_Sat');</script>
									</td>
								</tr>
								<tr>
									<td class="CL"><script>show_words('_tsc_allday_24hr');</script></td>
									<td class="CR"><input type="checkbox" id="allhrs" name="allhrs" /></td>
								</tr>
								<tr>
									<td class="CL"><script>show_words('tsc_start_time');</script></td>
									<td class="CR">
										<span id="start_hour_field"><select id="start_hour" name="start_hour"><option value="0">00</option><option value="1">01</option><option value="2">02</option><option value="3">03</option><option value="4">04</option><option value="5">05</option><option value="6">06</option><option value="7">07</option><option value="8">08</option><option value="9">09</option><option value="10">10</option><option value="11">11</option><option value="12">12</option><option value="13">13</option><option value="14">14</option><option value="15">15</option><option value="16">16</option><option value="17">17</option><option value="18">18</option><option value="19">19</option><option value="20">20</option><option value="21">21</option><option value="22">22</option><option value="23">23</option></select></span> : <span id="start_min_field"><select id="start_min" name="start_min"><option value="0">00</option><option value="1">01</option><option value="2">02</option><option value="3">03</option><option value="4">04</option><option value="5">05</option><option value="6">06</option><option value="7">07</option><option value="8">08</option><option value="9">09</option><option value="10">10</option><option value="11">11</option><option value="12">12</option><option value="13">13</option><option value="14">14</option><option value="15">15</option><option value="16">16</option><option value="17">17</option><option value="18">18</option><option value="19">19</option><option value="20">20</option><option value="21">21</option><option value="22">22</option><option value="23">23</option><option value="24">24</option><option value="25">25</option><option value="26">26</option><option value="27">27</option><option value="28">28</option><option value="29">29</option><option value="30">30</option><option value="31">31</option><option value="32">32</option><option value="33">33</option><option value="34">34</option><option value="35">35</option><option value="36">36</option><option value="37">37</option><option value="38">38</option><option value="39">39</option><option value="40">40</option><option value="41">41</option><option value="42">42</option><option value="43">43</option><option value="44">44</option><option value="45">45</option><option value="46">46</option><option value="47">47</option><option value="48">48</option><option value="49">49</option><option value="50">50</option><option value="51">51</option><option value="52">52</option><option value="53">53</option><option value="54">54</option><option value="55">55</option><option value="56">56</option><option value="57">57</option><option value="58">58</option><option value="59">59</option></select></span>
									</td>
								</tr>
								<tr>
									<td class="CL"><script>show_words('tsc_end_time');</script></td>
									<td class="CR">
										<span id="end_hour_field"><select id="end_hour" name="end_hour"><option value="0">00</option><option value="1">01</option><option value="2">02</option><option value="3">03</option><option value="4">04</option><option value="5">05</option><option value="6">06</option><option value="7">07</option><option value="8">08</option><option value="9">09</option><option value="10">10</option><option value="11">11</option><option value="12">12</option><option value="13">13</option><option value="14">14</option><option value="15">15</option><option value="16">16</option><option value="17">17</option><option value="18">18</option><option value="19">19</option><option value="20">20</option><option value="21">21</option><option value="22">22</option><option value="23">23</option></select></span> : <span id="end_min_field"><select id="end_min" name="end_min"><option value="0">00</option><option value="1">01</option><option value="2">02</option><option value="3">03</option><option value="4">04</option><option value="5">05</option><option value="6">06</option><option value="7">07</option><option value="8">08</option><option value="9">09</option><option value="10">10</option><option value="11">11</option><option value="12">12</option><option value="13">13</option><option value="14">14</option><option value="15">15</option><option value="16">16</option><option value="17">17</option><option value="18">18</option><option value="19">19</option><option value="20">20</option><option value="21">21</option><option value="22">22</option><option value="23">23</option><option value="24">24</option><option value="25">25</option><option value="26">26</option><option value="27">27</option><option value="28">28</option><option value="29">29</option><option value="30">30</option><option value="31">31</option><option value="32">32</option><option value="33">33</option><option value="34">34</option><option value="35">35</option><option value="36">36</option><option value="37">37</option><option value="38">38</option><option value="39">39</option><option value="40">40</option><option value="41">41</option><option value="42">42</option><option value="43">43</option><option value="44">44</option><option value="45">45</option><option value="46">46</option><option value="47">47</option><option value="48">48</option><option value="49">49</option><option value="50">50</option><option value="51">51</option><option value="52">52</option><option value="53">53</option><option value="54">54</option><option value="55">55</option><option value="56">56</option><option value="57">57</option><option value="58">58</option><option value="59">59</option></select></span>
									</td>
								</tr>
								</table>
								<table cellspacing="0" cellpadding="0" class="formarea">
								<tr align="center">
									<td class="btn_field">
										<input type="button" class="button_submit" id="SaveEditButton" value="Save" onclick="add_sche();" style="display:none;" />
										<script>$('#SaveEditButton').val(get_words('_save'));</script>
										<input type="button" class="button_submit" id="AddEditButton" value="Add" onclick="add_sche();" />
										<script>$('#AddEditButton').val(get_words('_add'));</script>
										<input type="reset" class="button_submit" id="ClearEditButton" value="Clear" onclick="window.location.reload(true)" />
										<script>$('#ClearEditButton').val(get_words('_clear'));</script>
									</td>
								</tr>
								</table>
							</div>
							
							<div class="box_tn">
								<div class="CT"><script>show_words('_schedule_rule_list');</script></div>
								<table id="rule_list" cellspacing="0" cellpadding="0" class="formarea">
								<tr align="center">
									<td class="CTS"><script>show_words('_adv_txt_01');</script></td>
									<td class="CTS"><script>show_words('_days');</script></td>
									<td class="CTS"><script>show_words('_time_stamp');</script></td>
									<td class="CTS"><script>show_words('_edit');</script></td>
									<td class="CTS"><script>show_words('_delete');</script></td>
								</tr>
								</table>
							</div>
							</div>
						</form>
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
