## color
- A V library for working with colors
- Support for
> - sRGB(A)
> - HSL(A)
> - CMYK
> - Hex (with optional alpha)
> - CIELAB
> - AdobeRGB(A)
> - LCH
### Usage
`v install werdl.color`

```v
import color 

fn main() {
    rgb:=color.rgb(160,225,43)
    println(rgb.cmyk())

    println(rgb.hex())

}
```
```v
// A list of all methods

// Constructors
rgb(r int, g int, b int) -> RGB
rgba(r int, g int, b int, a f64) -> RGB

hsl(h int, s int, b int) -> HSL
hsla(h int, s int, b int, a int) -> HSL

adobergb(r int, g int, b int) -> AdobeRGB // normalised to 255
adobergba(r int, g int, b int, a f64) -> AdobeRGB

cmyk(c int, m int, y int, k int) -> CMYK

cielab(l f64, a f64, b f64) -> CIELAB

lch(l f64, c f64, h f64) -> LCH

hex(x int) -> HEX // 3, 6 or 8 digit hex number
hex_s(s string) -> HEX // same spec

// Conversion
RGB.adobergb()
RGB.cielab()
RGB.cmyk()
RGB.hex()
RGB.hsl()
RGB.lch()

HSL.adobergb()
HSL.cielab()
HSL.cmyk()
HSL.hex()
HSL.lch()
HSL.rgb()

AdobeRGB.cielab()
AdobeRGB.cmyk()
AdobeRGB.hex()
AdobeRGB.hsl()
AdobeRGB.lch()
AdobeRGB.rgb()

CMYK.adobergb()
CMYK.cielab()
CMYK.hex()
CMYK.hsl()
CMYK.lch()
CMYK.rgb()

CIELAB.adobergb()
CIELAB.cmyk()
CIELAB.hex()
CIELAB.hsl()
CIELAB.lch()
CIELAB.rgb()

LCH.adobergb()
LCH.cielab()
LCH.cmyk()
LCH.hex()
LCH.hsl()
LCH.rgb()

HEX.adobergb()
HEX.cielab()
HEX.cmyk()
HEX.hsl()
HEX.lch()
HEX.rgb()

// access

HEX.int()
RGB.r
RGB.g
RGB.b // etc.

CIELAB.l
CIELAB.a
CIELAB.b // etc.
```
### XYZ tristimulus values
- We use Illuminant D65 with the standard 2° observer

$X_n=95.0455927$

$Y_n=100.0$

$Z_n=108.905775$
### Note
- This library involves conversion between different color types (obviously), including non-linear conversion.
- That means that while it is fairly accurate, it is not perfect!
- To avoid this as far as possible, try to use RGB as the medium, which has the actual calculations between the complicated formats!
