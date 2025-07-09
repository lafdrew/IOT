<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en"><!-- InstanceBegin template="/Templates/advanced.dwt" codeOutsideHTMLIsLocked="false" -->
<head>
<meta http-equiv="content-type" content="text/html; charset=utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE8"/>

<title>TRENDnet | TEW-818DRU | <!--#tr id="project.desc"-->AC1900 Dual Band Wireless Router<!--#endtr--></title>
<!-- InstanceBeginEditable name="Page Title" -->

<!-- InstanceEndEditable -->

<link href="../style/frame.css" rel="stylesheet" type="text/css" media="screen" />
<link href="../style/style.css" rel="stylesheet" type="text/css" media="screen" />
<!-- InstanceBeginEditable name="Local Styles" -->
	<style type="text/css">
	/*
	 * Styles used only on this page.
	 */
	.divNTP {
	  position: relative;
	  background-color: #FFFFFF;
	  color: #000000;
    border-style: solid;
    border-color: #6699FF;
    border-width: 1px;
    padding: 5px;
    width: 310px;
    font: 13px Arial;
    display: none;
	}
	.selNTP:hover {
		background-color:#3399FF;
	}
	</style>
	<!-- InstanceEndEditable -->

<script type="text/javascript" src="../scripts/jquery.min.js"></script>
<script type="text/javascript" src="../scripts/ddaccordion.js"></script>
<script type="text/javascript" src="../scripts/um.js?20120904<% nvram_get("Language"); %>"></script>
<script type="text/javascript" src="../scripts/func.js?20120904<% nvram_get("Language"); %>"></script>
<script type="text/javascript" src="../scripts/overlib.js"></script>
<!-- InstanceBeginEditable name="Include Files" -->

	<!-- InstanceEndEditable -->
<script language="JavaScript" type="text/javascript">
var langset = "<% nvram_get("Language"); %>";
var lang = (langset=="")? "EN":langset;
function doLangSet() {
	document.getElementById("redirect_url").value = location.pathname;
	document.Lang.submit();
}

var DosCotrolItme = "<% getDoSDefined(); %>";

function expand_path()
{
	//Expand menu by pathname
	var path = location.pathname;
	if(dev_Wlmode == "psta") {
		//Expand menu by pathname
		if (path.indexOf("/adm/") > -1)
			ddaccordion.expandone('expandable2', 0);
		if (path.indexOf("/internet/") > -1)
			ddaccordion.expandone('expandable2', 1);
	} else {
		if (path.indexOf("/adm/") > -1)
			ddaccordion.expandone('expandable2', 0);
		if (path.indexOf("/internet/") > -1)
			ddaccordion.expandone('expandable2', 1);
		if((path.indexOf("/wireless/") > -1 || path.indexOf("/wps/") > -1) && "<% nvram_invmatch("wl_unit_if", "1", "0"); %>" == "0")
			ddaccordion.expandone('expandable2', 2);
		if((path.indexOf("/wireless/") > -1 || path.indexOf("/wps/") > -1) && "<% nvram_invmatch("wl_unit_if", "0", "1"); %>" == "1")
			ddaccordion.expandone('expandable2', 3);
		if(path.indexOf("/advanced/") > -1) {
			if(path.indexOf("access_control.asp") > -1 || path.indexOf("filter.asp") > -1)
				ddaccordion.expandone('expandable2', 4);
			else
				ddaccordion.expandone('expandable2', 5);
		}
		if(path.indexOf("/usb/") > -1)
			ddaccordion.expandone('expandable2', 6);
	}
}

function menu_adjust() {
	if (lang=="DE") {
	} else	if (lang=="FR") {
	} else	if (lang=="ESP") {
	} else	if (lang=="RU") {
		if(dev_Wlmode != "psta")
			document.getElementById("mainmenu_3").style.margin = "-12px 0px 0px 5px";
	}
}

var dev_Wlmode = "<% nvram_get("wl_mode"); %>";
function template_load() {
	expand_path();

	//Language default selection
	var i;
	var lang_element = document.getElementById("langSelection");
	for (i=0; i<lang_element.options.length; i++) {
		if (lang == lang_element.options[i].value) {
			lang_element.options.selectedIndex = i;
			break;
		}
	}
	page_load();
	menu_adjust();
}
</script>
<!-- InstanceBeginEditable name="Scripts" -->
<script language="JavaScript" type="text/javascript">
<!--
var currectSysUptime = "<% sysuptime(); %>";
var updays, upminutes, uphours;
var deviceSysTime;
var weekday=new Array("Sun","Mon","Tue","Wed","Thu","Fri","Sat");
var monthname=new Array("Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec");
var nowhrs,nowmins,nowsecs;

function sysTime(){
	deviceSysTime = new Date();
	deviceSysTime.setTime(UTCSecond++ + "000");
	nowhrs = deviceSysTime.getUTCHours();
	nowmins = deviceSysTime.getUTCMinutes();
	nowsecs = deviceSysTime.getUTCSeconds();

	if (nowhrs<=9) nowhrs="0"+nowhrs;
	if (nowmins<=9) nowmins="0"+nowmins;
	if (nowsecs<=9) nowsecs="0"+nowsecs;

	document.getElementById("sysTime").innerHTML = weekday[deviceSysTime.getUTCDay()] + " " + monthname[deviceSysTime.getUTCMonth()] + " " + deviceSysTime.getUTCDate() + " " + nowhrs + ":" + nowmins + ":" + nowsecs + " " + deviceSysTime.getUTCFullYear();
	window.setTimeout("sysTime()", 1000);
}

$("html").mouseup(function() {
  if($("#select_NTPServer").is(':visible')) {
   if(!$("#select_NTPServer:hover").length>0 && !$("#NTPServerIP:hover").length>0) {
    $("#select_NTPServer").hide();
   }
  }
 }
);

function selectNTP(ntpvalue) {

	document.getElementById("NTPServerIP").value = ntpvalue;
	document.getElementById("select_NTPServer").style.display = "none";
	
	var NTPSync = "<% nvram_get("timer_interval"); %>";
	
	if (NTPSync == "")
		document.getElementById("NTPSync").value = "300";
	else
		document.getElementById("NTPSync").value = NTPSync;
}

function NTPFormCheck()
{
	if(document.getElementById("enableNTP").checked )
		document.timeField.enableNTP.value=1;
	else
		document.timeField.enableNTP.value=0;

	if( document.getElementById("enableNTP").checked == true && document.timeField.NTPServerIP.value == "" ) {
		Alert.render("<!--#tr id="ts.alert.1"-->Please select a NTP Server.<!--#endtr-->");
		return false;
	}
	if( document.timeField.NTPServerIP.value != "" && 
		document.timeField.timer_interval.value == ""){
		Alert.render("<!--#tr id="ts.alert.2"-->Please specify a value for the interval of synchroniztion.<!--#endtr-->");
		return false;
	}
	if(isAllNum( document.timeField.timer_interval.value ) == 0){
		Alert.render("<!--#tr id="ts.alert.3"-->Invalid NTP synchronization value.<!--#endtr-->");
		return false;
	}
	if( atoi(document.timeField.timer_interval.value, 1) > 300 || atoi(document.timeField.timer_interval.value, 1) < 1){
		Alert.render("<!--#tr id="ts.alert.4"-->The NTP synchronization value is out of range.(1~300)<!--#endtr-->");
		return false;
	}
	if (!checkInteger(document.timeField.timer_interval.value)) {
		Alert.render("<!--#tr id="ts.alert.5"-->The NTP synchronization value is not an Integer!<!--#endtr-->");
		return false;
	}
	
	//Tom.Hung 2009-1-14, add manual time setting check
	if( document.getElementById("enableNTP").checked == false ) {
		var month=1*document.getElementById("manual_month_select").value;
		var day=1*document.getElementById("manual_day_select").value;
		var wrongday=true;
		switch(month) {
			case 1:
			case 3:
			case 5:
			case 7:
			case 8:
			case 10:
			case 12:
				break;
			case 2:
				if(day>29) wrongday = false;
				break;
			case 4:
			case 6:
			case 9:
			case 11:
				if(day>30) wrongday = false;
				break;
			default:
		}
		if(wrongday == false) {
			Alert.render("<!--#tr id="ts.alert.6"-->Invalid Month and Day setting!<!--#endtr-->");
			return false;
		}
	}
	//Tom.Hung 2009-1-14
	
	totalWaitTime = 25; //second
	wait_page();
	document.getElementById("waitPad").style.display="block";
	//document.timeField.submit();
	scroll(0,0);
	return true;
}

function CheckValue()
{
			//Jacky.Yang 13-Dec-2007 - waitting page and redirect url
			wait_page();
			return true;
}

