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
    func fetchMenuDetailDataFromServer(menuHeaderModel: JCMenuHeaderModel, successCallBack: @escaping(_ result: [JCDishModel]) -> (), failureCallBack: @escaping(_ error: Error) -> ()) -> Void {
       
        let mgr = HttpManager.shared;
        mgr.requestSerializer.timeoutInterval = 10;
        mgr.request(.GET, urlString: menuHeaderModel.category_url ?? "", parameters: nil, finished: { (result, error) in
            
            var result: [String: Any]? = result as? [String: Any];
      
            if let error = error {
                // 请求失败
                failureCallBack(error);
                result = CacheManager.shared.getResultFromCache("\(menuHeaderModel.name ?? "").data") as? [String: Any];
            } else {
                
                // 缓存数据
                CacheManager.shared.cacheResult(result, fileName: "\(menuHeaderModel.name ?? "").data");
            }
            
            if let result = result {
                
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
                successCallBack(menuViewModelArray);
            }
        })
    }
}
