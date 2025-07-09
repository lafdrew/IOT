var CurrentTrId = 0;
var editEntry = 0;
var trigger_list = new Array();
var trigger_num = "<% getListNum(3); %>";
var full_list_string = "<% constructList(3); %>";

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

function show_match_proto(idx)
{
	var str = "";

	if (trigger_list[idx].match_proto == "tcp") {
		str += "<!--#tr id="tcp"-->TCP<!--#endtr-->";
	}
	else if (trigger_list[idx].match_proto == "udp") {
		str += "<!--#tr id="udp"-->UDP<!--#endtr-->";
	}
	else if (trigger_list[idx].match_proto == "both") {
		str += "<!--#tr id="both"-->Both<!--#endtr-->";
	}
	return str;
}

function show_trigger_proto(idx)
{
	var str = "";

	if (trigger_list[idx].trigger_proto == "tcp") {
		str += "<!--#tr id="tcp"-->TCP<!--#endtr-->";
	}
	else if (trigger_list[idx].trigger_proto == "udp") {
		str += "<!--#tr id="udp"-->UDP<!--#endtr-->";
	}
	else if (trigger_list[idx].trigger_proto == "both") {
		str += "<!--#tr id="both"-->Both<!--#endtr-->";
	}
	return str;
}

function show_match_port(idx)
{
	var str = "";

	str += trigger_list[idx].match_from;
	str += " - ";
	str += trigger_list[idx].match_to;

	return str;
}

