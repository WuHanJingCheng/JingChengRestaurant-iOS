//
//  JCHomeController.swift
//  JingChengWirelessOrderForDishes
//
//  Created by zhangxu on 2016/11/22.
//  Copyright © 2016年 zhangxu. All rights reserved.
//

import UIKit

class JCHomeController: UIViewController {
    
    // topView
    private lazy var topView: JCTopView = {
        let topView = JCTopView();
        topView.backgroundColor = UIColor.white;
        return topView;
    }();
    
    // 左边控制器
   private lazy var leftVc: JCLeftController = {
        let leftVc = JCLeftController();
        return leftVc;
    }();
    
    // 右边控制器
    private lazy var rightVc: JCRightController = {
        let rightVc = JCRightController();
        return rightVc;
    }();
    
    
    // 移除通知
    deinit {
        // 移除通知
        NotificationCenter.default.removeObserver(self);
        print("JCHomeController 被释放了");
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 添加topView
        view.addSubview(topView);
        
        // 添加左边控制器
        view.addSubview(leftVc.view);
        addChildViewController(leftVc);
        
        // 添加右边控制器视图
        view.addSubview(rightVc.view);
        addChildViewController(rightVc);
        
        // 更新导航栏标题
        updateNav_Title();
        
        // 回到输入桌号页面
        rightVc.orderedVc.dismissCallBack = { [weak self]
            _ in
            self?.dismiss(animated: true, completion: nil);
        }
        
        
        // 切换菜单内容
        leftVc.switchMenuCallBack = { [weak self]
            (model) in
            
            let name = model.name ?? "";
            switch name {
                // 推荐
            case "推荐":
                self?.rightVc.recommendVc.view.isHidden = false;
                self?.rightVc.menuVc.view.isHidden = true;
                self?.rightVc.orderedVc.view.isHidden = true;
                /// 菜谱
            case "菜谱":
                self?.rightVc.recommendVc.view.isHidden = true;
                self?.rightVc.menuVc.view.isHidden = false;
                self?.rightVc.orderedVc.view.isHidden = true;
                self?.rightVc.menuVc.collectionView.reloadData();
                // 已点
            default:
                self?.rightVc.recommendVc.view.isHidden = true;
                self?.rightVc.menuVc.view.isHidden = true;
                self?.rightVc.orderedVc.view.isHidden = false;
                self?.rightVc.orderedVc.updateOrderModelArray();
            }
        }
        
    
        // 添加通知
        NotificationCenter.default.addObserver(self, selector: #selector(updateCategoryContentNotification(notification:)), name: ChangeCategoryNotification, object: nil);

    }
    
    // 监听通知，显示菜品页面，隐藏其他页面
    @objc private func updateCategoryContentNotification(notification: Notification) -> Void {
        
        rightVc.recommendVc.view.isHidden = true;
        rightVc.menuVc.view.isHidden = false;
        rightVc.orderedVc.view.isHidden = true;
        rightVc.menuVc.collectionView.reloadData();
        // 回到顶部
        let indexPath = IndexPath(item: 0, section: 0);
        rightVc.menuVc.collectionView.scrollToItem(at: indexPath, at: .top, animated: false);
        
        // 改变三角形的位置
        changeTrianglePosition();
        
        // 更新导航栏标题
        topView.titleLabel.text = "菜谱";
        
    }
    
    // 改变三角形的位置
    private func changeTrianglePosition() -> Void {
        
        // 改变三角形的位置
        let _ = leftVc.leftModelArray.enumerated().map({
            (model) in
            if model.offset == 1 {
                model.element.isShow = true;
            } else {
                model.element.isShow = false;
            }
        });
        
        // 刷新状态
        leftVc.tableView.reloadData();
    }
    
    // 更新导航栏的标题
    private func updateNav_Title() -> Void {
        // 更新导航栏标题
        leftVc.titleCallBack = { [weak self]
            (model) in
            if let name = model.name {
                self?.topView.titleLabel.text = name;
            }
        }
    }
    
    // MARK: - 设置子控件的frame
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews();
        
        let width = view.bounds.size.width;
        let height = view.bounds.size.height;
        
        // 设置topView 的frame
        let topViewX = CGFloat(0);
        let topViewY = CGFloat(20);
        let topViewW = width;
        let topViewH = CGFloat(88/2);
        topView.frame = CGRect(x: topViewX, y: topViewY, width: topViewW, height: topViewH);
        
        // 设置leftVc 视图的frame
        let leftVcX = topViewX;
        let leftVcY = topView.frame.maxY;
        let leftVcW = realValue(value: 162/2);
        let leftVcH = height - topView.frame.maxY;
        leftVc.view.frame = CGRect(x: leftVcX, y: leftVcY, width: leftVcW, height: leftVcH);
        
        // 设置rightVc 的frame
        let rightVcX = leftVc.view.frame.maxX;
        let rightVcY = leftVcY;
        let rightVcW = width - rightVcX;
        let rightVcH = leftVcH;
        rightVc.view.frame = CGRect(x: rightVcX, y: rightVcY, width: rightVcW, height: rightVcH);
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