function syncWithHost()
{
	var currentTime = new Date();

	var seconds = currentTime.getSeconds();
	var minutes = currentTime.getMinutes();
	var hours = currentTime.getHours();
	var month = currentTime.getMonth() + 1;
	var day = currentTime.getDate();
	var year = currentTime.getFullYear();

	var seconds_str = " ";
	var minutes_str = " ";
	var hours_str = " ";
	var month_str = " ";
	var day_str = " ";
	var year_str = " ";

	if(seconds < 10)
		seconds_str = "0" + seconds;
	else
		seconds_str = ""+seconds;

	if(minutes < 10)
		minutes_str = "0" + minutes;
	else
		minutes_str = ""+minutes;

	if(hours < 10)
		hours_str = "0" + hours;
	else
		hours_str = ""+hours;

	if(month < 10)
		month_str = "0" + month;
	else
		month_str = ""+month;

	if(day < 10)
		day_str = "0" + day;
	else
		day_str = day;

	var tmp = month_str + day_str + hours_str + minutes_str + year + " ";
	makeRequest("/NTPSyncWithHost.cgi", tmp);
}

function ntpInitial()
{
	var tz = "<% nvram_get("time_zone"); %>";
	var ntpEnable = "<% nvram_get("ntp_enable"); %>";
	
	if (tz == "UCT_-11") {
		document.timeField.time_zone.options.selectedIndex = 0;
		document.timeField.time_zone.options.selectedIndex =0;
	}
	else if (tz == "UCT_-10") {
		document.timeField.time_zone.options.selectedIndex = 1;
		document.timeField.time_zone.options.selectedIndex =1;
	}
	else if (tz == "NAS_-09") {
		document.timeField.time_zone.options.selectedIndex = 2;
		document.timeField.time_zone.options.selectedIndex =2;
	}
	else if (tz == "PST_-08") {
		document.timeField.time_zone.options.selectedIndex = 3;
		document.timeField.time_zone.options.selectedIndex =3;
	}
	else if (tz == "MST_-07") {
		document.timeField.time_zone.options.selectedIndex = 4;
		document.timeField.time_zone.options.selectedIndex =4;
	}
	else if (tz == "MST_-07") {
		document.timeField.time_zone.options.selectedIndex = 5;
		document.timeField.time_zone.options.selectedIndex =5;
	}
	else if (tz == "CST_-06") {
		document.timeField.time_zone.options.selectedIndex = 6;
		document.timeField.time_zone.options.selectedIndex =6;
	}
	else if (tz == "UCT_-06") {
		document.timeField.time_zone.options.selectedIndex = 7;
		document.timeField.time_zone.options.selectedIndex =7;
	}
	else if (tz == "UCT_-05") {
		document.timeField.time_zone.options.selectedIndex = 8;
		document.timeField.time_zone.options.selectedIndex =8;
	}
	else if (tz == "EST_-05") {
		document.timeField.time_zone.options.selectedIndex = 9;
		document.timeField.time_zone.options.selectedIndex =9;
	}
	else if (tz == "AST_-04") {
		document.timeField.time_zone.options.selectedIndex = 10;
		document.timeField.time_zone.options.selectedIndex =10;
	}
	else if (tz == "UCT_-04") {
		document.timeField.time_zone.options.selectedIndex = 11;
		document.timeField.time_zone.options.selectedIndex =11;
	}
	else if (tz == "UCT_-03") {
		document.timeField.time_zone.options.selectedIndex = 12;
		document.timeField.time_zone.options.selectedIndex =12;
	}
	else if (tz == "EBS_-03") {
		document.timeField.time_zone.options.selectedIndex = 13;
		document.timeField.time_zone.options.selectedIndex =13;
	}
	else if (tz == "NOR_-02") {
		document.timeField.time_zone.options.selectedIndex = 14;
		document.timeField.time_zone.options.selectedIndex =14;
	}
	else if (tz == "EUT_-01") {
		document.timeField.time_zone.options.selectedIndex = 15;
		document.timeField.time_zone.options.selectedIndex =15;
	}
	else if (tz == "UCT_000") {
		document.timeField.time_zone.options.selectedIndex = 16;
		document.timeField.time_zone.options.selectedIndex =16;
	}
	else if (tz == "GMT_000") {
		document.timeField.time_zone.options.selectedIndex = 17;
		document.timeField.time_zone.options.selectedIndex =17;
	}

	else if (tz == "MET_001") {
		document.timeField.time_zone.options.selectedIndex = 18;
		document.timeField.time_zone.options.selectedIndex =18;
	}
	else if (tz == "MEZ_001") {
		document.timeField.time_zone.options.selectedIndex = 19;
		document.timeField.time_zone.options.selectedIndex =19;
	}
	else if (tz == "UCT_001") {
		document.timeField.time_zone.options.selectedIndex = 20;
		document.timeField.time_zone.options.selectedIndex =20;
	}
	else if (tz == "EET_002") {
		document.timeField.time_zone.options.selectedIndex = 21;
		document.timeField.time_zone.options.selectedIndex =21;
	}
	else if (tz == "SAS_002") {
		document.timeField.time_zone.options.selectedIndex = 22;
		document.timeField.time_zone.options.selectedIndex =22;
	}
	else if (tz == "IST_003") {
		document.timeField.time_zone.options.selectedIndex = 23;
		document.timeField.time_zone.options.selectedIndex =23;
	}
	else if (tz == "MSK_003") {
		document.timeField.time_zone.options.selectedIndex = 24;
		document.timeField.time_zone.options.selectedIndex =24;
	}
	else if (tz == "UCT_004") {
		document.timeField.time_zone.options.selectedIndex = 25;
		document.timeField.time_zone.options.selectedIndex =25;
	}
	else if (tz == "UCT_005") {
		document.timeField.time_zone.options.selectedIndex = 26;
		document.timeField.time_zone.options.selectedIndex =26;
	}
	else if (tz == "UCT_006") {
		document.timeField.time_zone.options.selectedIndex = 27;
		document.timeField.time_zone.options.selectedIndex =27;
	}
	else if (tz == "UCT_007") {
		document.timeField.time_zone.options.selectedIndex = 28;
		document.timeField.time_zone.options.selectedIndex =28;
	}
	else if (tz == "CST_008") {
		document.timeField.time_zone.options.selectedIndex = 29;
		document.timeField.time_zone.options.selectedIndex =29;
	}
	else if (tz == "CCT_008") {
		document.timeField.time_zone.options.selectedIndex = 30;
		document.timeField.time_zone.options.selectedIndex =30;
	}
	else if (tz == "SST_008") {
		document.timeField.time_zone.options.selectedIndex = 31;
		document.timeField.time_zone.options.selectedIndex =31;
	}
	else if (tz == "AWS_008") {
		document.timeField.time_zone.options.selectedIndex = 32;
		document.timeField.time_zone.options.selectedIndex =32;
	}
	else if (tz == "JST_009") {
		document.timeField.time_zone.options.selectedIndex = 33;
		document.timeField.time_zone.options.selectedIndex =33;
	}
	else if (tz == "KST_009") {
		document.timeField.time_zone.options.selectedIndex = 34;
		document.timeField.time_zone.options.selectedIndex =34;
	}
	else if (tz == "UCT_010") {
		document.timeField.time_zone.options.selectedIndex = 35;
		document.timeField.time_zone.options.selectedIndex =35;
	}
	else if (tz == "AES_010") {
		document.timeField.time_zone.options.selectedIndex = 36;
		document.timeField.time_zone.options.selectedIndex =36;
	}
	else if (tz == "UCT_011") {
		document.timeField.time_zone.options.selectedIndex = 37;
		document.timeField.time_zone.options.selectedIndex =37;
	}
	else if (tz == "UCT_012") {
		document.timeField.time_zone.options.selectedIndex = 38;
		document.timeField.time_zone.options.selectedIndex =38;
	}
	else if (tz == "NZS_012") {
		document.timeField.time_zone.options.selectedIndex = 39;
		document.timeField.time_zone.options.selectedIndex =39;
	}
	
	//if (NTPServerIP != "" && ntpEnable == "1" )
	//	document.getElementById(NTPServerIP).selected = true;

}

function dateAndTimeInitial()
{
	var loopCount;
	
	for (loopCount=0; loopCount<document.getElementById("manual_year_select").length; loopCount++)
	{
		if (deviceSysTime.getUTCFullYear() == parseInt(document.getElementById("manual_year_select").options[loopCount].text, 10))
			document.getElementById("manual_year_select").options[loopCount].selected = true;
	}
	//Alert.render("jacky - check month:" + deviceSysTime.getMonth());
	for (loopCount=0; loopCount<document.getElementById("manual_month_select").length; loopCount++)
	{
		if (deviceSysTime.getUTCMonth()+1 == parseInt(document.getElementById("manual_month_select").options[loopCount].value, 10))
			document.getElementById("manual_month_select").options[loopCount].selected = true;
	}
	
	for (loopCount=0; loopCount<document.getElementById("manual_day_select").length; loopCount++)
	{
		if (deviceSysTime.getUTCDate() == parseInt(document.getElementById("manual_day_select").options[loopCount].text, 10))
			document.getElementById("manual_day_select").options[loopCount].selected = true;
	}
	
	for (loopCount=0; loopCount<document.getElementById("manual_hour_select").length; loopCount++)
	{
		if (deviceSysTime.getUTCHours() == parseInt(document.getElementById("manual_hour_select").options[loopCount].text, 10))
			document.getElementById("manual_hour_select").options[loopCount].selected = true;
	}
	
	for (loopCount=0; loopCount<document.getElementById("manual_min_select").length; loopCount++)
	{
		if (deviceSysTime.getUTCMinutes() == parseInt(document.getElementById("manual_min_select").options[loopCount].text, 10))
			document.getElementById("manual_min_select").options[loopCount].selected = true;
	}
	
	for (loopCount=0; loopCount<document.getElementById("manual_sec_select").length; loopCount++)
	{
		if (deviceSysTime.getUTCSeconds() == parseInt(document.getElementById("manual_sec_select").options[loopCount].text, 10))
			document.getElementById("manual_sec_select").options[loopCount].selected = true;
	}
}

