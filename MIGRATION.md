# Migration Guide

## Migrating to 0.7.0

Version 0.7.0 renames the Swift package product and module to `SwiftWebP`.
This avoids name collisions with the underlying `webp-spm` package, whose C
module is still named `WebP`.

### Update Package.swift

If your app depends on Swift-WebP, use the explicit package name and the
`SwiftWebP` product:

```swift
.package(name: "SwiftWebP", url: "https://github.com/gewill/Swift-WebP.git", from: "0.7.0")
```

```swift
.product(name: "SwiftWebP", package: "SwiftWebP")
```

Replace older product declarations such as:

```swift
.product(name: "WebP", package: "Swift-WebP")
```

### Update Imports

Application code that uses this Swift wrapper should import `SwiftWebP`:

```swift
import SwiftWebP
```

Replace older wrapper imports:

```swift
import WebP
```

The `WebP` module name is now reserved for the underlying C `libwebp` package
provided by `webp-spm`. Most applications should not need to import it directly
when using the Swift wrapper APIs.

### Public API Names

The main Swift API type names are unchanged:

- `WebPEncoder`
- `WebPDecoder`
- `WebPDecoderOptions`
- `WebPEncoderConfig`
- `WebPImageInspector`

For example:

```swift
import SwiftWebP

let decoder = WebPDecoder()
let pixels = try decoder.decode(webPData, options: .init(), format: .rgba)
```

### Test Targets and Local Packages

If you maintain local package targets or benchmark packages that depended on
this repository by path, update their dependency names in the same way:

```swift
.package(name: "SwiftWebP", path: "../Swift-WebP")
```

```swift
.product(name: "SwiftWebP", package: "SwiftWebP")
```

## Migrating from 0.5.x or Earlier

Version 0.6.0 introduced the larger API modernization. If you are upgrading
from 0.5.x or earlier directly to 0.7.0, apply both sets of changes:

1. Follow the 0.6.0 API migration notes in [CHANGELOG.md](CHANGELOG.md#060).
2. Then apply the 0.7.0 package/product/module rename described above.
