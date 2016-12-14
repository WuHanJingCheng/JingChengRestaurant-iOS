//
//  JCMenuHeaderViewModel.swift
//  JingChengWirelessOrderForDishes
//
//  Created by zhangxu on 2016/11/23.
//  Copyright © 2016年 zhangxu. All rights reserved.
//

import UIKit

class JCMenuHeaderViewModel: NSObject {
    
    deinit {
        print("JCMenuHeaderViewModel 被释放了");
    }

    // 从服务器获取分类列表的数据
    func fetchMenuListDataFromServer(successCallBack: @escaping(_ result: [JCMenuHeaderModel]) -> (), failureCallBack: @escaping(_ error: Error) -> ()) -> Void {
        
        let mgr = HttpManager.shared;
        mgr.requestSerializer.timeoutInterval = 10;
        mgr.request(.GET, urlString: categoryListAPI, parameters: nil, finished: { (result, error) in
            
            var result: [String: Any]? = result as? [String: Any];
            
            if let error = error {
                // 请求失败
                failureCallBack(error);
                // 请求失败
                // 从缓存获取数据
                result = CacheManager.shared.getResultFromCache("menuHeaderData.data") as? [String: Any];
            } else {
                
                // 缓存数据
                CacheManager.shared.cacheResult(result, fileName: "menuHeaderData.data");
            }
            
            if let result = result {
                
                guard let resultArray = result["results"] as? [[String: Any]] else {
                    return;
                }
                
                var menuHeaderModelArray = [JCMenuHeaderModel]();
                
                let _ = resultArray.enumerated().map({
                    (dict) in
                    let model = JCMenuHeaderModel.modelWidthDict(dict: dict.element);
                    model.isSelected = (dict.offset == 0) ? true : false;
                    menuHeaderModelArray.append(model);
                });
                
                // 请求成功
                successCallBack(menuHeaderModelArray);
            }
        })
    }
}
