<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html lang="en-US" xmlns="http://www.w3.org/1999/xhtml" xml:lang="en-US">
<head>
<title>TRENDNET | modelName | Advanced | Samba Server</title>
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
<script lang="javascript" src="/jquery.sparkline.min.js"></script>
<script type="text/javascript">
	var misc = new ccpObject();
	var def_title = document.title;
	var model = "<!--# echo model_number -->";
	document.title = def_title.replace("modelName", model);
	
	var submit_button_flag = 0;

	var menu = new menuObject();

	var mainObj = new ccpObject();
	
		//if(smbUserCfg.name != null)
	       //User_cnt = smbUserCfg.name.length;
	var User_cnt = 0;

function user_cnt(){
	
	for(var i =0 ; i< 25;i++)
	{
		var temp_smbusername = get_by_id("smb_username"+i).value;
		if (temp_smbusername != "")
				User_cnt ++;
	}
}
	var User_DataArray = new Array();
	var DataArray = new Array();
	var list_max_num = 25;
	var User_cnt = 0;

	function Data(enable, name, passwd, permi, onList)
	{
		this.Enable = enable;
		this.Name = name;
		this.Passwd = passwd;
		this.Permi = permi;
		this.OnList = onList;
	}

	function set_reservation(){
		var index = 1;
		var smbname;
		var smbpasswd;
		var smbperm;
			user_cnt();
			for (var i = 0; i < User_cnt; i++)
			{	
				smbname = get_by_id("smb_username"+ i).value ;
				smbpasswd = get_by_id("smb_password"+ i).value;
				smbperm = get_by_id("smb_permission"+ i).value;
			//if(smbUserCfg.name[i].length > 0)
			if(smbname.length > 0 ){
				//DataArray[DataArray.length++] = new Data("0",smbUserCfg.name[i],smbUserCfg.passwd[i], smbUserCfg.permi[i], i);
				DataArray[DataArray.length++] = new Data("0",smbname,smbpasswd,smbperm, i);
			}
			$('#max_row').val(index-1);
	}
}
	function loadSettings(){
		//set_checked(smbCfg.storagemode,get_by_name("s_mode"));
		//set_checked(smbCfg.enable,get_by_name("smb"));
		set_checked("<!--# echo smb_enable -->",get_by_name("smb"));
		//set_checked(smbCfg.auth,get_by_name("auth"));
		
		// dlna
		set_checked("<!--# echo minidlna_enable -->",get_by_id("dlna"));
		$('#friendlyname').val('<!--# echo friendlyname -->');
	//	disable_dlna_server();

		$('#hostname').val('<!--# echo smb_host -->');
		$('#workgroup').val('<!--# echo smb_group -->');
		$('#descript').val('<!--# echo smb_desc -->');
		$('#admin_name').val('<!--# echo smb_admin_name -->');
		//$('#admin_passwd').val(smbCfg.Admin_passwd);
		//$('#admin_passwd_v').val(smbCfg.Admin_passwd);
		$('#permission').val(1);
		disable_smb_server();
	}

	function AddUsertoDatamodel()
	{
		var obj = new ccpObject();		
		obj.set_param_url('apply.cgi');
		obj.set_ccp_act('set');
		obj.add_param_event('smbserver');
		obj.set_param_next_page('smbserver.asp');

		for(var i=0; i<DataArray.length; i++)
		{
//			var instStr = "1.1."+ (i+1) +".0";
			//obj.add_param_arg('igdSMBServerUser_Username_',instStr,DataArray[i].Name);
			//obj.add_param_arg('igdSMBServerUser_Password_',instStr,DataArray[i].Passwd);
			//obj.add_param_arg('igdSMBServerUser_Permission_',instStr,DataArray[i].Permi);
			obj.add_param_arg('smb_username'+i,DataArray[i].Name);
			obj.add_param_arg('smb_password'+i,DataArray[i].Passwd);
			obj.add_param_arg('smb_permission'+i,DataArray[i].Permi);
			obj.add_param_arg('smb_enable'+i,'1');

		}
//		obj.get_config_obj();
// admin issue
		if ($('#admin_passwd').val() != "WDB8WvbXdH")
			obj.add_param_arg('smb_admin_pass',$('#admin_passwd').val());
		else
			obj.add_param_arg('smb_admin_pass',get_by_id("smb_admin_pass").value);
				

		obj.add_param_arg('smb_admin_name',$('#admin_name').val());
		obj.add_param_arg('smb_enable',get_checked_value(get_by_name("smb")));
		obj.add_param_arg('smb_host',$('#hostname').val());
		obj.add_param_arg('smb_group',$('#workgroup').val());
		obj.add_param_arg('smb_desc',$('#descript').val());
		obj.add_param_arg('reboot_type', 'application');

		var paramForm = obj.get_param();
		totalWaitTime = 20; //second
		redirectURL = location.pathname;
		wait_page();
		jq_ajax_post(paramForm.url, paramForm.arg);
	

	}


	function sumbit_dlna_enable()
	{
		
		//Media Server Name cannot entry  ~!@#$%^&*()_+}{[]\|"?></
		var re = /[^A-Za-z0-9_.-]/;
		var media_server_name = get_by_id("friendlyname").value;
		if(re.test(media_server_name)){
			alert(get_words('dlna_03'));
			return false;
		}

		if (media_server_name == ""){
			alert(get_words('dlna_03'));
	    		return false;
		}
		
		
		
		var obj = new ccpObject();		
		obj.set_param_url('apply.cgi');
		obj.set_ccp_act('set');
		obj.add_param_event('http_media2');
		obj.set_param_next_page('smbserver.asp');
		
		obj.add_param_arg('minidlna_enable',get_checked_value(get_by_id("dlna")));
		obj.add_param_arg('friendlyname',$('#friendlyname').val());

		var paramForm = obj.get_param();
		totalWaitTime = 15; //second
		redirectURL = location.pathname;
		wait_page();
		jq_ajax_post(paramForm.url, paramForm.arg);


	}


	function send_request(){
		var hostname_ = $('#hostname').val();
		var workgroup_ = $('#workgroup').val();
		var descript_ = $('#descript').val();
		//var storage_mode = get_by_name("s_mode");
		var admin = $('#admin_name').val();
		var passwd1 = $('#admin_passwd').val();
		var passwd2 = $('#admin_passwd_v').val();

		if (!chk_chars(hostname_)) {
			alert(addstr(get_words('li_msg162'),get_words('_ServerName')));
			return;
		}

		if(!chk_chars(workgroup_))
		{
			alert(addstr(get_words('li_msg162'),get_words('serv_workgrp')));
			return;
		}

		if(admin == "")
		{
			alert(addstr(get_words('_s_not_empty'),get_words('ADMIN')));
			return;
		}
		if(passwd1 != passwd2)
		{
			alert(get_words('MATCH_PWD_ERROR2'));
			return;
		}
		submit_all();
	}

