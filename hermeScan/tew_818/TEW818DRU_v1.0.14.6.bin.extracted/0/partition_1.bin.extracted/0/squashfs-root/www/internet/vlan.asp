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
	</style>
	<!-- InstanceEndEditable -->

<script type="text/javascript" src="../scripts/jquery.min.js"></script>
<script type="text/javascript" src="../scripts/ddaccordion.js"></script>
<script type="text/javascript" src="../scripts/um.js?20120904<% nvram_get("Language"); %>"></script>
<script type="text/javascript" src="../scripts/func.js?20120904<% nvram_get("Language"); %>"></script>
<script type="text/javascript" src="../scripts/overlib.js"></script>
<!-- InstanceBeginEditable name="Include Files" -->

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
<!--
var VlanList = new Array();
var WanPort = "<% get_wan_port(); %>";
var PortCount = "<% get_port_number(); %>";
var act = "0";
var rec_index = 0;

function assemble_vlan(){
	var str = "";
	var wan_tag;
	var i, j;

// for default internet
	if(document.getElementById("wan_en").checked == true){
		str = "1%";
	} else {
		str = "0%";
	}

	str += document.getElementById("wan_vid").value + "%";

	for(i=0; i<PortCount; i++){
		if(i != WanPort){
			str += "2%";
		} else {
			if(document.getElementById("wan_tag").checked == true){
				str += "1%";
			} else {
				str += "0%";
			}
		}
	}

	str = str.substring(0,str.length - 1);
	str += "|";

// for VLAN
	for(i=1;i<VlanList.length; i++){
		str += VlanList[i].en + "%";
		str += VlanList[i].vid + "%";
		//port0%port1%port2%port3%port4%
/*		for(j=0; j<PortCount; j++){
			str += VlanList[i].port[j] + "%";
		}
		str = str.substring(0,str.length - 1);
		str += "|";
*/
		for(j=3; j>=0; j--){
			str += VlanList[i].port[j] + "%";
		}
		str += VlanList[i].port[WanPort] + "|";
	}
	str = str.substring(0,str.length - 1);

	document.vlan.vlan_set.value = str;
	//alert(document.vlan.vlan_set.value);
}
		
function check_vid_type(val, type){
	if(type == "wan"){
		if(document.getElementById("wan_en").checked == true){
			if(val == ""){
				Alert.render("<!--#tr id="vlan.alert.1"-->The VLAN ID for the default internet cannot be null or empty.<!--#endtr-->");
				return false;
			}
		}

		if(val.search(/^-?[0-9]+$/) != 0 && val != ""){
			Alert.render("<!--#tr id="vlan.alert.2"-->VLAN id does not integer.<!--#endtr-->");
			return false;
		}
	} else {
		if(val.search(/^-?[0-9]+$/) != 0){
			Alert.render("<!--#tr id="vlan.alert.2"-->VLAN id does not integer.<!--#endtr-->");
			return false;
		}
	}
	return true;
}

function check_vid_range(val, type){
	if(type == "wan"){
		if (val != "" && (val < 3 || val > 4094)){
			Alert.render("<!--#tr id="vlan.alert.3"-->VLAN id only support 3~4094.<!--#endtr-->");
			return false;
		}
	} else {
		if (val < 3 || val > 4094){
			Alert.render("<!--#tr id="vlan.alert.3"-->VLAN id only support 3~4094.<!--#endtr-->");
			return false;
		}
	}

	return true;
}

function compare_wan_vid(val){
	if(val == document.getElementById("wan_vid").value){
		Alert.render("<!--#tr id="vlan.alert.4"-->This VID has been used.<!--#endtr-->");
		return false;
	}
	return true;
}

function compare_vlanlist_vid(filter_index, val, start){
	var i=0;

	for(i=start; i<VlanList.length; i++){
		if(i != filter_index){
			if(val == VlanList[i].vid){
				Alert.render("<!--#tr id="vlan.alert.4"-->This VID has been used.<!--#endtr-->");
				return false;
			}
		}
	}
	return true;
}

function check_vid_duplicate(filter, val, type){
	var i;

	if(type != "wan"){
		if(!compare_wan_vid(val)){
			return false;
		}
	}

	if(compare_vlanlist_vid(filter, val, 1)){
		return true;
	}

	return false;
}