function checkNTP()
{
	var ntpEnable;
	ntpEnable = document.getElementById("enableNTP").checked;
	
	if (ntpEnable == true) {
		document.getElementById("enableNTPField").style.display = "";
		document.getElementById("ntpServerField").style.display = "";
		document.getElementById("TimeZoneField").style.display = "";
		document.getElementById("ntpSyncField").style.display = "";
		document.getElementById("manualField").style.display = "none";
		document.getElementById("timeTag").value = "NTP";
	}
	else {
		document.getElementById("enableNTPField").style.display = "";
		document.getElementById("ntpServerField").style.display = "none";
		document.getElementById("TimeZoneField").style.display = "none";
		document.getElementById("ntpSyncField").style.display = "none";
		document.getElementById("manualField").style.display = "";
		document.getElementById("timeTag").value = "manual";
	}
}

/*
function tz_ntp_addr_selector(value)
{
	if (value != 0) {
		document.getElementById("NTPServerIP").value = document.getElementById("tz_ntp_addr_select").value;
	}
}
*/

function checkDST()
{
	var dstEnable;
	dstEnable = document.getElementById("DSTenable").checked;

	if (dstEnable == true) {
		document.getElementById("enableDSTField").style.display = "";
		document.getElementById("NtpDstOffsetField").style.display = "";
		document.getElementById("DSTdateField").style.display = "";
		document.timeField.NtpDstEnable.value=1;
	}
	else {
		document.getElementById("enableDSTField").style.display = "";
		document.getElementById("NtpDstOffsetField").style.display = "none";
		document.getElementById("DSTdateField").style.display = "none";
		document.timeField.NtpDstEnable.value=0;
	}
}

function tz_daylight_start_selector()
{
	var tmp="";
	var month=document.getElementById("tz_daylight_start_month_select").value;
	var day=document.getElementById("tz_daylight_start_day_select").value;
	var time=document.getElementById("tz_daylight_start_time_select").value;
	tmp=tmp.concat(month,day,time);
	//Alert.render("Start Time: "+tmp);
	document.getElementById("NtpDstStart").value = tmp;
}

function tz_daylight_end_selector()
{
	var tmp="";
	var month=document.getElementById("tz_daylight_end_month_select").value;
	var day=document.getElementById("tz_daylight_end_day_select").value;
	var time=document.getElementById("tz_daylight_end_time_select").value;
	tmp=tmp.concat(month,day,time);
	//Alert.render("End Time: "+tmp);
	document.getElementById("NtpDstEnd").value = tmp;
}

function page_load() {
	var ntpEnable = "<% nvram_get("ntp_enable"); %>";
	var projectName = "<% getProjectName(); %>";

	//tz = "<% nvram_get("time_zone"); %>"; // Ryan 2013.04.15 remove, because I have to change the system time to apply time_zone
	tz="";
	if(tz == "") tz = "0";
	index = tz.indexOf("_");
	tz = parseInt(tz.substr(index+1), 10);
	UTCSecond = <% localtime();  %>;
	UTCSecond = UTCSecond + ((tz)*60*60);
	
	sysTime();
	dateAndTimeInitial();
	ntpInitial();
	if (ntpEnable == "1")
		document.getElementById("enableNTP").checked = true;
	checkNTP();

	//Tom.Hung 2012-12-21, Daylight Saving Time
	var dstenable = "<% nvram_get("NtpDstEnable"); %>";
	var NtpDstOffset = "<% nvram_get("NtpDstOffset"); %>";
	var NtpDstStart = "<% nvram_get("NtpDstStart"); %>";
	var NtpDstEnd = "<% nvram_get("NtpDstEnd"); %>";
	var NTPServerIP = document.getElementById("NTPServerIP");
	
	if (dstenable == "1")
		document.getElementById("DSTenable").checked = true;
	checkDST();

	var loopCount;
	for (loopCount=0; loopCount<document.getElementById("NtpDstOffset").length; loopCount++)
	{
		if (parseInt(NtpDstOffset) == parseInt(document.getElementById("NtpDstOffset").options[loopCount].value, 10))
			document.getElementById("NtpDstOffset").options[loopCount].selected = true;
	}
	
	var dst_start_mon = NtpDstStart.substr(0,2);
	var dst_start_day = NtpDstStart.substr(2,2);
	var dst_start_time = NtpDstStart.substr(4,2);
	var dst_end_mon = NtpDstEnd.substr(0,2);
	var dst_end_day = NtpDstEnd.substr(2,2);
	var dst_end_time = NtpDstEnd.substr(4,2);

	for (loopCount=0; loopCount<document.getElementById("tz_daylight_start_month_select").length; loopCount++)
	{
		if (dst_start_mon == document.getElementById("tz_daylight_start_month_select").options[loopCount].value)
			document.getElementById("tz_daylight_start_month_select").options[loopCount].selected = true;
	}
	for (loopCount=0; loopCount<document.getElementById("tz_daylight_start_day_select").length; loopCount++)
	{
		if (dst_start_day == document.getElementById("tz_daylight_start_day_select").options[loopCount].value)
			document.getElementById("tz_daylight_start_day_select").options[loopCount].selected = true;
	}
	for (loopCount=0; loopCount<document.getElementById("tz_daylight_start_time_select").length; loopCount++)
	{
		if (dst_start_time == document.getElementById("tz_daylight_start_time_select").options[loopCount].value)
			document.getElementById("tz_daylight_start_time_select").options[loopCount].selected = true;
	}
	for (loopCount=0; loopCount<document.getElementById("tz_daylight_end_month_select").length; loopCount++)
	{
		if (dst_end_mon == document.getElementById("tz_daylight_end_month_select").options[loopCount].value)
			document.getElementById("tz_daylight_end_month_select").options[loopCount].selected = true;
	}
	for (loopCount=0; loopCount<document.getElementById("tz_daylight_end_day_select").length; loopCount++)
	{
		if (dst_end_day == document.getElementById("tz_daylight_end_day_select").options[loopCount].value)
			document.getElementById("tz_daylight_end_day_select").options[loopCount].selected = true;
	}
	for (loopCount=0; loopCount<document.getElementById("tz_daylight_end_time_select").length; loopCount++)
	{
		if (dst_end_time == document.getElementById("tz_daylight_end_time_select").options[loopCount].value)
			document.getElementById("tz_daylight_end_time_select").options[loopCount].selected = true;
	}

	tz_daylight_start_selector();
	tz_daylight_end_selector();
	//Tom.Hung 2012-12-21 end
}
//-->
</script>
	<!-- InstanceEndEditable -->
</head>
<body onload="template_load();">
<div id="waitPad" style="display: none;" ></div>
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
						<table border="0" cellpadding="0" cellspacing="0"  style="position:relative;width:920px; top:8px;" class="maintable">
							<tr>
								<td  valign="top"><img src="../images/logo.png" ></td>
								<td align="right"  valign="middle" nowrap="nowrap" class="description" style="width:600px; line-height:1.5em">
									<!--#tr id="project.desc"-->AC1900 Dual Band Wireless Router<!--#endtr-->
									<br>
              						TEW-818DRU
								</td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
		</td>
	</tr>
	<tr>
		<td>
<div class="dialog" style="margin-left:auto; margin-right:auto">
<div style="background-color: transparent;background-attachment: scroll;background-image: url(../images/bg_main2.png); background-position: right top; height: 40px;"><div></div></div>
<div style="background-color: transparent;background-repeat: repeat-y;background-attachment: scroll;background-image: url(../images/bg_main2_overlay.png);  background-position: right top;">
<div class="t"></div>
			<!--START MAIN TABLE -->
			<table border="0" cellpadding="0" cellspacing="0"  style="width:940px;">
				<tr>
					<td valign="top">
						<!--START LEFT NAVIGATION -->
