// wEase by Distant Illusions
// A comprehensive collection of easing functions, based on the work of Robert Penner.
// https://distantillusions.com/

/* This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/. */

#macro __WEASE_VERSION "1.0.0"

show_debug_message("wEase v" + __WEASE_VERSION + " by Distant Illusions");

// EASE LINEAR

/// @func ease_linear(a, b, amount)
/// @desc Returns the linear interpolation of two input values by the given amount.
/// @param {real} a The first value.
/// @param {real} b The second value.
/// @param {real} amount The amount to interpolate.
/// @returns {real} The interpolated value.
function ease_linear(_a, _b, _amount)
{
    return lerp(_a, _b, _amount);
}

// QUADRATIC EASING

/// @func ease_in_quad(a, b, amount)
/// @desc Returns the quadratic interpolation of two input values by the given amount.
/// @param {real} a The first value.
/// @param {real} b The second value.
/// @param {real} amount The amount to interpolate.
/// @returns {real} The interpolated value.
function ease_in_quad(_a, _b, _amount)
{
    var _c = _b - _a;
    return _c * power(_amount, 2) + _a;
}

/// @func ease_out_quad(a, b, amount)
/// @desc Returns the quadratic interpolation of two input values by the given amount.
/// @param {real} a The first value.
/// @param {real} b The second value.
/// @param {real} amount The amount to interpolate.
/// @returns {real} The interpolated value.
function ease_out_quad(_a, _b, _amount)
{
    var _c = _b - _a;
    return -_c * _amount * (_amount - 2) + _a;
}

/// @func ease_inout_quad(a, b, amount)
/// @desc Returns the quadratic interpolation of two input values by the given amount.
/// @param {real} a The first value.
/// @param {real} b The second value.
/// @param {real} amount The amount to interpolate.
/// @returns {real} The interpolated value.
function ease_inout_quad(_a, _b, _amount)
{
    var _c = _b - _a;
    _amount *= 2;
    
    if (_amount < 1)
    {
        return (_c * 0.5) * power(_amount, 2) + _a;
    }
    
    return (-_c * 0.5) * (--_amount * (_amount - 2) - 1) + _a;
}

// CUBIC EASING

/// @func ease_in_cubic(a, b, amount)
/// @desc Returns the cubic interpolation of two input values by the given amount.
/// @param {real} a The first value.
/// @param {real} b The second value.
/// @param {real} amount The amount to interpolate.
/// @returns {real} The interpolated value.
function ease_in_cubic(_a, _b, _amount)
{
    var _c = _b - _a;
    return _c * power(_amount, 3) + _a;
}

/// @func ease_out_cubic(a, b, amount)
/// @desc Returns the cubic interpolation of two input values by the given amount.
/// @param {real} a The first value.
/// @param {real} b The second value.
/// @param {real} amount The amount to interpolate.
/// @returns {real} The interpolated value.
function ease_out_cubic(_a, _b, _amount)
{
    var _c = _b - _a;
    return _c * (power(_amount - 1, 3) + 1) + _a;
}

/// @func ease_inout_cubic(a, b, amount)
/// @desc Returns the cubic interpolation of two input values by the given amount.
/// @param {real} a The first value.
/// @param {real} b The second value.
/// @param {real} amount The amount to interpolate.
/// @returns {real} The interpolated value.
function ease_inout_cubic(_a, _b, _amount)
{
    var _c = _b - _a;
    _amount *= 2;
    
    if (_amount < 1)
    {
        return (_c * 0.5) * power(_amount, 3) + _a;
    }
    
    return (_c * 0.5) * (power(_amount - 2, 3) + 2) + _a;
}

// QUARTIC EASING

/// @func ease_in_quart(a, b, amount)
/// @desc Returns the quartic interpolation of two input values by the given amount.
/// @param {real} a The first value.
/// @param {real} b The second value.
/// @param {real} amount The amount to interpolate.
/// @returns {real} The interpolated value.
function ease_in_quart(_a, _b, _amount)
{
    var _c = _b - _a;
    return _c * power(_amount, 4) + _a;
}

