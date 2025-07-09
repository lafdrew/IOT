/* 
 * func.js - Function Define.
 *
 * Copyright (c) U-Media Communications, Inc. All Rights Reserved.
 *
 * $Id: v1.0 12-Dec-2007 Jacky.Yang Exp $
 */

var totalWaitTime=20; //second
var renewTime=60; //millisecond, progress reflash clock.
//var renewClock=100 / ((totalWaitTime*1000)/renewTime);
var renewClock;
var percent=0;
var redirectURL;
var currectIP;
var intval="";
var apply_intval_time = 1000;
var wan_setting_NeedReboot = 0;
function wait_page()
{	
	if (percent == 0)
	{
		renewClock=100 / ((totalWaitTime*1000)/renewTime);
		//redirectURL = ".." + location.pathname;
		document.getElementById("mainform").style.display = "none";
		document.getElementById("waitform").innerHTML = "<table bolder=\"0\" width=\"600\"><tr><td colspan=\"2\"><font color=white><!--#tr id="func.js.4"-->The device is applying changes, please wait......<!--#endtr--></font></td></tr><tr><td width=\"95%\"><table align=\"left\" bgcolor=\"#FFFFFF\" cellpadding=\"0\" cellspacing=\"0\" bordercolor=\"#000000\" style=\"border-style: solid; border-width: 1px\"><tr><td width=545 align=\"left\"><table id=\"progress\" bgcolor=\"blue\" height=\"25\"><tr><td></td></tr></table></td></tr></table></td><td width=\"5%\"><font color=white><span id=\"progressValue\">&nbsp;</span></font></td></tr></table>";
	}
	percent+=renewClock;
	
	var now_location = location.href;
	if(now_location.indexOf("/adm/schedule.asp") != -1) {
		if (percent > 60) {
			if(window.opener && !window.opener.closed){
				window.opener.document.cookie = "new_schedule=" + new_schedule;
				window.opener.location.reload();
				window.close();
			}
		}
	}
	
	if (percent > 100) {
		if(redirectURL == null || redirectURL == "")
			redirectURL = "/";
		location.href = redirectURL;
		return;
	}
	document.getElementById("progress").style.width = Math.round(percent) + "%";
	document.getElementById("progressValue").innerHTML = Math.round(percent) + "%";
	window.setTimeout("wait_page()", renewTime);
}

function wan_setting_wait_page()
{	
	var redirect_time;
	if (wan_setting_NeedReboot == 1) {
		redirectURL = "/";
		redirect_time = 100;
	} else {
		redirectURL = "/internet/wan.asp";
		redirect_time = 70;
	}
	
	if (percent == 0)
	{
		renewClock=100 / ((totalWaitTime*1000)/renewTime);
		//redirectURL = ".." + location.pathname;
		document.getElementById("mainform").style.display = "none";
		document.getElementById("waitform").innerHTML = "<table bolder=\"0\" width=\"600\"><tr><td colspan=\"2\"><font color=white><!--#tr id="func.js.4"-->The device is applying changes, please wait......<!--#endtr--></font></td></tr><tr><td width=\"95%\"><table align=\"left\" bgcolor=\"#FFFFFF\" cellpadding=\"0\" cellspacing=\"0\" bordercolor=\"#000000\" style=\"border-style: solid; border-width: 1px\"><tr><td width=545 align=\"left\"><table id=\"progress\" bgcolor=\"blue\" height=\"25\"><tr><td></td></tr></table></td></tr></table></td><td width=\"5%\"><font color=white><span id=\"progressValue\">&nbsp;</span></font></td></tr></table>";
	}
	percent+=renewClock;
	if (percent > redirect_time) {
		if(redirectURL == null || redirectURL == "")
			redirectURL = "/";
		location.href = redirectURL;
		return;
	}
	document.getElementById("progress").style.width = Math.round(percent) + "%";
	document.getElementById("progressValue").innerHTML = Math.round(percent) + "%";
	window.setTimeout("wan_setting_wait_page()", renewTime);
}

