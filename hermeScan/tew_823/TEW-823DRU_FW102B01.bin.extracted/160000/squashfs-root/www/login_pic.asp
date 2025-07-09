<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html lang="en-US" xmlns="http://www.w3.org/1999/xhtml" xml:lang="en-US">
<head>
<meta http-equiv="Pragma" content="no-cache" />
<meta http-equiv="Expires" content="-1" />
<title>TRENDNET | modelName | Login</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<link href="/css/style.css" rel="stylesheet" type="text/css" />
<link href="/css/css_router.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="/uk_<!--# echo language -->.js"></script>
<script language="Javascript" src="/public_tew.js"></script>
<script type="text/javascript">
		var def_title = document.title;
		var model = "<!--# echo model_number -->";
		document.title = def_title.replace("modelName", model);
		var submit_button_flag = true;
			var keyStr = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/=";
			
			function encode_base64(psstr)
			{
				return psstr;
			}
			
			function encode64(input)
			{
				var output = "";
				var chr1, chr2, chr3;
				var enc1, enc2, enc3, enc4;
				var i = 0;
				
				do {
						chr1 = input.charCodeAt(i++);
						chr2 = input.charCodeAt(i++);
						chr3 = input.charCodeAt(i++);
						
						enc1 = chr1 >> 2;
						enc2 = ((chr1 & 3) << 4) | (chr2 >> 4);
						enc3 = ((chr2 & 15) << 2) | (chr3 >> 6);
						enc4 = chr3 & 63;
					
						if (isNaN(chr2)) {
							enc3 = enc4 = 64;
						} else if (isNaN(chr3)) {
							enc4 = 64;
						}
						
						output = output + keyStr.charAt(enc1) + keyStr.charAt(enc2) + keyStr.charAt(enc3) + keyStr.charAt(enc4);
					} while (i < input.length);
				
				return output;
			}

			function send_request()
			{
				if(get_by_id("login_n").value=="") {
					alert(get_words('MSG011'));
					return false;
				}
			
				if (!is_ascii(get_by_id("tmp_log_pass").value)) {
					alert(get_words('GW_SMTP_PASSWORD_INVALID'));
					return false;
				}
				if(submit_button_flag) {
					if (typeof(sessionStorage) !== "undefined") {
							sessionStorage.setItem('account', get_by_id("login_n").value);
					}
					
					get_by_id("login_name").value = base64Encode(get_by_id("login_n").value);
					get_by_id("log_pass").value = base64Encode(get_by_id("tmp_log_pass").value);
					get_by_id("graph_code").value = encode_base64(get_by_id("graph_code").value);
					submit_button_flag = false;
				}
				get_by_id("tmp_log_pass").value="";
				return true;
			}
			
			function onPageLoad()
			{
				document.form1.login_n.focus();	
				var graph_auth_state = "<!--# echo graph_auth_state -->";
				var salt = "<!--# echo login_salt -->";
				var graph_en = "<!--# echo graph_enable -->";
				
				if(graph_en !== "open"){ //none
					get_by_id("login1").style.display = "";
					get_by_id("login").style.display = "none";
				}else{ //open
					get_by_id("login1").style.display = "none";
					get_by_id("login").style.display = "";
					get_by_id("login").style.width = "170";
				}
				
				if (graph_auth_state == "2") {//enter wrong graph_code : pop_up "Please enter graphical authentication code"
					alert(get_words('li_alert_4'));
				}
				if (graph_auth_state == "3") {//enter wrong password : pop_up "Authentication Failed"
					alert(get_words('auth') + " " + get_words('_sdi_s9'));
				}
				var graph_counter = <!--# exec cgi /bin/login_fail_counter get -->;
				if(graph_en == "open" || graph_counter >= 10){
					get_by_id("show_graph").style.display = "";
				}				
				<!--# exec cgi /bin/nvram set graph_auth_state=1 -->
			}
			
			function graph_regenerate()
			{
				window.location.href="login_pic.asp";
				window.location.reload();
			}

			function change_lang() {
		   		get_by_id("language").value = get_by_id("lang_select").value;
				var Nlang = get_by_id("language").value;
					send_submit('lang_form');
			}

			function get_lang(){
				 set_selectIndex(get_by_id("language").value, get_by_id("lang_select"));
			}

</script>
</style>
</head>
<body onLoad="onPageLoad();">
<form name="lang_form" id="lang_form" action="/apply_sec.cgi" method=post>
<input type="hidden" id="html_response_return_page" name="html_response_return_page" value="/login_pic.asp">
<input type="hidden" id="html_response_page" name="html_response_page" value="/login_pic.asp">
<input type="hidden" id="language" name="language" value=<!--# echo language -->>
<input type="hidden" id="action" name="action" value="lang">
</form>

