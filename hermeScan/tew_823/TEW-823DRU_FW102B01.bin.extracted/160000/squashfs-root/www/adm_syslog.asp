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

	var DHCPList_word = "";
	var DHCPL_DataArray = new Array();
	
function DHCP_Data(name, ip, mac, Exp_time, onList){
	this.Name = name;
	this.IP = ip;
	this.MAC = mac;
	this.EXP_T = Exp_time;
	this.OnList = onList ;
}

function refresh_log(){
	var temp_entry = get_by_id("total_log").value.split("|syslog|");
	$("#syslog").html('');
	for (var i = 0; i < temp_entry.length; i++){
		var entry = temp_entry[i].split("|");
		var tmp_line = entry[0]+" "+entry[1]+" "+entry[2]+"\r<br/>";
		if(entry.length > 1){
			$("#syslog").append(tmp_line);
		}
	}

}
function clear_log(){
	send_submit("form2");
}

	function toPrefix (bit, padchar, deflen) {
		if (bit.length >= parseInt(deflen))
			return (bit);
		var out = bit
			for (var cnt = bit.length; cnt < parseInt(deflen); cnt++) {
				out = padchar + out;
			}
		return (out);
	}


	function toConvertBit(num){
                var base = 2;
                var tmp = parseInt(num);
                var bitNum = tmp.toString(base);
                bitNum = toPrefix(bitNum, "0", 8);
                return bitNum;
        }

	function convertIPToBit(ipaddr)
	{
		var ip_obj = ipaddr.split(".");
                var ip_bit = "";
                
                for(var i = 0; i < 4; i++){
                        ip_bit += toConvertBit(ip_obj[i]) 
                }
                return ip_bit;

	}
	
	function exclusiveCal(ip, mask)
	{
		var ip_bits = convertIPToBit(ip);
		var mask_bits = convertIPToBit(mask);
		var res = "";
		for(var i = 0; i <ip_bits.length; i++)
                        res += (ip_bits.charAt(i) & mask_bits.charAt(i));
                return res;
	}
	
function check_apply(){
	var obj = new ccpObject();
	obj.set_param_url('apply.cgi');
	obj.set_ccp_act('set');
	obj.add_param_event('tools_syslog');
	obj.set_param_next_page('adm_syslog.asp');
	obj.add_param_arg('reboot_type', 'application');	
	var chk_enable = get_checked_value(get_by_id("logEnabled"));
	
	if(get_by_id("logEnabled").checked){
			var lan_ip = "<!--# echo lan_ipaddr -->";
			var mask = "<!--# echo lan_netmask -->";
			var ip_addr_msg = replace_msg(all_ip_addr_msg, get_words('_ipaddr'));
			var temp_mask_obj = new addr_obj(mask.split("."), subnet_mask_msg, false, false);
			var temp_lan_ip_obj = new addr_obj(lan_ip.split("."), sys_ip_addr_msg, false, false);
			var sys_ip_addr_msg = replace_msg(all_ip_addr_msg,get_words('tsl_SLSIPA'));
			var temp_sys_ip_obj = new addr_obj(get_by_id("sys_server").value.split("."), sys_ip_addr_msg, false, false);

			if(!check_address(temp_sys_ip_obj, temp_mask_obj)){
			    return false;
			}
			/* It just check conflict with lan ip */
			if(!check_LAN_ip(temp_lan_ip_obj.addr, temp_sys_ip_obj.addr, get_words('_ipaddr'))){
				return false;
			}

			var ip_segment = exclusiveCal(lan_ip, mask);
			var sysip_segment = exclusiveCal(get_by_id("sys_server").value, mask);
			if (ip_segment != sysip_segment) {
				alert(get_words('FMT_INVALID_IPRANGE'));
				return false;
			}
		}else{
			get_by_id("sys_server").value = "0.0.0.0";
		}

		//save Syslog settings
		get_by_id("syslog_server").value = chk_enable +"/"+ get_by_id("sys_server").value;
		obj.add_param_arg('syslog_server',$("#syslog_server").val());
		/*
	var temp_dhcp_list = get_by_id("dhcp_list").value.split(",");
	var temp_data = temp_dhcp_list[0].split("/");
	if(temp_data.length > 1){
			get_by_id("syslog_server").value = chk_enable +"/"+ temp_data[1];
			obj.add_param_arg('syslog_server',$("#syslog_server").val());
	}
	*/
	get_by_id("log_system_activity").value = "1";
	obj.add_param_arg('log_system_activity','1');
	log_res_type = "system";
	get_by_id("log_attacks").value = "1";
	obj.add_param_arg('log_attacks','1');
	log_res_type = log_res_type +"| attack";
	get_by_id("log_notice").value = "1";
	obj.add_param_arg('log_notice','1');
	log_res_type = log_res_type +"| notice";
	
	var paramForm = obj.get_param();
	totalWaitTime = 20; //second
	redirectURL = location.pathname;
	wait_page();
	jq_ajax_post(paramForm.url, paramForm.arg);
			
	//get_by_id("form1").submit();

}

function set_lan_dhcp_list(){
	var index = 0;
	var temp_dhcp_list = get_by_id("dhcp_list").value.split(",");
	for (var i = 0; i < temp_dhcp_list.length; i++){	
		var temp_data = temp_dhcp_list[i].split("/");
		if(temp_data.length > 1){
			DHCPL_DataArray[DHCPL_DataArray.length++] = new DHCP_Data(temp_data[0], temp_data[1], temp_data[2], temp_data[3],index);
			DHCPList_word = DHCPList_word+ "<option value=\""+ index +"\">" + temp_data[0] + "</option>";
			index++;
		}
	}
}

