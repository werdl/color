## color
- A V library for working with colors
### Usage
`v install werdl/color`

```v
import color { RGB, CMYK, HEX, rgb, cmyk, hex }

fn main() {
    rgb:=rgb(160,225,43)
    println(rgb.cmyk())

    println(rgb.hex())

}
```