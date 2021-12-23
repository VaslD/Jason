/// Jason 是包含所有 [JSON](https://www.json.org/json-zh.html) 标准类型的枚举。
@frozen
public enum Jason: Hashable, Sendable {
    /// 表示 JSON 标准中的 `null`。
    ///
    /// ```swift
    /// let x: Jason = nil
    /// let y = Jason.empty
    /// XCTAssertNotNil(x)
    /// XCTAssert(x == y)
    /// ```
    case empty

    /// 表示 JSON 标准中的 `true` 或 `false`。
    ///
    /// > Tip: JSON 标准没有定义**布尔**类型，而是将 `true` 和 `false` 定义为独立的值。
    ///
    /// ```swift
    /// let x: Jason = true
    /// let y: Jason = .boolean(false)
    /// XCTAssertNotEqual(x, y)
    /// ```
    case boolean(Bool)

    /// 表示 JSON 标准中的**字符串**，即一连串 Unicode 字符。
    ///
    /// ```swift
    /// let a: Jason = "A string, 🤣!"
    /// let b = Jason.string("")
    /// let c: Jason = "\(Int.zero)"
    /// XCTAssert(c == "0")
    /// ```
    case string(String)

    /// 表示 JSON 数据中的整数。
    ///
    /// > Important:
    /// JSON 标准没有定义**整数**类型。JSON 仅有一种**数值**类型，用于表示任意十进制数字、同时支持整数和小数且没有上下限规定。当 JSON
    /// 中的数字符合 Swift 中 `Int` 的范围时，将被优先转换为此枚举成员。此枚举成员与 ``unsigned(_:)``、``float(_:)``
    /// 的等价性基于数学比较和 IEEE 754 浮点数定义；序列化时三者可能输出相同的 JSON。
    ///
    /// ```swift
    /// let x: Jason = -1
    /// let y = Jason.integer(2147483647)
    /// XCTAssert(x != y)
    /// ```
    case integer(Int)

    /// 表示 JSON 数据中的无符号整数。
    ///
    /// > Important:
    /// JSON 标准没有定义**整数**类型。JSON 仅有一种**数值**类型，用于表示任意十进制数字，同时支持整数和小数且没有上下限规定。仅当 JSON
    /// 中的数字符合 Swift 中 `UInt` 的范围且无法用 `Int` 表示时，将被转换为此枚举成员。此枚举成员与
    /// ``integer(_:)``、``float(_:)`` 的等价性基于数学比较和 IEEE 754 浮点数定义；序列化时三者可能输出相同的 JSON。
    ///
    /// 此枚举成员无法直接使用字面量表示，必须声明 ``unsigned(_:)`` 或传递 `UInt` 变量给 ``init(rawValue:)-9xl31`` 构造。
    ///
    /// ```swift
    /// let x: Jason = .unsigned(18446744073709551615)
    /// XCTAssert(x == Jason(rawValue: UInt.max))
    /// ```
    case unsigned(UInt)

    /// 表示 JSON 数据中的小数（IEEE 754 浮点数）。
    ///
    /// > Important:
    /// JSON 标准没有定义**浮点数**类型。JSON 仅有一种**数值**类型，用于表示任意十进制数字，同时支持整数和小数且没有上下限规定。仅当
    /// JSON 中的数字符合 Swift 中 `Double` 的范围且无法用 `Int` 或 `UInt` 表示时，将被转换为此枚举成员。此枚举成员与
    /// ``integer(_:)``、``unsigned(_:)`` 的等价性基于数学比较和 IEEE 754 浮点数定义；序列化时三者可能输出相同的 JSON。
    ///
    /// ```swift
    /// let x: Jason = 0.30000000000000004
    ///
    /// // IEEE 754 浮点数标准规定下列等式成立
    /// // 详见 https://0.30000000000000004.com
    /// XCTAssert(x == 0.30000000000000003)
    /// ```
    case float(Double)

    /// 表示 JSON 标准中的**数组**，即按顺序排列的零个或多个值。
    ///
    /// ```swift
    /// let x: Jason = []
    /// let y: Jason = [false, "1", 2.0, x, nil, [5, true]]
    /// ```
    case array([Jason])

    /// 表示 JSON 标准中的**对象**，即无序的零个或多个键值组合。
    ///
    /// ```swift
    /// let x: Jason = [:]
    /// let y: Jason = [
    ///     "A": "a",
    ///     "B": 2,
    ///     "Cc": false,
    ///     "d": x,
    ///     "é": nil,
    ///     "f": [
    ///         "G",
    ///         [true]
    ///     ]
    /// ]
    /// ```
    case dictionary([String: Jason])
}
