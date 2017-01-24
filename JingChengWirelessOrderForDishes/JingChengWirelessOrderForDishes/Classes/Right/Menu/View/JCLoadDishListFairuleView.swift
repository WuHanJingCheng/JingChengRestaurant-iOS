//
//  JCLoadDishListFairuleView.swift
//  JingChengDiningHall
//
//  Created by zhangxu on 2017/1/19.
//  Copyright © 2017年 zhangxu. All rights reserved.
//

import UIKit

class JCLoadDishListFairuleView: UIView {
    
    
    private lazy var icon: UIImageView = {
        let icon = UIImageView();
        icon.image = UIImage.imageWithName(name: "loaddishlistfailure");
        return icon;
    }();
    
    // 重新加载按钮
    lazy var reloadBtn: UIButton = {
        let button = UIButton(type: .custom);
        button.setTitle("重新加载", for: .normal);
        button.titleLabel?.font = Font(size: 36/2);
        button.setTitleColor(RGBWithHexColor(hexColor: 0x37acff), for: .normal);
        button.addTarget(self, action: #selector(reloadBtnClick), for: .touchUpInside);
        return button;
    }();
    
    // 提示label
    lazy var textLabel: UILabel = {
        let label = UILabel();
        label.text = "糟糕，似乎出现了点问题";
        label.font = Font(size: 32/2);
        label.textColor = RGBWithHexColor(hexColor: 0x8c8c8c);
        label.textAlignment = .center;
        return label;
    }();

    
    var reloadCallBack: (() -> ())?;
    
    // 初始化
    override init(frame: CGRect) {
        super.init(frame: frame);
        
        // 设置背景颜色
        backgroundColor = RGBWithHexColor(hexColor: 0xfaf8f0);
        
        // 添加icon
        addSubview(icon);
        
        // 添加提示label
        addSubview(textLabel);
        
        // 添加加载按钮
        addSubview(reloadBtn);
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // 监听按钮的点击
    func reloadBtnClick() -> Void {
        
        if let reloadCallBack = reloadCallBack {
            reloadCallBack();
        }
    }
    
    // 设置子控件的frame
    override func layoutSubviews() {
        super.layoutSubviews();
        
        let width = bounds.size.width;
        
        // 设置icon的frame
        let iconW = realValue(value: 198/2);
        let iconH = realValue(value: 256/2);
        let iconX = (width - iconW)/2 - realValue(value: 50);
        let iconY = realValue(value: 518/2 - 50);
        icon.frame = CGRect(x: iconX, y: iconY, width: iconW, height: iconH);
        
        // 设置提示label
        let textLabelW = calculateWidth(title: textLabel.text ?? "", fontSize: 32/2, maxWidth: realValue(value: 200))!;
        let textLabelH = realValue(value: 32/2);
        let textLabelX = (width - textLabelW)/2 - realValue(value: 50);
        let textLabelY = icon.frame.maxY + realValue(value: 20/2);
        textLabel.frame = CGRect(x: textLabelX, y: textLabelY, width: textLabelW, height: textLabelH);
        
        // 设置重加载按钮
        let reloadBtnW = iconW;
        let reloadBtnH = realValue(value: 36/2);
        let reloadBtnX = (width - reloadBtnW)/2 - realValue(value: 50);
        let reloadBtnY = textLabel.frame.maxY + realValue(value: 30/2);
        reloadBtn.frame = CGRect(x: reloadBtnX, y: reloadBtnY, width: reloadBtnW, height: reloadBtnH);
        
    }
    
    

}
