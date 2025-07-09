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
<script language="javascript" type="text/javascript">
/*
*  Afeter clicking apply button, it will trigger this function to check settings.
*  Accroding to different options, it will check their field values.
*  
*  Return :  If true, all fields is ok. Otherwise, some fileds settings is not ok.
*/
function applyCheck()
{
	var re = /^[\w\-]+$/; 

	// Check SAMBA server information
	if (isBlankString(document.getElementById("serverNameInput").value)) {
		document.getElementById("serverNameInput").focus();
		Alert.render("<!--#tr id="file.share.alert.1"-->Server name is blank!<!--#endtr-->");
		return false;
	}
	if (!re.test(document.getElementById("serverNameInput").value)) {
		document.getElementById("serverNameInput").focus();
		Alert.render("<!--#tr id="file.share.alert.2"-->Server name only accept [0-9a-zA-Z_-] characters.<!--#endtr-->");
		return false;
	}
	if (isBlankString(document.getElementById("workgroupInput").value)) {
		document.getElementById("workgroupInput").focus();
		Alert.render("<!--#tr id="file.share.alert.3"-->Workgroup is blank!<!--#endtr-->");
		return false;
	}
	if (!re.test(document.getElementById("workgroupInput").value)) {
		document.getElementById("workgroupInput").focus();
		Alert.render("<!--#tr id="file.share.alert.4"-->Workgroup only accept [0-9a-zA-Z_-] characters.<!--#endtr-->");
		return false;
	}
	if (document.getElementById("descriptionInput").value.indexOf("\"") > -1) {
		document.getElementById("descriptionInput").focus();
		Alert.render("<!--#tr id="file.share.alert.5"-->Description has invalid characters<!--#endtr--> \".");
		return false; 
	}

	// Check SAMBA administrator
	if (isBlankString(document.getElementById("smbUsernameInput").value)) {
		document.getElementById("smbUsernameInput").focus();
		Alert.render("<!--#tr id="file.share.alert.6"-->User name is blank!<!--#endtr-->");
		return false;
	}
	if (!re.test(document.getElementById("smbUsernameInput").value)) {
		document.getElementById("smbUsernameInput").focus();
		Alert.render("<!--#tr id="file.share.alert.7"-->User name only accept [0-9a-zA-Z_-] characters.<!--#endtr-->");
		return false;
	}
	if (isBlankString(document.getElementById("smbPasswordInput").value)) {
		document.getElementById("smbPasswordInput").focus();
		Alert.render("<!--#tr id="file.share.alert.8"-->Password is blank!<!--#endtr-->");
		return false;
	}
	if (document.getElementById("smbPasswordInput").value.indexOf("\"") > -1) {
		document.getElementById("smbPasswordInput").focus();
		Alert.render("<!--#tr id="mg.alert.4"-->Password have invalid characters<!--#endtr--> \".");
		return false; 
	}

	// Check SAMBA user
	var TOTALSMB = document.getElementById("smb_account").value;
	for (var i = 0; i < TOTALSMB; i++) {
		var smbAccountElement = document.getElementsByName("smb_username" + i)[0];
		var smbPasswordElement = document.getElementsByName("smb_password" + i)[0];

		if (isBlankString(smbAccountElement.value) && isBlankString(smbPasswordElement.value))
			continue;

		if (isBlankString(smbAccountElement.value)) {
			smbAccountElement.focus();
			Alert.render("<!--#tr id="file.share.alert.6"-->User name is blank!<!--#endtr-->");
			return false;
		}
		if (!re.test(smbAccountElement.value)) {
			smbAccountElement.focus();
			Alert.render("<!--#tr id="file.share.alert.7"-->User name only accept [0-9a-zA-Z_-] characters.<!--#endtr-->");
			return false;
		}
		if (isBlankString(smbPasswordElement.value)) {
			smbPasswordElement.focus();
			Alert.render("<!--#tr id="file.share.alert.8"-->Password is blank!<!--#endtr-->");
			return false;
		}
		if (smbPasswordElement.value.indexOf("\"") > -1) {
			smbPasswordElement.focus();
			Alert.render("<!--#tr id="mg.alert.4"-->Password have invalid characters<!--#endtr--> \".");
			return false; 
		}

		for (var j = 0; j < i; j++){
			var tmpsmbAccountElement = document.getElementsByName("smb_username" + j)[0];
					
			if (isBlankString(tmpsmbAccountElement.value))
				continue;
				
			// User name should be unique
			if (!isBlankString(smbAccountElement.value) && smbAccountElement.value == tmpsmbAccountElement.value){
					Alert.render("<!--#tr id="file.share.alert.9"-->This user name is already set in another rule.<!--#endtr-->");
					smbAccountElement.focus();
					return false;
			}
		}
	}

	// Check FTP administrator
	if (isBlankString(document.getElementById("ftpUsernameInput").value)) {
		document.getElementById("ftpUsernameInput").focus();
		Alert.render("<!--#tr id="file.share.alert.6"-->User name is blank!<!--#endtr-->");
		return false;
	}
	if (!re.test(document.getElementById("ftpUsernameInput").value)) {
		document.getElementById("ftpUsernameInput").focus();
		Alert.render("<!--#tr id="file.share.alert.7"-->User name only accept [0-9a-zA-Z_-] characters.<!--#endtr-->");
		return false;
	}
	if (isBlankString(document.getElementById("ftpPasswordInput").value)) {
		document.getElementById("ftpPasswordInput").focus();
		Alert.render("<!--#tr id="file.share.alert.8"-->Password is blank!<!--#endtr-->");
		return false;
	}
	if (document.getElementById("ftpPasswordInput").value.indexOf("\"") > -1) {
		document.getElementById("ftpPasswordInput").focus();
		Alert.render("<!--#tr id="mg.alert.4"-->Password have invalid characters<!--#endtr--> \".");
		return false; 
	}

	// Check FTP user
	var TOTALFTP = document.getElementById("ftp_account").value;
	for (var i = 0; i < TOTALFTP; i++) {
		var ftpAccountElement = document.getElementsByName("ftp_username" + i)[0];
		var ftpPasswordElement = document.getElementsByName("ftp_password" + i)[0];

		if (isBlankString(ftpAccountElement.value) && isBlankString(ftpPasswordElement.value))
			continue;

		if (isBlankString(ftpAccountElement.value)) {
			ftpAccountElement.focus();
			Alert.render("<!--#tr id="file.share.alert.6"-->User name is blank!<!--#endtr-->");
			return false;
		}
		if (!re.test(ftpAccountElement.value)) {
			ftpAccountElement.focus();
			Alert.render("<!--#tr id="file.share.alert.7"-->User name only accept [0-9a-zA-Z_-] characters.<!--#endtr-->");
			return false;
		}
		if (isBlankString(ftpPasswordElement.value)) {
			ftpPasswordElement.focus();
			Alert.render("<!--#tr id="file.share.alert.8"-->Password is blank!<!--#endtr-->");
			return false;
		}
		if (ftpPasswordElement.value.indexOf("\"") > -1) {
			ftpPasswordElement.focus();
			Alert.render("<!--#tr id="mg.alert.4"-->Password have invalid characters<!--#endtr--> \".");
			return false; 
		}
	}

	totalWaitTime = 25;
	wait_page();
	document.getElementById("waitPad").style.display="block";
	scroll(0,0);
	return true;
}

