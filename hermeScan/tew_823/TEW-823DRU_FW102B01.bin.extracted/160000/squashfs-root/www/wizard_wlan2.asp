<html>
<head>
<link rel="STYLESHEET" type="text/css" href="css_router.css">
<title>D-LINK CORPORATION, INC | WIRELESS ROUTER | HOME</title>
<script type="text/javascript" src="/lang_<!--# echo language -->.js"></script>
<script type="text/javascript" src="/lang.js"></script>
<script type="text/javascript" src="/jquery-1.6.1.min.js"></script>
<script language="JavaScript" src="public.js"></script>
<script language="JavaScript">
var submit_button_flag = 0;
	function show_encryption(){
		var security = get_by_id("asp_temp_35").value;
		var security_1 = get_by_id("asp_temp_68").value;
		get_by_id("show_wpa2_auto").style.display = "";
		get_by_id("show_wpa2_auto_1").style.display = "";
	}
	
	function send_request(){
		var security = get_by_id("asp_temp_35").value;
		var security_1 = get_by_id("asp_temp_68").value;
		//2.4G
		get_by_id("wlan0_security").value= "wpa2auto_psk";
		get_by_id("wlan0_psk_pass_phrase").value= get_by_id("asp_temp_37").value;
		get_by_id("wlan0_psk_cipher_type").value= "both";
		get_by_id("wps_configured_mode").value = 5;
		if(get_by_id("asp_temp_36").value == "ascii"){
			get_by_id("asp_temp_37").value = hex_to_a(get_by_id("asp_temp_37").value);
		}
		
		//5GHz

		get_by_id("wlan1_security").value= "wpa2auto_psk";
		get_by_id("wlan1_psk_pass_phrase").value= get_by_id("asp_temp_70").value;
		get_by_id("wlan1_psk_cipher_type").value= "both";
		get_by_id("wps_configured_mode").value = 5;
		if(get_by_id("asp_temp_69").value == "ascii"){
			get_by_id("asp_temp_70").value = hex_to_a(get_by_id("asp_temp_70").value);
		}
		
		if(submit_button_flag == 0){
			submit_button_flag = 1;
			get_by_id("wps_enable").value = 1;
			get_by_id("wlan0_ssid").value = ssid_decode("asp_temp_34");
			get_by_id("wlan1_ssid").value = ssid_decode("asp_temp_67");
			get_by_id("html_response_return_page").value = "wizard_wireless.asp";
			get_by_id("form1").submit();
		}
	}
	
	function wizard_cancel(){
            if (!is_form_modified("mainform")) {
			if(!confirm(_wizquit)) {
				return false;
			}
	    }
	    window.location.href="wizard_wireless.asp";
	}

	function go_back(){
		var pre_page = get_by_id("html_response_return_page").value;
		get_by_id("html_response_page").value = pre_page;
		get_by_id("html_response_return_page").value = pre_page;
		//get_by_id("wlan0_ssid").value = ssid_decode("asp_temp_34");
		//get_by_id("wlan1_ssid").value = ssid_decode("asp_temp_67");
		get_by_id("action").value = "response_page";
		get_by_id("form1").submit();
	}
</script>
<title></title>
<meta http-equiv=Content-Type content="text/html; charset=UTF-8">
<style type="text/css">
<!--
.style4 {font-size: 10px}
-->
</style>
</head>
<body topmargin="1" leftmargin="0" rightmargin="0" bgcolor="#757575">
<table border=0 cellspacing=0 cellpadding=0 align=center width=838>
<tr>
<td></td>
</tr>
<tr>
<td>
<div align=left>
<table width=838 border=0 cellspacing=0 cellpadding=0 align=center height=100>
<tr>
<td bgcolor="#FFFFFF"><div align=center>
  <table id="header_container" border="0" cellpadding="5" cellspacing="0" width="838" align="center">
    <tr>
      <td width="100%">&nbsp;&nbsp;<script>show_words(TA2)</script>: <a href="http://support.dlink.com.tw/"><!--# echo model_number --></a></td>
      <td align="right" nowrap><script>show_words(TA3)</script>: <!--# echo sys_hw_version --> &nbsp;</td>
      <td align="right" nowrap><script>show_words(sd_FWV)</script>: <!--# echo sys_fw_version --><!--# echox sys_region NA --></td>
      <td>&nbsp;</td>
    </tr>
  </table>
  <div align="center"><img src="wlan_masthead.gif" width="836" height="92" align="middle"></div></td>
