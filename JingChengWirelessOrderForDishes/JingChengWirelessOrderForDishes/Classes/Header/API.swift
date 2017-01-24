//
//  API.swift
//  JingChengWirelessOrderForDishes
//
//  Created by zhangxu on 2016/11/24.
//  Copyright © 2016年 zhangxu. All rights reserved.
//

import Foundation

/*---------------接口列表------------------- */

// 左边菜单列表
let leftMenuListAPI = "http://ac-otjqboap.clouddn.com/8e76e15a3ac53fe81588.json";

// 分类列表
func submenulistUrl(restaurantId: Int) -> String {
    
    let url = "https://jingchengrestaurant.azurewebsites.net/api/Restaurant/\(restaurantId)/menu";
    return url;
}




/************菜品的URL**************/
func dishlistUrl(MenuId: Int) -> String {
    
    let url = "https://jingchengrestaurant.azurewebsites.net/api/menu/\(MenuId)/dish";
    return url;
}
