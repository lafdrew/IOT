<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html lang="en-US" xmlns="http://www.w3.org/1999/xhtml" xml:lang="en-US">
<head>
<title>TRENDNET | modelName | Basic | Wireless</title>
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
	var menu = new menuObject();
	var connect;
	var wTimesec = "", wan_time = "";
	var cnt = 0;
	var temp, days = 0, hours = 0, mins = 0, secs = 0;
	
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
                url += "ipv6_status.xml";
                xmlhttp.onreadystatechange = xmldoc; 
                xmlhttp.open("GET", url, true); 
                xmlhttp.send(null); 
        }
        setTimeout("get_File()", 3000);
}

function createRequest() {
	var XMLhttpObject = null;
	try {
		XMLhttpObject = new XMLHttpRequest();
	} catch (e) {
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


function xmldoc(){
	var ipv6_wan_type;
	var network_ipv6_status;
	var ipv6_network_status_flag;
	var tr_dhcp_pd_networkassined;
	var tr_network_ipv6_status;
	var tr_wan_ipv6_addr;
	var	tr_lan_ipv6_addr;
	var	tr_wan_ipv6_gw;	
	var	tr_primary_ipv6_dns;
	var	tr_secondary_ipv6_dns;
	var tr_tunnel_ipv6_addr;
	var tr_dhcp_pd;
	var tr_show_button;
	var ipv6_wan_ip;
	var ipv6_wan_ip_local;
	var ipv6_wan_ip_list;
	var ipv6_wan_gw;
	var ipv6_lan_ip_list;
	var ipv6_lan_ip;
	var ipv6_primary_dns;
	var ipv6_secondary_dns;
	var link_local;
	var dhcp_pd;
	var dhcp_pd_networkassined;
	var ipv6_sel_wan = "<!--# echo ipv6_wan_proto -->";
	var ipv6_pppoe_share = "<!--# echo ipv6_pppoe_share -->";
	var ipv6_dhcp_ip;
	var tr_show_uptime;
	
	if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
	try {
		ipv6_wan_type = get_by_id("connection_ipv6_type");
		network_ipv6_status = get_by_id("network_ipv6_status");
		tr_dhcp_pd_networkassined=get_by_id("tr_dhcp_pd_networkassined");
		tr_network_ipv6_status=get_by_id("tr_network_ipv6_status");
		tr_show_button=get_by_id("tr_ipv6_show_button");
		tr_wan_ipv6_addr=get_by_id("tr_wan_ipv6_addr");
		tr_lan_ipv6_addr=get_by_id("tr_lan_ipv6_addr");
		tr_wan_ipv6_gw=get_by_id("tr_wan_ipv6_gw");
		tr_primary_ipv6_dns=get_by_id("tr_primary_ipv6_dns");
		tr_secondary_ipv6_dns=get_by_id("tr_secondary_ipv6_dns");
		tr_tunnel_ipv6_addr=get_by_id("tr_tunnel_ipv6_addr");
		tr_dhcp_pd=get_by_id("tr_dhcp_pd");
		ipv6_wan_ip_local = get_by_id("tunnel_ipv6_addr");
		ipv6_lan_ip = get_by_id("lan_ipv6_addr");
		link_local = get_by_id("lan_link_local_ip");
		dhcp_pd = get_by_id("dhcp_pd");
		//tr_show_uptime=get_by_id("tr_show_uptime");

		var xml = xmlhttp.responseXML;

		ipv6_sel_wan = replace_null_to_none(xml.getElementsByTagName("ipv6_wan_proto")[0].firstChild.nodeValue);
		ipv6_network_status_flag=xml.getElementsByTagName("ipv6_wan_network_status")[0].firstChild.nodeValue;
		ipv6_wan_ip_list =replace_null_to_none(xml.getElementsByTagName("ipv6_wan_ip")[0].firstChild.nodeValue).split(",");
		ipv6_lan_ip_list =replace_null_to_none(xml.getElementsByTagName("ipv6_lan_ip_global")[0].firstChild.nodeValue).split(",");
		ipv6_primary_dns = replace_null_to_none(xml.getElementsByTagName("ipv6_wan_primary_dns")[0].firstChild.nodeValue);
		ipv6_secondary_dns = replace_null_to_none(xml.getElementsByTagName("ipv6_wan_secondary_dns")[0].firstChild.nodeValue);
		if (ipv6_network_status_flag == "connect") {
			network_ipv6_status.innerHTML = get_words('CONNECTED');
			connect = 1;
		} else {
			network_ipv6_status.innerHTML = get_words('DISCONNECTED');
			connect = 0;
		}
		ipv6_wan_ip_local = replace_null_to_none(xml.getElementsByTagName("ipv6_wan_ip_local")[0].firstChild.nodeValue);
//		ipv6_lan_ip.innerHTML = replace_null_to_none(xml.getElementsByTagName("ipv6_lan_ip_global")[0].firstChild.nodeValue);
		link_local.innerHTML = replace_null_to_none(xml.getElementsByTagName("ipv6_lan_ip_local")[0].firstChild.nodeValue);
		ipv6_wan_gw = replace_null_to_none(xml.getElementsByTagName("ipv6_wan_default_gateway")[0].firstChild.nodeValue);
		dhcp_pd_status = replace_null_to_none(xml.getElementsByTagName("ipv6_dhcp_pd_enable")[0].firstChild.nodeValue);
		dhcp_pd_networkassined_status = replace_null_to_none(xml.getElementsByTagName("ipv6_dhcp_pd")[0].firstChild.nodeValue);
		dhcp_pd.innerHTML = dhcp_pd_status;
		dhcp_pd_networkassined = dhcp_pd_networkassined_status;
		ipv6_dhcp_ip = replace_null_to_none(xml.getElementsByTagName("ipv6_dhcp_ip")[0].firstChild.nodeValue);
		wTimesec = xmlhttp.responseXML.getElementsByTagName("ipv6_wan_uptime")[0].firstChild.nodeValue;
		 
		if(ipv6_primary_dns == "none")
			get_by_id("primary_ipv6_dns").innerHTML = "";
		else
			get_by_id("primary_ipv6_dns").innerHTML = ipv6_primary_dns;

		if(ipv6_secondary_dns == "none")
			get_by_id("secondary_ipv6_dns").innerHTML = "";
		else
			get_by_id("secondary_ipv6_dns").innerHTML = ipv6_secondary_dns;

		if(ipv6_wan_gw == "NULL")
			get_by_id("wan_ipv6_gw").innerHTML = "";
		else
			get_by_id("wan_ipv6_gw").innerHTML = ipv6_wan_gw;

		if(dhcp_pd_networkassined == "none")
			get_by_id("dhcp_pd_networkassined").innerHTML = "";
		else
			get_by_id("dhcp_pd_networkassined").innerHTML = dhcp_pd_networkassined;

		if(ipv6_wan_ip_local == "none")
			ipv6_wan_ip_local.innerHTML = "";
		else
			ipv6_wan_ip_local.innerHTML = ipv6_wan_ip_local;

		if(dhcp_pd_status =="Disabled"){
			tr_dhcp_pd_networkassined.style.display="none";
		}else{
			tr_dhcp_pd_networkassined.style.display="";
		}
	
		for (var i = 0; i < ipv6_wan_ip_list.length; i++){
			if(i==0){
				if(ipv6_wan_ip_list[i] == "None"|| ipv6_wan_ip_list[i] == "NULL"){
					get_by_id("wan_ipv6_addr").innerHTML = "";
				}else{	
					get_by_id("wan_ipv6_addr").innerHTML = ipv6_wan_ip_list[i];
				}
			}else{
				get_by_id("wan_ipv6_addr").innerHTML +="<br>";
				get_by_id("wan_ipv6_addr").innerHTML += ipv6_wan_ip_list[i];
			}
		}

		for (var i = 0; i < ipv6_lan_ip_list.length; i++){
			if(i==0){
				if(ipv6_lan_ip_list[i] == "None" || ipv6_lan_ip_list[i] == "NULL"){
					ipv6_lan_ip.innerHTML = "";
				}else{	
					ipv6_lan_ip.innerHTML = ipv6_lan_ip_list[i];
				}
			}else{
				ipv6_lan_ip.innerHTML +="<br>&nbsp; ";
				ipv6_lan_ip.innerHTML += ipv6_lan_ip_list[i];
			}		
		}

		tr_network_ipv6_status.style.display="";
		tr_wan_ipv6_addr.style.display="";
		tr_lan_ipv6_addr.style.display="";
		tr_wan_ipv6_gw.style.display="";	
		tr_primary_ipv6_dns.style.display="";
		tr_secondary_ipv6_dns.style.display="";
		tr_dhcp_pd_networkassined.style.display="";
		tr_show_button.style.display="";
		
		if(ipv6_sel_wan =="ipv6_static"){
			var use_link_local = "<!--# echo ipv6_use_link_local -->"
			if ( use_link_local == 1)
				ipv6_wan_ip = replace_null_to_none(xml.getElementsByTagName("ipv6_wan_ip_local")[0].firstChild.nodeValue);

			if (ipv6_wan_ip == "NULL")
				get_by_id("wan_ipv6_addr").innerHTML = "";
			
			ipv6_wan_type.innerHTML = get_words('IPV6_TEXT32');
//			tr_wan_ipv6_addr_local.style.display="none";		  
			tr_dhcp_pd.style.display="none";
			tr_dhcp_pd_networkassined.style.display="none";
			tr_show_button.style.display="none";
			tr_tunnel_ipv6_addr.style.display="none";
			//tr_show_uptime.style.display="none";
		}else if(ipv6_sel_wan =="ipv6_autoconfig"){
			ipv6_wan_type.innerHTML = get_words('IPV6_TEXT171');
			tr_tunnel_ipv6_addr.style.display="none";
			{
				$('#ctrl_buttons').html(
					"<input type=button id=connect class=button_submit name=connect value=\"" + get_words('LS312') + "\" onclick=wan_connection_type(\"ipv6_dhcp_renew\")>" +
					"<input type=button id=disconnect class=button_submit name=disconnect value=\"" + get_words('LS313') + "\" onclick=wan_connection_type(\"ipv6_dhcp_release\")>");
				if(cnt != 0){
					get_by_id("disconnect").disabled = true;
					get_by_id("connect").disabled = true;
				} else if (ipv6_dhcp_ip != "None" || dhcp_pd_networkassined_status != "None") {
					get_by_id("disconnect").disabled = false;
					get_by_id("connect").disabled = false;
				} else {
					get_by_id("disconnect").disabled = true;
					get_by_id("connect").disabled = false;
				}
			}
		}else if(ipv6_sel_wan =="ipv6_autoconfig_6rd"){
			ipv6_wan_type.innerHTML = get_words('IPV6_TEXT172');
			tr_tunnel_ipv6_addr.style.display="";
			$('#ctrl_buttons').html(
				"<input type=button id=connect class=button_submit name=connect value=\"" + get_words('LS312') + "\" onclick=wan_connection_type(\"ipv6_dhcp_renew\")>" +
				"<input type=button id=disconnect class=button_submit name=disconnect value=\"" + get_words('LS313') + "\" onclick=wan_connection_type(\"ipv6_dhcp_release\")>");
			if(cnt != 0){
				get_by_id("disconnect").disabled = true;
				get_by_id("connect").disabled = true;
			} else if (ipv6_dhcp_ip != "None" || dhcp_pd_networkassined_status != "None") {
				get_by_id("disconnect").disabled = false;
				get_by_id("connect").disabled = false;
			} else {
				get_by_id("disconnect").disabled = true;
				get_by_id("connect").disabled = false;
			}
		}else if(ipv6_sel_wan =="ipv6_autodetect"){
			ipv6_wan_type.innerHTML = get_words('IPV6_TEXT138');
			tr_tunnel_ipv6_addr.style.display="none";		  
			tr_show_button.style.display="none";

		}else if(ipv6_sel_wan =="ipv6_pppoe"){
			ipv6_wan_type.innerHTML = get_words('IPV6_TEXT34');
			tr_tunnel_ipv6_addr.style.display="none";
			if (ipv6_pppoe_share == "0") {
				$('#ctrl_buttons').html(
					"<input type=button id=connect class=button_submit name=connect value=\"" + get_words('_connect') + "\" onclick=wan_connection_type(\"ipv6_pppoe_connect\")>" +
					"<input type=button id=disconnect class=button_submit name=disconnect value=\"" + get_words('LS315') + "\" onclick=wan_connection_type(\"ipv6_pppoe_disconnect\")>");
				if(cnt != 0){
					get_by_id("disconnect").disabled = true;
					get_by_id("connect").disabled = true;
				} else if (ipv6_network_status_flag == "connect") {
					get_by_id("disconnect").disabled = false;
					get_by_id("connect").disabled = true;
				} else {
					get_by_id("disconnect").disabled = true;
					get_by_id("connect").disabled = false;
				}
			}else if(ipv6_pppoe_share == "1"){
				$('#ctrl_buttons').html(
					"<input type=button id=connect class=button_submit name=connect value=\"" + get_words('_connect') + "\" onclick=wan_connection_type(\"pppoe_connect\")>" +
					"<input type=button id=disconnect class=button_submit name=disconnect value=\"" + get_words('LS315') + "\" onclick=wan_connection_type(\"pppoe_disconnect\")>");
				if (ipv6_network_status_flag == "connect") {
					get_by_id("disconnect").disabled = false;
					get_by_id("connect").disabled = true;
				} else {
					get_by_id("disconnect").disabled = true;
					get_by_id("connect").disabled = false;
				}
			}
		}else if(ipv6_sel_wan =="ipv6_6in4"){
			ipv6_wan_type.innerHTML = get_words('IPV6_TEXT35');
			tr_tunnel_ipv6_addr.style.display="none";		  
			tr_show_button.style.display="none";
			//tr_show_uptime.style.display="none";

		}else if(ipv6_sel_wan =="ipv6_6to4"){
			ipv6_wan_type.innerHTML = get_words('IPV6_TEXT36');
			tr_tunnel_ipv6_addr.style.display="none";		  
			tr_dhcp_pd.style.display="none";
			tr_dhcp_pd_networkassined.style.display="none";
			tr_show_button.style.display="none";
			//tr_show_uptime.style.display="none";

		}else if(ipv6_sel_wan =="ipv6_6rd"){
			ipv6_wan_type.innerHTML = get_words('IPV6_TEXT139');
			tr_wan_ipv6_addr.style.display="none";		  
			tr_dhcp_pd.style.display="none";
			tr_dhcp_pd_networkassined.style.display="none";
			tr_show_button.style.display="none";
			//tr_show_uptime.style.display="none";

		}else if(ipv6_sel_wan =="link_local"){
			tr_network_ipv6_status.style.display="none";
			tr_wan_ipv6_addr.style.display="none";		  
			tr_tunnel_ipv6_addr.style.display="none";		  
			tr_lan_ipv6_addr.style.display="none";
			tr_primary_ipv6_dns.style.display="none";
			tr_secondary_ipv6_dns.style.display="none";			  
			tr_dhcp_pd.style.display="none";
			tr_wan_ipv6_gw.style.display="none";	
			tr_dhcp_pd_networkassined.style.display="none";
			tr_show_button.style.display="none";
			//tr_show_uptime.style.display="none";
			ipv6_wan_type.innerHTML = get_words('IPV6_TEXT37');
		}
	}catch(e){
/*			tr_tunnel_ipv6_addr.style.display="none";		  
			tr_show_button.style.display="none";
			ipv6_wan_ip.innerHTML = "";
			ipv6_wan_type.innerHTML = "";
			ipv6_wan_ip_local.innerHTML = ""; 
			ipv6_lan_ip.innerHTML = "";
			link_local.innerHTML = "";
			ipv6_wan_gw.innerHTML = "";
			dhcp_pd.innerHTML = "";
			dhcp_pd_networkassined.innerHTML = "";
			ipv6_primary_dns.innerHTML= "";
			ipv6_secondary_dns.innerHTML= "";
			network_ipv6_status.innerHTML = "";
*/			wTimesec = 0;
			wan_time = "";	
		return;
	}
	print_hostv6();
	if(cnt != 0)
		cnt = cnt-1;

  if(wTimesec == 0 || connect == 0){
          wan_time = get_words('_NA');
  }else{
          caculate_time();
  }
}
}

	function onPageLoad()
	{
		get_File();
	}

	String.prototype.lpad = function(padString, length) {
	var str = this;
	while (str.length < length)
	str = padString + str;
	return str;
	}

	function caculate_time(){
	
		var wTime = Math.floor(wTimesec);
		var days = Math.floor(wTime / 86400);
			wTime %= 86400;
			var hours = Math.floor(wTime / 3600);
			wTime %= 3600;
			var mins = Math.floor(wTime / 60);
			wTime %= 60;

			wan_time = days + " " + 
				((days <= 1) 
					? get_words('day')
					: get_words('days'))
				+ ", ";
			wan_time += hours + ":" + padout(mins) + ":" + padout(wTime);
		
	}
	function padout(number) {
		return (number < 10) ? '0' + number : number;
	}	
	
	function h2d(h) {return parseInt(h,16);}

	function h2d2(a,b) {return parseInt(a,16)*16+parseInt(b,16);}

	function ipv6_link_local()
	{
		var u32_pf;
		var ary_ip6rd_pf = [0,0];
		var ary_ip4 = wan_addr4.split(".");
		var u32_ip4 = (ary_ip4[0]*Math.pow(2,24)) + (ary_ip4[1]*Math.pow(2,16)) + (ary_ip4[2]*Math.pow(2,8)) + parseInt(ary_ip4[3]);
		u32_pf = parseInt(u32_ip4);
		str_tmp = u32_pf.toString(16).lpad("0",8);
		ary_ip6rd_pf[0] = str_tmp.substr(0,4);
		ary_ip6rd_pf[1] = str_tmp.substr(4,4);

		/*
		**    Date:		2013-02-26
		**    Author:	Silvia Chang, Vic Liu
		**    Reason:   update for 6rd link local addr when cable is unplug
		**    Note:		sync with DIR-820L
		**/
		if((v6Status.connType=="6")||(v6Status.connType=="9") )
		{
			if(v6Status.netState == "Connected")
				$('#tunnel_ipv6_addr').html("fe80::"+ary_ip6rd_pf[0]+":"+ary_ip6rd_pf[1]+"/64");
			else
				$('#tunnel_ipv6_addr').html("");
		}
	}

	//20120906 pascal add 6to4 IANA adress
	function change_6to4_format()
	{
		var address = obj.config_val('igdIPv6Status_IPAddressIANA_');
		var str="::";
		if(address != "")
			{
				var tmpv6ip =address.split(":");
				for(i=4;i<8;i++)
				{
					tmphex = "";
					tmphex = tmpv6ip[i].split("");
					if(tmphex.length == 1)
						str +=h2d(tmphex[0]);
					else
						str +=h2d2(tmphex[0], tmphex[1]);
					if(i<7)
						str +=".";
				}
				str +="/";
				str +=v6Status.WanIANAPrefixLen;
				$('#wan_ipv6_addriana').html(str);
			}
		else
			$('#wan_ipv6_addriana').html("");
	}
	
	function get_v6_gw(is_v4_gw)
	{

		if(is_v4_gw == 0)
		{
			$('#wan_ipv6_gw').html((ipv6_wan_gw == "")?"":filter_ipv6_addr(ipv6_wan_gw));
		}
		else
		{
			var i, tmphex, decvalue;
			$('#wan_ipv6_gw').html("::");
			//v6Status.gw = '';
			if(ipv6_wan_gw != "")
			{
				var tmpv6gw = ipv6_wan_gw.split(":");
				for(i=4;i<8;i++)
				{
					//alert(tmpv6gw[i]);
					tmphex = "";
					tmphex = tmpv6gw[i].split("");
					if(tmphex.length == 1)
						$('#wan_ipv6_gw')[0].innerHTML +=h2d(tmphex[0]);
					else
						$('#wan_ipv6_gw')[0].innerHTML +=h2d2(tmphex[0], tmphex[1]);
					if(i<7)
						$('#wan_ipv6_gw')[0].innerHTML +=".";
				}
			}
		}
	}

	function show_dhcppd(dhcppd_support)
	{	
		if(dhcppd_support){
			if(dhcp_pd_status == "Disabled")
			{
				$('#dhcp_pd').html(get_words('_disabled'));
				$('#dhcp_pd_networkassined').html("");
			}	
			else
			{
				$('#dhcp_pd').html(get_words('_enabled'));
				$('#dhcp_pd_networkassined').html((v6Status.dhcpPdAddr == "")?"":(v6Status.dhcpPdAddr+"/"+v6Status.dhcpPdLen));
			}
		}
		else
		{
			$('#dhcp_pd').html(get_words('_disabled'));
			$('#dhcp_pd_networkassined').html("");
		}
	}

	function set_control_button()
	{
		var wan_type = v6Status.connType;
		var commonAction1 = "do_connect()";
		var commonAction2 = "do_disconnect()";

		var button1_name = get_words('_connect');		//_connect;
		var button2_name = get_words('LS315');	//sd_Disconnect;
		var button1_action = commonAction1;
		var button2_action = commonAction2;
		
		switch(ipv6_sel_wan)
		{
			case "ipv6_autodetect":	//is_autodetect
				break;

			case "ipv6_static":	//is_static
			case "ipv6_6in4":	//is_6in4
			case "ipv6_6to4":	//is_6to4
			case "ipv6_6rd":	//is_6rd
			case "link_local":	//is_linklocal
			//case "8":	//is_dslite
				//return;

			case "ipv6_autoconfig":	//is_autoconf
			case "ipv6_autoconfig_6rd":	//is_autoconf_6rd
				button1_name =  get_words('LS312');		//sd_Renew;
				button2_name = get_words('LS313');	//sd_Release;
				break;
				
			case "ipv6_pppoe":	//is_pppoe
				break;
		}

		$('#ctrl_buttons').html("<input type=\"button\" value=\""+button1_name+"\" name=\"connect\" class=\"button_submit\" id=\"connect\" onClick=\""+button1_action+"\" />&nbsp;<input type=\"button\" value=\""+button2_name+"\" name=\"disconnect\" class=\"button_submit\" id=\"disconnect\" onClick=\""+button2_action+"\" />");
		if(ipv6_network_status_flag=="connect")
			$('#connect').attr('disabled',true);
		else
			$('#disconnect').attr('disabled',true);

		//20120215 silvia add if wantype is autoconf renew always enable.
		if ((ipv6_sel_wan == 'ipv6_autoconfig')||(ipv6_sel_wan=='ipv6_autoconfig_6rd'))
		{
			$('#connect').attr('disabled','');
			//if ((v6Status.wanIANA != "") || ((v6Status.dhcpPdEn == 1) && (v6Status.dhcpPdAddr != "")))
			if (((v6Status.wanIANA == "") && (v6Status.dhcpPdEn == 0))||
			((v6Status.WanIANAPrefixLen == "64") && (v6Status.dhcpPdEn == 0))||
			((v6Status.wanIANA == "") && (v6Status.dhcpPdEn == 1) && (v6Status.dhcpPdAddr == ""))||
			((v6Status.WanIANAPrefixLen == "64") && (v6Status.dhcpPdEn == 1) && (v6Status.dhcpPdAddr == "")))
				$('#disconnect').attr('disabled',true);
			else
				$('#disconnect').attr('disabled','');
		}

		if (login_Info != "w") {
			$('#connect').attr('disabled',true);
			$('#disconnect').attr('disabled',true);
		}
	}

	function do_connect()
	{
		$('#network_ipv6_status').html(get_words('ddns_connecting'));
		$('#connect').attr('disabled',true);
		var event = new ccpObject();
		event.set_param_url('get_set.ccp');
		event.set_ccp_act('doEvent');
		event.add_param_event('CCP_SUB_DOWANCONNECT_V6');
		event.get_config_obj();
	}

	function do_disconnect()
	{
		$('#network_ipv6_status').html(get_words('ddns_disconnecting'));
		$('#disconnect').attr('disabled',true);
		var event = new ccpObject();
		event.set_param_url('get_set.ccp');
		event.set_ccp_act('doEvent');
		event.add_param_event('CCP_SUB_DOWANDISCONNECT_V6');
		event.get_config_obj();
	}

	function print_hostv6()
	{
		var temp_dhcp_list = get_by_id("dhcp_list").value.split("@");
		var str = 	'<tr><td class="CTS">'+get_words('IPV6_TEXT0')+'</td>'+
					'<td class="CTS">'+get_words('YM187')+'</td></tr>';
		
		for (var i = 0; i < temp_dhcp_list.length; i++)
		{	
			var temp_data = temp_dhcp_list[i].split("/");
			if(temp_data.length != 0)
			{		
				if(temp_data.length > 1)
				{
					var temp_ipv6_address = temp_data[2].split(",");
					if(temp_ipv6_address.length > 1)
					{
						for(var j = 0; j < temp_ipv6_address.length;j++)
						{
							if(j > 0)
							{
								temp_data[1]="";
								temp_data[0]="";
							}
							str += '<tr><td class="CELL">' + temp_ipv6_address[j] + '</td><td class="CELL">' + temp_data[1] + '</td></tr>';
						}
					}
					else
						str += '<tr><td class="CELL">' + temp_data[2] + '</td><td class="CELL">' + temp_data[1] + '</td></tr>';
				}
			}
		}
		$('#host6_table').html(str);
	}

	function replace_null_to_none(item){
		if(item=="(null)")
			item="none";
		return item;
	}

 var wan_connection_type = function(conn_type) 
 {
		get_by_id("disconnect").disabled = true;
		get_by_id("connect").disabled = true;
		var wan_url = conn_type+".asp";
		$.ajax({
			type : "GET",
			url : wan_url,
			cache : false,
			success : function(res) {
			}
			
		});
		cnt = 2;
  };

	//20120822 add by Silvia
	function chk_typeAutoConf()
	{
		if(v6Status.connType == "2")
		{
			if ((((v6Status.wanIANA) != '') || ((v6Status.wanAddr) != '')) && (v6Status.gw) != '')
				$('#network_ipv6_status').html(get_words('CONNECTED'));
			else{
				$('#network_ipv6_status').html(get_words('DISCONNECTED'));
				wan_time = get_words('_na');
			}
		}
		if(v6Status.connType == "9")
		{
			if ((((v6Status.wanIANA) != '') || ((v6Status.wanAddr) != '')) && (v6Status.gw) != '')
				$('#network_ipv6_status').html(get_words('CONNECTED'));
			else{
				$('#network_ipv6_status').html(get_words('DISCONNECTED'));
				wan_time = get_words('_na');
			}
		}
	}
$(function(){
	onPageLoad();
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
			<br><script>document.write(model);</script></br>
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
				<script>document.write(menu.build_structure(1,0,1))</script>
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
								<script>show_words('_status');</script>
								</div>
								<div class="hr"></div>
								<div class="section_content_border">
								<div class="header_desc" id="manStatusIntroduction">
									<script>show_words('_help_txt225');</script>
									<p></p>
								</div>

<div class="box_tn">
	<div class="CT"><script>show_words('STATUS_IPV6_DESC_1');</script></div>
	<input type="hidden" id="dhcp_list" name="dhcp_list" value="<!--# exec cgi /bin/ipv6 ipv6_client_list -->" />
	<input type="hidden" id="ipv6_wan_proto" name="ipv6_wan_proto" value="" />
	<input type="hidden" id="ipv6_pppoe_dynamic" name="ipv6_pppoe_dynamic" value="" />
	<table cellspacing="0" cellpadding="0" class="formarea">
	<tr>
		<td class="CL"><script>show_words('IPV6_TEXT29a');</script></td>
		<td class="CR"><span id="connection_ipv6_type"></span></td>
	</tr>
	<tr id="tr_ipv6_conn_time" style="display: none;">
		<td class="CL"><script>show_words('_conuptime')</script></td>
		<td class="CR">
			<span id="ipv6_conn_time" nowrap="">NaN Days, NaN:NaN:NaN</span>&nbsp;<!--span id="ctrl_buttons"></span-->
		</td>
	</tr>
	<tr id="tr_network_ipv6_status">
		<td class="CL"><script>show_words('_netwrk_status_addr');</script></td>
		<td class="CR"><span id="network_ipv6_status">Connected</span></td>
	</tr>
	<tr id="tr_ipv6_show_button">
		<td colspan="2" class="btn_field">
			<span id="ctrl_buttons"></span>
		</td>
	</tr>
	<tr id="tr_wan_ipv6_addr">
		<td class="CL"><script>show_words('TEXT071');</script></td>
		<td class="CR">
			<div id="wan_ipv6_addriana" nowrap></div>
			<div id="wan_ipv6_StaticIP" nowrap></div>
			<div id="wan_ipv6_addr" nowrap></div>
		</td>
	</tr>
	<tr id="tr_tunnel_ipv6_addr">
		<td class="CL"><script>show_words('IPV6_TEXT145')</script></td>
		<td class="CR">
			<span id="tunnel_ipv6_addr" nowrap=""></span>
		</td>
	</tr>
	<tr id="tr_wan_ipv6_gw">
		<td class="CL"><script>show_words('IPV6_TEXT75');</script></td>
		<td class="CR"><span id="wan_ipv6_gw"></span></td>
	</tr>
	<tr id="tr_lan_ipv6_addr">
		<td class="CL"><script>show_words('IPV6_TEXT46');</script></td>
		<td class="CR"><span id="lan_ipv6_addr"></span></td>
	</tr>
	<tr id="tr_lan_ipv6_addr2" style="display:none">
		<td class="CL"></td>
		<td class="CR"><span id="lan_ipv6_addr2" nowrap></span></td>
	</tr>
	<tr id="tr_lan_link_local_ip">
		<td class="CL"><script>show_words('IPV6_TEXT47')</script></td>
		<td class="CR"><span id="lan_link_local_ip" nowrap></span></td>
	</tr>
	<tr id="tr_primary_ipv6_dns">
		<td class="CL"><script>show_words('_dns1');</script></td>
		<td class="CR"><span id="primary_ipv6_dns"></span></td>
	</tr>
	<tr id="tr_secondary_ipv6_dns">
		<td class="CL"><script>show_words('_dns2');</script></td>
		<td class="CR"><span id="secondary_ipv6_dns"></span></td>
	</tr>
	<tr id="tr_dhcp_pd" style="display: none;">
		<td class="CL">DHCP-PD</td>
		<td class="CR"><span id="dhcp_pd" nowrap></span></td>
	</tr>
	<tr id="tr_dhcp_pd_networkassined" style="display: none;">
		<td class="CL"><script>show_words('IPV6_TEXT166')</script></td>
		<td class="CR"><span id="dhcp_pd_networkassined" nowrap></span></td>
	</tr>
	</table>
	<form id="form1" name="form1" method="post" action=""></form>
	<input type="hidden" id="html_response_page" name="html_response_page" value="back.asp" />
	<input type="hidden" id="html_response_return_page" name="html_response_return_page" value="adm_ipv6status.asp" />
	<input type="hidden" id="html_response_message" name="html_response_message" value="WAN is connecting. " />
	<form id="form2" name="form2" method="post" action=""></form>
	<input type="hidden" id="html_response_page" name="html_response_page" value="adm_ipv6status.asp" />
	<input type="hidden" id="html_response_return_page" name="html_response_return_page" value="adm_ipv6status.asp" />
</div>
<!-- LAN IPv6 Computers -->
<div class="box_tn">
	<div class="CT"><script>show_words('TEXT072');</script></div>
	<table id="host6_table" cellspacing="0" cellpadding="0" class="formarea">
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