function submit_all(){
		var obj = new ccpObject();
		obj.set_param_url('apply.cgi');
		obj.set_ccp_act('set');
		obj.add_param_event('smbserver');
		obj.set_param_next_page('smbserver.asp');

		get_by_id("smb_enable").value = get_by_name("smb").value;
	//	get_by_id("hostname").value = get_by_id("admin_name").value;
//		get_by_id("smb_admin_pass").value = get_by_id("admin_passwd").value;

		get_by_id("smb_group").value = get_by_id("workgroup").value;
		get_by_id("smb_desc").value = get_by_id("descript").value;


		if ($('#admin_passwd').val() != "WDB8WvbXdH")
			obj.add_param_arg('smb_admin_pass',$('#admin_passwd').val());
		else
			obj.add_param_arg('smb_admin_pass',get_by_id("smb_admin_pass").value);

//		obj.add_param_arg('igdSMBServerAdmin_Password_','1.1.1.0',$('#admin_passwd').val());
		obj.add_param_arg('smb_admin_name',$('#admin_name').val());
		obj.add_param_arg('smb_enable',get_checked_value(get_by_name("smb")));
		obj.add_param_arg('smb_host',$('#hostname').val());
		obj.add_param_arg('smb_group',$('#workgroup').val());
		obj.add_param_arg('smb_desc',$('#descript').val());
		obj.add_param_arg('reboot_type', 'reboot');

		for(var i=0; i<DataArray.length; i++)
		{
//			var instStr = "1.1."+ (i+1) +".0";
			//obj.add_param_arg('igdSMBServerUser_Username_',instStr,DataArray[i].Name);
			//obj.add_param_arg('igdSMBServerUser_Password_',instStr,DataArray[i].Passwd);
			//obj.add_param_arg('igdSMBServerUser_Permission_',instStr,DataArray[i].Permi);
			obj.add_param_arg('smb_username'+i,DataArray[i].Name);
			obj.add_param_arg('smb_password'+i,DataArray[i].Passwd);
			obj.add_param_arg('smb_permission'+i,DataArray[i].Permi);
			obj.add_param_arg('smb_enable'+i,'1');

		}
		obj.add_param_arg('reboot_type','application');
//		obj.get_config_obj();
	
		var param = obj.get_param();
		totalWaitTime = 20; //second
		redirectURL = location.pathname;
		wait_page();
		jq_ajax_post(param.url, param.arg);
}

	function setValueSmbEnable()
	{
		var chk_part = get_by_id("smb_enable").value;
		$('input[name=smb][value='+chk_part+']').attr('checked', true);
	}

	function disable_smb_server()
	{
		var smb = get_by_name("smb");
		//get_by_name("auth")[0].disabled = smb[1].checked;
		//get_by_name("auth")[1].disabled = smb[1].checked;
		$('#hostname').attr("disabled",smb[1].checked);
		$('#workgroup').attr("disabled",smb[1].checked);
		$('#descript').attr("disabled",smb[1].checked);	
	}

	function disable_dlna_server()
	{
		var smb = get_by_name("dlna");
		//get_by_name("auth")[0].disabled = smb[1].checked;
		//get_by_name("auth")[1].disabled = smb[1].checked;
		$('#friendlyname').attr("disabled",smb[1].checked);
	}


	function update_DataArray(){
		var index = parseInt(get_by_id("edit").value);
		var insert = false;
		var is_enable = "0";

		if(index == "-1"){      //save
			if(DataArray.length == list_max_num){
				alert(addstr(get_words('_list_full'),get_words('serv_userlist')));
				return false;
			}else{
				index = DataArray.length;
				$('#max_row').val(index);
				insert = true;
			}
		}

		if(insert){
			DataArray[index] = new Data(is_enable, $('#user_name').val(), $('#user_passwd').val(), $('#permission').val(), index, index+1);			
		}else if (index != -1){
			DataArray[index].Enable = is_enable;
			DataArray[index].Name = $('#user_name').val();
			DataArray[index].Passwd = $('#user_passwd').val();
			DataArray[index].Permi = $('#permission').val();
			DataArray[index].OnList = index;
		}
		return true;
	}


	var smbUserCfg = {
		'name':		mainObj.config_str_multi('igdSMBServerUser_Username_'),
		'passwd':	mainObj.config_str_multi('igdSMBServerUser_Password_'),
		'permi':	mainObj.config_str_multi('igdSMBServerUser_Permission_')
	}



	function Data(enable, name, passwd, permi, onList)
	{

		if(index == "-1"){      //save
			if(DataArray.length == list_max_num){
				alert(addstr(get_words('_list_full'),get_words('serv_userlist')));
			}else{
				index = DataArray.length;
				$('#max_row').val(index);
				insert = true;
			}
		}
		if(insert){
			DataArray[index] = new Data(is_enable, $('#user_name').val(), $('#user_passwd').val(), $('#permission').val(), index, index+1);			
		}else if (index != -1){
			DataArray[index].Enable = is_enable;
			DataArray[index].Name = $('#user_name').val();
			DataArray[index].Passwd = $('#user_passwd').val();
			DataArray[index].Permi = $('#permission').val();
			DataArray[index].OnList = index;
		}
	}


	var smbUserCfg = {
		'name':		mainObj.config_str_multi('igdSMBServerUser_Username_'),
		'passwd':	mainObj.config_str_multi('igdSMBServerUser_Password_'),
		'permi':	mainObj.config_str_multi('igdSMBServerUser_Permission_')
	}



	function Data(enable, name, passwd, permi, onList)
	{
		this.Enable = enable;
		this.Name = name;
		this.Passwd = passwd;
		this.Permi = permi;
		this.OnList = onList;
	}

	function save_reserved(){
		var index = 0;
		var user = $('#user_name').val();
		var user_pass = $('#user_passwd').val();
		var permi = $('#permission').val();

		if(user == ""){
			alert(get_words('NAME_ERROR',LangMap.msg));
			return false;
		}

		for(m = 0; m < DataArray.length; m++){
			if(get_by_id("edit").value == "-1"){     //add
				if(user.length > 0){
					if((user == DataArray[m].Name)){
						alert(get_words('_username')+" '"+ user +"' "+get_words('li_msg151'));
						return false;
					}
				}
			}
			if(user.length > 0 && m != parseInt(get_by_id("edit").value)){
				if((user == DataArray[m].Name)){
					alert(get_words('_username')+" '"+ user +"' "+get_words('li_msg151'));
					return false;
				}
			}
		}

		if( update_DataArray() ) {
		   // insert ok
		}
		else {
			return false;
		}
		paintTable();
		clear_reserved();
		AddUsertoDatamodel();
		//$('#modified').val("true");
		return true;
	}

	function del_row()
	{
		var idx = get_checked_value(get_by_name('sel_del'));

		
//		alert( idx in window);
//		if( idx in window ) {
		if(	typeof idx == 'undefined'){
//			alert("Please select one to delete");
			alert(get_words('_list_to_del'));
			
			return;
		}		
		
		if (idx)
			idx = parseInt(idx,10);
		else if (idx==0 && !get_by_id('sel_del').checked)
			return;

		if(!confirm(get_words('li_msg145') + " " + DataArray[idx].Name))
			return;

		for(var i=idx; i<(DataArray.length-1); i++)
		{
			//DataArray[i].Enable = DataArray[i+1].Enable
			DataArray[i].Name = DataArray[i+1].Name;
			DataArray[i].Passwd = DataArray[i+1].Passwd;
			DataArray[i].Permi = DataArray[i+1].Permi;
			DataArray[i].OnList = DataArray[i+1].OnList;
		}

		if(DataArray.length > 0)
			DataArray.length -- ;

		paintTable();
		clear_reserved();

		var del = new ccpObject();
		del.set_param_url('get_set.ccp');
		del.set_ccp_act('del');
		del.add_param_event('CCP_SUB_WEBPAGE_APPLY');

		del.add_param_arg('IGD_SMBServer_User_i_','1.1.'+ User_cnt +'.0');
		del.ajax_submit(true);
		AddUsertoDatamodel();
		//deleteRedundentDatamodel();
		//$('#modified').val("true");
	}


	function edit_row(idx)
    {
        $('#user_name').val(DataArray[idx].Name);
        $('#user_passwd').val(DataArray[idx].Passwd);
        $('#permission').val(DataArray[idx].Permi);
		$('#edit').val(idx);
		$('#add').hide();
		$('#edit_btn').show();
    }

	function paintTable()
	{
		var contain = ""
		var is_enable = "";
		for(var i = 0; i < DataArray.length; i++){
			contain += '<tr>'+
					'<td class="CELL"><input type="radio" id="sel_del" name="sel_del" onClick="edit_row('+i+')" value="'+i+'" /></td>'+
					'<td class="CELL">'+DataArray[i].Name+'</td>'+
					'<td class="CELL">'+string_to_star(DataArray[i].Passwd.length)+'</td>'+
					'<td class="CELL">'+((DataArray[i].Permi == 1)?get_words('serv_read'):get_words('serv_write'))+'</td>'+
					'</tr>';
		}
		$('#UserTable').append(contain);
	}

	function string_to_star(len)
	{
		var stars = '';
		for (var j = 0; j<len;j++)
		{
			stars += '*';
		}
		return (stars)
	}

	function clear_reserved(){
		$('#user_name').val("");
		$('#user_passwd').val("");
		$('#permission').val(1);
		$('#edit').val(-1);
	}


