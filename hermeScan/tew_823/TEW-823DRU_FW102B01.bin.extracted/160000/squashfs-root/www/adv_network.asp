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
	var submit_button_flag = 0;
	
function check_apply(){
	var obj = new ccpObject();
	obj.set_param_url('apply.cgi');
	obj.set_ccp_act('set');
	obj.add_param_event('adv_network');
	obj.set_param_next_page('adv_network.asp');

	get_by_id("upnp_enable").value = get_by_id("upnpEnbl").value;
	get_by_id("wan_port_ping_response_enable").value = get_by_id("icmpEnabled").value;
	obj.add_param_arg('upnp_enable',$("#upnpEnbl").val());				
	obj.add_param_arg('wan_port_ping_response_enable',$("#icmpEnabled").val());				
	obj.add_param_arg('reboot_type', 'application+filter');				

	var paramForm = obj.get_param();
	totalWaitTime = 30; //second
	redirectURL = location.pathname;
	wait_page();
	jq_ajax_post(paramForm.url, paramForm.arg);

/*
	if(submit_button_flag == 0){
			submit_button_flag = 1;
			return true;
		}else{
			return false;
		}
*/
}

function reload_page(){
	window.location.href = "adv_network.asp";
}

function ip_ping(){
	if ($('#ping_ipaddr').val() == ""){
		alert(get_words('tsc_pingt_msg2'));
		return;
	}else{
		$("#textarea").html('');
		disablePinItem(true);
		$('textarea').text('Testing...........\n');
		get_by_id("form2").submit();
	}
}


function disablePinItem(opt){
	$('#pingTestIP').attr('disabled',opt);
	$('#PingButton').attr('disabled',opt);
}
function setValueUPnP(){
	var sel_upnp = "<!--# echo upnp_enable -->";
	$('#upnpEnbl').val(sel_upnp);
}
function setValueWANPing(){
	var sel_wping = "<!--# echo wan_port_ping_response_enable -->";
	$('#icmpEnabled').val(sel_wping);
}
$(function(){
	//UPnP
	setValueUPnP();
	
	//WAN Ping
	setValueWANPing();
	disablePinItem(false);	
	
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
				<script>document.write(menu.build_structure(1,0,3))</script>
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
							<div class="headerbg" id="advancedNetworkTitle">
							<script>show_words('_advnetwork');</script>
							</div>
							<div class="hr"></div>
							<div class="section_content_border">
								<div class="header_desc" id="advancedNetworkTitle">
									<script>show_words('_ADV_NETWRK_DESC');</script>
									<p></p>
								</div>
								<form id="form1" name="form1" method="post" action="apply.cgi">
									<input type="hidden" id="html_response_page" name="html_response_page" value="count_down.asp">
									<input type="hidden" id="html_response_message" name="html_response_message" value=""><script>get_by_id("html_response_message").value = get_words('sc_intro_sv');</script>
									<input type="hidden" id="html_response_return_page" name="html_response_return_page" value="adv_network.asp">
									<input type="hidden" id="action" name="action" value="adv_network">
									<input type="hidden" id="wan_port_ping_response_enable" name="wan_port_ping_response_enable" value="<!--# echo wan_port_ping_response_enable -->">
									<input type="hidden" id="upnp_enable" name="upnp_enable" value="<!--# echo upnp_enable -->">

									<div class="box_tn">
										<div class="CT"><script>show_words('ta_upnp');</script></div>
										<table cellspacing="0" cellpadding="0" class="formarea">
										<tr id="EnableAC">
											<td class="CL"><script>show_words('ta_upnp');</script></td>
											<td class="CR">
												<select id="upnpEnbl" name="upnpEnbl" size="1">
													<option value="0"><script>show_words('_disable');</script></option>
													<option value="1"><script>show_words('_enable');</script></option>
												</select>
											</td>
										</tr>
										</table>
									</div>
									<div class="box_tn">
										<div class="CT"><script>show_words('anet_wan_ping');</script></div>
										<table cellspacing="0" cellpadding="0" class="formarea">
											<tr id="EnableAC">
												<td class="CL"><script>show_words('_wan_ping_respond');</script></td>
												<td class="CR">
													<select id="icmpEnabled" name="icmpEnabled" size="1">
														<option value="0"><script>show_words('_disable');</script></option>
														<option value="1"><script>show_words('_enable');</script></option>
													</select>
												</td>
											</tr>
										</table>
									</div>
									
									<div id="buttonField" class="box_tn">
										<table cellspacing="0" cellpadding="0" class="formarea">
										<tr>
											<td align="center" class="btn_field">
											<input type="button" class="button_submit" id="anbtn1" value="Apply" onclick="check_apply();" />
											<script>$('#anbtn1').val(get_words('_apply'));</script>
											<input type="button" class="button_submit" id="anbtn2" value="Reset" onclick="reload_page();" />
											<script>$('#anbtn2').val(get_words('_reset'));</script>
										</td>
										</tr>
										</table>
									</div>
								</form>
	
		              <form id="form2" name="form2" method="post" action="ping_response.cgi">
									<input type="hidden" id="html_response_page" name="html_response_page" value="adv_network.asp">
		   						<input type="hidden" id="html_response_return_page" name="html_response_return_page" value="adv_network.asp">
									<input type="hidden" name="action" value="ping_test">

									<div class="box_tn">
										<div class="CT"><script>show_words('_ping');</script></div>
										<table cellspacing="0" cellpadding="0" class="formarea">
										<tr>
											<td class="CL"><script>show_words('aa_AT_0');</script></td>
											<td class="CR"><input type="text" name="ping_ipaddr" id="ping_ipaddr" value="<!--# echo ping_ipaddr -->" /></td>
										</tr>
										</table>

										<table cellspacing="0" cellpadding="0" class="formarea">
										<tr align="center">
											<td class="btn_field">
												<input type="button" class="button_submit" id="ping" name="ping" value="Ping" onclick="ip_ping();" />
												<input type="reset" class="button_submit" id="PingReset" value="Reset" onclick="reload_page();" />
												<script>$('#PingReset').val(get_words('_reset'));</script>
											</td>
										</tr>
										</table>

										<table cellspacing="0" cellpadding="0" class="formarea">
										<tr align="center">
											<td colspan="2" class="CELL">
												<textarea cols="76" rows="10" wrap="hard" readonly="1"><!--# echo ping_result --></textarea>
											</td>
										</tr>
										</table>
									</div>
								</form>
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
