<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html lang="en-US" xmlns="http://www.w3.org/1999/xhtml" xml:lang="en-US">
<head>
<title>TRENDNET | modelName | Administrator | Status</title>
<meta http-equiv=Content-Type content="text/html; charset=UTF-8">
<link href="/css/style.css" rel="stylesheet" type="text/css" />
<link href="/css/css_router.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="/uk_<!--# echo language -->.js"></script>
<script type="text/javascript" src="public_tew.js"></script>
<script type="text/javascript" src="public_msg.js"></script>
<script type="text/javascript" src="public_ipv6.js"></script>
<script type="text/javascript" src="pandoraBox.js"></script>
<script type="text/javascript" src="menu_all.js"></script>
<script type="text/javascript" src="js/jquery-1.3.2.min.js"></script>
<script type="text/javascript" src="js/xml.js"></script>
<script type="text/javascript" src="js/object.js"></script>
<script type="text/javascript" src="js/ddaccordion.js"></script>
<script type="text/javascript" src="js/ccpObject.js"></script>

<script type="text/javascript">
	var def_title = document.title;
	var model = "<!--# echo model_number -->";
	document.title = def_title.replace("modelName", model);
	var temp_wlan_enable = 1;
	var obj;
	var menu = new menuObject();
	var browserName=navigator.userAgent.toLowerCase();
	var nNow="", gTime,nd;
	var wTimesec = "", wan_time = "";
	var upTimesec = "", up_time = "";
	var temp, days = 0, hours = 0, mins = 0, secs = 0;
	var con_status = "";
	var cnt = 0;
	var cpu_sys_status = "",cpu_usr_status = "" ,cpu_idle_status="" ,cpu_io_status="";
	var mem_total_status="",mem_free_status="",mem_used_status="";
	var logged="";
	var wlan0_exist="",wlan1_exist="";
	var wlan0_mode="",wlan1_mode="";
	var wlan0_channel = "", wlan1_channel = "";
	var wlan0_width="", wlan1_width="";
	var wlan0_vap0_ssid="", wlan0_vap0_security="",wlan0_vap1_ssid="",wlan0_vap1_security="", wlan0_vap1_enable="";
	var wlan0_vap2_ssid = "", wlan0_vap2_security = "", wlan0_vap2_enable = "";
	var wlan0_vap3_ssid = "", wlan0_vap3_security = "", wlan0_vap3_enable = "";
	var wlan1_vap0_ssid="", wlan1_vap0_security="",wlan1_vap1_ssid="",wlan1_vap1_security="", wlan1_vap1_enable="";;
	var wlan1_vap2_ssid = "", wlan1_vap2_security = "", wlan1_vap2_enable = "";
	var wlan1_vap3_ssid = "", wlan1_vap3_security = "", wlan1_vap3_enable = "";
	var dns1 = "", dns2 = "", ip = "", netmask = "", gateway = "";
	var net_status = ""; cab_status = "";
	var uptime_status = "";
	var aftr_address = "", aftr_enable = "";
	var wan_connection_type = function(conn_type) 
	{
		get_by_id("connect").disabled=true;
		get_by_id("disconnect").disabled=true;
		wan_con = new createRequest();
                if(wan_con){
			var url = "";
			var temp_cURL = document.URL.split("/");
			for (var i = 0; i < temp_cURL.length-1; i++) {
				if ( i == 1) continue;
				if ( i == 0)
					url += temp_cURL[i] + "//";
				else
					url += temp_cURL[i] + "/";
			}
			url += conn_type + ".asp";
                        wan_con.open("GET", url, true);
                        wan_con.send(null);
			cnt = 2;
                }
	};

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
		setTimeout("get_File()", 3000);
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
	
	function xmldoc()
	{ 
		
		if (xmlhttp.readyState == 4 && xmlhttp.status == 200) { 
			try{
				logged = xmlhttp.responseXML.getElementsByTagName("logged")[0].firstChild.nodeValue;
				ip = xmlhttp.responseXML.getElementsByTagName("wan_ip")[0].firstChild.nodeValue;
				netmask = xmlhttp.responseXML.getElementsByTagName("wan_netmask")[0].firstChild.nodeValue;
				gateway = xmlhttp.responseXML.getElementsByTagName("wan_default_gateway")[0].firstChild.nodeValue;
				dns1 = xmlhttp.responseXML.getElementsByTagName("wan_primary_dns")[0].firstChild.nodeValue;
				dns2 = xmlhttp.responseXML.getElementsByTagName("wan_secondary_dns")[0].firstChild.nodeValue;
				net_status = xmlhttp.responseXML.getElementsByTagName("wan_network_status")[0].firstChild.nodeValue;
				con_status = xmlhttp.responseXML.getElementsByTagName("wan_connection_status")[0].firstChild.nodeValue;
				cab_status = xmlhttp.responseXML.getElementsByTagName("wan_cable_status")[0].firstChild.nodeValue;
				//uptime_status = xmlhttp.responseXML.getElementsByTagName("uptime")[0].firstChild.nodeValue;
				//cpu_usr_status = xmlhttp.responseXML.getElementsByTagName("cpu_usr")[0].firstChild.nodeValue;
				//cpu_sys_status = xmlhttp.responseXML.getElementsByTagName("cpu_sys")[0].firstChild.nodeValue;
				//cpu_idle_status = xmlhttp.responseXML.getElementsByTagName("cpu_idle")[0].firstChild.nodeValue;
				//cpu_io_status = xmlhttp.responseXML.getElementsByTagName("cpu_io")[0].firstChild.nodeValue;
				
				//mem_total_status = xmlhttp.responseXML.getElementsByTagName("mem_total")[0].firstChild.nodeValue;
				//mem_used_status = xmlhttp.responseXML.getElementsByTagName("mem_used")[0].firstChild.nodeValue;
				//mem_free_status = xmlhttp.responseXML.getElementsByTagName("mem_free")[0].firstChild.nodeValue;
				aftr_address = xmlhttp.responseXML.getElementsByTagName("aftr_address")[0].firstChild.nodeValue;
				aftr_enable = xmlhttp.responseXML.getElementsByTagName("aftr_enable")[0].firstChild.nodeValue;
				
				/* wlan0 host */
				wlan0_exist =xmlhttp.responseXML.getElementsByTagName("wlan0_enable")[0].firstChild.nodeValue;

				if (wlan0_exist == 1) {
					wlan0_mode=xmlhttp.responseXML.getElementsByTagName("wlan0_mode")[0].firstChild.nodeValue;
					wlan0_channel = xmlhttp.responseXML.getElementsByTagName("wlan_channel")[0].firstChild.nodeValue;
					wlan0_width= xmlhttp.responseXML.getElementsByTagName("wlan0_width")[0].firstChild.nodeValue;				
					wlan0_vap0_ssid= xmlhttp.responseXML.getElementsByTagName("wlan0_ssid")[0].firstChild.nodeValue;
					wlan0_vap0_security= xmlhttp.responseXML.getElementsByTagName("wlan0_security")[0].firstChild.nodeValue;
				}
				
				/* wlan0 guest network */
				wlan0_vap1_enable= xmlhttp.responseXML.getElementsByTagName("wlan0_guest_enable")[0].firstChild.nodeValue;

				if (wlan0_vap1_enable == 1) { /* guest ssid and security exist as guest network is enabled */
					wlan0_vap1_ssid = xmlhttp.responseXML.getElementsByTagName("wlan0_guest_ssid")[0].firstChild.nodeValue;
					wlan0_vap1_security = xmlhttp.responseXML.getElementsByTagName("wlan0_guest_security")[0].firstChild.nodeValue;
				}

				/* wlan0 mssid0 */
				wlan0_vap2_enable= xmlhttp.responseXML.getElementsByTagName("wlan0_vap2_enable")[0].firstChild.nodeValue;

				if (wlan0_vap2_enable == 1) {
					wlan0_vap2_ssid = xmlhttp.responseXML.getElementsByTagName("wlan0_vap2_ssid")[0].firstChild.nodeValue;
					wlan0_vap2_security = xmlhttp.responseXML.getElementsByTagName("wlan0_vap2_security")[0].firstChild.nodeValue;
				}

				/* wlan0 mssid1 */
				wlan0_vap3_enable= xmlhttp.responseXML.getElementsByTagName("wlan0_vap3_enable")[0].firstChild.nodeValue;

				if (wlan0_vap3_enable == 1) {
					wlan0_vap3_ssid = xmlhttp.responseXML.getElementsByTagName("wlan0_vap3_ssid")[0].firstChild.nodeValue;
					wlan0_vap3_security = xmlhttp.responseXML.getElementsByTagName("wlan0_vap3_security")[0].firstChild.nodeValue;
				}

				/* wlan1 host */
				wlan1_exist =xmlhttp.responseXML.getElementsByTagName("wlan1_enable")[0].firstChild.nodeValue;

				if (wlan1_exist == 1) {
					wlan1_mode=xmlhttp.responseXML.getElementsByTagName("wlan1_mode")[0].firstChild.nodeValue;
					wlan1_channel = xmlhttp.responseXML.getElementsByTagName("wlan1_channel")[0].firstChild.nodeValue;
					wlan1_width= xmlhttp.responseXML.getElementsByTagName("wlan1_width")[0].firstChild.nodeValue;
					wlan1_vap0_ssid= xmlhttp.responseXML.getElementsByTagName("wlan1_ssid")[0].firstChild.nodeValue;
					wlan1_vap0_security= xmlhttp.responseXML.getElementsByTagName("wlan1_security")[0].firstChild.nodeValue;
				}

				/* wlan1 guest network */
				wlan1_vap1_enable = xmlhttp.responseXML.getElementsByTagName("wlan1_guest_enable")[0].firstChild.nodeValue;

				if (wlan1_vap1_enable == 1) { /* guest ssid and security exist as guest network is enabled */
					wlan1_vap1_ssid = xmlhttp.responseXML.getElementsByTagName("wlan1_guest_ssid")[0].firstChild.nodeValue;
					wlan1_vap1_security = xmlhttp.responseXML.getElementsByTagName("wlan1_guest_security")[0].firstChild.nodeValue;
				}

				/* wlan1 mssid0 */
				wlan1_vap2_enable = xmlhttp.responseXML.getElementsByTagName("wlan1_vap2_enable")[0].firstChild.nodeValue;

				if (wlan1_vap2_enable == 1) {
					wlan1_vap2_ssid = xmlhttp.responseXML.getElementsByTagName("wlan1_vap2_ssid")[0].firstChild.nodeValue;
					wlan1_vap2_security = xmlhttp.responseXML.getElementsByTagName("wlan1_vap2_security")[0].firstChild.nodeValue;
				}

				/* wlan1 mssid1 */
				wlan1_vap3_enable= xmlhttp.responseXML.getElementsByTagName("wlan1_vap3_enable")[0].firstChild.nodeValue;

				if (wlan1_vap3_enable == 1) {
					wlan1_vap3_ssid = xmlhttp.responseXML.getElementsByTagName("wlan1_vap3_ssid")[0].firstChild.nodeValue;
					wlan1_vap3_security = xmlhttp.responseXML.getElementsByTagName("wlan1_vap3_security")[0].firstChild.nodeValue;
				}

				wTimesec = xmlhttp.responseXML.getElementsByTagName("wan_uptime")[0].firstChild.nodeValue;
				check_logout();
				/*show_cpu_table();
				show_mem_table();
				disable_wireless(wlan0_exist,wlan1_exist);
				show_wireless_status();
				show_wireless_status2();
				show_ssid_status();
				show_ssid_status2();
				*/
				time="<!--# echo session_timeout -->";
				clearTimeout("time_out()");
			}catch(e){
				dns1 = "0.0.0.0"; dns2 = "0.0.0.0"; ip = "0.0.0.0"; netmask = "0.0.0.0"; gateway = "0.0.0.0";
				con_status = ""; net_status = ""; cab_status = "";cpu_usr_status="N/A";cpu_sys_status="N/A";
				cpu_idle_status="N/A";cpu_io_status="N/A";uptime_status="N/A";
				mem_total_status="N/A";mem_used_status="N/A";mem_free_status = "N/A";
				aftr_address = "None"; aftr_enable = "0";
				wlan0_channel = "";
				wlan1_channel = "";
				wTimesec = 0;
				wlan0_exist="",wlan1_exist="";
				wlan0_mode="",wlan1_mode="";
				wlan0_channel = "", wlan1_channel = "";
				wlan0_width="", wlan1_width="";
				wlan0_vap0_ssid="", wlan0_vap0_security="",wlan0_vap1_ssid="",wlan0_vap1_security="";
				wlan0_vap2_ssid="",wlan0_vap2_security="",wlan0_vap3_ssid="",wlan0_vap3_security="";
				wlan1_vap0_ssid="", wlan1_vap0_security="",wlan1_vap1_ssid="",wlan1_vap1_security="";
				wlan1_vap2_ssid="",wlan1_vap2_security="",wlan1_vap3_ssid="",wlan1_vap3_security="";
			}

			if (cnt != 0) {
				cnt--;
			}
			
			}
		getDeviceStatus();
 }	

	function check_logout(){
		if(logged !="1"){
			window.location.href="login_pic.asp";
		}
	}


