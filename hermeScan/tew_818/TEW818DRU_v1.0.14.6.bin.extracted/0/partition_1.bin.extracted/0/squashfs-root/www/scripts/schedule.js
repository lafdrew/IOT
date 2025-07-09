var CurrentTrId = 0;
var editEntry = 0;
var schedule_list = new Array();
var schedule_num = "<% getListNum(0); %>";
var full_list_string = "<% constructList(0); %>";
var uid_assigned = "<% nvram_get("schedule_uid"); %>";
var access_list = new Array();
var access_num = "<% getListNum(1); %>";
var access_full_list_string = "<% constructList(1); %>";
var forward_list = new Array();
var forward_num = "<% getListNum(2); %>";
var forward_full_list_string = "<% constructList(2); %>";
var trigger_list = new Array();
var trigger_num = "<% getListNum(3); %>";
var trigger_full_list_string = "<% constructList(3); %>";
var range_list = new Array();
var range_num = "<% getListNum(4); %>";
var range_full_list_string = "<% constructList(4); %>";
var url_filter_list = new Array();
var url_filter_num = "<% getListNum(5); %>";
var url_full_list_string = "<% constructList(5); %>";
var ip_filter_list = new Array();
var ip_filter_num = "<% getListNum(6); %>";
var ip_full_list_string = "<% constructList(6); %>";



var new_schedule = "0"; //for window.opener to restore newed schedule 

function ip_filter_list_entry(from_ip, to_ip, sched, enable)
{
	this.from_ip = from_ip;
	this.to_ip = to_ip;
	this.sched = sched;
	this.enable = enable;
}

function url_filter_list_entry(lan_ip, url, sched, enable)
{
	this.lan_ip = lan_ip;
	this.url = url;
	this.sched = sched;
	this.enable = enable;
}

function range_list_entry(lan_ip, tcp_from, tcp_to, udp_from, udp_to, sched, enable)
{
	this.lan_ip = lan_ip;
	this.tcp_from = tcp_from;
	this.tcp_to = tcp_to;
	this.udp_from = udp_from;
	this.udp_to = udp_to;
	this.sched = sched;
	this.enable = enable;
}

function trigger_list_entry(match_proto, match_from, match_to, trigger_proto, trigger_from, trigger_to, sched, enable)
{
	this.match_proto = match_proto;
	this.match_from = match_from;
	this.match_to = match_to;
	this.trigger_proto = trigger_proto;
	this.trigger_from = trigger_from;
	this.trigger_to = trigger_to;
	this.sched = sched;
	this.enable = enable;
}

function forward_list_entry(pub_port, lan_ip, priv_port, proto, sched, enable)
{
	this.pub_port = pub_port;
	this.lan_ip = lan_ip;
	this.priv_port = priv_port;
	this.proto = proto;
	this.sched = sched;
	this.enable = enable;
}

function access_list_entry(from_ip, to_ip, from_port, to_port, proto, sched, enable)
{
	this.from_ip = from_ip;
	this.to_ip = to_ip;
	this.from_port = from_port;
	this.to_port = to_port;
	this.proto = proto;
	this.sched = sched;
	this.enable = enable;
}

function schedule_list_entry(uid, name, time)
{
	this.uid = uid;
	this.name = name;
	this.time = time;
}

function show_days(idx)
{
	var flag = schedule_list[idx].days;
	var str = "";

	if (flag & 1) {
		str += '<!--#tr id="schedule.sunday"-->Sun.<!--#endtr-->&nbsp;';
	}

	if (flag & 2) {
		str += '<!--#tr id="schedule.monday"-->Mon.<!--#endtr-->&nbsp;';
	}

	if (flag & 4) {
		str += '<!--#tr id="schedule.tuesday"-->Tue.<!--#endtr-->&nbsp;';
	}

	if (flag & 8) {
		str += '<!--#tr id="schedule.wednesday"-->Wed.<!--#endtr-->&nbsp;';
	}

	if (flag & 16) {
		str += '<!--#tr id="schedule.thursday"-->Thu.<!--#endtr-->&nbsp;';
	}

	if (flag & 32) {
		str += '<!--#tr id="schedule.friday"-->Fri.<!--#endtr-->&nbsp;';
	}

	if (flag & 64) {
		str += '<!--#tr id="schedule.saturday"-->Sat.<!--#endtr-->&nbsp;';
	}

	return str;
}

