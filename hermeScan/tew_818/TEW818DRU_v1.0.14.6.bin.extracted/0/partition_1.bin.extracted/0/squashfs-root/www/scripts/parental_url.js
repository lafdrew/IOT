var url_CurrentTrId = 0;
var url_editEntry = 0;
var schedule_editEntry = 0;
var url_filter_list = new Array();
var url_filter_num = "<% getListNum(5); %>";
var url_full_list_string = "<% constructList(5); %>";
var schedule_num = "<% getListNum(0); %>";
var full_list_string = "<% constructList(0); %>";
var uid_assigned = "<% nvram_get("schedule_uid"); %>";
var schedule_list = new Array();

function url_filter_list_entry(lan_ip, url, sched, enable)
{
	this.lan_ip = lan_ip;
	this.url = url;
	this.sched = sched;
	this.enable = enable;
}

function schedule_list_entry(uid, name, time)
{
	this.uid = uid;
	this.name = name;
	this.time = time;
}

function show_web_url(idx)
{
	var str = "";

	str += url_filter_list[idx].url;
	
	return str;
}

function show_url_schedule(idx)
{
	var str = "";
	var i = 0;
	var num = document.getElementById("filter_sched").length;
	
	if (num == 1) {
		str += "<!--#tr id="always"-->Always<!--#endtr-->";
	}
	else {
		while (i < num) {
			if (url_filter_list[idx].sched == document.getElementById("filter_sched").options[i].value) {
				str += document.getElementById("filter_sched").options[i].text;
				break;
			}

			i++;
		}
	}

	if (str == "") {
		str += "<!--#tr id="always"-->Always<!--#endtr-->";
	}

	return str;
}

function show_url_enable(idx)
{
	var str = "";

	if (url_filter_list[idx].enable == "on") {
		str += "<!--#tr id="active"-->Active<!--#endtr-->";
	}
	else if (url_filter_list[idx].enable == "off") {
		str += "<!--#tr id="inactive"-->Inactive<!--#endtr-->";
	}

	return str;
}

function dyn_add_url_sched_option()
{
	var F = document.forms[0];
	var str = "";
	var i = 0;
	var num = "<% getListNum(0); %>"; 
	var sched_list_string =  "<% constructList(0); %>";
	var sche_list = sched_list_string.split("/");

	while (i < num) {
		var list_value = sche_list[i].split(",");

		var opt = new Option(list_value[1], list_value[0], false, false);
		F.web_sched.options.add(opt);
		i++;
	}
}

function dyn_select_url_sched_option()
{
	var F = document.forms[0];
	var selvalue = F.web_sched;
	var cookie_str = document.cookie;
	var c_start, c_end, schedule_uid, count = 0, i;

	c_start = cookie_str.indexOf("new_schedule=");
	
	if (cookie_str.length > 0) {
		if (c_start != -1) {
			c_start = c_start + "new_schedule=".length;
			c_end = cookie_str.indexOf(";", c_start);
			if (c_end == -1) {
				c_end = cookie_str.length;
			}
			schedule_uid = cookie_str.substring(c_start, c_end);

		//	document.cookie = "new_schedule=; expires=Thu, 01, Jan 1970 00:00:00 UTC"

			for (i = 0; i < selvalue.length; i++) {
				if (schedule_uid == selvalue.options[i].value)
					count++;
			}

			if (count == 1)
				selvalue.value = schedule_uid;
			else
				selvalue.value = "0";			
		}
	}
}


function del_url_array_element(idx)
{
	for (var i = idx; i < url_filter_list.length - 1 ; i++) {
		url_filter_list[i] = url_filter_list[ i + 1];
	}

	url_filter_list.length = url_filter_list.length - 1;
}

function del_url_filter_list(idx)
{
	var tbody = document.getElementById("summary_tableList").getElementsByTagName("TBODY")[0];
	
	for (var j = tbody.rows.length; j > 1; j--) { 
		tbody.deleteRow(j - 1);
	}

	del_url_array_element(idx);

	for (var i = 0; i < url_filter_list.length; i++) {
		add_url_list(i);
	}
	for (var i = 0; i < ip_filter_list.length; i++) {
		add_ip_list(i);
	}
	

	url_editEntry = 0;
}

