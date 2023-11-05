## color
- A V library for working with colors
- Support for
> - sRGB(A)
> - HSL(A)
> - CMYK
> - Hex (with alpha)
> - CIELAB
> - AdobeRGB(A)
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
