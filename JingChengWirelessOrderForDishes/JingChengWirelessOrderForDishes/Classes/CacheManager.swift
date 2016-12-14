//
//  CacheManager.swift
//  JingChengWirelessOrderForDishes
//
//  Created by zhangxu on 2016/12/13.
//  Copyright © 2016年 zhangxu. All rights reserved.
//

import UIKit

let kDocument = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)[0];

class CacheManager: NSObject {
    
    // 单粒
    static let shared: CacheManager = CacheManager();
    
    // 初始化
    private override init() {
        super.init();
    }
    
    // MARK: - 缓存result
    func cacheResult(_ result : Any? , fileName : String) -> Void {
        
        let filePath = (kDocument as NSString).appendingPathComponent(fileName);
        let data = try!JSONSerialization.data(withJSONObject: result!, options: JSONSerialization.WritingOptions.prettyPrinted);
        print(filePath);
        NSKeyedArchiver.archiveRootObject(data, toFile: filePath);
    }
    
    // 获取缓存result
    func getResultFromCache(_ fileName : String) -> Any? {
        
        let filePath = (kDocument as NSString).appendingPathComponent(fileName);
        let data = NSKeyedUnarchiver.unarchiveObject(withFile: filePath) as?Data;
        if data == nil {
            return nil;
        }
        let result = try!JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers);
        return result;
    }

}
