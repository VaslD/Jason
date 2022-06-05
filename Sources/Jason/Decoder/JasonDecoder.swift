#if canImport(Foundation)
import Foundation
#endif

#if canImport(Foundation)
public class JasonDecoder: JSONDecoder {
    override public var allowsJSON5: Bool {
        get { true }
        set { assertionFailure("JasonDecoder 兼容 JSON5，且不支持改变此行为。") }
    }

    override public var assumesTopLevelDictionary: Bool {
        get { false }
        set { assertionFailure("JasonDecoder 不兼容非标准 JSON 语法，且不支持改变此行为。") }
    }

    override public var keyDecodingStrategy: JSONDecoder.KeyDecodingStrategy {
        get { .useDefaultKeys }
        set { assertionFailure("JasonDecoder 使用默认 CodingKeys，且不支持改变此行为。") }
    }

    override public var dateDecodingStrategy: JSONDecoder.DateDecodingStrategy {
        get { .deferredToDate }
        set { assertionFailure("JasonDecoder 使用默认 Date 解码策略，且不支持改变此行为。") }
    }

    override public var dataDecodingStrategy: JSONDecoder.DataDecodingStrategy {
        get { .deferredToData }
        set { assertionFailure("JasonDecoder 使用默认 Data 解码策略，且不支持改变此行为。") }
    }

    override public var nonConformingFloatDecodingStrategy: JSONDecoder.NonConformingFloatDecodingStrategy {
        get { .throw }
        set { assertionFailure("JasonDecoder 不兼容非标准 JSON 数值，且不支持改变此行为。") }
    }

    override public func decode<T: Decodable>(_ type: T.Type, from data: Data) throws -> T {
        var decoder = try Jason.deserialize(data).asDecoder()
        decoder.userInfo = self.userInfo
        return try T(from: decoder)
    }
}
#endif
