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
/*
 * is_number
 *	Return true if a value represents a number, else return false.
 */
function is_number(value)
{
	var str = value + "";
	return str.match(/^-?\d*\.?\d+$/) ? true : false;
}

/*
 * ipv4_to_bytearray
 *	Convert an IPv4 address dotted string to a byte array
 */
function ipv4_to_bytearray(ipaddr)
{
	var ip = ipaddr + "";
	var got = ip.match (/^\s*(\d{1,3})\s*[.]\s*(\d{1,3})\s*[.]\s*(\d{1,3})\s*[.]\s*(\d{1,3})\s*$/);
	if (!got) {
		return 0;
	}
	var a = [];
	var q = 0;
	for (var i = 1; i <= 4; i++) {
		q = parseInt(got[i],10);
		if (q < 0 || q > 255) {
			return 0;
		}
		a[i-1] = q;
	}
	return a;
}

function getValue(element, defaultValue)
{
    return isBlankString(element.value) ? defaultValue : element.value;
}

function checkIPv4Format(ipAddress)
{
    if (!ipAddress.match (/^\s*(\d{1,3})\s*[.]\s*(\d{1,3})\s*[.]\s*(\d{1,3})\s*[.]\s*(\d{1,3})\s*$/)) {
	    return false;
    }
    
    var ipItemArray = ipAddress.split(".");
    for (var index = 0; index < ipItemArray.length; index++)
    {
        var item = parseInt(ipItemArray[index],10);
        if (item < 0 || item > 255)
            return false;
    }
    return true;
}

function checkSubnet(ip1, netmask, ip2)
{
    if (ip1 == "0.0.0.0" || ip2 == "0.0.0.0")
        return true;

	//split the ip address and netmask
	var ip1Array = ip1.split(".");
	var netmaskArray = netmask.split(".");
	var ip2Array = ip2.split(".");
	var ip1_1=ip1Array[0]*1, ip1_2=ip1Array[1]*1, ip1_3=ip1Array[2]*1, ip1_4=ip1Array[3]*1; //ip1 = ip1_1.ip1_2.ip1_3.ip1_4
	var netmask1=netmaskArray[0]*1, netmask2=netmaskArray[1]*1, netmask3=netmaskArray[2]*1, netmask4=netmaskArray[3]*1;
	var ip2_1=ip2Array[0]*1, ip2_2=ip2Array[1]*1, ip2_3=ip2Array[2]*1, ip2_4=ip2Array[3]*1; //ip2 = ip2_1.ip2_2.ip2_3.ip2_4
	
	//get the subnet
	var subnet1_1=ip1_1&netmask1, subnet1_2=ip1_2&netmask2, subnet1_3=ip1_3&netmask3, subnet1_4=ip1_4&netmask4;
	var subnet2_1=ip2_1&netmask1, subnet2_2=ip2_2&netmask2, subnet2_3=ip2_3&netmask3, subnet2_4=ip2_4&netmask4;
	
	//compare the subnet
	if((subnet1_1!=subnet2_1) || 
	   (subnet1_2!=subnet2_2) ||
	   (subnet1_3!=subnet2_3) ||
	   (subnet1_4!=subnet2_4)) {
			return false;
	}
	
	return true;
}

function isHostAddr(ip, netmask)
{
    if (netmask == "255.255.255.255")
        return true;

	var ipArray = ip.split(".");
	var netmaskArray = netmask.split(".");
	
	var ip1_1=ipArray[0]*1, ip1_2=ipArray[1]*1, ip1_3=ipArray[2]*1, ip1_4=ipArray[3]*1;
	var netmask1=netmaskArray[0]*1, netmask2=netmaskArray[1]*1, netmask3=netmaskArray[2]*1, netmask4=netmaskArray[3]*1;
	var ip2_1=ip1_1&netmask1, ip2_2=ip1_2&netmask2, ip2_3=ip1_3&netmask3, ip2_4=ip1_4&netmask4;
		
	if(ip1_1==ip2_1 && ip1_2==ip2_2 && ip1_3==ip2_3 && ip1_4==ip2_4){
		return false;
	}	
	return true;
}

