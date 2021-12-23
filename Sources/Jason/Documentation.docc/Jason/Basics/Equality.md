# 等价性对比

使用 `==` 语法与另一 ``Jason/Jason`` 实例或其他类型实例进行等价性对比。

## Overview

两个 ``Jason/Jason`` 实例之间通过 ``Jason/Jason/==(_:_:)-65qwn`` 和 ``Jason/Jason/!=(_:_:)`` 进行等价性对比。

> Note: 当使用 `== nil` 和 `!= nil` 语法并且等式左边的类型为 ``Jason/Jason`` 时，也调用了 ``Jason/Jason/==(_:_:)-65qwn``。此时
`nil` 会被自动转换成 ``Jason/Jason/empty``。

```swift
let x: Jason = nil
assert(x == nil)
assert(x != 666)

let y: Jason = "String!"
assert(y == "String!")
assert(y != nil)
assert(y == .string("String!"))

let z: Jason = [0, 1.0, "2"]
let zz: Jason = [0, 1.0, "2"]
assert(z == zz)
```

``Jason/Jason`` 实际上支持与任意类型实例进行等价性对比，只需将其他类型变量写在等式右边。非 ``Jason/Jason`` 类型将被尝试转换为
``Jason/Jason`` 后执行对比。有关类型如何被转换为 ``Jason/Jason``，参阅《<doc:From-Raw-Value>》。

> Tip: 养成将 ``Jason/Jason`` 类型写在等式左边的习惯。因为并非所有类型都可以与 ``Jason/Jason`` 对比，但 ``Jason/Jason``
定义了接受任意类型实例的 ``Jason/Jason/==(_:_:)-2yrfx``。Swift 等价性对比语法将调用等式左边类型的 `==` 方法。

```swift
let x: Jason = nil
let xx: String? = nil
assert(x == xx)

let y: Jason = "String!"
let yy = "String!"
assert(y == yy)

let z: Jason = [0, 1.0, "2"]
let zz: [Any] = [0, 1.0, "2"]
assert(z == zz)
```

## Topics

### 核心实现

- ``Jason/Jason/==(_:_:)-65qwn``
- ``Jason/Jason/==(_:_:)-2yrfx``

### Swift 默认实现

- ``Jason/Jason/!=(_:_:)``