$(function(){
	setValueSmbEnable();
});
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
				<script>document.write(menu.build_structure(1,6,0))</script>
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
						<div class="headerbg" id="manStatusTitle">
								<script>show_words('_samba_server');</script>
						</div>
								<div class="hr"></div>
								<div class="section_content_border">
								<div class="header_desc" id="manStatusIntroduction">
									<p></p>
						</div>
				<form id="form1" name="form1" method="post" action="apply.cgi">		
				<input type="hidden" id="html_response_page" name="html_response_page" value="count_down.asp">
				<input type="hidden" id="html_response_message" name="html_response_message" value=""><script>get_by_id("html_response_message").value = get_words('sc_intro_sv');</script>
				<input type="hidden" id="html_response_return_page" name="html_response_return_page" value="media_server2.asp">
				<input type="hidden" id="action" name="action" value="http_kcode">						
				<input type="hidden" id="action" name="action" value="smbserver">
				<input type="hidden" id="minidlna_enable" name="minidlna_enable" value="<!--# echo minidlna_enable -->">
				<input type="hidden" id="smb_enable" name="smb_enable" value="<!--# echo smb_enable -->">
				<input type="hidden" id="smb_host" name="smb_host" value="<!--# echo smb_host -->">
				<input type="hidden" id="smb_admin_pass" name="smb_admin_pass" value="<!--# echo smb_admin_pass -->"">
				<input type="hidden" id="smb_group" name="smb_group" value="<!--# echo smb_group -->">
				<input type="hidden" id="smb_desc" name="smb_desc" value="<!--# echo smb_desc -->">
