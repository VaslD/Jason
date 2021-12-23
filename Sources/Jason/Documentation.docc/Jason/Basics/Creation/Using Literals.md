# 使用字面量创建 Jason

``Jason/Jason`` 遵循几乎所有 Swift 字面量表达 (Expressible-By-Literal) 协议。

## Overview

字面量 ([Literals](https://docs.swift.org/swift-book/ReferenceManual/LexicalStructure.html#ID414))
指代码中直接写出的定值表达式，例如 `"This is a String!"` 和 `-1.0` 等。字面量通常在编译阶段被直接优化为逻辑指令（例如
`JEQ`），或被用于初始化指定类型的变量、运行时常量等。

### 基本用法

得益于 Swift 提供的字面量协议，当代码中类型明确为 ``Jason/Jason`` 时，可以直接使用 [`String`](
https://developer.apple.com/documentation/swift/string/1541044-init#discussion)、[`Int`](
https://developer.apple.com/documentation/swift/int/1540495-init#discussion)、[`Double`](
https://developer.apple.com/documentation/swift/double/1540069-init#discussion)、[`Array`](
https://developer.apple.com/documentation/swift/array/1540235-init#discussion)、[`Dictionary`](
https://developer.apple.com/documentation/swift/dictionary/1538849-init#discussion)
等定值表达式传递参数或赋值，编译器将自动使用 ``Jason/Jason`` 类型。

```swift
func acceptJason(_ value: Jason) { /* ... */ }

acceptJason(true)
acceptJason("String works!")
acceptJason(42)
acceptJason(3.14)
acceptJason("Pi is \(Double.pi)")
acceptJason(["\(zero)", 1, "2", 3.0])
acceptJason([
    "a": "String works!",
    "b": 42,
    "c": 3.14,
    "d": "Pi is \(Double.pi)",
    "e": ["\(zero)", 1, "2", 3.0],
    "f": [
        "A": "String works!",
        "B": 42
    ],
    "g": false
])
```

但 Swift 标准库基本类型的推断优先级高于遵循字面量表达协议的自定义类型，因此在完全无类型线索时，Swift
将优先推断表达式为基本类型。如果希望在此时构建 ``Jason/Jason``，请明确指定变量或参数类型为 ``Jason/Jason``。

```swift
let s = "🤣"
// s 默认为 String，使用如下用法修复
let a: Jason = "🤣"

let i = 1
// i 默认为 Int，使用如下用法修复
let b: Jason = 1

let x: ["String", 42]
// x 默认为 [Any]，使用如下用法修复
let c: Jason = ["String", 42]

// 依此类推
```

### 空值

由于 JSON 标准定义了空值（也称：空指针）为合法 JSON，因此 ``Jason/Jason`` 可以**直接**用于表示 Swift 中的 `nil`，对应 JSON 标准中的
`null`；换言之，在使用 ``Jason/Jason`` 时 `nil` **不必须**使用 `Jason?` 类型存储。事实上，除非编译器自动推断或 API
定义要求使用 [`Optional`](https://developer.apple.com/documentation/swift/optional/) 类型，没有场景需要使用
`Jason?`。``Jason/Jason`` 内部使用 ``Jason/Jason/empty`` 标识 `nil`。

```swift
func acceptJason(_ value: Jason) { /* ... */ }

acceptJason(nil)
```

此语法同时允许任意 ``Jason/Jason`` 和 `nil` 进行等价对比。有关 ``Jason/Jason`` 之间、``Jason/Jason``
与已知类型进行等价性对比的细节和注意事项，参阅《<doc:Equality>》。

> Tip: `nil` 和非空值 ``Jason/Jason`` 为同一类型时，不需要（也不支持）使用 `if let` 和 `guard let`
语法升级为非空变量。

类似如下场景中的 ``Jason/Jason`` 变量可以直接使用。

```swift
func callAPI<T: Encodable>(_ body: T) { /* ... */ }

func acceptJason(_ value: Jason) {
    if value != nil {
        callAPI(value)
    }
}
```

> Note: Jason 的这种实现在某种意义上与 Swift 严格区分空值和有值的设计理念相违背。但 Jason 是用于表达 JSON 数据格式的类型；当
Swift 和 JSON 的设计理念无法兼顾时，Jason 选择了更贴近 JSON 标准的方式处理 `nil`。Swift 开发文档中仅**不推荐**将
`nil` 表达式用于自定义目的，并未明确禁止相关用法。

## Topics

### 核心实现

- ``Jason/Jason/init(nilLiteral:)``
- ``Jason/Jason/init(booleanLiteral:)``
- ``Jason/Jason/init(stringLiteral:)``
- ``Jason/Jason/init(integerLiteral:)``
- ``Jason/Jason/init(floatLiteral:)``
- ``Jason/Jason/init(arrayLiteral:)``
- ``Jason/Jason/init(dictionaryLiteral:)``

### Swift 默认实现

- ``Jason/Jason/init(unicodeScalarLiteral:)``
- ``Jason/Jason/init(extendedGraphemeClusterLiteral:)``
- ``Jason/Jason/init(stringInterpolation:)``
