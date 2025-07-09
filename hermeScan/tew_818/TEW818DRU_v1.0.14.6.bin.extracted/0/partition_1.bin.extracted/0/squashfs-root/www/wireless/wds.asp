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
function wl_basic_rateset_change()
{
	var phytype = document.radio.wl_phytype[document.radio.wl_phytype.selectedIndex].value;
	var i, cur, defrs;

	/* Define new rateset */
	if (phytype == "a")
		defrs = new Array("Default", "All");
	else
		defrs = new Array("Default", "All", "12");

	/* Save current rateset */
	for (i = 0; i < document.radio.wl_rateset.length; i++) {
		if (document.radio.wl_rateset[i].selected) {
			cur = document.radio.wl_rateset[i].value;
			break;
		}
	}

	/* Reconstruct rateset array from new rateset */
	document.radio.wl_rateset.length = defrs.length;
	for (var i in defrs) {
		if (defrs[i].toLowerCase() == "12")
			document.radio.wl_rateset[i] = new Option("1 & 2 Mbps", defrs[i].toLowerCase());
		else
			document.radio.wl_rateset[i] = new Option(defrs[i], defrs[i].toLowerCase());
		document.radio.wl_rateset[i].value = defrs[i].toLowerCase();
		if (defrs[i].toLowerCase() == cur)
			document.radio.wl_rateset[i].selected = true;
	}
}

function wl_rate_change()
{
 	var nphy_set = "<% wl_nphy_set(); %>";
	var phytype;
	var gmode = document.radio.wl_gmode[document.radio.wl_gmode.selectedIndex].value;
	var country = document.radio.wl_country_code[document.radio.wl_country_code.selectedIndex].value;
	var chanspec;
	var channel;
	var band;
	var i, cur, mcur, rates, rate;
	var radioid;
	var nmode;

	if (nphy_set == "1") {
		phytype = "n";
		band = document.radio.wl_nband[document.radio.wl_nband.selectedIndex].value;
		nmode = document.radio.wl_nmode[document.radio.wl_nmode.selectedIndex].value;
	} else {
		phytype =  document.radio.wl_phytype[document.radio.wl_phytype.selectedIndex].value;
		nmode = "0";
	}
	/* Save current rate */
	for (i = 0; i < document.radio.wl_rate.length; i++) {
		if (document.radio.wl_rate[i].selected) {
			cur = document.radio.wl_rate[i].value;
			break;
		}
	}

	if (document.radio.wl_chanspec.length > 0)
		chanspec = document.radio.wl_chanspec[document.radio.wl_chanspec.selectedIndex].value;
	else
		chanspec = 0;


	/* Save current mcast rate */
	for (i = 0; i < document.radio.wl_mrate.length; i++) {
		if (document.radio.wl_mrate[i].selected) {
			mcur = document.radio.wl_mrate[i].value;
			break;
		}
	}

	/* Define new rates */
	if (phytype == "b") {
		/* XXX BCM2051/BCM2053 cannot transmit at 5.5 and 11 Mbps in Japan on channel 14 */
		radioid = "<% wl_radioid("b"); %>";
		if (radioid != "BCM2050" && country == "JP" && chanspec == "14")
			rates = new Array(0, 1, 2);
		else
			rates = new Array(0, 1, 2, 5.5, 11);
	} else if (phytype == "g") {
		/* Japan does not allow OFDM rates on channel 14 */
		if ((country == "JP" && chanspec == "14") || gmode == "0")
			rates = new Array(0, 1, 2, 5.5, 11);
		else
			rates = new Array(0, 1, 2, 5.5, 6, 9, 11, 12, 18, 24, 36, 48, 54);
	} else if (phytype == "a") {
		rates = new Array(0, 6, 9, 12, 18, 24, 36, 48, 54);
	} else if (phytype == "n") {
		/* Exclude auto for unicast legacy rates */
		/* 5 Ghz */
		if (band == "1") {
			rates = new Array(6, 9, 12, 18, 24, 36, 48, 54);
		} else if (band == "2") {
			/* Japan does not allow OFDM rates on channel 14 */
			if (country == "JP" && chanspec == "14")
				rates = new Array(1, 2, 5.5, 11);
			else	
				rates = new Array(1, 2, 5.5, 6, 9, 11, 12, 18, 24, 36, 48, 54);
		}
		/* Add auto back if nmode is disabled */
		if (nmode == "0")
			rates.unshift(0);
		if (<% nvram_get("wl_rate"); %> == 0)
			cur = 0;
	} else
		return;

	/* Reconstruct rate array from new rates */
	document.radio.wl_rate.length = rates.length;
	for (var i in rates) {
		rate = rates[i] * 1000000;
		if (rates[i] == 0)
			document.radio.wl_rate[i] = new Option("<!--#tr id="auto"-->Auto<!--#endtr-->", rate);
		else
			document.radio.wl_rate[i] = new Option(rates[i] + " Mbps", rate);
		document.radio.wl_rate[i].value = rate;
		if (rate == cur)
			document.radio.wl_rate[i].selected = true;
	}

	/* Add auto for multicast. Unshift adds element to the beginning! */
	if (phytype == "n" && nmode != "0")
		rates.unshift(0);

	/* Reconstruct multicast rate array from new rates */
	document.radio.wl_mrate.length = rates.length;
	for (var i in rates) {
		rate = rates[i] * 1000000;
		if (rates[i] == 0)
			document.radio.wl_mrate[i] = new Option("<!--#tr id="auto"-->Auto<!--#endtr-->", rate);
		else
			document.radio.wl_mrate[i] = new Option(rates[i] + " Mbps", rate);
		document.radio.wl_mrate[i].value = rate;
		if (rate == mcur)
			document.radio.wl_mrate[i].selected = true;
	}
}

function wl_country_list_change(nphy_set)
{
	var phytype;
	var band;
	var cur = 0;
	var sel = 0;

	if (nphy_set == "1") {
		phytype = "n";
		band  = document.radio.wl_nband[document.radio.wl_nband.selectedIndex].value;
	} else
		phytype =  document.radio.wl_phytype[document.radio.wl_phytype.selectedIndex].value;

	/* Save current country */
	for (i = 0; i < document.radio.wl_country_code.length; i++) {
		if (document.radio.wl_country_code[i].selected) {
			cur = document.radio.wl_country_code[i].value;
			break;
		}
	}

	if (phytype == "a") {
		<% wl_um_country_list("a"); %>
	} else if (phytype == "n") {
		if (band == "1") {
			<% wl_um_country_list("n", 1); %>
		} else if (band == "2") {
			<% wl_um_country_list("n", 2); %>
		}
	} else {
		<% wl_um_country_list("b"); %>
	}

	/* Reconstruct country_code array from new countries */
	document.radio.wl_country_code.length = countries.length;
	for (var i in countries) {
		document.radio.wl_country_code[i].value = countries[i];
		if (countries[i] == cur) {
			document.radio.wl_country_code[i].selected = true;
			sel = 1;
		}
	}

	if (sel == 0)
		document.radio.wl_country_code[0].selected = true;
}

function wl_country_rev_list_change(nphy_set)
{
	var phytype;
	var band;
	var country = document.radio.wl_country_code[document.radio.wl_country_code.selectedIndex].value;
	var country_revs = new Array(0);
	var cur = 0;
	var sel = 0;

	if (nphy_set == "1") {
		phytype = "n";
		band  = document.radio.wl_nband[document.radio.wl_nband.selectedIndex].value;
	} else
		phytype =  document.radio.wl_phytype[document.radio.wl_phytype.selectedIndex].value;

	/* Save current country_rev */
	for (i = 0; i < document.radio.wl_country_rev.length; i++) {
		if (document.radio.wl_country_rev[i].selected) {
			cur = document.radio.wl_country_rev[i].value;
			break;
		}
	}

	if (phytype == "a") {
		<% wl_um_country_rev_list("a"); %>
	} else if (phytype == "n") {
		if (band == "1") {
			<% wl_um_country_rev_list("n", 1); %>
		} else if (band == "2") {
			<% wl_um_country_rev_list("n", 2); %>
		}
	} else {
		<% wl_um_country_rev_list("b"); %>
	}

	/* Reconstruct country_rev array from new selected */
	document.radio.wl_country_rev.length = country_revs.length;
	for (var i in country_revs) {
		document.radio.wl_country_rev[i] = new Option(country_revs[i], country_revs[i]);
		document.radio.wl_country_rev[i].value = country_revs[i];
		if (country_revs[i] == cur) {
			document.radio.wl_country_rev[i].selected = true;
			sel = 1;
		}
	}

	if (sel == 0)
		document.radio.wl_country_rev[0].selected = true;

}

//Tom.Hung 2012-11-6, Sort option list
function each(object, callback) { 
    if (undefined === object.length) { 
        for ( var name in object) { 
            if (false === callback(object[name], name, object)) 
                break; 
        } 
    } else { 
        for ( var i = 0, len = object.length; i < len; i++) { 
            if (i in object) { 
                if (false === callback(object[i], i, object)) 
                    break; 
            } 
        } 
    } 
} 

function addOption(object, object2) { 
    each(object2, function(o, index) { 
        object.options[index] = o; 
    }) 
} 

function map(object, callback, thisp) { 
    var ret = []; 
    each.call(thisp, object, function() { 
        ret.push(callback.apply(thisp, arguments)); 
    }); 
    return ret; 
} 

function sortlist(sortName,isDesc) { 
    var what = sortName; 
    this._options = map(what.options, function(o) { 
        return o; 
    }); 
    this._options.sort( function(a, b) { 
        if (a.text*1 < b.text*1 || a.text == "<!--#tr id="auto"-->Auto<!--#endtr-->") { 
            return isDesc == true ? 1 : -1; 
        } else { 
            return isDesc == true ? -1 : 1; 
        } 
    }); 
    what.options.length = 0;// clear current options 
    addOption(what, this._options); 
} 
//Tom.Hung 2012-11-6 end

