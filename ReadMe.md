# Jason

> 🇨🇳 Although this project and its developers use English for project management and communications, source code documentation for this package is written in Simplified Chinese for easier consumption in Xcode and DocC publishing.
>
> You may contribute code, submit pull requests and issues in English, but your work will be re-documented in Chinese before merging into the next release, until Apple provides a way to support internationalization in generated DocC.

> 📝 From release 2.2.1, DocC documentation archives are no longer included as source on the master/main branch. You can clone and import the [documentation branch](https://github.com/VaslD/Jason/tree/documentation), or find [Jason’s documentation on Netlify](https://jason-documentation.netlify.app/documentation/). Online documentation is always up-to-date. You will need to `xcodebuild` an older tar to get DocC for previous releases.

## What It Is

`Jason` is a single type, which is a union of all standard JSON value types, including `null`, key-value pairs, and arrays. Somewhat like generics, Jason provides a flexible, yet remaining type-safe, way to operate on loose structures represented by the JSON interchange format.

Simply put, when you have a `Jason` variable, you know it’s going to one of JSON-compatible Swift types. You don’t know which. You can find out, or you can assign it another JSON-compatible Swift type. Without Jason, this can only be accomplished by making everything `Any` since Swift is strong and static typed.

## How It Works

Primarily, `Jason` uses Swift *enum* and its capability to represent discriminated unions. While exposed as `Jason`, each JSON-compatible value is stored using its original Swift type, and is associated with an enumeration case that marks its type information. Collections, like key-value pairs and arrays, take `Jason` as elements, and themselves associated with enumeration cases to complete the cycle.

`Jason` conforms to almost all of Swift standard *Expressible-By-Literal* protocols. This allows consumer to write standard Swift literal syntax, like `"quotes"` for `String`s and `[bracket, bracket]` for `Array`s, and have compiler infer these types to `Jason` whenever the compiler sees fit.

`Jason` is both `Encodable` and `Decodable` to work with Swift’s Codable serialization framework. And it provides its own serialization and deserialization methods utilizing `JSONSerialization` from Foundation framework when available.

## How to Use It

While a simple demo app is nice, it requires the same amount of work and doesn't quite convey all necessary information on what to expect when you “do that”. So, all use cases and their expected behaviors can be found in [tests](./Tests/JasonTests).

## Caveats

Currently, `Jason` is guaranteed to work on all supported **Apple platforms only**. Most tests are failing on Linux (and likely Windows) due to different implementation from standard Math library and Foundation ports.

Maybe it's the way the tests are written, I don’t know. But pending further investigation, assume that Jason does not give back correct values on non-Apple platforms, and should not be used in production.

Tests should cover everything. If you managed to find a bug, please fill an issue and I will fix it as soon as possible.

