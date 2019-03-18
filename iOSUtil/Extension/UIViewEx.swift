//
//  UIViewEx.swift
//  iOSUtil
//
//  Created by wooky83 on 18/03/2019.
//  Copyright © 2019 wooky. All rights reserved.
//

import UIKit

extension UIView {
    var frameX: CGFloat {
        return self.frame.origin.x
    }
    
    var frameY: CGFloat {
        return self.frame.origin.y
    }
    
    var frameHeight: CGFloat {
        return self.frame.size.height
    }
    
    var frameWidth: CGFloat {
        return self.frame.size.width
    }
    
    var frameBottom: CGFloat {
        return self.frame.origin.y + self.frame.size.height
    }
}
