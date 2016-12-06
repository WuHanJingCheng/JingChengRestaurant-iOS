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
    func fetchMenuListDataFromServer(successCallBack: ((_ result: [JCMenuHeaderModel]) -> ())?, failureCallBack: ((_ error: Error) -> ())?) -> Void {
        
        let mgr = HttpManager.shared;
        mgr.requestSerializer.timeoutInterval = 10;
        mgr.request(.GET, urlString: categoryListAPI, parameters: nil, finished: { (result, error) in
            
            if let error = error {
                // 请求失败
                if let failureCallBack = failureCallBack {
                    failureCallBack(error);
                    return;
                }
            }
            
            guard let result = result as? [String: Any] else {return};
            
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
            if let successCallBack = successCallBack {
                successCallBack(menuHeaderModelArray);
            }
        })
    }
}
