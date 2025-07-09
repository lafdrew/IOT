<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<title>D-LINK CORPORATION, INC | WIRELESS ROUTER | HOME</title>
<meta http-equiv=Content-Type content="text/html; charset=UTF-8">
<link rel="stylesheet" type="text/css" href="web_file_access.css" />
<script type="text/JavaScript" src="jquery-1.6.1.min.js"></script>
<script type="text/Javascript" src="jquery-DOMWindow.js"></script>
</head>
<body>

<table class="main">
  <tr><th colspan=2 height=50px>
    <h1 class="header">D-Link Web File Access Server</h1>
  </th></tr>
  <tr>
    <td class="left"></td>
    <td class="right">&nbsp;
      <input type="button" id="cfolder" name="cfolder" value="New Folder" onClick="CreateFolder();"> 
      &nbsp;&nbsp;
      <input type="button" id="fupload" name="fupload" value="Upload" onClick="UploadFolder();"> 
    </td>
  </tr>
  <tr>
    <td class="treeTable">
    <div class="treeTable1">
      <ul class="jqueryFileTree">
        <li class="toexpanded">My Access Device Hard Drive
          <span id="tree_root"></span>
	</li>
      </ul>
    </div>
    </td>
    <td class="folderInfo">
      <table id="rtable" cellspacing="0">
        <thead>
	  <tr>
	    <th id="rname">Name</th>
	    <th id="rsize">Size</th>
	    <th id="rtype">File Type</th>
	    <th id="rMTime">Modified Time</th>
	  </tr>
	</thead>
	<tbody>
	</tbody>
      </table>
    </td>
  </tr>
</table>

<div id="inlineContent" style="display:none;">
<form id="cfolde">
<table width=100% height=100% class="uploadtab">
<thead><tr><th align="left">Create Folder</th></tr></thead>
<tbody>
        <tr><td><p>&nbsp;&nbsp;&nbsp;Please enter a folder name:&nbsp;<input type="text" id="filename" name="filename" value=""></p></td></tr>
</tbody>
<tfoot align=right>
        <tr>
            <td>
                <input type="submit" id="OK" name="OK" value="OK" class="closeDOMWindow"> &nbsp; 
                <input type="button" id="Cancel" name="Cancel" value="Cancel" class="closeDOMWindow">
            </td>
        </tr>
</tfoot>
</table>
</form>
</div>

<div id="ufile" style="display:none;">
<form id="form1" name="form1" method="POST" action="upload_file.cgi" enctype="multipart/form-data">
<input type="hidden" id="html_response_page" name="html_response_page" value="file_access.asp">
<input type="hidden" id="html_response_message" name="html_response_message" value="<!--# echo html_response_message -->">
<input type="hidden" id="html_response_return_page" name="html_response_return_page" value="file_access.asp">
<input type="hidden" id="file_path" name="file_path" value="">
<table width=100% height=100% class="uploadtab">
<thead><tr><th align="left">Upload File</th></tr></thead>
<tbody><tr><td><p>&nbsp;&nbsp;&nbsp;Please select a file:&nbsp;<input type="file" id="file" name="file"></p></td></tr></tbody>
<tfoot align="right"><tr><td>
<input type="button" id="fok" value="OK" onClick="send_request();" class="closeDOMWindow">
<input type="button" id="fcancel" value="Cancel" class="closeDOMWindow">
</td></tr>
</tfoot>
</table>
</form>
</div>
<span id="path" name="path" style="display:none"></span>
<input type="hidden" id="expand_st" name="expand_st" value="0">
</body>
<script type="text/javascript">
var treeTable = new Array();
var totalID=0;
var flag = true;

function CreateFolder()
{
	$.openDOMWindow({ 
		modal:1,
		height:110, 
		width:400,
		windowSourceID:'#inlineContent' 
	}); 
}

function UploadFolder()
{
	$.openDOMWindow({
		modal:1,
		height:110, 
		width:400,
		windowSourceID:'#ufile'
	});
}

function send_request()
{
	document.getElementById("file_path").value = $("#path").val();
	if (flag) {
		flag = false;
		document.form1.submit();
	}
	return true;
}

function ClickFolder(path, access, sub, right)
{

	if(document.getElementById(path) == undefined) {
		expand_tree(path);
	} else if (sub == 0)
		getFolder(path, 1, sub);
	else if (document.getElementById(path).className == "tocollapse") {
                getFolder(path, 1, sub);
        }else{
		document.getElementById(path).className = "tocollapse";
		document.getElementById(path+"-sub").innerHTML = "";
                getFolder(path, right, sub);
	}

	document.getElementById("cfolder").disabled = (access == 0) ? true : false; 
	document.getElementById("fupload").disabled = (access == 0) ? true : false; 
}

