#if canImport(Foundation)

import Foundation

public extension Jason {
    /// 序列化 ``Jason`` 为 JSON 数据。
    ///
    /// 此方法使用 `JSONSerialization` 将 ``Jason`` 转换为 JSON 数据。由于不需要经过 Codable 框架的容器机制，此方法比使用
    /// `JSONEncoder` 更快。
    ///
    /// > Note: 在 DEBUG 编译配置下，此方法输出经过键排序和缩进格式化的 JSON。
    ///
    /// - Returns: UTF-8 编码的 JSON 字符串数据
    func serialize() throws -> Data {
        let value = self.rawValue
        guard JSONSerialization.isValidJSONObject(value) else {
            throw JasonError.inconvertible
        }
#if DEBUG
        let options: JSONSerialization.WritingOptions = [.fragmentsAllowed, .sortedKeys, .prettyPrinted]
#else
        let options: JSONSerialization.WritingOptions = .fragmentsAllowed
#endif
        return try JSONSerialization.data(withJSONObject: value, options: options)
    }

    /// 解析 JSON 数据并构造 ``Jason``。
    ///
    /// 此方法使用 `JSONSerialization` 读取和解析 JSON 数据。由于不需要经过 Codable 框架的容器机制，此方法比使用
    /// `JSONDecoder` 快至少 10 倍。在支持的系统上，此方法允许解析 JSON 5 语法。
    ///
    /// - Parameter data: JSON 数据
    /// - Returns: JSON 对应的 ``Jason`` 实例
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
            throw JasonError.inconvertible
        }
        return result
    }

    /// 解析 JSON 字符串并构造 ``Jason``。
    ///
    /// 此方法使用 `JSONSerialization` 读取和解析 JSON 数据。由于不需要经过 Codable 框架的容器机制，此方法比使用
    /// `JSONDecoder` 快约 10 倍。
    ///
    /// - Parameter string: JSON 字符串
    /// - Returns: JSON 对应的 ``Jason`` 实例
    static func deserialize(_ string: String) throws -> Jason {
        guard !string.isEmpty else {
            return .empty
        }

        guard let data = string.data(using: .utf8) else {
            throw JasonError.inconvertible
        }
        return try Self.deserialize(data)
    }
}

#endif
