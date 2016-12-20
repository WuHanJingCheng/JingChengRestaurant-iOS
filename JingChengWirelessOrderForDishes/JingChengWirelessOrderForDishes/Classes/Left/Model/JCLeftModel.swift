//
//  JCLeftModel.swift
//  JingChengWirelessOrderForDishes
//
//  Created by zhangxu on 2016/11/22.
//  Copyright © 2016年 zhangxu. All rights reserved.
//

import UIKit

class JCLeftModel: NSObject {
    
    var img_url: String?;
    var name: String?;
    var isRedIcon: Bool = false;
    var isShow: Bool = false;
    var number: Int = 0;
    
    // 字典转模型
    class func modelWidthDic(dict: [String: Any]) -> JCLeftModel {
        
        let model = JCLeftModel();
        model.img_url = dict["img_url"] as? String ?? "";
        model.name = dict["name"] as? String ?? "";
        return model;
    }

}
