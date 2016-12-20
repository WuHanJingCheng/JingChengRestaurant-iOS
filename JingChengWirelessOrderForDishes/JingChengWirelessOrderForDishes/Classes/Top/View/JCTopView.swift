//
//  JCTopView.swift
//  JingChengWirelessOrderForDishes
//
//  Created by zhangxu on 2016/11/22.
//  Copyright © 2016年 zhangxu. All rights reserved.
//

import UIKit

class JCTopView: UIView {
    
    // 背景
    private lazy var background: UIImageView = {
        let background = UIImageView();
        background.image = UIImage.imageWithName(name: "top_background");
        background.isUserInteractionEnabled = true;
        return background;
    }();

    // logo
    private lazy var logo: UIImageView = {
        let logo = UIImageView();
        logo.image = UIImage.imageWithName(name: "top_logo");
        return logo;
    }();
    
    // logo 名称
    private lazy var logoNameLabel: UILabel = {
        let label = UILabel();
        label.font = Font(size: 24/2);
        label.textColor = RGBWithHexColor(hexColor: 0xe6e6e6);
        label.textAlignment = .left;
        label.text = "阿芈烧烤";
        return label;
    }();
    
    // title
    lazy var titleLabel: UILabel = {
        let label = UILabel();
        label.font = Font(size: 40/2);
        label.text = "菜谱";
        label.textColor = RGBWithHexColor(hexColor: 0xe6e6e6);
        label.textAlignment = .center;
        return label;
    }();
    
    deinit {
        print("JCTopView 被释放");
    }
    
    // 初始化
    override init(frame: CGRect) {
        super.init(frame: frame);
        
        // 添加背景
        addSubview(background);
        
        // 添加logo
        background.addSubview(logo);
        
        // 添加logo名称
        background.addSubview(logoNameLabel);
        
        // 添加title
        background.addSubview(titleLabel);
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - 设置子控件的frame
    override func layoutSubviews() {
        super.layoutSubviews();
        
        let height = bounds.size.height;
        let width = bounds.size.width;
        
        // 设置background 的frame
        background.frame = bounds;
        
        // 设置logo的frame
        let logoX = CGFloat(40/2);
        let logoY = (height - CGFloat(72/2))/2;
        let logoW = CGFloat(68/2);
        let logoH = CGFloat(72/2);
        logo.frame =  CGRect(x: logoX, y: logoY, width: logoW, height: logoH);
        
        // 设置logoNameLabel 的frame
        let logoNameLabelW = calculateWidth(title: logoNameLabel.text ?? "", fontSize: 24/2, maxWidth: realValue(value: 300)) ?? 0;
        let logoNameLabelH = realValue(value: 24/2);
        let logoNameLabelX = logo.frame.maxX + realValue(value: 16/2);
        let logoNameLabelY = (height - logoNameLabelH)/2;
        logoNameLabel.frame = CGRect(x: logoNameLabelX, y: logoNameLabelY, width: logoNameLabelW, height: logoNameLabelH);
        
        // 设置title的frame
        let titleLabelCenterX = width/2;
        let titleLabelCenterY = height/2;
        let titleLabelW = CGFloat(250);
        let titleLabelH = CGFloat(40/2);
        titleLabel.center = CGPoint(x: titleLabelCenterX, y: titleLabelCenterY);
        titleLabel.bounds = CGRect(x: 0, y: 0, width: titleLabelW, height: titleLabelH);
    }
    

}
