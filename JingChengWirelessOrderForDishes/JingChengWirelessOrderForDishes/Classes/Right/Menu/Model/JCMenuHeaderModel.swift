//
//  JCMenuHeaderModel.swift
//  JingChengWirelessOrderForDishes
//
//  Created by zhangxu on 2016/11/23.
//  Copyright © 2016年 zhangxu. All rights reserved.
//

import UIKit

class JCMenuHeaderModel: NSObject {
    
    
    // 服务器字段
    var MenuId: Int?;
    var MenuName: String?;
    var PictureUrl: String?;
    var PictureUrlSelected: String?;
    var DishUrl: String?;
    
    
    // 自定义字段
    var isSelected: Bool = false;
    
    
    // 字典转模型
    class func modelWidthDict(dict: [String: Any]) -> JCMenuHeaderModel {
        
        let model = JCMenuHeaderModel();
        model.MenuId = dict["MenuId"] as? Int;
        model.MenuName = dict["MenuName"] as? String;
        model.PictureUrl = dict["PictureUrl"] as? String;
        model.PictureUrlSelected = dict["PictureUrlSelected"] as? String;
        model.DishUrl = dict["DishUrl"] as? String;
        return model;
    }

}
