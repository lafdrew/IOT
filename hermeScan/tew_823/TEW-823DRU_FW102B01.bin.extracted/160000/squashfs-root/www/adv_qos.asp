<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html lang="en-US" xmlns="http://www.w3.org/1999/xhtml" xml:lang="en-US">
<head>
<title>TRENDNET | modelName | Tools | Schedule</title>
<meta http-equiv=Content-Type content="text/html; charset=UTF-8">
<link href="/css/style.css" rel="stylesheet" type="text/css" />
<link href="/css/css_router.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="/lang_<!--# echo language -->.js"></script>
<script type="text/javascript" src="/uk_<!--# echo language -->.js"></script>
<script type="text/javascript" src="public_tew.js"></script>
<script type="text/javascript" src="public_msg.js"></script>
<script type="text/javascript" src="public_ipv6.js"></script>
<script type="text/javascript" src="pandoraBox.js"></script>
<script type="text/javascript" src="menu_all.js"></script>
<script type="text/javascript" src="js/jquery-1.3.2.min.js"></script>
<script type="text/javascript" src="js/xml.js"></script>
<script type="text/javascript" src="js/object.js"></script>
<script type="text/javascript" src="js/ddaccordion.js"></script>
<script type="text/javascript" src="js/ccpObject.js"></script>

<script type="text/javascript" src="js/um.js"></script>
<script type="text/javascript" src="js/func.js"></script>
<script type="text/javascript" src="js/overlib.js"></script>
<script type="text/javascript">
	var def_title = document.title;
	var model = "<!--# echo model_number -->";
	document.title = def_title.replace("modelName", model);

	var menu = new menuObject();
    var array_enable = [], array_name = [], array_prio = [], array_proto = [],  array_src_ip = [];
	var array_dest_ip = [], array_src_mac = [], array_src_port = [], array_dst_port = [];
	var main = new ccpObject();
	var submit_button_flag = 0;
	var rule_max_num = 10;
	var DataArray = new Array();
	var TotalCnt=0;
     
function page_load() {
	setMax();
	qos_recalc(0);
	set_selectIndex("<!--# echo qos_enable -->", get_by_id("tmp_qos_enable"));
	set_selectIndex("<!--# echo qos_prio_ack -->", get_by_id("qos_ack"));
	set_selectIndex("<!--# echo qos_prio_icmp -->", get_by_id("qos_icmp"));
	set_selectIndex("<!--# echo qos_default_class -->", get_by_id("qos_default"));
	
	setItems("<!--# echo qos_enable -->");
	}

function setMax()
{
	//var orates = "80-100,10-100,5-100,3-100,2-95,0-0,0-0,0-0,0-0,0-0";
	//var irates = "0,0,0,0,0,0,0,0,0,0";   
	var up_0 = get_by_id("qos_up_class_0_bwd").value;
	var up_1 = get_by_id("qos_up_class_1_bwd").value;
	var up_2 = get_by_id("qos_up_class_2_bwd").value;
	var up_3 = get_by_id("qos_up_class_3_bwd").value;
	var up_4 = get_by_id("qos_up_class_4_bwd").value;
	
	var in_0 = get_by_id("qos_in_class_0_bwd").value;
	var in_1 = get_by_id("qos_in_class_1_bwd").value;
	var in_2 = get_by_id("qos_in_class_2_bwd").value;
	var in_3 = get_by_id("qos_in_class_3_bwd").value;
	var in_4 = get_by_id("qos_in_class_4_bwd").value;
	var orates = up_0+","+up_1+","+up_2+","+up_3+","+up_4+",0/0,0/0,0/0,0/0,0/0";
	var irates = in_0+","+in_1+","+in_2+","+in_3+","+in_4+",0,0,0,0,0";
	   	
	if(!orates)
	{
		orates = "80-100,10-100,5-100,3-100,2-95,0-0,0-0,0-00,0-0,0-0";
	}

     	
	if(!irates)
	{
		irates = "0,0,0,0,5,0,0,0,0,0";      
	}


    
	var rates = orates.split(',');

	ratehi = rates[0].split('/');
	get_by_id("obw_hi_lower").value = ratehi[0];
	get_by_id("obw_hi_higher").value = ratehi[1];
	
	rateh = rates[1].split('/');
	get_by_id("obw_h_lower").value = rateh[0];
	get_by_id("obw_h_higher").value = rateh[1];
	
	ratemed = rates[2].split('/');
	get_by_id("obw_med_lower").value = ratemed[0];
	get_by_id("obw_med_higher").value = ratemed[1];
	
	ratel = rates[3].split('/');
	get_by_id("obw_l_lower").value = ratel[0];
	get_by_id("obw_l_higher").value = ratel[1];
	
	ratelo = rates[4].split('/');
	get_by_id("obw_lo_lower").value = ratelo[0];
	get_by_id("obw_lo_higher").value = ratelo[1];
	
	var ratein = irates.split(',');
	 
	get_by_id("ibw_hi").value = ratein[0];
	get_by_id("ibw_h").value = ratein[1];
	get_by_id("ibw_med").value = ratein[2];
	get_by_id("ibw_l").value = ratein[3];
	get_by_id("ibw_lo").value = ratein[4];
	
	
}

function qos_recalc(input)
{
	var qos_enable = "<!--# echo qos_enable -->";
	var qos_obw = "<!--# echo qos_up_bwd -->";
	var qos_ibw = "<!--# echo qos_in_bwd -->";   

	if(input == 1)
	{
		qos_enable = get_by_id("tmp_qos_enable").value;
		setItems(qos_enable);
	}
	
	else if(input == 2)
	{
		//qos_obw1 =get_by_id("qos_obw").value;
		qos_obw1 =get_by_id("qos_up_bwd").value;		
		setBW(qos_obw1);
	}
	
	else if(input == 3)
	{
		//qos_ibw1 = get_by_id("qos_ibw").value;
		qos_ibw1 = get_by_id("qos_in_bwd").value;
		
		setiBW(qos_ibw1);
	}
	
	else
	{
		setItems(qos_enable);
		//setBW(qos_obw);
		setBW(qos_obw);
		//setiBW(qos_ibw);   
		setiBW(qos_ibw);   
	}
}

function setBW(qos_obw)
{
	a = get_by_id("obw_hi_lower").value/100;
	b = a*qos_obw;
	get_by_id("hi_lo").value = Math.floor(b);
		
	a = get_by_id("obw_hi_higher").value/100;
	b = a*qos_obw;
	get_by_id("hi_hi").value = Math.floor(b);

	a = get_by_id("obw_h_lower").value/100;
	b = a*qos_obw;
	get_by_id("h_lo").value = Math.floor(b);

	a = get_by_id("obw_h_higher").value/100;
	b = a*qos_obw;
	get_by_id("h_hi").value = Math.floor(b);

	a = get_by_id("obw_med_lower").value/100;
	b = a*qos_obw;
	get_by_id("med_lo").value = Math.floor(b);

	a = get_by_id("obw_med_higher").value/100;
	b = a*qos_obw;
	get_by_id("med_hi").value = Math.floor(b);

	a = get_by_id("obw_l_lower").value/100;
	b = a*qos_obw;
	get_by_id("l_lo").value = Math.floor(b);

	a = get_by_id("obw_l_higher").value/100;
	b = a*qos_obw;
	get_by_id("l_hi").value = Math.floor(b);
 	
	a = get_by_id("obw_lo_lower").value/100;
	b = a*qos_obw;
	get_by_id("lo_lo").value = Math.floor(b);

	a = get_by_id("obw_lo_higher").value/100;
	b = a*qos_obw;
	get_by_id("lo_hi").value = Math.floor(b);
}


function setiBW(qos_ibw)
{
	x = get_by_id("ibw_hi").value/100;
	y = x*qos_ibw;
	get_by_id("in_hi").value = Math.floor(y);
		
	x = get_by_id("ibw_h").value/100;
	y = x*qos_ibw;
	get_by_id("in_h").value = Math.floor(y);

	x = get_by_id("ibw_med").value/100;
	y = x*qos_ibw;
	get_by_id("in_med").value = Math.floor(y);

	x = get_by_id("ibw_l").value/100;
	y = x*qos_ibw;
	get_by_id("in_l").value = Math.floor(y);

	x = get_by_id("ibw_lo").value/100;
	y = x*qos_ibw;
	get_by_id("in_lo").value = Math.floor(y);

}


