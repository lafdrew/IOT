<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html lang="en-US" xmlns="http://www.w3.org/1999/xhtml" xml:lang="en-US">
<head>
<title>TRENDNET | modelName | Advanced | Inbound Filter</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<link href="/css/style.css" rel="stylesheet" type="text/css" />
<link href="/css/css_router.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="/uk_<!--# echo language -->.js"></script>
<script type="text/javascript" src="public_tew.js"></script>
<script type="text/javascript" src="public_msg.js"></script>
<script type="text/javascript" src="pandoraBox.js"></script>
<script type="text/javascript" src="menu_all.js"></script>
<script type="text/javascript" src="js/jquery-1.3.2.min.js"></script>
<script type="text/javascript" src="js/xml.js"></script>
<script type="text/javascript" src="js/object.js"></script>
<script type="text/javascript" src="js/ddaccordion.js"></script>
<script type="text/javascript" src="js/ccpObject.js"></script>
<script type="text/javascript">
	var def_title = document.title;
	var model = "<!--# echo model_number -->";
	document.title = def_title.replace("modelName", model);

	var menu = new menuObject();
	var submit_button_flag = 0;
	var rule_max_num = 10;
	var DataArray = new Array();
	var DataArray_detail = new Array(10);

	function onPageLoad(){
		set_form_default_values("form1");
		var login_who= checksessionStorage();
                if(login_who== "user"){
                        DisableEnableForm(document.form1,true); 
                }
	}
	//name/action/used(vs/port/wan/remote)
	function Data(name, action, used, onList) 
	{
		this.Name = name;
		this.Action = action;
		this.Used = used;
		this.Show_W = "";
		this.OnList = onList;
		var sActionW = get_words('_allow');
		if(action =="deny"){
			sActionW = get_words('_deny');
		}else if(action =="allow"){
			sActionW = get_words('_allow');
		}
		this.sAction = sActionW;
	}
	
	function Detail_Data(enable, ip_start, ip_end) 
	{
		this.Enable = enable;
		this.Ip_start = ip_start;
		this.Ip_end = ip_end;
	}
	
	function set_Inbound(){
		var index = 0;
		for (var i = 0; i < rule_max_num; i++){
			var temp_st;
			var temp_A;
			var temp_B;
			var k=i;
			if(parseInt(i,10)<10){
				k="0"+i;
			}
			temp_st = (get_by_id("inbound_filter_name_" + k).value).split("/");
			if (temp_st.length > 1){
				if(temp_st[0] != ""){
					DataArray[DataArray.length++] = new Data(temp_st[0], temp_st[1], temp_st[2], index);
					temp_A = get_by_id("inbound_filter_ip_"+ k +"_A").value.split(",");
					DataArray_detail[index] = new Array();
					var temp_ip_rang = 0;
					var enable_row_counter = 0;
					
					for(j=0;j<1;j++){
						var temp_A_e = temp_A[j].split("/");
						var temp_A_ip = temp_A_e[1].split("-");
						//document.write("temp_A_e=="+temp_A_e);
						//document.write("temp_A_ip[0]=="+temp_A_ip[0]);
						DataArray_detail[index][temp_ip_rang] = new Detail_Data(temp_A_e[0], temp_A_ip[0], temp_A_ip[1]);
						temp_ip_rang++;
						if(temp_A_e[0] == "1"){
							var T_IP_R = temp_A_e[1];
							if(temp_A_e[1] == "0.0.0.0-255.255.255.255"){
								T_IP_R = "*";
							}
							if(DataArray[index].Show_W !=""){
								//DataArray[index].Show_W = DataArray[index].Show_W + " , ";
								DataArray[index].Show_W = temp_A_ip[0];
								enable_row_counter++;
							}
							
							//if string too long, firefox not support css "word-wrap: break-word", so set one line only two data. 
							if(enable_row_counter > 0 && enable_row_counter%2 == 0){
								//DataArray[index].Show_W = DataArray[index].Show_W + "<br>";
								DataArray[index].Show_W = temp_A_ip[0];
							}
							
							//DataArray[index].Show_W = DataArray[index].Show_W + T_IP_R;
							DataArray[index].Show_W = temp_A_ip[0];
						}
					}
					
					temp_B = get_by_id("inbound_filter_ip_"+ k +"_B").value.split(",");
					for(j=0;j<temp_B.length;j++){
						var temp_B_e = temp_B[j].split("/");
						var temp_B_ip = temp_B_e[1].split("-");
						DataArray_detail[index][temp_ip_rang] = new Detail_Data(temp_B_e[0], temp_B_ip[0], temp_B_ip[1]);
						temp_ip_rang++;
						if(temp_B_e[0] == "1"){
							var T_IP_R = temp_B_e[1];
							if(temp_B_e[1] == "0.0.0.0-255.255.255.255"){
								T_IP_R = "*";
							}
							if(DataArray[index].Show_W !=""){
								DataArray[index].Show_W = DataArray[index].Show_W + " , ";
								enable_row_counter++;
							}
							
							if(enable_row_counter > 0 && enable_row_counter%2 == 0){
								DataArray[index].Show_W = DataArray[index].Show_W + "<br>";
							}
							
							DataArray[index].Show_W = DataArray[index].Show_W + T_IP_R;
						}
					}
					
					index++;
				}
			}
		}
	}
	
	function edit_row(obj){
		var mName = DataArray[obj].Name
		if (check_rule_conflict(mName)) {
			var warr_ibf_msg = ReplaceAll(GW_FIREWALL_FILTER_NAME_INVALID, "%s", mName);
			alert(warr_ibf_msg);
			return;
		}

        	
		get_by_id("edit").value = obj;
		get_by_id("ingress_filter_name").value = mName;
		set_checked(DataArray[obj].Action, get_by_name("action_select"));
		
	//	for(j=0;j<DataArray_detail[obj].length;j++){
		for(j=0;j<1;j++){
			set_checked(DataArray_detail[obj][j].Enable, get_by_id("entry_enable_"+j));
			get_by_id("ip_start_"+j).value = DataArray_detail[obj][j].Ip_start;
			get_by_id("ip_end_"+j).value = DataArray_detail[obj][j].Ip_end;
			//get_by_id("ip_end_"+j).value = DataArray_detail[obj][j].Ip_start;		
		}
		
		get_by_id("ip").value = get_by_id("ip_start_0").value;
		get_by_id("button1").value = get_words('YM34');
	}
	
	function get_rule_name(key)
	{
		var content = get_by_id(key).value;
		if (content === "") {
			return "";
		}
		var content_array = content.split("/");
		return content_array[content_array.length-1];
	}

        function check_rule_conflict(rule_name)
        {
                var flag = 0;
                for (var i = 0; i < 23; i++) {
                        var vs_name = "", pf_name = "";
                        if (i < 10) {
                                vs_name = get_rule_name("vs_rule_0"+i);
                                pf_name = get_rule_name("port_forward_both_0"+i);
                        } else {
                                vs_name = get_rule_name("vs_rule_"+i);
                                pf_name = get_rule_name("port_forward_both_"+i);
                        }
                        if (rule_name === vs_name || rule_name === pf_name) {
                                flag = 1;
                                break;
                        }
                }
		if (rule_name === get_by_id("remote_http_management_inbound_filter").value) {
				flag = 1;
		} 
		
                return flag;
        }

	function del_row(obj){
		if(check_rule_conflict(DataArray[obj].Name)) {
			alert(get_words('TEXT063'));
			return;
		}

		if(DataArray[obj].Used == "0000"){
			if(confirm(get_words('YM25') + " : " + DataArray[obj].Name)){
				delete_data(obj);
			}
		}else{
			if(confirm(get_words('YM25') + " : " + DataArray[obj].Name)){
				alert(DataArray[obj].Name + " is used.");
			}
		}

	}
	
	function delete_data(num){
		for(i=num ; i<DataArray.length-1 ;i++){
			DataArray[i].Name = DataArray[i+1].Name;
			DataArray[i].Action = DataArray[i+1].Action;
			DataArray[i].Used = DataArray[i+1].Used;
			DataArray[i].Show_W = DataArray[i+1].Show_W;
			DataArray[i].sAction = DataArray[i+1].sAction;
			DataArray[i].OnList = DataArray[i+1].OnList;
			for(j=0;j<DataArray_detail[i].length;j++){
				DataArray_detail[i][j].Enable = DataArray_detail[i+1][j].Enable;
				DataArray_detail[i][j].Ip_start = DataArray_detail[i+1][j].Ip_start;
				DataArray_detail[i][j].Ip_end = DataArray_detail[i+1][j].Ip_end;
			}
		}
		--DataArray.length;
		--DataArray_detail[DataArray.length].length;
		save_date();
	}
	
	function send_request(){

		if(get_by_id("ingress_filter_name").value.length > 0){
			/* check special string */
			if (Find_word(get_by_id("ingress_filter_name").value,'"') || 
			    Find_word(get_by_id("ingress_filter_name").value,"/")) {
				alert(get_words('INBOUND_FILTER_NAME') + " " + illegal_characters + " " + get_by_id("ingress_filter_name").value);
				return false;
			} else {
				if (!is_form_modified("form1") && !confirm(GW_FIREWALL_RULE_NAME_INVALID)) {
					return false;
				}
				var index = parseInt(get_by_id("edit").value,10);
				if(index > -1){
					if(!confirm(get_words('YM38') + " : " + get_by_id("ingress_filter_name").value)){
						return false;
					}else{
						if(DataArray[index].Used != "0000"){
							alert(DataArray[index].Name +" is used.");	
							return false;
						}
					}

					if((index < 0) && (DataArray.length >= rule_max_num)){
						alert(get_words('TEXT013') + " " + rule_max_num);
						return false;
					}
				}
				if(get_by_id("ingress_filter_name").value == "Allow All" || get_by_id("ingress_filter_name").value == "Deny All"){
					alert(get_words('TEXT014'));
					return false;
				}
				for(var i = 0; i < DataArray.length; i++){
					if(DataArray[i].Name==get_by_id("ingress_filter_name").value){
						if(DataArray[i].Name != "" && index==(DataArray[i].OnList)){
							continue;
						}else{
							alert(get_words('_name') +' '+ get_by_id("ingress_filter_name").value +' '+ get_words('sp_alreadyused'));
							return false;
						}			
					}
				}
				var is_checked = false;
				for(i=0;i<8;i++){
					var start_ip = get_by_id("ip_start_"+i).value;
					var end_ip = get_by_id("ip_end_"+i).value;

					var start_ip_addr_msg = replace_msg(all_ip_addr_msg,get_words('TEXT035'));
					var end_ip_addr_msg = replace_msg(all_ip_addr_msg,get_words('TEXT036'));
					var start_obj = new addr_obj(start_ip.split("."), start_ip_addr_msg, false, false);
					var end_obj = new addr_obj(end_ip.split("."), end_ip_addr_msg, false, false);

					if (!check_ip_order(start_obj, end_obj)){
						alert(get_words('TEXT039'));
						return false;
					}

					if(start_ip.length == 0){
						start_ip = "0.0.0.0";
						get_by_id("ip_start_"+i).value = "0.0.0.0";
					}else{
						if (!is_ipv4_valid(start_ip)) {
							alert(get_words('KR2') + " : " + start_ip + ".");
							get_by_id("ip_start_"+i).select();
							get_by_id("ip_start_"+i).focus();
							return false;
						}	
					}

					if(end_ip.length == 0){
						end_ip = "255.255.255.255";
						get_by_id("ip_end_"+i).value = "255.255.255.255";
					}else{
					    get_by_id("ip_end_"+i).value = get_by_id("ip_start_"+i).value;
						if (!is_ipv4_valid(end_ip)) {
							alert(get_words('KR2') + " : " + end_ip + ".");
							get_by_id("ip_end_"+i).select();
							get_by_id("ip_end_"+i).focus();
							return false;
						}
					}

					if(get_by_id("entry_enable_"+i).checked){
						for(j=0;j<8;j++){
							if (j != i){
								if(get_by_id("entry_enable_"+j).checked && (start_ip == get_by_id("ip_start_"+j).value && end_ip == get_by_id("ip_end_"+j).value)){
									alert(get_words('ai_alert_7a') + " "+ start_ip + " - " + end_ip + " "+ get_words('ai_alert_7b'));
									return false;
								}
							}
						}
						is_checked = true;
					}
				}
				if(!is_checked){
					alert(get_words('ai_alert_5a') + " '"+ get_by_id("ingress_filter_name").value +"'.");
					return false;
				}
				if(index > -1){
					DataArray[index].Name = get_by_id("ingress_filter_name").value;
					DataArray[index].Action = get_checked_value(get_by_name('action_select'));
					for(j=0;j<DataArray_detail[index].length;j++){
						DataArray_detail[index][j].Enable = get_checked_value(get_by_id("entry_enable_"+j));
						DataArray_detail[index][j].Ip_start = get_by_id("ip_start_"+j).value;
						DataArray_detail[index][j].Ip_end = get_by_id("ip_end_"+j).value;
					}
				}else{
					var T_num = DataArray.length;
					DataArray[DataArray.length++] = new Data(get_by_id("ingress_filter_name").value, get_checked_value(get_by_name('action_select')), "0000", T_num);
					DataArray_detail[T_num] = new Array();
					for(i=0;i<8;i++){
						DataArray_detail[T_num][i] = new Detail_Data(get_checked_value(get_by_id("entry_enable_"+i)), get_by_id("ip_start_"+i).value, get_by_id("ip_end_"+i).value);
					}
				}
				save_date();
			}
		}else{
			alert(GW_FIREWALL_RULE_NAME_INVALID);
			return false;
		}
    
	}
	function copy_data(){
		get_by_id("ip_start_0").value = get_by_id("ip").value;	
		get_by_id("ip_end_0").value = get_by_id("ip").value;	
		get_by_id("entry_enable_0").checked = true;
	
	}
	function save_date(){
		var obj = new ccpObject();
		obj.set_param_url('apply.cgi');
		obj.set_ccp_act('set');
		obj.add_param_event('adv_inbound_filter');
		obj.set_param_next_page('adv_inbound_filter.asp');
		for(var i=0; i<rule_max_num; i++){
			var k=i;
			var filter_name="", filter_ip_A="", filter_ip_B="";
			if(parseInt(i,10)<10){
				k=("0"+i).toString();
			}
			filter_name = "inbound_filter_name_" + k;
			filter_ip_A = "inbound_filter_ip_"+ k +"_A";
			filter_ip_B = "inbound_filter_ip_"+ k +"_B";
			get_by_id(filter_name).value = "";
			get_by_id(filter_ip_A).value = "";
			get_by_id(filter_ip_B).value = "";
			if(i<DataArray.length){
				var temp_st = DataArray[i].Name +"/"+ DataArray[i].Action +"/"+ DataArray[i].Used;
				var temp_A = "";
				var temp_B = "";
				for(j=0;j<1;j++){
					if(temp_A !=""){
						temp_A = temp_A + ",";
					}
					temp_A = temp_A + DataArray_detail[i][j].Enable +"/"+ DataArray_detail[i][j].Ip_start +"-"+ DataArray_detail[i][j].Ip_end;
				}
				for(j=1;j<DataArray_detail[i].length;j++){
					if(temp_B !=""){
						temp_B = temp_B + ",";
					}
					temp_B = temp_B + DataArray_detail[i][j].Enable +"/"+ DataArray_detail[i][j].Ip_start +"-"+ DataArray_detail[i][j].Ip_end;
				}
				get_by_id(filter_name).value = temp_st;
				get_by_id(filter_ip_A).value = temp_A;
				get_by_id(filter_ip_B).value = temp_B;
				
				obj.add_param_arg("inbound_filter_name_" + k,temp_st);
				obj.add_param_arg("inbound_filter_ip_"+ k +"_A",temp_A);
				obj.add_param_arg("inbound_filter_ip_"+ k +"_B",temp_B);
			}else{
				var temp_st = "";
				var temp_A = "";
				var temp_B = "";
				obj.add_param_arg("inbound_filter_name_" + k,temp_st);
				obj.add_param_arg("inbound_filter_ip_"+ k +"_A",temp_A);
				obj.add_param_arg("inbound_filter_ip_"+ k +"_B",temp_B);
			}
		}
		obj.add_param_arg('reboot_type','filter');
		totalWaitTime = 20; //second
		var param = obj.get_param();
		redirectURL = location.pathname;
		wait_page();
		jq_ajax_post(param.url, param.arg);
	}
