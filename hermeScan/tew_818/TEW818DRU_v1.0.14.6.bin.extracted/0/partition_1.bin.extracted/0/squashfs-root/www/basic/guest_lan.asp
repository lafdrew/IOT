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
<script language="JavaScript" type="text/javascript">
<!--
function inet_aton(a)
{
	var n;

	n = a.split(/\./);
	if (n.length != 4)
		return 0;

	return ((n[0] << 24) | (n[1] << 16) | (n[2] << 8) | n[3]);
}
	
function inet_ntoa(n)
{
	var a;

	a = (n >> 24) & 255;
	a += "."
	a += (n >> 16) & 255;
	a += "."
	a += (n >> 8) & 255;
	a += "."
	a += n & 255;

	return a;
}

function guest_lan_check()
{
//Disable entry to Guest LAN if we are running on VX 
//	
	var vx = "<% nvram_match("os_name", "vx", "1"); %>";
	var ap = "<% nvram_match("router_disable", "1", "1"); %>";
	
	document.lan.lan_ifname.value="<% nvram_get("lan_ifname"); %>";
	document.lan.lan1_ifname.value="<% nvram_get("lan1_ifname"); %>";

	
	if ( (ap == "1") || (vx == "1") ){
		document.lan.lan1_ifname.disabled = 1;
		document.lan.lan1_gateway.disabled = 1;
		document.lan.lan1_netmask.disabled = 1;
		document.lan.lan1_ipaddr.disabled = 1;
		document.lan.lan1_proto.disabled = 1;
		document.lan.lan1_dhcp.disabled = 1;
		document.lan.lan1_lease.disabled = 1;
		dhcp_server_mode(1, "disable");
		document.lan.num_lan_ifaces.value="1";
	}
	else{
		document.lan.num_lan_ifaces.value="2";
	}
	
		
}

function display_internal_lan()
{
	document.lan.write(document.lan.lan_ifname.value );
}

function lan_ipaddr_change()
{
	var lan_netaddr, lan_netmask, dhcp_start, dhcp_end;
	var lan1_netaddr, lan1_netmask, dhcp1_start, dhcp1_end;
	
	lan_netaddr = inet_aton(document.lan.lan_ipaddr.value);
	lan_netmask = inet_aton(document.lan.lan_netmask.value);
	lan_netaddr &= lan_netmask;

	dhcp_start = inet_aton(document.lan.dhcp_start.value);
	dhcp_start &= ~lan_netmask;
	dhcp_start |= lan_netaddr;
	dhcp_end = inet_aton(document.lan.dhcp_end.value);
	dhcp_end &= ~lan_netmask;
	dhcp_end |= lan_netaddr;

	document.lan.dhcp_start.value = inet_ntoa(dhcp_start);
	document.lan.dhcp_end.value = inet_ntoa(dhcp_end);
	
	lan1_netaddr = inet_aton(document.lan.lan1_ipaddr.value);
	lan1_netmask = inet_aton(document.lan.lan1_netmask.value);
	lan1_netaddr &= lan1_netmask;

	dhcp1_start = inet_aton(document.lan.dhcp1_start.value);
	dhcp1_start &= ~lan1_netmask;
	dhcp1_start |= lan1_netaddr;
	dhcp1_end = inet_aton(document.lan.dhcp1_end.value);
	dhcp1_end &= ~lan1_netmask;
	dhcp1_end |= lan1_netaddr;

	document.lan.dhcp1_start.value = inet_ntoa(dhcp1_start);
	document.lan.dhcp1_end.value = inet_ntoa(dhcp1_end);
	document.lan.lan1_lease.value = "<% nvram_get("lan1_lease"); %>";
	if (document.lan.lan1_lease.value == "")
		document.lan.lan1_lease.value = "<% nvram_get("lan_lease"); %>";

	document.lan.lan_gateway.value = document.lan.lan_ipaddr.value;
	document.lan.lan1_gateway.value = document.lan.lan1_ipaddr.value;
}
function lan_dhcp_change(index)
{
	var dhcp = document.lan.lan_dhcp[document.lan.lan_dhcp.selectedIndex].value;
	var dhcp1 = document.lan.lan1_dhcp[document.lan.lan1_dhcp.selectedIndex].value;
	
	if (index == "0"){
		if (document.lan.lan_dhcp.disabled == 1 || dhcp == "0") {
			document.lan.lan_gateway.disabled = 0;
			document.lan.lan_netmask.disabled = 0;
			document.lan.lan_ipaddr.disabled = 0;
		}
		else {
			document.lan.lan_gateway.disabled = 1;
			document.lan.lan_netmask.disabled = 1;
			document.lan.lan_ipaddr.disabled = 1;
		}
	}
	else if (index == "1"){
	
		if (document.lan.lan1_dhcp.disabled == 1 || dhcp1 == "0") {
			document.lan.lan1_netmask.disabled = 0;
			document.lan.lan1_ipaddr.disabled = 0;
		}
		else {
			document.lan.lan1_netmask.disabled = 1;
			document.lan.lan1_ipaddr.disabled = 1;
			document.lan.dhcp1_start.disabled = 1;
		
		}
	}
}

