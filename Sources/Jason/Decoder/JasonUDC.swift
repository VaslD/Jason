import Foundation

public struct JasonUDC: UnkeyedDecodingContainer {
    public let value: [Jason]
    public let codingPath: [CodingKey]

    public private(set) var currentIndex: Int
    public var userInfo: [CodingUserInfoKey: Any]

    public init(_ value: Jason, codingPath: [CodingKey]) throws {
        guard case let .array(array) = value else {
            throw DecodingError.typeMismatch([Any].self, DecodingError.Context(
                codingPath: codingPath,
                debugDescription: "Jason is not JSON Array."
            ))
        }
        self.value = array
        self.codingPath = codingPath
        self.currentIndex = 0
        self.userInfo = [:]
    }

    public var count: Int? {
        self.value.count
    }

    public var isAtEnd: Bool {
        self.currentIndex >= self.value.count
    }

    public mutating func decodeNil() throws -> Bool {
        guard self.value.indices.contains(self.currentIndex) else {
            throw DecodingError.valueNotFound(Any?.self, DecodingError.Context(
                codingPath: self.codingPath,
                debugDescription: "JSON Array has no more elements."
            ))
        }

        if case .empty = self.value[self.currentIndex] {
            self.currentIndex += 1
            return true
        }
        return false
    }

    public mutating func decode(_ type: Bool.Type) throws -> Bool {
        guard self.value.indices.contains(self.currentIndex) else {
            throw DecodingError.valueNotFound(Bool.self, DecodingError.Context(
                codingPath: self.codingPath,
                debugDescription: "JSON Array has no more elements."
            ))
        }

        guard let bool = self.value[self.currentIndex].asBool() else {
            throw DecodingError.typeMismatch(Bool.self, DecodingError.Context(
                codingPath: self.codingPath,
                debugDescription: "Jason cannot be converted to Bool."
            ))
        }
        self.currentIndex += 1
        return bool
    }

    public mutating func decode(_ type: String.Type) throws -> String {
        guard self.value.indices.contains(self.currentIndex) else {
            throw DecodingError.valueNotFound(String.self, DecodingError.Context(
                codingPath: self.codingPath,
                debugDescription: "JSON Array has no more elements."
            ))
        }

        guard let string = self.value[self.currentIndex].asString() else {
            throw DecodingError.typeMismatch(String.self, DecodingError.Context(
                codingPath: self.codingPath,
                debugDescription: "Jason cannot be converted to String."
            ))
        }
        self.currentIndex += 1
        return string
    }

    public mutating func decode(_ type: Double.Type) throws -> Double {
        guard self.value.indices.contains(self.currentIndex) else {
            throw DecodingError.valueNotFound(String.self, DecodingError.Context(
                codingPath: self.codingPath,
                debugDescription: "JSON Array has no more elements."
            ))
        }

        guard let double = self.value[self.currentIndex].asDouble() else {
            throw DecodingError.typeMismatch(Double.self, DecodingError.Context(
                codingPath: self.codingPath,
                debugDescription: "Jason cannot be converted to Double."
            ))
        }
        self.currentIndex += 1
        return double
    }

    public mutating func decode(_ type: Float.Type) throws -> Float {
        guard self.value.indices.contains(self.currentIndex) else {
            throw DecodingError.valueNotFound(Float.self, DecodingError.Context(
                codingPath: self.codingPath,
                debugDescription: "JSON Array has no more elements."
            ))
        }

        guard let double = self.value[self.currentIndex].asDouble() else {
            throw DecodingError.typeMismatch(Double.self, DecodingError.Context(
                codingPath: self.codingPath,
                debugDescription: "Jason cannot be converted to Double."
            ))
        }
        self.currentIndex += 1
        return Float(double)
    }

    public mutating func decode(_ type: Int.Type) throws -> Int {
        guard self.value.indices.contains(self.currentIndex) else {
            throw DecodingError.valueNotFound(Int.self, DecodingError.Context(
                codingPath: self.codingPath,
                debugDescription: "JSON Array has no more elements."
            ))
        }

        guard let int = self.value[self.currentIndex].asInt() else {
            throw DecodingError.typeMismatch(Int.self, DecodingError.Context(
                codingPath: self.codingPath,
                debugDescription: "Jason cannot be converted to Int."
            ))
        }
        self.currentIndex += 1
        return int
    }

