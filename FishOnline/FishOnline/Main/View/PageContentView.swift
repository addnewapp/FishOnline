//
//  PageContentView.swift
//  FishOnline
//
//  Created by ZPG's Mac on 16/9/20.
//  Copyright © 2020 Code With ZPG. All rights reserved.
//

import UIKit

private let ContentCellID = "ContentCellID"
class PageContentView: UIView { 
    
    // MARK：- 定义属性
    private var childVcs: [UIViewController]
    private weak var parentViewController: UIViewController?
    
    // MARK：- 懒加载属性
    private lazy var collectionView: UICollectionView = {[weak self] in
        // 1. 创建layout
        let layout = UICollectionViewFlowLayout() 
        layout.itemSize = (self?.bounds.size)!
        layout.minimumLineSpacing = 0
        layout.scrollDirection = .horizontal
            
        // 2. 创建UICollectionView
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isPagingEnabled = true
        collectionView.bounces = false
        collectionView.dataSource = self
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: ContentCellID)
        
        return collectionView
    }()
    
    // MARK：- 自定义构造函数
    init(frame: CGRect, childVcs: [UIViewController], parentViewController: UIViewController?) {
        self.childVcs = childVcs
        self.parentViewController = parentViewController
        
        super.init(frame: frame)
        
        // 设置UI
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK：- 设置UI界面
extension PageContentView {
    private func setupUI() {
        // 1. 将所有的子控制器添加到父控制器中
        for childVc in childVcs{
        parentViewController?.addChild(childVc)
        }
        // 2. 添加UICollectionView, 用于在Cell中存放控制器的View 
        addSubview(collectionView)
        collectionView.frame = bounds 
    }
}

// MARK：- 遵守UICollectionViewDataSources
extension PageContentView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return childVcs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // 1.创建Cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ContentCellID, for: indexPath)
        
        // 2.给Cell设置内容
        for view in cell.contentView.subviews {
            view.removeFromSuperview()
        }
        
        let childVc = childVcs[(indexPath as NSIndexPath).item]
        childVc.view.frame = cell.contentView.bounds
        cell.contentView.addSubview(childVc.view)
        
        return cell
    }
}
// MARK：- 对外暴露的方法
extension PageContentView{
    func setCuttentIndex(currentIndex: Int){
        let offsetX = CGFloat(currentIndex) * collectionView.frame.width
        collectionView.setContentOffset(CGPoint(x: offsetX, y: 0), animated: false)
    }
}
