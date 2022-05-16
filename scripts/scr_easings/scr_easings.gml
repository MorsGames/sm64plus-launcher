///EASING & TWEENING
///Original GameMaker Studio version by foreverisbetter
///Adapted to GameMaker Studio 2.3 by ThanielPIN

/// @function				ease_in_sine(_val1,_val2,_amount)
/// @description			Returns the sinusoidal interpolation of two input values by the given amount.
/// @param {real} _val1		The first value.
/// @param {real} _val2 	The second value.
/// @param {real} _amount 	The amount to interpolate.

function ease_in_sine(_val1,_val2,_amount) {
	
	var _d = _val2-_val1;
	
	return _d*(1-cos(_amount*(pi/2)))+_val1;
	
	}

/// @function				ease_in_quad(_val1,_val2,_amount)
/// @description			Returns the quadratic interpolation of two input values by the given amount.
/// @param {real} _val1		The first value.
/// @param {real} _val2 	The second value.
/// @param {real} _amount 	The amount to interpolate.

function ease_in_quad(_val1,_val2,_amount) {
	
	var _d = _val2-_val1;
	
	return _d*power(_amount,2)+_val1;
	
	}

/// @function				ease_in_cubic(_val1,_val2,_amount)
/// @description			Returns the cubic interpolation of two input values by the given amount.
/// @param {real} _val1		The first value.
/// @param {real} _val2 	The second value.
/// @param {real} _amount 	The amount to interpolate.

function ease_in_cubic(_val1,_val2,_amount) {
	
	var _d = _val2-_val1;
	
	return _d*power(_amount,3)+_val1;
	
	}

/// @function				ease_in_quart(_val1,_val2,_amount)
/// @description			Returns the quartic interpolation of two input values by the given amount.
/// @param {real} _val1		The first value.
/// @param {real} _val2 	The second value.
/// @param {real} _amount 	The amount to interpolate.

function ease_in_quart(_val1,_val2,_amount) {
	
	var _d = _val2-_val1;
	
	return _d*power(_amount,4)+_val1;
	
	}

/// @function				ease_in_quint(_val1,_val2,_amount)
/// @description			Returns the quintic interpolation of two input values by the given amount.
/// @param {real} _val1		The first value.
/// @param {real} _val2 	The second value.
/// @param {real} _amount 	The amount to interpolate.

function ease_in_quint(_val1,_val2,_amount) {
	
	var _d = _val2-_val1;
	
	return _d*power(_amount,5)+_val1;
	
	}

/// @function				ease_in_expo(_val1,_val2,_amount)
/// @description			Returns the exponential interpolation of two input values by the given amount.
/// @param {real} _val1		The first value.
/// @param {real} _val2 	The second value.
/// @param {real} _amount 	The amount to interpolate.

function ease_in_expo(_val1,_val2,_amount) {
	
	var _d = _val2-_val1;
	
	return _d*power(2,10*(_amount-1))+_val1;
	
	}

/// @function				ease_in_circ(_val1,_val2,_amount)
/// @description			Returns the circular interpolation of two input values by the given amount.
/// @param {real} _val1		The first value.
/// @param {real} _val2 	The second value.
/// @param {real} _amount 	The amount to interpolate.

function ease_in_circ(_val1,_val2,_amount) {
	
	var _d = _val2-_val1;
	
	return _d*(1-sqrt(1-power(_amount,2)))+_val1;
	
	}

/// @function				ease_in_back(_val1,_val2,_amount)
/// @description			Returns the overshooting cubic interpolation of two input values by the given amount.
/// @param {real} _val1		The first value.
/// @param {real} _val2 	The second value.
/// @param {real} _amount 	The amount to interpolate.

function ease_in_back(_val1,_val2,_amount) {
	
	var _d = _val2-_val1;
	var _s = 1.70158; // Feel free to modify this value.
	
	return _d*power(_amount,2)*((_s+1)*_amount-_s)+_val1;
	
	}

/// @function				ease_in_elastic(_val1,_val2,_amount)
/// @description			Returns the elastic interpolation of two input values by the given amount.
/// @param {real} _val1		The first value.
/// @param {real} _val2 	The second value.
/// @param {real} _amount 	The amount to interpolate.