function dhcp_server_mode(index, mode)
{
	var disabled;
	var visibility;
	var display;

	if (mode == "enable"){
		disabled = 0;
		visibility = "visible";
		display = "block";
	}
	else {
		disabled = 1;
		visibility = "hidden";
		display = "none";
	}
	
	if (index == 0) {
		document.lan.dhcp_start.disabled = disabled;
		document.lan.dhcp_end.disabled = disabled;
		document.lan.lan_lease.disabled = disabled;

		document.getElementById("dhcpReserveForm").style.visibility = visibility;
		document.getElementById("dhcpReserveForm").style.display = display;
	}
	else if (index ==1) {
		document.lan.dhcp1_start.disabled = disabled;
		document.lan.dhcp1_end.disabled = disabled;
		document.lan.lan1_lease.disabled = disabled;

		document.getElementById("dhcpReserveForm").style.visibility = visibility;
		document.getElementById("dhcpReserveForm").style.display = display;
	}
/*
	if (document.getElementById("hdcp_rsvdTable").style.display == "none"
		&& document.getElementById("hdcp1_rsvdTable").style.display == "none") {
		document.getElementById("dhcpReserveForm").style.visibility = "hidden";
		document.getElementById("dhcpReserveForm").style.display = "none"
	}
	else {
		document.getElementById("dhcpReserveForm").style.visibility = "visible";
		document.getElementById("dhcpReserveForm").style.display = "block"
	}
*/	
}

function lan_dhcp_server_change(index)
{
	var proto = document.lan.lan_proto[document.lan.lan_proto.selectedIndex].value;
	var proto1 = document.lan.lan1_proto[document.lan.lan1_proto.selectedIndex].value;
	
	if (index == 0){
		if (document.lan.lan_proto.disabled == 1 || proto == "static") {
			dhcp_server_mode(0, "disable");
		}
		else {
			dhcp_server_mode(0, "enable");
		}
	}
	else if (index == 1){
	
		if (document.lan.lan1_proto.disabled == 1 || proto1 == "static") {
			dhcp_server_mode(1, "disable");
		}
		else {
			dhcp_server_mode(1, "enable");
		}
	}
	
}

function lan_update()
{
	var ap = "<% nvram_match("router_disable", "1", "1"); %>";
	var dhcp = "<% nvram_match("lan_proto", "static", "static"); %>";
	var dhcp1= "<% nvram_match("lan1_proto", "static", "static"); %>";
	var ure_disable = "<% nvram_get("ure_disable"); %>";
	
	
	if (ap == "1") {
		document.lan.lan_dhcp.disabled = 0;
		document.lan.lan_proto.disabled = 1;

		dhcp_server_mode(0, "disable")
		
	}
	else {
		document.lan.lan_dhcp.disabled = 1;
		document.lan.lan_proto.disabled = 0;
		dhcp_server_mode(0, "enable");
		document.lan.lan1_dhcp.disabled = 1;
		document.lan.lan1_proto.disabled = 0;
		dhcp_server_mode(1, "enable");
		if(dhcp == "static") {
			dhcp_server_mode(0, "disable");
		}
		if(dhcp1 == "static") {
			dhcp_server_mode(1, "disable");
		}
	}
	guest_lan_check();
	if (ure_disable == "0") {
		document.lan.lan1_ifname.disabled = 1;
		document.lan.lan1_dhcp.disabled = 1;
		document.lan.lan1_ipaddr.disabled = 1;
		document.lan.lan1_netmask.disabled = 1;
		document.lan.lan1_gateway.disabled = 1;
		document.lan.lan1_proto.disabled = 1;
		dhcp_server_mode(1, "disable");
		document.lan.lan1_stp.disabled = 1;
   }
}

