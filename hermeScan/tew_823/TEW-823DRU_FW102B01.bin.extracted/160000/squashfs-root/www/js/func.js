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
function wait_page()
{	
	totalWaitTime=3;

	if (percent == 0)
	{
		renewClock=100 / ((totalWaitTime*1000)/renewTime);
		//redirectURL = ".." + location.pathname;
		document.getElementById("mainform").style.display = "none";
		document.getElementById("waitform").innerHTML = "<table bolder=\"0\" width=\"600\"><tr><td colspan=\"2\"><font color=white>The device is applying changes, please wait......</font></td></tr><tr><td width=\"95%\"><table align=\"left\" bgcolor=\"#FFFFFF\" cellpadding=\"0\" cellspacing=\"0\" bordercolor=\"#000000\" style=\"border-style: solid; border-width: 1px\"><tr><td width=545 align=\"left\"><table id=\"progress\" bgcolor=\"blue\" height=\"25\"><tr><td></td></tr></table></td></tr></table></td><td width=\"5%\"><font color=white><span id=\"progressValue\">&nbsp;</span></font></td></tr></table>";
	}
	percent+=renewClock;
	if (percent > 100) {
		if(redirectURL == null || redirectURL == "")
			redirectURL = "/";
		window.location.reload();
		return;
	}
	document.getElementById("progress").style.width = Math.round(percent) + "%";
	document.getElementById("progressValue").innerHTML = Math.round(percent) + "%";
	window.setTimeout("wait_page()", renewTime);
}

function upgrade_wait_page()
{	
	totalWaitTime=3;

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
		document.getElementById("waitform").innerHTML = "<table bolder=\"0\" width=\"600\"><tr><td colspan=\"2\"><font color=white>The device is applying changes, please wait......</font></td></tr><tr><td width=\"95%\"><table align=\"left\" bgcolor=\"#FFFFFF\" cellpadding=\"0\" cellspacing=\"0\" bordercolor=\"#000000\" style=\"border-style: solid; border-width: 1px\"><tr><td width=545 align=\"left\"><table id=\"progress\" bgcolor=\"blue\" height=\"25\"><tr><td></td></tr></table></td></tr></table></td><td width=\"5%\"><font color=white><span id=\"progressValue\">&nbsp;</span></font></td></tr></table>";
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
	totalWaitTime=3;

	if (percent == 0)
	{
		document.getElementById("mainform").style.display = "none";
		document.getElementById("waitform").innerHTML = "<table bolder=\"0\" width=\"600\"><tr><td colspan=\"2\"><font color=white>The device is applying changes, please wait......</font></td></tr><tr><td width=\"95%\"><table align=\"left\" bgcolor=\"#FFFFFF\" cellpadding=\"0\" cellspacing=\"0\" bordercolor=\"#000000\" style=\"border-style: solid; border-width: 1px\"><tr><td width=545 align=\"left\"><table id=\"progress\" bgcolor=\"blue\" height=\"25\"><tr><td></td></tr></table></td></tr></table></td><td width=\"5%\"><font color=white><span id=\"progressValue\">&nbsp;</span></font></td></tr></table>";
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
	totalWaitTime=10;

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
			window.location.reload();
		}
	}
		
	if (percent == 0)
	{
		renewClock=100 / ((totalWaitTime*1000)/renewTime);
		//redirectURL = ".." + location.pathname;
		document.getElementById("mainform").style.display = "none";
		document.getElementById("waitform").innerHTML = "<table bolder=\"0\" width=\"600\"><tr><td colspan=\"2\"><font color=white>Rebooting, please wait......</font></td></tr><tr><td width=\"95%\"><table align=\"left\" bgcolor=\"#FFFFFF\" cellpadding=\"0\" cellspacing=\"0\" bordercolor=\"#000000\" style=\"border-style: solid; border-width: 1px\"><tr><td width=545 align=\"left\"><table id=\"progress\" bgcolor=\"blue\" height=\"25\"><tr><td></td></tr></table></td></tr></table></td><td width=\"5%\"><font color=white><span id=\"progressValue\">&nbsp;</span></font></td></tr></table>";
	}
	percent+=renewClock;
	if (percent > 100) {
		if(redirectURL == null || redirectURL == "")
			redirectURL = "/";
		window.location.reload();
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
	totalWaitTime=10;

	if (percent == 0)
	{
		document.getElementById("mainform").style.display = "none";
		document.getElementById("waitform").innerHTML = "<table bolder=\"0\" width=\"600\"><tr><td colspan=\"2\"><font color=white>Rebooting, please wait......</font></td></tr><tr><td width=\"95%\"><table align=\"left\" bgcolor=\"#FFFFFF\" cellpadding=\"0\" cellspacing=\"0\" bordercolor=\"#000000\" style=\"border-style: solid; border-width: 1px\"><tr><td width=545 align=\"left\"><table id=\"progress\" bgcolor=\"blue\" height=\"25\"><tr><td></td></tr></table></td></tr></table></td><td width=\"5%\"><font color=white><span id=\"progressValue\">&nbsp;</span></font></td></tr></table>";
	}
	percent+=1;
	if (percent > 100) {
		if(redirectURL == null || redirectURL == "")
			redirectURL = "/";
		window.location.reload();
		
		window.clearInterval(intval);
		intval="";
		
		return;
	}
	document.getElementById("progress").style.width = Math.round(percent) + "%";
	document.getElementById("progressValue").innerHTML = Math.round(percent) + "%";
}

