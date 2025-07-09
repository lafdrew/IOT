var ruleCount;
var UTCSecond;
var index, docTemp, tz;
var checkWeek, checkStart_hour, checkStart_min, checkEnd_hour, checkEnd_min;
var startStamp, endStamp, nowStamp;
var deviceSysTime = new Date();

var checkLocalTZ = new Date();

function MM_preloadImages() { //v3.0
  var d=document; if(d.images){ if(!d.MM_p) d.MM_p=new Array();
    var i,j=d.MM_p.length,a=MM_preloadImages.arguments; for(i=0; i<a.length; i++)
    if (a[i].indexOf("#")!=0){ d.MM_p[j]=new Image; d.MM_p[j++].src=a[i];}}
}

function MM_swapImgRestore() { //v3.0
  var i,x,a=document.MM_sr; for(i=0;a&&i<a.length&&(x=a[i])&&x.oSrc;i++) x.src=x.oSrc;
}

function MM_findObj(n, d) { //v4.01
  var p,i,x;  if(!d) d=document; if((p=n.indexOf("?"))>0&&parent.frames.length) {
    d=parent.frames[n.substring(p+1)].document; n=n.substring(0,p);}
  if(!(x=d[n])&&d.all) x=d.all[n]; for (i=0;!x&&i<d.forms.length;i++) x=d.forms[i][n];
  for(i=0;!x&&d.layers&&i<d.layers.length;i++) x=MM_findObj(n,d.layers[i].document);
  if(!x && d.getElementById) x=d.getElementById(n); return x;
}

function MM_swapImage() { //v3.0
  var i,j=0,x,a=MM_swapImage.arguments; document.MM_sr=new Array; for(i=0;i<(a.length-2);i+=3)
   if ((x=MM_findObj(a[i]))!=null){document.MM_sr[j++]=x; if(!x.oSrc) x.oSrc=x.src; x.src=a[i+2];}
}

function style_display_on()
{
	if (window.ActiveXObject) { // IE
		return "block";
	}
	else if (window.XMLHttpRequest) { // Mozilla, Safari,...
		return "table";
	}
	return "block";
}

function style_display_on_tr()
{
	if (window.ActiveXObject) { // IE
		return "block";
	}
	else if (window.XMLHttpRequest) { // Mozilla, Safari,...
		return "table-row";
	}
	return "block";
}

function style_display_on_td()
{
	if (window.ActiveXObject) { // IE
		return "block";
	}
	else if (window.XMLHttpRequest) { // Mozilla, Safari,...
		return "table-cell";
	}
	return "block";
}

function style_display_on_tbody()
{
	if (window.ActiveXObject) { // IE
		return "block";
	}
	else if (window.XMLHttpRequest) { // Mozilla, Safari,...
		return "table-row-group";
	}
	return "block";
}

function atoi(str, num)
{
    i=1;
    if(num != 1 ){
        while (i != num && str.length != 0){
            if(str.charAt(0) == '.'){
                i++;
            }
            str = str.substring(1);
        }
        if(i != num )
            return -1;
    }

    for(i=0; i<str.length; i++){
        if(str.charAt(i) == '.'){
            str = str.substring(0, i);
            break;
        }
    }
    if(str.length == 0)
        return -1;
    return parseInt(str, 10);
}

function isAllNum(str)
{
	for (var i=0; i<str.length; i++){
	    if((str.charAt(i) >= '0' && str.charAt(i) <= '9') || (str.charAt(i) == '.' ))
			continue;
		return 0;
	}
	return 1;
}

function alphanumeric(alphane)
{
        var numaric = alphane;
        for(var j=0; j<numaric.length; j++)
                {
                  var alphaa = numaric.charAt(j);
                  var hh = alphaa.charCodeAt(0);
                  if((hh > 47 && hh<58) || (hh > 64 && hh<91) || (hh > 96 && hh<123))
                  {
                  }
                else    {
                         return false;
                  }
                }
 return true;
}

function is_number(value)
{
	var str = value + "";
	return str.match(/^-?\d*\.?\d+$/) ? true : false;
}

function is_port_valid(port)
{
	return (is_number(port) && port >= 0 && port < 65536);
}

function checkInteger(value)
{
	if (value.indexOf(".") > -1) {
		return false;
	}
	return true;
}

function checkRange(str, min, max)
{
	if (str*1 > max || str*1 < min)
		return false;
	return true;
}

function checkMaskRange(str)
{
	m = new Array(255,254,252,248,240,224,192,128,0);

	for(i=0;i<9;i++)
		if (str == m[i])
			return true;

	return false;
}

