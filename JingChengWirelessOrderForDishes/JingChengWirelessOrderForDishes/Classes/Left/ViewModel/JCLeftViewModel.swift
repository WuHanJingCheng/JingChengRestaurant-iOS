//
//  JCLeftViewModel.swift
//  JingChengWirelessOrderForDishes
//
//  Created by zhangxu on 2016/11/30.
//  Copyright © 2016年 zhangxu. All rights reserved.
//

import UIKit

class JCLeftViewModel: NSObject {
    
    // 从本地获取JSON数据
    func fetchJsonDataFromLocal(successCallBack: @escaping(_ menulist: [JCLeftModel]) -> ()) -> Void {
        
        
        DispatchQueue.global().async {
            
            guard let url = Bundle.main.url(forResource: "JCLeftData", withExtension: "json") else {
                return;
            }
            guard let data = try? Data.init(contentsOf: url) else {
                return;
            };
            
            guard let results = try!JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [[String: Any]] else {
                return;
            }
            
            var menulist = [JCLeftModel]();
            _ = results.enumerated().map({
                (dict) in
                
                let model = JCLeftModel.modelWidthDic(dict: dict.element);
                model.isRedIcon = (dict.offset == 2) ? true : false;
                model.isShow = (dict.offset == 1) ? true : false;
                menulist.append(model);
            });
            
            DispatchQueue.main.async {
                
                successCallBack(menulist);
            }
        }
    }
}
