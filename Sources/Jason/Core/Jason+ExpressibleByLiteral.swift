// MARK: - Jason + ExpressibleByNilLiteral

extension Jason: ExpressibleByNilLiteral {
    /// 通过 `nil` 表达式创建 ``empty``。
    ///
    /// > Warning: 此方法只能被编译器调用，请勿手动调用此方法！如有需要，参阅《<doc:Using-Cases>》并直接使用
    /// ``empty`` 成员。
    ///
    /// - Parameter nilLiteral: `nil` 字面量。
    @inlinable
    public init(nilLiteral: ()) {
        self = .empty
    }
}

// MARK: - Jason + ExpressibleByBooleanLiteral

extension Jason: ExpressibleByBooleanLiteral {
    /// 通过布尔表达式（例如 `true`）创建 ``boolean(_:)``。
    ///
    /// > Warning: 此方法只能被编译器调用，请勿手动调用此方法！如有需要，参阅《<doc:Using-Cases>》并直接使用
    /// ``boolean(_:)`` 成员。
    ///
    /// - Parameter value: `Bool` 表达式。
    @inlinable
    public init(booleanLiteral value: Bool) {
        self = .boolean(value)
    }
}

// MARK: - Jason + ExpressibleByStringLiteral, ExpressibleByStringInterpolation

extension Jason: ExpressibleByStringLiteral, ExpressibleByStringInterpolation {
    /// 通过字符串表达式（例如 `"someString"`）创建 ``string(_:)``。
    ///
    /// > Warning: 此方法只能被编译器调用，请勿手动调用此方法！如有需要，参阅《<doc:Using-Cases>》并直接使用
    /// ``string(_:)`` 成员。
    ///
    /// - Parameter value: `String` 字面量。
    @inlinable
    public init(stringLiteral value: String) {
        self = .string(value)
    }
}

// MARK: - Jason + ExpressibleByIntegerLiteral

extension Jason: ExpressibleByIntegerLiteral {
    /// 通过整数表达式（例如 `12345`）创建 ``integer(_:)``。
    ///
    /// > Warning: 此方法只能被编译器调用，请勿手动调用此方法！如有需要，参阅《<doc:Using-Cases>》并直接使用
    /// ``integer(_:)`` 成员。
    ///
    /// - Parameter value: `Int` 表达式。
    @inlinable
    public init(integerLiteral value: Int) {
        self = .integer(value)
    }
}

// MARK: - Jason + ExpressibleByFloatLiteral

extension Jason: ExpressibleByFloatLiteral {
    /// 通过浮点数表达式（例如 `0.12345`）创建 ``float(_:)``。
    ///
    /// > Warning: 此方法只能被编译器调用，请勿手动调用此方法！如有需要，参阅《<doc:Using-Cases>》并直接使用
    /// ``float(_:)`` 成员。
    ///
    /// - Parameter value: `Double` 表达式。
    @inlinable
    public init(floatLiteral value: Double) {
        self = .float(value)
    }
}

// MARK: - Jason + ExpressibleByArrayLiteral

extension Jason: ExpressibleByArrayLiteral {
    /// 通过数组表达式（例如 `[some, element]`）创建 ``array(_:)``。
    ///
    /// > Warning: 此方法只能被编译器调用，请勿手动调用此方法！如有需要，参阅《<doc:Using-Cases>》并直接使用
    /// ``array(_:)`` 成员。
    ///
    /// - Parameter elements: `[Jason]` 表达式。
    @inlinable
    public init(arrayLiteral elements: Jason...) {
        self = .array(elements)
    }
}

// MARK: - Jason + ExpressibleByDictionaryLiteral

extension Jason: ExpressibleByDictionaryLiteral {
    /// 通过字典表达式（例如 `["some": element]`）创建 ``dictionary(_:)``。
    ///
    /// > Warning: 此方法只能被编译器调用，请勿手动调用此方法！如有需要，参阅《<doc:Using-Cases>》并直接使用
    /// ``dictionary(_:)`` 成员。
    ///
    /// 如果指定的字典字面量中相同的键对应多个元素，只有最后一次指定的元素会被保留。
    ///
    /// - Parameter elements: `[String: Jason]` 表达式。
    @inlinable
    public init(dictionaryLiteral elements: (String, Jason)...) {
        self = .dictionary([String: Jason](elements, uniquingKeysWith: { _, new in new }))
    }
}
