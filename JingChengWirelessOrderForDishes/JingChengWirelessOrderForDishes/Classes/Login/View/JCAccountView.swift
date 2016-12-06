//
//  JCAccountView.swift
//  JingChengDiningHall
//
//  Created by zhangxu on 2016/10/13.
//  Copyright © 2016年 zhangxu. All rights reserved.
//

import UIKit

class JCAccountView: UIView {

    
    // 背景
    lazy var background: UIImageView = {
        let background = UIImageView();
        background.image = UIImage.imageWithName(name: "login_account_background");
        return background;
    }();
    
    // 账户
    lazy var accountLabel: UILabel = {
        let accountLabel = UILabel();
        accountLabel.text = "账户";
        accountLabel.textAlignment = .left;
        accountLabel.textColor = RGBWithHexColor(hexColor: 0x1a1a1a);
        accountLabel.font = Font(size: 36/2);
        return accountLabel;
    }();
    
    // 账户输入框
    lazy var accountTextField: UITextField = {
        let accountTextField = UITextField();
        accountTextField.placeholder = "手机号/名称";
        accountTextField.textColor = RGBWithHexColor(hexColor: 0x1a1a1a);
        accountTextField.clearButtonMode = .whileEditing;
        accountTextField.font = Font(size: 36/2);
        accountTextField.textAlignment = .left;
        return accountTextField;
    }();
    
    
    // MARK: - 初始化
    override init(frame: CGRect) {
        super.init(frame: frame);
        
        // 添加背景
        addSubview(background);
        
        // 添加账户label
        addSubview(accountLabel);
        
        // 添加输入框
        addSubview(accountTextField);
        
    }
    
    
    // MARK: - 设置子控件的frame
    override func layoutSubviews() {
        super.layoutSubviews();
        
        let width = bounds.size.width;
        
        // 设置background的frame
        background.frame = bounds;
        
        // 设置accountLabel 的frame
        let accountLabelX = realValue(value: 30/2);
        let accountLabelY = realValue(value: (100-36)/2/2);
        let accountLabelW = calculateWidth(title: accountLabel.text!, fontSize: 36/2, maxWidth: realValue(value: 100)) ?? 0;
        let accountLabelH = realValue(value: 36/2);
        accountLabel.frame = CGRect.init(x: accountLabelX, y: accountLabelY, width: accountLabelW, height: accountLabelH);
        
        // 设置输入框的frame
        let accountTextFieldX = accountLabel.frame.maxX + realValue(value: 40/2);
        let accountTextFieldY = accountLabelY;
        let accountTextFieldW = width - accountTextFieldX - realValue(value: 10);
        let accountTextFieldH = accountLabelH;
        accountTextField.frame = CGRect.init(x: accountTextFieldX, y: accountTextFieldY, width: accountTextFieldW, height: accountTextFieldH);
    }
    
      
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

}
