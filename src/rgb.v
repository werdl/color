module color

import math
import term

// NOTE!
// This project uses sRGB, not AdobeRGB, at least by default

pub struct RGB {
pub mut:
	r int [required]
	g int [required]
	b int [required]
	a f64 [optional] = 1 // optional but ideal
}

pub fn rgb(r int, g int, b int) RGB {
	return RGB{
		r: r
		g: g
		b: b
	}.normal()
}

pub fn rgba(r int, g int, b int, a f64) RGB {
	return RGB{
		r: r
		g: g
		b: b
		a: round2dp(a)
	}.normal()
}

fn (bits RGB) cmyk_() !CMYK {
	// Normalize RGB values
	r := f64(bits.r) / 255.0
	g := f64(bits.g) / 255.0
	b := f64(bits.b) / 255.0
	// Find maximum RGB value
	max_rgb := math.max(r, math.max(g, b))
	// Special case for white
	if r == 1.0 && g == 1.0 && b == 1.0 {
		return CMYK{
			c: 0
			m: 0
			y: 0
			k: 0
		}
	}
	// Calculate K value
	k := 1.0 - max_rgb
	// Avoid division by zero
	if r > 1e-9 || g > 1e-9 || b > 1e-9 {
		// Calculate CMY values
		c := (1.0 - r - k) / (1.0 - k)
		m := (1.0 - g - k) / (1.0 - k)
		y := (1.0 - b - k) / (1.0 - k)
		// Scale CMY values and convert to percentages
		return CMYK{
			c: int(c * 100.0)
			m: int(m * 100.0)
			y: int(y * 100.0)
			k: int(k * 100.0)
		}.normal()
	}
	// Handle the case where K is close to 1
	return CMYK{
		c: int(r * 100)
		m: int(g * 100)
		y: int(b * 100)
		k: int(k * 100)
	}.normal()
}

pub fn (r RGB) cmyk() CMYK {
	return r.cmyk_() or {
		CMYK{
			c: 0
			m: 0
			y: 0
			k: 0
		}
	}
}

pub fn (r RGB) hex() HEX {
	return HEX{
		data: '#${r.r.hex()}${r.g.hex()}${r.b.hex()}${int(r.a * 255).hex()}'
	}.normal()
}

pub fn (r RGB) fmt(s string) string {
	return term.rgb(r.r, r.g, r.b, s)
}

pub fn (rgb RGB) hsl() HSL {
	r := f64(rgb.r) / 255.0
	g := f64(rgb.g) / 255.0
	b := f64(rgb.b) / 255.0
	cmax := math.max(r, math.max(g, b))
	cmin := math.min(r, math.min(g, b))
	delta := cmax - cmin
	mut hue := 0
	if delta == 0.0 {
		hue = 0
	} else if cmax == r {
		hue = int(60.0 * ((g - b) / math.fmod(delta, 6.0)))
	} else if cmax == g {
		hue = int(60.0 * ((b - r) / delta + 2.0))
	} else {
		hue = int(60.0 * ((r - g) / delta + 4.0))
	}
	saturation := match delta {
		0 {
			0
		}
		else {
			int((delta / (1.0 - math.abs(cmax + cmin - 1.0))) * 100)
		}
	}
	lightness := int(((cmax + cmin) / 2.0) * 100)
	return HSL{
		h: hue
		s: saturation
		l: lightness
		a: rgb.a
	}.normal()
}

pub fn (rgb RGB) xyz() XYZ {
	mut r := f64(rgb.r) / 255
	mut g := f64(rgb.g) / 255
	mut b := f64(rgb.b) / 255

	if r > 0.04045 {
		r = math.pow(((r + 0.055) / 1.055), 2.4)
	} else {
		r = r / 12.92
	}

	if g > 0.04045 {
		g = math.pow(((g + 0.055) / 1.055), 2.4)
	} else {
		g = g / 12.92
	}

	if b > 0.04045 {
		b = math.pow(((b + 0.055) / 1.055), 2.4)
	} else {
		b = b / 12.92
	}

	r *= 100
	g *= 100
	b *= 100

	// Observer = 2°, Illuminant = D65
	x := r * 0.4124 + g * 0.3576 + b * 0.1805
	y := r * 0.2126 + g * 0.7152 + b * 0.0722
	z := r * 0.0193 + g * 0.1192 + b * 0.9505

	return XYZ{
		x: x
		y: y
		z: z
	}
}

pub fn (r RGB) cielab() CIELAB {
	return r.xyz().cielab()
}

pub fn (r RGB) adobergb() AdobeRGB {
	n := r.xyz().adobergb() // no alpha
	return adobergba(n.r, n.g, n.b, r.a)
}

pub fn (r RGB) lch() LCH {
	return r.cielab().lch()
}

pub fn (rgb RGB) normal() RGB {
	mut r := rgb
	r.r = normalise(r.r, 0, 255)
	r.g = normalise(r.g, 0, 255)
	r.b = normalise(r.b, 0, 255)

	return r
}
