//
//  PageTitleView.swift
//  FishOnline
//
//  Created by ZPG's Mac on 12/9/20.
//  Copyright © 2020 Code With ZPG. All rights reserved.
//

import UIKit
private let kScrollLineH = 2
class PageTitleView: UIView {
    
    // MARK：- 定义属性
    private var titles: [String]
    
    // MARK：- 懒加载属性
    private lazy var titleLabels: [UILabel] = [UILabel]()
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.scrollsToTop = false
        scrollView.bounces = false 
        return scrollView
    }()
    private lazy var scrollLine: UIView = {
        let scrollLine = UIView()
        scrollLine.backgroundColor = .orange
        return scrollLine
    }()  
    // MARK：- 自定义构造函数
    init(frame: CGRect, titles: [String]) {
        self.titles = titles
        
        super.init(frame: frame)
        
        // 设置UI界面
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
// MARK：- 设置UI界面
extension PageTitleView {
    private func setupUI() {
        // 1. 添加UIScroolView
        addSubview(scrollView)
        scrollView.frame = bounds
        
        // 2. 添加title对应的Label
        setupTitleLebels()
        
        // 3. 设置底线和滚动的滑块
        setupBottomLineAndScrollLine()
    }
    
    private func setupTitleLebels(){
        for (index, title) in titles.enumerated() {
            // 0. 确定label的一些frame值
            let labelW: CGFloat = frame.width / CGFloat(titles.count)
            let labelH: CGFloat = frame.height - CGFloat(kScrollLineH)
            let labelY: CGFloat = 0
            // 1. 创建UILabel 
            let label = UILabel()
            
            // 2. 设置Label的属性
            label.text = title 
            label.tag = index
            label.font = UIFont.systemFont(ofSize: 16.0)
            label.textColor = .darkGray
            label.textAlignment = .center
            
            // 3. 设置label的frame
            let labelX: CGFloat = labelW * CGFloat(index)
            label.frame = CGRect(x: labelX, y: labelY, width: labelW, height: labelH)
            
            // 4. 将label添加到ScrollView中
            scrollView.addSubview(label)
            titleLabels.append(label)
        }
    }
    private func setupBottomLineAndScrollLine(){
        // 1. 设置底线
        let bottomLine = UIView()
        bottomLine.backgroundColor = .lightGray
        let lineH: CGFloat = 0.5
        bottomLine.frame = CGRect(x: 0, y: frame.height, width: frame.width, height: lineH)
        addSubview(bottomLine)
        
        // 2. 添加ScrollLine
        // 2.1 获取第一个label
        guard let firstLabel = titleLabels.first else { return }
        firstLabel.textColor = .darkGray
        
        // 2.2 设置scrollLine的属性
        scrollView.addSubview(scrollLine)
        scrollLine.frame = CGRect(x: firstLabel.frame.origin.x, y: frame.height - CGFloat(kScrollLineH), width: firstLabel.frame.width, height: CGFloat(kScrollLineH))
        
    }
}