function getFolder(path, right, t_sub, sync)
{
	var async = (sync == "1") ? false:true;
	$("#path").val(path);
        $.ajax({
                type: "GET",
		async: async,
                url: "file_tree.js?right="+path,
                dataType: "script",
                cache: false,
                complete: function(xml) {
			try {
                        	var tmp = eval(xml.responseText);
			} catch(e) {
				getFolder(path, right, t_sub);
				return;
			}
			time = time_src;
                        if (typeof tmp === "undefined")
                                return;
                        var len = tmp.length;

			$("#tree_root>ul>li").each(function(i){
				if($(this).find('a').hasClass("selected")){
					$(this).find('a').removeClass("selected");
				}
			});
			$(document.getElementById(path)).find('a').addClass("selected");

			if(right == "1") {
				/* Add tbody content */
				var tbody = "";
				tbody += '<ul class="jqueryFileTree">';
				for (var i = 0; i < len-1 && tmp[i]['type'] == "Folder"; i++) {
					if (tmp[i]['name'] == "..")
						continue;
					tbody += '<li id="'+tmp[i]['path']+'" ';
					if (tmp[i]['sub'] == "1") tbody += 'class="tocollapse"';
					tbody += '><a href="#" onClick=ClickFolder("'+tmp[i]['path']+'","'+tmp[i]['access']+'","'+tmp[i]['sub']+'",0);><img src="images/directory.png" />'+tmp[i]['name']+'</a><span id="'+tmp[i]['path']+'-sub"></span>';
					totalID++;
				}
				tbody += '</li></ul>';
				document.getElementById(path+"-sub").innerHTML = tbody;

				if(t_sub == "1" || tmp[1]['type'] == "Folder")
					document.getElementById(path).className = "toexpanded";
			}

			$("#rtable>tbody").empty();
			var ret = "";
			for (var i = 0; i < len-1; i++) {
				if (tmp[i]['name'] == "..")
					continue;
				var name = tmp[i]['name'], size = tmp[i]['size'];
				var type = tmp[i]['type'], mtime = tmp[i]['time'];
				var sub_path = tmp[i]['path'], access = tmp[i]['access'], sub = tmp[i]['sub'];
				var sub_flag = 0;

				var renew = document.getElementById("html_response_message").value;
				if (renew != "" && renew == sub_path) {
					document.getElementById("cfolder").disabled = (access == 0) ? true : false; 
					document.getElementById("fupload").disabled = (access == 0) ? true : false; 
				}

				var span = "";
				if (type === "Folder"){
					sub_flag = 1;
					span = "<img src=\"images/directory.png\" /><a href=\"#\" onClick=ClickFolder(\""+ sub_path + "\",\"" + access +"\",\""+ sub +"\",1);>";
				}else{
					var img = (images[type] == undefined) ? images['file'] : images[type];
					span = "<img src=\""+img+"\" /><a href=\""+sub_path+"\" target=\"_blank\">";
				}
				ret += "<tr>";
				ret += "<td id=\"rname\">" + span + name + "</a></td>";
				ret += "<td id=\"rsize\">" + size + "</td>";
				ret += "<td id=\"rtype\">";
				if(type == "Folder")
					ret += type;
				else
					ret += type.toUpperCase() + " File";
				ret += "</td>";
				ret += "<td id=\"rMTime\">" + mtime + "</td></tr>";
			}
			$("#rtable>tbody").last().append(ret);
		}
        });
}

