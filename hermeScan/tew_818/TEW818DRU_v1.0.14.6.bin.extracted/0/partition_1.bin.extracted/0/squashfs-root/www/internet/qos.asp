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
var orules = "<% nvram_get("qos_orules"); %>"

var len;
var rules = orules.split('&#62;');;
if(orules.length >1)
{
 len = rules.length;
}
else
{
	len = 0;
}

var rulesTowrite = "";
var editIndex;


 
// addr_type < addr < proto < port_type < port < ipp2p < L7 < bcount < class < desc

function printTable()
{
	var ruleItem;
	var j = 1;

	if(len <= 0) {
		document.writeln("<tr>");
		document.writeln("<td>");
		document.writeln("<table width=\"100%\" class=\"tbl_main2\">");
		document.writeln("<tr align=\"center\" HEIGHT=30>");
		//document.writeln("<td class=\"label\" WIDTH=30 HEIGHT=30 align=\"center\"></td>"); //QA think this field is uncessary
		document.writeln("<td class=\"form_list_title\" WIDTH=40 align=\"center\"><!--#tr id="qos.31"-->Rule No.<!--#endtr--></td>");
		document.writeln("<td class=\"form_list_title\" WIDTH=90 align=\"center\"><!--#tr id="qos.32"-->Address Type<!--#endtr--></td>");
		document.writeln("<td class=\"form_list_title\" WIDTH=90 align=\"center\"><!--#tr id="qos.33"-->Address<!--#endtr--></td>");
		document.writeln("<td class=\"form_list_title\" WIDTH=80 align=\"center\"><!--#tr id="qos.34"-->Protocol<!--#endtr--></td>");
		document.writeln("<td class=\"form_list_title\" WIDTH=100 align=\"center\"><!--#tr id="qos.35"-->Port Filter<!--#endtr--></td>");
		document.writeln("<td class=\"form_list_title\" WIDTH=90 align=\"center\"><!--#tr id="qos.36"-->Port No.<!--#endtr--></td>");
		document.writeln("<td class=\"form_list_title\" WIDTH=50 align=\"center\"><!--#tr id="qos.37"-->Class<!--#endtr--></td>");
		document.writeln("<td class=\"form_list_title\" WIDTH=150 align=\"center\"><!--#tr id="qos.38"-->Description<!--#endtr--></td>");
		document.writeln("</tr>");
	   	document.writeln("</table>");
	   	document.writeln("</td>");
	   	document.writeln("</tr>");
		return;
	}

	document.writeln("<tr>");
//	document.writeln("<th width=\"310\" valign=\"top\" onMouseOver=\"return overlib(\'Current Qos Rules (Outbound).\', LEFT);\" onMouseOut=\"return nd();\"> ");
//	document.writeln("Current Qos Rules (Outbound):&nbsp;&nbsp;</td>");
//	document.writeln("<td>&nbsp;&nbsp;</td>");
	document.writeln("<td>");
	document.writeln("<table width=\"100%\" class=\"tbl_main2\">");
	document.writeln("<tr align=\"center\" HEIGHT=30>");
	document.writeln("<td class=\"label\" WIDTH=30 HEIGHT=30 align=\"center\">All<br><input type=\"checkbox\" name=\"checkAll\" id=\"checkAll\" onclick=\"chkAll();\"></td>");
	document.writeln("<td class=\"form_list_title\" WIDTH=40 align=\"center\"><!--#tr id="qos.31"-->Rule No.<!--#endtr--></td>");
	document.writeln("<td class=\"form_list_title\" WIDTH=90 align=\"center\"><!--#tr id="qos.32"-->Address Type<!--#endtr--></td>");
	document.writeln("<td class=\"form_list_title\" WIDTH=90 align=\"center\"><!--#tr id="qos.33"-->Address<!--#endtr--></td>");
	document.writeln("<td class=\"form_list_title\" WIDTH=80 align=\"center\"><!--#tr id="qos.34"-->Protocol<!--#endtr--></td>");
	document.writeln("<td class=\"form_list_title\" WIDTH=100 align=\"center\"><!--#tr id="qos.35"-->Port Filter<!--#endtr--></td>");
	document.writeln("<td class=\"form_list_title\" WIDTH=90 align=\"center\"><!--#tr id="qos.36"-->Port No.<!--#endtr--></td>");
	document.writeln("<td class=\"form_list_title\" WIDTH=50 align=\"center\"><!--#tr id="qos.37"-->Class<!--#endtr--></td>");
	document.writeln("<td class=\"form_list_title\" WIDTH=150 align=\"center\"><!--#tr id="qos.38"-->Description<!--#endtr--></td>");
	document.writeln("</tr>");
	
	for(var i=0; i<rules.length; i++)
	{
		if(rules[i].length <= 0)
			continue;
		
		ruleItem = rules[i].split('&#60;');
		
		document.writeln("<tr align=\"center\">");
		document.writeln("<td class=\"label\" align=\"center\">");
		document.writeln("<input type=\"checkbox\" name=\"rule_" + i + "\" id=\"rule_" + i + "\">");
		document.writeln("</td>");
		document.writeln("<td class=\"form_list_content\" align=\"center\">");
		document.writeln(j);
		document.writeln("</td>");
		document.writeln("<td class=\"form_list_content\" align=\"center\" nowrap>");
		if(ruleItem[0] == 1)
			document.writeln("<!--#tr id="qos.16"-->Destination IP<!--#endtr-->");
		else if(ruleItem[0] == 2)
			document.writeln("<!--#tr id="qos.17"-->Source IP<!--#endtr-->");
		else if(ruleItem[0] == 3)
			document.writeln("<!--#tr id="qos.18"-->Source MAC<!--#endtr-->");
		else
			document.writeln("<!--#tr id="any"-->Any<!--#endtr-->");
		document.writeln("</td>");
		document.writeln("<td class=\"form_list_content\" align=\"center\">");
		if(ruleItem[1])
			document.writeln(ruleItem[1]);
		else
			document.writeln("&nbsp;");
		document.writeln("</td>");
		document.writeln("<td class=\"form_list_content\" align=\"center\">");
		//[-2, 'Any Protocol'],[-1,'TCP/UDP'],[6,'TCP'],[17,'UDP']];
		if(ruleItem[2] == -2)
			document.writeln("<!--#tr id="any"-->Any<!--#endtr-->");
		else if(ruleItem[2] == -1)
			document.writeln("TCP/UDP");
		else if(ruleItem[2] == 6)
			document.writeln("TCP");
		else if(ruleItem[2] == 17)
			document.writeln("UDP");
		else
			document.writeln("&nbsp;");
		document.writeln("</td>");
		document.writeln("<td class=\"form_list_content\" align=\"center\">");
		if(ruleItem[3] == "d")
			document.writeln("<!--#tr id="destination"-->Destination<!--#endtr-->");
		else if(ruleItem[3] == "s")
			document.writeln("<!--#tr id="qos.39"-->Source<!--#endtr-->");
		else if(ruleItem[3] == "x")
			document.writeln("<!--#tr id="qos.40"-->Destination or Source<!--#endtr-->");
		else
			document.writeln("<!--#tr id="any"-->Any<!--#endtr-->");
		document.writeln("</td>");
		document.writeln("<td class=\"form_list_content\" align=\"center\">");
		if(ruleItem[4])
			document.writeln(ruleItem[4]);
		else
			document.writeln("&nbsp;");
		document.writeln("</td>");
		
		document.writeln("<td class=\"form_list_content\" align=\"center\">");
		if(ruleItem[8] == 0)
			document.writeln("<!--#tr id="qos.41"-->Highest<!--#endtr-->");
		else if(ruleItem[8] == "1")
			document.writeln("<!--#tr id="qos.42"-->High<!--#endtr-->");
		else if(ruleItem[8] == "2")
			document.writeln("<!--#tr id="qos.43"-->Medium<!--#endtr-->");
		else if(ruleItem[8] == "3")
			document.writeln("<!--#tr id="qos.44"-->Low<!--#endtr-->");
		else if(ruleItem[8] == "4")
			document.writeln("<!--#tr id="qos.45"-->Lowest<!--#endtr-->");
		else
			document.writeln("&nbsp;");
		document.writeln("</td>");
		document.writeln("<td class=\"form_list_content\" align=\"center\" style=\"max-width:150px; word-wrap:break-word;\">");
		if(ruleItem[9])	
			document.writeln(ruleItem[9]);
		else
			document.writeln("&nbsp;");
		document.writeln("</td>");
   		document.writeln("</tr>");
   		j++;
   	}
   	document.writeln("</table>");
   	document.writeln("</td>");
   	document.writeln("</tr>");
	document.writeln("</table>");
	document.writeln("<table width=\"100%\" class=\"tbl_main\">");
	document.writeln("<tr>");
	document.writeln("<td align=\"center\">");
	document.writeln("<INPUT type=\"button\" class=\"<!--#tr id="buttonWidth"-->button1<!--#endtr-->\" name=\"delete\" value=\"<!--#tr id="qos.46"-->Delete Rule<!--#endtr-->\" onclick=\"delRule();\" >&nbsp;&nbsp;");  
	document.writeln("<INPUT type=\"button\" class=\"<!--#tr id="buttonWidth"-->button1<!--#endtr-->\" name=\"edit\" value=\"<!--#tr id="qos.47"-->Edit Rule<!--#endtr-->\" onclick=\"toEdit();\" >");  
	document.writeln("</td>");
	document.writeln("</tr>");
}