function check_vid(filter, val, type){
	if(check_vid_type(val, type)){
		if(check_vid_range(val, type)){
			if(check_vid_duplicate(filter, val, type)){
				return true;
			}
		}
	}

	return false;
}
		
function compare_wan_untag(type){
	var en = document.getElementById("wan_en").checked;
	var tag;
	if(en == true){
		tag = document.getElementById("wan_tag").checked;
	} else {
		tag = false;
	}
	if(tag != true){
		Alert.render("<!--#tr id="vlan.alert.6"-->A port can only be assigned to a VLAN ID when it is in untagged state.<!--#endtr-->");
		return false;
	}
	return true;
}

function check_untag(filter_index, type, port_num, start){
	var i;
	if(type == "vlan" && port_num == WanPort){
		if(!compare_wan_untag(type)){
			return false;
		}
	}

	for(i=start; i<VlanList.length; i++){
		if(filter_index != i){
			if(VlanList[i].port[port_num] == "0"){
				Alert.render("<!--#tr id="vlan.alert.6"-->A port can only be assigned to a VLAN ID when it is in untagged state.<!--#endtr-->");
				return false;
			}
		}
	}

	return true;
}

function check_lan_untag(filter, type){
	var i, name;
	for(i=0; i<PortCount ;i++){
		if(i != WanPort){
			name = "port_" + (i+1);
		}else{
			name = "wanPort";
		}
		if(document.getElementById(name).selectedIndex == 0){
			if(!check_untag(filter, type, i, 1)){
				return false;
			}
		}
	}
	return true;
}

function check_default_internet(){
	var vid = document.getElementById("wan_vid").value;
	var en = document.getElementById("wan_en").checked;
	var tag;
	if(check_vid(rec_index, vid, "wan")){
		if(en == true){
			tag = document.getElementById("wan_tag").checked;
		} else {
			tag = false;
		}
		if (tag == false){
			if(check_untag(rec_index, "wan", WanPort, 1)){
				return true;
			}
		} else {
			return true;
		}
	}
	return false;
}
	
function check_all_vlan(){
	var i, j;

	for(i=1; i<VlanList.length; i++){
		if(check_vid(i, VlanList[i].vid, "vlan")){
			for(j=0; j<PortCount ;j++){
				if(VlanList[i].port[j] == 0){
					if (!check_untag(i, "vlan", j, i+1)){
						return false;
					}
				}
			}
		} else {
			return false;
		}
		
	}
	return true;
}

function checkVLAN()
{
	if(check_default_internet()){
		if(check_all_vlan()){
			assemble_vlan();
//			redirectURL = internalIPElement.value + location.pathname;
			totalWaitTime = 30;
			wait_page();
			document.getElementById("waitPad").style.display="block";
			scroll(0,0);
			return true;
		}
	}
	return false;
}

function VlanEntry(enable,vid,port0,port1,port2,port3,port4){
	var port = Array(port0,port1,port2,port3,port4);

	this.en = enable;
	this.vid = vid;
	this.port = port;
}

function edit(index){
	var i;
	var name;

	if(VlanList[index].en == "1"){
		document.getElementById("enable").checked = true;
	} else {
		document.getElementById("enable").checked = false;
	}
	document.getElementById("vid").value = VlanList[index].vid;
	for(i=0; i<PortCount; i++){
		if(i != WanPort){
			name = "port_" + (i+1);
		}else{
			name = "wanPort";
		}
		document.getElementById(name).selectedIndex = VlanList[index].port[i];
	}
	document.getElementById("vlanact").value = "<!--#tr id="edit"-->Edit<!--#endtr-->";
	rec_index = index;
	act = "1";
}

function show_all_row(){
	var i;

	for(i=1; i<VlanList.length; i++)
	{	
		addtoList(i);
	}
}

function del_all_row(){
	var table = document.getElementById("tabList").getElementsByTagName("TBODY")[0];
	var i;
	for(i = table.rows.length; i > 1;i--)
	{
		table.deleteRow(i -1);
	}
}

function check_record_count(){
	if(VlanList.length >= 6){
		Alert.render("<!--#tr id="vlan.alert.5"-->The maximum VLAN number is 5.<!--#endtr-->");
		return false;
	} else {
		return true;
	}

}

