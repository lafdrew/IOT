<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en"><!-- InstanceBegin template="/Templates/basic.dwt" codeOutsideHTMLIsLocked="false" -->
<head>
<meta http-equiv="content-type" content="text/html; charset=utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE8"/>

<title>TRENDnet | TEW-818DRU | <!--#tr id="project.desc"-->AC1900 Dual Band Wireless Router<!--#endtr--></title>
<!-- InstanceBeginEditable name="Page Title" -->

<!-- InstanceEndEditable -->

<link href="../style/style.css" rel="stylesheet" type="text/css" media="screen" />
<link href="../style/frame.css" rel="stylesheet" type="text/css" media="screen" />
<!-- InstanceBeginEditable name="Local Styles" -->
	<style type="text/css">
	/*
	 * Styles used only on this page.
	 */
	 
 #selectable .ui-selecting { background: #63cef6; }
 #selectable .ui-selected { background: #63cef6; color: white; }
 #selectable .ui-unselected { background: gray; color: green; }
 #selectable .ui-unselecting { background: green; color: black; }
 #selectable { border-spacing:0px; margin-left:0px;margin-top:0px; padding: 0px; width:100%;}
 #selectable td { height: 22px; }
.parental_th{
	font-weight: bold;
	text-align: center;
	background-color: #323339;
	vertical-align: middle;
	border: thin solid #191919;
	width:160px;
	height:26px;
	cursor: pointer;
} 
.parental_th:hover{
	background:#656E7A;
	cursor: pointer;
}

.checked{
	background-color:#00aff0;
	width:82px;
	border-bottom:solid 1px black;
	border-right:solid 1px black;
}

.disabled{
	width:82px;
	border-bottom:solid 1px black;
	border-right:solid 1px black;
}
	 
	</style>
	<!-- InstanceEndEditable -->

<script type="text/javascript" src="../scripts/jquery.min.js"></script>
<script type="text/javascript" src="../scripts/ddaccordion.js"></script>
<script type="text/javascript" src="../scripts/um.js?20120904<% nvram_get("Language"); %>"></script>
<script type="text/javascript" src="../scripts/func.js?20120904<% nvram_get("Language"); %>"></script>
<script type="text/javascript" src="../scripts/overlib.js"></script>
<!-- InstanceBeginEditable name="Include Files" -->
<script type="text/javascript" src="../scripts/parental_url.js"></script>
<script type="text/javascript" src="../scripts/parental_ip.js"></script>
<script type="text/javascript" src="../scripts/parental_mac.js"></script>
<script type="text/javascript" src="../scripts/jquery-ui.js"></script>

	<!-- InstanceEndEditable -->
<script language="JavaScript" type="text/javascript">
var langset = "<% nvram_get("Language"); %>";
var lang = (langset=="")? "EN":langset;
function doLangSet() {
	document.getElementById("redirect_url").value = location.pathname;
	document.Lang.submit();
}

function expand_path()
{
	if(dev_Wlmode == "psta") {
		//Expand menu by pathname
		var path = location.pathname;
		if(path.indexOf("/station/") > -1)
			ddaccordion.expandone('expandable', 0);
	
	} else {
		//Expand menu by pathname
		var path = location.pathname;
		if(path.indexOf("home.asp") > -1)
			ddaccordion.expandone('expandable', 0);
		if(path.indexOf("wireless.asp") > -1)
			ddaccordion.expandone('expandable', 1);
		if((path.indexOf("guestnetwork.asp") > -1 || path.indexOf("guest_lan.asp") > -1))
			ddaccordion.expandone('expandable', 2);
		if(path.indexOf("parental.asp") > -1)
			ddaccordion.expandone('expandable', 3);
	}
}

function menu_adjust() {
	if (lang=="DE") {
	} else	if (lang=="FR") {
	} else	if (lang=="ESP") {
	} else	if (lang=="RU") {
		if(dev_Wlmode != "psta")
			document.getElementById("mainmenu_4").style.margin = "-12px 0px 0px 5px";
	}
}

var dev_Wlmode = "<% nvram_get("wl_mode"); %>";
function template_load() {
	expand_path();

	//Language default selection
	var i;
	var lang_element = document.getElementById("langSelection");
	for (i=0; i<lang_element.options.length; i++) {
		if (lang == lang_element.options[i].value) {
			lang_element.options.selectedIndex = i;
			break;
		}
	}
	page_load();
	menu_adjust();
}
</script>
<!-- InstanceBeginEditable name="Scripts" -->
<script language="JavaScript" type="text/javascript">
<!--

function checkIPStartEnd(start,end) {
	if(atoi(start, 4) > atoi(end, 4))
		return false;
	return true;
}

function select_all_day(day){
	var check_flag = 0
	day = day.substring(4,5);
	for(i=0;i<24;i++){
		if(schedule_array[day][i] == 0){
			check_flag = 1;			
		}			
	}
	
	if(check_flag == 1){
		for(j=0;j<24;j++){
			schedule_array[day][j] = 1;
			if(j<10){
				j = "0"+j;
			}
		
			id = day + j;
			document.getElementById(id).className = "checked";	
		}
	}
	else{
		for(j=0;j<24;j++){
			schedule_array[day][j] = 0;
			if(j<10){
				j = "0"+j;
			}
		
			id = day + j;
			document.getElementById(id).className = "disabled";	
		}
	}
}

function select_all_time(time){
	var check_flag = 0;
	time_int = parseInt(time, 10);	
	for(i=0;i<7;i++){
		if(schedule_array[i][time] == 0){
			check_flag = 1;			
		}			
	}
	
	if(time<10){
		time = "0"+time;
	}

	if(check_flag == 1){
		for(i=0;i<7;i++){
			schedule_array[i][time_int] = 1;
			
		id = i + time;
		document.getElementById(id).className = "checked";
		}
	}
	else{
		for(i=0;i<7;i++){
			schedule_array[i][time_int] = 0;

		id = i + time;
		document.getElementById(id).className = "disabled";
		}
	}
}


var time_format = "<% nvram_get("time_format"); %>";

function change_time_format(format){
	time_format = format;
	if(format == "1"){
		document.getElementById("time_format").options[1].selected = true;
		document.getElementById("time_format").value = "1";
		var array_time = ["00", "01", "02", "03", "04", "05", "06", "07", "08", "09", "10", "11", "12", "13", "14", "15", "16", "17", "18", "19", "20", "21", "22", "23", "24"];
	} else {
		document.getElementById("time_format").options[0].selected = true;
		document.getElementById("time_format").value = "0";
		var array_time = ["12", "01", "02", "03", "04", "05", "06", "07", "08", "09", "10", "11", "12", "01", "02", "03", "04", "05", "06", "07", "08", "09", "10", "11", "12"];
	}
	for(i = 0; i < 24; i++){
		if(format == "1")
			document.getElementById(i).innerHTML = array_time[i] +" ~ "+ array_time[i+1];
		else{
			if(i < 11 || i == 23)
				document.getElementById(i).innerHTML = array_time[i] +" ~ "+ array_time[i+1] + " AM";
			else
				document.getElementById(i).innerHTML = array_time[i] +" ~ "+ array_time[i+1] + " PM";
		}	
	}
}


