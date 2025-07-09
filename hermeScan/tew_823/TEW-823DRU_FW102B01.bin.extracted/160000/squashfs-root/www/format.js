var format_error_msg = new Array(
			"Invalid IP address format.",	// FMT_INVALID_IPADDRESS
			"Invalid IP range format.",	// FMT_INVALID_IPRANGE
			"Invalid IP network format.",	// FMT_INVALID_IPNETWORK
			"The IP address is an invalid address.",	// FMT_INVALID_IPFORMAT
			"The 1st range of IP address must be 1 ~ 223.",	// FMT_INVALID_IPUSABLE
			"The User Account cannot be empty.",		// FMT_INVALID_ACCOUNT
			"The User Name cannot be empty."		// FMT_INVALID_USERNAME
			);

var FMT_INVALID_IPADDRESS	= 0;
var FMT_INVALID_IPRANGE		= 1;
var FMT_INVALID_IPNETWORK	= 2;
var FMT_INVALID_IPFORMAT	= 3;
var FMT_INVALID_IPUSABLE	= 4;
var FMT_INVALID_ACCOUNT		= 5;
var FMT_INVALID_USERNAME	= 6;

function fmt_error_msg(error_msg_idx)
{
	alert(format_error_msg[error_msg_idx]);
	return -1;
}

function fmt_account_verify(ui_element)
{
	var usr = get_by_id(ui_element).value;

	if (usr == "")
		return fmt_error_msg(FMT_INVALID_ACCOUNT);

	return 0;
}

function fmt_username_verify(ui_element)
{
	var usr = get_by_id(ui_element).value;

	if (usr == "")
		return fmt_error_msg(FMT_INVALID_USERNAME);

	return 0;
}

/* @ip is valid IP format, we don't need to verify @ip is valid or not */
function fmt_ip_useable_verify(ip)
{
	var ip_ary = ip.split(".");

	if (parseInt(ip_ary[0]) < 1 || parseInt(ip_ary[0]) > 224)
		return fmt_error_msg(FMT_INVALID_IPUSABLE);

	return 0;
}

function iprange_singal_check(singal_ip_fmt)
{
	var ip_obj = new addr_obj(singal_ip_fmt.split("."), ip_addr_msg, false, false);

	return (check_address(ip_obj) == true)?0:-1;
}

function iprange_range_check(range_ip_fmt)
{
	var ip_range_list = range_ip_fmt.split("-");

	if (ip_range_list.length != 2)
		return fmt_error_msg(FMT_INVALID_IPRANGE);

	if (iprange_singal_check(ip_range_list[0]) == -1 ||
		iprange_singal_check(ip_range_list[1]) == -1)
		return -1;

	return 0;
}

function iprange_network_check(network_ip_fmt)
{
	if(network_ip_fmt != "0.0.0.0/0") {
		if(!check_ip_data(network_ip_fmt))
			return -1;
	}

	return 0;
}

function iprange_fmt_check(ip_fmt)
{
	var ip_entry_fmt, ip_entry_list;

	if (ip_fmt == "*")
		return true;

	ip_entry_fmt = ip_fmt.replace(/;/, ",");
	ip_entry_list = ip_entry_fmt.split(",");

	for (var i = 0; i < ip_entry_list.length; i++) {
		if (ip_entry_list[i].search(/-/) == -1 && ip_entry_list[i].search(/\//) == -1)
			ret = iprange_singal_check(ip_entry_list[i]);
		else if (ip_entry_list[i].search(/-/) != -1)
			ret = iprange_range_check(ip_entry_list[i]);
		else
			ret = iprange_network_check(ip_entry_list[i]);

		if (ret == -1)
			return false;
	}

	return true;
}
