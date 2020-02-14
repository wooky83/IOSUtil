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
    }
    
    @IBAction func btnClicked(_ sender: UIButton) {
        UIView.animate(withDuration: 1.5, delay: 0, options: .curveEaseIn, animations: {
            sender.backgroundColor = .green
        }, completion: nil)
    }

}