<input type="hidden" id="smb_username0" name="smb_username0" value="<!--# echo smb_username0 -->">
<input type="hidden" id="smb_password0" name="smb_password0" value="<!--# echo smb_password0 -->">
<input type="hidden" id="smb_permission0" name="smb_permission0" value="<!--#echo smb_permission0 -->">
<input type="hidden" id="smb_enable0" name="smb_enable0" value="<!--#echo smb_enable0 -->">
<input type="hidden" id="smb_username1" name="smb_username1" value="<!--# echo smb_username1 -->">
<input type="hidden" id="smb_password1" name="smb_password1" value="<!--# echo smb_password1 -->">
<input type="hidden" id="smb_enable1" name="smb_enable1" value="<!--#echo smb_enable1 -->">
<input type="hidden" id="smb_permission1" name="smb_permission1" value="<!--#echo smb_permission1 -->">
<input type="hidden" id="smb_username2" name="smb_username2" value="<!--# echo smb_username2 -->">
<input type="hidden" id="smb_password2" name="smb_password2" value="<!--# echo smb_password2 -->">
<input type="hidden" id="smb_permission2" name="smb_permission2" value="<!--# echo smb_permission2 -->">
<input type="hidden" id="smb_enable2" name="smb_enable2" value="<!--#echo smb_enable2 -->">
<input type="hidden" id="smb_username3" name="smb_username3" value="<!--# echo smb_username3 -->">
<input type="hidden" id="smb_password3" name="smb_password3" value="<!--# echo smb_password3 -->">
<input type="hidden" id="smb_permission3" name="smb_permission3" value="<!--# echo smb_permission3 -->">
<input type="hidden" id="smb_enable3" name="smb_enable3" value="<!--#echo smb_enable3 -->">
<input type="hidden" id="smb_username4" name="smb_username4" value="<!--# echo smb_username4 -->">
<input type="hidden" id="smb_password4" name="smb_password4" value="<!--# echo smb_password4 -->">
<input type="hidden" id="smb_permission4" name="smb_permission4" value="<!--# echo smb_permission4 -->">
<input type="hidden" id="smb_enable4" name="smb_enable4" value="<!--#echo smb_enable4 -->">
<input type="hidden" id="smb_username5" name="smb_username5" value="<!--# echo smb_username5 -->">
<input type="hidden" id="smb_password5" name="smb_password5" value="<!--# echo smb_password5 -->">
<input type="hidden" id="smb_permission5" name="smb_permission5" value="<!--# echo smb_permission5 -->">
<input type="hidden" id="smb_enable5" name="smb_enable5" value="<!--#echo smb_enable5 -->">
<input type="hidden" id="smb_username6" name="smb_username6" value="<!--# echo smb_username6 -->">
<input type="hidden" id="smb_password6" name="smb_password6" value="<!--# echo smb_password6 -->">
<input type="hidden" id="smb_permission6" name="smb_permission6" value="<!--# echo smb_permission6 -->">
<input type="hidden" id="smb_enable6" name="smb_enable6" value="<!--#echo smb_enable6 -->">
<input type="hidden" id="smb_username7" name="smb_username7" value="<!--# echo smb_username7 -->">
<input type="hidden" id="smb_password7" name="smb_password7" value="<!--# echo smb_password7 -->">
<input type="hidden" id="smb_permission7" name="smb_permission7" value="<!--# echo smb_permission7 -->">
<input type="hidden" id="smb_enable7" name="smb_enable7" value="<!--#echo smb_enable7 -->">
<input type="hidden" id="smb_username8" name="smb_username8" value="<!--# echo smb_username8 -->">
<input type="hidden" id="smb_password8" name="smb_password8" value="<!--# echo smb_password8 -->">
<input type="hidden" id="smb_permission8" name="smb_permission8" value="<!--# echo smb_permission8 -->">
<input type="hidden" id="smb_enable8" name="smb_enable8" value="<!--#echo smb_enable8 -->">
<input type="hidden" id="smb_username9" name="smb_username9" value="<!--# echo smb_username9 -->">
<input type="hidden" id="smb_password9" name="smb_password9" value="<!--# echo smb_password9 -->">
<input type="hidden" id="smb_permission9" name="smb_permission9" value="<!--# echo smb_permission9 -->">
<input type="hidden" id="smb_enable9" name="smb_enable9" value="<!--#echo smb_enable9 -->">
<input type="hidden" id="smb_username10" name="smb_username10" value="<!--# echo smb_username10 -->">
<input type="hidden" id="smb_password10" name="smb_password10" value="<!--# echo smb_password10 -->">
<input type="hidden" id="smb_permission10" name="smb_permission10" value="<!--# echo smb_permission10 -->">
<input type="hidden" id="smb_enable10" name="smb_enable10" value="<!--#echo smb_enable10 -->">
<input type="hidden" id="smb_username11" name="smb_username11" value="<!--# echo smb_username11 -->">
<input type="hidden" id="smb_password11" name="smb_password11" value="<!--# echo smb_password11 -->">
<input type="hidden" id="smb_permission11" name="smb_permission11" value="<!--# echo smb_permission11 -->">
<input type="hidden" id="smb_enable11" name="smb_enable11" value="<!--#echo smb_enable11 -->">
<input type="hidden" id="smb_username12" name="smb_username12" value="<!--# echo smb_username12 -->">
<input type="hidden" id="smb_password12" name="smb_password12" value="<!--# echo smb_password12 -->">
<input type="hidden" id="smb_permission12" name="smb_permission12" value="<!--# echo smb_permission12 -->">
<input type="hidden" id="smb_enable12" name="smb_enable12" value="<!--#echo smb_enable12 -->">
<input type="hidden" id="smb_username13" name="smb_username13" value="<!--# echo smb_username13 -->">
<input type="hidden" id="smb_password13" name="smb_password13" value="<!--# echo smb_password13 -->">
<input type="hidden" id="smb_permission13" name="smb_permission13" value="<!--# echo smb_permission13 -->">
<input type="hidden" id="smb_enable13" name="smb_enable13" value="<!--#echo smb_enable13 -->">
<input type="hidden" id="smb_username14" name="smb_username14" value="<!--# echo smb_username14 -->">
<input type="hidden" id="smb_password14" name="smb_password14" value="<!--# echo smb_password14 -->">
<input type="hidden" id="smb_permission14" name="smb_permission14" value="<!--# echo smb_permission14 -->">
<input type="hidden" id="smb_enable14" name="smb_enable14" value="<!--#echo smb_enable14 -->">
<input type="hidden" id="smb_username15" name="smb_username15" value="<!--# echo smb_username15 -->">
<input type="hidden" id="smb_password15" name="smb_password15" value="<!--# echo smb_password15 -->">
<input type="hidden" id="smb_permission15" name="smb_permission15" value="<!--# echo smb_permission15 -->">
<input type="hidden" id="smb_enable15" name="smb_enable15" value="<!--#echo smb_enable15 -->">
<input type="hidden" id="smb_username16" name="smb_username16" value="<!--# echo smb_username16 -->">
<input type="hidden" id="smb_password16" name="smb_password16" value="<!--# echo smb_password16 -->">
<input type="hidden" id="smb_permission16" name="smb_permission16" value="<!--# echo smb_permission16 -->">
<input type="hidden" id="smb_enable16" name="smb_enable16" value="<!--#echo smb_enable16 -->">
<input type="hidden" id="smb_username17" name="smb_username17" value="<!--# echo smb_username17 -->">
<input type="hidden" id="smb_password17" name="smb_password17" value="<!--# echo smb_password17 -->">
<input type="hidden" id="smb_permission17" name="smb_permission17" value="<!--# echo smb_permission17 -->">
<input type="hidden" id="smb_enable17" name="smb_enable17" value="<!--#echo smb_enable17 -->">
<input type="hidden" id="smb_username18" name="smb_username18" value="<!--# echo smb_username18 -->">
<input type="hidden" id="smb_password18" name="smb_password18" value="<!--# echo smb_password18 -->">
<input type="hidden" id="smb_permission18" name="smb_permission18" value="<!--# echo smb_permission18 -->">
<input type="hidden" id="smb_enable18" name="smb_enable18" value="<!--#echo smb_enable18 -->">
<input type="hidden" id="smb_username19" name="smb_username19" value="<!--# echo smb_username19 -->">
<input type="hidden" id="smb_password19" name="smb_password19" value="<!--# echo smb_password19 -->">
<input type="hidden" id="smb_permission19" name="smb_permission19" value="<!--# echo smb_permission19 -->">
<input type="hidden" id="smb_enable19" name="smb_enable19" value="<!--#echo smb_enable19 -->">
<input type="hidden" id="smb_username20" name="smb_username20" value="<!--# echo smb_username20 -->">
<input type="hidden" id="smb_password20" name="smb_password20" value="<!--# echo smb_password20 -->">
<input type="hidden" id="smb_permission20" name="smb_permission20" value="<!--# echo smb_permission20 -->">
<input type="hidden" id="smb_enable20" name="smb_enable20" value="<!--#echo smb_enable20 -->">
<input type="hidden" id="smb_username21" name="smb_username21" value="<!--# echo smb_username21 -->">
<input type="hidden" id="smb_password21" name="smb_password21" value="<!--# echo smb_password21 -->">
<input type="hidden" id="smb_permission21" name="smb_permission21" value="<!--# echo smb_permission21 -->">
<input type="hidden" id="smb_enable21" name="smb_enable21" value="<!--#echo smb_enable21 -->">
<input type="hidden" id="smb_username22" name="smb_username22" value="<!--# echo smb_username22 -->">
<input type="hidden" id="smb_password22" name="smb_password22" value="<!--# echo smb_password22 -->">
<input type="hidden" id="smb_permission22" name="smb_permission22" value="<!--# echo smb_permission22 -->">
<input type="hidden" id="smb_enable22" name="smb_enable22" value="<!--#echo smb_enable22 -->">
<input type="hidden" id="smb_username23" name="smb_username23" value="<!--# echo smb_username23 -->">
<input type="hidden" id="smb_password23" name="smb_password23" value="<!--# echo smb_password23 -->">
<input type="hidden" id="smb_permission23" name="smb_permission23" value="<!--# echo smb_permission23 -->">
<input type="hidden" id="smb_enable23" name="smb_enable23" value="<!--#echo smb_enable23 -->">
<input type="hidden" id="smb_username24" name="smb_username24" value="<!--# echo smb_username24 -->">
<input type="hidden" id="smb_password24" name="smb_password24" value="<!--# echo smb_password24 -->">
<input type="hidden" id="smb_permission24" name="smb_permission24" value="<!--# echo smb_permission24 -->">
<input type="hidden" id="smb_enable24" name="smb_enable24" value="<!--#echo smb_enable24 -->">
<input type="hidden" id="del" name="del" value="-1">
<input type="hidden" id="edit" name="edit" value="-1">
<input type="hidden" id="max_row" name="max_row" value="-1">
<input type="hidden" id="reboot_type" name="reboot_type" value="reboot">


