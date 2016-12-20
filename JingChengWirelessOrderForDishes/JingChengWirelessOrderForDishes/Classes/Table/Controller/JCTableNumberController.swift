//
//  JCTableNumberController.swift
//  JingChengOrderMeal
//
//  Created by zhangxu on 2016/11/10.
//  Copyright © 2016年 zhangxu. All rights reserved.
//

import UIKit

class JCTableNumberController: UIViewController, UITabBarControllerDelegate {
    
    // 背景
    private lazy var background: UIImageView = {
        let background = UIImageView();
        background.isUserInteractionEnabled = true;
        background.image = UIImage.imageWithName(name: "table_background");
        return background;
    }();
    
    // 中间的背景
    private lazy var middlebackground: UIImageView = {
        let middlebackground = UIImageView();
        middlebackground.image = UIImage.imageWithName(name: "table_middle_background");
        middlebackground.isUserInteractionEnabled = true;
        return middlebackground;
    }();
    
    // logo 
    private lazy var logo: UIImageView = {
        let logo = UIImageView();
        logo.image = UIImage.imageWithName(name: "table_logo");
        return logo;
    }();
    
    // 就餐label
    private lazy var dinnerLabel: UILabel = {
        let label = UILabel();
        label.text = "请输入就餐桌号";
        label.font = Font(size: 32/2);
        label.textColor = RGBWithHexColor(hexColor: 0x323232);
        label.textAlignment = .left;
        return label;
    }();
    
    // 桌号输入框
    private lazy var tableTextField: UITextField = {
        let textField = UITextField();
        textField.placeholder = "桌号";
        textField.borderStyle = .none;
        textField.clearButtonMode = .whileEditing;
        textField.font = Font(size: 40/2);
        textField.textAlignment = .center;
        textField.textColor = RGBWithHexColor(hexColor: 0x1a1a1a);
//        textField.becomeFirstResponder();
        return textField;
    }();
    
    // 输入框下划线
    private lazy var tableBottomLine: UIImageView = {
        let icon = UIImageView();
        icon.image = UIImage.imageWithName(name: "table_bottomLine");
        return icon;
    }();
    