function ease_in_elastic(_val1,_val2,_amount) {
	
	var _d = _val2-_val1;
	var _s = 1.70158;
	var _p = 0.3;
	
	if (_amount = 0 || _d = 0) return _val1;
	
	if (_amount = 1) return _val1+_d;
	
	if (_d < abs(_d)) _s = _p*0.25;
	else _s = _p/(2*pi)*arcsin (1);
	
	return -(_d*power(2,10*(--_amount))*sin((_amount-_s)*(2*pi)/_p))+_val1;
	
	}

/// @function				ease_in_bounce(_val1,_val2,_amount)
/// @description			Returns the bounce-like interpolation of two input values by the given amount.
/// @param {real} _val1		The first value.
/// @param {real} _val2 	The second value.
/// @param {real} _amount 	The amount to interpolate.

function ease_in_bounce(_val1,_val2,_amount) {
	
	var _d = _val2-_val1;
	
	return _d-ease_out_bounce(0,_val2,1-_amount)+_val1;
	
	}
	
/// @function				ease_inout_sine(_val1,_val2,_amount)
/// @description			Returns the sinusoidal interpolation of two input values by the given amount.
/// @param {real} _val1		The first value.
/// @param {real} _val2 	The second value.
/// @param {real} _amount 	The amount to interpolate.

function ease_inout_sine(_val1,_val2,_amount) {
	
	var _d = _val2-_val1;
	
	return _d*0.5*(1-cos(pi*_amount))+_val1;
	
	}

/// @function				ease_inout_quad(_val1,_val2,_amount)
/// @description			Returns the quadratic interpolation of two input values by the given amount.
/// @param {real} _val1		The first value.
/// @param {real} _val2 	The second value.
/// @param {real} _amount 	The amount to interpolate.

function ease_inout_quad(_val1,_val2,_amount) {
	
	var _d = _val2-_val1;
	
	_amount *= 2;
	
	if (_amount < 1) return (_d*0.5)*power(_amount,2)+_val1;
	
	return (-_d*0.5)*(--_amount*(_amount-2)-1)+_val1;
	
	}

/// @function				ease_inout_cubic(_val1,_val2,_amount)
/// @description			Returns the cubic interpolation of two input values by the given amount.
/// @param {real} _val1		The first value.
/// @param {real} _val2 	The second value.
/// @param {real} _amount 	The amount to interpolate.

function ease_inout_cubic(_val1,_val2,_amount) {
	
	var _d = _val2-_val1;
	
	_amount *= 2;
	
	if (_amount < 1) return (_d*0.5)*power(_amount,3)+_val1;
	
	return (_d*0.5)*(power(_amount-2,3)+2)+_val1;
	
	}

/// @function				ease_inout_quart(_val1,_val2,_amount)
/// @description			Returns the quartic interpolation of two input values by the given amount.
/// @param {real} _val1		The first value.
/// @param {real} _val2 	The second value.
/// @param {real} _amount 	The amount to interpolate.

function ease_inout_quart(_val1,_val2,_amount) {
	
	var _d = _val2-_val1;
	
	_amount *= 2;
	
	if (_amount < 1) return _d*0.5*power(_amount,4)+_val1;
	
	return -_d*0.5*(power(_amount-2,4)-2)+_val1;
	
	}

/// @function				ease_inout_quint(_val1,_val2,_amount)
/// @description			Returns the quintic interpolation of two input values by the given amount.
/// @param {real} _val1		The first value.
/// @param {real} _val2 	The second value.
/// @param {real} _amount 	The amount to interpolate.

function ease_inout_quint(_val1,_val2,_amount) {
	
	var _d = _val2-_val1;
	
	_amount *= 2;
	
	if (_amount < 1) return _d*0.5*power(_amount,5)+_val1;
	
	return _d*0.5*(power(_amount-2,5)+2)+_val1;
	
	}

/// @function				ease_inout_expo(_val1,_val2,_amount)
/// @description			Returns the exponential interpolation of two input values by the given amount.
/// @param {real} _val1		The first value.
/// @param {real} _val2 	The second value.
/// @param {real} _amount 	The amount to interpolate.

function ease_inout_expo(_val1,_val2,_amount) {
	
	var _d = _val2-_val1;
	
	_amount *= 2;
	
	if (_amount < 1) return _d*0.5*power(2,10*(_amount-1))+_val1;
	
	return _d*0.5*(-power(2,-10*(_amount-1))+2)+_val1;
	
	}