function add_edit(){
	var enable, vid;
	var port = new Array();
	var i;

	if(act != 1){
		if(!check_record_count()){
			return false;
		}
	}

	if(document.getElementById("enable").checked == true)
		enable = "1";
	else
		enable = "0";

	vid = document.getElementById("vid").value;

	for(i=0; i<PortCount; i++){
		if(i != WanPort){
			name = "port_" + (i+1);
		}else{
			name = "wanPort";
		}
		port[i] = document.getElementById(name).value;
	}

	if(check_vid(rec_index, vid, "vlan")){
		if (check_lan_untag(rec_index, "vlan")){
			if (act != 1){
				rec_index = VlanList.length;
			}
			VlanList[rec_index] = new VlanEntry(enable, vid, port[0], port[1], port[2], port[3], port[4]);
			del_all_row();
			show_all_row();
			rec_index = VlanList.length;
			document.getElementById("enable").checked = false;
			document.getElementById("vid").value = "";
			for(i=0; i<PortCount; i++){
				if(i != WanPort){
					name = "port_" + (i+1);
				}else{
					name = "wanPort";
				}
				document.getElementById(name).selectedIndex = 2;
			}
			document.getElementById("vlanact").value = "<!--#tr id="add"-->Add<!--#endtr-->";
			document.getElementById("enable").checked = true;
			act = 0;
		}
	}
}

function del(idx){
	var table = document.getElementById("tabList").getElementsByTagName("TBODY")[0];
	var i;

	for (i=idx; i<VlanList.length-1 ;i++){
		VlanList[i] = VlanList[i+1];
	}

	VlanList.length = VlanList.length - 1;

	del_all_row();
	show_all_row();
}

function change_en(index, obj){
	if(obj.checked == true)
		VlanList[index].en = "1";
	else
		VlanList[index].en = "0";
}

function showvalue(type, value, index){
	var str = "";
	switch(type){
		case "enable" :
			if ( value == "1" )
				//str = "<input type=checkbox checked disabled>";
				str = "<input type=checkbox checked onclick=\"change_en("+ index +", this)\">";
			else
//				str = "<input type=checkbox disabled>";
				str = "<input type=checkbox onclick=\"change_en(" + index + ", this)\">";
			break;
		default : 
			if(index != WanPort) {
				str = "<!--#tr id="vlan.port"-->Port<!--#endtr--> " + (index+1);
			} else {
				str = "<!--#tr id="vlan.internet"-->WAN Port<!--#endtr-->";
			}
			switch(value){
				case "0" :
					str += "(U),";
					break;
				case "1" :
					str += "(T),";
					break;
				default:
					str = "";
			}
			break;
	}
	
	return str;
}

function addtoList(idx) {
	var table = document.getElementById("tabList").getElementsByTagName("TBODY")[0];
	var row = document.createElement("tr");
	var tdArray = new Array();
	var str = "", i;
	
	//create td
	row.setAttribute("id",idx);
	for(i=0; i<5; i++) {
		tdArray[i] = document.createElement("td");
		tdArray[i].setAttribute("class", "form_list_content");
	}
	
	//set td Text
	//Enable
	tdArray[0].innerHTML = showvalue("enable", VlanList[idx].en, idx);
	//VID
	tdArray[1].innerHTML = VlanList[idx].vid;
	//Member
	for(i=0; i<PortCount; i++){
		str += showvalue("port", VlanList[idx].port[i], i);
	}
	str = str.substring(0,str.length - 1);
	tdArray[2].innerHTML = str;

	//remove
	var Del = document.createElement("input");
	Del.setAttribute("type", "button");
	Del.setAttribute("value","<!--#tr id="remove"-->Remove<!--#endtr-->");
	Del.setAttribute("class","button3");
	Del.onclick = function(){ del(idx)};
	tdArray[3].appendChild(Del);

	//delete
	var Edit = document.createElement("input");
	Edit.setAttribute("type", "button");
	Edit.setAttribute("value", "<!--#tr id="edit"-->Edit<!--#endtr-->");
	Edit.setAttribute("class","button3");
	Edit.onclick = function(){ edit(idx)};
	tdArray[4].appendChild(Edit);	

	//obj append to table	
	for(i=0; i<5; i++) row.appendChild(tdArray[i]);
	table.appendChild(row);
}