function edit_schedule(schedule_uid)
{
	var F = document.forms[0];
	open_parental_schedule();
	var idx = 0, i = 0;
	var num = schedule_list.length;

	while(i < num){
		if(schedule_list[i].uid == schedule_uid) {
			idx = i;
			break;
		}
		i++;
	}
	
	CurrentTrId = idx;
	var start_day = 0;
	var start_time = "";
	var end_time = "";
	var time_temp = "";
	var select_day = "";
	var id = "";
	var obj_temp = schedule_list[idx].time;
	var obj =obj_temp.split('<');
	var day_time="";
	var day_time_temp = ""
	var time = "";
	var i=0, k = 0, j = 0;
	
	F.ruleUid.value = schedule_list[idx].uid;
	F.addRuleName.value = schedule_list[idx].name;
	
	for(i = 0; i < obj.length/2; i++){
		time_temp = obj[(2*i)+1];
		day_time = time_temp.split(':');
		select_day = parseInt(day_time[0],10);
		start_time = parseInt(day_time[1].substring(0,2),10);
		end_time = parseInt(day_time[1].substring(2,4),10);
		if(select_day == 127 && start_time == 0 && end_time == 24) {
			for(j=0;j<7;j++){
				for(k=0;k<24;k++){
					schedule_array[j][k] = 1;
						if(k<10){
							k = "0"+k;
						}

						id = j.toString() + k.toString();
						document.getElementById(id).className = "checked";
					}
				}
		}
		else {
			if (select_day & 1) {
				schedule_array[0][start_time] = 1;
				if(start_time < 10)
					time = "0" + start_time;
				else
					time = start_time;
				id = "0" + time.toString();
				document.getElementById(id).className = "checked";
			}
			if (select_day & 2) {
				schedule_array[1][start_time] = 1;
				if(start_time < 10)
					time = "0" + start_time;
				else
					time = start_time;
				id = "1" + time.toString();
				document.getElementById(id).className = "checked";
			}
			if (select_day & 4) {
				schedule_array[2][start_time] = 1;
				if(start_time < 10)
					time = "0" + start_time;
				else
					time = start_time;
				id = "2" + time.toString();
				document.getElementById(id).className = "checked";
			}
			if (select_day & 8) {
				schedule_array[3][start_time] = 1;
				if(start_time < 10)
					time = "0" + start_time;
				else
					time = start_time;
				id = "3" + time.toString();
				document.getElementById(id).className = "checked";
			}
			if (select_day & 16) {
				schedule_array[4][start_time] = 1;
				if(start_time < 10)
					time = "0" + start_time;
				else
					time = start_time;
				id = "4" + time.toString();
				document.getElementById(id).className = "checked";
			}
			if (select_day & 32) {
				schedule_array[5][start_time] = 1;
				if(start_time < 10)
					time = "0" + start_time;
				else
					time = start_time;
				id = "5" + time.toString();
				document.getElementById(id).className = "checked";
			}
			if (select_day & 64) {
				schedule_array[6][start_time] = 1;
				if(start_time < 10)
					time = "0" + start_time;
				else
					time = start_time;
				id = "6" + time.toString();
				document.getElementById(id).className = "checked";
			}
		}
	}
		schedule_editEntry = 1;
}

function edit_url_filter_list(idx, schedule_nam)
{
	url_CurrentTrId = idx;
	var F = document.forms[0];

	if (url_filter_list[idx].enable == "on") {
		F.checkenable.checked = true;
	}
	else {
		F.checkenable.checked = false;
	}
	change_fileter_mode("0");
	
	F.web_rule_enable.disabled = true;
	F.ip_rule_enable.disabled = true;

	F.web_url.value = url_filter_list[idx].url;

	F.filter_sched.value = url_filter_list[idx].sched;
	
	url_editEntry = 1;
	
	if(schedule_nam != "Always")
		edit_schedule(url_filter_list[idx].sched);
	else {
		document.getElementById("SetTable").innerHTML = "";
		schedule_editEntry = 0;
	}
		
}

