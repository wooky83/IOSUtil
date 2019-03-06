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
        
//        firstLabel.setHtmlLabel(bodyString: """
//<font face="Helvetica Neue">가나다바<font color="#3034ba" size="tt">사아자차</font>카<font size="50">타파</font>하</font>
//""", size: 20, color: nil, alignment: .left)
                firstLabel.setHtmlLabel(bodyString: """
        <span style="background-color:blue; font-size:20">abcdefghikl</span>
        """, size: 50, alignment: .left)

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
        self.numberOfLines = 2
    }
}