function upgrade_wait_page()
{	
	if(myBrowser()=="Chrome" || myBrowser()=="FF")//Griffin Chrome and FF use setTimeout can't work
	{
		if(intval=="")
		{
			intval=window.setInterval("upgrade_wait_page_intval()", 1000);//Chorme and FF always 1s
		}
		return;
	}
	
	if (percent == 0)
	{
		renewClock=100 / ((totalWaitTime*1000)/renewTime);
		//redirectURL = ".." + location.pathname;
		document.getElementById("mainform").style.display = "none";
		document.getElementById("waitform").innerHTML = "<table bolder=\"0\" width=\"600\"><tr><td colspan=\"2\"><font color=white><!--#tr id="func.js.4"-->The device is applying changes, please wait......<!--#endtr--></font></td></tr><tr><td width=\"95%\"><table align=\"left\" bgcolor=\"#FFFFFF\" cellpadding=\"0\" cellspacing=\"0\" bordercolor=\"#000000\" style=\"border-style: solid; border-width: 1px\"><tr><td width=545 align=\"left\"><table id=\"progress\" bgcolor=\"blue\" height=\"25\"><tr><td></td></tr></table></td></tr></table></td><td width=\"5%\"><font color=white><span id=\"progressValue\">&nbsp;</span></font></td></tr></table>";
	}
	percent+=renewClock;
	if (percent > 100) {
		totalWaitTime = 47; //second
		percent	=0 ;
		apply_reboot_page();	
		return;
	}
	document.getElementById("progress").style.width = Math.round(percent) + "%";
	document.getElementById("progressValue").innerHTML = Math.round(percent) + "%";
	window.setTimeout("upgrade_wait_page()", renewTime);
}


//Ryan add for chrome and FF
function upgrade_wait_page_intval()
{	
	if (percent == 0)
	{
		document.getElementById("mainform").style.display = "none";
		document.getElementById("waitform").innerHTML = "<table bolder=\"0\" width=\"600\"><tr><td colspan=\"2\"><font color=white><!--#tr id="func.js.4"-->The device is applying changes, please wait......<!--#endtr--></font></td></tr><tr><td width=\"95%\"><table align=\"left\" bgcolor=\"#FFFFFF\" cellpadding=\"0\" cellspacing=\"0\" bordercolor=\"#000000\" style=\"border-style: solid; border-width: 1px\"><tr><td width=545 align=\"left\"><table id=\"progress\" bgcolor=\"blue\" height=\"25\"><tr><td></td></tr></table></td></tr></table></td><td width=\"5%\"><font color=white><span id=\"progressValue\">&nbsp;</span></font></td></tr></table>";
	}
	percent+=1;
	if (percent > 100) {
		
		percent	=0 ;
		window.clearInterval(intval);
		intval="";
		apply_intval_time=470;
		apply_reboot_page();
		return;
	}
	document.getElementById("progress").style.width = Math.round(percent) + "%";
	document.getElementById("progressValue").innerHTML = Math.round(percent) + "%";
}

