function dyn_add_wlssid_sched_option()
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
		F.wl_schedule.options.add(opt);
		i++;
	}
}

function change_wlschedule() {
	var unit = "<% nvram_get("wl_unit"); %>";
	var schedule_mode = 0;
	
	if (unit == "0")
		schedule_mode = "<% nvram_get("wl0_schedule"); %>";
	else if (unit == "0.1")
		schedule_mode = "<% nvram_get("wl0.1_schedule"); %>";
	else if (unit == "0.2")
		schedule_mode = "<% nvram_get("wl0.2_schedule"); %>";
	else if (unit == "0.3")
		schedule_mode = "<% nvram_get("wl0.3_schedule"); %>";	
	else if (unit == "1")
		schedule_mode = "<% nvram_get("wl1_schedule"); %>";
	else if (unit == "1.1")
		schedule_mode = "<% nvram_get("wl1.1_schedule"); %>";
	else if (unit == "1.2")
		schedule_mode = "<% nvram_get("wl1.2_schedule"); %>";
	else if (unit == "1.3")
		schedule_mode = "<% nvram_get("wl1.3_schedule"); %>";

	var selvalue = document.getElementById("wl_schedule");
	var count = 0;
	var i = 0;
	var cookie_str = document.cookie;
	var c_start, c_end;

	c_start = cookie_str.indexOf("new_schedule=");
	
	if (cookie_str.length > 0) {
		if (c_start != -1) {
			c_start = c_start + "new_schedule=".length;
			c_end = cookie_str.indexOf(";", c_start);
			if (c_end == -1) {
				c_end = cookie_str.length;
			}
			schedule_mode = cookie_str.substring(c_start, c_end);

			document.cookie = "new_schedule=; expires=Thu, 01, Jan 1970 00:00:00 UTC"
		}
	}

	for (i = 0; i < selvalue.length; i++) {
		if (schedule_mode == selvalue.options[i].value)
			count++;
	}

	if (count == 1)
		document.getElementById("wl_schedule").value = schedule_mode;
	else
		document.getElementById("wl_schedule").value = "0";
}

