<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html lang="en-US" xmlns="http://www.w3.org/1999/xhtml" xml:lang="en-US">
<head>
<title>TRENDNET | modelName | Basic | Wireless</title>
<meta http-equiv=Content-Type content="text/html; charset=UTF-8">
<link href="/css/style.css" rel="stylesheet" type="text/css" />
<link href="/css/css_router.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="/uk_<!--# echo language -->.js"></script>
<script type="text/javascript" src="/public_tew.js"></script>
<script type="text/javascript" src="/public_msg.js"></script>
<script type="text/javascript" src="/public_ipv6.js"></script>
<script type="text/javascript" src="/pandoraBox.js"></script>
<script type="text/javascript" src="/menu_all.js"></script>
<script type="text/javascript" src="/js/jquery-1.3.2.min.js"></script>
<script type="text/javascript" src="/js/xml.js"></script>
<script type="text/javascript" src="/js/object.js"></script>
<script type="text/javascript" src="/js/ddaccordion.js"></script>
<script type="text/javascript" src="/js/ccpObject.js"></script>


<script type="text/javascript">
	var def_title = document.title;
	var model = "<!--# echo model_number -->";
	document.title = def_title.replace("modelName", model);
	
	var menu = new menuObject();
	var has_usb		= '1';
	var browserName=navigator.userAgent.toLowerCase();
	var con_status = "";
	var wlan0_exist="",wlan1_exist="";
	var wlan0_ssid="", wlan0_security="",wlan0_guest_ssid="",wlan0_guest_security="";
	var wlan1_ssid="", wlan1_security="",wlan1_guest_ssid="",wlan1_guest_security="";
	var net_status="";
	var cab_status="";
	var DHCPL_DataArray = new Array();


function setInternet(){
		if(cab_status!="connect")
		{
			$('#icon_nocableinet').show();
			$('#icon_noinet').hide();
			$('#icon_hasinet').hide();
			$('#inet_connection').html(get_words('_no_inet_connection'));
		}
		else if(net_status == "1" && con_status != "Disconnected")
		{
			$('#icon_nocableinet').hide();
			$('#icon_noinet').hide();
			$('#icon_hasinet').show();
			$('#inet_connection').html(get_words('_has_inet_connection'));
		}
		else
		{
			$('#icon_nocableinet').hide();
			$('#icon_noinet').show();
			$('#icon_hasinet').hide();
			$('#inet_connection').html(get_words('_no_inet_connection'));
		}
}

function setGuestNetwork(){
	if (wlan0_guest_enable=="1"){
		$('#gn_ssid_24g').text(wlan0_guest_ssid).html();
	}else{
		$('#gn_ssid_24g').html(get_words('_disabled'));
	}
	
	if (wlan1_guest_enable=="1"){
		$('#gn_ssid_5g').text(wlan1_guest_ssid).html();
		
	}else{
		$('#gn_ssid_5g').html(get_words('_disabled'));
	}

	if((wlan0_guest_enable=='1')||(wlan1_guest_enable=='1'))
	{
		$('#icon_nogn').hide();
		$('#icon_hasgn').show();
	}
	else
	{
		$('#icon_nogn').show();
		$('#icon_hasgn').hide();
	}
}

var hotplug_staus=0;


function setUSB(){
	if(has_usb=='1')
		$('#usb_field').show();
	var usb_val = '0';
	usb_val = hotplug_staus;
	usb_val = usb_val * 1; // number
//	if(usb_val=='1')
	if(usb_val==1)
	{
		$('#icon_nousb').hide();
		$('#icon_hasusb').show();
		$('#usb_status').html(get_words('_usb_connected'));
	}
	else
	{
		$('#icon_nousb').show();
		$('#icon_hasusb').hide();
		$('#usb_status').html(get_words('_no_usb_connected'));
	}
}

function setWlanSSID(){
	if (wlan0_exist=="1")
	{
		$('#ssid_24g').text(wlan0_ssid).html();
	}else{
		$('#ssid_24g').html(get_words('_disabled'));
	}
	
	if (wlan1_exist=="1"){
		$('#ssid_5g').text(wlan1_ssid).html();
	}else{
		$('#ssid_5g').html(get_words('_disabled'));
	}
	
	if((wlan0_exist=='1') || (wlan1_exist=='1'))
	{
		$('#icon_nossid').hide();
		$('#icon_hasssid').show();
	}else{
		$('#icon_nossid').show();
		$('#icon_hasssid').hide();
	}
}