function apply_reboot_page()
{	
	totalWaitTime=10;

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
			window.location.reload();
		}
	}
		
	if (percent == 0)
	{
		renewClock=100 / ((totalWaitTime*1000)/renewTime);
		//redirectURL = ".." + location.pathname;
		document.getElementById("mainform").style.display = "none";
		document.getElementById("waitform").innerHTML = "<table bolder=\"0\" width=\"600\"><tr><td colspan=\"2\"><font color=white>The device is applying changes and will need to reboot, please wait......</font></td></tr><tr><td width=\"95%\"><table align=\"left\" bgcolor=\"#FFFFFF\" cellpadding=\"0\" cellspacing=\"0\" bordercolor=\"#000000\" style=\"border-style: solid; border-width: 1px\"><tr><td width=545 align=\"left\"><table id=\"progress\" bgcolor=\"blue\" height=\"25\"><tr><td></td></tr></table></td></tr></table></td><td width=\"5%\"><font color=white><span id=\"progressValue\">&nbsp;</span></font></td></tr></table>";
	}
	percent+=renewClock;
	if (percent > 100) {
		if(redirectURL == null || redirectURL == "")
			redirectURL = "/";
		window.location.reload();
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
	totalWaitTime=10;

	if (percent == 0)
	{
		document.getElementById("mainform").style.display = "none";
		document.getElementById("waitform").innerHTML = "<table bolder=\"0\" width=\"600\"><tr><td colspan=\"2\"><font color=white>The device is applying changes and will need to reboot, please wait......</font></td></tr><tr><td width=\"95%\"><table align=\"left\" bgcolor=\"#FFFFFF\" cellpadding=\"0\" cellspacing=\"0\" bordercolor=\"#000000\" style=\"border-style: solid; border-width: 1px\"><tr><td width=545 align=\"left\"><table id=\"progress\" bgcolor=\"blue\" height=\"25\"><tr><td></td></tr></table></td></tr></table></td><td width=\"5%\"><font color=white><span id=\"progressValue\">&nbsp;</span></font></td></tr></table>";
	}
	percent+=1;
	if (percent > 100) {
		if(redirectURL == null || redirectURL == "")
			redirectURL = "/";
		window.location.reload();
		
		window.clearInterval(intval);
		intval="";
		
		return;
	}
	document.getElementById("progress").style.width = Math.round(percent) + "%";
	document.getElementById("progressValue").innerHTML = Math.round(percent) + "%";
}

