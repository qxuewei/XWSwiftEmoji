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
    var emojiCallBack : (_ emoji : Emoticon)->()
    fileprivate let emojiManager : EmoticonManager = EmoticonManager()
    fileprivate let emojiCollection : UICollectionView = UICollectionView(frame: .zero, collectionViewLayout: emojiFlowLayout())
    fileprivate let toolBar : UIToolbar = UIToolbar()
    init(emojiCallBack : @escaping (_ emoji : Emoticon)->()) {
        self.emojiCallBack = emojiCallBack
        super.init(nibName: nil, bundle: nil)

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
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
        preToolBarMethod()
    }
    fileprivate func preCollectionMethod() {
        emojiCollection.register(EmoticonViewCell.self, forCellWithReuseIdentifier: emojiCollectionCellID)
        emojiCollection.dataSource = self
        emojiCollection.delegate = self
    }
    fileprivate func preToolBarMethod() {
        let titles = ["最近","默认","emoji","浪小花"]
        var items : [UIBarButtonItem] = [UIBarButtonItem]()
        var index : Int = 0
        for title in titles {
            let item = UIBarButtonItem(title: title, style: .plain, target: self, action: #selector(toolBarClick(item:)))
            item.tag = index
            index += 1
            items.append(item)
            items.append(UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil))
        }
        items.removeLast()
        toolBar.setItems(items, animated: true)
        
    }
    
}
//MARK: - Selector
extension XWEmojiController {
    @objc fileprivate func toolBarClick(item : UIBarButtonItem) {
        let tag : Int = item.tag
        let indexPath = IndexPath(item: 0, section: tag)
        emojiCollection.scrollToItem(at: indexPath, at: .left, animated: true)
    }
    fileprivate func insertEmojiToRecent(emoji : Emoticon) {
        //删除,空白不需要插入
        guard emoji.isEmpty == false, emoji.isRemove == false else {
            return
        }
        
        //最近分组
        let recentEmojiPackage = emojiManager.packages.first!
        
        if recentEmojiPackage.emojis.contains(emoji) {
            let index = recentEmojiPackage.emojis.index(of: emoji)
            recentEmojiPackage.emojis.remove(at: index!)
        }else{
            recentEmojiPackage.emojis.remove(at: recentEmojiPackage.emojis.count - 2)
        }
        recentEmojiPackage.emojis.insert(emoji, at: 0)
    }
}

//MARK: - UICollectionDelegate
extension XWEmojiController : UICollectionViewDataSource,UICollectionViewDelegate {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return emojiManager.packages.count
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let package = emojiManager.packages[section]
        return package.emojis.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell : EmoticonViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: emojiCollectionCellID, for: indexPath) as! EmoticonViewCell
        let package : EmoticonPackage = emojiManager.packages[indexPath.section]
        let emoji : Emoticon = package.emojis[indexPath.item]
        cell.emoji = emoji
        return cell
    }
    ///点击UICollectionViewCell代理方法
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let package = emojiManager.packages[indexPath.section]
        let emoji = package.emojis[indexPath.item]
        insertEmojiToRecent(emoji: emoji)
        //将选择的表情传出去
        emojiCallBack(emoji)
    }
}

//MARK: - custom UICollectionViewFlowLayout 
class emojiFlowLayout : UICollectionViewFlowLayout {
    override func prepare() {
        super.prepare()
        let itemWH : CGFloat = UIScreen.main.bounds.width / 7
        itemSize = CGSize(width: itemWH, height: itemWH)
        minimumLineSpacing = 0
        minimumInteritemSpacing = 0
        scrollDirection = .horizontal
        collectionView?.isPagingEnabled = true
        collectionView?.showsVerticalScrollIndicator = false
        collectionView?.showsHorizontalScrollIndicator = false
        let edgeInsetH : CGFloat = ((collectionView?.bounds.height)! - itemWH * 3) * 0.5
        collectionView?.contentInset = UIEdgeInsets(top: edgeInsetH, left: 0.00, bottom: edgeInsetH, right: 0.000)
    }
}