function setWlanSecurity(){
	var level = [];

	security_w = wlan0_security;
	show_security = security_w;
	tmp_wlan0_security = wlan0_security.split("_");
	if(security_w == "wpa2auto_eap") {
		level[0] = get_words('wlan_security_eap');
	} else if (security_w == "wpa2_eap") {
		level[0] = get_words('_wifiser_mode6');
	} else if (security_w == "wpa_eap") {
		level[0] = get_words('_WPA');
	} else if(security_w == "wpa2auto_psk") {
		level[0] = get_words('wlan_security_psk');
	} else if (security_w == "wpa2_psk") {
		level[0] = get_words('_wifiser_mode4');
	} else if  (security_w == "wpa_psk"){
		level[0] = get_words('_wifiser_mode3');
	} else if(security_w == "disable"){
		level[0] = get_words('_disabled');
	} else if (tmp_wlan0_security[0] == "wep") {
		 if (tmp_wlan0_security[1] == "open") {
                        level[0] = get_words('_wifiser_mode0');
                } if (tmp_wlan0_security[1] == "share") {
                        level[0] = get_words('_wifiser_mode1');
                } if (tmp_wlan0_security[1] == "auto") {                                      
                        level[0] = get_words('_wifiser_mode2');                          
                }   
	}

	security_w = wlan1_security;
	show_security = security_w;
	tmp_wlan1_security = wlan1_security.split("_");
	if(security_w == "wpa2auto_eap") {
		level[1] = get_words('wlan_security_eap');
	} else if (security_w == "wpa2_eap") {
		level[1] = get_words('_wifiser_mode6');
	} else if (security_w == "wpa_eap") {
		level[1] = get_words('_WPA');
	} else if(security_w == "wpa2auto_psk") {
		level[1] = get_words('wlan_security_psk');
	} else if (security_w == "wpa2_psk") {
		level[1] = get_words('_wifiser_mode4');
	} else if  (security_w == "wpa_psk"){
		level[1] = get_words('_wifiser_mode3');
	} else if(security_w == "disable"){
		level[1] = get_words('_disabled');
	} else if (tmp_wlan1_security[0] == "wep") {
		 if (tmp_wlan1_security[1] == "open") {
                        level[1] = get_words('_wifiser_mode0');
                } if (tmp_wlan1_security[1] == "share") {
                        level[1] = get_words('_wifiser_mode1');
                } if (tmp_wlan1_security[1] == "auto") {                                      
                        level[1] = get_words('_wifiser_mode2');                          
                }                       
	}

	$('#secu_24g').html(level[0]);
	$('#secu_5g').html(level[1]);
	
}


function setWlanSecurityLevel(){
	var level = [];
	var tmp_wlan0_sec = wlan0_security.split("_");
	var tmp_wlan1_sec = wlan1_security.split("_");
	
	if(wlan0_security == "disable"){//None
		level[0] = get_words('_security_no');
	}else if(tmp_wlan0_sec[0] == "wep"){					//WEP		
		level[0] = get_words('_security_low');
	}else if(tmp_wlan0_sec[0] == "wpa"){//WPA_P, WPA_E
		level[0] = get_words('_security_middle');	
        }else if(tmp_wlan0_sec[0] == "wpa2auto"){		
		level[0] =get_words('_security_high');
	}else if(tmp_wlan0_sec[0] == "wpa2"){		
		level[0] =get_words('_security_high');
        }

	if(wlan1_security == "disable"){//None
		level[1] = get_words('_security_no');
	}else if(tmp_wlan1_sec[0] == "wep"){//WEP_MODE
		level[1] = get_words('_security_low');
	}else if(tmp_wlan1_sec[0] == "wpa"){//WPA_P, WPA_E
		level[1] = get_words('_security_middle');	
	}else if(tmp_wlan1_sec[0] == "wpa2auto"){//WPA_P, WPA_E		
		level[1] = get_words('_security_high');
	}else if(tmp_wlan1_sec[0] == "wpa2"){//WPA_P, WPA_E		
		level[1] = get_words('_security_high');
	}
	
	$('#secu_level_24g').html(level[0]);
	$('#secu_level_5g').html(level[1]);
	
}

