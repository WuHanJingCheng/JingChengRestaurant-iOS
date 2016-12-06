//
//  JCDishModel.swift
//  JingChengWirelessOrderForDishes
//
//  Created by zhangxu on 2016/11/23.
//  Copyright © 2016年 zhangxu. All rights reserved.
//

import UIKit

class JCDishModel: NSObject {
    
    var dish_url: String?;
    var name: String?;
    var price: CGFloat?;
    var dish_id: Int?;
    var width: CGFloat?;
    var height: CGFloat?;
    var isAddBtn: Bool = true;
    var number: Int = 0;// 份数
    var serialNumber: Int = 0;// 序号
    var indexPath: IndexPath?;
    
    // 字典转模型
    class func modelWithDict(dict: [String: Any]) -> JCDishModel {
        
        let model = JCDishModel();
        model.dish_id = dict["dish_id"] as? Int ?? 0;
        model.dish_url = dict["dish_url"] as? String ?? "";
        model.name = dict["name"] as? String ?? "";
        model.price = dict["price"] as? CGFloat ?? 0.0;
        model.width = dict["width"] as? CGFloat ?? 0.0;
        model.height = dict["height"] as? CGFloat ?? 0.0;
        return model;
    }

}