function checkValue()
{
    var internalIPElement = document.getElementById("ipAddress");
    var internalMaskElement = document.getElementById("subnetMask");
    var internalGatewayElement = document.getElementById("defaultGateway");
    var internalDhcpStartIPElement = document.getElementById("dhcpStartIP");
    var internalDhcpEndIPElement = document.getElementById("dhcpEndIP");
    var internalDhcpLeaseTimeElement = document.getElementById("dhcpLeaseTime");
    
    var guestIPElement = document.getElementById("guestIpAddress");
    var guestMaskElement = document.getElementById("guestMask");
    var guestGatewayElement = document.getElementById("guestGateway");
    var guestDhcpStartIPElement = document.getElementById("guestDhcpStartIP");
    var guestDhcpEndIPElement = document.getElementById("guestDhcpEndIP");
    var guestDhcpLeaseTimeElement = document.getElementById("guestDhcpLeaseTime");
    
    // 1. Check the value of IP Address
	if (!checkIpAddr(internalIPElement, false)) {
	    internalIPElement.focus();
		return false;
	}
	else if (!checkIpAddr(guestIPElement, false)) {
	    guestIPElement.focus();
		return false;
	}

	//Tom.Hung 2013-1-3, check Internal Network and Guest Network in same subnet?
	if(checkSameSubnet(internalIPElement.value, guestIPElement.value, internalMaskElement.value) ||
		checkSameSubnet(internalIPElement.value, guestIPElement.value, guestMaskElement.value)) {
		Alert.render("<!--#tr id="lan.alert.19" -->Internal Network and Guest Network can not set in same subnet.<!--#endtr -->");
		return false;
	}
	//Tom.Hung 2013-1-3 end
	
    // 2. Check the value of Subnet Mask
	if (!checkIpAddr(internalMaskElement, true)) {
	    internalMaskElement.focus();
		return false;
	}
	else if (!checkIpAddr(guestMaskElement, true)) {
	    guestMaskElement.focus();
		return false;
	}
	
	// 3. Check the value of Default Gateway
    if (!checkIpAddr(internalGatewayElement, false)) {
        internalGatewayElement.focus();
		return false;
	}
	else if (!checkIpAddr(guestGatewayElement, false)) {
        guestGatewayElement.focus();
		return false;
	}
	
	// 4. Check IP Address and Subnet Mask if they are matched. 
	if (!checkIPwithSubnetMask(internalIPElement.value, internalMaskElement.value)) {
	    internalIPElement.focus();
		return false;
	}
	else if (!checkIPwithSubnetMask(guestIPElement.value, guestMaskElement.value)) {
	    guestIPElement.focus();
		return false;
	}

    // 5. Check DHCP Settings if DHCP is enabled
	if (document.getElementById("dhcpServerSelector").options.selectedIndex == 0) {
	    if (!checkDhcpSetting(internalIPElement, internalMaskElement,
	        internalDhcpStartIPElement, internalDhcpEndIPElement, internalDhcpLeaseTimeElement)) {
            return false;
        }
    }
    
    if (document.getElementById("guestDhcpServerSelector").options.selectedIndex == 0) { 
	    if (!checkDhcpSetting(guestIPElement, guestMaskElement,
	        guestDhcpStartIPElement, guestDhcpEndIPElement, guestDhcpLeaseTimeElement)) {
            return false;
        }
    }

    //redirectURL = internalIPElement.value + location.pathname;
	totalWaitTime = 25;
	wait_page();
	document.getElementById("waitPad").style.display="block";
	scroll(0,0);
	return true;
}