</script>

</script>
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
				<script>document.write(menu.build_structure(1,4,1))</script>
				<p>&nbsp;</p>
				</div>
				<img src="/image/bg_l.gif" width="270" height="5" />
			</td>
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
							<div class="headerbg" id="tabBigTitle">
							<script>show_words('_inboundfilter');</script>
							</div>
							<div class="hr"></div>
							<div class="section_content_border">
							<div class="header_desc" id="introduction">
								<script>show_words('_adv_txt_23');</script>
								<p></p>
							</div>
<input type="hidden" id="vs_rule_00" name="vs_rule_00" value="<!--# echo vs_rule_00 -->">
		<input type="hidden" id="vs_rule_01" name="vs_rule_01" value="<!--# echo vs_rule_01 -->">
		<input type="hidden" id="vs_rule_02" name="vs_rule_02" value="<!--# echo vs_rule_02 -->">
		<input type="hidden" id="vs_rule_03" name="vs_rule_03" value="<!--# echo vs_rule_03 -->">
		<input type="hidden" id="vs_rule_04" name="vs_rule_04" value="<!--# echo vs_rule_04 -->">
		<input type="hidden" id="vs_rule_05" name="vs_rule_05" value="<!--# echo vs_rule_05 -->">
		<input type="hidden" id="vs_rule_06" name="vs_rule_06" value="<!--# echo vs_rule_06 -->">
		<input type="hidden" id="vs_rule_07" name="vs_rule_07" value="<!--# echo vs_rule_07 -->">
		<input type="hidden" id="vs_rule_08" name="vs_rule_08" value="<!--# echo vs_rule_08 -->">
		<input type="hidden" id="vs_rule_09" name="vs_rule_09" value="<!--# echo vs_rule_09 -->">
		<input type="hidden" id="vs_rule_10" name="vs_rule_10" value="<!--# echo vs_rule_10 -->">
		<input type="hidden" id="vs_rule_11" name="vs_rule_11" value="<!--# echo vs_rule_11 -->">
		<input type="hidden" id="vs_rule_12" name="vs_rule_12" value="<!--# echo vs_rule_12 -->">
		<input type="hidden" id="vs_rule_13" name="vs_rule_13" value="<!--# echo vs_rule_13 -->">
		<input type="hidden" id="vs_rule_14" name="vs_rule_14" value="<!--# echo vs_rule_14 -->">
		<input type="hidden" id="vs_rule_15" name="vs_rule_15" value="<!--# echo vs_rule_15 -->">
		<input type="hidden" id="vs_rule_16" name="vs_rule_16" value="<!--# echo vs_rule_16 -->">
		<input type="hidden" id="vs_rule_17" name="vs_rule_17" value="<!--# echo vs_rule_17 -->">
		<input type="hidden" id="vs_rule_18" name="vs_rule_18" value="<!--# echo vs_rule_18 -->">
		<input type="hidden" id="vs_rule_19" name="vs_rule_19" value="<!--# echo vs_rule_19 -->">
		<input type="hidden" id="vs_rule_20" name="vs_rule_20" value="<!--# echo vs_rule_20 -->">
		<input type="hidden" id="vs_rule_21" name="vs_rule_21" value="<!--# echo vs_rule_21 -->">
		<input type="hidden" id="vs_rule_22" name="vs_rule_22" value="<!--# echo vs_rule_22 -->">
		<input type="hidden" id="vs_rule_23" name="vs_rule_23" value="<!--# echo vs_rule_23 -->">


		<input type="hidden" id="port_forward_both_00" name="port_forward_both_00" value="<!--# echo port_forward_both_00 -->">
		<input type="hidden" id="port_forward_both_01" name="port_forward_both_01" value="<!--# echo port_forward_both_01 -->">
		<input type="hidden" id="port_forward_both_02" name="port_forward_both_02" value="<!--# echo port_forward_both_02 -->">
		<input type="hidden" id="port_forward_both_03" name="port_forward_both_03" value="<!--# echo port_forward_both_03 -->">
		<input type="hidden" id="port_forward_both_04" name="port_forward_both_04" value="<!--# echo port_forward_both_04 -->">
		<input type="hidden" id="port_forward_both_05" name="port_forward_both_05" value="<!--# echo port_forward_both_05 -->">
		<input type="hidden" id="port_forward_both_06" name="port_forward_both_06" value="<!--# echo port_forward_both_06 -->">
		<input type="hidden" id="port_forward_both_07" name="port_forward_both_07" value="<!--# echo port_forward_both_07 -->">
		<input type="hidden" id="port_forward_both_08" name="port_forward_both_08" value="<!--# echo port_forward_both_08 -->">
		<input type="hidden" id="port_forward_both_09" name="port_forward_both_09" value="<!--# echo port_forward_both_09 -->">
		<input type="hidden" id="port_forward_both_10" name="port_forward_both_10" value="<!--# echo port_forward_both_10 -->">
		<input type="hidden" id="port_forward_both_11" name="port_forward_both_11" value="<!--# echo port_forward_both_11 -->">
		<input type="hidden" id="port_forward_both_12" name="port_forward_both_12" value="<!--# echo port_forward_both_12 -->">
		<input type="hidden" id="port_forward_both_13" name="port_forward_both_13" value="<!--# echo port_forward_both_13 -->">
		<input type="hidden" id="port_forward_both_14" name="port_forward_both_14" value="<!--# echo port_forward_both_14 -->">
		<input type="hidden" id="port_forward_both_15" name="port_forward_both_15" value="<!--# echo port_forward_both_15 -->">
		<input type="hidden" id="port_forward_both_16" name="port_forward_both_16" value="<!--# echo port_forward_both_16 -->">
		<input type="hidden" id="port_forward_both_17" name="port_forward_both_17" value="<!--# echo port_forward_both_17 -->">
		<input type="hidden" id="port_forward_both_18" name="port_forward_both_18" value="<!--# echo port_forward_both_18 -->">
		<input type="hidden" id="port_forward_both_19" name="port_forward_both_19" value="<!--# echo port_forward_both_19 -->">
		<input type="hidden" id="port_forward_both_20" name="port_forward_both_20" value="<!--# echo port_forward_both_20 -->">
		<input type="hidden" id="port_forward_both_21" name="port_forward_both_21" value="<!--# echo port_forward_both_21 -->">
		<input type="hidden" id="port_forward_both_22" name="port_forward_both_22" value="<!--# echo port_forward_both_22 -->">
		<input type="hidden" id="port_forward_both_23" name="port_forward_both_23" value="<!--# echo port_forward_both_23 -->">

		<input type="hidden" id="remote_http_management_inbound_filter" name="remote_http_management_inbound_filter" value="<!--# echo remote_http_management_inbound_filter -->">

                <form id="form1" name="form1" method="post">
                <input type="hidden" id="inbound_filter_name_00" name="inbound_filter_name_00" value="<!--# echo inbound_filter_name_00 -->">
                <input type="hidden" id="inbound_filter_name_01" name="inbound_filter_name_01" value="<!--# echo inbound_filter_name_01 -->">
                <input type="hidden" id="inbound_filter_name_02" name="inbound_filter_name_02" value="<!--# echo inbound_filter_name_02 -->">
                <input type="hidden" id="inbound_filter_name_03" name="inbound_filter_name_03" value="<!--# echo inbound_filter_name_03 -->">
                <input type="hidden" id="inbound_filter_name_04" name="inbound_filter_name_04" value="<!--# echo inbound_filter_name_04 -->">
                <input type="hidden" id="inbound_filter_name_05" name="inbound_filter_name_05" value="<!--# echo inbound_filter_name_05 -->">
                <input type="hidden" id="inbound_filter_name_06" name="inbound_filter_name_06" value="<!--# echo inbound_filter_name_06 -->">
                <input type="hidden" id="inbound_filter_name_07" name="inbound_filter_name_07" value="<!--# echo inbound_filter_name_07 -->">
                <input type="hidden" id="inbound_filter_name_08" name="inbound_filter_name_08" value="<!--# echo inbound_filter_name_08 -->">
                <input type="hidden" id="inbound_filter_name_09" name="inbound_filter_name_09" value="<!--# echo inbound_filter_name_09 -->">
                <input type="hidden" id="inbound_filter_name_10" name="inbound_filter_name_10" value="<!--# echo inbound_filter_name_10 -->">
                <input type="hidden" id="inbound_filter_name_11" name="inbound_filter_name_11" value="<!--# echo inbound_filter_name_11 -->">
                <input type="hidden" id="inbound_filter_name_12" name="inbound_filter_name_12" value="<!--# echo inbound_filter_name_12 -->">
                <input type="hidden" id="inbound_filter_name_13" name="inbound_filter_name_13" value="<!--# echo inbound_filter_name_13 -->">
                <input type="hidden" id="inbound_filter_name_14" name="inbound_filter_name_14" value="<!--# echo inbound_filter_name_14 -->">
                <input type="hidden" id="inbound_filter_name_15" name="inbound_filter_name_15" value="<!--# echo inbound_filter_name_15 -->">
                <input type="hidden" id="inbound_filter_name_16" name="inbound_filter_name_16" value="<!--# echo inbound_filter_name_16 -->">
                <input type="hidden" id="inbound_filter_name_17" name="inbound_filter_name_17" value="<!--# echo inbound_filter_name_17 -->">
                <input type="hidden" id="inbound_filter_name_18" name="inbound_filter_name_18" value="<!--# echo inbound_filter_name_18 -->">
                <input type="hidden" id="inbound_filter_name_19" name="inbound_filter_name_19" value="<!--# echo inbound_filter_name_19 -->">
                <input type="hidden" id="inbound_filter_name_20" name="inbound_filter_name_20" value="<!--# echo inbound_filter_name_20 -->">
                <input type="hidden" id="inbound_filter_name_21" name="inbound_filter_name_21" value="<!--# echo inbound_filter_name_21 -->">
                <input type="hidden" id="inbound_filter_name_22" name="inbound_filter_name_22" value="<!--# echo inbound_filter_name_22 -->">
                <input type="hidden" id="inbound_filter_name_23" name="inbound_filter_name_23" value="<!--# echo inbound_filter_name_23 -->">

                <input type="hidden" id="inbound_filter_ip_00_A" name="inbound_filter_ip_00_A" value="<!--# echo inbound_filter_ip_00_A -->">
                <input type="hidden" id="inbound_filter_ip_01_A" name="inbound_filter_ip_01_A" value="<!--# echo inbound_filter_ip_01_A -->">
                <input type="hidden" id="inbound_filter_ip_02_A" name="inbound_filter_ip_02_A" value="<!--# echo inbound_filter_ip_02_A -->">
                <input type="hidden" id="inbound_filter_ip_03_A" name="inbound_filter_ip_03_A" value="<!--# echo inbound_filter_ip_03_A -->">
                <input type="hidden" id="inbound_filter_ip_04_A" name="inbound_filter_ip_04_A" value="<!--# echo inbound_filter_ip_04_A -->">
                <input type="hidden" id="inbound_filter_ip_05_A" name="inbound_filter_ip_05_A" value="<!--# echo inbound_filter_ip_05_A -->">
                <input type="hidden" id="inbound_filter_ip_06_A" name="inbound_filter_ip_06_A" value="<!--# echo inbound_filter_ip_06_A -->">
                <input type="hidden" id="inbound_filter_ip_07_A" name="inbound_filter_ip_07_A" value="<!--# echo inbound_filter_ip_07_A -->">
                <input type="hidden" id="inbound_filter_ip_08_A" name="inbound_filter_ip_08_A" value="<!--# echo inbound_filter_ip_08_A -->">
                <input type="hidden" id="inbound_filter_ip_09_A" name="inbound_filter_ip_09_A" value="<!--# echo inbound_filter_ip_09_A -->">
                <input type="hidden" id="inbound_filter_ip_10_A" name="inbound_filter_ip_10_A" value="<!--# echo inbound_filter_ip_10_A -->">
                <input type="hidden" id="inbound_filter_ip_11_A" name="inbound_filter_ip_11_A" value="<!--# echo inbound_filter_ip_11_A -->">
                <input type="hidden" id="inbound_filter_ip_12_A" name="inbound_filter_ip_12_A" value="<!--# echo inbound_filter_ip_12_A -->">
                <input type="hidden" id="inbound_filter_ip_13_A" name="inbound_filter_ip_13_A" value="<!--# echo inbound_filter_ip_13_A -->">
                <input type="hidden" id="inbound_filter_ip_14_A" name="inbound_filter_ip_14_A" value="<!--# echo inbound_filter_ip_14_A -->">
                <input type="hidden" id="inbound_filter_ip_15_A" name="inbound_filter_ip_15_A" value="<!--# echo inbound_filter_ip_15_A -->">
                <input type="hidden" id="inbound_filter_ip_16_A" name="inbound_filter_ip_16_A" value="<!--# echo inbound_filter_ip_16_A -->">
                <input type="hidden" id="inbound_filter_ip_17_A" name="inbound_filter_ip_17_A" value="<!--# echo inbound_filter_ip_17_A -->">
                <input type="hidden" id="inbound_filter_ip_18_A" name="inbound_filter_ip_18_A" value="<!--# echo inbound_filter_ip_18_A -->">
                <input type="hidden" id="inbound_filter_ip_19_A" name="inbound_filter_ip_19_A" value="<!--# echo inbound_filter_ip_19_A -->">
                <input type="hidden" id="inbound_filter_ip_20_A" name="inbound_filter_ip_20_A" value="<!--# echo inbound_filter_ip_20_A -->">
                <input type="hidden" id="inbound_filter_ip_21_A" name="inbound_filter_ip_21_A" value="<!--# echo inbound_filter_ip_21_A -->">
                <input type="hidden" id="inbound_filter_ip_22_A" name="inbound_filter_ip_22_A" value="<!--# echo inbound_filter_ip_22_A -->">
                <input type="hidden" id="inbound_filter_ip_23_A" name="inbound_filter_ip_23_A" value="<!--# echo inbound_filter_ip_23_A -->">
                
                <input type="hidden" id="inbound_filter_ip_00_B" name="inbound_filter_ip_00_B" value="<!--# echo inbound_filter_ip_00_B -->">
                <input type="hidden" id="inbound_filter_ip_01_B" name="inbound_filter_ip_01_B" value="<!--# echo inbound_filter_ip_01_B -->">
                <input type="hidden" id="inbound_filter_ip_02_B" name="inbound_filter_ip_02_B" value="<!--# echo inbound_filter_ip_02_B -->">
                <input type="hidden" id="inbound_filter_ip_03_B" name="inbound_filter_ip_03_B" value="<!--# echo inbound_filter_ip_03_B -->">
                <input type="hidden" id="inbound_filter_ip_04_B" name="inbound_filter_ip_04_B" value="<!--# echo inbound_filter_ip_04_B -->">
                <input type="hidden" id="inbound_filter_ip_05_B" name="inbound_filter_ip_05_B" value="<!--# echo inbound_filter_ip_05_B -->">
                <input type="hidden" id="inbound_filter_ip_06_B" name="inbound_filter_ip_06_B" value="<!--# echo inbound_filter_ip_06_B -->">
                <input type="hidden" id="inbound_filter_ip_07_B" name="inbound_filter_ip_07_B" value="<!--# echo inbound_filter_ip_07_B -->">
                <input type="hidden" id="inbound_filter_ip_08_B" name="inbound_filter_ip_08_B" value="<!--# echo inbound_filter_ip_08_B -->">
                <input type="hidden" id="inbound_filter_ip_09_B" name="inbound_filter_ip_09_B" value="<!--# echo inbound_filter_ip_09_B -->">
                <input type="hidden" id="inbound_filter_ip_10_B" name="inbound_filter_ip_10_B" value="<!--# echo inbound_filter_ip_10_B -->">
                <input type="hidden" id="inbound_filter_ip_11_B" name="inbound_filter_ip_11_B" value="<!--# echo inbound_filter_ip_11_B -->">
                <input type="hidden" id="inbound_filter_ip_12_B" name="inbound_filter_ip_12_B" value="<!--# echo inbound_filter_ip_12_B -->">
                <input type="hidden" id="inbound_filter_ip_13_B" name="inbound_filter_ip_13_B" value="<!--# echo inbound_filter_ip_13_B -->">
                <input type="hidden" id="inbound_filter_ip_14_B" name="inbound_filter_ip_14_B" value="<!--# echo inbound_filter_ip_14_B -->">
                <input type="hidden" id="inbound_filter_ip_15_B" name="inbound_filter_ip_15_B" value="<!--# echo inbound_filter_ip_15_B -->">
                <input type="hidden" id="inbound_filter_ip_16_B" name="inbound_filter_ip_16_B" value="<!--# echo inbound_filter_ip_16_B -->">
                <input type="hidden" id="inbound_filter_ip_17_B" name="inbound_filter_ip_17_B" value="<!--# echo inbound_filter_ip_17_B -->">
                <input type="hidden" id="inbound_filter_ip_18_B" name="inbound_filter_ip_18_B" value="<!--# echo inbound_filter_ip_18_B -->">
                <input type="hidden" id="inbound_filter_ip_19_B" name="inbound_filter_ip_19_B" value="<!--# echo inbound_filter_ip_19_B -->">
                <input type="hidden" id="inbound_filter_ip_20_B" name="inbound_filter_ip_20_B" value="<!--# echo inbound_filter_ip_20_B -->">
                <input type="hidden" id="inbound_filter_ip_21_B" name="inbound_filter_ip_21_B" value="<!--# echo inbound_filter_ip_21_B -->">
                <input type="hidden" id="inbound_filter_ip_22_B" name="inbound_filter_ip_22_B" value="<!--# echo inbound_filter_ip_22_B -->">
                <input type="hidden" id="inbound_filter_ip_23_B" name="inbound_filter_ip_23_B" value="<!--# echo inbound_filter_ip_23_B -->">
                <input type="hidden" id="edit" name="edit" value="-1">
                
