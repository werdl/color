import math

/*
Which CIELAB constants do we use?
    x - 95.047
    y - 100.0
    z - 108.883
*/

pub struct CIELAB {
	l int
	a int
	b int
}

pub fn (c CIELAB) xyz() XYZ {
	mut y := (f64(c.l) + 16.0) / 116.0
	mut x := f64(c.a) / 500.0 + y
	mut z := y - f64(c.b) / 200.0

	if math.pow(y, 3) > 0.008856 {
		y = math.pow(y, 3)
	} else {
		y = (y - 0.137931034) / 7.787
	}

	if math.pow(x, 3) > 0.008856 {
		x = math.pow(x, 3)
	} else {
		x = (x - 0.137931034) / 7.787
	}

	if math.pow(z, 3) > 0.008856 {
		z = math.pow(z, 3)
	} else {
		z = (z - 0.137931034) / 7.787
	}

	// Observer = 2°, Illuminant = D65
	x *= 95.047
	y *= 100.000
	z *= 108.883

	return XYZ{
		x: x
		y: y
		z: z
	}
}

pub fn (c CIELAB) rgb() RGB {
	return c.xyz().rgb()
}

pub fn (c CIELAB) adobergb() AdobeRGB {
	return c.rgb().adobergb()
}

pub fn (c CIELAB) hsl() HSL {
	return c.rgb().hsl()
}

pub fn (c CIELAB) cmyk() CMYK {
	return c.rgb().cmyk()
}

pub fn (c CIELAB) hex() HEX {
	return c.rgb().hex()
}