function onPageLoad() {

	$.ajax({
        	type: "GET",
		async:false,
		url: "file_tree.js?right=/",
		dataType: "script",
		cache: false,
		complete: function(xml) {
			try {
				var tmp = eval(xml.responseText);
			} catch(e) {
				onPageLoad();
				return;
			}
                        if (typeof(tmp) === "undefined")
                                return;

                        var tbody = '<ul class="jqueryFileTree">';

			if (tmp[0]['path'] == "none" && tmp[0]['name'] == "none" && tmp[0]['access'] == "none"){
				tbody += '<li class="warning">None Access Path.</li>';
				document.getElementById("tree_root").innerHTML = tbody;
				return;
			}

                        var len = tmp.length;
                        if (len < 3) {
				tbody += '<li class="warning">None USB Storage Insert.</li>';
				document.getElementById("tree_root").innerHTML = tbody;
                                return;
			}

                        /* Add tbody content */
                        for (var i = 0; i < len-1; i++) {
				if (tmp[i]['name'] == "..")
					continue;
				tbody += '<li id="'+tmp[i]['path']+'" ';
				if (tmp[i]['sub'] == "1") tbody += 'class="tocollapse"';
				tbody +='><a href="#" onClick=ClickFolder("'+tmp[i]['path']+'","'+tmp[i]['access']+'","'+tmp[i]['sub']+'",0);>'+tmp[i]['name']+'</a><span id="'+tmp[i]['path']+'-sub"></span>';
                                totalID++;
                        }
			tbody += '</li></ul>';
			document.getElementById("tree_root").innerHTML = tbody;
		}
	});


	$('#OK').click(function(){
		var path = $("#path").val();
		var filename = $("#filename").val();
		if (path.length == 0 || filename.length == 0) {
			alert("Error Path or filename");
			return;
		}
		var folderpath = path+"/"+filename;
		$.ajax({
			type: "POST",
			url: "apply.cgi",
			data: "folder_path="+folderpath+"&action=create_folder",
			cache: false,
			complete: function(){
				getFolder(path,"1");
				},
			error:function(){}
		});
		$("#filename").val("");

		return;
	});

	$('#Cancel').click(function(){
		$('#filename').val("");
	});

	$(".uploadtab>thead").css("background-color", "#808080");
	$(".uploadtab>tfoot").css("background-color", "#808080");

	document.getElementById("cfolder").disabled = true; 
	document.getElementById("fupload").disabled = true; 

	//time_out();

	var renew = document.getElementById("html_response_message").value;
	if (renew != "")
		expand_tree(renew);
}

function expand_tree(path) {
	var de_path = decodeURIComponent(path).split("/");
	var n_path = "/";
	var en_path = "";
	for (var i=1 ; i < de_path.length-1 ; i++) {
		n_path += de_path[i] + "/";
		en_path = encodeURIComponent(n_path);
                getFolder(en_path,"1","0","1");
	}
}

var time_src="7200";
var time="7200";
function time_out(){
	time=time-1;
	if(time<0){
		window.location.href="login_pic.asp";
		return;
	}
	setTimeout("time_out()",1000);
}

var images = {
"file" 	:	"images/file.png",
"3gp" 	:	"images/film.png",
"avi"	:	"images/film.png",
"mov"	:	"images/film.png",
"mp4"	:	"images/film.png",
"mpg"	:	"images/film.png",
"mpeg"	:	"images/film.png",
"wmv"	:	"images/film.png",
"m4p"	:	"images/music.png",
"mp3"	:	"images/music.png",
"ogg"	:	"images/music.png",
"wav"	:	"images/music.png",
"asp"	:	"images/code.png",
"aspx"	:	"images/code.png",
"c"	:	"images/code.png",
"h"	:	"images/code.png",
"cgi"	:	"images/code.png",
"cpp"	:	"images/code.png",
"vb"	:	"images/code.png",
"xml"	:	"images/code.png",
"css"	:	"images/css.png",
"bat"	:	"images/application.png",
"com"	:	"images/application.png",
"exe"	:	"images/application.png",
"bmp"	:	"images/picture.png",
"gif"	:	"images/picture.png",
"jpg"	:	"images/picture.png",
"jpeg"	:	"images/picture.png",
"png"	:	"images/picture.png",
"pcx"	:	"images/picture.png",
"tif"	:	"images/picture.png",
"tiff"	:	"images/picture.png",
"doc"	:	"images/doc.png",
"docx"	:	"images/doc.png",
"ppt"	:	"images/ppt.png",
"pptx"	:	"images/ppt.png",
"xls"	:	"images/xls.png",
"xlsx"	:	"images/xls.png",
"htm"	:	"images/html.png",
"html"	:	"images/html.png",
"php"	:	"images/php.png",
"jar"	:	"images/java.png",
"js"	:	"images/script.png",
"pl"	:	"images/script.png",
"py"	:	"images/script.png",
"rb"	:	"images/ruby.png",
"rbx"	:	"images/ruby.png",
"ruby"	:	"images/ruby.png",
"rhtml"	:	"images/ruby.png",
"rpm"	:	"images/linux.png",
"pdf"	:	"images/pdf.png",
"psd"	:	"images/psd.png",
"sql"	:	"images/db.png",
"swf"	:	"images/flash.png",
"log"	:	"images/txt.png",
"txt"	:	"images/txt.png",
"zip"	:	"images/zip.png",
"rar"	:	"images/zip.png",
"7z"	:	"images/zip.png",
"gz"	:	"images/zip.png",
"bz2"	:	"images/zip.png"
}
onPageLoad();
</script>
</html>