function toEdit(index)
{
	var r = 0;
	var index;
	var ruleItem;
	
	for(i = 0; i < rules.length; i++)
	{
		chkid = "rule_" + i ;
		if(document.getElementById(chkid) && (document.getElementById(chkid).checked == true))
		{
			r++;
			index = i;
		}
	}
	if(r != 1)
	{
		Alert.render("<!--#tr id="qos.alert.1"-->Please selet ONE rule to edit at a time.<!--#endtr-->");
		return false;
	}
	
	element = document.getElementById("tabEdit").style;
	element.display='block';
	element1 = document.getElementById("tabAdd").style;
	element1.display='none';
	document.adddel.edit.disabled = 1 ;
	
	ruleItem = rules[index].split('&#60;');
	
	document.adddel.ruleNo.value = "Rule No. " + (index + 1);
	document.getElementById("ruleNo_name").innerHTML = "Rule No. " + (index + 1);
	document.adddel.qos_ip_e.focus(); 
	
	document.adddel.qos_ip_e.selectedIndex = ruleItem[0];
	document.adddel.qos_ipaddr_e.value = ruleItem[1];
	
	if(ruleItem[2] == -1)
		document.adddel.qos_proto_e.selectedIndex = 1;
	else if(ruleItem[2] == 6)
		document.adddel.qos_proto_e.selectedIndex = 2;
	else if(ruleItem[2] == 17)
		document.adddel.qos_proto_e.selectedIndex = 3;
	else
		document.adddel.qos_proto_e.selectedIndex = 0;
		
	if(ruleItem[3] == "d")
		document.adddel.qos_port_e.selectedIndex = 1;
	else if(ruleItem[3] == "s")
		document.adddel.qos_port_e.selectedIndex = 2;
	else if(ruleItem[3] == "x")
		document.adddel.qos_port_e.selectedIndex = 3;
	else
		document.adddel.qos_port_e.selectedIndex = 0;
		
	document.adddel.qos_port_num_e.value = ruleItem[4]	
	document.adddel.qos_class_e.selectedIndex = ruleItem[8];
	document.adddel.qos_desc_e.value = ruleItem[9];
	
	editIndex = index;
}
    
function submitEdit()
{
	var v;
	
 	if(validateRule(1) == false)
 	{
 		return false;
 	}
	
	v = document.adddel.qos_ip_e.value + "<";
	v = v + document.adddel.qos_ipaddr_e.value + "<";
	v = v + document.adddel.qos_proto_e.value + "<";
	if(document.adddel.qos_port_e.value == 1)
		v = v + "d" + "<";
	else if(document.adddel.qos_port_e.value == 2)
		v = v + "s" + "<";
	else if(document.adddel.qos_port_e.value == 3)
		v = v + "x" + "<";
	else
		v = v + "a" + "<";
	v = v + document.adddel.qos_port_num_e.value + "<" + "0<";
	
		v = v+ "<" + "<";
		
	v = v + document.adddel.qos_class_e.value + "<";
	v = v + document.adddel.qos_desc_e.value;
	
	// addr_type < addr < proto < port_type < port < < < < class < desc
	rulesTowrite = "";
	if(editIndex > 0)
	{
		for(i = 0; i < editIndex; i++)
		{
			if(rules[i].length > 0)
				witeRules(i);
		}
	}
	
	if(rulesTowrite.length > 1)
	{
		
		rulesTowrite = rulesTowrite + ">" + v;
	}
	else
	{
		rulesTowrite = v;
	}
	
	if( editIndex < (rules.length - 1))
	{
		for(i = (editIndex + 1); i < rules.length; i++)
		{
			if(rules[i].length > 0)
				witeRules(i);
		}
	}
	
	document.adddel.qos_orules.value = rulesTowrite;
	totalWaitTime = 25; //second
	wait_page();
	document.getElementById("waitPad").style.display="block";
	scroll(0,0);
	document.adddel.submit();
	return true;
}

function resetEdit()
{
	
	element = document.getElementById("tabEdit").style;
	element.display='none';
	document.adddel.edit.disabled = 0 ;
	element1 = document.getElementById("tabAdd").style;
	element1.display='block';
}    
     
function setMax()
{
	var orates = "<% nvram_get("qos_orates"); %>";
	var irates = "<% nvram_get("qos_irates"); %>";   
	   	
	if(!orates)
	{
		orates = "80-100,10-100,5-100,3-100,2-95,0-0,0-0,0-00,0-0,0-0";
	}

     	
	if(!irates)
	{
		irates = "0,0,0,0,5,0,0,0,0,0";      
	}


    
	var rates = orates.split(',');

	ratehi = rates[0].split('-');
	document.set.obw_hi_lower.value = ratehi[0];
	document.set.obw_hi_higher.value = ratehi[1];
	
	rateh = rates[1].split('-');
	document.set.obw_h_lower.value = rateh[0];
	document.set.obw_h_higher.value = rateh[1];
	
	ratemed = rates[2].split('-');
	document.set.obw_med_lower.value = ratemed[0];
	document.set.obw_med_higher.value = ratemed[1];
	
	ratel = rates[3].split('-');
	document.set.obw_l_lower.value = ratel[0];
	document.set.obw_l_higher.value = ratel[1];
	
	ratelo = rates[4].split('-');
	document.set.obw_lo_lower.value = ratelo[0];
	document.set.obw_lo_higher.value = ratelo[1];
	
	var ratein = irates.split(',');
	 
	document.set.ibw_hi.value = ratein[0];
	document.set.ibw_h.value = ratein[1];
	document.set.ibw_med.value = ratein[2];
	document.set.ibw_l.value = ratein[3];
	document.set.ibw_lo.value = ratein[4];
	
}

function qos_recalc(input)
{
	var qos_enable = "<% nvram_get("qos_enable"); %>";
	var qos_obw = "<% nvram_get("qos_obw"); %>";
	var qos_ibw = "<% nvram_get("qos_ibw"); %>";       

	if(input == 1)
	{
		qos_enable = document.set.qos_enable.value;
		setItems(qos_enable);
	}
	
	else if(input == 2)
	{
		qos_obw1 = document.set.qos_obw.value;
		setBW(qos_obw1);
	}
	
	else if(input == 3)
	{
		qos_ibw1 = document.set.qos_ibw.value;
		setiBW(qos_ibw1);
	}
	
	else
	{
		setItems(qos_enable);
		setBW(qos_obw);
		setiBW(qos_ibw);   
	}
}

