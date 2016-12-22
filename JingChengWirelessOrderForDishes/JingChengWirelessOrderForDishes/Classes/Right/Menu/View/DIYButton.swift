//
//  DIYButton.swift
//  JingChengWirelessOrderForDishes
//
//  Created by zhangxu on 2016/11/23.
//  Copyright © 2016年 zhangxu. All rights reserved.
//

import UIKit


class DIYButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame);
        
        titleLabel?.font = Font(size: 32/2);
        setTitleColor(RGBWithHexColor(hexColor: 0x343434), for: .normal);
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
   
    override func imageRect(forContentRect contentRect: CGRect) -> CGRect {
        
        let image = self.image(for: .normal);
        guard let imageSize = image?.size else {return .zero};
        let imageX = realValue(value: 15/2);
        let imageY = (bounds.size.height - imageSize.height/2)/2;
        let imageW = imageSize.width/2;
        let imageH = imageSize.height/2;
        let rect = CGRect(x: imageX,y : imageY, width: imageW, height: imageH);
        return rect;

    }

    override func titleRect(forContentRect contentRect: CGRect) -> CGRect {
        
        let image = self.image(for: .normal);
        guard let imageSize = image?.size else {return .zero};
        guard let title = self.title(for: .normal) else {return .zero};
        let titleWidth = calculateWidth(title: title, fontSize: 32/2, maxWidth: realValue(value: 300)) ?? 0;
        let titleHeight = realValue(value: 32/2);
        let titleX = realValue(value: 30/2) + imageSize.width/2;
        let titleY = (bounds.size.height - titleHeight)/2;
        let rect = CGRect(x: titleX, y: titleY, width: titleWidth, height: titleHeight);
        return rect;
    }

}
