# 转换为已知类型

将 ``Jason/Jason`` 转换为 Swift 基本类型和自定义类型实例。

## Overview

``Jason/Jason`` 通过遵循 [`RawRepresentable`](
https://developer.apple.com/documentation/swift/rawrepresentable/) 保留了 JSON 数据的原始值，可以从 ``Jason/Jason/rawValue``
获取。尽管 ``Jason/Jason/rawValue`` 定义为返回 `Any`，但其类型只可能是如下之一：

| JSON     | ``Jason/Jason`` 枚举成员        | ``Jason/Jason/rawValue`` 返回值 |
| -------- | ------------------------------ | ------------------------------ |
| `nil`    | ``Jason/Jason/empty``          | `Any?.none`                    |
| `true`   | ``Jason/Jason/boolean(_:)``    | `Bool`                         |
| `false`  | ``Jason/Jason/boolean(_:)``    | `Bool`                         |
| 数值      | ``Jason/Jason/integer(_:)``    | `Int`                          |
| 数值      | ``Jason/Jason/unsigned(_:)``   | `UInt`                         |
| 数值      | ``Jason/Jason/float(_:)``      | `Double`                       |
| 字符串    | ``Jason/Jason/string(_:)``     | `String`                       |
| 数组      | ``Jason/Jason/array(_:)``      | `[Any]`                        |
| 对象      | ``Jason/Jason/dictionary(_:)`` | `[String: Any]`                |

其中数组和字典返回值中的 `Any` 也是上述类型之一。

### 获取期待的类型

某些情况下 JSON 的形式可能与编程所用类型不符，但两者可以互相转换。此时，使用
``Jason/Jason/asBool()``、``Jason/Jason/asString()``、``Jason/Jason/asInt()``、``Jason/Jason/asUInt()`` 或
``Jason/Jason/asDouble()`` 方法之一尝试自动将 JSON 的值转换为期待的类型。

```swift
let i: Jason = 1
let j: Jason = "1"
let k: Jason = true

let x = i.asInt()
let y = j.asInt()
let z = k.asInt()

assert(x == y)
assert(y == z)

print(z)  // 1
```

### 转换为自定义类型

如果自定义类型支持 [`Decodable`](https://developer.apple.com/documentation/swift/decodable/)，``Jason/Jason``
提供 ``Jason/Jason/as(_:decoder:)`` 将当前实例序列化为 JSON 数据并尝试反序列化成指定类型。Swift
标准库中的类型大多遵循 [`Decodable`](
https://developer.apple.com/documentation/swift/decodable/)，因此此方法能够统一处理绝大部分已知类型。

```swift
public struct Emoji: Decodable { /* ... */ }

let x: Jason = "😀"
let emoji = x.as(Emoji.self)
```

``Jason/Jason/as(_:decoder:)`` 支持指定解码所用的 [`JSONDecoder`](
https://developer.apple.com/documentation/foundation/jsondecoder/)。如果待解码类型期待与系统默认不同的属性名称和时间戳格式，传入
[`JSONDecoder`](https://developer.apple.com/documentation/foundation/jsondecoder/) 自定义这些行为。

```swift
public struct User: Decodable { /* ... */ }

let x: Jason = /* ... */
let user = x.as(Emoji.self, {
    $0.dateDecodingStrategy = .iso8601
    $0.keyDecodingStrategy = .convertFromSnakeCase
    return $0
}(JSONDecoder()))
```

## Topics

### 原始值

- ``Jason/Jason/rawValue``

### 转换为基本类型

- ``Jason/Jason/asBool()``
- ``Jason/Jason/asString()``
- ``Jason/Jason/asInt()``
- ``Jason/Jason/asUInt()``
- ``Jason/Jason/asDouble()``

### 转换为自定义类型

- ``Jason/Jason/as(_:decoder:)``
- ``Jason/Jason/as(_:)``