<form id="form1" name="form1" method="post" action=/apply_sec.cgi>
<input type="hidden" id="html_response_page" name="html_response_page" value="/login_pic.asp">
<input type="hidden" id="login_name" name="login_name">
<input type="hidden" id="log_pass" name="log_pass">
<input type="hidden" id="action" name="action" value="do_graph_auth">
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
			<td style="width:12px;"><img src="/image/bg_topl_login.gif" width="12" height="12" /></td>
			<td style="width:927px;"><img src="/image/bg_top_login.gif" width="927" height="12" /></td>
			<td style="width:11px;"><img src="/image/bg_topr_login.gif" width="11" height="12" /></td>
		</tr>
		<!-- End of upper frame -->

		<!-- main content -->
		<tr>
			<td style="background-image:url('/image/bg_l_login.gif');background-repeat:repeat-y;vertical-align:top;" width="12">
			<td style="background-image:url('/image/bg_login.gif');background-repeat:repeat-x repeat-y;vertical-align:top;" width="927">

			<table align="center" class="tbl_main" style="width:500px; margin-left:auto; margin-right:auto; margin-top:30px">
			<tr>
			<td valign="top">
				
				<table width="100%" border="0" cellpadding="0" cellspacing="0" class="tabBigTitle">
				<tr>
					<td colspan="2" class="CT" ><img src="image/icons_login.png" style="float:left; margin:0 -8px 0 10px"/>
					<div style="margin:22px 0 0 0; font-size:26px;text-transform:uppercase;"><script>document.write(model);</script> <script>show_words('li_Login')</script></div></td>
				</tr>
				<tr>
					<td class="CL"><strong><script>show_words('_username')</script>&nbsp;&#58;</strong></td>
					<td class="CR"><input type="text" id="login_n" name="login_n" value="" style="width:200px;" onfocus="select();">
					</td>
				</tr>
				<tr>
					<td class="CL"><strong><script>show_words('_password')</script>&nbsp;&#58;</strong></td>
					<td class="CR"><input type="password" id="tmp_log_pass" name="tmp_log_pass" value="" style="width:200px;" onfocus="select();"/>&nbsp;&nbsp;</td>
				</tr>				
				<tr id="show_graph" style="display:none">
					<td colspan="2" class="CELL">
						<b><script>show_words('_authword')</script>&nbsp;</b>
						<input type="password" id="graph_code" name="graph_code" value="" maxlength="8" style="width:200px;" onKeyPress='{ if (event.keyCode == 13) get_by_id("login").click(); }'>
					</td>
				</tr>
				<tr>
					<td class="CL"><strong><script>show_words('_Language')</script>&nbsp;&#58;</strong></td>
					<td class="CR">
						<select id="lang_select" size="1" style="width:200px;" onchange="change_lang()">
							<option value="en" selected="">English</option>
							<option value="sp">Español</option>
							<option value="ge">Deutsch</option>
							<option value="ru">Русский</option>
							<option value="fr">Français</option>
						</select>
						<!--script>$('#lang_select').val(br_lang);</script-->
					</td>
				</tr>
				
				<tr id="show_graph" style="display:none">
				<!--span><input type=password name=graph_code id=graph_code size=20 maxlength=15></span-->
					<td class="CL">
						<table border="0" cellspacing=0 cellpadding=0>
						<tr>
							<!--# exec cgi /bin/graph_auth /tmp/auth.bmp -->
						</tr>
						</table>
					</td>
					<td class="CR">
						<!--input class="ButtonSmall" type="button" name="Refresh" id="refresh" value="" onClick="graph_regenerate();"  style="width:120;" />
						<script>get_by_id("refresh").value = regenerate;</script-->
				</tr>
				</table>
				
			</td>
			</tr>
			</table>

			<br/>
			<div style="margin-left:390px">
				<input class="ButtonSmall" type="submit" id="login" value="" onClick="return send_request()" style="display:none">
				<input class="ButtonSmall" type="submit" id="login1" value="" onClick="return send_request()" style="display:none">
		        <script>get_by_id("login1").value = get_words('_login');</script>
				<script>get_by_id("login").value = get_words('_login');</script>
			</div>
			<br/><br/>
			</td>
			<td style="background-image:url('/image/bg_r_login.gif');background-repeat:repeat-y;vertical-align:top;" width="11">
		</tr>
		<!-- End of main content -->

		<!-- lower frame -->
		<tr>
			<td style="width:12px;"><img src="/image/bg_butl_login.gif" width="12" height="12" /></td>
			<td style="width:927px;"><img src="/image/bg_but_login.gif" width="927" height="12" /></td>
			<td style="width:11px;"><img src="/image/bg_butr_login.gif" width="11" height="12" /></td>
		</tr>
		<!-- End of lower frame -->

		</table>
		
		<!-- footer -->
		<div class="footer">
			<table border="0" cellpadding="0" cellspacing="0" style="width:920px;" class="maintable">
			<tr>
				<td align="left" valign="top" class="txt_footer">
				<br><script>show_words('_copyright');</script></td>
				<td align="right" valign="top" class="txt_footer">
				<br><a href="http://www.trendnet.com/register" target="_blank"><img src="/image/icons_warranty_1.png" style="border:0px;vertical-align:middle;padding-right:10px;" border="0" /><script>show_words('_warranty');</script></a></td>
			</tr>
			</table>
		</div>
		</div>
		<!-- end of footer -->
</form>
</body>

<script>
get_lang();
</script>
</html>