var schedule_array = new Array(7);
function init_array(arr){
	for(i=0;i<7;i++){
		arr[i] = new Array(24);

		for(j=0;j<24;j++){
			arr[i][j] = 0;
		}
	}
}

function register_event(){
	var array_temp = new Array(7);
	var checked = 0
	var unchecked = 0;
	init_array(array_temp);

  $(function() {
    $( "#selectable" ).selectable({
		filter:'td',
		selecting: function(event, ui){
					
		},
		unselecting: function(event, ui){
			
		},
		selected: function(event, ui){	
			id = ui.selected.getAttribute('id');
			column = parseInt(id.substring(0,1), 10);
			row = parseInt(id.substring(1,3), 10);	

			array_temp[column][row] = 1;
			if(schedule_array[column][row] == 1){
				checked = 1;
			}
			else if(schedule_array[column][row] == 0){
				unchecked = 1;
			}
		},
		unselected: function(event, ui){

		},		
		stop: function(event, ui){
			if((checked == 1 && unchecked == 1) || (checked == 0 && unchecked == 1)){
				for(i=0;i<7;i++){
					for(j=0;j<24;j++){
						if(array_temp[i][j] == 1){
						schedule_array[i][j] = array_temp[i][j];					
						array_temp[i][j] = 0;		//initialize
						if(j < 10){
							j = "0" + j;						
						}		
							id = i.toString() + j.toString();					
							document.getElementById(id).className = "checked";					
						}
					}
				}									
			}
			else if(checked == 1 && unchecked == 0){
				for(i=0;i<7;i++){
					for(j=0;j<24;j++){
						if(array_temp[i][j] == 1){
						schedule_array[i][j] = 0;					
						array_temp[i][j] = 0;
						
						if(j < 10){
							j = "0" + j;						
						}
							id = i.toString() + j.toString();											
							document.getElementById(id).className = "disabled";												
						}
					}
				}			
			}
		
			checked = 0;
			unchecked = 0;
		}		
	});		
  });

 }

function settingTable(){
	var array_date = ["", "<!--#tr id="schedule.sunday"-->Sun<!--#endtr-->", "<!--#tr id="schedule.monday"-->Mon<!--#endtr-->", "<!--#tr id="schedule.tuesday"-->Tue<!--#endtr-->", "<!--#tr id="schedule.wednesday"-->Wed<!--#endtr-->", "<!--#tr id="schedule.thursday"-->Thu<!--#endtr-->", "<!--#tr id="schedule.friday"-->Fri<!--#endtr-->", "<!--#tr id="schedule.saturday"-->Sat<!--#endtr-->"];
	var array_time_id = ["00", "01", "02", "03", "04", "05", "06", "07", "08", "09", "10", "11", "12", "13", "14", "15", "16", "17", "18", "19", "20", "21", "22", "23"];
	if(time_format == "1")
		var array_time = ["00", "01", "02", "03", "04", "05", "06", "07", "08", "09", "10", "11", "12", "13", "14", "15", "16", "17", "18", "19", "20", "21", "22", "23", "24"];
	else
		var array_time = ["12am", "1am", "2am", "3am", "4am", "5am", "6am", "7am", "8am", "9am", "10am", "11am", "12pm", "1pm", "2pm", "3pm", "4pm", "5pm", "6pm", "7pm", "8pm", "9pm", "10pm", "11pm", "12am"];
	
	var code = "";
	
	code +='<table id="set_rule_tb" width="100%" class="tbl_main">';
	code +='<input type="hidden" name="ruleUid" value="" >';
	code +='<tr><td class="CT" colspan="2"><!--#tr id="schedule.add.rules"-->Add Schedule Rule<!--#endtr--></td></tr>';
	code +='<tr><td class="CL"><!--#tr id="schedule.rule.name"-->Rule Name<!--#endtr--></td><td class="CR"><input name="addRuleName" value="" size="15" maxlength="15" onkeydown="return prevent_press_enter(event);"></td></tr>';	
	code +='<tr><td class="CL"><!--#tr id="time.format"-->Time Format<!--#endtr--></td><td class="CR">';
	code +='<select id="time_format" name="time_format" onchange="change_time_format(this.value);">';
	code += '<option value="0" >12 <!--#tr id="hours"-->Hours<!--#endtr--></option></option>';
	code += '<option value="1" >24 <!--#tr id="hours"-->Hours<!--#endtr--></option></option>';
	code += '</select>';
	code +='</td></tr>';
	
	code += '<tr><td colspan="2"><table id="selectable" class="tbl_main2">';
	code += '<tr>';
	for(i=0;i<8;i++){
		if(i == 0)
			code +="<th class='parental_th'>"+array_date[i]+"</th>";	
		else
			code +="<th id=col_"+(i-1)+" class='parental_th' onclick='select_all_day(this.id);'>"+array_date[i]+"</th>";			
	}
	code += '</tr>';
	
	for(i=0;i<24;i++){
		code += '<tr>';
		code +="<th id="+i+" class='parental_th' onclick='select_all_time(this.id)'>"+ array_time[i] + " ~ " + array_time[i+1] +"</th>";
		for(j=0;j<7;j++){
			code += "<td id="+ j + array_time_id[i] +" class='disabled' ></td>";		
		}
		
		code += '</tr>';			
	}
	
	code +='</table></td></tr>';
	code +='</table>';
	
	
	code +='<table>';
	code +='<tr>';
	code +='<td width="82px" bgcolor="#00aff0">';
	code +='</td>';
	code +='<td style="font-size:16px">';
	code +='&nbsp;<!--#tr id="allow"-->Allow<!--#endtr-->';
	code +='</td>';
	code +='</tr>';
	code +='</table>';

	document.getElementById("SetTable").innerHTML = code;
	register_event();
}

function applyCheck() {
	var currentLanIP = document.getElementById("currentLanIP").value;
	var currentLanMask = document.getElementById("currentLanMask").value;

	if (document.getElementById("parental_macmode").value == "allow" && mac_filter_list.length==0) {
		Alert.render("<!--#tr id="lan.alert.26"-->MAC Filter: Allowed MAC is empty.<!--#endtr-->");
		document.pa.mac_address.focus();
		return false;
	}

	pre_submit();
	totalWaitTime = 25;
	redirectURL = ".." + location.pathname;
	wait_page();
	document.getElementById("waitPad").style.display="block";
	scroll(0,0);
	return true;
}

function ip_value()
{
	if (document.pa.client_ipaddr.options.selectedIndex != 0) {
		document.pa.ip_ip_start.value = document.pa.client_ipaddr.value;
	}
}

