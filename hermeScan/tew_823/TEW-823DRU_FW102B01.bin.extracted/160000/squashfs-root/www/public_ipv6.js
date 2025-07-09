﻿function select_ipv6_wan_page(ipv6_sel_wan){ 
location.href = "internet_"+ipv6_sel_wan+".asp";
}
function ipv6_addr_obj(addr, e_msg, allow_zero, is_network){
this.addr = addr;
this.e_msg = e_msg;
this.allow_zero = allow_zero;	
this.is_network = is_network;	
}	
function check_ipv6_symbol(strOrg,strFind){
/*For fitting old check_ipv6_address function use*/	
/*if false return 2, if have double-colon return 1, completely IPv6 address return 0*/
var symbol_count=0; 
var _index = 0;
var current_index =-1;
var dc_flag=0; 
strFind = ":";	
for(_index=0;_index<strOrg.length;_index++)
{
_index = strOrg.indexOf(strFind,_index);	
if(_index<=-1)	
break;
else{
if(_index == -1){
return -1;
}else{
symbol_count++;
if((_index-current_index)==1){
dc_flag++;
if(dc_flag>1){
alert("The IPv6 address allows double-colon only once.");
return 2;
}
}	
current_index = _index;	
}	
}	
}
if(symbol_count<2 || symbol_count>7){ 
alert("The IPv6 address is illegal address");
return 2;	
}	
if(symbol_count>=2 && symbol_count<7 && dc_flag==0){	
alert("The IPv6 address is illegal address");
return 2;	
}	
if(symbol_count==7 && dc_flag>0){ 
alert("The IPv6 address is illegal address");
return 2;
}	
return dc_flag;
} 
function check_ipv6_address(my_obj,strFind){
var ip = my_obj.addr;
var count_zero=0; 
var ip_temp;
var sum = 0;
var ipv6_field_number = 0;
if(strFind == "::"){ 
if (my_obj.addr.length == 2){ 
if(ip[0].charAt(0) =="f" || ip[0].charAt(0) =="F"){
if(ip[0].charAt(1) =="f" || ip[0].charAt(1) =="F"){
//alert(my_obj.e_msg[IPv6_MULTICASE_IP_ERROR]);
alert(my_obj.e_msg[21]);//IPv6_MULTICASE_IP_ERROR
return false;
}	
}	
for(var i = 0; i < 2; i++){	
ip_temp = ip[i].split(":");
for(var index =0; index < ip_temp.length; index++){
if(ip_temp[index].length == 0 || ip_temp[index].length > 4){
alert(my_obj.e_msg[IPv6_INVALID_IP]);
return false;
}
for(var pos =0; pos < ip_temp[index].length ;pos++){
if(!check_hex(ip_temp[index].charAt(pos))){
alert(my_obj.e_msg[IPv6_FIRST_IP_ERROR+ipv6_field_number]);
return false;
}
sum += transValue(ip_temp[index].charAt(pos))*(pos+1);	
}
ipv6_field_number++;	
}
}
if(sum == 0){ 
alert(my_obj.e_msg[IPv6_ZERO_IP]);	
return false; 
}
}else{	
alert(my_obj.e_msg[IPv6_INVALID_IP]);
return false;
}
} 
else{	
if (my_obj.addr.length == 8){ 
if(ip[0].charAt(0) =="f" || ip[0].charAt(0) =="F"){
if(ip[0].charAt(1) =="f" || ip[0].charAt(1) =="F"){
//alert(my_obj.e_msg[IPv6_MULTICASE_IP_ERROR]);
alert(my_obj.e_msg[21]);//IPv6_MULTICASE_IP_ERROR
return false;
}	
}	
for(var i = 0; i < ip.length; i++){
if (ip[i] == "0"){
count_zero++;
}else if((ip[i].charAt(0) =="0") && (ip[i].charAt(1) =="0")){
count_zero++;	
}else if((ip[i].charAt(0) =="0") && (ip[i].charAt(1) =="0") && (ip[i].charAt(2) =="0")){
count_zero++;	
}else if((ip[i].charAt(0) =="0") && (ip[i].charAt(1) =="0") && (ip[i].charAt(2) =="0") && (ip[i].charAt(3) =="0")){
count_zero++;	
}
} 
if (!my_obj.allow_zero && count_zero == 8){	
alert(my_obj.e_msg[IPv6_ZERO_IP]);	
return false; 
}else{
count_zero=0;
for(var i = 0; i < ip.length; i++){
if(ip[i].length > 4 || ip[i].length == 0){
alert(my_obj.e_msg[IPv6_INVALID_IP]);
return false;
}	
for(var index =0; index < ip[i].length ;index++){
if(!check_hex(ip[i].charAt(index))){
alert(my_obj.e_msg[IPv6_FIRST_IP_ERROR+i]);
return false;
}	
}
}
}
}else{	
alert(my_obj.e_msg[IPv6_INVALID_IP]);
return false;
}	
}
return true;
} 
function get_stateful_ipv6(ipv6_addr)
{
var ipv6_addr_prefix=""; 
var ipv6_addr_suffix="";
var index=0;
var string_len=0;
var colon=0;
var total_colon=0;
var fields=0;
var zero_ipv6_addr="";
var i=0;
string_len = ipv6_addr.length;
index = check_symbol(ipv6_addr,"::"); 
if(index != -1){
ipv6_addr_prefix = ipv6_addr.substring(0,index);
ipv6_addr_suffix = ipv6_addr.substring(index+2,string_len);	
colon = find_colon(ipv6_addr_prefix,":");
total_colon = colon;
colon = find_colon(ipv6_addr_suffix,":");
total_colon += colon;
fields = total_colon+2;
for(i=0;i<(8-fields);i++){
zero_ipv6_addr += ":0"; 
}
ipv6_addr = ipv6_addr_prefix+ zero_ipv6_addr +":"+ ipv6_addr_suffix;
}	
return ipv6_addr;
}
function get_stateful_prefix(ipv6_addr,length){
var index=0;
var ipv6_addr_prefix="";
if(length == 64)
index = count_colon_pos(ipv6_addr,":",4);
if(length == 112)
index = count_colon_pos(ipv6_addr,":",7);
ipv6_addr_prefix = ipv6_addr.substring(0,index-1);
return ipv6_addr_prefix; 
}
function get_stateful_suffix(ipv6_addr){
var index=0;
var ipv6_addr_suffix="";
var string_len=0;
string_len = ipv6_addr.length; 
index = count_last_colon_pos(ipv6_addr,":");
ipv6_addr_suffix = ipv6_addr.substring(index+1,string_len);	
return ipv6_addr_suffix; 
} 
function check_ipv6_address_suffix(strOrg,tag){
if( strOrg.length > 0 && strOrg.length < 5){
for(var index =0; index < strOrg.length ;index++){
if(!check_hex(strOrg.charAt(index))){
alert("The suffix of "+tag +" must be a hexadecimal.");
return false;
}	
}
}else{
alert("The suffix of "+tag+" is not an invalid address.");
return false;	
}
return true;	
}
function check_lan_ipv6_subnet(strOrg,tag){
if( strOrg.length > 0 && strOrg.length < 5){
for(var index =0; index < strOrg.length ;index++){
if(!check_hex(strOrg.charAt(index))){
alert("The subnet of "+tag +" must be a hexadecimal.");
return false;
}	
}
}else{
alert("The subnet of "+tag+" is not an invalid address.");
return false;	
}
return true;	
}