function checkIpAddr(field, ismask)
{
	if (field.value == "") {
		alert("Error. IP address is empty.");
		return false;
	}

	if (isAllNum(field.value) == 0) {
		alert("It should be a [0-9] number.");
		return false;
	}

	var reg = /^\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}$/;
	if(reg.test(field.value) == false) {
		alert("IP address format error.");
		return false;
	}

	v = new Array(atoi(field.value, 1), atoi(field.value, 2), atoi(field.value, 3), atoi(field.value, 4) );
	if (ismask) {
		// Tom.Hung 2008-09-08 - check subnet mask.
		if (!checkMaskRange(v[0]) || !checkMaskRange(v[1]) || !checkMaskRange(v[2]) || !checkMaskRange(v[3]) ||
			(v[0] < 255 && v[1]+v[2]+v[3] > 0) ||
			(v[0] == 255 && v[1] < 255 && v[2]+v[3] > 0) ||
			(v[0] == 255 && v[1] == 255 && v[2] < 255 && v[3] > 0) ||
			field.value == "0.0.0.0" || field.value == "255.255.255.254" || field.value == "255.255.255.255")
		{
			alert("Mask address format error.");
			return false;
		}
	}
	else {
		if ((!checkRange(v[0], 0, 255)) ||
				(!checkRange(v[1], 0, 255)) ||
				(!checkRange(v[2], 0, 255)) ||
				(!checkRange(v[3], 0, 255)))
		{
			alert("Incorrect IP address settings. The last octet of the IP address must be in the range of 1 to 254.");
			return false;
		}
		if ( v[0] == "0" || v[0] == "127") { // Local IP
			alert(field.value + " is a local IP address.");
			return false;
		} else if ( v[0] == 255 && v[1] == 255 && v[2] == 255 && v[3] == 255) {
			alert(field.value + " is a broadcast IP address.");
			return false;
		} else if ( v[0] >= 1 && v[0] <= 126) { // Class A
			if ( v[1]== 0 && v[2]== 0 && v[3]== 0 ) {
				alert(field.value+" is a Class A network address.");
				return false;
			} else if ( v[1]== 255 && v[2]== 255 && v[3]== 255 ) {
				alert(field.value +" is a Class A broadcast address.");
				return false;
			}
		} else if ( v[0] >= 128 && v[0] <= 191) { // Class B
			if ( v[2]== 0 && v[3]== 0 ) {
				alert(field.value+" is a Class B network address.");
				return false;
			} else if (v[2]== 255 && v[3]== 255) {
				alert(field.value+" is a Class B broadcast address.");
				return false;
			}
		} else if ( v[0] >= 192 && v[0] <= 223) { // Class C
			if ( v[3]== 0 ) {
				alert(field.value+" is a Class C network address.");
				return false;
			} else if ( v[3]== 255 ) {
				alert(field.value+" is a Class C broadcast address.");
				return false;
			}
		} else if ( v[0] >= 224 && v[0] <= 239) { // Class D
				alert(field.value+" is a Class D IP address.");
				return false;
		} else if ( v[0] >= 240 && v[0] <= 255) { // Class E
				alert(field.value+" is a Class E IP address.");
				return false;
		}
	}
	return true;
}

function checkIpRangeFormat(field)
{
	var regIP = /^\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}$/;
	var regIpNetmask = /^\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}\/\d{1,2}$/;
	var regIpRange = /^\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}\-\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}$/;

	if (regIP.test(field.value) == true || regIpNetmask.test(field.value) == true || regIpRange.test(field.value) == true) {
		return true;
	} else {
		return false;
	}
}

function checkIpRangeAddr(field)
{
	var v = new Array(atoi(field, 1), atoi(field, 2), atoi(field, 3), atoi(field, 4));	
	
	if ((!checkRange(v[0], 0, 255)) ||
		(!checkRange(v[1], 0, 255)) ||
		(!checkRange(v[2], 0, 255)) ||
		(!checkRange(v[3], 0, 255)))
	{
		return false;
	}
	
	return true;
}

function checkIpRangeElement(field)
{
	var ipNetmaskSplitter = "/";
	var ipConnector = "-";

	if (field.value.search(ipNetmaskSplitter) != -1) { // IP/Netmask
		var ip_netmask = field.value.split(ipNetmaskSplitter);

		// check IP
		if (!checkIpRangeAddr(ip_netmask[0])) {
			return false;
		}

		// check Netmask
		if (!checkRange(ip_netmask[1], 0, 32)) {
			return false;
		}			
	} else if (field.value.search(ipConnector) != -1) { // Start_Of_IP_addr-End_Of_IP_addr
		var ipRangeAddr = field.value.split(ipConnector);		

		// check start of IP address
		if (!checkIpRangeAddr(ipRangeAddr[0])) {
			return false;
		}

		// check end of IP address
		if (!checkIpRangeAddr(ipRangeAddr[1])) {
			return false;
		}
		
	} else { // IP
		if (!checkIpRangeAddr(field.value)) {
			return false;
		}
	}

	return true;	
}