function mac_value()
{
	if (document.pa.client_macaddr.options.selectedIndex != 0) {
		document.pa.mac_address.value = document.pa.client_macaddr.value;
	}
}

function pre_submit()
{
	if (document.getElementById("filter_all_enable").options.selectedIndex == 1) {
		document.getElementById("filter_all_enable").value = "1";
		document.getElementById("filter_url_enable").value = "1";
		document.getElementById("filter_ip_enable").value = "1";		
	}	else {
		document.getElementById("filter_all_enable").value = "0";
		document.getElementById("filter_url_enable").value = "0";
		document.getElementById("filter_ip_enable").value = "0";		
	}
	
	pre_schedule_submit();
	pre_url_submit();
	pre_ip_submit();
	pre_mac_submit();
}

function change_mac_mode(mac_type) {
	if(mac_type == "0") {
		//mac allow
		document.getElementById("mac_deny").checked = false;
	} else {
		//mac deny
		document.getElementById("mac_allow").checked = false;
	}
}

function filter_sched_change() {
	document.getElementById("SetTable").innerHTML = "";
	schedule_editEntry = 0;
}

var filter_mode = "0";

function add_filter_table(F) {
	var i = 0;
	var j = 0;

	if(document.getElementById("SetTable").innerHTML != "") {
		if(add_table(F) == false)
			return false;
	}
	
	if (filter_mode == "0") { //add url table
		if(add_url_table(F) == false) {
			i = schedule_list.length - 1;
			j =  document.getElementById("filter_sched").length - 1;
			del_schedule(i);
			if(j != 0)
				document.getElementById("filter_sched").remove(j);
			return false;
		}
	}
	else { //add ip table
		if(add_ip_table(F) == false) {
			i = schedule_list.length - 1;
			j =  document.getElementById("filter_sched").length - 1;
			del_schedule(i);
			if(j != 0)
				document.getElementById("filter_sched").remove(j);
			return false;
		}
	}

	if (url_editEntry == 0 && ip_editEntry == 0) {
		var tbody = document.getElementById("summary_tableList").getElementsByTagName("TBODY")[0];
		for (j = tbody.rows.length; j > 1; j--) { 
			tbody.deleteRow(j - 1);
		}
		for (i = 0; i < url_filter_list.length; i++) {
			add_url_list(i);
		}
		for (i = 0; i < ip_filter_list.length; i++) {
			add_ip_list(i);
		}
	} 
	cancel_input();
}

function cancel_input() {
	var F = document.forms[0];
	document.getElementById("SetTable").innerHTML = "";
	schedule_editEntry = 0;

	cancel_url_input();
	cancel_ip_input();
		
	F.web_rule_enable.disabled = false;
	F.ip_rule_enable.disabled = false;
}

function change_fileter_mode(filter_type) {
	filter_mode = filter_type;
	if (filter_type == "0") { 
		//web url filter
		document.getElementById("url_option").style.display = style_display_on_tr();
		document.getElementById("ip_option").style.display = "none";
		document.getElementById("ip_ip_start").value = "";
		document.getElementById("web_rule_enable").checked = true;
		document.getElementById("ip_rule_enable").checked = false;
		
	} else { 
		//ip filter
		document.getElementById("url_option").style.display = "none";
		document.getElementById("ip_option").style.display = style_display_on_tr();
		document.getElementById("web_url").value = "";
		document.getElementById("web_rule_enable").checked = false;
		document.getElementById("ip_rule_enable").checked = true;
	}
}

function updateState() 
{
	if (document.getElementById("filter_all_enable").options.selectedIndex == 1) {
		document.getElementById("filter_all_enable").value = "1";
		document.getElementById("parental_rule").style.display = style_display_on();
		document.getElementById("set_rule_table").style.display = style_display_on();
		document.getElementById("filter_table").style.display = style_display_on();
		
		change_fileter_mode("0");
	} else {
		document.getElementById("filter_all_enable").value = "0";
		document.getElementById("parental_rule").style.display = "none";
		document.getElementById("SetTable").innerHTML = "";
		document.getElementById("set_rule_table").style.display = "none";
		document.getElementById("filter_table").style.display = "none";
	}
	
	if (document.pa.parental_macmode.options.selectedIndex == 0) {
		document.getElementById("mac_rule_table").style.display = "none";
		document.getElementById("mac_add_table").style.display = "none";
		document.getElementById("mac_display_table").style.display = "none";
	}
	else {
		document.getElementById("mac_rule_table").style.display = style_display_on();
		document.getElementById("mac_add_table").style.display = style_display_on();
		document.getElementById("mac_display_table").style.display = style_display_on();
	}
}

function init_sched_select()
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
		F.filter_sched.options.add(opt);
		i++;
	}
}

function init_sched_table()
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
}

function init_table()
{
	init_sched_table();
	init_url_table();
	init_ip_table();
	init_mac_table();
}


function page_load() {
	init_sched_select();
	init_table();
	updateState();
}
//-->
</script>
<!-- InstanceEndEditable -->
</head>
<body onload="template_load();">
<div id="waitPad" style="display: none;" ></div>
<div id="dialogoverlay" style="display: none;"></div>
<div id="dialogbox" style="display: none;">
<table class="tbl_main" style="color: #FFF;" width="420px">
	<tr>
		<td class="CT" height="20px"></td>
	</tr>
	<tr style="vertical-align: middle;">
		<td class="CR" style="background: #4F5158" align="center">
			<br><span id="dialogboxbody">&nbsp;</span><br><br>
			<span id="dialogboxfoot"></span>
		</td>
	</tr>
</table>
</div>
<div class="wrapper"> 
<table width="100%" border="0"  cellpadding="0" cellspacing="0" >
	<tr>
		<td class="header">
			<table width="100%" border="0" cellpadding="0" cellspacing="0">
				<tr>
					<td class="header_1">
						<table border="0" cellpadding="0" cellspacing="0"  style="position:relative;width:920px; top:8px;" class="maintable">
							<tr>
								<td  valign="top"><img src="../images/logo.png" ></td>
								<td align="right"  valign="middle" nowrap="nowrap" class="description" style="width:600px; line-height:1.5em">
									<!--#tr id="project.desc"-->AC1900 Dual Band Wireless Router<!--#endtr-->
									<br>
              						TEW-818DRU
								</td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
		</td>
	</tr>
	<tr>
		<td>
<div class="dialog" style="margin-left:auto; margin-right:auto">
<div style="background-color: transparent;background-attachment: scroll;background-image: url(../images/bg_main2.png); background-position: right top; height: 40px;"><div></div></div>
<div style="background-color: transparent;background-repeat: repeat-y;background-attachment: scroll;background-image: url(../images/bg_main2_overlay.png);  background-position: right top;">
<div class="t"></div>
			<!--START MAIN TABLE -->
			<table border="0" cellpadding="0" cellspacing="0"  style="width:940px;">
				<tr>
					<td valign="top">
						<!--START LEFT NAVIGATION -->
