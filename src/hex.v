module main

pub struct HEX {
	pub:
		data string
}

pub fn hex(s string) HEX {
	return HEX{
		data: s
	}
}

fn (h HEX) rgb_() !RGB {
	if h.data.len != 7 || h.data[0] != `#` {
		return RGB{
			r: 0,
			b: 0,
			g: 0
		}
	}

    r := h.data[1..3].parse_int(16, 0)!
    g := h.data[3..5].parse_int(16, 0)!
    b := h.data[5..7].parse_int(16, 0)!

    return RGB{r: int(r), g: int(g), b: int(b)}
}
pub fn (h HEX) rgb() RGB {
	return h.rgb_() or { 
		RGB{
			r: 0,
			b: 0,
			g: 0
		}
	}
}

pub fn (h HEX) cmyk() CMYK {
	return h.rgb().cmyk()
}