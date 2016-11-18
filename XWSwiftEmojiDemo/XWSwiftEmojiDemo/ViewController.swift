//
//  ViewController.swift
//  XWSwiftEmojiDemo
//
//  Created by 邱学伟 on 2016/11/14.
//  Copyright © 2016年 邱学伟. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    lazy var currentText: NSMutableAttributedString = NSMutableAttributedString()
    @IBOutlet weak var textView: UITextView!
    
    fileprivate lazy var emojiController : XWEmojiController = XWEmojiController {[weak self] (emoji) -> () in
        self!.textView.insertEmoji(emoji: emoji)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        textView.inputView = emojiController.view
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "提取", style: .plain, target: self, action: #selector(getEmojiStr))
    }
    
    @objc fileprivate func getEmojiStr() {
        print(textView.getEmojiText())
    }
    
    override func viewWillAppear(_ animated: Bool) {
        textView.becomeFirstResponder()
    }
    
}