function fail_reboot()
{	
	totalWaitTime=10;

	if ((Math.round(percent) > 50) && (Math.round(percent)%5) == 0) {
		if (currectIP != "")
		window.location.reload();
	}
		
	if (percent == 0)
	{
		renewClock=100 / ((totalWaitTime*1000)/renewTime);
		//redirectURL = ".." + location.pathname;
		document.getElementById("mainform").style.display = "none";
		document.getElementById("waitform").innerHTML = "<table bolder=\"0\" width=\"600\"><tr><td colspan=\"2\"><font color=white>Invalid firmware file. The firmware cannot be upgraded. The router will reboot now to ensure the device returns to normal operation.</font></td></tr><tr><td colspan=\"2\"><font color=white>Rebooting, please wait......</font></td></tr><tr><td width=\"95%\"><table align=\"left\" bgcolor=\"#FFFFFF\" cellpadding=\"0\" cellspacing=\"0\" bordercolor=\"#000000\" style=\"border-style: solid; border-width: 1px\"><tr><td width=545 align=\"left\"><table id=\"progress\" bgcolor=\"blue\" height=\"25\"><tr><td></td></tr></table></td></tr></table></td><td width=\"5%\"><font color=white><span id=\"progressValue\">&nbsp;</span></font></td></tr></table>";
	}
	percent+=renewClock;
	if (percent > 100) {
		if(redirectURL == null || redirectURL == "")
			redirectURL = "/";
		window.location.reload();
		return;
	}
	document.getElementById("progress").style.width = Math.round(percent) + "%";
	document.getElementById("progressValue").innerHTML = Math.round(percent) + "%";
	window.setTimeout("reboot_page()", renewTime);
}
// ryan add for upgrade fail to reboot
function apply_fail_reboot()
{	
	totalWaitTime=10;

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
		window.location.reload();
		}
	}
		
	if (percent == 0)
	{
		renewClock=100 / ((totalWaitTime*1000)/renewTime);
		//redirectURL = ".." + location.pathname;
		document.getElementById("mainform").style.display = "none";
		document.getElementById("waitform").innerHTML = "<table bolder=\"0\" width=\"600\"><tr><td colspan=\"2\"><font color=white>Invalid firmware file. The firmware cannot be upgraded. The router will reboot now to ensure the device returns to normal operation.</font></td></tr><tr><td width=\"95%\"><table align=\"left\" bgcolor=\"#FFFFFF\" cellpadding=\"0\" cellspacing=\"0\" bordercolor=\"#000000\" style=\"border-style: solid; border-width: 1px\"><tr><td width=545 align=\"left\"><table id=\"progress\" bgcolor=\"blue\" height=\"25\"><tr><td></td></tr></table></td></tr></table></td><td width=\"5%\"><font color=white><span id=\"progressValue\">&nbsp;</span></font></td></tr></table>";
	}
	percent+=renewClock;
	if (percent > 100) {
		if(redirectURL == null || redirectURL == "")
			redirectURL = "/";
		window.location.reload();
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
	totalWaitTime=10;

	if (percent == 0)
	{
		document.getElementById("mainform").style.display = "none";
		document.getElementById("waitform").innerHTML = "<table bolder=\"0\" width=\"600\"><tr><td colspan=\"2\"><font color=white>Invalid firmware file. The firmware cannot be upgraded. The router will reboot now to ensure the device returns to normal operation.</font></td></tr><tr><td width=\"95%\"><table align=\"left\" bgcolor=\"#FFFFFF\" cellpadding=\"0\" cellspacing=\"0\" bordercolor=\"#000000\" style=\"border-style: solid; border-width: 1px\"><tr><td width=545 align=\"left\"><table id=\"progress\" bgcolor=\"blue\" height=\"25\"><tr><td></td></tr></table></td></tr></table></td><td width=\"5%\"><font color=white><span id=\"progressValue\">&nbsp;</span></font></td></tr></table>";
	}
	percent+=1;
	if (percent > 100) {
		if(redirectURL == null || redirectURL == "")
			redirectURL = "/";
		window.location.reload();
		
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