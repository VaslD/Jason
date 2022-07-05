import Foundation
import XCTest

@testable import Jason

class SerializationTests: XCTestCase {
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

    func testSerializedJason() throws {
        var value: Jason = nil
        value["params"] = try .serialized([
            "keys": "someKey",
            "category": ["my category"],
        ])

        value["params"] = try .serialized("ABC")
        let x = try value.serialize()

        value["params"] = try .serialized("ABC", serializeStringAsIs: true)
        let y = try value.serialize()
        XCTAssert(x != y)
    }

    func testDeserializationJSON() throws {
        guard let symbols = Bundle.module.url(forResource: "Jason Symbols", withExtension: "json"),
              let rows = Bundle.module.url(forResource: "All Rows", withExtension: "json") else {
            return
        }
        var data = try Data(contentsOf: symbols, options: .mappedIfSafe)
        _ = try Jason.deserialize(data)

        data = try Data(contentsOf: rows, options: .mappedIfSafe)
        _ = try Jason.deserialize(data)
    }
    
    func testDecimalBehaviors() throws {
        let double = 0.8
        try XCTAssertEqual(JSONEncoder().encode(double), "0.80000000000000004".data(using: .utf8)!)
        
        var doubleAsJason: Jason = 0.8
        XCTAssertEqual(doubleAsJason.rawValue as! Double, 0.8)
        try XCTAssertEqual(JSONEncoder().encode(doubleAsJason), "0.8".data(using: .utf8)!)
        try XCTAssertEqual(doubleAsJason.serialize(), "0.8".data(using: .utf8)!)
        
        doubleAsJason = Jason(rawValue: double)!
        XCTAssertEqual(doubleAsJason.rawValue as! Double, 0.8)
        try XCTAssertEqual(JSONEncoder().encode(doubleAsJason), "0.8".data(using: .utf8)!)
        try XCTAssertEqual(doubleAsJason.serialize(), "0.8".data(using: .utf8)!)
        
        doubleAsJason = Jason(rawValue: Decimal(0.8))!
        XCTAssertEqual(doubleAsJason.rawValue as! Double, 0.8)
        XCTAssertEqual(doubleAsJason.rawValue as! Decimal, 0.8)
        XCTAssertEqual(doubleAsJason.rawValue as! Decimal, 0.80000000000000004)
        try XCTAssertEqual(JSONEncoder().encode(doubleAsJason), "0.8".data(using: .utf8)!)
        try XCTAssertEqual(doubleAsJason.serialize(), "0.8".data(using: .utf8)!)
        
        doubleAsJason = Jason(rawValue: NSDecimalNumber(string: "0.80000000000000004"))!
        XCTAssertNotEqual(doubleAsJason.rawValue as! Decimal, NSDecimalNumber(string: "0.80000000000000004") as Decimal)
    }
}