function wl_chanspec_list_change(nphy_set)
{
	var phytype;
	var band;
	var bw_cap;
	var country = document.radio.wl_country_code[document.radio.wl_country_code.selectedIndex].value;
	var chanspecs = new Array(0);
	var cur = 0;
	var cur_text;
	var sel = 0;
	var nmode;

	if (nphy_set == "1") {
		phytype = "n";
		band  = document.radio.wl_nband[document.radio.wl_nband.selectedIndex].value;
		nmode = document.radio.wl_nmode[document.radio.wl_nmode.selectedIndex].value;
		if (nmode == "0") {
			document.radio.wl_bw_cap.selectedIndex = 0;
			document.radio.wl_bw_cap.disabled = true;
		} else {
			document.radio.wl_bw_cap.disabled = false;
		}		
		bw_cap = document.radio.wl_bw_cap[document.radio.wl_bw_cap.selectedIndex].value;

	} else {
		phytype =  document.radio.wl_phytype[document.radio.wl_phytype.selectedIndex].value;
	}

	/* Save current chanspec */
	for (i = 0; i < document.radio.wl_chanspec.length; i++) {
		if (document.radio.wl_chanspec[i].selected) {
			cur = document.radio.wl_chanspec[i].value;
			cur_text = document.radio.wl_chanspec[i].text
			break;
		}
	}

	if (phytype == "a") {
		<% wl_chanspec_list("a"); %>
	} else if (phytype == "n") {
		if (band == "1") {
			/* 5 GHz */
			if (bw_cap == "1") {
				<% wl_chanspec_list("n", "1", 20); %>
			} else if (bw_cap == "3") {
				<% wl_chanspec_list("n", "1", 40); %>
			} else {
				<% wl_chanspec_list("n", "1", 80); %>
			}
		} else if (band == "2") {
			/* 2.4 GHz */
			if (bw_cap == "1") {
				<% wl_chanspec_list("n", "2", 20 ); %>
			} else if (bw_cap == "3") {
				<% wl_chanspec_list("n", "2", 40 ); %>
			}
		}
	} else {
		<% wl_chanspec_list("b"); %>
	}

	/* Reconstruct channel array from new chanspecs */
	document.radio.wl_chanspec.length = chanspecs.length;
	for (var i in chanspecs) {
		//Tom.Hung 2012-11-6, Don't show 36u,36l,36/80.
		var reg = /(u|l|(\/80))?/gi;
		var str = chanspecs[i].toString();
		var ch_display = str.replace(reg, "");
		//Tom.Hung 2012-11-6 end
		if (chanspecs[i] == 0)
			document.radio.wl_chanspec[i] = new Option("<!--#tr id="auto"-->Auto<!--#endtr-->", chanspecs[i]);
		else
			document.radio.wl_chanspec[i] = new Option(ch_display, chanspecs[i]);
		document.radio.wl_chanspec[i].value = chanspecs[i];
		if (chanspecs[i] == cur || document.radio.wl_chanspec[i].text == cur_text) {
			document.radio.wl_chanspec[i].selected = true;
			sel = 1;
		}
	}

	//Tom.Hung 2012-11-6, Sort option list
	//Remove same chanspec
	var chanspec_select = document.radio.wl_chanspec;
	//Tom.Hung 2012-11-7, work around to hide 5G DFS channel (52~140)
	for(i=0;i<chanspec_select.length;i++) {
		if(chanspec_select[i].text != "<!--#tr id="auto"-->Auto<!--#endtr-->" &&
			(parseInt(chanspec_select[i].text, 10) > 48 && parseInt(chanspec_select[i].text, 10) < 149)) {
			chanspec_select.remove(i);
			i--;
		}
	}
	//Tom.Hung 2012-11-7 end
	for(i=0;i<chanspec_select.length;i++) {
		for(j=i+1;j<chanspec_select.length;j++) {
			if(chanspec_select[i].text == chanspec_select[j].text) {
				chanspec_select.remove(j);
				j--;
			}
		}
	}
	//Sort chanspec
	sortlist(chanspec_select, false);
	//Keep cur chanspec
	for(i=0;i<chanspec_select.length;i++) {
		if(chanspec_select[i].value == cur || chanspec_select[i].text == cur_text) {
			chanspec_select[i].selected = true;
			sel = 1;
		}
	}
	//Tom.Hung 2012-11-6 end

	if (sel == 0 && document.radio.wl_chanspec.length > 0)
		document.radio.wl_chanspec[0].selected = true;
}

function wl_ewc_options(nphy_set)
{
	var bw;
	var bw_cap;
	var band;
	var frameburst;
	var chanspec;
	var nmode;

	//Tom.Hung 2012-12-4, Keep cur MCS index
	var cur_mcsidx;
	var nmcsidx = document.radio.wl_nmcsidx;
	for(i=0;i<nmcsidx.length;i++) {
		if(nmcsidx[i].selected == true) {
			cur_mcsidx = nmcsidx[i].value;
			break;
		}
	}
	//Tom.Hung 2012-12-4 end

	if (nphy_set == "0")
		return;

	if (document.radio.wl_chanspec.length > 0)
		chanspec = document.radio.wl_chanspec[document.radio.wl_chanspec.selectedIndex].value;
	else
		chanspec = 0;
	nmode = document.radio.wl_nmode[document.radio.wl_nmode.selectedIndex].value;
	if (chanspec == "0" && nmode != "0") {
		<% wl_um_nphyrates("0"); %>
		document.radio.wl_nmcsidx.disabled = false;
		document.radio.wl_gmode.disabled = true;
		//Tom.Hung 2012-12-4, Keep cur MCS index
		for(i=0;i<nmcsidx.length;i++) {
			if(nmcsidx[i].value == cur_mcsidx) {
				nmcsidx[i].selected = true;
				break;
			}
		}
		//Tom.Hung 2012-12-4 end
		return;
	}

	document.radio.wl_chanspec.disabled = 0;
	if (document.radio.wl_nphyrate != null)
		document.radio.wl_nphyrate.disabled = 0;
	document.radio.wl_bw_cap.disabled = 0;

	frameburst = document.radio.wl_frameburst[document.radio.wl_frameburst.selectedIndex].value;
/*
#ifdef BCMINTERNAL
*/
	/* Disable RIFS when frameburst is off */
	if (frameburst == "on") {
		document.radio.wl_rifs.disabled = 0;
	}  else {
		document.radio.wl_rifs.disabled = 1;
	}
/*
#endif
*/
	/* If nmode is disabled, allow only 20Mhz selection */
        if (nmode == "0") {
		document.radio.wl_bw_cap.selectedIndex = 0;
		document.radio.wl_bw_cap.disabled = 1;
	}

	band = document.radio.wl_nband[document.radio.wl_nband.selectedIndex].value;
	bw_cap = document.radio.wl_bw_cap[document.radio.wl_bw_cap.selectedIndex].value;

	/* TODO: Need to add 80 MHz phy rates... */
	if (bw_cap == "7")
		bw = "40";
	else if (bw_cap == "3")
		bw = "40";
	else
		bw = "20";

	if (bw == "40") {
		<% wl_um_nphyrates("40"); %>
	} else if (bw == "20") {
		<% wl_um_nphyrates("20"); %>
	}

	if (nmode == "0") {
		document.radio.wl_nmcsidx.disabled = true;
		if (band == "1")
			document.radio.wl_gmode.disabled = true;
		else if (band == "2")
			document.radio.wl_gmode.disabled = false;
	} else {
		document.radio.wl_nmcsidx.disabled = false;
		document.radio.wl_gmode.disabled = true;
	}

	//Tom.Hung 2012-12-4, Keep cur MCS index
	for(i=0;i<nmcsidx.length;i++) {
		if(nmcsidx[i].value == cur_mcsidx) {
			nmcsidx[i].selected = true;
			break;
		}
	}
	//Tom.Hung 2012-12-4 end
}

function wl_phytype_change()
{
	var phytype = document.radio.wl_phytype[document.radio.wl_phytype.selectedIndex].value;
	var gmode = document.radio.wl_gmode[document.radio.wl_gmode.selectedIndex].value;

	if (phytype == "g") {
		document.radio.wl_gmode.disabled = 0;
		document.radio.wl_gmode_protection.disabled = 0;
	} else {
		document.radio.wl_gmode.disabled = 1;
	}

	if (phytype == "b" || (phytype == "g" && (gmode == "0" || gmode == "1")))
		document.radio.wl_plcphdr.disabled = 0;
	else
		document.radio.wl_plcphdr.disabled = 1;

	wl_basic_rateset_change();
}

function wl_nband_change()
{

	var bandtype = document.radio.wl_nband[document.radio.wl_nband.selectedIndex].value;

	if (bandtype == "2")
		document.radio.wl_plcphdr.disabled = 0;
	else 
		document.radio.wl_plcphdr.disabled = 1;

	/*
	 * This block of code checks to see if 80 MHz is listed. If it is
	 * and the band selected is 2.4 GHz, then hide the 80 MHz selection
	 * since it is not a valid option for that band.
	 */
	if (document.radio.wl_bw_cap.length == 3) {
		if (bandtype == "2") {
			if (document.radio.wl_bw_cap[2].selected) {
				document.radio.wl_bw_cap[0].selectedIndex = 0;
				/* document.radio.wl_bw_cap[0].selected = true; */
			}
			document.radio.wl_bw_cap[2].style.display = 'none';
		} else {
			document.radio.wl_bw_cap[2].style.display = '';
		}
	}
}

function wl_mode_onchange()
{
	//The following variable is set when the user changes wl_mode
	document.radio.wl_mode_changed = 1;
	wl_mode_change();
}

function wl_mode_change()
{
	var mode = document.radio.wl_mode[document.radio.wl_mode.selectedIndex].value;
	var ure = document.radio.wl_ure[document.radio.wl_ure.selectedIndex].value;

	if (mode == "sta" || mode == "wet" || mode == "psta" || mode == "psr") {
		document.radio.wl_infra.disabled = 0;
/*
#ifdef BCMINTERNAL
*/
		document.radio.wl_lazywds.disabled = 1;
		document.radio.wl_wds0.disabled = 1;
		document.radio.wl_wds1.disabled = 1;
		document.radio.wl_wds2.disabled = 1;
		document.radio.wl_wds3.disabled = 1;
		document.radio.wl_wds_timeout.disabled = 1;
/* 
#endif
*/
		document.radio.wl_sta_retry_time.disabled = 0;
    // Provide an intelligent setting when URE or WL mode is changed
		if( document.radio.wl_mode_changed == 1 || 
		    document.radio.wl_ure_changed == 1 ) {
			if( mode == "psta" || mode == "psr" ) { // Proxy or Repeater
				document.radio.wl_sta_retry_time.value = 5;
				document.radio.wl_ure[0].disabled = 1;
				document.radio.wl_ure[1].disabled = 1;
			} else if( mode == "wet" )  // WET or RangeExtender
				document.radio.wl_sta_retry_time.value = 5;
			else if ( ure == "1" )    // Travel Router
				document.radio.wl_sta_retry_time.value = 300;
			else //STA
				document.radio.wl_sta_retry_time.value = 0;

			document.radio.wl_mode_changed = 0;
			document.radio.wl_ure_changed = 0;
		}
	}
	else {
		document.radio.wl_infra.disabled = 1;
/*
#ifdef BCMINTERNAL
*/
		document.radio.wl_lazywds.disabled = 0;
		document.radio.wl_wds0.disabled = 0;
		document.radio.wl_wds1.disabled = 0;
		document.radio.wl_wds2.disabled = 0;
		document.radio.wl_wds3.disabled = 0;
		document.radio.wl_wds_timeout.disabled = 0;
/* 
#endif
*/
		document.radio.wl_sta_retry_time.disabled = 1;
	}
}

