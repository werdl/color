module color

fn intoverflow(f f64) int {
	i := int(f)
	if f64(i).eq_epsilon(f) {
		return i
	} else {
		return 0
	}
}


fn normalise(x int, min int, max int) int {
	if x>max {
		return max
	} else if x<min {
		return min
	} else {
		return x
	}
}