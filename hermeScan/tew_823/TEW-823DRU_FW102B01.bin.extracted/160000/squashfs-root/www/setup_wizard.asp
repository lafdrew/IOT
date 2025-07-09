<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html lang="en-US" xmlns="http://www.w3.org/1999/xhtml" xml:lang="en-US">
<head>
<script>
	//Jerry, redirect to doc root
	{
		var loc = window.location.pathname;
		var arr = loc.split('/');
		try {
			if (arr.length > 2) //more than one directory
			{
				location.replace('/wizard_router.asp');
			}
		} catch (e) {
		}
	}
</script>
<title>TRENDNET | modelName | Wizard</title>
<style type="text/css">
/*
 * Styles used only on this page.
 * WAN mode radio buttons
 */
#wan_modes p {
	margin-bottom: 1px;
}
#wan_modes input {
	float: left;
	margin-right: 1em;
}
#wan_modes label.duple {
	float: none;
	width: auto;
	text-align: left;
}
#wan_modes .itemhelp {
	margin: 0 0 1em 2em;
}

/*
 * Wizard buttons at bottom wizard "page".
 */
#wz_buttons {
	margin-top: 1em;
	border: none;
}

#wz_progress {
  background-color:#bca;
  border:2px solid green;
}

body{ font-size:12px;
margin: 8px;
}
.langmenu{
position: absolute;
display: none;
background: white;
border: 1px solid #555555;
border-width: 5px 0px 5px 0px;
padding: 10px;
font: normal 12px Verdana;
z-index: 100;
}

.langmenu .column{
float: left;
width: 120px; /*width of each menu column*/
margin-right: 5px;
}

.langmenu .column ul{
margin: 0;
padding: 0;
list-style-type: none;
}

.langmenu .column ul li{
padding-bottom: 8px;
}

.langmenu .column ul li a{
text-decoration: none;
}
#progressbar {
	height: 20px;
	background: #666666;
	border-width: thin;
	border-style: solid;
}
.CL {
	padding-left: 100px;
}
</style>
<meta http-equiv=Content-Type content="text/html; charset=UTF-8">
<meta http-equiv="pragma" content="no-cache" />
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
var menu = new menuObject();
var submit_button_flag = 0;
var salt = "345cd2ef";
var wan_mac		= "<!--# echo wan_mac -->";
var br_lang = "<!--# echo sys_wizard_lang -->";
var alreadyconf = "<!--# echo setup_wizard_rt -->";
var is_support = 0;
var wan_detect_id = 0;
var detect_try_again_id = 0;
var wan_info_id = 0;
var wan_cable_status = "", wan_connection_status = "";
var wan_detect_type = "", p2_ip= "";
var obj = new ccpObject();
var tmp_alert_count = 1, check_wan_id = 0, direct_dhcp_save = 0;
var p2_subnet = "", p2_gw = "", p2_dns = "", p1_dns = "";
var staticip = "", staticmask = "", staticgw = "";
var wan_proto_type = "";
var unplug = 0;


function clear_timing_events() {
	/* clear delay execute function */
	clearTimeout(wan_info_id);
	clearTimeout(wan_detect_id);
	clearTimeout(detect_try_again_id);
}

