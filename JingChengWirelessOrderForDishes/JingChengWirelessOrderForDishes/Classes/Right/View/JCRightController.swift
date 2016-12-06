//
//  JCRightController.swift
//  JingChengWirelessOrderForDishes
//
//  Created by zhangxu on 2016/11/22.
//  Copyright © 2016年 zhangxu. All rights reserved.
//

import UIKit

class JCRightController: UIViewController {

    // 懒加载菜谱
    lazy var menuVc: JCMenuController = {
        let menuVc = JCMenuController();
        menuVc.view.isHidden = false;
        return menuVc;
    }();
    
    // 懒加载推荐
    lazy var recommendVc: JCRecommendController = {
        let recommendVc = JCRecommendController();
        recommendVc.view.isHidden = true;
        return recommendVc;
    }();
    
    // 懒加载已点
    lazy var orderedVc: JCOrderController = {
        let orderedVc = JCOrderController();
        orderedVc.view.isHidden = true;
        return orderedVc;
    }();
    
    // 释放
    deinit {
        print("JCRightController被释放了");
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 设置背景颜色
        view.backgroundColor = RGBWithHexColor(hexColor: 0xf5ebd5);
        
        // 添加菜谱
        view.addSubview(menuVc.view);
        addChildViewController(menuVc);
        
        // 添加推荐
        view.addSubview(recommendVc.view);
        addChildViewController(recommendVc);
        
        // 添加已点
        view.addSubview(orderedVc.view);
        addChildViewController(orderedVc);

    }
    
    // 设置子控件的frame
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews();
        // 设置menuVC的frame
        menuVc.view.frame = view.bounds;
        
        // 设置recommendVC的frame
        recommendVc.view.frame = view.bounds;
        
        // 设置已点的frame 
        orderedVc.view.frame = view.bounds;
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
