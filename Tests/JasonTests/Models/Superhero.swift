import Foundation

public struct Superhero: Decodable, Equatable, Hashable {
    public let name: String
    public let age: UInt
    public let secretIdentity: String
    public let powers: [String]
}
