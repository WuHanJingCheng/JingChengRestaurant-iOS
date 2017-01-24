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
    func fetchMenuListDataFromServer(successCallBack: @escaping(_ result: [JCMenuHeaderModel]) -> (), failureCallBack: @escaping(_ error: Error?) -> ()) -> Void {
        
        let mgr = HttpManager.shared;
        mgr.requestSerializer.timeoutInterval = 10;
        mgr.request(.GET, urlString: submenulistUrl(restaurantId: restaurantId), parameters: nil, finished: { (dataTask, result, error) in
            
            if let dataTask = dataTask {
                guard let response = dataTask.response as? HTTPURLResponse else {
                    return;
                }
                
                if response.statusCode == 200 || response.statusCode == 201 || response.statusCode == 304 {
                    
                    guard let results = result as? [[String: Any]] else {
                        return;
                    }
                    
                    var menulist = [JCMenuHeaderModel]();
                    _ = results.enumerated().map({
                        (dict) in
                        let model = JCMenuHeaderModel.modelWidthDict(dict: dict.element);
                        model.isSelected = (dict.offset == 0) ? true : false;
                        menulist.append(model);
                    });
                    // 请求成功
                    successCallBack(menulist);
                } else {
                    failureCallBack(error);
                }
            }
        })
    }
}
