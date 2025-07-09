var ip_CurrentTrId = 0;
var ip_editEntry = 0;
var ip_filter_list = new Array();
var ip_filter_num = "<% getListNum(6); %>";
var ip_full_list_string = "<% constructList(6); %>";

function checkIPStartEnd(start,end) {
	if(atoi(start, 4) > atoi(end, 4))
		return false;
	return true;
}

function ip_filter_list_entry(from_ip, to_ip, sched, enable)
{
	this.from_ip = from_ip;
	this.to_ip = to_ip;
	this.sched = sched;
	this.enable = enable;
}

function show_ip_ip(idx)
{
	var str = "";

	str += ip_filter_list[idx].from_ip;
//	str += " - ";
//	str += ip_filter_list[idx].to_ip;
	
	return str;
}

function show_ip_schedule(idx)
{
	var str = "";
	var i = 0;
	var num = document.getElementById("filter_sched").length;
	
	if (num == 1) {
		str += "<!--#tr id="always"-->Always<!--#endtr-->";
	}
	else {
		while (i < num) {
			if (ip_filter_list[idx].sched == document.getElementById("filter_sched").options[i].value) {
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

function show_ip_enable(idx)
{
	var str = "";

	if (ip_filter_list[idx].enable == "on") {
		str += "<!--#tr id="active"-->Active<!--#endtr-->";
	}
	else if (ip_filter_list[idx].enable == "off") {
		str += "<!--#tr id="inactive"-->Inactive<!--#endtr-->";
	}

	return str;
}

function dyn_add_ip_sched_option()
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
		F.ip_sched.options.add(opt);
		i++;
	}
}

function dyn_select_ip_sched_option()
{
	var F = document.forms[0];
	var selvalue = F.ip_sched;
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


function del_ip_array_element(idx)
{
	for (var i = idx; i < ip_filter_list.length - 1 ; i++) {
		ip_filter_list[i] = ip_filter_list[ i + 1];
	}

	ip_filter_list.length = ip_filter_list.length - 1;
}

function del_ip_filter_list(idx)
{
	var tbody = document.getElementById("summary_tableList").getElementsByTagName("TBODY")[0];
	
	for (var j = tbody.rows.length; j > 1; j--) { 
		tbody.deleteRow(j - 1);
	}

	del_ip_array_element(idx);

	for (var i = 0; i < url_filter_list.length; i++) {
		add_url_list(i);
	}
	for (var i = 0; i < ip_filter_list.length; i++) {
		add_ip_list(i);
	}

	ip_editEntry = 0;
}

function edit_ip_filter_list(idx, schedule_nam)
{
	ip_CurrentTrId = idx;
	var F = document.forms[0];

	if (ip_filter_list[idx].enable == "on") {
		F.checkenable.checked = true;
	}
	else {
		F.checkenable.checked = false;
	}
	
	change_fileter_mode("1");
	
	F.web_rule_enable.disabled = true;
	F.ip_rule_enable.disabled = true;

	F.ip_ip_start.value = ip_filter_list[idx].from_ip;
//	F.ip_ip_end.value = ip_filter_list[idx].to_ip;

	F.filter_sched.value = ip_filter_list[idx].sched;
	
	ip_editEntry = 1;
	
	if(schedule_nam != "Always")
		edit_schedule(ip_filter_list[idx].sched);
	else {
		document.getElementById("SetTable").innerHTML = "";
		schedule_editEntry = 0;
	}
}

function add_ip_list(idx)
{
	var tbody = document.getElementById("summary_tableList").getElementsByTagName("TBODY")[0];
	var row = document.createElement("tr");
	var tdArray = new Array();
	var str = "";
	var array = new Array("filter_ip_from_start", "filter_ip_from_end", "filter_ip_schedule", "filter_ip_enable");

	//create td
	row.setAttribute("id", idx + "ip");
	for(i = 0; i < 5; i++) {
		tdArray[i] = document.createElement("td");
		tdArray[i].setAttribute("class", "form_list_content");
	}
	tdArray[0].setAttribute("width", "70%");

	//set td Text
	tdArray[0].innerHTML = show_ip_ip(idx);
	tdArray[1].innerHTML = show_ip_schedule(idx);
	tdArray[2].innerHTML = show_ip_enable(idx);

	//remove
	var Del = document.createElement("input");
	Del.setAttribute("type", "button");
	Del.setAttribute("value","<!--#tr id="remove"-->Remove<!--#endtr-->");
	Del.setAttribute("class","button3");
	Del.onclick = function(){ del_ip_filter_list(idx)};
	tdArray[3].appendChild(Del);

	//Edit
	var Edit = document.createElement("input");
	Edit.setAttribute("type", "button");
	Edit.setAttribute("value", "<!--#tr id="edit"-->Edit<!--#endtr-->");
	Edit.setAttribute("class","button3");
	Edit.onclick = function(){ edit_ip_filter_list(idx, show_ip_schedule(idx))};
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

function cancel_ip_input()
{
	var F = document.forms[0];
	F.checkenable.checked = false;
	F.ip_ip_start.value = "";
//	F.ip_ip_end.value = "";
	F.filter_sched.options.selectedIndex = 0;
	
	ip_editEntry = 0;
}

function add_ip_table(F)
{
	var currentLanIP = document.getElementById("currentLanIP").value;
	var currentLanMask = document.getElementById("currentLanMask").value;

	var enable, from_ip_val, to_ip_val, sched;

	if (F.checkenable.checked == true) {
		enable = "on";
	}
	else {
		enable = "off";
	}

	var from_ip = F.ip_ip_start;
//	var to_ip = F.ip_ip_end;

	if (isBlankString(from_ip.value)) {
		from_ip.focus();
		Alert.render("<!--#tr id="ip.address.blank"-->IP address cannot be left blank.<!--#endtr-->");
		return false;
	}

	if (!checkIpAddr(from_ip, false)) {
		from_ip.focus();
		Alert.render("<!--#tr id="ip.address.error"-->Invalid IP address! Please enter a valid IP address.<!--#endtr-->");
		return false;
	}

	if (!checkSameSubnet(from_ip.value , currentLanIP, currentLanMask)) {
		from_ip.focus();
		Alert.render("<!--#tr id="ip.not.in.lan.error" -->IP address does not in LAN subnet.<!--#endtr -->");
		return false;
 	}

	from_ip_val = from_ip.value;
	to_ip_val = from_ip.value;
	sched = F.filter_sched.value;
	
	if (ip_editEntry == 0) { //add new entry
		if (ip_filter_list.length >= 24) {
			Alert.render("<!--#tr id="access.alert.maxrule"-->The maximum number of rules is 24.<!--#endtr-->");
			return false;
		}

		for (i = 0; i < ip_filter_list.length; i++) {
			if (from_ip_val == ip_filter_list[i].from_ip) {
				Alert.render("<!--#tr id="lan.alert.22"-->This IP is already set in another rule.<!--#endtr-->");
				return false;
			}
		}
		
		ip_filter_list[ip_filter_list.length] = new ip_filter_list_entry(from_ip_val, to_ip_val, sched, enable);
	//add_ip_list(ip_filter_list.length - 1);
	}
	else {
		for (i = 0; i < ip_filter_list.length; i++) {
			if (i == ip_CurrentTrId) {
				continue;
			}

			if (from_ip_val == ip_filter_list[i].from_ip) {
				Alert.render("<!--#tr id="lan.alert.22"-->This IP is already set in another rule.<!--#endtr-->");
				return false;
			}
		}

		ip_filter_list[ip_CurrentTrId] = new ip_filter_list_entry(from_ip_val, to_ip_val, sched, enable);

		var edit_row = document.getElementById(ip_CurrentTrId + "ip");
		edit_row.cells[0].innerHTML = show_ip_ip(ip_CurrentTrId);
		edit_row.cells[1].innerHTML = show_ip_schedule(ip_CurrentTrId);
		edit_row.cells[2].innerHTML = show_ip_enable(ip_CurrentTrId);
	}

	return true;
}

function pre_ip_submit() 
{
	var i;

	for (i = 0; i < ip_filter_list.length; i++) {
		document.getElementById("filter_ip_from_start" + i).value = ip_filter_list[i].from_ip;
		document.getElementById("filter_ip_from_end" + i).value = ip_filter_list[i].to_ip;
		document.getElementById("filter_ip_schedule" + i).value = ip_filter_list[i].sched;
		document.getElementById("filter_ip_enable" + i).value = ip_filter_list[i].enable;
	}
}