function checkDhcpSetting(ip, mask, dhcpStartIP, dhcpEndIP, dhcpLeaseTime)
{
    // 1. Check the value of DHCP Start IP
	if (!checkIpAddr(dhcpStartIP, false)) {
	    dhcpStartIP.focus();
		return false;
	}
	
	// 2. Check the value of DHCP End IP
	if (!checkIpAddr(dhcpEndIP, false)) {
	    dhcpEndIP.focus();
		return false;
	}
	
    // 3. Check the relation between DHCP Start IP and DHCP End IP. ---------- (Start IP < End IP)
	if (!checkDhcpStartEnd(dhcpStartIP.value, dhcpEndIP.value)) {
	    dhcpStartIP.focus();
		Alert.render("<!--#tr id="lan.alert.14" -->DHCP Start IP should smaller than End IP!<!--#endtr -->");
		return false;
	}
		
    // 4. Check the relation of IP Address, Subnet Mask and DHCP End IP
	if(!checkSubnet(ip.value, mask.value, dhcpEndIP.value)) {
	    Alert.render("<!--#tr id="lan.alert.11" -->Incorrect IP address and subnet mask setting.<!--#endtr -->");
	    return false;
	}

    // 5. Check the relation between DHCP Start IP and Subnet Mask.
    //    Check the relation between DHCP End IP and Subnet Mask.
	if (!checkIPwithSubnetMask(dhcpStartIP.value, mask.value) || 
		!checkIPwithSubnetMask(dhcpEndIP.value, mask.value)) {
		return false;	
	}
	
	// 6. Check DHCP Start IP <= IP Address <= DHCP End IP. If true, it is not allowed.
	var LanIP = ip.value;
	var ipstart = dhcpStartIP.value;
	var ipend = dhcpEndIP.value;
	var ns = eval(FormatNum(""+atoi(ipstart,1),3)+FormatNum(""+atoi(ipstart,2),3)+FormatNum(""+atoi(ipstart,3),3)+FormatNum(""+atoi(ipstart,4),3));
	var ne = eval(FormatNum(""+atoi(ipend,1),3)+FormatNum(""+atoi(ipend,2),3)+FormatNum(""+atoi(ipend,3),3)+FormatNum(""+atoi(ipend,4),3));
	var n = eval(FormatNum(""+atoi(LanIP,1),3)+FormatNum(""+atoi(LanIP,2),3)+FormatNum(""+atoi(LanIP,3),3)+FormatNum(""+atoi(LanIP,4),3));
	if (ns <= ne && n >= ns && n <= ne) {
		Alert.render("<!--#tr id="lan.alert.16" -->You can't set LAN IP address in DHCP pool.<!--#endtr -->");
		return false;
	}
	
	// 7. Check the format of DHCP Lease Time
	if (!is_number(dhcpLeaseTime.value) || !checkInteger(dhcpLeaseTime.value)) {
	    dhcpLeaseTime.focus();
	    Alert.render("<!--#tr id="lan.alert.17" -->DHCP Lease Time is not an integer value!<!--#endtr -->");
	    return false;
	}
	
	// 8. Check the range of DHCP Lease Time
	if (dhcpLeaseTime.value < 60 || dhcpLeaseTime.value > 604800) {
	    dhcpLeaseTime.focus();
	    Alert.render("<!--#tr id="lan.alert.18" -->DHCP Lease Time should be 60 ~ 604800!<!--#endtr -->");
	    return false;
	}
	return true;
}


function checkDhcpStartEnd(start, end)
{
	if(atoi(start, 4) > atoi(end, 4))
		return false;
	return true;
}

//Grffin TEW691GR - [+ Check mask function]
function checkSubnet(ip, mask, client)
{
  ip_d = getDigit(ip, 1);
  mask_d = getDigit(mask, 1);
  client_d = getDigit(client, 1);
  if ( (ip_d & mask_d) != (client_d & mask_d ) )
	return false;

  ip_d = getDigit(ip, 2);
  mask_d = getDigit(mask, 2);
  client_d = getDigit(client, 2);
  if ( (ip_d & mask_d) != (client_d & mask_d ) )
	return false;

  ip_d = getDigit(ip, 3);
  mask_d = getDigit(mask, 3);
  client_d = getDigit(client, 3);
  if ( (ip_d & mask_d) != (client_d & mask_d ) )
	return false;

  ip_d = getDigit(ip, 4);
  mask_d = getDigit(mask, 4);
  client_d = getDigit(client, 4);
  if ( (ip_d & mask_d) != (client_d & mask_d ) )
	return false;

  return true;
}

function getDigit(str, num)
{
  i=1;
  if ( num != 1 ) {
  	while (i!=num && str.length!=0) {
		if ( str.charAt(0) == '.' ) {
			i++;
		}
		str = str.substring(1);
  	}
  	if ( i!=num )
  		return -1;
  }
  for (i=0; i<str.length; i++) {
  	if ( str.charAt(i) == '.' ) {
		str = str.substring(0, i);
		break;
	}
  }
  if ( str.length == 0)
  	return -1;
  d = parseInt(str, 10);
  return d;
}

//Tom.Hung 2009-2-19, number format
function FormatNum(Source,Length){  
	var strTemp="";  
	for(i=1;i<=Length-Source.length;i++){  
		strTemp+="0";  
	}  
	return strTemp+Source;  
}

