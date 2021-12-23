# 嵌套 JSON 文本

以 ``Jason/Jason/string(_:)`` 嵌套 JSON 的文本形式。

## Overview

某些场景下，例如在键值容器、表结构数据库、HTTP Form Data 中存储 JSON 时，需要以文本形式嵌套 JSON。以 Mozilla Web
开发者文档中示例 [JSON](https://developer.mozilla.org/en-US/docs/Learn/JavaScript/Objects/JSON#json_structure) 为例。

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

假设某场景需要将其转换为文本形式的键值对。

```json
{
  "squadName": "Super hero squad",
  "homeTown": "Metro City",
  "formed": "2016",
  "secretBase": "Super tower",
  "active": "true",
  "members": "[{\"name\":\"Molecule Man\",\"age\":29,\"secretIdentity\":\"Dan Jukes\",\"powers\":[\"Radiation resistance\",\"Turning tiny\",\"Radiation blast\"]},{\"name\":\"Madame Uppercut\",\"age\":39,\"secretIdentity\":\"Jane Wilson\",\"powers\":[\"Million tonne punch\",\"Damage resistance\",\"Superhuman reflexes\"]},{\"name\":\"Eternal Flame\",\"age\":1000000,\"secretIdentity\":\"Unknown\",\"powers\":[\"Immortality\",\"Heat Immunity\",\"Inferno\",\"Teleportation\",\"Interdimensional travel\"]}]"
}
```

当构造或修改 ``Jason/Jason`` 时，将需要嵌套的 ``Jason/Jason`` 作为参数调用 ``Jason/Jason/serialized(_:serializeStringAsIs:)``
即可得到其作为 JSON 文本的 ``Jason/Jason/string(_:)`` 枚举成员。

```json
let squad: Jason = try [
    "squadName": "Super hero squad",
    "homeTown": "Metro City",
    "formed": try .serialized(2016),
    "secretBase": "Super tower",
    "active": try .serialized(true),
    "members": try .serialized([
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
    ])
]
```

> Warning: ``Jason/Jason/serialized(_:serializeStringAsIs:)`` 默认仍会转义已经为 ``Jason/Jason/string(_:)``
的输入。如果需要保持 ``Jason/Jason/string(_:)`` 不变、只嵌套和转义其他形式的 JSON，向 `serializeStringAsIs` 参数传递 `true`。

## Topics

### 核心实现

- ``Jason/Jason/serialized(_:serializeStringAsIs:)``