function getDeviceStatus() {
	var start_time = new Date();
	start_time= start_time.getTime();

	$('#st_wan').show();
		$('#st_igmp').show();
	$('#st_router_lan').show();
		$('#st_ap_lan').hide();

	
	
	// WAN
	get_by_id("wan_proto").value = "<!--# echo wan_proto_ori -->";
	var tmp_wan_pro = "<!--# echo wan_proto_ori -->";
	var wanProto = '';
	switch(tmp_wan_pro)
	{
		case "static":
			wanProto =  get_words('_sdi_staticip');
			break;
		case "dhcpc":
			wanProto =  get_words('bwn_Mode_DHCP');
			break;
		case "pppoe":
			if ( "<!--# echo wan_pppoe_russia_enable -->" == "1" )
				wanProto =  get_words('rus_wan_pppoe');
			else
				wanProto =  get_words('_PPPoE');
			break;
		case "pptp":
			if ( "<!--# echo wan_pptp_russia_enable -->" == "1" )
				wanProto =  get_words('rus_wan_pptp');
			else
				wanProto =  get_words('_PPTP');
			break;
		case "l2tp":
			if ( "<!--# echo wan_l2tp_russia_enable -->" == "1" )
				wanProto =  get_words('rus_wan_l2tp');
			else
				wanProto =  get_words('_L2TP');
			break;
		case "dslite":
			wanProto = 	get_words('IPV6_TEXT140');
			break;
/*		case "6":
			wanProto =  get_words('rus_wan_pppoe');
			break;
		case "7":
			wanProto =  get_words('rus_wan_pptp');
			break;
		case "8":
			wanProto =  get_words('rus_wan_l2tp');
			break;
		case "9":
			wanProto =  get_words('bwn_Mode_DHCPPLUS');
			break;
*/			
	}
	
	$('#connection_type').html(wanProto);
	if(cab_status == 'connect')
		$('#cable_status').html(get_words('CONNECTED'));
	else
		$('#cable_status').html(get_words('DISCONNECTED'));
		
	$('#show_uptime').html();
	
	var tmp_wan_mac = "<!--# echo wan_mac -->";
	$('#show_mac').html(tmp_wan_mac);
	
	
	if(net_status == "Connecting" || net_status == "1")
	{
		$('#wan_ip').html(ip=== "NULL" ? "0.0.0.0" : ip);
		$('#wan_netmask').html(netmask=== "NULL" ? "0.0.0.0" : netmask);
		$('#wan_gateway').html(gateway=== "NULL" ? "0.0.0.0" : gateway);
		$('#wan_dns1').html(dns1=== "NULL" ? "0.0.0.0" : dns1);
		$('#wan_dns2').html(dns2=== "NULL" ? "0.0.0.0" : dns2);
//		$('#aftr').html(filter_ipv6_addr(obj.config_val('igdWanStatus_DsLiteAFTR_')));
//		$('#ds_dhcp').html(obj.config_val('igdWanStatus_DsLiteDHCP_'));
	}
	else
	{
		$('#wan_ip').html("0.0.0.0");
		$('#wan_netmask').html("0.0.0.0");
		$('#wan_gateway').html("0.0.0.0");
		$('#wan_dns1').html("0.0.0.0");
		$('#wan_dns2').html("0.0.0.0");
//		$('#aftr').html("None");
//		$('#ds_dhcp').html(obj.config_val('igdWanStatus_DsLiteDHCP_'));

	}
//	$('#opendns_enable').html(
//		(obj.config_val('igdWanStatus_AdvancedDNSEnable_') == '0'? get_words('_disabled'): get_words('_enabled'))
//	);
	
	// LAN
	var tmp_lan_mac = "<!--# echo lan_mac -->";
	var tmp_lan_ip = "<!--# echo lan_ipaddr -->";
	var tmp_lan_netmask = "<!--# echo lan_netmask -->";
	
	$('#lan_mac').html(tmp_lan_mac);
	$('#lan_ip').html(tmp_lan_ip);
	$('#lan_netmask').html(tmp_lan_netmask);
	$('#lan_dhcpd_enable').html(
		(get_by_id("dhcpd_enable").value == '0'? get_words('_disabled'): get_words('_enabled'))
	);
	
	//2.4G
	var wlan0_enable = "<!--# echo wlan0_vap0_enable -->";
	var tmp_wlan0_mac = "<!--# echo wlan0_mac -->";

	if (wlan0_exist != "NULL" && wlan0_enable == "1")
	{
		$('#wlan0_mac').html(tmp_wlan0_mac);
		$('#wlan0_channel').html(wlan0_channel);

		var secCfg = [wlan0_vap0_security, wlan0_vap2_security,
		              wlan0_vap3_security, wlan0_vap1_security];
		var ssid   = [wlan0_vap0_ssid, wlan0_vap2_ssid,
		              wlan0_vap3_ssid, wlan0_vap1_ssid];

		for (var i = 0; i < 4; i++) {
			var security = secCfg[i].split("_");
			var wpamode = "";
			
			if (security[0] == "wpa2") {
				if (security[1] == "psk") {
					wpamode = get_words('bws_WPAM_3');
					$('#wlan0_vap'+i+'_ssid').text(ssid[i]+' / '+wpamode+ " - PSK").html();
				} else if (security[1] == "eap") {
					wpamode = get_words('bws_WPAM_3');
					$('#wlan0_vap'+i+'_ssid').text(ssid[i]+' / '+wpamode+ " - EAP").html();
				}
			} else if (security[0] == "wpa") {					
				if (security[1] == "psk") {
					wpamode = get_words('bws_WPAM_1');
					$('#wlan0_vap'+i+'_ssid').text(ssid[i]+' / '+wpamode+ " - PSK").html();
				}else if (security[1] == "eap") {
					wpamode = get_words('bws_WPAM_1');
					$('#wlan0_vap'+i+'_ssid').text(ssid[i]+' / '+wpamode+ " - EAP").html();
				}
			} else if (secCfg[i] == "wpa2auto_eap") {
				wpamode = get_words('bws_WPAM_2');
				$('#wlan0_vap'+i+'_ssid').text(ssid[i]+' / '+wpamode+ " - EAP").html();
			} else if(secCfg[i] == "wpa2auto_psk") {
				wpamode = get_words('bws_WPAM_2');
				$('#wlan0_vap'+i+'_ssid').text(ssid[i]+' / '+wpamode+ " - PSK").html();
			} else if (secCfg[i] == "disable") {
				$('#wlan0_vap'+i+'_ssid').text(ssid[i]+' / '+get_words('_disable_s')).html();
			} else if(security[0] == "wep") {					//WEP
				var keyLenStr = "";
				var authTypeStr = "";
					
				$('#wlan0_vap'+i+'_ssid').text(ssid[i]+' / '+get_words('_WEP')).html();
			}
		}
	}

	//5G
	//wlan1_exist = 1;
	var wlan1_enable = "<!--# echo wlan1_vap0_enable -->";
	var tmp_wlan1_mac = "<!--# echo wlan1_mac -->";

	if (wlan1_exist != "NULL" && wlan1_enable == "1")
	{
		$('#wlan1_mac').html(tmp_wlan1_mac);
		$('#wlan1_channel').html(wlan1_channel);

		var secCfg = [wlan1_vap0_security, wlan1_vap2_security,
		              wlan1_vap3_security, wlan1_vap1_security];
		var ssid   = [wlan1_vap0_ssid, wlan1_vap2_ssid,
		              wlan1_vap3_ssid, wlan1_vap1_ssid];

		for (var i = 0; i < 4; i++) {
			var security = secCfg[i].split("_");
			var wpamode = "";
			
			if (security[0] == "wpa2") {
				if (security[1] == "psk") {
					wpamode = get_words('bws_WPAM_3');
					$('#wlan1_vap'+i+'_ssid').text(ssid[i]+' / '+wpamode+ " - PSK").html();
				} else if (security[1] == "eap") {
					wpamode = get_words('bws_WPAM_3');
					$('#wlan1_vap'+i+'_ssid').text(ssid[i]+' / '+wpamode+ " - EAP").html();
				}
			} else if (security[0] == "wpa") {					
				if (security[1] == "psk") {
					wpamode = get_words('bws_WPAM_1');
					$('#wlan1_vap'+i+'_ssid').text(ssid[i]+' / '+wpamode+ " - PSK").html();
				}else if (security[1] == "eap") {
					wpamode = get_words('bws_WPAM_1');
					$('#wlan1_vap'+i+'_ssid').text(ssid[i]+' / '+wpamode+ " - EAP").html();
				}
			} else if (secCfg[i] == "wpa2auto_eap") {
				wpamode = get_words('bws_WPAM_2');
				$('#wlan1_vap'+i+'_ssid').text(ssid[i]+' / '+wpamode+ " - EAP").html();
			} else if(secCfg[i] == "wpa2auto_psk") {
				wpamode = get_words('bws_WPAM_2');
				$('#wlan1_vap'+i+'_ssid').text(ssid[i]+' / '+wpamode+ " - PSK").html();
			} else if (secCfg[i] == "disable") {
				$('#wlan1_vap'+i+'_ssid').text(ssid[i]+' / '+get_words('_disable_s')).html();
			} else if(security[0] == "wep") {					//WEP
				var keyLenStr = "";
				var authTypeStr = "";
					
				$('#wlan1_vap'+i+'_ssid').text(ssid[i]+' / '+get_words('_WEP')).html();
			}
		}
	}	
	
	set_control_button();
/*
	var end_time = new Date();
	end_time= end_time.getTime();
	var cal_time = (end_time-start_time)/1000 ;
	if (cal_time<=3)
		setTimeout("getDeviceStatus()",3000);
	else
		setTimeout("getDeviceStatus()",cal_time*1000);
*/
}

	var time_daylight_saving_enable = "<!--# echo time_daylight_saving_enable-->";
	var time_daylight_saving_start_month = "<!--# echo time_daylight_saving_start_month-->";
	var time_daylight_saving_start_week = "<!--# echo time_daylight_saving_start_week-->";
	var time_daylight_saving_start_day_of_week = "<!--# echo time_daylight_saving_start_day_of_week-->";
	var time_daylight_saving_start_time = "<!--# echo time_daylight_saving_start_time-->";
	var time_daylight_saving_end_month = "<!--# echo time_daylight_saving_end_month-->";
	var time_daylight_saving_end_week = "<!--# echo time_daylight_saving_end_week-->";
	var time_daylight_saving_end_day_of_week = "<!--# echo time_daylight_saving_end_day_of_week-->";
	var time_daylight_saving_end_time = "<!--# echo time_daylight_saving_end_time-->";	
	var time_daylight_offset = "<!--# echo time_daylight_offset -->";