function show_times(idx)
{
	var flag = schedule_list[idx].times;
	var time_array = flag.split("-");
	var from = time_array[0];
	var to = time_array[1];
	var str = "";
	var i;
	var tmp;

	tmp = parseInt(from / 3600);
	for (i = 0; i < 10; i++) {
		if (tmp == i) {
			str += "0";
			str += i;
			break;
		}
	}

	if (i == 10) {
		for (i = 10; i < 24; i++) {
			if (tmp == i) {
				str += i;
				break;
			}
		}
	}

	str += ":"

	tmp = parseInt((from % 3600) /60);
	for (i = 0; i < 10; i++) {
		if (tmp == i) {
			str += "0";
			str += i;
			break;
		}
	}

	if (i == 10) {
		for (i = 10; i < 60; i++) {
			if (tmp == i) {
				str += i;
				break;
			}
		}
	}

	str += "&nbsp;-&nbsp;";

	if (to == "86399") {
		str += "00";
	}
	else {
		tmp = parseInt(to / 3600);
		for (i = 0; i < 10; i++) {
			if (tmp == i) {
				str += "0";
				str += i;
				break;
			}
		}
		if (i == 10) {
			for (i = 10; i < 24; i++) {
				if (tmp == i) {
					str += i;
					break;
				}
			}
		}
	}

	str += ":"

	if (to == "86399") {
		str += "00";
	}
	else {
		tmp = parseInt((to % 3600) /60);
		for (i = 0; i < 10; i++) {
			if (tmp == i) {
				str += "0";
				str += i;
				break;
			}
		}
		if (i == 10) {
			for (i = 10; i < 60; i++) {
				if (tmp == i) {
					str += i;
					break;
				}
			}
		}
	}

	return str;
}

function del_array_element(idx)
{
	for (var i = idx; i < schedule_list.length - 1 ; i++) {
		schedule_list[i] = schedule_list[i + 1];
	}

	schedule_list.length = schedule_list.length - 1;
}

function del_schedule(idx)
{
	var tbody = document.getElementById("tableList").getElementsByTagName("TBODY")[0];
	
	for (var j = tbody.rows.length; j > 1; j--) { 
		tbody.deleteRow(j - 1);
	}

	del_array_element(idx);

	for (var i = 0; i < schedule_list.length; i++) {
		add_list(i);
	}

	editEntry = 0;
}

function edit_schedule(idx)
{
	var F = document.forms[0];
	cancel_input(F);
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
	var k = 0, j = 0;
	
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

	editEntry = 1;
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
	for(i=0; i<3; i++) {
		tdArray[i] = document.createElement("td");
		tdArray[i].setAttribute("class", "form_list_content");
	}

	//set td Text
	tdArray[0].innerHTML = schedule_list[idx].name;
	
	//remove
	var Del = document.createElement("input");
	Del.setAttribute("type", "button");
	Del.setAttribute("value","<!--#tr id="remove"-->Remove<!--#endtr-->");
	Del.setAttribute("class","button3");
	Del.onclick = function(){ del_schedule(idx)};
	tdArray[1].appendChild(Del);

	//delete
	var Edit = document.createElement("input");
	Edit.setAttribute("type", "button");
	Edit.setAttribute("value", "<!--#tr id="edit"-->Edit<!--#endtr-->");
	Edit.setAttribute("class","button3");
	Edit.onclick = function(){ edit_schedule(idx)};
	tdArray[2].appendChild(Edit);	

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
	for ( i = 0; i < 3; i++) {
		row.appendChild(tdArray[i]);
	}

	tbody.appendChild(row);
}