function setBW(qos_obw)
{
	a = document.set.obw_hi_lower.value/100;
	b = a*qos_obw;
	document.set.hi_lo.value = Math.floor(b);
		
	a = document.set.obw_hi_higher.value/100;
	b = a*qos_obw;
	document.set.hi_hi.value = Math.floor(b);

	a = document.set.obw_h_lower.value/100;
	b = a*qos_obw;
	document.set.h_lo.value = Math.floor(b);

	a = document.set.obw_h_higher.value/100;
	b = a*qos_obw;
	document.set.h_hi.value = Math.floor(b);

	a = document.set.obw_med_lower.value/100;
	b = a*qos_obw;
	document.set.med_lo.value = Math.floor(b);

	a = document.set.obw_med_higher.value/100;
	b = a*qos_obw;
	document.set.med_hi.value = Math.floor(b);

	a = document.set.obw_l_lower.value/100;
	b = a*qos_obw;
	document.set.l_lo.value = Math.floor(b);

	a = document.set.obw_l_higher.value/100;
	b = a*qos_obw;
	document.set.l_hi.value = Math.floor(b);
 	
	a = document.set.obw_lo_lower.value/100;
	b = a*qos_obw;
	document.set.lo_lo.value = Math.floor(b);

	a = document.set.obw_lo_higher.value/100;
	b = a*qos_obw;
	document.set.lo_hi.value = Math.floor(b);
}


function setiBW(qos_ibw)
{
	x = document.set.ibw_hi.value/100;
	y = x*qos_ibw;
	document.set.in_hi.value = Math.floor(y);
		
	x = document.set.ibw_h.value/100;
	y = x*qos_ibw;
	document.set.in_h.value = Math.floor(y);

	x = document.set.ibw_med.value/100;
	y = x*qos_ibw;
	document.set.in_med.value = Math.floor(y);

	x = document.set.ibw_l.value/100;
	y = x*qos_ibw;
	document.set.in_l.value = Math.floor(y);

	x = document.set.ibw_lo.value/100;
	y = x*qos_ibw;
	document.set.in_lo.value = Math.floor(y);

}


function setItems(b)
{	
	if(b == 0)
	{
   		document.set.qos_ack.disabled = 1;
		document.set.qos_icmp.disabled = 1;
			
		document.set.obw_hi_lower.disabled = 1;
		document.set.obw_hi_higher.disabled = 1;
		document.set.obw_h_lower.disabled = 1;
		document.set.obw_h_higher.disabled = 1;
		document.set.obw_med_lower.disabled = 1;
		document.set.obw_med_higher.disabled = 1;
		document.set.obw_l_lower.disabled = 1;
		document.set.obw_l_higher.disabled = 1;
		document.set.obw_lo_lower.disabled = 1;
		document.set.obw_lo_higher.disabled = 1;
		document.set.qos_obw.disabled = 1;
		
		document.set.ibw_hi.disabled = 1;
		document.set.ibw_h.disabled = 1;
		document.set.ibw_med.disabled = 1;
		document.set.ibw_l.disabled = 1;
		document.set.ibw_lo.disabled = 1;
		document.set.qos_ibw.disabled = 1;
		
		document.set.qos_default.disabled = 1;
		
	
	}
	else
	{
		document.set.qos_ack.disabled = 0;
		document.set.qos_icmp.disabled = 0;
	
		document.set.obw_hi_lower.disabled = 0;
		document.set.obw_hi_higher.disabled = 0;
		document.set.obw_h_lower.disabled = 0;
		document.set.obw_h_higher.disabled = 0;
		document.set.obw_med_lower.disabled = 0;
		document.set.obw_med_higher.disabled = 0;
		document.set.obw_l_lower.disabled = 0;
		document.set.obw_l_higher.disabled = 0;
		document.set.obw_lo_lower.disabled = 0;
		document.set.obw_lo_higher.disabled = 0;
		document.set.qos_obw.disabled = 0;
		
		document.set.ibw_hi.disabled = 0;
		document.set.ibw_h.disabled = 0;
		document.set.ibw_med.disabled = 0;
		document.set.ibw_l.disabled = 0;
		document.set.ibw_lo.disabled = 0;
		document.set.qos_ibw.disabled = 0;
		
			
		document.set.qos_default.disabled = 0;
		
	
	}
}

/**
* Before sending data to devices, check field values of inbound class settings and 
* field value of outbound class settings.
*/
function validateData()
{	
    // 1. Check values of Inbound Class Settings
    if (!validateNumberRange(document.getElementById("ics_BwMaxInbound")))
    {
        showDebugMessage("Bw Max Inbound value of Inbound Class Setting is error !!!");
        return false;
    }
    if(!validateNumber(document.set.ibw_hi))
	{
        showDebugMessage("Highest value of Inbound Class Setting is error !!!");
        return false;
    }
	if(!validateNumber(document.set.ibw_h))
    {
        showDebugMessage("High value of Inbound Class Setting is error !!!");
        return false;
    }
	if(!validateNumber(document.set.ibw_med))
    {
        showDebugMessage("Medium value of Inbound Class Setting is error !!!");
        return false;
    }
	if(!validateNumber(document.set.ibw_l))
    {
        showDebugMessage("Low value of Inbound Class Setting is error !!!");
        return false;
    }
	if(!validateNumber(document.set.ibw_lo))
    {
        showDebugMessage("Lowest value of Inbound Class Setting is error !!!");
        return false;
    }
	
	// 2. Check values of Outbound Class Settings
    if (!validateNumberRange(document.getElementById("ocs_BwMaxInbound")))
    {
        showDebugMessage("Bw Max Inbound value of Outbound Class Setting is error !!!");
        return false;
    }
	if(!validateNumber(document.set.obw_hi_lower))
    {
        showDebugMessage("Highest lowbound value of Outbound Class Setting is error !!!");
        return false;
    }
	if(!validateNumber(document.set.obw_hi_higher))
    {
        showDebugMessage("Highest upbound value of Outbound Class Setting is error !!!");
        return false;
    }
	if(!validateNumber(document.set.obw_h_lower))
    {
        showDebugMessage("High lowbound value of Outbound Class Setting is error !!!");
        return false;
    }
	if(!validateNumber(document.set.obw_h_higher))
    {
        showDebugMessage("High upbound value of Outbound Class Setting is error !!!");
        return false;
    }
	if(!validateNumber(document.set.obw_med_lower))
    {
        showDebugMessage("Medium lowbound value of Outbound Class Setting is error !!!");
        return false;
    }
	if(!validateNumber(document.set.obw_med_higher))
    {
        showDebugMessage("Medium upbound value of Outbound Class Setting is error !!!");
        return false;
    }
	if(!validateNumber(document.set.obw_l_lower))
    {
        showDebugMessage("Low lowbound value of Outbound Class Setting is error !!!");
        return false;
    }
	if(!validateNumber(document.set.obw_l_higher))
    {
        showDebugMessage("Low upbound value of Outbound Class Setting is error !!!");
        return false;
    }
	if(!validateNumber(document.set.obw_lo_lower))
    {
        showDebugMessage("Lowest lowbound value of Outbound Class Setting is error !!!");
        return false;
    }
	if(!validateNumber(document.set.obw_lo_higher))
    {
        showDebugMessage("Lowest upbound value of Outbound Class Setting is error !!!");
        return false;
    }
    
    // 3. Check ranges of Outbound Class Settings
	if(!validateRange(document.set.obw_hi_lower,document.set.obw_hi_higher))
    {
        showDebugMessage("Hightest range of Outbound Class Setting is error !!!");
        return false;
    }
	if(!validateRange(document.set.obw_h_lower,document.set.obw_h_higher))
    {
        showDebugMessage("High range of Outbound Class Setting is error !!!");
        return false;
    }
	if(!validateRange(document.set.obw_med_lower,document.set.obw_med_higher))
    {
        showDebugMessage("Medium range of Outbound Class Setting is error !!!");
        return false;
    }
	if(!validateRange(document.set.obw_l_lower,document.set.obw_l_higher))
    {
        showDebugMessage("Low range of Outbound Class Setting is error !!!");
        return false;
    }
	if(!validateRange(document.set.obw_lo_lower,document.set.obw_lo_higher))
    {   
        showDebugMessage("Lowest range of Outbound Class Setting is error !!!");
        return false;
    }
	
	//Griffin -To add inbound limit
	if(!validateSumNoMin(document.set.ibw_hi, document.set.ibw_h, document.set.ibw_med, document.set.ibw_l, document.set.ibw_lo))
    {
        return false;
    }	
    
	if(!validateSum(document.set.obw_hi_lower, document.set.obw_h_lower, document.set.obw_med_lower, document.set.obw_l_lower, document.set.obw_lo_lower))
    {
        return false;
    }	
	
	var vhigh = document.set.obw_hi_lower.value + "-" + document.set.obw_hi_higher.value;
	var vh = document.set.obw_h_lower.value + "-" + document.set.obw_h_higher.value;
	var vmed = document.set.obw_med_lower.value + "-" + document.set.obw_med_higher.value;
	var vl = document.set.obw_l_lower.value + "-" + document.set.obw_l_higher.value;
	var vlow = document.set.obw_lo_lower.value + "-" + document.set.obw_lo_higher.value;
	document.set.qos_orates.value = vhigh + "," + vh + "," + vmed + "," + vl + "," + vlow + ",0-0,0-0,0-0,0-0,0-0";
	
	var vhigh = document.set.ibw_hi.value;
	var vh = document.set.ibw_h.value;
	var vmed = document.set.ibw_med.value;
	var vl = document.set.ibw_l.value;
	var vlow = document.set.ibw_lo.value;
	document.set.qos_irates.value = vhigh + "," + vh + "," + vmed + "," + vl + "," + vlow + ",0,0,0,0,0";

	totalWaitTime = 25; //second
	wait_page();
	document.getElementById("waitPad").style.display="block";
	scroll(0,0);
	return true;
}