function show_start(year,month) {

 var week = showWeekDate(year,month);
 var start_md_1st = week.week1.start.split("/");
 var start_md_2st = week.week2.start.split("/");
 var start_md_3st = week.week3.start.split("/");
 var start_md_4st = week.week4.start.split("/");
 var start_md_5st = week.week5.start.split("/");
 if(week.hasOwnProperty("week6"))
   {
 var start_md_6st = week.week6.start.split("/");
}

 var end_md_1st = week.week1.end.split("/");
 var end_md_2st = week.week2.end.split("/");
 var end_md_3st = week.week3.end.split("/");
 var end_md_4st = week.week4.end.split("/");
 var end_md_5st = week.week5.end.split("/");
 if(week.hasOwnProperty("week6"))
   {
 var end_md_6st = week.week6.end.split("/");
}

var st_day=[];
var ed_day=[];
if(time_daylight_saving_start_week =="1"){
st_day=start_md_1st[0];
}else if(time_daylight_saving_start_week =="2"){
st_day=start_md_2st[0];
}else if(time_daylight_saving_start_week =="3"){
st_day=start_md_3st[0];
}else if(time_daylight_saving_start_week =="4"){
st_day=start_md_4st[0];
}else if(time_daylight_saving_start_week =="5"){
st_day=start_md_5st[0];
}else if(time_daylight_saving_start_week =="6"){
st_day=start_md_6st[0];
 }

var day_light_start = ""+time_daylight_saving_start_month+" "+st_day+" "+year+" "+time_daylight_saving_start_time+":"+"00"+":"+"00";

var now = ""+change_mon(nNow.getMonth()) +" "+nNow.getDate() +" "+nNow.getFullYear() + " " +len_checked(nNow.getHours())+ ":" +len_checked(nNow.getMinutes())+ ":" +len_checked(nNow.getSeconds());

var d_s_time = Date.parse(day_light_start);
var n_s_time = Date.parse(now);

if(n_s_time > d_s_time){

var n_time;

n_time = new Date(n_s_time + (3600000*time_daylight_offset/3600));

var test = n_time.toString();

var time = test.split(" ");

var gg=[];

if(time[0]=="Mon"){
gg=time[0].replace("Mon","1");
}
else if(time[0]=="Tue"){
gg=time[0].replace("Tue","2");
}
else if(time[0]=="Wed"){
gg=time[0].replace("Wed","3");
}
else if(time[0]=="Thu"){
gg=time[0].replace("Thu","4");
}
else if(time[0]=="Fri"){
gg=time[0].replace("Fri","5");
}
else if(time[0]=="Sat"){
gg=time[0].replace("Sat","6");
}
else if(time[0]=="Sun"){
gg=time[0].replace("Sun","7");
}

var tt=[];

if(time[1]=="Jan"){
tt=time[1].replace("Jan","1");
}else if(time[1]=="Feb"){
tt=time[1].replace("Feb","2");
}else if(time[1]=="Mar"){
tt=time[1].replace("Mar","3");
}else if(time[1]=="Apr"){
tt=time[1].replace("Apr","4");
}else if(time[1]=="May"){
tt=time[1].replace("May","5");
}else if(time[1]=="Jun"){
tt=time[1].replace("Jun","6");
}else if(time[1]=="Jul"){
tt=time[1].replace("Jul","7");
}else if(time[1]=="Aug"){
tt=time[1].replace("Aug","8");
}else if(time[1]=="Sep"){
tt=time[1].replace("Sep","9");
}else if(time[1]=="Oct"){
tt=time[1].replace("Oct","10");
}else if(time[1]=="Nov"){
tt=time[1].replace("Nov","11");
}else if(time[1]=="Dec"){
tt=time[1].replace("Dec","12");
}

var QQ=[];

//QQ = time[4].split(":");

		//nNow = new Date(time[3],tt-1,time[2],QQ[0],QQ[1],QQ[2]); 
              if(time[3].length > 4){

             QQ = time[3].split(":");
             
             		nNow = new Date(time[5],tt-1,time[2],QQ[0],QQ[1],QQ[2]); 
              }else{

             QQ = time[4].split(":");
             
             		nNow = new Date(time[3],tt-1,time[2],QQ[0],QQ[1],QQ[2]); 
             
             }



}
}

