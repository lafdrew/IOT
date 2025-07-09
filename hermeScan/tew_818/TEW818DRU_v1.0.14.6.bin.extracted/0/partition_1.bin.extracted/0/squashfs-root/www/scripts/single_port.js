var CurrentTrId = 0;
var editEntry = 0;
var forward_list = new Array();
var forward_num = "<% getListNum(2); %>";
var full_list_string = "<% constructList(2); %>";

function forward_list_entry(pub_port, lan_ip, priv_port, proto, sched, enable)
{
	this.pub_port = pub_port;
	this.lan_ip = lan_ip;
	this.priv_port = priv_port;
	this.proto = proto;
	this.sched = sched;
	this.enable = enable;
}

function show_lan_ip(idx)
{
	var str = "";

	str += forward_list[idx].lan_ip;
	
	return str;
}

function show_proto(idx)
{
	var str = "";

	if (forward_list[idx].proto == "tcp") {
		str += "TCP";
	}
	else if (forward_list[idx].proto == "udp") {
		str += "UDP";
	}

	return str;
}

function show_pub_port(idx)
{
	var str = "";

	str += forward_list[idx].pub_port;

	return str;
}

function show_priv_port(idx)
{
	var str = "";

	str += forward_list[idx].priv_port;

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

			if (forward_list[idx].sched == list_value[0]) {
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

	if (forward_list[idx].enable == "on") {
		str += "<!--#tr id="yes"-->Yes<!--#endtr-->";
	}
	else if (forward_list[idx].enable == "off") {
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
		F.sp_sched.options.add(opt);

		i++;
	}
}

function dyn_select_sched_option()
{
	var F = document.forms[0];
	var selvalue = F.sp_sched;
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
	for (var i = idx; i < forward_list.length - 1 ; i++) {
		forward_list[i] = forward_list[ i + 1];
	}

	forward_list.length = forward_list.length - 1;
}

function del_forward_list(idx)
{
	var tbody = document.getElementById("tableList").getElementsByTagName("TBODY")[0];
	
	for (var j = tbody.rows.length; j > 1; j--) { 
		tbody.deleteRow(j - 1);
	}

	del_array_element(idx);

	for (var i = 0; i < forward_list.length; i++) {
		add_list(i);
	}

	editEntry = 0;
}

function edit_forward_list(idx)
{
	CurrentTrId = idx;
	var F = document.forms[0];

	if (forward_list[idx].enable == "on") {
		F.sp_rule_enable.checked = true;
	}
	else {
		F.sp_rule_enable.checked = false;
	}

	F.sp_lan_ip.value = forward_list[idx].lan_ip;

	F.sp_public_port.value = forward_list[idx].pub_port;
	F.sp_private_port.value = forward_list[idx].priv_port;

	if (forward_list[idx].proto == "tcp") {
		F.sp_proto.options.selectedIndex = 0;
	}
	else if (forward_list[idx].proto == "udp"){
		F.sp_proto.options.selectedIndex = 1;
	}

	F.sp_sched.value = forward_list[idx].sched;

	editEntry = 1;
}

function add_list(idx)
{
	var tbody = document.getElementById("tableList").getElementsByTagName("TBODY")[0];
	var row = document.createElement("tr");
	var tdArray = new Array();
	var str = "";
	var array = new Array("forward_port_proto", "forward_port_from_start", "forward_port_from_end", "forward_port_to_ip", "forward_port_to_start", 
		"forward_port_to_end", "forward_port_schedule", "forward_port_enable");

	//create td
	row.setAttribute("id",idx);
	for(i = 0; i < 8; i++) {
		tdArray[i] = document.createElement("td");
		tdArray[i].setAttribute("class", "form_list_content");
	}

	//set td Text
	tdArray[0].innerHTML = show_proto(idx);
	tdArray[1].innerHTML = show_pub_port(idx);
	tdArray[2].innerHTML = show_lan_ip(idx);
	tdArray[3].innerHTML = show_priv_port(idx);
	tdArray[4].innerHTML = show_schedule(idx);
	tdArray[5].innerHTML = show_enable(idx);

	//remove
	var Del = document.createElement("input");
	Del.setAttribute("type", "button");
	Del.setAttribute("value","<!--#tr id="remove"-->Remove<!--#endtr-->");
	Del.setAttribute("class","button3");
	Del.onclick = function(){ del_forward_list(idx)};
	tdArray[6].appendChild(Del);

	//delete
	var Edit = document.createElement("input");
	Edit.setAttribute("type", "button");
	Edit.setAttribute("value", "<!--#tr id="edit"-->Edit<!--#endtr-->");
	Edit.setAttribute("class","button3");
	Edit.onclick = function(){ edit_forward_list(idx)};
	tdArray[7].appendChild(Edit);

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
	for ( i = 0; i < 8; i++) {
		row.appendChild(tdArray[i]);
	}

	tbody.appendChild(row);
}

function init_table()
{
	var j = 0, i = 0;

	while (i < forward_num)
	{
		var acc_list = full_list_string.split("/");
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
		add_list(i);
	}
}

function cancel_input(F)
{
	F.sp_rule_enable.checked = false;
	F.sp_lan_ip.value = "";
	F.sp_public_port.value = "";
	F.sp_private_port.value = "";
	F.sp_proto.options.selectedIndex = 0;
	F.sp_sched.options.selectedIndex = 0;

	editEntry = 0;
}

function add_table(F)
{
	var currentLanIP = document.getElementById("currentLanIP").value;
	var currentLanMask = document.getElementById("currentLanMask").value;

	var enable, lan_ip_val, proto, pub_port_val, priv_port_val, sched;

	if (F.sp_rule_enable.checked == true) {
		enable = "on";
	}
	else {
		enable = "off";
	}

	var lan_ip = F.sp_lan_ip;
	var pub_port = F.sp_public_port;
	var priv_port = F.sp_private_port;

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

	if (isBlankString(pub_port.value) || isBlankString(priv_port.value)) {
		Alert.render("<!--#tr id="ip.port.blank"-->Port cannot be left blank.<!--#endtr-->");
		return false;
	}

	if (!is_port_valid(pub_port.value) || !is_port_valid(priv_port.value)) {
		Alert.render("<!--#tr id="port.error"-->Please input a correct port between 0 and 65535<!--#endtr-->");
		return false;
	}

	lan_ip_val = lan_ip.value;
	pub_port_val = pub_port.value;
	priv_port_val = priv_port.value;

	if (F.sp_proto.options.selectedIndex == 0) {
		proto = "tcp";
	}
	else {
		proto = "udp";
	}

	sched = F.sp_sched.value;

	if (editEntry == 0) { //add new entry
		if (forward_list.length >= 24) {
			Alert.render("<!--#tr id="access.alert.maxrule"-->The maximum number of rules is 24.<!--#endtr-->");
			return false;
		}

		forward_list[forward_list.length] = new forward_list_entry(pub_port_val, lan_ip_val, priv_port_val, proto, sched, enable);
		add_list(forward_list.length - 1);
	}
	else {
		forward_list[CurrentTrId] = new forward_list_entry(pub_port_val, lan_ip_val, priv_port_val, proto, sched, enable);

		var edit_row = document.getElementById(CurrentTrId);
		edit_row.cells[0].innerHTML = show_proto(CurrentTrId);
		edit_row.cells[1].innerHTML = show_pub_port(CurrentTrId);
		edit_row.cells[2].innerHTML = show_lan_ip(CurrentTrId);
		edit_row.cells[3].innerHTML = show_priv_port(CurrentTrId);
		edit_row.cells[4].innerHTML = show_schedule(CurrentTrId);
		edit_row.cells[5].innerHTML = show_enable(CurrentTrId);
	}

	cancel_input(F);
	return true;
}

function pre_submit() 
{
	var i;

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

