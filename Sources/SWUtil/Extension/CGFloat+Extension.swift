#if canImport(UIKit)
import UIKit

extension CGFloat: SWCompatible {}
public extension SW where Base == CGFloat {
    func adjust(_ baseWidth: Base = 375) -> Base {
        base * (min(UIScreen.main.bounds.width, UIScreen.main.bounds.height) / baseWidth)
    }
}
#endif