function show_end(year,month) {

 var week = showWeekDate(year,month);
 var start_md_1st = week.week1.start.split("/");
 var start_md_2st = week.week2.start.split("/");
 var start_md_3st = week.week3.start.split("/");
 var start_md_4st = week.week4.start.split("/");
 var start_md_5st = week.week5.start.split("/");
 if(week.hasOwnProperty("week6"))
   {
 var start_md_6st = week.week6.start.split("/");
}

 var end_md_1st = week.week1.end.split("/");
 var end_md_2st = week.week2.end.split("/");
 var end_md_3st = week.week3.end.split("/");
 var end_md_4st = week.week4.end.split("/");
 var end_md_5st = week.week5.end.split("/");
 if(week.hasOwnProperty("week6"))
   {
 var end_md_6st = week.week6.end.split("/");
}

var st_day=[];
var ed_day=[];


if(time_daylight_saving_start_week =="1"){
st_day=start_md_1st[0];
}else if(time_daylight_saving_start_week =="2"){
st_day=start_md_2st[0];
}else if(time_daylight_saving_start_week =="3"){
st_day=start_md_3st[0];
}else if(time_daylight_saving_start_week =="4"){
st_day=start_md_4st[0];
}else if(time_daylight_saving_start_week =="5"){
st_day=start_md_5st[0];
}else if(time_daylight_saving_start_week =="6"){
st_day=start_md_6st[0];
 }


if(time_daylight_saving_end_week =="1"){
ed_day=end_md_1st[0];
}else if(time_daylight_saving_end_week =="2"){
ed_day=end_md_2st[0];
}else if(time_daylight_saving_end_week =="3"){
ed_day=end_md_3st[0];
}else if(time_daylight_saving_end_week =="4"){
ed_day=end_md_4st[0];
}else if(time_daylight_saving_end_week =="5"){
ed_day=end_md_5st[0];
}else if(time_daylight_saving_end_week =="6"){
ed_day=end_md_6st[0];
}


var day_light_end = ""+time_daylight_saving_end_month+" "+ed_day+" "+year+" "+time_daylight_saving_end_time+":"+"00"+":"+"00";

var now = ""+change_mon(nNow.getMonth()) +" "+nNow.getDate() +" "+nNow.getFullYear() + " " +len_checked(nNow.getHours())+ ":" +len_checked(nNow.getMinutes())+ ":" +len_checked(nNow.getSeconds());

var e_s_time = Date.parse(day_light_end);
var n_s_time = Date.parse(now);

if(n_s_time > e_s_time){


var n_time;

n_time = new Date(n_s_time - (3600000*time_daylight_offset/3600));


var test = n_time.toString();

var time = test.split(" ");

var gg=[];

if(time[0]=="Mon"){
gg=time[0].replace("Mon","1");
}
else if(time[0]=="Tue"){
gg=time[0].replace("Tue","2");
}
else if(time[0]=="Wed"){
gg=time[0].replace("Wed","3");
}
else if(time[0]=="Thu"){
gg=time[0].replace("Thu","4");
}
else if(time[0]=="Fri"){
gg=time[0].replace("Fri","5");
}
else if(time[0]=="Sat"){
gg=time[0].replace("Sat","6");
}
else if(time[0]=="Sun"){
gg=time[0].replace("Sun","7");
}

var tt=[];

if(time[1]=="Jan"){
tt=time[1].replace("Jan","1");
}else if(time[1]=="Feb"){
tt=time[1].replace("Feb","2");
}else if(time[1]=="Mar"){
tt=time[1].replace("Mar","3");
}else if(time[1]=="Apr"){
tt=time[1].replace("Apr","4");
}else if(time[1]=="May"){
tt=time[1].replace("May","5");
}else if(time[1]=="Jun"){
tt=time[1].replace("Jun","6");
}else if(time[1]=="Jul"){
tt=time[1].replace("Jul","7");
}else if(time[1]=="Aug"){
tt=time[1].replace("Aug","8");
}else if(time[1]=="Sep"){
tt=time[1].replace("Sep","9");
}else if(time[1]=="Oct"){
tt=time[1].replace("Oct","10");
}else if(time[1]=="Nov"){
tt=time[1].replace("Nov","11");
}else if(time[1]=="Dec"){
tt=time[1].replace("Dec","12");
}

var QQ=[];

//QQ = time[4].split(":");

//		nNow = new Date(time[3],tt-1,time[2],QQ[0],QQ[1],QQ[2]); 
              if(time[3].length > 4){

             QQ = time[3].split(":");
             
             		nNow = new Date(time[5],tt-1,time[2],QQ[0],QQ[1],QQ[2]); 
              }else{

             QQ = time[4].split(":");
             
             		nNow = new Date(time[3],tt-1,time[2],QQ[0],QQ[1],QQ[2]); 
             
             }

}



}