<div class="box_tn">
	<div class="CT"><script>show_words('dlna_04');</script></div>
	<table cellspacing="0" cellpadding="0" class="formarea">
	<!-- ----------------- System Info ----------------- -->
	<tr>
		<!--td class="CR">
			<input type="radio" name="dlna" value="1" onClick="disable_dlna_server()">
			<script>show_words('_enable')</script>&nbsp;&nbsp;&nbsp;
			<input type="radio" name="dlna" value="0" onClick="disable_dlna_server()">
			<script>show_words('_disable')</script>
		</td-->
		<td class="CL"><script>show_words('_enable');</script></td>
		<td class="CR">
		<input type="checkbox" id="dlna" name="dlna" value="1">
		</td>
	</tr>
	<tr id="show_media_name" style="display: none;">
		<td class="CL"><script>show_words('dlna_02');</script></td>
		<td class="CR">
			<input type="text" id="friendlyname" name="friendlyname" size="20" maxlength="15" value="" />
		</td>
	</tr>
	
	</table>

	<div id="buttonField2" class="box_tn">
		<table cellspacing="0" cellpadding="0" class="formarea">
			<tr align="center">
				<td colspan="2" class="btn_field">
					<input type="button" class="button_submit" id="submit2" value="Apply" onclick="sumbit_dlna_enable();" />
					<script>$('#submit2').val(get_words('_apply'));</script>
					<!--input type="reset" class="button_submit" id="btn_cancel2" value="Clear" onclick="window.location.reload()" />
					<script>$('#btn_cancel').val(get_words('_clear'));</script-->
				</td>
			</tr>
		</table>
	</div>


