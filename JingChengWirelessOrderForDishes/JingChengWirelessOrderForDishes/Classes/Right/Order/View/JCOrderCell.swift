//
//  JCOrderCell.swift
//  JingChengWirelessOrderForDishes
//
//  Created by zhangxu on 2016/11/24.
//  Copyright © 2016年 zhangxu. All rights reserved.
//

import UIKit

class JCOrderCell: UITableViewCell {

    // 序号
    private lazy var serialNumberLabel: UILabel = {
        let label = UILabel();
        label.text = "1";
        label.font = Font(size: 32/2);
        label.textColor = RGBWithHexColor(hexColor: 0x1a1a1a);
        label.textAlignment = .center;
        return label;
    }();
    
    // 菜图片
    private lazy var dishImage: UIImageView = {
        let dishImage = UIImageView();
        dishImage.image = UIImage.imageWithName(name: "menuList_dish");
        return dishImage;
    }();
    
    // 菜名
    private lazy var dishNameLabel: UILabel = {
        let label = UILabel();
        label.text = "特色烧肉";
        label.font = Font(size: 32/2);
        label.textColor = RGBWithHexColor(hexColor: 0x1a1a1a);
        label.textAlignment = .left;
        return label;
    }();
    
    // 减号按钮
    lazy var minusBtn: UIButton = {
        let button = UIButton(type: .custom);
        button.setImage(UIImage.imageWithName(name: "order_minusBtn"), for: .normal);
        button.addTarget(self, action: #selector(minusBtnClick(button:)), for: .touchUpInside);
        return button;
    }();
    
    // 份数
    lazy var numberLabel: UILabel = {
        let label = UILabel();
        label.text = "1";
        label.textAlignment = .center;
        label.font = Font(size: 32/2);
        label.textColor = RGBWithHexColor(hexColor: 0x1a1a1a);
        return label;
    }();
    
    // 加号按钮
    lazy var plusBtn: UIButton = {
        let button = UIButton(type: .custom);
        button.setImage(UIImage.imageWithName(name: "order_plusBtn"), for: .normal);
        button.addTarget(self, action: #selector(plusBtnClick(button:)), for: .touchUpInside);
        return button;
    }();
    
    // 价格
    private lazy var priceLabel: UILabel = {
        let label = UILabel();
        label.text = "￥00.00";
        label.font = Font(size: 32/2);
        label.textColor = RGBWithHexColor(hexColor: 0x1a1a1a);
        label.textAlignment = .center;
        return label;
    }();
    
    // 下单状态
    private lazy var statusLabel: UILabel = {
        let label = UILabel();
        label.text = "未下单";
        label.font = Font(size: 32/2);
        label.textAlignment = .center;
        label.textColor = RGBWithHexColor(hexColor: 0x1a1a1a);
        return label;
    }();
    
    // 底部线条
    private lazy var bottomLine: UIImageView = {
        let imageView = UIImageView();
        imageView.image = UIImage.imageWithName(name: "order_bottomLine");
        return imageView;
    }();
    
    var model: JCDishModel? {
        didSet {
            // 取出可选类型中的数据
            guard let model = model else {
                return;
            }
            
            // 序号
            serialNumberLabel.text = "\(model.serialNumber)";
            
            // 菜图片
            if let dish_url = model.dish_url {
                dishImage.zx_setImageWithURL(dish_url);
            }
            
            // 菜名
            if let name = model.name {
                dishNameLabel.text = name;
            }
            
            // 价格
            if let price = model.price {
                priceLabel.text = String(format: "￥%.2f", price);
            }
            
            // 份数
            numberLabel.text = "\(model.number)";
            
        }
    }
    
    // 减号按钮的点击回调
    var minusBtnCallBack: ((_ model: JCDishModel) -> ())?;
    // 加号按钮的点击回调
    var plusBtnCallBack: ((_ model: JCDishModel) -> ())?;
    
    
    // MARK: - 初始化
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier);
        
        // 清除cell颜色
        backgroundColor = UIColor.clear;
        
        // 取消选中状态
        selectionStyle = .none;
        
        // 添加序号
        contentView.addSubview(serialNumberLabel);
        
        // 添加菜图片
        contentView.addSubview(dishImage);
        
        // 添加菜名
        contentView.addSubview(dishNameLabel);
        
        // 添加减号按钮
        contentView.addSubview(minusBtn);
        
        // 份数
        contentView.addSubview(numberLabel);
        
        // 加号按钮
        contentView.addSubview(plusBtn);
        
        // 添加价格
        contentView.addSubview(priceLabel);
        
        // 添加下单状态
        contentView.addSubview(statusLabel);
        
        // 添加底部线条
        contentView.addSubview(bottomLine);
        
    }
    
