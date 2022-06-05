import Foundation
import XCTest

@testable import Jason

class DecoderTests: XCTestCase {
    func testStandardTypes() throws {
        let simple = Bundle.module.url(forResource: "Simple", withExtension: "json")!
        let data = try Data(contentsOf: simple)
        let model = try JasonDecoder().decode(Standard.self, from: data)

        XCTAssertEqual(model.null, nil)
        XCTAssertEqual(model.bool, true)
        XCTAssertEqual(model.string, "Abç")
        XCTAssertEqual(model.int, Int(Int32.max))
        XCTAssertEqual(model.uint, UInt(UInt32.max))
        XCTAssertEqual(model.float, 1 / 2)
        XCTAssertEqual(model.double, 79228162514264337593543950336)
        XCTAssertEqual(model.int8, Int8.max)
        XCTAssertEqual(model.int16, Int16.max)
        XCTAssertEqual(model.int32, Int32.max)
        XCTAssertEqual(model.int64, Int64.max)
        XCTAssertEqual(model.uint8, UInt8.max)
        XCTAssertEqual(model.uint16, UInt16.max)
        XCTAssertEqual(model.uint32, UInt32.max)
        XCTAssertEqual(model.uint64, UInt64.max)
        XCTAssertEqual(model.array[0], model.array[1])
    }
}