function showWeekDate(year,month)
{ 
 var date = new Date();
 if (year.length > 0 && month.length > 0 ) 
  {
  date = new Date(year,month-1,1);
  } else {
  date = new Date(date.getFullYear(),date.getMonth(),1);
  }
  
 var week = new Object;
 week.week1 = new Object;
 week.week2 = new Object;
 week.week3 = new Object;
 week.week4 = new Object;
 week.week5 = new Object;
 
 week.today = date.getDay();
 if (week.today == 0) 
 {
  date.setDate(date.getDate()+1);
  week.today = date.getDay();
 }
 

 week.week1.workDays = 5-week.today+1;
 if (week.week1.workDays<0) week.week1.workDays=0;

 week.week1.start = date.getDate()+"/"+(date.getMonth()+1);

 date.setDate(date.getDate()+(1+week.week1.workDays));
 week.week1.end = date.getDate()+"/"+(date.getMonth()+1);

 date.setDate(date.getDate()+1);
 week.week2.workDays = 5;
 week.week2.start = date.getDate()+"/"+(date.getMonth()+1);

 date.setDate(date.getDate()+(1+week.week2.workDays));
 week.week2.end = date.getDate()+"/"+(date.getMonth()+1);

 date.setDate(date.getDate()+1);
 week.week3.workDays = 5;
 week.week3.start = date.getDate()+"/"+(date.getMonth()+1);

 date.setDate(date.getDate()+(1+week.week3.workDays));
 week.week3.end = date.getDate()+"/"+(date.getMonth()+1);

 date.setDate(date.getDate()+1);
 week.week4.workDays = 5;
 week.week4.start = date.getDate()+"/"+(date.getMonth()+1);

 date.setDate(date.getDate()+(1+week.week4.workDays));
 week.week4.end = date.getDate()+"/"+(date.getMonth()+1);


 date.setDate(date.getDate()+1);
 week.week5.start = date.getDate()+"/"+(date.getMonth()+1);
 

        var nextMonth = new Date(date.getFullYear(),date.getMonth()+1,1);
 var monthLastDay = new Date(nextMonth-86400000); 
 
 date.setDate(date.getDate()+6);
      if (date <= monthLastDay)
 {
  week.week5.workDays = 5;
  week.week5.end = date.getDate()+"/"+(date.getMonth()+1); 
  if (date < monthLastDay) {
   week.week6 = new Object;
   date.setDate(date.getDate()+1);
   week.week6.start = date.getDate()+"/"+(date.getMonth()+1);
   week.week6.end = monthLastDay.getDate()+"/"+(date.getMonth()+1);
   week.week6.workDays = monthLastDay.getDay();
  }
 } else {
  week.week5.end = monthLastDay.getDate()+"/"+(monthLastDay.getMonth()+1);
  week.week5.workDays = monthLastDay.getDay();
  if (week.week5.workDays >5 ) week.week5.workDays = 5;   
 }

 return week;
}


