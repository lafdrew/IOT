<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en"><!-- InstanceBegin template="/Templates/advanced.dwt" codeOutsideHTMLIsLocked="false" -->
<head>
<meta http-equiv="content-type" content="text/html; charset=utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE8"/>

<title>TRENDnet | TEW-818DRU | <!--#tr id="project.desc"-->AC1900 Dual Band Wireless Router<!--#endtr--></title>
<!-- InstanceBeginEditable name="Page Title" -->

<!-- InstanceEndEditable -->

<link href="../style/frame.css" rel="stylesheet" type="text/css" media="screen" />
<link href="../style/style.css" rel="stylesheet" type="text/css" media="screen" />
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
<script type="text/javascript" src="../scripts/schedule.js"></script>
<script type="text/javascript" src="../scripts/jquery-ui.js"></script>

	<!-- InstanceEndEditable -->
<script language="JavaScript" type="text/javascript">
var langset = "<% nvram_get("Language"); %>";
var lang = (langset=="")? "EN":langset;
function doLangSet() {
	document.getElementById("redirect_url").value = location.pathname;
	document.Lang.submit();
}

var DosCotrolItme = "<% getDoSDefined(); %>";

function expand_path()
{
	//Expand menu by pathname
	var path = location.pathname;
	if(dev_Wlmode == "psta") {
		//Expand menu by pathname
		if (path.indexOf("/adm/") > -1)
			ddaccordion.expandone('expandable2', 0);
		if (path.indexOf("/internet/") > -1)
			ddaccordion.expandone('expandable2', 1);
	} else {
		if (path.indexOf("/adm/") > -1)
			ddaccordion.expandone('expandable2', 0);
		if (path.indexOf("/internet/") > -1)
			ddaccordion.expandone('expandable2', 1);
		if((path.indexOf("/wireless/") > -1 || path.indexOf("/wps/") > -1) && "<% nvram_invmatch("wl_unit_if", "1", "0"); %>" == "0")
			ddaccordion.expandone('expandable2', 2);
		if((path.indexOf("/wireless/") > -1 || path.indexOf("/wps/") > -1) && "<% nvram_invmatch("wl_unit_if", "0", "1"); %>" == "1")
			ddaccordion.expandone('expandable2', 3);
		if(path.indexOf("/advanced/") > -1) {
			if(path.indexOf("access_control.asp") > -1 || path.indexOf("filter.asp") > -1)
				ddaccordion.expandone('expandable2', 4);
			else
				ddaccordion.expandone('expandable2', 5);
		}
		if(path.indexOf("/usb/") > -1)
			ddaccordion.expandone('expandable2', 6);
	}
}

