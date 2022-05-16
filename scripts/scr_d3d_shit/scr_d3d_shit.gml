/// @description d3d - Sets the transformation to a translation over the indicated vector.
/// @param xt x value
/// @param yt y value
/// @param zt z value
function d3d_transform_set_translation(argument0, argument1, argument2) {

	// build the rotation matrix
	var m = matrix_build_identity();
	m[12] = argument0;
	m[13] = argument1;
	m[14] = argument2;
	matrix_set( matrix_world, m);
}

/// @description d3d - set transform identiy matrix
function d3d_transform_set_identity() {

	var i = matrix_build_identity();
	matrix_set( matrix_world, i)
}
