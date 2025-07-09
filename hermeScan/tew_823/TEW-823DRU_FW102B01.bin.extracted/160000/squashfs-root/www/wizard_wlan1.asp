﻿<html>
<head>
<link rel="STYLESHEET" type="text/css" href="css_router.css">
<title>D-LINK CORPORATION, INC | WIRELESS ROUTER | HOME</title>
<script language="Javascript" src="md5.js"></script>
<script type="text/javascript" src="/lang_<!--# echo language -->.js"></script>
<script type="text/javascript" src="/lang.js"></script>
<script language="Javascript" src="public.js"></script>
<script language="Javascript">
	var submit_button_flag = 0;
	function mis_length(){
		var mis_length = 8;
		if(parseInt(get_by_id("asp_temp_35").value) < 2){
			mis_length = 13;
		}
		
		return mis_length;
	}
	function max_length(){
		var max_length = 63;
		if(parseInt(get_by_id("asp_temp_35").value) < 2){
			max_length = 26;
		}
		
		return max_length;
	}
	function mis_length_1(){
		var mis_length = 8;
		
		if(parseInt(get_by_id("asp_temp_68").value) < 2){
			mis_length = 13;
		}
		return mis_length;
	}
	function max_length_1(){
		var max_length = 63;
		
		if(parseInt(get_by_id("asp_temp_68").value) < 2){
			max_length = 26;
		}
		return max_length;
	}
	function send_request(){
		var security = "<!--# echo asp_temp_35 -->";
		var security_1 = "<!--# echo asp_temp_68 -->";
		var key1 = get_by_id("key1").value;
		var key2 = get_by_id("key2").value;
		var temp_key_1 = key1;
		var temp_key_2 = key2;
		
		var mis = mis_length();
		var max = max_length();
		var mis_1 = mis_length_1();
		var max_1 = max_length_1();
		
		if(parseInt(get_by_id("asp_temp_35").value) == 1){
			if(key1.length != mis && key1.length != max && key1.length != 5 && key1.length != 10){
	        	alert(IPV6_TEXT2); 
	            return false;
			}else{
				if(key1.length == 5){
					mis = key1.length;
					max = 10;
					get_by_id("asp_temp_50").value = 0;
				}else if(key1.length == 10){
					mis = 5;
					max = key1.length;
					get_by_id("asp_temp_50").value = 0;
				}
				if(key1.length == max){
					for (var j = 0; j < key1.length; j++){
		        		if (!check_hex(key1.substring(j, j+1))){
		        			alert(IPV6_TEXT2);  
		        			return false;
		        		}
					}
				}else{
		        	get_by_id("asp_temp_36").value = "ascii";
		        	temp_key_1 = a_to_hex(get_by_id("key1").value);
		        }
	        }
		}else if(parseInt(get_by_id("asp_temp_35").value) > 1){
			if (key1.length < mis){                   
	        	alert(IPV6_TEXT2);  
				return false;
	        }else if (key1.length > max){
        		if(!isHex(key1)){
        			alert(IPV6_TEXT2);  
        			return false;
        		}
			}
			temp_key_1 = get_by_id("key1").value;
		}
		get_by_id("passpharse1").value = temp_key_1;
		get_by_id("asp_temp_37").value = get_by_id("passpharse1").value;
		
		if (get_by_id("set_5g_security").checked) {
			get_by_id("asp_temp_70").value = get_by_id("asp_temp_37").value;		 	
        }else{				
		
		if(parseInt(get_by_id("asp_temp_68").value) == 1){
				if(key2.length != mis_1 && key2.length != max_1 && key2.length != 5 && key2.length != 10){
	        	alert(IPV6_TEXT2);  
	            return false;
			}else{
				if(key2.length == 5){
						mis_1 = key2.length;
						max_1 = 10;
					get_by_id("asp_temp_50").value = 0;
				}else if(key2.length == 10){
						mis_1 = 5;
						max_1 = key2.length;
					get_by_id("asp_temp_50").value = 0;
				}
					if(key2.length == max_1){
					for (var j = 0; j < key2.length; j++){
		        		if (!check_hex(key2.substring(j, j+1))){
		        			alert(IPV6_TEXT2);  
		        			return false;
		        		}
					}
				}else{
		        	get_by_id("asp_temp_36").value = "ascii";
			        	temp_key_2 = a_to_hex(get_by_id("key2").value);
		        }
	        }
		}else if(parseInt(get_by_id("asp_temp_68").value) > 1){
				if (key2.length < mis_1){                   
		        	alert(IPV6_TEXT2);  
				return false;
		        }else if (key2.length > max_1){
        		if(!isHex(key2)){
        			alert(IPV6_TEXT2);  
        			return false;
        		}
			}
				var temp_key_2 = get_by_id("key2").value;
				get_by_id("passpharse2").value = temp_key_2;
				get_by_id("asp_temp_70").value = get_by_id("passpharse2").value;
		}
			
		}
		
		if(submit_button_flag == 0){
			submit_button_flag = 1;
			get_by_id("form1").submit();
		}
	}
	
	function onPageLoad(){
		set_5g();
		if(parseInt(get_by_id("asp_temp_35").value) < 2){
			get_by_id("show_wep").style.display = "none";
		}else{
			get_by_id("show_psk").style.display = "";
		}
		get_by_id("key1").maxLength = max_length();
		get_by_id("key2").maxLength = max_length();
		
		if(parseInt(get_by_id("asp_temp_35").value) > 1){
			get_by_id("key1").maxLength = 64;
		}
		
		if(parseInt(get_by_id("asp_temp_68").value) > 1){
			get_by_id("key2").maxLength = 64;
		}

		if (get_by_id("asp_temp_37").value != "")
			get_by_id("key1").value = get_by_id("asp_temp_37").value;

		if (get_by_id("asp_temp_70").value != "")
			get_by_id("key2").value = get_by_id("asp_temp_70").value;
	}
	
	function wizard_cancel(){
		if (confirm (_wizquit)) {
			window.location.href="wizard_wireless.asp";
		}
	}
	

	function set_5g()
         {
            if (get_by_id("set_5g_security").checked) {
                get_by_id("show_key2").style.display = "none";
                get_by_id("show_security0").innerHTML = "";
		get_by_id("show_security1").innerHTML = "";
		get_by_id("key2").value = get_by_id("key1").value;
            } else {
                get_by_id("show_key2").style.display = "";
                get_by_id("show_security0").innerHTML = "2.4GHz Band ";
		get_by_id("show_security1").innerHTML = "5GHz Band ";
            }
            
        }
	
        function go_back(){
                get_by_id("html_response_page").value = "wizard_wlan.asp";
                get_by_id("html_response_return_page").value = "wizard_wlan.asp";
                get_by_id("action").value = "response_page";
                get_by_id("form1").submit();
        }
	
