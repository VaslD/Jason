public struct JasonSVDC: SingleValueDecodingContainer {
    public let value: Jason
    public let codingPath: [CodingKey]

    public var userInfo: [CodingUserInfoKey: Any]

    public init(_ value: Jason, codingPath: [CodingKey]) {
        self.value = value
        self.codingPath = codingPath
        self.userInfo = [:]
    }

    public func decodeNil() -> Bool {
        if case .empty = self.value {
            return true
        }
        return false
    }

    public func decode(_ type: Bool.Type) throws -> Bool {
        guard let bool = self.value.asBool() else {
            throw DecodingError.typeMismatch(Bool.self, DecodingError.Context(
                codingPath: self.codingPath,
                debugDescription: "Jason cannot be converted to Bool."
            ))
        }
        return bool
    }

    public func decode(_ type: String.Type) throws -> String {
        guard let string = self.value.asString() else {
            throw DecodingError.typeMismatch(String.self, DecodingError.Context(
                codingPath: self.codingPath,
                debugDescription: "Jason cannot be converted to String."
            ))
        }
        return string
    }

    public func decode(_ type: Double.Type) throws -> Double {
        guard let double = self.value.asDouble() else {
            throw DecodingError.typeMismatch(Double.self, DecodingError.Context(
                codingPath: self.codingPath,
                debugDescription: "Jason cannot be converted to Double."
            ))
        }
        return double
    }

    public func decode(_ type: Float.Type) throws -> Float {
        guard let double = self.value.asDouble() else {
            throw DecodingError.typeMismatch(Double.self, DecodingError.Context(
                codingPath: self.codingPath,
                debugDescription: "Jason cannot be converted to Double."
            ))
        }
        return Float(double)
    }

    public func decode(_ type: Int.Type) throws -> Int {
        guard let int = self.value.asInt() else {
            throw DecodingError.typeMismatch(Int.self, DecodingError.Context(
                codingPath: self.codingPath,
                debugDescription: "Jason cannot be converted to Int."
            ))
        }
        return int
    }

    public func decode(_ type: Int8.Type) throws -> Int8 {
        guard let int = self.value.asInt() else {
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

    public func decode(_ type: Int16.Type) throws -> Int16 {
        guard let int = self.value.asInt() else {
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

    public func decode(_ type: Int32.Type) throws -> Int32 {
        guard let int = self.value.asInt() else {
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

    public func decode(_ type: Int64.Type) throws -> Int64 {
        guard let int = self.value.asInt() else {
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

    public func decode(_ type: UInt.Type) throws -> UInt {
        guard let uint = self.value.asUInt() else {
            throw DecodingError.typeMismatch(UInt.self, DecodingError.Context(
                codingPath: self.codingPath,
                debugDescription: "Jason cannot be converted to UInt."
            ))
        }
        return uint
    }

    public func decode(_ type: UInt8.Type) throws -> UInt8 {
        guard let uint = self.value.asUInt() else {
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

    public func decode(_ type: UInt16.Type) throws -> UInt16 {
        guard let uint = self.value.asUInt() else {
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

    public func decode(_ type: UInt32.Type) throws -> UInt32 {
        guard let uint = self.value.asUInt() else {
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

    public func decode(_ type: UInt64.Type) throws -> UInt64 {
        guard let uint = self.value.asUInt() else {
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

    public func decode<T: Decodable>(_ type: T.Type) throws -> T {
        var decoder = JasonTLD(self.value, codingPath: self.codingPath)
        decoder.userInfo = self.userInfo
        return try T(from: decoder)
    }
}
