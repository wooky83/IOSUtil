//
//  ViewController.swift
//  iOSUtil
//
//  Created by wooky83 on 22/02/2019.
//  Copyright © 2019 wooky. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var firstLabel: UILabel!
    @IBOutlet weak var secondLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        firstLabel.setHtmlLabel(bodyString: "<i>ABab</i>ABab<i>가나</i>가니<b>다라</b><u>마바사E</u>FG", size: 20, color: nil, alignment: .left)
        print(firstLabel.font)
    }

}

extension UILabel {
    
    func setHtmlLabel(bodyString: String?, fontFamily: String? = nil, size: CGFloat? = nil, color: String? = nil, alignment: NSTextAlignment? = nil) {
        print(UIColor.white.hexString())
        AttributedStringFactory.create(bodyString ?? "", fontFamily: fontFamily, fontSize: size ?? self.font.pointSize, fontColor: color) {
            self.attributedText = $0
        }
        if let alignment = alignment {
            self.textAlignment = alignment
        }
    }
}