function check_daylight_saving(){

                     d = new Date();

                     var test_year = ""+d.getFullYear()+"";

                     show_start(test_year,time_daylight_saving_start_month);

                     show_end(test_year,time_daylight_saving_end_month);

}

function get_time(){
	var time_zone_area ="<!--# echo time_zone_area-->";
	var time_zone = "<!--# echo time_zone-->"
	
	var ntp_client ="<!--# echo ntp_client_enable-->";

	      d = new Date();
	       var offset;
		if (gTime){
			return;
		}
	
		offset = (parseInt(time_zone)* 3.75)/60;


		gTime = "<!--# exec cgi /bin/date +%s-->";

		var teste ;

		var router_tz = "<!--# exec cgi /bin/date +%z-->";
		var router_tz_offset_sign = router_tz.substring(0,1);
		var router_tz_offset_hour = parseInt(router_tz_offset_sign + router_tz.substring(1,3), 10);
		var router_tz_offset_min = parseInt(router_tz_offset_sign + router_tz.substring(3), 10);
		var router_tz_offset = (router_tz_offset_hour*60) + router_tz_offset_min;

		var teste = gTime * 1000 + (d.getTimezoneOffset() * 60000);
		
	 if(time_daylight_saving_enable =="1"){
  	       	
  	       	nd = new Date(teste + (60000*router_tz_offset));
	}else{
              	nd = new Date(teste + (3600000*offset));
 	}
	var test = nd.toString();

	var time = test.split(" ");

	var gg=[];

	if(time[0]=="Mon"){
		gg=time[0].replace("Mon","1");
	}
	else if(time[0]=="Tue"){
		gg=time[0].replace("Tue","2");
	}
	else if(time[0]=="Wed"){
		gg=time[0].replace("Wed","3");
	}
	else if(time[0]=="Thu"){
		gg=time[0].replace("Thu","4");
	}
	else if(time[0]=="Fri"){
		gg=time[0].replace("Fri","5");
	}
	else if(time[0]=="Sat"){
		gg=time[0].replace("Sat","6");
	}
	else if(time[0]=="Sun"){
		gg=time[0].replace("Sun","7");
	}

	var tt=[];

	if(time[1]=="Jan"){
		tt=time[1].replace("Jan","1");
	}else if(time[1]=="Feb"){
		tt=time[1].replace("Feb","2");
	}else if(time[1]=="Mar"){
		tt=time[1].replace("Mar","3");
	}else if(time[1]=="Apr"){
		tt=time[1].replace("Apr","4");
	}else if(time[1]=="May"){
		tt=time[1].replace("May","5");
	}else if(time[1]=="Jun"){
		tt=time[1].replace("Jun","6");
	}else if(time[1]=="Jul"){
		tt=time[1].replace("Jul","7");
	}else if(time[1]=="Aug"){
		tt=time[1].replace("Aug","8");
	}else if(time[1]=="Sep"){
		tt=time[1].replace("Sep","9");
	}else if(time[1]=="Oct"){
		tt=time[1].replace("Oct","10");
	}else if(time[1]=="Nov"){
		tt=time[1].replace("Nov","11");
	}else if(time[1]=="Dec"){
		tt=time[1].replace("Dec","12");
	}

	var QQ=[];

		//QQ = time[4].split(":");

		//nNow = new Date(time[3],tt-1,time[2],QQ[0],QQ[1],QQ[2]); 
              if(time[3].length > 4){

             QQ = time[3].split(":");
             
             		nNow = new Date(time[5],tt-1,time[2],QQ[0],QQ[1],QQ[2]); 
              }else{

             QQ = time[4].split(":");
             
             		nNow = new Date(time[3],tt-1,time[2],QQ[0],QQ[1],QQ[2]); 
             
             }

	/*if(time_daylight_saving_enable =="1"){

	       check_daylight_saving();

	}*/
}

function STime(){
		nNow.setTime(nNow.getTime() + 1000);
              var fulldate = ' '+change_week(nNow.getDay()) +' '+change_mon(nNow.getMonth()) +', '+nNow.getDate() +', '+nNow.getFullYear()
				+ ' ' +len_checked(nNow.getHours())+ ':' +len_checked(nNow.getMinutes())+ ':' +len_checked(nNow.getSeconds());
	
	$("#sysTime").html(fulldate);		
		setTimeout('STime()', 1000);
}

	function padout(number) {
		return (number < 10) ? '0' + number : number;
	}

function caculate_time(inseconds){
		var wTime = inseconds;
		var days = Math.floor(wTime / 86400);
		wTime %= 86400;
		var hours = Math.floor(wTime / 3600);
		wTime %= 3600;
		var mins = Math.floor(wTime / 60);
		wTime %= 60;

		var result;

		result = days + " " + 
			((days <= 1) ? "Day" : "Days")
			+ ", ";
		result += hours + ":" + padout(mins) + ":" + padout(wTime);

		return result;
}

function get_wan_time(){
		wTimesec = "<!--# exec cgi /bin/system_time get_wantime 1 -->";
		if(wTimesec == 0 || con_status == "Disconnected" || con_status == ""){
			wan_time = get_words('_na');
		}else{
			wTimesec = wTimesec/100;
			wan_time = caculate_time(wTimesec);
		}
}
function WTime(){
		if(con_status == "Disconnected" || con_status == "") {
			wan_time = get_words('_na');
			wTimesec = 0;
		}
	
		//$("#sysUptime").html(wan_time);
		if(wTimesec != 0){
			wTimesec++;
			wan_time=caculate_time(wTimesec);
		}
		setTimeout('WTime()', 1000);
}

function get_up_time(){
	upTimesec = "<!--# exec cgi /bin/system_time get_booting_time -->";
	//if(upTimesec == 0)
		//up_time = get_words('_na');
	//else
		//up_time = caculate_time(upTimesec);
}

function UpTime(){
	if(upTimesec != 0){
		upTimesec++;
		up_time = caculate_time(upTimesec);
	}
	else
		up_time = get_words('_na');
		
	$("#sysUptime").html(up_time);
	setTimeout('UpTime()', 1000);
}

