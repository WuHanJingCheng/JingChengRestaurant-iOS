//
//  ZXAnimation.swift
//  JingChengWirelessOrderForDishes
//
//  Created by zhangxu on 2016/12/13.
//  Copyright © 2016年 zhangxu. All rights reserved.
//

import UIKit

class ZXAnimation: NSObject {
    
    // 启动动画
    class func startAnimation(targetView: JCDishDetailView) -> Void {
        // 动画执行前
        targetView.whiteBackground.transform = CGAffineTransform(scaleX: 0.5, y: 0.5);
        targetView.alpha = 0;
        
        // 动画执行后
        UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0.7, options: .beginFromCurrentState, animations: { [weak targetView]
            _ in
            
            targetView?.whiteBackground.transform = CGAffineTransform.init(scaleX: 1, y: 1);
            targetView?.alpha = 1;
            
            }, completion: nil);
        
    }
    
    // 停止动画
    class func stopAnimation(targetView: JCDishDetailView) -> Void {
        
        UIView.animate(withDuration: 0.2, animations: { [weak targetView]
            _ in
            
            targetView?.whiteBackground.transform = CGAffineTransform(scaleX: 1, y: 1);
            targetView?.alpha = 0;
            
        }, completion: { [weak targetView]
            _ in
            
            // 移除目标视图
            targetView?.removeFromSuperview();
        })
    }

}
