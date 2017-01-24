//
//  JCDishModel.swift
//  JingChengWirelessOrderForDishes
//
//  Created by zhangxu on 2016/11/23.
//  Copyright © 2016年 zhangxu. All rights reserved.
//

import UIKit

class JCDishModel: NSObject {
    
    // 服务器字段
    var DishId: Int?;
    var DishName: String?;
    var Price: CGFloat?;
    var Thumbnail: String?;
    var PictureUrlLarge: String?;
    var Recommanded: Bool?;
    var Detail: String?;
    
    
    
    
    
    
    //  自定义字段
    var isAddBtn: Bool = true;
    var number: Int = 0;// 份数
    var serialNumber: Int = 0;// 序号
    var indexPath: IndexPath?;
    
    // 字典转模型
    class func modelWithDict(dict: [String: Any]) -> JCDishModel {
        
        let model = JCDishModel();
        model.DishId = dict["DishId"] as? Int;
        model.DishName = dict["DishName"] as? String;
        model.Price = dict["Price"] as? CGFloat;
        model.Thumbnail = dict["Thumbnail"] as? String;
        model.PictureUrlLarge = dict["PictureUrlLarge"] as? String;
        model.Recommanded = dict["Recommanded"] as? Bool;
        model.Detail = dict["Detail"] as? String;
        return model;
    }

}
