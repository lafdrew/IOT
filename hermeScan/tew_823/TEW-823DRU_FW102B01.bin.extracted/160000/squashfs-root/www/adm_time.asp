<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html lang="en-US" xmlns="http://www.w3.org/1999/xhtml" xml:lang="en-US">
<head>
<title>TRENDNET | modelName | Basic | Wireless</title>
<meta http-equiv=Content-Type content="text/html; charset=UTF-8">
<link href="/css/style.css" rel="stylesheet" type="text/css" />
<link href="/css/css_router.css" rel="stylesheet" type="text/css" />
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

<script type="text/javascript">
	var def_title = document.title;
	var model = "<!--# echo model_number -->";
	document.title = def_title.replace("modelName", model);
	var menu = new menuObject();
	var nNow, gTime,nd;
	var submit_button_flag = 0;

////

	var time_daylight_saving_enable = "<!--# echo time_daylight_saving_enable-->";
	var time_daylight_saving_start_month = "<!--# echo time_daylight_saving_start_month-->";
	var time_daylight_saving_start_week = "<!--# echo time_daylight_saving_start_week-->";
	var time_daylight_saving_start_day_of_week = "<!--# echo time_daylight_saving_start_day_of_week-->";
	var time_daylight_saving_start_time = "<!--# echo time_daylight_saving_start_time-->";
	var time_daylight_saving_end_month = "<!--# echo time_daylight_saving_end_month-->";
	var time_daylight_saving_end_week = "<!--# echo time_daylight_saving_end_week-->";
	var time_daylight_saving_end_day_of_week = "<!--# echo time_daylight_saving_end_day_of_week-->";
	var time_daylight_saving_end_time = "<!--# echo time_daylight_saving_end_time-->";	
	var time_daylight_offset = "<!--# echo time_daylight_offset -->";

function show_start(year,month) {

 var week = showWeekDate(year,month);
 var start_md_1st = week.week1.start.split("/");
 var start_md_2st = week.week2.start.split("/");
 var start_md_3st = week.week3.start.split("/");
 var start_md_4st = week.week4.start.split("/");
 var start_md_5st = week.week5.start.split("/");
 if(week.hasOwnProperty("week6"))
   {
 var start_md_6st = week.week6.start.split("/");
}

 var end_md_1st = week.week1.end.split("/");
 var end_md_2st = week.week2.end.split("/");
 var end_md_3st = week.week3.end.split("/");
 var end_md_4st = week.week4.end.split("/");
 var end_md_5st = week.week5.end.split("/");
 if(week.hasOwnProperty("week6"))
   {
 var end_md_6st = week.week6.end.split("/");
}

var st_day=[];
var ed_day=[];
if(time_daylight_saving_start_week =="1"){
st_day=start_md_1st[0];
}else if(time_daylight_saving_start_week =="2"){
st_day=start_md_2st[0];
}else if(time_daylight_saving_start_week =="3"){
st_day=start_md_3st[0];
}else if(time_daylight_saving_start_week =="4"){
st_day=start_md_4st[0];
}else if(time_daylight_saving_start_week =="5"){
st_day=start_md_5st[0];
}else if(time_daylight_saving_start_week =="6"){
st_day=start_md_6st[0];
 }

var day_light_start = ""+time_daylight_saving_start_month+" "+st_day+" "+year+" "+time_daylight_saving_start_time+":"+"00"+":"+"00";

var now = ""+change_mon(nNow.getMonth()) +" "+nNow.getDate() +" "+nNow.getFullYear() + " " +len_checked(nNow.getHours())+ ":" +len_checked(nNow.getMinutes())+ ":" +len_checked(nNow.getSeconds());

var d_s_time = Date.parse(day_light_start);
var n_s_time = Date.parse(now);

if(n_s_time > d_s_time){

var n_time;

n_time = new Date(n_s_time + (3600000*time_daylight_offset/3600));

var test = n_time.toString();

var time = test.split(" ");

var gg=[];

if(time[0]=="Mon"){
gg=time[0].replace("Mon","1");
}
else if(time[0]=="Tue"){
gg=time[0].replace("Tue","2");
}
else if(time[0]=="Wed"){
gg=time[0].replace("Wed","3");
}
else if(time[0]=="Thu"){
gg=time[0].replace("Thu","4");
}
else if(time[0]=="Fri"){
gg=time[0].replace("Fri","5");
}
else if(time[0]=="Sat"){
gg=time[0].replace("Sat","6");
}
else if(time[0]=="Sun"){
gg=time[0].replace("Sun","7");
}

var tt=[];

if(time[1]=="Jan"){
tt=time[1].replace("Jan","1");
}else if(time[1]=="Feb"){
tt=time[1].replace("Feb","2");
}else if(time[1]=="Mar"){
tt=time[1].replace("Mar","3");
}else if(time[1]=="Apr"){
tt=time[1].replace("Apr","4");
}else if(time[1]=="May"){
tt=time[1].replace("May","5");
}else if(time[1]=="Jun"){
tt=time[1].replace("Jun","6");
}else if(time[1]=="Jul"){
tt=time[1].replace("Jul","7");
}else if(time[1]=="Aug"){
tt=time[1].replace("Aug","8");
}else if(time[1]=="Sep"){
tt=time[1].replace("Sep","9");
}else if(time[1]=="Oct"){
tt=time[1].replace("Oct","10");
}else if(time[1]=="Nov"){
tt=time[1].replace("Nov","11");
}else if(time[1]=="Dec"){
tt=time[1].replace("Dec","12");
}

var QQ=[];

//QQ = time[4].split(":");

		//nNow = new Date(time[3],tt-1,time[2],QQ[0],QQ[1],QQ[2]); 
              if(time[3].length > 4){

             QQ = time[3].split(":");
             
             		nNow = new Date(time[5],tt-1,time[2],QQ[0],QQ[1],QQ[2]); 
              }else{

             QQ = time[4].split(":");
             
             		nNow = new Date(time[3],tt-1,time[2],QQ[0],QQ[1],QQ[2]); 
             
             }



}
}

