## color
- A V library for working with colors
- Support for
> - RGB(A)
> - HSL(A)
> - CMYK
> - Hex (with alpha)
### Usage
`v install werdl.color`

```v
import color { RGB, CMYK, HEX, HSL, rgb, cmyk, hex, hsl }

fn main() {
    rgb:=rgb(160,225,43)
    println(rgb.cmyk())

    println(rgb.hex())

}
```