function menu_adjust() {
	if (lang=="DE") {
	} else	if (lang=="FR") {
	} else	if (lang=="ESP") {
	} else	if (lang=="RU") {
		if(dev_Wlmode != "psta")
			document.getElementById("mainmenu_3").style.margin = "-12px 0px 0px 5px";
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
	code +='<input type="hidden" name="ruleUid" value="">';
	code +='<tr><td class="CT" colspan="2"><!--#tr id="schedule.add.rules"-->Add Schedule Rule<!--#endtr--></td></tr>';
	code +='<tr><td class="CL"><!--#tr id="schedule.rule.name"-->Rule Name<!--#endtr--></td><td class="CR"><input name="addRuleName" value="" size="15" maxlength="15" onkeydown="return prevent_press_enter(event);"></td></tr>';	
	code +='<tr><td class="CL"><!--#tr id="time.format"-->Time Format<!--#endtr--></td><td class="CR">';
	code +='<select id="time_format" name="time_format" onchange="change_time_format(this.value);">';
	code += '<option value="0" >12 <!--#tr id="hours"-->Hours<!--#endtr--></option>';
	code += '<option value="1" >24 <!--#tr id="hours"-->Hours<!--#endtr--></option>';
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

function applyCheck()
{

	pre_submit();

	totalWaitTime = 25;
	wait_page();
	document.getElementById("waitPad").style.display="block";
	scroll(0,0);
	return true;
}

var time_format = "<% nvram_get("time_format"); %>";
function page_load() {

	init_array(schedule_array);
	settingTable();
	change_time_format(time_format);
	init_table();
}
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
			"<a href=\"../basic/home.asp?expandable=0\"><img src=\"../images/but_basic_0<!--#tr id="image.lang.png"-->.png<!--#endtr-->\" style=\"float:left\" class=\"img-swap\" border=\"0\" /></a><a href=\"../adm/status.asp?expandable2=0\"><img src=\"../images/but_advance_1<!--#tr id="image.lang.png"-->.png<!--#endtr-->\" border=\"0\" /></a>"+
			"</div>"+
			"<div class=\"borderbottom\"> </div>"+
			"<div class=\"menuheader expandable2\" onclick=\"location.href='../adm/status.asp'\"> <img class=\"CatImage\" src=\"../images/but_administrator_0.png\"><span class=\"CatTitle\" id=\"mainmenu_1\"><!--#tr id="administrator"-->Administrator<!--#endtr--></span></div>"+
			"<ul class=\"categoryitems\">"+
				"<li><a onclick=\"location.href='../adm/management.asp'\"><!--#tr id="adm.node.management"-->Management<!--#endtr--></a></li>"+
				"<li><a onclick=\"location.href='../adm/upload_firmware.asp'\"><!--#tr id="adm.node.upload"-->Upload Firmware<!--#endtr--></a></li>"+
				"<li><a onclick=\"location.href='../adm/settings.asp'\"><!--#tr id="adm.node.settings"-->Settings Management<!--#endtr--></a></li>"+
				"<li><a onclick=\"location.href='../adm/time.asp'\"><!--#tr id="adm.node.time"-->Time<!--#endtr--></a></li>"+
				"<li><a onclick=\"location.href='../adm/schedule.asp'\"><!--#tr id="adv.node.schedule"-->Schedule<!--#endtr--></a></li>"+
				"<li><a onclick=\"location.href='../adm/status.asp'\"><!--#tr id="adm.node.routerstatus"-->Router Status<!--#endtr--></a></li>"+
				"<li><a onclick=\"location.href='../adm/ipv6status.asp'\"><!--#tr id="adm.node.ipv6.status"-->IPv6 Status<!--#endtr--></a></li>"+
				"<li><a onclick=\"location.href='../adm/syslog.asp'\"><!--#tr id="adm.node.system.log"-->System Log<!--#endtr--></a></li>"+
				"<li><a onclick=\"location.href='../adm/network.asp'\"><!--#tr id="adv.node.network"-->Advanced Network<!--#endtr--></a></li>"+
				"<li><a onclick=\"location.href='../adm/clientstatus.asp'\"><!--#tr id="adm.node.clientstatus"-->Client Status<!--#endtr--></a></li>"+
				"<li><a onclick=\"location.href='../adm/devicemode.asp'\"><!--#tr id="adm.node.devicemode"-->Device Mode<!--#endtr--></a></li>"+
			"</ul>"+
			"<div class=\"menuheader expandable2\" onclick=\"location.href='../internet/lan.asp'\"><img class=\"CatImage\" src=\"../images/but_setup_0.png\"><span class=\"CatTitle\" id=\"mainmenu_2\"><!--#tr id="setup"-->Setup<!--#endtr--></span></div>"+
			"<ul class=\"categoryitems\">"+
				"<li><a onclick=\"location.href='../internet/lan.asp'\"><!--#tr id="net.node.lan"-->LAN<!--#endtr--></a></li>"+
				"<li><a onclick=\"location.href='../internet/wan.asp'\"><!--#tr id="net.node.wan"-->WAN<!--#endtr--></a></li>"+
				"<li><a onclick=\"location.href='../internet/routing.asp'\"><!--#tr id="adv.node.routing"-->Routing<!--#endtr--></a></li>"+
				"<li><a onclick=\"location.href='../internet/ipv6.asp'\"><!--#tr id="net.node.ipv6"-->IPv6<!--#endtr--></a></li>"+
				"<li><a onclick=\"location.href='../internet/qos.asp'\"><!--#tr id="net.node.qos"-->QoS<!--#endtr--></a></li>"+
				"<li><a onclick=\"location.href='../wizard/wizard_internet.asp'\"><!--#tr id="wizard.node"-->Wizard<!--#endtr--></a></li>"+
				"<li><a onclick=\"location.href='../internet/vlan.asp'\"><!--#tr id="net.node.vlan"-->VLAN<!--#endtr--></a></li>"+
			"</ul>"+

			"<div class=\"menuheader expandable2\" onclick=\"location.href='../wireless/multissid.asp?wl_unit=0.1'\"> <img class=\"CatImage\" src=\"../images/but_wireless_24_0<!--#tr id="image.lang.png"-->.png<!--#endtr-->\"><span class=\"CatTitle\" id=\"mainmenu_3\"><!--#tr id="wireless.24g"-->Wireless 2.4GHz<!--#endtr--></span></div> "+
			"<ul class=\"categoryitems\">"+
				"<li><a onclick=\"location.href='../wireless/multissid.asp?wl_unit=0.1'\"><!--#tr id="wireless.node.multissid"-->Multiple SSID<!--#endtr--></a></li>"+
				"<li><a onclick=\"location.href='../wireless/wds.asp?wl_unit=0'\"><!--#tr id="wireless.node.wds"-->WDS<!--#endtr--></a></li>"+
				"<li><a onclick=\"location.href='../wireless/advanced.asp?wl_unit=0'\"><!--#tr id="wireless.node.adv"-->Advanced<!--#endtr--></a></li>"+
				"<li><a onclick=\"location.href='../wps/wps.asp?wl_unit=0'\"><!--#tr id="wireless.node.wps"-->WPS<!--#endtr--></a></li>"+
			"</ul>"+

			"<div class=\"menuheader expandable2\" onclick=\"location.href='../wireless/multissid.asp?wl_unit=1.1'\"> <img class=\"CatImage\" src=\"../images/but_wireless_5_0<!--#tr id="image.lang.png"-->.png<!--#endtr-->\"><span class=\"CatTitle\" id=\"mainmenu_4\"><!--#tr id="wireless.5g"-->Wireless 5GHz<!--#endtr--></span></div>"+ 
			"<ul class=\"categoryitems\">"+
				"<li><a onclick=\"location.href='../wireless/multissid.asp?wl_unit=1.1'\"><!--#tr id="wireless.node.multissid"-->Multiple SSID<!--#endtr--></a></li>"+
				"<li><a onclick=\"location.href='../wireless/wds.asp?wl_unit=1'\"><!--#tr id="wireless.node.wds"-->WDS<!--#endtr--></a></li>"+
				"<li><a onclick=\"location.href='../wireless/advanced.asp?wl_unit=1'\"><!--#tr id="wireless.node.adv"-->Advanced<!--#endtr--></a></li>"+
				"<li><a onclick=\"location.href='../wps/wps.asp?wl_unit=1'\"><!--#tr id="wireless.node.wps"-->WPS<!--#endtr--></a></li>"+
			"</ul>"+

			"<div class=\"menuheader expandable2\" onclick=\"location.href='../advanced/access_control.asp'\"> <img class=\"CatImage\" src=\"../images/but_security_0.png\"><span class=\"CatTitle\" id=\"mainmenu_5\"><!--#tr id="security"-->Security<!--#endtr--></span></div> "+
			"<ul class=\"categoryitems\">"+
				"<li><a onclick=\"location.href='../advanced/access_control.asp'\"><!--#tr id="adv.node.ac"-->Access Control<!--#endtr--></a></li>"+
			"</ul>"+

			"<div class=\"menuheader expandable2\" onclick=\"location.href='../advanced/dmz.asp'\"> <img class=\"CatImage\" src=\"../images/but_firewall_0.png\"><span class=\"CatTitle\" id=\"mainmenu_6\"><!--#tr id="firewall"-->Firewall<!--#endtr--></span></div>"+
			"<ul class=\"categoryitems\">"+
				"<li><a onclick=\"location.href='../advanced/dmz.asp'\"><!--#tr id="adv.node.dmz"-->DMZ<!--#endtr--></a></li>"+
				"<li><a onclick=\"location.href='../advanced/single_port.asp'\"><!--#tr id="adv.node.virtual.rules"-->Virtual Server<!--#endtr--></a></li>"+
				"<li><a onclick=\"location.href='../advanced/port_trigger.asp'\"><!--#tr id="adv.node.special.app"-->Special Applications<!--#endtr--></a></li>"+
				"<li><a onclick=\"location.href='../advanced/port_range.asp'\"><!--#tr id="adv.node.gaming"-->Gaming<!--#endtr--></a></li>"+
				"<li><a onclick=\"location.href='../advanced/alg.asp'\"><!--#tr id="adv.node.alg"-->ALG<!--#endtr--></a></li>"+
			"</ul>"+

			"<div class=\"menuheader expandable2\" onclick=\"location.href='../usb/samba.asp'\"> <img class=\"CatImage\" src=\"../images/but_usb_0.png\"><span class=\"CatTitle\" id=\"mainmenu_7\"><!--#tr id="usb"-->USB<!--#endtr--></span></div>"+
			"<ul class=\"categoryitems\">"+
				"<li><a onclick=\"location.href='../usb/samba.asp'\"><!--#tr id="usb.node.samba"-->Samba Server<!--#endtr--></a></li>"+
				"<li><a onclick=\"location.href='../usb/ftp.asp'\"><!--#tr id="usb.node.ftp"-->FTP Server<!--#endtr--></a></li>"+
				"<li><a onclick=\"location.href='../usb/ejectdevice.asp'\"><!--#tr id="usb.node.eject.device"-->Eject Device<!--#endtr--></a></li>"+
				"</ul>");
		}
		else {
			document.write("<div class=\"homenav\" style=\"margin-bottom:20px\">"+
													"<a href=\"../station/link_status.asp?expandable=0\"><img src=\"../images/but_basic_0<!--#tr id="image.lang.png"-->.png<!--#endtr-->\" style=\"float:left\" class=\"img-swap\" border=\"0\" /></a><a href=\"../adm/status.asp?expandable2=0\"><img src=\"../images/but_advance_1<!--#tr id="image.lang.png"-->.png<!--#endtr-->\" border=\"0\" /></a>"+
											"</div>"+
											"<div class=\"borderbottom\"> </div>"+
											"<div class=\"menuheader expandable2\" onclick=\"location.href='../adm/status.asp'\"> <img class=\"CatImage\" src=\"../images/but_administrator_0.png\"><span class=\"CatTitle\" id=\"mainmenu_1\"><!--#tr id="administrator"-->Administrator<!--#endtr--></span></div>"+
											"<ul class=\"categoryitems\">"+
													"<li><a onclick=\"location.href='../adm/management.asp'\"><!--#tr id="adm.node.management"-->Management<!--#endtr--></a></li>"+
													"<li><a onclick=\"location.href='../adm/upload_firmware.asp'\"><!--#tr id="adm.node.upload"-->Upload Firmware<!--#endtr--></a></li>"+
													"<li><a onclick=\"location.href='../adm/settings.asp'\"><!--#tr id="adm.node.settings"-->Settings Management<!--#endtr--></a></li>"+
													"<li><a onclick=\"location.href='../adm/time.asp'\"><!--#tr id="adm.node.time"-->Time<!--#endtr--></a></li>"+
													"<li><a onclick=\"location.href='../adm/status.asp'\"><!--#tr id="adm.node.routerstatus"-->Router Status<!--#endtr--></a></li>"+
													"<li><a onclick=\"location.href='../adm/syslog.asp'\"><!--#tr id="adm.node.system.log"-->System Log<!--#endtr--></a></li>"+
													"<li><a onclick=\"location.href='../adm/devicemode.asp'\"><!--#tr id="adm.node.devicemode"-->Device Mode<!--#endtr--></a></li>"+
											"</ul>"+
											"<div class=\"menuheader expandable2\" onclick=\"location.href='../internet/lan.asp'\"><img class=\"CatImage\" src=\"../images/but_setup_0.png\"><span class=\"CatTitle\" id=\"mainmenu_2\"><!--#tr id="setup"-->Setup<!--#endtr--></span></div>"+
											"<ul class=\"categoryitems\">"+
													"<li><a onclick=\"location.href='../internet/lan.asp'\"><!--#tr id="net.node.lan"-->LAN<!--#endtr--></a></li>"+
											"</ul>");
		}
	</script>
