<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
<head>
<meta http-equiv="content-type" content="text/html; charset=utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE8"/>

<title>TRENDnet | TEW-818DRU | <!--#tr id="project.desc"-->AC1900 Dual Band Wireless Router<!--#endtr--></title>
<link href="./style/style.css" rel="stylesheet" type="text/css" media="screen" />
<style>
html
{
	background: #000 url('./images/bg4.gif') top center;
}

.dialog2 .content,
.dialog2 .t,
.dialog2 .b,
.dialog2 .b div {
 background:transparent url('./images/bg_main3.png') no-repeat top right;
}

.CT {
	background: #323339 url('./images/cell-1.gif') no-repeat top left;
	border-width: 1px;
	padding: 8px;
	border-style: solid;
	border-color: #191919;
	font: bold 25px verdana,arial,sans-serif;
	color: #FFF;
	text-shadow: 0px 1px 1px #555, 0px -1px 1px #000;
	text-transform:uppercase;
}

.CTS {
	background: #323339 url('./images/cell-1.gif') no-repeat top left;
	border-width: 1px;
	padding: 8px;
	border-style: solid;
	border-color: #191919;
	font: normal 14px verdana,arial,sans-serif;
	color: #EEE;
}

.CL {
	background: #47494f url('./images/cell-1.gif');
	border-width: 1px;
	padding: 6px 6px 10px 6px;
	border-style: solid;
	border-color: #191919;
	font: normal 14px verdana,arial,sans-serif;
	min-width:120px;
	width:120px;
}
.CR {
	background: #47494f  url('./images/cell-1.gif');
	border-width: 1px;
	padding: 10px 6px 10px 6px;
	border-style: solid;
	border-color: #191919;
	font: 14px verdana,arial,sans-serif;
	width:75%;
}
	
.button1 {
	color:#FFF;
	font:normal 16px tahoma,arial,sans-serif;
	padding:3px 8px 6px 8px;
	background:  #00aff0 url('./images/overlay.png') repeat-x center left;
	border:1px solid #63cef6;
	-moz-border-radius:4px;-webkit-border-radius:4px;border-radius:4px;
	border-bottom:1px solid #63cef6;
	-moz-box-shadow:inset 0 1px 0 rgba(22,142,199,0.5);-webkit-box-shadow:inset 0 0 0 rgba(22,142,199,0.5);box-shadow:inset 0 0 0 rgba(22,142,199,0.5);
	cursor:pointer;
	height:30px;
	min-width:100px;
	width:100px;
	margin:10px 20px 20px 0px;
}

.button1:hover {
	color:#FFF;
	background: #00aff0 url('./images/but_mouseover.png') repeat-x top center ;
	border:1px solid #3e97ce;
}

.button1:active {
	position:relative;
	top:0px;
	border:1px solid #3e97ce;
	background: #00aff0 url('./images/but_mouseover2.png') repeat-x top center;
	color:#FFF;
}

.button1_NoWidth {
	color:#FFF;
	font:normal 16px tahoma,arial,sans-serif;
	padding:3px 8px 6px 8px;
	background:  #00aff0 url('./images/overlay.png') repeat-x center left;
	border:1px solid #63cef6;
	-moz-border-radius:4px;-webkit-border-radius:4px;border-radius:4px;
	border-bottom:1px solid #63cef6;
	-moz-box-shadow:inset 0 1px 0 rgba(22,142,199,0.5);-webkit-box-shadow:inset 0 0 0 rgba(22,142,199,0.5);box-shadow:inset 0 0 0 rgba(22,142,199,0.5);
	cursor:pointer;
	height:30px;
	min-width:100px;
	margin:10px 20px 20px 0px;
}

.button1_NoWidth:hover {
	color:#FFF;
	background: #00aff0 url('./images/but_mouseover.png') repeat-x top center ;
	border:1px solid #3e97ce;
}

.button1_NoWidth:active {
	position:relative;
	top:0px;
	border:1px solid #3e97ce;
	background: #00aff0 url('./images/but_mouseover2.png') repeat-x top center;
	color:#FFF;
}

.tbl_main {
	margin:15px 0;
}

.input {
	width:97%;
	height:25px;
	font: normal 16px verdana,arial,sans-serif;
	padding:0px 0px 0px 5px
}
</style>