</script>
<title></title>
<meta http-equiv=Content-Type content="text/html; charset=UTF-8">
<style type="text/css">
<!--
.style5 {font-size: 10px}
-->
</style>
</head>
<body topmargin="1" leftmargin="0" rightmargin="0" bgcolor="#757575">

<table border=0 cellspacing=0 cellpadding=0 align=center width=838>
<tr>
<td>
<div align=left>
<table width=75% border=0 cellspacing=0 cellpadding=0 align=center height=100>
<tr>
<td bgcolor="#FFFFFF">

  <table id="header_container" border="0" cellpadding="5" cellspacing="0" width="838" align="center">
    <tr>
      <td width="100%">&nbsp;&nbsp;<script>show_words(TA2)</script>: <a href="http://support.dlink.com.tw/"><!--# echo model_number --></a></td>
      <td align="right" nowrap><script>show_words(TA3)</script>: <!--# echo sys_hw_version --> &nbsp;</td>
      <td align="right" nowrap><script>show_words(sd_FWV)</script>: <!--# echo sys_fw_version --><!--# echox sys_region NA --></td>
      <td>&nbsp;</td>
    </tr>
  </table>
  <div align="center"><img src="wlan_masthead.gif" width="836" height="92" align="middle">
  </div>  
</td>
</tr>
</table>
</td>
</tr>
<tr>
  <td bgcolor="#FFFFFF"><p>&nbsp;</p>    
  <form id="form1" name="form1" method="post" action="apply.cgi">
