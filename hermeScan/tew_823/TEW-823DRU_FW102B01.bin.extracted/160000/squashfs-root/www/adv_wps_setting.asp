<html>
<head>
<script type="text/javascript" src="/lang_<!--# echo language -->.js"></script>
<script language="JavaScript" src="/lang.js"></script>
<script language="JavaScript" src="public.js"></script>
<script language="JavaScript" src="public_msg.js"></script>
<script language="JavaScript"> 
var submit_button_flag = 0;
var radius_button_flag = 0;
var radius_button_flag_1 = 0;

	function onPageLoad(){
		set_checked("<!--# echo wps_enable -->", get_by_id("wpsEnable"));
		if ("<!--# echo wps_configured_mode -->" === "5")
		set_checked("<!--# echo wps_lock -->", get_by_id("wpsLock"));
		show_buttons();

		if(get_by_id("wlan0_enable").value == "0" && get_by_id("wlan1_enable").value == "0"){
			DisableEnableForm(form1,true);		
		}
		var login_who= checksessionStorage();
		if(login_who== "user"){
//			DisableEnableForm(document.form1,true);	
			
		}   
		
		/* Gray-out */
		isWpsGrayOut("wpsEnable");

		if ("<!--# echo wps_lock -->" === "1" && "<!--# echo wps_configured_mode -->" === "5" &&
		    "<!--# echo wps_enable -->" === "1"
		) {
			get_by_id("generate_pin").disabled = true;
			get_by_id("reset_pin").disabled = true;
			get_by_id("wpsLock").checked = true;
			get_by_id("wpsLock").disabled = false;
		}

		if (("<!--# echo wlan0_enable -->" === "0" && "<!--# echo wlan1_enable -->" === "0") ||
		    ("<!--# echo wlan0_schedule -->" === "Never" && "<!--# echo wlan1_schedule -->" === "Never")) {
			get_by_id("wpsEnable").checked = false;
			get_by_id("wpsEnable").disabled = true;
			get_by_id("wpsLock").disabled = true;
			get_by_id("generate_pin").disabled = true;
			get_by_id("reset_pin").disabled = true;
			get_by_id("wps_wizard").disabled = true;
		}

	        set_form_default_values("form1");
	}

	function send_request(){	
		//if (!is_form_modified("form1") && !confirm(_ask_nochange)) {
		var wpsEnable_value = get_checked_value(get_by_id("wpsEnable"));
		var Lock_value = get_checked_value(get_by_id("wpsLock"));
		if (!is_wps_modified()) {
			if ((wpsEnable_value == "<!--# echo wps_enable -->") && (Lock_value == "<!--# echo wps_lock -->") && !confirm(_ask_nochange)) {
					return false;
				}
		}
		
		
		if(!(ischeck_wps("auto"))){
				return false;
		}
	
		var wlan0_security= "<!--# echo wlan0_security -->";
		var wlan1_security= "<!--# echo wlan1_security -->";
		var wlan0_vap1_security= "<!--# echo wlan0_vap1_security -->";
		var wlan1_vap1_security= "<!--# echo wlan1_vap1_security -->";
		var wlan0_wep_default_key= "<!--# echo wlan0_wep_default_key -->";
		var wlan1_wep_default_key= "<!--# echo wlan1_wep_default_key -->";
		var wlan0_vap1_wep_default_key= "<!--# echo wlan0_vap1_wep_default_key -->";
		var wlan1_vap1_wep_default_key= "<!--# echo wlan1_vap1_wep_default_key -->";
		
		var security = wlan0_security.split("_");
		var security1 = wlan1_security.split("_");		
		var vap1_security = wlan0_vap1_security.split("_");
		var vap1_security1 = wlan1_vap1_security.split("_");
		
		if(security[1] == "eap" ||security1[1] == "eap" || vap1_security[1] == "eap"  || vap1_security1[1] == "eap" ){				//EAP
			alert(TEXT026);
			return false;
		}
	
		if(security[1] == "share" ||security1[1] == "share" || vap1_security[1] == "share"  || vap1_security1[1] == "share" ){				//EAP
			alert(_wps_albert_1);
			return false;
		}
		
		if((security[0] == "wep" && wlan0_wep_default_key!= "1") 
		|| (security1[0] == "wep" && wlan1_wep_default_key!= "1") 
		|| (vap1_security[0] == "wep" && wlan0_vap1_wep_default_key != "1") 
		|| (vap1_security1[0] == "wep" && wlan1_vap1_wep_default_key != "1")){
				alert(TEXT024);//Can't choose WEP key 2, 3, 4 when WPS is enable
				return false;
		}
	
		<!--save Wi-Fi value-->		
		if(get_by_id("wps_enable").value != get_checked_value(get_by_id("wpsEnable"))){
			get_by_id("wps_enable").value = get_checked_value(get_by_id("wpsEnable"));
			get_by_id("reboot_type").value = "wlanapp";
		}

		get_by_id("wps_lock").value = get_checked_value(get_by_id("wpsLock"));

		if(submit_button_flag == 0){
			submit_button_flag = 1;
			
			return true;
		}else{
			return false;
		}
		
	}

	function is_wps_modified(){ //check wps change or not, false:not change, true:change
		if((get_by_id("wps_enable").value == "<!--# echo wps_enable -->") && 
		   (get_by_id("wps_pin").value == "<!--# echo wps_pin -->")){
			return false;
		}else{
			return true;
		}
	}
	
	// for WPS function 		
	function show_buttons(){
		var enable = get_by_id("wpsEnable");
		if(!enable.checked){
			get_by_id("wpsLock").disabled = true;
		}else if(get_by_id("wpsEnable").checked){
			get_by_id("show_wps_pin").innerHTML = get_by_id("wps_pin").value;
			get_by_id("wpsLock").disabled = false;
		}

		get_by_id("reset_pin").disabled = !enable.checked;
		get_by_id("generate_pin").disabled = !enable.checked;
		get_by_id("wps_wizard").disabled = !enable.checked;			
		
		if(get_by_id("wps_configured_mode").value == "5"){
			lock();
			if (!enable.checked) {
				get_by_id("generate_pin").disabled = true;
				get_by_id("reset_pin").disabled = true;
			}
		}else{
			get_by_id("reset_to_unconfigured").disabled = true;
			get_by_id("wpsLock").disabled = true;
		}

		if (get_by_id("wlan0_enable").value === "0" && 
			get_by_id("wlan1_enable").value === "0") {
			get_by_id("reset_pin").disabled = true;
			get_by_id("generate_pin").disabled = true;
			get_by_id("wps_wizard").disabled = true;			
			get_by_id("wpsLock").disabled = true;
		}
	}
	
	function lock(){
		var wpsLock = get_by_id("wpsLock");
		if(get_by_id("wps_configured_mode").value == "5"){
			get_by_id("generate_pin").disabled = wpsLock.checked;
			get_by_id("reset_pin").disabled = wpsLock.checked;
		}else{
			get_by_id("reset_to_unconfigured").disabled = true;
			get_by_id("generate_pin").disabled = true;
			get_by_id("reset_pin").disabled = true;
		}
	}
	
	function set_pinvalue(obj_value){
		get_by_id("wps_pin").value = obj_value;
		get_by_id("show_wps_pin").innerHTML = obj_value;
	}
	
	function compute_pin_checksum(val)
	{
 		var accum = 0; 
 		var code = parseInt(val)*10;
 
 		accum += 3 * (parseInt(code / 10000000) % 10); 
 		accum += 1 * (parseInt(code / 1000000) % 10); 
 		accum += 3 * (parseInt(code / 100000) % 10); 
 		accum += 1 * (parseInt(code / 10000) % 10);
 		accum += 3 * (parseInt(code / 1000) % 10);
 		accum += 1 * (parseInt(code / 100) % 10);
 		accum += 3 * (parseInt(code / 10) % 10); 
 		accum += 1 * (parseInt(code / 1) % 10); 
 		var digit = (parseInt(accum) % 10);
 		return ((10 - digit) % 10);
	}

	function genPinClicked()
	{
 		var num_str="1";
 		var rand_no;
 		var num;
 
 		while (num_str.length != 7) {
  			rand_no = Math.random()*1000000000; 
  			num = parseInt(rand_no, 10);
  			num = num%10000000;
  			num_str = num.toString();
 		}
 
 		num = num*10 + compute_pin_checksum(num);
 		num = parseInt(num, 10); 
 		get_by_id("wps_pin").innerHTML = num; 
 		get_by_id("localPin").value = num;
	}
	
	function genPinClicked()
	{
 		var num_str="1";
 		var rand_no;
 		var num;
 
 		while (num_str.length != 7) {
  			rand_no = Math.random()*1000000000; 
  			num = parseInt(rand_no, 10);
  			num = num%10000000;
  			num_str = num.toString();
 		} 
 		num = num*10 + compute_pin_checksum(num);
 		num = parseInt(num, 10);  		 
 		get_by_id("wps_pin").value = num;
 		get_by_id("show_wps_pin").innerHTML = num;
	}

	function Unconfigured_button()
    {
        get_by_id("form2").submit();
    }

	
	function ischeck_wps(obj){
		var is_true = false;
		if(get_by_id("wpsEnable").checked){
			if(get_by_id("wlan0_enable").value == "0" && get_by_id("wlan1_enable").value == "0"){
				alert(TEXT028);
				is_true = true;
			}
			}
		if(is_true){
			if(obj == "wps"){
				get_by_id("wpsEnable").checked = false;
			}
			return false;
		}
		return true;
	}