function validateSum(v1, v2, v3, v4, v5)
{
	var sum;
	sum = parseInt(v1.value) + parseInt(v2.value) + parseInt(v3.value) + parseInt(v4.value)+ parseInt(v5.value);
	
	if(sum > 100)
	{
		Alert.render("<!--#tr id="qos.alert.2"-->The sum of all %BWMin can not be over 100!<!--#endtr-->");
		v1.focus(); 
		v1.select();
		return false;
	}
	return true;
}

function validateSumNoMin(v1, v2, v3, v4, v5)
{
	var sum;
	sum = parseInt(v1.value) + parseInt(v2.value) + parseInt(v3.value) + parseInt(v4.value)+ parseInt(v5.value);
	
	if(sum > 100)
	{
		Alert.render("<!--#tr id="qos.alert.11"-->The sum of all %BW can not be over 100!<!--#endtr-->");
		v1.focus(); 
		v1.select();
		return false;
	}
	return true;
}

function validateNumber(val)
{
	if(!val.value)
	{
		Alert.render("<!--#tr id="qos.alert.3"-->Please enter a number!<!--#endtr-->");
		val.focus(); 
		val.select();
		return false;
	}
	
	for(i = 0; i < val.value.length; i++)
	{
		if(val.value.charAt(i) < '0' || val.value.charAt(i) > '9')
		{	
			Alert.render("<!--#tr id="qos.alert.4"-->It is an invalid number!<!--#endtr-->");
			val.focus(); 
			val.select();
			return false;
		}
	}
	
	if(val.value < 0 || val.value > 100)
	{
		Alert.render("<!--#tr id="qos.alert.5"-->Invalid number, the number must be great than 0 and less than 100!<!--#endtr-->");
		val.focus(); 
		val.select();
		return false;
	}

	return true;	
}

function validateNumberRange(val, lowBound, upBound)
{
	if(!val.value)
	{
		Alert.render("<!--#tr id="qos.alert.3"-->Please enter a number!<!--#endtr-->");
		val.focus(); 
		val.select();
		return false;
	}
	
	for(i = 0; i < val.value.length; i++)
	{
		if(val.value.charAt(i) < '0' || val.value.charAt(i) > '9')
		{	
			Alert.render("<!--#tr id="qos.alert.4"-->It is an invalid number!<!--#endtr-->");
			val.focus(); 
			val.select();
			return false;
		}
	}
	
	if(val.value < lowBound || val.value > upBound)
	{
		Alert.render("<!--#tr id="qos.alert.6"-->Invalid number, it is out of range :<!--#endtr-->" + lowBound + " ~ " + upBound);
		val.focus(); 
		val.select();
		return false;
	}

	return true;	
}

function validateRange(val1, val2)
{
	if(parseInt(val1.value) > parseInt(val2.value))
	{
		Alert.render("<!--#tr id="qos.alert.7"-->Invalid number, the %BWMin must not be great than %BWMax!<!--#endtr-->");
		val1.focus(); 
		val1.select();
		return false;
	}
	return true;
}

function chkAll()
{
	var chk = 1;
	var chkid;
	
	if(document.getElementById("checkAll") && document.getElementById("checkAll").checked ==0){
		chk = 0;
	}
	for ( var i = 0; i < rules.length; i++)
	{
		chkid = "rule_" + i ;	
		if(document.getElementById(chkid) && document.getElementById(chkid).checked == (!chk))
		{
			document.getElementById(chkid).click();
		}
	}
}

function delRule()
{
	var flag = 0;
	var ruleLeft = "";
	var i;
	var chkid;
	
	for(i = 0; i < rules.length; i++)
	{
		chkid = "rule_" + i ;
		if(document.getElementById(chkid) && (document.getElementById(chkid).checked == true))
		{
			flag = 1;
			break;
		}
	}
	
	if(!flag)
	{
		Alert.render("<!--#tr id="qos.alert.8"-->No rule is selected. Please check the rules you want to delete.<!--#endtr-->");
		return false;
	}
	
	rulesTowrite = "";
	for(i = 0; i < rules.length; i++)
	{
		chkid = "rule_" + i ;
		
		if(document.getElementById(chkid) && (document.getElementById(chkid).checked == false))
		{
			//alert("add rule #" + i);
			if(rules[i].length > 0)
				witeRules(i);
		}
	}
	
	document.adddel.qos_orules.value = rulesTowrite;
	totalWaitTime = 25; //second
	wait_page();
	document.getElementById("waitPad").style.display="block";
	scroll(0,0);
	document.adddel.submit();
	return true;
}

function addRule()
{
	var v;
	
 	if(validateRule(0) == false)
 	{
 		return false;
 	}
	
	v = document.adddel.qos_ip.value + "<";
	v = v + document.adddel.qos_ipaddr.value + "<";
	v = v + document.adddel.qos_proto.value + "<";
	if(document.adddel.qos_port.value == 1)
		v = v + "d" + "<";
	else if(document.adddel.qos_port.value == 2)
		v = v + "s" + "<";
	else if(document.adddel.qos_port.value == 3)
		v = v + "x" + "<";
	else
		v = v + "a" + "<";
	v = v + document.adddel.qos_port_num.value + "<" + "0<";
	
    v = v + "<" + "<";  
		
	v = v + document.adddel.qos_class.value + "<";
	v = v + document.adddel.qos_desc.value;
	
	// addr_type < addr < proto < port_type < port < < < < class < desc
	
	rulesTowrite = "";
	if(len > 0)
	{
		for(i = 0; i < rules.length; i++)
		{
			//Alert.render("add rule #" + i);
			if(rules[i].length > 0)
				witeRules(i);
		}
		if(rulesTowrite.length > 1)
		{
			v = rulesTowrite + ">" + v;
		}
	}
	
	document.adddel.qos_orules.value = v;
	//alert("document.adddel.qos_orules.value = " + document.adddel.qos_orules.value);
	totalWaitTime = 25; //second
	wait_page();
	document.getElementById("waitPad").style.display="block";
	scroll(0,0);
	document.adddel.submit();
	return true;
}