</div>
						<!--END LEFT NAVIGATION --> 
<script type="text/javascript" src="../scripts/xpmenu.js"></script>
					</td>
					<td style="width:650px; padding: 10px 0px 0px 15px; " valign="top" class="txt_main">
<iframe class="rebootRedirect" name="rebootRedirect" id="rebootRedirect" frameborder="0" width="1" height="1" scrolling="no" src="" style="display:none">redirect</iframe>
<div id="waitform"></div>
<div id="mainform">
	<div id="main_content">
	<!-- InstanceBeginEditable name="Main Content" -->
<table class="body"><tr><td>
<h1><!--#tr id="schedule.title"-->Schedule<!--#endtr--></h1>
<div class="hr" ></div>
<p>
<!--#tr id="schedule.desc"-->Define schedule rules for various firewall features.<!--#endtr-->
</p>

<form method="post" name="schedule_form" action="/uapply.cgi" onSubmit="return applyCheck();" target="rebootRedirect">
<input type="hidden" name="page" value="/adm/schedule.asp">
<input type="hidden" name="token" value="<% genToken(); %>">

<div id="SetTable"></div>

<table width="100%" class="tbl_main">
	<tr align="center">
		<td>
			<input type="button" class="<!--#tr id="buttonWidth"-->button1<!--#endtr-->" value="<!--#tr id="add"-->Add<!--#endtr-->" onclick="add_table(this.form);">
			<input type="reset" class="button1" value="<!--#tr id="cancel"-->Cancel<!--#endtr-->" onclick="cancel_input(this.form);">
		</td>
	</tr>