<script>
ddaccordion.init({ //top level headers initialization
	headerclass: "expandable", //Shared CSS class name of headers group that are expandable
	contentclass: "categoryitems", //Shared CSS class name of contents group
	revealtype: "click", //Reveal content when user clicks or onmouseover the header? Valid value: "click", "clickgo", or "mouseover"
	mouseoverdelay: 200, //if revealtype="mouseover", set delay in milliseconds before header expands onMouseover
	collapseprev: true, //Collapse previous content (so only one open at any time)? true/false 
	defaultexpanded: [], //index of content(s) open by default [index1, index2, etc]. [] denotes no content
	onemustopen: true, //Specify whether at least one header should be open always (so never all headers closed)
	animatedefault: true, //Should contents open by default be animated into view?
	persiststate: true, //persist state of opened contents within browser session?
	toggleclass: ["", "openheader"], //Two CSS classes to be applied to the header when it's collapsed and expanded, respectively ["class1", "class2"]
	togglehtml: ["src", "", ""], //Additional HTML added to the header when it's collapsed and expanded, respectively  ["position", "html1", "html2"] (see docs)
	animatespeed: 200, //speed of animation: integer in milliseconds (ie: 200), or keywords "fast", "normal", or "slow"
	oninit:function(headers, expandedindices){ //custom code to run when headers have initalized
	},
	onopenclose:function(header, index, state, isuseractivated){ //custom code to run whenever a header is opened or closed
	}
})

ddaccordion.init({ //top level headers initialization
	headerclass: "expandable2", //Shared CSS class name of headers group that are expandable
	contentclass: "categoryitems", //Shared CSS class name of contents group
	revealtype: "click", //Reveal content when user clicks or onmouseover the header? Valid value: "click", "clickgo", or "mouseover"
	mouseoverdelay: 200, //if revealtype="mouseover", set delay in milliseconds before header expands onMouseover
	collapseprev: true, //Collapse previous content (so only one open at any time)? true/false 
	defaultexpanded: [], //index of content(s) open by default [index1, index2, etc]. [] denotes no content
	onemustopen: true, //Specify whether at least one header should be open always (so never all headers closed)
	animatedefault: false, //Should contents open by default be animated into view?
	persiststate: true, //persist state of opened contents within browser session?
	toggleclass: ["", "openheader"], //Two CSS classes to be applied to the header when it's collapsed and expanded, respectively ["class1", "class2"]
	togglehtml: ["src", "", ""], //Additional HTML added to the header when it's collapsed and expanded, respectively  ["position", "html1", "html2"] (see docs)
	animatespeed: 200, //speed of animation: integer in milliseconds (ie: 200), or keywords "fast", "normal", or "slow"
	oninit:function(headers, expandedindices){ //custom code to run when headers have initalized
	},
	onopenclose:function(header, index, state, isuseractivated){ //custom code to run whenever a header is opened or closed
	}
})

jQuery(function(){
     $(".img-swap").hover(
          function(){this.src = this.src.replace("_0","_2");},
          function(){this.src = this.src.replace("_2","_0");
     });
});
</script>

<!-- InstanceParam name="img_folder" type="text" value="../images/" -->