<div class="box_tn">
	<div class="CT"><script>show_words('_adv_txt_24');</script></div>
	<table cellspacing="0" cellpadding="0" class="formarea">
	<tr>
		<td class="CL"><script>show_words('_adv_txt_01')</script></td>
		<td class="CR">
			<input type="text" id="ingress_filter_name" size="20" maxlength="15" />
		</td>
	</tr>

	<tr>
		<td class="CL"><script>show_words('_adv_txt_25')</script></td>
		<td class="CR">
			<input type="radio" name="action_select" value="allow" checked>
			<script>show_words('_allow')</script>
			<input type="radio" name="action_select" value="deny">
			<script>show_words('_deny')</script>
		</td>
	</tr>
	<tr>
		<td class="CL"><script>show_words('_ipaddr')</script></td>
		<td class="CR">
			 <input type="text" id="ip" size="20" maxlength="15" onChange="copy_data();">
			
		</td>
		  
	</tr>
	 <script>
				for(i=0;i<8;i++){
					document.write("<tr id='dlink_table' style=display:none>")
					document.write("<td class=CL align=\"middle\"><INPUT type=\"checkbox\" name=\"entry_enable_"+ i +"\" id=\"entry_enable_"+ i +"\" value=\"1\"></td>")
					document.write("<td class=CR ><input id=\"ip_start_" + i + "\" name=\"ip_start_" + i + "\" size=\"15\" maxlength=\"15\" value=\"0.0.0.0\">")
					document.write("<input id=\"ip_end_" + i + "\" name=\"ip_end_" + i + "\" size=\"15\" maxlength=\"15\" value=\"255.255.255.255\"></td>")
					document.write("</tr>")
				}
			</script>
	<tr align="center">
		<td colspan="2" class="btn_field">
			<input name="button1" id="button1" type="button" class="ButtonSmall" id="add" onClick="return send_request()" />
			<input name="button2" id="button2" type="button" disabled class="ButtonSmall" id="clear" onClick="return send_request()" />
			<script>get_by_id("button1").value = get_words('_add');</script>
			<script>get_by_id("button2").value = get_words('_clear');</script>
		</td>
	</tr>
	</table>
