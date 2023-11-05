import math

struct XYZ {
	x f64
	y f64
	z f64
}

fn (x XYZ) cielab() CIELAB {
	mut value := 0.0

	var_x := x.x / 95.0489 // standard illuminant D65
	var_y := x.y / 100.0
	var_z := x.z / 108.8840

	mut xyz := [var_x, var_y, var_z]
	for j in 0 .. xyz.len {
		value = xyz[j]
		if value > 0.008856 {
			value = math.pow(value, 1.0 / 3.0)
		} else {
			value = (7.787 * value) + (16.0 / 116.0)
		}
		xyz[j] = value
	}

	return CIELAB{
		l: int(math.round(116.0 * xyz[1]) - 16.0)
		a: int(math.round(500.0 * (xyz[0] - xyz[1])))
		b: int(math.round(200.0 * (xyz[1] - xyz[2])))
	}
}

fn fix(f f64) int {
	return int(math.round(f))
}

fn (xyz XYZ) rgb() RGB {
	x := xyz.x / 100 // X from 0 to 95.047
	y := xyz.y / 100 // Y from 0 to 100.000
	z := xyz.z / 100 // Z from 0 to 108.883

	mut r := x * 3.2406 + y * -1.5372 + z * -0.4986
	mut g := x * -0.9689 + y * 1.8758 + z * 0.0415
	mut b := x * 0.0557 + y * -0.2040 + z * 1.0570

	if r > 0.0031308 {
		r = 1.055 * (math.pow(r, 0.41666667)) - 0.055
	} else {
		r *= 12.92
	}

	if g > 0.0031308 {
		g = 1.055 * (math.pow(g, 0.41666667)) - 0.055
	} else {
		g *= 12.92
	}

	if b > 0.0031308 {
		b = 1.055 * (math.pow(b, 0.41666667)) - 0.055
	} else {
		b *= 12.92
	}

	r *= 255
	g *= 255
	b *= 255

	return RGB{
		r: fix(r)
		g: fix(g)
		b: fix(b)
	}
}

fn gamma_adobe(c f64) f64 {
	if c <= 0.0 {
		return 0.0
	}
	return math.pow(c, 1 / 2.19921875)
}

fn (xyz XYZ) adobergb() AdobeRGB {
	x := xyz.x / 100
	y := xyz.y / 100
	z := xyz.z / 100

	rlin := x * 2.04159 + y * -0.56501 + z * -0.34473
	glin := x * -0.96924 + y * 1.87597 + z * 0.04156
	blin := x * 0.01344 + y * -0.11836 + z * 1.01517
	return AdobeRGB{
		r: fix(255 * gamma_adobe(rlin))
		g: fix(255 * gamma_adobe(glin))
		b: fix(255 * gamma_adobe(blin))
	}
}