// Annie.Weng @20130325: add for usb safely removing
var http_request = false;
function makeRequest(url, content) {
	http_request = false;
	if (window.XMLHttpRequest) { // Mozilla, Safari,...
		http_request = new XMLHttpRequest();
		if (http_request.overrideMimeType) {
			http_request.overrideMimeType('text/xml');
		}
	} else if (window.ActiveXObject) { // IE
		try {
			http_request = new ActiveXObject("Msxml2.XMLHTTP");
		} catch (e) {
			try {
			http_request = new ActiveXObject("Microsoft.XMLHTTP");
			} catch (e) {}
		}
	}
	if (!http_request) {
		Alert.render("<!--#tr id="syslg.alert.1" -->Giving up :( Cannot create an XMLHTTP instance<!--#endtr -->");
		return false;
	}
	http_request.onreadystatechange = alertContents;
	http_request.open('POST', url, true);
	http_request.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
	http_request.send(content);
}

function alertContents() {
	if (http_request.readyState == 4) {
		if (http_request.status == 200) {
			showUsbStatus( http_request.responseText );
		} else {
		    Alert.render("<!--#tr id="syslg.alert.2"-->There was a problem with the request.<!--#endtr-->");
		}
	}
}

function showUsbStatus(str)
{
	if (str == "OK") {
		Alert.render("<!--#tr id="file.share.usb.msgok"-->Now you can remove this device.<!--#endtr-->");
	}
	else {
		Alert.render("<!--#tr id="file.share.usb.msgfail"-->The device cannot be removed right now. Try removing the device again later.<!--#endtr-->");
	}

	self.location.reload();
}