</div>

<div class="box_tn">
	<div class="CT"><script>show_words('serv_info');</script></div>
	<table cellspacing="0" cellpadding="0" class="formarea">
	<!-- ----------------- System Info ----------------- -->
	<tr>
		<td class="CL"><script>show_words('serv_samba_');</script></td>
		<td class="CR">
			<input type="hidden" id="smb_server" name="smb_server" value="">
			<input type="radio" name="smb" value="1" onClick="disable_smb_server()">
			<script>show_words('_enable')</script>&nbsp;&nbsp;&nbsp;
			<input type="radio" name="smb" value="0" onClick="disable_smb_server()">
			<script>show_words('_disable')</script>
		</td>
	</tr>
	<tr>
		<td class="CL"><script>show_words('_ServerName');</script></td>
		<td class="CR">
			<input type="text" id="hostname" name="hostname" size="20" maxlength="15" value="" />
		</td>
	</tr>
	<tr>
		<td class="CL"><script>show_words('serv_workgrp');</script></td>
		<td class="CR">
			<input name="workgroup" type="text" id="workgroup" size="20" maxlength="15" value="" />
		</td>
	</tr>
	<tr>
		<td class="CL"><script>show_words('serv_desc');</script></td>
		<td class="CR">
			<input name="descript" type="text" id="descript" size="20" maxlength="48" value="" />
		</td>
	</tr>
	</table>