function add_url_list(idx)
{
	var tbody = document.getElementById("summary_tableList").getElementsByTagName("TBODY")[0];
	var row = document.createElement("tr");
	var tdArray = new Array();
	var str = "";
	var array = new Array("filter_url_from_start", "filter_url_from_end", "filter_url_addr", "filter_url_schedule", "filter_url_enable");
	
	//create td
	row.setAttribute("id", idx + "url");
	for(i = 0; i < 5; i++) {
		tdArray[i] = document.createElement("td");
		tdArray[i].setAttribute("class", "form_list_content");
	}
	tdArray[0].setAttribute("width", "70%");

	//set td Text
	tdArray[0].innerHTML = show_web_url(idx);
	tdArray[1].innerHTML = show_url_schedule(idx);
	tdArray[2].innerHTML = show_url_enable(idx);

	//remove
	var Del = document.createElement("input");
	Del.setAttribute("type", "button");
	Del.setAttribute("value","<!--#tr id="remove"-->Remove<!--#endtr-->");
	Del.setAttribute("class","button3");
	Del.onclick = function(){ del_url_filter_list(idx)};
	tdArray[3].appendChild(Del);

	//Edit
	var Edit = document.createElement("input");
	Edit.setAttribute("type", "button");
	Edit.setAttribute("value", "<!--#tr id="edit"-->Edit<!--#endtr-->");
	Edit.setAttribute("class","button3");
	Edit.onclick = function(){ edit_url_filter_list(idx, show_url_schedule(idx))};
	tdArray[4].appendChild(Edit);

	var hidden, i;
	for (i = 0; i < array.length; i++) {
		hidden = document.createElement("input");
		hidden.setAttribute("type", "hidden");
		hidden.setAttribute("name", array[i] + idx);
		hidden.setAttribute("id", array[i] + idx);
		hidden.setAttribute("value", "");
		row.appendChild(hidden);
	}
	
	//obj append to table
	for ( i = 0; i < 5; i++) {
		row.appendChild(tdArray[i]);
	}

	tbody.appendChild(row);
}

function init_url_table()
{
	var j = 0, i = 0;

	while (i < url_filter_num)
	{
		var acc_list = url_full_list_string.split("/");
		var list_value = acc_list[i].split(",");
		var ip_list = list_value[0].split(":");
		
		url_filter_list[j] = new url_filter_list_entry(ip_list[0], ip_list[1], list_value[1], list_value[2]);
		j++;
		i++;
	}

	for (i = 0; i < url_filter_list.length; i++) {
		add_url_list(i);
	}
}

function cancel_url_input()
{
	var F = document.forms[0];
	F.checkenable.checked = false;
	F.web_url.value = "";
	F.filter_sched.options.selectedIndex = 0;
	
	url_editEntry = 0;
}


function add_list(idx)
{
	var tbody = document.getElementById("tableList").getElementsByTagName("TBODY")[0];
	var row = document.createElement("tr");
	var tdArray = new Array();
	var str = "";
	var array = new Array("schedule_uid", "schedule_name", "schedule_time");
	var row_id = "list"+idx;
	
	//create td
	row.setAttribute("id", row_id);

	var hidden, i;
	for (i = 0; i < array.length; i++) {
		hidden = document.createElement("input");
		hidden.setAttribute("type", "hidden");
		hidden.setAttribute("name", array[i] + idx);
		hidden.setAttribute("id", array[i] + idx);
		hidden.setAttribute("value", "");
		row.appendChild(hidden);
	}
	tbody.appendChild(row);
}


