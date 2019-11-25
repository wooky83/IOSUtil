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
    @IBOutlet weak var ThirdLabel: TTTAttributedLabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        firstLabel.setHtmlLabel(bodyString: """
//<font face="Helvetica Neue">가나다바<font color="#3034ba" size="tt">사아자차</font>카<font size="50">타파</font>하</font>
//""", size: 20, color: nil, alignment: .left)
//                firstLabel.setHtmlLabel(bodyString: """
//        <span style="background-color:blue; font-size:20">abcdefghikl</span>
//        """, size: 50, alignment: .left)

//        firstLabel.setHtmlLabel(bodyString: """
//                <font color="#61666B">이달의 적립횟수는<br> <font size="16"><b>1건</b></font>입니다</font>
//                """, size: 14, alignment: .center)

        
        firstLabel.setHtmlLabel(bodyString: "수가 무얼까는 & 1건")
        let attributedStr = NSMutableAttributedString(attributedString: firstLabel.attributedText!)
        let attachMent = CTextAttachment()
        let hi = resizeImage(image: UIImage(named: "icCoinSmall")!, targetSize: CGSize(width: 21, height: 19))
        attachMent.image = hi
        attributedStr.append(NSAttributedString(string: " "))
        attributedStr.append(NSAttributedString(attachment: attachMent))
        firstLabel.attributedText = attributedStr
        firstLabel.backgroundColor = .green
        firstLabel.layer.applySketchShadow(color: .black, alpha: 0.3, x: 0.5, y: 3.5, blur: 10, spread: 1.5)
        firstLabel.layer.cornerRadius = 50
        
        secondLabel.setHtmlLabel(bodyString: "가나다<a href=\"http://www.naver.com\">네이버</a>사다리다")
        //"<font size=\"20\">가나다<b><u>네이버</u></b>사다리다</font>"
        ThirdLabel.setHtmlLabel(bodyString: "<font size=\"20\">가나다<b><u>네이버</u></b>사다리다\n노노재팬이다</font>", lineSpacing: 10)
//        ThirdLabel.text = "Fork me on GitHub! (https://github.com/mattt/TTTAttributedLabel/)" // Repository URL will be automatically detected and linked
        ThirdLabel.delegate = self
        if let text = ThirdLabel.text as? NSString {
            let hi = text.range(of: "다리")
            ThirdLabel.addLink(to:URL.init(string: "http://www.naver.com"), with: hi)

//            let hi2 = text.range(of: "Fork")
//            ThirdLabel.addLink(to:URL.init(string: "http://www.daum.net"), with: hi2)
        }
        
        
//
//        NSRange range = [ThirdLabel.text rangeOfString:@"me"];
//        [label addLinkToURL:[NSURL URLWithString:@"http://github.com/mattt/"] withRange:range];
    }
    
    @objc func btnClicked(_ sender: UIButton) {
        UIView.animate(withDuration: 1.5, delay: 0, options: .curveEaseIn, animations: {
            sender.backgroundColor = .green
        }, completion: nil)
    }

}

extension ViewController: TTTAttributedLabelDelegate {
    func attributedLabel(_ label: TTTAttributedLabel!, didSelectLinkWith url: URL!) {
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
}

extension UIFont {
    func sizeOfString (string: String, constrainedToWidth width: Double) -> CGSize {
        return NSString(string: string).boundingRect(
            with: CGSize(width: width, height: .greatestFiniteMagnitude),
            options: .usesLineFragmentOrigin,
            attributes: [.font: self],
            context: nil).size
    }
}

extension UILabel {
    
    func setHtmlLabel(bodyString: String?, fontFamily: String? = nil, size: CGFloat? = nil, color: String? = nil, alignment: NSTextAlignment? = nil, lineSpacing: CGFloat? = nil) {
        AttributedStringFactory.create(bodyString ?? "", fontFamily: fontFamily, fontSize: size ?? self.font.pointSize, fontColor: color) {
            if let line = lineSpacing {
                let hi = NSMutableParagraphStyle()
                hi.lineSpacing = line
                $0.addAttribute(.paragraphStyle, value: hi, range: NSMakeRange(0, $0.length))
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

func resizeImage(image: UIImage, targetSize: CGSize) -> UIImage {
    let size = image.size
    
    let widthRatio  = targetSize.width  / size.width
    let heightRatio = targetSize.height / size.height
    
    // Figure out what our orientation is, and use that to form the rectangle
    var newSize: CGSize
    if(widthRatio > heightRatio) {
        newSize = CGSize(width: size.width * heightRatio, height: size.height * heightRatio)
    } else {
        newSize = CGSize(width: size.width * widthRatio, height: size.height * widthRatio)
    }
    
    // This is the rect that we've calculated out and this is what is actually used below
    let rect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)
    
    // Actually do the resizing to the rect using the ImageContext stuff
    UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
    image.draw(in: rect)
    guard let newImage = UIGraphicsGetImageFromCurrentImageContext() else { return UIImage() }
    UIGraphicsEndImageContext()
    
    return newImage
}


