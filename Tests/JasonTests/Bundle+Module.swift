import Foundation

private class BundleLocator {}

extension Bundle {
    static let module = Bundle(for: BundleLocator.self)
}