/// @func ease_out_quart(a, b, amount)
/// @desc Returns the quartic interpolation of two input values by the given amount.
/// @param {real} a The first value.
/// @param {real} b The second value.
/// @param {real} amount The amount to interpolate.
/// @returns {real} The interpolated value.
function ease_out_quart(_a, _b, _amount)
{
    var _c = _b - _a;
    return -_c * (power(_amount - 1, 4) - 1) + _a;
}

/// @func ease_inout_quart(a, b, amount)
/// @desc Returns the quartic interpolation of two input values by the given amount.
/// @param {real} a The first value.
/// @param {real} b The second value.
/// @param {real} amount The amount to interpolate.
/// @returns {real} The interpolated value.
function ease_inout_quart(_a, _b, _amount)
{
    var _c = _b - _a;
    _amount *= 2;
    
    if (_amount < 1)
    {
        return _c * 0.5 * power(_amount, 4) + _a;
    }
    
    return -_c * 0.5 * (power(_amount - 2, 4) - 2) + _a;
}

// QUINTIC EASING

/// @func ease_in_quint(a, b, amount)
/// @desc Returns the quintic interpolation of two input values by the given amount.
/// @param {real} a The first value.
/// @param {real} b The second value.
/// @param {real} amount The amount to interpolate.
/// @returns {real} The interpolated value.
function ease_in_quint(_a, _b, _amount)
{
    var _c = _b - _a;
    return _c * power(_amount, 5) + _a;
}

/// @func ease_out_quint(a, b, amount)
/// @desc Returns the quintic interpolation of two input values by the given amount.
/// @param {real} a The first value.
/// @param {real} b The second value.
/// @param {real} amount The amount to interpolate.
/// @returns {real} The interpolated value.
function ease_out_quint(_a, _b, _amount)
{
    var _c = _b - _a;
    return _c * (power(_amount - 1, 5) + 1) + _a;
}

/// @func ease_inout_quint(a, b, amount)
/// @desc Returns the quintic interpolation of two input values by the given amount.
/// @param {real} a The first value.
/// @param {real} b The second value.
/// @param {real} amount The amount to interpolate.
/// @returns {real} The interpolated value.
function ease_inout_quint(_a, _b, _amount)
{
    var _c = _b - _a;
    _amount *= 2;
    
    if (_amount < 1)
    {
        return _c * 0.5 * power(_amount, 5) + _a;
    }
    
    return _c * 0.5 * (power(_amount - 2, 5) + 2) + _a;
}

// SINUSOIDAL EASING

/// @func ease_in_sine(a, b, amount)
/// @desc Returns the sinusoidal interpolation of two input values by the given amount.
/// @param {real} a The first value.
/// @param {real} b The second value.
/// @param {real} amount The amount to interpolate.
/// @returns {real} The interpolated value.
function ease_in_sine(_a, _b, _amount)
{
    var _c = _b - _a;
    return _c * (1 - cos(_amount * (pi / 2))) + _a;
}

/// @func ease_out_sine(a, b, amount)
/// @desc Returns the sinusoidal interpolation of two input values by the given amount.
/// @param {real} a The first value.
/// @param {real} b The second value.
/// @param {real} amount The amount to interpolate.
/// @returns {real} The interpolated value.
function ease_out_sine(_a, _b, _amount)
{
    var _c = _b - _a;
    return _c * sin(_amount * (pi / 2)) + _a;
}

/// @func ease_inout_sine(a, b, amount)
/// @desc Returns the sinusoidal interpolation of two input values by the given amount.
/// @param {real} a The first value.
/// @param {real} b The second value.
/// @param {real} amount The amount to interpolate.
/// @returns {real} The interpolated value.
function ease_inout_sine(_a, _b, _amount)
{
    var _c = _b - _a;
    return _c * 0.5 * (1 - cos(pi * _amount)) + _a;
}

