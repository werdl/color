module color

import math

/*
Which CIELAB constants do we use?
    x - 95.047
    y - 100.0
    z - 108.883
*/

pub struct CIELAB {
pub mut:
	l f64
	a f64
	b f64
}

pub fn (c CIELAB) xyz() XYZ {
	mut y := ((c.l) + 16.0) / 116.0
	mut x := (c.a) / 500.0 + y
	mut z := y - (c.b) / 200.0

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

	xn, yn, zn := d65()
	// Observer = 2°, Illuminant = D65
	x *= xn
	y *= yn
	z *= zn

	return XYZ{
		x: x
		y: y
		z: z
	}
}

pub fn (c CIELAB) fmt(s string) string {
	return c.rgb().fmt(s)
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

pub fn (c CIELAB) lch() LCH {
	return LCH{
		l: c.l
		c: (math.hypot((c.a), (c.b)))
		h: (math.atan2((c.b), (c.a)) * 360.0 / math.tau)
	}.normal()
}

pub fn (ci CIELAB) normal() CIELAB {
	mut c := ci

	c.l = normalfse(c.l, 0, 100)
	c.a = normalfse(c.a, -128, 128)
	c.b = normalfse(c.b, -128, 128)

	return c
}