</script>
<link rel="STYLESHEET" type="text/css" href="css_router.css">
<title>D-LINK SYSTEMS, INC | WIRELESS ROUTER | HOME</title>
<meta http-equiv=Content-Type content="text/html; charset=UTF-8">
<style type="text/css">
<!--
.style1 {font-size: 11px}
-->
</style>
</head>
<body topmargin="1" leftmargin="0" rightmargin="0" bgcolor="#757575">
	<table id="header_container" border="0" cellpadding="5" cellspacing="0" width="838" align="center">
     <tr>
        <td width="100%">&nbsp;&nbsp;<script>show_words(TA2)</script>: <a href="http://support.dlink.com.tw/"><!--# echo model_number --></a></td>
        
		<td align="right" nowrap><script>show_words(TA3)</script>: <!--# echo sys_hw_version --> &nbsp;</td>
		<td align="right" nowrap><script>show_words(sd_FWV)</script>: <!--# echo sys_fw_version --><!--# echox sys_region NA --></td>
		<td>&nbsp;</td>
      </tr>
    </table>
	<table id="topnav_container" border="0" cellpadding="0" cellspacing="0" width="838" align="center">
		<tr>
			<td align="center" valign="middle"><img src="wlan_masthead.gif" width="836" height="92"></td>
		</tr>
	</table>
	<table border="0" cellpadding="2" cellspacing="1" width="838" align="center" bgcolor="#FFFFFF">
		<tr id="topnav_container">
			<td><img src="short_modnum.gif" width="125" height="25"></td>
			<script>show_top("adv");</script>
		</tr>
	</table>
	<table border="1" cellpadding="2" cellspacing="0" width="838" height="100%" align="center" bgcolor="#FFFFFF" bordercolordark="#FFFFFF">
		<tr>
		  <td id="sidenav_container" valign="top" width="125" align="right">
				<table border="0" cellpadding="0" cellspacing="0">
					<tr>
						<td id="sidenav_container">
							<div id="sidenav">
								<UL>
									<script>show_left("Advance", 14);</script>
		 			                        </UL>
						  
							</div>
						</td>			
					</tr>
				</table>			
		  </td>
			<input type="hidden" id="wps_default_pin" name="wps_default_pin" value="<!--# exec cgi /bin/wlan wps pin default -->">
			<input type="hidden" id="wps_generate_pin" name="wps_generate_pin" value="<!--# exec cgi /bin/wlan wps pin random -->">

                        <input type="hidden" id="wlan0_security" name="wlan0_security" value="<!--# echo wlan0_security -->">
                        <input type="hidden" id="wlan1_security" name="wlan1_security" value="<!--# echo wlan1_security -->">
                        <input type="hidden" id="wlan0_psk_cipher_type" name="wlan0_psk_cipher_type" value="<!--# echo wlan0_psk_cipher_type -->">
                        <input type="hidden" id="wlan1_psk_cipher_type" name="wlan1_psk_cipher_type" value="<!--# echo wlan1_psk_cipher_type -->">
                        <input type="hidden" id="wlan0_ssid_broadcast" name="wlan0_ssid_broadcast" value="<!--# echo wlan0_ssid_broadcast -->">
                        <input type="hidden" id="wlan1_ssid_broadcast" name="wlan1_ssid_broadcast" value="<!--# echo wlan1_ssid_broadcast -->">

			<form id="form1" name="form1" method="post" action="apply.cgi">
			<input type="hidden" id="action" name="action" value="adv_wps">
				<input type="hidden" id="html_response_page" name="html_response_page" value="back.asp">
				<input type="hidden" id="html_response_message" name="html_response_message" value="">
				<script>get_by_id("html_response_message").value = sc_intro_sv;</script>
				<input type="hidden" id="html_response_return_page" name="html_response_return_page" value="adv_wps_setting.asp">
				<input type="hidden" id="reboot_type" name="reboot_type" value="wlanapp">
				<input type="hidden" id="wlan0_enable" name="wlan0_enable" value="<!--# echo wlan0_enable -->"> 
                <input type="hidden" id="wlan1_enable" name="wlan1_enable" value="<!--# echo wlan1_enable -->"> 
                <input type="hidden" id="wps_pin" name="wps_pin" value="<!--# echo wps_pin -->">
				<input type="hidden" id="wps_configured_mode" name="wps_configured_mode" value="<!--# echo wps_configured_mode -->">
				<input type="hidden" id="mac_filter_type" name="mac_filter_type" value="<!--# echo mac_filter_type -->">
				
                
				<input type="hidden" id="apply" name="apply" value="0">                                    
              <td valign="top" id="maincontent_container">
				<div id="maincontent">
				  <div id="box_header"> 
						<h1><script>show_words(LY2)</script> </h1>
						<p><script>show_words(LY3)</script></p>
                                                                                             
						<input name="button" id="button" type="submit" class=button_submit value="" onClick="return send_request()">
						<input name="button2" id="button2" type="button" class=button_submit value="" onclick="page_cancel('form1', 'adv_wps_setting.asp');">
						<script>check_reboot();</script>
						<script>get_by_id("button").value = _savesettings;</script>
						<script>get_by_id("button2").value = _dontsavesettings;</script>
					</div>
					<div class="box">
					<h2><script>show_words(LW4)</script></h2>
							
          <table cellSpacing=1 cellPadding=1 width=525 border=0>
            <tr> 
              <td class="duple">
                  <script>show_words(_enable)</script> :</td>
              <td width="340">&nbsp; <input name="wpsEnable" type=checkbox id="wpsEnable" value="1" onClick="show_buttons();"> 
                <input type="hidden" id="wps_enable" name="wps_enable" value="<!--# echo wps_enable -->"> 
              </td>
            </tr>
            <tr> 
              <td class="duple">
                 <script>show_words(lock_wps_pin)</script> :</td>
              <td>&nbsp; <input name="wpsLock" type="checkbox" id="wpsLock" value="1" onclick="lock();">
              <input type="hidden" id="wps_lock" name="wps_lock" value="<!--# echo wps_pin -->">
              <input type="hidden" id="disable_wps_pin" name="disable_wps_pin" value=""> </td>
            </tr>
