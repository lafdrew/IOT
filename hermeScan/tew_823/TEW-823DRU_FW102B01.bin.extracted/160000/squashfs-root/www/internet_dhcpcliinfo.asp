<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html lang="en-US" xmlns="http://www.w3.org/1999/xhtml" xml:lang="en-US">
<head>
<title>TRENDNET | modelName | Network | DHCP Client List</title>
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
	var obj = new ccpObject();
	var menu = new menuObject();
	var DHCPL_DataArray = new Array();
	var login_who= checksessionStorage();
	
function DHCP_Data(name, ip, mac, Exp_time, onList) 
{
	this.Name = name;
	this.IP = ip;
	this.MAC = mac;
	this.EXP_T = Exp_time;
	this.OnList = onList;
}
function set_lan_dhcp_list(){
	var index = 0;
	var temp_dhcp_list = get_by_id("dhcp_list").value.split(",");
	for (var i = 0; i < temp_dhcp_list.length; i++){	
		var temp_data = temp_dhcp_list[i].split("/");
		if(temp_data.length > 1){
			DHCPL_DataArray[DHCPL_DataArray.length++] = new DHCP_Data(temp_data[0], temp_data[1], temp_data[2], temp_data[3], index);
			//DHCPList_word = DHCPList_word+ "<option value=\""+ index +"\">" + temp_data[0] + "</option>";
			index++;
		}
	}
	//get_by_id("dhcp_num").innerHTML = DHCPL_DataArray.length;
	//set_reservation();
}
function revoke(idx){
	get_by_id("revoke_ip").value = DHCPL_DataArray[idx].IP;
	get_by_id("revoke_mac").value = DHCPL_DataArray[idx].MAC;
	send_submit("form2");
}

</script>
</head>
<body>
<div class="wrapper"> 
<table border="0" width="950" cellpadding="0" cellspacing="0" align="center">
 <input type="hidden" id="dhcp_list" name="dhcp_list" value="<!--# exec cgi /bin/cmo_get_list dhcpd_leased_table -->">
 <form id="form2" name="form2" method="post" action="dhcp_revoke.cgi">
<input type="hidden" id="html_response_page" name="html_response_page" value="internet_dhcpcliinfo.asp">
<input type="hidden" id="html_response_return_page" name="html_response_return_page" value="internet_dhcpcliinfo.asp">
<input type="hidden" id="action" name="action" value="lan_revoke">
<input type="hidden" id="revoke_ip" name="revoke_ip">
<input type="hidden" id="revoke_mac" name="revoke_mac">
</form>

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
				<script>document.write(menu.build_structure(1,1,9))</script>
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
								<div class="headerbg" id="inetDhcpTitle">
								<script>show_words('bd_DHCP');</script>
								</div>
								<div class="hr"></div>
								<div class="section_content_border">
								<div class="header_desc" id="inetDhcpIntroduction">
								<script>show_words('_desc_dhcp_client_list');</script>
								<p></p>
								</div>

<div class="box_tn">
	<div class="CT"><script>show_words('_dhcp_clients');</script></div>
	<table id="dhcp_list" border="1" cellspacing="0" cellpadding="0" class="formarea">
	<tr>
		<td class="CTS"><center><script>show_words('_macaddr');</script></center></td>
		<td class="CTS"><center><script>show_words('_ipaddr');</script></center></td>
		<td class="CTS"><center><script>show_words('_lb_expire_in');</script></center></td>
	</tr>
	 <script>
							set_lan_dhcp_list();
							for(i=0;i<DHCPL_DataArray.length;i++){
								document.write("<tr><td><center>"+ DHCPL_DataArray[i].MAC +"</center></td><td><center>"+ DHCPL_DataArray[i].IP +"</center></td><td><center>"+ DHCPL_DataArray[i].EXP_T +"</center></td>");
								/*
								if(login_who== "user"){
									document.write("<td></td>");
								}else{
									document.write("<td><center><a href='javascript:revoke(" + i + ")'>" + bd_Revoke + "</a></center></td>");
								}
								if(login_who== "user"){
									document.write("<td></td>");
								}else{
									document.write("<td><center><a href='javascript:edit_dhcp_client(" + i + ")'>" + bd_Reserve + "</a></center></td></tr>");
								}
								*/
							}
						</script>
	</table>
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
		<td><img src="image/bg_butl.gif" width="270" height="12" /></td>
		<td><img src="image/bg_butr.gif" width="680" height="12" /></td>
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
</table><br>
</div>
</body>
</html>