// Copies a whole directory
function copy_dir(from_dir, to_dir) {
	
	if (!directory_exists(to_dir))
		directory_create(to_dir)
		
	var _file;
	var _files = 0;
	
	for (var _filename = file_find_first(from_dir + "/*.*", fa_directory); _filename != ""; _filename = file_find_next()) {

		if (_filename == "." || _filename == "..")
			continue
			
		_file[_files] = _filename
		_files++;
	}
	file_find_close();
	
	var _i = 0;
	repeat (_files) {
		
		_filename = _file[_i]
		_i++;
		
		var _from = from_dir + "/" + _filename;
		var _to = to_dir + "/" + _filename;
		
		if (directory_exists(_from))
			copy_dir(_from, _to);
		else {
			var _size = 0;
			if (file_exists(_to)) {
				var _binfile = file_bin_open(_to, 0);
				_size = file_bin_size(_binfile);
				file_bin_close(_binfile);
			}
			if (_size < 8) {
				if (file_exists(_to))
					file_delete(_to);
				file_copy(_from, _to);
			}
		}
	}
}