function setItems(b)
{	
	if(b == 0)
	{
   		get_by_id("qos_ack").disabled = 1;
		get_by_id("qos_icmp").disabled = 1;
			
		get_by_id("obw_hi_lower").disabled = 1;
		get_by_id("obw_hi_higher").disabled = 1;
		get_by_id("obw_h_lower").disabled = 1;
		get_by_id("obw_h_higher").disabled = 1;
		get_by_id("obw_med_lower").disabled = 1;
		get_by_id("obw_med_higher").disabled = 1;
		get_by_id("obw_l_lower").disabled = 1;
		get_by_id("obw_l_higher").disabled = 1;
		get_by_id("obw_lo_lower").disabled = 1;
		get_by_id("obw_lo_higher").disabled = 1;
		//get_by_id("qos_obw").disabled = 1;
		get_by_id("qos_up_bwd").disabled = 1;
		
		get_by_id("ibw_hi").disabled = 1;
		get_by_id("ibw_h").disabled = 1;
		get_by_id("ibw_med").disabled = 1;
		get_by_id("ibw_l").disabled = 1;
		get_by_id("ibw_lo").disabled = 1;
	//	get_by_id("qos_ibw").disabled = 1;
		get_by_id("qos_in_bwd").disabled = 1;
		get_by_id("qos_default").disabled = 1;		
	
	}
	else
	{
		get_by_id("qos_ack").disabled = 0;
		get_by_id("qos_icmp").disabled = 0;
	
		get_by_id("obw_hi_lower").disabled = 0;
		get_by_id("obw_hi_higher").disabled = 0;
		get_by_id("obw_h_lower").disabled = 0;
		get_by_id("obw_h_higher").disabled = 0;
		get_by_id("obw_med_lower").disabled = 0;
		get_by_id("obw_med_higher").disabled = 0;
		get_by_id("obw_l_lower").disabled = 0;
		get_by_id("obw_l_higher").disabled = 0;
		get_by_id("obw_lo_lower").disabled = 0;
		get_by_id("obw_lo_higher").disabled = 0;
	//	get_by_id("qos_obw").disabled = 0;
		get_by_id("qos_up_bwd").disabled = 0;
		
		get_by_id("ibw_hi").disabled = 0;
		get_by_id("ibw_h").disabled = 0;
		get_by_id("ibw_med").disabled = 0;
		get_by_id("ibw_l").disabled = 0;
		get_by_id("ibw_lo").disabled = 0;
		//get_by_id("qos_ibw").disabled = 0;
		get_by_id("qos_in_bwd").disabled = 0;
			
			
		get_by_id("qos_default").disabled = 0;
		
	
	}
}

/**
* Before sending data to devices, check field values of inbound class settings and 
* field value of outbound class settings.
*/
function validateData()
{	
    // 1. Check values of Inbound Class Settings
    if (!validateNumberRange(get_by_id("qos_in_bwd")))
    {
        alert("Bw Max Inbound value of Inbound Class Setting is error !!!");
        return false;
    }
    if(!validateNumber(get_by_id("ibw_hi")))
	{
        alert("Highest value of Inbound Class Setting is error !!!");
        return false;
    }
	if(!validateNumber(get_by_id("ibw_h")))
    {
        alert("High value of Inbound Class Setting is error !!!");
        return false;
    }
	if(!validateNumber(get_by_id("ibw_med")))
    {
        alert("Medium value of Inbound Class Setting is error !!!");
        return false;
    }
	if(!validateNumber(get_by_id("ibw_l")))
    {
        alert("Low value of Inbound Class Setting is error !!!");
        return false;
    }
	if(!validateNumber(get_by_id("ibw_lo")))
    {
        alert("Lowest value of Inbound Class Setting is error !!!");
        return false;
    }
	
	// 2. Check values of Outbound Class Settings
    if (!validateNumberRange(get_by_id("qos_up_bwd")))
    {
        alert("Bw Max Inbound value of Outbound Class Setting is error !!!");
        return false;
    }
	if(!validateNumber(get_by_id("obw_hi_lower")))
    {
        alert("Highest lowbound value of Outbound Class Setting is error !!!");
        return false;
    }
	if(!validateNumber(get_by_id("obw_hi_higher")))
    {
        alert("Highest upbound value of Outbound Class Setting is error !!!");
        return false;
    }
	if(!validateNumber(get_by_id("obw_h_lower")))
    {
        alert("High lowbound value of Outbound Class Setting is error !!!");
        return false;
    }
	if(!validateNumber(get_by_id("obw_h_higher")))
    {
        alert("High upbound value of Outbound Class Setting is error !!!");
        return false;
    }
	if(!validateNumber(get_by_id("obw_med_lower")))
    {
        alert("Medium lowbound value of Outbound Class Setting is error !!!");
        return false;
    }
	if(!validateNumber(get_by_id("obw_med_higher")))
    {
        alert("Medium upbound value of Outbound Class Setting is error !!!");
        return false;
    }
	if(!validateNumber(get_by_id("obw_l_lower")))
    {
        alert("Low lowbound value of Outbound Class Setting is error !!!");
        return false;
    }
	if(!validateNumber(get_by_id("obw_l_higher")))
    {
        alert("Low upbound value of Outbound Class Setting is error !!!");
        return false;
    }
	if(!validateNumber(get_by_id("obw_lo_lower")))
    {
        alert("Lowest lowbound value of Outbound Class Setting is error !!!");
        return false;
    }
	if(!validateNumber(get_by_id("obw_lo_higher")))
    {
        alert("Lowest upbound value of Outbound Class Setting is error !!!");
        return false;
    }
    
    // 3. Check ranges of Outbound Class Settings
	if(!validateRange(get_by_id("obw_hi_lower"),get_by_id("obw_hi_higher")))
    {
        alert("Hightest range of Outbound Class Setting is error !!!");
        return false;
    }
	if(!validateRange(get_by_id("obw_h_lower"),get_by_id("obw_h_higher")))
    {
        alert("High range of Outbound Class Setting is error !!!");
        return false;
    }
	if(!validateRange(get_by_id("obw_med_lower"),get_by_id("obw_med_higher")))
    {
        alert("Medium range of Outbound Class Setting is error !!!");
        return false;
    }
	if(!validateRange(get_by_id("obw_l_lower"),get_by_id("obw_l_higher")))
    {
        alert("Low range of Outbound Class Setting is error !!!");
        return false;
    }
	if(!validateRange(get_by_id("obw_lo_lower"),get_by_id("obw_lo_higher")))
    {   
        alert("Lowest range of Outbound Class Setting is error !!!");
        return false;
    }
	
	//Griffin -To add inbound limit
	if(!validateSumNoMin(get_by_id("ibw_hi"), get_by_id("ibw_h"), get_by_id("ibw_med"), get_by_id("ibw_l"), get_by_id("ibw_lo")))
    {
        return false;
    }	
    
	if(!validateSum(get_by_id("obw_hi_lower"), get_by_id("obw_h_lower"), get_by_id("obw_med_lower"), get_by_id("obw_l_lower"), get_by_id("obw_lo_lower")))
    {
        return false;
    }	
	/*
	var vhigh = get_by_id("obw_hi_lower").value + "-" + get_by_id("obw_hi_higher").value;
	var vh = get_by_id("obw_h_lower").value + "-" + get_by_id("obw_h_higher").value;
	var vmed = get_by_id("obw_med_lower").value + "-" + get_by_id("obw_med_higher").value;
	var vl = get_by_id("obw_l_lower").value + "-" + get_by_id("obw_l_higher").value;
	var vlow = get_by_id("obw_lo_lower").value + "-" + get_by_id("obw_lo_higher").value;
	//get_by_id("qos_orates").value = vhigh + "," + vh + "," + vmed + "," + vl + "," + vlow + ",0-0,0-0,0-0,0-0,0-0";
	
	var vhigh = get_by_id("ibw_hi").value;
	var vh = get_by_id("ibw_h").value;
	var vmed = get_by_id("ibw_med").value;
	var vl = get_by_id("ibw_l").value;
	var vlow = get_by_id("ibw_lo").value;
	//get_by_id("qos_irates").value = vhigh + "," + vh + "," + vmed + "," + vl + "," + vlow + ",0,0,0,0,0";

	totalWaitTime = 25; //second
	wait_page();
	//document.getElementById("waitPad").style.display="block";
	//scroll(0,0);
	*/
	return true;
	
}

function validateSum(v1, v2, v3, v4, v5)
{
	var sum;
	sum = parseInt(v1.value) + parseInt(v2.value) + parseInt(v3.value) + parseInt(v4.value)+ parseInt(v5.value);
	
	if(sum > 100)
	{
		alert("The sum of all %BWMin can not be over 100!");
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
		alert("The sum of all %BW can not be over 100!");
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
		alert("Please enter a number!");
		val.focus(); 
		val.select();
		return false;
	}
	
	for(i = 0; i < val.value.length; i++)
	{
		if(val.value.charAt(i) < '0' || val.value.charAt(i) > '9')
		{	
			alert("It is an invalid number!");
			val.focus(); 
			val.select();
			return false;
		}
	}
	
	if(val.value < 0 || val.value > 100)
	{
		alert("Invalid number, the number must be great than 0 and less than 100!");
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
		alert("Please enter a number!");
		val.focus(); 
		val.select();
		return false;
	}
	
	for(i = 0; i < val.value.length; i++)
	{
		if(val.value.charAt(i) < '0' || val.value.charAt(i) > '9')
		{	
			alert("It is an invalid number!");
			val.focus(); 
			val.select();
			return false;
		}
	}
	
	if(val.value < lowBound || val.value > upBound)
	{
		alert("Invalid number, it is out of range :" + lowBound + " ~ " + upBound);
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
		alert("Invalid number, the %BWMin must not be great than %BWMax!");
		val1.focus(); 
		val1.select();
		return false;
	}
	return true;
}