function print_dhcp_sel(){
	var print_sel = get_by_id("sys_dhcp").value;
	if(print_sel > -1){
		get_by_id("sys_server").value = DHCPL_DataArray[print_sel].IP;
	}
}

function setValueEnableSystemLog(){
		var syslog_ser = get_by_id("syslog_server").value.split("/");
		set_checked(syslog_ser[0], get_by_id("logEnabled"));
		get_by_id("sys_server").value = syslog_ser[1];
		disable_log();
}

$(function(){
	setValueEnableSystemLog();
	refresh_log();
});

function disable_log(){
	get_by_id("show_sysip").style.display = "none";
  	if (get_by_id("logEnabled").checked){
    	get_by_id("show_sysip").style.display = "";
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
			<td style="background-image:url('/image/bg_l.gif');background-repeat:repeat-y;vertical-align:top;" width="270">
				<div style="padding-left:6px;">
				<script>document.write(menu.build_structure(1,0,2))</script>
				<p>&nbsp;</p>
				</div>
				<img src="/image/bg_l.gif" width="270" height="5" />
			</td>
			<!-- End of left menu -->
			
			<form id="form1" name="form1" method="post" action="apply.cgi">
				<input type="hidden" id="html_response_page" name="html_response_page" value="count_down.asp">
				<input type="hidden" id="html_response_message" name="html_response_message" value="">
				<input type="hidden" id="html_response_return_page" name="html_response_return_page" value="adm_syslog.asp">
				<input type="hidden" id="action" name="action" value="tools_syslog">
				<input type="hidden" id="log_system_activity" name="log_system_activity" value="<!--# echo log_system_activity -->">
				<input type="hidden" id="log_debug_information" name="log_debug_information" value="<!--# echo log_debug_information -->">
				<input type="hidden" id="log_attacks" name="log_attacks" value="<!--# echo log_attacks -->">
				<input type="hidden" id="log_dropped_packets" name="log_dropped_packets" value="<!--# echo log_dropped_packets -->">
				<input type="hidden" id="log_notice" name="log_notice" value="<!--# echo log_notice -->">
				<input type="hidden" id="syslog_server" name="syslog_server" value="<!--# echo syslog_server -->">
				<input type="hidden" name="total_log" id="total_log" value="<!--# exec cgi /bin/get_log_page page -->">
				<input type="hidden" id="dhcp_list" name="dhcp_list" value="<!--# exec cgi /bin/cmo_get_list dhcpd_leased_table -->">

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
								<div class="headerbg" id="syslogTitle">
								<script>show_words('_system_log');</script>
								</div>
								<div class="hr"></div>
								<div class="section_content_border">
								<div class="header_desc" id="syslogIntroduction">
									<script>show_words('_SYSLOG_DESC');</script>
									<p></p>
								</div>

<div class="box_tn">
	<div class="CT" id="syslogSysLog"><script>show_words('_system_log');</script></div>
	<table cellspacing="0" cellpadding="0" class="formarea">
	<tr>
		<td class="CL"><script>show_words('_enable_system_log');</script></td>
		<td class="CR">
			<input type="checkbox" name="logEnabled" id="logEnabled" value="1" onClick="disable_log();"/>
		</td>

	</tr>
	<tr id="show_sysip" style="display:none">
		<td class="CL"><script>show_words('tsl_SLSIPA')</script></td>
                        <td width="70%" class="CR"> 
			<input id="sys_server" name="sys_server" size="16" maxlength="15" type="text">
							&lt;&lt;
                            <select id="sys_dhcp" name="sys_dhcp" size="1" onchange="print_dhcp_sel()">
                              <option selected="selected" value="-1"><script>show_words('bd_CName');</script></option>
                              <script>
                              	set_lan_dhcp_list();
                              	document.write(DHCPList_word);
                              </script>
                            </select>
		         </td>
	</tr>
	<tr>
		<td colspan="2" align="center" class="btn_field">
			<input class="button_submit" type="button" value="" id="syslogApply" name="Apply" onclick="check_apply();" />
			<script>$('#syslogApply').val(get_words('_adv_txt_17'));</script>
		</td>
	</tr>
	</table>
	
	<table cellspacing="0" cellpadding="0" class="formarea">
	<tr>
		<td colspan="2" align="center" class="CELL">
			<textarea style="font-size:9pt" name="syslog" id="syslog" cols="85" rows="15" wrap="hard" readonly="1" TextMode="MultiLine"></textarea>
		</td>
	</tr>
	<tr align="center">
		<td colspan="2" class="btn_field">
		<form method="post" name="SubmitClearLog" action="/goform/clearlog">
			<input class="button_submit" type="button" value="Refresh" id="syslogSysLogRefresh" name="refreshlog" onclick="refresh_log();window.location.href='adm_syslog.asp';" />
			<script>$('#syslogSysLogRefresh').val(get_words('sl_reload'));</script>
			<input class="button_submit" type="button" value="Clear" id="syslogSysLogClear" name="clearlog" onclick="clear_log();" />
			<script>$('#syslogSysLogClear').val(get_words('_clear'));</script>
		</form>
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
	</form>
	</tr>
				<form id="form2" name="form2" method="post" action="log_clear_page.cgi">
					<input type="hidden" id="html_response_page" name="html_response_page" value="count_down.asp">
					<input type="hidden" id="html_response_return_page" name="html_response_return_page" value="adm_syslog.asp">
				</form>
	
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