function add_ip_list(idx)
{
	var tbody = document.getElementById("alltableList").getElementsByTagName("TBODY")[0];
	var row = document.createElement("tr");
	var tdArray = new Array();
	var str = "";
	var array = new Array("filter_ip_from_start", "filter_ip_from_end", "filter_ip_schedule", "filter_ip_enable");
	
	//create td
	row.setAttribute("id", idx + "ip");

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

function init_ip_table()
{
	var j = 0, i = 0;

	while (i < ip_filter_num)
	{
		var acc_list = ip_full_list_string.split("/");
		var list_value = acc_list[i].split(",");
		var ip_list = list_value[0].split("-");
		
		ip_filter_list[j] = new ip_filter_list_entry(ip_list[0], ip_list[1], list_value[1], list_value[2]);
		j++;
		i++;
	}

	for (i = 0; i < ip_filter_list.length; i++) {
		add_ip_list(i);
	}
}

function add_url_list(idx)
{
	var tbody = document.getElementById("alltableList").getElementsByTagName("TBODY")[0];
	var row = document.createElement("tr");
	var tdArray = new Array();
	var str = "";
	var array = new Array("filter_url_from_start", "filter_url_from_end", "filter_url_addr", "filter_url_schedule", "filter_url_enable");
	
	//create td
	row.setAttribute("id", idx + "url");

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

function add_range_list(idx)
{
	var tbody = document.getElementById("alltableList").getElementsByTagName("TBODY")[0];
	var row = document.createElement("tr");
	var tdArray = new Array();
	var str = "";
	var array = new Array("port_range_client", "port_range_tcp_start", "port_range_tcp_end", "port_range_udp_start", "port_range_udp_end", 
		"port_range_schedule", "port_range_enable");
	
	//create td
	row.setAttribute("id", idx + "range");

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

function init_range_table()
{
	var j = 0, i = 0;

	while (i < range_num)
	{
		var acc_list = range_full_list_string.split("/");
		var list_value = acc_list[i].split(",");
		var tcp_port_list = list_value[1].split("-");
		var udp_port_list = list_value[2].split("-");
		
		range_list[j] = new range_list_entry(list_value[0], tcp_port_list[0], tcp_port_list[1], udp_port_list[0], udp_port_list[1], list_value[3], list_value[4]);
		j++;
		i++;
	}

	for (var i=0; i < range_list.length; i++) {
		add_range_list(i);
	}
}

function add_trigger_list(idx)
{
	var tbody = document.getElementById("alltableList").getElementsByTagName("TBODY")[0];
	var row = document.createElement("tr");
	var tdArray = new Array();
	var str = "";
	var array = new Array("autofw_port_out_proto", "autofw_port_out_start", "autofw_port_out_end", "autofw_port_in_proto", "autofw_port_in_start", 
		"autofw_port_in_end", "autofw_port_to_start", "autofw_port_to_end", "autofw_port_schedule", "autofw_port_enable");
	
	//create td
	row.setAttribute("id", idx + "trigger");

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

function init_trigger_table()
{
	var j = 0, i = 0;

	while (i < trigger_num)
	{
		var acc_list = trigger_full_list_string.split("/");
		var list_value = acc_list[i].split(",");
		var tmp_list = list_value[0].split(":");
		var match_port_list = tmp_list[1].split("-");
		var tmp2_list = list_value[1].split(":");
		var trigger_port_list = tmp2_list[1].split("-");
		var trigger_port_list2 = trigger_port_list[1].split(">");
		
		trigger_list[j] = new trigger_list_entry(tmp_list[0], match_port_list[0], match_port_list[1], tmp2_list[0], trigger_port_list[0], trigger_port_list2[0], list_value[2], list_value[3]);
		j++;
		i++;
	}

	for (var i=0; i < trigger_list.length; i++) {
		add_trigger_list(i);
	}
}

function add_forward_list(idx)
{
	var tbody = document.getElementById("alltableList").getElementsByTagName("TBODY")[0];
	var row = document.createElement("tr");
	var tdArray = new Array();
	var str = "";
	var array = new Array("forward_port_proto", "forward_port_from_start", "forward_port_from_end", "forward_port_to_ip", "forward_port_to_start", 
		"forward_port_to_end", "forward_port_schedule", "forward_port_enable");
	
	//create td
	row.setAttribute("id", idx + "forward");

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

function init_forward_table()
{
	var j = 0, i = 0;

	while (i < forward_num)
	{
		var acc_list = forward_full_list_string.split("/");
		var list_value = acc_list[i].split(",");
		var tmp_list = list_value[0].split(">");
		var pub_port_list = tmp_list[0].split("-");
		var ip_list = tmp_list[1].split(":");
		var priv_port_list = ip_list[1].split("-");
		
		forward_list[j] = new forward_list_entry(pub_port_list[0], ip_list[0], priv_port_list[0], list_value[1], list_value[2], list_value[3]);
		j++;
		i++;
	}

	for (var i=0; i < forward_list.length; i++) {
		add_forward_list(i);
	}
}

function add_access_list(idx)
{
	var tbody = document.getElementById("alltableList").getElementsByTagName("TBODY")[0];
	var row = document.createElement("tr");
	var tdArray = new Array();
	var str = "";
	var array = new Array("filter_client_from_start", "filter_client_from_end", "filter_client_proto", "filter_client_to_start", "filter_client_to_end", 
		"filter_client_schedule", "filter_client_enable");
	
	//create td
	row.setAttribute("id", idx + "access");

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

function init_access_table()
{
	var j = 0, i = 0;

	while (i < access_num)
	{
		var acc_list = access_full_list_string.split("/");
		var list_value = acc_list[i].split(",");
		var tmp_list = list_value[0].split(":");
		var ip_list = tmp_list[0].split("-");
		var port_list = tmp_list[1].split("-");
		
		access_list[j] = new access_list_entry(ip_list[0], ip_list[1], port_list[0], port_list[1], list_value[1], list_value[2], list_value[3]);
		j++;
		i++;
	}

	for (var i=0; i < access_list.length; i++) {
		add_access_list(i);
	}
}

function init_table()
{
	var j = 0, i = 0, k = 0;

	while (i < schedule_num)
	{
		var time_list = "";
		var time = "";
		var sche_list = full_list_string.split("/");
		var list_value = sche_list[i].split(",");
		
		for(k = 2; k < list_value.length; k++) {
			time_list = list_value[k].split("-");
			if(time != "")
					time += "<";
			time += "RuleBuff<" + time_list[0] + time_list[1];
		}
		
		schedule_list[j] = new schedule_list_entry(list_value[0], list_value[1], time);
		j++;
		i++;
	}

	for (var i=0; i < schedule_list.length; i++) {
		add_list(i);
	}
	
	init_access_table();
	init_forward_table();
	init_trigger_table();
	init_range_table();
	init_url_table();
	init_ip_table();	
}

function diable_day(F, mode)
{
//	F.week_all.checked = false;
	F.week_sun.checked = false;
	F.week_mon.checked = false;
	F.week_tue.checked = false;
	F.week_wed.checked = false;
	F.week_thu.checked = false;
	F.week_fri.checked = false;
	F.week_sat.checked = false;

	if (mode == 0) {
		F.week_sun.disabled = false;
		F.week_mon.disabled = false;
		F.week_tue.disabled = false;
		F.week_wed.disabled = false;
		F.week_thu.disabled = false;
		F.week_fri.disabled = false;
		F.week_sat.disabled = false;	
	}
	else if (mode == 1) {
		F.week_sun.disabled = true;
		F.week_mon.disabled = true;
		F.week_tue.disabled = true;
		F.week_wed.disabled = true;
		F.week_thu.disabled = true;
		F.week_fri.disabled = true;
		F.week_sat.disabled = true;
	}
}

function diable_time(F, mode)
{
//	F.day_all.checked = false;
	F.from_hr.selectedIndex = 0;
	F.from_min.selectedIndex = 0;
	F.to_hr.selectedIndex = 0;
	F.to_min.selectedIndex = 0;

	if (mode == 0) {
		F.from_hr.disabled = false;
		F.from_min.disabled = false;
		F.to_hr.disabled = false;
		F.to_min.disabled = false;
	}
	else if (mode == 1) {
		F.from_hr.disabled = true;
		F.from_min.disabled = true;
		F.to_hr.disabled = true;
		F.to_min.disabled = true;
	}
}

function select_day(F)
{
	if (F.week_all.checked == true) {
		diable_day(F, 1);
	}
	else {
		diable_day(F, 0);
	}
}

function select_time(F)
{
	if (F.day_all.checked == true) {
		diable_time(F, 1);
	}
	else {
		diable_time(F, 0);
	}
}

function cancel_input(F)
{
	init_array(schedule_array);
	F.ruleUid.value = "";
	F.addRuleName.value = "";
	settingTable();
	change_time_format(time_format);
	editEntry = 0;
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
		Alert.render("<!--#tr id="schedule.alert.2"-->Schedule name is empty.<!--#endtr-->");
		return false;
	}

	if (time_temp == "") {
		Alert.render("<!--#tr id="schedule.alert.1"-->Must select at least one day.<!--#endtr-->");
		return false;		
	}

	if (editEntry == 0) { //add new entry
		if (schedule_list.length >= 16) {
			Alert.render("<!--#tr id="schedule.alert.maxrule"-->The maximum number of rules is 16.<!--#endtr-->");
			return false;
		}
		
		for (i = 0; i < schedule_list.length; i++) {
			if (rule_name == schedule_list[i].name) {
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
		add_list(schedule_list.length - 1);
	}
	else { //edit existing entry
		for (i = 0; i < schedule_list.length; i++) {
			if (i == CurrentTrId) {
				continue;
			}

			if (rule_name == schedule_list[i].name) {
				Alert.render("<!--#tr id="schedule.alert.3"-->Same rule is not allowed.<!--#endtr-->");
				return false;
			}
		}

		schedule_list[CurrentTrId] = new schedule_list_entry(uid, rule_name, time_temp);

		var edit_row = document.getElementById("list"+CurrentTrId);
		edit_row.cells[0].innerHTML = schedule_list[CurrentTrId].name;
	}

	cancel_input(F);

	return true;
}

function pre_wl_submit()
{
	var F = document.forms[0];
	var i = 0, j = 0, k = 0;
	var check_uid = 0;
	var wlname="";
	var wlvalue="";
	
	if (F.wl_s_change.value != "" && F.wl_s_change.value != "0") {
		for (i = 0; i < schedule_list.length; i++) {
				if (schedule_list[i].uid == F.wl_s_change.value)
					check_uid = 1;
		}

		if (check_uid == 0)
			F.wl_s_change.value = "remove";
	}
	
	for (i = 0; i <= 2; i++) {
		for (j = 0; j <= 3; j++) {
			check_uid = 0;
			wlname = "wl_s_change" + i.toString() + "_" + j.toString();
			wlvalue = document.getElementById(wlname).value;
			
			if (wlvalue != "" && wlvalue != "0") {
				for (k = 0; k < schedule_list.length; k++) {
					if (schedule_list[k].uid == wlvalue) {
						check_uid = 1;
					}
				}
				
				if (check_uid == 0) {
					document.getElementById(wlname).value = "remove";
				}
			}
		}
	}
}

function pre_ip_submit() 
{
	var i;
	var j,k;
	var check_uid = 0;
	
	for (j = 0; j < ip_filter_list.length; j++) {
		check_uid = 0;
		
		for (k = 0; k < schedule_list.length; k++) {
			if (ip_filter_list[j].sched == schedule_list[k].uid)
				check_uid = 1;
		}

		if (ip_filter_list[j].sched == "0")
			check_uid = 1;
				
		if (check_uid == 0)
			ip_filter_list[j].sched = "0";
	}

	for (i = 0; i < ip_filter_list.length; i++) {
		document.getElementById("filter_ip_from_start" + i).value = ip_filter_list[i].from_ip;
		document.getElementById("filter_ip_from_end" + i).value = ip_filter_list[i].to_ip;
		document.getElementById("filter_ip_schedule" + i).value = ip_filter_list[i].sched;
		document.getElementById("filter_ip_enable" + i).value = ip_filter_list[i].enable;
	}
}

function pre_url_submit() 
{
	var i;
	var j,k;
	var check_uid = 0;
	
	for (j = 0; j < url_filter_list.length; j++) {
		check_uid = 0;
		
		for (k = 0; k < schedule_list.length; k++) {
			if (url_filter_list[j].sched == schedule_list[k].uid)
				check_uid = 1;
		}

		if (url_filter_list[j].sched == "0")
			check_uid = 1;

		if (check_uid == 0)
			url_filter_list[j].sched = "0";
	}
	
	for (i = 0; i < url_filter_list.length; i++) {
		document.getElementById("filter_url_from_start" + i).value = "";
		document.getElementById("filter_url_from_end" + i).value = "";
		document.getElementById("filter_url_addr" + i).value = url_filter_list[i].url;
		document.getElementById("filter_url_schedule" + i).value = url_filter_list[i].sched;
		document.getElementById("filter_url_enable" + i).value = url_filter_list[i].enable;
	}
}

function pre_range_submit() 
{
	var i;
	var j,k;
	var check_uid = 0;
	
	for (j = 0; j < range_list.length; j++) {
		check_uid = 0;
		
		for (k = 0; k < schedule_list.length; k++) {
			if (range_list[j].sched == schedule_list[k].uid)
				check_uid = 1;
		}
		
		if (range_list[j].sched == "0")
			check_uid = 1;
		
		if (check_uid == 0)
			range_list[j].sched = "0";
	}
	
	for (i = 0; i < range_list.length; i++) {
		document.getElementById("port_range_client" + i).value = range_list[i].lan_ip;
		document.getElementById("port_range_tcp_start" + i).value = range_list[i].tcp_from;
		document.getElementById("port_range_tcp_end" + i).value = range_list[i].tcp_to;
		document.getElementById("port_range_udp_start" + i).value = range_list[i].udp_from;
		document.getElementById("port_range_udp_end" + i).value = range_list[i].udp_to;
		document.getElementById("port_range_schedule" + i).value = range_list[i].sched;
		document.getElementById("port_range_enable" + i).value = range_list[i].enable;
	}
}

function pre_trigger_submit() 
{
	var i;
	var j,k;
	var check_uid = 0;
	
	for (j = 0; j < trigger_list.length; j++) {
		check_uid = 0;
		
		for (k = 0; k < schedule_list.length; k++) {
			if (trigger_list[j].sched == schedule_list[k].uid)
				check_uid = 1;
		}
		
		if (trigger_list[j].sched == "0")
			check_uid = 1;
		
		if (check_uid == 0)
			trigger_list[j].sched = "0";
	}
	
	for (i = 0; i < trigger_list.length; i++) {
		document.getElementById("autofw_port_out_proto" + i).value = trigger_list[i].match_proto;
		document.getElementById("autofw_port_out_start" + i).value = trigger_list[i].match_from;
		document.getElementById("autofw_port_out_end" + i).value = trigger_list[i].match_to;
		document.getElementById("autofw_port_in_proto" + i).value = trigger_list[i].trigger_proto;
		document.getElementById("autofw_port_in_start" + i).value = trigger_list[i].trigger_from;
		document.getElementById("autofw_port_in_end" + i).value = trigger_list[i].trigger_to;
		document.getElementById("autofw_port_to_start" + i).value = trigger_list[i].trigger_from;
		document.getElementById("autofw_port_to_end" + i).value = trigger_list[i].trigger_to;
		document.getElementById("autofw_port_schedule" + i).value = trigger_list[i].sched;
		document.getElementById("autofw_port_enable" + i).value = trigger_list[i].enable;
	}
}

function pre_forward_submit() 
{
	var i;
	var j,k;
	var check_uid = 0;
	
	for (j = 0; j < forward_list.length; j++) {
		check_uid = 0;
		
		for (k = 0; k < schedule_list.length; k++) {
			if (forward_list[j].sched == schedule_list[k].uid) {
				check_uid = 1;
			}
		}
		
		if (forward_list[j].sched == "0")
				check_uid = 1;
				
		if (check_uid == 0)
			forward_list[j].sched = "0";
	}

	for (i = 0; i < forward_list.length; i++) {
		document.getElementById("forward_port_proto" + i).value = forward_list[i].proto;
		document.getElementById("forward_port_from_start" + i).value = forward_list[i].pub_port;
		document.getElementById("forward_port_from_end" + i).value = forward_list[i].pub_port;
		document.getElementById("forward_port_to_ip" + i).value = forward_list[i].lan_ip;
		document.getElementById("forward_port_to_start" + i).value = forward_list[i].priv_port;
		document.getElementById("forward_port_to_end" + i).value = forward_list[i].priv_port;
		document.getElementById("forward_port_schedule" + i).value = forward_list[i].sched;
		document.getElementById("forward_port_enable" + i).value = forward_list[i].enable;
	}
}

function pre_access_submit() 
{
	var i;
	var j,k;
	var check_uid = 0;
	
	for (j = 0; j < access_list.length; j++) {
		check_uid = 0;
		
		for (k = 0; k < schedule_list.length; k++) {
			if (access_list[j].sched == schedule_list[k].uid)
				check_uid = 1;
		}
		
		if (access_list[j].sched == "0")
				check_uid = 1;
		
		if (check_uid == 0)
			access_list[j].sched = "0";
	}
	
	for (i = 0; i < access_list.length; i++) {
		document.getElementById("filter_client_from_start" + i).value = access_list[i].from_ip;
		document.getElementById("filter_client_from_end" + i).value = access_list[i].to_ip;
		document.getElementById("filter_client_proto" + i).value = access_list[i].proto;
		document.getElementById("filter_client_to_start" + i).value = access_list[i].from_port;
		document.getElementById("filter_client_to_end" + i).value = access_list[i].to_port;
		document.getElementById("filter_client_schedule" + i).value = access_list[i].sched;
		document.getElementById("filter_client_enable" + i).value = access_list[i].enable;
	}
}

function pre_submit() {
	var i, j;
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
		document.getElementById("schedule_time" + i).value = time;
	}

	if(schedule_list.length == 0)
		new_schedule = "0";
	else
		new_schedule = schedule_list[schedule_list.length - 1].uid;
		
	pre_access_submit();
	pre_forward_submit();
	pre_trigger_submit();
	pre_range_submit();
	pre_url_submit();
	pre_ip_submit();
	pre_wl_submit();
}