<script type="text/javascript" src="../scripts/func.js"></script>
<script language="JavaScript" type="text/javascript">

function doLangSet() {
	document.getElementById("redirect_url").value = location.pathname;
	document.Lang.submit();
}

function getHTTPObject() {
  var xmlhttp = false;

  if (window.XMLHttpRequest) {  // code for IE7+, Firefox, Chrome, Opera, Safari
    xmlhttp = new XMLHttpRequest();
  } else {                      // code for IE6, IE5
    try {
			xmlhttp = new ActiveXObject("Msxml2.XMLHTTP");
    } catch (e) {
        try {
			xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
        } catch (e) {}
    }
  }
  return xmlhttp;
}

//Griffin -language switch
function selectLanguagefunc(value) {
	document.getElementById("langSelectionOnly").value = value;
	document.language_select.submit();
}

function press_enter(e) {
	if (e.keyCode==13) {
		e.preventDefault ? e.preventDefault() : e.returnValue = false;
		return login();
	}
	return true;
}

function login() {
    var user = document.getElementById("userName").value;
    var password = document.getElementById("userPassword").value;
    var selectLanguage = document.getElementById("langSelection").value;
    
    if (user == "")
        user = "emptyuserrrrrrrrrrrr";
    if (password == "")
        password = "emptypasswordddddddd";

    var xmlHttpRequest = getHTTPObject();
    xmlHttpRequest.onreadystatechange = function () {listenResponse(xmlHttpRequest);};
    xmlHttpRequest.open("get", "login.cgi?langSelection=" + selectLanguage, false, user, password);
	//Tom.Hung 2013-5-30, fix opera can't login
	if(window.opera) {
		var WizardConfigured = "<% nvram_get("WizardConfigured"); %>";
		var pname;
	
		if (WizardConfigured != "1") {
			pname = "/wizard/wizard_internet.asp"
		} else {
			pname = "/basic/home.asp";
		}
		//http://user:password@ip/adm/status.asp
		var redirect = "http://" + user + ":" + password + "@" + window.location.host + pname;
		window.location.href = redirect;
		return true;
	}
	//Tom.Hung 2013-5-30 end
    xmlHttpRequest.send("");

    return true;
}

function listenResponse(xmlHttpRequest)
{
	if (xmlHttpRequest.readyState == 4) {
		if (xmlHttpRequest.status == 200) {
			var url=window.location.toString();
			var str_value = url.split("l");
			//var lanip = "< nvram_get("lan_ipaddr"); %>";
		    //window.location = window.location.protocol + "//" + lanip;
			window.location = str_value[0];//Griffin - To update for follow enter IP or direct to incorrect IP while enter by WAN.
		} else {
		    Alert.render("<!--#tr id="login.alert.2"-->Incorrect username and/or password!<!--#endtr-->");
		}
	}
}

function pageLoad()
{
    // Language default selection
    var langset = "<% nvram_get("Language"); %>";
    var lang = (langset=="")? "EN":langset;
	var lang_element = document.getElementById("langSelection");
	for (var i=0; i<lang_element.options.length; i++) {
		if (lang == lang_element.options[i].value) {
			lang_element.options.selectedIndex = i;
			break;
		}
	}
	//Tom.Hung 2013-7-19, Focus on username when open this page
	document.getElementById("userName").focus();
	//Tom.Hung 2013-7-19 end
}
</script>

</head>
<body onload="pageLoad();">
<div id="dialogoverlay" style="display: none;"></div>
<div id="dialogbox" style="display: none;">
<table class="tbl_main" style="color: #FFF;" width="420px">
	<tr>
		<td class="CT" height="20px"></td>
	</tr>
	<tr style="vertical-align: middle;">
		<td class="CR" style="background: #4F5158" align="center">
			<br><span id="dialogboxbody">&nbsp;</span><br><br>
			<span id="dialogboxfoot"></span>
		</td>
	</tr>
