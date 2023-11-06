module color

pub struct CMYK {
pub mut:
	c int [required]
	m int [required]
	y int [required]
	k int [required]
}

pub fn cmyk(c int, m int, y int, k int) CMYK {
	return CMYK{
		c: c
		m: m
		y: y
		k: k
	}.normal()
}

pub fn (bits CMYK) rgb() RGB {
	// Scale CMY values to the 0-1 range
	c := f64(bits.c) / 100.0
	m := f64(bits.m) / 100.0
	y := f64(bits.y) / 100.0
	k := f64(bits.k) / 100.0

	// Calculate RGB values
	r := (1.0 - c) * (1.0 - k)
	g := (1.0 - m) * (1.0 - k)
	b := (1.0 - y) * (1.0 - k)

	// Scale RGB values to the 0-255 range
	return RGB{
		r: int(r * 255.0)
		g: int(g * 255.0)
		b: int(b * 255.0)
	}.normal()
}

pub fn (bits CMYK) hex() HEX {
	return bits.rgb().hex()
}

pub fn (c CMYK) hsl() HSL {
	return c.rgb().hsl()
}

pub fn (c CMYK) fmt(s string) string {
	return c.rgb().fmt(s)
}

pub fn (c CMYK) cielab() CIELAB {
	return c.rgb().cielab()
}

pub fn (c CMYK) lch() LCH {
	return c.cielab().lch()
}

pub fn (cm CMYK) normal() CMYK {
	mut c := cm
	c.c = normalise(c.c, 0, 100)
	c.m = normalise(c.m, 0, 100)
	c.y = normalise(c.y, 0, 100)
	c.k = normalise(c.k, 0, 100)

	return c
}