<script>
ddaccordion.init({ //top level headers initialization
	headerclass: "expandable", //Shared CSS class name of headers group that are expandable
	contentclass: "categoryitems", //Shared CSS class name of contents group
	revealtype: "click", //Reveal content when user clicks or onmouseover the header? Valid value: "click", "clickgo", or "mouseover"
	mouseoverdelay: 200, //if revealtype="mouseover", set delay in milliseconds before header expands onMouseover
	collapseprev: true, //Collapse previous content (so only one open at any time)? true/false 
	defaultexpanded: [], //index of content(s) open by default [index1, index2, etc]. [] denotes no content
	onemustopen: true, //Specify whether at least one header should be open always (so never all headers closed)
	animatedefault: true, //Should contents open by default be animated into view?
	persiststate: true, //persist state of opened contents within browser session?
	toggleclass: ["", "openheader"], //Two CSS classes to be applied to the header when it's collapsed and expanded, respectively ["class1", "class2"]
	togglehtml: ["src", "", ""], //Additional HTML added to the header when it's collapsed and expanded, respectively  ["position", "html1", "html2"] (see docs)
	animatespeed: 200, //speed of animation: integer in milliseconds (ie: 200), or keywords "fast", "normal", or "slow"
	oninit:function(headers, expandedindices){ //custom code to run when headers have initalized
	},
	onopenclose:function(header, index, state, isuseractivated){ //custom code to run whenever a header is opened or closed
	}
})

ddaccordion.init({ //top level headers initialization
	headerclass: "expandable2", //Shared CSS class name of headers group that are expandable
	contentclass: "categoryitems", //Shared CSS class name of contents group
	revealtype: "click", //Reveal content when user clicks or onmouseover the header? Valid value: "click", "clickgo", or "mouseover"
	mouseoverdelay: 200, //if revealtype="mouseover", set delay in milliseconds before header expands onMouseover
	collapseprev: true, //Collapse previous content (so only one open at any time)? true/false 
	defaultexpanded: [], //index of content(s) open by default [index1, index2, etc]. [] denotes no content
	onemustopen: true, //Specify whether at least one header should be open always (so never all headers closed)
	animatedefault: false, //Should contents open by default be animated into view?
	persiststate: true, //persist state of opened contents within browser session?
	toggleclass: ["", "openheader"], //Two CSS classes to be applied to the header when it's collapsed and expanded, respectively ["class1", "class2"]
	togglehtml: ["src", "", ""], //Additional HTML added to the header when it's collapsed and expanded, respectively  ["position", "html1", "html2"] (see docs)
	animatespeed: 200, //speed of animation: integer in milliseconds (ie: 200), or keywords "fast", "normal", or "slow"
	oninit:function(headers, expandedindices){ //custom code to run when headers have initalized
	},
	onopenclose:function(header, index, state, isuseractivated){ //custom code to run whenever a header is opened or closed
	}
})

jQuery(function(){
     $(".img-swap").hover(
          function(){this.src = this.src.replace("_0","_2");},
          function(){this.src = this.src.replace("_2","_0");
     });
});
</script>

<!-- InstanceParam name="img_folder" type="text" value="../images/" -->

<div class="arrowlistmenu" style="padding-top: 0px">
<script>
	if(dev_Wlmode != "psta") {
			document.write("<div class=\"homenav\" style=\"margin-bottom:20px\">"+
												"<a href=\"../basic/home.asp?expandable=0\"><img src=\"../images/but_basic_1<!--#tr id="image.lang.png"-->.png<!--#endtr-->\" style=\"float:left\" border=\"0\" /></a><a href=\"../adm/status.asp?expandable2=0\"><img src=\"../images/but_advance_0<!--#tr id="image.lang.png"-->.png<!--#endtr-->\" class=\"img-swap\" border=\"0\" /></a>"+
											"</div>"+
											"<div class=\"borderbottom\"> </div>"+
											"<div class=\"menuheader expandable\" onclick=\"location.href='../basic/home.asp'\" >"+
												"<img class=\"CatImage\" src=\"../images/but_network_status_0.png\" /><span class=\"CatTitle\" id=\"mainmenu_1\"><!--#tr id="basic.menu.networkstatus"-->Network Status<!--#endtr--></span>"+
											"</div>"+
											"<ul class=\"categoryitems\" >"+
												"<li style=\"display:none;\"></li>"+
											"</ul>"+
											"<div class=\"menuheader expandable\" onclick=\"location.href='../basic/wireless.asp?wl_unit=0'\">"+
												"<img class=\"CatImage\" src=\"../images/but_wireless_0.png\" /><span class=\"CatTitle\" id=\"mainmenu_2\"><!--#tr id="basic.menu.wireless"-->Wireless<!--#endtr--></span>"+
											"</div>"+
											"<ul class=\"categoryitems\" >"+
												"<li style=\"display:none;\"></li>"+
											"</ul>"+
											"<div class=\"menuheader expandable\" onclick=\"location.href='../basic/guestnetwork.asp?wl_unit=0.3'\">"+
												"<img class=\"CatImage\" src=\"../images/but_guest_network_0.png\" /><span class=\"CatTitle\" id=\"mainmenu_3\"><!--#tr id="basic.menu.guestnetwork"-->Guest Network<!--#endtr--></span>"+
											"</div>"+
											"<ul class=\"categoryitems\" >"+
												"<li style=\"display:none;\"></li>"+
											"</ul>"+
											"<div class=\"menuheader expandable\" onclick=\"location.href='../basic/parental.asp'\">"+
												"<img class=\"CatImage\" src=\"../images/but_parental_control_0.png\" /><span class=\"CatTitle\" id=\"mainmenu_4\"><!--#tr id="basic.menu.parental"-->Parental Control<!--#endtr--></span>"+
											"</div>"+
											"<ul class=\"categoryitems\" >"+
												"<li style=\"display:none;\"></li>"+
											"</ul>");
	}
	else{
			document.write("<div class=\"homenav\" style=\"margin-bottom:20px\">"+
												"<a href=\"../station/link_status.asp?expandable=0\"><img src=\"../images/but_basic_1<!--#tr id="image.lang.png"-->.png<!--#endtr-->\" style=\"float:left\" border=\"0\" /></a><a href=\"../adm/status.asp?expandable2=0\"><img src=\"../images/but_advance_0<!--#tr id="image.lang.png"-->.png<!--#endtr-->\" class=\"img-swap\" border=\"0\" /></a>"+
											"</div>"+
											"<div class=\"borderbottom\"> </div>"+
											"<div class=\"menuheader expandable\" onclick=\"location.href='../station/link_status.asp'\">"+
												"<img class=\"CatImage\" src=\"../images/but_wireless_0.png\" /><span class=\"CatTitle\" id=\"mainmenu_1\"><!--#tr id="basic.menu.wireless"-->Wireless<!--#endtr--></span>"+
											"</div>"+
											"<ul class=\"categoryitems\" >"+
												"<li><a onclick=\"location.href='../station/site_survey.asp'\"><!--#tr id="wireless.node.ss"-->Site Survey<!--#endtr--></a></li>"+
												"<li><a onclick=\"location.href='../station/wireless_basic.asp'\"><!--#tr id="wireless.node.bws"-->Manual Configuration<!--#endtr--></a></li>"+
												"<li><a onclick=\"location.href='../station/link_status.asp'\"><!--#tr id="wl.status"-->Link Status<!--#endtr--></a></li>"+
											"</ul>");
	}