function reboot_page()
{	
	if(myBrowser()=="Chrome" || myBrowser()=="FF")//Griffin Chrome and FF use setTimeout can't work
	{
		if(intval=="")
		{
			intval=window.setInterval("reboot_page_intval()", 1000);//Chorme and FF always 1s
		}
		return;
	}
	
	if(myBrowser()!="Safari" && myBrowser()!="Chrome")
	{
		if ((Math.round(percent) > 50) && (Math.round(percent)%5) == 0) {
			if (currectIP != "")
				rebootRedirect.location.href="http://" + currectIP +"/rebootredirect.asp";
		}
	}
		
	if (percent == 0)
	{
		renewClock=100 / ((totalWaitTime*1000)/renewTime);
		//redirectURL = ".." + location.pathname;
		document.getElementById("mainform").style.display = "none";
		document.getElementById("waitform").innerHTML = "<table bolder=\"0\" width=\"600\"><tr><td colspan=\"2\"><font color=white><!--#tr id="func.js.2"-->Rebooting, please wait......<!--#endtr--></font></td></tr><tr><td width=\"95%\"><table align=\"left\" bgcolor=\"#FFFFFF\" cellpadding=\"0\" cellspacing=\"0\" bordercolor=\"#000000\" style=\"border-style: solid; border-width: 1px\"><tr><td width=545 align=\"left\"><table id=\"progress\" bgcolor=\"blue\" height=\"25\"><tr><td></td></tr></table></td></tr></table></td><td width=\"5%\"><font color=white><span id=\"progressValue\">&nbsp;</span></font></td></tr></table>";
	}
	percent+=renewClock;
	if (percent > 100) {
		if(redirectURL == null || redirectURL == "")
			redirectURL = "/";
		location.href = redirectURL;
		if(myBrowser()!="Safari" && myBrowser()!="Chrome")
			window.setTimeout("reboot_page()", 5000);
			
		return;
	}
	document.getElementById("progress").style.width = Math.round(percent) + "%";
	document.getElementById("progressValue").innerHTML = Math.round(percent) + "%";
	
	window.setTimeout("reboot_page()", renewTime);
}

//Griffin add for chrome and FF
function reboot_page_intval()
{	
	if (percent == 0)
	{
		document.getElementById("mainform").style.display = "none";
		document.getElementById("waitform").innerHTML = "<table bolder=\"0\" width=\"600\"><tr><td colspan=\"2\"><font color=white><!--#tr id="func.js.2"-->Rebooting, please wait......<!--#endtr--></font></td></tr><tr><td width=\"95%\"><table align=\"left\" bgcolor=\"#FFFFFF\" cellpadding=\"0\" cellspacing=\"0\" bordercolor=\"#000000\" style=\"border-style: solid; border-width: 1px\"><tr><td width=545 align=\"left\"><table id=\"progress\" bgcolor=\"blue\" height=\"25\"><tr><td></td></tr></table></td></tr></table></td><td width=\"5%\"><font color=white><span id=\"progressValue\">&nbsp;</span></font></td></tr></table>";
	}
	percent+=1;
	if (percent > 100) {
		if(redirectURL == null || redirectURL == "")
			redirectURL = "/";
		location.href = redirectURL;
		
		window.clearInterval(intval);
		intval="";
		
		return;
	}
	document.getElementById("progress").style.width = Math.round(percent) + "%";
	document.getElementById("progressValue").innerHTML = Math.round(percent) + "%";
}

function apply_reboot_page()
{	
	if(myBrowser()=="Chrome" || myBrowser()=="FF")//Griffin Chrome and FF use setTimeout can't work
	{
		if(intval=="")
		{
			intval=window.setInterval("apply_reboot_page_intval()", apply_intval_time);//Chorme and FF always 1s
		}
		return;
	}
	
	if(myBrowser()!="Safari" && myBrowser()!="Chrome")
	{
		if ((Math.round(percent) > 50) && (Math.round(percent)%5) == 0) {
			if (currectIP != "")
				rebootRedirect.location.href="http://" + currectIP +"/rebootredirect.asp";
		}
	}
		
	if (percent == 0)
	{
		renewClock=100 / ((totalWaitTime*1000)/renewTime);
		//redirectURL = ".." + location.pathname;
		document.getElementById("mainform").style.display = "none";
		document.getElementById("waitform").innerHTML = "<table bolder=\"0\" width=\"600\"><tr><td colspan=\"2\"><font color=white><!--#tr id="func.js.5"-->The device is applying changes and will need to reboot, please wait......<!--#endtr--></font></td></tr><tr><td width=\"95%\"><table align=\"left\" bgcolor=\"#FFFFFF\" cellpadding=\"0\" cellspacing=\"0\" bordercolor=\"#000000\" style=\"border-style: solid; border-width: 1px\"><tr><td width=545 align=\"left\"><table id=\"progress\" bgcolor=\"blue\" height=\"25\"><tr><td></td></tr></table></td></tr></table></td><td width=\"5%\"><font color=white><span id=\"progressValue\">&nbsp;</span></font></td></tr></table>";
	}
	percent+=renewClock;
	if (percent > 100) {
		if(redirectURL == null || redirectURL == "")
			redirectURL = "/";
		location.href = redirectURL;
		if(myBrowser()!="Safari" && myBrowser()!="Chrome")
			window.setTimeout("apply_reboot_page()", 5000);
			
		return;
	}
	document.getElementById("progress").style.width = Math.round(percent) + "%";
	document.getElementById("progressValue").innerHTML = Math.round(percent) + "%";
	
	window.setTimeout("apply_reboot_page()", renewTime);
}

