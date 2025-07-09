<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html lang="en-US" xmlns="http://www.w3.org/1999/xhtml" xml:lang="en-US">
<head>
<title>TRENDNET | modelName | Wireless 2.4GHz | WDS</title>
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
<script type="text/Javascript" src="/jquery-DOMWindow.js"></script>
<script type="text/javascript" src="js/xml.js"></script>
<script type="text/javascript" src="js/object.js"></script>
<script type="text/javascript" src="js/ddaccordion.js"></script>
<script type="text/javascript" src="js/ccpObject.js"></script>
<script type="text/javascript">   
function apply_site() {
	var site = document.getElementsByName("site");
	var table1 = document.getElementById("siteTable");
	var row_data;
	var index = 0;
	for (index = 0; index < site.length; index++){
		if (site[index].checked){
			row_data = table1.rows[index+1];
		}

	}
	if (row_data != undefined) {
		if (window.opener.document.getElementById("wds_mac_1").value ==="")
			window.opener.document.getElementById("wds_mac_1").value = get_row_data(row_data,1);
		else if (window.opener.document.getElementById("wds_mac_2").value =="")
			window.opener.document.getElementById("wds_mac_2").value = get_row_data(row_data,1);
		else if (window.opener.document.getElementById("wds_mac_3").value == "")
			window.opener.document.getElementById("wds_mac_3").value = get_row_data(row_data,1);
		else if (window.opener.document.getElementById("wds_mac_4").value == "")
			window.opener.document.getElementById("wds_mac_4").value = get_row_data(row_data,1);
	} 
	if (get_by_id("index").value == ""){
		//alert(si_msg_3);
		return;
	}
	window.close();
}
function show_clients(clients)
{
	var temp_scan_list = clients.split("\n");
	var div = "";

	div += "<table id=\"siteTable\" cellspacing=\"0\" cellpadding=\"0\" class=\"formarea\">";
	div += "<tr><td class=\"CL\">"+get_words('_wmode_ssid')+"</td>";
	div += "<td class=\"CR\">"+get_words('_macaddr')+"</td>";
	div += "<td class=\"CR\">"+get_words('_channel')+"</td>";
	div += "<td class=\"CR\">"+get_words('_wifiser_title0')+"</td></tr>";
	for(var tsl_i=0 ; tsl_i < temp_scan_list.length ; tsl_i++) {
		var temp_entry = temp_scan_list[tsl_i].split("\b");
		if ( temp_entry[1] == undefined)
			continue;
		div += "<tr><td class=\"CL\">"+temp_entry[0]+"</td>";
		div += "<td class=\"CR\">"+temp_entry[1]+"</td>";
		div += "<td class=\"CR\">"+temp_entry[2]+"</td>";
		div += "<td class=\"CR\"><input type=radio id=site name=site onClick=select_site("+tsl_i+");></td></tr>";
	}
	$(scan_site).append(div);

}

function getJson()
{
        $.ajax({
                type: "GET",
                url: "wlan_site_survey_24g.js",
                async: true,
                cache: false,
                dataType: "text",
                complete : function(data){
                        try{
                                var obj = data.responseText;
                                show_clients(obj);
                        }catch(e){
                        }
                }
        });
}
getJson();

function select_site(which_row) {
	get_by_id("index").value = which_row;
	//change_color("siteTable", which_row+1);
}

</script>
</head>
<body  topmargin="1" leftmargin="0" rightmargin="0">
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
		<!-- main content -->
			<div class="headerbg" id="basicTitle">
				<script>show_words('help743')</script>
			</div>
		<form id="form1" name="form1" method="post" action="sitesurvey.cgi">
			<input type="hidden" id="index" name="index" value="">
		<div class="hr"></div>
		<div class="section_content_border">
			<div class="header_desc" id="basicIntroduction">
			<p></p>
			</div>
		</div>
		<div id=scan_site class="CT"><script>show_words('_wds_long')</script>
		
<tr> 
<td  height="10" align="center">
	<input name="Apply" type="button" class="box_tn" onClick="apply_site()" value="Connect">
	<input name="button" type="button" class="box_tn" onClick="window.close()" value="Exit">
</td>
</tr>
		</div>
		</table>
	</td>
</tr>
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
	</table>
</div>
</body>
</html>
