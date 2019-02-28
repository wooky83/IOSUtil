//
//  GoodLuck.swift
//  iOSUtil
//
//  Created by wooky83 on 22/02/2019.
//  Copyright © 2019 wooky. All rights reserved.
//

import Foundation
import UIKit

extension String {
    func attributedStringFromHtml(familyName: String = "Apple SD Gothic Neo", fontColor: String = "#ffffff", fontSize: CGFloat) -> NSAttributedString {
        let html = "<font face=\"\(familyName)\" color=\"\(fontColor)\"><span style= \"font-size:\(Int(fontSize))\">\(self)</span></font>"
        guard let data = html.data(using: .utf8) else { return NSAttributedString() }
        do {
            return try NSAttributedString(data: data, options: [NSAttributedString.DocumentReadingOptionKey.documentType: NSAttributedString.DocumentType.html, NSAttributedString.DocumentReadingOptionKey.characterEncoding: String.Encoding.utf8.rawValue], documentAttributes: nil)
        } catch{
            return NSAttributedString()
        }
    }
}