    // 监听减号按钮的点击
    @objc private func minusBtnClick(button: UIButton) -> Void {
        
        if let minusBtnCallBack = minusBtnCallBack, let model = model {
            minusBtnCallBack(model);
        }
    }
    
    // 监听加号按钮的点击
    @objc private func plusBtnClick(button: UIButton) -> Void {
        
        if let plusBtnCallBack = plusBtnCallBack, let model = model {
            plusBtnCallBack(model);
        }
    }
    
    // 设置子控件的frame
    override func layoutSubviews() {
        super.layoutSubviews();
        
        let height = bounds.size.height;
        
        // 设置serialNumberLabel 的frame
        let serialNumberLabelX = realValue(value: 0);
        let serialNumberLabelY = realValue(value: 20/2);
        let serialNumberLabelW = realValue(value: 80/2);
        let serialNumberLabelH = realValue(value: 100/2);
        serialNumberLabel.frame = CGRect(x: serialNumberLabelX, y: serialNumberLabelY, width: serialNumberLabelW, height: serialNumberLabelH);
        
        // 设置dishImage 的frame
        let dishImageX = serialNumberLabel.frame.maxX + realValue(value: 150/2);
        let dishImageY = serialNumberLabelY;
        let dishImageW = realValue(value: 100/2);
        let dishImageH = dishImageW;
        dishImage.frame = CGRect(x: dishImageX, y: dishImageY, width: dishImageW, height: dishImageH);
        
        // 设置dishNameLabel 的frame
        let dishNameLabelX = dishImage.frame.maxX + realValue(value: 20/2);
        let dishNameLabelY = serialNumberLabelY;
        let dishNameLabelW = realValue(value: 450/2);
        let dishNameLabelH = serialNumberLabelH;
        dishNameLabel.frame = CGRect(x: dishNameLabelX, y: dishNameLabelY, width: dishNameLabelW, height: dishNameLabelH);
        
        // 设置minusBtn 的frame
        let minusBtnX = dishNameLabel.frame.maxX + realValue(value: 50/2);
        let minusBtnW = realValue(value: 48/2);
        let minusBtnH = minusBtnW;
        let minusBtnY = (height - minusBtnH)/2;
        minusBtn.frame = CGRect(x: minusBtnX, y: minusBtnY, width: minusBtnW, height: minusBtnH);
        
        // 设置numberLabel 的frame
        let numberLabelX = minusBtn.frame.maxX + realValue(value: 5/2);
        let numberLabelY = minusBtnY;
        let numberLabelW = realValue(value: 60/2);
        let numberLabelH = minusBtnH;
        numberLabel.frame = CGRect(x: numberLabelX, y: numberLabelY, width: numberLabelW, height: numberLabelH);
        
        // 设置plusBtn 的frame
        let plusBtnX = numberLabel.frame.maxX + realValue(value: 5/2);
        let plusBtnY = minusBtnY;
        let plusBtnW = minusBtnW;
        let plusBtnH = plusBtnW;
        plusBtn.frame = CGRect(x: plusBtnX, y: plusBtnY, width: plusBtnW, height: plusBtnH);
        
        // 设置priceLabel 的frame
        let priceLabelX = plusBtn.frame.maxX + realValue(value: 120/2);
        let priceLabelY = serialNumberLabelY;
        let priceLabelW = realValue(value: 100);
        let priceLabelH = serialNumberLabelH;
        priceLabel.frame = CGRect(x: priceLabelX, y: priceLabelY, width: priceLabelW, height: priceLabelH);
        
        // 设置statusLabel 的frame
        let statusLabelX = priceLabel.frame.maxX + realValue(value: 140/2);
        let statusLabelY = serialNumberLabelY;
        let statusLabelW = realValue(value: 100/2);
        let statusLabelH = serialNumberLabelH;
        statusLabel.frame = CGRect(x: statusLabelX, y: statusLabelY, width: statusLabelW, height: statusLabelH);
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