function show_end(year,month) {

 var week = showWeekDate(year,month);
 var start_md_1st = week.week1.start.split("/");
 var start_md_2st = week.week2.start.split("/");
 var start_md_3st = week.week3.start.split("/");
 var start_md_4st = week.week4.start.split("/");
 var start_md_5st = week.week5.start.split("/");
 if(week.hasOwnProperty("week6"))
   {
 var start_md_6st = week.week6.start.split("/");
}

 var end_md_1st = week.week1.end.split("/");
 var end_md_2st = week.week2.end.split("/");
 var end_md_3st = week.week3.end.split("/");
 var end_md_4st = week.week4.end.split("/");
 var end_md_5st = week.week5.end.split("/");
 if(week.hasOwnProperty("week6"))
   {
 var end_md_6st = week.week6.end.split("/");
}

var st_day=[];
var ed_day=[];


if(time_daylight_saving_start_week =="1"){
st_day=start_md_1st[0];
}else if(time_daylight_saving_start_week =="2"){
st_day=start_md_2st[0];
}else if(time_daylight_saving_start_week =="3"){
st_day=start_md_3st[0];
}else if(time_daylight_saving_start_week =="4"){
st_day=start_md_4st[0];
}else if(time_daylight_saving_start_week =="5"){
st_day=start_md_5st[0];
}else if(time_daylight_saving_start_week =="6"){
st_day=start_md_6st[0];
 }


if(time_daylight_saving_end_week =="1"){
ed_day=end_md_1st[0];
}else if(time_daylight_saving_end_week =="2"){
ed_day=end_md_2st[0];
}else if(time_daylight_saving_end_week =="3"){
ed_day=end_md_3st[0];
}else if(time_daylight_saving_end_week =="4"){
ed_day=end_md_4st[0];
}else if(time_daylight_saving_end_week =="5"){
ed_day=end_md_5st[0];
}else if(time_daylight_saving_end_week =="6"){
ed_day=end_md_6st[0];
}


var day_light_end = ""+time_daylight_saving_end_month+" "+ed_day+" "+year+" "+time_daylight_saving_end_time+":"+"00"+":"+"00";

var now = ""+change_mon(nNow.getMonth()) +" "+nNow.getDate() +" "+nNow.getFullYear() + " " +len_checked(nNow.getHours())+ ":" +len_checked(nNow.getMinutes())+ ":" +len_checked(nNow.getSeconds());

var e_s_time = Date.parse(day_light_end);
var n_s_time = Date.parse(now);

if(n_s_time > e_s_time){


var n_time;

n_time = new Date(n_s_time - (3600000*time_daylight_offset/3600));


var test = n_time.toString();

var time = test.split(" ");

var gg=[];

if(time[0]=="Mon"){
gg=time[0].replace("Mon","1");
}
else if(time[0]=="Tue"){
gg=time[0].replace("Tue","2");
}
else if(time[0]=="Wed"){
gg=time[0].replace("Wed","3");
}
else if(time[0]=="Thu"){
gg=time[0].replace("Thu","4");
}
else if(time[0]=="Fri"){
gg=time[0].replace("Fri","5");
}
else if(time[0]=="Sat"){
gg=time[0].replace("Sat","6");
}
else if(time[0]=="Sun"){
gg=time[0].replace("Sun","7");
}

var tt=[];

if(time[1]=="Jan"){
tt=time[1].replace("Jan","1");
}else if(time[1]=="Feb"){
tt=time[1].replace("Feb","2");
}else if(time[1]=="Mar"){
tt=time[1].replace("Mar","3");
}else if(time[1]=="Apr"){
tt=time[1].replace("Apr","4");
}else if(time[1]=="May"){
tt=time[1].replace("May","5");
}else if(time[1]=="Jun"){
tt=time[1].replace("Jun","6");
}else if(time[1]=="Jul"){
tt=time[1].replace("Jul","7");
}else if(time[1]=="Aug"){
tt=time[1].replace("Aug","8");
}else if(time[1]=="Sep"){
tt=time[1].replace("Sep","9");
}else if(time[1]=="Oct"){
tt=time[1].replace("Oct","10");
}else if(time[1]=="Nov"){
tt=time[1].replace("Nov","11");
}else if(time[1]=="Dec"){
tt=time[1].replace("Dec","12");
}

var QQ=[];

//QQ = time[4].split(":");

		//nNow = new Date(time[3],tt-1,time[2],QQ[0],QQ[1],QQ[2]); 
              if(time[3].length > 4){

             QQ = time[3].split(":");
             
             		nNow = new Date(time[5],tt-1,time[2],QQ[0],QQ[1],QQ[2]); 
              }else{

             QQ = time[4].split(":");
             
             		nNow = new Date(time[3],tt-1,time[2],QQ[0],QQ[1],QQ[2]); 
             
             }

}



}

function showWeekDate(year,month)
{ 
 var date = new Date();
 if (year.length > 0 && month.length > 0 ) 
  {
  date = new Date(year,month-1,1);
  } else {
  date = new Date(date.getFullYear(),date.getMonth(),1);
  }
  
 var week = new Object;
 week.week1 = new Object;
 week.week2 = new Object;
 week.week3 = new Object;
 week.week4 = new Object;
 week.week5 = new Object;
 
 week.today = date.getDay();
 if (week.today == 0) 
 {
  date.setDate(date.getDate()+1);
  week.today = date.getDay();
 }
 

 week.week1.workDays = 5-week.today+1;
 if (week.week1.workDays<0) week.week1.workDays=0;

 week.week1.start = date.getDate()+"/"+(date.getMonth()+1);

 date.setDate(date.getDate()+(1+week.week1.workDays));
 week.week1.end = date.getDate()+"/"+(date.getMonth()+1);

 date.setDate(date.getDate()+1);
 week.week2.workDays = 5;
 week.week2.start = date.getDate()+"/"+(date.getMonth()+1);

 date.setDate(date.getDate()+(1+week.week2.workDays));
 week.week2.end = date.getDate()+"/"+(date.getMonth()+1);

 date.setDate(date.getDate()+1);
 week.week3.workDays = 5;
 week.week3.start = date.getDate()+"/"+(date.getMonth()+1);

 date.setDate(date.getDate()+(1+week.week3.workDays));
 week.week3.end = date.getDate()+"/"+(date.getMonth()+1);

 date.setDate(date.getDate()+1);
 week.week4.workDays = 5;
 week.week4.start = date.getDate()+"/"+(date.getMonth()+1);

 date.setDate(date.getDate()+(1+week.week4.workDays));
 week.week4.end = date.getDate()+"/"+(date.getMonth()+1);


 date.setDate(date.getDate()+1);
 week.week5.start = date.getDate()+"/"+(date.getMonth()+1);
 

        var nextMonth = new Date(date.getFullYear(),date.getMonth()+1,1);
 var monthLastDay = new Date(nextMonth-86400000); 
 
 date.setDate(date.getDate()+6);
      if (date <= monthLastDay)
 {
  week.week5.workDays = 5;
  week.week5.end = date.getDate()+"/"+(date.getMonth()+1); 
  if (date < monthLastDay) {
   week.week6 = new Object;
   date.setDate(date.getDate()+1);
   week.week6.start = date.getDate()+"/"+(date.getMonth()+1);
   week.week6.end = monthLastDay.getDate()+"/"+(date.getMonth()+1);
   week.week6.workDays = monthLastDay.getDay();
  }
 } else {
  week.week5.end = monthLastDay.getDate()+"/"+(monthLastDay.getMonth()+1);
  week.week5.workDays = monthLastDay.getDay();
  if (week.week5.workDays >5 ) week.week5.workDays = 5;   
 }

 return week;
}


function check_daylight_saving(){

                     d = new Date();

                     var test_year = ""+d.getFullYear()+"";

                     show_start(test_year,time_daylight_saving_start_month);

                     show_end(test_year,time_daylight_saving_end_month);

}

