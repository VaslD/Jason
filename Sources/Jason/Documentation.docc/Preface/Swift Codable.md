# Swift 中的 Codable

了解 `Encodable` 和 `Decodable` 的工作原理、以及与 Foundation 框架中 `JSONEncoder` 和 `JSONDecoder` 的关系。

## Overview

> Important: 与 Jason 框架所附其他文档不同，此文档仅供开发者快速入门，不保证准确性、实时性、且不能成为 Swift
语言和标准库中序列化技术的官方参考。如需对照标准文档，请参阅 Apple 开发者文档《[编解码和序列化](
https://developer.apple.com/documentation/swift/swift_standard_library/encoding_decoding_and_serialization/)》。

Codable 是 Swift 中的序列化 (serialization)
技术别称，用于将实例在内存中的状态转储到文件中进行数据交换、以及从文件中恢复先前的实例或重新构建等价新实例。这种技术也被称为编码 (encoding)
或归档 (archiving)。

Codable 定义了一种通用的、格式无关的抽象序列化方案，并非为 JSON 设计。JSON 是 Foundation 框架原生支持的序列化格式之一。第三方开发者也基于
Codable 提供了 [CSV](https://github.com/dehesa/CodableCSV) 和 [XML](https://github.com/MaxDesiatov/XMLCoder)
等格式支持。

### 容器

Codable 的工作原理基于**容器**：

- **单元容器** (Single Value Container) 是最基础的容器类型，通常用于保存 Swift 基本类型、或用于抽象处理结构未知的复杂类型。
- **键值容器** (Keyed Container) 类似字典 (`Dictionary`)，支持通过文本**键**查找和存取**值**。Swift
  允许**键值容器**支持数值**键**，但支持数值**键**的容器仍然需要支持文本**键**。从某种意义上来说，数组 (`Array`) 结构也对应**键值容器**。
- **有序容器** (Unkeyed Container) 类似流 (`Sequence`)，支持按顺序存取**值**。Codable
  不要求**有序容器**明确知道内部元素的数量，也不要求**有序容器**能够乱序取值。尽管数组 (`Array`)
  通常使用**有序容器**保存，**有序容器**并不具备数组的所有功能。

### 基本单元

**容器**支持存取 15 种基本单元，对应 Swift 常用的值类型：

- `nil`
- `Bool`
- `String`
- `Int` 和 `Int8`、`Int16`、`Int32`、`Int64`
- `UInt` 和 `UInt8`、`UInt16`、`UInt32`、`UInt64`
- `Double` 和 `Float`

Swift 并未定义~~基本单元~~的概念，但任何遵循**容器**协议的类型都必须单独提供这 15
种类型的存、取实现。基本单元也均支持 `Codable` 协议，用于组装复杂单元。

### Codable 协议和复杂单元

[`Codable`](https://developer.apple.com/documentation/swift/codable/) 是 [`Encodable`](
https://developer.apple.com/documentation/swift/encodable/) 和 [`Decodable`](
https://developer.apple.com/documentation/swift/decodable/) 协议的统称。

```swift
typealias Codable = Decodable & Encodable
```

[`Encodable`](https://developer.apple.com/documentation/swift/encodable/)
声明当前类型可以用于编码。协议要求类型提供将实例放入抽象编码器的方法。

```swift
func encode(to encoder: Encoder) throws
```

[`Decodable`](https://developer.apple.com/documentation/swift/decodable/)
声明当前类型可以用于解码。协议要求类型提供从抽象解码器构造的方法。

```swift
init(from decoder: Decoder) throws
```

**容器**支持存储遵循 [`Encodable`](https://developer.apple.com/documentation/swift/encodable/)
协议的复杂单元，也支持构造遵循 [`Decodable`](https://developer.apple.com/documentation/swift/decodable/)
协议的复杂单元。因此，遵循 [`Codable`](https://developer.apple.com/documentation/swift/codable/)
的类型既可以通过解码器构造、也可以被重新编码。Swift 标准库中的大多数类型都是实现 [`Codable`](
https://developer.apple.com/documentation/swift/codable/) 协议的复杂单元。

Swift 编译器为属性全部可被编、解码（即每个属性的类型都是基本单元或复杂单元）的类型提供默认编、解码实现，但类型至少需要声明遵循
[`Encodable`](https://developer.apple.com/documentation/swift/encodable/)、[`Decodable`](
https://developer.apple.com/documentation/swift/decodable/) 或 [`Codable`](
https://developer.apple.com/documentation/swift/codable/)。Swift
默认实现大致为将每个属性对应的**值**放入单独的**单元容器**，因为这些属性的类型均为基本单元或已经遵循
[`Encodable`](https://developer.apple.com/documentation/swift/encodable/)、[`Decodable`](
https://developer.apple.com/documentation/swift/decodable/
)，**单元容器**保证提供方法处理这些**值**；随后以属性名作为**键**，将所有属性统一放入**键值容器**。

例如，对于如下定义的类型：

```swift
struct MyModel: Encodable {
    var id: UInt64
    var name: String
    var createdAt: Date // 因为 Date 实现了 Encodable，使用 Double 保存数据
    // ...
}
```

编码器会将其存储为如下抽象格式：

```
键值容器
├─ 键："id"
│  │
│  值：单元容器
│     └─ UInt64
│
├─ 键："name"
│  │
│  值：单元容器
│     └─ String
│
├─ 键："createdAt"
│  │
│  值：单元容器
│     └─ Date
│        └─ 单元容器
│           └─ Double
│
...
```

当移除所有中间状态和实现细节，[`JSONEncoder`](
https://developer.apple.com/documentation/foundation/jsonencoder/) 编码后的结构就会对应如下 JSON 文本。

```json
{
    "id": /* UInt64 */,
    "name": /* String */, 
    "createdAt": /* Double */,
    // ...
}
```

### Coding Key

Codable 中**键值容器**使用的**键**遵循 [`CodingKey`](
https://developer.apple.com/documentation/swift/codingkey)，而 [`CodingKey`](
https://developer.apple.com/documentation/swift/codingkey) 要求**键**至少支持文本。

```swift
protocol CodingKey {
    var stringValue: String
    var intValue: Int?
}
```

Swift 默认生成的 [`Encodable`](https://developer.apple.com/documentation/swift/encodable/) 和 [`Decodable`](
https://developer.apple.com/documentation/swift/decodable/) 实现使用属性变量名作为 [`CodingKey`](
https://developer.apple.com/documentation/swift/codingkey)。如果希望在编、解码时使用与 Swift
变量不同的属性名，自定义类型可声明一个访问权限至少为 `private`、遵循 [`CodingKey`](
https://developer.apple.com/documentation/swift/codingkey)、原始值类型为 [`String`](
https://developer.apple.com/documentation/swift/string/) 的**嵌套枚举类型**。Swift
编译器在生成默认实现时将参考此枚举提供的名称。

如下定义的类型，`id` 和 `createdAt` 属性在编码时使用不同的名称。

```swift
struct MyModel: Encodable {
    var id: UInt64
    var name: String
    var createdAt: Date

    private enum CodingKeys: String, CodingKey {
        case id = "model_id"
        case name
        case createdAt = "created_at"
    }
}
```

```json
{
    "model_id": /* UInt64 */,
    "name": /* String */, 
    "created_at": /* Double */,
}
```

> Tip: 当类型同时支持编、解码时，Swift 默认实现只支持使用同一份 [`CodingKey`](
https://developer.apple.com/documentation/swift/codingkey)，即每个属性在编码和解码时对应的键必须相同。

自定义 [`CodingKey`](https://developer.apple.com/documentation/swift/codingkey)
也可用于忽略将被编码和解码的属性。如下定义的类型，`createdAt` 属性将不参与编码。

```swift
struct MyModel: Encodable {
    var id: UInt64
    var name: String
    var createdAt: Date

    private enum CodingKeys: String, CodingKey {
        case id = "model_id"
        case name
    }
}
```

```json
{
    "model_id": /* UInt64 */,
    "name": /* String */
}
```

> Tip: 当定义属性不参与解码时，可能必须为其指定默认值才能获取默认 [`Decodable`](
https://developer.apple.com/documentation/swift/decodable/) 实现。