function apply_action(){
	var obj = new ccpObject();
	
	obj.set_param_url('apply.cgi');
	obj.set_ccp_act('set');
	obj.add_param_event('adv_qos');
	obj.set_param_next_page('adv_qos.asp');
	obj.add_param_arg('reboot_type', 'qos');
	
    if (validateData() == false){
    	return false;
    }
	obj.add_param_arg('qos_enable',get_by_id("tmp_qos_enable").value);
	obj.add_param_arg('qos_in_bwd',get_by_id("qos_in_bwd").value);	
	obj.add_param_arg('qos_prio_ack',get_by_id("qos_ack").value);
	obj.add_param_arg('qos_prio_icmp',get_by_id("qos_icmp").value);
	obj.add_param_arg('qos_default_class',get_by_id("qos_default").value);
	obj.add_param_arg('qos_in_class_0_bwd',get_by_id("ibw_hi").value);
	obj.add_param_arg('qos_in_class_1_bwd',get_by_id("ibw_h").value);
	obj.add_param_arg('qos_in_class_2_bwd',get_by_id("ibw_med").value);
	obj.add_param_arg('qos_in_class_3_bwd',get_by_id("ibw_l").value);
	obj.add_param_arg('qos_in_class_4_bwd',get_by_id("ibw_lo").value);
	obj.add_param_arg('qos_up_bwd',get_by_id("qos_up_bwd").value);
	obj.add_param_arg('qos_up_class_0_bwd',(get_by_id("obw_hi_lower").value +"/"+ get_by_id("obw_hi_higher").value));
	obj.add_param_arg('qos_up_class_1_bwd',(get_by_id("obw_h_lower").value +"/"+ get_by_id("obw_h_higher").value));
	obj.add_param_arg('qos_up_class_2_bwd',(get_by_id("obw_med_lower").value +"/"+ get_by_id("obw_med_higher").value));
	obj.add_param_arg('qos_up_class_3_bwd',(get_by_id("obw_l_lower").value +"/"+ get_by_id("obw_l_higher").value));
	obj.add_param_arg('qos_up_class_4_bwd',(get_by_id("obw_lo_lower").value +"/"+ get_by_id("obw_lo_higher").value));

	
	//save qos rule
	for(var i=0; i<DataArray.length; i++)
		{
			var key, value;
			if (i<10)
				key = "qos_filter_rule_0" + i;
			else
				key = "qos_filter_rule_" + i;

			value = DataArray[i].Name + "/" + DataArray[i].Enable + "/" + DataArray[i].Prio + "/" +
					DataArray[i].Proto + "/" + DataArray[i].Src_ip + "/" + DataArray[i].Dest_ip + "/" +
					DataArray[i].Src_mac + "/" + DataArray[i].Src_port + "/" + DataArray[i].Dst_port;
			obj.add_param_arg(key,value);
					
		}
	var param = obj.get_param();
	
	totalWaitTime = 25; //second
	redirectURL = location.pathname;
	wait_page();
	jq_ajax_post(param.url, param.arg);	
  } 
  
  
