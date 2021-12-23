import Foundation
import XCTest

#if canImport(ZippyJSON)
import ZippyJSON
#endif

@testable import Jason

class JSONTests: XCTestCase {
    // MARK: Configuration

#if canImport(ZippyJSON)
    typealias Decoder = ZippyJSONDecoder
    typealias Encoder = ZippyJSONEncoder
#else
    typealias Decoder = JSONDecoder
    typealias Encoder = JSONEncoder
#endif

    // MARK: Tests

    func testJSONEmpty() {
        let x: Jason = nil
        XCTAssertNotNil(x)
        XCTAssert(x == nil)
        XCTAssert(x == .empty)
        XCTAssert(x != 0)
        XCTAssert(x == Jason?.none)
        XCTAssert(x == String?.none)
    }

    func testJSONBoolean() {
        let x: Jason = true
        let y: Jason = false
        XCTAssert(x == true)
        XCTAssert(x == Bool???(true) as Any?)
        XCTAssert(y == false)
        XCTAssertNotEqual(x, y)
        XCTAssert(x != 1)
    }

    func testJSONString() {
        let a: Jason = "A string!"
        let b: Jason = "🤣"
        let c: Jason = ""
        let d: Jason = "\(Int.zero)"
        XCTAssert(a == "A string!")
        XCTAssert(b == "🤣")
        XCTAssert(c == "")
        XCTAssert(d == "0")
        XCTAssert(d != 0)
    }

    func testJSONNumber() {
        let a: Jason = 0
        let b: Jason = 2147483647
        XCTAssert(a == 0)
        XCTAssert(a != nil)
        XCTAssert(b == 2147483647)

        let c: Jason = 0.0
        let d: Jason = 0.30000000000000004
        XCTAssert(c == 0)
        XCTAssert(c != nil)
        XCTAssert(d == 0.30000000000000003)

#if arch(arm) || arch(i386) || arch(arm64_32)
        let e: Jason = .unsigned(4294967295)
#else
        let e: Jason = .unsigned(18446744073709551615)
#endif
        let f = Jason.unsigned(0)
        XCTAssert(e == .unsigned(UInt.max))
        XCTAssert(f == 0)
        XCTAssert(f == 0.0)
        XCTAssert(f != "0")

        XCTAssert(a == c)
        XCTAssert(a == f)
        XCTAssert(c == f)
    }

    func testJSONArray() {
        let x: Jason = []
        let y: Jason = [false, "1", 2.0, true, 4, nil]
        XCTAssert(x == [])
        XCTAssert(x != [:])
        XCTAssert(y == [false, "1", 2, true, 4.0, nil])
    }

    func testJSONObject() {
        let x: Jason = [:]
        let y: Jason = [
            "A": "a",
            "B": 2,
            "Cc": false,
            "d": ["D"],
            "é": nil
        ]
        XCTAssert(x == [:])
        XCTAssert(x != [])
        XCTAssert(y == [
            "A": "a",
            "B": 2.0,
            "Cc": false,
            "d": ["D"],
            "é": .empty
        ])
    }

    func testRawValue() {
        let array = [true, 2.0, 3, "🪵🧍", UInt.max] as [Any]
        let x = Jason(rawValue: array)
        XCTAssertNotNil(x)
        XCTAssertNotNil(x?.rawValue as? [Any])
        XCTAssert(x?[2].rawValue as? Int == 3)

        let xPrime = Jason(rawValue: [x])
        XCTAssertEqual(xPrime?[0], x)

        let dictionary = [
            "array": array,
            "JSON": x!,
            "nothing": String?.none as Any
        ] as [String: Any]
        let y = Jason(rawValue: dictionary)
        XCTAssertNotNil(y)
        XCTAssertNotNil(y?.rawValue as? [String: Any])
        XCTAssert((y?["array"].rawValue as? [Any])?[2] as? Int == 3)
        XCTAssert((y?.rawValue as? [String: Any])?["JSON"] is [Any])

        let yPrime = Jason(rawValue: ["y": y])
        XCTAssertEqual(yPrime?["y"], y)

        XCTAssertNil(Jason(rawValue: [Date()] as [Any]))
        XCTAssertNil(Jason(rawValue: ["date": Date()] as [String: Any]))
    }

