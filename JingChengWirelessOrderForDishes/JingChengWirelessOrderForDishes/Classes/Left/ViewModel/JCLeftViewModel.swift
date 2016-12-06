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
    func fetchLeftDataFromServer(successCallBack: ((_ result: [JCLeftModel]) -> ())?, failureCallBack: ((_ error: Error) -> ())?) -> Void {
        
        let mgr = HttpManager.shared;
        mgr.requestSerializer.timeoutInterval = 10;
        mgr.request(.GET, urlString: leftMenuListAPI, parameters: nil, finished: { (result, error) in
            
            if let error = error {
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
            }
            
            var leftModelArray = [JCLeftModel]();
            let _ = resultArray.enumerated().map({
                (dict) in
                let model = JCLeftModel.modelWidthDic(dict: dict.element);
                model.isRedIcon = (dict.offset == 2) ? true : false;
                model.isTriangle = (dict.offset == 1) ? true : false;
                leftModelArray.append(model);
            });
            
            // 解析成功
            if let successCallBack = successCallBack {
                successCallBack(leftModelArray);
            }
        });
    }
}
