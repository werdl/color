module main

import math

pub struct RGB{
    pub:
        r int
        g int
        b int
}

pub fn rgb(r int, g int, b int) RGB {
	return RGB{
		r: r,
		g: g,
		b: b
	}
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
        return CMYK{c: 0, m: 0, y: 0, k: 0}
    }
    // Calculate K value
    k := 1.0 - max_rgb
    // Avoid division by zero
    if math.abs(k) > 1e-9 {
        // Calculate CMY values
        c := (1.0 - r - k) / (1.0 - k)
        m := (1.0 - g - k) / (1.0 - k)
        y := (1.0 - b - k) / (1.0 - k)
        // Scale CMY values and convert to percentages
        return CMYK{
            c: intoverflow(c * 100.0),
            m: intoverflow(m * 100.0),
            y: intoverflow(y * 100.0),
            k: intoverflow(k * 100.0),
        }
    }
    // Handle the case where K is close to 1
    return CMYK{
        c: intoverflow(r*100), 
        m: intoverflow(g*100), 
        y: intoverflow(b*100), 
        k: intoverflow(k*100)
    }
}
pub fn (r RGB) cmyk() CMYK {
	return r.cmyk_() or { 
        CMYK{
            c: 0,
            m: 0,
            y: 0,
            k: 0
        } 
    }
}
pub fn (r RGB) hex() HEX {
	return HEX{
		data: "#${r.r.hex()}${r.g.hex()}${r.b.hex()}"
	}
}