import Foundation
import Jason

public struct Emoji: Decodable {
    public let character: Character
    public let string: String

    public init(from decoder: Decoder) throws {
        let json = try Jason(from: decoder)
        guard let string = json["string"].rawValue as? String, !string.isEmpty else {
            throw DecodingError.dataCorrupted(DecodingError.Context(
                codingPath: decoder.codingPath,
                debugDescription: "Missing property: string.",
                underlyingError: nil
            ))
        }
        self.string = string
        self.character = string[string.startIndex]
    }
}