//Griffin add for chrome and FF
function apply_reboot_page_intval()
{	
	if (percent == 0)
	{
		document.getElementById("mainform").style.display = "none";
		document.getElementById("waitform").innerHTML = "<table bolder=\"0\" width=\"600\"><tr><td colspan=\"2\"><font color=white><!--#tr id="func.js.5"-->The device is applying changes and will need to reboot, please wait......<!--#endtr--></font></td></tr><tr><td width=\"95%\"><table align=\"left\" bgcolor=\"#FFFFFF\" cellpadding=\"0\" cellspacing=\"0\" bordercolor=\"#000000\" style=\"border-style: solid; border-width: 1px\"><tr><td width=545 align=\"left\"><table id=\"progress\" bgcolor=\"blue\" height=\"25\"><tr><td></td></tr></table></td></tr></table></td><td width=\"5%\"><font color=white><span id=\"progressValue\">&nbsp;</span></font></td></tr></table>";
	}
	percent+=1;
	if (percent > 100) {
		if(redirectURL == null || redirectURL == "")
			redirectURL = "/";
		location.href = redirectURL;
		
		window.clearInterval(intval);
		intval="";
		
		return;
	}
	document.getElementById("progress").style.width = Math.round(percent) + "%";
	document.getElementById("progressValue").innerHTML = Math.round(percent) + "%";
}

