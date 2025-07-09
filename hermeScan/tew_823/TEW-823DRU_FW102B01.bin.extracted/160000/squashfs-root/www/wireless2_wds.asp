<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html lang="en-US" xmlns="http://www.w3.org/1999/xhtml" xml:lang="en-US">
<head>
<title>TRENDNET | modelName | Wireless 5GHz | WDS</title>
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
	var menu = new menuObject();
	var model	="<!--# echo model_number -->";
	var def_title = document.title;
	document.title = def_title.replace("modelName", model);

	var val = "<!--# echo wlan1_vap0_security -->";
	val = val.split("_");

	var lanCfg = {
		'enable':     '<!--# echo wlan1_vap0_enable -->',
		'sMode':      val[0],
		'sCipher':    val[1],
		'wdsenable':  '<!--# echo wlan1_wds_enable -->' ,
	};

	var wdsCfg = {
		'apmac':      ['<!--# echo wlan1_wds_mac_1 -->','<!--# echo wlan1_wds_mac_2 -->','<!--# echo wlan1_wds_mac_3 -->','<!--# echo wlan1_wds_mac_4 -->'],
	};

	function chkMACPolicy()
	{
		for (var i = 1; i <= 4 ; i++) {
			var keyvalue = $('#wds_mac_' + i).val();
			if (keyvalue != "")	{
				if (!check_mac(keyvalue)) {
					alert(get_words('LS47'));
					return false;
				}
				if (keyvalue.toUpperCase() == "FF:FF:FF:FF:FF:FF") {
					alert(get_words('_wifiser_mode25'));
					return false;
				}
			}

			for (var j = 1; j < i; j++) {
				var cmpvalue = $('#wds_mac_' + j).val();

				if (cmpvalue == "" && keyvalue == "")
					continue;

				if (keyvalue.toUpperCase() == cmpvalue.toUpperCase())	{
					alert(addstr(get_words('GW_MAC_FILTER_MAC_UNIQUENESS_INVALID'), keyvalue.toUpperCase()));
					return false
				}
			}
		}
		return true;
	}

	function check_apply()
	{
		var basic="";

		if(!chkMACPolicy())
			return false;

		var obj = new ccpObject();
		obj.set_param_url('apply.cgi');
		obj.set_ccp_act('set');
		obj.add_param_event('wds');
		obj.set_param_next_page('wireless_wds.asp');
		//Wireless Distribution System(WDS)
		var wdsEnable = $('#wds_mode').val();
		obj.add_param_arg('wlan1_wds_enable',wdsEnable);
		obj.add_param_arg('reboot_type', 'wireless');
		//obj.add_param_arg('wlanCfg_WDSEnable_','1.2.0.0',wdsEnable);
		//obj.add_param_arg('wlanCfg_WDSEnable_','1.3.0.0',wdsEnable);
		//obj.add_param_arg('wlanCfg_WDSEnable_','1.4.0.0',wdsEnable);

		for (var i = 1; i <= 4; i++) {
			var mac_val = $('#wds_mac_' + i).val();
			obj.add_param_arg('wlan1_wds_mac_' + i, mac_val.toUpperCase());
		}

		var paramForm = obj.get_param();

		totalWaitTime = 20; //second
		redirectURL = location.pathname;
		wait_page();
		jq_ajax_post(paramForm.url, paramForm.arg);
	}

	function setValueWDS()
	{
		var sel_wds = lanCfg.wdsenable;
		$('#wds_mode').val(sel_wds);
		
		if (lanCfg.sMode != "disable" &&
		    (lanCfg.sMode != "wep" || lanCfg.sCipher == "auto")
		   )
			$('#wds_mode').attr('disabled', true);
	}
	function setValueAPMACAddress(){
		if(wdsCfg.apmac!=null){
			for(var i=0;i<4;i++)
			{
				$('#wds_mac_'+(i+1)).val(wdsCfg.apmac[i]);
			}
		}
	}
	function setEventWDS()
	{
		var func = function(){
			var sel_wds = $('#wds_mode option:selected').val();
			if(sel_wds == '0') {
				$('#wds_mac_list_1,#wds_mac_list_2,#wds_mac_list_3,#wds_mac_list_4').hide();
				$('#site_survey').attr("disabled", true);
			} else {
				$('#wds_mac_list_1,#wds_mac_list_2,#wds_mac_list_3,#wds_mac_list_4').show();
				$('#site_survey').attr("disabled", false);
			}
		};
		func()
		$('#wds_mode').change(func);
	}
	
	function site_survey ()
        {
		window.open("sitesurvey_5g.asp","scan","width=1000,height=500,resizable=1,scrollbars=1");
        } 
