# JSON 和 JSON5

了解传统 JSON 数据交换格式和 JSON5 扩展格式。

## Overview

> Important: 与 Jason 框架所附其他文档不同，此文档仅供开发者快速入门，不保证准确性、实时性、且不能成为 JSON 和 JSON5
的官方参考。如需对照标准文档，请参阅《[ECMA 404：JSON 数据交换格式](
http://www.ecma-international.org/publications/files/ECMA-ST/ECMA-404.pdf)》和《[JSON5 官方技术规格](
https://json5.github.io/json5-spec/)》。

文档中大部分内容引用自 [JSON.org](https://www.json.org/json-zh.html) 和 [JSON5.org](https://json5.org/)。

### JSON

JSON (ECMA-404, ISO 21778:2017) 是一种轻量数据交换格式，便于人类和机器读写。JSON 正式发布于 2013 年，基于 1999 年标准化的
ECMAScript (JavaScript) 语法，全称为 **J**ava**S**cript **O**bject **N**otation（JS 对象表记法）。ECMA 于 2017
年修订了 JSON 标准第二版，现今通行的 JSON 格式通常使用这一版本。

JSON 的基本语法结构如下：

- 允许将任意多**空格**插入任意语法边界之间。**空格**是无意义的字符：
  - 无长度字符
  - 标准空格 (U+0020)
  - Tab (U+0009)
  - LF (U+000A)
  - CR (U+000D)
  
  ![JSON Whitespace Syntax](JSONWhitespace)

- **值**是任意 JSON 结构之一。

  ![JSON Value Syntax](JSONValue)

JSON 定义了如下结构（形式）：

- **`null`** 用于表示大部分编程语言中的空值和空指针。
- **`true`** 用于表示逻辑上的肯定。
- **`false`** 用于表示逻辑上的否定。
- **数值**以标准十进制记法或科学计数法表示。

  ![JSON Number Syntax](JSONNumber)

- **字符串**是以 `"` (U+0022, Quotation Mark) 起止的任意 Unicode 字符组合。**字符串**中的如下字符需要转义：
  - `"` (U+0022, Quotation Mark)
  - `\` (U+005C, Reverse Solidus)
  - 收录于 Unicode 控制符 (Cc, Control) 类别的字符

  ![JSON String Syntax](JSONString)

- 任意数量的有序**值**排列构成**数组**。不同的**值**之间以 `,` (U+002C, Comma) 分隔。**数组**以 `[` (U+005B, Left Square Bracket)
  开始、`]` (U+005D, Right Square Bracket) 结束。

  ![JSON Array Syntax](JSONArray)

- 任意数量的无序**键**、**值**组合构成**对象**。**键**是一个**字符串**。**键**、**值**之间以 `:` (U+003A, Colon)
  分隔。不同**键**、**值**组合之间以 `,` (U+002C, Comma) 分隔。**对象**以 `{` (U+007B, Left Curly Bracket) 开始、`}`
  (U+007D, Right Curly Bracket) 结束。

  ![JSON Object Syntax](JSONObject)

> Important: JSON 没有定义**布尔**、**整数**、**浮点数**类型，也没有**无符号 (unsigned)** 和**可选值 (nullable)** 的概念。在 JSON
中，`null`、`true`、`false` 分别是三种独立的结构。当**整数**、**浮点数**表达的数学概念符合 JSON
标准时即是统一的**数值**类型，可以混用不同记法；正无穷、负无穷和部分**浮点数**定义的语法、概念不符合 JSON 标准，不能使用。

如下是 Mozilla Web 开发者文档提供的 JSON 格式示例：

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

### JSON5

JSON5 发布于 2018 年，将 ECMAScript 5.1 (ES5) 标准中新增的语法带到了 JSON 中。 Apple 的 Foundation 框架在
iOS / iPadOS / tvOS / Mac Catalyst 15.0、macOS 12.0、watchOS 8.0 和更高系统版本上添加了 JSON5 支持。

JSON5 定义了更宽松的 JSON 语法，与传统 JSON 的主要区别如下：

- JSON5 支持 `//` 单行**注释**，和以 `/*` 开始、`*/` 结束的多行**注释**。
- **对象**和**数组**定义中允许最后元素末尾添加一个 `,` (U+002C, Comma)。
- **对象**定义允许使用任何符合 ES5 [Identifier Name](https://262.ecma-international.org/5.1/#sec-7.6)
  的字符作**键**。与传统 JSON 相比，**键**不再要求是**字符串**。
- 允许将 `'` (U+0027, Apostrophe) 用于**字符串**首尾替代 `"` (U+0022,
  Quotation Mark)；**字符串**定义中允许转义换行和其他字符。
- **数值**定义允许添加 `+` (U+002B, Plus Sign)；允许添加 `0x` 前缀并使用十六进制表示；允许使用 [IEEE 754](
  http://ieeexplore.ieee.org/servlet/opac?punumber=4610933) 浮点数标准定义的**正无穷**、**负无穷**、**无效数值 (NaN)**。
- **数值**定义在维持准确性的情况下允许省略小数点前后的数字 `0`，但保留小数点。
- **空格**允许是任意 Unicode 视为“空白”的字符，包括不同语言使用的单词分隔符和不同系统中的换行符等：
  - U+000B
  - U+000C
  - U+00A0
  - U+2028
  - U+2029
  - BOM (U+FEFF)
  - 收录于 Unicode 空格和分隔符 (Zs, Space Separator) 类别的其他字符

如下是 JSON5 语法和等价传统 JSON 语法的对比：

```javascript
{
  // 这是一条注释
  unquoted_key: '单引号中包含"双引号"也可以。',
  lineBreaksAllowed: "如果需要换行，转义换行符，类似这样：\
就不需要 \\n 了！",
  hexadecimal: 0x1B3D,
  "leadingDecimalPoint":    .1234, // 即 0.1234
  "trailing_decimal_point": 5678., // 即 5678.0、5678
  positiveSign:             +1,    // 即 1、1.0
  trailingComma: '对象和数组中',
  and_in: [
    "最后一个元素可以用逗号结束",
  ],
}
```

```json
{
  "unquoted_key": "单引号中包含\"双引号\"也可以。",
  "lineBreaksAllowed": "如果需要换行，转义换行符，类似这样：\n就不需要 \\n 了！",
  "hexadecimal": 6973,
  "leadingDecimalPoint": 0.1234,
  "trailing_decimal_point": 5678,
  "positiveSign": 1,
  "trailingComma": "对象和数组中",
  "and_in": [
    "最后一个元素可以用逗号结束"
  ]
}
```