////
function get_time(){


var time_zone_area ="<!--# echo time_zone_area-->";
var time_zone = "<!--# echo time_zone-->"

var ntp_client ="<!--# echo ntp_client_enable-->";


      d = new Date();

       var offset;

	if (gTime){
		return;
	}

//if(ntp_client==1){
offset = (parseInt(time_zone)* 3.75)/60;

/*
if(time_zone_area=="0"){
offset=-12;
}else if(time_zone_area=="1"){
offset=-11;
}else if(time_zone_area=="2"){
offset=-10;
}else if(time_zone_area=="3"){
offset=-9;
}else if(time_zone_area=="4"){
offset=-8;
}else if(time_zone_area=="5"){
offset=-7;
}else if(time_zone_area=="6"){
offset=-7;
}else if(time_zone_area=="7"){
offset=-7;
}else if(time_zone_area=="8"){
offset=-6;
}else if(time_zone_area=="9"){
offset=-6;
}else if(time_zone_area=="10"){
offset=-6;
}else if(time_zone_area=="11"){
offset=-6;
}else if(time_zone_area=="12"){
offset=-5;
}else if(time_zone_area=="13"){
offset=-5;
}else if(time_zone_area=="14"){
offset=-4.5;
}else if(time_zone_area=="15"){
offset=-4;
}else if(time_zone_area=="16"){
offset=-4;
}else if(time_zone_area=="17"){
offset=-4;
}else if(time_zone_area=="18"){
offset=-3.5;
}else if(time_zone_area=="19"){
offset=-3;
}else if(time_zone_area=="20"){
offset=-3;
}else if(time_zone_area=="21"){
offset=-3;
}else if(time_zone_area=="22"){
offset=-2;
}else if(time_zone_area=="23"){
offset=-1;
}else if(time_zone_area=="24"){
offset=-1;
}else if(time_zone_area=="25"){
offset=0;
}else if(time_zone_area=="26"){
offset=0;
}else if(time_zone_area=="27"){
offset=+1;
}else if(time_zone_area=="28"){
offset=+1;
}else if(time_zone_area=="29"){
offset=+1;
}else if(time_zone_area=="30"){
offset=+1;
}else if(time_zone_area=="31"){
offset=+1;
}else if(time_zone_area=="32"){
offset=+2;
}else if(time_zone_area=="33"){
offset=+2;
}else if(time_zone_area=="34"){
offset=+2;
}else if(time_zone_area=="35"){
offset=+2;
}else if(time_zone_area=="36"){
offset=+2;
}else if(time_zone_area=="37"){
offset=+2;
}else if(time_zone_area=="38"){
offset=+3;
}else if(time_zone_area=="39"){
offset=+3;
}else if(time_zone_area=="40"){
offset=+3;
}else if(time_zone_area=="41"){
offset=+3.5;
}else if(time_zone_area=="42"){
offset=+4;
}else if(time_zone_area=="43"){
offset=+4;
}else if(time_zone_area=="44"){
offset=+4;
}else if(time_zone_area=="45"){
offset=+4.5;
}else if(time_zone_area=="46"){
offset=+5;
}else if(time_zone_area=="47"){
offset=+5.5;
}else if(time_zone_area=="48"){
offset=+5.5;
}else if(time_zone_area=="49"){
offset=+5.75;
}else if(time_zone_area=="50"){
offset=+6;
}else if(time_zone_area=="51"){
offset=+6;
}else if(time_zone_area=="52"){
offset=+6.5;
}else if(time_zone_area=="53"){
offset=+7;
}else if(time_zone_area=="54"){
offset=+7;
}else if(time_zone_area=="55"){
offset=+8;
}else if(time_zone_area=="56"){
offset=+8;
}else if(time_zone_area=="57"){
offset=+8;
}else if(time_zone_area=="58"){
offset=+8;
}else if(time_zone_area=="59"){
offset=+8;
}else if(time_zone_area=="60"){
offset=+8;
}else if(time_zone_area=="61"){
offset=+9;
}else if(time_zone_area=="62"){
offset=+9;
}else if(time_zone_area=="63"){
offset=+9;
}else if(time_zone_area=="64"){
offset=+9.5;
}else if(time_zone_area=="65"){
offset=+9.5;
}else if(time_zone_area=="66"){
offset=+10;
}else if(time_zone_area=="67"){
offset=+10;
}else if(time_zone_area=="68"){
offset=+10;
}else if(time_zone_area=="69"){
offset=+10;
}else if(time_zone_area=="70"){
offset=+10;
}else if(time_zone_area=="71"){
offset=+11;
}else if(time_zone_area=="72"){
offset=+11;
}else if(time_zone_area=="73"){
offset=+12;
}else if(time_zone_area=="74"){
offset=+12;
}else if(time_zone_area=="75"){
offset=+12;
}else if(time_zone_area=="76"){
offset=+13;
}else if(time_zone_area=="77"){
offset=+13;
}
*/
		gTime = "<!--# exec cgi /bin/date +%s-->";

		var teste ;

		var router_tz = "<!--# exec cgi /bin/date +%z-->";
		var router_tz_offset_sign = router_tz.substring(0,1);
		var router_tz_offset_hour = parseInt(router_tz_offset_sign + router_tz.substring(1,3), 10);
		var router_tz_offset_min = parseInt(router_tz_offset_sign + router_tz.substring(3), 10);
		var router_tz_offset = (router_tz_offset_hour*60) + router_tz_offset_min;

		var teste = gTime * 1000 + (d.getTimezoneOffset() * 60000);
		
	 if(time_daylight_saving_enable =="1"){
  	       	
  	       	nd = new Date(teste + (60000*router_tz_offset));
	}else{
              	nd = new Date(teste + (3600000*offset));
 	}
 	
var test = nd.toString();

var time = test.split(" ");

var gg=[];

if(time[0]=="Mon"){
gg=time[0].replace("Mon","1");
}
else if(time[0]=="Tue"){
gg=time[0].replace("Tue","2");
}
else if(time[0]=="Wed"){
gg=time[0].replace("Wed","3");
}
else if(time[0]=="Thu"){
gg=time[0].replace("Thu","4");
}
else if(time[0]=="Fri"){
gg=time[0].replace("Fri","5");
}
else if(time[0]=="Sat"){
gg=time[0].replace("Sat","6");
}
else if(time[0]=="Sun"){
gg=time[0].replace("Sun","7");
}

var tt=[];
if(time[1]=="Jan"){
tt=time[1].replace("Jan","1");
}else if(time[1]=="Feb"){
tt=time[1].replace("Feb","2");
}else if(time[1]=="Mar"){
tt=time[1].replace("Mar","3");
}else if(time[1]=="Apr"){
tt=time[1].replace("Apr","4");
}else if(time[1]=="May"){
tt=time[1].replace("May","5");
}else if(time[1]=="Jun"){
tt=time[1].replace("Jun","6");
}else if(time[1]=="Jul"){
tt=time[1].replace("Jul","7");
}else if(time[1]=="Aug"){
tt=time[1].replace("Aug","8");
}else if(time[1]=="Sep"){
tt=time[1].replace("Sep","9");
}else if(time[1]=="Oct"){
tt=time[1].replace("Oct","10");
}else if(time[1]=="Nov"){
tt=time[1].replace("Nov","11");
}else if(time[1]=="Dec"){
tt=time[1].replace("Dec","12");
}

var QQ=[];

//QQ = time[4].split(":");

		//nNow = new Date(time[3],tt-1,time[2],QQ[0],QQ[1],QQ[2]); 
              if(time[3].length > 4){

             QQ = time[3].split(":");
             
             		nNow = new Date(time[5],tt-1,time[2],QQ[0],QQ[1],QQ[2]); 
              }else{

             QQ = time[4].split(":");
             
             		nNow = new Date(time[3],tt-1,time[2],QQ[0],QQ[1],QQ[2]); 
             
             }

//}
//else
//{
/*
		gTime = "<!--# exec cgi /bin/system_time get -->";
		var time = gTime.split("/");

		nNow = new Date(time[0],time[1]-1,time[2],time[3],time[4],time[5]); // Date type's month define 0~11
*/




/*
		gTime = "<!--# exec cgi /bin/date +%s-->";
                
              var teste = gTime * 1000  + (d.getTimezoneOffset() * 60000);


              var l_offset = (-(d.getTimezoneOffset()/60));


              nd = new Date(teste + (3600000*(l_offset)));
 
             var test = nd.toString();

             var time = test.split(" ");

             var gg=[];

             if(time[0]=="Mon"){
             gg=time[0].replace("Mon","1");
             }
             else if(time[0]=="Tue"){
             gg=time[0].replace("Tue","2");
             }
             else if(time[0]=="Wed"){
             gg=time[0].replace("Wed","3");
             }
             else if(time[0]=="Thu"){
             gg=time[0].replace("Thu","4");
             }
             else if(time[0]=="Fri"){
             gg=time[0].replace("Fri","5");
             }
             else if(time[0]=="Sat"){
             gg=time[0].replace("Sat","6");
             }
             else if(time[0]=="Sun"){
             gg=time[0].replace("Sun","7");
             }
             
             var tt=[];
             
             if(time[1]=="Jan"){
             tt=time[1].replace("Jan","1");
             }else if(time[1]=="Feb"){
             tt=time[1].replace("Feb","2");
             }else if(time[1]=="Mar"){
             tt=time[1].replace("Mar","3");
             }else if(time[1]=="Apr"){
             tt=time[1].replace("Apr","4");
             }else if(time[1]=="May"){
             tt=time[1].replace("May","5");
             }else if(time[1]=="Jun"){
             tt=time[1].replace("Jun","6");
             }else if(time[1]=="Jul"){
             tt=time[1].replace("Jul","7");
             }else if(time[1]=="Aug"){
             tt=time[1].replace("Aug","8");
             }else if(time[1]=="Sep"){
             tt=time[1].replace("Sep","9");
             }else if(time[1]=="Oct"){
             tt=time[1].replace("Oct","10");
             }else if(time[1]=="Nov"){
             tt=time[1].replace("Nov","11");
             }else if(time[1]=="Dec"){
             tt=time[1].replace("Dec","12");
             }
             
             var QQ=[];
             
             QQ = time[4].split(":");
             
             		nNow = new Date(time[3],tt-1,time[2],QQ[0],QQ[1],QQ[2]); 
             
             
             }
             /*
             	gTime = objTime.curLocTime;
             	var time = gTime.split(",");
             	gTime = month_device[time[1]-1] + " " + time[2] + ", " + time[0] + " " + time[3] + ":" + time[4] + ":" + time[5];		
             	nNow = new Date(gTime);
             */	
             
/////

//if(time_daylight_saving_enable =="1"){

  //     check_daylight_saving();
    //   	offerset = "<!--# exec cgi /bin/date +%z-->";
                

//}

////

}