function createRequest() {
	var XMLhttpObject = false;
	if(window.XMLHttpRequest) {
		try {
			XMLhttpObject = new XMLHttpRequest();
		} catch (e) {
		}
	} else if(window.ActiveXObject) {
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

function wan_info_xmldoc() {
	if(xmlhttp.readyState == 4 && xmlhttp.status == 200) {
		try {
			wan_cable_status = xmlhttp.responseXML.getElementsByTagName("wan_cable_status")[0].firstChild.nodeValue;
			p2_ip = xmlhttp.responseXML.getElementsByTagName("wan_ip")[0].firstChild.nodeValue;
			p2_subnetmask = xmlhttp.responseXML.getElementsByTagName("wan_netmask")[0].firstChild.nodeValue;
			p2_defgw = xmlhttp.responseXML.getElementsByTagName("wan_default_gateway")[0].firstChild.nodeValue;
			p2_dns1 = xmlhttp.responseXML.getElementsByTagName("wan_primary_dns")[0].firstChild.nodeValue;
			if (p2_dns1=== "NULL" ) p2_dns1 = "0.0.0.0";
			p2_dns2 = xmlhttp.responseXML.getElementsByTagName("wan_secondary_dns")[0].firstChild.nodeValue;
			if (p2_dns2=== "NULL" ) p2_dns2 = "0.0.0.0";
			wan_connection_status = xmlhttp.responseXML.getElementsByTagName("wan_connection_status")[0].firstChild.nodeValue;
			
			if (wan_cable_status == 'connect')
				clearTimeout(wan_detect_id);
		} catch(e) {
		}
	}
}

function get_wan_info() {
	xmlhttp = new createRequest();
	if(xmlhttp) {
		var url = "";
		var temp_cURL = document.URL.split("/");
		for(var i = 0; i < temp_cURL.length - 1; i++) {
			if(i == 1)
				continue;
			if(i == 0)
				url += temp_cURL[i] + "//";
			else
				url += temp_cURL[i] + "/";
		}
		url += "device_status.xml";
		xmlhttp.onreadystatechange = wan_info_xmldoc;
		xmlhttp.open("GET", url, true);
		xmlhttp.send(null);
	}
	wan_detect_id = setTimeout("get_wan_info()", 3000);
}

function wan_detect_xmldoc() {
	$.ajax({
              	type: "GET",
                url: "auto-detect.asp",
      	        async: true,
              	cache: false,
      	        complete : function(data){
   	        		try{
										wan_detect_type = data.responseText;
										wan_detect_type = trim_string(wan_detect_type);
				
										if(wan_detect_type != "") {
											clearTimeout(wan_detect_id);
											switch(wan_detect_type) {
												case 'dhcpc':		//dhcp
													direct_dhcp_save = 1;
													wz_p3a_save();
													//setTimeout("show_page_p2()", 10000);
													wan_proto_type = "dhcpc";
													break;
												case 'pppoe':		//pppoe
													show_page_p3c();
													wan_proto_type = "pppoe";
													break;
												default:	//unknown type
													if (wan_cable_status == 'connect') {
														show_page_p3();//setp 4
													}
													break;
											}
										}else{
											/* unable to detect */
											detect_try_again_id = setTimeout("detect_try_again()", 2500);
											wan_detect_id = setTimeout("wan_detect_xmldoc()", "3000");
										}
									}catch(e){
									}
								}
        });
}


function get_ip()
{
	var web_url;
	var temp_cURL = document.URL.split('/');

	var next_page;
	if(alreadyconf=='0')
		next_page='adm_status.asp';
	else
		next_page='login_pic.asp';

	return next_page;
}
function check_browser()	//chk support bookmark and lang
{
	var chkMSIE = (navigator.userAgent.match(/msie/gi) == 'MSIE') ? true : false ;
	var isMSIE = (-[1,]) ? false : true;

	if(window.sidebar && window.sidebar.addPanel){ //Firefox
		is_support = 1;
	}else if (chkMSIE && window.external) {  //IE favorite
		is_support = 2;
	}
	return is_support;
}
function chk_browser_lang()
{
	check_browser();
	if (is_support == 2)	// ie only
		curr_lang = window.navigator.userLanguage;
	else	// other browser
		curr_lang = window.navigator.language;

	currLindex = lang_compare(curr_lang);
	lang_change(currLindex);
	return currLindex;
}
function user_sel_lang(index)
{
	lang_change(index);
	var temp_cURL = document.URL.split('#');
	if (temp_cURL.length>1)
	{
		lang_change(temp_cURL[1]);
	}
}

/* language change */
function lang_change(Nlang)
{
	var indexL =Nlang.split('#');
	var temp_cURL = document.URL.split('#');
	if (indexL.length>1)
	{
		Nlang = indexL[1];
		$('#curr_language').val(Nlang);
		if (indexL[1] != br_lang)
		{
			send_change_lang_ajax_submit(Nlang);
			return;
		}
	}else if ((Nlang != br_lang) || (temp_cURL.length == 1) || (br_lang == 0))
	{
		send_change_lang_ajax_submit(Nlang);
		return;
	}
}
function send_change_lang_ajax_submit(Nlang)
{
	var time=new Date().getTime();
	var temp_cURL = document.URL.split('#');
	var ajax_param = {
		type: 	"POST",
		async:	false,
		url: 	'apply.cgi',
		data: 	'html_response_page=wizard_router.asp&action=wizard_lang&changed=1&lang='+Nlang,				
		success: function(data) {
			window.location.href = temp_cURL[0] +'#'+Nlang;
			window.location.reload(true);
		}
	};
	$.ajax(ajax_param);
}

function wizard_cancel(){
	if(confirm(get_words('_wizquit'))){
		clear_timing_events();	
		if(submit_button_flag == 0){
			submit_button_flag = 1;
			var tmp_response= get_ip();
			get_by_id("html_response_page").value = tmp_response;
			send_submit("form2");
		}
	}
}
function show_page(page){
	$('div[name=page]').hide();
	$('#'+page).show();
}
<!-- p0 -->
function show_page_p0(){
	clear_timing_events();
	wan_detect_type = "";
	get_wan_info();
	show_page('p0');
	change_step(1);
}
<!-- p1 -->
var probe_count  = 0;
var progressBarMaxWidth = 500;
function show_page_p1(){
	sleep(3000);
	//get_wan_info();
	$('#progressbar').width(0);
	show_page('p1');
	change_step(1);
	var curWidth = $('#progressbar').width();
	var fieldWidth = curWidth + (progressBarMaxWidth)/90;
	$('#progressbar').width(fieldWidth);
	
	if(setTimeout('check_cable_status()',3000)){
		setTimeout('wan_detect_xmldoc()',1500);
		//draw_progress_bar();
		
		//probe_count = 0;
		//do_probe();
		//setTimeout('get_probe_state()',1500);
		draw_progress_bar();
	}
	return true;
}

function sleep(ms){

var starttime= new Date().getTime();

do{

}while((new Date().getTime()-starttime)<ms)

}

function check_cable_status()
{
	
	//sleep(3000);
	if (wan_cable_status == 'connect') {	//skip try again page	//usar
		return true;
	}else{
		alert(get_words("_tnw_14"));
		unplug = 1;
		clear_timing_events();
		return false;
}
}
function draw_progress_bar()
{
	var curWidth = $('#progressbar').width();
	var fieldWidth = curWidth + (progressBarMaxWidth)/90;
		if (progressBarMaxWidth<=fieldWidth) {
			$('#progressbar').width(progressBarMaxWidth);
			return;
		}
		else {
			if (unplug == 1){
				unplug = 0;
				return;
			}else{
				$('#progressbar').width(fieldWidth);
				setTimeout('draw_progress_bar()', 100);
			}
		}
}
function do_probe()
{
	var time=new Date().getTime();
	var ajax_param = {
		type: 	"POST",
		async:	true,
		url: 	'easy_setup.ccp',
		data: 	'ccp_act=do_probe&es_step=0'+"&"+time+"="+time
	};
	$.ajax(ajax_param);
}
function get_probe_state_hldr(data)
{
	wz_probe_wan = get_node_value(data, 'probe_status');
//	console.log("wz_probe_wan", wz_probe_wan);
	if (wz_probe_wan == '10' || probe_count++ >= 9) {		//probe finished: 10
		$('#progressbar').width(progressBarMaxWidth);
		show_page_p3();//setp 4
		return;
	}
	if (wz_probe_wan != '' && wz_probe_wan != '0') {
		$('#progressbar').width(progressBarMaxWidth);
		check_probe_wan();
		return;
	}
	setTimeout('get_probe_state()', 1000);
}
function get_probe_state()
{
	var time=new Date().getTime();
	var ajax_param = {
		type: 	"POST",
		async:	true,
		url: 	'easy_setup.ccp',
		data: 	'ccp_act=get_probe_state&es_step=0'+"&"+time+"="+time,
		success: function(data) {
			get_probe_state_hldr(data);
		},
		error: function(xhr, ajaxOptions, thrownError){
			if (xhr.status == 200) {
				try {
					setTimeout(function() {
						document.write(xhr.responseText);
					}, 0);
				} catch (e) {
				}
			}
		}
	};
	$.ajax(ajax_param);
}
<!-- check probe_wan -->
function check_probe_wan()
{
	switch(wz_probe_wan) {
		case '1':		//dhcp
			show_page_p2();//setp 3
			break;
		case '2':		//pppoe
			show_page_p3c();
			break;
		default:	//unknown type
			show_page_p3();//setp 4
			break;
	}
}
<!-- p2 -->
function show_page_p2(){
	clear_timing_events();
	show_page('p2');
	change_step(2);

	var p2_mac = "<!--# echo wan_mac -->";
	var p2_ssid = "<!--# echot wlan0_vap0_ssid -->";
	var p2_wsec = "<!--# echo wlan0_vap0_security -->";
	var p2_ssid5 = "<!--# echot wlan1_vap0_ssid -->";
	var p2_wsec5 = "<!--# echo wlan1_vap0_security -->";

	var authType, authType5;
	var security = p2_wsec.split("_");
	var security5 = p2_wsec5.split("_");
	
	if(p2_wsec== "disable")//None
	{
		authType = get_words('_none');
	}
	else if(p2_wsec== "wep")//WEP_MODE
	{
		if(security[1] == "auto" || security[1] == "open")//AUTO
		{
			authType = get_words('_wifiser_mode2');
		}
		else//SHARE
		{
			authType = get_words('_wifiser_mode1');
		}
	}
	else if(security[1] == "psk")//WPA_P
	{
		if(security[0] == "wpa2auto")//AUTO
			authType = get_words('_wifiser_mode5');
		if(security[0] == "wpa2")//WPA2
			authType = get_words('_wifiser_mode4');
		if(security[0] == "wpa")//WPA
			authType = get_words('_wifiser_mode3');
	}
	else if(security[1] == "eap")//WPA_E
	{
		if(security[0] == "wpa2auto")//AUTO
			authType = get_words('_wifiser_mode7');
		if(security[0] == "wpa2")//WPA2
			authType = get_words('_wifiser_mode6');
		if(security[0] == "wpa")//WPA
			authType = get_words('_WPA');
	}
	
	//5G
	if(p2_wsec5== "disable")//None
	{
		authType5 = get_words('_none');
	}
	else if(p2_wsec5== "wep")//WEP_MODE
	{
		if(security5[1] == "auto" || security5[1] == "open")//AUTO
		{
			authType5 = get_words('_wifiser_mode2');
		}
		else//SHARE
		{
			authType5 = get_words('_wifiser_mode1');
		}
	}
	else if(security5[1] == "psk")//WPA_P
	{
		if(security5[0] == "wpa2auto")//AUTO
			authType5 = get_words('_wifiser_mode5');
		if(security5[0] == "wpa2")//WPA2
			authType5 = get_words('_wifiser_mode4');
		if(security5[0] == "wpa")//WPA
			authType5 = get_words('_wifiser_mode3');
	}
	else if(security5[1] == "eap")//WPA_E
	{
		if(security5[0] == "wpa2auto")//AUTO
			authType5 = get_words('_wifiser_mode7');
		if(security5[0] == "wpa2")//WPA2
			authType5 = get_words('_wifiser_mode6');
		if(security5[0] == "wpa")//WPA
			authType5 = get_words('_WPA');
	}		

	$('#p2_ipaddr').html(p2_ip);
	$('#p2_macaddr').html(p2_mac);
	$('#p2_ssid').html(p2_ssid);
	$('#p2_authtype').html(authType);
	$('#p2_subnet').html(p2_subnetmask);
	$('#p2_gw').html(p2_defgw);
	$('#p2_dns').html( p2_dns2 != "" ? (p2_dns1 + "/" + p2_dns2) : p2_dns1);
	$('#p2_ssid5').html(p2_ssid5);
	$('#p2_authtype5').html(authType5);
}

function wizard_ok()
{
	clear_timing_events();
	show_page_wan_ok();

}
function async_ajax(url, arg, func){
	var time=new Date().getTime();
	var ajax_param = {
		type: 	"POST",
		async:	true,
		url: 	url,
		data: 	arg+"&"+time+"="+time,
		success: function(data) {
			if(func!=undefined)
				func(data);
		}
	};
	try {
			$.ajax(ajax_param);
	} catch (e) {
	}
}

<!-- p3 -->
function show_page_p3(){
	clear_timing_events();
	wan_detect_type = "";
	show_page('p3');
	change_step(2);
}
function sel_page_p3(){
	var p3_val = $('input[name=p3_wan_type]:checked').val();
	switch(p3_val)
	{
	case '0': 
		show_page_p3a(); 
		wan_proto_type = "dhcpc";
		break;
	case '1': 
		show_page_p3b(); 
		wan_proto_type = "static";
		break;
	case '2': 
		show_page_p3c(); 
		wan_proto_type = "pppoe";
		break;
	case '3': 
		show_page_p3d(); 
		wan_proto_type = "pptp";
		break;
	case '4': 
		show_page_p3e(); 
		wan_proto_type = "l2tp";
		break;
	}
}
<!-- p3a -->
var already_clone;
function show_page_p3a(){
	show_page('p3a');
	change_step(2);
	
	var tmp_hostname = "<!--# echo hostname -->";
	var mac = wan_mac.split(':');
	$('#p3a_device_name').val(tmp_hostname);
	$('#p3a_mac1').val(mac[0]);
	$('#p3a_mac2').val(mac[1]);
	$('#p3a_mac3').val(mac[2]);
	$('#p3a_mac4').val(mac[3]);
	$('#p3a_mac5').val(mac[4]);
	$('#p3a_mac6').val(mac[5]);
}
function clone_mac_action(){
  get_by_id("mac_clone_addr").value = get_by_id("mac_clone_addr2").value;
	var mac = get_by_id("mac_clone_addr").value;
	var mac_clone = mac.split(':');
	$('#p3a_mac1').val(mac_clone[0]);
	$('#p3a_mac2').val(mac_clone[1]);
	$('#p3a_mac3').val(mac_clone[2]);
	$('#p3a_mac4').val(mac_clone[3]);
	$('#p3a_mac5').val(mac_clone[4]);
	$('#p3a_mac6').val(mac_clone[5]);
	already_clone = 1;
}


function wz_p3a_save(){
	/* dhcpc
	** check value
	**/
	var input_mac="";
	
	if (direct_dhcp_save == 1){
		var tmp_hostname = "<!--# echo hostname -->";
		var mac = wan_mac.split(':');
		$('#p3a_device_name').val(tmp_hostname);
		$('#p3a_mac1').val(mac[0]);
		$('#p3a_mac2').val(mac[1]);
		$('#p3a_mac3').val(mac[2]);
		$('#p3a_mac4').val(mac[3]);
		$('#p3a_mac5').val(mac[4]);
		$('#p3a_mac6').val(mac[5]);		
		direct_dhcp_save = 0;
	}
	
	input_mac=[$('#p3a_mac1').val(),$('#p3a_mac2').val(),$('#p3a_mac3').val(),$('#p3a_mac4').val(),$('#p3a_mac5').val(),$('#p3a_mac6').val()].join(":");

	if (!check_mac(input_mac)){
		alert (get_words('KR3')+":" + input_mac + ".");
		return;
	} 
	input_mac = trim_string(input_mac);
	if(!is_mac_valid(input_mac, true)) {
		alert(get_words('KR3')+":" + input_mac + ".");
		return;
	}

	//dhcpc
	obj.add_param_arg('wan_mac',input_mac);
	obj.add_param_arg('hostname',$('#p3a_device_name').val());
	obj.add_param_arg('wan_proto', 'dhcpc');
	obj.add_param_arg('wan_specify_dns', 0);
	
	//static
	obj.add_param_arg('wan_static_ipaddr',$('#wan_static_ipaddr').val());
	obj.add_param_arg('wan_static_netmask',$('#wan_static_netmask').val());
	obj.add_param_arg('wan_static_gateway',$('#wan_static_gateway').val());
	obj.add_param_arg('wan_primary_dns',$('#wan_static_gateway').val());
	obj.add_param_arg('wan_secondary_dns',$('#wan_static_gateway').val());
	
	//pppoe
	obj.add_param_arg('wan_pppoe_dynamic_00',$('#wan_pppoe_dynamic_00').val());
	obj.add_param_arg('wan_pppoe_username_00',$('#wan_pppoe_username_00').val());
	obj.add_param_arg('wan_pppoe_password_00',$('#wan_pppoe_password_00').val());		
	obj.add_param_arg('wan_pppoe_max_idle_time',get_by_id("wan_pppoe_max_idle_time").value);
	obj.add_param_arg('wan_pppoe_connect_mode_00',get_by_id("wan_pppoe_connect_mode_00").value);
	obj.add_param_arg('wan_pppoe_mtu',get_by_id("wan_pppoe_mtu").value);
	
	//pptp
	obj.add_param_arg('wan_pptp_ipaddr',$('#wan_pptp_ipaddr').val());
	obj.add_param_arg('wan_pptp_netmask',$('#wan_pptp_netmask').val());
	obj.add_param_arg('wan_pptp_gateway',$('#wan_pptp_gateway').val());
	obj.add_param_arg('wan_pptp_password', $('#wan_pptp_password').val());
	obj.add_param_arg('wan_pptp_server_ip', $('#wan_pptp_server_ip').val());
	obj.add_param_arg('wan_pptp_username', $('#wan_pptp_username').val());
	var pptp_dynamic = "<!--# echo wan_pptp_dynamic -->";
	obj.add_param_arg('wan_pptp_dynamic', pptp_dynamic);
	obj.add_param_arg('wan_pptp_max_idle_time',get_by_id("wan_pptp_max_idle_time").value);	
	obj.add_param_arg('wan_pptp_connect_mode',get_by_id("wan_pptp_connect_mode").value);
	obj.add_param_arg('opendns_enable', get_by_id("opendns_enable").value);
	obj.add_param_arg('hnat_enable', get_by_id("hnat_enable").value);
	obj.add_param_arg('wan_pptp_mtu',get_by_id("wan_pptp_mtu").value);

	//l2tp
	obj.add_param_arg('wan_l2tp_ipaddr',$('#wan_l2tp_ipaddr').val());
	obj.add_param_arg('wan_l2tp_netmask',$('#wan_l2tp_netmask').val());
	obj.add_param_arg('wan_l2tp_gateway',$('#wan_l2tp_gateway').val());
	obj.add_param_arg('wan_l2tp_password', $('#wan_l2tp_password').val());
	obj.add_param_arg('wan_l2tp_server_ip', $('#wan_l2tp_server_ip').val());
	obj.add_param_arg('wan_l2tp_username', $('#wan_l2tp_username').val());
	obj.add_param_arg('wan_l2tp_dynamic', $('#wan_l2tp_dynamic').val());
	obj.add_param_arg('wan_l2tp_max_idle_time',get_by_id("wan_l2tp_max_idle_time").value);	
	obj.add_param_arg('wan_l2tp_connect_mode',get_by_id("wan_l2tp_connect_mode").value);
	obj.add_param_arg('wan_l2tp_mtu',get_by_id("wan_l2tp_mtu").value);

  obj.add_param_arg('wan_pppoe_russia_enable',0);
  obj.add_param_arg('wan_pptp_russia_enable',0);
  obj.add_param_arg('wan_l2tp_russia_enable',0);

	if(alreadyconf=='0')
		next_page='adm_status.asp';
	else
		next_page='login_pic.asp';
		
		obj.add_param_arg('reboot_type', 'wan');
		obj.set_param_url('apply_sec.cgi');
		obj.set_ccp_act('set');
		obj.add_param_event('wizard_wan');
		//obj.set_param_next_page(next_page);
		obj.add_param_arg('setup_wizard_rt','0');
		var paramForm = obj.get_param();
		totalWaitTime = 40; //second
		redirectURL = location.pathname;
		//start_count_down();
		jq_ajax_post(paramForm.url, paramForm.arg);
		
		show_page_wan_detecting();
	
}

<!-- p3b -->
function show_page_p3b(){
	show_page('p3b');
	change_step(2);
}
function wz_p3b_save(){
	/* static ip
	** check value
	**/
	var ip = $('#p3b_wan_ip').val();
	var mask = $('#p3b_wan_mask').val();
	var gateway = $('#p3b_wan_gw').val();
	var dns1 = $('#p3b_wan_dns1').val();
	var dns2 = $('#p3b_wan_dns2').val();
	var ip_addr_msg = replace_msg(all_ip_addr_msg,get_words('_ipaddr'));
	var gateway_msg = replace_msg(all_ip_addr_msg,get_words('wwa_gw'));
	var dns1_addr_msg = replace_msg(all_ip_addr_msg,get_words('wwa_pdns'));
	var dns2_addr_msg = replace_msg(all_ip_addr_msg,get_words('wwa_sdns'));
	var temp_ip_obj = new addr_obj(ip.split("."), ip_addr_msg, false, false);
	var temp_mask_obj = new addr_obj(mask.split("."), subnet_mask_msg, false, false);
	var temp_gateway_obj = new addr_obj(gateway.split("."), gateway_msg, false, false);
	var temp_dns1_obj = new addr_obj(dns1.split("."), dns1_addr_msg, false, false);
	var temp_dns2_obj = new addr_obj(dns2.split("."), dns2_addr_msg, true, false);
	if (!check_lan_setting(temp_ip_obj, temp_mask_obj, temp_gateway_obj)){
		return;
	}
	if (!check_address(temp_dns1_obj)){
		return;
	}
	if (dns2 != "" && dns2 != "0.0.0.0"){
		if (!check_address(temp_dns2_obj)){
			return;
		}
	}
	
	//static
	staticip = $('#p3b_wan_ip').val()==''?'0.0.0.0':$('#p3b_wan_ip').val();
	staticmask = $('#p3b_wan_mask').val()==''?'0.0.0.0':$('#p3b_wan_mask').val();
	staticgw = $('#p3b_wan_gw').val()==''?'0.0.0.0':$('#p3b_wan_gw').val();
	obj.add_param_arg('wan_static_ipaddr',staticip);
	obj.add_param_arg('wan_static_netmask',staticmask);
	obj.add_param_arg('wan_static_gateway',staticgw);
	
	var pridns = $('#p3b_wan_dns1').val()==''?'0.0.0.0':$('#p3b_wan_dns1').val();
	var secdns = $('#p3b_wan_dns2').val()==''?'0.0.0.0':$('#p3b_wan_dns2').val();
	if(pridns=='0.0.0.0' && secdns=='0.0.0.0'){
		obj.add_param_arg('wan_specify_dns', 0);
	}else{
		obj.add_param_arg('wan_specify_dns', 1);
	}
	
	obj.add_param_arg('wan_primary_dns',pridns);
	obj.add_param_arg('wan_secondary_dns',secdns);
	obj.add_param_arg('wan_proto', 'static');
	
	//dhcpc
	obj.add_param_arg('wan_mac',$('#wan_mac').val());
	obj.add_param_arg('hostname',$('#hostname').val());
	
	//pppoe
	obj.add_param_arg('wan_pppoe_dynamic_00',$('#wan_pppoe_dynamic_00').val());
	obj.add_param_arg('wan_pppoe_username_00',$('#wan_pppoe_username_00').val());
	obj.add_param_arg('wan_pppoe_password_00',$('#wan_pppoe_password_00').val());		
	obj.add_param_arg('wan_pppoe_max_idle_time',get_by_id("wan_pppoe_max_idle_time").value);
	obj.add_param_arg('wan_pppoe_connect_mode_00',get_by_id("wan_pppoe_connect_mode_00").value);
	obj.add_param_arg('wan_pppoe_mtu',get_by_id("wan_pppoe_mtu").value);
	
	//pptp
	obj.add_param_arg('wan_pptp_ipaddr',$('#wan_pptp_ipaddr').val());
	obj.add_param_arg('wan_pptp_netmask',$('#wan_pptp_netmask').val());
	obj.add_param_arg('wan_pptp_gateway',$('#wan_pptp_gateway').val());
	obj.add_param_arg('wan_pptp_password', $('#wan_pptp_password').val());
	obj.add_param_arg('wan_pptp_server_ip', $('#wan_pptp_server_ip').val());
	obj.add_param_arg('wan_pptp_username', $('#wan_pptp_username').val());
	var pptp_dynamic = "<!--# echo wan_pptp_dynamic -->";
	obj.add_param_arg('wan_pptp_dynamic', pptp_dynamic);
	obj.add_param_arg('wan_pptp_max_idle_time',get_by_id("wan_pptp_max_idle_time").value);	
	obj.add_param_arg('wan_pptp_connect_mode',get_by_id("wan_pptp_connect_mode").value);
	obj.add_param_arg('opendns_enable', get_by_id("opendns_enable").value);
	obj.add_param_arg('hnat_enable', get_by_id("hnat_enable").value);
	obj.add_param_arg('wan_pptp_mtu',get_by_id("wan_pptp_mtu").value);

	//l2tp
	obj.add_param_arg('wan_l2tp_ipaddr',$('#wan_l2tp_ipaddr').val());
	obj.add_param_arg('wan_l2tp_netmask',$('#wan_l2tp_netmask').val());
	obj.add_param_arg('wan_l2tp_gateway',$('#wan_l2tp_gateway').val());
	obj.add_param_arg('wan_l2tp_password', $('#wan_l2tp_password').val());
	obj.add_param_arg('wan_l2tp_server_ip', $('#wan_l2tp_server_ip').val());
	obj.add_param_arg('wan_l2tp_username', $('#wan_l2tp_username').val());
	obj.add_param_arg('wan_l2tp_dynamic', $('wan_l2tp_dynamic').val());
	obj.add_param_arg('wan_l2tp_max_idle_time',get_by_id("wan_l2tp_max_idle_time").value);	
	obj.add_param_arg('wan_l2tp_connect_mode',get_by_id("wan_l2tp_connect_mode").value);
	obj.add_param_arg('wan_l2tp_mtu',get_by_id("wan_l2tp_mtu").value);

  obj.add_param_arg('wan_pppoe_russia_enable',0);
  obj.add_param_arg('wan_pptp_russia_enable',0);
  obj.add_param_arg('wan_l2tp_russia_enable',0);

		if(alreadyconf=='0')
			next_page='adm_status.asp';
		else
			next_page='login_pic.asp';
	
	obj.add_param_arg('reboot_type', 'wan');
	obj.set_param_url('apply_sec.cgi');
	obj.set_ccp_act('set');
	obj.add_param_event('wizard_wan');
	//obj.set_param_next_page(next_page);
	obj.add_param_arg('setup_wizard_rt','0');
	var paramForm = obj.get_param();
	totalWaitTime = 30; //second
	redirectURL = location.pathname;
	//start_count_down();
	jq_ajax_post(paramForm.url, paramForm.arg);

	show_page_wan_detecting();
}

<!-- p3c -->
function show_page_p3c(){
	show_page('p3c');
	change_step(2);
}
function wz_p3c_save(){
	//pppoe save

	if($('#pppoe_user_name').val() == ""){
		alert(get_words('PPP_USERNAME_EMPTY', LangMap.msg));
		return;
	}
	if($('#pppoe_user_pwd').val() == "" || $('#pppoe_verify_pwd').val() == ""){
		alert(get_words('GW_WAN_PPPOE_PASSWORD_INVALID'));
		return;
	}
	if (!check_pwd("pppoe_user_pwd", "pppoe_verify_pwd")){
		return;
	}
	
	get_by_id("wan_pppoe_dynamic_00").value = "1";
	get_by_id("wan_pppoe_username_00").value = trim_string($('#pppoe_user_name').val());
	get_by_id("wan_pppoe_password_00").value = $('#pppoe_user_pwd').val();
	
	//pppoe
	//obj.add_param_arg('wan_pppoe_dynamic_00',$('#wan_pppoe_dynamic_00').val());
	obj.add_param_arg('wan_pppoe_username_00',$('#wan_pppoe_username_00').val());
	obj.add_param_arg('wan_pppoe_password_00',$('#wan_pppoe_password_00').val());			
	obj.add_param_arg('wan_proto', 'pppoe');
	obj.add_param_arg('wan_specify_dns', 0);
	obj.add_param_arg('wan_pppoe_max_idle_time',get_by_id("wan_pppoe_max_idle_time").value);
	obj.add_param_arg('wan_pppoe_connect_mode_00','always_on');
	obj.add_param_arg('wan_pppoe_mtu',get_by_id("wan_pppoe_mtu").value);

	//dhcpc
	obj.add_param_arg('wan_mac',$('#wan_mac').val());
	obj.add_param_arg('hostname',$('#hostname').val());
	
	//static
	obj.add_param_arg('wan_static_ipaddr',$('#wan_static_ipaddr').val());
	obj.add_param_arg('wan_static_netmask',$('#wan_static_netmask').val());
	obj.add_param_arg('wan_static_gateway',$('#wan_static_gateway').val());
	obj.add_param_arg('wan_primary_dns',$('#wan_static_gateway').val());
	obj.add_param_arg('wan_secondary_dns',$('#wan_static_gateway').val());
	
	//pptp
	obj.add_param_arg('wan_pptp_ipaddr',$('#wan_pptp_ipaddr').val());
	obj.add_param_arg('wan_pptp_netmask',$('#wan_pptp_netmask').val());
	obj.add_param_arg('wan_pptp_gateway',$('#wan_pptp_gateway').val());
	obj.add_param_arg('wan_pptp_password', $('#wan_pptp_password').val());
	obj.add_param_arg('wan_pptp_server_ip', $('#wan_pptp_server_ip').val());
	obj.add_param_arg('wan_pptp_username', $('#wan_pptp_username').val());
	var pptp_dynamic = "<!--# echo wan_pptp_dynamic -->";
	obj.add_param_arg('wan_pptp_dynamic', pptp_dynamic);
	obj.add_param_arg('wan_pptp_max_idle_time',get_by_id("wan_pptp_max_idle_time").value);	
	obj.add_param_arg('wan_pptp_connect_mode',get_by_id("wan_pptp_connect_mode").value);
	obj.add_param_arg('opendns_enable',get_by_id("opendns_enable").value);
	obj.add_param_arg('hnat_enable',get_by_id("hnat_enable").value);
	obj.add_param_arg('wan_pptp_mtu',get_by_id("wan_pptp_mtu").value);

	//l2tp
	obj.add_param_arg('wan_l2tp_ipaddr',$('#wan_l2tp_ipaddr').val());
	obj.add_param_arg('wan_l2tp_netmask',$('#wan_l2tp_netmask').val());
	obj.add_param_arg('wan_l2tp_gateway',$('#wan_l2tp_gateway').val());
	obj.add_param_arg('wan_l2tp_password', $('#wan_l2tp_password').val());
	obj.add_param_arg('wan_l2tp_server_ip', $('#wan_l2tp_server_ip').val());
	obj.add_param_arg('wan_l2tp_username', $('#wan_l2tp_username').val());
	obj.add_param_arg('wan_l2tp_dynamic', $('#wan_l2tp_dynamic').val());
	obj.add_param_arg('wan_l2tp_max_idle_time',get_by_id("wan_l2tp_max_idle_time").value);	
	obj.add_param_arg('wan_l2tp_connect_mode',get_by_id("wan_l2tp_connect_mode").value);
	obj.add_param_arg('wan_l2tp_mtu',get_by_id("wan_l2tp_mtu").value);

  obj.add_param_arg('wan_pppoe_russia_enable',0);
  obj.add_param_arg('wan_pptp_russia_enable',0);
  obj.add_param_arg('wan_l2tp_russia_enable',0);
	
		if(alreadyconf=='0')
			next_page='adm_status.asp';
		else
			next_page='login_pic.asp';
	
	obj.add_param_arg('reboot_type', 'wan');
	obj.set_param_url('apply_sec.cgi');
	obj.set_ccp_act('set');
	obj.add_param_event('wizard_wan');
	//obj.set_param_next_page(next_page);
	obj.add_param_arg('setup_wizard_rt','0');
	var paramForm = obj.get_param();
	totalWaitTime = 30; //second
	redirectURL = location.pathname;
	//start_count_down();
	jq_ajax_post(paramForm.url, paramForm.arg);

	show_page_wan_detecting();
}
<!-- p3d -->
function show_page_p3d(){
	show_page('p3d');
	change_step(2);
}
function wz_p3d_save(){
	/* pptp
	** check value
	**/
	var pptp_type  = $('#pptp_conn_type:checked').val();
	var ip = $('#pptp_ip_addr').val();
	var mask = $('#pptp_subnet_mask').val();  
	var gateway = $('#pptp_gateway').val();
	var server_ip = $('#pptp_server_ip').val();
	var ip_addr_msg = replace_msg(all_ip_addr_msg,get_words('_ipaddr'));
	var gateway_msg = replace_msg(all_ip_addr_msg,get_words('wwa_gw'));
	var dns1_addr_msg = replace_msg(all_ip_addr_msg,get_words('wwa_pdns'));
	var dns2_addr_msg = replace_msg(all_ip_addr_msg,get_words('wwa_sdns'));
	var server_ip_addr_msg = replace_msg(all_ip_addr_msg,get_words('_server_ip'));
	var temp_ip_obj = new addr_obj(ip.split("."), ip_addr_msg, false, false);
	var temp_mask_obj = new addr_obj(mask.split("."), subnet_mask_msg, false, false);
	var temp_gateway_obj = new addr_obj(gateway.split("."), gateway_msg, false, false);
	var temp_server_ip_obj = new addr_obj(server_ip.split("."), server_ip_addr_msg, false, false);
	if (pptp_type=='1'){
		if (!check_lan_setting(temp_ip_obj, temp_mask_obj, temp_gateway_obj)){
			return;
		}
	}
	/*
	** Date:	2013-04-23
	** Author:	Moa Chung
	** Reason:	allow pptp server ip enter domain name and ip
	**/
	if(ip_pattern(server_ip))// ip format
	{
		if (!check_address(temp_server_ip_obj)){
			return false;
		}
	}
	else//domain format
	{
		if(server_ip == ""){
			alert(get_words('YM108'));
			return false;
		}
	}
	
	if($('#pptp_user_name').val() == ""){
		alert(get_words('PPP_USERNAME_EMPTY', LangMap.msg));
		return;
	 }
	if ($('#pptp_user_pwd').val() == "" || $('#pptp_verify_pwd').val() == ""){
		alert(get_words('GW_WAN_PPTP_PASSWORD_INVALID'));
		return;
	}
	if (!check_pwd("pptp_user_pwd", "pptp_verify_pwd")){
		return;
	}
	
	var type = $('#pptp_conn_type:checked').val();
	var wan_pptp_dynamic_tmp = "";
	if(type=='1'){
		obj.add_param_arg('wan_pptp_ipaddr',$('#pptp_ip_addr').val());
		obj.add_param_arg('wan_pptp_netmask',$('#pptp_subnet_mask').val());
		obj.add_param_arg('wan_pptp_gateway',$('#pptp_gateway').val());
		wan_pptp_dynamic_tmp = "0";
	}else{
		wan_pptp_dynamic_tmp = "1";
	}
	
	
	//pptp
	obj.add_param_arg('wan_pptp_password', $('#pptp_user_pwd').val());
	obj.add_param_arg('wan_pptp_server_ip', $('#pptp_server_ip').val());
	obj.add_param_arg('wan_pptp_username', $('#pptp_user_name').val());
	obj.add_param_arg('wan_pptp_dynamic', wan_pptp_dynamic_tmp);
	obj.add_param_arg('wan_proto', 'pptp');
	obj.add_param_arg('wan_specify_dns', 0);
	
	obj.add_param_arg('wan_pptp_max_idle_time',get_by_id("wan_pptp_max_idle_time").value);	
	obj.add_param_arg('wan_pptp_connect_mode','always_on');
	obj.add_param_arg('opendns_enable', 0);
	obj.add_param_arg('hnat_enable', 0);
	obj.add_param_arg('wan_pptp_mtu',get_by_id("wan_pptp_mtu").value);
	obj.add_param_arg('wan_proto', 'pptp');
	
	//dhcpc
	obj.add_param_arg('wan_mac',$('#wan_mac').val());
	obj.add_param_arg('hostname',$('#hostname').val());
	
	//static
	obj.add_param_arg('wan_static_ipaddr',$('#wan_static_ipaddr').val());
	obj.add_param_arg('wan_static_netmask',$('#wan_static_netmask').val());
	obj.add_param_arg('wan_static_gateway',$('#wan_static_gateway').val());
	obj.add_param_arg('wan_primary_dns',$('#wan_static_gateway').val());
	obj.add_param_arg('wan_secondary_dns',$('#wan_static_gateway').val());
	
	//pppoe
	obj.add_param_arg('wan_pppoe_dynamic_00',$('#wan_pppoe_dynamic_00').val());
	obj.add_param_arg('wan_pppoe_username_00',$('#wan_pppoe_username_00').val());
	obj.add_param_arg('wan_pppoe_password_00',$('#wan_pppoe_password_00').val());	
	obj.add_param_arg('wan_pppoe_max_idle_time',get_by_id("wan_pppoe_max_idle_time").value);
	obj.add_param_arg('wan_pppoe_connect_mode_00',get_by_id("wan_pppoe_connect_mode_00").value);
	obj.add_param_arg('wan_pppoe_mtu',get_by_id("wan_pppoe_mtu").value);

	//l2tp
	obj.add_param_arg('wan_l2tp_ipaddr',$('#wan_l2tp_ipaddr').val());
	obj.add_param_arg('wan_l2tp_netmask',$('#wan_l2tp_netmask').val());
	obj.add_param_arg('wan_l2tp_gateway',$('#wan_l2tp_gateway').val());
	obj.add_param_arg('wan_l2tp_password', $('#wan_l2tp_password').val());
	obj.add_param_arg('wan_l2tp_server_ip', $('#wan_l2tp_server_ip').val());
	obj.add_param_arg('wan_l2tp_username', $('#wan_l2tp_username').val());
	obj.add_param_arg('wan_l2tp_dynamic', $('#wan_l2tp_dynamic').val());
	obj.add_param_arg('wan_l2tp_max_idle_time',get_by_id("wan_l2tp_max_idle_time").value);	
	obj.add_param_arg('wan_l2tp_connect_mode',get_by_id("wan_l2tp_connect_mode").value);
	obj.add_param_arg('wan_l2tp_mtu',get_by_id("wan_l2tp_mtu").value);
	
  obj.add_param_arg('wan_pppoe_russia_enable',0);
  obj.add_param_arg('wan_pptp_russia_enable',0);
  obj.add_param_arg('wan_l2tp_russia_enable',0);

	if(alreadyconf=='0')
		next_page='adm_status.asp';
	else
		next_page='login_pic.asp';
	
	obj.add_param_arg('reboot_type', 'wan');
	obj.set_param_url('apply_sec.cgi');
	obj.set_ccp_act('set');
	obj.add_param_event('wizard_wan');
	//obj.set_param_next_page(next_page);
	obj.add_param_arg('setup_wizard_rt','0');
	var paramForm = obj.get_param();
	totalWaitTime = 30; //second
	redirectURL = location.pathname;
	//start_count_down();
	jq_ajax_post(paramForm.url, paramForm.arg);

	show_page_wan_detecting();
}
<!-- p3e -->
function show_page_p3e(){
	show_page('p3e');
	change_step(2);
}
function wz_p3e_save(){
	/* l2tp
	** check value
	**/
	var l2tp_type = $('#l2tp_conn_type:checked').val();
	var ip = $('#l2tp_ip_addr').val();
	var mask = $('#l2tp_subnet_mask').val();
	var gateway = $('#l2tp_gateway').val();
	var server_ip = $('#l2tp_server_ip').val();
	var ip_addr_msg = replace_msg(all_ip_addr_msg,get_words('_ipaddr'));
	var gateway_msg = replace_msg(all_ip_addr_msg,get_words('wwa_gw'));
	var server_ip_addr_msg = replace_msg(all_ip_addr_msg,get_words('_server_ip'));
	var temp_ip_obj = new addr_obj(ip.split("."), ip_addr_msg, false, false);
	var temp_mask_obj = new addr_obj(mask.split("."), subnet_mask_msg, false, false);
	var temp_gateway_obj = new addr_obj(gateway.split("."), gateway_msg, false, false);
	var temp_server_ip_obj = new addr_obj(server_ip.split("."), server_ip_addr_msg, false, false);
	if (l2tp_type=='1'){
		if (!check_lan_setting(temp_ip_obj, temp_mask_obj, temp_gateway_obj)){
			return;
		}
	}
	/*
	** Date:	2013-04-23
	** Author:	Moa Chung
	** Reason:	allow l2tp server ip enter domain name and ip
	**/
	if(ip_pattern(server_ip))// ip format
	{
		if (!check_address(temp_server_ip_obj)){
			return false;
		}
	}
	else//domain format
	{
		if(server_ip == ""){
			alert(get_words('YM112'));
			return false;
		}
	}
	
	if($('#l2tp_user_name').val() == ""){
		alert(get_words('GW_WAN_L2TP_USERNAME_INVALID'));
		return;
	}

	if ($('#l2tp_user_pwd').val() == "" || $('#l2tp_verify_pwd').val() == ""){
		alert(get_words('GW_WAN_L2TP_PASSWORD_INVALID'));
		return;
	}

	if (!check_pwd("l2tp_user_pwd", "l2tp_verify_pwd")){
		return;
	}
	
	
	var type = $('#l2tp_conn_type:checked').val();
	var wan_l2tp_dynamic_tmp = "";
	if(type=='1'){
		obj.add_param_arg('wan_l2tp_ipaddr',$('#l2tp_ip_addr').val());
		obj.add_param_arg('wan_l2tp_netmask',$('#l2tp_subnet_mask').val());
		obj.add_param_arg('wan_l2tp_gateway',$('#l2tp_gateway').val());
		wan_l2tp_dynamic_tmp = "0";
	}else{
		wan_l2tp_dynamic_tmp = "1";
	}

	//l2tp
	obj.add_param_arg('wan_l2tp_password', $('#l2tp_user_pwd').val());
	obj.add_param_arg('wan_l2tp_server_ip', $('#l2tp_server_ip').val());
	obj.add_param_arg('wan_l2tp_username', $('#l2tp_user_name').val());
	obj.add_param_arg('wan_l2tp_dynamic', wan_l2tp_dynamic_tmp);
	obj.add_param_arg('wan_proto', 'l2tp');
	obj.add_param_arg('wan_specify_dns', 0);
	obj.add_param_arg('wan_l2tp_max_idle_time',get_by_id("wan_l2tp_max_idle_time").value);	
	obj.add_param_arg('wan_l2tp_connect_mode','always_on');
	obj.add_param_arg('opendns_enable',0);
	obj.add_param_arg('hnat_enable',0);
	obj.add_param_arg('wan_l2tp_mtu',get_by_id("wan_l2tp_mtu").value);
	
	//dhcpc
	obj.add_param_arg('wan_mac',$('#wan_mac').val());
	obj.add_param_arg('hostname',$('#hostname').val());
	
	//static
	obj.add_param_arg('wan_static_ipaddr',$('#wan_static_ipaddr').val());
	obj.add_param_arg('wan_static_netmask',$('#wan_static_netmask').val());
	obj.add_param_arg('wan_static_gateway',$('#wan_static_gateway').val());
	obj.add_param_arg('wan_primary_dns',$('#wan_static_gateway').val());
	obj.add_param_arg('wan_secondary_dns',$('#wan_static_gateway').val());
	
	//pppoe
	obj.add_param_arg('wan_pppoe_dynamic_00',$('#wan_pppoe_dynamic_00').val());
	obj.add_param_arg('wan_pppoe_username_00',$('#wan_pppoe_username_00').val());
	obj.add_param_arg('wan_pppoe_password_00',$('#wan_pppoe_password_00').val());		
	obj.add_param_arg('wan_pppoe_max_idle_time',get_by_id("wan_pppoe_max_idle_time").value);
	obj.add_param_arg('wan_pppoe_connect_mode_00',get_by_id("wan_pppoe_connect_mode_00").value);
	obj.add_param_arg('wan_pppoe_mtu',get_by_id("wan_pppoe_mtu").value);
	
	//pptp
	obj.add_param_arg('wan_pptp_ipaddr',$('#wan_pptp_ipaddr').val());
	obj.add_param_arg('wan_pptp_netmask',$('#wan_pptp_netmask').val());
	obj.add_param_arg('wan_pptp_gateway',$('#wan_pptp_gateway').val());
	obj.add_param_arg('wan_pptp_password', $('#wan_pptp_password').val());
	obj.add_param_arg('wan_pptp_server_ip', $('#wan_pptp_server_ip').val());
	obj.add_param_arg('wan_pptp_username', $('#wan_pptp_username').val());
	var pptp_dynamic = "<!--# echo wan_pptp_dynamic -->";
	obj.add_param_arg('wan_pptp_dynamic', pptp_dynamic);
	obj.add_param_arg('wan_pptp_max_idle_time',get_by_id("wan_pptp_max_idle_time").value);	
	obj.add_param_arg('wan_pptp_connect_mode',get_by_id("wan_pptp_connect_mode").value);
	obj.add_param_arg('wan_pptp_mtu',get_by_id("wan_pptp_mtu").value);

  obj.add_param_arg('wan_pppoe_russia_enable',0);
  obj.add_param_arg('wan_pptp_russia_enable',0);
  obj.add_param_arg('wan_l2tp_russia_enable',0);

	if(alreadyconf=='0')
		next_page='adm_status.asp';
	else
		next_page='login_pic.asp';
	
	obj.add_param_arg('reboot_type', 'wan');
	obj.set_param_url('apply_sec.cgi');
	obj.set_ccp_act('set');
	obj.add_param_event('wizard_wan');
	//obj.set_param_next_page(next_page);
	obj.add_param_arg('setup_wizard_rt','0');
	var paramForm = obj.get_param();
	totalWaitTime = 30; //second
	redirectURL = location.pathname;
	//start_count_down();
	jq_ajax_post(paramForm.url, paramForm.arg);

	show_page_wan_detecting();
}
function show_page_wan_ok(){
	clear_timing_events();
	show_page('wan_ok');
	change_step(3);

	start_count_down();
}
function start_count_down(){
	var sec = parseInt($('#show_second').html());
	if(sec>0){
		$('#show_second').html(--sec);
		setTimeout("start_count_down()", 1000);
	} else{
		$('input[name=back_btn]').removeAttr('disabled');
		if(alreadyconf=='0')
			next_page='adm_status.asp';
		else
			next_page='login_pic.asp';
	
		//window.location.href=next_page;
	}
}
function show_page_wan_detecting()
{
	show_page('wan_detecting');
	change_step(2);
	$('#detect_msg_str').html(get_words('mydlink_tx05')+mul0('.', 4-query_wan_times%3));
	setTimeout("get_wan_info()", 20000);
	check_wan_id = setTimeout("check_wan()", 25000);

}


<!-- check internet exist? -->
var query_wan_times = 30;
var query_wan = 0;
function mul0(str, num)
{
	if (!num) return "";
	var newStr = str;
	while (--num) newStr += str;
	return newStr;
}


function check_wan(){
	//$('#detect_msg_str').html(get_words('mydlink_tx05')+mul0('.', 4-query_wan_times%3));
	//var st = query_wan_connection();
	
	if (p2_subnetmask !="" && wan_connection_status == "Connected"){
		show_page_p2();//setp 3
		clearTimeout(check_wan_id);
	}else{
		if (query_wan < 20){
			query_wan++;
			clearTimeout(wan_detect_id);
			get_wan_info();
			check_wan_id = setTimeout("check_wan()", 3000);
		}else{
			query_wan_times = 30;
			clearTimeout(check_wan_id);
			query_wan = 0;
			show_page('wan_failed');
		}														
	}
}


function query_wan_connection()
{
	var obj1 = new ccpObject();
	obj1.set_param_url('ping.ccp');
	obj1.set_ccp_act('queryWanConnect');
	obj1.get_config_obj();
	var ret = obj1.config_val("WANisReady");
	return ret;
}
function do_fakeping()
{
	var obj = new ccpObject();
	obj.set_param_url('ping.ccp');
	obj.set_ccp_act('fakeping');
	obj.set_param_option('fakeping',1);
	var paramPing = obj.get_param();
	ping_wan(paramPing);
}
function ping_wan(p)
{
	var time=new Date().getTime();
	var ajax_param = {
		type: 	"POST",
		async:	true,
		url: 	p.url,
		data: 	p.arg+"&"+time+"="+time
	};

	$.ajax(ajax_param);
}

function change_step(step)
{
	switch(step){
	case 1:
		$('#btn_step2,#btn_step3').removeClass('openheader').addClass('closeheader');
		$('#btn_step1').addClass('openheader').removeClass('closeheader');
		$('#btn_step1').find('img').attr('src', $('#btn_step1').find('img').attr('src').replace('_0.','_1.'));
		$('#btn_step2').find('img').attr('src', $('#btn_step2').find('img').attr('src').replace('_1.','_0.'));
		$('#btn_step3').find('img').attr('src', $('#btn_step3').find('img').attr('src').replace('_1.','_0.'));
		$('#manStatusTitle').html(get_words('_check_connection'));
		break;
	case 2:
		$('#btn_step1,#btn_step3').removeClass('openheader').addClass('closeheader');
		$('#btn_step2').addClass('openheader').removeClass('closeheader');
		$('#btn_step1').find('img').attr('src', $('#btn_step1').find('img').attr('src').replace('_1.','_0.'));
		$('#btn_step2').find('img').attr('src', $('#btn_step2').find('img').attr('src').replace('_0.','_1.'));
		$('#btn_step3').find('img').attr('src', $('#btn_step3').find('img').attr('src').replace('_1.','_0.'));
		$('#manStatusTitle').html(get_words('_confirm_settings'));
		break;
	case 3:
		$('#btn_step1,#btn_step2').removeClass('openheader').addClass('closeheader');
		$('#btn_step3').addClass('openheader').removeClass('closeheader');
		$('#btn_step1').find('img').attr('src', $('#btn_step1').find('img').attr('src').replace('_1.','_0.'));
		$('#btn_step2').find('img').attr('src', $('#btn_step2').find('img').attr('src').replace('_1.','_0.'));
		$('#btn_step3').find('img').attr('src', $('#btn_step3').find('img').attr('src').replace('_0.','_1.'));
		$('#manStatusTitle').html(get_words('_finish'));
		break;
	}
}

/*	function change_lang() {
		var Nlang = $('#lang_select').val();
		if (Nlang != br_lang) {
			lang_submit(Nlang);
			return;
		}
	}
*/
	function change_lang() {
		   		get_by_id("language").value = get_by_id("lang_select").value;
				var Nlang = get_by_id("language").value;
					send_submit('lang_form');
			}

	function get_lang(){
		 set_selectIndex(get_by_id("language").value, get_by_id("lang_select"));
	}
	function lang_submit(Nlang) {
		var time = new Date().getTime();
		var temp_cURL = document.URL.split('#');
		var ajax_param = {
			type : "POST",
			async : false,
			url : 'curr_lang.ccp',
			data : 'ccp_act=set&ccpSubEvent=CCP_SUB_WEBPAGE_APPLY&curr_language=' + Nlang + '&igd_CurrentLanguage_1.0.0.0=' + Nlang + "&" + time + "=" + time,
			success : function(data) {
				window.location.href = temp_cURL[0] + '#' + Nlang;
				/*				var isSafari = navigator.userAgent.search("Safari") > -1;
				 if (isSafari)
				 location.replace('/wizard_router.asp');
				 else
				 window.location.reload(true);
				 */
				window.location.reload(true);
			}
		};
		$.ajax(ajax_param);
	}
	
	
$(function(){
	//chk_browser_lang();
	window.location.replace('#' + br_lang);
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
			<td style="background-image:url('/image/bg_l.gif');background-repeat:repeat-y;vertical-align:top;width:270px;" width="270">
				<div style="padding-left:6px;">
					<div class="arrowlistmenu">
						<div class="homenav" style="margin-bottom:20px;">
						<span style="font:bold 20px verdana,arial,sans-serif;background-repeat:no-repeat;text-align:center;padding-top:15px;display:inline-block;width:252px;height:72px;background-image:url('/image/but_setup_wizard.gif');"><script>get_words('_wizard');</script>SETUP WIZARD</span>
						</div>
						<div class="borderbottom"> </div>
						<div><div id="btn_step1" onclick="show_page_p0();" class="menuheader expandable openheader"><img src="/image/but_wizard1_1.png" class="CatImage" /><span class="CatTitle"><script>show_words('_check_connection')</script></span></div></div>
						<div><div id="btn_step2" class="menuheader expandable closeheader"><img src="/image/but_wizard2_0.png" class="CatImage" /><span class="CatTitle"><script>show_words('_confirm_settings')</script></span></div></div>
						<div><div id="btn_step3" class="menuheader expandable closeheader"><img src="/image/but_wizard3_0.png" class="CatImage" /><span class="CatTitle"><script>show_words('_finish')</script></span></div></div>
					</div>
					<p>&nbsp;</p>
				</div>
				<img src="/image/bg_l.gif" width="270" height="5" />
			</td>
			<!-- End of left menu -->
								<!-- dhcp -->
								<input type="hidden" id="wan_mac" name="wan_mac" value="<!--# echo wan_mac -->">
								<input type="hidden" id="old_wan_mac" name="old_wan_mac" value="<!--# echo wan_mac -->">
								<input type="hidden" id="hostname" name="hostname" value="<!--# echo hostname -->">
								<input type="hidden" id="mac_clone_addr" name="mac_clone_addr" value="<!--# echo mac_clone_addr -->">			
								<input type="hidden" id="mac_clone_addr2" name="mac_clone_addr2" value="<!--# exec cgi /bin/clone mac_clone_addr -->">

								<!-- pppoe -->
								<input type="hidden" name="wan_pppoe_dynamic_00" id="wan_pppoe_dynamic_00" value="<!--# echo wan_pppoe_dynamic_00 -->">
								<input type="hidden" name="wan_pppoe_ipaddr_00" id="wan_pppoe_ipaddr_00" value="<!--# echo wan_pppoe_ipaddr_00 -->">
								<input type="hidden" id="wan_pppoe_username_00" name="wan_pppoe_username_00" value="<!--# echo wan_pppoe_username_00 -->">
								<input type="hidden" id="wan_pppoe_password_00" name="wan_pppoe_password_00" value="<!--# echo wan_pppoe_password_00 -->">
								<input type="hidden" id="pppoe_pwd2" name="pppoe_pwd2" value="<!--# echo wan_pppoe_password_00 -->">
								<input type="hidden" id="wan_pppoe_service_00" name="wan_pppoe_service_00" value="<!--# echo wan_pppoe_service_00 -->">
								<input type="hidden" id="wan_pppoe_max_idle_time" name="wan_pppoe_max_idle_time" value="<!--# echo wan_pppoe_max_idle_time -->">
								<input type="hidden" id="wan_pppoe_mtu" name="wan_pppoe_mtu" value="<!--# echo wan_pppoe_mtu -->">
								<input type="hidden" id="wan_pppoe_connect_mode_00" name="wan_pppoe_connect_mode_00" value="<!--# echo wan_pppoe_connect_mode_00 -->">
								<input type="hidden" id="wan_pppoe_russia_enable" name="wan_pppoe_russia_enable" value="<!--# echo wan_pppoe_russia_enable -->">
								
								<!-- pptp -->
								<input type="hidden" id="wan_pptp_dynamic" name="wan_pptp_dynamic" value="<!--# echo wan_pptp_dynamic -->">
								<input type="hidden" id="wan_pptp_ipaddr" name="wan_pptp_ipaddr" value="<!--# echo wan_pptp_ipaddr -->">
								<input type="hidden" id="wan_pptp_netmask" name="wan_pptp_netmask" value="<!--# echo wan_pptp_netmask -->">
								<input type="hidden" id="wan_pptp_gateway" name="wan_pptp_gateway" value="<!--# echo wan_pptp_gateway -->">
								<input type="hidden" id="wan_pptp_server_ip" name="wan_pptp_server_ip" value="<!--# echo wan_pptp_server_ip -->">
								<input type="hidden" id="wan_pptp_username" name="wan_pptp_username" value="<!--# echo wan_pptp_username -->">
								<input type="hidden" id="wan_pptp_password" name="wan_pptp_password" value="<!--# echo wan_pptp_password -->">
								<input type="hidden" id="pptp_password2" name="pptp_password2" value="<!--# echo wan_pptp_password -->">
								<input type="hidden" id="wan_pptp_max_idle_time" name="wan_pptp_max_idle_time" value="<!--# echo wan_pptp_max_idle_time -->">
								<input type="hidden" id="wan_pptp_mtu" name="wan_pptp_mtu" value="<!--# echo wan_pptp_mtu -->">
								<input type="hidden" id="wan_pptp_connect_mode" name="wan_pptp_connect_mode" value="<!--# echo wan_pptp_connect_mode -->">
								<input type="hidden" id="wan_pptp_russia_enable" name="wan_pptp_russia_enable" value="<!--# echo wan_pptp_russia_enable -->">
								
								<!-- l2tp -->
								<input type="hidden" id="wan_l2tp_dynamic" name="wan_l2tp_dynamic" value="<!--# echo wan_l2tp_dynamic -->">
								<input type="hidden" id="wan_l2tp_ipaddr" name="wan_l2tp_ipaddr" value="<!--# echo wan_l2tp_ipaddr -->">
								<input type="hidden" id="wan_l2tp_netmask" name="wan_l2tp_netmask" value="<!--# echo wan_l2tp_netmask -->">
								<input type="hidden" id="wan_l2tp_gateway" name="wan_l2tp_gateway" value="<!--# echo wan_l2tp_gateway -->">
								<input type="hidden" id="wan_l2tp_server_ip" name="wan_l2tp_server_ip" value="<!--# echo wan_l2tp_server_ip -->">
								<input type="hidden" id="wan_l2tp_username" name="wan_l2tp_username" value="<!--# echo wan_l2tp_username -->">
								<input type="hidden" id="wan_l2tp_password" name="wan_l2tp_password" value="<!--# echo wan_l2tp_password -->">
								<input type="hidden" id="l2tp_password2" name="l2tp_password2" value="<!--# echo wan_l2tp_password -->">
								<input type="hidden" id="wan_l2tp_max_idle_time" name="wan_l2tp_max_idle_time" value="<!--# echo wan_l2tp_max_idle_time -->">
								<input type="hidden" id="wan_l2tp_mtu" name="wan_l2tp_mtu" value="<!--# echo wan_l2tp_mtu -->">
								<input type="hidden" id="wan_l2tp_connect_mode" name="wan_l2tp_connect_mode" value="<!--# echo wan_l2tp_connect_mode -->">
								<input type="hidden" id="wan_l2tp_russia_enable" name="wan_l2tp_russia_enable" value="<!--# echo wan_l2tp_russia_enable -->">
								
								<!-- static -->
								<input type="hidden" id="wan_static_ipaddr" name="wan_static_ipaddr" value="<!--# echo wan_static_ipaddr -->">
								<input type="hidden" id="wan_static_netmask" name="wan_static_netmask" value="<!--# echo wan_static_netmask -->">
								<input type="hidden" id="wan_static_gateway" name="wan_static_gateway" value="<!--# echo wan_static_gateway -->">
								<!-- dns -->
								<input type="hidden" id="opendns_enable" name="opendns_enable" value="<!--# echo opendns_enable -->">
								<input type="hidden" id="opendns_mode" name="opendns_mode">
								<input type="hidden" id="wan_primary_dns" name="wan_primary_dns" value="<!--# echo wan_primary_dns -->">
								<input type="hidden" id="wan_secondary_dns" name="wan_secondary_dns" value="<!--# echo wan_secondary_dns -->">
								<input type="hidden" id="dns_relay" name="dns_relay" value="<!--# echo dns_relay -->">
								<input type="hidden" id="hnat_enable" name="hnat_enable" value="<!--# echo hnat_enable -->">
								<!-- for check cable -->
								<input type="hidden" id="wan_cable_status" name="wan_cable_status" value="<!--# echo wan_cable_status -->">
								<input type="hidden" id="net_status" name="net_status" value="<!--# echo net_status -->">
								<!-- for dhcp info -->
								<input type="hidden" id="wan_ip_value" name="wan_ip_value" value="<!--# echo wan_ip_value -->">
								<input type="hidden" id="wan_netmask_value" name="wan_netmask_value" value="<!--# echo wan_netmask_value -->">
								<input type="hidden" id="wan_gateway_value" name="wan_gateway_value" value="<!--# echo wan_gateway_value -->">
								<input type="hidden" id="wan_dns1_value" name="wan_dns1_value" value="<!--# echo wan_dns1_value -->">
								<input type="hidden" id="wan_dns2_value" name="wan_dns2_value" value="<!--# echo wan_dns2_value -->">
								<input type="hidden" id="wan_proto" name="wan_proto" value="<!--# echo wan_proto -->">
								<input type="hidden" id="wan_specify_dns" name="wan_specify_dns" value="<!--# echo wan_specify_dns -->">
								<!-- for wlan -->
								<!-- 2.4G -->
								<input type="hidden" id="wlan0_ssid" name="wlan0_ssid" size="40" maxlength="32" value="<!--# echot wlan0_ssid -->">
								<input type="hidden" id="wlan0_psk_pass_phrase" name="wlan0_psk_pass_phrase" value="<!--# echot wlan0_psk_pass_phrase-->">
								<input type="hidden" id="wlan0_security" name="wlan0_security" value="wpa2auto_psk">
								<input type="hidden" id="wlan0_psk_cipher_type" name="wlan0_psk_cipher_type" value="both">
								<!-- 2.4G End -->
								<!-- 5G -->
								<input type="hidden" id="wlan1_ssid" name="wlan1_ssid" size="40" maxlength="32" value="<!--# echot wlan1_ssid -->">
								<input type="hidden" id="wlan1_psk_pass_phrase" name="wlan1_psk_pass_phrase" value="<!--# echot wlan1_psk_pass_phrase-->">
								<input type="hidden" id="wlan1_security" name="wlan1_security" value="wpa2auto_psk">
								<input type="hidden" id="wlan1_psk_cipher_type" name="wlan1_psk_cipher_type" value="both">
								<!-- 5G End -->
								<input type="hidden" id="wps_configured_mode" name="wps_configured_mode" value="5">
								<input type="hidden" id="disable_wps_pin" name="disable_wps_pin" value="1">
								<input type="hidden" id="wps_enable" name="wps_enable" value="1">													

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
								<script>show_words('_check_connection')</script>
								</div>
								<div class="hr"></div>
								<div class="section_content_border">
									<div class="header_desc" id="basicIntroduction">
										<p></p>
									</div>
<div id="p0" name="page" class="box_tn">
<table width="100%" border="0" cellpadding="0" cellspacing="0" class="tabBigTitle">
	<tr>
		<td class="CT">	
			<font><script>document.write(addstr(get_words('_tnw_01'), model));</script></font>
		</td>
	</tr>
	<tr>
		<td align="center" class="CELL">
		<form name="lang_form" id="lang_form" action="/apply_sec.cgi" method=post>
		<input type="hidden" id="html_response_return_page" name="html_response_return_page" value="setup_wizard.asp">
		<input type="hidden" id="html_response_page" name="html_response_page" value="setup_wizard.asp">
		<input type="hidden" id="language" name="language" value=<!--# echo language -->>
		<input type="hidden" id="action" name="action" value="lang">
		</form>


			<div align="right" style="display: yes;">
				<strong><script>show_words('_Language')</script>&nbsp;&#58;</strong>
				<select id="lang_select" size="1" style="width:100px;" onChange="change_lang();">
							<option value="en" selected="">English</option>
							<option value="sp">Español</option>
							<option value="ge">Deutsch</option>
							<option value="ru">Русский</option>
							<option value="fr">Français</option>
				</select>
				<!--script>$('#lang_select').val(br_lang);</script-->

			</div>
			<div style="padding:50px;">
				<p><b><script>show_words('_tnw_02');</script></b></p>
			</div>
		</td>
	</tr>
	<tr>
		<td align="center" class="CELL">
			<input name="p0_cancel" id="p0_cancel" type="button" class="ButtonSmall" onclick="wizard_cancel()" value="Cancel" />
			<script>$('#p0_cancel').val(get_words('_cancel'));</script>
			<input name="p0_apply" id="p0_apply" type="button" class="ButtonSmall" onclick="show_page_p1();" value="Next &gt;" />
			<script>$('#p0_apply').val(get_words('_next')+' >');</script>
		</td>
	</tr>
</table>
</div>

<div id="p1" name="page" class="box_tn" style="display:none;">
<table width="100%" border="0" cellpadding="0" cellspacing="0">
	<tr>
		<td class="CT">	
			<font><script>document.write(addstr(get_words('_tnw_03'), model));</script></font>
		</td>
	</tr>
	<tr>
		<td align="center" class="CELL" style="padding:50px;">
			<div align="center">
			<div align="left" style="width:500px;border:1px solid #000000;background-color:#ffffff;" >
				<div id="progressbar">&nbsp;</div>
			</div>
			</div>
		</td>
	</tr>
	<tr>
		<td align="center" class="CELL">
			<input name="p1_apply" id="p1_apply" type="button" class="ButtonSmall" onclick="show_page_p0()" value="&lt; Back" />
			<script>$('#p1_apply').val('< '+get_words('_back'));</script>
			<input name="p1_cancel" id="p1_cancel" type="button" class="ButtonSmall" onclick="wizard_cancel()" value="Cancel" />
			<script>$('#p1_cancel').val(get_words('_cancel'));</script>
		</td>
	</tr>
</table>
</div>

<div id="p2" name="page" class="box_tn" style="display:none;">
<table width="100%" border="0" cellpadding="0" cellspacing="0">
	<tr>
		<td colspan="2" class="CT">	
			<font><script>document.write(get_words('_confirm_settings'));</script></font>
		</td>
	</tr>
	<tr>
		<td align="right" class="CELL" style="width:40%;"><b><script>show_words('help569');</script>&nbsp;<script>show_words('_ipaddr');</script> :</b></td>
		<td align="left" class="CELL" style="width:60%;" id="p2_ipaddr"></td>
	</tr>
	<tr>
		<td align="right" class="CELL" style="width:60%;">
			<b><script>show_words('help569');</script> <script>show_words('_subnet');</script> :</b></td>
		<td align="left" class="CELL" style="width:40%;" id="p2_subnet"></td>
	</tr>
	<tr>
		<td align="right" class="CELL" style="width:60%;">
			<b><script>show_words('help569');</script> <script>show_words('wwa_gw');</script> :</b></td>
		<td align="left" class="CELL" style="width:40%;" id="p2_gw"></td>
	</tr>
	<tr>
		<td align="right" class="CELL" style="width:60%;">
			<b><script>show_words('_tnw_04_f02');</script> :</b></td>
		<td align="left" class="CELL" style="width:40%;" id="p2_dns"></td>
	</tr>	
	<tr>
		<td align="right" class="CELL" style="width:40%;"><b><script>show_words('WAN');</script>&nbsp;<script>show_words('_macaddr');</script> :</b></td>
		<td align="left" class="CELL" style="width:60%;" id="p2_macaddr"></td>
	</tr>
	<tr>
		<td align="right" class="CELL" style="width:40%;"><b><script>show_words('KR16');</script><script>show_words('wwl_wnn');</script> :</b></td>
		<td align="left" class="CELL" style="width:60%;" id="p2_ssid"></td>
	</tr>
	<tr>
		<td align="right" class="CELL" style="width:40%;"><b><script>show_words('KR16');</script><script>show_words('_tnw_04_f01');</script> :</b></td>
		<td align="left" class="CELL" style="width:60%;" id="p2_authtype"></td>
	</tr>
	<tr>
		<td align="right" class="CELL" style="width:60%;">
			<b><script>show_words('KR17');</script> <script>show_words('wwl_wnn');</script> :</b></td>
		<td align="left" class="CELL" style="width:40%;" id="p2_ssid5"></td>
	</tr>
	<tr>
		<td align="right" class="CELL" style="width:60%;">
			<b><script>show_words('KR17');</script> <script>show_words('_tnw_04_f01');</script> :</b></td>
		<td align="left" class="CELL" style="width:40%;" id="p2_authtype5"></td>
	</tr>	
	<form id="form2" name="form2" method="post" action="apply_sec.cgi">
		<input type="hidden" id="action" name="action" value="setup_wizard_cancel">
		<input type="hidden" id="html_response_page" name="html_response_page" value="login_pic.asp">
		<input type="hidden" id="html_response_return_page" name="html_response_return_page" value="login.asp">
		<tr>
			<td colspan="2" align="center" class="CELL">
				<input name="p2_apply" id="p2_apply" type="button" class="ButtonSmall" onclick="show_page_p0()" value="&lt; Back" />
				<script>$('#p2_apply').val('< '+get_words('_back'));</script>
				<input name="p2_finish" id="p2_finish" type="button" class="ButtonSmall" onclick="wizard_ok()" value="Save" />
				<script>$('#p2_finish').val(get_words('_save'));</script>
			</td>
		</tr>
	</form>
</table>
</div>

<div id="p3" name="page" class="box_tn" style="display:none;">
<table width="100%" border="0" cellpadding="0" cellspacing="0">
	<tr>
		<td class="CT">	
			<font><script>document.write(addstr(get_words('_tnw_05'), model));</script></font>
		</td>
	</tr>
	<tr>
		<td align="left" class="CELL" style="padding-left:200px;">
			<input type="radio" name="p3_wan_type" value="0" />
			<b><script>show_words('_tnw_dhcp');</script></b>
		</td>
	</tr>
	<tr>
		<td align="left" class="CELL" style="padding-left:200px;">
			<input type="radio" name="p3_wan_type" value="1" />
			<b><script>show_words('_tnw_static');</script></b>
		</td>
	</tr>
	<tr>
		<td align="left" class="CELL" style="padding-left:200px;">
			<input type="radio" name="p3_wan_type" value="2" />
			<b><script>show_words('_tnw_pppoe');</script></b>
		</td>
	</tr>
	<tr>
		<td align="left" class="CELL" style="padding-left:200px;">
			<input type="radio" name="p3_wan_type" value="3" />
			<b><script>show_words('_tnw_pptp');</script></b>
		</td>
	</tr>
	<tr>
		<td align="left" class="CELL" style="padding-left:200px;">
			<input type="radio" name="p3_wan_type" value="4" />
			<b><script>show_words('_tnw_l2tp');</script></b>
		</td>
	</tr>
	<tr>
		<td align="center" class="CELL">
			<input name="p3_back" id="p3_back" type="button" class="ButtonSmall" onclick="show_page_p0()" value="&lt; Back" />
			<script>$('#p3_back').val('< '+get_words('_back'));</script>
			<input name="p3_apply" id="p3_apply" type="button" class="ButtonSmall" onclick="sel_page_p3()" value="Next &gt;" />
			<script>$('#p3_apply').val(get_words('_next')+' >');</script>
			<input name="p3_cancel" id="p3_cancel" type="button" class="ButtonSmall" onclick="wizard_cancel()" value="Cancel" />
			<script>$('#p3_cancel').val(get_words('_cancel'));</script>
		</td>
	</tr>
</table>
</div>

<div id="p3a" name="page" class="box_tn" style="display:none;">
<!-- DHCP -->
<table width="100%" border="0" cellpadding="0" cellspacing="0">
	<tr>
		<td colspan="2" class="CT">	
			<font><script>document.write(addstr(get_words('_tnw_06'), model));</script></font>
		</td>
	</tr>
	<tr>
		<td align="right" class="CL">
			<b><script>show_words('_hostname');</script>:</b>
		</td>
		<td align="left" class="CR">
			<input type="text" id="p3a_device_name" name="device_name" size="40" maxlength="39" value="" />
			<b><script>show_words('_optional');</script></b>
		</td>
	</tr>
	<tr>
		<td align="right" class="CL">
			<b><script>show_words('_mac');</script>:</b>
		</td>
		<td align="left" class="CR">
			<font face="Arial" size="2">
				<input type="text" id="p3a_mac1" name="mac1" size="2" maxlength="2" />
				-
				<input type="text" id="p3a_mac2" name="mac2" size="2" maxlength="2" />
				-
				<input type="text" id="p3a_mac3" name="mac3" size="2" maxlength="2" />
				-
				<input type="text" id="p3a_mac4" name="mac4" size="2" maxlength="2" />
				-
				<input type="text" id="p3a_mac5" name="mac5" size="2" maxlength="2" />
				-
				<input type="text" id="p3a_mac6" name="mac6" size="2" maxlength="2" />
				<b><script>show_words('_optional');</script></b>
			</font>
		</td>
	</tr>
	<tr>
		<td align="right" class="CL">
			<span id="macCloneMac"></span>
		</td>
		<td align="left" class="CR">
			<input id="p3a_clone" type="button" value="Clone MAC Address" onclick="clone_mac_action()" />
			<script>$('#p3a_clone').val(get_words('_tnw_clone'));</script>
		</td>
	</tr>
	<tr>
		<td colspan="2" align="center" class="CELL">
			<input name="p3a_back" id="p3a_back" type="button" class="ButtonSmall" onclick="show_page_p3()" value="&lt; Back" />
			<script>$('#p3a_back').val('< '+get_words('_back'));</script>
			<input name="p3a_apply" id="p3a_apply" type="button" class="ButtonSmall" onclick="wz_p3a_save()" value="Save" />
			<script>$('#p3a_apply').val(get_words('_save'));</script>
			<input name="p3a_cancel" id="p3a_cancel" type="button" class="ButtonSmall" onclick="wizard_cancel()" value="Cancel" />
			<script>$('#p3a_cancel').val(get_words('_cancel'));</script>
		</td>
	</tr>
</table>
</div>

<div id="p3b" name="page" class="box_tn" style="display:none;">
<!-- Static -->
<table width="100%" border="0" cellpadding="0" cellspacing="0">
	<tr>
		<td colspan="2" class="CT">	
			<font><script>document.write(addstr(get_words('_tnw_07'), model));</script></font>
		</td>
	</tr>
	<tr>
		<td align="right" class="CELL" style="width:40%;"><b><script>show_words('_wan_ipaddr');</script>:</b></td>
		<td align="left" class="CELL" style="width:60%;">
			<input type="text" id="p3b_wan_ip" size="16" maxlength="18" value="" />
		</td>
	</tr>
	<tr>
		<td align="right" class="CELL" style="width:40%;"><b><script>show_words('_wan_submask');</script>:</b></td>
		<td align="left" class="CELL" style="width:60%;">
			<input type="text" id="p3b_wan_mask" size="16" maxlength="18" value="" />
		</td>
	</tr>
	<tr>
		<td align="right" class="CELL" style="width:40%;"><b><script>show_words('_wan_gwaddr');</script>:</b></td>
		<td align="left" class="CELL" style="width:60%;">
			<input type="text" id="p3b_wan_gw" size="16" maxlength="18" value="" />
		</td>
	</tr>
	<tr>
		<td align="right" class="CELL" style="width:40%;"><b><script>show_words('_dns1');</script>:</b></td>
		<td align="left" class="CELL" style="width:60%;">
			<input type="text" id="p3b_wan_dns1" size="16" maxlength="18" value="" />
		</td>
	</tr>
	<tr>
		<td align="right" class="CELL" style="width:40%;"><b><script>show_words('_dns2');</script>:</b></td>
		<td align="left" class="CELL" style="width:60%;">
			<input type="text" id="p3b_wan_dns2" size="16" maxlength="18" value="" />
		</td>
	</tr>
	<tr>
		<td colspan="2" align="center" class="CELL">
			<input name="p3b_back" id="p3b_back" type="button" class="ButtonSmall" onclick="show_page_p3()" value="&lt; Back" />
			<script>$('#p3b_back').val('< '+get_words('_back'));</script>
			<input name="p3b_apply" id="p3b_apply" type="button" class="ButtonSmall" onclick="wz_p3b_save()" value="Save" />
			<script>$('#p3b_apply').val(get_words('_save'));</script>
			<input name="p3b_cancel" id="p3b_cancel" type="button" class="ButtonSmall" onclick="wizard_cancel()" value="Cancel" />
			<script>$('#p3b_cancel').val(get_words('_cancel'));</script>
		</td>
	</tr>
</table>
</div>

<div id="p3c" name="page" class="box_tn" style="display:none;">
<!-- PPPoE -->
<table width="100%" border="0" cellpadding="0" cellspacing="0">
	<tr>
		<td colspan="2" class="CT">
			<font><script>document.write(addstr(get_words('_tnw_08'), model));</script></font>
		</td>
	</tr>
<!--
	<tr>
		<td align="right" class="CELL" style="width:40%;"></td>
		<td align="left" class="CELL" style="width:60%;">
			<font face="Arial">
				<input type="radio" id="pppoe_conn_type" name="pppoe_conn_type" value="0" onclick="$('#pppoe_ip_addr').attr('disabled','disabled');" checked="" />
			</font>
			<b><script>show_words('carriertype_ct_0');</script></b>&nbsp;
			<font face="Arial">
				<input type="radio" id="pppoe_conn_type" name="pppoe_conn_type" value="1" onclick="$('#pppoe_ip_addr').removeAttr('disabled');" />
			</font>
			<b><script>show_words('_sdi_staticip');</script></b>&nbsp;
		</td>
	</tr>
-->
	<tr>
		<td align="right" class="CELL" style="width:40%;"><b><script>show_words('_username');</script>:</b></td>
		<td align="left" class="CELL" style="width:60%;">
			<input type="text" id="pppoe_user_name" size="30" maxlength="63" value="" />
		</td>
	</tr>
	<tr>
		<td align="right" class="CELL" style="width:40%;"><b><script>show_words('_password');</script>:</b></td>
		<td align="left" class="CELL" style="width:60%;">
			<input type="password" id="pppoe_user_pwd" size="30" maxlength="64" value="" />
		</td>
	</tr>
	<tr>
		<td align="right" class="CELL" style="width:40%;"><b><script>show_words('_verifypw');</script>:</b></td>
		<td align="left" class="CELL" style="width:60%;">
			<input type="password" id="pppoe_verify_pwd" size="30" maxlength="64" value="" />
		</td>
	</tr>
<!--
	<tr>
		<td align="right" class="CELL" style="width:40%;"><b><script>show_words('_ipaddr');</script>:</b></td>
		<td align="left" class="CELL" style="width:60%;">
			<input type="text" id="pppoe_ip_addr" size="16" maxlength="18" value="0.0.0.0" disabled>
		</td>
	</tr>
-->
	<tr>
		<td colspan="2" align="center" class="CELL">
			<input name="p3c_back" id="p3c_back" type="button" class="ButtonSmall" onclick="show_page_p3()" value="&lt; Back" />
			<script>$('#p3c_back').val('< '+get_words('_back'));</script>
			<input name="p3c_apply" id="p3c_apply" type="button" class="ButtonSmall" onclick="wz_p3c_save()" value="Save" />
			<script>$('#p3c_apply').val(get_words('_save'));</script>
			<input name="p3c_cancel" id="p3c_cancel" type="button" class="ButtonSmall" onclick="wizard_cancel()" value="Cancel" />
			<script>$('#p3c_cancel').val(get_words('_cancel'));</script>
		</td>
	</tr>
</table>
</div>
<div id="p3d" name="page" class="box_tn" style="display:none;">
<!-- PPTP -->
<table width="100%" border="0" cellpadding="0" cellspacing="0">
	<tr>
		<td colspan="2" class="CT">
			<font><script>document.write(addstr(get_words('_tnw_09'), model));</script></font>
		</td>
	</tr>
	<tr>
		<td align="right" class="CELL" style="width:40%;"></td>
		<td align="left" class="CELL" style="width:60%;">
			<font face="Arial">
				<input type="radio" id="pptp_conn_type" name="pptp_conn_type" value="0" onclick="$('input[name=pptp_static_g]').attr('disabled','disabled');" checked="" />
			</font>
			<b><script>show_words('carriertype_ct_0');</script></b>&nbsp;
			<font face="Arial">
				<input type="radio" id="pptp_conn_type" name="pptp_conn_type" value="1" onclick="$('input[name=pptp_static_g]').removeAttr('disabled');" />
			</font>
			<b><script>show_words('_sdi_staticip');</script></b>&nbsp;
		</td>
	</tr>
	<tr>
		<td align="right" class="CELL" style="width:40%;"><b><script>show_words('_my_ip');</script>:</b></td>
		<td align="left" class="CELL" style="width:60%;">
			<input type="text" id="pptp_ip_addr" name="pptp_static_g" size="16" maxlength="63" value="0.0.0.0" disabled>
		</td>
	</tr>
	<tr>
		<td align="right" class="CELL" style="width:40%;"><b><script>show_words('_subnet');</script>:</b></td>
		<td align="left" class="CELL" style="width:60%;">
			<input type="text" id="pptp_subnet_mask" name="pptp_static_g" size="16" maxlength="63" value="0.0.0.0" disabled>
		</td>
	</tr>
	<tr>
		<td align="right" class="CELL" style="width:40%;"><b><script>show_words('_gateway');</script>:</b></td>
		<td align="left" class="CELL" style="width:60%;">
			<input type="text" id="pptp_gateway" name="pptp_static_g" size="16" maxlength="63" value="0.0.0.0" disabled>
		</td>
	</tr>
<!-- pppoe should not show here
	<tr>
		<td align="right" class="CELL" style="width:40%;"><b>User Name:</b></td>
		<td align="left" class="CELL" style="width:60%;">
			<input type="text" id="pppoe_user_name2" size="30" maxlength="63" value="" />
		</td>
	</tr>
-->
	<tr>
		<td align="right" class="CELL" style="width:40%;"><b><script>show_words('_server_ip');</script>:</b></td>
		<td align="left" class="CELL" style="width:60%;">
			<input type="text" id="pptp_server_ip" size="16" maxlength="63" value="" />
		</td>
	</tr>
	<tr>
		<td align="right" class="CELL" style="width:40%;"><b><script>show_words('_pptp_account');</script>:</b></td>
		<td align="left" class="CELL" style="width:60%;">
			<input type="text" id="pptp_user_name" size="30" maxlength="63" value="" />
		</td>
	</tr>
	<tr>
		<td align="right" class="CELL" style="width:40%;"><b><script>show_words('_pptp_password');</script>:</b></td>
		<td align="left" class="CELL" style="width:60%;">
			<input type="password" id="pptp_user_pwd" name="pptp_user_pwd" size="30" maxlength="63" value="" />
		</td>
	</tr>
	<tr>
		<td align="right" class="CELL" style="width:40%;"><b><script>show_words('_pptp_password_re');</script>:</b></td>
		<td align="left" class="CELL" style="width:60%;">
			<input type="password" id="pptp_verify_pwd" name="pptp_verify_pwd" size="30" maxlength="63" value="" />
		</td>
	</tr>
	<tr>
		<td colspan="2" align="center" class="CELL">
			<input name="p3d_back" id="p3d_back" type="button" class="ButtonSmall" onclick="show_page_p3()" value="&lt; Back" />
			<script>$('#p3d_back').val('< '+get_words('_back'));</script>
			<input name="p3d_apply" id="p3d_apply" type="button" class="ButtonSmall" onclick="wz_p3d_save()" value="Save" />
			<script>$('#p3d_apply').val(get_words('_save'));</script>
			<input name="p3d_cancel" id="p3d_cancel" type="button" class="ButtonSmall" onclick="wizard_cancel()" value="Cancel" />
			<script>$('#p3d_cancel').val(get_words('_cancel'));</script>
		</td>
	</tr>
</table>
</div>

<div id="p3e" name="page" class="box_tn" style="display:none;">
<!-- L2TP -->
<table width="100%" border="0" cellpadding="0" cellspacing="0">
	<tr>
		<td colspan="2" class="CT">
			<font><script>document.write(addstr(get_words('_tnw_10'), model));</script></font>
		</td>
	</tr>
	<tr>
		<td align="right" class="CELL" style="width:40%;"></td>
		<td align="left" class="CELL" style="width:60%;">
			<font face="Arial">
				<input type="radio" id="l2tp_conn_type" name="l2tp_conn_type" value="0" onclick="$('input[name=l2tp_static_g]').attr('disabled','disabled');" checked="" />
			</font>
			<b><script>show_words('carriertype_ct_0');</script></b>&nbsp;
			<font face="Arial">
				<input type="radio" id="l2tp_conn_type" name="l2tp_conn_type" value="1" onclick="$('input[name=l2tp_static_g]').removeAttr('disabled');" />
			</font>
			<b><script>show_words('_sdi_staticip');</script></b>&nbsp;
		</td>
	</tr>
	<tr>
		<td align="right" class="CELL" style="width:40%;"><b><script>show_words('_my_ip');</script>:</b></td>
		<td align="left" class="CELL" style="width:60%;">
			<input type="text" id="l2tp_ip_addr" name="l2tp_static_g" size="16" maxlength="63" value="0.0.0.0" disabled>
		</td>
	</tr>
	<tr>
		<td align="right" class="CELL" style="width:40%;"><b><script>show_words('_subnet');</script>:</b></td>
		<td align="left" class="CELL" style="width:60%;">
			<input type="text" id="l2tp_subnet_mask" name="l2tp_static_g" size="16" maxlength="63" value="0.0.0.0" disabled>
		</td>
	</tr>
	<tr>
		<td align="right" class="CELL" style="width:40%;"><b><script>show_words('_gateway');</script>:</b></td>
		<td align="left" class="CELL" style="width:60%;">
			<input type="text" id="l2tp_gateway" name="l2tp_static_g" size="16" maxlength="63" value="0.0.0.0" disabled>
		</td>
	</tr>
	<tr>
		<td align="right" class="CELL" style="width:40%;"><b><script>show_words('_server_ip');</script>:</b></td>
		<td align="left" class="CELL" style="width:60%;">
			<input type="text" id="l2tp_server_ip" size="16" maxlength="63" value="" />
		</td>
	</tr>
	<tr>
		<td align="right" class="CELL" style="width:40%;"><b><script>show_words('_l2tp_account');</script>:</b></td>
		<td align="left" class="CELL" style="width:60%;">
			<input type="text" id="l2tp_user_name" size="30" maxlength="63" value="" />
		</td>
	</tr>
	<tr>
		<td align="right" class="CELL" style="width:40%;"><b><script>show_words('_l2tp_password');</script>:</b></td>
		<td align="left" class="CELL" style="width:60%;">
			<input type="password" id="l2tp_user_pwd" name="l2tp_user_pwd" size="30" maxlength="63" value="" />
		</td>
	</tr>
	<tr>
		<td align="right" class="CELL" style="width:40%;"><b><script>show_words('_l2tp_password_re');</script>:</b></td>
		<td align="left" class="CELL" style="width:60%;">
			<input type="password" id="l2tp_verify_pwd" name="l2tp_verify_pwd" size="30" maxlength="63" value="" />
		</td>
	</tr>
	<tr>
		<td colspan="2" align="center" class="CELL">
			<input name="p3e_back" id="p3e_back" type="button" class="ButtonSmall" onclick="show_page_p3()" value="&lt; Back" />
			<script>$('#p3e_back').val('< '+get_words('_back'));</script>
			<input name="p3e_apply" id="p3e_apply" type="button" class="ButtonSmall" onclick="wz_p3e_save()" value="Save" />
			<script>$('#p3e_apply').val(get_words('_save'));</script>
			<input name="p3e_cancel" id="p3e_cancel" type="button" class="ButtonSmall" onclick="wizard_cancel()" value="Cancel" />
			<script>$('#p3e_cancel').val(get_words('_cancel'));</script>
		</td>
	</tr>
</table>
</div>

<div id="wan_ok" name="page" class="box_tn" style="display:none;">
<table width="100%" border="0" cellpadding="0" cellspacing="0">
	<tr>
		<td class="CT">	
			<font>&nbsp;</font>
		</td>
	</tr>
	<tr>
		<td align="center" class="CELL" style="padding:50px;">
			<p>
				<span id="msg_str"><b><script>show_words('_tnw_11');</script></b></span>
			</p>
			<p>
				<b><script>show_words('_tnw_12');</script> <span id="show_second">40</span> <script>show_words('_tnw_13');</script></b>
			</p>
		</td>
	</tr>
	<tr>
		<td align="center" class="CELL">
			<input type="button" id="back_btn" name="back_btn" class="ButtonSmall" onclick="location.replace(get_ip());" disabled="" value="Back" />
			<script>$('#back_btn').val(get_words('_back'));</script>
		</td>
	</tr>
</table>
</div>

<div id="wan_detecting" name="page" class="box_tn" style="display:none;">
<table width="100%" border="0" cellpadding="0" cellspacing="0">
	<tr>
		<td class="CT">	
			<font>&nbsp;</font>
		</td>
	</tr>
	<tr>
		<td align="center" class="CELL" style="padding:50px;">
			<b><span id="detect_msg_str"></span></b>
		</td>
	</tr>
</table>
</div>

<div id="wan_failed" name="page" class="box_tn" style="display:none;">
<table width="100%" border="0" cellpadding="0" cellspacing="0">
	<tr>
		<td class="CT">	
			<font>&nbsp;</font>
		</td>
	</tr>
	<tr>
		<td align="center" class="CELL" style="padding:50px;">
			<span id="msg_str"><b><script>show_words('mydlink_tx03');</script></b></span>
		</td>
	</tr>
	<tr>
		<td align="center" class="CELL">
			<input type="button" id="failed_retry" name="failed_retry" class="ButtonSmall" onclick="show_page_p0();" value="Retry" />
			<script>$('#failed_retry').val(get_words('_retry'));</script>
			<input type="button" id="failed_cancel" name="failed_cancel" class="ButtonSmall" onclick="wizard_cancel();" value="Cancel" />
			<script>$('#failed_cancel').val(get_words('_cancel'));</script>
		</td>
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
<script>
get_wan_info();
get_lang();
</script>
</script>
</html>