    func testJSONSubscript() throws {
        XCTAssert(JasonIndex.property("123") == "123")
        XCTAssert(JasonIndex.element(1) == 1)

        var x: Jason = [3.14, "pi"]
        XCTAssert(x[.invalid] == nil)
        XCTAssert(x[0] == 3.14)
        XCTAssert(x[0].rawValue as? Double == 3.14)
        XCTAssert(x[1][2] == nil)
        XCTAssert(x[1][2] == .empty)
        x[0] = 3.1415
        XCTAssert(x[0] == 3.1415)
        x[5] = "No Data Loss"
        XCTAssert(x[1] == "pi")
        XCTAssert(x[2] == nil)
        XCTAssert(x[3] == nil)
        XCTAssert(x[4] == nil)
        XCTAssert(x[5] == "No Data Loss")
        XCTAssert(x.count == 6)
        x["key"] = "Data Loss"
        XCTAssert(x["key"] == nil)

        let copy = x
        x[.invalid] = "~"
        XCTAssert(copy == x)
        x[Int.min] = "~"
        XCTAssert(copy == x)

        var y: Jason = [
            "pi": 3.14
        ]
        XCTAssert(y["pi"] == 3.14)
        XCTAssert(y["pi"].rawValue as? Double == 3.14)
        XCTAssert(y["Pi"]["value"] == nil)
        XCTAssert(y["Pi"]["value"] == .empty)
        y["e"] = 2.71828
        XCTAssert(y["e"] == 2.71828)
        y[0] = "Data Loss"
        XCTAssert(y[0] == nil)
        XCTAssert(y["keyA"] == nil)

        y["keyA"]["keyB"] = 15
        XCTAssert(y["keyA"] != nil)
        XCTAssert(y["keyA"].rawValue is [String: Any])
        XCTAssert(y["keyA"]["keyB"] == 15)

        x[15]["key"][2] = y
        XCTAssert(x.count == 16)
        XCTAssertFalse(x[15].isEmpty)
        XCTAssert(x[15]["key"].rawValue is [Any])
        XCTAssert(x[15]["key"][2]["keyA"]["keyB"] == 15)
    }

    func testJSON() throws {
        let countries = Bundle.module.url(forResource: "Countries", withExtension: "json")!
        var data = try Data(contentsOf: countries)
        var model = try Decoder().decode(Jason.self, from: data)
        XCTAssert(Set([
            "AF",
            "AN",
            "AS",
            "EU",
            "NA",
            "OC",
            "SA"
        ]) == Set((model["continents"].rawValue as! [String: Any]).keys))

        let worldState = Bundle.module.url(forResource: "WorldState", withExtension: "json")!
        data = try Data(contentsOf: worldState)
        model = try Decoder().decode(Jason.self, from: data)
        XCTAssert(model["timestamp"] == "2021-06-01T07:20:12.000Z")

        let largeNumber = "18446744073709551615".data(using: .utf8)!
        XCTAssertNoThrow(try Decoder().decode(Jason.self, from: largeNumber))

        let simpleJSON = "null".data(using: .utf8)!
        model = try Decoder().decode(Jason.self, from: simpleJSON)["someKey"]

        let emoji = try Decoder().decode(Emoji.self, from: "{\"string\":\"😀 (Emoji)\"}".data(using: .utf8)!)
        XCTAssertEqual(emoji.character, "😀")
        XCTAssertEqual(emoji.string, "😀 (Emoji)")
    }