function wl_ure_onchange()
{
	//The following variable is set when the user changes wl_ure
	document.radio.wl_ure_changed = 1;
	wl_ure_change();
}

function wl_ure_change()
{
	var mode = document.radio.wl_ure[document.radio.wl_ure.selectedIndex].value;
	var router_disable = "<% nvram_get("router_disable"); %>";

	if( mode == "1" ) {
		if (router_disable == "1") {
			document.radio.wl_mode.value = "wet";
		}
		else {
			document.radio.wl_mode.value = "sta";
		}
		document.radio.wl_mode.disabled=1;
		document.radio.wl_infra.disabled = 0;
		document.radio.wl_lazywds.disabled = 0;
		document.radio.wl_wds0.disabled = 0;
		document.radio.wl_wds1.disabled = 0;
		document.radio.wl_wds2.disabled = 0;
		document.radio.wl_wds3.disabled = 0;
		document.radio.wl_wds_timeout.disabled = 0;
	}
	else {
	  document.radio.wl_mode.disabled=0;
	}
	wl_mode_change();
	document.radio.wl_ure_changed = 0;
}

function wl_gmode_options(nphy_set)
{
	var gmode = "<% nvram_get("wl_gmode"); %>";
	var index;

	if (nphy_set == "1")
		document.radio.wl_gmode.disabled = 1;
	else
		document.radio.wl_gmode.disabled = 0;

	if (gmode == "2") {
		index = document.radio.wl_gmode.length;
		document.radio.wl_gmode[index] = new Option("54g Only", "2");
		document.radio.wl_gmode[index].selected = true;
	}
}
function wl_amsdu_options(nphy_set)
{
	var amsdu;

        if (nphy_set == "0")
                return;

	amsdu = "<% wl_inlist("cap", "amsdu"); %>";
/*
#ifdef BCMINTERNAL
*/
	if (amsdu != "1")
		document.radio.wl_amsdu.disabled = 1;
	else
		document.radio.wl_amsdu.disabled = 0;
/*
#endif
*/
}

function wl_wme_options(nphy_set)
{
	var w_ind = document.radio.wl_wme.selectedIndex;
	var w_val = document.radio.wl_wme[w_ind].value;

	document.radio.wl_wme.disabled = 0;

	if (w_val == "off") {
		document.radio.wl_wme_no_ack.disabled = 1;
		document.radio.wl_wme_apsd.disabled = 1;
	} else {
		document.radio.wl_wme_no_ack.disabled = 0;
		document.radio.wl_wme_apsd.disabled = 0;
	}
}

function wl_ure_modes()
{
	var isap = "<% wl_inlist("cap", "ap"); %>";
	var issta = "<% wl_inlist("cap", "sta"); %>";

	if (isap != "1" || issta != "1") {
		document.radio.wl_ure[0].selected = 1;
		document.radio.wl_ure[1].disabled = 1;
	} else {
		document.radio.wl_ure[1].disabled = 0;
	}
}

function wl_mcs_onchange()
{
 	var nphy_set = "<% wl_nphy_set(); %>";
	var mcs_val;
	var nmode;
	if (nphy_set == "0")
		return;
	mcs_val =  document.radio.wl_nmcsidx[document.radio.wl_nmcsidx.selectedIndex].value;
	nmode = document.radio.wl_nmode[document.radio.wl_nmode.selectedIndex].value;

	/* If using 'legacy rate' then enable */
	if (mcs_val == "-2" || nmode == "0")
		document.radio.wl_rate.disabled = 0;
	else
		document.radio.wl_rate.disabled = 1;
}

function wl_nmode_change()
{
<% wl_nphy_comment_beg(); %>
	var crypto = "<% wl_crypto(); %>";
	var wep = "<% wl_wep(); %>";
	var wl_akm_wpa = "<% nvram_inlist("wl_akm", "wpa", "1"); %>"*1;
	var wl_akm_psk = "<% nvram_inlist("wl_akm", "psk", "1"); %>"*1;
	var wl_akm_wpa2 = "<% nvram_inlist("wl_akm", "wpa2", "1"); %>"*1;
	var wl_akm_psk2 = "<% nvram_inlist("wl_akm", "psk2", "1"); %>"*1;
	var i, cur, options;

	/* Save current selected nmode option */
	cur = document.radio.wl_nmode[document.radio.wl_nmode.selectedIndex].value;

	if (((wl_akm_wpa == 1 || wl_akm_psk == 1 || wl_akm_wpa2 == 1 || wl_akm_psk2 == 1) && crypto == "tkip") || wep == "enabled") {
		document.radio.wl_nmode.length = 1;
		document.radio.wl_nmode[0] = new Option("<!--#tr id="off"-->Off<!--#endtr-->", "0");
		document.radio.wl_nmode[0].value = "0";
		if (document.radio.wl_nmode[0].value == cur)
			document.radio.wl_nmode[0].selected = true;
	} else {
		document.radio.wl_nmode.length = 2;
		document.radio.wl_nmode[0] = new Option("<!--#tr id="auto"-->Auto<!--#endtr-->", "-1");
		document.radio.wl_nmode[0].value = "-1";
		if (document.radio.wl_nmode[0].value == cur)
			document.radio.wl_nmode[0].selected = true;
		document.radio.wl_nmode[1] = new Option("<!--#tr id="off"-->Off<!--#endtr-->", "0");
		document.radio.wl_nmode[1].value = "0";
		if (document.radio.wl_nmode[1].value == cur)
			document.radio.wl_nmode[1].selected = true;
	}
<% wl_nphy_comment_end(); %>
}

function wl_recalc()
{
 	var nphy_set = "<% wl_nphy_set(); %>";

	if (nphy_set != "1")
		wl_phytype_change();
	else
		wl_nband_change();
	wl_country_list_change(nphy_set);
	wl_country_rev_list_change(nphy_set);
	wl_chanspec_list_change(nphy_set);
	wl_mode_change();
	wl_gmode_options(nphy_set);
	wl_nmode_change();
	wl_rate_change();
	wl_ewc_options(nphy_set);
	wl_amsdu_options(nphy_set);
	wl_wme_options(nphy_set);
	wl_ure_change();
	wl_ure_modes();
	wl_mcs_onchange(); /* This has to be after wl_ewc_options */
}

