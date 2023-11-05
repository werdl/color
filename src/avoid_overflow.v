module main

fn intoverflow(f f64) int {
	i := int(f)
	if f64(i).eq_epsilon(f) {
		return i
	} else {
		return 0
	}
}
