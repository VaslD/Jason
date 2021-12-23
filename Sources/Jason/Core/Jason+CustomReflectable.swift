extension Jason: CustomReflectable {
    /// ``Jason/Jason`` 不支持 `Mirror`。
    ///
    /// ``Jason/Jason`` 已提供格式化的 JSON 作为 ``debugDescription`` 用于调试器输出。如果允许 Swift 生成 `Mirror`
    /// 将重复输出每个元素，并且会显示混乱的换行和缩进。
    ///
    /// > Warning:
    /// 向 `Mirror(reflecting:)` 传入 ``Jason/Jason`` 将获得无意义、甚至错误的实例信息。请勿在操作 ``Jason/Jason``
    /// 时依赖 `Mirror`。
    @inlinable
    public var customMirror: Mirror {
        Mirror(reflecting: Any?.none as Any)
    }
}
