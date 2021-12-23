# 转换兼容类型实例为 Jason

尝试将任意类型实例转换为 ``Jason/Jason``。

## Overview

对于编译时类型不稳定的变量、范型容器、非 Swift 类型的实例，使用 ``Jason/Jason/init(rawValue:)-9xl31`` 构建方法可尝试将其转换为
``Jason/Jason``。Swift 基本类型的 Core Foundation 和 Foundation 桥接类型都可以被此方法转换成 
``Jason/Jason``。注意 ``Jason/Jason/init(rawValue:)-9xl31`` 可能失败；如果转换失败返回值将是 `Jason?.none`，即 `Jason?` 类型的
`nil`（而不是 `Jason` 类型的 `nil`）。

> Warning: 当显性使用 `nil`、或使用任意 [`Optional`](
https://developer.apple.com/documentation/swift/optional/) 类型实例 `as Any` 语法构造
``Jason/Jason`` 时，传入 `nil` 会导致 ``Jason/Jason/init(rawValue:)-9xl31`` 构造方法成功并且返回 ``Jason/Jason/empty``（即
`Jason` 类型的 `nil`）。这种用法（将可选值作为非可选 `Any` 传递）被认为是调用者刻意规避非空检查，因此
``Jason/Jason/init(rawValue:)-9xl31`` 不再由于传入空值而构造失败。如果调用者不期待此行为，请预先检查传入变量是否非空；通常 Swift
编译器也会给出相应警告。

```swift
func acceptJason(_ value: Jason) { /* ... */ }

let array = [true, 2.0, 3, "🪵🧍"] as [Any]
var x = Jason(rawValue: array)

let dictionary = [
    "array": array,
    "JSON": x!,
    "nothing": String?.none as Any,
] as [String: Any]
x = Jason(rawValue: dictionary)

acceptJason(x)
```

如果类型遵循 [`RawRepresentable`](
https://developer.apple.com/documentation/swift/rawrepresentable/) 协议，`init(rawValue:)`
调用会被编译器重定向到 ``Jason/Jason/init(rawValue:)-6b8z5``
并使用 [`RawRepresentable.rawValue`](
https://developer.apple.com/documentation/swift/rawrepresentable/1540698-rawvalue) 创建 ``Jason/Jason``。

> Tip: 在 Swift 中，包含原始值的[枚举](
https://docs.swift.org/swift-book/LanguageGuide/Enumerations.html)和
[`OptionSet`](https://developer.apple.com/documentation/swift/optionset/) 即使不声明也默认实现 [`RawRepresentable`](
https://developer.apple.com/documentation/swift/rawrepresentable/) 协议。

```swift
public enum Gender: Int {
    case male = 1
    case female
    case other = -1
}

func acceptJason(_ value: Jason) { /* ... */ }

let z = Jason(rawValue: Gender.male)
acceptJason(z)
```

对于绝大多数自定义类型的实例，``Jason/Jason/init(rawValue:)-9xl31``
都会失败，因为没有通用的方法可以获取任意类型的属性信息。当自定义类型遵循 [`Encodable`](
https://developer.apple.com/documentation/swift/encodable/) 时，请配置或使用默认 [`JSONEncoder`](
https://developer.apple.com/documentation/foundation/jsonencoder/) 编码设置（例如属性命名规则、时间戳起始日期等）并调用
`encodeJason(_:)` 将类型实例编码后转换为 ``Jason/Jason``。

```swift
public struct Emoji: Encodable { /* ... */ }

func acceptJason(_ value: Jason) { /* ... */ }

let emoji = Emoji(/* ... */)
let y = try JSONEncoder().encodeJason(emoji)
acceptJason(y)
```

## Topics

### 核心实现

- ``Jason/Jason/init(rawValue:)-9xl31``
- ``Jason/Jason/init(rawValue:)-6b8z5``
- ``Jason/Jason/init(rawValue:)-2g1ub``
- ``Jason/Jason/init(rawValue:)-5b03a``
- ``Jason/Jason/init(rawValue:)-2xvjw``