function checkRouteTable(isLanMode, ipElement, gatewayElement, maskElement)
{
    var currentLanIP = "<% nvram_get("lan_ipaddr"); %>";
    var currentLanMask = "<% nvram_get("lan_netmask"); %>";
    var isHostAddress = isHostAddr(ipElement.value, maskElement.value);
    
    if (isLanMode)
    {
        if(!checkSubnet(gatewayElement.value, maskElement.value, currentLanIP) || 
           (currentLanIP == "" && gatewayElement.value != "0.0.0.0")) 
        {
			Alert.render("<!--#tr id="routing.alert.5"-->The next hop is unreachable via LAN interface!<!--#endtr-->");
			gatewayElement.focus();
			return false;
		}
    }
    else
    {
        if (checkSameSubnet(gatewayElement.value, currentLanIP, currentLanMask))
        {
			Alert.render("<!--#tr id="routing.alert.6"-->Incorrect route settings. Please enter a valid IP network address/subnet address or valid host gateway address within the IP subnet defined by the subnet mask. Otherwise, please modify the subnet mask accordingly.<!--#endtr-->");
			gatewayElement.focus();
			return false;
	    }        
    }
    
	if (isHostAddress && maskElement.value != "255.255.255.255") // route add -host
	{
		Alert.render("<!--#tr id="routing.alert.7"-->The netmask must be set to \'255.255.255.255\' when the destination addrress is a host!<!--#endtr-->");
		maskElement.focus();
		return false;
	}
	else if (!isHostAddress && maskElement.value == "255.255.255.255") // route add -net
    {
        Alert.render("<!--#tr id="routing.alert.8"-->The netmask can not be set to \'255.255.255.255\' when the destination addrress is a network!<!--#endtr-->");
        maskElement.focus();
        return false;
	}
	
	return true;
}
    
function applyCheck()
{
    var TOTAL = 5;
    var checkElementList = [["wanIP", "wanMask", "wanGateway", "wanMetric"], 
        ["lanIP", "lanMask", "lanGateway", "lanMetric"]];

    for (var item = 0; item < checkElementList.length; item++)
    {
        for (var i = 0; i < TOTAL; i++)
        {
            var ipElement = document.getElementById(checkElementList[item][0] + i);
            var maskElement = document.getElementById(checkElementList[item][1] + i);
            var gatewayElement = document.getElementById(checkElementList[item][2] + i);
            var metricElement = document.getElementById(checkElementList[item][3] + i);

            // 1. If the values of the column in this row is all blank, it will pass the check.
            if (isBlankString(ipElement.value) && isBlankString(maskElement.value) && isBlankString(gatewayElement.value) && isBlankString(metricElement.value))
                continue;

            // 2. Check Gateway
            if (isBlankString(gatewayElement.value)) 
            {
                gatewayElement.value = "0.0.0.0";
            }
            else if (!checkIPv4Format(gatewayElement.value)) 
            {
                gatewayElement.focus();
                return false;
            }

            // 3. Check IP
            if (!checkIPv4Format(ipElement.value)) 
            {
                ipElement.focus();
                Alert.render("<!--#tr id="routing.alert.3" -->IP Address only accept [0-9.] characters.<!--#endtr -->");
                return false;
            }

            // 4. Check Netmask
            if (!checkIPv4Format(maskElement.value)) 
            {
                maskElement.focus();
                Alert.render("<!--#tr id="routing.alert.3" -->IP Address only accept [0-9.] characters.<!--#endtr -->");
                return false;
            }

            // 5. Check Metric
            if (isBlankString(metricElement.value)) 
            {
                metricElement.value = "1";
            }
            if(!is_number(metricElement.value)) {
                Alert.render("<!--#tr id="routing.alert.1"-->Please input the value of Metric between 1 and 15.<!--#endtr-->");
                metricElement.focus();
                return false;
            }
            if(!checkInteger(metricElement.value)) {
                Alert.render("<!--#tr id="routing.alert.1"-->Please input the value of Metric between 1 and 15.<!--#endtr-->");
                metricElement.focus();
                return false;
            }
            if (!checkRange(metricElement.value, 1, 15)) 
            {
                metricElement.focus();
                Alert.render("<!--#tr id="routing.alert.1"-->Please input the value of Metric between 1 and 15.<!--#endtr-->");
                return false;
            }

            // 6. Check relation
            if (!checkRouteTable(item == 1 ? true : false, ipElement, gatewayElement, maskElement))
                return false;

            // 7. Check duplicate rules
            for (var j = i-1; j > -1; j--)
            {
                if (ipElement.value == document.getElementById(checkElementList[item][0] + j).value &&
                    maskElement.value == document.getElementById(checkElementList[item][1] + j).value &&
                    gatewayElement.value == document.getElementById(checkElementList[item][2] + j).value &&
                    metricElement.value == document.getElementById(checkElementList[item][3] + j).value)
                {
                    ipElement.focus();
                    Alert.render("<!--#tr id="routing.alert.9"-->This entry had be defined in static route list. If you want to redefined it, please 'delete' the previous entry in static route list first!!<!--#endtr-->");
                    return false;
                }
            }
        } 
    }

	totalWaitTime = 25;
	wait_page();
	document.getElementById("waitPad").style.display="block";
	scroll(0,0);
	return true;
}

