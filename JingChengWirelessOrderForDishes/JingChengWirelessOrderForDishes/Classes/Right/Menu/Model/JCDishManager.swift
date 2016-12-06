//
//  JCDishManager.swift
//  JingChengOrderMeal
//
//  Created by zhangxu on 2016/11/8.
//  Copyright © 2016年 zhangxu. All rights reserved.
//

import UIKit

class JCDishManager: NSObject {
    
    // 创建单粒
    static let shared: JCDishManager = JCDishManager();
 
    // 数组
    lazy var dishs: [JCDishModel] = [JCDishModel]();
    
    // 桌号
    var tableNumber: String?
    
    // MARK: - 初始化
    private override init() {
        super.init();
    }
    
    // 存桌号
    class func storeTableNumber(tableNumber: String) -> Void {
        
        let mgr = JCDishManager.shared;
        mgr.tableNumber = tableNumber;
    }
    
    // 获取桌号
    class func getTableNumber() -> String {
        
        let tableNumber = JCDishManager.shared.tableNumber ?? "";
        return tableNumber;
    }
    
    // 增加菜
    class func addDish(model: JCDishModel) -> Void {
        let mgr = JCDishManager.shared;
        if mgr.dishs.count == 0 {
            model.number = 1;
            mgr.dishs.append(model);
        } else {
            
            for (index,tempModel) in mgr.dishs.enumerated() {
                if tempModel.dish_id == model.dish_id {
                    mgr.dishs.remove(at: index);
                    tempModel.number += 1;
                    tempModel.number = (tempModel.number < 100) ? tempModel.number : 99;
                    mgr.dishs.append(tempModel);
                    return;
                }
            }
            
            model.number = 1;
            mgr.dishs.append(model);
        }
    }
    
    // 减少菜
    class func reduceDish(model: JCDishModel) -> Void {
        let mgr = JCDishManager.shared;
        if mgr.dishs.count == 0 {
            return;
        }
        for (index, tempModel) in mgr.dishs.enumerated() {
            if tempModel.dish_id == model.dish_id {
                tempModel.number = (tempModel.number > 0) ? (tempModel.number - 1) : 0;
                if tempModel.number == 0 {
                    mgr.dishs.remove(at: index);
                }
                return;
            }
        }
    }
    
    // 查找菜
    class func findDish(model: JCDishModel) -> JCDishModel? {
        
        let mgr = JCDishManager.shared;
        if mgr.dishs.count == 0 {
            return nil;
        }
        for tempModel in mgr.dishs {
            if tempModel.dish_id == model.dish_id {
                return tempModel;
            }
        }
        
        return nil;
    }
    
    // 删除一道菜
    class func deleteDish(model: JCDishModel) -> Void {
        
        var dishs = JCDishManager.shared.dishs;
        if dishs.count == 0 {return};
        
        for (index,tempModel) in dishs.enumerated() {
            if tempModel.dish_id == model.dish_id {
                dishs.remove(at: index);
            }
        }
        
        JCDishManager.shared.dishs.removeAll();
        JCDishManager.shared.dishs += dishs;
    }
    
    // 计算总价格
    class func totalPrice() -> CGFloat {
        
        var amount: CGFloat = 0.0;
        let dishs = JCDishManager.shared.dishs;
        for model in dishs {
            amount += (model.price ?? 0.0) * CGFloat(model.number);
        }
        return amount;
    }
    
    // 统计总份数
    class func totalNumber() -> Int {
        
        var total: Int = 0;
        let dishs = JCDishManager.shared.dishs;
        for model in dishs {
            total += model.number;
        }
        return total;
    }
    
    // 删除全部
    class func deleteAll() -> Void {
        
        JCDishManager.shared.dishs.removeAll();
    }

}
