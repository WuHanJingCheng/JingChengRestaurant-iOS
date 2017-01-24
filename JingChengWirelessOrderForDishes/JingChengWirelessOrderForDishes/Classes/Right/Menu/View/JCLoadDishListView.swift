//
//  JCLoadDishListView.swift
//  JingChengDiningHall
//
//  Created by zhangxu on 2017/1/19.
//  Copyright © 2017年 zhangxu. All rights reserved.
//

import UIKit

class JCLoadDishListView: UIView {

    private lazy var loadView: UIImageView = {
        let loadView = UIImageView();
        return loadView;
    }();
    
    
    // 初始化
    override init(frame: CGRect) {
        super.init(frame: frame);
        
        backgroundColor = RGBWithHexColor(hexColor: 0xfaf8f0);
        
        // 添加loadView
        addSubview(loadView);
        
        let image = UIImage.sd_animatedGIFNamed("loaddishlist");
        loadView.image = image;
        
    }
    
    // 设置loadView 的frame
    override func layoutSubviews() {
        super.layoutSubviews();
        
        let width = bounds.size.width;
        let height = bounds.size.height;
        
        // 设置loadView的frame
        let loadViewW = realValue(value: 400);
        let loadViewH = realValue(value: 300);
        let loadViewX = (width - loadViewW)/2 - realValue(value: 50);
        let loadViewY = (height - loadViewH)/2 - realValue(value: 50);
        loadView.frame = CGRect(x: loadViewX, y: loadViewY, width: loadViewW, height: loadViewH);
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
