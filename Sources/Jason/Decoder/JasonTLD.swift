public struct JasonTLD: Decoder {
    public let value: Jason
    public let codingPath: [CodingKey]

    public var userInfo: [CodingUserInfoKey: Any]

    public init(_ value: Jason, codingPath: [CodingKey]) {
        self.value = value
        self.codingPath = codingPath
        self.userInfo = [:]
    }

    public func container<K: CodingKey>(keyedBy type: K.Type) throws -> KeyedDecodingContainer<K> {
        try KeyedDecodingContainer(JasonKDC(self.value, codingPath: self.codingPath))
    }

    public func unkeyedContainer() throws -> UnkeyedDecodingContainer {
        try JasonUDC(self.value, codingPath: self.codingPath)
    }

    public func singleValueContainer() throws -> SingleValueDecodingContainer {
        JasonSVDC(self.value, codingPath: self.codingPath)
    }
}

// MARK: - Jason -> Decoder

public extension Jason {
    func asDecoder(_ codingPath: [CodingKey] = []) throws -> JasonTLD {
        JasonTLD(self, codingPath: codingPath)
    }
}
