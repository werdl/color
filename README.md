## color
- A V library for working with colors
- Support for
> - sRGB(A)
> - HSL(A)
> - CMYK
> - Hex (with alpha)
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
### Note
- This library involves conversion between different color types (obviously), including non-linear conversion.
- That means that while it is fairly accurate, it is not perfect!
- To avoid this as far as possible, try to use RGB as the medium, which has the actual calculations between the complicated formats!