function setConnectDevice(){
		var temp_dhcp_list = get_by_id("dhcp_list").value.split(",");
		var tmp_lan_pc = new Array();
		for (var i = 0; i < temp_dhcp_list.length; i++) {
			if (tmp_lan_pc.length == 0) {
				tmp_lan_pc.push(temp_dhcp_list[i]);
			} else {
				var tdata = temp_dhcp_list[i].split("/");
				var tflag = 0;
				for (var j = 0; j < tmp_lan_pc.length; j++) {
					var pdata = tmp_lan_pc[j].split("/");
					if (pdata[0] == tdata[0]) {
						tflag = 1;
						break;
					}
				}
				if (tflag == 0)
					tmp_lan_pc.push(temp_dhcp_list[i]);
			}
		}

		$('#connected_devices').html('<div class="hr2"></div>');
		for (var i = 0; i < tmp_lan_pc.length; i++){	
			var temp_data = tmp_lan_pc[i].split("/");
			if(temp_data.length != 0){		
				if(temp_data.length > 1){
					if(temp_data[1] == "")temp_data[1]="(null)";
						$('#connected_devices').append('<span style="width:154px;display:inline-block;text-align:center;" title="'+temp_data[2]+"\n"+temp_data[0]+'"><img src="/image/icons_connected_devices.png" /><p style="font-size:10px;">'+(temp_data[1]||'&nbsp;')+'</p></span>');
				
					if(i%2==1 && (temp_data.length-1)>i)
						$('#connected_devices').append('<div class="hr2"></div>');
				}
			}
		}	
}

	function createRequest() {
		var XMLhttpObject = false;
		if (window.XMLHttpRequest) {
			try {
				XMLhttpObject = new XMLHttpRequest();
			} catch (e) {
			}
		} else if (window.ActiveXObject) {
			try {
				XMLhttpObject = new ActiveXObject("Msxml2.XMLHTTP");
			} catch (e) {
				try {
					XMLhttpObject = new ActiveXObject("Microsoft.XMLHTTP");
				} catch (e) {
					return null;
				}
			}
		}
		return XMLhttpObject;
	}

	function get_File() {
		xmlhttp = new createRequest();
		if(xmlhttp){
			var url = "";
			var temp_cURL = document.URL.split("/");
			for (var i = 0; i < temp_cURL.length-1; i++) {
				if (i == 1) continue;
				if ( i == 0)
					url += temp_cURL[i] + "//";
				else
					url += temp_cURL[i] + "/";
			}
			url += "device_status.xml";
			xmlhttp.onreadystatechange = xmldoc; 
			xmlhttp.open("GET", url, true); 
			xmlhttp.send(null); 
		}
		//setTimeout("get_File()", 3000);
	}
	
	function xmldoc()
	{ 
		var dns1 = "", dns2 = "", ip = "", netmask = "", gateway = "";
		var uptime_status = "";
		var aftr_address = "", aftr_enable = "";
		
		
		if (xmlhttp.readyState == 4 && xmlhttp.status == 200) { 
			try{
				net_status = xmlhttp.responseXML.getElementsByTagName("wan_network_status")[0].firstChild.nodeValue;
				con_status = xmlhttp.responseXML.getElementsByTagName("wan_connection_status")[0].firstChild.nodeValue;
				cab_status = xmlhttp.responseXML.getElementsByTagName("wan_cable_status")[0].firstChild.nodeValue;

				/* wlan0 */
				wlan0_exist = xmlhttp.responseXML.getElementsByTagName("wlan0_enable")[0].firstChild.nodeValue;
				
				if (wlan0_exist == 1) { 
					wlan0_ssid = xmlhttp.responseXML.getElementsByTagName("wlan0_ssid")[0].firstChild.nodeValue;
					wlan0_security = xmlhttp.responseXML.getElementsByTagName("wlan0_security")[0].firstChild.nodeValue;
				}

				/* wlan0 guest network */
				wlan0_guest_enable = xmlhttp.responseXML.getElementsByTagName("wlan0_guest_enable")[0].firstChild.nodeValue;

				if (wlan0_guest_enable == 1) { /* guest ssid and security exist as guest network is enabled */
					wlan0_guest_ssid = xmlhttp.responseXML.getElementsByTagName("wlan0_guest_ssid")[0].firstChild.nodeValue;
					wlan0_guest_security = xmlhttp.responseXML.getElementsByTagName("wlan0_guest_security")[0].firstChild.nodeValue;
				}

				/* wlan1 */
				wlan1_exist = xmlhttp.responseXML.getElementsByTagName("wlan1_enable")[0].firstChild.nodeValue;

				if (wlan1_exist == 1) {
					wlan1_ssid = xmlhttp.responseXML.getElementsByTagName("wlan1_ssid")[0].firstChild.nodeValue;
					wlan1_security = xmlhttp.responseXML.getElementsByTagName("wlan1_security")[0].firstChild.nodeValue;
				}

				/* wlan1 guest network */
				wlan1_guest_enable = xmlhttp.responseXML.getElementsByTagName("wlan1_guest_enable")[0].firstChild.nodeValue;

				if (wlan1_guest_enable == 1) { /* guest ssid and security exist as guest network is enabled */
					wlan1_guest_ssid = xmlhttp.responseXML.getElementsByTagName("wlan1_guest_ssid")[0].firstChild.nodeValue;
					wlan1_guest_security = xmlhttp.responseXML.getElementsByTagName("wlan1_guest_security")[0].firstChild.nodeValue;
				}

				setConnectDevice();
				setInternet();
				setWlanSSID();
				setGuestNetwork();
				setWlanSecurity();
				setWlanSecurityLevel();
				
				hotplug_staus = xmlhttp.responseXML.getElementsByTagName("usb_hotplug_staus")[0].firstChild.nodeValue;
				setUSB();
			}catch(e){
				dns1 = "0.0.0.0"; dns2 = "0.0.0.0"; ip = "0.0.0.0"; netmask = "0.0.0.0"; gateway = "0.0.0.0";
			}
		}
		if ("<!--# echo feature_mbssid -->" == "y") {
			get_by_id("wlan0").style.display="none";
		}
  }


