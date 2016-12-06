//
//  JCMenuViewModel.swift
//  JingChengWirelessOrderForDishes
//
//  Created by zhangxu on 2016/11/23.
//  Copyright © 2016年 zhangxu. All rights reserved.
//

import UIKit


class JCMenuViewModel: NSObject {
 
    deinit {
        print("JCMenuViewModel 被释放了");
    }
    
    // 发送请求获取分类对应的数据
    func fetchMenuDetailDataFromServer(url: String, successCallBack: ((_ result: [JCDishModel]) -> ())?, failureCallBack: ((_ error: Error) -> ())?) -> Void {
       
        let mgr = HttpManager.shared;
        mgr.requestSerializer.timeoutInterval = 10;
        mgr.request(.GET, urlString: url, parameters: nil, finished: { (result, error) in
            
            if let error = error {
                // 请求失败
                if let failureCallBack = failureCallBack {
                    failureCallBack(error);
                    return;
                }
            }
            
            guard let result = result as? [String: Any] else {
                return;
            }
            
            guard let resultArray = result["results"] as? [[String: Any]] else {
                return;
            };
            
            var menuViewModelArray = [JCDishModel]();
            
            let _ = resultArray.map({
                (dict) in
                let model = JCDishModel.modelWithDict(dict: dict);
                menuViewModelArray.append(model);
            });
            
            // 请求成功
            if let successCallBack = successCallBack {
                successCallBack(menuViewModelArray);
            }
        })
    }
}
