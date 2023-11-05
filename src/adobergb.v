module main

import math

pub struct AdobeRGB {
pub:
	r int [required]
	g int [required]
	b int [required]
	a f64 [optional] = 1 // optional but ideal
}

fn linear_adobe(c f64) f64 {
	if c <= 0.0 {
		return 0.0
	}
	return math.pow(c, 2.19921875)
}

fn (a AdobeRGB) xyz() XYZ {
	rlin := linear_adobe(f64(a.r) / 255.0) * 100
	glin := linear_adobe(f64(a.g) / 255.0) * 100
	blin := linear_adobe(f64(a.b) / 255.0) * 100
	x := rlin * 0.57667 + glin * 0.18556 + blin * 0.18823
	y := rlin * 0.29734 + glin * 0.62736 + blin * 0.07529
	z := rlin * 0.02703 + glin * 0.07069 + blin * 0.99134

	return XYZ{
		x: x
		y: y
		z: z
	}
}

pub fn adobergb(r int, g int, b int) AdobeRGB {
	return AdobeRGB{
		r: r
		g: g
		b: b
	}
}

pub fn adobergba(r int, g int, b int, a f64) AdobeRGB {
	return AdobeRGB{
		r: r
		g: g
		b: b
		a: round2dp(a)
	}
}

pub fn (a AdobeRGB) rgb() RGB {
	n := a.xyz().rgb() // no alpha
	return rgba(n.r, n.g, n.b, a.a)
}

pub fn (a AdobeRGB) cmyk() CMYK {
	return a.rgb().cmyk()
}

pub fn (a AdobeRGB) hex() HEX {
	return a.rgb().hex()
}

pub fn (a AdobeRGB) cielab() CIELAB {
	return a.rgb().cielab()
}

pub fn (a AdobeRGB) hsl() HSL {
	return a.rgb().hsl()
}