</script>
</head>
<body>
<div class="wrapper">
<table border="0" width="950" cellpadding="0" cellspacing="0" align="center">
<!-- banner and model description-->
<tr>
	<td class="header_1">
		<table border="0" cellpadding="0" cellspacing="0" style="position:relative;width:920px;top:8px;" class="maintable">
		<tr>
			<td valign="top"><img src="/image/logo.png" /></td>
			<td align="right" valign="middle" class="description" style="width:600px;line-height:1.5em;">
			<script>show_words('PRODUCT_DESC')</script>
			<br><script>document.write(model);</script></br></td>
		</tr>
		</table>
	</td>
</tr>
<!-- End of banner and model description-->

<tr>
	<td>
		<table border="0" cellpadding="0" cellspacing="0" style="position:relative;width:950px;top:10px;margin-left:5px;" class="maintable">
		<!-- upper frame -->
		<tr>
			<td><img src="/image/bg_topl.gif" width="270" height="7" /></td>
			<td><img src="/image/bg_topr_01.gif" width="680" height="7" /></td>
		</tr>
		<!-- End of upper frame -->

		<tr>
			<!-- left menu -->
			<td style="background-image:url('/image/bg_l.gif');background-repeat:repeat-y;vertical-align:top;width:" width="270">
				<div style="padding-left:6px;">
				<script>document.write(menu.build_structure(0,0,-1));</script>
				<p>&nbsp;</p>
				</div>
				<img src="/image/bg_l.gif" width="270" height="5" />
			</td>
			<!-- End of left menu -->

			<td style="background-image:url('/image/bg_r.gif');background-repeat:repeat-y;vertical-align:top;" width="680">
				<img src="/image/bg_topr_02.gif" width="680" height="5" />
				<table border="0" cellpadding="0" cellspacing="0">
				<tr>
					<td valign="top" style="width:650px;padding-left:10px;">
						<table width="100%" border="0" cellpadding="0" cellspacing="0">
						<tr>
							<td valign="top">
						<iframe class="rebootRedirect" name="rebootRedirect" id="rebootRedirect" frameborder="0" width="1" height="1" scrolling="no" src="" style="visibility: hidden;">redirect</iframe>
						<div id="waitform"></div>
						<div id="waitPad" style="display: none;"></div>
						<div id="mainform">
								<!-- main content -->
								<div class="headerbg" id="manStatusTitle">
								<script>show_words('_networkstate');</script>
								</div>
								<div class="hr"></div>
								<div class="section_content_border">
