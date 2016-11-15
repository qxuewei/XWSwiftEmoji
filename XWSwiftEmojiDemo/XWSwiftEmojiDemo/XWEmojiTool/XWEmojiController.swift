//
//  XWEmojiController.swift
//  XWSwiftEmojiDemo
//
//  Created by 邱学伟 on 2016/11/14.
//  Copyright © 2016年 邱学伟. All rights reserved.
//  自定义表情键盘

import UIKit
fileprivate let emojiCollectionCellID : String = "emojiCollectionCellID"
class XWEmojiController: UIViewController {

    fileprivate let emojiCollection : UICollectionView = UICollectionView(frame: .zero, collectionViewLayout: emojiFlowLayout())
    fileprivate let toolBar : UIToolbar = UIToolbar()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
}

//MARK: - UI
extension XWEmojiController {
    fileprivate func setupUI() {
        view.addSubview(emojiCollection)
        emojiCollection.backgroundColor = UIColor.red
        toolBar.backgroundColor = UIColor.green
        view.addSubview(toolBar)
        emojiCollection.translatesAutoresizingMaskIntoConstraints = false
        toolBar.translatesAutoresizingMaskIntoConstraints = false
        let views = ["tBar" : toolBar,"eCollection" : emojiCollection]
        //水平方向约束 horizontal
        var cons : [NSLayoutConstraint] = NSLayoutConstraint.constraints(withVisualFormat: "H:|-0-[tBar]-0-|", options: [], metrics: nil, views: views)
        //垂直方向约束 vertical
        cons += NSLayoutConstraint.constraints(withVisualFormat: "V:|-0-[eCollection]-0-[tBar]-0-|", options: [.alignAllLeft,.alignAllRight], metrics: nil, views: views)
        view.addConstraints(cons)
        
        preCollectionMethod()
        
    }
    fileprivate func preCollectionMethod() {
        emojiCollection.register(UICollectionViewCell.self, forCellWithReuseIdentifier: emojiCollectionCellID)
        emojiCollection.dataSource = self
        
        //设置Collection布局
//        let emojiCollectionViewLayout : UICollectionViewFlowLayout = emojiCollection.collectionViewLayout as! UICollectionViewFlowLayout
//        let emojiItemWH : CGFloat = UIScreen.main.bounds.width * 0.9
//        emojiCollectionViewLayout.itemSize = CGSize(width: emojiItemWH, height: emojiItemWH)
        
    }
}

//MARK: - UICollectionDelegate
extension XWEmojiController : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 9
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell : UICollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: emojiCollectionCellID, for: indexPath)
        cell.backgroundColor = indexPath.item % 2 == 0 ? UIColor.orange : UIColor.blue
        return cell
    }
}

//MARK: - custom UICollectionViewFlowLayout 
class emojiFlowLayout : UICollectionViewFlowLayout {
    override func prepare() {
        super.prepare()
        let itemWH : CGFloat = UIScreen.main.bounds.width * 0.7
        itemSize = CGSize(width: itemWH, height: itemWH)
        minimumLineSpacing = 0
        minimumInteritemSpacing = 0
        scrollDirection = .horizontal
        collectionView?.isPagingEnabled = true
        collectionView?.showsVerticalScrollIndicator = false
        collectionView?.showsHorizontalScrollIndicator = false
    }
}