function page_load() {
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
<h1><!--#tr id="route.title"-->Static Route Settings<!--#endtr--></h1>
<div class="hr" ></div>
<p>
<!--#tr id="route.desc"-->The static routing option allows you to define fixed routes to specific destinations.<!--#endtr-->
</p>

<form name="lan" method="post" action="/uapply.cgi" onSubmit="return applyCheck();" target="rebootRedirect">
<input type="hidden" name="page" value="/internet/routing.asp">
<input type="hidden" name="token" value="<% genToken(); %>">
<!-- These are set by the Javascript functions above --> 
<!--<input type="hidden" name="num_lan_ifaces" value="2">
<input type="hidden" name="lan_ifname" value="" >
<input type="hidden" name="lan1_ifname" value="" >-->
<table width="100%" class="tbl_main">
	<tr>
		<td class="CT" colspan="2"><!--#tr id="route.wan.static.route"-->WAN Static Routes<!--#endtr--></td>
	</tr>
	<tr>
		<td>
			<table width="100%" class="tbl_main2">
				<tr>
					<input type="hidden" name="wan_route" value="5">
					<td class="form_list_title"><!--#tr id="ip.address"-->IP Address<!--#endtr--></td>
					<td class="form_list_title"><!--#tr id="subnet.mask"-->Subnet Mask<!--#endtr--></td>
					<td class="form_list_title"><!--#tr id="gateway"-->Gateway<!--#endtr--></td>
					<td class="form_list_title"><!--#tr id="metric"-->Metric<!--#endtr--></td>
				</tr>
				<tr>
					<td class="form_list_content"><input id="wanIP0" name="wan_route_ipaddr0" value="<% wan_route("ipaddr", 0); %>" size="15" maxlength="15" onkeydown="return prevent_press_enter(event);"></td>
					<td class="form_list_content"><input id="wanMask0" name="wan_route_netmask0" value="<% wan_route("netmask", 0); %>" size="15" maxlength="15" onkeydown="return prevent_press_enter(event);"></td>
					<td class="form_list_content"><input id="wanGateway0" name="wan_route_gateway0" value="<% wan_route("gateway", 0); %>" size="15" maxlength="15" onkeydown="return prevent_press_enter(event);"></td>
					<td class="form_list_content"><input id="wanMetric0" name="wan_route_metric0" value="<% wan_route("metric", 0); %>" size="2" maxlength="2" onkeydown="return prevent_press_enter(event);"></td>
				</tr>
				<tr>
					<td class="form_list_content"><input id="wanIP1" name="wan_route_ipaddr1" value="<% wan_route("ipaddr", 1); %>" size="15" maxlength="15" onkeydown="return prevent_press_enter(event);"></td>
					<td class="form_list_content"><input id="wanMask1" name="wan_route_netmask1" value="<% wan_route("netmask", 1); %>" size="15" maxlength="15" onkeydown="return prevent_press_enter(event);"></td>
					<td class="form_list_content"><input id="wanGateway1" name="wan_route_gateway1" value="<% wan_route("gateway", 1); %>" size="15" maxlength="15" onkeydown="return prevent_press_enter(event);"></td>
					<td class="form_list_content"><input id="wanMetric1" name="wan_route_metric1" value="<% wan_route("metric", 1); %>" size="2" maxlength="2" onkeydown="return prevent_press_enter(event);"></td>
				</tr>
				<tr>
					<td class="form_list_content"><input id="wanIP2" name="wan_route_ipaddr2" value="<% wan_route("ipaddr", 2); %>" size="15" maxlength="15" onkeydown="return prevent_press_enter(event);"></td>
					<td class="form_list_content"><input id="wanMask2" name="wan_route_netmask2" value="<% wan_route("netmask", 2); %>" size="15" maxlength="15" onkeydown="return prevent_press_enter(event);"></td>
					<td class="form_list_content"><input id="wanGateway2" name="wan_route_gateway2" value="<% wan_route("gateway", 2); %>" size="15" maxlength="15" onkeydown="return prevent_press_enter(event);"></td>
					<td class="form_list_content"><input id="wanMetric2" name="wan_route_metric2" value="<% wan_route("metric", 2); %>" size="2" maxlength="2" onkeydown="return prevent_press_enter(event);"></td>
				</tr>
				<tr>
					<td class="form_list_content"><input id="wanIP3" name="wan_route_ipaddr3" value="<% wan_route("ipaddr", 3); %>" size="15" maxlength="15" onkeydown="return prevent_press_enter(event);"></td>
					<td class="form_list_content"><input id="wanMask3" name="wan_route_netmask3" value="<% wan_route("netmask", 3); %>" size="15" maxlength="15" onkeydown="return prevent_press_enter(event);"></td>
					<td class="form_list_content"><input id="wanGateway3" name="wan_route_gateway3" value="<% wan_route("gateway", 3); %>" size="15" maxlength="15" onkeydown="return prevent_press_enter(event);"></td>
					<td class="form_list_content"><input id="wanMetric3" name="wan_route_metric3" value="<% wan_route("metric", 3); %>" size="2" maxlength="2" onkeydown="return prevent_press_enter(event);"></td>
				</tr>
				<tr>
					<td class="form_list_content"><input id="wanIP4" name="wan_route_ipaddr4" value="<% wan_route("ipaddr", 4); %>" size="15" maxlength="15" onkeydown="return prevent_press_enter(event);"></td>
					<td class="form_list_content"><input id="wanMask4" name="wan_route_netmask4" value="<% wan_route("netmask", 4); %>" size="15" maxlength="15" onkeydown="return prevent_press_enter(event);"></td>
					<td class="form_list_content"><input id="wanGateway4" name="wan_route_gateway4" value="<% wan_route("gateway", 4); %>" size="15" maxlength="15" onkeydown="return prevent_press_enter(event);"></td>
					<td class="form_list_content"><input id="wanMetric4" name="wan_route_metric4" value="<% wan_route("metric", 4); %>" size="2" maxlength="2" onkeydown="return prevent_press_enter(event);"></td>
				</tr>
			</table>
		</td>
	</tr>
</table>

<table width="100%" class="tbl_main">
	<tr>
		<td class="CT" colspan="2"><!--#tr id="route.lan.static.route"-->LAN Static Routes<!--#endtr--></td>
	</tr>
	<tr>
		<td>
			<table width="100%" class="tbl_main2">
				<tr>
					<input type="hidden" name="lan_route" value="5">
					<td class="form_list_title"><!--#tr id="ip.address"-->IP Address<!--#endtr--></td>
					<td class="form_list_title"><!--#tr id="subnet.mask"-->Subnet Mask<!--#endtr--></td>
					<td class="form_list_title"><!--#tr id="gateway"-->Gateway<!--#endtr--></td>
					<td class="form_list_title"><!--#tr id="metric"-->Metric<!--#endtr--></td>
				</tr>
				<tr>
					<td class="form_list_content"><input id="lanIP0"      name="lan_route_ipaddr0" value="<% lan_route("ipaddr", 0); %>" size="15" maxlength="15" onkeydown="return prevent_press_enter(event);"></td>
					<td class="form_list_content"><input id="lanMask0"    name="lan_route_netmask0" value="<% lan_route("netmask", 0); %>" size="15" maxlength="15" onkeydown="return prevent_press_enter(event);"></td>
					<td class="form_list_content"><input id="lanGateway0" name="lan_route_gateway0" value="<% lan_route("gateway", 0); %>" size="15" maxlength="15" onkeydown="return prevent_press_enter(event);"></td>
					<td class="form_list_content"><input id="lanMetric0"  name="lan_route_metric0" value="<% lan_route("metric", 0); %>" size="2" maxlength="2"onkeydown="return prevent_press_enter(event);"></td>
				</tr>                                                 
				<tr>                                                  
					<td class="form_list_content"><input id="lanIP1"      name="lan_route_ipaddr1" value="<% lan_route("ipaddr", 1); %>" size="15" maxlength="15" onkeydown="return prevent_press_enter(event);"></td>
					<td class="form_list_content"><input id="lanMask1"    name="lan_route_netmask1" value="<% lan_route("netmask", 1); %>" size="15" maxlength="15" onkeydown="return prevent_press_enter(event);"></td>
					<td class="form_list_content"><input id="lanGateway1" name="lan_route_gateway1" value="<% lan_route("gateway", 1); %>" size="15" maxlength="15" onkeydown="return prevent_press_enter(event);"></td>
					<td class="form_list_content"><input id="lanMetric1"  name="lan_route_metric1" value="<% lan_route("metric", 1); %>" size="2" maxlength="2" onkeydown="return prevent_press_enter(event);"></td>
				</tr>                                                 
				<tr>                                                  
					<td class="form_list_content"><input id="lanIP2"      name="lan_route_ipaddr2" value="<% lan_route("ipaddr", 2); %>" size="15" maxlength="15" onkeydown="return prevent_press_enter(event);"></td>
					<td class="form_list_content"><input id="lanMask2"    name="lan_route_netmask2" value="<% lan_route("netmask", 2); %>" size="15" maxlength="15" onkeydown="return prevent_press_enter(event);"></td>
					<td class="form_list_content"><input id="lanGateway2" name="lan_route_gateway2" value="<% lan_route("gateway", 2); %>" size="15" maxlength="15" onkeydown="return prevent_press_enter(event);"></td>
					<td class="form_list_content"><input id="lanMetric2"  name="lan_route_metric2" value="<% lan_route("metric", 2); %>" size="2" maxlength="2" onkeydown="return prevent_press_enter(event);"></td>
				</tr>                                                 
				<tr>                                                  
					<td class="form_list_content"><input id="lanIP3"      name="lan_route_ipaddr3" value="<% lan_route("ipaddr", 3); %>" size="15" maxlength="15" onkeydown="return prevent_press_enter(event);"></td>
					<td class="form_list_content"><input id="lanMask3"    name="lan_route_netmask3" value="<% lan_route("netmask", 3); %>" size="15" maxlength="15" onkeydown="return prevent_press_enter(event);"></td>
					<td class="form_list_content"><input id="lanGateway3" name="lan_route_gateway3" value="<% lan_route("gateway", 3); %>" size="15" maxlength="15" onkeydown="return prevent_press_enter(event);"></td>
					<td class="form_list_content"><input id="lanMetric3"  name="lan_route_metric3" value="<% lan_route("metric", 3); %>" size="2" maxlength="2" onkeydown="return prevent_press_enter(event);"></td>
				</tr>                                                 
				<tr>                                                  
					<td class="form_list_content"><input id="lanIP4"      name="lan_route_ipaddr4" value="<% lan_route("ipaddr", 4); %>" size="15" maxlength="15" onkeydown="return prevent_press_enter(event);"></td>
					<td class="form_list_content"><input id="lanMask4"    name="lan_route_netmask4" value="<% lan_route("netmask", 4); %>" size="15" maxlength="15" onkeydown="return prevent_press_enter(event);"></td>
					<td class="form_list_content"><input id="lanGateway4" name="lan_route_gateway4" value="<% lan_route("gateway", 4); %>" size="15" maxlength="15" onkeydown="return prevent_press_enter(event);"></td>
					<td class="form_list_content"><input id="lanMetric4"  name="lan_route_metric4" value="<% lan_route("metric", 4); %>" size="2" maxlength="2" onkeydown="return prevent_press_enter(event);"></td>
				</tr>
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
</form>

<table width="100%" class="tbl_main">
	<tr>
		<td class="CT" colspan="2"><!--#tr id="route.routing.table"-->Routing Table<!--#endtr--></td>
	</tr>
	<tr>
		<td>
			<table width="100%" class="tbl_main2">
				<tr>
					<td class="form_list_title" width="120px" align="center"><!--#tr id="ip"-->IP<!--#endtr--></td>
					<td class="form_list_title" width="120px" align="center"><!--#tr id="netmask"-->Netmask<!--#endtr--></td>
					<td class="form_list_title" width="120px" align="center"><!--#tr id="gateway"-->Gateway<!--#endtr--></td>
					<td class="form_list_title" align="center"><!--#tr id="metric"-->Metric<!--#endtr--></td>
					<td class="form_list_title" align="center"><!--#tr id="interface"-->Interface<!--#endtr--></td>
				</tr>
				<div id="firstRoutingTable">
				<% show_routing_table(); %>
				</div>
				<div id="secondRoutingTable"></div>
			</table>
		</td>
	</tr>
</table>

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
