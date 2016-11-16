//
//  Emoticon.swift
//  XWSwiftEmojiDemo
//
//  Created by 邱学伟 on 2016/11/16.
//  Copyright © 2016年 邱学伟. All rights reserved.
//

import UIKit

class Emoticon: NSObject {
    var code : String? = nil {
        didSet{
            guard let code = code else {
                return
            }
            //1.创建扫描器
            let scanner = Scanner(string: code)
            //2.扫描code中的值
            var uint32 : UInt32 = 0
            scanner.scanHexInt32(&uint32)
            //3.将uint32 转成字符
            let c =  Character(UnicodeScalar(uint32)!)
            //4.将字符转成字符串
            emojiCode = String(c)
        }
    }
    var chs  : String? = nil
    var png  : String? = nil {
        didSet{
            guard let png = png else {
                return
            }
            pngPath = Bundle.main.bundlePath + "/Emoticons.bundle/" + png
            
        }
    }
    //数据处理
    var pngPath : String? = nil
    var emojiCode : String? = nil
    
    init(dict : [String : String]) {
        super.init()
        setValuesForKeys(dict)
    }
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
    }
    override var description: String{
        return dictionaryWithValues(forKeys: ["emojiCode","chs","pngPath"]).description
    }
}
