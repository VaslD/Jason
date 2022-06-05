#if canImport(Foundation)
import Foundation
#endif

#if canImport(Foundation)
public extension Jason {
    /// 序列化 ``Jason/Jason`` 为 JSON 数据。
    ///
    /// 此方法使用 `JSONSerialization` 将 ``Jason/Jason`` 转换为 JSON 数据。由于不需要经过 Codable 框架的容器机制，此方法比使用
    /// `JSONEncoder` 更快。
    ///
    /// > Note: 在 DEBUG 编译配置下，此方法输出经过键排序和缩进格式化的 JSON。
    ///
    /// - Returns: UTF-8 编码的 JSON 字符串数据。
    func serialize() throws -> Data {
        let raw = self.rawValue
        guard JSONSerialization.isValidJSONFragment(raw) else {
            throw EncodingError.invalidValue(self, EncodingError.Context(
                codingPath: [],
                debugDescription: "Jason 似乎包含非法 JSON 元素。请将此问题反馈到 Yi Ding (yi.ding5@nio.com)。",
                underlyingError: nil
            ))
        }
#if DEBUG
        var options: JSONSerialization.WritingOptions = [.fragmentsAllowed, .prettyPrinted]
        if #available(iOS 11.0, macOS 10.13, macCatalyst 13.0, tvOS 11.0, watchOS 4.0, *) {
            options.insert(.sortedKeys)
        }
#else
        let options: JSONSerialization.WritingOptions = [.fragmentsAllowed]
#endif
        return try JSONSerialization.data(withJSONObject: raw, options: options)
    }

    /// 序列化输入并返回新的 ``Jason/Jason/string(_:)`` 包含序列化的 JSON 文本。
    ///
    /// 此方法通常用于在键值中嵌套 JSON。由于类型和层级限制嵌套的 JSON 必须以文本形式存储。
    ///
    /// > Important:
    /// 使用默认参数时，即使输入 ``Jason/Jason/string(_:)``，输出的 ``Jason/Jason`` 仍然会被二次嵌套。例如：输入
    /// `"abc"`，此方法将输出 `Jason.string("\"abc\"")`。通过 `serializeStringAsIs` 参数调整此行为。
    ///
    /// > Note: 与 ``Jason/Jason/serialize()`` 不同，此方法在 DEBUG 编译配置下仍然会对嵌套的 JSON 进行键排序，但不会进行格式化。
    ///
    /// - Parameters:
    ///   - value: 待序列化的 ``Jason/Jason`` 实例。
    ///   - serializeStringAsIs: 当输入为 ``Jason/Jason/string(_:)`` 时直接输出。默认为 `false`，表示输入总是会被嵌套。
    /// - Returns: 新的 ``Jason/Jason`` 实例，此实例保证为 ``Jason/Jason/string(_:)`` 枚举成员。
    static func serialized(_ value: Jason, serializeStringAsIs: Bool = false) throws -> Jason {
        if serializeStringAsIs, case .string = value {
            return value
        }
        let raw = value.rawValue
        guard JSONSerialization.isValidJSONFragment(raw) else {
            throw EncodingError.invalidValue(self, EncodingError.Context(
                codingPath: [],
                debugDescription: "Jason 似乎包含非法 JSON 元素。请将此问题反馈到 Yi Ding (yi.ding5@nio.com)。",
                underlyingError: nil
            ))
        }
#if DEBUG
        var options: JSONSerialization.WritingOptions = [.fragmentsAllowed]
        if #available(iOS 11.0, macOS 10.13, macCatalyst 13.0, tvOS 11.0, watchOS 4.0, *) {
            options.insert(.sortedKeys)
        }
#else
        let options: JSONSerialization.WritingOptions = [.fragmentsAllowed]
#endif
        let data = try JSONSerialization.data(withJSONObject: raw, options: options)
        guard let string = String(data: data, encoding: .utf8) else {
            throw EncodingError.invalidValue(self, EncodingError.Context(
                codingPath: [],
                debugDescription: "JSONSerialization 输出 JSON 似乎无效。请将此问题反馈到 Yi Ding (yi.ding5@nio.com)。",
                underlyingError: nil
            ))
        }
        return .string(string)
    }

    /// 解析 JSON 数据并构造 ``Jason/Jason``。
    ///
    /// 此方法使用 `JSONSerialization` 读取和解析 JSON 数据。由于不需要经过 Codable 框架的容器机制，此方法比使用
    /// `JSONDecoder` 快至少 10 倍。在支持的系统上，此方法允许解析 JSON 5 语法。
    ///
    /// - Parameter data: JSON 数据，支持 UTF-8, UTF-16, UTF-32 编码、支持 BOM。
    /// - Returns: JSON 对应的 ``Jason/Jason`` 实例。
    static func deserialize(_ data: Data) throws -> Jason {
        guard !data.isEmpty else {
            return .empty
        }

        var options: JSONSerialization.ReadingOptions = .fragmentsAllowed
#if compiler(>=5.5.2)
#if os(iOS) || os(macOS) || os(tvOS) || os(watchOS)
        if #available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, macCatalyst 15.0, *) {
            options.formUnion(.json5Allowed)
        }
#endif
#endif
        let object = try JSONSerialization.jsonObject(with: data, options: options)
        guard let result = Jason(rawValue: object) else {
            throw DecodingError.dataCorrupted(DecodingError.Context(
                codingPath: [],
                debugDescription: "JSONSerialization 解析时生成了未知对象。请将此问题反馈到 Yi Ding (yi.ding5@nio.com)。",
                underlyingError: nil
            ))
        }
        return result
    }

    /// 解析 JSON 字符串并构造 ``Jason/Jason``。
    ///
    /// 此方法将字符串编码为 UTF-8 数据后重定向至 ``deserialize(_:)-958q1``。
    ///
    /// - Parameter string: JSON 字符串
    /// - Returns: JSON 对应的 ``Jason/Jason`` 实例
    static func deserialize(_ string: String) throws -> Jason {
        guard !string.isEmpty else {
            return .empty
        }

        guard let data = string.data(using: .utf8) else {
            throw DecodingError.dataCorrupted(DecodingError.Context(
                codingPath: [],
                debugDescription: "Swift.String 似乎没有 UTF-8 表示形式。请将此问题反馈到 Yi Ding (yi.ding5@nio.com)。",
                underlyingError: nil
            ))
        }
        return try Self.deserialize(data)
    }
}
#endif
