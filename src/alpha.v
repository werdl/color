module color

import math

pub fn is_alpha(a f64) bool {
	return a >= 0 && a <= 1
}

pub fn round2dp(x f64) f64 {
	if x == 1.0 {
		return 1.0
	} else {
		return math.round_sig(x, 2)
	}
}