</div>
</form>

<div class="box_tn">
	<div class="CT"><script>show_words('serv_setadmin');</script></div>
	<table cellspacing="0" cellpadding="0" class="formarea">
	<!-- ----------------- System Info ----------------- -->
	<tr>
		<td class="CL"><script>show_words('ADMIN')</script></td> 
		<td class="CR"><input type="text" id="admin_name" name="admin_name" size="20" maxlength="15" >
		</td>
	</tr>
	<tr>
		<td class="CL"><script>show_words('_NewPwd')</script></td>  
		<td class="CR"><input name="admin_passwd" type="password" id="admin_passwd" size="20" maxlength="15" value ="WDB8WvbXdH" >
		</td>
	</tr>

	<tr>
		<td class="CL"><script>show_words('serv_repasswd')</script></td> 
		<td class="CR"><input name="admin_passwd_v" type="password" id="admin_passwd_v" size="20" maxlength="15" value ="WDB8WvbXdH">
		</td>
	</tr>
	</table>
	<div id="buttonField" class="box_tn">
		<table cellspacing="0" cellpadding="0" class="formarea">
			<tr align="center">
				<td colspan="2" class="btn_field">
					<input type="button" class="button_submit" id="submit" value="Apply" onclick="send_request();" />
					<script>$('#submit').val(get_words('_apply'));</script>
					<input type="reset" class="button_submit" id="btn_cancel" value="Cancel" onclick="window.location.reload()" />
					<script>$('#btn_cancel').val(get_words('_cancel'));</script>
				</td>
			</tr>
		</table>
	</div>
