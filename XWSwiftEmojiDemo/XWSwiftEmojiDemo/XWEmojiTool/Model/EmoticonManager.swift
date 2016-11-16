//
//  EmoticonManager.swift
//  XWSwiftEmojiDemo
//
//  Created by 邱学伟 on 2016/11/16.
//  Copyright © 2016年 邱学伟. All rights reserved.
//

import UIKit

class EmoticonManager {
    var packages : [EmoticonPackage] = [EmoticonPackage]()
    init() {
        //最近
        packages.append(EmoticonPackage(id: ""))
        //默认表情
        packages.append(EmoticonPackage(id: "com.sina.default"))
        //emoji
        packages.append(EmoticonPackage(id: "com.apple.emoji"))
        //浪小花
        packages.append(EmoticonPackage(id: "com.sina.lxh"))
    }
}