function STime(){

	nNow.setTime(nNow.getTime() + 1000);



	//new Date(yr_num, mo_num, day_num, hr_num, min_num, sec_num)
	//var date = new Date();
	var fulldate = ' '+change_week(nNow.getDay()) +' '+change_mon(nNow.getMonth()) +', '+nNow.getDate() +', '+nNow.getFullYear()
				+ ' ' +len_checked(nNow.getHours())+ ':' +len_checked(nNow.getMinutes())+ ':' +len_checked(nNow.getSeconds());
	$("#show_systime").html(fulldate);

	setTimeout('STime()', 1000);


}

function check_value(){
	if($('#enableNTP').attr('checked') && $('#NTPServerIP').val() == ''){
		//alert("Please enter NTP Server");
		alert(get_words('YM185'));
		return false;
	}
	return true;
}
function check_apply(){
	if(check_value()){
		var dat = '';
		var year = $('#manual_year_select').val();
		var mon = $('#manual_month_select').val();
		var day = $('#manual_day_select').val();
		var hour = $('#manual_hour_select').val();
		var minu = $('#manual_min_select').val();
		var sec = $('#manual_sec_select').val();

              var check_week = new Date();

              var Local_offset = check_week.getTimezoneOffset();
      
              var today =  check_week.getDay();

              var get_week = "";

                if(today =="0"){
                  get_week = "Sun"; 
                }else if(today == "1"){
                  get_week = "Mon";
                }else if(today == "2"){ 
                  get_week = "Tue";
                }else if(today == "3"){ 
                   get_week = "Wed";
                }else if(today == "4"){ 
                   get_week = "Thu";
                }else if(today == "5"){ 
                   get_week = "Fri";
                }else if(today == "6"){ 
                  get_week = "Sat";
                  }


              var get_mon ="";

                if(mon =="1"){
                  get_mon = "Jan"; 
                }else if(mon == "2"){
                  get_mon = "Feb";
                }else if(mon == "3"){ 
                  get_mon = "Mar";
                }else if(mon == "4"){ 
                  get_mon = "Apr";
                }else if(mon == "5"){ 
                  get_mon = "May";
                }else if(mon == "6"){ 
                  get_mon = "Jun";
                }else if(mon == "7"){ 
                  get_mon = "Jul";
                }else if(mon == "8"){
                  get_mon = "Aug";
                }else if(mon == "9"){ 
                  get_mon = "Sep";
                }else if(mon == "10"){ 
                  get_mon = "Oct";
                }else if(mon == "11"){ 
                  get_mon = "Nov";
                }else if(mon == "12"){ 
                  get_mon = "Dec";
                }

              var new_time = get_week +" " + get_mon  +" "+day +" " + hour +":"+ minu +":"+ sec +" " +year;


              var ntime;

              var c_time = Date.parse(new_time);
                
                 
              ntime = new Date(c_time + (60000*Local_offset));


              var time_str = ntime.toString();

              var cut_time = time_str.split(" ");

              var m_time=[];

              m_time = cut_time[4].split(":");

              var last_mon="";
               
                if(cut_time[1] =="Jan"){
                  last_mon = "1"; 
                }else if(cut_time[1] == "Feb"){
                  last_mon = "2";
                }else if(cut_time[1] == "Mar"){ 
                  last_mon = "3";
                }else if(cut_time[1] == "Apr"){ 
                  last_mon = "4";
                }else if(cut_time[1] == "May"){ 
                  last_mon = "5";
                }else if(cut_time[1] == "Jun"){ 
                  last_mon = "6";
                }else if(cut_time[1] == "Jul"){ 
                  last_mon = "7";
                }else if(cut_time[1] == "Aug"){
                  last_mon = "8";
                }else if(cut_time[1] == "Sep"){ 
                  last_mon = "9";
                }else if(cut_time[1] == "Oct"){ 
                  last_mon = "10";
                }else if(cut_time[1] == "Nov"){ 
                  last_mon = "11";
                }else if(cut_time[1] == "Dec"){ 
                  last_mon = "12";
                }


    
		var dat = cut_time[3] +"/"+ last_mon +"/"+ cut_time[2] +"/"+ m_time[0] +"/"+ m_time[1] +"/"+ m_time[2];


		var obj = new ccpObject();
		obj.set_param_url('apply.cgi');
		obj.set_ccp_act('set');
		obj.add_param_event('timeset');
		obj.set_param_next_page('adm_time.asp');
		obj.add_param_arg('reboot_type', 'application');
		obj.add_param_arg('system_time',dat);
		obj.add_param_arg('time_daylight_saving_enable',get_checked_value(get_by_id("DSTenable")));
		obj.add_param_arg('time_zone_area',get_by_id("time_zone").selectedIndex);				
		obj.add_param_arg('time_zone', $('#time_zone').val());				
		
		//if(get_by_id("DSTenable").checked){
			get_by_id("time_daylight_saving_start_month").value = get_by_id("tz_daylight_start_month_select").value;
			get_by_id("time_daylight_saving_start_week").value = get_by_id("tz_daylight_start_week_select").value;
			get_by_id("time_daylight_saving_start_day_of_week").value = get_by_id("tz_daylight_start_dayweek_select").value;
			get_by_id("time_daylight_saving_start_time").value = get_by_id("tz_daylight_start_time_select").value;
			get_by_id("time_daylight_saving_end_month").value = get_by_id("tz_daylight_end_month_select").value;
			get_by_id("time_daylight_saving_end_week").value = get_by_id("tz_daylight_end_week_select").value;
			get_by_id("time_daylight_saving_end_day_of_week").value = get_by_id("tz_daylight_end_dayweek_select").value;
			get_by_id("time_daylight_saving_end_time").value = get_by_id("tz_daylight_end_time_select").value;		
			
			obj.add_param_arg('time_daylight_saving_start_month',$("#tz_daylight_start_month_select").val());				
			obj.add_param_arg('time_daylight_saving_start_week',$("#tz_daylight_start_week_select").val());				
			obj.add_param_arg('time_daylight_saving_start_day_of_week',$("#tz_daylight_start_dayweek_select").val());				
			obj.add_param_arg('time_daylight_saving_start_time',$("#tz_daylight_start_time_select").val());				
			obj.add_param_arg('time_daylight_saving_end_month',$("#tz_daylight_end_month_select").val());				
			obj.add_param_arg('time_daylight_saving_end_week',$("#tz_daylight_end_week_select").val());				
			obj.add_param_arg('time_daylight_saving_end_day_of_week',$("#tz_daylight_end_dayweek_select").val());				
			obj.add_param_arg('time_daylight_saving_end_time',$("#tz_daylight_end_time_select").val());				
			
		//}

		get_by_id("ntp_client_enable").value = get_checked_value(get_by_id("enableNTP"));	
		obj.add_param_arg('ntp_client_enable',get_checked_value(get_by_id("enableNTP")));
		var time_type = get_by_id("enableNTP");
		get_by_id("ntp_sync_interval").value = get_by_id("NTPSync").value;		
		get_by_id("time_daylight_offset").value = get_by_id("DSToffset").value;		
		get_by_id("ntp_server").value = get_by_id("NTPServerIP").value;		
		obj.add_param_arg('ntp_sync_interval',$("#NTPSync").val());				
		obj.add_param_arg('time_daylight_offset',$("#DSToffset").val());				
		obj.add_param_arg('ntp_server',$("#NTPServerIP").val());						

		var paramForm = obj.get_param();
		totalWaitTime = 5; //second
		redirectURL = location.pathname;
		wait_page();
		jq_ajax_post(paramForm.url, paramForm.arg);

/*
		if(submit_button_flag == 0){
			submit_button_flag = 1;
			return true;
		}else{
			return false;
		}
		*/
		
	}
}


