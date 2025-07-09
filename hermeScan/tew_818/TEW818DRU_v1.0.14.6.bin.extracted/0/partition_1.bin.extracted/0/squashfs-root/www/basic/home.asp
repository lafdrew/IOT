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
<script language="javascript" type="text/javascript">
function page_load() {
	//Wireless, SSID
	var ssid2g_enable = "<% nvram_get("wl0_bss_enabled"); %>"*1;
	var ssid5g_enable = "<% nvram_get("wl1_bss_enabled"); %>"*1;

	var ssid2g = "<% nvram_get("wl0_ssid"); %>";
	var ssid5g = "<% nvram_get("wl1_ssid"); %>";

	if(ssid2g_enable || ssid5g_enable) {
		document.getElementById("wireless_enable").style.display = "block";
		document.getElementById("wireless_disable").style.display = "none";
	} else {
		document.getElementById("wireless_enable").style.display = "none";
		document.getElementById("wireless_disable").style.display = "block";
	}

	if(ssid2g_enable)
		document.getElementById("ssid2g").innerHTML = ssid2g;
	else
		document.getElementById("ssid2g").innerHTML = "<!--#tr id="disabled"-->Disabled<!--#endtr-->";
	if(ssid5g_enable)
		document.getElementById("ssid5g").innerHTML = ssid5g;
	else
		document.getElementById("ssid5g").innerHTML = "<!--#tr id="disabled"-->Disabled<!--#endtr-->";

	//Wireless Security
	var wl0_auth = "<% nvram_get("wl0_auth"); %>"*1;
	var wl0_wep = "<% nvram_match("wl0_wep", "enabled", "1"); %>"*1;
	var wl0_akm_wpa = "<% nvram_inlist("wl0_akm", "wpa", "1"); %>"*1;
	var wl0_akm_psk = "<% nvram_inlist("wl0_akm", "psk", "1"); %>"*1;
	var wl0_akm_wpa2 = "<% nvram_inlist("wl0_akm", "wpa2", "1"); %>"*1;
	var wl0_akm_psk2 = "<% nvram_inlist("wl0_akm", "psk2", "1"); %>"*1;
	var mode2g;

	if(wl0_auth == 0 && wl0_wep == 0 && wl0_akm_wpa == 0 && wl0_akm_psk == 0 && wl0_akm_wpa2 == 0 && wl0_akm_psk2 == 0) {
		mode2g = "<!--#tr id="disable" -->Disable<!--#endtr -->";
	}
	else if(wl0_auth == 0 && wl0_wep == 1 && wl0_akm_wpa == 0 && wl0_akm_psk == 0 && wl0_akm_wpa2 == 0 && wl0_akm_psk2 == 0) {
		mode2g = "WEP-OPEN";
	}
	else if(wl0_auth == 1 && wl0_wep == 1 && wl0_akm_wpa == 0 && wl0_akm_psk == 0 && wl0_akm_wpa2 == 0 && wl0_akm_psk2 == 0) {
		mode2g = "WEP-SHARED";
	}
	else if(wl0_auth == 0 && wl0_wep == 0 && wl0_akm_wpa == 1 && wl0_akm_psk == 0 && wl0_akm_wpa2 == 0 && wl0_akm_psk2 == 0) {
		mode2g = "<!--#tr id="security.37"-->WPA<!--#endtr-->";
	}
	else if(wl0_auth == 0 && wl0_wep == 0 && wl0_akm_wpa == 0 && wl0_akm_psk == 0 && wl0_akm_wpa2 == 1 && wl0_akm_psk2 == 0) {
		mode2g = "<!--#tr id="security.6"-->WPA2<!--#endtr-->";
	}
	else if(wl0_auth == 0 && wl0_wep == 0 && wl0_akm_wpa == 1 && wl0_akm_psk == 0 && wl0_akm_wpa2 == 1 && wl0_akm_psk2 == 0) {
		mode2g = "<!--#tr id="security.43"-->WPA2 Mixed<!--#endtr-->";
	}
	else if(wl0_auth == 0 && wl0_wep == 0 && wl0_akm_wpa == 0 && wl0_akm_psk == 1 && wl0_akm_wpa2 == 0 && wl0_akm_psk2 == 0) {
		mode2g = "<!--#tr id="security.5"-->WPA-PSK<!--#endtr-->";
	}
	else if(wl0_auth == 0 && wl0_wep == 0 && wl0_akm_wpa == 0 && wl0_akm_psk == 0 && wl0_akm_wpa2 == 0 && wl0_akm_psk2 == 1) {
		mode2g = "<!--#tr id="security.7"-->WPA2-PSK<!--#endtr-->";
	}
	else if(wl0_auth == 0 && wl0_wep == 0 && wl0_akm_wpa == 0 && wl0_akm_psk == 1 && wl0_akm_wpa2 == 0 && wl0_akm_psk2 == 1) {
		mode2g = "<!--#tr id="security.42"-->WPA2-PSK Mixed<!--#endtr-->";
	}
	document.getElementById("mode2g").innerHTML = mode2g;

	var wl1_auth = "<% nvram_get("wl1_auth"); %>"*1;
	var wl1_wep = "<% nvram_match("wl1_wep", "enabled", "1"); %>"*1;
	var wl1_akm_wpa = "<% nvram_inlist("wl1_akm", "wpa", "1"); %>"*1;
	var wl1_akm_psk = "<% nvram_inlist("wl1_akm", "psk", "1"); %>"*1;
	var wl1_akm_wpa2 = "<% nvram_inlist("wl1_akm", "wpa2", "1"); %>"*1;
	var wl1_akm_psk2 = "<% nvram_inlist("wl1_akm", "psk2", "1"); %>"*1;
	var mode5g;

	if(wl1_auth == 0 && wl1_wep == 0 && wl1_akm_wpa == 0 && wl1_akm_psk == 0 && wl1_akm_wpa2 == 0 && wl1_akm_psk2 == 0) {
		mode5g = "<!--#tr id="disable" -->Disable<!--#endtr -->";
	}
	else if(wl1_auth == 0 && wl1_wep == 1 && wl1_akm_wpa == 0 && wl1_akm_psk == 0 && wl1_akm_wpa2 == 0 && wl1_akm_psk2 == 0) {
		mode5g = "WEP-OPEN";
	}
	else if(wl1_auth == 1 && wl1_wep == 1 && wl1_akm_wpa == 0 && wl1_akm_psk == 0 && wl1_akm_wpa2 == 0 && wl1_akm_psk2 == 0) {
		mode5g = "WEP-SHARED";
	}
	else if(wl1_auth == 0 && wl1_wep == 0 && wl1_akm_wpa == 1 && wl1_akm_psk == 0 && wl1_akm_wpa2 == 0 && wl1_akm_psk2 == 0) {
		mode5g = "<!--#tr id="security.37"-->WPA<!--#endtr-->";
	}
	else if(wl1_auth == 0 && wl1_wep == 0 && wl1_akm_wpa == 0 && wl1_akm_psk == 0 && wl1_akm_wpa2 == 1 && wl1_akm_psk2 == 0) {
		mode5g = "<!--#tr id="security.6"-->WPA2<!--#endtr-->";
	}
	else if(wl1_auth == 0 && wl1_wep == 0 && wl1_akm_wpa == 1 && wl1_akm_psk == 0 && wl1_akm_wpa2 == 1 && wl1_akm_psk2 == 0) {
		mode5g = "<!--#tr id="security.43"-->WPA2 Mixed<!--#endtr-->";
	}
	else if(wl1_auth == 0 && wl1_wep == 0 && wl1_akm_wpa == 0 && wl1_akm_psk == 1 && wl1_akm_wpa2 == 0 && wl1_akm_psk2 == 0) {
		mode5g = "<!--#tr id="security.5"-->WPA-PSK<!--#endtr-->";
	}
	else if(wl1_auth == 0 && wl1_wep == 0 && wl1_akm_wpa == 0 && wl1_akm_psk == 0 && wl1_akm_wpa2 == 0 && wl1_akm_psk2 == 1) {
		mode5g = "<!--#tr id="security.7"-->WPA2-PSK<!--#endtr-->";
	}
	else if(wl1_auth == 0 && wl1_wep == 0 && wl1_akm_wpa == 0 && wl1_akm_psk == 1 && wl1_akm_wpa2 == 0 && wl1_akm_psk2 == 1) {
		mode5g = "<!--#tr id="security.42"-->WPA2-PSK Mixed<!--#endtr-->";
	}
	document.getElementById("mode5g").innerHTML = mode5g;
	
	//Guest Network
	var guest2g = "<% nvram_get("wl0.3_bss_enabled"); %>"*1;
	var guest5g = "<% nvram_get("wl1.3_bss_enabled"); %>"*1;
	var guest2gssid = "<% nvram_get("wl0.3_ssid"); %>";
	var guest5gssid = "<% nvram_get("wl1.3_ssid"); %>";

	if(guest2g || guest5g) {
		document.getElementById("guest_enable").style.display = "block";
		document.getElementById("guest_disable").style.display = "none";
	} else {
		document.getElementById("guest_enable").style.display = "none";
		document.getElementById("guest_disable").style.display = "block";
	}

	if(guest2g)
		document.getElementById("guest_2g_ssid").innerHTML = guest2gssid;
	else
		document.getElementById("guest_2g_ssid").innerHTML = "<!--#tr id="disabled"-->Disabled<!--#endtr-->";

	if(guest5g)
		document.getElementById("guest_5g_ssid").innerHTML = guest5gssid;
	else
		document.getElementById("guest_5g_ssid").innerHTML = "<!--#tr id="disabled"-->Disabled<!--#endtr-->";

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
<h1 ><!--#tr id="basic.menu.networkstatus"-->Network Status<!--#endtr--></h1>
<div class="hr" ></div>
<form method="post" name="XXXXX" action="../XXXXXXX">
<div style="width:99%; height:100%">
  <div style="float:left; min-height:300px">
    <div class="boxshadow" style="width:220px; height:100%;">
      <h4><!--#tr id="basic.status.internet"-->Internet<!--#endtr--></h4>
      <div class="hr2" ></div>
      <table width="100%" border="0" cellpadding="3" cellspacing="1">
        <tr>
          <% getWanStatus(); %>
        </tr>
      </table>
    </div>
    
    <div class="boxshadow" style="width:220px; height:100%;">
      <h4><!--#tr id="basic.menu.guestnetwork"-->Guest Network<!--#endtr--></h4>
      <div class="hr2" ></div>
      <table width="100%" border="0" cellpadding="3" cellspacing="1">
        <tr>
          <td width="16%">
		  	<img src="../images/icons_guest_network_0.png" id="guest_disable">
		  	<img src="../images/icons_guest_network_1.png" id="guest_enable" style="display:none">
		  </td>
          <td width="84%">
			<table width="100%">
				<tr>
					<td width="10px" rowspan="5">&nbsp;</td>
					<td>
						<b><!--#tr id="basic.status.guest.2.4g.ssid"-->2.4GHz Guest SSID:<!--#endtr--></b>
					</td>
				</tr>
				<tr>
					<td style="word-break:break-all;">
						<span id="guest_2g_ssid"></span>
					</td>
				</tr>
				<tr>
					<td>&nbsp;</td>
				</tr>
				<tr>
					<td>
						<b><!--#tr id="basic.status.guest.5g.ssid"-->5GHz Guest SSID:<!--#endtr--></b>
					</td>
				</tr>
				<tr>
					<td style="word-break:break-all;">
						<span id="guest_5g_ssid"></span>
					</td>
				</tr>
			</table>
		  </td>
        </tr>
        </table>
    </div>
    
        <div class="boxshadow" style="width:220px; height:100%; ">
      <h4><!--#tr id="usb"-->USB<!--#endtr--></h4><div class="hr2" ></div>
      <table width="100%" border="0" cellpadding="3" cellspacing="1">
        <tr>
			<% getUSBDevice(); %>
        </tr>
      </table>
      </div>
  </div>
  
  <div style="float:right; min-height:300px">
   <div class="boxshadow" style="width:330px; height:100%;">
      <h4><!--#tr id="basic.menu.wireless"-->Wireless<!--#endtr--></h4>
      <div class="hr2" ></div>
      <table width="100%" border="0" cellpadding="3" cellspacing="1">
        <tr>
          <td width="16%">
		  	<img src="../images/icons_wireless_0.png" id="wireless_disable">
			<img src="../images/icons_wireless_1.png" id="wireless_enable" style="display:none">
		  </td>
          <td width="84%">
		  	<table width="100%">
				<tr>
					<td width="10px" rowspan="5">&nbsp;</td>
					<td>
						<b><!--#tr id="basic.status.wireless.2.4g.ssid"-->2.4 GHz SSID:<!--#endtr--></b>
					</td>
				</tr>
				<tr>
					<td style="word-break:break-all;">
						<span id="ssid2g"></span>
					</td>
				</tr>
				<tr>
					<td>&nbsp;
						
					</td>
				</tr>
				<tr>
					<td>
						<b><!--#tr id="basic.status.wireless.5g.ssid"-->5 GHz SSID:<!--#endtr--></b>
					</td>
				</tr>
				<tr>
					<td style="word-break:break-all;">
						<span id="ssid5g"></span>
					</td>
				</tr>
			</table>
		  </td>
        </tr>
      </table>
      <div class="hr2" ></div>
      <table width="100%" border="0" cellpadding="3" cellspacing="1">
        <tr>
          <td width="16%" valign="top"><img src="../images/icons_wireless_security.png"></td>
          <td width="84%" valign="top">
		  	<table width="100%">
				<tr>
					<td width="10px" rowspan="5">&nbsp;</td>
					<td>
						<p><b><!--#tr id="basic.status.wireless.2.4g"-->2.4 GHz:<!--#endtr--></b>&nbsp;<span id="mode2g"></span><br>
						<b><!--#tr id="basic.status.wireless.5g"-->5 GHz:<!--#endtr--></b>&nbsp;<span id="mode5g"></span></p>
					</td>
				</tr>
			</table>
		  </td>
        </tr>
      </table>
    </div>
    <div class="boxshadow" style="width:330px; height:100%; ">
      <h4><!--#tr id="basic.status.connected.devices"-->Connected Devices<!--#endtr--></h4><div class="hr2" ></div>
	  <% getHomeConnect(); %>
    </div>
  </div>
</div>
<div class="clear"></div>
</form>
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