/// @function				ease_inout_circ(_val1,_val2,_amount)
/// @description			Returns the circular interpolation of two input values by the given amount.
/// @param {real} _val1		The first value.
/// @param {real} _val2 	The second value.
/// @param {real} _amount 	The amount to interpolate.

function ease_inout_circ(_val1,_val2,_amount) {
	
	var _d = _val2-_val1;
	
	_amount *= 2;
	
	if (_amount < 1) return _d*0.5*(1-sqrt(1-power(_amount,2)))+_val1;
	
	return _d*0.5*(sqrt(1-power(_amount-2,2))+1)+_val1;
	
	}

/// @function				ease_inout_back(_val1,_val2,_amount)
/// @description			Returns the overshooting cubic interpolation of two input values by the given amount.
/// @param {real} _val1		The first value.
/// @param {real} _val2 	The second value.
/// @param {real} _amount 	The amount to interpolate.

function ease_inout_back(_val1,_val2,_amount) {
	
	var _d = _val2-_val1;
	var _s = 1.70158;
	
	_amount *= 2;
	
	if (_amount < 1) {
		_s *= 1.525;
		return _d*0.5*(power(_amount,2)*((_s+1)*_amount-_s))+_val1;
		}
	
	_amount -= 2;
	_s *= 1.525
	return _d*0.5*(power(_amount,2)*((_s+1)*_amount+_s)+2)+_val1;
	
	}

/// @function				ease_inout_elastic(_val1,_val2,_amount)
/// @description			Returns the elastic interpolation of two input values by the given amount.
/// @param {real} _val1		The first value.
/// @param {real} _val2 	The second value.
/// @param {real} _amount 	The amount to interpolate.

function ease_inout_elastic(_val1,_val2,_amount) {
	
	var _d = _val2-_val1;
	var _s = 1.70158;
	var _p = 0.3*1.5;
	
	if (_amount = 0 || _d = 0) return _val1;
	
	_amount *= 2;
	
	if (_amount = 2) return _val1+_d;
	
	if (_d < abs(_d)) _s = _p*0.25;
	else _s = _p/(2*pi)*arcsin(1);
	
	if (_amount < 1) return -0.5*(_d*power(2,10*(--_amount))*sin((_amount-_s)*(2*pi)/_p))+_val1;
	
	return _d*power(2,-10*(--_amount))*sin((_amount-_s)*(2*pi)/_p)*0.5+_d+_val1;
	
	}

/// @function				ease_inout_bounce(_val1,_val2,_amount)
/// @description			Returns the bounce-like interpolation of two input values by the given amount.
/// @param {real} _val1		The first value.
/// @param {real} _val2 	The second value.
/// @param {real} _amount 	The amount to interpolate.

function ease_inout_bounce(_val1,_val2,_amount) {
	
	var _d = _val2-_val1;
	
	if (_amount < 0.5) return (ease_in_bounce(0,val2,_amount*2)*0.5+_val1);
	
	return (ease_out_bounce(0,val2,_amount*2-1)*0.5+_d*0.5+_val1);
	
	}

/// @function				ease_out_sine(_val1,_val2,_amount)
/// @description			Returns the sinusoidal interpolation of two input values by the given amount.
/// @param {real} _val1		The first value.
/// @param {real} _val2 	The second value.
/// @param {real} _amount 	The amount to interpolate.

function ease_out_sine(_val1,_val2,_amount) {
	
	var _d = _val2-_val1;
	
	return _d*sin(_amount*(pi/2))+_val1;
	
	}

/// @function				ease_out_quad(_val1,_val2,_amount)
/// @description			Returns the quadratic interpolation of two input values by the given amount.
/// @param {real} _val1		The first value.
/// @param {real} _val2 	The second value.
/// @param {real} _amount 	The amount to interpolate.

function ease_out_quad(_val1,_val2,_amount) {
	
	var _d = _val2-_val1;
	
	return -_d*_amount*(_amount-2)+_val1;
	
	}

/// @function				ease_out_cubic(_val1,_val2,_amount)
/// @description			Returns the cubic interpolation of two input values by the given amount.
/// @param {real} _val1		The first value.
/// @param {real} _val2 	The second value.
/// @param {real} _amount 	The amount to interpolate.