// add qos rule
	function onPageLoad()
	{
		var rule_value;
		// get qos_filter_rule_XX value  (name/enable/prio/proto/src ip/dest ip/src mac/src port/dst port)
		for (j=0; j<rule_max_num; j++) {
			if (j > 9){
				rule_value = (get_by_id("qos_filter_rule_" + j).value);
			}else{
				rule_value = (get_by_id("qos_filter_rule_0" + j).value);				
			}				  
			
			if (rule_value == ""){
				break;
			}
			
			temp = rule_value.split("/");
		    
			array_name[j] = temp[0];
			array_enable[j] = temp[1];
			array_prio[j] = temp[2]; 
			array_proto[j] = temp[3]; 			
			array_src_ip[j] = temp[4];
			array_dest_ip[j] = temp[5];
			array_src_mac[j] = temp[6];
			array_src_port[j] = temp[7];
			array_dst_port[j] = temp[8];
		}

		set_qos();
		paintTable();
		
		}

	//(name/enable/prio/proto/src ip/dest ip/src mac/src port/dst port)
	function Data( name,enable,prio, proto, src_ip, dest_ip,src_mac,src_port,dst_port,onList)
	{
		
		this.Name = name;
		this.Enable = enable;
		this.Prio = prio;
		this.Proto = proto; 
		this.Src_ip = src_ip;
		this.Dest_ip = dest_ip;
		this.Src_mac = src_mac;
		this.Src_port = src_port;
		this.Dst_port = dst_port;
		this.OnList = onList ;
	
	}

	function set_qos()
	{
		var index = 0;
		for (var i = 0; i < rule_max_num; i++) {
			if(array_name[i] != "" && array_name[i])
			{
				TotalCnt++;
				DataArray[DataArray.length++] = new Data(array_name[i], array_enable[i],  array_prio[i], array_proto[i], array_src_ip[i],
				                                         array_dest_ip[i],array_src_mac[i],array_src_port[i],array_dst_port[i], i);
			
			}
		}

		$('#max_row').val(index-1);
	}

	function del_row(idx)
	{
		if(!confirm(get_words('YM25') + ": " + DataArray[idx].Name + "?"))
			return;

		for(var i=idx; i<(DataArray.length-1); i++)
		{
			DataArray[i].Enable = DataArray[i+1].Enable;
			DataArray[i].Name = DataArray[i+1].Name;
			DataArray[i].Prio = DataArray[i+1].Prio;
			DataArray[i].Proto = DataArray[i+1].Proto;
			DataArray[i].Src_ip = DataArray[i+1].Src_ip;
			DataArray[i].Dest_ip = DataArray[i+1].Dest_ip;
			DataArray[i].Src_mac = DataArray[i+1].Src_mac;
			DataArray[i].Src_port = DataArray[i+1].Src_port;
			DataArray[i].Dst_port = DataArray[i+1].Dst_port;
			DataArray[i].OnList = DataArray[i+1].OnList;	
			
		}

		if(DataArray.length > 0)
			DataArray.length -- ;

		paintTable();
		clear_reserved();

		AddPFtoDatamodel();
	}

	function update_DataArray()
	{
		var index = parseInt($('#edit').val());
		var insert = false;
		var is_chk = get_checked_value($('#enable')[0]);

		if(index == "-1"){      //save
			if(DataArray.length == rule_max_num){
				alert(get_words('TEXT015'));
			}else{
				index = DataArray.length;
				$('#max_row').val(index);
				insert = true;
			}
		}

		if(insert){  //(name/enable/prio/proto/src ip/dest ip/src mac/src port/dst port)
			DataArray[index] = new Data($('#qos_desc').val(),is_chk,  $('#qos_class').val(), $('#qos_proto').val(), $('#source_ip').val(), 
			                   $('#dest_ip').val(), $('#source_mac').val(), $('#source_port').val(),$('#dest_port').val(),index+1);				
	
		}else if (index != -1){			
			DataArray[index].Enable = is_chk;
			DataArray[index].Name = $('#qos_desc').val();
			DataArray[index].Prio = $('#qos_class').val();
			DataArray[index].Proto = $('#qos_proto').val();
			DataArray[index].Src_ip = $('#source_ip').val();
			DataArray[index].Dest_ip = $('#dest_ip').val();
			DataArray[index].Src_mac = $('#source_mac').val();
			DataArray[index].Src_port = $('#source_port').val();
			DataArray[index].Dst_port = $('#dest_port').val();
			DataArray[index].OnList = index;
		}
	}

	function clear_reserved()
	{
		$("input[name=sel_del]").each(function () { this.checked = false; });
		set_checked(0, $('#enable')[0]);
		$('#qos_desc').val("");
		$('#qos_class').val("");
		$('#qos_port').val("");
		$('#source_ip').val("");
		$('#dest_ip').val("");
		$('#source_mac').val("");
		$('#source_port').val("");
		$('#dest_port').val("");
		$('#edit').val(-1);
		$('#add').attr('disabled', '');
        $('#clear').attr('disabled', true);
	}

	function edit_row(idx)
    {
        set_checked(DataArray[idx].Enable, $('#enable')[0]);
        $('#qos_desc').val(DataArray[idx].Name);
       // $('#qos_class').val(DataArray[idx].Prio);
       // $('#qos_proto').val(DataArray[idx].Proto);
       set_selectIndex(DataArray[idx].Proto, get_by_id("qos_proto"));
       set_selectIndex(DataArray[idx].Prio, get_by_id("qos_class"));
      //  $('#source_ip').val(DataArray[idx].Src_ip);
        get_by_id("source_ip").value = DataArray[idx].Src_ip;
        $('#dest_ip').val(DataArray[idx].Dest_ip);
        $('#source_mac').val(DataArray[idx].Src_mac);
        $('#source_port').val(DataArray[idx].Src_port);
        $('#dest_port').val(DataArray[idx].Dst_port);
		$('#edit').val(idx);
		$('#add').val(get_words('_save'));
		$('#clear').attr('disabled', '');
		//setEnable("inb_enable_1");
		//setEnable("sch_enable_2");
		
		var Src_ip_val= DataArray[idx].Src_ip;
		var Dest_ip_val= DataArray[idx].Dest_ip;
		var Src_mac_val= DataArray[idx].Src_mac; 
		var Src_port_val= DataArray[idx].Src_port;
		var Dst_port_val= DataArray[idx].Dst_port;
		var qos_proto_val= DataArray[idx].Proto;
		 
		if(Src_ip_val != ''){set_selectIndex("2", get_by_id("qos_ip"));}
		if(Dest_ip_val !=''){set_selectIndex("1", get_by_id("qos_ip"));}
		if(Src_mac_val !=''){set_selectIndex("3", get_by_id("qos_ip"));}
		if(Src_port_val !=''&& Dst_port_val!=''&& (Src_port_val==Dst_port_val)){
			set_selectIndex("3", get_by_id("qos_port"));
		}else if(Src_port_val !=''){
			set_selectIndex("2", get_by_id("qos_port"));
		}else if(Dst_port_val !=''){
			set_selectIndex("1", get_by_id("qos_port"));
		}
	
		change_mode();
    }
    
    function change_mode(){
		var address_filter = get_by_id("qos_ip").value;
		var port_filter = get_by_id("qos_port").value;
		if (address_filter == "0"){ //0:Any 1:Destination IP  2:Source IP 3:Source MAC
			get_by_id("source_ip").style.display = "";
			get_by_id("source_ip").value = "";
			get_by_id("dest_ip").style.display = "none";
			get_by_id("source_mac").style.display = "none";
			get_by_id("source_ip").disabled = true;
			get_by_id("dest_ip").disabled = true;
			get_by_id("source_mac").disabled = true;
		}else if (address_filter == "1"){
			get_by_id("source_ip").style.display = "none";
			get_by_id("dest_ip").style.display = "";
			get_by_id("source_mac").style.display = "none";
			get_by_id("source_ip").disabled = true;
			get_by_id("dest_ip").disabled = false;
			get_by_id("source_mac").disabled = true;
		}else if (address_filter == "2"){
			get_by_id("source_ip").style.display = "";
			get_by_id("dest_ip").style.display = "none";
			get_by_id("source_mac").style.display = "none";
			get_by_id("source_ip").disabled = false;
			get_by_id("dest_ip").disabled = true;
			get_by_id("source_mac").disabled = true;
		}else if (address_filter == "3"){
			get_by_id("source_ip").style.display = "none";
			get_by_id("dest_ip").style.display = "none";
			get_by_id("source_mac").style.display = "";
			get_by_id("source_ip").disabled = true;
			get_by_id("dest_ip").disabled = true;
			get_by_id("source_mac").disabled = false;
		}
	
	if (port_filter == "0"){ //0:Any 1:Destination Port  2:Source Port 3:Source or Destination
			get_by_id("source_port").style.display = "";
			get_by_id("dest_port").style.display = "none";
			get_by_id("source_port").disabled = true;
			get_by_id("dest_port").disabled = true;
		}else if (port_filter == "1"){
		    get_by_id("source_port").style.display = "none";
			get_by_id("dest_port").style.display = "";
			get_by_id("source_port").disabled = true;
			get_by_id("dest_port").disabled = false;
		}else if (port_filter == "2"){
			get_by_id("source_port").style.display = "";
			get_by_id("dest_port").style.display = "none";
			get_by_id("source_port").disabled = false;
			get_by_id("dest_port").disabled = true;
		}else if (port_filter == "3"){
			get_by_id("source_port").style.display = "";
			get_by_id("dest_port").style.display = "none";
			get_by_id("source_port").disabled = false;
			get_by_id("dest_port").disabled = false;
		}
	
	}

	function AddPFtoDatamodel()
	{
		var obj = new ccpObject();
		obj.set_param_url('apply.cgi');
		obj.set_ccp_act('set');
		obj.add_param_event('adv_qos');
		obj.set_param_next_page('adv_qos.asp');
		obj.add_param_arg('reboot_type', 'qos');
		
		for(var i=0; i<DataArray.length; i++)
		{
			var key, value;
			if (i<10)
				key = "qos_filter_rule_0" + i;
			else
				key = "qos_filter_rule_" + i;

			value = DataArray[i].Name + "/" + DataArray[i].Enable + "/" + DataArray[i].Prio + "/" +
					DataArray[i].Proto + "/" + DataArray[i].Src_ip + "/" + DataArray[i].Dest_ip + "/" +
					DataArray[i].Src_mac + "/" + DataArray[i].Src_port + "/" + DataArray[i].Dst_port;
			obj.add_param_arg(key,value);
					
		}
		
		
		//save qos setting
		obj.add_param_arg('qos_enable',get_by_id("tmp_qos_enable").value);
	obj.add_param_arg('qos_in_bwd',get_by_id("qos_in_bwd").value);	
	obj.add_param_arg('qos_prio_ack',get_by_id("qos_ack").value);
	obj.add_param_arg('qos_prio_icmp',get_by_id("qos_icmp").value);
	obj.add_param_arg('qos_default_class',get_by_id("qos_default").value);
	obj.add_param_arg('qos_in_class_0_bwd',get_by_id("ibw_hi").value);
	obj.add_param_arg('qos_in_class_1_bwd',get_by_id("ibw_h").value);
	obj.add_param_arg('qos_in_class_2_bwd',get_by_id("ibw_med").value);
	obj.add_param_arg('qos_in_class_3_bwd',get_by_id("ibw_l").value);
	obj.add_param_arg('qos_in_class_4_bwd',get_by_id("ibw_lo").value);
	obj.add_param_arg('qos_up_bwd',get_by_id("qos_up_bwd").value);
	obj.add_param_arg('qos_up_class_0_bwd',(get_by_id("obw_hi_lower").value +"/"+ get_by_id("obw_hi_higher").value));
	obj.add_param_arg('qos_up_class_1_bwd',(get_by_id("obw_h_lower").value +"/"+ get_by_id("obw_h_higher").value));
	obj.add_param_arg('qos_up_class_2_bwd',(get_by_id("obw_med_lower").value +"/"+ get_by_id("obw_med_higher").value));
	obj.add_param_arg('qos_up_class_3_bwd',(get_by_id("obw_l_lower").value +"/"+ get_by_id("obw_l_higher").value));
	obj.add_param_arg('qos_up_class_4_bwd',(get_by_id("obw_lo_lower").value +"/"+ get_by_id("obw_lo_higher").value));
	
		var paramStr = obj.get_param();		
		totalWaitTime = 10; //second
		redirectURL = location.pathname;
		wait_page();
		jq_ajax_post(paramStr.url, paramStr.arg);
	}
	
	function validatePorts(val)
{
	var i;
	sval = String(val);
	var strAlert = "Invalid Ports! Please enter valid Ports, the correct format is" +  "\"Port[,Port]...\".";
	 
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
			alert(strAlert);
			return false;
		}
	}

	var sub = val.split(',');
	for(i = 0; i < sub.length; i++ )
	{
		if((sub[i]-0) < 0 || (sub[i]-0) > 65535)
		{
			alert(strAlert);
			return false;
		}
	}
	return true;
}

	function send_request()
	{
	/*	if (!is_form_modified("form3") && !confirm(get_words('_ask_nochange'))) {
			return false;
		}
		*/
		var count = 0;
		
		var tmp_name = get_by_id("qos_desc").value;
		var address_filter = get_by_id("qos_ip").value;
		var port_filter = get_by_id("qos_port").value;
		var re = /^[\w\-]+$/;
		//check description /name
		if (!re.test(tmp_name)) {
			alert("Description only accept [0-9a-zA-Z_-] characters.");
			return false;
		}
		//check ip/mac filter type
		if(address_filter == "0"){
			alert("IP/MAC address filter can not be [Any]! Please enter a other filter.");
		    return false;
		}
		if (tmp_name != "")
		{
			for (var j = 0; j < DataArray.length; j++)
			{
				if($('#edit').val()!=j){
					if (tmp_name == DataArray[j].Name){
						alert("The description is already in the list");
						return false;
					}
					/*
					if (mode == "0"){
						if(get_by_id("ip").value == DataArray[j].Ip_addr){
							alert(KR2);
							return false;
						}
					}else{
						if(get_by_id("mac").value == DataArray[j].MAC){
							alert(LS47);
							return false;
						}
					}
					*/
				}
				
			}
		}

		var source_ip = get_by_id("source_ip").value;
		var dest_ip = get_by_id("dest_ip").value;
		var source_mac = get_by_id("source_mac").value;
		var source_port = get_by_id("source_port").value;
		var dest_port = get_by_id("dest_port").value;
		var check_name = get_by_id("qos_desc").value;
		
		var ip_addr_msg = replace_msg(all_ip_addr_msg, get_words('ES_IP_ADDR'));
		var temp_source_ip_obj = new addr_obj(source_ip.split("."), ip_addr_msg, false, false);
		var temp_dest_ip_obj = new addr_obj(dest_ip.split("."), ip_addr_msg, false, false);
		var temp_pf;
		
		if (check_name != "")
		{
			if(Find_word(check_name,'"') || Find_word(check_name,"/"))
			{
				alert(addstr(get_words('up_ai_se_2'), get_words('_adv_txt_01')));
				return false;
			}
		
			if (address_filter == "1"){ //0:any 1:dest ip  2:source ip 4. source mac
				if (!check_address(temp_dest_ip_obj)){
					return false;
				}
			}else if (address_filter == "2"){ //0:any 1:dest ip  2:source ip 4. source mac
				if (!check_address(temp_source_ip_obj)){
					return false;
				}
			}else{
				if (!check_mac(source_mac)){
				alert(get_words('KR3'));
				return false;
				}
			}
			
			if (port_filter == "1"){ //0:any 1:dest port  2:source port 4. source /dest port
				if (!validatePorts(dest_port)){
					return false;
				}
			}else if (port_filter == "2"){ 
				if (!validatePorts(source_port)){
					return false;
				}
			}else{
				if (!validatePorts(dest_port)){
					return false;
				}
			}
			
		//set address_filter field value change
			
			if (address_filter == "0"){ //Any
				get_by_id("source_ip").value = "";
				get_by_id("dest_ip").value = "";
				get_by_id("source_mac").value = "";
			}else if(address_filter == "1"){ //Dest IP
				get_by_id("source_ip").value = "";
				get_by_id("source_mac").value = "";
			}else if(address_filter == "2"){ //Source IP
				get_by_id("dest_ip").value = "";
				get_by_id("source_mac").value = "";
			}else{ //source mac
				get_by_id("source_ip").value = "";
				get_by_id("dest_ip").value = "";
			}
			//set port_filter field value change
			
			if (port_filter == "0"){ //Any
				get_by_id("source_port").value = "";
				get_by_id("dest_port").value = "";
			}else if(port_filter == "1"){ //Dest port
				get_by_id("source_port").value = "";
			}else if(port_filter == "2"){ //Source port
				get_by_id("dest_port").value = "";
			}else if(port_filter == "3"){ //Source port
				get_by_id("dest_port").value = get_by_id("source_port").value;
			}
			
			count++;
		} else {
			alert("Description cannot be empty.");
			return false;
		}

		if(submit_button_flag == 0){
			update_DataArray();
			paintTable();
			clear_reserved();
			AddPFtoDatamodel();
			
			submit_button_flag = 1;
		}
	}
	
	function paintTable()
	{//Rule No.	Address Type	Address	Protocol	Port Filter	Port No.	Class	Description
		var contain = '<div class="box_tn">';
			contain += '<div class="CT">QoS Rule List</div>';
			contain += '<table cellspacing="0" cellpadding="0" class="formarea">';
			//contain += '<tr><td class="CTS" style="word-break:break-all;">'+get_words('_enable')+'</td>';
			contain += '<tr><td class="CTS"  align="center" >Rule No.</td>';
			contain += '<td class="CTS  align="center" ">Description</td>';
			contain += '<td class="CTS" align="center" >'+get_words('aa_AT')+'</td>';
			contain += '<td class="CTS" align="center" >'+get_words('_address')+'</td>';
			contain += '<td class="CTS" align="center" >'+get_words('_protocol')+'</td>';
		    contain += '<td width="50" height="22" align="center" class="CTS">Port Filter</td>';
			contain += '<td width="51" height="22" align="center" class="CTS">Port No.</td>';
			contain += '<td width="51" height="22" align="center" class="CTS">Class</td>';
			contain += '<td class="CTS" align="center" >'+get_words('_edit')+'</td>';
			contain += '<td class="CTS" align="center" >'+get_words('_delete')+'</td>';
			contain += '</tr>';
		
		for(var i = 0; i < DataArray.length; i++)
		{
			var is_chk='';
			var Type;
			var PortFilter;
			var Class;
			var Proto;
			var Show_Port; 
			var Show_IP; 
			
			if(DataArray[i].Src_ip !=''){
				Type="Source IP";
				Show_IP = DataArray[i].Src_ip;
			}else if(DataArray[i].Dest_ip!=''){
				Type="Destination IP";
				Show_IP = DataArray[i].Dest_ip;
			}else if(DataArray[i].Src_mac!=''){
				Type="Source MAC";
				Show_IP = DataArray[i].Src_mac;
			}else if(DataArray[i].Src_ip==''&& DataArray[i].Dest_ip=='' && DataArray[i].Src_mac==''){
				Type="Any";
				Show_IP = "";
			}
			if(DataArray[i].Src_port !='' && DataArray[i].Dst_port !='' && DataArray[i].Src_port==DataArray[i].Dst_port){
				PortFilter="Source or Destination";
				Show_Port = DataArray[i].Src_port;
			}else if(DataArray[i].Src_port !=''){ 
				PortFilter="Source";
				Show_Port = DataArray[i].Src_port;
			}else if(DataArray[i].Dst_port !=''){
				PortFilter="Destination";
				Show_Port = DataArray[i].Dst_port;
			}else if(DataArray[i].Src_port==''&& DataArray[i].Dst_port==''){
				PortFilter="Any";
				Show_Port =""
			}
			
			if(DataArray[i].Proto=="0"){
				Proto="Any";
			}else if(DataArray[i].Proto=="1"){
				Proto="TCP";
			}else if(DataArray[i].Proto=="2"){
				Proto="UDP";
			}else if(DataArray[i].Proto=="3"){
				Proto="TCP/UDP";
			}
			if(DataArray[i].Prio=="0"){
				Class="Highest";
			}else if(DataArray[i].Prio=="1"){
				Class="High";
			}else if(DataArray[i].Prio=="2"){
				Class="Medium";
			}else if(DataArray[i].Prio=="3"){
				Class="Low";
			}else if(DataArray[i].Prio=="4"){
				Class="Lowest";
			}
			if (DataArray[i].Enable == 1)
//			{
				is_chk = "checked";
//				contain += '<tr align="center" style="background-color:rgb(255,255,0);">';
//			}else{
				contain += '<tr align="center" class="break_word">';
//			}
			
			
			
			contain += '<td align="center" class="CELL">'+(i+1)+'<input type="checkbox" id="sel_enable" name="sel_enable" disabled ' +is_chk+' />'+
					'</td><td align="center" class="CELL">' + DataArray[i].Name +
					'</td><td align="center" class="CELL">' + Type + 
					'</td><td align="center" class="CELL">' + Show_IP +
					'</td><td align="center" class="CELL">' + Proto +
					'</td><td align="center" class="CELL">' + PortFilter +
					'</td><td align="center" class="CELL">' + Show_Port +
					'</td><td align="center" class="CELL">' + Class+
					'</td><td align="center" class="CELL">' +
					'<a href="javascript:edit_row('+ i +')"><img src="edit.gif" border="0" title="'+get_words('_edit')+'" /></a>'+
					'</td><td align="center" class="CELL">'+
					'<a href="javascript:del_row(' + i +')"><img src="delete.gif" border="0" title="'+get_words('_delete')+'" /></a>'+
					'</td>';

			contain += '</tr>';
		}
		contain += '</table>';
		contain += '</div>';
		$('#PFTable').html(contain);

		set_form_default_values("form1");
	}	

