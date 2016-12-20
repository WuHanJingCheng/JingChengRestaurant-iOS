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
    class func startAnimation(targetView: UIView) -> Void {
        // 动画执行前
        let subView = targetView.subviews[0].subviews[0];
        subView.transform = CGAffineTransform(scaleX: 0.5, y: 0.5);
        targetView.alpha = 0;
        
        // 动画执行后
        UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0.7, options: .beginFromCurrentState, animations: {
            _ in
            
            subView.transform = CGAffineTransform.init(scaleX: 1, y: 1);
            targetView.alpha = 1;
            
            }, completion: nil);
        
    }
    
    // 停止动画
    class func stopAnimation(targetView: UIView) -> Void {
        
        let subView = targetView.subviews[0].subviews[0];
        UIView.animate(withDuration: 0.5, animations: { [weak targetView]
            _ in
            
            subView.transform = CGAffineTransform(scaleX: 0, y: 0);
            targetView?.alpha = 0;
            
        }, completion: { [weak targetView]
            _ in
            
            // 移除目标视图
            targetView?.removeFromSuperview();
        })
    }

}
