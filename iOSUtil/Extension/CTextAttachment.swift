//
//  CTextAttachment.swift
//  iOSUtil
//
//  Created by wooky83 on 25/11/2019.
//  Copyright © 2019 wooky. All rights reserved.
//

import UIKit

class CTextAttachment: NSTextAttachment {
    override func attachmentBounds(for textContainer: NSTextContainer?, proposedLineFragment lineFrag: CGRect, glyphPosition position: CGPoint, characterIndex charIndex: Int) -> CGRect {
        bounds.origin = CGPoint(x: 0, y: -4)
        bounds.size = CGSize(width: 21, height: 19)
        return bounds
    }
}



