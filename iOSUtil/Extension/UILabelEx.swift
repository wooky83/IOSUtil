//
//  UILabelEx.swift
//  iOSUtil
//
//  Created by wooky83 on 06/12/2019.
//  Copyright © 2019 wooky. All rights reserved.
//

import UIKit

extension UILabel {
    
    
    //<font face="AppleSDGothicNeo-Regular"><b>가나다라마바사</b><br><span style="font-size:19;color:red;background-color:blue">아자차카타파하</span></font>
    func setHtmlLabel(bodyString: String?, fontFamily: String? = nil, size: CGFloat? = nil, color: String? = nil, alignment: NSTextAlignment? = nil, lineSpacing: CGFloat? = nil) {
        AttributedStringFactory.create(bodyString ?? "", fontFamily: fontFamily, fontSize: size ?? self.font.pointSize, fontColor: color) {
            switch $0 {
            case .success(let value):
                self.attributedText = value
            case .failure:
                self.attributedText = NSAttributedString(string: bodyString•)
            }
            guard let cAttributedText = self.attributedText, lineSpacing != nil else { return }
            let mutableAttributedText = NSMutableAttributedString(attributedString: cAttributedText)
            if let spacing = lineSpacing {
                mutableAttributedText.addAttribute(.paragraphStyle, value: NSMutableParagraphStyle().then { obj in obj.lineSpacing = spacing }, range: NSRange(location: 0, length: mutableAttributedText.length))
            }
            self.attributedText = mutableAttributedText
        }
        if let alignment = alignment {
            self.textAlignment = alignment
        }
    }
}

public protocol Then {}

extension Then where Self: Any {

    /// Makes it available to set properties with closures just after initializing and copying the value types.
    ///
    ///     let frame = CGRect().with {
    ///       $0.origin.x = 10
    ///       $0.size.width = 100
    ///     }
    public func with(_ block: (inout Self) -> Void) -> Self {
        var copy = self
        block(&copy)
        return copy
    }

    /// Makes it available to execute something with closures.
    ///
    ///     UserDefaults.standard.do {
    ///       $0.set("devxoul", forKey: "username")
    ///       $0.set("devxoul@gmail.com", forKey: "email")
    ///       $0.synchronize()
    ///     }
    public func `do`(_ block: (Self) -> Void) {
        block(self)
    }

}

extension Then where Self: AnyObject {

    /// Makes it available to set properties with closures just after initializing.
    ///
    ///     let label = UILabel().then {
    ///       $0.textAlignment = .Center
    ///       $0.textColor = UIColor.blackColor()
    ///       $0.text = "Hello, World!"
    ///     }
    @discardableResult
    public func then(_ block: (Self) -> Void) -> Self {
        block(self)
        return self
    }

}

extension NSObject: Then {}

extension CGPoint: Then {}
extension CGRect: Then {}
extension CGSize: Then {}
extension CGVector: Then {}

#if os(iOS) || os(tvOS)
    extension UIEdgeInsets: Then {}
    extension UIOffset: Then {}
    extension UIRectEdge: Then {}
#endif