// EXPONENTIAL EASING

/// @func ease_in_expo(a, b, amount)
/// @desc Returns the exponential interpolation of two input values by the given amount.
/// @param {real} a The first value.
/// @param {real} b The second value.
/// @param {real} amount The amount to interpolate.
/// @returns {real} The interpolated value.
function ease_in_expo(_a, _b, _amount)
{
    if (_amount == 0)
    {
        return _a;
    }
    var _c = _b - _a;
    return _c * power(2, 10 * (_amount - 1)) + _a;
}

/// @func ease_out_expo(a, b, amount)
/// @desc Returns the exponential interpolation of two input values by the given amount.
/// @param {real} a The first value.
/// @param {real} b The second value.
/// @param {real} amount The amount to interpolate.
/// @returns {real} The interpolated value.
function ease_out_expo(_a, _b, _amount)
{
    if (_amount == 1)
    {
        return _b;
    }
    var _c = _b - _a;
    return _c * (-power(2, -10 * _amount) + 1) + _a;
}

/// @func ease_inout_expo(a, b, amount)
/// @desc Returns the exponential interpolation of two input values by the given amount.
/// @param {real} a The first value.
/// @param {real} b The second value.
/// @param {real} amount The amount to interpolate.
/// @returns {real} The interpolated value.
function ease_inout_expo(_a, _b, _amount)
{
    if (_amount == 0)
    {
        return _a;
    }
    if (_amount == 1)
    {
        return _b;
    }
    var _c = _b - _a;
    _amount *= 2;
    
    if (_amount < 1)
    {
        return _c * 0.5 * power(2, 10 * (_amount - 1)) + _a;
    }
    
    --_amount;
    return _c * 0.5 * (-power(2, -10 * _amount) + 2) + _a;
}

// CIRCULAR EASING

/// @func ease_in_circ(a, b, amount)
/// @desc Returns the circular interpolation of two input values by the given amount.
/// @param {real} a The first value.
/// @param {real} b The second value.
/// @param {real} amount The amount to interpolate.
/// @returns {real} The interpolated value.
function ease_in_circ(_a, _b, _amount)
{
    var _c = _b - _a;
    return _c * (1 - sqrt(1 - power(_amount, 2))) + _a;
}

/// @func ease_out_circ(a, b, amount)
/// @desc Returns the circular interpolation of two input values by the given amount.
/// @param {real} a The first value.
/// @param {real} b The second value.
/// @param {real} amount The amount to interpolate.
/// @returns {real} The interpolated value.
function ease_out_circ(_a, _b, _amount)
{
    var _c = _b - _a;
    return _c * sqrt(1 - power(_amount - 1, 2)) + _a;
}

/// @func ease_inout_circ(a, b, amount)
/// @desc Returns the circular interpolation of two input values by the given amount.
/// @param {real} a The first value.
/// @param {real} b The second value.
/// @param {real} amount The amount to interpolate.
/// @returns {real} The interpolated value.
function ease_inout_circ(_a, _b, _amount)
{
    var _c = _b - _a;
    _amount *= 2;
    
    if (_amount < 1)
    {
        return _c * 0.5 * (1 - sqrt(1 - power(_amount, 2))) + _a;
    }
    
    return _c * 0.5 * (sqrt(1 - power(_amount - 2, 2)) + 1) + _a;
}

// ELASTIC EASING

