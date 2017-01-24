//
//  JCLeftCell.swift
//  JingChengWirelessOrderForDishes
//
//  Created by zhangxu on 2016/11/22.
//  Copyright © 2016年 zhangxu. All rights reserved.
//

import UIKit

fileprivate let redIconPadding = realValue(value: 8/2);

class JCLeftCell: UITableViewCell {
    
    // 背景
    private lazy var background: UIImageView = {
        let background = UIImageView();
        background.isUserInteractionEnabled = true;
        return background;
    }();
    
    // icon
    private lazy var icon: UIImageView = {
        let icon = UIImageView();
        return icon;
    }();
    
    // name
    private lazy var nameLabel: UILabel = {
        let label = UILabel();
        label.font = Font(size: 28/2);
        label.textColor = RGBWithHexColor(hexColor: 0x191919);
        label.textAlignment = .center;
        return label;
    }();

    // 红色数字图标
    private lazy var redIcon: UIButton = {
        let button = UIButton(type: .custom);
        button.setBackgroundImage(UIImage.resizeImage(imageName: "left_cell_redIcon"), for: .normal);
        button.contentEdgeInsets = UIEdgeInsets(top: redIconPadding, left: redIconPadding, bottom: redIconPadding, right: redIconPadding);
        button.setTitle("0", for: .normal);
        button.setTitleColor(UIColor.white, for: .normal);
        button.titleLabel?.font = Font(size: 24/2);
        button.isHidden = true;
        return button;
    }();
    
    var isShow: Bool? {
        didSet {
            // 获取可选类型中的数据
            guard let isShow = isShow else {
                return;
            }
            
            if isShow == true {
                background.image = UIImage.imageWithName(name: "left_cell_background");
                nameLabel.textColor = RGBWithHexColor(hexColor: 0xf5aa3f);
            } else {
                background.image = UIImage.imageWithName(name: "");
                nameLabel.textColor = RGBWithHexColor(hexColor: 0x191919);
            }
        }
    }
    

    var model: JCLeftModel? {
        didSet {
            // 取出可选类型中的数据
            guard let model = model else {
                return;
            }
            
            // 购物车显示红色数字角标
            redIcon.isHidden = !model.isRedIcon;
            
            // 是否选中背景
            isShow = model.isShow;
           
            // 修改份数
            redIcon.setTitle("\(model.number)", for: .normal);
            
            let title = redIcon.title(for: .normal) ?? "0";
            if title == "0" {
                redIcon.isHidden = true;
            }
            
            // 加载图片
            if let picture = model.picture {
                icon.image = UIImage.imageWithName(name: picture);
            }
            // 加载文本
            if let name = model.name {
                nameLabel.text = name;
            }
            
            // 更新frame
            layoutIfNeeded();
            setNeedsLayout();
            
        }
    }
    
    // MARK: - 初始化
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier);
        
        // 清除cell颜色
        backgroundColor = UIColor.clear;
        
        // 取消cell的选中样式
        selectionStyle = .none;
        
        // 添加背景
        contentView.addSubview(background);
        
        // 添加icon
        background.addSubview(icon);
        
        // 添加name
        background.addSubview(nameLabel);
    
        
        // 添加redIcon 
        icon.addSubview(redIcon);
        
    }
    
    // 改变份数
    func changeRedIconNumber(model: JCLeftModel) -> () {
        
        // 购物车显示红色数字角标
        redIcon.isHidden = !model.isRedIcon;
        
        // 修改份数
        redIcon.setTitle("\(model.number)", for: .normal);
        
        let title = redIcon.title(for: .normal) ?? "0";
        if title == "0" {
            redIcon.isHidden = true;
        }
        
        // 更新frame
        layoutIfNeeded();
        setNeedsLayout();
    }
    
    // 改变选中状态
    func changeSelectedPosition(model: JCLeftModel) -> Void {
        
        // 是否选中背景
        isShow = model.isShow;
 
    }
    
    // 设置子控件的frame
    override func layoutSubviews() {
        super.layoutSubviews();
        
        let width = bounds.size.width;
        let height = bounds.size.height;
      
        
        // 设置背景的frame
        let backgroundW = width;
        let backgroundH = realValue(value: 160/2);
        let backgroundX = realValue(value: 0);
        let backgroundY = (height - backgroundH)/2;
        background.frame = CGRect(x: backgroundX, y: backgroundY, width: backgroundW, height: backgroundH);
        
        // 设置icon的frame
        let iconCenterX = backgroundW/2;
        let iconCenterY = realValue(value: 17/2/2 + 100/2/2);
        let iconW = realValue(value: 100/2);
        let iconH = iconW;
        icon.center = CGPoint(x: iconCenterX, y: iconCenterY);
        icon.bounds = CGRect(x: 0, y: 0, width: iconW, height: iconH);
        
        // 设置name的frame
        let nameLabelX = CGFloat(0);
        let nameLabelY = icon.frame.maxY + realValue(value: 15/2);
        let nameLabelW = backgroundW;
        let nameLabelH = realValue(value: 28/2);
        nameLabel.frame = CGRect(x: nameLabelX, y: nameLabelY, width: nameLabelW, height: nameLabelH);
        
        
        // 设置红色角标
        let title = redIcon.title(for: .normal) ?? "0";
        var redIconW: CGFloat = realValue(value: 36/2);
        if title.characters.count == 1 {
            redIconW = realValue(value: 36/2);
        } else {
            var attribute = [String: Any]();
            attribute[NSFontAttributeName] = Font(size: 24/2);
            redIconW = title.size(attributes: attribute).width + redIconPadding * 2;
        }
        let redIconH = realValue(value: 36/2);
        let redIconX = iconW - redIconW/1.5;
        let redIconY = realValue(value: 0);
        redIcon.frame = CGRect(x: redIconX, y: redIconY, width: redIconW, height: redIconH);
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