function setValueSystemTime(){
	get_time();
	STime();
}


function setValueEnableDaylightSaving(){
	var tmp_time_daylight_saving_enable = "<!--# echo time_daylight_saving_enable -->";
	$('#DSTenable').attr('checked', (tmp_time_daylight_saving_enable=='1'?true:false));
}


function setEventEnableDaylightSaving(){
	var func = function(){
		var chk_ds = $('#DSTenable').attr('checked')
		if(chk_ds){
			$('#DSToffsetField').show();
			$('#DSTdateField').show();
		}
		else{
			$('#DSToffsetField').hide();
			$('#DSTdateField').hide();
		}
	};
	func();
	
	$('#DSTenable').change(func);
}
function setValueDaylightSavingOffset(){
	//var val_offset = objTime.dlSavOffset;
	//$('#DSToffset').val(val_offset);
}
function setValueDaylightSavingDates(){
	/*
	** Date:	2013-03-27
	** Author:	Moa Chung
	** Reason: 	for our datamodel use week and dayofweek to handle day light saving.
	**/
	setValueDSTStartMonth();
//	setValueDSTStartDay();
	setValueDSTStartWeek();
	setValueDSTStartDayWeek();
	setValueDSTStartHour();
	setValueDSTEndMonth();
//	setValueDSTEndDay();
	setValueDSTEndWeek();
	setValueDSTEndDayWeek();
	setValueDSTEndHour();
}

function set_month_list(){
	for(var i = 0; i < month.length; i++){
		document.write("<option value=" + (i+1) + " >" + month[i] + "</option>");
	}
}


function set_seq_list(m_name) {
	var s_name;
  var temp_time = "<!--# exec cgi /bin/date +%Y/%m/%d/%H/%M/%S -->";
  var Dtime = temp_time.split("/");
  var year = parseInt(Dtime[0]);
  var mon = get_by_id(m_name).selectedIndex + 1;
  var day = getDaysInMonth(mon,year);
  var selectDate = new Date(year,mon-1,day);
  var firstDateOfSelectVear = new Date(year,mon-1,1);
  var weekNumber = Math.ceil((((selectDate - firstDateOfSelectVear)/86400000) + (firstDateOfSelectVear.getDay()+1))/7);

	if(m_name == "tz_daylight_start_month_select") 
		s_name = "tz_daylight_start_week_select";
	else if (m_name == "tz_daylight_end_month_select")
		s_name = "tz_daylight_end_week_select";
	                    
  for(var i=0; i<weekNumber;i++) {
      get_by_id(s_name).options[i] = new Option(sequence[i]);
      get_by_id(s_name).length=weekNumber;
			get_by_id(s_name).options[i].value = i+1;
  }
 			set_week_list(s_name); 
}

function set_week_list(s_name){
	var m_name,w_name;
	var temp_time = "<!--# exec cgi /bin/date +%Y/%m/%d/%H/%M/%S -->";
  var Dtime = temp_time.split("/");
  var year = parseInt(Dtime[0]);

	if(s_name == "tz_daylight_start_week_select") {
		m_name = "tz_daylight_start_month_select";
		w_name = "tz_daylight_start_dayweek_select";
	} else if (s_name = "tz_daylight_end_week_select") {
		m_name = "tz_daylight_end_month_select";
		w_name = "tz_daylight_end_dayweek_select";
}

    var mon = get_by_id(m_name).selectedIndex + 1;
    var weeknumber = get_by_id(s_name).selectedIndex + 1;
    var week_length = get_by_id(s_name).length;

    var selectDate,day,week,index=0;
    if(weeknumber == 1){
             selectDate = new Date(year,mon-1,1); 
             index = selectDate.getDay();
             week = 7 - index;

    } else if (weeknumber == week_length) {
             day = getDaysInMonth(mon,year);
             selectDate = new Date(year,mon-1,day);
             week = selectDate.getDay()+1;
    } else {
            week = 7;
    }
    
    for(var i=0; i<week;i++) {
			get_by_id(w_name).options[i] = new Option(Week[i+index]);
      get_by_id(w_name).length=i+1;
			get_by_id(w_name).options[i].value=i+index+1;
    }
}

function setValueDSTStartMonth(){
	set_selectIndex("<!--# echo time_daylight_saving_start_month -->", get_by_id("tz_daylight_start_month_select"));
	set_seq_list("tz_daylight_start_month_select");
}


function setValueDSTStartDay(){
	//var chk_ds = objTime.dlSavDDStart;
	//$('#tz_daylight_start_day_select').val(chk_ds);
}


function setValueDSTStartWeek(){
	set_selectIndex("<!--# echo time_daylight_saving_start_week -->", get_by_id("tz_daylight_start_week_select"));
	set_week_list("tz_daylight_start_week_select");
}


function setValueDSTStartDayWeek(){
	set_selectIndex("<!--# echo time_daylight_saving_start_day_of_week -->", get_by_id("tz_daylight_start_dayweek_select"));
}


function setValueDSTStartHour(){
	set_selectIndex("<!--# echo time_daylight_saving_start_time -->", get_by_id("tz_daylight_start_time_select"));
}


