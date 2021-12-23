# 序列化为 JSON

将 ``Jason/Jason`` 序列化为 JSON 数据用于传输和交换。

## Overview

``Jason/Jason`` 支持作为 [`Encodable`](
https://developer.apple.com/documentation/swift/encodable/) 与 [`JSONEncoder`](
https://developer.apple.com/documentation/foundation/jsonencoder/) 交互，也提供不依赖 [`JSONEncoder`](
https://developer.apple.com/documentation/foundation/jsonencoder/) 的序列化方法。

> Important: JSON 编码依赖 Foundation 框架。在 Foundation 框架不可用的平台上，``Jason/Jason/serialize()``
方法也不可用；但 ``Jason/Jason`` 仍然支持使用平台提供的、或第三方的
`Encoder`（例如 [ZippyJSON](https://github.com/michaeleisel/ZippyJSON)）编码 JSON。

以 Mozilla Web 开发者文档中示例 [JSON](
https://developer.mozilla.org/en-US/docs/Learn/JavaScript/Objects/JSON#json_structure) 对应的 ``Jason/Jason``
为例，如下两种方式输出的 JSON 等价。

```json
let x: Jason = [
    "squadName": "Super hero squad",
    "homeTown": "Metro City",
    "formed": 2016,
    "secretBase": "Super tower",
    "active": true,
    "members": [
        [
            "name": "Molecule Man",
            "age": 29,
            "secretIdentity": "Dan Jukes",
            "powers": [
                "Radiation resistance",
                "Turning tiny",
                "Radiation blast"
            ]
        ],
        [
            "name": "Madame Uppercut",
            "age": 39,
            "secretIdentity": "Jane Wilson",
            "powers": [
                "Million tonne punch",
                "Damage resistance",
                "Superhuman reflexes"
            ]
        ],
        [
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
        ]
    ]
]

var serialized = try x.serialize()
serialized = try JSONEncoder().encode(x)
```

> Note: ``Jason/Jason/serialize()`` 在 DEBUG 编译配置下输出经过键排序的 JSON 便于调试。JSON
标准中的键值无序，因此文本表示不同的 JSON 格式在解析时可能等价。

## Topics

### 核心实现

- ``Jason/Jason/serialize()``
- ``Jason/Jason/encode(to:)``
