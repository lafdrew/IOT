var CurrentTrId = 0;
var editEntry = 0;
var access_list = new Array();
var access_num = "<% getListNum(1); %>";
var full_list_string = "<% constructList(1); %>";


function checkIPStartEnd(start,end) {
	if(atoi(start, 4) > atoi(end, 4))
		return false;
	return true;
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

function show_ip(idx)
{
	var str = "";

	str += access_list[idx].from_ip;
	str += " - ";
	str += access_list[idx].to_ip;
	
	return str;
}

function show_proto(idx)
{
	var str = "";

	if (access_list[idx].proto == "tcp") {
		str += "TCP";
	}
	else if (access_list[idx].proto == "udp") {
		str += "UDP";
	}

	return str;
}

function show_port(idx)
{
	var str = "";

	str += access_list[idx].from_port;
	str += " - ";
	str += access_list[idx].to_port;

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

			if (access_list[idx].sched == list_value[0]) {
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

	if (access_list[idx].enable == "on") {
		str += "<!--#tr id="yes"-->Yes<!--#endtr-->";
	}
	else if (access_list[idx].enable == "off") {
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
		F.fc_sched.options.add(opt);
		
		i++;
	}
}

function dyn_select_sched_option()
{
	var F = document.forms[0];
	var selvalue = F.fc_sched;
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
	for (var i = idx; i < access_list.length - 1 ; i++) {
		access_list[i] = access_list[ i + 1];
	}

	access_list.length = access_list.length - 1;
}

function del_access_list(idx)
{
	var tbody = document.getElementById("tableList").getElementsByTagName("TBODY")[0];
	
	for (var j = tbody.rows.length; j > 1; j--) { 
		tbody.deleteRow(j - 1);
	}

	del_array_element(idx);

	for (var i = 0; i < access_list.length; i++) {
		add_list(i);
	}

	editEntry = 0;
}

function edit_access_list(idx)
{
	CurrentTrId = idx;
	var F = document.forms[0];

	if (access_list[idx].enable == "on") {
		F.fc_rule_enable.checked = true;
	}
	else {
		F.fc_rule_enable.checked = false;
	}

	F.fc_ip_start.value = access_list[idx].from_ip;
	F.fc_ip_end.value = access_list[idx].to_ip;

	F.fc_port_start.value = access_list[idx].from_port;
	F.fc_port_end.value = access_list[idx].to_port;

	if (access_list[idx].proto == "tcp") {
		F.fc_proto.options.selectedIndex = 0;
	}
	else if (access_list[idx].proto == "udp"){
		F.fc_proto.options.selectedIndex = 1;
	}

	F.fc_sched.value = access_list[idx].sched;
	
	editEntry = 1;
}

function add_list(idx)
{
	var tbody = document.getElementById("tableList").getElementsByTagName("TBODY")[0];
	var row = document.createElement("tr");
	var tdArray = new Array();
	var str = "";
	var array = new Array("filter_client_from_start", "filter_client_from_end", "filter_client_proto", "filter_client_to_start", "filter_client_to_end", 
		"filter_client_schedule", "filter_client_enable");

	//create td
	row.setAttribute("id",idx);
	for(i = 0; i < 7; i++) {
		tdArray[i] = document.createElement("td");
		tdArray[i].setAttribute("class", "form_list_content");
	}
	tdArray[0].setAttribute("colspan", "3");
	tdArray[2].setAttribute("colspan", "3");

	//set td Text
	tdArray[0].innerHTML = show_ip(idx);
	tdArray[1].innerHTML = show_proto(idx);
	tdArray[2].innerHTML = show_port(idx);
	tdArray[3].innerHTML = show_schedule(idx);
	tdArray[4].innerHTML = show_enable(idx);

	//remove
	var Del = document.createElement("input");
	Del.setAttribute("type", "button");
	Del.setAttribute("value","<!--#tr id="remove"-->Remove<!--#endtr-->");
	Del.setAttribute("class","button3");
	Del.onclick = function(){ del_access_list(idx)};
	tdArray[5].appendChild(Del);

	//delete
	var Edit = document.createElement("input");
	Edit.setAttribute("type", "button");
	Edit.setAttribute("value", "<!--#tr id="edit"-->Edit<!--#endtr-->");
	Edit.setAttribute("class","button3");
	Edit.onclick = function(){ edit_access_list(idx)};
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

	while (i < access_num)
	{
		var acc_list = full_list_string.split("/");
		var list_value = acc_list[i].split(",");
		var tmp_list = list_value[0].split(":");
		var ip_list = tmp_list[0].split("-");
		var port_list = tmp_list[1].split("-");
		
		access_list[j] = new access_list_entry(ip_list[0], ip_list[1], port_list[0], port_list[1], list_value[1], list_value[2], list_value[3]);
		j++;
		i++;
	}

	for (var i=0; i < access_list.length; i++) {
		add_list(i);
	}
}

function cancel_input(F)
{
	F.fc_rule_enable.checked = false;
	F.fc_ip_start.value = "";
	F.fc_ip_end.value = "";
	F.fc_port_start.value = "";
	F.fc_port_end.value = "";
	F.fc_proto.options.selectedIndex = 0;
	F.fc_sched.options.selectedIndex = 0;

	editEntry = 0;
}

function add_table(F)
{
	var currentLanIP = document.getElementById("currentLanIP").value;
	var currentLanMask = document.getElementById("currentLanMask").value;

	var enable, from_ip, to_ip, proto, from_port, to_port, sched;

	if (F.fc_rule_enable.checked == true) {
		enable = "on";
	}
	else {
		enable = "off";
	}

	var ip_start = F.fc_ip_start;
	var ip_end = F.fc_ip_end;
	var port_start = F.fc_port_start;
	var port_end = F.fc_port_end;

	if (isBlankString(ip_start.value) || isBlankString(ip_end.value)) {
		Alert.render("<!--#tr id="ip.address.blank"-->IP address cannot be left blank.<!--#endtr-->");
		return false;
	}

	if (!checkIpAddr(ip_start, false) || !checkIpAddr(ip_end, false)) {
		Alert.render("<!--#tr id="ip.address.error"-->Invalid IP address! Please enter a valid IP address.<!--#endtr-->");
		return false;
	}

	if (!checkSameSubnet(ip_start.value , currentLanIP, currentLanMask) || !checkSameSubnet(ip_end.value , currentLanIP, currentLanMask)) {
            Alert.render("<!--#tr id="ip.not.in.lan.error" -->IP address does not in LAN subnet.<!--#endtr -->");
            return false;
 	}

 	if (!checkIPStartEnd(ip_start.value, ip_end.value)) {
		Alert.render("<!--#tr id="access.alert.2" -->Start IP should smaller than End IP!<!--#endtr -->");
		return false;
	}

	if (isBlankString(port_start.value) || isBlankString(port_end.value)) {
		Alert.render("<!--#tr id="ip.port.blank"-->Port cannot be left blank.<!--#endtr-->");
		return false;
	}

	if (!is_port_valid(port_start.value) || !is_port_valid(port_start.value)) {
		Alert.render("<!--#tr id="port.error"-->Please input a correct port between 0 and 65535<!--#endtr-->");
		return false;
	}

	if (parseInt(port_start.value) > parseInt(port_end.value)) {
		Alert.render("<!--#tr id="access.alert.1"-->Destination Start port should be less than Destination End Port<!--#endtr-->");
		return false;
	}

	from_ip = ip_start.value;
	to_ip = ip_end.value;
	from_port = port_start.value;
	to_port = port_end.value;

	if (F.fc_proto.options.selectedIndex == 0) {
		proto = "tcp";
	}
	else {
		proto = "udp";
	}
	
	sched = F.fc_sched.value;


	if (editEntry == 0) { //add new entry
		if (access_list.length >= 24) {
			Alert.render("<!--#tr id="access.alert.maxrule"-->The maximum number of rules is 24.<!--#endtr-->");
			return false;
		}

		access_list[access_list.length] = new access_list_entry(from_ip, to_ip, from_port, to_port, proto, sched, enable);
		add_list(access_list.length - 1);
		
	}
	else {
		access_list[CurrentTrId] = new access_list_entry(from_ip, to_ip, from_port, to_port, proto, sched, enable);

		var edit_row = document.getElementById(CurrentTrId);
		edit_row.cells[0].innerHTML = show_ip(CurrentTrId);
		edit_row.cells[1].innerHTML = show_proto(CurrentTrId);
		edit_row.cells[2].innerHTML = show_port(CurrentTrId);
		edit_row.cells[3].innerHTML = show_schedule(CurrentTrId);
		edit_row.cells[4].innerHTML = show_enable(CurrentTrId);
	}

	cancel_input(F);
	return true;
}

function pre_submit() 
{
	var i;
	
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