</tr>
</table>
</div>
</td>
</tr>
<tr>
  <td bgcolor="#FFFFFF"><p>&nbsp;</p>    
  <table width="650" border="0" align="center">
    <tr>
      <td><div class=box>
              <h2 align="left">
                <script>show_words(_setupdone)</script>
              </h2>
        <div align="left">
                <p class="box_msg">
                  <script>show_words(wwl_intro_end)</script>
                </p>
            <form id="form1" name="form1" method="post" action="apply.cgi">
			<input type="hidden" id="action" name="action" value="wizard_wlan_concurrent">
		  	<input type="hidden" id="html_response_page" name="html_response_page" value="wizard_wireless.asp">
			<input type="hidden" id="html_response_return_page" name="html_response_return_page" value="<!--# echo html_response_return_page -->">
			<input type="hidden" id="reboot_type" name="reboot_type" value="all">
		  	<input type="hidden" id="asp_temp_35" name="asp_temp_35" value="<!--# echo asp_temp_35 -->">
		  	<input type="hidden" id="asp_temp_37" name="asp_temp_37" value="<!--# echo asp_temp_37 -->">
		  	<input type="hidden" id="asp_temp_36" name="asp_temp_36" value="<!--# echo asp_temp_36 -->">
		  	<input type="hidden" id="asp_temp_50" name="asp_temp_50" value="<!--# echo asp_temp_50 -->">
			
			<input type="hidden" id="asp_temp_68" name="asp_temp_68"value="<!--# echo asp_temp_68 -->">
			<input type="hidden" id="asp_temp_69" name="asp_temp_69" value="<!--# echo asp_temp_69 -->">
			<input type="hidden" id="asp_temp_70" name="asp_temp_70" value="<!--# echo asp_temp_70 -->">
			<input type="hidden" id="asp_temp_71" name="asp_temp_71" value="<!--# echo asp_temp_71 -->">
		  
			<input type="hidden" id="wlan0_security" name="wlan0_security">
			<input type="hidden" id="asp_temp_34" name="asp_temp_34" value="<!--# echot asp_temp_34 -->">		  
			<input type="hidden" id="wlan0_ssid" name="wlan0_ssid" value="">		  
			<input type="hidden" id="wlan0_psk_pass_phrase" name="wlan0_psk_pass_phrase">
			<input type="hidden" id="wlan0_psk_cipher_type" name="wlan0_psk_cipher_type">
			
			<input type="hidden" id="wlan1_security" name="wlan1_security">
			<input type="hidden" id="asp_temp_67" name="asp_temp_67" value="<!--# echot asp_temp_67 -->">
			<input type="hidden" id="wlan1_ssid" name="wlan1_ssid" value="">		  
			<input type="hidden" id="wlan1_psk_pass_phrase" name="wlan1_psk_pass_phrase">
			<input type="hidden" id="wlan1_psk_cipher_type" name="wlan1_psk_cipher_type">
			<input type="hidden" id="wps_configured_mode" name="wps_configured_mode">
			<input type="hidden" id="wps_enable" name="wps_enable">
            <div>
              <div id=w2>
                <table width="650" align="center" class="formarea">
                  <tr id="show_wpa2_auto" style="display:none">
                  	<td colspan="3">
                      <table width="650" style="word-break:break-all;" class="box">
                              <tr> 
                                <td width="266" class="duple"><script>show_words(GW_WLAN_RADIO_0_NAME)</script>
                                  <script>show_words(wwl_wnn)</script>
                                  &nbsp;:</td>
                                <td><span id="SSID24G"></span>
                                </td>
                              </tr>
                              <tr> 
                                <td class="duple"><script>show_words(bws_SM)</script>&nbsp;:</td>
                                <td width="372"><script>show_words(KR48)</script></td>
                              </tr>
                              <tr> 
                                <td class="duple"><script>show_words(bws_CT)</script>&nbsp;:</td>
                                <td><script>show_words(bws_CT_3)</script></td>
                              </tr>
                              <tr > 
                                <td class="duple"><script>show_words(_psk)</script>&nbsp;:</td>
                                <td> 
                                  <!--# echo asp_temp_37 -->
                                </td>
                              </tr>
                            </table></td>
			  </tr>
			   <tr id="show_wpa2_auto_1" style="display:none">
                  	<td colspan="3">
                      <table width="650" style="word-break:break-all;" class="box">
                              <tr> 
                                <td width="261" class="duple"><script>show_words(GW_WLAN_RADIO_1_NAME)</script>
                                  <script>show_words(wwl_wnn)</script>
                                  :</td>
                                <td><span id="SSID5G"></span>
                                </td>
                              </tr>
                              <tr> 
                                <td class="duple"><script>show_words(bws_SM)</script>&nbsp;:</td>
                                <td width="377"><script>show_words(KR48)</script></td>
                              </tr>
                              <tr> 
                                <td class="duple"><script>show_words(bws_CT)</script>&nbsp;:</td>
                                <td><script>show_words(bws_CT_3)</script></td>
                              </tr>
                              <tr > 
                                <td class="duple"><script>show_words(_psk)</script>&nbsp;:</td>
                                <td> 
                                  <!--# echo asp_temp_70 -->
                                </td>
                              </tr>
                            </table></td>
                  </tr>
                </table>
                <div align="center"><br>
                        <input type="button" class="button_submit" id="prev_b" name="prev_b" value="" onClick="go_back();">
                        <input type="button" class="button_submit" id="next_b" name="next_b" value="" onClick="send_request()">
                       <input type="button" class="button_submit" id="cancel_b" name="cancel_b" value="" onclick="wizard_cancel();">
                        
						<script>get_by_id("prev_b").value = _prev;</script>
						<script>get_by_id("next_b").value = _next;</script>
						<script>get_by_id("cancel_b").value = _cancel;</script>
                    <br>
                </div>
              </div>
            </div>
          </form>
        </div>
      </div></td>
    </tr>
  </table>
    <p>&nbsp;</p></td>
</tr>
<tr>
  <td bgcolor="#FFFFFF"><table id="footer_container" border="0" cellpadding="0" cellspacing="0" width="836" align="center">
    <tr>
      <td width="125" align="center">&nbsp;&nbsp;<img src="wireless_tail.gif" width="114" height="35"></td>
      <td width="10">&nbsp;</td>
      <td>&nbsp;</td>
      <td>&nbsp;</td>
    </tr>
  </table></td>
</tr>
</table>
<div id="copyright"><script>show_words(_copyright);</script> </div>
</body>
<script>
	show_encryption();
	var tssid_24G = $("#asp_temp_34").val();
	var tssid_5G = $("#asp_temp_67").val();
	$("#SSID24G").text(tssid_24G);
	$("#SSID5G").text(tssid_5G);
</script>
</html>
