//
//  JCTopView.swift
//  JingChengWirelessOrderForDishes
//
//  Created by zhangxu on 2016/11/22.
//  Copyright © 2016年 zhangxu. All rights reserved.
//

import UIKit

class JCTopView: UIView {

    // logo
    private lazy var logo: UIImageView = {
        let logo = UIImageView();
        logo.image = UIImage.imageWithName(name: "top_logo");
        return logo;
    }();
    
    // title
    lazy var titleLabel: UILabel = {
        let label = UILabel();
        label.font = Font(size: 40/2);
        label.text = "菜谱";
        label.textColor = RGBWithHexColor(hexColor: 0x191919);
        label.textAlignment = .center;
        return label;
    }();
    
    deinit {
        print("JCTopView 被释放");
    }
    
    // 初始化
    override init(frame: CGRect) {
        super.init(frame: frame);
        
        // 添加logo
        addSubview(logo);
        // 添加title
        addSubview(titleLabel);
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - 设置子控件的frame
    override func layoutSubviews() {
        super.layoutSubviews();
        
        let height = bounds.size.height;
        let width = bounds.size.width;
        
        // 设置logo的frame
        let logoX = CGFloat(40/2);
        let logoY = (height - CGFloat(72/2))/2;
        let logoW = CGFloat(68/2);
        let logoH = CGFloat(72/2);
        logo.frame =  CGRect(x: logoX, y: logoY, width: logoW, height: logoH);
        
        // 设置title的frame
        let titleLabelCenterX = width/2;
        let titleLabelCenterY = height/2;
        let titleLabelW = CGFloat(250);
        let titleLabelH = CGFloat(40/2);
        titleLabel.center = CGPoint(x: titleLabelCenterX, y: titleLabelCenterY);
        titleLabel.bounds = CGRect(x: 0, y: 0, width: titleLabelW, height: titleLabelH);
    }
    

}