function checkIpRange(field)
{
	// check IP range format
	if (!checkIpRangeFormat(field)) {
		return false;
	}

	// check IP range element
	if (!checkIpRangeElement(field)) {
		return false;
	}

	return true;
}

function d2b(value)
{
	var num1;
	var num2=null;
	var currnum;
	currnum = 128;

	num1 = eval(value);
	if(num1 >= currnum)
	{
		num2 = "1";
		num1 = num1 - currnum;
		currnum = currnum / 2;
	}
	else
	{
		num2 = "0";
		currnum = currnum / 2;
	}		

	for (p = 1; p <= 7; p++)
	{
		if(num1 >= currnum)
		{
			num2 = num2 + "1";
			num1 = num1 - currnum;
			currnum = currnum / 2;
		}
		else
		{
			num2 = num2 + "0";
			currnum = currnum / 2;
		}
	}
	return num2;
}

function checkIPwithSubnetMask(ip,subnet)
{
	var i,j,vi=0,vj=0,zero=0,one=0;
	var ip_b=new Array(d2b(atoi(ip,1)), d2b(atoi(ip,2)), d2b(atoi(ip,3)), d2b(atoi(ip,4)));
	var subnet_b=new Array(d2b(atoi(subnet,1)), d2b(atoi(subnet,2)), d2b(atoi(subnet,3)), d2b(atoi(subnet,4)));
	var foundzero=0;

	for(i=0;i<4;i++) {
		if(!foundzero)
		for(j=0;j<8;j++) {
			if(subnet_b[i].charAt(j) == "0") {
				vi = i;
				vj = j;
				foundzero=1;
				break;
			}
		}
	}

	for(i=vi;i<4;i++) {
		if (i==vi) {
			for(j=vj;j<8;j++) {
				if(ip_b[i].charAt(j) == "0")
					zero++;
				else if(ip_b[i].charAt(j) == "1")
					one++;
				else 
					return false;
			}
		} else {
			for(j=0;j<8;j++) {
				if(ip_b[i].charAt(j) == "0")
					zero++;
				else if(ip_b[i].charAt(j) == "1")
					one++;
				else 
					return false;
			}
		}
	}

	if (zero == 0 && one != 0)	{
		alert("Incorrect IP address settings. Please enter a valid host IP address within the IP subnet(s) defined by the subnet mask or modify the subnet mask accordingly.");
		return false;
	} else if (zero != 0 && one == 0) {
		alert("Incorrect IP address settings. Please enter a valid host IP address within the IP subnet(s) defined by the subnet mask or modify the subnet mask accordingly.");
		return false;
	} else if (zero == 0 && one == 0) {
		return false;
	}

	return true;
}

function checkIPinSubnetMask(ip,subnet)
{
	var ip_b=new Array(atoi(ip,1), atoi(ip,2), atoi(ip,3), atoi(ip,4));
	var subnet_b=new Array(atoi(subnet,1), atoi(subnet,2), atoi(subnet,3), atoi(subnet,4));
	
	if( (ip_b[0] >= subnet_b[0]) ||
		(ip_b[0] < subnet_b[0] && ip_b[1] >= subnet_b[1]) ||
		(ip_b[0] < subnet_b[0] && ip_b[1] < subnet_b[1] && ip_b[2] >= subnet_b[2]) ||
		(ip_b[0] < subnet_b[0] && ip_b[1] < subnet_b[1] && ip_b[2] < subnet_b[2] && ip_b[3] >= subnet_b[3]) ){
		return true;
	} else {
		return false;
	}
}

function checkSameSubnet(ipa,ipb,gateway) {
	var i,j;
	var a= new Array(d2b(atoi(ipa,1)),d2b(atoi(ipa,2)),d2b(atoi(ipa,3)),d2b(atoi(ipa,4)));
	var b= new Array(d2b(atoi(ipb,1)),d2b(atoi(ipb,2)),d2b(atoi(ipb,3)),d2b(atoi(ipb,4)));
	var gw = new Array(d2b(atoi(gateway,1)),d2b(atoi(gateway,2)),d2b(atoi(gateway,3)),d2b(atoi(gateway,4)));

	for(i=0;i<4;i++) {
		for(j=0;j<8;j++) {
			if(gw[i].charAt(j) == "1")
				if(a[i].charAt(j) != b[i].charAt(j))
					return false;
		}
	}
	return true;
}