function fail_reboot()
{	
	if ((Math.round(percent) > 50) && (Math.round(percent)%5) == 0) {
		if (currectIP != "")
			rebootRedirect.location.href="http://" + currectIP +"/rebootredirect.asp";
	}
		
	if (percent == 0)
	{
		renewClock=100 / ((totalWaitTime*1000)/renewTime);
		//redirectURL = ".." + location.pathname;
		document.getElementById("mainform").style.display = "none";
		document.getElementById("waitform").innerHTML = "<table bolder=\"0\" width=\"600\"><tr><td colspan=\"2\"><font color=white><!--#tr id="func.js.3"-->Invalid firmware file. The firmware cannot be upgraded. The router will reboot now to ensure the device returns to normal operation.<!--#endtr--></font></td></tr><tr><td colspan=\"2\"><font color=white><!--#tr id="func.js.2"-->Rebooting, please wait......<!--#endtr--></font></td></tr><tr><td width=\"95%\"><table align=\"left\" bgcolor=\"#FFFFFF\" cellpadding=\"0\" cellspacing=\"0\" bordercolor=\"#000000\" style=\"border-style: solid; border-width: 1px\"><tr><td width=545 align=\"left\"><table id=\"progress\" bgcolor=\"blue\" height=\"25\"><tr><td></td></tr></table></td></tr></table></td><td width=\"5%\"><font color=white><span id=\"progressValue\">&nbsp;</span></font></td></tr></table>";
	}
	percent+=renewClock;
	if (percent > 100) {
		if(redirectURL == null || redirectURL == "")
			redirectURL = "/";
		location.href = redirectURL;
		return;
	}
	document.getElementById("progress").style.width = Math.round(percent) + "%";
	document.getElementById("progressValue").innerHTML = Math.round(percent) + "%";
	window.setTimeout("reboot_page()", renewTime);
}
// ryan add for upgrade fail to reboot
function apply_fail_reboot()
{	
	if(myBrowser()=="Chrome" || myBrowser()=="FF")//Griffin Chrome and FF use setTimeout can't work
	{
		if(intval=="")
		{
			intval=window.setInterval("apply_fail_page_intval()", apply_intval_time);//Chorme and FF always 1s
		}
		return;
	}
	
	if(myBrowser()!="Safari" && myBrowser()!="Chrome")
	{
		if ((Math.round(percent) > 50) && (Math.round(percent)%5) == 0) {
			if (currectIP != "")
				rebootRedirect.location.href="http://" + currectIP +"/rebootredirect.asp";
		}
	}
		
	if (percent == 0)
	{
		renewClock=100 / ((totalWaitTime*1000)/renewTime);
		//redirectURL = ".." + location.pathname;
		document.getElementById("mainform").style.display = "none";
		document.getElementById("waitform").innerHTML = "<table bolder=\"0\" width=\"600\"><tr><td colspan=\"2\"><font color=white><!--#tr id="func.js.3"-->Invalid firmware file. The firmware cannot be upgraded. The router will reboot now to ensure the device returns to normal operation.<!--#endtr--></font></td></tr><tr><td width=\"95%\"><table align=\"left\" bgcolor=\"#FFFFFF\" cellpadding=\"0\" cellspacing=\"0\" bordercolor=\"#000000\" style=\"border-style: solid; border-width: 1px\"><tr><td width=545 align=\"left\"><table id=\"progress\" bgcolor=\"blue\" height=\"25\"><tr><td></td></tr></table></td></tr></table></td><td width=\"5%\"><font color=white><span id=\"progressValue\">&nbsp;</span></font></td></tr></table>";
	}
	percent+=renewClock;
	if (percent > 100) {
		if(redirectURL == null || redirectURL == "")
			redirectURL = "/";
		location.href = redirectURL;
		if(myBrowser()!="Safari" && myBrowser()!="Chrome")
			window.setTimeout("apply_fail_reboot()", 5000);
			
		return;
	}
	document.getElementById("progress").style.width = Math.round(percent) + "%";
	document.getElementById("progressValue").innerHTML = Math.round(percent) + "%";
	
	window.setTimeout("apply_fail_reboot()", renewTime);		
}

function apply_fail_page_intval()
{	
	if (percent == 0)
	{
		document.getElementById("mainform").style.display = "none";
		document.getElementById("waitform").innerHTML = "<table bolder=\"0\" width=\"600\"><tr><td colspan=\"2\"><font color=white><!--#tr id="func.js.3"-->Invalid firmware file. The firmware cannot be upgraded. The router will reboot now to ensure the device returns to normal operation.<!--#endtr--></font></td></tr><tr><td width=\"95%\"><table align=\"left\" bgcolor=\"#FFFFFF\" cellpadding=\"0\" cellspacing=\"0\" bordercolor=\"#000000\" style=\"border-style: solid; border-width: 1px\"><tr><td width=545 align=\"left\"><table id=\"progress\" bgcolor=\"blue\" height=\"25\"><tr><td></td></tr></table></td></tr></table></td><td width=\"5%\"><font color=white><span id=\"progressValue\">&nbsp;</span></font></td></tr></table>";
	}
	percent+=1;
	if (percent > 100) {
		if(redirectURL == null || redirectURL == "")
			redirectURL = "/";
		location.href = redirectURL;
		
		window.clearInterval(intval);
		intval="";
		
		return;
	}
	document.getElementById("progress").style.width = Math.round(percent) + "%";
	document.getElementById("progressValue").innerHTML = Math.round(percent) + "%";
}