<!--
            <tr> 
              <td class="duple">&nbsp;</td>
              <td>&nbsp;
                <input type="button" name="reset_to_unconfigured" id="reset_to_unconfigured" value="" onClick="Unconfigured_button();"></td>
                <script>get_by_id("reset_to_unconfigured").value = resetUnconfiged;</script>
			</tr>
-->
          </table>
					</div>
					<div class="box"> 
						<h2><script>show_words(LY5)</script></h2>
							
          <table cellpadding="1" cellspacing="1" border="0" width="525">
            <tr> 
              <td class="duple"><script>show_words(LW9)</script> :</td>
              <td>&nbsp;&nbsp;<span id="show_wps_pin"> 
                <!--# echo wps_pin -->
                </span></td>
            </tr>
            <tr> 
              <td class="duple">&nbsp;</td>
              <td width="340">&nbsp; 
                <input type="button" name="generate_pin" id="generate_pin" value="" onclick='genPinClicked();'> 
                <input type="button" name="reset_pin" id="reset_pin" value="" onclick='set_pinvalue(get_by_id("wps_default_pin").value);'></td>
                <script>get_by_id("generate_pin").value = LW11;</script>
				<script>get_by_id("reset_pin").value = LW10;</script>
			</tr>
           
          </table>
					</div>
							<div class="box"> 
						<h2><script>show_words(LY10)</script></h2>
		
          <br>
				            
          <table cellpadding="1" cellspacing="1" border="0" width="525">
            <tr> 
              <td class="duple">&nbsp;</td>
              <td width="340">&nbsp;<input name="wps_wizard" id="wps_wizard" type="button" class="button_submit" value="" onClick="window.location.href='wps_wifi_setup.asp'"></td>
              <script>get_by_id("wps_wizard").value = LW13;</script>
			</tr>
          </table>
				</div>
					
					</form>
					
					<form id="form2" name="form2" method="post" action="restore_default_wireless.cgi">
					<input type="hidden" id="html_response_page" name="html_response_page" value="count_down.asp">
					<input type="hidden" id="html_response_message" name="html_response_message" value=""><script>get_by_id("html_response_message").value = sc_intro_sv;</script>
					<input type="hidden" id="html_response_return_page" name="html_response_return_page" value="wireless.asp">
					<input type="hidden" id="action" name="action" value="restore_default_wireless">
					<input type="hidden" id="reboot_type" name="reboot_type" value="wireless">
					<input type="hidden" id="mac_filter_type" name="mac_filter_type" value="<!--# echo mac_filter_type -->">
					</form>


            <td valign="top" width="150" id="sidehelp_container" align="left">
				<table cellSpacing=0 cellPadding=2 bgColor=#ffffff border=0>
                  <tbody>
                    <tr>
                     	<td id=help_text><strong><script>show_words(_hints)</script></strong></b>&hellip;</strong>                        
						<p><script>show_words(LW14)</script></p>
						<p><script>show_words(LW15)</script></p>
						<p><script>show_words(LW16)</script></p>
						<p><script>show_words(LW17)</script></p><p><a href="support_adv.asp#Protected_Setup" onclick="return jump_if();"><script>show_words(_more)</script>&hellip;</a></p>
						</td>
                    </tr>
                  </tbody>
				</table>
            </td>
		</tr>
	</table>
	<table id="footer_container" border="0" cellpadding="0" cellspacing="0" width="838" align="center">
		<tr>
			<td width="125" align="center">&nbsp;&nbsp;<img src="wireless_tail.gif" width="114" height="35"></td>
			<td width="10">&nbsp;</td>
			<td>&nbsp;</td>
		</tr>
	</table>
<script>
onPageLoad();
</script>    
<br>
<div id="copyright"><script>show_words(_copyright);</script></div>
<br>
</body>
<script>reboot_needed(left["Advance"].link[14]);</script>
</html>
