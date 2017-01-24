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
    func fetchMenuDetailDataFromServer(menuHeaderModel: JCMenuHeaderModel, successCallBack: @escaping(_ result: [JCDishModel]) -> (), failureCallBack: @escaping(_ error: Error?) -> ()) -> URLSessionDataTask? {
       
        let mgr = HttpManager.shared;
        mgr.requestSerializer.timeoutInterval = 10;
        let task = mgr.get(dishlistUrl(MenuId: menuHeaderModel.MenuId ?? 0), parameters: nil, progress: nil, success: {
            (dataTask, result) in
            
            guard let response = dataTask.response as? HTTPURLResponse else {
                return;
            }
            
            if response.statusCode == 200 || response.statusCode == 201 || response.statusCode == 304 {
                
                guard let results = result as? [[String: Any]] else {
                    return;
                }
                
                var dishlist = [JCDishModel]();
                _ = results.map({
                    (dict) in
                    
                    let model = JCDishModel.modelWithDict(dict: dict);
                    dishlist.append(model);
                });
                
                // 请求成功
                successCallBack(dishlist);
            }
            
        }, failure: {
            (dataTask, error) in
            
            failureCallBack(error);
            
        })
       
        return task;
    }
}