</script>
</div>
						<!--END LEFT NAVIGATION --> 
<script type="text/javascript" src="../scripts/xpmenu.js"></script>
					</td>
					<td style="width:670px; padding: 10px 0px 0px 15px; " valign="top" class="txt_main">
<iframe class="rebootRedirect" name="rebootRedirect" id="rebootRedirect" frameborder="0" width="1" height="1" scrolling="no" src="" style="display:none">redirect</iframe>
<div id="waitform"></div>
<div id="mainform">
	<div id="main_content">
	<!-- InstanceBeginEditable name="Main Content" -->
<table class="body"><tr><td>
<h1><!--#tr id="basic.menu.parental"-->Parental Control<!--#endtr--></h1>
<div class="hr" ></div>
<p>
	<!--#tr id="parental.desc"-->Parental control settings allow you to set up restrictions/filters specifically who is allowed or denied access to your network for a specified period of time and restricted access to web content. Web URL filters allows you to block or restrict access to specific websites. IP/MAC filters allow you to restrict access to your network to wired or wireless computers and devices you specify by using the IP addresses (ex. 192.168.10.x) or MAC address (ex. a1:b2:c3:d4:e3:f5). You can check the MAC address or IP address of the computers and devices currently connected to your router under the <a href="../adm/clientstatus.asp">Advanced > Administrator > Client Status</a> page.<!--#endtr-->
</p>

<form method="post" name="pa" action="/uapply.cgi" onSubmit="return applyCheck();" target="rebootRedirect">
<input type="hidden" name="page" value="/basic/parental.asp">
<input type="hidden" name="token" value="<% genToken(); %>">
<input type="hidden" id="currentLanIP" value="<% nvram_get("lan_ipaddr"); %>" >
<input type="hidden" id="currentLanMask" value="<% nvram_get("lan_netmask"); %>" >

<table width="100%" class="tbl_main">
	<tr>
		<td class="CT" colspan="2"><!--#tr id="basic.menu.parental"-->Parental Control<!--#endtr--></td>
	</tr>
	<tr>
		<td class="CL"><!--#tr id="basic.parental.filter"-->Filter<!--#endtr--></td>
		<td class="CR">
			<select id="filter_all_enable" name="filter_all_enable" onChange="updateState()">
				<option value="0" <% nvram_match("filter_all_enable", "0", "selected"); %>><!--#tr id="disabled"-->Disabled<!--#endtr--></option>
				<option value="1" <% nvram_match("filter_all_enable", "1", "selected"); %>><!--#tr id="enabled"-->Enabled<!--#endtr--></option>
			</select>
		</td>
	</tr>
	<tr>
		<input type="hidden" name="filter_url_enable" id="filter_url_enable" value="">
		<input type="hidden" name="filter_url" id="filter_url" value="24">
		<input type="hidden" name="filter_ip_enable" id="filter_ip_enable" value="">
		<input type="hidden" name="filter_ip" id="filter_ip" value="24"> 
	</tr>
</table>

<table width="100%" class="tbl_main" id="parental_rule">
	<tr>
		<td class="CT" colspan="2"><!--#tr id="basic.parental.rule"-->Parental Control Rule<!--#endtr--></td>
	</tr>
	<tr>
		<td class="CL"><!--#tr id="active"-->Active<!--#endtr--></td>
		<td class="CR">
			<input name="checkenable" type="checkbox" onkeydown="return prevent_press_enter(event);">
		</td>
	</tr>
	<tr>
		<td class="CL"><!--#tr id="basic.parental.filter.type"-->Filter Type<!--#endtr--></td>
		<td class="CR">
	  	<input type="radio" name="web_rule_enable" id="web_rule_enable" value="0" onclick="change_fileter_mode(this.value)" onkeydown="return prevent_press_enter(event);" checked><!--#tr id="basic.parental.web"-->Web URL<!--#endtr-->
	  	<input type="radio" name="ip_rule_enable" id="ip_rule_enable" value="1" onclick="change_fileter_mode(this.value)" onkeydown="return prevent_press_enter(event);"><!--#tr id="ip"-->IP<!--#endtr-->
		</td>
	</tr>
	<tr id="url_option">
		<td class="CL"><!--#tr id="url"-->URL<!--#endtr--></td>
		<td class="CR">
			<input name="web_url" id="web_url" value="" size="32" maxlength="128" onkeydown="return prevent_press_enter(event);">
		</td>
	</tr>
	<tr id="ip_option">
		<td class="CL"><!--#tr id="ip.address"-->IP Address<!--#endtr--></td>
		<td class="CR">
			<input name="ip_ip_start" id="ip_ip_start" value="" size="15" maxlength="15" onkeydown="return prevent_press_enter(event);">&nbsp;<<&nbsp;
			<select id="client_ipaddr" name="client_ipaddr"  onchange=ip_value();>
				<option value="0"><!--#tr id="wi.28"-->Host Name<!--#endtr--></option>
				<% hostname(0, 0); %>
			</select>
		</td>
	</tr>
	<tr id="filter_schedule_tr">
		<td class="CL"><!--#tr id="schedule"-->Schedule<!--#endtr--></td>
		<td class="CR">
			<select name="filter_sched" id="filter_sched" onchange="filter_sched_change()">
				<option value="0" checked><!--#tr id="always"-->Always<!--#endtr--></option>
			</select>
			<input type="button" value="<!--#tr id="new.schedule"-->Add New<!--#endtr-->" onclick="open_parental_schedule()">
		</td>
	</tr>
</table>

<table width="100%" class="tbl_main" style="display:none">
	<tr>
		<td class="CT" colspan="2"><!--#tr id="schedule.rules"-->Schedule Rules<!--#endtr--></td>
	</tr>
	<tr>
		<td>
			<table width="100%" class="tbl_main2" id="tableList">
				<tbody>
					<tr>
						<input type="hidden" name="newschedule" id="schedule" value="16">
						<input type="hidden" name="schedule_uid" id="schedule_uid" value="<% nvram_get("schedule_uid"); %>">
					</tr>
			</tbody>
			</table>
		</td>
	</tr>
</table>

<div id="SetTable"></div>

