@_exported import Jason

/// 当导入 JSON 模块时，`Jason` 将拥有别名 `JSON`，并将一同导入 Jason 模块。
///
/// 如果后续 Swift 标准库提供 `JSON` 类型，移除 JSON 模块以避免命名冲突。
public typealias JSON = Jason
