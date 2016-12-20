//
//  JCLeftViewModel.swift
//  JingChengWirelessOrderForDishes
//
//  Created by zhangxu on 2016/11/30.
//  Copyright © 2016年 zhangxu. All rights reserved.
//

import UIKit

class JCLeftViewModel: NSObject {
    
    
    // 从服务器请求数据
    func fetchLeftDataFromServer(successCallBack: @escaping(_ result: [JCLeftModel]) -> (), failureCallBack: @escaping(_ error: Error) -> ()) -> Void {
        
        let mgr = HttpManager.shared;
        mgr.requestSerializer.timeoutInterval = 10;
        mgr.request(.GET, urlString: leftMenuListAPI, parameters: nil, finished: { (result, error) in
            
            var result: [String: Any]? = result as? [String: Any];
            
            if let error = error {
                failureCallBack(error);
                // 显示请求错误
                print("请求失败, 或没有网络");
                // 加载缓存
                result = CacheManager.shared.getResultFromCache("leftMenuData.data") as? [String: Any];
            } else {
                
                // 缓存数据
                CacheManager.shared.cacheResult(result, fileName: "leftMenuData.data");
            }
            
            if let result = result {
     
                guard let resultArray = result["results"] as? [[String: Any]] else {
                    return;
                }
                
                var leftModelArray = [JCLeftModel]();
                let _ = resultArray.enumerated().map({
                    (dict) in
                    let model = JCLeftModel.modelWidthDic(dict: dict.element);
                    model.isRedIcon = (dict.offset == 2) ? true : false;
                    model.isShow = (dict.offset == 1) ? true : false;
                    leftModelArray.append(model);
                });
                
                // 解析成功
                successCallBack(leftModelArray);
            }
            
        });
    }
}
