var mac_CurrentTrId = 0;
var mac_editEntry = 0;
var mac_filter_list = new Array();

var mac_full_list_string = "<% nvram_get("parental_maclist"); %>";

function mac_filter_list_entry(mac)
{
	this.mac = mac;
}

function show_mac(idx)
{
	var str = "";

	str += mac_filter_list[idx].mac;

	return str;
}

function del_mac_array_element(idx)
{
	for (var i = idx; i < mac_filter_list.length - 1 ; i++) {
		mac_filter_list[i] = mac_filter_list[ i + 1];
	}

	mac_filter_list.length = mac_filter_list.length - 1;
}

function del_mac_filter_list(idx)
{
	var tbody = document.getElementById("mac_tableList").getElementsByTagName("TBODY")[0];
	
	for (var j = tbody.rows.length; j > 1; j--) { 
		tbody.deleteRow(j - 1);
	}

	del_mac_array_element(idx);

	for (var i = 0; i < mac_filter_list.length; i++) {
		add_mac_list(i);
	}

	mac_editEntry = 0;
}

function edit_mac_filter_list(idx)
{
	mac_CurrentTrId = idx;
	var F = document.forms[0];

	F.mac_address.value = mac_filter_list[idx].mac;
	
	mac_editEntry = 1;
}

function add_mac_list(idx)
{
	var tbody = document.getElementById("mac_tableList").getElementsByTagName("TBODY")[0];
	var row = document.createElement("tr");
	var tdArray = new Array();
	var str = "";
	var array = new Array("parental_maclist", "parental_macif");

	//create td
	row.setAttribute("id", idx + "mac");
	for(i = 0; i < 3; i++) {
		tdArray[i] = document.createElement("td");
		tdArray[i].setAttribute("class", "form_list_content");
	}
	
	tdArray[0].setAttribute("width", "70%");

	//set td Text
	tdArray[0].innerHTML = show_mac(idx);

	//remove
	var Del = document.createElement("input");
	Del.setAttribute("type", "button");
	Del.setAttribute("value","<!--#tr id="remove"-->Remove<!--#endtr-->");
	Del.setAttribute("class","button3");
	Del.onclick = function(){ del_mac_filter_list(idx)};
	tdArray[1].appendChild(Del);

	//delete
	var Edit = document.createElement("input");
	Edit.setAttribute("type", "button");
	Edit.setAttribute("value", "<!--#tr id="edit"-->Edit<!--#endtr-->");
	Edit.setAttribute("class","button3");
	Edit.onclick = function(){ edit_mac_filter_list(idx)};
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

function init_mac_table()
{
	var j = 0, i = 0;

	if (mac_full_list_string != "") {
		var acc_list = mac_full_list_string.split(" ");

		for (j =0; j < acc_list.length; j++) {
			mac_filter_list[j] = new mac_filter_list_entry(acc_list[j]);
		}

		for (i = 0; i < mac_filter_list.length; i++) {
			add_mac_list(i);
		}
	}
}

function cancel_mac_input()
{
	var F = document.forms[0];
	F.mac_address.value = "";
	
	mac_editEntry = 0;
}

function checkMacValid(mac)
{
	var list = mac.split(":");
	if (parseInt(list[0], 16) & 0x1) {
		return false;
	}

	if ((parseInt(list[0], 16) == 0xff) && (parseInt(list[1], 16) == 0xff) && (parseInt(list[2], 16) == 0xff) && 
		(parseInt(list[3], 16) == 0xff) && (parseInt(list[4], 16) == 0xff) && (parseInt(list[5], 16) == 0xff)) {
		return false;
	}

	if ((parseInt(list[0], 16) == 0x00) && (parseInt(list[1], 16) == 0x00) && (parseInt(list[2], 16) == 0x00) && 
		(parseInt(list[3], 16) == 0x00) && (parseInt(list[4], 16) == 0x00) && (parseInt(list[5], 16) == 0x00)) {
		return false;
	}

	return true;
}

function add_mac_table(F)
{
	var mac_val, i = 0;

	var mac = F.mac_address; 

	if (isBlankString(mac.value)) {
		Alert.render("<!--#tr id="mac.address.blank"-->MAC address cannot be left blank.<!--#endtr-->");
		return false;
	}

	if (!checkMac(mac.value) || !checkMacValid(mac.value)) {
		Alert.render("<!--#tr id="mac.address.error"-->Invalid MAC address! Please enter a valid MAC address.<!--#endtr-->");
		return false;
	}

	mac_val = mac.value;
	if (mac_editEntry == 0) { //add new entry
		if (mac_filter_list.length >= 24) {
			Alert.render("<!--#tr id="access.alert.maxrule"-->The maximum number of rules is 24.<!--#endtr-->");
			return false;
		}

		for (i = 0; i < mac_filter_list.length; i++) {
			if (mac_val.toLowerCase() == mac_filter_list[i].mac.toLowerCase()) {
				Alert.render("<!--#tr id="lan.alert.23"-->This MAC Address is already set in another rule.<!--#endtr-->");
				return false;
			}
		}

		mac_filter_list[mac_filter_list.length] = new mac_filter_list_entry(mac_val);
		add_mac_list(mac_filter_list.length - 1);
	}
	else {
		for (i = 0; i < mac_filter_list.length; i++) {
			if (i == mac_CurrentTrId) {
				continue;
			}

			if (mac_val == mac_filter_list[i].mac) {
				Alert.render("<!--#tr id="lan.alert.23"-->This MAC Address is already set in another rule.<!--#endtr-->");
				return false;
			}
		}
		
		mac_filter_list[mac_CurrentTrId] = new mac_filter_list_entry(mac_val);

		var edit_row = document.getElementById(mac_CurrentTrId + "mac");
		edit_row.cells[0].innerHTML = show_mac(mac_CurrentTrId);
 	}

	cancel_mac_input();
	return true;
}

function pre_mac_submit() 
{
	var i;
	var len = mac_filter_list.length;

	document.getElementById("filter_macmode").value = document.getElementById("parental_macmode").value;
//	document.getElementById("wl_macmode").value = document.getElementById("parental_macmode").value;

	for (i = 0; i < len; i++) {
		document.getElementById("parental_maclist" + i).value = mac_filter_list[i].mac;
		document.getElementById("parental_macif" + i).value = "lan";
		document.getElementById("macFilter" + i).value = mac_filter_list[i].mac;
		document.getElementById("macAddressInput" + i).value = "";
	}

	for (i = len; i < 24; i++) {
		document.getElementById("macFilter" + i).value = "";
		document.getElementById("macAddressInput" + i).value = "";
	}
}
