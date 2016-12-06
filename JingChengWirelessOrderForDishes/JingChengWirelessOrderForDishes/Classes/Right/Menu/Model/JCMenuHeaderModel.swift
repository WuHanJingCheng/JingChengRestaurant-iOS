//
//  JCMenuHeaderModel.swift
//  JingChengWirelessOrderForDishes
//
//  Created by zhangxu on 2016/11/23.
//  Copyright © 2016年 zhangxu. All rights reserved.
//

import UIKit

class JCMenuHeaderModel: NSObject {
    
    var img_url: String?;
    var name: String?;
    var category_url: String?;
    var isSelected: Bool = false;
    
    
    // 字典转模型
    class func modelWidthDict(dict: [String: Any]) -> JCMenuHeaderModel {
        
        let model = JCMenuHeaderModel();
        model.img_url = dict["img_url"] as? String ?? "";
        model.name = dict["name"] as? String ?? "";
        model.category_url = dict["category_url"] as? String ?? "";
        return model;
    }

}