    public mutating func decode(_ type: Int8.Type) throws -> Int8 {
        guard self.value.indices.contains(self.currentIndex) else {
            throw DecodingError.valueNotFound(Int8.self, DecodingError.Context(
                codingPath: self.codingPath,
                debugDescription: "JSON Array has no more elements."
            ))
        }

        guard let int = self.value[self.currentIndex].asInt() else {
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
        self.currentIndex += 1
        return int8
    }

    public mutating func decode(_ type: Int16.Type) throws -> Int16 {
        guard self.value.indices.contains(self.currentIndex) else {
            throw DecodingError.valueNotFound(Int16.self, DecodingError.Context(
                codingPath: self.codingPath,
                debugDescription: "JSON Array has no more elements."
            ))
        }

        guard let int = self.value[self.currentIndex].asInt() else {
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
        self.currentIndex += 1
        return int16
    }

    public mutating func decode(_ type: Int32.Type) throws -> Int32 {
        guard self.value.indices.contains(self.currentIndex) else {
            throw DecodingError.valueNotFound(Int32.self, DecodingError.Context(
                codingPath: self.codingPath,
                debugDescription: "JSON Array has no more elements."
            ))
        }

        guard let int = self.value[self.currentIndex].asInt() else {
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
        self.currentIndex += 1
        return int32
    }

    public mutating func decode(_ type: Int64.Type) throws -> Int64 {
        guard self.value.indices.contains(self.currentIndex) else {
            throw DecodingError.valueNotFound(Int64.self, DecodingError.Context(
                codingPath: self.codingPath,
                debugDescription: "JSON Array has no more elements."
            ))
        }

        guard let int = self.value[self.currentIndex].asInt() else {
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
        self.currentIndex += 1
        return int64
    }

    public mutating func decode(_ type: UInt.Type) throws -> UInt {
        guard self.value.indices.contains(self.currentIndex) else {
            throw DecodingError.valueNotFound(UInt.self, DecodingError.Context(
                codingPath: self.codingPath,
                debugDescription: "JSON Array has no more elements."
            ))
        }

        guard let uint = self.value[self.currentIndex].asUInt() else {
            throw DecodingError.typeMismatch(UInt.self, DecodingError.Context(
                codingPath: self.codingPath,
                debugDescription: "Jason cannot be converted to UInt."
            ))
        }
        self.currentIndex += 1
        return uint
    }

    public mutating func decode(_ type: UInt8.Type) throws -> UInt8 {
        guard self.value.indices.contains(self.currentIndex) else {
            throw DecodingError.valueNotFound(UInt8.self, DecodingError.Context(
                codingPath: self.codingPath,
                debugDescription: "JSON Array has no more elements."
            ))
        }

        guard let uint = self.value[self.currentIndex].asUInt() else {
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
        self.currentIndex += 1
        return uint8
    }

    public mutating func decode(_ type: UInt16.Type) throws -> UInt16 {
        guard self.value.indices.contains(self.currentIndex) else {
            throw DecodingError.valueNotFound(UInt16.self, DecodingError.Context(
                codingPath: self.codingPath,
                debugDescription: "JSON Array has no more elements."
            ))
        }

        guard let uint = self.value[self.currentIndex].asUInt() else {
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
        self.currentIndex += 1
        return uint16
    }

    public mutating func decode(_ type: UInt32.Type) throws -> UInt32 {
        guard self.value.indices.contains(self.currentIndex) else {
            throw DecodingError.valueNotFound(UInt32.self, DecodingError.Context(
                codingPath: self.codingPath,
                debugDescription: "JSON Array has no more elements."
            ))
        }

        guard let uint = self.value[self.currentIndex].asUInt() else {
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
        self.currentIndex += 1
        return uint32
    }

    public mutating func decode(_ type: UInt64.Type) throws -> UInt64 {
        guard self.value.indices.contains(self.currentIndex) else {
            throw DecodingError.valueNotFound(UInt64.self, DecodingError.Context(
                codingPath: self.codingPath,
                debugDescription: "JSON Array has no more elements."
            ))
        }

        guard let uint = self.value[self.currentIndex].asUInt() else {
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
        self.currentIndex += 1
        return uint64
    }

    public mutating func decode<T: Decodable>(_ type: T.Type) throws -> T {
        guard self.value.indices.contains(self.currentIndex) else {
            throw DecodingError.valueNotFound(Any?.self, DecodingError.Context(
                codingPath: self.codingPath,
                debugDescription: "JSON Array has no more elements."
            ))
        }

        var decoder = JasonTLD(self.value[self.currentIndex], codingPath: self.codingPath)
        decoder.userInfo = self.userInfo
        let instance = try T(from: decoder)
        self.currentIndex += 1
        return instance
    }

    public mutating func nestedContainer<K: CodingKey>(keyedBy type: K.Type) throws -> KeyedDecodingContainer<K> {
        guard self.value.indices.contains(self.currentIndex) else {
            throw DecodingError.valueNotFound([String: Any].self, DecodingError.Context(
                codingPath: self.codingPath,
                debugDescription: "JSON Array has no more elements."
            ))
        }

        var container = try JasonKDC<K>(self.value[self.currentIndex], codingPath: self.codingPath)
        container.userInfo = self.userInfo
        self.currentIndex += 1
        return KeyedDecodingContainer(container)
    }

    public mutating func nestedUnkeyedContainer() throws -> UnkeyedDecodingContainer {
        guard self.value.indices.contains(self.currentIndex) else {
            throw DecodingError.valueNotFound([Any].self, DecodingError.Context(
                codingPath: self.codingPath,
                debugDescription: "JSON Array has no more elements."
            ))
        }

        var container = try JasonUDC(self.value[self.currentIndex], codingPath: self.codingPath)
        container.userInfo = self.userInfo
        self.currentIndex += 1
        return container
    }

    public mutating func superDecoder() throws -> Decoder {
        throw DecodingError.valueNotFound(Any.self, DecodingError.Context(
            codingPath: self.codingPath,
            debugDescription: "JSON Array has no super decoder."
        ))
    }
}