</SCRIPT>
</head>
<body>
<div class="wrapper">
<table border="0" width="950" cellpadding="0" cellspacing="0" align="center">
<!-- banner and model description-->
<tr>
	<td class="header_1">
		<table border="0" cellpadding="0" cellspacing="0" style="position:relative;width:920px;top:8px;" class="maintable">
		<tr>
			<td valign="top"><img src="/image/logo.png" /></td>
			<td align="right" valign="middle" class="description" style="width:600px;line-height:1.5em;">
			<script>show_words('PRODUCT_DESC')</script>
			<br><script>document.write(model);</script></br></td>
		</tr>
		</table>
	</td>
</tr>
<!-- End of banner and model description-->

<tr>
	<td>
		<table border="0" cellpadding="0" cellspacing="0" style="position:relative;width:950px;top:10px;margin-left:5px;" class="maintable">
		<!-- upper frame -->
		<tr>
			<td><img src="/image/bg_topl.gif" width="270" height="7" /></td>
			<td><img src="/image/bg_topr_01.gif" width="680" height="7" /></td>
		</tr>
		<!-- End of upper frame -->

		<tr>
			<!-- left menu -->
			<td style="background-image:url('/image/bg_l.gif');background-repeat:repeat-y;vertical-align:top;" width="270">
				<div style="padding-left:6px;">
				<script>document.write(menu.build_structure(1,1,7))</script>
				<p>&nbsp;</p>
				</div>
			    <img src="/image/bg_l.gif" width="270" height="5" /></td>
			<!-- End of left menu -->

			<td style="background-image:url('/image/bg_r.gif');background-repeat:repeat-y;vertical-align:top;" width="680">
				<img src="/image/bg_topr_02.gif" width="680" height="5" />
				<table border="0" cellpadding="0" cellspacing="0">
				<tr>
					<td valign="top" style="width:650px;padding-left:10px;">
						<table width="100%" border="0" cellpadding="0" cellspacing="0">
						<tr>
							<td valign="top">
						<iframe class="rebootRedirect" name="rebootRedirect" id="rebootRedirect" frameborder="0" width="1" height="1" scrolling="no" src="" style="visibility: hidden;">redirect</iframe>
						<div id="waitform"></div>
						<div id="waitPad" style="display: none;"></div>
						<div id="mainform">
							<!-- main content -->
							<div class="headerbg" id="scheduleTitle">
							Quality of Service Settings
							</div>
							<div class="hr"></div>
							<div class="section_content_border">
							<div class="header_desc" id="scheduleIntroduction">
								This page allows you to configure the QoS feature. 
								<p></p>
							</div>
						
					<form id="form1" name="form1" method="post" action="apply.cgi">	
								<div id="AccessControlMain" class="box_tn">								
                                <!-- get nvram value start-->
								<input type="hidden" id="qos_enable" name="qos_enable" value="<!--# echo qos_enable -->">
								<input type="hidden" id="qos_prio_ack" name="qos_prio_ack" value="<!--# echo qos_prio_ack -->">
								<input type="hidden" id="qos_prio_icmp" name="qos_prio_icmp" value="<!--# echo qos_prio_icmp -->">
								<input type="hidden" id="qos_default_class" name="qos_default_class" value="<!--# echo qos_default_class -->">
								<input type="hidden" id="qos_up_class_0_bwd" name="qos_up_class_0_bwd" value="<!--# echo qos_up_class_0_bwd -->">
								<input type="hidden" id="qos_up_class_1_bwd" name="qos_up_class_1_bwd" value="<!--# echo qos_up_class_1_bwd -->">
								<input type="hidden" id="qos_up_class_2_bwd" name="qos_up_class_2_bwd" value="<!--# echo qos_up_class_2_bwd -->"> 
								<input type="hidden" id="qos_up_class_3_bwd" name="qos_up_class_3_bwd" value="<!--# echo qos_up_class_3_bwd -->"> 
								<input type="hidden" id="qos_up_class_4_bwd" name="qos_up_class_4_bwd" value="<!--# echo qos_up_class_4_bwd -->">
								<input type="hidden" id="qos_in_class_0_bwd" name="qos_in_class_0_bwd" value="<!--# echo qos_in_class_0_bwd -->"> 
								<input type="hidden" id="qos_in_class_1_bwd" name="qos_in_class_1_bwd" value="<!--# echo qos_in_class_1_bwd -->"> 
								<input type="hidden" id="qos_in_class_2_bwd" name="qos_in_class_2_bwd" value="<!--# echo qos_in_class_2_bwd -->">
								<input type="hidden" id="qos_in_class_3_bwd" name="qos_in_class_3_bwd" value="<!--# echo qos_in_class_3_bwd -->"> 
								<input type="hidden" id="qos_in_class_4_bwd" name="qos_in_class_4_bwd" value="<!--# echo qos_in_class_4_bwd -->">

								<input type="hidden" id="qos_filter_rule_00" name="qos_filter_rule_00" value="<!--# echo qos_filter_rule_00 -->">
								<input type="hidden" id="qos_filter_rule_01" name="qos_filter_rule_01" value="<!--# echo qos_filter_rule_01 -->">
								<input type="hidden" id="qos_filter_rule_02" name="qos_filter_rule_02" value="<!--# echo qos_filter_rule_02 -->">
								<input type="hidden" id="qos_filter_rule_03" name="qos_filter_rule_03" value="<!--# echo qos_filter_rule_03 -->">
								<input type="hidden" id="qos_filter_rule_04" name="qos_filter_rule_04" value="<!--# echo qos_filter_rule_04 -->">
								<input type="hidden" id="qos_filter_rule_05" name="qos_filter_rule_05" value="<!--# echo qos_filter_rule_05 -->">
								<input type="hidden" id="qos_filter_rule_06" name="qos_filter_rule_06" value="<!--# echo qos_filter_rule_06 -->">
								<input type="hidden" id="qos_filter_rule_07" name="qos_filter_rule_07" value="<!--# echo qos_filter_rule_07 -->">
								<input type="hidden" id="qos_filter_rule_08" name="qos_filter_rule_08" value="<!--# echo qos_filter_rule_08 -->">
								<input type="hidden" id="qos_filter_rule_09" name="qos_filter_rule_09" value="<!--# echo qos_filter_rule_09 -->">
								<input type="hidden" id="del" name="del" value="-1" />
							    <input type="hidden" id="edit" name="edit" value="-1" />
							    <input type="hidden" id="max_row" name="max_row" value="-1" />
                          <!-- get nvram value end-->      
                                <table class="tbl_main" width="100%">
                                  <tbody>
                                    <tr>
                                      <td class="CT" colspan="2">QoS Setting</td>
                                    </tr>
                                    <tr>
                                      <td class="CL" onmouseover="return overlib('Enables the Qos feature.', LEFT);" onmouseout="return nd();">Enable QoS </td>
                                      <td class="CR">
									  <select onchange="qos_recalc(1);" name="tmp_qos_enable"  id="tmp_qos_enable">
                                          <option selected="selected" value="0">Disabled</option>
                                          <option value="1">Enabled</option>
                                      </select>                                      </td>
                                    </tr>
                                    <tr>
                                      <td class="CL" onmouseover="return overlib('Prioritizes the transmit ACK packets.', LEFT);" onmouseout="return nd();">Prioritize ACK </td>
                                      <td class="CR"><select name="qos_ack" id="qos_ack">
                                          <option value="0">Disabled</option>
                                          <option selected="selected" value="1">Enabled</option>
                                      </select>                                      </td>
                                    </tr>
                                    <tr>
                                      <td class="CL" onmouseover="return overlib('Prioritizes the ICMP packets (PING replies, etc)..', LEFT);" onmouseout="return nd();">Prioritize ICMP </td>
                                      <td class="CR"><select name="qos_icmp" id="qos_icmp">
                                          <option selected="selected" value="0">Disabled</option>
                                          <option value="1">Enabled</option>
                                      </select>                                      </td>
                                    </tr>
                                  </tbody>
                                </table>
                                <table class="tbl_main" width="100%">
                                  <tbody>
                                    <tr>
                                      <td class="CT" colspan="2">Traffic Class Setting</td>
                                    </tr>
                                    <tr>
                                      <td class="CL" 
                      onmouseover="return overlib('IQos default traffic class for unclassified traffic.', LEFT);" 
                      onmouseout="return nd();">Default Traffic Class </td>
                                      <td class="CR"><select name="qos_default" id="qos_default">
                                          <option value="0">Highest</option>
                                          <option value="1">High</option>
                                          <option value="2">Medium</option>
                                          <option selected="selected" value="3">Low</option>
                                          <option value="4">Lowest</option>
                                      </select>                                      </td>
                                    </tr>
                                  </tbody>
                                </table>
                                <table class="tbl_main" width="100%">
                                  <tbody>
                                    <tr>
                                      <td class="CT" colspan="2">Inbound Class Setting</td>
                                    </tr>
                                    <tr>
                                      <td class="CL" 
                      onmouseover="return overlib('Inbound traffic classes.', LEFT);" 
                      onmouseout="return nd();" height="21">Inbound Classes<br />
                                        (% Max Input BW) </td>
                                      <td class="CR"></td>
                                    </tr>
                                    <tr>
                                      <td class="CL" 
                      onmouseover="return overlib('Sets the maximum bw for inbound traffic.', LEFT);" 
                      onmouseout="return nd();">BW Max Inbound </td>
                                      <td class="CR"><input id="qos_in_bwd" onchange="qos_recalc(3);" value="<!--# echo qos_in_bwd -->" maxlength="6" size="6" name="qos_in_bwd"/>
                                        Kbit/s </td>
                                    </tr>
                                    <tr>
                                      <td class="CL"></td>
                                      <td class="CR"><font size="1">%BW</font> </td>
                                    </tr>
                                    <tr>
                                      <td class="CL" 
                      onmouseover="return overlib('Highest Priority settings in percent of max BW', LEFT);" 
                      onmouseout="return nd();">Highest</td>
                                      <td class="CR"><input onchange="qos_recalc(3);" maxlength="3" size="3" name="ibw_hi" id="ibw_hi" />
                                        &nbsp;&nbsp;&nbsp;
                                        <input 
                        style="BORDER-BOTTOM: #ffffff 1px solid; TEXT-ALIGN: center; BORDER-LEFT: #ffffff 1px solid; PADDING-BOTTOM: 0px; PADDING-LEFT: 0px; PADDING-RIGHT: 0px; BORDER-TOP: #ffffff 1px solid; BORDER-RIGHT: #ffffff 1px solid; PADDING-TOP: 0px" 
                        readonly="readOnly" maxlength="40" size="3" name="in_hi" id="in_hi" />
                                        Kbit/s </td>
                                    </tr>
                                    <tr>
                                      <td class="CL" 
                      onmouseover="return overlib('High Priority settings in percent of max BW', LEFT);" 
                      onmouseout="return nd();">High</td>
                                      <td class="CR"><input onchange="qos_recalc(3);" maxlength="3" size="3" name="ibw_h"  id="ibw_h"/>
                                        &nbsp;&nbsp;&nbsp;
                                        <input 
                        style="BORDER-BOTTOM: #ffffff 1px solid; TEXT-ALIGN: center; BORDER-LEFT: #ffffff 1px solid; PADDING-BOTTOM: 0px; PADDING-LEFT: 0px; PADDING-RIGHT: 0px; BORDER-TOP: #ffffff 1px solid; BORDER-RIGHT: #ffffff 1px solid; PADDING-TOP: 0px" 
                        readonly="readOnly" maxlength="40" size="3" name="in_h" id="in_h"/>
                                        Kbit/s </td>
                                    </tr>
                                    <tr>
                                      <td class="CL" 
                      onmouseover="return overlib('Medium Priority settings in percent of max BW', LEFT);" 
                      onmouseout="return nd();">Medium</td>
                                      <td class="CR"><input onchange="qos_recalc(3);" maxlength="3" size="3" name="ibw_med" id="ibw_med"/>
                                        &nbsp;&nbsp;&nbsp;
                                        <input 
                        style="BORDER-BOTTOM: #ffffff 1px solid; TEXT-ALIGN: center; BORDER-LEFT: #ffffff 1px solid; PADDING-BOTTOM: 0px; PADDING-LEFT: 0px; PADDING-RIGHT: 0px; BORDER-TOP: #ffffff 1px solid; BORDER-RIGHT: #ffffff 1px solid; PADDING-TOP: 0px" 
                        readonly="readOnly" maxlength="40" size="3" name="in_med" id="in_med"/>
                                        Kbit/s </td>
                                    </tr>
                                    <tr>
                                      <td class="CL" 
                      onmouseover="return overlib('Low Priority settings in percent of max BW', LEFT);" 
                      onmouseout="return nd();">Low</td>
                                      <td class="CR"><input onchange="qos_recalc(3);" maxlength="3" size="3" name="ibw_l" id="ibw_l"/>
                                        &nbsp;&nbsp;&nbsp;
                                        <input 
                        style="BORDER-BOTTOM: #ffffff 1px solid; TEXT-ALIGN: center; BORDER-LEFT: #ffffff 1px solid; PADDING-BOTTOM: 0px; PADDING-LEFT: 0px; PADDING-RIGHT: 0px; BORDER-TOP: #ffffff 1px solid; BORDER-RIGHT: #ffffff 1px solid; PADDING-TOP: 0px" 
                        readonly="readOnly" maxlength="40" size="3" name="in_l" id="in_l"/>
                                        Kbit/s </td>
                                    </tr>
                                    <tr>
                                      <td class="CL" 
                      onmouseover="return overlib('Lowest Priority settings in percent of max BW', LEFT);" 
                      onmouseout="return nd();">Lowest</td>
                                      <td class="CR"><input onchange="qos_recalc(3);" maxlength="3" size="3" name="ibw_lo" id="ibw_lo"/>
                                        &nbsp;&nbsp;&nbsp;
                                        <input 
                        style="BORDER-BOTTOM: #ffffff 1px solid; TEXT-ALIGN: center; BORDER-LEFT: #ffffff 1px solid; PADDING-BOTTOM: 0px; PADDING-LEFT: 0px; PADDING-RIGHT: 0px; BORDER-TOP: #ffffff 1px solid; BORDER-RIGHT: #ffffff 1px solid; PADDING-TOP: 0px" 
                        readonly="readOnly" maxlength="40" size="3" name="in_lo" id="in_lo"/>
                                        Kbit/s </td>
                                    </tr>
                                  </tbody>
                                </table>
                                <table class="tbl_main" width="100%">
                                  <tbody>
                                    <tr>
                                      <td class="CT" colspan="2">Outbound Class Setting</td>
                                    </tr>
                                    <tr>
                                      <td class="CL" 
                      onmouseover="return overlib('Outbound traffic classes.', LEFT);" 
                      onmouseout="return nd();" height="21">Outbound 
                                        Classes<br />
                                        (% Max Output BW) </td>
                                      <td class="CR"></td>
                                    </tr>
                                    <tr>
                                      <td class="CL" 
                      onmouseover="return overlib('Sets the maximum bw for outbound traffic.', LEFT);" 
                      onmouseout="return nd();">BW Max Outbound </td>
                                      <td class="CR"><input name="qos_up_bwd" id="qos_up_bwd" onchange="qos_recalc(2);" value="<!--# echo qos_up_bwd -->" maxlength="6" size="6" />
                                        Kbit/s </td>
                                    </tr>
                                    <tr>
                                      <td class="CL"></td>
                                      <td class="CR"><font size="1">%BWMin&nbsp;&nbsp;%BWMax</font> </td>
                                    </tr>
                                    <tr>
                                      <td class="CL" 
                      onmouseover="return overlib('Highest Priority settings in percent of max BW', LEFT);" 
                      onmouseout="return nd();">Highest</td>
                                      <td class="CR"><input onchange="qos_recalc(2);" maxlength="3" size="3" name="obw_hi_lower" id="obw_hi_lower"/>
                                          <input onchange="qos_recalc(2);" maxlength="3" size="3" name="obw_hi_higher" id="obw_hi_higher"/>
                                        &nbsp;&nbsp;&nbsp;
                                          <input 
                        style="BORDER-BOTTOM: #ffffff 1px solid; TEXT-ALIGN: center; BORDER-LEFT: #ffffff 1px solid; PADDING-BOTTOM: 0px; PADDING-LEFT: 0px; PADDING-RIGHT: 0px; BORDER-TOP: #ffffff 1px solid; BORDER-RIGHT: #ffffff 1px solid; PADDING-TOP: 0px" 
                        readonly="readOnly" maxlength="40" size="3" name="hi_lo" id="hi_lo"/>
                                        --
                                        <input 
                        style="BORDER-BOTTOM: #ffffff 1px solid; TEXT-ALIGN: center; BORDER-LEFT: #ffffff 1px solid; PADDING-BOTTOM: 0px; PADDING-LEFT: 0px; PADDING-RIGHT: 0px; BORDER-TOP: #ffffff 1px solid; BORDER-RIGHT: #ffffff 1px solid; PADDING-TOP: 0px" 
                        readonly="readOnly" maxlength="40" size="3" name="hi_hi" id="hi_hi"/>
                                        Kbit/s </td>
                                    </tr>
                                    <tr>
                                      <td class="CL" 
                      onmouseover="return overlib('High Priority settings in percent of max BW', LEFT);" 
                      onmouseout="return nd();">High</td>
                                      <td class="CR"><input onchange="qos_recalc(2);" maxlength="3" size="3" name="obw_h_lower" id="obw_h_lower"/>
                                          <input onchange="qos_recalc(2);" maxlength="3" size="3" name="obw_h_higher" id="obw_h_higher"/>
                                        &nbsp;&nbsp;&nbsp;
                                          <input 
                        style="BORDER-BOTTOM: #ffffff 1px solid; TEXT-ALIGN: center; BORDER-LEFT: #ffffff 1px solid; PADDING-BOTTOM: 0px; PADDING-LEFT: 0px; PADDING-RIGHT: 0px; BORDER-TOP: #ffffff 1px solid; BORDER-RIGHT: #ffffff 1px solid; PADDING-TOP: 0px" 
                        readonly="readOnly" maxlength="40" size="3" name="h_lo" id="h_lo"/>
                                        --
                                        <input 
                        style="BORDER-BOTTOM: #ffffff 1px solid; TEXT-ALIGN: center; BORDER-LEFT: #ffffff 1px solid; PADDING-BOTTOM: 0px; PADDING-LEFT: 0px; PADDING-RIGHT: 0px; BORDER-TOP: #ffffff 1px solid; BORDER-RIGHT: #ffffff 1px solid; PADDING-TOP: 0px" 
                        readonly="readOnly" maxlength="40" size="3" name="h_hi" id="h_hi"/>
                                        Kbit/s </td>
                                    </tr>
                                    <tr>
                                      <td class="CL" 
                      onmouseover="return overlib('Medium Priority settings in percent of max BW', LEFT);" 
                      onmouseout="return nd();">Medium</td>
                                      <td class="CR"><input onchange="qos_recalc(2);" maxlength="3" size="3" name="obw_med_lower" id="obw_med_lower"/>
                                          <input onchange="qos_recalc(2);" maxlength="3" size="3" name="obw_med_higher" id="obw_med_higher"/>
                                        &nbsp;&nbsp;&nbsp;
                                          <input 
                        style="BORDER-BOTTOM: #ffffff 1px solid; TEXT-ALIGN: center; BORDER-LEFT: #ffffff 1px solid; PADDING-BOTTOM: 0px; PADDING-LEFT: 0px; PADDING-RIGHT: 0px; BORDER-TOP: #ffffff 1px solid; BORDER-RIGHT: #ffffff 1px solid; PADDING-TOP: 0px" 
                        readonly="readOnly" maxlength="40" size="3" name="med_lo" id="med_lo"/>
                                        --
                                        <input 
                        style="BORDER-BOTTOM: #ffffff 1px solid; TEXT-ALIGN: center; BORDER-LEFT: #ffffff 1px solid; PADDING-BOTTOM: 0px; PADDING-LEFT: 0px; PADDING-RIGHT: 0px; BORDER-TOP: #ffffff 1px solid; BORDER-RIGHT: #ffffff 1px solid; PADDING-TOP: 0px" 
                        readonly="readOnly" maxlength="40" size="3" name="med_hi" id="med_hi"/>
                                        Kbit/s </td>
                                    </tr>
                                    <tr>
                                      <td class="CL" 
                      onmouseover="return overlib('Low Priority settings in percent of max BW', LEFT);" 
                      onmouseout="return nd();">Low</td>
                                      <td class="CR"><input onchange="qos_recalc(2);" maxlength="3" size="3" name="obw_l_lower" id="obw_l_lower"/>
                                          <input onchange="qos_recalc(2);" maxlength="3" size="3" name="obw_l_higher" id="obw_l_higher"/>
                                        &nbsp;&nbsp;&nbsp;
                                          <input 
                        style="BORDER-BOTTOM: #ffffff 1px solid; TEXT-ALIGN: center; BORDER-LEFT: #ffffff 1px solid; PADDING-BOTTOM: 0px; PADDING-LEFT: 0px; PADDING-RIGHT: 0px; BORDER-TOP: #ffffff 1px solid; BORDER-RIGHT: #ffffff 1px solid; PADDING-TOP: 0px" 
                        readonly="readOnly" maxlength="40" size="3" name="l_lo" id="l_lo" />
                                        --
                                        <input 
                        style="BORDER-BOTTOM: #ffffff 1px solid; TEXT-ALIGN: center; BORDER-LEFT: #ffffff 1px solid; PADDING-BOTTOM: 0px; PADDING-LEFT: 0px; PADDING-RIGHT: 0px; BORDER-TOP: #ffffff 1px solid; BORDER-RIGHT: #ffffff 1px solid; PADDING-TOP: 0px" 
                        readonly="readOnly" maxlength="40" size="3" name="l_hi" id="l_hi"/>
                                        Kbit/s </td>
                                    </tr>
                                    <tr>
                                      <td class="CL" 
                      onmouseover="return overlib('Lowest Priority settings in percent of max BW', LEFT);" 
                      onmouseout="return nd();">Lowest</td>
                                      <td class="CR"><input onchange="qos_recalc(2);" maxlength="3" size="3" name="obw_lo_lower" id="obw_lo_lower"/>
                                          <input onchange="qos_recalc(2);" maxlength="3" size="3" name="obw_lo_higher" id="obw_lo_higher"/>
                                        &nbsp;&nbsp;&nbsp;
                                          <input 
                        style="BORDER-BOTTOM: #ffffff 1px solid; TEXT-ALIGN: center; BORDER-LEFT: #ffffff 1px solid; PADDING-BOTTOM: 0px; PADDING-LEFT: 0px; PADDING-RIGHT: 0px; BORDER-TOP: #ffffff 1px solid; BORDER-RIGHT: #ffffff 1px solid; PADDING-TOP: 0px" 
                        readonly="readOnly" maxlength="40" size="3" name="lo_lo" id="lo_lo"/>
                                        --
                                        <input 
                        style="BORDER-BOTTOM: #ffffff 1px solid; TEXT-ALIGN: center; BORDER-LEFT: #ffffff 1px solid; PADDING-BOTTOM: 0px; PADDING-LEFT: 0px; PADDING-RIGHT: 0px; BORDER-TOP: #ffffff 1px solid; BORDER-RIGHT: #ffffff 1px solid; PADDING-TOP: 0px" 
                        readonly="readOnly" maxlength="40" size="3" name="lo_hi" id="lo_hi"/>
                                        Kbit/s </td>
                                    </tr>
                                  </tbody>
                                </table>
                                <table class="tbl_main" width="100%">
                                  <tbody>
                                    <tr align="middle">
                                      <td><input class="button_submit"  value="Apply" type="button" name="action" onClick="apply_action();">
                                          <input class="button_submit" name="button" type="button"  onclick="window.location.reload();" value="Cancel" />                                      </td>
                                    </tr>
                                  </tbody>
                                </table>
                                <table cellspacing="0" cellpadding="0" class="formarea">
								<tr align="center">
									<td class="btn_field">
									   <!-- add table -->
                                        <div style="DISPLAY: block" id="tabAdd">
                                          <table class="tbl_main" width="100%">
                                            <tbody>
                                              <tr>
                                                <td class="CT" colspan="2">QoS Rule Add</td>
                                              </tr>
                                              <tr>
                                                <td class="CL" height="21">Add QoS Rule</td>
                                                <td class="CR"></td>
                                              </tr>
											<tr>
											<td class="CL"><script>show_words('_adv_txt_00');</script></td>
											<td class="CR">
											<input type="checkbox" id="enable" name="enable" value="1" />
											</td>
											</tr>
                                              <tr>
                                                <td class="CL">IP/MAC Address Filter</td>
                                                <td class="CR">
												<select onchange="change_mode()" name="qos_ip" id="qos_ip">
                                                    <option selected="selected" value="0">Any</option>
                                                    <option value="1">Destination IP</option>
                                                    <option value="2">Source IP</option>
                                                    <option value="3">Source MAC</option>
                                                </select>
                                                  &nbsp; Address:
                                                  <input maxlength="17" size="17" name="source_ip" id="source_ip"> 
                                                  <input maxlength="17" size="17" name="dest_ip" id="dest_ip"> 
                                                  <input maxlength="17" size="17" name="source_mac" id="source_mac"> 
                                                  </td>
                                              </tr>
                                              <tr>
                                                <td class="CL">Protocol Filter</td>
                                                <td class="CR"><select name="qos_proto" id="qos_proto">
                                                    <option selected="selected" value="0">Any</option>
                                                    <option value="3">TCP/UDP</option>
                                                    <option value="1">TCP</option>
                                                    <option value="2">UDP</option>
                                                </select>                                                </td>
                                              </tr>
                                              <tr>
                                                <td class="CL">Port Filter</td>
                                                <td class="CR"><select onchange="change_mode()" name="qos_port" id="qos_port">
                                                    <option selected="selected" value="0">Any</option>
                                                    <option value="1">Destination Port</option>
                                                    <option value="2">Source Port</option>
                                                    <option value="3">Source or Destination</option>
                                                </select>
                                                  &nbsp; Port List:
                                                  <input maxlength="16" size="13" name="source_port" id="source_port"> 
                                                  <input maxlength="16" size="13" name="dest_port" id="dest_port"> 
                                                  </td>
                                              </tr>
                                              <tr>
                                                <td class="CL">Class Assigned</td>
                                                <td class="CR">
												<select name="qos_class" id="qos_class">
                                                    <option selected="selected" value="0">Highest</option>
                                                    <option value="1">High</option>
                                                    <option value="2">Medium</option>
                                                    <option value="3">Low</option>
                                                    <option value="4">Lowest</option>
                                                </select>                                                </td>
                                              </tr>
                                              <tr>
                                                <td class="CL">Description</td>
                                                <td class="CR"><input maxlength="32" size="32" name="qos_desc" id="qos_desc"/>                                                </td>
                                              </tr>
                                            </tbody>
                                          </table>
                                          <table class="tbl_main" width="100%">
                                            <tbody>
                                              <tr align="middle">
                                                <!--td><input name="button2" id="button2" type="button" class="button_submit" onclick="addRule();" value="Add Rule" -->                                                </td>
                                                <input type="hidden" id="sch_enable_2" value="1" />
                                                <td><input class="ButtonSmall" onclick="return send_request()" type="button" name="add" id="add"/>
                                                  <script>$('#add').val(get_words('_add'));</script>
                                                  <input class="ButtonSmall" onclick="document.location.reload();" type="button" name="clear" id="clear" />                                                </td>
                                                  <script>$('#clear').val(get_words('_clear'));</script>
                                              </tr>
                                            </tbody>
                                          </table>
                                        </div>
										<div class="box_tn">
										<span id="PFTable"></span>
										</div>
									</td>
								</tr>
								</table>
							</div>
							</form>
							<!-- End of main content -->
							<br/>
						</div>					</td>
				</tr>
				</table>			</td>
		</tr>
		</table>		</td>
	</tr>
		<!-- lower frame -->
		<tr>
			<td><img src="/image/bg_butl.gif" width="270" height="12" /></td>
			<td><img src="/image/bg_butr.gif" width="680" height="12" /></td>
		</tr>
		<!-- End of lower frame -->
		</table>
		<!-- footer -->
		<div class="footer">
			<table border="0" cellpadding="0" cellspacing="0" style="width:920px;" class="maintable">
			<tr>
				<td align="left" valign="top" class="txt_footer">
				<br><script>show_words("_copyright");</script></td>
				<td align="right" valign="top" class="txt_footer">
				<br><a href="http://www.trendnet.com/register" target="_blank"><img src="/image/icons_warranty_1.png" style="border:0px;vertical-align:middle;padding-right:10px;" border="0" /><script>show_words("_warranty");</script></a></td>
			</tr>
			</table>
		</div>
		<!-- end of footer -->

	</td>
</tr>
</table><br/>
</div>
</body>
<script>
page_load();
onPageLoad();
change_mode();
</script>
</html>