function show_trigger_port(idx)
{
	var str = "";

	str += trigger_list[idx].trigger_from;
	str += " - ";
	str += trigger_list[idx].trigger_to;

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

			if (trigger_list[idx].sched == list_value[0]) {
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

	if (trigger_list[idx].enable == "on") {
		str += "<!--#tr id="yes"-->Yes<!--#endtr-->";
	}
	else if (trigger_list[idx].enable == "off") {
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
		F.pt_sched.options.add(opt);
		
		i++;
	}
}

function dyn_select_sched_option()
{
	var F = document.forms[0];
	var selvalue = F.pt_sched;
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
	for (var i = idx; i < trigger_list.length - 1 ; i++) {
		trigger_list[i] = trigger_list[ i + 1];
	}

	trigger_list.length = trigger_list.length - 1;
}

function del_trigger_list(idx)
{
	var tbody = document.getElementById("tableList").getElementsByTagName("TBODY")[0];
	
	for (var j = tbody.rows.length; j > 1; j--) { 
		tbody.deleteRow(j - 1);
	}

	del_array_element(idx);

	for (var i = 0; i < trigger_list.length; i++) {
		add_list(i);
	}

	editEntry = 0;
}

function edit_trigger_list(idx)
{
	CurrentTrId = idx;
	var F = document.forms[0];

	if (trigger_list[idx].enable == "on") {
		F.pt_rule_enable.checked = true;
	}
	else {
		F.pt_rule_enable.checked = false;
	}

	F.pt_match_port_start.value = trigger_list[idx].match_from;
	F.pt_match_port_end.value = trigger_list[idx].match_to;

	F.pt_trigger_port_start.value = trigger_list[idx].trigger_from;
	F.pt_trigger_port_end.value = trigger_list[idx].trigger_to;

	if (trigger_list[idx].match_proto == "tcp") {
		F.pt_match_proto.options.selectedIndex = 0;
	}
	else if (trigger_list[idx].match_proto == "udp"){
		F.pt_match_proto.options.selectedIndex = 1;
	}
	else if (trigger_list[idx].match_proto == "both"){
		F.pt_match_proto.options.selectedIndex = 2;
	}
	if (trigger_list[idx].trigger_proto == "tcp") {
		F.pt_trigger_proto.options.selectedIndex = 0;
	}
	else if (trigger_list[idx].trigger_proto == "udp"){
		F.pt_trigger_proto.options.selectedIndex = 1;
	}
	else if (trigger_list[idx].trigger_proto == "both"){
		F.pt_trigger_proto.options.selectedIndex = 2;
	}
	F.pt_sched.value = trigger_list[idx].sched;
	
	editEntry = 1;
}

function add_list(idx)
{
	var tbody = document.getElementById("tableList").getElementsByTagName("TBODY")[0];
	var row = document.createElement("tr");
	var tdArray = new Array();
	var str = "";
	var array = new Array("autofw_port_out_proto", "autofw_port_out_start", "autofw_port_out_end", "autofw_port_in_proto", "autofw_port_in_start", 
		"autofw_port_in_end", "autofw_port_to_start", "autofw_port_to_end", "autofw_port_schedule", "autofw_port_enable");

	//create td
	row.setAttribute("id",idx);
	for(i = 0; i < 8; i++) {
		tdArray[i] = document.createElement("td");
		tdArray[i].setAttribute("class", "form_list_content");
	}
	tdArray[1].setAttribute("colspan", "3");
	tdArray[3].setAttribute("colspan", "3");

	//set td Text
	tdArray[0].innerHTML = show_match_proto(idx);
	tdArray[1].innerHTML = show_match_port(idx);
	tdArray[2].innerHTML = show_trigger_proto(idx);
	tdArray[3].innerHTML = show_trigger_port(idx);
	tdArray[4].innerHTML = show_schedule(idx);
	tdArray[5].innerHTML = show_enable(idx);

	//remove
	var Del = document.createElement("input");
	Del.setAttribute("type", "button");
	Del.setAttribute("value","<!--#tr id="remove"-->Remove<!--#endtr-->");
	Del.setAttribute("class","button3");
	Del.onclick = function(){ del_trigger_list(idx)};
	tdArray[6].appendChild(Del);

	//delete
	var Edit = document.createElement("input");
	Edit.setAttribute("type", "button");
	Edit.setAttribute("value", "<!--#tr id="edit"-->Edit<!--#endtr-->");
	Edit.setAttribute("class","button3");
	Edit.onclick = function(){ edit_trigger_list(idx)};
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

	while (i < trigger_num)
	{
		var acc_list = full_list_string.split("/");
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
		add_list(i);
	}
}

function cancel_input(F)
{
	F.pt_rule_enable.checked = false;
	F.pt_match_port_start.value = "";
	F.pt_match_port_end.value = "";
	F.pt_trigger_port_start.value = "";
	F.pt_trigger_port_end.value = "";
	F.pt_match_proto.options.selectedIndex = 0;
	F.pt_trigger_proto.options.selectedIndex = 0;
	F.pt_sched.options.selectedIndex = 0;

	editEntry = 0;
}

function add_table(F)
{
	var enable, match_port_start_vale, match_port_end_val, trigger_port_start_val, trigger_port_end_val, sched;
	var match_proto, trigger_proto;

	if (F.pt_rule_enable.checked == true) {
		enable = "on";
	}
	else {
		enable = "off";
	}

	var match_port_start = F.pt_match_port_start;
	var match_port_end = F.pt_match_port_end;
	var trigger_port_start = F.pt_trigger_port_start;
	var trigger_port_end = F.pt_trigger_port_end;

	if (isBlankString(match_port_start.value) || isBlankString(match_port_end.value) || isBlankString(trigger_port_start.value) || isBlankString(trigger_port_end.value)) {
		Alert.render("<!--#tr id="ip.port.blank"-->Port cannot be left blank.<!--#endtr-->");
		return false;
	}

	if (!is_port_valid(match_port_start.value) || !is_port_valid(match_port_end.value) || !is_port_valid(trigger_port_start.value) || !is_port_valid(trigger_port_end.value)) {
		Alert.render("<!--#tr id="port.error"-->Please input a correct port between 0 and 65535<!--#endtr-->");
		return false;
	}

	if (parseInt(match_port_start.value) > parseInt(match_port_end.value)) {
		Alert.render("<!--#tr id="trigger.alert.1"-->Match Start port should be less than Match End Port<!--#endtr-->");
		return false;
	}

	if (parseInt(trigger_port_start.value) > parseInt(trigger_port_end.value)) {
		Alert.render("<!--#tr id="trigger.alert.2"-->Trigger Start port should be less than Trigger End Port<!--#endtr-->");
		return false;
	}

	match_port_start_vale = match_port_start.value;
	match_port_end_val = match_port_end.value;
	trigger_port_start_val = trigger_port_start.value;
	trigger_port_end_val = trigger_port_end.value;

	if (F.pt_match_proto.options.selectedIndex == 0) {
		match_proto = "tcp";
	}
	else if (F.pt_match_proto.options.selectedIndex == 1) {
		match_proto = "udp";
	}
	else {
		match_proto = "both";
	}

	if (F.pt_trigger_proto.options.selectedIndex == 0) {
		trigger_proto = "tcp";
	}
	else if (F.pt_trigger_proto.options.selectedIndex == 1){
		trigger_proto = "udp";
	}
	else {
		trigger_proto = "both";
	}

	
	sched = F.pt_sched.value;


	if (editEntry == 0) { //add new entry
		if (trigger_list.length >= 24) {
			Alert.render("<!--#tr id="access.alert.maxrule"-->The maximum number of rules is 24.<!--#endtr-->");
			return false;
		}

		trigger_list[trigger_list.length] = new trigger_list_entry(match_proto, match_port_start_vale, match_port_end_val, trigger_proto, trigger_port_start_val, trigger_port_end_val, sched, enable);
		add_list(trigger_list.length - 1);
		
	}
	else {
		trigger_list[CurrentTrId] = new trigger_list_entry(match_proto, match_port_start_vale, match_port_end_val, trigger_proto, trigger_port_start_val, trigger_port_end_val, sched, enable);

		var edit_row = document.getElementById(CurrentTrId);
		edit_row.cells[0].innerHTML = show_match_proto(CurrentTrId);
		edit_row.cells[1].innerHTML = show_match_port(CurrentTrId);
		edit_row.cells[2].innerHTML = show_trigger_proto(CurrentTrId);
		edit_row.cells[3].innerHTML = show_trigger_port(CurrentTrId);
		edit_row.cells[4].innerHTML = show_schedule(CurrentTrId);
		edit_row.cells[5].innerHTML = show_enable(CurrentTrId);
	}

	cancel_input(F);
	return true;
}

function pre_submit() 
{
	var i;
	
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