<div style="float:left; min-height:300px">
	<div class="boxshadow" style="width:250px; height:100%;">
		<div class="h4"><script>show_words('sa_Internet');</script></div>
		<div class="hr2"></div>
		<table width="100%" border="0" cellpadding="3" cellspacing="1">
		<tr>
			<td width="16%"><img src="/image/icons_internet_2.png" class="img-swap" id="icon_nocableinet" style="display:none;" /><img src="/image/icons_internet_0.png" class="img-swap" id="icon_noinet" style="display:none;" /><img src="/image/icons_internet_1.png" class="img-swap" id="icon_hasinet" style="display:none;" /></td>
			<td width="84%" span id="inet_connection"></span></td>
		</tr>
		</table>
	</div>
	<div class="boxshadow" style="width:250px;height:100%;">
		<div class="h4"><script>show_words('_guest_network');</script></div>
		<div class="hr2"></div>
		<table width="100%" border="0" cellpadding="3" cellspacing="1">
		<tr>
			<td width="16%"><img src="/image/icons_guest_network_0.png" class="img-swap" id="icon_nogn" style="display:none;" /><img src="/image/icons_guest_network_1.png" class="img-swap" id="icon_hasgn" style="display:none;" /></td>
			<td width="84%">
				<strong><script>show_words('KR16');</script></strong> <script>show_words('_guest_network');</script> <strong>(<script>show_words('_ssid');</script>)</strong>: <span id="gn_ssid_24g" class="break_word"></span><p style="line-height:5px;">&nbsp;</p>
				<strong><script>show_words('KR17');</script></strong> <script>show_words('_guest_network');</script> <strong>(<script>show_words('_ssid');</script>)</strong>: <span id="gn_ssid_5g" class="break_word"></span>
			</td>
		</tr>
		</table>
	</div>
	<div id="usb_field" class="boxshadow" style="width:220px;height:100%;display:none;">
		<div class="h4"><script>show_words('_usb');</script></div><div class="hr2"></div>
		<table width="100%" border="0" cellpadding="3" cellspacing="1">
		<tr>
			<td width="16%"><img src="/image/icons_usb_0.png" class="img-swap" id="icon_nousb" style="display:none;" /><img src="/image/icons_usb_1.png" class="img-swap" id="icon_hasusb" style="display:none;" /></td>
			<td width="84%"><span id="usb_status"></span></td>
		</tr>
		</table>
	</div>
  
</div>
<div style="float:right;min-height:300px">
	<div class="boxshadow" style="width:330px;height:100%;">
		<div class="h4"><script>show_words('_wireless');</script></div>
		<div class="hr2"></div>
		<table width="100%" border="0" cellpadding="3" cellspacing="1">
		<tr>
			<td width="16%"><img src="/image/icons_wireless_ssid_orange.png" class="img-swap" id="icon_nossid" style="width:60px;" /><img src="/image/icons_wireless_ssid_green.png" class="img-swap" id="icon_hasssid" style="width:60px;display:none;" /></td>
			<td width="84%">
			<b><script>show_words('KR16');</script> <script>show_words('_name_ssid');</script>: </b><div id="ssid_24g" style="display:inline-block;" class="break_word"></div><p style="line-height:5px;">&nbsp;</p>
			<b><script>show_words('KR17');</script> <script>show_words('_name_ssid');</script>: </b><div id="ssid_5g" style="display:inline-block;" class="break_word"></div>
			</td>
		</tr>
		</table>
		<div class="hr2"></div>
		<table width="100%" border="0" cellpadding="3" cellspacing="1">
		<tr>
			<td width="16%" valign="top"><img src="/image/icons_wireless_security.png" /></td>
			<td width="84%" valign="top"><p><b><script>show_words('KR16');</script>: </b><span id="secu_24g"></span> <span id="secu_level_24g"></span><br>
			<b><script>show_words('KR17');</script>: </b><span id="secu_5g"></span> <span id="secu_level_5g"></span></p></td>
		</tr>
		</table>
	</div>
	<div class="boxshadow" style="width:330px;height:100%;">
		<div class="h4"><script>show_words('_connected_devices');</script></div>
		<input type="hidden" id="dhcp_list" name="dhcp_list" value="<!--# exec cgi /bin/cmo_get_list local_lan_ip -->">
		<span id="connected_devices">
		</span>
	</div>
</div>
								</div>
								<!-- End of main content -->
							<br/>
						</div>
					</td>
				</tr>
				</table>
			</td>
		</tr>
		</table>
		</td>
	</tr>
		<!-- lower frame -->
		<tr>
			<td><img src="/image/bg_butl.gif" width="270" height="12" /></td>
			<td><img src="/image/bg_butr.gif" width="680" height="12" /></td>
		</tr>
		<!-- End of lower frame -->

		</table>
		<!-- footer -->
		<div class="footer">
			<table border="0" cellpadding="0" cellspacing="0" style="width:920px;" class="maintable">
			<tr>
				<td align="left" valign="top" class="txt_footer">
				<br><script>show_words("_copyright");</script></td>
				<td align="right" valign="top" class="txt_footer">
				<br><a href="http://www.trendnet.com/register" target="_blank"><img src="/image/icons_warranty_1.png" style="border:0px;vertical-align:middle;padding-right:10px;" border="0" /><script>show_words("_warranty");</script></a></td>
			</tr>
			</table>
		</div>
		<!-- end of footer -->

	</td>
</tr>
</table><br/>
</div>
<script>
	get_File();
</script>
</body>
</html>