<table width="100%" class="tbl_main" id="set_rule_table">
	<tr align="center">
		<td>
			<input type="button" class="<!--#tr id="buttonWidth"-->button1<!--#endtr-->" value="<!--#tr id="add"-->Add<!--#endtr-->" onclick="add_filter_table(this.form);">
			<input type="reset" class="button1" value="<!--#tr id="cancel"-->Cancel<!--#endtr-->" onclick="cancel_input();">
		</td>
	</tr>
</table>

<table width="100%" class="tbl_main" id="filter_table" style="display:none">
	<tr>
		<td class="CT" colspan="2"><!--#tr id="basic.parental.summary"-->Parental Control Summary<!--#endtr--></td>
	</tr>
	<tr>
		<td colspan="2">
			<table width="100%" class="tbl_main2" id="summary_tableList">
				<tbody>
					<tr>
						<td class="form_list_title" width="70%"><!--#tr id="basic.parental.filter.desc"-->Filter Description<!--#endtr--></td>
						<td class="form_list_title"><!--#tr id="schedule"-->Schedule<!--#endtr--></td>
						<td class="form_list_title"><!--#tr id="status.title"-->Status<!--#endtr--></td>
						<td class="form_list_title"><!--#tr id="remove"-->Remove<!--#endtr--></td>
						<td class="form_list_title"><!--#tr id="edit"-->Edit<!--#endtr--></td>
					</tr>
				</tbody>
			</table>
		</td>
	</tr>
</table>

<table width="100%" class="tbl_main" id="web_display_table" style="display:none">
	<tr>
		<td class="CT" colspan="2"><!--#tr id="basic.parental.urlfilter"-->Web URL Filter<!--#endtr--></td>
	</tr>
	<tr>
		<td colspan="2">
			<table width="100%" class="tbl_main2" id="web_tableList">
				<tbody>
					<tr>
						<td class="form_list_title" width="70%"><!--#tr id="url"-->URL<!--#endtr--></td>
						<td class="form_list_title"><!--#tr id="schedule"-->Schedule<!--#endtr--></td>
						<td class="form_list_title"><!--#tr id="enabled"-->Enabled<!--#endtr--></td>
						<td class="form_list_title"><!--#tr id="remove"-->Remove<!--#endtr--></td>
						<td class="form_list_title"><!--#tr id="edit"-->Edit<!--#endtr--></td>
					</tr>
				</tbody>
			</table>
		</td>
	</tr>
</table>



<table width="100%" class="tbl_main" id="ip_display_table" style="display:none">
	<tr>
		<td class="CT" colspan="2"><!--#tr id="basic.parental.ipfilter"-->IP Filter Rules<!--#endtr--></td>
	</tr>
	<tr>
		<td colspan="2">
			<table width="100%" class="tbl_main2" id="ip_tableList">
				<tbody>
					<tr>
						<td class="form_list_title" width="70%" colspan="3"><!--#tr id="ip.address"-->IP Address<!--#endtr--></td>
						<td class="form_list_title"><!--#tr id="schedule"-->Schedule<!--#endtr--></td>
						<td class="form_list_title"><!--#tr id="enabled"-->Enabled<!--#endtr--></td>
						<td class="form_list_title"><!--#tr id="remove"-->Remove<!--#endtr--></td>
						<td class="form_list_title"><!--#tr id="edit"-->Edit<!--#endtr--></td>
					</tr>
				</tbody>
			</table>
		</td>
	</tr>
</table>

<table width="100%" class="tbl_main">
	<tr>
		<td class="CT" colspan="2"><!--#tr id="basic.parental.macfilter"-->MAC Filters<!--#endtr--></td>
	</tr>

  <tr>
    <td class="CL"
	onMouseOver="return overlib('Selects whether clients with the specified MAC address are allowed or denied access to the router and the WAN.', LEFT);"
	onMouseOut="return nd();">
	<!--#tr id="basic.parental.macfilter.mode"-->MAC Filter Mode<!--#endtr-->
    </td>
    <td class="CR">
	<select name="parental_macmode" id="parental_macmode" onChange="updateState()">
	  <option value="disabled" <% nvram_match("filter_macmode", "disabled", "selected"); %>><!--#tr id="disabled"-->Disabled<!--#endtr--></option>
	  <option value="allow" <% nvram_match("filter_macmode", "allow", "selected"); %>><!--#tr id="allow"-->Allow<!--#endtr--></option>
	  <option value="deny" <% nvram_match("filter_macmode", "deny", "selected"); %>><!--#tr id="deny"-->Deny<!--#endtr--></option>
	</select>
	<input type="hidden" name="parental_maclist" id="parental_maclist" value="24">
	<input type="hidden" name="parental_macif" id="parental_macif" value="24">
    </td>
</table> 
<table width="100%" class="tbl_main" id="mac_rule_table" style="display:none">
	<tr>
		<td class="CT" colspan="2"><!--#tr id="macfilter.add.rule"-->Add MAC Filter Rule<!--#endtr--></td>
	</tr>
	<tr>
		<td class="CL"><!--#tr id="basic.parental.macfilter"-->MAC Filters<!--#endtr--></td>
		<td class="CR">
			<input name="mac_address" value="" size="17" maxlength="17" onkeydown="return prevent_press_enter(event);">&nbsp;<<&nbsp;
			<select id="client_macaddr" name="client_macaddr" onchange=mac_value();>
				<option value="0">Host Name</option>
				<% hostname(1, 1); %>
			</select>
		</td>
	</tr>
</table>

<table width="100%" class="tbl_main" id="mac_add_table" style="display:none">
	<tr align="center">
		<td>
			<input type="button" class="<!--#tr id="buttonWidth"-->button1<!--#endtr-->" value="<!--#tr id="add"-->Add<!--#endtr-->" onclick="add_mac_table(this.form);">
			<input type="reset" class="button1" value="<!--#tr id="cancel"-->Cancel<!--#endtr-->" onclick="cancel_mac_input();">
		</td>
	</tr>
</table>
 
<table width="100%" class="tbl_main" id="mac_display_table" style="display:none">
	<tr>
		<td class="CT" colspan="2"><!--#tr id="basic.parental.macfilter"-->MAC Filters<!--#endtr--></td>
	</tr>

	<tr>
		<td colspan="2">
			<table width="100%" class="tbl_main2" id="mac_tableList">
				<tbody>
					<tr>
						<td class="form_list_title" width="70%"><!--#tr id="basic.parental.macfilter"-->MAC Filters<!--#endtr--></td>
						<td class="form_list_title"><!--#tr id="remove"-->Remove<!--#endtr--></td>
						<td class="form_list_title"><!--#tr id="edit"-->Edit<!--#endtr--></td>
					</tr>
				</tbody>
			</table>
		</td>
	</tr>
</table>