// Annie.Weng @20130104: TEW-812DRU, support DHCP reservation
function checkDhcpReservations()
{
	var lanMask;
	var dhcpStartIP;
	var dhcpEndIP;
	var prefix;

	for (var idx=0; idx <2; idx++)
	{
		if (idx==0){
			prefix = "dhcp_rsvd";
			lanMask = "<% nvram_get("lan_netmask"); %>";
			dhcpStartIP = "<% nvram_get("dhcp_start"); %>";
			dhcpEndIP = "<% nvram_get("dhcp_end"); %>";
		}
		else{
			prefix = "dhcp"+idx+"_rsvd";
			lanMask = "<% nvram_get("lan1_netmask"); %>";
			dhcpStartIP = "<% nvram_get("dhcp1_start"); %>";
			dhcpEndIP = "<% nvram_get("dhcp1_end"); %>";
		}

		var len = document.getElementById(prefix+"List").value;	

		for (var i = 0; i < len; i++)
		{
			var rsvdHostname = document.getElementById(prefix+"Hostname"+i);
			var rsvdIp = document.getElementById(prefix+"Ipaddr"+i);
			var rsvdMac = document.getElementById(prefix+"Macaddr"+i);

			var isEmptyRow = isBlankString(rsvdHostname.value) && 
			isBlankString(rsvdIp.value) && isBlankString(rsvdMac.value);

			if (isEmptyRow){
				continue;
			}

			// 1. Check: Rule of Computer Name
			var re = /^[\w\-]+$/;  
			if (!isBlankString(rsvdHostname.value) && !re.test(rsvdHostname.value)) {
				alert("<!--#tr id="mg.alert.2"-->Host Name only accept [0-9a-zA-Z_-] characters.<!--#endtr-->");
				rsvdHostname.focus();
				return false;
			}

			// 2. Check: IP value
			if (!checkIpAddr(rsvdIp,false)) {
				rsvdIp.focus();
				return false;
			}

			// 3. Check: DHCP Start IP <= IP Address <= DHCP End IP.
			var dhcprip=rsvdIp.value;
			if (atoi(dhcprip, 4) < atoi(dhcpStartIP, 4) || atoi(dhcprip, 4) > atoi(dhcpEndIP, 4) || !checkSameSubnet(dhcpStartIP, dhcprip ,lanMask)) {
				alert("<!--#tr id="lan.alert.20" -->The reservation IP address must be within the DHCP IP address range.<!--#endtr -->");
				rsvdIp.focus();
				return false;
			}

			// 4. Check: MAC Address should not be empty!
			if ( isBlankString(rsvdMac.value)){
				alert("<!--#tr id="um.js.18" -->Error. MAC address is empty.<!--#endtr -->");			
				rsvdMac.focus();
				return false;
			}

			// 5. Check: if the MAC address is invalid
			if (!checkMACAddr(rsvdMac) ) {
				alert("<!--#tr id="mac.address.error"-->Invalid MAC address! Please enter a valid MAC address.<!--#endtr-->");
				rsvdMac.focus();
				return false;
			}

			// 6. Check: if MAC address correct
			if (rsvdMac.value.toLowerCase() == "00:00:00:00:00:00" ||
				rsvdMac.value.toLowerCase() == "ff:ff:ff:ff:ff:ff") {
				alert("<!--#tr id="mac.address.error"-->Invalid MAC address! Please enter a valid MAC address.<!--#endtr-->");
				rsvdMac.focus();
				return false;
			}
		
			// 7. Check: MAC Address can not be a multicast or broadcast MAC Address
			if (multicastMAC(rsvdMac) || broadcastMAC(rsvdMac)) {
				alert("<!--#tr id="wan.alert.12"-->MAC Address can't be a multicast or broadcast MAC Address!<!--#endtr-->");
				rsvdMac.focus();
				return false;
			}

			for (var j = 0; j < i; j++)
			{
				var tmpHostname = document.getElementById(prefix+"Hostname"+j);
				var tmpIp = document.getElementById(prefix+"Ipaddr"+j);
				var tmpMac = document.getElementById(prefix+"Macaddr"+j);

				var isTmpRowEmpty = isBlankString(tmpHostname.value) && 
				isBlankString(tmpIp.value) && isBlankString(tmpMac.value);

				if (isTmpRowEmpty){
					continue;
				}

				// 8. Hostname should be unique
				if ( !isBlankString(rsvdHostname.value)
					&& rsvdHostname.value == tmpHostname.value){
					alert("<!--#tr id="lan.alert.21"-->This Hostname is already set in another rule.<!--#endtr-->");
					rsvdHostname.focus();
					return false;
				}

				// 9. IP Address must be unique
				if (rsvdIp.value == tmpIp.value){
					alert("<!--#tr id="lan.alert.22"-->This IP Address is already set in another rule.<!--#endtr-->");
					rsvdIp.focus();
					return false;
				}

				// 10. This MAC Address must be unique
				if (rsvdMac.value.toLowerCase() == tmpMac.value.toLowerCase()){
					alert("<!--#tr id="lan.alert.23"-->This MAC Address is already set in another rule.<!--#endtr-->");
					rsvdMac.focus();
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
	lan_update();
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
<h1><!--#tr id="guest.7"-->Advanced Guest Network Settings<!--#endtr--></h1>
<div class="hr" ></div>
<p>
<!--#tr id="guest.8"-->This page allows you to configure the advanced guest network settings of the router.<!--#endtr-->
</p>

<form name="lan" method="post" action="/uapply.cgi" onSubmit="return checkValue();" target="rebootRedirect">
<input type="hidden" name="page" value="/basic/guest_lan.asp">
<input type="hidden" name="token" value="<% genToken(); %>">
<!-- These are set by the Javascript functions above --> 
<input type="hidden" name="num_lan_ifaces" value="2">
<input type="hidden" name="lan_ifname" value="" >
<input type="hidden" name="lan1_ifname" value="" >
<table width="100%" class="tbl_main">
	<tr>
		<td class="CT" colspan="3"><!--#tr id="guest.9"-->Guest Network Interface Setting<!--#endtr--></td>
	</tr>
	<tr style="display:none">
		<td class="CL">
		<!--#tr id="lan.12"-->Configured Networks<!--#endtr-->
		</td>
		<td class="CR2" style="display:none"><B><!--#tr id="internal.network"-->Internal Network<!--#endtr--></B></td>
		<td class="CR2"><B><!--#tr id="guest.network"-->Guest Network<!--#endtr--></B></td>
	</tr>
	<tr>
		<td class="CL"
		onMouseOver="return overlib('Shows the MAC address (also known as Ethernet address) of the LAN interface.', LEFT);"
		onMouseOut="return nd();">
		<!--#tr id="mac.address"-->MAC Address<!--#endtr-->
		</td>
		<td class="CR2" style="display:none"><% nvram_get("lan_hwaddr"); %></td>
		<td class="CR2" <% nvram_invmatch("wl_unit_if", "0", "style=display:none"); %>><% nvram_get("wl0.3_hwaddr"); %></td>
		<td class="CR2" <% nvram_invmatch("wl_unit_if", "1", "style=display:none"); %>><% nvram_get("wl1.3_hwaddr"); %></td>
	</tr> 
	<tr style="display:none">
		<td class="CL"
		onMouseOver="return overlib('Selects interfaces for LAN ', LEFT);"
		onMouseOut="return nd();">
		LAN Interface
		</td>
		<td class="CR2" style="display:none"><% nvram_get("lan_ifname"); %></td>
		<td class="CR2"><% nvram_get("lan1_ifname"); %></td>
	</tr>  
	<tr style="display:none">
		<td class="CL"
		onMouseOver="return overlib('Sets the method to use to obtain an IP address of the LAN interface.', LEFT);"
		onMouseOut="return nd();">
		Protocol
		</td>
		<td class="CR2" style="display:none">
			<select name="lan_dhcp" onChange="lan_dhcp_change(0);">
				<option value="1" <% nvram_match("lan_dhcp", "1", "selected"); %>>DHCP</option>
				<option value="0" <% nvram_match("lan_dhcp", "0", "selected"); %>>Static</option>
			</select>
		</td>
		<td class="CR2" style="display:none">
			<select name="lan1_dhcp" onChange="lan_dhcp_change(1);">
				<option value="1" <% nvram_match("lan1_dhcp", "1", "selected"); %>>DHCP</option>
				<option value="0" <% nvram_match("lan1_dhcp", "0", "selected"); %>>Static</option>
			</select>
		</td>
	</tr>  
	<tr>
		<td class="CL"
		onMouseOver="return overlib('Sets the IP address of the LAN interface.', LEFT);"
		onMouseOut="return nd();">
		<!--#tr id="ip.address"-->IP Address<!--#endtr-->
		</td>
		<td class="CR2" style="display:none">
			<input id="ipAddress" name="lan_ipaddr" value="<% nvram_get("lan_ipaddr"); %>" size="15" maxlength="15" onChange="lan_ipaddr_change();" onkeydown="return prevent_press_enter(event);">
		</td>
		<td class="CR2">
			<input id="guestIpAddress" name="lan1_ipaddr" value="<% nvram_get("lan1_ipaddr"); %>" size="15" maxlength="15" onChange="lan_ipaddr_change();" onkeydown="return prevent_press_enter(event);">
		</td>
	</tr>
	<tr>
		<td class="CL"
		onMouseOver="return overlib('Sets the IP netmask of the LAN interface.', LEFT);"
		onMouseOut="return nd();">
		<!--#tr id="subnet.mask"-->Subnet Mask<!--#endtr-->
		</td>
		<td class="CR2" style="display:none">
			<input id="subnetMask" name="lan_netmask" value="<% nvram_get("lan_netmask"); %>" size="15" maxlength="15" onChange="lan_ipaddr_change();" onkeydown="return prevent_press_enter(event);">
		</td>
		<td class="CR2">
			<input id="guestMask" name="lan1_netmask" value="<% nvram_get("lan1_netmask"); %>" size="15" maxlength="15" onChange="lan_ipaddr_change();" onkeydown="return prevent_press_enter(event);">
		</td>
	</tr>
	<tr style="display:none">
		<td class="CL"
		onMouseOver="return overlib('Sets the Default Gateway of the LAN interface.', LEFT);"
		onMouseOut="return nd();">
		<!--#tr id="default.gateway"-->Default Gateway<!--#endtr-->
		</td>
		<td class="CR2" style="display:none">
			<input id="defaultGateway" name="lan_gateway" value="<% nvram_get("lan_gateway"); %>" size="15" maxlength="15" onkeydown="return prevent_press_enter(event);">
		</td>
		<td class="CR2">
			<input id="guestGateway" name="lan1_gateway" value="<% nvram_get("lan1_gateway"); %>" size="15" maxlength="15" onkeydown="return prevent_press_enter(event);">
		</td>
	</tr>
</table>

<table width="100%" class="tbl_main">
	<tr>
		<td class="CT" colspan="3"><!--#tr id="lan.6"-->DHCP Server Setting<!--#endtr--></td>
	</tr>
	<tr style="display:none">
		<td class="CL">
		<!--#tr id="lan.12"-->Configured Networks<!--#endtr-->
		</td>
		<td class="CR2" style="display:none"><B><!--#tr id="internal.network"-->Internal Network<!--#endtr--></B></td>
		<td class="CR2"><B><!--#tr id="guest.network"-->Guest Network<!--#endtr--></B></td>
	</tr>
	<tr>
		<td class="CL"
		onMouseOver="return overlib('Enables DHCP Server functionality on the LAN.', LEFT);"
		onMouseOut="return nd();">
		<!--#tr id="lan.7"-->DHCP Server<!--#endtr-->
		</td>
		<td class="CR2" style="display:none">
			<select id="dhcpServerSelector" name="lan_proto" onChange="lan_dhcp_server_change(0);"> 
				<option value="dhcp" <% nvram_match("lan_proto", "dhcp", "selected"); %>><!--#tr id="enabled"-->Enabled<!--#endtr--></option>
				<option value="static" <% nvram_match("lan_proto", "static", "selected"); %>><!--#tr id="disabled"-->Disabled<!--#endtr--></option>
			</select>
		</td>
		<td class="CR2">
			<select id="guestDhcpServerSelector" name="lan1_proto" onChange="lan_dhcp_server_change(1);"> 
				<option value="dhcp" <% nvram_match("lan1_proto", "dhcp", "selected"); %>><!--#tr id="enabled"-->Enabled<!--#endtr--></option>
				<option value="static" <% nvram_match("lan1_proto", "static", "selected"); %>><!--#tr id="disabled"-->Disabled<!--#endtr--></option>
			</select>
		</td>
	</tr>
	<tr>
		<td class="CL"
		onMouseOver="return overlib('Sets the start of the IP address range that the DHCP Server will use.', LEFT);"
		onMouseOut="return nd();">
		<!--#tr id="lan.8"-->DHCP Start IP<!--#endtr-->
		</td>
		<td class="CR2" style="display:none">
			<input id="dhcpStartIP" name="dhcp_start" value="<% nvram_get("dhcp_start"); %>" size="15" maxlength="15" onkeydown="return prevent_press_enter(event);">
		</td>
		<td class="CR2">
			<input id="guestDhcpStartIP" name="dhcp1_start" value="<% nvram_get("dhcp1_start"); %>" size="15" maxlength="15" onkeydown="return prevent_press_enter(event);">
		</td>
	</tr>
	<tr>
		<td class="CL"
		onMouseOver="return overlib('Sets the end of the IP address range that the DHCP Server will use.', LEFT);"
		onMouseOut="return nd();">
		<!--#tr id="lan.9"-->DHCP End IP<!--#endtr-->
		</td>
		<td class="CR2" style="display:none">
			<input id="dhcpEndIP" name="dhcp_end" value="<% nvram_get("dhcp_end"); %>" size="15" maxlength="15" onkeydown="return prevent_press_enter(event);">
		</td>
		<td class="CR2">
			<input id="guestDhcpEndIP" name="dhcp1_end" value="<% nvram_get("dhcp1_end"); %>" size="15" maxlength="15" onkeydown="return prevent_press_enter(event);">
		</td>
	</tr>
	<tr>
		<td class="CL"
		onMouseOver="return overlib('Sets the number of seconds DHCP leases should be valid for.', LEFT);"
		onMouseOut="return nd();">
		<!--#tr id="lan.10"-->DHCP Lease Time<!--#endtr-->
		</td>
		<td class="CR2" style="display:none">
			<input id="dhcpLeaseTime" name="lan_lease" value="<% nvram_get("lan_lease"); %>" size="6" maxlength="6" onkeydown="return prevent_press_enter(event);">&nbsp;<!--#tr id="lan.11"-->(seconds)<!--#endtr-->
		</td>
		<td class="CR2">
			<input id="guestDhcpLeaseTime" name="lan1_lease" value="<% nvram_get("lan1_lease"); %>" size="6" maxlength="6" onkeydown="return prevent_press_enter(event);">&nbsp;<!--#tr id="lan.11"-->(seconds)<!--#endtr-->
		</td>
	</tr>
	<tr style="display:none">
		<td class="CL"
		onMouseOver="return overlib('Enables the use of the Ethernet 802.1d Spanning Tree Protocol to eliminate bridging loops across the LAN interfaces.', LEFT);"
		onMouseOut="return nd();">
		Spanning Tree Protocol
		</td>
		<td class="CR2" style="display:none">
			<select name="lan_stp">
				<option value="1" <% nvram_match("lan_stp", "1", "selected"); %>>Enabled</option>
				<option value="0" <% nvram_match("lan_stp", "0", "selected"); %>>Disabled</option>
			</select>
		</td>
		<td class="CR2" style="display:none">
			<select name="lan1_stp">
				<option value="1" <% nvram_match("lan1_stp", "1", "selected"); %>>Enabled</option>
				<option value="0" <% nvram_match("lan1_stp", "0", "selected"); %>>Disabled</option>
			</select>
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

<!--
#ifdef __CONFIG_EMF__
-->	
<!--
<% emf_enable_display(); %>
<% emf_entries_display(); %>
<% emf_uffp_entries_display(); %>
<% emf_rtport_entries_display(); %>
-->	
<!--
#endif	// __CONFIG_EMF__
-->	
</form>

<div id=dhcpReserveForm style="display:none">
<form method="post" action="/uapply.cgi" onSubmit="return checkDhcpReservations();">
<input type="hidden" name="page" value="/basic/guest_lan.asp">
<input type="hidden" name="token" value="<% genToken(); %>">
<input type="hidden" name="dhcp_reservelist" id="dhcp_reservelist" value="2">
<table width="100%" class="tbl_main">
	<tr>
		<td class="CT" colspan="2"><!--#tr id="lan.13"-->DHCP Reservations List<!--#endtr--></td>
	</tr>
	<tr style="display:none">
		<td id="hdcp_rsvdTable">
			<table width="100%" class="tbl_main2">
				<tr>
					<td colspan="4">
						<B><!--#tr id="internal.network"-->Internal Network<!--#endtr--></B>
					</td>
				</tr>
				<tr>
					<input type="hidden" name="dhcp_rsvdList" id="dhcp_rsvdList" value="24">
					<td class="form_list_title"><!--#tr id="dcl.2"-->Hostname<!--#endtr--></td>
					<td class="form_list_title"><!--#tr id="mac.address"-->MAC Address<!--#endtr--></td>
					<td class="form_list_title"><!--#tr id="ip.address"-->IP Address<!--#endtr--></td>
					<td class="form_list_title"><!--#tr id="enabled"-->Enabled<!--#endtr--></td>
				</tr>
				<% dhcp_reservelist(0, 0, 23); %>
			</table>
		</td>
	</tr>
	<tr>
		<td id="hdcp1_rsvdTable">
			<table width="100%" class="tbl_main2">
				<tr style="display:none">
					<td colspan="4">
						<B><!--#tr id="guest.network"-->Guest Network<!--#endtr--></B>
					</td>
				</tr>
				<tr>
					<input type="hidden" name="dhcp1_rsvdList" id="dhcp1_rsvdList" value="10">					
					<td class="form_list_title"><!--#tr id="dcl.2"-->Hostname<!--#endtr--></td>
					<td class="form_list_title"><!--#tr id="mac.address"-->MAC Address<!--#endtr--></td>
					<td class="form_list_title"><!--#tr id="ip.address"-->IP Address<!--#endtr--></td>
					<td class="form_list_title"><!--#tr id="enabled"-->Enabled<!--#endtr--></td>
				</tr>
				<% dhcp_reservelist(1, 0, 9); %>
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
