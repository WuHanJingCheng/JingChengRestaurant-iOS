//
//  JCEmptyBackground.swift
//  JingChengWirelessOrderForDishes
//
//  Created by zhangxu on 2016/11/29.
//  Copyright © 2016年 zhangxu. All rights reserved.
//

import UIKit

class JCEmptyBackground: UIView {

    // 背景
    private lazy var background: UIImageView = {
        let background = UIImageView();
        background.image = UIImage.imageWithName(name: "order_empty_background");
        background.isUserInteractionEnabled = true;
        return background;
    }();
    
    // 图片
    private lazy var icon: UIImageView = {
        let icon = UIImageView();
        icon.image = UIImage.imageWithName(name: "order_empty_icon");
        return icon;
    }();
    
    // 文字
    private lazy var textLabel: UILabel = {
        let label = UILabel();
        label.font = Font(size: 36/2);
        label.textColor = RGBWithHexColor(hexColor: 0x1a1a1a);
        label.text = "你还没有点餐哦";
        return label;
    }();
    
    // 详细文字
    private lazy var detailLabel: UILabel = {
        let label = UILabel();
        label.font = Font(size: 36/2);
        label.textColor = RGBWithHexColor(hexColor: 0x1a1a1a);
        label.text = "赶快行动吧";
        return label;
    }();
    
    // 重新开台
    private lazy var keepOrderBtn: UIButton = {
        let button = UIButton(type: .custom);
        button.setBackgroundImage(UIImage.imageWithName(name: "order_empty_keepOrderBtn_background_normal"), for: .normal);
        button.setBackgroundImage(UIImage.imageWithName(name: "order_empty_keepOrderBtn_background_highlighted"), for: .highlighted);
        button.setTitle("重新开台", for: .normal);
        button.setTitleColor(RGBWithHexColor(hexColor: 0x1a1a1a), for: .normal)
        button.titleLabel?.font = Font(size: 32/2);
        button.addTarget(self, action: #selector(keepOrderBtnClick), for: .touchUpInside);
        return button;
    }();
    
    // 点餐按钮
    private lazy var orderBtn: UIButton = {
        let button = UIButton(type: .custom);
        button.setBackgroundImage(UIImage.imageWithName(name: "order_empty_orderBtn_background_normal"), for: .normal);
        button.setTitle("点餐", for: .normal);
        button.setBackgroundImage(UIImage.imageWithName(name: "order_empty_orderBtn_background_highlighted"), for: .highlighted);
        button.setTitleColor(RGBWithHexColor(hexColor: 0x1a1a1a), for: .normal);
        button.titleLabel?.font = Font(size: 32/2);
        button.addTarget(self, action: #selector(orderBtnClick), for: .touchUpInside);
        return button;
    }();
    
    // 点击点餐按钮回调
    var orderBtnCallBack: (() -> ())?;
    // 点击重新开台按钮的回调
    var keepOrderBtnCallBack: (() -> ())?;
    
    // 初始化
    override init(frame: CGRect) {
        super.init(frame: frame);
        
        // 添加background 
        addSubview(background);
        
        // 添加icon 
        background.addSubview(icon);
        
        // 添加textLabel
        background.addSubview(textLabel);
        
        // 添加detailLabel 
        background.addSubview(detailLabel);
        
        // 添加keepOrderBtn
        background.addSubview(keepOrderBtn);
        
        // 添加orderBtn 
        background.addSubview(orderBtn);

    }
    
    // 监听点餐按钮点击
    @objc private func orderBtnClick() -> Void {
        
        if let orderBtnCallBack = orderBtnCallBack {
            orderBtnCallBack();
        }
    }
    
    // 监听重新开台的按钮点击
    @objc private func keepOrderBtnClick() -> Void {
        
        if let keepOrderBtnCallBack = keepOrderBtnCallBack {
            keepOrderBtnCallBack();
        }
    }
    
    // 设置子控件的frame
    override func layoutSubviews() {
        super.layoutSubviews();
        
        // 设置background 的frame
        background.frame = bounds;
        
        let width = background.bounds.size.width;
        
        // 设置icon
        let iconX = realValue(value: 314/2);
        let iconY = realValue(value: 408/2);
        let iconW = realValue(value: 602/2);
        let iconH = realValue(value: 462/2);
        icon.frame = CGRect(x: iconX, y: iconY, width: iconW, height: iconH);
        
        // 设置textLabel 的frame
        let textLabelX = icon.frame.maxX + realValue(value: 130/2);
        let textLabelY = realValue(value: 528/2);
        let textLabelW = calculateWidth(title: textLabel.text ?? "", fontSize: 36/2, maxWidth: width - textLabelX) ?? 0;
        let textLabelH = realValue(value: 36/2);
        textLabel.frame = CGRect(x: textLabelX, y: textLabelY ,width: textLabelW, height: textLabelH);
        
        // 设置detailLabel 的frame
        let detailLabelX = textLabelX;
        let detailLabelY = textLabel.frame.maxY + realValue(value: 38/2);
        let detailLabelW = textLabelW;
        let detailLabelH = textLabelH;
        detailLabel.frame = CGRect(x: detailLabelX, y: detailLabelY, width: detailLabelW, height: detailLabelH);
        
        // 设置keepOrderBtn 的 frame
        let keepOrderBtnX = textLabelX;
        let keepOrderBtnY = detailLabel.frame.maxY + realValue(value: 126/2);
        let keepOrderBtnW = realValue(value: 220/2);
        let keepOrderBtnH = realValue(value: 72/2);
        keepOrderBtn.frame = CGRect(x: keepOrderBtnX, y: keepOrderBtnY, width: keepOrderBtnW, height: keepOrderBtnH);
        
        // 设置orderBtn 的frame
        let orderBtnX = keepOrderBtn.frame.maxX + realValue(value: 80/2);
        let orderBtnY = keepOrderBtnY;
        let orderBtnW = keepOrderBtnW;
        let orderBtnH = keepOrderBtnH;
        orderBtn.frame = CGRect(x: orderBtnX, y: orderBtnY, width: orderBtnW, height: orderBtnH);
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
}
