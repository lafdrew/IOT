<html>
<head>
<title>D-LINK CORPORATION, INC | WIRELESS ROUTER | HOME</title>
<meta http-equiv=Content-Type content="text/html; charset=UTF-8">
<LINK href="/form_css.css" type=text/css rel=stylesheet>
<script type="text/javascript" src="/lang_<!--# echo language -->.js"></script>
<script type="text/javascript" src="/lang.js"></script>
</head>
<body>
<script language="JavaScript">
	function hidden_fw_up(){
		parent.document.getElementById("fw_up_1").style.display="none"; 
		parent.document.getElementById("fw_up_2").style.display="none"; 
		parent.document.getElementById("fw_up_3").style.display="none"; 
		parent.document.getElementById("fw_up_4").style.display="none"; 
	}

	function hidden_lp_up(){
		parent.document.getElementById("lp_up_1").style.display="none"; 
		parent.document.getElementById("lp_up_2").style.display="none"; 
		parent.document.getElementById("lp_up_3").style.display="none"; 
		parent.document.getElementById("lp_up_4").style.display="none"; 
	}
	
	function show_fw_up(){
		parent.document.getElementById("fw_up_1").style.display=""; 
		parent.document.getElementById("fw_up_2").style.display=""; 
		parent.document.getElementById("fw_up_3").style.display=""; 
		parent.document.getElementById("fw_up_4").style.display=""; 
	}

	function show_lp_up(){
		parent.document.getElementById("lp_up_1").style.display=""; 
		parent.document.getElementById("lp_up_2").style.display=""; 
		parent.document.getElementById("lp_up_3").style.display=""; 
		parent.document.getElementById("lp_up_4").style.display=""; 
	}

	function check_fw_lp(){
		var new_count = 0;
		/* Firmware Check */
		var result = "<!--# exec cgi /bin/online_firmware_check check_fw -->";
		if(result =="LATEST"){
			parent.document.getElementById("check_result").innerHTML = TEXT045;
			hidden_fw_up();
		}else if(result.length > 0 && result !="ERROR"){
			parent.document.getElementById("check_now_result").style.display ="";

			var fm_info = result.split("+");
			parent.document.getElementById("latest_version").innerHTML = fm_info[0]; //new firmware
			parent.document.getElementById("latest_date").innerHTML = fm_info[1]; //new date

			var site = fm_info[2].split(",");
			var site_url = fm_info[3].split(",");
			var obj = parent.document.getElementById("sel_site");
			var count = 0;

			for (var i = 0; i < site.length; i++){			
				var tmpoption = parent.document.createElement("option");						
				tmpoption.text = site[i];
				tmpoption.value = site_url[i];
				obj.options[count++] = tmpoption;
			}
			show_fw_up();
			new_count++;
		}else{
			//alert("Error contacting the server, please check the Internet connecting status");
			//alert(GW_FW_NOTIFY_FIRMWARE_ERROR);
			hidden_fw_up();
			parent.document.getElementById("check_result").innerHTML = TEXT045;
		}
		/* Language Check */
		var lang_region = "<!--# echo lang_region -->";
		if ("<!--# echo sys_lang_en -->" == "none") {
			hidden_lp_up();
		} else if(lang_region.length >= 2) {
			var result_lp = "<!--# exec cgi /bin/online_firmware_check check_lp -->";
			if(result_lp == "LATEST") {
				if(result == "LATEST")
					parent.document.getElementById("check_result").innerHTML = TEXT045_a;
				else
					parent.document.getElementById("check_result").innerHTML = TEXT045;
				hidden_lp_up();
			} else if(result_lp.length > 0 && result_lp !="ERROR") {
				parent.document.getElementById("check_now_result").style.display ="";
				var lp_info = result_lp.split("+");
				parent.document.getElementById("latest_version_lp").innerHTML = lp_info[0]; //new language pack
				parent.document.getElementById("latest_date_lp").innerHTML = lp_info[1]; //new date

				var site = lp_info[2].split(",");
				var site_url = lp_info[3].split(",");
				var obj = parent.document.getElementById("sel_site_lp");
				var count = 0;

				for (var i = 0; i < site.length; i++){
					var ooption = parent.document.createElement("option");
					ooption.text = site[i];
					ooption.value = site_url[i];
					obj.options[count++] = ooption;
				}
				show_lp_up();
				new_count++;
			} else {
				hidden_lp_up();
				parent.document.getElementById("check_result").innerHTML = TEXT045_a;
			}
		} else {
			hidden_lp_up();
		}

		if(new_count == 2)
			parent.document.getElementById("lp_up_5").style.display=""; 
		else
			parent.document.getElementById("lp_up_5").style.display="none"; 

		if ("<!--# echo sys_lang_en -->" != "none")
			parent.document.getElementById("check_now_c").disabled = false;
		else
			parent.document.getElementById("check_now_b").disabled = false;
	}

check_fw_lp();
</script>
</body>
</html>
