//
//  JCPasswordView.swift
//  JingChengDiningHall
//
//  Created by zhangxu on 2016/10/13.
//  Copyright © 2016年 zhangxu. All rights reserved.
//

import UIKit

class JCPasswordView: UIView {

    // 背景
    private lazy var background: UIImageView = {
        let background = UIImageView();
        background.image = UIImage.imageWithName(name: "login_account_background");
        return background;
    }();
    
    // 密码
    private lazy var passwordLabel: UILabel = {
        let passwordLabel = UILabel();
        passwordLabel.text = "密码";
        passwordLabel.font = Font(size: 36/2);
        passwordLabel.textColor = RGBWithHexColor(hexColor: 0x1a1a1a);
        passwordLabel.textAlignment = .left;
        return passwordLabel;
    }();
    
    // 密码输入框
    lazy var passwordTextField: UITextField = {
        let passwordTextField = UITextField();
        passwordTextField.placeholder = "请输入密码";
        passwordTextField.textColor = RGBWithHexColor(hexColor: 0x1a1a1a);
        passwordTextField.clearButtonMode = .whileEditing;
        passwordTextField.font = Font(size: 36/2);
        passwordTextField.textAlignment = .left;
        return passwordTextField;
    }();
    
    // 显示密码的按钮
    private lazy var eyeBtn: UIButton = {
        let eyeBtn = UIButton(type: .custom);
        eyeBtn.setImage(UIImage.imageWithName(name: "login_password_eye_normal"), for: .normal);
        eyeBtn.setImage(UIImage.imageWithName(name: "login_password_eye_selected"), for: .selected);
        return eyeBtn;
    }();
    
    // MARK: - 初始化方法
    override init(frame: CGRect) {
        super.init(frame: frame);
        
        // 设置背景
        addSubview(background);
        
        // 添加密码
        addSubview(passwordLabel);
        
        // 添加密码输入框
        addSubview(passwordTextField);
        
        // 添加显示密码的按钮
        addSubview(eyeBtn);
    }
    
    // MARK: - 设置子控件的frame
    override func layoutSubviews() {
        super.layoutSubviews();
        
        let width = bounds.size.width;
        let height = bounds.size.height;
        
        // 设置背景的frame
        background.frame = bounds;
        
        // 设置passwordLabel 的frame
        let passwordLabelX = realValue(value: 30/2);
        let passwordLabelY = realValue(value: (100-36)/2/2);
        let passwordLabelW = calculateWidth(title: passwordLabel.text ?? "", fontSize: 36/2, maxWidth: realValue(value: 100)) ?? 0;
        let passwordLabelH = realValue(value: 36/2);
        passwordLabel.frame = CGRect.init(x: passwordLabelX, y: passwordLabelY, width: passwordLabelW, height: passwordLabelH);
        
        // 设置passwordTextField 的frame
        let passwordTextFieldX = passwordLabel.frame.maxX + realValue(value: 40/2);
        let passwordTextFieldY = passwordLabelY;
        let passwordTextFieldW = width - passwordTextFieldX - realValue(value: 10) - realValue(value: 40/2);
        let passwordTextFieldH = passwordLabelH;
        passwordTextField.frame = CGRect.init(x: passwordTextFieldX, y: passwordTextFieldY, width: passwordTextFieldW, height: passwordTextFieldH);
        
        // 设置显示密码按钮的frame
        let eyeBtnCenterX = width - realValue(value: 20/2) - realValue(value: 40/2) + realValue(value: 40/2/2);
        let eyeBtnCenterY = height/2;
        let eyeBtnW = realValue(value: 40/2);
        let eyeBtnH = realValue(value: 18/2);
        eyeBtn.center = CGPoint.init(x: eyeBtnCenterX, y: eyeBtnCenterY);
        eyeBtn.bounds = CGRect.init(x: 0, y: 0, width: eyeBtnW, height: eyeBtnH);
        
    
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
