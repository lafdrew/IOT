<html>
<head>
<meta http-equiv=Content-Type content="text/html; charset=iso-8859-1">
<title>D-LINK SYSTEMS, INC | WIRED ROUTER | HOME</title>
</head>

<SCRIPT ID=clientEventHandlersJS LANGUAGE=javascript>
	var str="<!--# exec cgi /bin/strip_cmd $ /bin/http_login -->";
	var url = "URL0=" + document.location;

	function applet_install()
	{
		document.Firm.statusMessage("Installing...");
		var rev = document.Firm.install();

		if(rev == -1)
			document.Firm.statusMessage("VCA installation detected on your computer...");
		else if(rev == -2)
			document.Firm.statusMessage("Stop installation");
		else if(rev == -3)
			document.Firm.statusMessage("Stop installation");
		else if(rev == -4) {
			alert("File check error. Please download the file again.");
			document.Firm.statusMessage("Stop installation.");
		} else
		{
			document.Firm.statusMessage("Installation successful");
			var _rev = document.Firm.startParsing(str, url);

			if(_rev == 0) document.Firm.statusMessage("Error: Preparation of connection settings failed.");
			else if(_rev == 1) document.Firm.statusMessage("Install not yet");
			else {
				document.Firm.statusMessage("Preparing connection settings...");
				document.Firm.statusMessage("Preparation of connection settings complete.");
				document.Firm.runUtility();
			}
		}
	}
	
	function check_download_status()
	{
		/*
		rev -6: Already download.
		rev -5: Already installed.
		rev -4: Connection fail
		rev -3: InterruptedException
		rev -2: IOException
		rev -1: Download fail
		rev  0: Initial status
		rev  1: Download success
		rev  2: Download now
		*/

		var rev = document.Firm.get_download_error_code();

		if(rev == 2 || rev == 0) setTimeout("check_download_status()", 300);
		else if(rev == -6) document.Firm.statusMessage("Already downloaded");
		else if(rev == -5) document.Firm.statusMessage("VCA installation detected on your computer...");
		else if(rev == -4) document.Firm.statusMessage("Error: Connection failed");
		//else if(rev == -3) document.Firm.statusMessage("InterruptedException");
		//else if(rev == -2) document.Firm.statusMessage("IOException");
		else if(rev == -3) document.Firm.statusMessage("Error: Unable to complete installation");
		else if(rev == -2) document.Firm.statusMessage("Error: Unable to create folders");
		else if(rev == -1) document.Firm.statusMessage("Error: Download failed");
		else
		{
		 	document.Firm.statusMessage("Download complete");
		 	applet_install();
			return;
		}
	}

	function window_onload() {

		if(navigator.userAgent.toLowerCase().indexOf("windows") < 0) {
			alert("Your operating system is not Windows.");
			return;
		}

		if (document.Firm.checkEnvironment() == 0) {
			alert("The VCA does not support Firefox browser of Windows Vista, please running it through Internet Explorer (IE).");
			return;
		}

		var rev = document.Firm.isInstall();
		var list_url = "<!--# exec cgi /bin/list_url -->";
		var indicate_ver = "<!--# echo sys_vca_version -->";

		if (rev == 1) {
			var apply_to_upgrade = document.Firm.chkVersion(indicate_ver, list_url);

			if (apply_to_upgrade == 1) {
				document.Firm.uninstall();
				rev = 0;
			}
		}

		if (rev == 1)
		{
			document.Firm.statusMessage("VCA installation detected on your computer...");
			var rev = document.Firm.startParsing(str, url);

			if(rev == 0)		document.Firm.statusMessage("Error: Preparation of connection settings failed.");
			else if(rev == 1)	document.Firm.statusMessage("Install not yet");
			else
			{
				document.Firm.statusMessage("Preparing connection settings...");
				document.Firm.statusMessage("Preparation of connection settings complete.");
				document.Firm.runUtility();
			}
		}
		else
		{
			document.Firm.statusMessage("VCA ready to install");
			document.Firm.statusMessage("Download installation file");
//			document.Firm.downloadURL("<!--# exec cgi /bin/firmupdate -d http://wrpd.dlink.com.tw/router/firmware/query.asp?model=DIR-130_Ax_SSLUtilityW -->");
//			document.Firm.downloadURL("<!--# exec cgi /bin/list_url -->");
			document.Firm.downloadURL(list_url);
			check_download_status();
		}
	}
</SCRIPT>


<!--# exec cgi /bin/file_exist "/bin/firmupdate -d http://wrpd.dlink.com.tw/router/firmware/query.asp?model=DIR-130_Ax_SSLApplet" -->


</html>