function checkUsbRemove(){

	var usbListLen = document.getElementById	("usb_devlist_len").value;
	var selectNum = 0;
	var sel;
	var devName;
	var param = "";
	
	for( var i=0; i<usbListLen; i++){
		sel = document.getElementById("usb_select"+i).checked;
		if (sel) {
			selectNum++;
			devName = document.getElementById("usb_sharename"+i).value;
			param += devName+',';
		}
	}

	if (selectNum) {
		makeRequest("../unmountUsbDev.cgi", 'param='+param);
	}
}

function selectAll(val){
	var usbListLen = document.getElementById	("usb_devlist_len").value;
	for( var i=0; i<usbListLen; i++){
		document.getElementById("usb_select"+i).checked = val;
	}
}

// ~Annie.Weng @20130325

function page_load() {
	var projectName = "<% getProjectName(); %>";

	// Annie.Weng @20130325: add for usb safely removing
	var usbListLen = document.getElementById	("usb_devlist_len").value;
	if (usbListLen =="0") {
		document.getElementById("usb_rmbtn").disabled = true;
	}
	else {
		document.getElementById("usb_rmbtn").disabled = false;
	}
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
<h1><!--#tr id="usb.node.samba"-->Samba Server<!--#endtr--></h1>
<div class="hr" ></div>
<p>
<!--#tr id="advanced.usb.samba.desc"-->Enable the SAMBA server to share the files on USB storage.<!--#endtr-->
</p>

<!-- SAMBA Configuration -->
<form name="smb" method="post" action="/uapply.cgi" onSubmit="return applyCheck();" target="rebootRedirect">
<input type="hidden" name="page" value="/usb/samba.asp">
<input type="hidden" name="token" value="<% genToken(); %>">
<table width="100%" class="tbl_main">
	<tr>
		<td class="CT" colspan="2"><!--#tr id="file.share.smb"-->SAMBA Server Information<!--#endtr--></td>
	</tr>
	<tr id="smb_status_tr">
		<td class="CL"><!--#tr id="file.share.server.status"-->Server Status<!--#endtr--></td>
		<td class="CR">
		  <select id="serverStatusSelect" name="smb_enable">
			<option value="0" <% nvram_match("smb_enable", "0", "selected"); %>><!--#tr id="disabled"-->Disabled<!--#endtr--></option>
			<option value="1" <% nvram_match("smb_enable", "1", "selected"); %>><!--#tr id="enabled"-->Enabled<!--#endtr--></option>
		  </select>
		</td>
	</tr>
	<tr id="smb_name_tr">
		<td class="CL"><!--#tr id="file.share.server.name"-->Server Name<!--#endtr--></td>
		<td class="CR"><input id="serverNameInput" name="smb_host" maxlength="15" value="<% nvram_get("smb_host"); %>" onkeydown="return prevent_press_enter(event);"></td>
	</tr>
	<tr id="smb_group_tr">
		<td class="CL"><!--#tr id="file.share.workgroup"-->Workgroup<!--#endtr--></td>
		<td class="CR"><input id="workgroupInput" name="smb_group" maxlength="15" value="<% nvram_get("smb_group"); %>" onkeydown="return prevent_press_enter(event);"></td>
	</tr>
	<tr id="smb_desc_tr">
		<td class="CL"><!--#tr id="file.share.description"-->Description<!--#endtr--></td>
		<td class="CR"><input id="descriptionInput" name="smb_desc" maxlength="48" value="<% nvram_get("smb_desc"); %>" onkeydown="return prevent_press_enter(event);"></td>
	</tr>
</table>

<table width="100%" class="tbl_main">
	<tr>
		<td class="CT" colspan="2"><!--#tr id="administrator"-->Administrator<!--#endtr--></td>
	</tr>
	<tr>
		<td class="CL"><!--#tr id="wan.user.name"-->User Name<!--#endtr--></td>
		<td class="CR"><input id="smbUsernameInput" name="smb_admin_name" maxlength="15" value="<% nvram_get("smb_admin_name"); %>" onkeydown="return prevent_press_enter(event);"></td>
	</tr>
	<tr>
		<td class="CL"><!--#tr id="password"-->Password<!--#endtr--></td>
		<td class="CR">
			<table border="0">
				<tr>
					<td><input type="password" id="smbPasswordInput" name="smb_admin_pass" maxlength="15" value="<% nvram_get("smb_admin_pass"); %>" onkeydown="return prevent_press_enter(event);"></td>
					<td>&nbsp;</td>
					<td><font color="white"><!--#tr id="file.share.note.1"-->Note: The default administrator password is the same as the router’s default management login password.<!--#endtr--></font></td>
				</tr>
			</table>
		</td>
	</tr>
</table>

<table width="100%" class="tbl_main">
	<tr>
		<td class="CT" colspan="2"><!--#tr id="file.share.user.list"-->User Account List<!--#endtr--></td>
	</tr>
	<tr>
		<td>
			<table width="100%" class="tbl_main2">
			  <tr>
				<input type="hidden" name="smb_account" id="smb_account" value="5">
				<td class="form_list_title"><!--#tr id="user.name"-->User Name<!--#endtr--></td>
				<td class="form_list_title"><!--#tr id="password"-->Password<!--#endtr--></td>
				<td class="form_list_title"><!--#tr id="permission"-->Permission<!--#endtr--></td>
				<td class="form_list_title"><!--#tr id="enabled"-->Enabled<!--#endtr--></td>
			  </tr>
			  <% smb_account(0, 4); %>
			</table>
		</td>
	</tr>
</table>

<!-- FTP Configuration -->
<table width="100%" class="tbl_main" style="display:none">
	<tr>
		<td class="CT" colspan="2"><!--#tr id="file.share.ftp"-->FTP Server Information<!--#endtr--></td>
	</tr>
	<tr id="ftp_status_tr">
		<td class="CL"><!--#tr id="file.share.server.status"-->Server Status<!--#endtr--></td>
		<td class="CR">
		  <select id="ftpServerStatusSelect" name="ftp_enable">
			<option value="0" <% nvram_match("ftp_enable", "0", "selected"); %>><!--#tr id="disabled"-->Disabled<!--#endtr--></option>
			<option value="1" <% nvram_match("ftp_enable", "1", "selected"); %>><!--#tr id="enabled"-->Enabled<!--#endtr--></option>
		  </select>
		</td>
	</tr>
	<tr id="ftp_codepage_tr">
		<td class="CL"><!--#tr id="file.share.ftp.codepage"-->Language(Codepage)<!--#endtr--></td>
		<td class="CR">
		  <select id="ftpServerCodepageSelect" name="ftp_codepage">
			<option value="0" <% nvram_match("ftp_codepage", "0", "selected"); %>><!--#tr id="codepage.0"-->Western European<!--#endtr--></option>
			<option value="1" <% nvram_match("ftp_codepage", "1", "selected"); %>><!--#tr id="codepage.1"-->Central European<!--#endtr--></option>
			<option value="2" <% nvram_match("ftp_codepage", "2", "selected"); %>><!--#tr id="codepage.2"-->Greek<!--#endtr--></option>
			<option value="3" <% nvram_match("ftp_codepage", "3", "selected"); %>><!--#tr id="codepage.3"-->Cyrillic<!--#endtr--></option>
			<option value="4" <% nvram_match("ftp_codepage", "4", "selected"); %>><!--#tr id="codepage.4"-->Japanese<!--#endtr--></option>
			<option value="5" <% nvram_match("ftp_codepage", "5", "selected"); %>><!--#tr id="codepage.5"-->Korean<!--#endtr--></option>
			<option value="6" <% nvram_match("ftp_codepage", "6", "selected"); %>><!--#tr id="codepage.6"-->Traditional Chinese<!--#endtr--></option>
			<option value="7" <% nvram_match("ftp_codepage", "7", "selected"); %>><!--#tr id="codepage.7"-->Simplified Chinese<!--#endtr--></option>
			<option value="8" <% nvram_match("ftp_codepage", "8", "selected"); %>><!--#tr id="codepage.8"-->Thai<!--#endtr--></option>
			<option value="9" <% nvram_match("ftp_codepage", "9", "selected"); %>><!--#tr id="codepage.9"-->Arabic<!--#endtr--></option>
		  </select>
		</td>
	</tr>
</table>

<table width="100%" class="tbl_main" style="display:none">
	<tr>
		<td class="CT" colspan="2"><!--#tr id="administrator"-->Administrator<!--#endtr--></td>
	</tr>
	<tr>
		<td class="CL"><!--#tr id="user.name"-->User Name<!--#endtr--></td>
		<td class="CR"><input id="ftpUsernameInput" name="ftp_admin_name" maxlength="15" value="<% nvram_get("ftp_admin_name"); %>" onkeydown="return prevent_press_enter(event);"></td>
	</tr>
	<tr>
		<td class="CL"><!--#tr id="password"-->Password<!--#endtr--></td>
		<td class="CR"><input type="password" id="ftpPasswordInput" name="ftp_admin_pass" maxlength="15" value="<% nvram_get("ftp_admin_pass"); %>" onkeydown="return prevent_press_enter(event);"></td>
	</tr>
</table>

<table width="100%" class="tbl_main" style="display:none">
	<tr>
		<td class="CT" colspan="2"><!--#tr id="file.share.user.list"-->User Account List<!--#endtr--></td>
	</tr>
	<tr>
		<td>
			<table width="100%" class="tbl_main2">
			  <tr>
				<input type="hidden" name="ftp_account" id="ftp_account" value="5">
				<td class="form_list_title"><!--#tr id="user.name"-->User Name<!--#endtr--></td>
				<td class="form_list_title"><!--#tr id="password"-->Password<!--#endtr--></td>
				<td class="form_list_title"><!--#tr id="permission"-->Permission<!--#endtr--></td>
				<td class="form_list_title"><!--#tr id="enabled"-->Enabled<!--#endtr--></td>
			  </tr>
			  <% ftp_account(0, 4); %>
			</table>
		</td>
	</tr>
</table>

<table width="100%" class="tbl_main">
	<tr align="center">
		<td>
			<input type="submit" class="<!--#tr id="buttonWidth"-->button1<!--#endtr-->" name="action" value="<!--#tr id="apply"-->Apply<!--#endtr-->">
			<input type="reset" class="button1" name="action" value="<!--#tr id="cancel"-->Cancel<!--#endtr-->">
		</td>
	</tr>
</table>

<table width="100%" class="tbl_main" style="display:none">
	<tr>
		<td class="CT" colspan="2"><!--#tr id="file.share.usb"-->USB Storage<!--#endtr--></td>
	</tr>
	<tr>
		<td>
			<table width="100%" class="tbl_main2">
			<tr>
				<td class="form_list_title">
					<a href="javascript:void(0)" onclick="selectAll(true);" title="<!--#tr id="select.all"-->Select All<!--#endtr-->"><b>+</b></a>|
					<a href="javascript:void(0)" onclick="selectAll(false);" title="<!--#tr id="select.none"-->Select None<!--#endtr-->"><b>-</b></a>
				</td>
				<td class="form_list_title"><!--#tr id="file.share.usb.sharename"-->Share Name<!--#endtr--></td>
				<td class="form_list_title"><!--#tr id="file.share.usb.devdesc"-->Device Description<!--#endtr--></td>
				<td class="form_list_title"><!--#tr id="file.share.usb.totalspace"-->Total Space<!--#endtr--></td>
				<td class="form_list_title"><!--#tr id="file.share.usb.freespace"-->Free Space<!--#endtr--></td>
			</tr>
			<% usb_devlist(); %>
			</table>
		</td>
	</tr>
	<tr align="center">
		<td>
		  	<input id="usb_rmbtn" type="button" class="button1_NoWidth" value="<!--#tr id="file.share.usb.rm"-->Safely Remove USB Device<!--#endtr-->" onclick="checkUsbRemove();">
		  	<input type="button" class="<!--#tr id="buttonWidth"-->button1<!--#endtr-->" value="<!--#tr id="refresh"-->Refresh<!--#endtr-->" onclick="self.location.reload();">
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