<table width="100%" class="tbl_main" style="display:none">
	<tr>
		<td class="CT" colspan="2"><!--#tr id="filter.lan.mac.filter"-->LAN MAC Filters<!--#endtr--></td>
	</tr>

  <tr>
    <td class="CL"
	onMouseOver="return overlib('Selects whether clients with the specified MAC address are allowed or denied access to the router and the WAN.', LEFT);"
	onMouseOut="return nd();">
	<!--#tr id="filter.lan.mac.filter.mode"-->LAN MAC Filter Mode<!--#endtr-->
    </td>
    <td class="CR">
	<select name="filter_macmode" id="filter_macmode">
	  <option value="disabled" <% nvram_match("filter_macmode", "disabled", "selected"); %>><!--#tr id="disabled"-->Disabled<!--#endtr--></option>
	  <option value="allow" <% nvram_match("filter_macmode", "allow", "selected"); %>><!--#tr id="allow"-->Allow<!--#endtr--></option>
	  <option value="deny" <% nvram_match("filter_macmode", "deny", "selected"); %>><!--#tr id="deny"-->Deny<!--#endtr--></option>
	</select>
    </td>
  </tr>
  <tr>
    <td class="CL" valign="top" rowspan="16"
	onMouseOver="return overlib('Filter packets from LAN machines with the specified MAC addresses. The MAC address format is XX:XX:XX:XX:XX:XX.', LEFT);"
	onMouseOut="return nd();">
	<input type="hidden" name="filter_maclist" value="24">
	<!--#tr id="filter.lan.mac.filter"-->LAN MAC Filters<!--#endtr-->
    </td>
		<td class="CR">
			<table width="100%" class="tbl_main2" style="border-collapse: separate;">
				<tr>
					<td><input id="macFilter0" name="filter_maclist0" value="<% nvram_list("filter_maclist", 0); %>" size="17" maxlength="17"></td>
					<td><input id="macFilter1" name="filter_maclist1" value="<% nvram_list("filter_maclist", 1); %>" size="17" maxlength="17"></td>
					<td><input id="macFilter2" name="filter_maclist2" value="<% nvram_list("filter_maclist", 2); %>" size="17" maxlength="17"></td>
				</tr>
				<tr>
					<td><input id="macFilter3" name="filter_maclist3" value="<% nvram_list("filter_maclist", 3); %>" size="17" maxlength="17"></td>
					<td><input id="macFilter4" name="filter_maclist4" value="<% nvram_list("filter_maclist", 4); %>" size="17" maxlength="17"></td>
					<td><input id="macFilter5" name="filter_maclist5" value="<% nvram_list("filter_maclist", 5); %>" size="17" maxlength="17"></td>
				</tr>
				<tr>
					<td><input id="macFilter6" name="filter_maclist6" value="<% nvram_list("filter_maclist", 6); %>" size="17" maxlength="17"></td>
					<td><input id="macFilter7" name="filter_maclist7" value="<% nvram_list("filter_maclist", 7); %>" size="17" maxlength="17"></td>
					<td><input id="macFilter8" name="filter_maclist8" value="<% nvram_list("filter_maclist", 8); %>" size="17" maxlength="17"></td>
				</tr>
				<tr>
					<td><input id="macFilter9" name="filter_maclist9" value="<% nvram_list("filter_maclist", 9); %>" size="17" maxlength="17"></td>
					<td><input id="macFilter10" name="filter_maclist10" value="<% nvram_list("filter_maclist", 10); %>" size="17" maxlength="17"></td>
					<td><input id="macFilter11" name="filter_maclist11" value="<% nvram_list("filter_maclist", 11); %>" size="17" maxlength="17"></td>
				</tr>
				<tr>
					<td><input id="macFilter12" name="filter_maclist12" value="<% nvram_list("filter_maclist", 12); %>" size="17" maxlength="17"></td>
					<td><input id="macFilter13" name="filter_maclist13" value="<% nvram_list("filter_maclist", 13); %>" size="17" maxlength="17"></td>
					<td><input id="macFilter14" name="filter_maclist14" value="<% nvram_list("filter_maclist", 14); %>" size="17" maxlength="17"></td>
				</tr>
				<tr>
					<td><input id="macFilter15" name="filter_maclist15" value="<% nvram_list("filter_maclist", 15); %>" size="17" maxlength="17"></td>
					<td><input id="macFilter16" name="filter_maclist16" value="<% nvram_list("filter_maclist", 16); %>" size="17" maxlength="17"></td>
					<td><input id="macFilter17" name="filter_maclist17" value="<% nvram_list("filter_maclist", 17); %>" size="17" maxlength="17"></td>
				</tr>
				<tr>
					<td><input id="macFilter18" name="filter_maclist18" value="<% nvram_list("filter_maclist", 18); %>" size="17" maxlength="17"></td>
					<td><input id="macFilter19" name="filter_maclist19" value="<% nvram_list("filter_maclist", 19); %>" size="17" maxlength="17"></td>
					<td><input id="macFilter20" name="filter_maclist20" value="<% nvram_list("filter_maclist", 20); %>" size="17" maxlength="17"></td>
				</tr>
				<tr>
					<td><input id="macFilter21" name="filter_maclist21" value="<% nvram_list("filter_maclist", 21); %>" size="17" maxlength="17"></td>
					<td><input id="macFilter22" name="filter_maclist22" value="<% nvram_list("filter_maclist", 22); %>" size="17" maxlength="17"></td>
					<td><input id="macFilter23" name="filter_maclist23" value="<% nvram_list("filter_maclist", 23); %>" size="17" maxlength="17"></td>
				</tr>
			</table>
		</td>
	</tr>
</table>