function ease_out_cubic(_val1,_val2,_amount) {
	
	var _d = _val2-_val1;
	
	return _d*(power(_amount-1,3)+1)+_val1;
	
	}

/// @function				ease_out_quart(_val1,_val2,_amount)
/// @description			Returns the quartic interpolation of two input values by the given amount.
/// @param {real} _val1		The first value.
/// @param {real} _val2 	The second value.
/// @param {real} _amount 	The amount to interpolate.

function ease_out_quart(_val1,_val2,_amount) {
	
	var _d = _val2-_val1;
	
	return -_d*(power(_amount-1,4)-1)+_val1;
	
	}

/// @function				ease_out_quint(_val1,_val2,_amount)
/// @description			Returns the quintic interpolation of two input values by the given amount.
/// @param {real} _val1		The first value.
/// @param {real} _val2 	The second value.
/// @param {real} _amount 	The amount to interpolate.

function ease_out_quint(_val1,_val2,_amount) {
	
	var _d = _val2-_val1;
	
	return _d*(power(_amount-1,5)+1)+_val1;
	
	}

/// @function				ease_out_expo(_val1,_val2,_amount)
/// @description			Returns the exponential interpolation of two input values by the given amount.
/// @param {real} _val1		The first value.
/// @param {real} _val2 	The second value.
/// @param {real} _amount 	The amount to interpolate.

function ease_out_expo(_val1,_val2,_amount) {
	
	var _d = _val2-_val1;
	
	return _d*(-power(2,-10*_amount)+1)+_val1;
	
	}

/// @function				ease_out_circ(_val1,_val2,_amount)
/// @description			Returns the circular interpolation of two input values by the given amount.
/// @param {real} _val1		The first value.
/// @param {real} _val2 	The second value.
/// @param {real} _amount 	The amount to interpolate.

function ease_out_circ(_val1,_val2,_amount) {
	
	var _d = _val2-_val1;
	
	return _d*sqrt(1-power(_amount-1,2))+_val1;
	
	}

/// @function				ease_out_back(_val1,_val2,_amount)
/// @description			Returns the overshooting cubic interpolation of two input values by the given amount.
/// @param {real} _val1		The first value.
/// @param {real} _val2 	The second value.
/// @param {real} _amount 	The amount to interpolate.

function ease_out_back(_val1,_val2,_amount) {
	
	var _d = _val2-_val1;
	var _s = 1.70158;
	
	_amount -= 1;
	return _d*(power(_amount,2)*((_s+1)*_amount+_s)+1)+_val1;
	
	}

/// @function				ease_out_elastic(_val1,_val2,_amount)
/// @description			Returns the elastic interpolation of two input values by the given amount.
/// @param {real} _val1		The first value.
/// @param {real} _val2 	The second value.
/// @param {real} _amount 	The amount to interpolate.

function ease_out_elastic(_val1,_val2,_amount) {
	
	var _d = _val2-_val1;
	var _s = 1.70158;
	var _p = 0.3;
	
	if (_amount = 0 || _d = 0) return _val1;
	
	if (_amount = 1) return _val1+_d;
	
	if (_d < abs(_d)) _s = _p*0.25;
	else _s = _p/(2*pi)*arcsin(1);
	
	return _d*power(2,-10*_amount)*sin((_amount-_s)*(2*pi)/_p)+_d+_val1;
	
	}

/// @function				ease_out_bounce(_val1,_val2,_amount)
/// @description			Returns the bounce-like interpolation of two input values by the given amount.
/// @param {real} _val1		The first value.
/// @param {real} _val2 	The second value.
/// @param {real} _amount 	The amount to interpolate.

function ease_out_bounce(_val1,_val2,_amount) {
	
	var _d = _val2-_val1;
	
	if (_amount < (1/2.75)) return _d*(7.5625*power(_amount,2))+_val1;
	else
	if (_amount < (2/2.75)) {
		_amount -= (1.5/2.75);
		return _d*(7.5625*power(_amount,2)+0.75)+_val1;
		}
	else
	if (_amount < (2.5/2.75)) {
		_amount -= (2.25/2.75);
		return _d*(7.5625*power(_amount,2)+0.9375)+_val1;
		}
	else {
		_amount -= (2.625/2.75);
		return _d*(7.5625*power(_amount,2)+0.984375)+_val1;
		}
	
	}