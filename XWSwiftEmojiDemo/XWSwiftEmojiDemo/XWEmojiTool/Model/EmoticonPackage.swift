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
            addEmptyEmoticon(true)
            return
        }
        //根据ID拼接表情路径
        let emojiPath : String = Bundle.main.path(forResource: "\(id)/info.plist", ofType: nil, inDirectory: "Emoticons.bundle")!
        //根据info.plist读取数据
        let array = NSArray(contentsOfFile: emojiPath)! as! [[String : String]]
        var index : Int = 0
        for var dict in array {
            if let png = dict["png"] {
                dict["png"] = id + "/" + png
            }
            emojis.append(Emoticon(dict: dict))
            index += 1
            if index == 20 {
                emojis.append(Emoticon(isRemove: true))
                index = 0
            }
        }
        //添加空白表情
        addEmptyEmoticon(false)
    }
    fileprivate func addEmptyEmoticon(_ isRecently : Bool) {
        let count = emojis.count % 21
        if count == 0 && !isRecently {
            return
        }
        
        for _ in count..<20 {
            emojis.append(Emoticon(isEmpty: true))
        }
        
        emojis.append(Emoticon(isRemove: true))
    }

}
