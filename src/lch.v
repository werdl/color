module color

import math

struct LCH {
pub mut:
	l f64
	c f64
	h f64
}

pub fn (l LCH) cielab() CIELAB {
	h_rad := (l.h) * math.tau / 360.0
	return CIELAB{
		l: l.l
		a: (l.c * math.cos(h_rad))
		b: (l.h * math.sin(h_rad))
	}.normal()
}

pub fn (l LCH) fmt(s string) string {
	return l.rgb().fmt(s)
}

pub fn (l LCH) rgb() RGB {
	return l.cielab().rgb()
}

pub fn (l LCH) cmyk() CMYK {
	return l.cielab().cmyk()
}

pub fn (l LCH) hsl() HSL {
	return l.cielab().hsl()
}

pub fn (l LCH) hex() HEX {
	return l.cielab().hex()
}

pub fn (l LCH) adobergb() AdobeRGB {
	return l.cielab().adobergb()
}

pub fn (lc LCH) normal() LCH {
	mut l := lc
	l.l = normalfse(l.l, 0, 100)
	l.c = normalfse(l.c, 0, 128)
	l.h = normalfse(l.h, 0, 360)

	return l
}
