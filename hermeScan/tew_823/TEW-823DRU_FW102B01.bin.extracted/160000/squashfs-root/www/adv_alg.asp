<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html lang="en-US" xmlns="http://www.w3.org/1999/xhtml" xml:lang="en-US">
<head>
<title>TRENDNET | modelName | Advanced | ALG</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<link href="/css/style.css" rel="stylesheet" type="text/css" />
<link href="/css/css_router.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="/uk_<!--# echo language -->.js"></script>
<script type="text/javascript" src="public_tew.js"></script>
<script type="text/javascript" src="public_msg.js"></script>
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
	
		set_checked("<!--# echo ipsec_pass_through -->", get_by_id("ipsec"));
		set_checked("<!--# echo alg_rtsp -->", get_by_id("rtsp"));
		set_checked("<!--# echo alg_sip -->", get_by_id("sip"));		
		set_checked("<!--# echo alg_h323 -->", get_by_id("h323"));
		set_checked("<!--# echo alg_ftp -->", get_by_id("ftp"));
		set_checked("<!--# echo alg_tftp -->", get_by_id("tftp"));
		
		//set_form_default_values("form1");
		var login_who= checksessionStorage();
                if(login_who== "user" || "<!--# echo wan_proto -->" == "dslite"){
                        DisableEnableForm(document.form1,true); 
                }
	}
	
function save_status(){
	var obj = new ccpObject();
	
	obj.set_param_url('apply.cgi');
	obj.set_ccp_act('set');
	obj.add_param_event('adv_dmz');
	obj.set_param_next_page('adv_alg.asp');
	
	obj.add_param_arg('alg_rtsp',get_checked_value(get_by_id("rtsp")));
	obj.add_param_arg('alg_sip',get_checked_value(get_by_id("sip")));
	obj.add_param_arg('alg_h323',get_checked_value(get_by_id("h323")));
	obj.add_param_arg('alg_ftp',get_checked_value(get_by_id("ftp")));
	obj.add_param_arg('alg_tftp',get_checked_value(get_by_id("tftp")));
	obj.add_param_arg('ipsec_pass_through',get_checked_value(get_by_id("ipsec")));
  
  // sync pptp l2tp pass through
	obj.add_param_arg('pptp_pass_through',get_checked_value(get_by_id("ipsec")));
	obj.add_param_arg('l2tp_pass_through',get_checked_value(get_by_id("ipsec")));
	
	
	
	var param = obj.get_param();
	
	totalWaitTime = 30; //second
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
				<script>document.write(menu.build_structure(1,5,4))</script>
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
								<div class="headerbg" id="scheduleTitle">
								<script>show_words('_alg_config_l');</script>
								</div>
								<div class="hr"></div>
								<div class="section_content_border">
								<div class="header_desc" id="algIntroduction">
									<script>show_words('_ALG_DESC');</script>
									<p></p>
								</div>

<form method="post" name="schedule" action="/goform/scheduleAdd" onsubmit="return CheckValue();">
<div class="box_tn">
	<div class="CT">
		<script>show_words('_alg_config_l');</script>
	</div>
	<!-- Start of DisableAlgMain -->  
	<table cellspacing="0" cellpadding="0" class="formarea">
	<!-- Start of SpeicalServiceMain1 ~ SpeicalServiceMain10 -->
	    <input type="hidden" id="alg_ipsec" name="alg_ipsec" value="<!--# echo ipsec_pass_through -->">
		<input type="hidden" id="alg_rtsp" name="alg_rtsp" value="<!--# echo alg_rtsp -->">
		<input type="hidden" id="alg_sip" name="alg_sip" value="<!--# echo alg_sip -->">
		<input type="hidden" id="alg_h323" name="alg_h323" value="<!--# echo alg_h323 -->">
		<input type="hidden" id="alg_ftp" name="alg_ftp" value="<!--# echo alg_ftp -->">
		<input type="hidden" id="alg_tftp" name="alg_tftp" value="<!--# echo alg_tftp -->">
		
	<tr id="SpeicalServiceMain1">
		<td class="CTS"><script>show_words('_srvname');</script></td>
		<td class="CTS"><script>show_words('_description');</script></td>
		<td class="CTS"><script>show_words('_enable');</script></td>
	</tr>
	<tr id="SpeicalServiceMain5">
		<td class="CELL"><script>show_words('_streaming_media');</script></td>
		<td class="CELL"><script>show_words('_rtsp_1');</script> </td>
		<td class="CELL"><input type="checkbox" id="rtsp" name="rtsp" value="1"/></td>
	</tr>
	<tr id="SpeicalServiceMain7">
		<td class="CELL"><script>show_words('_streaming_media_voip');</script></td>
		<td class="CELL"><script>show_words('_session_init_protocol_l');</script></td>
		<td class="CELL"><input type="checkbox" id="sip" name="sip"value="1" /></td>
	</tr>
	<tr id="SpeicalServiceMain8">
		<td class="CELL"><script>show_words('_streaming_media_voip');</script></td>
		<td class="CELL"><script>show_words('_h323_l');</script></td>
		<td class="CELL"><input type="checkbox" id="h323" name="h323" value="1"/></td>
	</tr>
	<tr id="SpeicalServiceMain9">
		<td class="CELL"><script>show_words('_file_transfer');</script></td>
		<td class="CELL"><script>show_words('_ftp_l');</script></td>
		<td class="CELL"><input type="checkbox" id="ftp" name="ftp" value="1"/></td>
	</tr>
	<tr id="SpeicalServiceMain10">
		<td class="CELL"><script>show_words('_file_transfer');</script></td>
		<td class="CELL"><script>show_words('_tftp_l');</script></td>
		<td class="CELL"><input type="checkbox" id="tftp" name="tftp" value="1" /></td>
	</tr>
	<tr id="SpeicalServiceMain13">
		<td class="CELL"><script>show_words('vpn_passthrough');</script></td>
		<td class="CELL"><script>show_words('_tnw_pptp');</script>/<script>show_words('_tnw_l2tp');</script>/<script>show_words('help584');</script></td>
		<td class="CELL"><input type="checkbox" id="ipsec" name="ipsec" value="1"/></td>
	</tr>
	<!-- End of SpeicalServiceMain1 ~ SpeicalServiceMain10 -->
	</table>
	<table cellspacing="0" cellpadding="0" class="formarea">
	<tr align="center">
		<td class="btn_field">
			<input type="button" class="button_submit" id="btn_save_status" value="Save Status" onclick="save_status();" />
			<script>$('#btn_save_status').val(get_words('_apply'));</script>
			<input type="reset" class="button_submit" id="btn_cancel" value="Cancel" onclick="window.location.reload()" />
			<script>$('#btn_cancel').val(get_words('_cancel'));</script>
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
<script>
	onPageLoad();
</script>

</html>
