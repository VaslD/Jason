# 将 Jason 用于调试

在 LLDB 中使用 ``Jason/Jason`` 检查 JSON 数据和 Swift 基本类型。

## Overview

Swift 基本类型（例如 `Data` 和 `Dictionary`）的调试输出通常不尽人意。如果使用 `po` 命令查看 `Data` 类型变量，LLDB 输出：

```
▿ 48 bytes
  - count : 48
  ▿ pointer : 0x000000010304d600
    - pointerValue : 4345615872
  ▿ bytes : 48 elements
    - 0 : 123
    - 1 : 34
    - 2 : 104
    - 3 : 97
    - 4 : 115
    ...
```

对于 `Dictionary` 和 `Array` 类型变量，LLDB 输出：

```
▿ 12 elements
  ▿ 0 : 2 elements
    - key : "four_elements"
    ▿ value : 4 elements
      - 0 : nil
      - 1 : 1
      - 2 : 2
      - 3 : 3
  ▿ 1 : 2 elements
    - key : "has_value"
    - value : 1
  ...
```

这种输出并不利于定位问题或对比差异。``Jason/Jason`` 转换 Swift 类型的能力可用于在调试中以 JSON 文本查看
`Data` 和 `Dictionary` 等基本类型。同时，``Jason/Jason`` 输出的字典经过键排序，更适合查找和对比；以 JSON 文本查看 `String` 和 `Int`
时也更容易察觉到区别。

如需将 Swift 基本类型以 JSON 格式输出，使用如下命令查看 `anything` 变量。

```
(lldb) po Jason(rawValue: anything)!
```

频繁使用可将如下初始化脚本加入 `~/.lldbinit`，LLDB 将支持 `jo anything` 命令。

```
command regex jo 's/(.+)/po Jason(rawValue: %1)!/'
```

如需将 JSON 数据 (`Data`) 或文本 (`String`) 格式化输出，使用如下命令。

```
(lldb) po try! Jason.deserialize(stringOrData)
```

如需将遵循 `Encodable` 的类型以 JSON 格式输出，使用如下命令。

```
(lldb) po try! JSONEncoder().encodeJason(encodable)
```

## Topics

### 核心实现

- ``Jason/Jason/debugDescription``
- ``Jason/Jason/customMirror``
