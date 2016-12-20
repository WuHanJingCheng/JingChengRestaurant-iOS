//
//  JCLeftController.swift
//  JingChengWirelessOrderForDishes
//
//  Created by zhangxu on 2016/11/22.
//  Copyright © 2016年 zhangxu. All rights reserved.


import UIKit

class JCLeftController: UIViewController {
    
    // cell标识
    fileprivate let leftCellIdentifier = "leftCellIdentifier";
    
    // 背景
    private lazy var background: UIImageView = {
        let background = UIImageView();
        background.image = UIImage.imageWithName(name: "left_background");
        background.isUserInteractionEnabled = true;
        return background;
    }();
    
    // tableView
    lazy var tableView: UITableView = {
        let tableView = UITableView.init(frame: .zero, style: .plain);
        tableView.dataSource = self;
        tableView.delegate = self;
        tableView.rowHeight = realValue(value: 275/2);
        tableView.separatorStyle = .none;
        tableView.backgroundColor = UIColor.clear;
        tableView.bounces = false;
        return tableView;
    }();
    
    // 设置退出按钮的frame
    private lazy var exitBtn: UIButton = {
        let button = UIButton(type: .custom);
        button.setImage(UIImage.imageWithName(name: "left_exitBtn"), for: .normal);
        button.addTarget(self, action: #selector(exitBtnClick(button:)), for: .touchUpInside);
        return button;
    }();
    
    // 懒加载数据
    lazy var leftModelArray: [JCLeftModel] = [JCLeftModel]();

    // 切换菜单
    var switchMenuCallBack: ((_ model: JCLeftModel) -> ())?;
    // 更新导航栏标题
    var titleCallBack: ((_ model: JCLeftModel) -> ())?;
 
    
    // 释放
    deinit {
        print("JCLeftController 被释放了");
        
        // 移除通知
        NotificationCenter.default.removeObserver(self);
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 添加背景
        view.addSubview(background);
        
        // 添加tableView
        background.addSubview(tableView);
        
        // 添加退出按钮
        background.addSubview(exitBtn);
        
        // 注册cell
        tableView.register(JCLeftCell.self, forCellReuseIdentifier: leftCellIdentifier);
        
        // 发送请求
        let leftViewModel = JCLeftViewModel();
        leftViewModel.fetchLeftDataFromServer(successCallBack: { (result) in
            // 请求成功后的回调
            // 情况数组
            self.leftModelArray.removeAll();
            // 更新数组
            self.leftModelArray += result;
            // 刷新数据
            self.tableView.reloadData();
            
            }, failureCallBack: {
                (error) in
                // 请求失败后的回调
                print("请求失败", error);
        });
        
        // 添加通知监听份数的变化
        NotificationCenter.default.addObserver(self, selector: #selector(updateRedIconNumber), name: ChangeRedIconNumberNotification, object: nil);
        
    }
    
    // 监听通知
    @objc private func updateRedIconNumber() -> Void {
        
        // 修改份数
        let model = leftModelArray[2];
        model.number = JCDishManager.totalNumber();
        // 刷新数据
        let indexPath = IndexPath.init(row: 2, section: 0);
        let cell = tableView.cellForRow(at: indexPath) as? JCLeftCell;
        cell?.changeRedIconNumber(model: model);
    }
    
    // 监听退出按钮的点击
    @objc private func exitBtnClick(button: UIButton) -> Void {
        
        // 退出
        guard let window = UIApplication.shared.keyWindow else {
            return;
        }
        let exitView = JCExitView();
        exitView.frame = window.bounds;
        window.addSubview(exitView);
        // 添加动画
        ZXAnimation.startAnimation(targetView: exitView);
        // 回到登录页面
        exitView.submitBtnCallBack = { [unowned exitView, weak self]
            _ in
            // 将分数清空
            JCDishManager.shared.dishs.removeAll();
   
            self?.stopAnimation(targetView: exitView)
        
        }
        // 让退出页面消失
        exitView.cancelBtnCallBack = { [unowned exitView]
            _ in
            ZXAnimation.stopAnimation(targetView: exitView);
        }
    }
    
    // 停止动画
    func stopAnimation(targetView: UIView) -> Void {
        
        // 回到登录页面
        guard let window = UIApplication.shared.keyWindow else {
            return;
        }
        guard let loginVc = window.rootViewController as? JCLoginController else {
            return;
        };
        
        // 先将已有得根控制器销毁
        loginVc.dismiss(animated: false, completion: nil);
        
        let subView = targetView.subviews[0].subviews[0];
        UIView.animate(withDuration: 0.5, animations: {
            _ in
            
            subView.transform = CGAffineTransform(scaleX: 0, y: 0);
            targetView.alpha = 0;
            
            }, completion: {
                _ in
            
                // 移除目标视图
                targetView.removeFromSuperview();
        })
    }

    
    // 设置子控件的frame
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews();
        
        let width = view.bounds.size.width;
        let height = view.bounds.size.height;
        
        // 设置背景的frame
        background.frame = view.bounds;
        
        // 设置tableView的frame
        let tableViewX = CGFloat(0);
        let tableViewY = realValue(value: 219/2);
        let tableViewW = width;
        let tableViewH = realValue(value: 825/2);
        tableView.frame = CGRect(x: tableViewX, y: tableViewY, width: tableViewW, height: tableViewH);
        
        // 设置exitBtn 的frame
        let exitBtnX = realValue(value: 30/2);
        let exitBtnY = height - realValue(value: 101/2);
        let exitBtnW = realValue(value: 100/2);
        let exitBtnH = realValue(value: 41/2);
        exitBtn.frame = CGRect(x: exitBtnX, y: exitBtnY, width: exitBtnW, height: exitBtnH);
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

// MARK: - 隔离数据源方法
extension JCLeftController: UITableViewDataSource, UITableViewDelegate {
    
    //  返回行
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return leftModelArray.count;
    }
    
    //  返回cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: leftCellIdentifier, for: indexPath) as? JCLeftCell;
        let model = leftModelArray[indexPath.row];
        cell?.model = model;
        return cell!;
    }
    
    // 选中cell，切换内容
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // 取出Model
        let model = leftModelArray[indexPath.row];
        
        // 切换菜单
        if let switchMenuCallBack = switchMenuCallBack {
            switchMenuCallBack(model);
        }
        
        // 改变三角形的显示和隐藏
        changeTrianglePosition(model);
        
        // 更新导航栏标题
        if let titleCallBack = titleCallBack {
            titleCallBack(model);
        }
    }
    
    // 改变三角形的显示和隐藏
    private func changeTrianglePosition(_ model: JCLeftModel) -> Void {
        
        let _ = leftModelArray.map({
            (leftModel) in
            leftModel.isShow = false;
        });
        
        model.isShow = true;
        
        // 刷新状态
        tableView.reloadData();
    }
}

