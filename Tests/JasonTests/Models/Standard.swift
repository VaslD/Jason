public struct Standard: Decodable, Equatable {
    public let null: Range<Int>?

    public let bool: Bool

    public let string: String

    public let int: Int
    public let int8: Int8
    public let int16: Int16
    public let int32: Int32
    public let int64: Int64

    public let uint: UInt
    public let uint8: UInt8
    public let uint16: UInt16
    public let uint32: UInt32
    public let uint64: UInt64

    public let float: Float
    public let double: Double

    public let array: [Standard]
}
