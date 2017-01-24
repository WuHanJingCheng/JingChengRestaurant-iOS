//
//  JCMenuHeaderCell.swift
//  JingChengWirelessOrderForDishes
//
//  Created by zhangxu on 2016/11/23.
//  Copyright © 2016年 zhangxu. All rights reserved.
//

import UIKit

let margin = realValue(value: 28/2);

class JCMenuHeaderCell: UICollectionViewCell {
    
    
    // DIYButton
    lazy var menuHeaderBtn: DIYButton = {
        let button = DIYButton(type: .custom);
        button.setBackgroundImage(UIImage.resizeImage(imageName: "menuHeader_btn_background_normal"), for: .normal);
        button.setBackgroundImage(UIImage.resizeImage(imageName: "menuHeader_btn_background_selected"), for: .selected);
        button.clipsToBounds = true;
        button.addTarget(self, action: #selector(menuHeaderBtnClick(button:)), for: .touchUpInside);
        button.contentEdgeInsets = UIEdgeInsets.init(top: margin, left: margin, bottom: margin, right: margin);
        return button;
    }();
    
    deinit {
        print("JCMenuHeaderCell 被释放了");
    }
    
    var menuHeaderModel: JCMenuHeaderModel? {
        didSet {
            // 取出可选类型中的数据
            guard let menuHeaderModel = menuHeaderModel else {
                return;
            }
            
            menuHeaderBtn.isSelected = menuHeaderModel.isSelected;
            
            if let PictureUrl = menuHeaderModel.PictureUrl {
                menuHeaderBtn.zx_setImageWidthURL(PictureUrl, forState: .normal);
            }
            
            if let PictureUrlSelected = menuHeaderModel.PictureUrlSelected {
                menuHeaderBtn.zx_setImageWidthURL(PictureUrlSelected, forState: .selected);
            }
            
            if menuHeaderModel.isSelected == false {
                menuHeaderBtn.setTitleColor(RGBWithHexColor(hexColor: 0x343434), for: .normal);
            } else {
                menuHeaderBtn.setTitleColor(RGBWithHexColor(hexColor: 0xf8c67e), for: .normal);
            }
            
            if let MenuName = menuHeaderModel.MenuName {
                menuHeaderBtn.setTitle(MenuName, for: .normal);
            }
        }
    }
    
    // 更新选中状态
    func updateSelectedStatus(model: JCMenuHeaderModel) -> Void {
        
        menuHeaderBtn.isSelected = model.isSelected;
        
        if model.isSelected == false {
            menuHeaderBtn.setTitleColor(RGBWithHexColor(hexColor: 0x343434), for: .normal);
        } else {
            menuHeaderBtn.setTitleColor(RGBWithHexColor(hexColor: 0xf8c67e), for: .normal);
        }
    }
    
    // 更新cell状态
    var changeOtherBtnStatusCallBack: ((_ model: JCMenuHeaderModel) -> ())?;
   
    
    // 点击header 改变button状态
    @objc private func menuHeaderBtnClick(button: UIButton) -> Void {
        
        if let changeOtherBtnStatusCallBack = changeOtherBtnStatusCallBack, let menuHeaderModel = menuHeaderModel {
            changeOtherBtnStatusCallBack(menuHeaderModel);
        }
    }
    
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        
        let _ = self.subviews.map({
            (element) -> (UIView) in
            if element.frame.contains(self.convert(point, to: menuHeaderBtn)) {
                return element;
            } else {
                return self;
            }
        });
        
        return self.point(inside: point, with: event) ? menuHeaderBtn : nil;
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame);
        
        // 清除cell颜色
        backgroundColor = UIColor.clear;
        
        // 添加button
        contentView.addSubview(menuHeaderBtn);
        
    }
    
    // 设置按钮的frame
    override func layoutSubviews() {
        super.layoutSubviews();
        
        let height = bounds.size.height;
        let width = bounds.size.width;
        
        let menuHeaderBtnX = realValue(value: 10/2);
        let menuHeaderBtnY = realValue(value: 0);
        let menuHeaderBtnW = width - menuHeaderBtnX * CGFloat(2);
        let menuHeaderBtnH = height;
        menuHeaderBtn.frame = CGRect(x: menuHeaderBtnX, y: menuHeaderBtnY, width: menuHeaderBtnW, height: menuHeaderBtnH);
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