function validateRule(val)
{
	// Validate IP address or MAC address
	if(val == 0)
	{
		ipE = document.adddel.qos_ip;
		ipaddrE = document.adddel.qos_ipaddr;
		portE = document.adddel.qos_port;
		portnumE = document.adddel.qos_port_num;
		descE = document.adddel.qos_desc;
	}
	else if(val == 1)
	{
		ipE = document.adddel.qos_ip_e;
		ipaddrE = document.adddel.qos_ipaddr_e;
		portE = document.adddel.qos_port_e;
		portnumE = document.adddel.qos_port_num_e;
		descE = document.adddel.qos_desc_e;
	}	

	if(ipE.value == 1 || ipE.value == 2) // Check IP Address (Destination IP or Source IP)
	{
		if(!validateIp(ipaddrE.value))
		{
			ipaddrE.focus(); 
			ipaddrE.select();
			return false;
		}
	}
	else if(ipE.value == 3) // Check Source MAC
	{
		if (!validateMac(ipaddrE.value))
		{
			qos_ipaddrE.focus(); 
			qos_ipaddrE.select();
			return false;
		}
	}
	
	// Validate Ports
	if(portE.value != 0)
	{
		if(!validatePorts(portnumE.value))
		{
			portnumE.focus(); 
			portnumE.select();
			return false;
		}
	}
	//Tom.Hung 2013-1-3, description only accept [0-9a-zA-Z_-] characters.
	var re = /^[\w\-]+$/;
	if (!re.test(descE.value)) {
		alert("<!--#tr id="qos.alert.10"-->Description only accept [0-9a-zA-Z_-] characters.<!--#endtr-->");
		return false;
	}
	//Tom.Hung 2013-1-3 end

	return true;
}

function witeRules(index)
{
	var ruleItem = rules[index].split('&#60;');
	var aRule = "";
	
	//alert("index =" + index);
	aRule = ruleItem[0];
	for(var i = 1; i < ruleItem.length; i++)
	{
		aRule = aRule + "<" + ruleItem[i];
	}
	if(rulesTowrite.length > 1)
	{
		rulesTowrite = rulesTowrite + ">" + aRule;
	}
	else
	{
		rulesTowrite = aRule;
	}
}

function validateMac(val)
{
	var i;
	var sval = String(val);
	var strAlert = "<!--#tr id="mac.address.error"-->Invalid MAC address! Please enter a valid MAC address.<!--#endtr-->";
	
	// 1. Check total length
	if (sval.length != 17)
 	{	
		Alert.render(strAlert);
		return false;
	}
	
	// 2. Check characters (0~9, a~f , A~F)
	for (i = 0; i < sval.length; i++)
	{	
		if ((i % 3) == 2)
		{
			if (sval.charAt(i) != ':')
	 		{  
	 			Alert.render(strAlert);
	 			return false;
            }
        }
        else if (!((sval.charAt(i) >= '0' && sval.charAt(i) <= '9') || 
        		(sval.charAt(i) >= 'A' && sval.charAt(i) <= 'F') || 
        		(sval.charAt(i) >= 'a' && sval.charAt(i) <= 'f')))
		{
			Alert.render(strAlert);
			return false;
		}
 	}
 	
 	// 3. Split Mac Address by ':'
 	var sub = val.split(':');

    // 4. ff:ff:ff:ff:ff:ff  or 00:00:00:00:00:00--- It is illegal Mac Address.
	if(sub[0].toLowerCase() == 'ff' && sub[1].toLowerCase() == 'ff' && sub[2].toLowerCase() == 'ff' && 
		sub[3].toLowerCase() == 'ff' && sub[4].toLowerCase() == 'ff' && sub[5].toLowerCase() == 'ff')
	{
		Alert.render(strAlert);
		return false;
	}
	else if(sub[0] == '00' && sub[1] == '00' && sub[2] == '00' && sub[3] == '00' && sub[4] == '00' && sub[5] == '00')
	{
		Alert.render(strAlert);
		return false;
	}
	
    // 5. If First item = ff, it is not allowed.
 	sub[0] = '0x'+sub[0];
 	if((sub[0] & 1) == 1)
 	{
		Alert.render(strAlert);
		return false;
	}
	return true;
}

function validateIp(val)
{
	var i;
	sval = String(val);
	var strAlert = "<!--#tr id="ip.address.error"-->Invalid IP address! Please enter a valid IP address.<!--#endtr-->";
 
	if(val.length < 7 || val.length > 15)
	{
		Alert.render(strAlert);
		return false;
	}
	
	for (i = 0; i < sval.length; i++)
	{
		if(sval.charAt(i) == '.')
		{
			continue;
		}
		else if(sval.charAt(i)<'0' || sval.charAt(i)>'9')
		{
			Alert.render(strAlert);
			return false;
		}
	}
 
	var sub = val.split('.');
	if(sub.length != 4)
	{
		Alert.render(strAlert);
		return false;
	}
	
	if(sub[0].length == 0 || sub[1].length == 0 || sub[2].length == 0 || sub[3].length == 0)
	{	
		Alert.render(strAlert);
		return false;
	}

	if((sub[0]-0) < 0 || (sub[0]-0) > 255 || (sub[1]-0) < 0 || (sub[1]-0) > 255 ||
		(sub[2]-0) < 0 || (sub[2]-0) > 255 || (sub[3]-0) < 0 || (sub[3]-0) > 255)
	{
		Alert.render(strAlert);
		return false;
	}
	return true;
}

function validatePorts(val)
{
	var i;
	sval = String(val);
	var strAlert = "<!--#tr id="qos.alert.9"-->Invalid Ports! Please enter valid Ports, the correct format is<!--#endtr-->" +  "\"Port[,Port]...\".";
	 
	if(val.length == 0) 
		return true;

    // input string fortmat : ',' or 0~9	
	for (i = 0; i < sval.length; i++)
	{
		if(sval.charAt(i) == ',')
		{
			continue;
		}
		else if(sval.charAt(i)<'0' || sval.charAt(i)>'9')
		{
			Alert.render(strAlert);
			return false;
		}
	}

	var sub = val.split(',');
	for(i = 0; i < sub.length; i++ )
	{
		if((sub[i]-0) < 0 || (sub[i]-0) > 65535)
		{
			Alert.render(strAlert);
			return false;
		}
	}
	return true;
}

function turnOffInputBySelector(selectElement, inputElement, targetIndex)
{
    inputElement.disabled = (selectElement.selectedIndex == targetIndex);
    if (inputElement.disabled) {
        inputElement.value = "";
    }
}

function showDebugMessage(message)
{
    if (DEBUG_TAG)
    {
        Alert.render(message);
    }   
}

function applyCheck()
{
	totalWaitTime = 25;
	wait_page();
	document.getElementById("waitPad").style.display="block";
	scroll(0,0);
	return true;
}

