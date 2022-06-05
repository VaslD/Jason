import Foundation
import XCTest

@testable import Jason

class PathTests: XCTestCase {
    func testPathDecoding() throws {
        let decoder = JSONDecoder()

        let squad = Bundle.module.url(forResource: "Squad", withExtension: "json")!
        var data = try! Data(contentsOf: squad)
        XCTAssertNoThrow(try decoder.decode([Superhero].self, from: data, path: ["members"]))
        XCTAssertEqual(try decoder.decode(Int.self, from: data, path: ["formed"]), 2016)
        XCTAssertEqual(try decoder.decode(Superhero.self, from: data, path: ["members", 2]).secretIdentity, "Unknown")
        XCTAssertEqual(try decoder.decode(Superhero?.self, from: data, path: ["unknown", 1]), nil)
        XCTAssertEqual(try decoder.decode(Superhero?.self, from: data, path: [0, 2]), nil)
        XCTAssertEqual(try decoder.decode(Date?.self, from: data, path: ["leader", 0]), nil)
        XCTAssertEqual(try decoder.decode(Date?.self, from: data, path: ["leader", "powers"]), nil)
        XCTAssertEqual(try decoder.decode(Superhero?.self, from: data, path: ["members", 0, "John", "age"]), nil)
        XCTAssertEqual(try decoder.decode(Superhero?.self, from: data, path: ["members", 42, "age"])?.age, nil)
        XCTAssertEqual(try decoder.decode(Int?.self, from: data, path: ["members", "1", "age"]), nil)
        XCTAssertEqual(try decoder.decode(String?.self, from: data, path: ["members", 0, 1, "name"]), nil)
        XCTAssertEqual(try decoder.decode(String?.self, from: data, path: ["members", 3, "name"]), nil)
        XCTAssertEqual(try decoder.decode(String?.self, from: data, path: ["members", "x"]), nil)
        XCTAssertThrowsError(try decoder.decode(Superhero?.self, from: data, path: ["members", 0, "age"]))
        XCTAssertThrowsError(try decoder.decode(Superhero?.self, from: data, path: ["squadName"]))
        XCTAssertThrowsError(try decoder.decode(Superhero.self, from: data, path: [""]))
        XCTAssertThrowsError(try decoder.decode(Superhero.self, from: data, path: [.invalid]))
        XCTAssertThrowsError(try decoder.decode(Superhero.self, from: data, path: [-100]))

        let powers = Bundle.module.url(forResource: "Powers", withExtension: "json")!
        data = try! Data(contentsOf: powers)
        XCTAssertEqual(try decoder.decode(String?.self, from: data, path: [JasonIndex.property("1")]), nil)
        XCTAssertEqual(try decoder.decode(String?.self, from: data, path: [1, "power"]), nil)
        XCTAssertEqual(try decoder.decode(String?.self, from: data, path: [0, 1, 2]), nil)
        XCTAssertEqual(try decoder.decode(String?.self, from: data, path: [0, 7, 2]), nil)

        data = "[\"A\",\"B\"]".data(using: .utf8)!
        XCTAssertNoThrow(try decoder.decode([String].self, from: data, path: []))
        XCTAssertEqual(try decoder.decode(String?.self, from: data, path: [2]), nil)
        XCTAssertEqual(try decoder.decode(String?.self, from: data, path: [3]), nil)
    }
}
