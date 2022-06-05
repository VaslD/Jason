public struct JasonKDC<Key: CodingKey>: KeyedDecodingContainerProtocol {
    public let value: [String: Jason]
    public let codingPath: [CodingKey]

    public var userInfo: [CodingUserInfoKey: Any]

    public init(_ value: Jason, codingPath: [CodingKey]) throws {
        guard case let .dictionary(dict) = value else {
            throw DecodingError.typeMismatch([String: Any].self, DecodingError.Context(
                codingPath: codingPath,
                debugDescription: "Jason is not JSON Object."
            ))
        }
        self.value = dict
        self.codingPath = codingPath
        self.userInfo = [:]
    }

    public var allKeys: [Key] {
        self.value.keys.compactMap(Key.init(stringValue:))
    }

    public func contains(_ key: Key) -> Bool {
        self.value.keys.contains(key.stringValue)
    }

    public func decodeNil(forKey key: Key) throws -> Bool {
        let property = key.stringValue
        guard self.value.keys.contains(property) else {
            throw DecodingError.keyNotFound(key, DecodingError.Context(
                codingPath: self.codingPath,
                debugDescription: "JSON Object has no property matching \"\(property)\"."
            ))
        }

        if case .empty = self.value[property] {
            return true
        }
        return false
    }

    public func decode(_ type: Bool.Type, forKey key: Key) throws -> Bool {
        let property = key.stringValue
        guard let item = self.value[property] else {
            throw DecodingError.keyNotFound(key, DecodingError.Context(
                codingPath: self.codingPath,
                debugDescription: "JSON Object has no property matching \"\(property)\"."
            ))
        }

        guard let bool = item.asBool() else {
            throw DecodingError.typeMismatch(Bool.self, DecodingError.Context(
                codingPath: self.codingPath,
                debugDescription: "Jason cannot be converted to Bool."
            ))
        }
        return bool
    }

    public func decode(_ type: String.Type, forKey key: Key) throws -> String {
        let property = key.stringValue
        guard let item = self.value[property] else {
            throw DecodingError.keyNotFound(key, DecodingError.Context(
                codingPath: self.codingPath,
                debugDescription: "JSON Object has no property matching \"\(property)\"."
            ))
        }

        guard let string = item.asString() else {
            throw DecodingError.typeMismatch(String.self, DecodingError.Context(
                codingPath: self.codingPath,
                debugDescription: "Jason cannot be converted to String."
            ))
        }
        return string
    }

    public func decode(_ type: Double.Type, forKey key: Key) throws -> Double {
        let property = key.stringValue
        guard let item = self.value[property] else {
            throw DecodingError.keyNotFound(key, DecodingError.Context(
                codingPath: self.codingPath,
                debugDescription: "JSON Object has no property matching \"\(property)\"."
            ))
        }

        guard let double = item.asDouble() else {
            throw DecodingError.typeMismatch(Double.self, DecodingError.Context(
                codingPath: self.codingPath,
                debugDescription: "Jason cannot be converted to Double."
            ))
        }
        return double
    }

    public func decode(_ type: Float.Type, forKey key: Key) throws -> Float {
        let property = key.stringValue
        guard let item = self.value[property] else {
            throw DecodingError.keyNotFound(key, DecodingError.Context(
                codingPath: self.codingPath,
                debugDescription: "JSON Object has no property matching \"\(property)\"."
            ))
        }

        guard let double = item.asDouble() else {
            throw DecodingError.typeMismatch(Double.self, DecodingError.Context(
                codingPath: self.codingPath,
                debugDescription: "Jason cannot be converted to Double."
            ))
        }
        return Float(double)
    }

    public func decode(_ type: Int.Type, forKey key: Key) throws -> Int {
        let property = key.stringValue
        guard let item = self.value[property] else {
            throw DecodingError.keyNotFound(key, DecodingError.Context(
                codingPath: self.codingPath,
                debugDescription: "JSON Object has no property matching \"\(property)\"."
            ))
        }

        guard let int = item.asInt() else {
            throw DecodingError.typeMismatch(Int.self, DecodingError.Context(
                codingPath: self.codingPath,
                debugDescription: "Jason cannot be converted to Int."
            ))
        }
        return int
    }

    public func decode(_ type: Int8.Type, forKey key: Key) throws -> Int8 {
        let property = key.stringValue
        guard let item = self.value[property] else {
            throw DecodingError.keyNotFound(key, DecodingError.Context(
                codingPath: self.codingPath,
                debugDescription: "JSON Object has no property matching \"\(property)\"."
            ))
        }

        guard let int = item.asInt() else {
            throw DecodingError.typeMismatch(Int.self, DecodingError.Context(
                codingPath: self.codingPath,
                debugDescription: "Jason cannot be converted to Int."
            ))
        }
        guard let int8 = Int8(exactly: int) else {
            throw DecodingError.typeMismatch(Int8.self, DecodingError.Context(
                codingPath: self.codingPath,
                debugDescription: "Jason can be converted to Int, but not Int8."
            ))
        }
        return int8
    }

    public func decode(_ type: Int16.Type, forKey key: Key) throws -> Int16 {
        let property = key.stringValue
        guard let item = self.value[property] else {
            throw DecodingError.keyNotFound(key, DecodingError.Context(
                codingPath: self.codingPath,
                debugDescription: "JSON Object has no property matching \"\(property)\"."
            ))
        }

        guard let int = item.asInt() else {
            throw DecodingError.typeMismatch(Int.self, DecodingError.Context(
                codingPath: self.codingPath,
                debugDescription: "Jason cannot be converted to Int."
            ))
        }
        guard let int16 = Int16(exactly: int) else {
            throw DecodingError.typeMismatch(Int16.self, DecodingError.Context(
                codingPath: self.codingPath,
                debugDescription: "Jason can be converted to Int, but not Int16."
            ))
        }
        return int16
    }

    public func decode(_ type: Int32.Type, forKey key: Key) throws -> Int32 {
        let property = key.stringValue
        guard let item = self.value[property] else {
            throw DecodingError.keyNotFound(key, DecodingError.Context(
                codingPath: self.codingPath,
                debugDescription: "JSON Object has no property matching \"\(property)\"."
            ))
        }

        guard let int = item.asInt() else {
            throw DecodingError.typeMismatch(Int.self, DecodingError.Context(
                codingPath: self.codingPath,
                debugDescription: "Jason cannot be converted to Int."
            ))
        }
        guard let int32 = Int32(exactly: int) else {
            throw DecodingError.typeMismatch(Int32.self, DecodingError.Context(
                codingPath: self.codingPath,
                debugDescription: "Jason can be converted to Int, but not Int32."
            ))
        }
        return int32
    }

    public func decode(_ type: Int64.Type, forKey key: Key) throws -> Int64 {
        let property = key.stringValue
        guard let item = self.value[property] else {
            throw DecodingError.keyNotFound(key, DecodingError.Context(
                codingPath: self.codingPath,
                debugDescription: "JSON Object has no property matching \"\(property)\"."
            ))
        }

        guard let int = item.asInt() else {
            throw DecodingError.typeMismatch(Int.self, DecodingError.Context(
                codingPath: self.codingPath,
                debugDescription: "Jason cannot be converted to Int."
            ))
        }
        guard let int64 = Int64(exactly: int) else {
            throw DecodingError.typeMismatch(Int64.self, DecodingError.Context(
                codingPath: self.codingPath,
                debugDescription: "Jason can be converted to Int, but not Int64."
            ))
        }
        return int64
    }

    public func decode(_ type: UInt.Type, forKey key: Key) throws -> UInt {
        let property = key.stringValue
        guard let item = self.value[property] else {
            throw DecodingError.keyNotFound(key, DecodingError.Context(
                codingPath: self.codingPath,
                debugDescription: "JSON Object has no property matching \"\(property)\"."
            ))
        }

        guard let uint = item.asUInt() else {
            throw DecodingError.typeMismatch(UInt.self, DecodingError.Context(
                codingPath: self.codingPath,
                debugDescription: "Jason cannot be converted to UInt."
            ))
        }
        return uint
    }

    public func decode(_ type: UInt8.Type, forKey key: Key) throws -> UInt8 {
        let property = key.stringValue
        guard let item = self.value[property] else {
            throw DecodingError.keyNotFound(key, DecodingError.Context(
                codingPath: self.codingPath,
                debugDescription: "JSON Object has no property matching \"\(property)\"."
            ))
        }

        guard let uint = item.asUInt() else {
            throw DecodingError.typeMismatch(UInt.self, DecodingError.Context(
                codingPath: self.codingPath,
                debugDescription: "Jason cannot be converted to UInt."
            ))
        }
        guard let uint8 = UInt8(exactly: uint) else {
            throw DecodingError.typeMismatch(UInt8.self, DecodingError.Context(
                codingPath: self.codingPath,
                debugDescription: "Jason can be converted to UInt, but not UInt8."
            ))
        }
        return uint8
    }

    public func decode(_ type: UInt16.Type, forKey key: Key) throws -> UInt16 {
        let property = key.stringValue
        guard let item = self.value[property] else {
            throw DecodingError.keyNotFound(key, DecodingError.Context(
                codingPath: self.codingPath,
                debugDescription: "JSON Object has no property matching \"\(property)\"."
            ))
        }

        guard let uint = item.asUInt() else {
            throw DecodingError.typeMismatch(UInt.self, DecodingError.Context(
                codingPath: self.codingPath,
                debugDescription: "Jason cannot be converted to UInt."
            ))
        }
        guard let uint16 = UInt16(exactly: uint) else {
            throw DecodingError.typeMismatch(UInt16.self, DecodingError.Context(
                codingPath: self.codingPath,
                debugDescription: "Jason can be converted to UInt, but not UInt16."
            ))
        }
        return uint16
    }

    public func decode(_ type: UInt32.Type, forKey key: Key) throws -> UInt32 {
        let property = key.stringValue
        guard let item = self.value[property] else {
            throw DecodingError.keyNotFound(key, DecodingError.Context(
                codingPath: self.codingPath,
                debugDescription: "JSON Object has no property matching \"\(property)\"."
            ))
        }

        guard let uint = item.asUInt() else {
            throw DecodingError.typeMismatch(UInt.self, DecodingError.Context(
                codingPath: self.codingPath,
                debugDescription: "Jason cannot be converted to UInt."
            ))
        }
        guard let uint32 = UInt32(exactly: uint) else {
            throw DecodingError.typeMismatch(UInt32.self, DecodingError.Context(
                codingPath: self.codingPath,
                debugDescription: "Jason can be converted to UInt, but not UInt32."
            ))
        }
        return uint32
    }

    public func decode(_ type: UInt64.Type, forKey key: Key) throws -> UInt64 {
        let property = key.stringValue
        guard let item = self.value[property] else {
            throw DecodingError.keyNotFound(key, DecodingError.Context(
                codingPath: self.codingPath,
                debugDescription: "JSON Object has no property matching \"\(property)\"."
            ))
        }

        guard let uint = item.asUInt() else {
            throw DecodingError.typeMismatch(UInt.self, DecodingError.Context(
                codingPath: self.codingPath,
                debugDescription: "Jason cannot be converted to UInt."
            ))
        }
        guard let uint64 = UInt64(exactly: uint) else {
            throw DecodingError.typeMismatch(UInt64.self, DecodingError.Context(
                codingPath: self.codingPath,
                debugDescription: "Jason can be converted to UInt, but not UInt64."
            ))
        }
        return uint64
    }

    public func decode<T: Decodable>(_ type: T.Type, forKey key: Key) throws -> T {
        let property = key.stringValue
        guard let item = self.value[property] else {
            throw DecodingError.keyNotFound(key, DecodingError.Context(
                codingPath: self.codingPath,
                debugDescription: "JSON Object has no property matching \"\(property)\"."
            ))
        }

        var decoder = JasonTLD(item, codingPath: self.codingPath)
        decoder.userInfo = self.userInfo
        return try T(from: decoder)
    }

    public func nestedContainer<K: CodingKey>(keyedBy type: K.Type,
                                              forKey key: Key) throws -> KeyedDecodingContainer<K> {
        let property = key.stringValue
        guard let item = self.value[property] else {
            throw DecodingError.keyNotFound(key, DecodingError.Context(
                codingPath: self.codingPath,
                debugDescription: "JSON Object has no property matching \"\(key.stringValue)\"."
            ))
        }

        var container = try JasonKDC<K>(item, codingPath: self.codingPath)
        container.userInfo = self.userInfo
        return KeyedDecodingContainer(container)
    }

    public func nestedUnkeyedContainer(forKey key: Key) throws -> UnkeyedDecodingContainer {
        let property = key.stringValue
        guard let item = self.value[property] else {
            throw DecodingError.keyNotFound(key, DecodingError.Context(
                codingPath: self.codingPath,
                debugDescription: "JSON Object has no property matching \"\(property)\"."
            ))
        }

        var container = try JasonUDC(item, codingPath: self.codingPath)
        container.userInfo = self.userInfo
        return container
    }

    public func superDecoder() throws -> Decoder {
        throw DecodingError.valueNotFound(Any.self, DecodingError.Context(
            codingPath: self.codingPath,
            debugDescription: "JSON Object has no super decoder."
        ))
    }

    public func superDecoder(forKey key: Key) throws -> Decoder {
        throw DecodingError.valueNotFound(Any.self, DecodingError.Context(
            codingPath: self.codingPath,
            debugDescription: "JSON Object has no super decoder."
        ))
    }
}
