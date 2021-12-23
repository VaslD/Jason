# 解析 JSON 数据格式

``Jason/Jason`` 可解析 JSON 格式数据和文本，或作为 `Decodable` 使用。

## Overview

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

如下几种方式解析效果相同，但不使用 [`JSONDecoder`](
https://developer.apple.com/documentation/foundation/jsondecoder/) 会显著提高解析效率。

```swift
let string =
    """
    {"squadName":"Super hero squad","homeTown":"Metro City","formed":2016,
    "secretBase":"Super tower","active":true,"members":[{"name":"Molecule Man",
    "age":29,"secretIdentity":"Dan Jukes","powers":["Radiation resistance",
    "Turning tiny","Radiation blast"]},{"name":"Madame Uppercut","age":39,
    "secretIdentity":"Jane Wilson","powers":["Million tonne punch",
    "Damage resistance","Superhuman reflexes"]},{"name":"Eternal Flame",
    "age":1000000,"secretIdentity":"Unknown","powers":["Immortality",
    "Heat Immunity","Inferno","Teleportation","Interdimensional travel"]}]}
    """

let data = Data([
    123,34,115,113,117,97,100,78,97,109,101,34,58,34,83,117,112,101,114,32,104,
    101,114,111,32,115,113,117,97,100,34,44,34,104,111,109,101,84,111,119,110,
    34,58,34,77,101,116,114,111,32,67,105,116,121,34,44,34,102,111,114,109,101,
    100,34,58,50,48,49,54,44,34,115,101,99,114,101,116,66,97,115,101,34,58,34,
    83,117,112,101,114,32,116,111,119,101,114,34,44,34,97,99,116,105,118,101,34,
    58,116,114,117,101,44,34,109,101,109,98,101,114,115,34,58,91,123,34,110,97,
    109,101,34,58,34,77,111,108,101,99,117,108,101,32,77,97,110,34,44,34,97,103,
    101,34,58,50,57,44,34,115,101,99,114,101,116,73,100,101,110,116,105,116,121,
    34,58,34,68,97,110,32,74,117,107,101,115,34,44,34,112,111,119,101,114,115,
    34,58,91,34,82,97,100,105,97,116,105,111,110,32,114,101,115,105,115,116,97,
    110,99,101,34,44,34,84,117,114,110,105,110,103,32,116,105,110,121,34,44,34,
    82,97,100,105,97,116,105,111,110,32,98,108,97,115,116,34,93,125,44,123,34,
    110,97,109,101,34,58,34,77,97,100,97,109,101,32,85,112,112,101,114,99,117,
    116,34,44,34,97,103,101,34,58,51,57,44,34,115,101,99,114,101,116,73,100,101,
    110,116,105,116,121,34,58,34,74,97,110,101,32,87,105,108,115,111,110,34,44,
    34,112,111,119,101,114,115,34,58,91,34,77,105,108,108,105,111,110,32,116,111,
    110,110,101,32,112,117,110,99,104,34,44,34,68,97,109,97,103,101,32,114,101,
    115,105,115,116,97,110,99,101,34,44,34,83,117,112,101,114,104,117,109,97,110,
    32,114,101,102,108,101,120,101,115,34,93,125,44,123,34,110,97,109,101,34,58,
    34,69,116,101,114,110,97,108,32,70,108,97,109,101,34,44,34,97,103,101,34,58,
    49,48,48,48,48,48,48,44,34,115,101,99,114,101,116,73,100,101,110,116,105,116,
    121,34,58,34,85,110,107,110,111,119,110,34,44,34,112,111,119,101,114,115,34,
    58,91,34,73,109,109,111,114,116,97,108,105,116,121,34,44,34,72,101,97,116,32,
    73,109,109,117,110,105,116,121,34,44,34,73,110,102,101,114,110,111,34,44,34,
    84,101,108,101,112,111,114,116,97,116,105,111,110,34,44,34,73,110,116,101,
    114,100,105,109,101,110,115,105,111,110,97,108,32,116,114,97,118,101,108,34,
    93,125,93,125
])

var deserialized = try Jason.deserialize(string)
deserialized = try Jason.deserialize(data)
deserialized = try JSONDecoder().decodeJason(from: data)
deserialized = try JSONDecoder().decode(Jason.self, from: data)
```

> Important: JSON 解析依赖 Foundation 框架。在 Foundation 框架不可用的平台上，``Jason/Jason/deserialize(_:)-958q1`` 和
``Jason/Jason/deserialize(_:)-2v8zs`` 方法也不可用；但 ``Jason/Jason`` 仍然支持使用平台提供的、或第三方的
`Decoder`（例如 [ZippyJSON](https://github.com/michaeleisel/ZippyJSON)）解析 JSON。

## Topics

### 核心实现

- ``Jason/Jason/deserialize(_:)-958q1``
- ``Jason/Jason/deserialize(_:)-2v8zs``
- ``Jason/Jason/init(from:)-3h3id``
- ``Jason/Jason/init(from:)-29s6e``
- ``Jason/Jason/init(from:)-9mme0``
- ``Jason/Jason/init(from:)-13m9u``