function set_control_button(){
	var wan_type = "<!--# echo wan_proto_ori -->";
	var button_position = $('#show_button')[0];
	if(wan_type != "0")
	{
		var button1_name = get_words("_connect");
		var button2_name = get_words("LS315");
		var button1_action;
		var button2_action;

                var login_who= checksessionStorage();

                if (wan_type == "dhcpc") {
                        button1_name = get_words("LS312");
                        button2_name = get_words("LS313");
                        button1_action ="wan_connection_type('dhcp_renew')";
                        button2_action ="wan_connection_type('dhcp_release')";
                }
                else if (wan_type == "pptp") {
                        button1_action ="wan_connection_type('pptp_connect')";
                        button2_action ="wan_connection_type('pptp_disconnect')";
                }
                else if (wan_type == "l2tp") {
                        button1_action ="wan_connection_type('l2tp_connect')";
                        button2_action ="wan_connection_type('l2tp_disconnect')";
                }
                else if (wan_type == "pppoe") {
                        button1_action ="wan_connection_type('pppoe_connect')";
                        button2_action ="wan_connection_type('pppoe_disconnect')";
                }
                else if (wan_type == "usb3g") {
                        button1_action ="wan_connection_type('usb3g_connect')";
                        button2_action ="wan_connection_type('usb3g_disconnect')";
                }
                else if (wan_type == "usb3g_phone") {
                        button1_action ="wan_connection_type('usb3g_phone_connect')";
                        button2_action ="wan_connection_type('usb3g_phone_disconnect')";
                }

		var ctrl_buttons =
		'<table id="box_statusButton" cellspacing="0" cellpadding="0" class="formarea">'+
		'<tr>'+
			'<td colspan="2" align="center" class="btn_field">'+
				'<input type="button" class="button_submit" id="connect" value="'+button1_name+'" onclick="'+button1_action+'" />'+
				'<input type="button" class="button_submit" id="disconnect" value="'+button2_name+'" onclick="'+button2_action+'" />'+
			'</td>'+
		'</tr>'+
		'</table>';
                
                if (wan_type != "static")
                        $("#ctrl_buttons").html(ctrl_buttons);
		if(login_who != "user")
		{
			if(cab_status == 'connect')
			{
				if(con_status == "Disconnected" || con_status == "Idle")
				{
					$('#network_status').html(get_words('DISCONNECTED'));
					$("#disconnect").attr("disabled",true);
					$("#connect").attr("disabled",false);
				}
				else if(con_status == 'Connected'){
					$('#network_status').html(get_words('CONNECTED'));
					$("#disconnect").attr("disabled",false);
					$("#connect").attr("disabled",true);

				}
				else if(con_status == 'Connecting'){
					$('#network_status').html(get_words('ddns_connecting'));
					$("#disconnect").attr("disabled",false);
					$("#connect").attr("disabled",true);
				}
				else if(con_status == 'Disconnecting')
				{
					$('#network_status').html(get_words('ddns_disconnecting'));
					$("#disconnect").attr("disabled",true);
					$("#connect").attr("disabled",true);
				}
			}
			else{
				$('#network_status').html(get_words('DISCONNECTED'));
				$("#disconnect").attr("disabled",true);
				$("#connect").attr("disabled",true);
			}
		}
		else
		{
			if(con_status == "Disconnected")
				$('#network_status').html(get_words('DISCONNECTED'));
			else
				$('#network_status').html(get_words('CONNECTED'));
			$("#connect").attr("disabled",'disabled');
			$("#disconnect").attr("disabled",'disabled');
		}
	}
	else
	{
		if(con_status == "Disconnected")
			$('#network_status').html(get_words('DISCONNECTED'));
		else
			$('#network_status').html(get_words('CONNECTED'));
	}
}

function setValueSystemTime(){
	STime();
}

function setValueSystemUpTime(){
	get_up_time();
	UpTime();
}