<div class="arrowlistmenu" style="padding-top: 0px">
	<script>
		if(dev_Wlmode != "psta") {
			document.write("<div class=\"homenav\" style=\"margin-bottom:20px\">"+
			"<a href=\"../basic/home.asp?expandable=0\"><img src=\"../images/but_basic_0<!--#tr id="image.lang.png"-->.png<!--#endtr-->\" style=\"float:left\" class=\"img-swap\" border=\"0\" /></a><a href=\"../adm/status.asp?expandable2=0\"><img src=\"../images/but_advance_1<!--#tr id="image.lang.png"-->.png<!--#endtr-->\" border=\"0\" /></a>"+
			"</div>"+
			"<div class=\"borderbottom\"> </div>"+
			"<div class=\"menuheader expandable2\" onclick=\"location.href='../adm/status.asp'\"> <img class=\"CatImage\" src=\"../images/but_administrator_0.png\"><span class=\"CatTitle\" id=\"mainmenu_1\"><!--#tr id="administrator"-->Administrator<!--#endtr--></span></div>"+
			"<ul class=\"categoryitems\">"+
				"<li><a onclick=\"location.href='../adm/management.asp'\"><!--#tr id="adm.node.management"-->Management<!--#endtr--></a></li>"+
				"<li><a onclick=\"location.href='../adm/upload_firmware.asp'\"><!--#tr id="adm.node.upload"-->Upload Firmware<!--#endtr--></a></li>"+
				"<li><a onclick=\"location.href='../adm/settings.asp'\"><!--#tr id="adm.node.settings"-->Settings Management<!--#endtr--></a></li>"+
				"<li><a onclick=\"location.href='../adm/time.asp'\"><!--#tr id="adm.node.time"-->Time<!--#endtr--></a></li>"+
				"<li><a onclick=\"location.href='../adm/schedule.asp'\"><!--#tr id="adv.node.schedule"-->Schedule<!--#endtr--></a></li>"+
				"<li><a onclick=\"location.href='../adm/status.asp'\"><!--#tr id="adm.node.routerstatus"-->Router Status<!--#endtr--></a></li>"+
				"<li><a onclick=\"location.href='../adm/ipv6status.asp'\"><!--#tr id="adm.node.ipv6.status"-->IPv6 Status<!--#endtr--></a></li>"+
				"<li><a onclick=\"location.href='../adm/syslog.asp'\"><!--#tr id="adm.node.system.log"-->System Log<!--#endtr--></a></li>"+
				"<li><a onclick=\"location.href='../adm/network.asp'\"><!--#tr id="adv.node.network"-->Advanced Network<!--#endtr--></a></li>"+
				"<li><a onclick=\"location.href='../adm/clientstatus.asp'\"><!--#tr id="adm.node.clientstatus"-->Client Status<!--#endtr--></a></li>"+
				"<li><a onclick=\"location.href='../adm/devicemode.asp'\"><!--#tr id="adm.node.devicemode"-->Device Mode<!--#endtr--></a></li>"+
			"</ul>"+
			"<div class=\"menuheader expandable2\" onclick=\"location.href='../internet/lan.asp'\"><img class=\"CatImage\" src=\"../images/but_setup_0.png\"><span class=\"CatTitle\" id=\"mainmenu_2\"><!--#tr id="setup"-->Setup<!--#endtr--></span></div>"+
			"<ul class=\"categoryitems\">"+
				"<li><a onclick=\"location.href='../internet/lan.asp'\"><!--#tr id="net.node.lan"-->LAN<!--#endtr--></a></li>"+
				"<li><a onclick=\"location.href='../internet/wan.asp'\"><!--#tr id="net.node.wan"-->WAN<!--#endtr--></a></li>"+
				"<li><a onclick=\"location.href='../internet/routing.asp'\"><!--#tr id="adv.node.routing"-->Routing<!--#endtr--></a></li>"+
				"<li><a onclick=\"location.href='../internet/ipv6.asp'\"><!--#tr id="net.node.ipv6"-->IPv6<!--#endtr--></a></li>"+
				"<li><a onclick=\"location.href='../internet/qos.asp'\"><!--#tr id="net.node.qos"-->QoS<!--#endtr--></a></li>"+
				"<li><a onclick=\"location.href='../wizard/wizard_internet.asp'\"><!--#tr id="wizard.node"-->Wizard<!--#endtr--></a></li>"+
				"<li><a onclick=\"location.href='../internet/vlan.asp'\"><!--#tr id="net.node.vlan"-->VLAN<!--#endtr--></a></li>"+
			"</ul>"+

			"<div class=\"menuheader expandable2\" onclick=\"location.href='../wireless/multissid.asp?wl_unit=0.1'\"> <img class=\"CatImage\" src=\"../images/but_wireless_24_0<!--#tr id="image.lang.png"-->.png<!--#endtr-->\"><span class=\"CatTitle\" id=\"mainmenu_3\"><!--#tr id="wireless.24g"-->Wireless 2.4GHz<!--#endtr--></span></div> "+
			"<ul class=\"categoryitems\">"+
				"<li><a onclick=\"location.href='../wireless/multissid.asp?wl_unit=0.1'\"><!--#tr id="wireless.node.multissid"-->Multiple SSID<!--#endtr--></a></li>"+
				"<li><a onclick=\"location.href='../wireless/wds.asp?wl_unit=0'\"><!--#tr id="wireless.node.wds"-->WDS<!--#endtr--></a></li>"+
				"<li><a onclick=\"location.href='../wireless/advanced.asp?wl_unit=0'\"><!--#tr id="wireless.node.adv"-->Advanced<!--#endtr--></a></li>"+
				"<li><a onclick=\"location.href='../wps/wps.asp?wl_unit=0'\"><!--#tr id="wireless.node.wps"-->WPS<!--#endtr--></a></li>"+
			"</ul>"+

			"<div class=\"menuheader expandable2\" onclick=\"location.href='../wireless/multissid.asp?wl_unit=1.1'\"> <img class=\"CatImage\" src=\"../images/but_wireless_5_0<!--#tr id="image.lang.png"-->.png<!--#endtr-->\"><span class=\"CatTitle\" id=\"mainmenu_4\"><!--#tr id="wireless.5g"-->Wireless 5GHz<!--#endtr--></span></div>"+ 
			"<ul class=\"categoryitems\">"+
				"<li><a onclick=\"location.href='../wireless/multissid.asp?wl_unit=1.1'\"><!--#tr id="wireless.node.multissid"-->Multiple SSID<!--#endtr--></a></li>"+
				"<li><a onclick=\"location.href='../wireless/wds.asp?wl_unit=1'\"><!--#tr id="wireless.node.wds"-->WDS<!--#endtr--></a></li>"+
				"<li><a onclick=\"location.href='../wireless/advanced.asp?wl_unit=1'\"><!--#tr id="wireless.node.adv"-->Advanced<!--#endtr--></a></li>"+
				"<li><a onclick=\"location.href='../wps/wps.asp?wl_unit=1'\"><!--#tr id="wireless.node.wps"-->WPS<!--#endtr--></a></li>"+
			"</ul>"+

			"<div class=\"menuheader expandable2\" onclick=\"location.href='../advanced/access_control.asp'\"> <img class=\"CatImage\" src=\"../images/but_security_0.png\"><span class=\"CatTitle\" id=\"mainmenu_5\"><!--#tr id="security"-->Security<!--#endtr--></span></div> "+
			"<ul class=\"categoryitems\">"+
				"<li><a onclick=\"location.href='../advanced/access_control.asp'\"><!--#tr id="adv.node.ac"-->Access Control<!--#endtr--></a></li>"+
			"</ul>"+

			"<div class=\"menuheader expandable2\" onclick=\"location.href='../advanced/dmz.asp'\"> <img class=\"CatImage\" src=\"../images/but_firewall_0.png\"><span class=\"CatTitle\" id=\"mainmenu_6\"><!--#tr id="firewall"-->Firewall<!--#endtr--></span></div>"+
			"<ul class=\"categoryitems\">"+
				"<li><a onclick=\"location.href='../advanced/dmz.asp'\"><!--#tr id="adv.node.dmz"-->DMZ<!--#endtr--></a></li>"+
				"<li><a onclick=\"location.href='../advanced/single_port.asp'\"><!--#tr id="adv.node.virtual.rules"-->Virtual Server<!--#endtr--></a></li>"+
				"<li><a onclick=\"location.href='../advanced/port_trigger.asp'\"><!--#tr id="adv.node.special.app"-->Special Applications<!--#endtr--></a></li>"+
				"<li><a onclick=\"location.href='../advanced/port_range.asp'\"><!--#tr id="adv.node.gaming"-->Gaming<!--#endtr--></a></li>"+
				"<li><a onclick=\"location.href='../advanced/alg.asp'\"><!--#tr id="adv.node.alg"-->ALG<!--#endtr--></a></li>"+
			"</ul>"+

			"<div class=\"menuheader expandable2\" onclick=\"location.href='../usb/samba.asp'\"> <img class=\"CatImage\" src=\"../images/but_usb_0.png\"><span class=\"CatTitle\" id=\"mainmenu_7\"><!--#tr id="usb"-->USB<!--#endtr--></span></div>"+
			"<ul class=\"categoryitems\">"+
				"<li><a onclick=\"location.href='../usb/samba.asp'\"><!--#tr id="usb.node.samba"-->Samba Server<!--#endtr--></a></li>"+
				"<li><a onclick=\"location.href='../usb/ftp.asp'\"><!--#tr id="usb.node.ftp"-->FTP Server<!--#endtr--></a></li>"+
				"<li><a onclick=\"location.href='../usb/ejectdevice.asp'\"><!--#tr id="usb.node.eject.device"-->Eject Device<!--#endtr--></a></li>"+
				"</ul>");
		}
		else {
			document.write("<div class=\"homenav\" style=\"margin-bottom:20px\">"+
													"<a href=\"../station/link_status.asp?expandable=0\"><img src=\"../images/but_basic_0<!--#tr id="image.lang.png"-->.png<!--#endtr-->\" style=\"float:left\" class=\"img-swap\" border=\"0\" /></a><a href=\"../adm/status.asp?expandable2=0\"><img src=\"../images/but_advance_1<!--#tr id="image.lang.png"-->.png<!--#endtr-->\" border=\"0\" /></a>"+
											"</div>"+
											"<div class=\"borderbottom\"> </div>"+
											"<div class=\"menuheader expandable2\" onclick=\"location.href='../adm/status.asp'\"> <img class=\"CatImage\" src=\"../images/but_administrator_0.png\"><span class=\"CatTitle\" id=\"mainmenu_1\"><!--#tr id="administrator"-->Administrator<!--#endtr--></span></div>"+
											"<ul class=\"categoryitems\">"+
													"<li><a onclick=\"location.href='../adm/management.asp'\"><!--#tr id="adm.node.management"-->Management<!--#endtr--></a></li>"+
													"<li><a onclick=\"location.href='../adm/upload_firmware.asp'\"><!--#tr id="adm.node.upload"-->Upload Firmware<!--#endtr--></a></li>"+
													"<li><a onclick=\"location.href='../adm/settings.asp'\"><!--#tr id="adm.node.settings"-->Settings Management<!--#endtr--></a></li>"+
													"<li><a onclick=\"location.href='../adm/time.asp'\"><!--#tr id="adm.node.time"-->Time<!--#endtr--></a></li>"+
													"<li><a onclick=\"location.href='../adm/status.asp'\"><!--#tr id="adm.node.routerstatus"-->Router Status<!--#endtr--></a></li>"+
													"<li><a onclick=\"location.href='../adm/syslog.asp'\"><!--#tr id="adm.node.system.log"-->System Log<!--#endtr--></a></li>"+
													"<li><a onclick=\"location.href='../adm/devicemode.asp'\"><!--#tr id="adm.node.devicemode"-->Device Mode<!--#endtr--></a></li>"+
											"</ul>"+
											"<div class=\"menuheader expandable2\" onclick=\"location.href='../internet/lan.asp'\"><img class=\"CatImage\" src=\"../images/but_setup_0.png\"><span class=\"CatTitle\" id=\"mainmenu_2\"><!--#tr id="setup"-->Setup<!--#endtr--></span></div>"+
											"<ul class=\"categoryitems\">"+
													"<li><a onclick=\"location.href='../internet/lan.asp'\"><!--#tr id="net.node.lan"-->LAN<!--#endtr--></a></li>"+
											"</ul>");
		}
	</script>
</div>
						<!--END LEFT NAVIGATION --> 
<script type="text/javascript" src="../scripts/xpmenu.js"></script>
					</td>
					<td style="width:650px; padding: 10px 0px 0px 15px; " valign="top" class="txt_main">
<iframe class="rebootRedirect" name="rebootRedirect" id="rebootRedirect" frameborder="0" width="1" height="1" scrolling="no" src="" style="display:none">redirect</iframe>
<div id="waitform"></div>
<div id="mainform">
	<div id="main_content">
	<!-- InstanceBeginEditable name="Main Content" -->
<table class="body"><tr><td>
<h1><!--#tr id="ts.title"-->Time Settings<!--#endtr--></h1>
<div class="hr" ></div>
<p>
<!--#tr id="ts.desc"-->You may configure your time and time zone.<!--#endtr-->
</p>

<form method="post" name="timeField" action="/setNTP.cgi" onsubmit="return NTPFormCheck();" target="rebootRedirect">
<input type="hidden" name="page" value="/adm/time.asp">
<input type="hidden" name="token" value="<% genToken(); %>">
<table width="100%" class="tbl_main">
	<tr>
		<td class="CT" colspan="2"><!--#tr id="ts.1"-->Time Configuration<!--#endtr--></td>
	</tr>
	<tr>
		<td class="CL"><!--#tr id="ts.2"-->System Time<!--#endtr--></td>
		<td class="CR"><span id="sysTime">&nbsp;</span></td>
	</tr>
</table>

