# 访问容器中的子元素

结合 ``JasonIndex`` 访问 ``Jason/Jason`` 容器中的层级和元素。

## Overview

当 ``Jason/Jason`` 是字典和数组等容器时，可以使用下标 (`[]`) 语法存取子层级或某个元素。

> Warning: 代码示例只涉及部分场景，调用者**必须**参阅核心实现中的文档以全面了解读取和写入时的注意事项。以非预期方式使用
``Jason/Jason/subscript(_:)-7vljl`` 可能导致数据丢失。

> Important: ``Jason/Jason`` 作为容器时其中的元素也是 ``Jason/Jason``，下标语法只能读取和写入已经是 ``Jason/Jason``
类型的元素。如果需要将元素作为 Swift 基本类型操作，参阅《<doc:Create-Jason>》和《<doc:Cast>》。

以 Mozilla Web 开发者文档中示例 [JSON](
https://developer.mozilla.org/en-US/docs/Learn/JavaScript/Objects/JSON#json_structure) 为例。

```json
{
  "squadName": "Super hero squad",
  "homeTown": "Metro City",
  "formed": 2016,
  "secretBase": "Super tower",
  "active": true,
  "members": [
    {
      "name": "Molecule Man",
      "age": 29,
      "secretIdentity": "Dan Jukes",
      "powers": [
        "Radiation resistance",
        "Turning tiny",
        "Radiation blast"
      ]
    },
    {
      "name": "Madame Uppercut",
      "age": 39,
      "secretIdentity": "Jane Wilson",
      "powers": [
        "Million tonne punch",
        "Damage resistance",
        "Superhuman reflexes"
      ]
    },
    {
      "name": "Eternal Flame",
      "age": 1000000,
      "secretIdentity": "Unknown",
      "powers": [
        "Immortality",
        "Heat Immunity",
        "Inferno",
        "Teleportation",
        "Interdimensional travel"
      ]
    }
  ]
}
```

### 读取

字符串和整数可用于下标语法。

> Tip: 下标支持传入变量和数组，请参阅相关方法和 ``JasonIndex`` 文档。

```swift
let value = try Jason.deserialize(data)

print(value["homeTown"])          // "Metro City"
print(value["members"][0]["age"]) // 29
```

下标也可用于前往或保存子层级。

```swift
let value = try Jason.deserialize(data)

let members = value["members"]
print(members)
/*
[
  {
    "name": "Molecule Man",
    "age": 29,
    ...
]
*/
```

无效的层级和元素将返回 ``Jason/Jason/empty``。对 ``Jason/Jason/empty`` 继续使用下标语法仍然返回 ``Jason/Jason/empty``。

```swift
let value = try Jason.deserialize(data)

print(value["NONEXISTENT_KEY"][1024]) // null
```

### 写入

下标语法可用于赋值。

> Tip: 下标支持传入变量和数组，请参阅相关方法和 ``JasonIndex`` 文档。

```swift
var value: Jason = nil

value["homeTown"] = "Metro City"
print(value["homeTown"]) // "Metro City"
```

赋值时允许跨越层级。

```swift
let value = try Jason.deserialize(data)

var members = value["members"]
members[0]["age"] = 10
print(members)
/*
[
  {
    "name": "Molecule Man",
    "age": 10,
    ...
]
*/
```

写入不存在的层级和元素将被创建。

```swift
var value = try Jason.deserialize(data)

value["members"][3]["name"] = "Unknown"
value["members"][3]["age"] = -1
print(value)
/*
{
  "squadName": "Super hero squad",
  "homeTown": "Metro City",
  "formed": 2016,
  "secretBase": "Super tower",
  "active": true,
  "members": [
    { ... },
    { ... },
    { ... },
    {
      "name": "Unknown",
      "age": -1
    }
  ]
}
*/
```

## Topics

### 核心实现

- ``Jason/Jason/subscript(_:)-7vljl``

### 快捷方法

- ``Jason/Jason/subscript(_:)-78ht5``
- ``Jason/Jason/subscript(_:)-8ri6f``
- ``Jason/Jason/subscript(_:)-2dzy2``
- ``Jason/Jason/subscript(_:)-67a5h``
- ``Jason/Jason/subscript(_:)-557qh``