<table width="100%" class="tbl_main" style="display:none">
	<tr>
		<td class="CT" colspan="4"><!--#tr id="security.44"-->Wireless MAC Filter<!--#endtr--></td>
	</tr>
	<tr>
		<td class="CL"
		onMouseOver="return overlib('Selects whether clients with the specified MAC address are allowed or denied wireless access.', LEFT);"
		onMouseOut="return nd();">
		<!--#tr id="security.41"-->Filter Mode<!--#endtr-->
		</td>
		<td class="CR" colspan="3">
			<select name="wl_macmode" id="wl_macmode">
				<option value="disabled" <% nvram_match("wl_macmode", "disabled", "selected"); %>><!--#tr id="disabled"-->Disabled<!--#endtr--></option>
				<option value="allow" <% nvram_match("wl_macmode", "allow", "selected"); %>><!--#tr id="allow"-->Allow<!--#endtr--></option>
				<option value="deny" <% nvram_match("wl_macmode", "deny", "selected"); %>><!--#tr id="deny"-->Deny<!--#endtr--></option>
			</select>
		</td>
	</tr>
	<tr>
		<td class="CL" valign="top" rowspan="16"
		onMouseOver="return overlib('Allows or denies wireless access to clients with the specified MAC addresses. The MAC address format is XX:XX:XX:XX:XX:XX.', LEFT);"
		onMouseOut="return nd();">
		<input type="hidden" name="wl_maclist" value="24">
		<!--#tr id="mac.address"-->MAC Address<!--#endtr-->
		</td>
		<td class="CR2"><input id="macAddressInput0" name="wl_maclist0" value="<% nvram_list("wl_maclist", 0); %>" size="17" maxlength="17"></td>
		<td class="CR2"><input id="macAddressInput1" name="wl_maclist1" value="<% nvram_list("wl_maclist", 1); %>" size="17" maxlength="17"></td>
		<td class="CR2"><input id="macAddressInput2" name="wl_maclist2" value="<% nvram_list("wl_maclist", 2); %>" size="17" maxlength="17"></td>
	</tr>
	<tr>
		<td class="CR2"><input id="macAddressInput3" name="wl_maclist3" value="<% nvram_list("wl_maclist", 3); %>" size="17" maxlength="17"></td>
		<td class="CR2"><input id="macAddressInput4" name="wl_maclist4" value="<% nvram_list("wl_maclist", 4); %>" size="17" maxlength="17"></td>
		<td class="CR2"><input id="macAddressInput5" name="wl_maclist5" value="<% nvram_list("wl_maclist", 5); %>" size="17" maxlength="17"></td>
	</tr>
	<tr>
		<td class="CR2"><input id="macAddressInput6" name="wl_maclist6" value="<% nvram_list("wl_maclist", 6); %>" size="17" maxlength="17"></td>
		<td class="CR2"><input id="macAddressInput7" name="wl_maclist7" value="<% nvram_list("wl_maclist", 7); %>" size="17" maxlength="17"></td>
		<td class="CR2"><input id="macAddressInput8" name="wl_maclist8" value="<% nvram_list("wl_maclist", 8); %>" size="17" maxlength="17"></td>
	</tr>
	<tr>
		<td class="CR2"><input id="macAddressInput9" name="wl_maclist9" value="<% nvram_list("wl_maclist", 9); %>" size="17" maxlength="17"></td>
		<td class="CR2"><input id="macAddressInput10" name="wl_maclist10" value="<% nvram_list("wl_maclist", 10); %>" size="17" maxlength="17"></td>
		<td class="CR2"><input id="macAddressInput11" name="wl_maclist11" value="<% nvram_list("wl_maclist", 11); %>" size="17" maxlength="17"></td>
	</tr>
	<tr>
		<td class="CR2"><input id="macAddressInput12" name="wl_maclist12" value="<% nvram_list("wl_maclist", 12); %>" size="17" maxlength="17"></td>
		<td class="CR2"><input id="macAddressInput13" name="wl_maclist13" value="<% nvram_list("wl_maclist", 13); %>" size="17" maxlength="17"></td>
		<td class="CR2"><input id="macAddressInput14" name="wl_maclist14" value="<% nvram_list("wl_maclist", 14); %>" size="17" maxlength="17"></td>
	</tr>
	<tr>
		<td class="CR2"><input id="macAddressInput15" name="wl_maclist15" value="<% nvram_list("wl_maclist", 15); %>" size="17" maxlength="17"></td>
		<td class="CR2"><input id="macAddressInput16" name="wl_maclist16" value="<% nvram_list("wl_maclist", 16); %>" size="17" maxlength="17"></td>
		<td class="CR2"><input id="macAddressInput17" name="wl_maclist17" value="<% nvram_list("wl_maclist", 17); %>" size="17" maxlength="17"></td>
	</tr>
	<tr>
		<td class="CR2"><input id="macAddressInput18" name="wl_maclist18" value="<% nvram_list("wl_maclist", 18); %>" size="17" maxlength="17"></td>
		<td class="CR2"><input id="macAddressInput19" name="wl_maclist19" value="<% nvram_list("wl_maclist", 19); %>" size="17" maxlength="17"></td>
		<td class="CR2"><input id="macAddressInput20" name="wl_maclist20" value="<% nvram_list("wl_maclist", 20); %>" size="17" maxlength="17"></td>
	</tr>
	<tr>
		<td class="CR2"><input id="macAddressInput21" name="wl_maclist21" value="<% nvram_list("wl_maclist", 21); %>" size="17" maxlength="17"></td>
		<td class="CR2"><input id="macAddressInput22" name="wl_maclist22" value="<% nvram_list("wl_maclist", 22); %>" size="17" maxlength="17"></td>
		<td class="CR2"><input id="macAddressInput23" name="wl_maclist23" value="<% nvram_list("wl_maclist", 23); %>" size="17" maxlength="17"></td>
	</tr>
</table>

<table width="100%" class="tbl_main">
    <tr align="center">
      <td>
		  <input type="submit" class="<!--#tr id="buttonWidth"-->button1<!--#endtr-->" name="action" value="<!--#tr id="apply"-->Apply<!--#endtr-->">
		  <input type="reset" class="button1" name="action" value="<!--#tr id="cancel"-->Cancel<!--#endtr-->" onClick="updateState()">
      </td>
    </tr>
</table>
</form>

</td></tr></table>
	<!-- InstanceEndEditable -->
	</div>
</div>
					</td>
				</tr>
			</table>
    		<!--END MAIN TABLE -->
</div>
<div style="background-color: transparent;background-attachment: scroll;background-image: url(../images/bg_main2.png); background-position: right bottom; height: 50px;"><div></div></div>
</div>
		</td>
	</tr>
</table>
</div>

<div class="footer" >
<table border="0" cellpadding="0" cellspacing="0"  style="position:static; width:940px; margin:20px auto 0px auto ">
    <tr>
		<td>
			<form method="post" name="Lang" action="/goform/setSysLang">
			<table border="0" cellpadding="2" cellspacing="2" summary="" align="center" style="display:none">
				<tr><td>
					<input type="hidden" name="token" value="<% genToken(); %>">
					<select name="langSelection" id="langSelection" onchange="doLangSet();">
					<option value="EN" selected="selected">English</option>
					<option value="DE">Deutsch</option>
					<option value="FR">French</option>
					<option value="ESP">Espanol</option>
					<option value="RU">Russian</option>
					</select>
					<input type="hidden" id="redirect_url" name="redirect_url" value="/" />
				</td></tr>
			</table>
			</form>
		</td>
		<td class="txt_footer">
			<!--#tr id="bottom.copyright"-->Copyright &copy; 2014 TRENDnet. All Rights Reserved.<!--#endtr-->
		</td>
		<td align="right" class="txt_footer">
			<img src="../images/icons_warranty_1.png"><a href="http://www.trendnet.com/register" target="_blank" style="margin: 0 0 0 10px;line-height:25px;vertical-align: top;"><!--#tr id="bottom.product.registration"-->Product Warranty Registration<!--#endtr--></a>&nbsp;&nbsp;&nbsp;
		</td>
	</tr>
</table>
</div>
</body>
<!-- InstanceEnd --></html>