function checkMac(str){
	var len = str.length;
	if(len!=17)
		return false;

	for (var i=0; i<str.length; i++) {
		if((i%3) == 2){
			if(str.charAt(i) == ':')
				continue;
		}else{
			if (    (str.charAt(i) >= '0' && str.charAt(i) <= '9') ||
					(str.charAt(i) >= 'a' && str.charAt(i) <= 'f') ||
					(str.charAt(i) >= 'A' && str.charAt(i) <= 'F') )
			continue;
		}
		return false;
	}
	return true;
}

function checkMACAddr(field)
{
	if(field.value == ""){
		alert("Error. MAC address is empty.");
		field.value = field.defaultValue;
		field.focus();
		return false;
	}

	return checkMac(field.value);
}

function checkTimeValue(checkTag, week, checkValue)
{
	var lastDay;
	var now_weekDay = deviceSysTime.getDay();
	
	if (now_weekDay == 0)
		lastDay = 6; //for auto add one day
	else
		lastDay = now_weekDay - 1;
	docTemp = checkValue;
		
	index = docTemp.indexOf(",");
	checkStart_hour = parseInt(docTemp.substr(0, index), 10);
	docTemp = docTemp.substr(index+1);
	index = docTemp.indexOf(",");
	checkStart_min = parseInt(docTemp.substr(0, index), 10);
	docTemp = docTemp.substr(index+1);

	index = docTemp.indexOf(",");
	checkEnd_hour = parseInt(docTemp.substr(0, index), 10);
	checkEnd_min = parseInt(docTemp.substr(index+1), 10);
	
	//Jacky.Yang check time stamp, must the same with schedule.c check.
	startStamp = (checkStart_hour*60) + checkStart_min;
	endStamp = (checkEnd_hour*60) + checkEnd_min;
	nowStamp = (deviceSysTime.getHours()*60) + deviceSysTime.getMinutes();
	if ((checkEnd_hour < checkStart_hour) || ((checkStart_hour == checkEnd_hour) && (checkEnd_min < checkStart_min))) // next day
	{
		//endStamp = endStamp + 24*60;
		//if (nowStamp <= endStamp) //next day
		if (nowStamp < endStamp) //next day
		{
			if (week.substr(lastDay, 1) == 1)
				return true;
		}
		else //today
		{
			if ((startStamp <= nowStamp))
				if (week.substr(now_weekDay, 1) == 1)
					return true;
		}
	}
	else
	{
		//if ((startStamp <= nowStamp) && (nowStamp <= endStamp))
		if ((startStamp <= nowStamp) && (nowStamp < endStamp))
			if (week.substr(now_weekDay, 1) == 1)
				return true;
	}
	return false;
}

function drawColor(Tag, IDValue)
{
	if (Tag == "working") {
		document.getElementById("drawColor"+IDValue).style.backgroundColor="#FFFF00";
	}
	else if (Tag == "waiting")
	{
		document.getElementById("drawColor"+IDValue).style.backgroundColor="#E1E6EC";
	}
}

function checkRuleWorking()
{
	var loopCount=0;
	
	for (loopCount=0; loopCount<ruleCount; loopCount++)
	{	
		if (document.getElementById("delRule"+loopCount).checked)
		{
			docTemp = document.getElementById("scheduleInfo"+loopCount).value;
			if (document.getElementById("schedule"+loopCount).innerHTML == "Always") {
				drawColor("working", loopCount);
			}
			else {
				index = docTemp.indexOf(",");
				checkWeek = docTemp.substr(0, index);
				if (checkTimeValue("time", checkWeek, docTemp.substr(index+1))) {
					drawColor("working", loopCount);
				}
				else
					drawColor("waiting", loopCount);
			}
		}
	}
	window.setTimeout("checkRuleWorking()", 1000);
}

function currectSysTime()
{
	deviceSysTime.setTime(UTCSecond++ + "000");
	window.setTimeout("currectSysTime()", 1000);
}

function transSSID(SSID)
{
	var loopCount=0;
	var origSSID="";
	var tempChar;
	
	for (loopCount=0; loopCount<SSID.length; loopCount=loopCount+2) {
		tempChar = String.fromCharCode(parseInt(SSID.substr(loopCount, 2), 16));
		if (tempChar == '"')
			origSSID = origSSID + "\"";
		else
			origSSID = origSSID + tempChar;
	}
	return origSSID;
}

