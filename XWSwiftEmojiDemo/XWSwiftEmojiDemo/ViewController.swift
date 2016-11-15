//
//  ViewController.swift
//  XWSwiftEmojiDemo
//
//  Created by 邱学伟 on 2016/11/14.
//  Copyright © 2016年 邱学伟. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    fileprivate let emojiController : XWEmojiController = XWEmojiController()
    
    @IBOutlet weak var textView: UITextView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        textView.inputView = emojiController.view
    }

    override func viewWillAppear(_ animated: Bool) {
        textView.becomeFirstResponder()
    }


}

