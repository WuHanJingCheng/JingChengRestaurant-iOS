//
//  JCExitView.swift
//  JingChengWirelessOrderForDishes
//
//  Created by zhangxu on 2016/11/30.
//  Copyright © 2016年 zhangxu. All rights reserved.
//

import UIKit

class JCExitView: UIView {

    // 背景
    private lazy var background: UIImageView = {
        let background = UIImageView();
        background.image = UIImage.imageWithName(name: "exitView_background");
        background.isUserInteractionEnabled = true;
        return background;
    }();
    
    // 内容背景
    private lazy var contentbackground: UIImageView = {
        let contentbackground = UIImageView();
        contentbackground.image = UIImage.imageWithName(name: "exitView_contentbackground");
        contentbackground.isUserInteractionEnabled = true;
        return contentbackground;
    }();
    
    // 添加退出标签
    private lazy var exitLabel: UILabel = {
        let label = UILabel();
        label.text = "退出登录";
        label.font = Font(size: 36/2);
        label.textColor = RGBWithHexColor(hexColor: 0x191919);
        label.textAlignment = .center;
        return label;
    }();
    
    // 详情标签
    private lazy var detailLabel: UILabel = {
        let label = UILabel();
        label.text = "你确定退出登录吗?";
        label.font = Font(size: 36/2);
        label.textColor = RGBWithHexColor(hexColor: 0x191919);
        label.textAlignment = .center;
        return label;
    }();
    
    // 确定按钮
    private lazy var submitBtn: UIButton = {
        let button = UIButton(type: .custom);
        button.setBackgroundImage(UIImage.imageWithName(name: "exitView_submitBtn_background"), for: .normal);
        button.setTitle("确定", for: .normal);
        button.setTitleColor(RGBWithHexColor(hexColor: 0x191919), for: .normal);
        button.addTarget(self, action: #selector(submitBtnClick), for: .touchUpInside);
        button.titleLabel?.font = Font(size: 36/2);
        return button;
    }();
    
    // 取消按钮
    private lazy var cancelBtn: UIButton = {
        let button = UIButton(type: .custom);
        button.setBackgroundImage(UIImage.imageWithName(name: "exitView_cancelBtn_background"), for: .normal);
        button.setTitle("取消", for: .normal);
        button.setTitleColor(RGBWithHexColor(hexColor: 0x191919), for: .normal);
        button.titleLabel?.font = Font(size: 36/2);
        button.addTarget(self, action: #selector(cancelBtnClick), for: .touchUpInside);
        return button;
    }();
    
    // 确定按钮的回调
    var submitBtnCallBack: (() -> ())?;
    // 取消按钮的回调
    var cancelBtnCallBack: (() -> ())?;
    
    // 初始化
    override init(frame: CGRect) {
        super.init(frame: frame);
        
        // 添加背景
        addSubview(background);
        
        // 添加内容背景
        background.addSubview(contentbackground);
        
        // 添加exitLabel
        contentbackground.addSubview(exitLabel);
        
        // 添加detailLabel
        contentbackground.addSubview(detailLabel);
        
        // 添加submitBtn
        contentbackground.addSubview(submitBtn);
        
        // 添加cancelBtn
        contentbackground.addSubview(cancelBtn);
        
    }
    
    // 监听确定按钮的点击
    @objc private func submitBtnClick() -> Void {
        
        if let submitBtnCallBack = submitBtnCallBack {
            submitBtnCallBack();
        }
    }
    
    // 监听取消按钮的点击
    @objc private func cancelBtnClick() -> Void {
        
        if let cancelBtnCallBack = cancelBtnCallBack {
            cancelBtnCallBack();
        }
    }
    
    // 设置子控件的frame
    override func layoutSubviews() {
        super.layoutSubviews();
        
        // 设置background 的frame
        background.frame = bounds;
        
        let width = background.bounds.size.width;
        let height = background.bounds.size.height;
        
        // 设置contentbackground 的frame
        let contentbackgroundCenterX = width/2;
        let contentbackgroundCenterY = height/2;
        let contentbackgroundW = realValue(value: 842/2);
        let contentbackgroundH = realValue(value: 502/2);
        contentbackground.center = CGPoint(x: contentbackgroundCenterX, y: contentbackgroundCenterY);
        contentbackground.bounds = CGRect(x: 0, y: 0, width: contentbackgroundW, height: contentbackgroundH);
        
        // 设置exitLabel 的frame
        let exitLabelX = realValue(value: 0);
        let exitLabelY = realValue(value: 0);
        let exitLabelW = contentbackgroundW;
        let exitLabelH = realValue(value: 116/2);
        exitLabel.frame = CGRect(x: exitLabelX, y: exitLabelY, width: exitLabelW, height: exitLabelH);
        
        // 设置detailLabel 的frame
        let detailLabelX = exitLabelX;
        let detailLabelY = exitLabel.frame.maxY;
        let detailLabelW = exitLabelW;
        let detailLabelH = contentbackgroundH - exitLabelH - realValue(value: 124/2);
        detailLabel.frame = CGRect(x: detailLabelX, y: detailLabelY, width: detailLabelW, height: detailLabelH);
        
        // 设置submitBtn 的frame
        let submitBtnX = realValue(value: 70/2);
        let submitBtnY = detailLabel.frame.maxY + realValue(value: 24/2);
        let submitBtnW = realValue(value: 310/2);
        let submitBtnH = realValue(value: 76/2);
        submitBtn.frame = CGRect(x: submitBtnX, y: submitBtnY, width: submitBtnW, height: submitBtnH);
        
        // 设置cancelBtn 的frame
        let cancelBtnX = submitBtn.frame.maxX + realValue(value: 82/2);
        let cancelBtnY = submitBtnY;
        let cancelBtnW = submitBtnW;
        let cancelBtnH = submitBtnH;
        cancelBtn.frame = CGRect(x: cancelBtnX, y: cancelBtnY, width: cancelBtnW, height: cancelBtnH);
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

}
