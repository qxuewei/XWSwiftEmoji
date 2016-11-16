//
//  EmoticonPackage.swift
//  XWSwiftEmojiDemo
//
//  Created by 邱学伟 on 2016/11/16.
//  Copyright © 2016年 邱学伟. All rights reserved.
//

import UIKit

class EmoticonPackage: NSObject {
    var emojis : [Emoticon] = [Emoticon]()
    init(id : String) {
        super.init()
        if id == "" {
            return
        }
        //根据ID拼接表情路径
        let emojiPath : String = Bundle.main.path(forResource: "\(id)/info.plist", ofType: nil, inDirectory: "Emoticons.bundle")!
        //根据info.plist读取数据
        let array = NSArray(contentsOfFile: emojiPath)! as! [[String : String]]
        for var dict in array {
            if let png = dict["png"] {
                dict["png"] = id + "/" + png
            }
            emojis.append(Emoticon(dict: dict))
        }
    }
   
}
