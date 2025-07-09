<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html lang="en-US" xmlns="http://www.w3.org/1999/xhtml" xml:lang="en-US">
<head>
<title>TRENDNET | modelName | Wireless 5GHz | Station List</title>
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

	var lanCfg = {
		'enable':			['<!--# echo wlan1_vap0_enable -->']
	};

function show_wlan_clients(clients) {

        //var table = "";
        //var cnt = 0;

        //if (typeof(clients) == "undefined")
            //    return table;
        var lan_list = $('#lan_list')
        var data = clients.split(",");
        
        for (var i = 0; i < data.length-1; i++) {
                var drow = data[i].split("/");
                var tmp_mac = drow[0];
                var tmp_mode = drow[1];
                var time = drow[2];
                var tmp_rate = drow[3];
                var tmp_signal = drow[4];
                var addr = drow[5];
                
                lan_list.append('<tr><td class="CELL">'+tmp_mac+'</td><td class="CELL">'+tmp_mode+'</td><td class="CELL">'+tmp_rate+'</td><td class="CELL">'+tmp_signal+'</td></tr>');        
        }
}

function getJson() {

        $.ajax({
                type: "GET",
                url: "wlan_client_list.js",
                async: true,
                cache: false,
                dataType: "json",
                complete : function(data){
                        try{
                                var obj = eval("(" + data.responseText + ")");
                                var client5 = "Client5G";
                                show_wlan_clients(obj[client5]);
                        }catch(e){
                        }
                }
        });
} 

$(function(){
	if(lanCfg.enable[0]==1)
		$('#radioOnField').show();
	else
		$('#radioOffField').show();
	//WPS Config
	//setValueLan();
	getJson();
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
				<script>document.write(menu.build_structure(1,3,4))</script>
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
								<script>show_words('_statlst')</script>
								</div>
								<div class="hr"></div>
								<div class="section_content_border">
								<div class="header_desc" id="basicIntroduction">
									<script>show_words('_desc_station_list')</script>
									<p></p>
								</div>

<div id="radioOnField" class="box_tn" style="display: none;">
	<div class="CT"><script>show_words('_wireless_network')</script></div>
	<table id="lan_list" cellspacing="0" cellpadding="0" class="formarea">
	<tr>
		<td class="CTS"><script>show_words('_macaddr');</script></td>
		<td class="CTS"><script>show_words('_mode');</script></td>
		<td class="CTS"><script>show_words('_rate');</script></td>
		<td class="CTS"><script>show_words('_singal');</script></td>
	</tr>
	</table>
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
