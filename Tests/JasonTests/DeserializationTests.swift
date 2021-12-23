import Foundation
import XCTest

@testable import Jason

class DeserializationTests: XCTestCase {
    func testNullDecoding() throws {
        let original = Jason.empty

        let data = try JSONEncoder().encode(original)
        let deserialized = try Jason.deserialize(data)
        let decoded = try JSONDecoder().decodeJason(from: data)

        XCTAssertEqual(deserialized, original)
        XCTAssertEqual(deserialized, decoded)
    }

    func testBooleanDecoding() throws {
        let original = Jason.boolean(true)

        let data = try JSONEncoder().encode(original)
        let deserialized = try Jason.deserialize(data)
        let decoded = try JSONDecoder().decodeJason(from: data)

        XCTAssertEqual(deserialized, original)
        XCTAssertEqual(deserialized, decoded)
    }

    func testStringDecoding() throws {
        let original = Jason.string("JasonSerializationTests")

        let data = try JSONEncoder().encode(original)
        let deserialized = try Jason.deserialize(data)
        let decoded = try JSONDecoder().decodeJason(from: data)

        XCTAssertEqual(deserialized, original)
        XCTAssertEqual(deserialized, decoded)
    }

    func testIntDecoding() throws {
        let original = Jason.integer(Int.max)

        let data = try JSONEncoder().encode(original)
        let deserialized = try Jason.deserialize(data)
        let decoded = try JSONDecoder().decodeJason(from: data)

        XCTAssertEqual(deserialized, original)
        XCTAssertEqual(deserialized, decoded)
    }

    func testUIntDecoding() throws {
        let original = Jason.unsigned(UInt.max)

        let data = try JSONEncoder().encode(original)
        let deserialized = try Jason.deserialize(data)
        let decoded = try JSONDecoder().decodeJason(from: data)

        XCTAssertEqual(deserialized, original)
        XCTAssertEqual(deserialized, decoded)
    }

    func testDoubleDecoding() throws {
        let original = Jason.float(Double.pi)

        let data = try JSONEncoder().encode(original)
        let deserialized = try Jason.deserialize(data)
        let decoded = try JSONDecoder().decodeJason(from: data)

        XCTAssertEqual(deserialized, original)
        XCTAssertEqual(deserialized, decoded)
    }

    func testArrayDecoding() throws {
        let original = Jason.array([
            .empty,
            .string("JasonDeserializationTests"),
            .boolean(true),
            .integer(Int.min),
            .unsigned(UInt.max)
        ])

        let data = try JSONEncoder().encode(original)
        let deserialized = try Jason.deserialize(data)
        let decoded = try JSONDecoder().decodeJason(from: data)

        XCTAssertEqual(deserialized, original)
        XCTAssertEqual(deserialized, decoded)
    }

    func testObjectDecoding() throws {
        let worldState = Bundle.module.url(forResource: "WorldState", withExtension: "json")!
        let data = try Data(contentsOf: worldState)
        let deserialized = try Jason.deserialize(data)
        let decoded = try JSONDecoder().decodeJason(from: data)
        XCTAssertEqual(deserialized, decoded)
    }
}
