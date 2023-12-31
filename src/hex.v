module color

pub struct HEX {
pub mut:
	data string
}

pub fn hex_s(s string) HEX {
	match s.len {
		7 {
			return HEX{
				data: s
			}.normal()
		}
		9 {
			return HEX{
				data: s
			}.normal()
		}
		6 {
			return HEX{
				data: '#' + s
			}.normal()
		}
		8 {
			return HEX{
				data: '#' + s
			}.normal()
		}
		else {
			return HEX{
				data: '#000000'
			}.normal()
		}
	}
}

fn pad(s string) string {
	mut out := ''
	if s.len == 3 {
		for c in s {
			out += c.ascii_str().repeat(2)
		}
	} else if s.len > 8 {
		out = s[..8]
	} else if s.len == 8 {
		out = s
	} else if s.len >= 6 {
		out = s[..6]
	} else {
		out = '0'.repeat(6 - s.len) + s
	}
	return out
}

fn hex_(i int) !HEX {
	return HEX{
		data: '#${pad(i.hex())}'
	}.normal()
}

pub fn hex(i int) HEX {
	return hex_(i) or { hex_s('#000000') }
}

pub fn (h HEX) int() !int {
	return int(h.data[1..].parse_int(16, 0)!)
}

fn (h HEX) rgb_() !RGB {
	if (h.data.len != 7 && h.data.len != 9) || h.data[0] != `#` {
		return RGB{
			r: 0
			b: 0
			g: 0
		}
	}

	r := h.data[1..3].parse_int(16, 0)!
	g := h.data[3..5].parse_int(16, 0)!
	b := h.data[5..7].parse_int(16, 0)!
	if h.data.len == 7 {
		return RGB{
			r: int(r)
			g: int(g)
			b: int(b)
		}
	} else {
		return RGB{
			r: int(r)
			g: int(g)
			b: int(b)
			a: round2dp(f64(h.data[7..9].parse_int(16, 0)!) / 255.0)
		}.normal()
	}
}

pub fn (h HEX) rgb() RGB {
	return h.rgb_() or {
		RGB{
			r: 0
			b: 0
			g: 0
		}
	}
}

pub fn (h HEX) cmyk() CMYK {
	return h.rgb().cmyk()
}

pub fn (h HEX) hsl() HSL {
	return h.rgb().hsl()
}

pub fn (h HEX) fmt(s string) string {
	return h.rgb().fmt(s)
}

pub fn (h HEX) cielab() CIELAB {
	return h.rgb().cielab()
}

pub fn (h HEX) adobergb() AdobeRGB {
	return h.rgb().adobergb()
}

pub fn (h HEX) lch() LCH {
	return h.cielab().lch()
}

fn zpad(s string) string {
	if s.len == 1 {
		return '0${s}'
	} else if s.len == 2 {
		return s
	} else {
		return '00'
	}
}

pub fn (he HEX) normal_() !HEX {
	mut h := HEX{
		data: '#'
	}
	h.data += zpad(normalise(int(he.data[1..3].parse_int(16, 0)!), 0, 255).hex())
	h.data += zpad(normalise(int(he.data[3..5].parse_int(16, 0)!), 0, 255).hex())
	h.data += zpad(normalise(int(he.data[5..7].parse_int(16, 0)!), 0, 255).hex())
	return h
}

pub fn (h HEX) normal() HEX {
	return h.normal_() or { hex(0x000000) }
}
