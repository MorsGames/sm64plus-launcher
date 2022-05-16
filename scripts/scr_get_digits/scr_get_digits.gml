// Get digits from a string
function get_digits(value) {
	
	var _str = string_digits(value);
	if (_str == "") {
		keyboard_string = "";
		return "";
	}
	else
		return real(_str);
}