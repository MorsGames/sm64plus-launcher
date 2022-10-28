function gamepad_get_buttons() {
    
    var _list = ds_list_create();

	if (gamepad_button_check(0, gp_face1))
        ds_list_add(_list, gp_face1);
	if (gamepad_button_check(0, gp_face2))
        ds_list_add(_list, gp_face2);
	if (gamepad_button_check(0, gp_face3))
        ds_list_add(_list, gp_face3);
	if (gamepad_button_check(0, gp_face4))
        ds_list_add(_list, gp_face4);

	if (gamepad_button_check(0, gp_padl))
        ds_list_add(_list, gp_padl);
	if (gamepad_button_check(0, gp_padr))
        ds_list_add(_list, gp_padr);
	if (gamepad_button_check(0, gp_padd))
        ds_list_add(_list, gp_padd);
	if (gamepad_button_check(0, gp_padu))
        ds_list_add(_list, gp_padu);

	if (gamepad_button_check(0, gp_shoulderl))
        ds_list_add(_list, gp_shoulderl);
	if (gamepad_button_check(0, gp_shoulderlb))
        ds_list_add(_list, gp_shoulderlb);
	if (gamepad_button_check(0, gp_shoulderr))
        ds_list_add(_list, gp_shoulderr);
	if (gamepad_button_check(0, gp_shoulderrb))
        ds_list_add(_list, gp_shoulderrb);

	if (gamepad_button_check(0, gp_start))
        ds_list_add(_list, gp_start);
	if (gamepad_button_check(0, gp_select))
        ds_list_add(_list, gp_select);

	if (gamepad_button_check(0, gp_stickl))
        ds_list_add(_list, gp_stickl);
	if (gamepad_button_check(0, gp_stickr))
        ds_list_add(_list, gp_stickr);
        
    return _list;
}