function add_table(F)
{
	var uid;
	var rule_name;
	var flag = 0;
	var day_select = 0;
	var time_temp = "";
	var start_time = 0;
	var end_time = 0;
	var i = 0, j = 0, k = 0, idx = 0;
	var opt_num = 0;
  
	uid = F.ruleUid.value;
	rule_name = F.addRuleName.value;

	for(j = 0; j < 24; j++){
			day_select = 0;
			for(i = 0; i < 7; i++){
				if(schedule_array[i][j] == 1){
					flag = 1;
					k = j + 1;
					if (i == 0)
						day_select |= 1;
					if (i == 1) 
						day_select |= 2;
					if (i == 2)
						day_select |= 4;
					if (i == 3)
						day_select |= 8;
					if (i == 4)
						day_select |= 16;
					if (i == 5)
						day_select |= 32;
					if (i == 6)
						day_select |= 64;
				}
			}
			if(flag == 1){
				flag = 0;
				if(j<10)
					start_time = "0" + j;
				else
					start_time = j;
				if(k<10)
					end_time = "0" + k;
				else
					end_time = k;
				if(time_temp != "")
					time_temp += "<";
				time_temp += "RuleBuff<" + day_select.toString() + ":" + start_time.toString() + end_time.toString();
			}
		}
		
		if (day_select == 127 && time_temp.length == 431) {
			start_time = "00";
			end_time = "24";
			time_temp = "";
			time_temp += "RuleBuff<" + day_select.toString()+ ":" + start_time.toString() + end_time.toString();
		}
		
	if (isBlankString(rule_name)) {
		F.addRuleName.focus();
		Alert.render("<!--#tr id="schedule.alert.2"-->Schedule name is empty.<!--#endtr-->");
		return false;
	}

	if (time_temp == "") {
		Alert.render("<!--#tr id="schedule.alert.1"-->Must select at least one day.<!--#endtr-->");
		return false;		
	}

	if (schedule_editEntry == 0) { //add new entry
		if (schedule_list.length >= 16) {
			Alert.render("<!--#tr id="schedule.alert.maxrule"-->The maximum number of rules is 16.<!--#endtr-->");
			return false;
		}
		
		for (i = 0; i < schedule_list.length; i++) {
			if (rule_name == schedule_list[i].name) {
				F.addRuleName.focus();
				Alert.render("<!--#tr id="schedule.alert.3"-->Same rule is not allowed.<!--#endtr-->");
				return false;
			}
		}

		if ((uid == "") || (uid*1 == 0)) {
			//assign valid UID
			uid_assigned = uid_assigned*1 + 1;
			uid = uid_assigned*1;
		}
		
		schedule_list[schedule_list.length] = new schedule_list_entry(uid, rule_name, time_temp);

		var opt = new Option(rule_name, uid, false, false);
		F.filter_sched.options.add(opt);
		F.filter_sched.value = uid;
		add_list(schedule_list.length - 1);
	
	}
	else { //edit existing entry
		for (i = 0; i < schedule_list.length; i++) {
			if (i == CurrentTrId) {
				continue;
			}

			if (rule_name == schedule_list[i].name) {
				F.addRuleName.focus();
				Alert.render("<!--#tr id="schedule.alert.3"-->Same rule is not allowed.<!--#endtr-->");
				return false;
			}
		}
		
		schedule_list[CurrentTrId] = new schedule_list_entry(uid, rule_name, time_temp);
		
		for (opt_num = 0; opt_num < F.filter_sched.length; opt_num++) {
			if(F.filter_sched.options[opt_num].value == uid)
				F.filter_sched.options[opt_num].text = rule_name;
		}
	}
}