<input type="hidden" id="html_response_page" name="html_response_page" value="wizard_wlan2.asp">
<input type="hidden" id="html_response_return_page" name="html_response_return_page" value="wizard_wlan1.asp">
<input type="hidden" id="reboot_type" name="reboot_type" value="none">
<input type="hidden" id="action" name="action" value="response_page">
<input type="hidden" id="asp_temp_34" name="asp_temp_34" value="<!--# echot asp_temp_34 -->">
<input type="hidden" id="asp_temp_35" name="asp_temp_35" value="<!--# echo asp_temp_35 -->">
<input type="hidden" id="asp_temp_36" name="asp_temp_36" value="hex">
<input type="hidden" id="asp_temp_37" name="asp_temp_37" value="<!--# echo asp_temp_37 -->">
<input type="hidden" id="asp_temp_50" name="asp_temp_50" value="1">

<input type="hidden" id="asp_temp_67" name="asp_temp_67" value="<!--# echot asp_temp_67 -->">
<input type="hidden" id="asp_temp_68" name="asp_temp_68" value="<!--# echo asp_temp_68 -->">
<input type="hidden" id="asp_temp_69" name="asp_temp_69" value="hex">
<input type="hidden" id="asp_temp_70" name="asp_temp_70" value="<!--# echo asp_temp_70 -->">
<input type="hidden" id="asp_temp_71" name="asp_temp_71" value="1">
  <table width="650" border="0" align="center">
    <tr>
      <td><div class=box>
        <h2 align="left"><script>show_words(wwl_title_s4_2)</script></h2>
                <table align="center" class="formarea" summary="wizard wep">
                  <tr> 
                    <td class="box_msg" colspan="2"> <br>
                      <script>show_words(wwl_s4_intro)</script><br> <br> </td>
                  </tr>
                  <tr id="show_psk" style="display:none"> 
                    <td class="box_msg" colspan="2"> <script>show_words(wwl_s4_intro_za1)</script><br> 
                      <br>
                      <script>show_words(wwl_s4_intro_za2)</script><br> <br>
                      <script>show_words(wwl_s4_intro_za3)</script><br> <br> </td>
                  </tr>
                  <tr id="show_wep" style="display:none"> 
                    <td class="box_msg" colspan="2"> <script>show_words(wwl_s4_intro_z1)</script><br> 
                      <br>
                      <script>show_words(wwl_s4_intro_z2)</script><br> <br>
                      <script>show_words(wwl_s4_intro_z3)</script><br> <br>
                      <script>show_words(wwl_s4_intro_z4)</script><br> <br> 
                    </td>
                  </tr>
                  <tr> 
                    <td height="31" colspan="2"> <div align="left"> 
                        <p align="center"> 
                          <input name="set_5g_security" type="checkbox" id="set_5g_security" onClick="set_5g()">
                          <script>show_words(wwl_s4_intro_z5)</script></p>
                      </div></td>
                  </tr>
                  <tr id="show_key1"> 
                    <td width="299"> <div align="right"><b><span id="show_security0"></span> 
                        <script>show_words(wwl_WSP)</script>&nbsp;:&nbsp;</b></div></td>
                    <td width="311"> <input id="key1" name="key1" type="text" size="20" maxlength="20"> 
                      <input type="hidden" id="passpharse1" name="passpharse1" maxlength="64"> 
                  </tr>
                  <tr id="show_key2"> 
                    <td width="299"> <div align="right"><b><span id="show_security1"></span> 
                        <script>show_words(wwl_WSP)</script>&nbsp;:&nbsp;</b></div></td>
                    <td width="311"> <input id="key2" name="key2" type="text" size="20" maxlength="20"> 
                      <input type="hidden" id="passpharse2" name="passpharse2" maxlength="64"> 
                  </tr>
                  <tr> 
                    <td class="box_msg" colspan="2"> <br>
                      <script>show_words(wwl_s4_note)</script><br> <br> </td>
                  </tr>
                  <tr> 
                    <td colspan="2"> <p align="center"> 
                        <input type="button" class="button_submit" id="prev_b" name="prev_b" value="" onclick="go_back();">
                        <input type="button" class="button_submit" id="next_b" name="next_b" value="" onClick="send_request()">
                        <input type="button" class="button_submit" id="cancel_b" name="cancel_b" value="" onclick="wizard_cancel();">
                       	<script>get_by_id("prev_b").value = _prev;</script>
						<script>get_by_id("next_b").value = _next;</script>
						<script>get_by_id("cancel_b").value = _cancel;</script>
                      </p>
			  	</td>
                  </tr>
                </table>
      </div></td>
    </tr>
  </table></form> 
 				 
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
<script>
onPageLoad();
</script>
</body>
</html>
