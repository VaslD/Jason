# 使用枚举成员创建 Jason

作为 Swift 枚举，``Jason/Jason`` 支持创建指定枚举成员。

## Overview

字面量构建方法不支持传递变量。当参数为 [`Bool`](
https://developer.apple.com/documentation/swift/bool/)、[`String`](
https://developer.apple.com/documentation/swift/string/)、[`Int`](
https://developer.apple.com/documentation/swift/int/)、[`UInt`](
https://developer.apple.com/documentation/swift/uint/)、[`Double`](
https://developer.apple.com/documentation/swift/double/) 变量时，需要在代码中指定枚举成员。

```swift
func acceptJason(_ value: Jason) { /* ... */ }

acceptJason(.empty)

let b = true
acceptJason(.boolean(b))

let s = "String works!"
acceptJason(.string(s))

let i = 42
acceptJason(.integer(i))

let u = UInt.max
acceptJason(.unsigned(u))

let d = Double.pi
acceptJason(.float(d))
```

由于数组和字典是范型容器，``Jason/Jason/array(_:)`` 和 ``Jason/Jason/dictionary(_:)`` 通常不能直接创建，除非容器内的元素类型已经是
``Jason/Jason``。使用 ``Jason/Jason/init(rawValue:)-9xl31``
构造方法将尝试转换范型容器内的所有元素，此方法内部优化处理了元素类型已经是 ``Jason/Jason``
的容器；但如果遇到无法任何转换的元素，此方法将失败。

## Topics

### 核心实现

- ``Jason/Jason/empty``
- ``Jason/Jason/boolean(_:)``
- ``Jason/Jason/string(_:)``
- ``Jason/Jason/integer(_:)``
- ``Jason/Jason/unsigned(_:)``
- ``Jason/Jason/float(_:)``
- ``Jason/Jason/array(_:)``
- ``Jason/Jason/dictionary(_:)``
