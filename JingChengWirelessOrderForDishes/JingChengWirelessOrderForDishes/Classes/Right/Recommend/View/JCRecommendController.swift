//
//  JCRecommendController.swift
//  JingChengWirelessOrderForDishes
//
//  Created by zhangxu on 2016/11/23.
//  Copyright © 2016年 zhangxu. All rights reserved.
//

import UIKit
import WebKit

class JCRecommendController: UIViewController {
    
    // webView
    private lazy var webView: WKWebView = {
        let configuration = WKWebViewConfiguration();
        let webView = WKWebView.init(frame: .zero, configuration: configuration);
        return webView;
    }();
    
    // 释放
    deinit {
        print("JCRecommendController 被释放了");
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 添加webView
        view.addSubview(webView);
        
        // 创建URL对象
        guard let url = URL(string: "http://www.baidu.com") else {
            return;
        }
        
        // 创建请求对象
        let request = URLRequest.init(url: url, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10);
        webView.load(request);

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // 设置webView的frame
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews();
        
        // 设置webView的frame
        webView.frame = view.bounds;
    }
  
}
