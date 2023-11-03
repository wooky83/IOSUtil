#if canImport(UIKit)
import UIKit

public extension SW where Base: UIView {
    var frameX: CGFloat {
        base.frame.origin.x
    }

    var frameY: CGFloat {
        base.frame.origin.y
    }

    var frameHeight: CGFloat {
        base.frame.size.height
    }

    var frameWidth: CGFloat {
        base.frame.size.width
    }

    var frameBottom: CGFloat {
        base.frame.origin.y + base.frame.size.height
    }
}
#endif