function applyCheck() {
	
	var re3 = /^[\w\~\`\!\@\#\$\%\^\&\*\(\)\_\+\-\=\\\|\[\{\]\}\;\:\'\"\/\?\.\>\,\<\ ]+$/;//Griffin -for check SSID
	
	//Tom.Hung 2009-2-12, SSID can't include invalid characters.
	if (!re3.test(document.radio.wl_ssid.value) && document.radio.wl_ssid.value != "") {
		Alert.render("<!--#tr id="ssid.error"-->Invalid characters in SSID!<!--#endtr-->");
		return false;
	}
    
    for (var i = 0; i < 4; i++)
    {
        var macAddressElement = document.getElementById("macAddress" + i);
        if (!isBlankString(macAddressElement.value) && !checkMac(macAddressElement.value)) 
        {
            macAddressElement.focus();
            Alert.render("<!--#tr id="mac.address.error"-->Invalid MAC address! Please enter a valid MAC address.<!--#endtr-->");
            return false;
        }
    }
    //Set redirect location
	var unit = "<% nvram_get("wl_unit"); %>";
	var redirect_page = document.getElementById("page");
	var redirect_value = "/redirect.asp?url=/wireless/wds.asp%3Fwl_unit%3D"+unit;
	redirect_page.value = redirect_value;
	
    totalWaitTime = 25;
	wait_page();
	document.getElementById("waitPad").style.display="block";
	scroll(0,0);
	return true;
}

function page_load() {
	wl_recalc();
	//Tom.Hung 2012-11-19, Keep cur MCS index
	var cur_mcsidx = "<% nvram_get("wl_nmcsidx"); %>";
	var nmcsidx = document.radio.wl_nmcsidx;
	for(i=0;i<nmcsidx.length;i++) {
		if(nmcsidx[i].value == cur_mcsidx) {
			nmcsidx[i].selected = true;
			break;
		}
	}
	//Tom.Hung 2012-11-19 end
	//Tom.Hung 2013-3-15, Hide fourth ssid because it used for guest network
	document.radio.wl_bssid.remove(3);
	//Tom.Hung 2013-3-15 end
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
<h1><!--#tr id="wireless.node.wds"-->WDS<!--#endtr--></h1>
<div class="hr" ></div>
<p>
<!--#tr id="advanced.wireless.wds.desc"-->This page allows you to configure Wireless Distribution System (WDS) for the wireless LAN interfaces.<!--#endtr-->
</p>

<form name="radio" method="post" action="/wireless/wds.asp" onsubmit="return applyCheck();" target="rebootRedirect">
<input type="hidden" name="page" id="page" value="/wireless/wds.asp">
<input type="hidden" name="token" value="<% genToken(); %>">
<div style="display:none">
<table width="100%" class="tbl_main">
	<tr>
		<td class="CT" colspan="2"><!--#tr id="wireless.interface"-->Wireless Interface<!--#endtr--></td>
	</tr>
	<tr>
		<td class="CL"
		onMouseOver="return overlib('Selects which wireless interface to configure.', LEFT);"
		onMouseOut="return nd();">
		<!--#tr id="wireless.interface"-->Wireless Interface<!--#endtr-->
		</td>
		<td class="CR">
			<select name="wl_unit" onChange="submit();">
				<% wl_um_list(); %>
			</select>
		</td>
	</tr>
</table>
</div>

<table width="100%" class="tbl_main" style="display:none">
	<tr>
		<td class="CT" colspan="2" <% nvram_invmatch("wl_unit_if", "0", "style=display:none"); %>><!--#tr id="wireless.network"-->Wireless Network<!--#endtr--></td>
		<td class="CT" colspan="2" <% nvram_invmatch("wl_unit_if", "1", "style=display:none"); %>><!--#tr id="wireless.network.ac"-->AC Wireless Network (802.11ac/a/n)<!--#endtr--></td>
	</tr>
	<tr>
		<td class="CL"
		onMouseOver="return overlib('Selects desired BSS to configure.', LEFT);"
		onMouseOut="return nd();">
		<!--#tr id="basic.4"-->Multiple SSID<!--#endtr-->
		</td>
		<td class="CR">
			<select name="wl_bssid" onChange="submit();">
				<% wl_bssid_list(); %>
			</select>
		</td>
	</tr>
	<tr>
		<td class="CL"
		onMouseOver="return overlib('Enables or disables this SSID .', LEFT);"
		onMouseOut="return nd();">
		<!--#tr id="basic.5"-->Radio On/Off<!--#endtr-->
		</td>
		<td class="CR">
			<select name="wl_bss_enabled">
				<option value="0" <% nvram_match("wl_bss_enabled", "0", "selected"); %>><!--#tr id="off"-->Off<!--#endtr--></option> 
				<option value="1" <% nvram_match("wl_bss_enabled", "1", "selected"); %>><!--#tr id="on"-->On<!--#endtr--></option>
			</select>
		</td>
	</tr>  
	<tr>
		<td class="CL"
		onMouseOver="return overlib('Enable/Disable 802.11N support.', LEFT);"
		onMouseOut="return nd();">
		<!--#tr id="basic.6"-->802.11 n-mode<!--#endtr-->
		</td>
		<td class="CR">
			<select name="wl_nmode" onChange="wl_recalc();">
				<option value="-1" <% nvram_match("wl_nmode", "-1", "selected"); %>><!--#tr id="auto"-->Auto<!--#endtr--> </option>
				<option value="0" <% nvram_match("wl_nmode", "0", "selected"); %>><!--#tr id="off"-->Off<!--#endtr--> </option>
			</select>
		</td>
	</tr>
	<tr>
		<td class="CL"
		onMouseOver="return overlib('Sets the Network Name (also known as SSID) of this network.', LEFT);"
		onMouseOut="return nd();">
		<!--#tr id="wireless.name.ssid"-->Wireless Name (SSID)<!--#endtr-->
		</td>
		<td class="CR">
			<input name="wl_ssid" value="<% nvram_get("wl_ssid"); %>" size="32" maxlength="32" onkeydown="return prevent_press_enter(event);">
		</td>
	</tr>  
	<tr>
		<td class="CL"
		onMouseOver="return overlib('Selecting <b>Closed</b> hides the network from active scans. Selecting <b>Open</b> reveals the network to active scans.', LEFT);"
		onMouseOut="return nd();">
		<!--#tr id="basic.8"-->Broadcast Network Name (SSID)<!--#endtr-->
		</td>
		<td class="CR">
			<select name="wl_closed" onChange="wl_closed_check();">
				<option value="0" <% nvram_match("wl_closed", "0", "selected"); %>><!--#tr id="enabled"-->Enabled<!--#endtr--></option>
				<option value="1" <% nvram_match("wl_closed", "1", "selected"); %>><!--#tr id="disabled"-->Disabled<!--#endtr--></option>
			</select>
		</td>
	</tr>
	<tr>
		<td class="CL"
		onMouseOver="return overlib('Selects a channel specification.', LEFT);"
		onMouseOut="return nd();">
		<!--#tr id="basic.9"-->Frequency (Channel)<!--#endtr--></td>
		<td class="CR">
			<select name="wl_chanspec" onChange="wl_recalc();">
			<option	 value="<% nvram_get("wl_chanspec"); %>" selected></option>
			</select>&nbsp;&nbsp;<!--<% wl_cur_chanspec(); %>-->
		</td>
	</tr>
</table>

<table width="100%" class="tbl_main">
	<tr>
		<td class="CT" colspan="2"><!--#tr id="basic.10"-->Wireless Distribution System (WDS)<!--#endtr--></td>
	</tr>
	<tr>
		<td class="CL" valign="top" rowspan="5"
		onmouseover="return overlib('Enter the peer wireless MAC addresses of any wireless bridges that should be part of the wireless distribution system (WDS).', LEFT);"
		onmouseout="return nd();">
		<input type="hidden" name="wl_wds" value="4" />
		<!--#tr id="basic.11"-->AP MAC Address<!--#endtr-->
		</td>
	</tr>
	<tr>
		<td class="CR">
			<input id="macAddress0" name="wl_wds0" value="<% nvram_list("wl_wds", 0); %>" size="17" maxlength="17" onkeydown="return prevent_press_enter(event);" />
			&nbsp;&nbsp;<!--<% wl_wds_status(0); %>-->
		</td>
	</tr>
	<tr>
		<td class="CR">
			<input id="macAddress1" name="wl_wds1" value="<% nvram_list("wl_wds", 1); %>" size="17" maxlength="17" onkeydown="return prevent_press_enter(event);" />
			&nbsp;&nbsp;<!--<% wl_wds_status(1); %>-->
		</td>
	</tr>
	<tr>
		<td class="CR">
			<input id="macAddress2" name="wl_wds2" value="<% nvram_list("wl_wds", 2); %>" size="17" maxlength="17" onkeydown="return prevent_press_enter(event);" />
			&nbsp;&nbsp;<!--<% wl_wds_status(2); %>-->
		</td>
	</tr>
	<tr>
		<td class="CR">
			<input id="macAddress3" name="wl_wds3" value="<% nvram_list("wl_wds", 3); %>" size="17" maxlength="17" onkeydown="return prevent_press_enter(event);" />
			&nbsp;&nbsp;<!--<% wl_wds_status(3); %>-->
		</td>
	</tr>
	<tr style="display:none">
		<td class="CL"
		onmouseover="return overlib('Selecting <b>Disabled</b> disables wireless bridge restriction. Any wireless bridge (including the ones listed in <b>Remote Bridges</b>) will be granted access. Selecting <b>Enabled</b> enables wireless bridge restriction. Only those bridges listed in <b>Remote Bridges</b> will be granted access.', LEFT);"
		onmouseout="return nd();"> Bridge Restriction</td>
		<td class="CR">
			<select name="wl_lazywds">
				<option value="0" <% nvram_match("wl_lazywds", "0", "selected"); %>>Enabled</option>
				<option value="1" <% nvram_match("wl_lazywds", "1", "selected"); %>>Disabled</option>
			</select>
		</td>
	</tr>
	<tr style="display:none">
		<td class="CL"
		onmouseover="return overlib('Sets the Wireless bridge link detection interval in seconds. Leave blank or set to zero to disable the detection', LEFT);"
		onmouseout="return nd();"> Bridge Link Detection Interval</td>
		<td class="CR">
			<input name="wl_wds_timeout" value="<% nvram_get("wl_wds_timeout"); %>" size="10" maxlength="10" onkeydown="return prevent_press_enter(event);"/>
		</td>
	</tr>
<!--
#ifdef BCMPLC
-->
	<tr style="display:none">
		<td class="CL"
		onmouseover="return overlib('When this option is enabled, PLC network is supported. When this option is disabled, PLC network is not supported.', LEFT);"
		onmouseout="return nd();"> PLC Support</td>
		<td class="CR">
			<select name="wl_plc">
				<option value="0" <% nvram_match("wl_plc", "0", "selected"); %>>Disabled</option>
				<option value="1" <% nvram_match("wl_plc", "1", "selected"); %>>Enabled</option>
			</select>
		</td>
	</tr>
<!--
#endif
-->
</table>

<div id="ht_mode">
<table width="100%" class="tbl_main" style="display:none">
	<tr>
		<td class="CT" colspan="2"><!--#tr id="basic.14"-->HT Physical Mode<!--#endtr--></td>
	</tr>
<% wl_nphy_comment_beg(); %>
	<tr>
		<td class="CL"
		onMouseOver="return overlib('Selects Channel Bandwidth', LEFT);"
		onMouseOut="return nd();">
		<!--#tr id="basic.15"-->Channel Bandwidth<!--#endtr--></td>
		<td class="CR">
			<select name="wl_bw_cap" onChange="wl_recalc();">
			  <% wl_bw_cap_list(); %>
			</select>
			&nbsp;&nbsp;<!--<% wl_cur_bw(); %>-->
		</td>
	</tr>
	<tr>
		<td class="CL"
		onMouseOver="return overlib('Select NPHY Rate (MCS Index)', LEFT);"
		onMouseOut="return nd();">
		<!--#tr id="basic.16"-->MCS<!--#endtr--></td>
		<td class="CR">
			<select name="wl_nmcsidx" onChange="wl_mcs_onchange();">
			</select>
		</td>
	</tr>
<% wl_nphy_comment_end(); %>
</table>
</div>

<div style="display:none">
<table width="100%" class="tbl_main">
 <tr>
    <td class="CL"
	onMouseOver="return overlib('Restricts the channel set based on country requirements.', LEFT);"
	onMouseOut="return nd();">
	Country</td>
    <td class="CR">
	<select name="wl_country_code" onChange="wl_recalc();">
	  <option value="<% wl_cur_country(); %>" selected></option>
	</select>
	&nbsp;&nbsp;Current: <% wl_cur_country(); %>    </td>
  </tr>
  <tr>
    <td class="CL"
	onMouseOver="return overlib('Country regulatory revision index.', LEFT);"
	onMouseOut="return nd();">
	Regulatory Revision</td>
    <td class="CR">
	<select name="wl_country_rev" onChange="wl_recalc();">
	  <option value="<% wl_cur_regrev(); %>" selected></option>
	</select>
	&nbsp;&nbsp;Current: <% wl_cur_regrev(); %>    </td>
  </tr>
</table>
</div>

<div style="display:none">
<table width="100%" class="tbl_main">
  <tr>
    <td class="CL"
	onMouseOver="return overlib('Enables or disables the wireless Interface.', LEFT);"
	onMouseOut="return nd();">
	Interface</td>
    <td class="CR">
	<select name="wl_radio">
	  <option value="0" <% nvram_match("wl_radio", "0", "selected"); %>>Disabled</option>
	  <option value="1" <% nvram_match("wl_radio", "1", "selected"); %>>Enabled</option>
	</select>    </td>
  </tr>
  <tr>
    <td class="CL"
	onMouseOver="return overlib('Selects 802.11 Band to use.', LEFT);"
	onMouseOut="return nd();">
	802.11 Band</td>
    <td class="CR">
	<select name=<% wl_phytype_name(); %>  onChange="wl_recalc();">
	  <% wl_phytypes(); %>
	</select>
	&nbsp;&nbsp;<% wl_cur_phytype(); %>    </td>
  </tr>
<% wl_nphy_comment_beg(); %>
  <tr>
    <td class="CL"
	onMouseOver="return overlib('Select number of transmit chains to use', LEFT);"
	onMouseOut="return nd();">
	NPHY TxChains</td>
    <td class="CR">
	<select name="wl_txchain" onChange="wl_recalc();">
<% wl_txchains_list();%>
	</select>    </td>
  </tr>
  <tr>
    <td class="CL"
	onMouseOver="return overlib('Select number of receive chains to support', LEFT);"
	onMouseOut="return nd();">
	NPHY RxChains</td>
    <td class="CR">
	<select name="wl_rxchain">
<% wl_rxchains_list();%>
	</select>    </td>
  </tr>
<% wl_nphy_comment_end(); %>
  <tr>
    <td class="CL"
	onMouseOver="return overlib('Set the mode to 54g Auto for the widest compatibility. Set the mode to 54g Performance for the fastest performance among 54g certified equipment. Set the mode to 54g LRS if you are experiencing difficulty with legacy 802.11b equipment.', LEFT);"
	onMouseOut="return nd();">
	54g&#8482; Mode</td>
    <td class="CR">
	<select name="wl_gmode" onChange="wl_recalc();">
	  <option value="1" <% nvram_match("wl_gmode", "1", "selected"); %>>54g Auto</option>
	  <option value="4" <% nvram_match("wl_gmode", "4", "selected"); %>>54g Performance</option>
	  <option value="5" <% nvram_match("wl_gmode", "5", "selected"); %>>54g LRS</option>
	  <option value="0" <% nvram_match("wl_gmode", "0", "selected"); %>>802.11b Only</option>
	</select>    </td>
  </tr>
  <tr>
	<% wl_protection(); %>
  </tr>
  <tr>
        <% wl_mimo_preamble(); %>
  </tr>
  <tr>
    <td class="CL"
	onMouseOver="return overlib('Advertise packet priority using VLAN tag.', LEFT);"
	onMouseOut="return nd();">
	VLAN Priority Support</td>
    <td class="CR">
	<select name="wl_vlan_prio_mode">
	  <option value="off" <% nvram_match("wl_vlan_prio_mode", "off", "selected"); %>>Off </option>
	  <option value="on" <% nvram_match("wl_vlan_prio_mode", "on", "selected"); %>>On </option>
	</select>    </td>
  </tr>
  <tr>
    <td class="CL"
	onMouseOver="return overlib('Forces the transmission rate for the AP to a particular speed.', LEFT);"
	onMouseOut="return nd();">
	<% wl_legacy_string(); %> Rate</td>
    <td class="CR">
	<select name="wl_rate">
	  <!-- All a/b/g rates -->
	  <option value="0" <% nvram_match("wl_rate", "0", "selected"); %>>Auto</option>
	  <option value="1000000" <% nvram_match("wl_rate", "1000000", "selected"); %>>1 Mbps</option>
	  <option value="2000000" <% nvram_match("wl_rate", "2000000", "selected"); %>>2 Mbps</option>
	  <option value="5500000" <% nvram_match("wl_rate", "5500000", "selected"); %>>5.5 Mbps</option>
	  <option value="6000000" <% nvram_match("wl_rate", "6000000", "selected"); %>>6 Mbps</option>
	  <option value="9000000" <% nvram_match("wl_rate", "9000000", "selected"); %>>9 Mbps</option>
	  <option value="11000000" <% nvram_match("wl_rate", "11000000", "selected"); %>>11 Mbps</option>      
	  <option value="12000000" <% nvram_match("wl_rate", "12000000", "selected"); %>>12 Mbps</option>
	  <option value="18000000" <% nvram_match("wl_rate", "18000000", "selected"); %>>18 Mbps</option>
	  <option value="24000000" <% nvram_match("wl_rate", "24000000", "selected"); %>>24 Mbps</option>
	  <option value="36000000" <% nvram_match("wl_rate", "36000000", "selected"); %>>36 Mbps</option>
	  <option value="48000000" <% nvram_match("wl_rate", "48000000", "selected"); %>>48 Mbps</option>
	  <option value="54000000" <% nvram_match("wl_rate", "54000000", "selected"); %>>54 Mbps</option>
	</select>    </td>
  </tr>
  <tr>
    <td class="CL"
	onMouseOver="return overlib('Selects the basic rates that wireless clients must support.', LEFT);"
	onMouseOut="return nd();">
	Basic Rate Set</td>
    <td class="CR">
	<select name="wl_rateset">
	  <option value="default" <% nvram_match("wl_rateset", "default", "selected"); %>>Default</option>
	  <option value="all" <% nvram_match("wl_rateset", "all", "selected"); %>>All</option>
	  <option value="12" <% nvram_match("wl_rateset", "12", "selected"); %>>1 & 2 Mbps</option>
	</select>    </td>
  </tr>
  <tr>
    <td class="CL"
	onMouseOver="return overlib('Forces the multicast/broadcast transmission rate for the AP to a particular speed.', LEFT);"
	onMouseOut="return nd();">
	Multicast Rate</td>
    <td class="CR">
	<select name="wl_mrate">
	  <!-- All a/b/g rates -->
	  <option value="0" <% nvram_match("wl_mrate", "0", "selected"); %>>Auto</option>
	  <option value="1000000" <% nvram_match("wl_mrate", "1000000", "selected"); %>>1 Mbps</option>
	  <option value="2000000" <% nvram_match("wl_mrate", "2000000", "selected"); %>>2 Mbps</option>
	  <option value="5500000" <% nvram_match("wl_mrate", "5500000", "selected"); %>>5.5 Mbps</option>
	  <option value="6000000" <% nvram_match("wl_mrate", "6000000", "selected"); %>>6 Mbps</option>
	  <option value="9000000" <% nvram_match("wl_mrate", "9000000", "selected"); %>>9 Mbps</option>
	  <option value="11000000" <% nvram_match("wl_mrate", "11000000", "selected"); %>>11 Mbps</option>      
	  <option value="12000000" <% nvram_match("wl_mrate", "12000000", "selected"); %>>12 Mbps</option>
	  <option value="18000000" <% nvram_match("wl_mrate", "18000000", "selected"); %>>18 Mbps</option>
	  <option value="24000000" <% nvram_match("wl_mrate", "24000000", "selected"); %>>24 Mbps</option>
	  <option value="36000000" <% nvram_match("wl_mrate", "36000000", "selected"); %>>36 Mbps</option>
	  <option value="48000000" <% nvram_match("wl_mrate", "48000000", "selected"); %>>48 Mbps</option>
	  <option value="54000000" <% nvram_match("wl_mrate", "54000000", "selected"); %>>54 Mbps</option>
	</select>    </td>
  </tr>
<!--
#ifdef BCMINTERNAL
-->
  <tr>
    <td class="CL"
	onMouseOver="return overlib('Broadcom Dynamic Channel Selection Support.', LEFT);"
	onMouseOut="return nd();">
	Broadcom DCS</td>
    <td class="CR">
	<select name="wl_bcmdcs">
	  <option value="off" <% nvram_match("wl_bcmdcs", "off", "selected"); %>>Off </option>
	  <option value="on" <% nvram_match("wl_bcmdcs", "on", "selected"); %>>On </option>
	</select>    </td>
  </tr>	
  <tr>
    <td class="CL"
	onMouseOver="return overlib('Selects the transmitting antenna.', LEFT);"
	onMouseOut="return nd();">
	Antenna Diversity</td>
    <td class="CR">
	<select name="wl_antdiv">
	  <option value="-1" <% nvram_match("wl_antdiv", "-1", "selected"); %>>Default</option>
	  <option value="0" <% nvram_match("wl_antdiv", "0", "selected"); %>>Use Antenna 0</option>
	  <option value="1" <% nvram_match("wl_antdiv", "1", "selected"); %>>Use Antenna 1</option>
	  <option value="3" <% nvram_match("wl_antdiv", "3", "selected"); %>>Auto Select</option>
	</select>    </td>
  </tr>
<!--
#endif
-->
</table>
</div>

<div style="display:none">
<table width="100%" class="tbl_main">
  <tr>
    <td class="CL"
	onMouseOver="return overlib('Selects a regulatory mode to use.', LEFT);"
	onMouseOut="return nd();">
	Regulatory Mode</td>
    <td class="CR">
	<select name="wl_reg_mode" onChange="wl_recalc();">
	  <option value="off" <% nvram_match("wl_reg_mode", "off", "selected"); %>>Off</option>
	  <option value="h" <% nvram_match("wl_reg_mode", "h", "selected"); %>>802.11H Loose</option>
	  <option value="strict_h" <% nvram_match("wl_reg_mode", "strict_h", "selected"); %>>802.11H Strict</option>
	  <option value="d" <% nvram_match("wl_reg_mode", "d", "selected"); %>>802.11D</option>
	</select>    </td>
  </tr>
  <tr>
    <td class="CL"
	onMouseOver="return overlib('Power Mitigation factor (in db)', LEFT);"
	onMouseOut="return nd();">
	TPC Mitigation (db)</td>
    <td class="CR">
	<select name="wl_tpc_db">
	  <option value="0" <% nvram_match("wl_tpc_db", "off", "selected"); %>>0 (Off)</option>
	  <option value="2" <% nvram_match("wl_tpc_db", "2", "selected"); %>>2</option>
	  <option value="3" <% nvram_match("wl_tpc_db", "3", "selected"); %>>3</option>
	  <option value="4" <% nvram_match("wl_tpc_db", "4", "selected"); %>>4</option>
	</select>    </td>
  </tr>
</table>
</div>

<% wl_nphy_comment_beg(); %>
<div style="display:none">
<table width="100%" class="tbl_main">
  <tr>
    <td class="CL"
	onMouseOver="return overlib('Enable/Disable Overlapping BSS Coexisistence aka 20/40 Coex.', LEFT);"
	onMouseOut="return nd();">
	OBSS Coexistence</td>
    <td class="CR">
	<select name="wl_obss_coex">
	  <option value="0" <% nvram_match("wl_obss_coex", "0", "selected"); %>>Off</option>
	  <option value="1" <% nvram_match("wl_obss_coex", "1", "selected"); %>>On</option>
	</select>    </td>
  </tr>
</table>
</div>
<% wl_nphy_comment_end(); %>  

<div style="display:none">
<table width="100%" class="tbl_main">
  <tr>
    <td class="CL"
	onMouseOver="return overlib('Sets the fragmentation threshold.', LEFT);"
	onMouseOut="return nd();">
	Fragmentation Threshold</td>
    <td class="CR"><input name="wl_frag" value="<% nvram_get("wl_frag"); %>" size="4" maxlength="4"></td>
  </tr>
  <tr>
    <td class="CL"
	onMouseOver="return overlib('Sets the RTS threshold.', LEFT);"
	onMouseOut="return nd();">
	RTS Threshold</td>
    <td class="CR"><input name="wl_rts" value="<% nvram_get("wl_rts"); %>" size="4" maxlength="4"></td>
  </tr>
  <tr>
    <td class="CL"
	onMouseOver="return overlib('Sets the wakeup interval for clients in power-save mode.', LEFT);"
	onMouseOut="return nd();">
	DTIM Interval</td>
    <td class="CR"><input name="wl_dtim" value="<% nvram_get("wl_dtim"); %>" size="4" maxlength="4"></td>
  </tr>
  <tr>
    <td class="CL"
	onMouseOver="return overlib('Sets the beacon interval for the AP.', LEFT);"
	onMouseOut="return nd();">
	Beacon Interval</td>
    <td class="CR"><input name="wl_bcn" value="<% nvram_get("wl_bcn"); %>" size="4" maxlength="4"></td>
  </tr>
  <tr>
    <td class="CL"
	onMouseOver="return overlib('Enable/Disable rotation of beacon order when running in MultiBSS mode.', LEFT);"
	onMouseOut="return nd();">
	Beacon Rotation:</td>
    <td class="CR">
	<select name="wl_bcn_rotate">
	  <option value="1" <% nvram_match("wl_bcn_rotate", "1", "selected"); %>>Enabled</option>
	  <option value="0" <% nvram_match("wl_bcn_rotate", "0", "selected"); %>>Disabled</option>
	</select>    </td>
  </tr>
  <tr>
    <td class="CL"
	onMouseOver="return overlib('Sets whether short or long preambles are used. Short preambles improve throughput but all clients in the wireless network must support this capability if selected.', LEFT);"
	onMouseOut="return nd();">
	Preamble Type</td>
    <td class="CR">
	<select name="wl_plcphdr">
	  <option value="long" <% nvram_match("wl_plcphdr", "long", "selected"); %>>Long</option>
	  <option value="short" <% nvram_match("wl_plcphdr", "short", "selected"); %>>Short</option>
	</select>    </td>
  </tr>
  <tr>
    <td class="CL"
	onMouseOver="return overlib('Sets the Associations the Driver Should Accept.', LEFT);"
	onMouseOut="return nd();">
	Max Associations Limit</td>
    <td class="CR"><input name="wl_maxassoc" value="<% nvram_get("wl_maxassoc"); %>" size="4" maxlength="4"></td>
</table>
</div>

<div style="display:none">
<table width="100%" class="tbl_main">
  <tr>
    <td class="CL"
	onMouseOver="return overlib('Enable/Disable XPress mode', LEFT);"
	onMouseOut="return nd();">
	XPress&#8482; Technology</td>
    <td class="CR">
	<select name="wl_frameburst" onChange="wl_recalc();">
	  <option value="off" <% nvram_match("wl_frameburst", "off", "selected"); %>>Off</option>
	  <option value="on" <% nvram_match("wl_frameburst", "on", "selected"); %>>On</option>
	</select>    </td>
  </tr>  
</table>
</div>
<% wl_nphy_comment_beg(); %>
<div style="display:none">
<table width="100%" class="tbl_main">
<% wl_nphy_comment_end(); %>
<!--
#ifdef BCMINTERNAL
-->
<% wl_nphy_comment_beg(); %>
  <tr>
    <td class="CL"
	onMouseOver="return overlib('Enable/Disable A-MSDU mode.  Fragmentation must be disabled when A-MSDU mode is enabled', LEFT);"
	onMouseOut="return nd();">
	A-MSDU Technology</td>
    <td class="CR">
	<select name="wl_amsdu">
	  <option value="auto" <% nvram_match("wl_amsdu", "auto", "selected"); %>>Auto</option>
	  <option value="off" <% nvram_match("wl_amsdu", "off", "selected"); %>>Off</option>
	  <option value="on" <% nvram_match("wl_amsdu", "on", "selected"); %>>On</option>
	</select>    </td>
  </tr>  
  <tr>
    <td class="CL"
	onMouseOver="return overlib('Enable/Disable A-MPDU mode.', LEFT);"
	onMouseOut="return nd();">
	A-MPDU Technology</td>
    <td class="CR">
	<select name="wl_ampdu">
	  <option value="auto" <% nvram_match("wl_ampdu", "auto", "selected"); %>>Auto</option>
	  <option value="off" <% nvram_match("wl_ampdu", "off", "selected"); %>>Off</option>
	  <option value="on" <% nvram_match("wl_ampdu", "on", "selected"); %>>On</option>
	</select>    </td>
  </tr>  
  <tr>
    <td class="CL"
	onMouseOver="return overlib('Enable/Disable RIFS transmissions (Need to have Framebursting).', LEFT);"
	onMouseOut="return nd();">
	RIFS mode</td>
    <td class="CR">
	<select name="wl_rifs">
	  <option value="auto" <% nvram_match("wl_rifs", "auto", "selected"); %>>Auto</option>
	  <option value="off" <% nvram_match("wl_rifs", "off", "selected"); %>>Off</option>
	  <option value="on" <% nvram_match("wl_rifs", "on", "selected"); %>>On</option>
	</select>    </td>
  </tr>
<% wl_nphy_comment_end(); %>
<!--
#endif
-->
<% wl_nphy_comment_beg(); %>	
  <tr>
    <td class="CL"
	onMouseOver="return overlib('RIFS mode to advertise in beacons and probe responses.', LEFT);"
	onMouseOut="return nd();">
	RIFS Mode Advertisement</td>
    <td class="CR">
	<select name="wl_rifs_advert">
	  <option value="auto" <% nvram_match("wl_rifs_advert", "auto", "selected"); %>>Auto</option>
	  <option value="off" <% nvram_match("wl_rifs_advert", "off", "selected"); %>>Off</option>
	</select>    </td>
  </tr>
<% wl_nphy_comment_end(); %>
<!--
#ifdef BCMINTERNAL
-->
<% wl_nphy_comment_beg(); %>	
  <tr>
    <td class="CL"
	onMouseOver="return overlib('Enable/Disable STBC for transmissions.', LEFT);"
	onMouseOut="return nd();">
	STBC Tx</td>
    <td class="CR">
	<select name="wl_stbc_tx">
	  <option value="auto" <% nvram_match("wl_stbc_tx", "auto", "selected"); %>>Auto</option>
	  <option value="on" <% nvram_match("wl_stbc_tx", "on", "selected"); %>>On</option>
	  <option value="off" <% nvram_match("wl_stbc_tx", "off", "selected"); %>>Off</option>
	</select>    </td>
  </tr>
<% wl_nphy_comment_end(); %>
<!--
#endif
-->
<% wl_nphy_comment_beg(); %>	
</table>
</div>
<% wl_nphy_comment_end(); %>

<div style="display:none">
<table width="100%" class="tbl_main">
  <tr>
    <td class="CL"
	onMouseOver="return overlib('Enable/Disable WMM support', LEFT);"
	onMouseOut="return nd();">
	WMM Support</td>
    <td class="CR">
	<select name="wl_wme" onChange="wl_recalc();">
	  <option value="auto" <% nvram_match("wl_wme", "auto", "selected"); %>>Auto</option>
	  <option value="off" <% nvram_match("wl_wme", "off", "selected"); %>>Off</option>
	  <option value="on" <% nvram_match("wl_wme", "on", "selected"); %>>On</option>
	</select>    </td>
  </tr>
  <tr>
    <td class="CL"
	onMouseOver="return overlib('Enable/Disable WMM No-Acknowledgment', LEFT);"
	onMouseOut="return nd();">
	No-Acknowledgement</td>
    <td class="CR">
	<select name="wl_wme_no_ack">
	  <option value="off" <% nvram_match("wl_wme_no_ack", "off", "selected"); %>>Off</option>
	  <option value="on" <% nvram_match("wl_wme_no_ack", "on", "selected"); %>>On</option>
	</select>    </td>
  </tr>
  <tr>
    <td class="CL"
	onMouseOver="return overlib('Enable/Disable Automatic Power Save Delivery', LEFT);"
	onMouseOut="return nd();">
	APSD Support</td>
    <td class="CR">
	<select name="wl_wme_apsd">
	  <option value="off" <% nvram_match("wl_wme_apsd", "off", "selected"); %>>Off</option>
	  <option value="on" <% nvram_match("wl_wme_apsd", "on", "selected"); %>>On</option>
	</select>    </td>
  </tr>
  <tr>
    <td class="CL" valign="top" rowspan="1"
	onMouseOver="return overlib('WMM EDCA Parameters for AP.  CW value should be one less than a power of 2.  TXOP value should be a multiple of 32.', LEFT);"
	onMouseOut="return nd();">
	<input type="hidden" name="wme_ap" value="8">
	EDCA AP Parameters</td>
    <td class="label">CWmin</td>
    <td class="label">CWmax</td>
    <td class="label">AIFSN</td>
    <td class="label">TXOP(b)<br>Limit (usec)</td>
    <td class="label">TXOP(a/g)<br>Limit (usec)</td>
    <td class="label">Admission<br>Control</td>
    <td class="label">Discard<br>Oldest First</td>
  </tr>
  <tr>	
    <td class="CL" valign="top" rowspan="1"
	onMouseOver="return overlib('AP AC_BE parameters', LEFT);"
	onMouseOut="return nd();">
	<input type="hidden" name="wl_wme_ap_be" value="5">
	AC_BE</td>
	<td><input name="wl_wme_ap_be0" value="<% nvram_list("wl_wme_ap_be", 0); %>" size="6" maxlength="6"></td>
	<td><input name="wl_wme_ap_be1" value="<% nvram_list("wl_wme_ap_be", 1); %>" size="6" maxlength="6"></td>
	<td><input name="wl_wme_ap_be2" value="<% nvram_list("wl_wme_ap_be", 2); %>" size="6" maxlength="6"></td>
	<td><input name="wl_wme_ap_be3" value="<% nvram_list("wl_wme_ap_be", 3); %>" size="6" maxlength="6"></td>
	<td><input name="wl_wme_ap_be4" value="<% nvram_list("wl_wme_ap_be", 4); %>" size="6" maxlength="6"></td>
	<td>
          <select name="wl_wme_ap_be5">
	    <option value="off" <% nvram_indexmatch("wl_wme_ap_be", 5, "off", "selected"); %>>Off</option>
	    <option value="on" <% nvram_indexmatch("wl_wme_ap_be", 5, "on", "selected"); %>>On</option>
	  </select>	</td>
	<td>
          <select name="wl_wme_ap_be6">
	    <option value="off" <% nvram_indexmatch("wl_wme_ap_be", 6, "off", "selected"); %>>Off</option>
	    <option value="on" <% nvram_indexmatch("wl_wme_ap_be", 6, "on", "selected"); %>>On</option>
	  </select>	</td>
  </tr>
  <tr>	
    <td class="CL" valign="top" rowspan="1"
	onMouseOver="return overlib('AP AC_BK parameters', LEFT);"
	onMouseOut="return nd();">
	<input type="hidden" name="wl_wme_ap_bk" value="5">
	AC_BK</td>
	<td><input name="wl_wme_ap_bk0" value="<% nvram_list("wl_wme_ap_bk", 0); %>" size="6" maxlength="6"></td>
	<td><input name="wl_wme_ap_bk1" value="<% nvram_list("wl_wme_ap_bk", 1); %>" size="6" maxlength="6"></td>
	<td><input name="wl_wme_ap_bk2" value="<% nvram_list("wl_wme_ap_bk", 2); %>" size="6" maxlength="6"></td>
	<td><input name="wl_wme_ap_bk3" value="<% nvram_list("wl_wme_ap_bk", 3); %>" size="6" maxlength="6"></td>
	<td><input name="wl_wme_ap_bk4" value="<% nvram_list("wl_wme_ap_bk", 4); %>" size="6" maxlength="6"></td>
	<td>
          <select name="wl_wme_ap_bk5">
	    <option value="off" <% nvram_indexmatch("wl_wme_ap_bk", 5, "off", "selected"); %>>Off</option>
	    <option value="on" <% nvram_indexmatch("wl_wme_ap_bk", 5, "on", "selected"); %>>On</option>
	  </select>	</td>
	<td>
          <select name="wl_wme_ap_bk6">
	    <option value="off" <% nvram_indexmatch("wl_wme_ap_bk", 6, "off", "selected"); %>>Off</option>
	    <option value="on" <% nvram_indexmatch("wl_wme_ap_bk", 6, "on", "selected"); %>>On</option>
	  </select>	</td>
  </tr>
  <tr>	
    <td class="CL" valign="top" rowspan="1"
	onMouseOver="return overlib('AP AC_VI parameters', LEFT);"
	onMouseOut="return nd();">
	<input type="hidden" name="wl_wme_ap_vi" value="5">
	AC_VI</td>
	<td><input name="wl_wme_ap_vi0" value="<% nvram_list("wl_wme_ap_vi", 0); %>" size="6" maxlength="6"></td>
	<td><input name="wl_wme_ap_vi1" value="<% nvram_list("wl_wme_ap_vi", 1); %>" size="6" maxlength="6"></td>
	<td><input name="wl_wme_ap_vi2" value="<% nvram_list("wl_wme_ap_vi", 2); %>" size="6" maxlength="6"></td>
	<td><input name="wl_wme_ap_vi3" value="<% nvram_list("wl_wme_ap_vi", 3); %>" size="6" maxlength="6"></td>
	<td><input name="wl_wme_ap_vi4" value="<% nvram_list("wl_wme_ap_vi", 4); %>" size="6" maxlength="6"></td>
	<td>
          <select name="wl_wme_ap_vi5">
	    <option value="off" <% nvram_indexmatch("wl_wme_ap_vi", 5, "off", "selected"); %>>Off</option>
	    <option value="on" <% nvram_indexmatch("wl_wme_ap_vi", 5, "on", "selected"); %>>On</option>
	  </select>	</td>
	<td>
          <select name="wl_wme_ap_vi6">
	    <option value="off" <% nvram_indexmatch("wl_wme_ap_vi", 6, "off", "selected"); %>>Off</option>
	    <option value="on" <% nvram_indexmatch("wl_wme_ap_vi", 6, "on", "selected"); %>>On</option>
	  </select>	</td>
  </tr>
  <tr>	
    <td class="CL" valign="top" rowspan="1"
	onMouseOver="return overlib('AP AC_VO parameters', LEFT);"
	onMouseOut="return nd();">
	<input type="hidden" name="wl_wme_ap_vo" value="5">
	AC_VO</td>
	<td><input name="wl_wme_ap_vo0" value="<% nvram_list("wl_wme_ap_vo", 0); %>" size="6" maxlength="6"></td>
	<td><input name="wl_wme_ap_vo1" value="<% nvram_list("wl_wme_ap_vo", 1); %>" size="6" maxlength="6"></td>
	<td><input name="wl_wme_ap_vo2" value="<% nvram_list("wl_wme_ap_vo", 2); %>" size="6" maxlength="6"></td>
	<td><input name="wl_wme_ap_vo3" value="<% nvram_list("wl_wme_ap_vo", 3); %>" size="6" maxlength="6"></td>
	<td><input name="wl_wme_ap_vo4" value="<% nvram_list("wl_wme_ap_vo", 4); %>" size="6" maxlength="6"></td>
	<td>
          <select name="wl_wme_ap_vo5">
	    <option value="off" <% nvram_indexmatch("wl_wme_ap_vo", 5, "off", "selected"); %>>Off</option>
	    <option value="on" <% nvram_indexmatch("wl_wme_ap_vo", 5, "on", "selected"); %>>On</option>
	  </select>	</td>
	<td>
          <select name="wl_wme_ap_vo6">
	    <option value="off" <% nvram_indexmatch("wl_wme_ap_vo", 6, "off", "selected"); %>>Off</option>
	    <option value="on" <% nvram_indexmatch("wl_wme_ap_vo", 6, "on", "selected"); %>>On</option>
	  </select>	</td>
  </tr>
  <tr>
    <td class="CL" valign="top" rowspan="1"
	onMouseOver="return overlib('WMM EDCA Parameters for STA.  CW value should be one less than a power of two.  TXOP limit should be a multiple of 32.', LEFT);"
	onMouseOut="return nd();">
	<input type="hidden" name="wme_sta" value="8">
	EDCA STA Parameters</td>
  </tr>
  <tr>	
    <td class="CL" valign="top" rowspan="1"
	onMouseOver="return overlib('STA AC_BE parameters', LEFT);"
	onMouseOut="return nd();">
	<input type="hidden" name="wl_wme_sta_be" value="5">
	AC_BE</td>
	<td><input name="wl_wme_sta_be0" value="<% nvram_list("wl_wme_sta_be", 0); %>" size="6" maxlength="6"></td>
	<td><input name="wl_wme_sta_be1" value="<% nvram_list("wl_wme_sta_be", 1); %>" size="6" maxlength="6"></td>
	<td><input name="wl_wme_sta_be2" value="<% nvram_list("wl_wme_sta_be", 2); %>" size="6" maxlength="6"></td>
	<td><input name="wl_wme_sta_be3" value="<% nvram_list("wl_wme_sta_be", 3); %>" size="6" maxlength="6"></td>
	<td><input name="wl_wme_sta_be4" value="<% nvram_list("wl_wme_sta_be", 4); %>" size="6" maxlength="6"></td>
	<td><input name="wl_wme_sta_be5" value="<% nvram_list("wl_wme_sta_be", 5); %>" type="hidden"></td>
	<td><input name="wl_wme_sta_be6" value="<% nvram_list("wl_wme_sta_be", 6); %>" type="hidden"></td>
  </tr>
  <tr>	
    <td class="CL" valign="top" rowspan="1"
	onMouseOver="return overlib('STA AC_BK parameters', LEFT);"
	onMouseOut="return nd();">
	<input type="hidden" name="wl_wme_sta_bk" value="5">
	AC_BK</td>
	<td><input name="wl_wme_sta_bk0" value="<% nvram_list("wl_wme_sta_bk", 0); %>" size="6" maxlength="6"></td>
	<td><input name="wl_wme_sta_bk1" value="<% nvram_list("wl_wme_sta_bk", 1); %>" size="6" maxlength="6"></td>
	<td><input name="wl_wme_sta_bk2" value="<% nvram_list("wl_wme_sta_bk", 2); %>" size="6" maxlength="6"></td>
	<td><input name="wl_wme_sta_bk3" value="<% nvram_list("wl_wme_sta_bk", 3); %>" size="6" maxlength="6"></td>
	<td><input name="wl_wme_sta_bk4" value="<% nvram_list("wl_wme_sta_bk", 4); %>" size="6" maxlength="6"></td>
	<td><input name="wl_wme_sta_bk5" value="<% nvram_list("wl_wme_sta_bk", 5); %>" type="hidden"></td>
	<td><input name="wl_wme_sta_bk6" value="<% nvram_list("wl_wme_sta_bk", 6); %>" type="hidden"></td>
  </tr>
  <tr>	
    <td class="CL" valign="top" rowspan="1"
	onMouseOver="return overlib('STA AC_VI parameters', LEFT);"
	onMouseOut="return nd();">
	<input type="hidden" name="wl_wme_sta_vi" value="5">
	AC_VI</td>
	<td><input name="wl_wme_sta_vi0" value="<% nvram_list("wl_wme_sta_vi", 0); %>" size="6" maxlength="6"></td>
	<td><input name="wl_wme_sta_vi1" value="<% nvram_list("wl_wme_sta_vi", 1); %>" size="6" maxlength="6"></td>
	<td><input name="wl_wme_sta_vi2" value="<% nvram_list("wl_wme_sta_vi", 2); %>" size="6" maxlength="6"></td>
	<td><input name="wl_wme_sta_vi3" value="<% nvram_list("wl_wme_sta_vi", 3); %>" size="6" maxlength="6"></td>
	<td><input name="wl_wme_sta_vi4" value="<% nvram_list("wl_wme_sta_vi", 4); %>" size="6" maxlength="6"></td>
	<td><input name="wl_wme_sta_vi5" value="<% nvram_list("wl_wme_sta_vi", 5); %>" type="hidden"></td>
	<td><input name="wl_wme_sta_vi6" value="<% nvram_list("wl_wme_sta_vi", 6); %>" type="hidden"></td>
  </tr>
  <tr>	
    <td class="CL" valign="top" rowspan="1"
	onMouseOver="return overlib('STA AC_VO parameters', LEFT);"
	onMouseOut="return nd();">
	<input type="hidden" name="wl_wme_sta_vo" value="5">
	AC_VO</td>
	<td><input name="wl_wme_sta_vo0" value="<% nvram_list("wl_wme_sta_vo", 0); %>" size="6" maxlength="6"></td>
	<td><input name="wl_wme_sta_vo1" value="<% nvram_list("wl_wme_sta_vo", 1); %>" size="6" maxlength="6"></td>
	<td><input name="wl_wme_sta_vo2" value="<% nvram_list("wl_wme_sta_vo", 2); %>" size="6" maxlength="6"></td>
	<td><input name="wl_wme_sta_vo3" value="<% nvram_list("wl_wme_sta_vo", 3); %>" size="6" maxlength="6"></td>
	<td><input name="wl_wme_sta_vo4" value="<% nvram_list("wl_wme_sta_vo", 4); %>" size="6" maxlength="6"></td>
	<td><input name="wl_wme_sta_vo5" value="<% nvram_list("wl_wme_sta_vo", 5); %>" type="hidden"></td>
	<td><input name="wl_wme_sta_vo6" value="<% nvram_list("wl_wme_sta_vo", 6); %>" type="hidden"></td>
  </tr>

  <tr>
    <td class="CL" valign="top" rowspan="1"
	onMouseOver="return overlib('WMM Tx retry limits, fallback limits and max rate parameters.', LEFT);"
	onMouseOut="return nd();">
	<input type="hidden" name="wme_txp" value="8">
	WMM TX Parameters</td>
    <td class="label">Short Retry<br>Limit</td>
    <td class="label">Short Fallbk<br>Limit</td>
    <td class="label">Long Retry<br>Limit</td>
    <td class="label">Long Fallbk<br>Limit</td>
    <td class="label">Max Rate<br>In 500 kbps<br>Disabled when 0<br></td>
  </tr>
  <tr>	
    <td class="CL" valign="top" rowspan="1"
	onMouseOver="return overlib('AC_BE Tx parameters', LEFT);"
	onMouseOut="return nd();">
	<input type="hidden" name="wl_wme_txp_be" value="5">
	AC_BE</td>
	<td><input name="wl_wme_txp_be0" value="<% nvram_list("wl_wme_txp_be", 0); %>" size="6" maxlength="6"></td>
	<td><input name="wl_wme_txp_be1" value="<% nvram_list("wl_wme_txp_be", 1); %>" size="6" maxlength="6"></td>
	<td><input name="wl_wme_txp_be2" value="<% nvram_list("wl_wme_txp_be", 2); %>" size="6" maxlength="6"></td>
	<td><input name="wl_wme_txp_be3" value="<% nvram_list("wl_wme_txp_be", 3); %>" size="6" maxlength="6"></td>
	<td><input name="wl_wme_txp_be4" value="<% nvram_list("wl_wme_txp_be", 4); %>" size="6" maxlength="6"></td>
  </tr>
  <tr>	
    <td class="CL" valign="top" rowspan="1"
	onMouseOver="return overlib('AC_BK Tx parameters', LEFT);"
	onMouseOut="return nd();">
	<input type="hidden" name="wl_wme_txp_bk" value="5">
	AC_BK</td>
	<td><input name="wl_wme_txp_bk0" value="<% nvram_list("wl_wme_txp_bk", 0); %>" size="6" maxlength="6"></td>
	<td><input name="wl_wme_txp_bk1" value="<% nvram_list("wl_wme_txp_bk", 1); %>" size="6" maxlength="6"></td>
	<td><input name="wl_wme_txp_bk2" value="<% nvram_list("wl_wme_txp_bk", 2); %>" size="6" maxlength="6"></td>
	<td><input name="wl_wme_txp_bk3" value="<% nvram_list("wl_wme_txp_bk", 3); %>" size="6" maxlength="6"></td>
	<td><input name="wl_wme_txp_bk4" value="<% nvram_list("wl_wme_txp_bk", 4); %>" size="6" maxlength="6"></td>
  </tr>
  <tr>	
    <td class="CL" valign="top" rowspan="1"
	onMouseOver="return overlib('AC_VI Tx parameters', LEFT);"
	onMouseOut="return nd();">
	<input type="hidden" name="wl_wme_txp_vi" value="5">
	AC_VI</td>
	<td><input name="wl_wme_txp_vi0" value="<% nvram_list("wl_wme_txp_vi", 0); %>" size="6" maxlength="6"></td>
	<td><input name="wl_wme_txp_vi1" value="<% nvram_list("wl_wme_txp_vi", 1); %>" size="6" maxlength="6"></td>
	<td><input name="wl_wme_txp_vi2" value="<% nvram_list("wl_wme_txp_vi", 2); %>" size="6" maxlength="6"></td>
	<td><input name="wl_wme_txp_vi3" value="<% nvram_list("wl_wme_txp_vi", 3); %>" size="6" maxlength="6"></td>
	<td><input name="wl_wme_txp_vi4" value="<% nvram_list("wl_wme_txp_vi", 4); %>" size="6" maxlength="6"></td>
  </tr>
  <tr>	
    <td class="CL" valign="top" rowspan="1"
	onMouseOver="return overlib('AC_VO Tx parameters', LEFT);"
	onMouseOut="return nd();">
	<input type="hidden" name="wl_wme_txp_vo" value="5">
	AC_VO</td>
	<td><input name="wl_wme_txp_vo0" value="<% nvram_list("wl_wme_txp_vo", 0); %>" size="6" maxlength="6"></td>
	<td><input name="wl_wme_txp_vo1" value="<% nvram_list("wl_wme_txp_vo", 1); %>" size="6" maxlength="6"></td>
	<td><input name="wl_wme_txp_vo2" value="<% nvram_list("wl_wme_txp_vo", 2); %>" size="6" maxlength="6"></td>
	<td><input name="wl_wme_txp_vo3" value="<% nvram_list("wl_wme_txp_vo", 3); %>" size="6" maxlength="6"></td>
	<td><input name="wl_wme_txp_vo4" value="<% nvram_list("wl_wme_txp_vo", 4); %>" size="6" maxlength="6"></td>
  </tr>
</table>
</div>

<div style="display:none">
<table width="100%" class="tbl_main">
  <tr>
    <td class="CL"
	onMouseOver="return overlib('Selecting <b>Wireless Bridge</b> disables access point functionality. Only wireless bridge (also known as Wireless Distribution System or WDS) functionality will be available. Selecting <b>Access Point</b> enables access point functionality. Wireless bridge functionality will still be available and wireless stations will be able to associate to the AP.', LEFT);"
	onMouseOut="return nd();">
	Mode</td>
    <td>
	<select name="wl_mode" onChange="wl_mode_onchange();">
	<% wl_mode_list();%>
	</select>    </td>
  </tr>
  <tr>
    <td class="CL"
	onMouseOver="return overlib('Sets Network.', LEFT);"
	onMouseOut="return nd();">
	Network</td>
    <td>
	<select name="wl_infra">
	  <option value="1" <% nvram_match("wl_infra", "1", "selected"); %>>BSS</option>
	  <option value="0" <% nvram_match("wl_infra", "0", "selected"); %>>IBSS</option>
	</select>    </td>
  </tr>
  <tr>
    <td class="CL"
	  onMouseOver="return overlib('Enable AP & Station functions for a single radio.  If the Router Mode (on the Basic page) is Router, then this makes the product into a Travel Router. If the Router Mode is AP, then this setting turns the product into a Range Extender.', LEFT);"
	onMouseOut="return nd();">
	URE Mode</td>
    <td>
	   <select name="wl_ure" onChange="wl_ure_onchange();">
	    <option value="0" <% wl_ure_list(0); %> >OFF</option>

	    <option value="1" <% wl_ure_list(1); %> >ON</option>
	   </select>    </td>
  </tr>
</table>
</div>

<div style="display:none">
<table width="100%" class="tbl_main">
  <tr>
    <td class="CL"
	onMouseOver="return overlib('Controls the STA behavior for the first assocaiation.  This parameter sets the time to wait between attempts to associate with the Access Point for the initial association.  Setting this to 0 seconds will cause the STA to only attempt association once.  Once the initial association is successful, the STA will always attempt re-associations.', LEFT);"
	onMouseOut="return nd();">
	STA Retry Time(sec)</td>
    <td>
	    <input name="wl_sta_retry_time" value="<% nvram_get("wl_sta_retry_time"); %>" size="4" maxlength="4" onkeydown="return prevent_press_enter(event);">    </td>
  </tr>
</table>
</div>

<div style="display:none">
<table width="100%" class="tbl_main">
	<tr>
		<td class="CL"
		onMouseOver="return overlib('Selects desired Bridge br0 or br1 .', LEFT);"
		onMouseOut="return nd();">
		Network Bridge:
		</td>
		<td class="CR">
			<!-- Tom.Hung 2013-3-21, fix the bridge to LAN -->
			<select name="wl_bridge" id="wl_bridge"><option value=0 selected>LAN</option></select>
		</td>
	</tr>  
</table>
</div>

<table width="100%" class="tbl_main">
	<tr align="center">
		<td>
			<input type="submit" class="<!--#tr id="buttonWidth"-->button1<!--#endtr-->" name="action" value="<!--#tr id="apply"-->Apply<!--#endtr-->">
			<input type="reset" class="button1" name="action" value="<!--#tr id="cancel"-->Cancel<!--#endtr-->">	</td>
		</tr>
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
