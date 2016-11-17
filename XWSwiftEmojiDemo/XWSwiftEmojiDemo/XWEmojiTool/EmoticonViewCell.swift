//
//  EmoticonViewCell.swift
//  XWSwiftEmojiDemo
//
//  Created by 邱学伟 on 2016/11/16.
//  Copyright © 2016年 邱学伟. All rights reserved.
//

import UIKit

class EmoticonViewCell: UICollectionViewCell {
    fileprivate let emojiBtn : UIButton = UIButton()
    var emoji : Emoticon? = nil {
        didSet{
            guard let emoji = emoji else {
                return
            }
            emojiBtn.setImage(UIImage(contentsOfFile: (emoji.pngPath) ?? ""), for: .normal)
            emojiBtn.setTitle(emoji.emojiCode, for: .normal)
            if emoji.isRemove == true {
                emojiBtn.setImage(UIImage(named: "compose_emotion_delete"), for: .normal)
            }
        }
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpUI()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension EmoticonViewCell {
    fileprivate func setUpUI() {
        addSubview(emojiBtn)
        emojiBtn.frame = contentView.bounds
        emojiBtn.isUserInteractionEnabled = false
        emojiBtn.titleLabel?.font = UIFont.systemFont(ofSize: 32)
    }
}