$(function(){
	get_time();
	setValueSystemTime();
	//get_wan_time();
	//WTime();
	get_File();
	
//	getDeviceStatus();
	setValueSystemUpTime();
});

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
			<td style="background-image:url('/image/bg_l.gif');background-repeat:repeat-y;vertical-align:top;" width="270">
				<div style="padding-left:6px;">
				<script>document.write(menu.build_structure(1,0,0))</script>
				<p>&nbsp;</p>
				</div>
				<img src="/image/bg_l.gif" width="270" height="5" />
			</td>
			<!-- End of left menu -->

			<input type="hidden" id="html_response_page" name="html_response_page" value="count_down.asp">
			<input type="hidden" id="html_response_return_page" name="html_response_return_page" value="st_device.asp">
			<input type="hidden" id="wan_current_ipaddr" name="wan_current_ipaddr" value="<!--# echo wan_current_ipaddr_00 -->">
			<input type="hidden" id="wan_proto" name="wan_proto" value="<!--# echo wan_proto_ori -->">
			<input type="hidden" id="wan_pppoe_dynamic_00" name="wan_pppoe_dynamic_00" value="<!--# echo wan_pppoe_dynamic_00 -->">
			<input type="hidden" id="wan_pptp_dynamic" name="wan_pptp_dynamic" value="<!--# echo wan_pptp_dynamic -->">
			<input type="hidden" id="wan_l2tp_dynamic" name="wan_l2tp_dynamic" value="<!--# echo wan_l2tp_dynamic -->">
			<input type="hidden" id="dhcpd_enable" name="dhcpd_enable" value="<!--# echo dhcpd_enable -->">
			<input type="hidden" id="dhcpc_connection_status" name="dhcpc_connection_status" value="<!--# echo dhcpc_connection_status -->">
			<input type="hidden" id="pppoe_00_connection_status" name="pppoe_00_connection_status" value="<!--# echo pppoe_00_connection_status -->">
			<input type="hidden" id="pptp_connection_status" name="pptp_connection_status" value="<!--# echo pptp_connection_status -->">
			<input type="hidden" id="l2tp_connection_status" name="l2tp_connection_status" value="<!--# echo l2tp_connection_status -->">
			<input type="hidden" id="bigpond_connection_status" name="bigpond_connection_status" value="<!--# echo bigpond_connection_status -->">
			<input type="hidden" id="wan_pppoe_russia_enable" name="wan_pppoe_russia_enable" value="<!--# echo wan_pppoe_russia_enable -->">
			<input type="hidden" id="wan_pptp_russia_enable" name="wan_pptp_russia_enable" value="<!--# echo wan_pptp_russia_enable -->">
			<input type="hidden" id="wan_l2tp_russia_enable" name="wan_l2tp_russia_enable" value="<!--# echo wan_l2tp_russia_enable -->">
			<input type="hidden" id="wan_pptp_ipaddr" name="wan_pptp_ipaddr" value="<!--# echo wan_pptp_ipaddr -->">
			<input type="hidden" id="russia_wan_phy_ipaddr" name="russia_wan_phy_ipaddr" value="<!--# echo russia_wan_phy_ipaddr -->">

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
										<script>show_words('_status');</script>
									</div>
									<div class="hr"></div>
									<div class="section_content_border">
										<div class="header_desc" id="manStatusIntroduction">
											<script>show_words('_help_txt225');</script>
											<p></p>
										</div>
										<div class="box_tn">
											<div class="CT"><script>show_words('_system_info');</script></div>
											<table cellspacing="0" cellpadding="0" class="formarea">
											<!-- ----------------- System Info ----------------- -->
											<tr>
												<td class="CL"><script>show_words('sd_FWV');</script></td>
												<td class="CR"><span id="fwVer"><!--# echo sys_fw_version --><!--# echox sys_region NA --> , <!--# echo sys_fw_date --></span></td>
												<!--<td>1.0.0.2, 17-Jan-2008</td>-->
											</tr>
											<tr>
												<td class="CL"><script>show_words('_system_time');</script></td>
												<td class="CR"><span id="sysTime"></span></td>
											</tr>
											<tr>
												<td class="CL"><script>show_words('_system_up_time');</script></td>
												<td class="CR"><span id="sysUptime"></span></td>
											</tr>
											</table>
										</div>
										<div class="box_tn">
											<div class="CT"><script>show_words('_internet_configs');</script></div>
											<table cellspacing="0" cellpadding="0" class="formarea">
											<tr>
												<td class="CL" id="statusConnectedType"><script>show_words('_connected_type');</script></td>
												<td class="CR"><span id="connection_type"></span></td>
											</tr>
											<script>/*
												<tr>
													<td class="CL">WAN Network Status</td>
													<td><span id="wanNetworkStatus">&nbsp;</span></td>
												</tr>
											*/</script>
											<tr>
												<td class="CL" id="statusWANIPAddr"><script>show_words('_wan_ip_addr');</script></td>
												<td class="CR"><span id="wan_ip"></span></td>
											</tr>
											<tr>
												<td class="CL" id="statusSubnetMask"><script>show_words('_subnet');</script></td>
												<td class="CR"><span id="wan_netmask"></span></td>
											</tr>
											<tr>
												<td class="CL" id="statusDefaultGW"><script>show_words('_defgw');</script></td>
												<td class="CR"><span id="wan_gateway"></span></td>
											</tr>
											<tr>
												<td class="CL" id="statusPrimaryDNS"><script>show_words('_pri_dns');</script></td>
												<td class="CR"><span id="wan_dns1"></span></td>
											</tr>
											<tr>
												<td class="CL" id="statusSecondaryDNS"><script>show_words('_sec_dns');</script></td>
												<td class="CR"><span id="wan_dns2"></span></td>
											</tr>
											<tr style="display:none">
												<td class="CL" id="statusWANMAC"><script>show_words('_macaddr');</script></td>
												<td class="CR"><span id="show_mac"></span></td>
											</tr>
											</table>
											<!--
											/*
											** Date:	2013-02-08
											** Author:	Moa Chung
											** Reason:	fixed renew/release btn cannot enable/disable.
											**/
											-->
											<span id="network_status" style="display:none;"></span>
											<span id="ctrl_buttons">
											</span>
										</div>
										<div class="box_tn">
											<div class="CT"><script>show_words('_LAN');</script></div>
											<table cellspacing="0" cellpadding="0" class="formarea">
											<tr>
												<td class="CL"><script>show_words('_macaddr');</script></td>
												<td class="CR"><span id="lan_mac"></span></td>
											</tr>
											<tr>
												<td class="CL"><script>show_words('_ipaddr');</script></td>
												<td class="CR"><span id="lan_ip"></span></td>
											</tr>
											<tr>
												<td class="CL"><script>show_words('_subnet');</script></td>
												<td class="CR"><span id="lan_netmask"></span></td>
											</tr>
											</table>
										</div>
										<!-- 2.4GHz -->
										<div class="box_tn">
											<div class="CT"><script>show_words('_24Ghz_wireless');</script></div>
											<table cellspacing="0" cellpadding="0" class="formarea">
											<tr>
												<td class="CL"><script>show_words('_macaddr');</script></td>
												<td class="CR"><span id="wlan0_mac"></span></td>
											</tr>
											<tr>
												<td class="CL"><script>show_words('_channel');</script></td>
												<td class="CR"><span id="wlan0_channel"></span></td>
											</tr>
											<tr>
												<td class="CL"><script>show_words('sd_NNSSID');</script> / <script>show_words('sd_SecTyp');</script></td>
												<td class="CR"><span id="wlan0_vap0_ssid"></span></td>
											</tr>
											<tr style="display:none;">
												<td colspan="2" class="CELL"><span id="wlan0_vap0_security0"></span></td>
											</tr>
											<tr>
												<td class="CL"><script>show_words('_lb_multi_ssid_1');</script> / <script>show_words('sd_SecTyp');</script></td>
												<td class="CR"><span id="wlan0_vap1_ssid"></span></td>
											</tr>
											<tr style="display:none;">
												<td colspan="2" class="CELL"><span id="wlan0_vap0_security1"></span></td>
											</tr>
											<tr>
												<td class="CL"><script>show_words('_lb_multi_ssid_2');</script> / <script>show_words('sd_SecTyp');</script></td>
												<td class="CR"><span id="wlan0_vap2_ssid"></span></td>
											</tr>
											<tr style="display:none;">
												<td colspan="2" class="CELL"><span id="wlan0_vap0_security2"></span></td>
											</tr>
											<tr>
												<td class="CL"><script>show_words('_guest_network');</script> / <script>show_words('sd_SecTyp');</script></td>
												<td class="CR"><span id="wlan0_vap3_ssid"></span></td>
											</tr>
											<tr style="display:none;">
												<td colspan="2" class="CELL"><span id="wlan0_vap0_security3"></span></td>
											</tr>
											</table>
										</div>
										<!-- 5GHz -->
										<div class="box_tn">
											<div class="CT"><script>show_words('_5Ghz_wireless');</script></div>
											<table cellspacing="0" cellpadding="0" class="formarea">
											<tr>
												<td class="CL"><script>show_words('_macaddr');</script></td>
												<td class="CR"><span id="wlan1_mac"></span></td>
											</tr>
											<tr>
												<td class="CL"><script>show_words('_channel');</script></td>
												<td class="CR"><span id="wlan1_channel"></span></td>
											</tr>
											<tr>
												<td class="CL"><script>show_words('sd_NNSSID');</script> / <script>show_words('sd_SecTyp');</script></td>
												<td class="CR"><span id="wlan1_vap0_ssid"></span></td>
											</tr>
											<tr style="display:none;">
												<td colspan="2" class="CELL"><span id="wlan1_vap0_security0"></span></td>
											</tr>
											<tr>
												<td class="CL"><script>show_words('_lb_multi_ssid_1');</script> / <script>show_words('sd_SecTyp');</script></td>
												<td class="CR"><span id="wlan1_vap1_ssid"></span></td>
											</tr>
											<tr style="display:none;">
												<td colspan="2" class="CELL"><span id="wlan1_vap0_security1"></span></td>
											</tr>
											<tr>
												<td class="CL"><script>show_words('_lb_multi_ssid_2');</script> / <script>show_words('sd_SecTyp');</script></td>
												<td class="CR"><span id="wlan1_vap2_ssid"></span></td>
											</tr>
											<tr style="display:none;">
												<td colspan="2" class="CELL"><span id="wlan1_vap0_security2"></span></td>
											</tr>
											<tr>
												<td class="CL"><script>show_words('_guest_network');</script> / <script>show_words('sd_SecTyp');</script></td>
												<td class="CR"><span id="wlan1_vap3_ssid"></span></td>
											</tr>
											<tr style="display:none;">
												<td colspan="2" class="CELL"><span id="wlan1_vap0_security3"></span></td>
											</tr>
											</table>
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
</body>
</html>