function add_url_table(F)
{
	var enable, url_val, sched, i;

	var reg = /[;,\"\'#&*()\\|`<> ]/;
	var reg2 = /(http\:\/\/)?/;

	if (F.checkenable.checked == true) {
		enable = "on";
	}
	else {
		enable = "off";
	}

	var url = F.web_url;

	if (isBlankString(url.value)) {
		F.web_url.focus();
		Alert.render("<!--#tr id="url.error.blank"-->The URL can't be a blank string.<!--#endtr-->");
		return false;
	}

	if (reg.test(url.value)) {
		F.web_url.focus();
		Alert.render("<!--#tr id="url.error.invalid.2"-->The URL can't include the following characters<!--#endtr-->: ; , \" \' # & * ( ) \\ | ` < > ");
		return false;
	}

	url.value = url.value.replace(reg2, "");
	
	sched = F.filter_sched.value;

	url_val = url.value;

	if (url_editEntry == 0) { //add new entry
		if (url_filter_list.length >= 24) {
			Alert.render("<!--#tr id="access.alert.maxrule"-->The maximum number of rules is 24.<!--#endtr-->");
			return false;
		}

		for (i = 0; i < url_filter_list.length; i++) {
			if (url_val == url_filter_list[i].url) {
				F.web_url.focus();
				Alert.render("<!--#tr id="lan.alert.24"-->This URL Address is already set in another rule.<!--#endtr-->");
				return false;
			}
		}
		
		url_filter_list[url_filter_list.length] = new url_filter_list_entry("*", url_val, sched, enable);
		//add_url_list(url_filter_list.length - 1);
	}
	else {
		for (i = 0; i < url_filter_list.length; i++) {
			if (i == url_CurrentTrId) {
				continue;
			}

			if (url_val == url_filter_list[i].url) {
				F.web_url.focus();
				Alert.render("<!--#tr id="lan.alert.24"-->This URL Address is already set in another rule.<!--#endtr-->");
				return false;
			}
		}

		url_filter_list[url_CurrentTrId] = new url_filter_list_entry("*", url_val, sched, enable);

		var edit_row = document.getElementById(url_CurrentTrId + "url");
		edit_row.cells[0].innerHTML = show_web_url(url_CurrentTrId);
		edit_row.cells[1].innerHTML = show_url_schedule(url_CurrentTrId);
		edit_row.cells[2].innerHTML = show_url_enable(url_CurrentTrId);
	}

	return true;
}

function del_schedule_array_element(idx)
{
	for (var i = idx; i < schedule_list.length - 1 ; i++) {
		schedule_list[i] = schedule_list[i + 1];
	}

	if (schedule_list.length != 0)
		schedule_list.length = schedule_list.length - 1;
}

function del_schedule(idx)
{
	var tbody = document.getElementById("tableList").getElementsByTagName("TBODY")[0];
	
	for (var j = tbody.rows.length; j > 1; j--) { 
		tbody.deleteRow(j - 1);
	}

	del_schedule_array_element(idx);

	for (var i = 0; i < schedule_list.length; i++) {
		add_list(i);
	}

	schedule_editEntry = 0;
}

function pre_schedule_submit()
{
	var i,j,k;
	var day="",start_time="", end_time="";
	var time_array;
	var time_temp = "";
	var time = "";
	var day_time = "";
	
	document.getElementById("schedule_uid").value = uid_assigned;

	for (i = 0; i < schedule_list.length; i++) {
		time_temp = schedule_list[i].time.split('<');
		time = "";
		for(j = 0; j < time_temp.length/2; j++){
			day_time = time_temp[(2*j)+1].split(':');
			day = day_time[0];
			start_time = day_time[1].substring(0,2);
			end_time = day_time[1].substring(2,4);
			time = time + day + ":" + start_time + "-" + end_time;
			if(j < (time_temp.length/2)-1)
					time = time + ",";
		}

		document.getElementById("schedule_uid" + i).value = schedule_list[i].uid;
		document.getElementById("schedule_name" + i).value = schedule_list[i].name;
		document.getElementById("schedule_time" + i).value = time;;
	}
}

function pre_url_submit() 
{
	var i;
	
	for (i = 0; i < url_filter_list.length; i++) {
		document.getElementById("filter_url_from_start" + i).value = "";
		document.getElementById("filter_url_from_end" + i).value = "";
		document.getElementById("filter_url_addr" + i).value = url_filter_list[i].url;
		document.getElementById("filter_url_schedule" + i).value = url_filter_list[i].sched;
		document.getElementById("filter_url_enable" + i).value = url_filter_list[i].enable;
	}
}