function setValueDSTEndMonth(){
	set_selectIndex("<!--# echo time_daylight_saving_end_month -->", get_by_id("tz_daylight_end_month_select"));
	set_seq_list("tz_daylight_end_month_select");
}
function setValueDSTEndDay(){
	//var chk_de = objTime.dlSavDDEnd;
	//$('#tz_daylight_end_day_select').val(chk_de);
}
function setValueDSTEndWeek(){
	set_selectIndex("<!--# echo time_daylight_saving_end_week -->", get_by_id("tz_daylight_end_week_select"));
	set_week_list("tz_daylight_end_week_select");
}
function setValueDSTEndDayWeek(){
	set_selectIndex("<!--# echo time_daylight_saving_end_day_of_week -->", get_by_id("tz_daylight_end_dayweek_select"));
}
function setValueDSTEndHour(){
	set_selectIndex("<!--# echo time_daylight_saving_end_time -->", get_by_id("tz_daylight_end_time_select"));
}
function setValueEnableNTPServer(){
	var chk_enable = "<!--# echo ntp_client_enable -->";
	$('#enableNTP').attr('checked', (chk_enable=='1'?true:false));
}
function setEventEnableNTPServer(){
	var func = function(){
		var chk_enable = $('#enableNTP').attr('checked');
		if(chk_enable){
			$('#ntpServerField').show();
			$('#TimeZoneField').show();
			$('#ntpSyncField').show();
			$('#manualField').hide();
		}
		else{
			$('#ntpServerField').hide();
			$('#TimeZoneField').hide();
			$('#ntpSyncField').hide();
			$('#manualField').show();
		}
	};
	func();
	$('#enableNTP').change(func);
}
function setValueNTPServer(){
	var val_serv = "<!--# echo ntp_server -->";
	$('#NTPServerIP').val(val_serv);
}
function setValueTimeZone(){
	get_by_id("time_zone").selectedIndex = get_by_id("time_zone_area").value;
}
function setValueNTPSynchronization(){
	var val_sync = "<!--# echo ntp_sync_interval -->";
	$('#NTPSync').val(val_sync);
}
function setValueDateAndTime(){
	var datetime= new Date();
	var curLocalTime = datetime.getFullYear() +"/"+ (datetime.getMonth()+1) + "/" + datetime.getDate() + "/" +
			datetime.getHours() + "/" + datetime.getMinutes() + "/" + datetime.getSeconds();
	var dat = curLocalTime.split('/');
	if (dat != null) {
		var i=0;
		$('#manual_year_select').val(dat[i++]);
		$('#manual_month_select').val(dat[i++]);
		$('#manual_day_select').val(dat[i++]);
		$('#manual_hour_select').val(dat[i++]);
		$('#manual_min_select').val(dat[i++]);
		$('#manual_sec_select').val(dat[i++]);
	}
}
$(function(){
	get_by_id("apply_2nd_cgi_parameter").value = "";
	get_by_id("apply_2nd_cgi").value = "";
	
	var val_offset = "<!--# echo time_daylight_offset -->";
	$('#DSToffset').val(val_offset);
	
	//Time Configuration
	setValueSystemTime();
	
	//Daylight Saving Time
	setValueEnableDaylightSaving();
	setEventEnableDaylightSaving();
	setValueDaylightSavingOffset();
	setValueDaylightSavingDates();
	
	//NTP Settings
	setValueEnableNTPServer();
	setEventEnableNTPServer();
	setValueNTPServer();
	setValueTimeZone();
	setValueNTPSynchronization();
	
	//Date and Time Settings
	setValueDateAndTime();
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
			<td><img src="/image/bg_topr.gif" width="680" height="7" /></td>
		</tr>
		<!-- End of upper frame -->

		<tr>
			<!-- left menu -->
			<td style="background-image:url('/image/bg_l.gif');background-repeat:repeat-y;vertical-align:top;" width="270">
				<div style="padding-left:6px;">
				<script>document.write(menu.build_structure(1,0,5))</script>
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
								<div class="headerbg" id="manTimeSettingTitle">
								<script>show_words('_time_setting');</script>
								</div>
								<div class="hr"></div>
								<div class="section_content_border">
								<div class="header_desc" id="manTimeSettingIntruduction">
									<script>show_words('_TIME_DESC');</script>
									<p></p>
								</div>
								
								<form id="form1" name="form1" method="post" action=apply.cgi>
									<input type="hidden" id="html_response_page" name="html_response_page" value="adm_time.asp">
									<input type="hidden" id="html_response_message" name="html_response_message" value=""><script>get_by_id("html_response_message").value = get_words('sc_intro_sv');</script>
									<input type="hidden" id="html_response_return_page" name="html_response_return_page" value="adm_time.asp">
									<input type="hidden" id="apply_2nd_cgi" name="apply_2nd_cgi" value="">
									<input type="hidden" id="apply_2nd_cgi_parameter" name="apply_2nd_cgi_parameter" value="">
									<input type="hidden" id="system_time" name="system_time" value="<!--# echo system_time -->">
									<input type="hidden" id="time_zone_area" name="time_zone_area" value="<!--# echo time_zone_area -->">
									<input type="hidden" id="time_daylight_saving_start_month" name="time_daylight_saving_start_month" value="<!--# echo time_daylight_saving_start_month -->">
									<input type="hidden" id="time_daylight_saving_start_week" name="time_daylight_saving_start_week" value="<!--# echo time_daylight_saving_start_week -->">
									<input type="hidden" id="time_daylight_saving_start_day_of_week" name="time_daylight_saving_start_day_of_week" value="<!--# echo time_daylight_saving_start_day_of_week -->">
									<input type="hidden" id="time_daylight_saving_start_time" name="time_daylight_saving_start_time" value="<!--# echo time_daylight_saving_start_time -->">
									<input type="hidden" id="time_daylight_saving_end_month" name="time_daylight_saving_end_month" value="<!--# echo time_daylight_saving_end_month -->">
									<input type="hidden" id="time_daylight_saving_end_week" name="time_daylight_saving_end_week" value="<!--# echo time_daylight_saving_end_week -->">
									<input type="hidden" id="time_daylight_saving_end_day_of_week" name="time_daylight_saving_end_day_of_week" value="<!--# echo time_daylight_saving_end_day_of_week -->">
									<input type="hidden" id="time_daylight_saving_end_time" name="time_daylight_saving_end_time" value="<!--# echo time_daylight_saving_end_time -->">
									<input type="hidden" id="result_timer" name="result_timer" value="60">
									<input type="hidden" id="action" name="action" value="timeset">								
									<input type="hidden" id="time_daylight_saving_enable" name="time_daylight_saving_enable" value="<!--# echo time_daylight_saving_enable -->">
									<input type="hidden" id="ntp_sync_interval" name="ntp_sync_interval" value="<!--# echo ntp_sync_interval -->">
									<input type="hidden" id="time_daylight_offset" name="time_daylight_offset" value="<!--# echo time_daylight_offset -->">
									<input type="hidden" id="ntp_server" name="ntp_server" value="<!--# echo ntp_server -->">
									
									<div class="box_tn">
										<div class="CT"><script>show_words('tt_TimeConf');</script></div>
										<table cellspacing="0" cellpadding="0" class="formarea">
										<tr>
											<td class="CL"><script>show_words('_system_time');</script></td>
											<td class="CR"><span id="show_systime"></span></td>
										</tr>
					
										</table>
									</div>
									
									<div id="DSTField" class="box_tn">
										<div class="CT" id="manDayLightSavingTime"><script>show_words('_daylight_saving_time');</script></div>
										<table cellspacing="0" cellpadding="0" class="formarea">
										<tr id="enableDSTField">
											<td class="CL" id="manDSTEnable"><script>show_words('tt_dsen2');</script></td>
											<td class="CR"><input type="checkbox" id="DSTenable" name="DSTenable" value="1" /></td>
										</tr>
										<tr id="DSToffsetField">
											<td class="CL"><script>show_words('tt_dsoffs');</script></td>
											<td class="CR">
												<select name="DSToffset" id="DSToffset">
													<option value="-7200">-2:00</option>
													<option value="-5400">-1:30</option>
													<option value="-3600">-1:00</option>
													<option value="-1800">-0:30</option>
													<option value="1800">+0:30</option>
													<option value="3600">+1:00</option>
													<option value="5400">+1:30</option>
													<option value="7200">+2:00</option>
												</select>
											</td>
										</tr>
										<tr id="DSTdateField">
											<td class="CL"><script>show_words('tt_dsdates');</script></td>
											<td class="CR">
												<table cellspacing="0" cellpadding="0">
												<tr>
													<td>&nbsp;</td>
													<td><script>show_words('tt_Month');</script></td>
													<td><script>show_words('ZM21');</script></td>
													<td><script>show_words('ZM22');</script></td>
													<td><script>show_words('tt_Hour');</script></td>
												</tr>
												<tr>
													<td><script>show_words('tt_dststart');</script>
													<input type="hidden" id="DSTStart" name="DSTStart" value="030102" />
													</td>
													<td>
														<select id="tz_daylight_start_month_select" name="tz_daylight_start_month_select" onchange="set_seq_list(this.id)";>
														<script>set_month_list();</script>
														</select>
													</td>
													<td>
														<select name="tz_daylight_start_week_select" id="tz_daylight_start_week_select" onchange="set_week_list(this.id)";>
															<!--script>set_seq_list();</script-->
														</select>
													</td>
													<td>
														<select name="tz_daylight_start_dayweek_select" id="tz_daylight_start_dayweek_select">
															<!--script>set_week_list();</script-->
														</select>
													</td>
													<td>
														<select name="tz_daylight_start_time_select" id="tz_daylight_start_time_select">
															<option value="0">0</option>
															<option value="1">1</option>
															<option value="2">2</option>
															<option value="3">3</option>
															<option value="4">4</option>
															<option value="5">5</option>
															<option value="6">6</option>
															<option value="7">7</option>
															<option value="8">8</option>
															<option value="9">9</option>
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
													<td><script>show_words('tt_dstend');</script>
													<input type="hidden" id="DSTEnd" name="DSTEnd" value="100102" />
													</td>
													<td>
														<select id="tz_daylight_end_month_select" name="tz_daylight_end_month_select" onchange="set_seq_list(this.id);">
														<script>set_month_list();</script>
														</select>
													</td>
													<td>
														<select name="tz_daylight_end_week_select" id="tz_daylight_end_week_select" onchange="set_week_list(this.id)";>
															<!--script>set_seq_list();</script-->
														</select>
													</td>
													<td>
														<select name="tz_daylight_end_dayweek_select" id="tz_daylight_end_dayweek_select">
															<!--script>set_week_list();</script-->
														</select>
													<td>
														<select name="tz_daylight_end_time_select" id="tz_daylight_end_time_select">
															<option value="0">0</option>
															<option value="1">1</option>
															<option value="2">2</option>
															<option value="3">3</option>
															<option value="4">4</option>
															<option value="5">5</option>
															<option value="6">6</option>
															<option value="7">7</option>
															<option value="8">8</option>
															<option value="9">9</option>
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
									</div>
									
									<div class="box_tn">
										<div class="CT"><script>show_words('_ntp_settings');</script></div>
										<table cellspacing="0" cellpadding="0" class="formarea">
										<tr id="enableNTPField">
											<td class="CL"><script>show_words('tt_EnNTP');</script></td>
											<td class="CR"><input type="checkbox" id="enableNTP" name="enableNTP" value="1" /></td>
											<input type="hidden" id="ntp_client_enable" name="ntp_client_enable" value="<!--# echo ntp_client_enable -->">
										</tr>
										<tr id="ntpServerField" style="display: none;">
											<td class="CL"><script>show_words('_ntp_server');</script></td>
											<td class="CR">
												<select id="NTPServerIP" name="NTPServerIP">
													<option selected="selected" value=""><script>show_words('tt_SelNTPSrv');</script></option>
													<option id="pool.ntp.org" value="pool.ntp.org">pool.ntp.org</option>
													<option id="time-a.nist.gov" value="time-a.nist.gov">time-a.nist.gov</option>
													<option id="time-b.nist.gov" value="time-b.nist.gov">time-b.nist.gov</option>
													<option id="time.nist.gov" value="time.nist.gov">time.nist.gov</option>
													<option id="time.windows.com" value="time.windows.com">time.windows.com</option>
												</select>
										  </td>
										</tr>
										<tr id="TimeZoneField" style="display: none;"> 
											<td class="CL"><script>show_words('tt_TimeZ');</script></td>
											<td class="CR">
												<select id="time_zone">
													<option value="-192" default="false"><script>show_words('up_tz_00')</script></option>
													<option value="-176" default="false"><script>show_words('up_tz_01')</script></option>
													<option value="-160" default="false"><script>show_words('up_tz_02')</script></option>
													<option value="-144" default="false"><script>show_words('up_tz_03')</script></option>
													<option value="-128" default="true"><script>show_words('up_tz_04')</script></option>
													<option value="-112" default="false"><script>show_words('up_tz_05')</script></option>
													<option value="-112" default="false"><script>show_words('up_tz_06')</script></option>
													<option value="-112" default="false"><script>show_words('up_tz_06b')</script></option>
													<option value="-96" default="false"><script>show_words('up_tz_07')</script></option>
													<option value="-96" default="false"><script>show_words('up_tz_08')</script></option>
													<option value="-96" default="false"><script>show_words('up_tz_09')</script></option>
													<option value="-96" default="false"><script>show_words('up_tz_10')</script></option>
													<option value="-80" default="false"><script>show_words('up_tz_11')</script></option>
													<option value="-80" default="false"><script>show_words('up_tz_12')</script></option>
													<option value="-72" default="false"><script>show_words('up_tz_13b')</script></option>
													<option value="-64" default="false"><script>show_words('up_tz_15')</script></option>
													<option value="-64" default="false"><script>show_words('up_tz_14')</script></option>
													<option value="-64" default="false"><script>show_words('up_tz_16')</script></option>
													<option value="-56" default="false"><script>show_words('up_tz_17')</script></option>
													<option value="-48" default="false"><script>show_words('up_tz_18')</script></option>
													<option value="-48" default="false"><script>show_words('up_tz_19')</script></option>
													<option value="-48" default="false"><script>show_words('up_tz_20')</script></option>
													<option value="-32" default="false"><script>show_words('up_tz_21')</script></option>
													<option value="-16" default="false"><script>show_words('up_tz_22')</script></option>
													<option value="-16" default="false"><script>show_words('up_tz_23')</script></option>
													<option value="0" default="false"><script>show_words('up_tz_24')</script></option>
													<option value="0" default="false"><script>show_words('up_tz_25')</script></option>
													<option value="16" default="false"><script>show_words('up_tz_26')</script></option>
													<option value="16" default="false"><script>show_words('up_tz_27')</script></option>
													<option value="16" default="false"><script>show_words('up_tz_28')</script></option>
													<option value="16" default="false"><script>show_words('up_tz_29')</script></option>
													<!--option value="16" default="false"><script>show_words('up_tz_29b')</script></option-->
													<option value="16" default="false"><script>show_words('up_tz_30')</script></option>
													<option value="32" default="false"><script>show_words('up_tz_31')</script></option>
													<option value="32" default="false"><script>show_words('up_tz_32')</script></option>
													<option value="32" default="false"><script>show_words('up_tz_33')</script></option>
													<option value="32" default="false"><script>show_words('up_tz_34')</script></option>
													<option value="32" default="false"><script>show_words('up_tz_35')</script></option>
													<option value="32" default="false"><script>show_words('up_tz_36')</script></option>
													<option value="48" default="false"><script>show_words('up_tz_37')</script></option>
													<option value="48" default="false"><script>show_words('up_tz_38')</script></option>
													<option value="48" default="false"><script>show_words('up_tz_40')</script></option>
													<option value="48" default="false"><script>show_words('up_tz_41')</script></option>
													<option value="64" default="false"><script>show_words('up_tz_43b')</script></option>
													<option value="64" default="false"><script>show_words('up_tz_42')</script></option>
													<option value="64" default="false"><script>show_words('up_tz_43')</script></option>
													<option value="72" default="false"><script>show_words('up_tz_44')</script></option>
													<option value="80" default="false"><script>show_words('up_tz_46')</script></option>
													<option value="88" default="false"><script>show_words('up_tz_47')</script></option>
													<option value="88" default="false"><script>show_words('up_tz_47b')</script></option>
													<option value="92" default="false"><script>show_words('up_tz_48')</script></option>
													<option value="96" default="false"><script>show_words('up_tz_51')</script></option>
													<option value="96" default="false"><script>show_words('up_tz_50')</script></option>
													<option value="104" default="false"><script>show_words('up_tz_52')</script></option>
													<option value="112" default="false"><script>show_words('up_tz_54b')</script></option>
													<option value="112" default="false"><script>show_words('up_tz_53')</script></option>
													<option value="128" default="false"><script>show_words('up_tz_59')</script></option>
													<option value="128" default="false"><script>show_words('up_tz_55')</script></option>
													<option value="128" default="false"><script>show_words('up_tz_57')</script></option>
													<option value="128" default="false"><script>show_words('up_tz_59b')</script></option>
													<option value="128" default="false"><script>show_words('up_tz_58')</script></option>
													<option value="128" default="false"><script>show_words('up_tz_56')</script></option>
													<option value="144" default="false"><script>show_words('up_tz_62b')</script></option>
													<option value="144" default="false"><script>show_words('up_tz_60')</script></option>
													<option value="144" default="false"><script>show_words('up_tz_61')</script></option>
													<option value="152" default="false"><script>show_words('up_tz_63')</script></option>
													<option value="152" default="false"><script>show_words('up_tz_64')</script></option>
													<option value="160" default="false"><script>show_words('up_tz_69b')</script></option>
													<option value="160" default="false"><script>show_words('up_tz_65')</script></option>
													<option value="160" default="false"><script>show_words('up_tz_66')</script></option>
													<option value="160" default="false"><script>show_words('up_tz_67')</script></option>
													<option value="160" default="false"><script>show_words('up_tz_68')</script></option>
													<option value="176" default="false"><script>show_words('up_tz_70b')</script></option>
													<option value="176" default="false"><script>show_words('up_tz_70')</script></option>
													<option value="192" default="false"><script>show_words('up_tz_72b')</script></option>
													<option value="192" default="false"><script>show_words('up_tz_71')</script></option>
													<option value="192" default="false"><script>show_words('up_tz_72')</script></option>                                                                                                
				                                                                        <option value="208" default="false"><script>show_words('up_tz_73')</script></option>
				                                                                        <option value="208" default="false"><script>show_words('up_tz_73b')</script></option>
												</select>
											</td>
										</tr>
										<tr id="ntpSyncField" style="display: none;">
											<td class="CL"><script>show_words('_ntp_sync');</script></td>
											<td class="CR"><input size="4" id="NTPSync" name="NTPSync" value="" type="text" /> &nbsp;(1~300) <script>show_words('tt_Minute');</script></td>
										</tr>
										</table>
									</div>
									
									<div id="manualField" class="box_tn" style="display: block;">
										<div class="CT"><script>show_words('_date_time_settings');</script></div>
										<table cellspacing="0" cellpadding="0" class="formarea">
										<tr>
											<td class="CL"><script>show_words('tt_DaT');</script></td>
											<td class="CR">
												<table id="tools_time_set" cellspacing="2" cellpadding="2" border="0" summary="">
												<tr>
													<td><script>show_words('tt_Year');</script></td>
													<td>
														<select id="manual_year_select" name="manual_year_select">
															<option value="2000">2000</option>
															<option value="2001">2001</option>
															<option value="2002">2002</option>
															<option value="2003">2003</option>
															<option value="2004" selected="selected">2004</option>
															<option value="2005">2005</option>
															<option value="2006">2006</option>
															<option value="2007">2007</option>
															<option value="2008">2008</option>
															<option value="2009">2009</option>
															<option value="2010">2010</option>
															<option value="2011">2011</option>
															<option value="2012">2012</option>
															<option value="2013">2013</option>
															<option value="2014">2014</option>
															<option value="2015">2015</option>
															<option value="2016">2016</option>
															<option value="2017">2017</option>
															<option value="2018">2018</option>
															<option value="2019">2019</option>
															<option value="2020">2020</option>
															<option value="2021">2021</option>
															<option value="2022">2022</option>
															<option value="2023">2023</option>
															<option value="2024">2024</option>
															<option value="2025">2025</option>
															<option value="2026">2026</option>
															<option value="2027">2027</option>
															<option value="2028">2028</option>
															<option value="2029">2029</option>
															<option value="2030">2030</option>
															<option value="2031">2031</option>
															<option value="2032">2032</option>
															<option value="2033">2033</option>
															<option value="2034">2034</option>
															<option value="2035">2035</option>
															<option value="2036">2036</option>
															<option value="2037">2037</option>
														</select>
													</td>
													<td><script>show_words('tt_Month');</script></td>
													<td>
														<select id="manual_month_select" name="manual_month_select">
															<option value="1" selected="selected"><script>show_words('tt_Jan');</script></option>
															<option value="2"><script>show_words('tt_Feb');</script></option>
															<option value="3"><script>show_words('tt_Mar');</script></option>
															<option value="4"><script>show_words('tt_Apr');</script></option>
															<option value="5"><script>show_words('tt_May');</script></option>
															<option value="6"><script>show_words('tt_Jun');</script></option>
															<option value="7"><script>show_words('tt_Jul');</script></option>
															<option value="8"><script>show_words('tt_Aug');</script></option>
															<option value="9"><script>show_words('tt_Sep');</script></option>
															<option value="10"><script>show_words('tt_Oct');</script></option>
															<option value="11"><script>show_words('tt_Nov');</script></option>
															<option value="12"><script>show_words('tt_Dec');</script></option>
														</select>
													</td>
													<td><script>show_words('tt_Day');</script></td>
													<td>
														<select id="manual_day_select" name="manual_day_select">
															<option value="1" selected="selected">01</option>
															<option value="2">02</option>
															<option value="3">03</option>
															<option value="4">04</option>
															<option value="5">05</option>
															<option value="6">06</option>
															<option value="7">07</option>
															<option value="8">08</option>
															<option value="9">09</option>
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
													<td><script>show_words('tt_Hour');</script></td>
													<td>
														<select id="manual_hour_select" name="manual_hour_select">
															<option value="0" selected="selected">00</option>
															<option value="1">01</option>
															<option value="2">02</option>
															<option value="3">03</option>
															<option value="4">04</option>
															<option value="5">05</option>
															<option value="6">06</option>
															<option value="7">07</option>
															<option value="8">08</option>
															<option value="9">09</option>
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
													<td><script>show_words('tt_Minute');</script></td>
													<td>
														<select id="manual_min_select" name="manual_min_select">
															<option value="0" selected="selected">00</option>
															<option value="1">01</option>
															<option value="2">02</option>
															<option value="3">03</option>
															<option value="4">04</option>
															<option value="5">05</option>
															<option value="6">06</option>
															<option value="7">07</option>
															<option value="8">08</option>
															<option value="9">09</option>
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
													<td><script>show_words('tt_Second');</script></td>
													<td>
														<select id="manual_sec_select" name="manual_sec_select">
															<option value="0" selected="selected">00</option>
															<option value="1">01</option>
															<option value="2">02</option>
															<option value="3">03</option>
															<option value="4">04</option>
															<option value="5">05</option>
															<option value="6">06</option>
															<option value="7">07</option>
															<option value="8">08</option>
															<option value="9">09</option>
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
									
									<div class="box_tn">
										<table cellspacing="0" cellpadding="0" class="formarea">
										<tr align="center" valign="middle">
											<td class="btn_field">
												<input type="button" class="button_submit" id="apply" value="Apply" onclick="check_apply();" />
												<script>$('#apply').val(get_words('_adv_txt_17'));</script>
												<input type="reset" class="button_submit" id="cancel" value="Cancel" onclick="window.location.reload()" />
												<script>$('#cancel').val(get_words('_cancel'));</script>
											</td>
										</tr>
										</table>
									</div>
									</div>
								<!-- End of main content -->
							</form>
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
</html>