<table width="100%" class="tbl_main">
	<tr>
		<td class="CT" colspan="2"><!--#tr id="ts.11" -->Daylight Saving Time<!--#endtr --></td>
	</tr>
	<tr id="enableDSTField">
		<td class="CL" id="manDSTEnable"><!--#tr id="ts.12" -->Enable Daylight Saving<!--#endtr --></td>
		<td class="CR">
			<input type="checkbox" id="DSTenable" name="DSTenable" onclick="checkDST();" />
			<input type="hidden" name="NtpDstEnable" value="0" />
		</td>
	</tr>
	<tr id="NtpDstOffsetField">
		<td class="CL"><!--#tr id="ts.13" -->Daylight Saving Offset<!--#endtr --></td>
		<td class="CR">
			<select name="NtpDstOffset" id="NtpDstOffset">
				<option value="-7200">-2:00</option>
				<option value="-5400">-1:30</option>
				<option value="-3600">-1:00</option>
				<option value="-1800">-0:30</option>
				<option value="1800">+0:30</option>
				<option value="3600" selected>+1:00</option>
				<option value="5400">+1:30</option>
				<option value="7200">+2:00</option>
			</select>  
		</td>
	</tr>
	<tr id="DSTdateField">
		<td class="CL"><!--#tr id="ts.14" -->Daylight Saving Dates<!--#endtr --></td>
		<td class="CR">
			<table cellspacing="0" cellpadding="0" width="100%" style="border-collapse: separate;">
				<tr>
					<td>&nbsp;</td>
					<td><!--#tr id="month" -->Month<!--#endtr --></td>
					<td><!--#tr id="day" -->Day<!--#endtr --></td>
					<td><!--#tr id="hour" -->Hour<!--#endtr --></td>
				</tr>
				<tr>
					<td><!--#tr id="ts.15" -->DST Start<!--#endtr -->
						<input type="hidden" id="NtpDstStart" name="NtpDstStart" value="">
					</td>
					<td>
						<select name="tz_daylight_start_month_select" id="tz_daylight_start_month_select" onchange="tz_daylight_start_selector();">
							<option value="01"><!--#tr id="jan" -->Jan<!--#endtr --></option>
							<option value="02"><!--#tr id="feb" -->Feb<!--#endtr --></option>
							<option value="03" selected><!--#tr id="mar" -->Mar<!--#endtr --></option>
							<option value="04"><!--#tr id="apr" -->Apr<!--#endtr --></option>
							<option value="05"><!--#tr id="may" -->May<!--#endtr --></option>
							<option value="06"><!--#tr id="jun" -->Jun<!--#endtr --></option>
							<option value="07"><!--#tr id="jul" -->Jul<!--#endtr --></option>
							<option value="08"><!--#tr id="aug" -->Aug<!--#endtr --></option>
							<option value="09"><!--#tr id="sep" -->Sep<!--#endtr --></option>
							<option value="10"><!--#tr id="oct" -->Oct<!--#endtr --></option>
							<option value="11"><!--#tr id="nov" -->Nov<!--#endtr --></option>
							<option value="12"><!--#tr id="dec" -->Dec<!--#endtr --></option>
						</select>
					</td>
					<td>
						<select name="tz_daylight_start_day_select" id="tz_daylight_start_day_select" onchange="tz_daylight_start_selector();">
							<option value="01" selected>01</option>
							<option value="02">02</option>
							<option value="03">03</option>
							<option value="04">04</option>
							<option value="05">05</option>
							<option value="06">06</option>
							<option value="07">07</option>
							<option value="08">08</option>
							<option value="09">09</option>
							<option value="10">10</option>
							<option value="11">11</option>
							<option value="12">12</option>
							<option value="13">13</option>
							<option value="14">14</option>
							<option value="15">15</option>
							<option value="16">16</option>
							<option value="17">17</option>
							<option value="18">18</option>
							<option value="19">19</option>
							<option value="20">20</option>
							<option value="21">21</option>
							<option value="22">22</option>
							<option value="23">23</option>
							<option value="24">24</option>
							<option value="25">25</option>
							<option value="26">26</option>
							<option value="27">27</option>
							<option value="28">28</option>
							<option value="29">29</option>
							<option value="30">30</option>
							<option value="31">31</option>
						</select>
					</td>
					<td>
						<select name="tz_daylight_start_time_select" id="tz_daylight_start_time_select" onchange="tz_daylight_start_selector();">
							<option value="00">0</option>
							<option value="01">1</option>
							<option value="02" selected>2</option>
							<option value="03">3</option>
							<option value="04">4</option>
							<option value="05">5</option>
							<option value="06">6</option>
							<option value="07">7</option>
							<option value="08">8</option>
							<option value="09">9</option>
							<option value="10">10</option>
							<option value="11">11</option>
							<option value="12">12</option>
							<option value="13">13</option>
							<option value="14">14</option>
							<option value="15">15</option>
							<option value="16">16</option>
							<option value="17">17</option>
							<option value="18">18</option>
							<option value="19">19</option>
							<option value="20">20</option>
							<option value="21">21</option>
							<option value="22">22</option>
							<option value="23">23</option>
						</select>
					</td>
				</tr>
				<tr>
					<td><!--#tr id="ts.16" -->DST End<!--#endtr -->
						<input type="hidden" id="NtpDstEnd" name="NtpDstEnd" value="">
					</td>
					<td>
						<select name="tz_daylight_end_month_select" id="tz_daylight_end_month_select" onchange="tz_daylight_end_selector();">
							<option value="01"><!--#tr id="jan" -->Jan<!--#endtr --></option>
							<option value="02"><!--#tr id="feb" -->Feb<!--#endtr --></option>
							<option value="03"><!--#tr id="mar" -->Mar<!--#endtr --></option>
							<option value="04"><!--#tr id="apr" -->Apr<!--#endtr --></option>
							<option value="05"><!--#tr id="may" -->May<!--#endtr --></option>
							<option value="06"><!--#tr id="jun" -->Jun<!--#endtr --></option>
							<option value="07"><!--#tr id="jul" -->Jul<!--#endtr --></option>
							<option value="08"><!--#tr id="aug" -->Aug<!--#endtr --></option>
							<option value="09"><!--#tr id="sep" -->Sep<!--#endtr --></option>
							<option value="10" selected><!--#tr id="oct" -->Oct<!--#endtr --></option>
							<option value="11"><!--#tr id="nov" -->Nov<!--#endtr --></option>
							<option value="12"><!--#tr id="dec" -->Dec<!--#endtr --></option>
						</select>
					</td>
					<td>
						<select name="tz_daylight_end_day_select" id="tz_daylight_end_day_select" onchange="tz_daylight_end_selector();">
							<option value="01" selected>01</option>
							<option value="02">02</option>
							<option value="03">03</option>
							<option value="04">04</option>
							<option value="05">05</option>
							<option value="06">06</option>
							<option value="07">07</option>
							<option value="08">08</option>
							<option value="09">09</option>
							<option value="10">10</option>
							<option value="11">11</option>
							<option value="12">12</option>
							<option value="13">13</option>
							<option value="14">14</option>
							<option value="15">15</option>
							<option value="16">16</option>
							<option value="17">17</option>
							<option value="18">18</option>
							<option value="19">19</option>
							<option value="20">20</option>
							<option value="21">21</option>
							<option value="22">22</option>
							<option value="23">23</option>
							<option value="24">24</option>
							<option value="25">25</option>
							<option value="26">26</option>
							<option value="27">27</option>
							<option value="28">28</option>
							<option value="29">29</option>
							<option value="30">30</option>
							<option value="31">31</option>
						</select>
					</td>
					<td>
						<select name="tz_daylight_end_time_select" id="tz_daylight_end_time_select" onchange="tz_daylight_end_selector();">
							<option value="00">0</option>
							<option value="01">1</option>
							<option value="02" selected>2</option>
							<option value="03">3</option>
							<option value="04">4</option>
							<option value="05">5</option>
							<option value="06">6</option>
							<option value="07">7</option>
							<option value="08">8</option>
							<option value="09">9</option>
							<option value="10">10</option>
							<option value="11">11</option>
							<option value="12">12</option>
							<option value="13">13</option>
							<option value="14">14</option>
							<option value="15">15</option>
							<option value="16">16</option>
							<option value="17">17</option>
							<option value="18">18</option>
							<option value="19">19</option>
							<option value="20">20</option>
							<option value="21">21</option>
							<option value="22">22</option>
							<option value="23">23</option>
						</select>
					</td>
				</tr>
			</table>
		</td>
	</tr>
</table>

