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
    
    // 选中小三角
    private lazy var triangleView: UIImageView = {
        let triangleView = UIImageView();
        triangleView.image = UIImage.imageWithName(name: "left_cell_triangleView");
        return triangleView;
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

    var model: JCLeftModel? {
        didSet {
            // 取出可选类型中的数据
            guard let model = model else {
                return;
            }
            
            // 购物车显示红色数字角标
            redIcon.isHidden = !model.isRedIcon;
            
            // 选中显示三角
            triangleView.isHidden = !model.isTriangle;
            
            // 修改份数
            redIcon.setTitle("\(model.number)", for: .normal);
            
            let title = redIcon.title(for: .normal) ?? "0";
            if title == "0" {
                redIcon.isHidden = true;
            }
            
            // 加载图片
            if let img_url = model.img_url {
                icon.zx_setImageWithURL(img_url);
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
        
        // 添加icon
        contentView.addSubview(icon);
        
        // 添加name
        contentView.addSubview(nameLabel);
        
        // 添加triangleView 
        contentView.addSubview(triangleView);
        
        // 添加redIcon 
        icon.addSubview(redIcon);
        
    }
    
    // 设置子控件的frame
    override func layoutSubviews() {
        super.layoutSubviews();
        
        let width = bounds.size.width;
        let height = bounds.size.height;
      
        
        // 设置icon的frame
        let iconCenterX = width/2;
        let iconCenterY = realValue(value: 100/2 + 100/2/2);
        let iconW = realValue(value: 100/2);
        let iconH = iconW;
        icon.center = CGPoint(x: iconCenterX, y: iconCenterY);
        icon.bounds = CGRect(x: 0, y: 0, width: iconW, height: iconH);
        
        // 设置name的frame
        let nameLabelX = CGFloat(0);
        let nameLabelY = icon.frame.maxY + realValue(value: 15/2);
        let nameLabelW = width;
        let nameLabelH = realValue(value: 28/2);
        nameLabel.frame = CGRect(x: nameLabelX, y: nameLabelY, width: nameLabelW, height: nameLabelH);
        
        // 设置triangleView 的frame
        let triangleViewW = realValue(value: 18/2);
        let triangleViewH = realValue(value: 32/2);
        let triangleViewX = width - triangleViewW;
        let triangleViewY = height/2 + triangleViewH/2;
        triangleView.frame = CGRect(x: triangleViewX, y: triangleViewY, width: triangleViewW, height: triangleViewH);
        
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