</table>

<table width="100%" class="tbl_main">
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
						<td class="form_list_title"><!--#tr id="schedule.rule.name"-->Rule Name<!--#endtr--></td>
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
		<td class="CT" colspan="2">ALL Rules</td>
	</tr>
	<tr>
		<td>
			<table width="100%" class="tbl_main2" id="alltableList">
				<tbody>
					<tr>
						<input type="hidden" name="wl_s_change" id="wl_s_change" value="<% nvram_get("wl_schedule"); %>">
						<input type="hidden" name="wl_s_change0_0" id="wl_s_change0_0" value="<% nvram_get("wl0_schedule"); %>">
						<input type="hidden" name="wl_s_change0_1" id="wl_s_change0_1" value="<% nvram_get("wl0.1_schedule"); %>">
						<input type="hidden" name="wl_s_change0_2" id="wl_s_change0_2" value="<% nvram_get("wl0.2_schedule"); %>">
						<input type="hidden" name="wl_s_change0_3" id="wl_s_change0_3" value="<% nvram_get("wl0.3_schedule"); %>">
						<input type="hidden" name="wl_s_change1_0" id="wl_s_change1_0" value="<% nvram_get("wl1_schedule"); %>">
						<input type="hidden" name="wl_s_change1_1" id="wl_s_change1_1" value="<% nvram_get("wl1.1_schedule"); %>">
						<input type="hidden" name="wl_s_change1_2" id="wl_s_change1_2" value="<% nvram_get("wl1.2_schedule"); %>">
						<input type="hidden" name="wl_s_change1_3" id="wl_s_change1_3" value="<% nvram_get("wl1.3_schedule"); %>">
						<input type="hidden" name="wl_s_change2_0" id="wl_s_change2_0" value="<% nvram_get("wl2_schedule"); %>">
						<input type="hidden" name="wl_s_change2_1" id="wl_s_change2_1" value="<% nvram_get("wl2.1_schedule"); %>">
						<input type="hidden" name="wl_s_change2_2" id="wl_s_change2_2" value="<% nvram_get("wl2.2_schedule"); %>">
						<input type="hidden" name="wl_s_change2_3" id="wl_s_change2_3" value="<% nvram_get("wl2.3_schedule"); %>">
						<input type="hidden" name="filter_url" id="filter_url" value="24">
						<input type="hidden" name="filter_ip" id="filter_ip" value="24"> 
						<input type="hidden" name="filter_client" id="filter_client" value="24">
						<input type="hidden" name="forward_port" id="forward_port" value="24">
						<input type="hidden" name="autofw_port" id="autofw_port" value="24">
						<input type="hidden" name="port_range" id="port_range" value="24">
						<input type="hidden" name="schedule_change" id="schedule_change" value="0">
					</tr>
          			</tbody>
			</table>
		</td>
	</tr>
</table>

<table width="100%" class="tbl_main">
	<tr align="center">
		<td>
			<input type="submit" class="button1" name="action" value="<!--#tr id="apply"-->Apply<!--#endtr-->">
			<input type="reset" class="button1" name="action" value="<!--#tr id="cancel"-->Cancel<!--#endtr-->" onclick="window.location.reload()">
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