//Griffin -check browser version
function myBrowser(){  
	var userAgent = navigator.userAgent; 
	var isOpera = userAgent.indexOf("Opera") > -1; 
	var isIE = userAgent.indexOf("compatible") > -1 && userAgent.indexOf("MSIE") > -1 && !isOpera ; 
	var isFF = userAgent.indexOf("Firefox") > -1 ; 
	var isSafari = userAgent.indexOf("Safari") > -1 && userAgent.indexOf("Chrome") < 1 ; 
	var isChrome = userAgent.indexOf("Chrome") > -1 ; 
	if(isIE){  
	   var IE5 = IE55 = IE6 = IE7 = IE8 = false;  
	   var reIE = new RegExp("MSIE (//d+//.//d+);");  
	   reIE.test(userAgent);  
	   var fIEVersion = parseFloat(RegExp["$1"]);  
	   IE55 = fIEVersion == 5.5 ;  
	   IE6 = fIEVersion == 6.0 ;  
	   IE7 = fIEVersion == 7.0 ;  
	   IE8 = fIEVersion == 8.0 ;  
	   if(IE55){ return "IE55"; }  
	   if(IE6){ return "IE6"; }  
	   if(IE7){ return "IE7"; }  
	   if(IE8){ return "IE8"; }  
	}  
	if(isFF){ return "FF"; }  
	if(isOpera){ return "Opera"; }  
	if(isSafari){ return "Safari"; }  
	if(isChrome){ return "Chrome"; }  
} //myBrowser() end

function CustomAlert(){
    this.render = function(dialog){
        var dialogoverlay = document.getElementById('dialogoverlay');
        var dialogbox = document.getElementById('dialogbox');
        dialogoverlay.style.display = "block";
        dialogoverlay.style.height = "100%";
        dialogbox.style.left = "35%";
        dialogbox.style.top = "20%";
        dialogbox.style.display = "block";
        document.getElementById('dialogboxbody').innerHTML = dialog;
        document.getElementById('dialogboxfoot').innerHTML = '<input type="button" class="button1" style="margin: 10px 0px 10px 0px" value="<!--#tr id="close"-->Close<!--#endtr-->" onclick="Alert.ok()">';

 
    }
	this.ok = function(){
		document.getElementById('dialogbox').style.display = "none";
		document.getElementById('dialogoverlay').style.display = "none";
	}
}
var Alert = new CustomAlert();

function CustomConfirm(){
    this.render = function(dialog,funcyes,yesvalue,funcno,novalue){
    		var dialogoverlay = document.getElementById('dialogoverlay');
        var dialogbox = document.getElementById('dialogbox');
        dialogoverlay.style.display = "block";
        dialogoverlay.style.height = "100%";
        dialogbox.style.left = "35%";
        dialogbox.style.top = "20%";
        dialogbox.style.display = "block";
        document.getElementById('dialogboxbody').innerHTML = dialog;
        document.getElementById('dialogboxfoot').innerHTML = '<input type="button" class="button1" style="margin: 10px 0px 10px 0px" value="<!--#tr id="ok"-->OK<!--#endtr-->" onclick="Confirm.yes(\''+funcyes+'\',\''+yesvalue+'\');"> <input type="button" class="button1" style="margin: 10px 0px 10px 0px" value="<!--#tr id="cancel"-->Cancel<!--#endtr-->" onclick="Confirm.no(\''+funcno+'\',\''+novalue+'\');">';
     }
	this.no = function(funcno,novalue){
		if(funcno !="")
			window.eval(funcno)(novalue);
		document.getElementById('dialogbox').style.display = "none";
		document.getElementById('dialogoverlay').style.display = "none";
	}
	this.yes = function(funcyes,yesvalue){
		if(funcyes !="")
			window.eval(funcyes)(yesvalue);
		document.getElementById('dialogbox').style.display = "none";
		document.getElementById('dialogoverlay').style.display = "none";
	}
}
var Confirm  = new CustomConfirm();

function prevent_press_enter(e) {
	if (e.keyCode==13) 
		e.preventDefault ? e.preventDefault() : e.returnValue = false;
	
	return true;
}

