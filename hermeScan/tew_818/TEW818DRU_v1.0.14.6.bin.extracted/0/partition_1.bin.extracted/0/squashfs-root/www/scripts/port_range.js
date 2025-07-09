var CurrentTrId = 0;
var editEntry = 0;
var range_list = new Array();
var range_num = "<% getListNum(4); %>";
var full_list_string = "<% constructList(4); %>";

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

function show_lan_ip(idx)
{
	var str = "";

	str += range_list[idx].lan_ip;

	return str;
}

function show_tcp_port(idx)
{
	var str = "";

	if (range_list[idx].tcp_from == "0" && range_list[idx].tcp_to == "0") {

	}
	else {
		str += range_list[idx].tcp_from;
		str += " - ";
		str += range_list[idx].tcp_to;
	}
	
	return str;
}

function show_udp_port(idx)
{
	var str = "";

	if (range_list[idx].udp_from == "0" && range_list[idx].udp_to == "0") {

	}
	else {
		str += range_list[idx].udp_from;
		str += " - ";
		str += range_list[idx].udp_to;
	}

	return str;
}

function show_schedule(idx)
{
	var str = "";
	var i = 0;
	var num = "<% getListNum(0); %>"; 
	var sched_list_string =  "<% constructList(0); %>";


	if (num == 0) {
		str += "<!--#tr id="always"-->Always<!--#endtr-->";
	}
	else {
		var sche_list = sched_list_string.split("/");
		
		while (i < num) {
			var list_value = sche_list[i].split(",");

			if (range_list[idx].sched == list_value[0]) {
				str += list_value[1];
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

function show_enable(idx)
{
	var str = "";

	if (range_list[idx].enable == "on") {
		str += "<!--#tr id="yes"-->Yes<!--#endtr-->";
	}
	else if (range_list[idx].enable == "off") {
		str += "<!--#tr id="no"-->No<!--#endtr-->";
	}

	return str;
}

function dyn_add_sched_option()
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
		F.pr_sched.options.add(opt);
		
		i++;
	}
}

function dyn_select_sched_option()
{
	var F = document.forms[0];
	var selvalue = F.pr_sched;
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

			document.cookie = "new_schedule=; expires=Thu, 01, Jan 1970 00:00:00 UTC"

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


function del_array_element(idx)
{
	for (var i = idx; i < range_list.length - 1 ; i++) {
		range_list[i] = range_list[ i + 1];
	}

	range_list.length = range_list.length - 1;
}

function del_range_list(idx)
{
	var tbody = document.getElementById("tableList").getElementsByTagName("TBODY")[0];
	
	for (var j = tbody.rows.length; j > 1; j--) { 
		tbody.deleteRow(j - 1);
	}

	del_array_element(idx);

	for (var i = 0; i < range_list.length; i++) {
		add_list(i);
	}

	editEntry = 0;
}

function edit_range_list(idx)
{
	CurrentTrId = idx;
	var F = document.forms[0];

	if (range_list[idx].enable == "on") {
		F.pr_rule_enable.checked = true;
	}
	else {
		F.pr_rule_enable.checked = false;
	}

	F.pr_lan_ip.value = range_list[idx].lan_ip;

	if (range_list[idx].tcp_from == "0" && range_list[idx].tcp_to == "") {
		F.pr_tcp_port_start.value = "";
		F.pr_tcp_port_end.value = "";
	}
	else {
		F.pr_tcp_port_start.value = range_list[idx].tcp_from;
		F.pr_tcp_port_end.value = range_list[idx].tcp_to;
	}

	if (range_list[idx].udp_from == "0" && range_list[idx].udp_to == "") {
		F.pr_udp_port_start.value = "";
		F.pr_udp_port_end.value = "";
	}
	else {
		F.pr_udp_port_start.value = range_list[idx].udp_from;
		F.pr_udp_port_end.value = range_list[idx].udp_to;
	}

	F.pr_sched.value = range_list[idx].sched;
	
	editEntry = 1;
}

function add_list(idx)
{
	var tbody = document.getElementById("tableList").getElementsByTagName("TBODY")[0];
	var row = document.createElement("tr");
	var tdArray = new Array();
	var str = "";
	var array = new Array("port_range_client", "port_range_tcp_start", "port_range_tcp_end", "port_range_udp_start", "port_range_udp_end", 
		"port_range_schedule", "port_range_enable");


	//create td
	row.setAttribute("id",idx);
	for(i = 0; i < 7; i++) {
		tdArray[i] = document.createElement("td");
		tdArray[i].setAttribute("class", "form_list_content");
	}

	//set td Text
	tdArray[0].innerHTML = show_lan_ip(idx);
	tdArray[1].innerHTML = show_tcp_port(idx);
	tdArray[2].innerHTML = show_udp_port(idx);
	tdArray[3].innerHTML = show_schedule(idx);
	tdArray[4].innerHTML = show_enable(idx);

	//remove
	var Del = document.createElement("input");
	Del.setAttribute("type", "button");
	Del.setAttribute("value","<!--#tr id="remove"-->Remove<!--#endtr-->");
	Del.setAttribute("class","button3");
	Del.onclick = function(){ del_range_list(idx)};
	tdArray[5].appendChild(Del);

	//delete
	var Edit = document.createElement("input");
	Edit.setAttribute("type", "button");
	Edit.setAttribute("value", "<!--#tr id="edit"-->Edit<!--#endtr-->");
	Edit.setAttribute("class","button3");
	Edit.onclick = function(){ edit_range_list(idx)};
	tdArray[6].appendChild(Edit);

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
	for ( i = 0; i < 7; i++) {
		row.appendChild(tdArray[i]);
	}

	tbody.appendChild(row);
}

function init_table()
{
	var j = 0, i = 0;

	while (i < range_num)
	{
		var acc_list = full_list_string.split("/");
		var list_value = acc_list[i].split(",");
		var tcp_port_list = list_value[1].split("-");
		var udp_port_list = list_value[2].split("-");
		
		range_list[j] = new range_list_entry(list_value[0], tcp_port_list[0], tcp_port_list[1], udp_port_list[0], udp_port_list[1], list_value[3], list_value[4]);
		j++;
		i++;
	}

	for (var i=0; i < range_list.length; i++) {
		add_list(i);
	}
}

function cancel_input(F)
{
	F.pr_rule_enable.checked = false;
	F.pr_lan_ip.value = "";
	F.pr_tcp_port_start.value = "";
	F.pr_tcp_port_end.value = "";
	F.pr_udp_port_start.value = "";
	F.pr_udp_port_end.value = "";
	F.pr_sched.options.selectedIndex = 0;

	editEntry = 0;
}

function add_table(F)
{
	var enable, lan_ip_val, tcp_port_start_val, tcp_port_end_val, udp_port_start_val, udp_port_end_val, sched;
	var tcp_port_empty = 0, udp_port_empty = 0;

	var currentLanIP = document.getElementById("currentLanIP").value;
    	var currentLanMask = document.getElementById("currentLanMask").value;

	var j = 0;

	if (F.pr_rule_enable.checked == true) {
		enable = "on";
	}
	else {
		enable = "off";
	}

	var lan_ip = F.pr_lan_ip;
	var tcp_port_start = F.pr_tcp_port_start;
	var tcp_port_end = F.pr_tcp_port_end;
	var udp_port_start = F.pr_udp_port_start;
	var udp_port_end = F.pr_udp_port_end;

	if (isBlankString(lan_ip.value)) {
		Alert.render("<!--#tr id="ip.address.blank"-->IP address cannot be left blank.<!--#endtr-->");
		return false;
	}

	if (!checkIpAddr(lan_ip, false)) {
		Alert.render("<!--#tr id="ip.address.error"-->Invalid IP address! Please enter a valid IP address.<!--#endtr-->");
		return false;
	}

	if (!checkSameSubnet(lan_ip.value , currentLanIP, currentLanMask)) {
		Alert.render("<!--#tr id="ip.not.in.lan.error" -->IP address does not in LAN subnet.<!--#endtr -->");
		return false;
	}

	if (isBlankString(tcp_port_start.value) && isBlankString(tcp_port_end.value)) {
		if (isBlankString(udp_port_start.value) && isBlankString(udp_port_end.value)) {
			Alert.render("<!--#tr id="ip.port.blank"-->Port cannot be left blank.<!--#endtr-->");
			return false;
		}
		
		tcp_port_empty = 1;
	}

	if (isBlankString(udp_port_start.value) && isBlankString(udp_port_end.value)) {
		if (isBlankString(tcp_port_start.value) && isBlankString(tcp_port_end.value)) {
			Alert.render("<!--#tr id="ip.port.blank"-->Port cannot be left blank.<!--#endtr-->");
			return false;
		}

		udp_port_empty = 1;
	}

	if (tcp_port_empty == 1) {
		if (!is_port_valid(udp_port_start.value) || !is_port_valid(udp_port_end.value)) {
			Alert.render("<!--#tr id="port.error"-->Please input a correct port between 0 and 65535<!--#endtr-->");
			return false;
		}

		if (parseInt(udp_port_start.value) > parseInt(udp_port_end.value)) {
			Alert.render("<!--#tr id="port.range.alert.1"-->TCP Start port should be less than TCP End Port<!--#endtr-->");
			return false;
		}
	}

	if (udp_port_empty == 1) {
		if (!is_port_valid(tcp_port_start.value) || !is_port_valid(tcp_port_end.value)) {
			Alert.render("<!--#tr id="port.error"-->Please input a correct port between 0 and 65535<!--#endtr-->");
			return false;
		}

		if (parseInt(tcp_port_start.value) > parseInt(tcp_port_end.value)) {
			Alert.render("<!--#tr id="port.range.alert.2"-->UDP Start port should be less than UDP End Port<!--#endtr-->");
			return false;
		}
	}

	lan_ip_val = lan_ip.value;
	tcp_port_start_val = tcp_port_start.value;
	tcp_port_end_val = tcp_port_end.value;
	udp_port_start_val = udp_port_start.value;
	udp_port_end_val = udp_port_end.value;
	
	sched = F.pr_sched.value;


	if (editEntry == 0) { //add new entry
		for (j = 0; j < range_list.length; j++) {
			if (tcp_port_empty == 0) {
				if (parseInt(range_list[j].tcp_from) != 0 && parseInt(range_list[j].tcp_to) != 0) {
					if ((parseInt(tcp_port_start_val) >= parseInt(range_list[j].tcp_from) && parseInt(tcp_port_start_val) <= parseInt(range_list[j].tcp_to)) 
								|| (parseInt(tcp_port_end_val) >= parseInt(range_list[j].tcp_from) && parseInt(tcp_port_end_val) <= parseInt(range_list[j].tcp_to)) 
								|| (parseInt(range_list[j].tcp_from) >= parseInt(tcp_port_start_val) && parseInt(range_list[j].tcp_from) <= parseInt(tcp_port_end_val)) 
								|| (parseInt(range_list[j].tcp_to) >= parseInt(tcp_port_start_val) && parseInt(range_list[j].tcp_to) <= parseInt(tcp_port_end_val))) {
						Alert.render("<!--#tr id="port.range.alert.3"-->The TCP port number is already used. Please assign a different port number.<!--#endtr-->");
						return false;
					}
				}
			}
			
			if (udp_port_empty == 0) {
				if (parseInt(range_list[j].udp_from) != 0 && parseInt(range_list[j].udp_to) != 0) {
					if ((parseInt(udp_port_start_val) >= parseInt(range_list[j].udp_from) && parseInt(udp_port_start_val) <= parseInt(range_list[j].udp_to)) 
								|| (parseInt(udp_port_end_val) >= parseInt(range_list[j].udp_from) && parseInt(udp_port_end_val <= range_list[j].udp_to)) 
								|| (parseInt(range_list[j].udp_from) >= parseInt(udp_port_start_val) && parseInt(range_list[j].udp_from) <= parseInt(udp_port_end_val)) 
								|| (parseInt(range_list[j].udp_to) >= parseInt(udp_port_start_val) && parseInt(range_list[j].udp_to) <= parseInt(udp_port_end_val))) {
						Alert.render("<!--#tr id="port.range.alert.4"-->The UDP port number is already used. Please assign a different port number.<!--#endtr-->");
						return false;
					}
				}
			}
		}
		
		if (range_list.length >= 24) {
			Alert.render("<!--#tr id="access.alert.maxrule"-->The maximum number of rules is 24.<!--#endtr-->");
			return false;
		}

		range_list[range_list.length] = new range_list_entry(lan_ip_val, tcp_port_start_val, tcp_port_end_val, udp_port_start_val, udp_port_end_val, sched, enable);
		add_list(range_list.length - 1);
		
	}
	else {
		for (j = 0; j < range_list.length; j++) {
			if (j == CurrentTrId) {
				continue;
			}

			if (tcp_port_empty == 0) {
				if (parseInt(range_list[j].tcp_from) != 0 && parseInt(range_list[j].tcp_to) != 0) {
					if ((parseInt(tcp_port_start_val) >= parseInt(range_list[j].tcp_from) && parseInt(tcp_port_start_val) <= parseInt(range_list[j].tcp_to)) 
								|| (parseInt(tcp_port_end_val) >= parseInt(range_list[j].tcp_from) && parseInt(tcp_port_end_val) <= parseInt(range_list[j].tcp_to)) 
								|| (parseInt(range_list[j].tcp_from) >= parseInt(tcp_port_start_val) && parseInt(range_list[j].tcp_from) <= parseInt(tcp_port_end_val)) 
								|| (parseInt(range_list[j].tcp_to) >= parseInt(tcp_port_start_val) && parseInt(range_list[j].tcp_to) <= parseInt(tcp_port_end_val))) {
						Alert.render("<!--#tr id="port.range.alert.3"-->The TCP port number is already used. Please assign a different port number.<!--#endtr-->");
						return false;
					}
				}
			}

			if (udp_port_empty == 0) {
				if (parseInt(range_list[j].udp_from) != 0 && parseInt(range_list[j].udp_to) != 0) {
					if ((parseInt(udp_port_start_val) >= parseInt(range_list[j].udp_from) && parseInt(udp_port_start_val) <= parseInt(range_list[j].udp_to)) 
								|| (parseInt(udp_port_end_val) >= parseInt(range_list[j].udp_from) && parseInt(udp_port_end_val <= range_list[j].udp_to)) 
								|| (parseInt(range_list[j].udp_from) >= parseInt(udp_port_start_val) && parseInt(range_list[j].udp_from) <= parseInt(udp_port_end_val)) 
								|| (parseInt(range_list[j].udp_to) >= parseInt(udp_port_start_val) && parseInt(range_list[j].udp_to) <= parseInt(udp_port_end_val))) {
						Alert.render("<!--#tr id="port.range.alert.4"-->The UDP port number is already used. Please assign a different port number.<!--#endtr-->");
						return false;
					}
				}
			}
		}
		
		range_list[CurrentTrId] = new range_list_entry(lan_ip_val, tcp_port_start_val, tcp_port_end_val, udp_port_start_val, udp_port_end_val, sched, enable);

		var edit_row = document.getElementById(CurrentTrId);
		edit_row.cells[0].innerHTML = show_lan_ip(CurrentTrId);
		edit_row.cells[1].innerHTML = show_tcp_port(CurrentTrId);
		edit_row.cells[2].innerHTML = show_udp_port(CurrentTrId);
		edit_row.cells[3].innerHTML = show_schedule(CurrentTrId);
		edit_row.cells[4].innerHTML = show_enable(CurrentTrId);
	}

	cancel_input(F);
	return true;
}

function pre_submit() 
{
	var i;

	var array = new Array("port_range_client", "port_range_tcp_start", "port_range_tcp_end", "port_range_udp_start", "port_range_udp_end", 
		"schedule", "port_range_enable");
	
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

