<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html lang="en-US" xmlns="http://www.w3.org/1999/xhtml" xml:lang="en-US">
<head>
<title>TRENDNET | modelName | Setup | IPv6</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
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
function onPageLoad(){
	var link_local ;
	link_local = document.getElementById("link_local_ip_l").value;
	document.getElementById("lan_link_local_ip").innerHTML= link_local.toUpperCase();

	if("<!--# echo ipv6_ula_enable -->" == 1){
		get_by_id("tr_ula_lan_ip").style.display="";
		get_by_id("ula_lan_ip").innerHTML= "<!--# exec cgi /bin/ipv6 get_ula -->".toUpperCase();
	}else
		get_by_id("tr_ula_lan_ip").style.display="none";
		
	set_form_default_values("form1");
 	var login_who= checksessionStorage();
	if(login_who== "user"){
		DisableEnableForm(document.form1,true);
	}
}

function send_request(){
	var obj = new ccpObject();
	
	obj.set_param_url('apply.cgi');
	obj.set_ccp_act('set');
	obj.add_param_event('adv_ipv6_link_local');
	obj.set_param_next_page('internet_link_local.asp');
	
	obj.add_param_arg('ipv6_wan_proto', get_by_id("ipv6_w_proto").value);
	obj.add_param_arg('reboot_type', 'wan');
  /*
    var is_modify = is_form_modified("form1");
        if (!is_modify && !confirm(up_jt_1+"\n"+up_jt_2+"\n"+up_jt_3)) {
                        return false;
        }
	*/
	var param = obj.get_param();
	
	totalWaitTime = 20; //second
	redirectURL = location.pathname;
	wait_page();
	jq_ajax_post(param.url, param.arg);
    
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
			<br><script>document.write(model);</script></br>
			</td>
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
				<script>document.write(menu.build_structure(1,1,3))</script>
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
								<div class="headerbg" id="setmanTitle">
								<script>show_words('_net_ipv6_01');</script>
								</div>
								<div class="hr"></div>
								<div class="section_content_border">
								<div class="header_desc" id="wanIntroduction">
									<script>show_words('_net_ipv6_02');</script>
									<p></p>
								</div>

							<form id="form1" name="form1" method="post" action="">
							<input type="hidden" id="ipv6_wan_proto" name="ipv6_wan_proto" value="<!--# echo ipv6_wan_proto -->">
							<input type="hidden" maxLength=80 size=80 name="link_local_ip_l" id="link_local_ip_l" value="<!--# exec cgi /bin/ipv6 link_local_ip_l -->">
							<input type="hidden" id="action" name="action" value="adv_ipv6_link_local">
							<input type="hidden" id="page_type" name="page_type" value="IPv6">
								<p>
								
								
								<div class="box_tn">
									<div class="CT"><script>show_words('IPV6_TEXT29a');</script></div>
									<table cellspacing="0" cellpadding="0" class="formarea">
									<tr>
										<td class="CL"><script>show_words('IPV6_TEXT29a')</script></td>
										<td class="CR">
											<select name="ipv6_w_proto" id="ipv6_w_proto" onChange=select_ipv6_wan_page(get_by_id("ipv6_w_proto").value);>
												<option value="ipv6_static"><script>show_words('_net_ipv6_12')</script></option>	<!--Static-->
												<option value="ipv6_autoconfig"><script>show_words('IPV6_TEXT107')</script></option>	<!--Autoconfiguration-->
						<!--					<option value="1"><script>show_words('_help_txt82')</script></option>		Stateless DHCPv6-->
						<!--					<option value="2"><script>show_words('_help_txt84')</script></option>		DHCPv6(Stateful)-->
												<option value="link_local" selected><script>show_words('_help_txt110')</script></option>	<!--Link-Local-->
												<option value="ipv6_pppoe"><script>show_words('_PPPoE')</script></option>			<!--PPPoE-->
												<option value="ipv6_6to4"><script>show_words('IPV6_TEXT36')</script></option>		<!--6to4-->
											</select>
										</td>
									</tr>
									</table>
								</div>
								<br>


								<div class="box_tn" id="lan_ip_setting">		<!--LanIpv6-->
									<div class="CT"><script>show_words('_help_txt96');</script></div>
									<table cellspacing="0" cellpadding="0" class="formarea">
									<tr id="LanIpLinkLocalIp_tr">
										<td class="CL"><script>show_words('IPV6_TEXT47')</script></td>
										<td class="CR">
											<span id="lan_link_local_ip"></span>
										</td>
									</tr>
							     	<tr id="tr_ula_lan_ip" style="display:none">
										<td class="CL"><script>show_words('IPV6_ULA_TEXT08')</script></td>
										<td class="CR">
											<b><span id="ula_lan_ip"></span></b>
										</td>
									</tr>
									</table>
								</div>

								<div class="box_tn">
								<table cellspacing="0" cellpadding="0" class="formarea">
									<tr align="center">
										<td colspan="2" class="btn_field">
											<input name="button" type="button" class="ButtonSmall" id="button" onClick="return send_request()" />
											<script>$('#button').val(get_words('_adv_txt_17'));</script>
											<input name="button2" type="button" class="ButtonSmall" id="button2" onClick="page_cancel('form1', 'internet_ipv6.asp');" />
											<script>$('#button2').val(get_words('ES_cancel'));</script>
										</td>
									</tr>
								</table>
							</div>

							</form>
							<br/>
							</div>
								<!-- End of main content -->

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
	onPageLoad();
</script>
</html>