function page_load() {
	setMax();
	qos_recalc(0);
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
<h1><!--#tr id="qos.title"-->Quality of Service Settings<!--#endtr--></h1>
<div class="hr" ></div>
<p>
<!--#tr id="qos.desc"-->This page allows you to configure the QoS feature.<!--#endtr-->
</p>

<form name="set" method="post" action="/uapply.cgi" onsubmit="return validateData();">
<input type="hidden" name="page" value="/internet/qos.asp">
<input type="hidden" name="token" value="<% genToken(); %>">
<input type="hidden" name="qos_orates" value="<% nvram_get("qos_orates"); %>">
<input type="hidden" name="qos_irates" value="<% nvram_get("qos_irates"); %>">
<table width="100%" class="tbl_main">
	<tr>
		<td class="CT" colspan="2"><!--#tr id="qos.1"-->QoS Setting<!--#endtr--></td>
	</tr>
	<tr>
		<td class="CL"
		onMouseOver="return overlib('Enables the Qos feature.', LEFT);"
		onMouseOut="return nd();">
		<!--#tr id="qos.2"-->Enable QoS<!--#endtr-->
		<td class="CR">
			<select name="qos_enable" onChange="qos_recalc(1);">
				<option value="0" <% nvram_match("qos_enable", "0", "selected"); %>><!--#tr id="disabled"-->Disabled<!--#endtr--></option> 
				<option value="1" <% nvram_match("qos_enable", "1", "selected"); %>><!--#tr id="enabled"-->Enabled<!--#endtr--></option>
			</select>
		</td>
	</tr>
	<tr>
		<td class="CL"
		onMouseOver="return overlib('Prioritizes the transmit ACK packets.', LEFT);"
		onMouseOut="return nd();">
		<!--#tr id="qos.3"-->Prioritize ACK<!--#endtr-->
		</td>
		<td class="CR">
			<select name="qos_ack">
				<option value="0" <% nvram_match("qos_ack", "0", "selected"); %>><!--#tr id="disabled"-->Disabled<!--#endtr--></option> 
				<option value="1" <% nvram_match("qos_ack", "1", "selected"); %>><!--#tr id="enabled"-->Enabled<!--#endtr--></option>
			</select>
		</td>
	</tr>
	<tr>
		<td class="CL"
		onMouseOver="return overlib('Prioritizes the ICMP packets (PING replies, etc)..', LEFT);"
		onMouseOut="return nd();">
		<!--#tr id="qos.4"-->Prioritize ICMP<!--#endtr-->
		</td>
		<td class="CR">
			<select name="qos_icmp">
				<option value="0" <% nvram_match("qos_icmp", "0", "selected"); %>><!--#tr id="disabled"-->Disabled<!--#endtr--></option> 
				<option value="1" <% nvram_match("qos_icmp", "1", "selected"); %>><!--#tr id="enabled"-->Enabled<!--#endtr--></option>
			</select>
		</td>
	</tr>  
</table>

<table width="100%" class="tbl_main">
	<tr>
		<td class="CT" colspan="2"><!--#tr id="qos.5"-->Traffic Class Setting<!--#endtr--></td>
	</tr>
	<tr>
		<td class="CL"
		onMouseOver="return overlib('IQos default traffic class for unclassified traffic.', LEFT);"
		onMouseOut="return nd();">
		<!--#tr id="qos.6"-->Default Traffic Class<!--#endtr-->
		</td>
		<td class="CR">
			<select name="qos_default">
				<option value="0" <% nvram_match("qos_default", "0", "selected"); %>><!--#tr id="highest"-->Highest<!--#endtr--></option>
				<option value="1" <% nvram_match("qos_default", "1", "selected"); %>><!--#tr id="high"-->High<!--#endtr--></option>
				<option value="2" <% nvram_match("qos_default", "2", "selected"); %>><!--#tr id="medium"-->Medium<!--#endtr--></option>
				<option value="3" <% nvram_match("qos_default", "3", "selected"); %>><!--#tr id="low"-->Low<!--#endtr--></option>
				<option value="4" <% nvram_match("qos_default", "4", "selected"); %>><!--#tr id="lowest"-->Lowest<!--#endtr--></option>
			</select>
		</td>
	</tr>
</table>

<table width="100%" class="tbl_main">
	<tr>
		<td class="CT" colspan="2"><!--#tr id="qos.7"-->Inbound Class Setting<!--#endtr--></td>
	</tr>
	<tr>
		<td class="CL"
		onMouseOver="return overlib('Inbound traffic classes.', LEFT);"
		onMouseOut="return nd();" height="21">
		<!--#tr id="qos.8"-->Inbound Classes<br> (% Max Input BW)<!--#endtr-->
		</td>
		<td class="CR"></td>
	</tr>
	<tr>
		<td class="CL"
		onMouseOver="return overlib('Sets the maximum bw for inbound traffic.', LEFT);"
		onMouseOut="return nd();">
		<!--#tr id="qos.9"-->BW Max Inbound<!--#endtr-->
		</td>
		<td class="CR">
			<input id="ics_BwMaxInbound" name="qos_ibw" value="<% nvram_get("qos_ibw"); %>" onChange="qos_recalc(3);" size="6" maxlength="6"> Kbit/s
		</td>
	</tr>
	<tr>
		<td class="CL">
		</td>
		<td class="CR">
			<font size="1">%BW</font>
		</td>
	</tr>
	<tr>
		<td class="CL"
		onMouseOver="return overlib('Highest Priority settings in percent of max BW', LEFT);"
		onMouseOut="return nd();">
		<!--#tr id="highest"-->Highest<!--#endtr--></td>
		<td class="CR">
			<input name="ibw_hi" size="3" maxlength="3" onChange="qos_recalc(3);"> &nbsp;&nbsp;&nbsp; 
			<INPUT maxLength=40 size=3 name=in_hi style="text-align: center; border: 1px solid #FFFFFF; padding: 0" readonly> Kbit/s
		</td>
	</tr>
	<tr>
		<td class="CL"
		onMouseOver="return overlib('High Priority settings in percent of max BW', LEFT);"
		onMouseOut="return nd();">
		<!--#tr id="high"-->High<!--#endtr--></td>
		<td class="CR">
			<input name="ibw_h" size="3" maxlength="3" onChange="qos_recalc(3);"> &nbsp;&nbsp;&nbsp; 
			<INPUT maxLength=40 size=3 name=in_h style="text-align: center; border: 1px solid #FFFFFF; padding: 0" readonly> Kbit/s
		</td>
	</tr>
	<tr>
		<td class="CL"
		onMouseOver="return overlib('Medium Priority settings in percent of max BW', LEFT);"
		onMouseOut="return nd();">
		<!--#tr id="medium"-->Medium<!--#endtr--></td>
		<td class="CR">
			<input name="ibw_med"  size="3" maxlength="3" onChange="qos_recalc(3);"> &nbsp;&nbsp;&nbsp; 
			<INPUT maxLength=40 size=3 name=in_med style="text-align: center; border: 1px solid #FFFFFF; padding: 0" readonly> Kbit/s
		</td>
	</tr>
	<tr>
		<td class="CL"
		onMouseOver="return overlib('Low Priority settings in percent of max BW', LEFT);"
		onMouseOut="return nd();">
		<!--#tr id="low"-->Low<!--#endtr--></td>
		<td class="CR">
			<input name="ibw_l" size="3" maxlength="3" onChange="qos_recalc(3);"> &nbsp;&nbsp;&nbsp; 
			<INPUT maxLength=40 size=3 name=in_l style="text-align: center; border: 1px solid #FFFFFF; padding: 0" readonly> Kbit/s
		</td>
	</tr>
	<tr>
		<td class="CL"
		onMouseOver="return overlib('Lowest Priority settings in percent of max BW', LEFT);"
		onMouseOut="return nd();">
		<!--#tr id="lowest"-->Lowest<!--#endtr--></td>
		<td class="CR">
			<input name="ibw_lo" size="3" maxlength="3" onChange="qos_recalc(3);"> &nbsp;&nbsp;&nbsp; 
			<INPUT maxLength=40 size=3 name=in_lo style="text-align: center; border: 1px solid #FFFFFF; padding: 0" readonly> Kbit/s
		</td>
	</tr>
</table>

<table width="100%" class="tbl_main">
	<tr>
		<td class="CT" colspan="2"><!--#tr id="qos.10"-->Outbound Class Setting<!--#endtr--></td>
	</tr>
	<tr>
		<td class="CL"
		onMouseOver="return overlib('Outbound traffic classes.', LEFT);"
		onMouseOut="return nd();" height="21">
		<!--#tr id="qos.11"-->Outbound Classes<br> (% Max Output BW)<!--#endtr-->
		</td>
		<td class="CR"></td>
	</tr>
	<tr>
		<td class="CL"
		onMouseOver="return overlib('Sets the maximum bw for outbound traffic.', LEFT);"
		onMouseOut="return nd();">
		<!--#tr id="qos.12"-->BW Max Outbound<!--#endtr-->
		</td>
		<td class="CR">
			<input id="ocs_BwMaxInbound" name="qos_obw" value="<% nvram_get("qos_obw"); %>" onChange="qos_recalc(2);" size="6" maxlength="6"> Kbit/s
		</td>
	</tr>
	<tr>
		<td class="CL">
		</td>
		<td class="CR">
			<font size="1">%BWMin&nbsp;&nbsp;%BWMax</font>
		</td>
	</tr>
	<tr>
		<td class="CL"
		onMouseOver="return overlib('Highest Priority settings in percent of max BW', LEFT);"
		onMouseOut="return nd();">
		<!--#tr id="highest"-->Highest<!--#endtr--></td>
		<td class="CR">
			<input name="obw_hi_lower" size="3" maxlength="3" onChange="qos_recalc(2);">
			<input name="obw_hi_higher" size="3" maxlength="3" onChange="qos_recalc(2);">&nbsp;&nbsp;&nbsp; 
			<INPUT maxLength=40 size=3 name=hi_lo style="text-align: center; border: 1px solid #FFFFFF; padding: 0" readonly> 
			-- 
			<INPUT maxLength=40 size=3 name=hi_hi style="text-align: center; border: 1px solid #FFFFFF; padding: 0" readonly> Kbit/s
		</td>
	</tr>
	<tr>
		<td class="CL"
		onMouseOver="return overlib('High Priority settings in percent of max BW', LEFT);"
		onMouseOut="return nd();">
		<!--#tr id="high"-->High<!--#endtr--></td>
		<td class="CR">
			<input name="obw_h_lower" size="3" maxlength="3" onChange="qos_recalc(2);">
			<input name="obw_h_higher" size="3" maxlength="3" onChange="qos_recalc(2);">&nbsp;&nbsp;&nbsp; 
			<INPUT maxLength=40 size=3 name=h_lo style="text-align: center; border: 1px solid #FFFFFF; padding: 0" readonly> 
			-- 
			<INPUT maxLength=40 size=3 name=h_hi style="text-align: center; border: 1px solid #FFFFFF; padding: 0" readonly> Kbit/s
		</td>
	</tr>
	<tr>
		<td class="CL"
		onMouseOver="return overlib('Medium Priority settings in percent of max BW', LEFT);"
		onMouseOut="return nd();">
		<!--#tr id="medium"-->Medium<!--#endtr--></td>
		<td class="CR">
			<input name="obw_med_lower"  size="3" maxlength="3" onChange="qos_recalc(2);">
			<input name="obw_med_higher" size="3" maxlength="3" onChange="qos_recalc(2);">&nbsp;&nbsp;&nbsp; 
			<INPUT maxLength=40 size=3 name=med_lo style="text-align: center; border: 1px solid #FFFFFF; padding: 0" readonly> 
			-- 
			<INPUT maxLength=40 size=3 name=med_hi style="text-align: center; border: 1px solid #FFFFFF; padding: 0" readonly> Kbit/s
		</td>
	</tr>
	<tr>
		<td class="CL"
		onMouseOver="return overlib('Low Priority settings in percent of max BW', LEFT);"
		onMouseOut="return nd();">
		<!--#tr id="low"-->Low<!--#endtr--></td>
		<td class="CR">
			<input name="obw_l_lower" size="3" maxlength="3" onChange="qos_recalc(2);">
			<input name="obw_l_higher" size="3" maxlength="3" onChange="qos_recalc(2);">&nbsp;&nbsp;&nbsp; 
			<INPUT maxLength=40 size=3 name=l_lo style="text-align: center; border: 1px solid #FFFFFF; padding: 0" readonly> 
			-- 
			<INPUT maxLength=40 size=3 name=l_hi style="text-align: center; border: 1px solid #FFFFFF; padding: 0" readonly> Kbit/s
		</td>
	</tr>
	<tr>
		<td class="CL"
		onMouseOver="return overlib('Lowest Priority settings in percent of max BW', LEFT);"
		onMouseOut="return nd();">
		<!--#tr id="lowest"-->Lowest<!--#endtr--></td>
		<td class="CR">
			<input name="obw_lo_lower" size="3" maxlength="3" onChange="qos_recalc(2);">
			<input name="obw_lo_higher" size="3" maxlength="3" onChange="qos_recalc(2);">&nbsp;&nbsp;&nbsp; 
			<INPUT maxLength=40 size=3 name=lo_lo style="text-align: center; border: 1px solid #FFFFFF; padding: 0" readonly> 
			-- 
			<INPUT maxLength=40 size=3 name=lo_hi style="text-align: center; border: 1px solid #FFFFFF; padding: 0" readonly> Kbit/s
		</td>
	</tr>
</table>

<table width="100%" class="tbl_main">
	<tr align="center">
		<td>
			<input type="submit" class="<!--#tr id="buttonWidth"-->button1<!--#endtr-->" name="action" value="<!--#tr id="apply"-->Apply<!--#endtr-->"> 
			<input type="button" class="button1" value="<!--#tr id="cancel"-->Cancel<!--#endtr-->" onClick="window.location.reload();">
		</td>
	</tr>
</table>
</form>

<form name="adddel" method="post" action="/uapply.cgi">
<input type="hidden" name="page" value="/internet/qos.asp">
<input type="hidden" name="token" value="<% genToken(); %>">
<input type="hidden" name="qos_orules" value="<% nvram_get("qos_orules"); %>">
<input type="hidden" name="action" value="Apply">
<!-- add table -->
<div style="display:block;" id="tabAdd">   
<table width="100%" class="tbl_main">
	<tr>
		<td class="CT" colspan="2"><!--#tr id="qos.13"-->QoS Rule Add<!--#endtr--></td>
	</tr>
	<tr>
		<td class="CL"
		onMouseOver="return overlib('Add Qos Rule (Outbound). The rules are evaluated top to bottom, as shown in the GUI. The *first* one that matches sets the class.', LEFT);"
		onMouseOut="return nd();" height="21">
		<!--#tr id="qos.14"-->Add QoS Rule (Outbound)<!--#endtr-->
		</td>
		<td class="CR"></td>
	</tr>  
	<tr>
		<td class="CL"
		onMouseOver="return overlib('IQos IP/MAC Address Filter Setting', LEFT);"
		onMouseOut="return nd();">
		<!--#tr id="qos.15"-->IP/MAC Address Filter<!--#endtr--></td>
		<td class="CR">
			<select name="qos_ip" onchange="turnOffInputBySelector(this, document.adddel.qos_ipaddr, 0)">
				<option value="0"><!--#tr id="any"-->Any<!--#endtr--></option>
				<option value="1"><!--#tr id="qos.16"-->Destination IP<!--#endtr--></option>
				<option value="2"><!--#tr id="qos.17"-->Source IP<!--#endtr--></option>
				<option value="3"><!--#tr id="qos.18"-->Source MAC<!--#endtr--></option>
			</select>
			&nbsp; <!--#tr id="qos.19"-->Address:<!--#endtr--> <input name="qos_ipaddr" size="17" maxlength="17" disabled="true">
		</td>
	</tr>
	<tr>
		<td class="CL"
		onMouseOver="return overlib('Protocol Filter', LEFT);"
		onMouseOut="return nd();">
		<!--#tr id="qos.20"-->Protocol Filter<!--#endtr--></td>
		<td class="CR">
			<select name="qos_proto">
				<option value="-2"><!--#tr id="any"-->Any<!--#endtr--></option>
				<option value="-1"><!--#tr id="qos.21"-->TCP/UDP<!--#endtr--></option>
				<option value="6"><!--#tr id="tcp"-->TCP<!--#endtr--></option>
				<option value="17"><!--#tr id="udp"-->UDP<!--#endtr--></option>
			</select>
		</td>
	</tr>
	<tr>
		<td class="CL"
		onMouseOver="return overlib('IQos Port Filter Setting', LEFT);"
		onMouseOut="return nd();" >
		<!--#tr id="qos.22"-->Port Filter<!--#endtr--></td>
		<td class="CR">
			<select name="qos_port" onchange="turnOffInputBySelector(this, document.adddel.qos_port_num, 0)">
				<option value="0"><!--#tr id="any"-->Any<!--#endtr--></option>
				<option value="1"><!--#tr id="qos.23"-->Destination Port<!--#endtr--></option>
				<option value="2"><!--#tr id="qos.24"-->Source Port<!--#endtr--></option>
				<option value="3"><!--#tr id="qos.25"-->Source or Destination<!--#endtr--></option>
			</select>
			&nbsp; <!--#tr id="qos.26"-->Port List:<!--#endtr--> <input name="qos_port_num" size="13" maxlength="16" disabled="true">
		</td>
	</tr>
	<tr>
		<td class="CL"
		onMouseOver="return overlib('Set the IQos Classes', LEFT);"
		onMouseOut="return nd();">
		<!--#tr id="qos.27"-->Class Assigned<!--#endtr--></td>
		<td class="CR">
			<select name="qos_class">
				<option value="0"><!--#tr id="highest"-->Highest<!--#endtr--></option>
				<option value="1"><!--#tr id="high"-->High<!--#endtr--></option>
				<option value="2"><!--#tr id="medium"-->Medium<!--#endtr--></option>
				<option value="3"><!--#tr id="low"-->Low<!--#endtr--></option>
				<option value="4"><!--#tr id="lowest"-->Lowest<!--#endtr--></option>
			</select>
		</td>
	</tr>
	<tr>
		<td class="CL"
		onMouseOver="return overlib('Description of the rule', LEFT);"
		onMouseOut="return nd();">
		<!--#tr id="qos.28"-->Description<!--#endtr--></td>
		<td class="CR">
			<input name="qos_desc" size="32" maxlength="32">
		</td>
	</tr>
</table>

<table width="100%" class="tbl_main">
	<tr align="center">
		<td>
			<INPUT type="button" class="<!--#tr id="buttonWidth"-->button1<!--#endtr-->" value="<!--#tr id="qos.29"-->Add Rule<!--#endtr-->" onclick="addRule();">
		</td>
	</tr>
</table>
</div>

<!-- edit table -->
<div style="display:none;" id="tabEdit">
<table width="100%" class="tbl_main">
	<tr>
		<td class="CT" colspan="2"><!--#tr id="qos.48"-->QoS Rule Edit<!--#endtr--></td>
	</tr>
	<tr>
		<td class="CL"
		onMouseOver="return overlib('Edit/Make changes to the IQos Rules (Outbound).', LEFT);"
		onMouseOut="return nd();" height="21">
		<!--#tr id="qos.49"-->Edit QoS Rule (Outbound)<!--#endtr--></td>
		<td class="CR">
			<INPUT type="hidden" maxLength="20" size="12" name="ruleNo" style="text-align: center; border: 1px solid #FFFFFF; padding: 0">
			<span id="ruleNo_name"></span>
		</td>
	</tr>  
	<tr>
		<td class="CL"
		onMouseOver="return overlib('IQos IP/MAC Address Filter Setting', LEFT);"
		onMouseOut="return nd();">
		<!--#tr id="qos.15"-->IP/MAC Address Filter<!--#endtr--></td>
		<td class="CR">
			<select name="qos_ip_e">
				<option value="0"><!--#tr id="any"-->Any<!--#endtr--></option>
				<option value="1"><!--#tr id="qos.16"-->Destination IP<!--#endtr--></option>
				<option value="2"><!--#tr id="qos.17"-->Source IP<!--#endtr--></option>
				<option value="3"><!--#tr id="qos.18"-->Source MAC<!--#endtr--></option>
			</select>
			&nbsp; <!--#tr id="qos.19"-->Address:<!--#endtr--> <input name="qos_ipaddr_e" size="17" maxlength="17">
		</td>
	</tr>
	<tr>
		<td class="CL"
		onMouseOver="return overlib('IQos Protocol Filter - TCP, UDP, Any etc.', LEFT);"
		onMouseOut="return nd();">
		<!--#tr id="qos.20"-->Protocol Filter<!--#endtr--></td>
		<td class="CR">
			<select name="qos_proto_e">
				<option value="-2"><!--#tr id="any"-->Any<!--#endtr--></option>
				<option value="-1"><!--#tr id="qos.21"-->TCP/UDP<!--#endtr--></option>
				<option value="6"><!--#tr id="tcp"-->TCP<!--#endtr--></option>
				<option value="17"><!--#tr id="udp"-->UDP<!--#endtr--></option>
			</select>
		</td>
	</tr>
	<tr>
		<td class="CL"
		onMouseOver="return overlib('Port Filter Setting', LEFT);"
		onMouseOut="return nd();" >
		<!--#tr id="qos.22"-->Port Filter<!--#endtr--></td>
		<td class="CR">
			<select name="qos_port_e">
				<option value="0"><!--#tr id="any"-->Any<!--#endtr--></option>
				<option value="1"><!--#tr id="qos.23"-->Destination Port<!--#endtr--></option>
				<option value="2"><!--#tr id="qos.24"-->Source Port<!--#endtr--></option>
				<option value="3"><!--#tr id="qos.25"-->Source or Destination<!--#endtr--></option>
			</select>
			&nbsp; <!--#tr id="qos.26"-->Port List:<!--#endtr--> <input name="qos_port_num_e" size="16" maxlength="16">
		</td>
	</tr>
	<tr>
		<td class="CL"
		onMouseOver="return overlib('Qos Class Setting', LEFT);"
		onMouseOut="return nd();">
		<!--#tr id="qos.27"-->Class Assigned<!--#endtr--></td>
		<td class="CR">
			<select name="qos_class_e">
				<option value="0"><!--#tr id="qos.41"-->Highest<!--#endtr--></option>
				<option value="1"><!--#tr id="qos.42"-->High<!--#endtr--></option>
				<option value="2"><!--#tr id="qos.43"-->Medium<!--#endtr--></option>
				<option value="3"><!--#tr id="qos.44"-->Low<!--#endtr--></option>
				<option value="4"><!--#tr id="qos.45"-->Lowest<!--#endtr--></option>
			</select>
		</td>
	</tr>
	<tr>
		<td class="CL"
		onMouseOver="return overlib('Description of the rule', LEFT);"
		onMouseOut="return nd();">
		<!--#tr id="qos.38"-->Description<!--#endtr--></td>
		<td class="CR">
			<input name="qos_desc_e" size="32" maxlength="32">
		</td>
	</tr>
</table>

<table width="100%" class="tbl_main">
	<tr align="center">
		<td>
			<INPUT type="button" class="button1" name="subEdit" value="<!--#tr id="qos.submit.edit"-->Submit Edit<!--#endtr-->" onclick="submitEdit();">&nbsp;
			<INPUT type="button" class="button1" name="resEdit" value="<!--#tr id="qos.reset.edit"-->Reset Edit<!--#endtr-->" onclick="resetEdit();">
		</td>
	</tr>
</table>
</div>

<table width="100%" class="tbl_main">
	<tr>
		<td class="CT" colspan="2"><!--#tr id="qos.30"-->QoS Rule List<!--#endtr--></td>
	</tr>
<script language="JavaScript" type="text/javascript">
	printTable();
</script>
</table>
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
