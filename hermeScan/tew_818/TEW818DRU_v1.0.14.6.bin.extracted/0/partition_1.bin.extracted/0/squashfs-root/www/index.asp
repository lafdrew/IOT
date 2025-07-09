<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="en-US" xml:lang="en-US">
<head>
<meta http-equiv="content-type" content="text/html; charset=utf-8">
<title><% getProjectName(); %></title>
<script>
function wizard_check() {
	var WizardConfigured = "<% nvram_get("WizardConfigured"); %>";
	var wanport = "<% nvram_get("http_wanport"); %>";
	var lanip = "<% nvram_get("lan_ipaddr"); %>";
	var lan1ip = "<% nvram_get("lan1_ipaddr"); %>";
	var pname;

	/*if (WizardConfigured != "1") {
		pname = "/wizard/wizard.asp"
	} else*/ {
		pname = "/basic/home.asp";
	}

	if(wanport != "" && window.location.port == wanport) {
		window.location = window.location.protocol + "//" + window.location.host + pname;
	} else {
		if(window.location.hostname == lan1ip) {
			window.location = window.location.protocol + "//" + lan1ip + pname;
		} else {
			window.location = window.location.protocol + "//" + lanip + pname;
		}
	}
}
</script>
</head>

<body onload="wizard_check();">
</body>
</html>