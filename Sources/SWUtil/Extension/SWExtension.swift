import Foundation

public struct SW<Base> {
    public var base: Base

    public init(_ base: Base) {
        self.base = base
    }
}

public protocol SWCompatible {
    associatedtype Base
    var sw: SW<Base> { get }
    static var sw: SW<Base>.Type { get }
}

public extension SWCompatible {
    var sw: SW<Self> { SW(self) }
    static var sw: SW<Self>.Type { SW<Self>.self }
}

extension NSObject: SWCompatible {}