    // 就餐按钮
    private lazy var dinnerBtn: UIButton = {
        let button = UIButton(type: .custom);
        button.setBackgroundImage(UIImage.imageWithName(name: "table_submitBtn"), for: .normal);
        button.setTitle("点餐", for: .normal);
        button.setTitleColor(RGBWithHexColor(hexColor: 0x343434), for: .normal);
        button.titleLabel?.font = Font(size: 36/2);
        button.addTarget(self, action: #selector(dinnerBtnClick(button:)), for: .touchUpInside);
        return button;
    }();
    
    // 移除通知
    deinit {
         // 移除通知
        NotificationCenter.default.removeObserver(self);
        
        print("JCTableNumberController 被释放了");
    }
 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 添加背景
        view.addSubview(background);
        
        // 添加中间的背景
        background.addSubview(middlebackground);
        
        // logo
        middlebackground.addSubview(logo);
        
        // 添加 dinnerLabel
        middlebackground.addSubview(dinnerLabel);
        
        // 添加 桌号输入框
        middlebackground.addSubview(tableTextField);
        
        // 添加输入框下划线
        middlebackground.addSubview(tableBottomLine);
        
        // 输入就餐按钮
        middlebackground.addSubview(dinnerBtn);
        
        // 添加通知，监听键盘的弹出
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: Notification.Name.UIKeyboardWillShow, object: nil);
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil);

        
        // Do any additional setup after loading the view.
    }
    
    // MARK: - 点击屏幕其他地方，回收键盘
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true);
    }
    
    
    // MARK: - 键盘弹出
    @objc private func keyboardWillShow(notification: Notification) -> Void {
        
        guard let userInfo = notification.userInfo else {
            return;
        }
        
        // 键盘弹出需要的时间
        let duration = (userInfo[UIKeyboardAnimationDurationUserInfoKey] as! NSNumber).doubleValue;
        
        // 动画
        UIView.animate(withDuration: duration) {
            
            // 取出键盘高度
            let keyboardF = (userInfo[UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue;
            let keyboardH = keyboardF.size.height;
            self.view.transform = CGAffineTransform(translationX: 0, y: -keyboardH/2 + realValue(value: 80/2));
        }
    }
    
    // MARK: - 键盘影藏
    @objc private func keyboardWillHide(notification: Notification) -> Void {
        
        guard let userInfo = notification.userInfo else {
            return;
        }
        
        // 键盘弹出需要的时间
        let duration = (userInfo[UIKeyboardAnimationDurationUserInfoKey] as! NSNumber).doubleValue;
        // 动画
        UIView.animate(withDuration: duration) {
            
            self.view.transform = CGAffineTransform.identity;
        }
    }
    
  
    // MARK: - 点击进入推荐页面
    @objc private func dinnerBtnClick(button: UIButton) -> Void {
        
        let homeVc = JCHomeController();
        homeVc.modalTransitionStyle = .crossDissolve;
        present(homeVc, animated: true, completion: nil);
        
    }

    // MARK: - 设置子控件的frame
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews();
        
        // 设置背景的frame
        background.frame = view.bounds;
        
        // 设置中间背景的frame
        let middlebackgroundCenterX = kScreenWidth/2;
        let middlebackgroundCenterY = kScreenHeight/2;
        let middlebackgroundW = realValue(value: 874/2);
        let middlebackgroundH = realValue(value: 564/2);
        middlebackground.center = CGPoint(x: middlebackgroundCenterX, y: middlebackgroundCenterY);
        middlebackground.bounds = CGRect(x: 0, y: 0, width: middlebackgroundW, height: middlebackgroundH);
        
        // 设置logo 的frame
        let logoCenterX = middlebackgroundW/2;
        let logoCenterY = realValue(value: 56/2 + 150/2/2);
        let logoW = realValue(value: 150/2);
        let logoH = logoW;
        logo.center = CGPoint(x: logoCenterX, y: logoCenterY);
        logo.bounds = CGRect(x: 0, y: 0, width: logoW, height: logoH);
        
        // 设置dinnerLabel 的frame
        let dinnerLabelX = realValue(value: 240/2);
        let dinnerLabelY = logo.frame.maxY + realValue(value: 95/2);
        let dinnerLabelW = (calculateWidth(title: dinnerLabel.text ?? "", fontSize: 32/2, maxWidth: 300/2) ?? 0) + realValue(value: 2);
        let dinnerLabelH = realValue(value: 32/2);
        dinnerLabel.frame = CGRect(x: dinnerLabelX, y: dinnerLabelY, width: dinnerLabelW, height: dinnerLabelH);
        
        // 设置 tableTextField 的frame
        let tableTextFieldX = dinnerLabel.frame.maxX + realValue(value: 30/2);
        let tableTextFieldY = dinnerLabel.frame.maxY - realValue(value: 48/2);
        let tableTextFieldW = realValue(value: 120/2);
        let tableTextFieldH = realValue(value: 40/2);
        tableTextField.frame = CGRect(x: tableTextFieldX, y: tableTextFieldY, width: tableTextFieldW, height: tableTextFieldH);
        
        // 设置tableBottomLine 的frame
        let tableBottomLineX = tableTextFieldX;
        let tableBottomLineY = tableTextField.frame.maxY + realValue(value: 8/2);
        let tableBottomLineW = tableTextFieldW;
        let tableBottomLineH = realValue(value: 1/2);
        tableBottomLine.frame = CGRect(x: tableBottomLineX, y: tableBottomLineY, width: tableBottomLineW, height: tableBottomLineH);
        
        // 设置dinnerBtn 的frame
        let dinnerBtnCenterX = logoCenterX;
        let dinnerBtnCenterY = dinnerLabel.frame.maxY + realValue(value: 110/2 + 64/2/2);
        let dinnerBtnW = realValue(value: 200/2);
        let dinnerBtnH = realValue(value: 64/2);
        dinnerBtn.center = CGPoint(x: dinnerBtnCenterX, y: dinnerBtnCenterY);
        dinnerBtn.bounds = CGRect(x: 0, y: 0, width: dinnerBtnW, height: dinnerBtnH);
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
       
    }

}
