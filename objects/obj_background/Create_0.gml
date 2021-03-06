/// @desc The background drawer

// Load the backgrounds
var _add = function(name) {
	var _path = GFX_PATH + "skyboxes\\" + name + ".png";

	if (file_exists(_path))
	    return sprite_add(_path, 1, 0, 0, 0, 0);
	else {
	    return spr_placeholder;
	}
}

backgrounds = [_add("water"), _add("cloud_floor"), _add("ccm"), _add("ssl"), _add("wdw"), _add("bidw"), _add("bitfs"), _add("bits"), spr_void]
backgrounds_no = 8;

background_index = choose(1, 2, 3, 4);
change_background = function(new_index) {
	background_alpha = 0;
	background_index_last = background_index;
	background_index = new_index % backgrounds_no;
	if (background_index < 0)
		background_index = backgrounds_no;
}
change_background(background_index);
background_alpha = 1;

message_timer = 0;
message_text = "";
message_position = 0;
message_move = 0;

display_message = function(msg) {
	message_text = msg;
	message_timer = 120;
	message_move = true;
}

// Shader uniforms and the background surface

res_u = shader_get_uniform(shd_curve, "u_uResolution");
surface_recreate = function() {
    surf = surface_create(view_wport[0], view_hport[0]);
}
surface_recreate();

fade = 1;