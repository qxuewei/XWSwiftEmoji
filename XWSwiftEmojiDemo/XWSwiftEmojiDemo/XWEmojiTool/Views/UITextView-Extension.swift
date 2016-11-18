//
//  UITextView-Extension.swift
//  XWSwiftEmojiDemo
//
//  Created by 邱学伟 on 2016/11/18.
//  Copyright © 2016年 邱学伟. All rights reserved.
//

import UIKit

extension UITextView {
    //给textView插入表情
    func insertEmoji(emoji : Emoticon) {
        if emoji.isEmpty {
            return
        }
        if emoji.isRemove {
            deleteBackward()
            return
        }
        //emoji
        if emoji.emojiCode != nil {
            let textRange : UITextRange = selectedTextRange!
            replace(textRange, withText: emoji.emojiCode!)
            return
        }
        //普通图片
        if emoji.pngPath != nil {
            guard let image : UIImage = UIImage(contentsOfFile: emoji.pngPath!) else {
                return
            }
            let font : UIFont = self.font!
            let attriButedStrM : NSMutableAttributedString = NSMutableAttributedString(attributedString: attributedText)
            let textAttachment : EmoticonAttachment = EmoticonAttachment()
            textAttachment.bounds = CGRect(x: 0, y: -4, width: font.lineHeight, height:font.lineHeight)
            textAttachment.image = image
            textAttachment.chs = emoji.chs
            
            let selectedRange : NSRange = self.selectedRange
            attriButedStrM.replaceCharacters(in: selectedRange, with:NSAttributedString(attachment: textAttachment))
            attributedText = attriButedStrM
            self.font = font
            self.selectedRange =  NSRange(location: selectedRange.location+1, length: selectedRange.length)
        }
    }
    
    //提取textView中文本
    func getEmojiText() -> String {
        let textViewAttributedStr = NSMutableAttributedString(attributedString:attributedText)
        let range : NSRange = NSRange(location: 0, length: textViewAttributedStr.length)
        textViewAttributedStr.enumerateAttributes(in: range, options: []){(dict,range,_)-> Void in
            if let emoticonAttachment : EmoticonAttachment = dict["NSAttachment"] as? EmoticonAttachment {
                textViewAttributedStr.replaceCharacters(in: range, with: emoticonAttachment.chs!)
            }
        }
        return textViewAttributedStr.string
    }
}
