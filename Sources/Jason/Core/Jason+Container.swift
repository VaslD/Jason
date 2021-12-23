public extension Jason {
    /// 查询 ``Jason`` 当前包含元素的个数。
    ///
    /// 此属性工作原理如下：
    /// - 检查 ``string(_:)`` 是否为空，空则返回 `0`，否则返回 `1`。
    /// - 向 ``array(_:)``, ``dictionary(_:)`` 成员转发 `count` 请求。
    /// - 对于 ``empty`` 固定返回 `0`。
    /// - 对于其他成员固定返回 `1`。
    var count: Int {
        switch self {
        case .empty:
            return 0
        case .boolean, .float, .integer, .unsigned:
            return 1
        case let .string(string):
            return string.isEmpty ? 0 : 1
        case let .array(array):
            return array.count
        case let .dictionary(dict):
            return dict.count
        }
    }

    /// 检查 ``Jason`` 是否为 ``empty`` 或内部集合是否为空。
    ///
    /// 此属性工作原理如下：
    /// - 向 ``string(_:)``, ``array(_:)``, ``dictionary(_:)`` 成员转发 `isEmpty` 请求。
    /// - 对于 ``empty`` 固定返回 `true`。
    /// - 对于其他成员固定返回 `false`。
    var isEmpty: Bool {
        switch self {
        case .empty:
            return true
        case .boolean, .float, .integer, .unsigned:
            return false
        case let .string(string):
            return string.isEmpty
        case let .array(array):
            return array.isEmpty
        case let .dictionary(dict):
            return dict.isEmpty
        }
    }

    /// 检查 ``Jason`` 是否包含某个子元素。
    ///
    /// 此方法工作原理如下：
    /// - 当前为 ``string(_:)`` 时，检查输入为 ``string(_:)`` 则转发 `contains(_:)`
    ///   请求，判断输入是否为当前字符串的子字符串；其他输入返回 `false`。
    /// - 当前为 ``array(_:)`` 时，转发 `contains(_:)` 请求，判断数组中是否包含与输入相等的 ``Jason``。
    /// - 当前为 ``dictionary(_:)`` 时，检查输入为 ``string(_:)`` 则判断字典中是否存在此键；其他输入返回 `false`。
    /// - 对于其他成员固定返回 `false`。
    ///
    /// - Parameter element: 待比较的子元素
    /// - Returns: 是否包含
    func contains(_ element: Jason) -> Bool {
        switch self {
        case let .string(this):
            guard case let .string(other) = element else {
                return false
            }
            return this.contains(other)
        case let .array(array):
            return array.contains(element)
        case let .dictionary(dict):
            guard case let .string(key) = element else {
                return false
            }
            return dict.keys.contains(key)
        default:
            return false
        }
    }
}