<table width="100%" class="tbl_main">
	<tr>
		<td class="CT" colspan="2"><!--#tr id="ts.3"-->NTP Settings<!--#endtr--></td>
	</tr>
	<tr id="enableNTPField">
		<td class="CL"><!--#tr id="ts.4"-->Enable NTP Server<!--#endtr--></td>
		<td class="CR">
			<input type="checkbox" id="enableNTP" name="enableNTP" value="" onclick="checkNTP();">
			<input type="hidden" name="ntp_server" value="1" />
		</td>
	</tr>
	<tr id="ntpServerField">
		<td class="CL"><!--#tr id="ts.5"-->NTP Server<!--#endtr--></td>
		<td class="CR">
			<!--<input size="32" maxlength="17" name="NTPServerIP" value="<%  nvram_list("ntp_server", 0); %>" type="text">-->
			<input type="text" name="NTPServerIP" id="NTPServerIP" style="width:320px;" value="<% nvram_get("ntp_server"); %>" onfocus="document.getElementById('select_NTPServer').style.display='block';">
			<div class="divNTP" name="select_NTPServer" id="select_NTPServer">
				<div class="selNTP" onclick="selectNTP(this.innerHTML);">0.north-america.pool.ntp.org (DST Support)</div>
				<div class="selNTP" onclick="selectNTP(this.innerHTML);">1.north-america.pool.ntp.org (DST Support)</div>
				<div class="selNTP" onclick="selectNTP(this.innerHTML);">pool.ntp.org</div>
				<div class="selNTP" onclick="selectNTP(this.innerHTML);">time-a.nist.gov</div>
				<div class="selNTP" onclick="selectNTP(this.innerHTML);">time-b.nist.gov</div>
				<div class="selNTP" onclick="selectNTP(this.innerHTML);">time.nist.gov</div>
				<div class="selNTP" onclick="selectNTP(this.innerHTML);">time.windows.com</div>
			</div>	
		</td>
	</tr>
	<tr id="TimeZoneField">
		<td class="CL"><!--#tr id="ts.7"-->Time Zone<!--#endtr--></td>
		<td class="CR">
			<select name="time_zone">
				<option value="UCT_-11"><!--#tr id="ts.gmt.1"-->(GMT-11:00) Midway Island, Samoa<!--#endtr--></option>
				<option value="UCT_-10"><!--#tr id="ts.gmt.2"-->(GMT-10:00) Hawaii<!--#endtr--></option>
				<option value="NAS_-09"><!--#tr id="ts.gmt.3"-->(GMT-09:00) Alaska<!--#endtr--></option>
				<option value="PST_-08"><!--#tr id="ts.gmt.4"-->(GMT-08:00) Pacific Time<!--#endtr--></option>
				<option value="MST_-07"><!--#tr id="ts.gmt.5"-->(GMT-07:00) Mountain Time<!--#endtr--></option>
				<option value="MST_-07"><!--#tr id="ts.gmt.6"-->(GMT-07:00) Arizona<!--#endtr--></option>
				<option value="CST_-06"><!--#tr id="ts.gmt.7"-->(GMT-06:00) Central Time<!--#endtr--></option>
				<option value="UCT_-06"><!--#tr id="ts.gmt.8"-->(GMT-06:00) Middle America<!--#endtr--></option>
				<option value="UCT_-05"><!--#tr id="ts.gmt.9"-->(GMT-05:00) Indiana East, Colombia<!--#endtr--></option>
				<option value="EST_-05"><!--#tr id="ts.gmt.10"-->(GMT-05:00) Eastern Time<!--#endtr--></option>
				<option value="AST_-04"><!--#tr id="ts.gmt.11"-->(GMT-04:00) Atlantic Time, Brazil West<!--#endtr--></option>
				<option value="UCT_-04"><!--#tr id="ts.gmt.12"-->(GMT-04:00) Bolivia, Venezuela<!--#endtr--></option>
				<option value="UCT_-03"><!--#tr id="ts.gmt.13"-->(GMT-03:00) Guyana<!--#endtr--></option>
				<option value="EBS_-03"><!--#tr id="ts.gmt.14"-->(GMT-03:00) Brazil East, Greenland<!--#endtr--></option>
				<option value="NOR_-02"><!--#tr id="ts.gmt.15"-->(GMT-02:00) Mid-Atlantic<!--#endtr--></option>
				<option value="EUT_-01"><!--#tr id="ts.gmt.16"-->(GMT-01:00) Azores Islands<!--#endtr--></option>
				<option value="UCT_000"><!--#tr id="ts.gmt.17"-->(GMT) Gambia, Liberia, Morocco<!--#endtr--></option>
				<option value="GMT_000"><!--#tr id="ts.gmt.18"-->(GMT) England<!--#endtr--></option>
				<option value="MET_001"><!--#tr id="ts.gmt.19"-->(GMT+01:00) Czech Republic, N<!--#endtr--></option>
				<option value="MEZ_001"><!--#tr id="ts.gmt.20"-->(GMT+01:00) Germany<!--#endtr--></option>
				<option value="UCT_001"><!--#tr id="ts.gmt.21"-->(GMT+01:00) Tunisia<!--#endtr--></option>
				<option value="EET_002"><!--#tr id="ts.gmt.22"-->(GMT+02:00) Greece, Ukraine, Turkey<!--#endtr--></option>
				<option value="SAS_002"><!--#tr id="ts.gmt.23"-->(GMT+02:00) South Africa<!--#endtr--></option>
				<option value="IST_003"><!--#tr id="ts.gmt.24"-->(GMT+03:00) Iraq, Jordan, Kuwait<!--#endtr--></option>
				<option value="MSK_003"><!--#tr id="ts.gmt.25"-->(GMT+03:00) Moscow Winter Time<!--#endtr--></option>
				<option value="UCT_004"><!--#tr id="ts.gmt.26"-->(GMT+04:00) Armenia<!--#endtr--></option>
				<option value="UCT_005"><!--#tr id="ts.gmt.27"-->(GMT+05:00) Pakistan, Russia<!--#endtr--></option>
				<option value="UCT_006"><!--#tr id="ts.gmt.28"-->(GMT+06:00) Bangladesh, Russia<!--#endtr--></option>
				<option value="UCT_007"><!--#tr id="ts.gmt.29"-->(GMT+07:00) Thailand, Russia<!--#endtr--></option>
				<option value="CST_008"><!--#tr id="ts.gmt.30"-->(GMT+08:00) China Coast, Hong Kong<!--#endtr--></option>
				<option value="CCT_008"><!--#tr id="ts.gmt.31"-->(GMT+08:00) Taipei<!--#endtr--></option>
				<option value="SST_008"><!--#tr id="ts.gmt.32"-->(GMT+08:00) Singapore<!--#endtr--></option>
				<option value="AWS_008"><!--#tr id="ts.gmt.33"-->(GMT+08:00) Australia (WA)<!--#endtr--></option>
				<option value="JST_009"><!--#tr id="ts.gmt.34"-->(GMT+09:00) Japan, Korea<!--#endtr--></option>
				<option value="KST_009"><!--#tr id="ts.gmt.35"-->(GMT+09:00) Korean<!--#endtr--></option>
				<option value="UCT_010"><!--#tr id="ts.gmt.36"-->(GMT+10:00) Guam, Russia<!--#endtr--></option>
				<option value="AES_010"><!--#tr id="ts.gmt.37"-->(GMT+10:00) Australia (QLD, TAS,NSW,ACT,VIC)<!--#endtr--></option>
				<option value="UCT_011"><!--#tr id="ts.gmt.38"-->(GMT+11:00) Solomon Islands<!--#endtr--></option>
				<option value="UCT_012"><!--#tr id="ts.gmt.39"-->(GMT+12:00) Fiji<!--#endtr--></option>
				<option value="NZS_012"><!--#tr id="ts.gmt.40"-->(GMT+12:00) New Zealand<!--#endtr--></option>
			</select>
		</td>
	</tr>
	<tr id="ntpSyncField">
		<td class="CL"><!--#tr id="ts.8"-->NTP synchronization<!--#endtr--></td>
		<td class="CR"><input size="4" id="NTPSync" name="timer_interval" value="<% nvram_get("timer_interval"); %>" type="text"> &nbsp;(1~300) <!--#tr id="minute"-->Minute<!--#endtr--></td>
	</tr>
</table>

