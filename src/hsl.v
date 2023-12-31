module color

pub struct HSL {
pub mut:
	h int [required]
	s int [required]
	l int [required]
	a f64 [optional] = 1.0 // optional but ideal
}

fn hue_to_rgb(p f64, q f64, to f64) int {
	t := if to < 0.0 {
		to + 1.0
	} else if to > 1.0 {
		to - 1.0
	} else {
		to
	}

	ct := 6.0 * t

	if ct < 1.0 {
		return int((p + (q - p) * ct) * 255.0)
	} else if ct < 3.0 {
		return int(q * 255.0)
	} else if ct < 4.0 {
		return int((p + (q - p) * (4.0 - ct)) * 255.0)
	} else {
		return int(p * 255.0)
	}
}

pub fn hsl(h int, s int, l int) HSL {
	return HSL{
		h: h
		s: s
		l: l
	}.normal()
}

pub fn hsla(h int, s int, l int, a f64) HSL {
	return HSL{
		h: h
		s: s
		l: l
		a: round2dp(a)
	}.normal()
}

pub fn (hsl HSL) rgb() RGB {
	h := f64(hsl.h)
	s := f64(hsl.s) / 100.0
	l := f64(hsl.l) / 100.0

	if s == 0.0 {
		// Achromatic (grayscale)
		gray_value := int(l * 255.0)
		return RGB{
			r: gray_value
			g: gray_value
			b: gray_value
		}.normal()
	}

	q := if l < 0.5 {
		l * (1.0 + s)
	} else {
		l + s - l * s
	}

	p := 2.0 * l - q

	return RGB{
		r: hue_to_rgb(p, q, (h + 120.0) / 360.0)
		g: hue_to_rgb(p, q, h / 360.0)
		b: hue_to_rgb(p, q, (h - 120.0) / 360.0)
		a: hsl.a
	}.normal()
}

pub fn (hsl HSL) cmyk() CMYK {
	return hsl.rgb().cmyk()
}

pub fn (hsl HSL) hex() HEX {
	return hsl.rgb().hex()
}

pub fn (hsl HSL) cielab() CIELAB {
	return hsl.rgb().cielab()
}

pub fn (hsl HSL) adobergb() AdobeRGB {
	return hsl.rgb().adobergb()
}

pub fn (hsl HSL) lch() LCH {
	return hsl.cielab().lch()
}

pub fn (hs HSL) normal() HSL {
	mut h := hs

	h.h = normalise(h.h, 0, 360)
	h.s = normalise(h.s, 0, 100)
	h.l = normalise(h.l, 0, 100)

	return h
}
