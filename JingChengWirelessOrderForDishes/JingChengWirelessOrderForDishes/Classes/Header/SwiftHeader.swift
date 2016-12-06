//
//  JCSwiftHeader.swift
//  AlphaRestaurant
//
//  Created by zhangxu on 16/9/28.
//  Copyright © 2016年 zhangxu. All rights reserved.
//

import Foundation
import UIKit
import SDWebImage
import MJRefresh

let kScreenWidth = UIScreen.main.bounds.size.width;
let kScreenHeight = UIScreen.main.bounds.size.height;

// 通知名称
let ChangeRedIconNumberNotification = NSNotification.Name("ChangeRedIconNumberNotification");
let ChangeCategoryNotification = NSNotification.Name("ChangeCategoryNotification");


extension UIImage {
    
    class func imageWithName(name: String) -> UIImage? {
        
        let imageName = isiPadPro_12_9_Inch() ? name + "_9_7@2x.png" : name + "_9_7@2x.png";
        let image = UIImage(named: imageName);
        return image;
    }
    
    // 拉伸图片
    class func resizeImage(imageName: String) -> UIImage {
        
        guard let image = UIImage.imageWithName(name: imageName) else {
            return UIImage();
        }
        let imageW = image.size.width * 0.5;
        let imageH = image.size.height * 0.5;
        return image.resizableImage(withCapInsets: UIEdgeInsets.init(top: imageH, left: imageW, bottom: imageH, right: imageW), resizingMode: .tile);
    }
}

// 加载网络图片
extension UIImageView {
    
    // MARK: - 加载网络图片，有占位图
    func zx_setImageWithURL(_ urlString: String?, placeholderImage: UIImage?) -> Void {
        
        guard let urlString = urlString , let placeholderImage = placeholderImage else {
            return;
        }
        let url = URL(string: urlString)!;
        sd_setImage(with: url, placeholderImage: placeholderImage);
    }
    
    // MARK: - 加载网络图片，没有占位图
    func zx_setImageWithURL(_ urlString: String?) -> Void {
        guard let urlString = urlString else {
            return;
        }
        let url = URL(string: urlString);
        sd_setImage(with: url);
    }
}

extension UIButton {
    
    func zx_setBackgroundImageWidthURL(_ urlString: String?, forState: UIControlState) -> Void {
        
        guard let urlString = urlString else {return};
        
        guard let url = URL(string: urlString) else {return};
        
        sd_setBackgroundImage(with: url, for: forState)
    }
    
    func zx_setImageWidthURL(_ urlString: String?, forState: UIControlState) -> Void {
        
        guard let urlString = urlString else {return};
        
        guard let url = URL(string: urlString) else {return};
        
        sd_setImage(with: url, for: forState);
    }
}

// 是否是12.9 inch
func isiPadPro_12_9_Inch() -> Bool {
    
    return (kScreenWidth == 1366.0) ? true : false;
}

// 根据文字返回宽度
func calculateWidth(title: String, fontSize: CGFloat, maxWidth: CGFloat) -> CGFloat? {
    
    var attribute = [String: Any]();
    attribute[NSFontAttributeName] = Font(size: fontSize);
    let width = title.size(attributes: attribute).width;
    return (width < maxWidth) ? width : maxWidth;
}

// 根据文字返回宽度(粗体)
func calculateWidth(title: String, boldFontSize: CGFloat, maxWidth: CGFloat) -> CGFloat? {
    
    var attribute = [String: Any]();
    attribute[NSFontAttributeName] = BoldFont(size: boldFontSize);
    let width = title.size(attributes: attribute).width;
    return (width < maxWidth) ? width : maxWidth;
}

// 根据label 的宽度和字体大小返回label高度
func calculateLabelHeight(labelW: CGFloat, text: String, fontSize: CGFloat, maxHeight: CGFloat) -> CGFloat? {
    
    var attributes = [String: Any]();
    attributes[NSFontAttributeName] = Font(size: fontSize);
    let rect = (text as NSString).boundingRect(with: CGSize(width: labelW, height: 10000), options: .usesLineFragmentOrigin, attributes: attributes, context: nil);
    return (rect.size.height <= maxHeight) ? rect.size.height : maxHeight;
}

// RGB
func RGB(red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor {
    
    let color = UIColor.init(red: red / 255.0, green: green / 255.0, blue: blue / 255.0, alpha: 1);
    return color;
}

// 16进制色码
func RGBWithHexColor(hexColor: Int) -> UIColor {
    
    let red = ((hexColor & 0xFF0000) >> 16);
    let green = ((hexColor & 0xFF00) >> 8);
    let blue = (hexColor & 0xFF);
    let color = RGB(red: CGFloat(red), green: CGFloat(green), blue: CGFloat(blue));
    return color;
}

// 设置字体大小
func Font(size: CGFloat) -> UIFont {
    
    let font = UIFont.systemFont(ofSize: realValue(value: size));
    return font;
}

// 设置粗体
func BoldFont(size: CGFloat) -> UIFont {
    
    let font = UIFont.boldSystemFont(ofSize: realValue(value: size));
    return font;
}

// 真实值
func realValue(value: CGFloat) -> CGFloat {
    
    let realValue = value/1024.0 * kScreenWidth;
    return realValue;
}

// 延迟执行
func delayCallBack(_ time : CGFloat, callBack : (() -> ())?) -> Void {
    
    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + Double(__int64_t(time) * __int64_t(NSEC_PER_SEC)) / Double(NSEC_PER_SEC), execute: {
        
        if let callBack = callBack {
            callBack();
        }
    })
}

// 设置圆角
func setRoundCorner(currentView: UIView, cornerRadii: CGSize) -> Void {
    
    // 设置圆角
    let bezierPath = UIBezierPath.init(roundedRect: currentView.bounds, byRoundingCorners: UIRectCorner.allCorners, cornerRadii: cornerRadii);
    let shapeLayer = CAShapeLayer();
    // 设置大小
    shapeLayer.frame = currentView.bounds;
    // 设置圆形样子
    shapeLayer.path = bezierPath.cgPath;
    currentView.layer.mask = shapeLayer;
}


