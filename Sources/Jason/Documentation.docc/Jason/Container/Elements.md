# 将 Jason 作为集合类型使用

查询 ``Jason/Jason`` 中子元素状态和执行常用集合操作。

## Overview

``Jason/Jason`` 支持常用的 ``Jason/Jason/isEmpty``、``Jason/Jason/count`` 和 ``Jason/Jason/contains(_:)``
属性和方法查询元素状态。

> Warning: 这些方法在 ``Jason/Jason`` 是任何形式时都可以调用。调用者**必须**参阅每个方法的文档，以了解当 ``Jason/Jason``
不是容器（例如是 JSON 标准中 `true`、`false` 或数值）时这些方法的工作原理和返回值。鉴于 ``Jason/Jason`` 的灵活性，部分方法与 Swift
标准库中的同名方法存在使用区别！

```swift
let n: Jason = nil
print(n.isEmpty)   // true

let s: Jason = ""
print(s.isEmpty)   // true

let i: Jason = 42
print(i.count)     // 1

let a: Jason = [
    nil,
    "x",
    100
]
print(a.count)     // 3

let d: Jason = [
    "0": nil,
    "one": [1]
]
print(d.count)     // 2

print(s.contains(" "))   // false
print(d.contains("one")) // true
print(i.contains(42))    // false
```

``Jason/Jason`` 也支持使用 ``Jason/Jason/map(_:)`` 将容器内的所有元素映射为任意类型并获取结果数组。如果希望在映射过程中抛弃空值
(`nil`)，使用 ``Jason/Jason/compactMap(_:)``。如果不需要映射结果，使用 ``Jason/Jason/forEach(_:)``。

> Warning: 与 Swift 标准库中的 `map(_:)`、`compactMap(_:)` 和 `forEach(_:)` 不同，``Jason/Jason``
要求调用者提供传入两个参数的闭包，以同时支持数组和字典形式的容器。参数 0 为 ``JasonIndex`` 类型的索引，用于标识元素在容器中的位置；参数 1
为容器中的元素。映射方法在 ``Jason/Jason`` 是任何形式时都可以调用。调用者**必须**参阅每个方法的文档，以了解当 ``Jason/Jason``
不是容器（例如是 JSON 标准中的 `true`、`false` 等值）时这些方法的工作原理和返回值。

> Important: ``Jason/Jason`` 作为容器时其中的元素也是 ``Jason/Jason``，映射闭包需要支持处理 ``Jason/Jason``
类型的元素。如果需要将元素作为 Swift 基本类型操作，参阅《<doc:Cast>》。

```swift
let a: Jason = [
    nil,
    "x",
    100
]
let aa = a.compactMap { _, element in element }
print(aa)  // ["x", 100]

let b: Jason = [
    "A": 15,
    "B": "202",
    "C": true
]
let bb = b.map { _, element in element.asString()! }
bb.forEach { _, element in print(element) }
// "15"
// "202"
// "true"

let c: Jason = "31057294840"
let cc = c.map { index, element in 
    if index.stringValue.isEmpty {
        return true
    }
    return false
}
print(cc)  // []
```

## Topics

### 核心实现

- ``Jason/Jason/isEmpty``
- ``Jason/Jason/count``
- ``Jason/Jason/contains(_:)``
- ``Jason/Jason/forEach(_:)``
- ``Jason/Jason/map(_:)``
- ``Jason/Jason/compactMap(_:)``
