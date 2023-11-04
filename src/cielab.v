// WIP

import math

pub struct CIELAB {
    l int
    a int
    b int
}

pub fn (rgb RGB) cielab() CIELAB {
    // RGB to XYZ conversion
    xyz := rgb.xyz()
    // XYZ to CIELAB conversion
    cielab := xyz_to_cielab(xyz)

    return cielab
}

fn (rgb RGB) xyz() []f64 {
    r := gamma_correct(f64(rgb.r) / 255.0)
    g := gamma_correct(f64(rgb.g) / 255.0)
    b := gamma_correct(f64(rgb.b) / 255.0)

    // Apply RGB to XYZ transformation matrix
    x := 0.4124564*r + 0.3575761*g + 0.1804375*b
    y := 0.2126729*r + 0.7151522*g + 0.0721750*b
    z := 0.0193339*r + 0.1191920*g + 0.9503041*b

    return [x, y, z]
}

fn gamma_correct(value f64) f64 {
    if value > 0.04045 {
        return math.pow(((value + 0.055) / 1.055),2.4)
    } else {
        return value / 12.92
    }
}
fn cie_cube_root(t f64) f64 {
    if t > 0.008856 {
        return math.pow(t,(1.0 / 3.0))
    } else {
        return 903.3 * t
    }
}
fn xyz_to_cielab(list []f64) CIELAB {
	mut x:=list[0]
	mut y:=list[1]
	mut z:=list[2]


    x /= 95.047
    y /= 100.0
    z /= 108.883

    x = cie_cube_root(x)
    y = cie_cube_root(y)
    z = cie_cube_root(z)

    l := int(116*y - 16)
    a := int((x - y) * 500)
    b := int((y - z) * 200)

    return CIELAB{l: l, a: a, b: b}
}