</table>
</div>
<div class="wrapper"> 
<table width="100%" border="0"  cellpadding="0" cellspacing="0" >
  <tr>
    <td class="header">
		<table width="100%" border="0" cellpadding="0" cellspacing="0">
		  <tr>
			<td class="header_1">
				<table border="0" cellpadding="0" cellspacing="0"  style="position: relative; width: 920px; top: 8px;" class="maintable">
				  <tr >
					<td  valign="top"><img src="./images/logo.png" ></td>
					<td align="right"  valign="middle" nowrap="nowrap" class="description" style="width:600px; line-height:1.5em">
					<!--#tr id="project.desc"-->AC1900 Dual Band Wireless Router<!--#endtr--><br>TEW-818DRU</td>
				  </tr>
				</table>
			</td>
		  </tr>
		</table>
    </td>
  </tr>
  	<td>
<div class="dialog2" style="margin-left:auto; margin-right:auto;">
<div class="content">
  <!--START MAIN TABLE -->
  <table border="0" cellpadding="0" cellspacing="0"  style="width:1000px;">
      <tr >
        <td valign="top">
        	<!--START LEFT NAVIGATION -->
			<!--END LEFT NAVIGATION --> 
			<form method="post" name="mainform">
			  <table align="center" class="tbl_main" style="width:<!--#tr id="login.width"-->500px<!--#endtr-->; margin-left:auto; margin-right:auto; margin-top:80px">
				<tr>
				  <td colspan="2" class="CT" ><img src="./images/icons_login.png" style="float:left; margin:0 -8px 0 10px"/>
					<div style="margin:22px 0 0 0">&nbsp;&nbsp;<!--#tr id="login.tag.2"-->TEW-818DRU LOGIN<!--#endtr--></div></td>
				</tr>
				<tr>
				  <td class="CL" ><b><!--#tr id="user.name"-->User Name<!--#endtr-->:</b></td>
				  <td class="CR"><label for="UserName"></label>
				  <input class="input" type="text" id="userName" name="userName" onkeydown="return press_enter(event);"></td>
				</tr>
				<tr>
				  <td class="CL" ><b><!--#tr id="password"-->Password<!--#endtr-->:</b></td>
				  <td class="CR"><input class="input" type="password" id="userPassword" name="userPassword" onkeydown="return press_enter(event);"></td>
				</tr>
				<tr>
				  <td class="CL" ><b><!--#tr id="login.tag.5"-->Language<!--#endtr-->:</b></td>
				  <td class="CR">
					<select class="input" name="langSelection" id="langSelection" style="width: 98%" onChange="selectLanguagefunc(this.value);">
						<option value="EN" selected="selected">English</option>
						<option value="DE">Deutsch</option>
						<option value="FR">Fran&#231;ais</option>
						<option value="ESP">Espa&#241;ol</option>
						<option value="RU">P&#1091;&#1089;&#1089;&#1082;&#1080;&#1081;</option>
					</select>
					</td>
				</tr>
			  </table>
			  <div style="position:relative; left:390px">
			  <input name="XXXXXXXXx" type="button" class="<!--#tr id="buttonWidth"-->button1<!--#endtr-->" value="<!--#tr id="login.tag.1"-->Login<!--#endtr-->" onclick="return login();"/>
			  </div>
			</form>
        	<p>&nbsp;</p>
			<form method="post" name="language_select" action="/autoLang.cgi" >
				<input type="hidden" name="token" value="<% genToken(); %>">
				<input type="hidden" name="langSelectionOnly" id="langSelectionOnly" value="" />
			</form>
		</td>
     </tr>
  </table>
  <!--END MAIN TABLE -->
</div>
<div style="background-color: transparent;background-attachment: scroll;background-image: url(./images/bg_main3.png); background-position: right bottom; height: 50px;"><div></div></div>
</div>
    </td>
  </tr>
</table>
</div>
<div class="footer" >
  <table border="0" cellpadding="0" cellspacing="0"  style="position:static; width:940px; margin:20px auto 0px auto ">
    <tr >
    <td class="txt_footer"><!--#tr id="bottom.copyright"-->Copyright &copy; 2014 TRENDnet. All Rights Reserved.<!--#endtr--></td>
		<td align="right" class="txt_footer">
			<img src="./images/icons_warranty_1.png"><a href="http://www.trendnet.com/register" target="_blank" style="margin: 0 0 0 10px;line-height:25px;vertical-align: top;"><!--#tr id="bottom.product.registration"-->Product Warranty Registration<!--#endtr--></a>&nbsp;&nbsp;&nbsp;
		</td>
    </tr>
  </table>
</div>

</body>
</html>
