//
//  UILabelEx.swift
//  iOSUtil
//
//  Created by wooky83 on 06/12/2019.
//  Copyright © 2019 wooky. All rights reserved.
//

import UIKit

extension UILabel {
    
    func setHtmlLabel(bodyString: String?, fontFamily: String? = nil, size: CGFloat? = nil, color: String? = nil, alignment: NSTextAlignment? = nil, lineSpacing: CGFloat? = nil) {
        AttributedStringFactory.create(bodyString ?? "", fontFamily: fontFamily, fontSize: size ?? self.font.pointSize, fontColor: color) {
            if let line = lineSpacing {
                let paragraphStyle = NSMutableParagraphStyle()
                paragraphStyle.lineSpacing = line
                $0.addAttribute(.paragraphStyle, value: paragraphStyle, range: NSMakeRange(0, $0.length))
                self.attributedText = $0
            } else {
                self.attributedText = $0
            }
        }
        if let alignment = alignment {
            self.textAlignment = alignment
        }
    }
}