</div>
</form>
<span id="IBFTable"></span>

<table cellspacing="0" cellpadding="0" class="formarea">
    <tr height="22" align="center" class="CTS">
      <td height="22" align="center" class="CTS"><b><script>show_words('_adv_txt_01');</script></b></td>
      <td height="22" align="center" class="CTS"><b><script>show_words('_adv_txt_25');</script></b></td>
      <td height="22" align="center" class="CTS"><b><script>show_words('_ipaddr');</script></b></td>
      <td height="22" align="center" class="CTS"><b><script>show_words('_edit');</script></b></td>
      <td height="22" align="center" class="CTS"><b><script>show_words('_delete');</script></b></td>
    </tr>
    <script>
								set_Inbound();
								for(var i=0;i<DataArray.length;i++){
									document.write("<tr align='center'>")
									document.write("<td align='center' class='CELL'>"+ DataArray[i].Name +"</td>")
									document.write("<td align='center' class='CELL'>"+ DataArray[i].sAction +"</td>")
									document.write("<td align='center' class='CELL'>"+ DataArray[i].Show_W +"</td>")
									document.write("<td align='center' class='CELL'><a href=\"javascript:edit_row("+ i +")\"><img src=\"/edit.gif\" border=\"0\" title="+get_words('_edit')+"></a></td>")
									document.write("<td align='center' class='CELL'><a href=\"javascript:del_row(" + i +")\"><img src=\"/delete.gif\"  border=\"0\" title="+get_words('_edit')+"></a></td>")
									document.write("</tr>")
								}
							  </script>
</table>

			<br/>
							</div>
							<!-- End of main content -->
							<br/>
						</div>
					</td>
				</tr>
				</table>
			</td>
		</tr>
		</table>
		</td>
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
	onPageLoad();
</script>
</html>