/// @func ease_in_elastic(a, b, amount, [amplitude], [period])
/// @desc Returns the elastic interpolation of two input values by the given amount.
/// @param {real} a The first value.
/// @param {real} b The second value.
/// @param {real} amount The amount to interpolate.
/// @param {real} amplitude[OPTIONAL] The amplitude of the elastic bounce. Defaults to the change in value.
/// @param {real} period[OPTIONAL] The period of the elastic bounce. Defaults to 0.3.
/// @returns {real} The interpolated value.
function ease_in_elastic(_a, _b, _amount, _amplitude = undefined, _period = 0.3)
{
    var _c = _b - _a;
    
    if (_amount == 0 || _c == 0)
    {
        return _a;
    }
    if (_amount == 1)
    {
        return _a + _c;
    }
    
    var _s;
    if (_amplitude == undefined || _amplitude < abs(_c))
    {
        _amplitude = _c;
        _s = _period * 0.25;
    }
    else
    {
        _s = _period / (2 * pi) * arcsin(_c / _amplitude);
    }
    
    _amount--;
    return -(_amplitude * power(2, 10 * _amount) * sin((_amount - _s) * (2 * pi) / _period)) + _a;
}

/// @func ease_out_elastic(a, b, amount, [amplitude], [period])
/// @desc Returns the elastic interpolation of two input values by the given amount.
/// @param {real} a The first value.
/// @param {real} b The second value.
/// @param {real} amount The amount to interpolate.
/// @param {real} amplitude[OPTIONAL] The amplitude of the elastic bounce. Defaults to the change in value.
/// @param {real} period[OPTIONAL] The period of the elastic bounce. Defaults to 0.3.
/// @returns {real} The interpolated value.
function ease_out_elastic(_a, _b, _amount, _amplitude = undefined, _period = 0.3)
{
    var _c = _b - _a;
    
    if (_amount == 0 || _c == 0)
    {
        return _a;
    }
    if (_amount == 1)
    {
        return _a + _c;
    }
    
    var _s;
    if (_amplitude == undefined || _amplitude < abs(_c))
    {
        _amplitude = _c;
        _s = _period * 0.25;
    }
    else
    {
        _s = _period / (2 * pi) * arcsin(_c / _amplitude);
    }
    
    return _amplitude * power(2, -10 * _amount) * sin((_amount - _s) * (2 * pi) / _period) + _c + _a;
}

/// @func ease_inout_elastic(a, b, amount, [amplitude], [period])
/// @desc Returns the elastic interpolation of two input values by the given amount.
/// @param {real} a The first value.
/// @param {real} b The second value.
/// @param {real} amount The amount to interpolate.
/// @param {real} amplitude[OPTIONAL] The amplitude of the elastic bounce. Defaults to the change in value.
/// @param {real} period[OPTIONAL] The period of the elastic bounce. Defaults to 0.45.
/// @returns {real} The interpolated value.
function ease_inout_elastic(_a, _b, _amount, _amplitude = undefined, _period = 0.45)
{
    var _c = _b - _a;
    
    if (_amount == 0 || _c == 0)
    {
        return _a;
    }
    
    _amount *= 2;
    if (_amount == 2)
    {
        return _a + _c;
    }
    
    var _s;
    if (_amplitude == undefined || _amplitude < abs(_c))
    {
        _amplitude = _c;
        _s = _period * 0.25;
    }
    else
    {
        _s = _period / (2 * pi) * arcsin(_c / _amplitude);
    }
    
    _amount--;
    if (_amount < 0)
    {
        return -0.5 * (_amplitude * power(2, 10 * _amount) * sin((_amount - _s) * (2 * pi) / _period)) + _a;
    }
    
    return _amplitude * power(2, -10 * _amount) * sin((_amount - _s) * (2 * pi) / _period) * 0.5 + _c + _a;
}

// BACK EASING

/// @func ease_in_back(a, b, amount, [overshoot])
/// @desc Returns the overshooting cubic interpolation of two input values by the given amount.
/// @param {real} a The first value.
/// @param {real} b The second value.
/// @param {real} amount The amount to interpolate.
/// @param {real} overshoot[OPTIONAL] The amount of overshoot. Defaults to 1.70158.
/// @returns {real} The interpolated value.
function ease_in_back(_a, _b, _amount, _overshoot = 1.70158)
{
    var _c = _b - _a;
    return _c * power(_amount, 2) * ((_overshoot + 1) * _amount - _overshoot) + _a;
}