function transSSIDForInnerHtml(SSID)
{
	var loopCount=0;
	var origSSID="";
	var tempChar;
	
	for (loopCount=0; loopCount<SSID.length; loopCount=loopCount+2) {
		tempChar = String.fromCharCode(parseInt(SSID.substr(loopCount, 2), 16));
		if (tempChar == '"')
			origSSID = origSSID + "\"";
		else if (tempChar == ' ')
			origSSID = origSSID + "&nbsp;";
		else
			origSSID = origSSID + tempChar;
	}
	//alert("jacky - check origSSID: " + origSSID);
	return origSSID;
}

function formatMac(mac)
{
    if ( -1 != mac.indexOf('-',2)){ // if match '-'
        mac = mac.replace(/\-/g,':');
    }else if ( -1 == mac.indexOf(':',2)){ // if all numgers
        mac = mac.substr(0,2)+":"+mac.substr(2,2)+":"+mac.substr(4,2)+":"+mac.substr(6,2)+":"+mac.substr(8,2)+":"+mac.substr(10,2);
    }
    return mac.toUpperCase();
}

function checkMACAddr(field)
{
        if(field.value == ""){
                return false;
        }

        return checkMac(field.value);
}

/* 01:00:5E:xx:xx:xx  && 03:00:5e:xx:xx:xx is an example for Multicast MAC
   the First bit of the first byte should be one */

function multicastMAC(mac)
{

        if( checkMACAddr(mac) == false )
                return false;

        var fmac = formatMac(mac.value);
        var tmac = fmac.split(":", 3);

        Ibyte = bitStr(tmac[0], 8);
        if( Ibyte.charAt(7) == "1" )
                return true;

        return false;
}

function broadcastMAC(mac)
{

        if( checkMACAddr(mac) == false )
                return false;

        var fmac = formatMac(mac.value);
        var tmac = fmac.split(":", 6);

        if ((tmac[0]  == "FF") && (tmac[1] == "FF") && (tmac[2] == "FF") && (tmac[3]  == "FF") && (tmac[4] == "FF") && (tmac[5] == "FF"))
                        return true;
        else
                return false;
}

/* Convert Decimal No. to Bits */
function bitStr(N, bits)
{
  var S = "", Q;

  while (bits--) {
        S = (Q=N%2) + S ; N = (N-Q)/2
  }

  return S ;

}

/* **************************************************************************************
Function:      trim(),ltrim(),rtrim()
Author:        Joan.huang
Create Date:   2009.10.06
Modify Date:   2009.10.06
Purpose:       trim string
************************************************************************************** */
//trim string space   
function trim(str){  
 return str.replace(/(^\s*)|(\s*$)/g, "");
}
//trim string left
function ltrim(str){  
 return str.replace(/(^\s*)/g,"");
}
//trim string right
function rtrim(str){  
 return str.replace(/(\s*$)/g,"");
}

/* **************************************************************************************
Function:      validateEmpty()
Author:        Joan.huang
Create Date:   2009.10.06
Modify Date:   2009.10.06
Purpose:       Validate value is empty or length is 0;	
***************************************************************************************/

function validateEmpty(formName,elementId)
{
	var trimItem;
	var checkItem;
	
	checkItem=document.getElementById(elementId);
	
	if(checkItem.value.length == 0){
		checkItem.focus();
		return true;
	}

	trimItem=trim(checkItem.value);
	if(trimItem.length == 0){
		checkItem.focus();
		return true;
	}

	return false;
}  
/* **************************************************************************************
Function:      validateRegular()
Author:        joan.huang
Create Date:   2009.10.06
Modify Date:   2009.10.06
Purpose:       Validate value using regular expression.
***************************************************************************************/

function validateRegular(formName,elementId,regexp)
{
	var trimItem;
	var checkItem;

	checkItem=document.getElementById(elementId);
	trimItem=trim(checkItem.value);

	return regexp.test(trimItem);
}

/* **************************************************************************************
Function:      isBlankString()
Author:        Peter.Chen
Create Date:   2012.09.25
Modify Date:   2012.09.25
Purpose:       Check the string is empty string or blank string. (Ex : "" or "     ")
***************************************************************************************/
function isBlankString(StringValue)
{
    return StringValue.replace(/^[\s\t]+/,"").length == 0;   
}


function GetArgsFromHref(sHref, sArgName)
{
	var args_session = sHref.split(";session_id=");
	var args = args_session[0].split("?");
	var retval = "";
	
	var str = args[1];
	if(str)
		args = str.split("&");
	for(var i = 0; i < args.length; i ++)	{
		str = args[i];
		var arg = str.split("=");
		if(arg.length <= 1) continue;
		if(arg[0] == sArgName) retval = arg[1];
	}
	return unescape(retval);
}