    func testValueConversion() {
        let a: Jason = true
        XCTAssertEqual(a.asBool(), true)
        XCTAssertEqual(a.asString(), "true")
        XCTAssertEqual(a.asInt(), 1)
        XCTAssertEqual(a.asUInt(), 1)
        XCTAssertEqual(a.asDouble(), 1)

        let b: Jason = "false"
        XCTAssertEqual(b.asBool(), false)
        XCTAssertEqual(b.asString(), "false")
        XCTAssertNil(b.asInt())
        XCTAssertNil(b.asUInt())
        XCTAssertNil(b.asDouble())

        let c: Jason = 42
        XCTAssertNil(c.asBool())
        XCTAssertEqual(c.asString(), "42")
        XCTAssertEqual(c.asInt(), 42)
        XCTAssertEqual(c.asUInt(), 42)
        XCTAssertEqual(c.asDouble(), 42.0)

        let d: Jason = 3.14
        XCTAssertNil(d.asBool())
        XCTAssertEqual(d.asString(), "3.14")
        XCTAssertNil(d.asInt())
        XCTAssertNil(d.asUInt())
        XCTAssertEqual(d.asDouble(), 3.14000000)

        let e: Jason = nil
        XCTAssertNil(e.asBool())
        XCTAssertNil(e.asString())
        XCTAssertNil(e.asInt())
        XCTAssertNil(e.asUInt())
        XCTAssertNil(e.asDouble())

        XCTAssert(Jason.integer(1).asBool()!)
        XCTAssertFalse(Jason.integer(0).asBool()!)
        XCTAssert(Jason.unsigned(1).asBool()!)
        XCTAssertFalse(Jason.unsigned(0).asBool()!)
        XCTAssertNil(Jason.unsigned(300).asBool())
        XCTAssert(Jason(rawValue: 1.0)!.asBool()!)
        XCTAssertFalse(Jason(rawValue: 0.0)!.asBool()!)

        XCTAssert(Jason.unsigned(UInt.max).asString() == "18446744073709551615")

        XCTAssert(Jason.boolean(false).asInt() == 0)
        XCTAssert(Jason.unsigned(0).asInt() == 0)
        XCTAssertNil(Jason.unsigned(UInt.max).asInt())

        XCTAssert(Jason.boolean(false).asUInt() == 0)
        XCTAssert(Jason.unsigned(UInt.max).asUInt() == UInt.max)

        XCTAssert(Jason.boolean(false).asDouble() == 0)
        XCTAssert(Jason.unsigned(UInt.max).asDouble() == Double(UInt.max))
    }

    func testFoundationCompatibility() throws {
        let encoded = try JSONSerialization.data(withJSONObject: [
            "A": [
                nil,
                "b",
                3,
                4.0,
                UInt.max,
                true
            ]
        ], options: [])
        let json: Jason = [
            "A": [
                nil,
                "b",
                3,
                4.0,
                Jason(rawValue: UInt.max)!,
                .boolean(true)
            ]
        ]
        let data = try Encoder().encode(json)
        XCTAssertEqual(encoded, data)
    }

    func testNullValue() throws {
        let encoder = Encoder()
        let decoder = Decoder()

        let object: Jason = [
            "has_value": 1,
            "no_value": nil,
            "four_elements": [
                nil,
                1,
                2,
                3,
                4,
                5
            ]
        ]
        XCTAssert(object["no_value"] == nil)
        XCTAssert((object["four_elements"].rawValue as! [Any]).count == 6)

        var data = try encoder.encode(object)
        var decoded = try decoder.decodeJason(from: data)
        XCTAssertFalse((decoded.rawValue as! [String: Any]).keys.contains("no_value"))
        XCTAssert((decoded["four_elements"].rawValue as! [Any]).count == 6)

        encoder.userInfo[CodingUserInfoKey.Jason.keepNullValues] = true
        data = try encoder.encode(object)
        decoded = try decoder.decodeJason(from: data)
        XCTAssert((decoded.rawValue as! [String: Any]).keys.contains("no_value"))

        encoder.userInfo[CodingUserInfoKey.Jason.skipNullValues] = true
        data = try encoder.encode(object)
        decoded = try decoder.decodeJason(from: data)
        XCTAssert((decoded["four_elements"].rawValue as! [Any]).count == 5)
    }

    func testEnumRawValue() throws {
        enum Number: Int, LosslessStringConvertible {
            case negativeOne = -1
            case zero
            case one

            var description: String {
                switch self {
                case .negativeOne:
                    return "negativeOne"
                case .zero:
                    return "0"
                case .one:
                    return "一"
                }
            }

            init?(_ description: String) {
                switch description {
                case "negativeOne":
                    self = .negativeOne
                case "0":
                    self = .zero
                case "一":
                    self = .one
                default:
                    return nil
                }
            }
        }

        let number = Number.negativeOne
        let json = Jason(rawValue: number)!
        XCTAssert(json == -1)
        XCTAssert(json == Jason(rawValue: -1))
    }
}