<div id="manualField">
<table width="100%" class="tbl_main">
	<tr>
		<td class="CT" colspan="2"><!--#tr id="ts.9"-->Date and Time Settings<!--#endtr--></td>
	</tr>
	<tr>
		<td class="CL"><!--#tr id="ts.10"-->Date And Time<!--#endtr--></td>
		<td class="CR">
			<table cellspacing="2" cellpadding="2" border="0" summary="" width="100%" style="border-collapse: separate;">
				<tr>
					<td><!--#tr id="year"-->Year<!--#endtr--></td>
					<td>
						<select id="manual_year_select" name="manual_year_select">
							<option value="2000">2000</option>
							<option value="2001">2001</option>
							<option value="2002">2002</option>
							<option value="2003">2003</option>
							<option value="2004">2004</option>
							<option value="2005">2005</option>
							<option value="2006">2006</option>
							<option value="2007">2007</option>
							<option value="2008">2008</option>
							<option value="2009">2009</option>
							<option value="2010">2010</option>
							<option value="2011">2011</option>
							<option value="2012" selected="selected">2012</option>
							<option value="2013">2013</option>
							<option value="2014">2014</option>
							<option value="2015">2015</option>
							<option value="2016">2016</option>
							<option value="2017">2017</option>
							<option value="2018">2018</option>
							<option value="2019">2019</option>
						</select>
					</td>
					<td><!--#tr id="month"-->Month<!--#endtr--></td>
					<td>
						<select id="manual_month_select" name="manual_month_select">
							<option value="01" selected="selected"><!--#tr id="jan"-->Jan<!--#endtr--></option>
							<option value="02"><!--#tr id="feb"-->Feb<!--#endtr--></option>
							<option value="03"><!--#tr id="mar"-->Mar<!--#endtr--></option>
							<option value="04"><!--#tr id="apr"-->Apr<!--#endtr--></option>
							<option value="05"><!--#tr id="may"-->May<!--#endtr--></option>
							<option value="06"><!--#tr id="jun"-->Jun<!--#endtr--></option>
							<option value="07"><!--#tr id="jul"-->Jul<!--#endtr--></option>
							<option value="08"><!--#tr id="aug"-->Aug<!--#endtr--></option>
							<option value="09"><!--#tr id="sep"-->Sep<!--#endtr--></option>
							<option value="10"><!--#tr id="oct"-->Oct<!--#endtr--></option>
							<option value="11"><!--#tr id="nov"-->Nov<!--#endtr--></option>
							<option value="12"><!--#tr id="dec"-->Dec<!--#endtr--></option>
						</select>
					</td>
					<td><!--#tr id="day"-->Day<!--#endtr--></td>
					<td>
						<select id="manual_day_select" name="manual_day_select">
							<option value="01" selected="selected">01</option>
							<option value="02">02</option>
							<option value="03">03</option>
							<option value="04">04</option>
							<option value="05">05</option>
							<option value="06">06</option>
							<option value="07">07</option>
							<option value="08">08</option>
							<option value="09">09</option>
							<option value="10">10</option>
							<option value="11">11</option>
							<option value="12">12</option>
							<option value="13">13</option>
							<option value="14">14</option>
							<option value="15">15</option>
							<option value="16">16</option>
							<option value="17">17</option>
							<option value="18">18</option>
							<option value="19">19</option>
							<option value="20">20</option>
							<option value="21">21</option>
							<option value="22">22</option>
							<option value="23">23</option>
							<option value="24">24</option>
							<option value="25">25</option>
							<option value="26">26</option>
							<option value="27">27</option>
							<option value="28">28</option>
							<option value="29">29</option>
							<option value="30">30</option>
							<option value="31">31</option>
						</select>
					</td>
				</tr>
				<tr>
					<td><!--#tr id="hour"-->Hour<!--#endtr--></td>
					<td>
						<select id="manual_hour_select" name="manual_hour_select">						
							<option value="00" selected="selected">00</option>
							<option value="01">01</option>
							<option value="02">02</option>
							<option value="03">03</option>
							<option value="04">04</option>
							<option value="05">05</option>
							<option value="06">06</option>
							<option value="07">07</option>
							<option value="08">08</option>
							<option value="09">09</option>
							<option value="10">10</option>
							<option value="11">11</option>
							<option value="12">12</option>
							<option value="13">13</option>
							<option value="14">14</option>
							<option value="15">15</option>
							<option value="16">16</option>
							<option value="17">17</option>
							<option value="18">18</option>
							<option value="19">19</option>
							<option value="20">20</option>
							<option value="21">21</option>
							<option value="22">22</option>
							<option value="23">23</option>
						</select>
					</td>
					<td><!--#tr id="minute"-->Minute<!--#endtr--></td>
					<td>
						<select id="manual_min_select" name="manual_min_select">
							<option value="00" selected="selected">00</option>
							<option value="01">01</option>
							<option value="02">02</option>
							<option value="03">03</option>
							<option value="04">04</option>
							<option value="05">05</option>
							<option value="06">06</option>
							<option value="07">07</option>
							<option value="08">08</option>
							<option value="09">09</option>
							<option value="10">10</option>
							<option value="11">11</option>
							<option value="12">12</option>
							<option value="13">13</option>
							<option value="14">14</option>
							<option value="15">15</option>
							<option value="16">16</option>
							<option value="17">17</option>
							<option value="18">18</option>
							<option value="19">19</option>
							<option value="20">20</option>
							<option value="21">21</option>
							<option value="22">22</option>
							<option value="23">23</option>
							<option value="24">24</option>
							<option value="25">25</option>
							<option value="26">26</option>
							<option value="27">27</option>
							<option value="28">28</option>
							<option value="29">29</option>
							<option value="30">30</option>
							<option value="31">31</option>
							<option value="32">32</option>
							<option value="33">33</option>
							<option value="34">34</option>
							<option value="35">35</option>
							<option value="36">36</option>
							<option value="37">37</option>
							<option value="38">38</option>
							<option value="39">39</option>
							<option value="40">40</option>
							<option value="41">41</option>
							<option value="42">42</option>
							<option value="43">43</option>
							<option value="44">44</option>
							<option value="45">45</option>
							<option value="46">46</option>
							<option value="47">47</option>
							<option value="48">48</option>
							<option value="49">49</option>
							<option value="50">50</option>
							<option value="51">51</option>
							<option value="52">52</option>
							<option value="53">53</option>
							<option value="54">54</option>
							<option value="55">55</option>
							<option value="56">56</option>
							<option value="57">57</option>
							<option value="58">58</option>
							<option value="59">59</option>
						</select>
					</td>
					<td><!--#tr id="second"-->Second<!--#endtr--></td>
					<td>
						<select id="manual_sec_select" name="manual_sec_select">
							<option value="00" selected="selected">00</option>
							<option value="01">01</option>
							<option value="02">02</option>
							<option value="03">03</option>
							<option value="04">04</option>
							<option value="05">05</option>
							<option value="06">06</option>
							<option value="07">07</option>
							<option value="08">08</option>
							<option value="09">09</option>
							<option value="10">10</option>
							<option value="11">11</option>
							<option value="12">12</option>
							<option value="13">13</option>
							<option value="14">14</option>
							<option value="15">15</option>
							<option value="16">16</option>
							<option value="17">17</option>
							<option value="18">18</option>
							<option value="19">19</option>
							<option value="20">20</option>
							<option value="21">21</option>
							<option value="22">22</option>
							<option value="23">23</option>
							<option value="24">24</option>
							<option value="25">25</option>
							<option value="26">26</option>
							<option value="27">27</option>
							<option value="28">28</option>
							<option value="29">29</option>
							<option value="30">30</option>
							<option value="31">31</option>
							<option value="32">32</option>
							<option value="33">33</option>
							<option value="34">34</option>
							<option value="35">35</option>
							<option value="36">36</option>
							<option value="37">37</option>
							<option value="38">38</option>
							<option value="39">39</option>
							<option value="40">40</option>
							<option value="41">41</option>
							<option value="42">42</option>
							<option value="43">43</option>
							<option value="44">44</option>
							<option value="45">45</option>
							<option value="46">46</option>
							<option value="47">47</option>
							<option value="48">48</option>
							<option value="49">49</option>
							<option value="50">50</option>
							<option value="51">51</option>
							<option value="52">52</option>
							<option value="53">53</option>
							<option value="54">54</option>
							<option value="55">55</option>
							<option value="56">56</option>
							<option value="57">57</option>
							<option value="58">58</option>
							<option value="59">59</option>
						</select>
					</td>
				</tr>
			</table>
		</td>
	</tr>
</table>
</div>

<table width="100%" class="tbl_main">
  <tr align="center" valign="middle">
    <td>
	  <input type="submit" class="button1" value="<!--#tr id="apply"-->Apply<!--#endtr-->"> &nbsp; &nbsp;
      <input type="reset" class="button1" value="<!--#tr id="cancel"-->Cancel<!--#endtr-->" onClick="window.location.reload()">
    </td>
  </tr>
</table>

<input type="hidden" id="timeTag" name="timeTag" value="">
</form>

</td></tr></table>
	<!-- InstanceEndEditable -->
	</div>
</div>
					</td>
				</tr>
			</table>
    		<!--END MAIN TABLE -->
</div>
<div style="background-color: transparent;background-attachment: scroll;background-image: url(../images/bg_main2.png); background-position: right bottom; height: 50px;"><div></div></div>
</div>
		</td>
	</tr>
</table>
</div>

<div class="footer" >
<table border="0" cellpadding="0" cellspacing="0"  style="position:static; width:940px; margin:20px auto 0px auto ">
    <tr>
		<td>
			<form method="post" name="Lang" action="/goform/setSysLang">
			<table border="0" cellpadding="2" cellspacing="2" summary="" align="center" style="display:none">
				<tr><td>
					<input type="hidden" name="token" value="<% genToken(); %>">
					<select name="langSelection" id="langSelection" onchange="doLangSet();">
					<option value="EN" selected="selected">English</option>
					<option value="DE">Deutsch</option>
					<option value="FR">French</option>
					<option value="ESP">Espanol</option>
					<option value="RU">Russian</option>
					</select>
					<input type="hidden" id="redirect_url" name="redirect_url" value="/" />
				</td></tr>
			</table>
			</form>
		</td>
		<td class="txt_footer">
			<!--#tr id="bottom.copyright"-->Copyright &copy; 2014 TRENDnet. All Rights Reserved.<!--#endtr-->
		</td>
		<td align="right" class="txt_footer">
			<img src="../images/icons_warranty_1.png"><a href="http://www.trendnet.com/register" target="_blank" style="margin: 0 0 0 10px;line-height:25px;vertical-align: top;"><!--#tr id="bottom.product.registration"-->Product Warranty Registration<!--#endtr--></a>&nbsp;&nbsp;&nbsp;
		</td>
	</tr>
</table>
</div>
</body>
<!-- InstanceEnd --></html>