/// @func ease_out_back(a, b, amount, [overshoot])
/// @desc Returns the overshooting cubic interpolation of two input values by the given amount.
/// @param {real} a The first value.
/// @param {real} b The second value.
/// @param {real} amount The amount to interpolate.
/// @param {real} overshoot[OPTIONAL] The amount of overshoot. Defaults to 1.70158.
/// @returns {real} The interpolated value.
function ease_out_back(_a, _b, _amount, _overshoot = 1.70158)
{
    var _c = _b - _a;
    _amount -= 1;
    return _c * (power(_amount, 2) * ((_overshoot + 1) * _amount + _overshoot) + 1) + _a;
}

/// @func ease_inout_back(a, b, amount, [overshoot])
/// @desc Returns the overshooting cubic interpolation of two input values by the given amount.
/// @param {real} a The first value.
/// @param {real} b The second value.
/// @param {real} amount The amount to interpolate.
/// @param {real} overshoot[OPTIONAL] The amount of overshoot. Defaults to 1.70158.
/// @returns {real} The interpolated value.
function ease_inout_back(_a, _b, _amount, _overshoot = 1.70158)
{
    var _c = _b - _a;
    _amount *= 2;
    
    if (_amount < 1)
    {
        _overshoot *= 1.525;
        return _c * 0.5 * (power(_amount, 2) * ((_overshoot + 1) * _amount - _overshoot)) + _a;
    }
    
    _amount -= 2;
    _overshoot *= 1.525;
    return _c * 0.5 * (power(_amount, 2) * ((_overshoot + 1) * _amount + _overshoot) + 2) + _a;
}

// BOUNCE EASING

/// @func ease_in_bounce(a, b, amount)
/// @desc Returns the bounce-like interpolation of two input values by the given amount.
/// @param {real} a The first value.
/// @param {real} b The second value.
/// @param {real} amount The amount to interpolate.
/// @returns {real} The interpolated value.
function ease_in_bounce(_a, _b, _amount)
{
    var _c = _b - _a;
    return _c - ease_out_bounce(0, _b, 1 - _amount) + _a;
}

/// @func ease_out_bounce(a, b, amount)
/// @desc Returns the bounce-like interpolation of two input values by the given amount.
/// @param {real} a The first value.
/// @param {real} b The second value.
/// @param {real} amount The amount to interpolate.
/// @returns {real} The interpolated value.
function ease_out_bounce(_a, _b, _amount)
{
    var _c = _b - _a;
    
    if (_amount < (1 / 2.75))
    {
        return _c * (7.5625 * power(_amount, 2)) + _a;
    }
    else if (_amount < (2 / 2.75))
    {
        _amount -= (1.5 / 2.75);
        return _c * (7.5625 * power(_amount, 2) + 0.75) + _a;
    }
    else if (_amount < (2.5 / 2.75))
    {
        _amount -= (2.25 / 2.75);
        return _c * (7.5625 * power(_amount, 2) + 0.9375) + _a;
    }
    else
    {
        _amount -= (2.625 / 2.75);
        return _c * (7.5625 * power(_amount, 2) + 0.984375) + _a;
    }
}

/// @func ease_inout_bounce(a, b, amount)
/// @desc Returns the bounce-like interpolation of two input values by the given amount.
/// @param {real} a The first value.
/// @param {real} b The second value.
/// @param {real} amount The amount to interpolate.
/// @returns {real} The interpolated value.
function ease_inout_bounce(_a, _b, _amount)
{
    var _c = _b - _a;
    
    if (_amount < 0.5)
    {
        return (ease_in_bounce(0, _b, _amount * 2) * 0.5) + _a;
    }
    
    return (ease_out_bounce(0, _b, _amount * 2 - 1) * 0.5 + _c * 0.5) + _a;
} 