</div>

<div class="box_tn">
	<div class="CT"><script>show_words('serv_userlist');</script></div>
	<table cellspacing="0" cellpadding="0" class="formarea">
	<!-- ----------------- System Info ----------------- -->
	<tr>
		<td class="CL"><script>show_words('_username')</script></td>
		<td class="CR"><input type="text" id="user_name" name="user_name" size="15" maxlength="15" value=""></td>
	</tr>
	<tr>
		<td class="CL"><script>show_words('_password')</script></td>
		<td class="CR"><input name="user_passwd" type="password" id="user_passwd" size="15" maxlength="15" value="" onChange=""></td>
	</tr>
	<tr>
		<td class="CL"><script>show_words('serv_permission')</script></td>
		<td class="CR">
			<select id="permission" name="permission" size="1">
				<option value="1"><script>show_words('serv_read')</script></option>
				<option value="7"><script>show_words('serv_write')</script></option>
			</select>
		</td>
	</tr>
	</table>
	<div id="buttonField" class="box_tn">
		<table cellspacing="0" cellpadding="0" class="formarea">
		<tr align="center">
			<td colspan="2" class="btn_field">
				<input name="add" type="button" class="button_submit" id="add" onClick="save_reserved()" value="">
				<script>$('#add').val(get_words('_add'));</script>
				<input type="button" class="button_submit" id="edit_btn" onClick="save_reserved()" value="" style="display:none;">
				<script>$('#edit_btn').val(get_words('_edit'));</script>
				<input type="reset" class="button_submit" id="btn_cancel1" value="Clear" onclick="window.location.reload()" />
				<script>$('#btn_cancel1').val(get_words('_clear'));</script>
			</td>
		</tr>
		</table>
	</div>
	
</div>

<div class="box_tn">
	<div class="CT"><script>show_words('serv_curr_userlist');</script></div>
	<table id="UserTable" cellspacing="0" cellpadding="0" class="formarea">
	<tr>
		<td class="CELL" width="40px"></td>
		<td class="CELL"><script>show_words('_username');</script></td>
		<td class="CELL"><script>show_words('_password');</script></td>
		<td class="CELL"><script>show_words('serv_permission');</script></td>
	</tr>
	</table>
	<script>
		set_reservation();
		paintTable();
	</script>

	<div class="CT" align="right">
		<strong><script>show_words('serv_total_user')</script></strong>&nbsp;&nbsp;&nbsp;
		<input name="del_user" type="button" class="button_submit" id="del_user" onClick="del_row()" value="" />
		<script>$('#del_user').val(get_words('_delete'));</script>
	</div>
</div>

								</div>
							</div>
							<!-- End of main content -->
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
<script>
	loadSettings();
</script>
</body>
</html>
