#if canImport(UIKit)
import UIKit

public extension UIView {
    var frameX: CGFloat {
        frame.origin.x
    }

    var frameY: CGFloat {
        frame.origin.y
    }

    var frameHeight: CGFloat {
        frame.size.height
    }

    var frameWidth: CGFloat {
        frame.size.width
    }

    var frameBottom: CGFloat {
        frame.origin.y + frame.size.height
    }
}
#endif