$(function(){
	if(lanCfg.enable == '1')
		$('#radioOnField').show();
	else
		$('#radioOffField').show();
	//Wireless Distribution System(WDS)
	setValueWDS();
	setValueAPMACAddress();
	setEventWDS();
	
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
			<td align="right" valign="middle" nowrap="nowrap" class="description" style="width:600px;line-height:1.5em;">
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
				<script>document.write(menu.build_structure(1,3,0))</script>
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
									<div class="headerbg" id="basicTitle">
									<script>show_words('help743')</script>
									</div>
									<div class="hr"></div>
									<div class="section_content_border">
									<div class="header_desc" id="basicIntroduction">
										<script>show_words('_desc_wps')</script>
										<p></p>
									</div>

<div id="radioOnField" style="display:none;">
<div class="box_tn">
	<div class="CT"><script>show_words('_wds_long')</script></div>
	<table cellspacing="0" cellpadding="0" class="formarea">
	<tr> 
		<td class="CL"><script>show_words('help743')</script></td>
		<td class="CR">
			<select name="wds_mode" id="wds_mode" size="1">
		<option id="wds_mode_0" value="0"><script>show_words('_disable')</script></option>
		<!--<option id="wds_mode_4" value=4>Lazy Mode</option>
		<option id="wds_mode_2" value=2>Bridge Mode</option>
		<option id="wds_mode_3" value=3>Repeater Mode</option>-->
		<option id="wds_mode_3" value="1"><script>show_words('_enable')</script></option>
			</select>
			<input type="button"  class="box_tn" id="site_survey" value="Site survey" onclick="site_survey();" />
		</td>
	</tr>
	<tr id="wds_mac_list_1" name="wds_mac_list_1" style="display: none;">
		<td class="CL"><script>show_words('_lb_apmacaddr');</script></td>
		<td class="CR"><input type="text" id="wds_mac_1" name="wds_1" size="20" maxlength="17" value="" /></td>
		</tr>
	<tr id="wds_mac_list_2" name="wds_mac_list_2" style="display: none;">
		<td class="CL"><script>show_words('_lb_apmacaddr');</script></td>
		<td class="CR"><input type="text" id="wds_mac_2" name="wds_2" size="20" maxlength="17" value="" /></td>
	</tr>
	<tr id="wds_mac_list_3" name="wds_mac_list_3" style="display: none;">
		<td class="CL"><script>show_words('_lb_apmacaddr');</script></td>
		<td class="CR"><input type="text" id="wds_mac_3" name="wds_3" size="20" maxlength="17" value="" /></td>
	</tr>
	<tr id="wds_mac_list_4" name="wds_mac_list_4" style="display: none;">
		<td class="CL"><script>show_words('_lb_apmacaddr');</script></td>
		<td class="CR"><input type="text" id="wds_mac_4" name="wds_4" size="20" maxlength="17" value="" /></td>
	</tr>
		<input type="hidden" name="wds_list" value="1" />
	</table>
</div>

<div id="buttonField" class="box_tn">
	<table cellspacing="0" cellpadding="0" class="formarea">
	<tr align="center">
		<td colspan="2" class="btn_field">
			<input type="button" class="button_submit" id="btn_apply" value="Apply" onclick="check_apply();" />
			<script>$('#btn_apply').val(get_words('_apply'));</script>
			<input type="reset" class="button_submit" id="btn_cancel" value="Cancel" onclick="window.location.reload()" />
			<script>$('#btn_cancel').val(get_words('_cancel'));</script>
		</td>
	</tr>
	</table>
</div>

</div>

<div id="radioOffField" class="box_tn" style="display: none;">
	<table cellspacing="0" cellpadding="0" class="formarea">
	<tr>
		<td colspan="2" align="center" class="CELL"><font color="red" id="Msg" name="Msg"><script>show_words('_MSG_woff');</script></font></td>
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