function parseData(data){
	var i ;
	var data_ary = data.split("|");
	var item_ary = new Array();

	if (data != ""){
		for (i = 0; i < data_ary.length; i++){
			item_ary = data_ary[i].split("%");
			VlanList[i] = new VlanEntry(item_ary[0],item_ary[1],item_ary[5],item_ary[4],item_ary[3], item_ary[2], item_ary[6]); //for TEW-812DRUv2
			//VlanList[i] = new VlanEntry(item_ary[0],item_ary[1],item_ary[2],item_ary[3],item_ary[4], item_ary[5], item_ary[6]); 
		}
	}
}

function setDefaultWan(){
	if(VlanList[0].en == "1"){
		document.getElementById("wan_en").checked = true;
	} else {
		document.getElementById("wan_en").checked = false;
	}
	document.getElementById("wan_vid").value = VlanList[0].vid;
	if(VlanList[0].port[WanPort] == "1"){
		document.getElementById("wan_tag").checked = true;
	} else {
		document.getElementById("wan_tag").checked = false;
	}
}

function page_load() {
	//var data ="0%%2%2%2%2%0|1%222%2%2%2%1%1|0%333%2%1%0%2%2"; en%vid%port0%port1%port2%port3%port4
	var data ="<% nvram_get("um_vlan"); %>";
	if(WanPort == ""){
		WanPort = "4";
	}
	if(PortCount == ""){
		PortCount = "5";
	}

	if(data != ""){
		parseData(data);
		setDefaultWan();
		show_all_row();
		rec_index = VlanList.length;
	}else{
		VlanList[0] = new VlanEntry(0,"",2,2,2,2,0); 
	}
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
<h1><!--#tr id="vlan.title"-->Virtual Local Area Network (LAN) Settings<!--#endtr--></h1>
<div class="hr" ></div>
<p>
<!--#tr id="vlan.desc"-->This page allows you to configure the VLAN of the router.<!--#endtr-->
</p>

<div id=vlan>
<form method="post" action="/vlan.asp" name="vlan" onSubmit="return checkVLAN();" target="rebootRedirect">
<input type="hidden" name="page" value="/internet/vlan.asp">
<input type="hidden" name="token" value="<% genToken(); %>">

<table class="tbl_main" width="100%">
	<tbody><tr>
		<td class="CT" colspan="3"><!--#tr id="vlan.internet.title"-->Default Internet Setting<!--#endtr--></td>
	</tr>
	<tr>
		<td>
			<table class="tbl_main2" width="100%">
				<tbody>
					<tr>
						<td class="form_list_title"><!--#tr id="enabled"-->Enabled<!--#endtr--></td>
						<td class="form_list_title"><!--#tr id="vlan.portnum"-->Port Number<!--#endtr--></td>
						<td class="form_list_title"><!--#tr id="vlan.id"-->VID<!--#endtr-->(3~4094)</td>
						<td class="form_list_title"><!--#tr id="vlan.tag"-->Tagged<!--#endtr--></td>
					</tr>
					<tr>
						<td class="form_list_content"><input name="wan_en" id="wan_en" type="checkbox"></td>
						<td class="form_list_content"><!--#tr id="vlan.internet"-->WAN Port<!--#endtr--></td>
						<td class="form_list_content"><input name="wan_vid" id="wan_vid" size="4" maxLength="4" type="text" onkeydown="return prevent_press_enter(event);"></td>
						<td class="form_list_content"><input name="wan_tag" id="wan_tag" type="checkbox"></td></tr>
			</tbody></table>
		</td>
	</tr>
</tbody></table>

<table class="tbl_main" width="100%">
	<tbody><tr>
		<td class="CT" colspan="3"><!--#tr id="vlan.1"-->Virtual LAN Interface Setting<!--#endtr--></td>
	</tr>
	<tr>
		<td>
			<table class="tbl_main2" width="100%">
				<tbody>
					<tr>
						<td class="form_list_title"><!--#tr id="enabled"-->Enabled<!--#endtr--></td>
						<td class="form_list_title"><!--#tr id="vlan.id"-->VID<!--#endtr-->(3~4094)</td>
						<td class="form_list_title"><!--#tr id="vlan.port"-->Port<!--#endtr--> 1</td>
						<td class="form_list_title"><!--#tr id="vlan.port"-->Port<!--#endtr--> 2</td>
						<td class="form_list_title"><!--#tr id="vlan.port"-->Port<!--#endtr--> 3</td>
						<td class="form_list_title"><!--#tr id="vlan.port"-->Port<!--#endtr--> 4</td>
						<td class="form_list_title"><!--#tr id="vlan.internet"-->WAN Port<!--#endtr--></td>
					</tr>
					<tr>
						<td class="form_list_content"><input name="enable" id="enable" type="checkbox" checked></td>
						<td class="form_list_content"><input name="vid" id="vid" size=4 maxLength=4 type="text" onkeydown="return prevent_press_enter(event);"></td>
						<td class="form_list_content"><select name="port_1" id="port_1" style="width:90px">
														<option value="0"><!--#tr id="vlan.untag"-->Untagged<!--#endtr--></option>
														<option value="1"><!--#tr id="vlan.tag"-->Tagged<!--#endtr--></option>
														<option value="2" selected><!--#tr id="vlan.exclude"-->Excluded<!--#endtr--></option>
													</select>
						</td>
						<td class="form_list_content"><select name="port_2" id="port_2" style="width:90px">
														<option value="0"><!--#tr id="vlan.untag"-->Untagged<!--#endtr--></option>
														<option value="1"><!--#tr id="vlan.tag"-->Tagged<!--#endtr--></option>
														<option value="2" selected><!--#tr id="vlan.exclude"-->Excluded<!--#endtr--></option>
													</select>
						</td>
						<td class="form_list_content"><select name="port_3" id="port_3" style="width:90px">
														<option value="0"><!--#tr id="vlan.untag"-->Untagged<!--#endtr--></option>
														<option value="1"><!--#tr id="vlan.tag"-->Tagged<!--#endtr--></option>
														<option value="2" selected><!--#tr id="vlan.exclude"-->Excluded<!--#endtr--></option>
													</select>
						</td>
						<td class="form_list_content"><select name="port_4" id="port_4" style="width:90px">
														<option value="0"><!--#tr id="vlan.untag"-->Untagged<!--#endtr--></option>
														<option value="1"><!--#tr id="vlan.tag"-->Tagged<!--#endtr--></option>
														<option value="2" selected><!--#tr id="vlan.exclude"-->Excluded<!--#endtr--></option>
													</select>
						</td>
						<td class="form_list_content"><select name="wanPort" id="wanPort" style="width:90px">
														<option value="0"><!--#tr id="vlan.untag"-->Untagged<!--#endtr--></option>
														<option value="1"><!--#tr id="vlan.tag"-->Tagged<!--#endtr--></option>
														<option value="2" selected><!--#tr id="vlan.exclude"-->Excluded<!--#endtr--></option>
													</select>
						</td>
			</tbody></table>
		</td>
	</tr>
</tbody></table>

<table class="tbl_main" width="100%">
	<tbody><tr align="center">
		<td>
			<input class="button1" name="vlanact" id="vlanact" value="<!--#tr id="add"-->Add<!--#endtr-->" type="button" onclick="add_edit()">
		</td>
	</tr>
</tbody></table>

<table class="tbl_main" width="100%">
	<tbody><tr>
		<td class="CT" colspan="3"><!--#tr id="vlan.list"-->VLAN List<!--#endtr--></td>
	</tr>
	<tr>
		<td>
			<table class="tbl_main2" width="100%" id="tabList">
				<tbody>
					<tr>
						<td class="form_list_title"><!--#tr id="enabled"-->Enabled<!--#endtr--></td>
						<td class="form_list_title"><!--#tr id="vlan.id"-->VID<!--#endtr--></td>
						<td class="form_list_title"><!--#tr id="member"-->Member<!--#endtr--></td>
						<td class="form_list_title"><!--#tr id="remove"-->Remove<!--#endtr--></td>
						<td class="form_list_title"><!--#tr id="edit"-->Edit<!--#endtr--></td>
					</tr>
				</tbody>
			</table>
		</td>
	</tr>
</tbody></table>

<table width="100%" class="tbl_main">
	<tr align="center">
		<td>
			<input class="button1" name="action" value="<!--#tr id="apply"-->Apply<!--#endtr-->" type="submit">
			<input class="button1" name="action" value="<!--#tr id="cancel"-->Cancel<!--#endtr-->" type="reset" onclick="window.location.reload()">
		</td>
	</tr>
</table>
<input type="hidden" name="vlan_set" id="vlan_set" value="<% nvram_get("um_vlan"); %>">
</form>
</div>

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
