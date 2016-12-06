//
//  JCLoginController.swift
//  JingChengDiningHall
//
//  Created by zhangxu on 2016/10/13.
//  Copyright © 2016年 zhangxu. All rights reserved.
//

import UIKit

class JCLoginController: UIViewController {
    
    
    // 背景
    private lazy var background: UIImageView = {
        let background = UIImageView();
        background.isUserInteractionEnabled = true;
        background.image = UIImage.imageWithName(name: "login_background");
        return background;
    }();
    
    // 小背景
    private lazy var loginBackground: UIImageView = {
        let loginBackground = UIImageView();
        loginBackground.image = UIImage.imageWithName(name: "login_middle_background");
        loginBackground.isUserInteractionEnabled = true;
        return loginBackground;
    }();
    
    // 账户
    private lazy var accountView: JCAccountView = JCAccountView();
    
    // 密码
    private lazy var passwordView: JCPasswordView = JCPasswordView();
    
    // 登录按钮
    private lazy var loginBtn: UIButton = {
        let loginBtn = UIButton(type: .custom);
        loginBtn.setBackgroundImage(UIImage.imageWithName(name: "login_btn"), for: .normal);
        loginBtn.setTitle("登录", for: .normal);
        loginBtn.titleLabel?.font = Font(size: 36/2);
        loginBtn.setTitleColor(RGBWithHexColor(hexColor: 0x1a1a1a), for: .normal);
        loginBtn.addTarget(self, action: #selector(loginBtnClick(button:)), for: .touchUpInside);
        return loginBtn;
    }();
    
    
    // 移除通知
    deinit {
        NotificationCenter.default.removeObserver(self);
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // 添加背景
        view.addSubview(background);
        
        // 添加登录背景
        background.addSubview(loginBackground);
        
        // 添加账户
        loginBackground.addSubview(accountView);
        
        // 添加密码
        loginBackground.addSubview(passwordView);
        
        // 登录按钮
        loginBackground.addSubview(loginBtn);
        
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

    // MARK: - 点击登录按钮，进入主页
    @objc private func loginBtnClick(button: UIButton) -> Void {
        
        debugPrint("点击了登录按钮");

        let tableVc = JCTableNumberController();
        present(tableVc, animated: true, completion: nil);
    }
    
    
    // MARK: - 设置子控件的frame
    override func viewDidLayoutSubviews() {
        
        super.viewDidLayoutSubviews();
        
        // 设置背景的frame
        background.frame = view.bounds;
        
        // 设置白色背景的frame
        let loginBackgroundCenterX = kScreenWidth/2;
        let loginBackgroundCenterY = kScreenHeight/2;
        let loginBackgroundW = realValue(value: 830/2);
        let loginBackgroundH = realValue(value: 512/2);
        loginBackground.center = CGPoint(x: loginBackgroundCenterX, y: loginBackgroundCenterY);
        loginBackground.bounds = CGRect(x: 0, y: 0, width: loginBackgroundW, height: loginBackgroundH);
        
         // 设置accountView 的frame
        let accountViewCenterX = loginBackgroundW/2;
        let accountViewCenterY = realValue(value: 50/2 + 100/2/2);
        let accountViewW = realValue(value: 720/2);
        let accountViewH = realValue(value: 100/2);
        accountView.center = CGPoint.init(x: accountViewCenterX, y: accountViewCenterY);
        accountView.bounds = CGRect.init(x: 0, y: 0, width: accountViewW, height: accountViewH);
        
        // 设置passwordView 的frame
        let passwordViewCeneterX = accountViewCenterX;
        let passwordViewCeneterY = accountView.frame.maxY + realValue(value: 30/2 + 100/2/2);
        let passwordViewW = accountViewW;
        let passwordViewH = accountViewH;
        passwordView.center = CGPoint.init(x: passwordViewCeneterX, y: passwordViewCeneterY);
        passwordView.bounds = CGRect.init(x: 0, y: 0, width: passwordViewW, height: passwordViewH);
        
        // 设置登录按钮的frame
        let loginBtnCenterX = accountViewCenterX;
        let loginBtnCenterY = passwordView.frame.maxY + realValue(value: 60/2 + 100/2/2);
        let loginBtnW = accountViewW;
        let loginBtnH = accountViewH;
        loginBtn.center = CGPoint.init(x: loginBtnCenterX, y: loginBtnCenterY);
        loginBtn.bounds = CGRect.init(x: 0, y: 0, width: loginBtnW, height: loginBtnH);
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
