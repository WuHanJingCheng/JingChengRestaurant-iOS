//
//  JCMenuCell.swift
//  JingChengWirelessOrderForDishes
//
//  Created by zhangxu on 2016/11/23.
//  Copyright © 2016年 zhangxu. All rights reserved.
//

import UIKit

class JCMenuCell: UICollectionViewCell {
    
    
    // 背景
    private lazy var background: UIImageView = {
        let background = UIImageView();
        background.image = UIImage.imageWithName(name: "menu_cell_background");
        background.isUserInteractionEnabled = true;
        background.clipsToBounds = true;
        return background;
    }();
    
    // 菜图片
    private lazy var dishImage: UIImageView = {
        let dishImage = UIImageView();
        dishImage.isUserInteractionEnabled = true;
        return dishImage;
    }();
    
    // 菜名
    private lazy var dishNameLabel:UILabel = {
        let label = UILabel();
        label.font = Font(size: 36/2);
        label.textAlignment = .center;
        label.textColor = RGBWithHexColor(hexColor: 0x1a1a1a);
        label.text = "菜名";
        return label;
    }();
    
    // 价格
    private lazy var priceLabel: UILabel = {
        let label = UILabel();
        label.text = "￥19.99";
        label.font = Font(size: 36/2);
        label.textColor = RGBWithHexColor(hexColor: 0xd18313);
        label.textAlignment = .center;
        return label;
    }();
    
    // 减号按钮
    lazy var minusBtn: UIButton = {
        let button = UIButton(type: .custom);
        button.setImage(UIImage.imageWithName(name: "menu_minusBtn"), for: .normal);
        button.isHidden = true;
        button.addTarget(self, action: #selector(minusBtnClick(button:)), for: .touchUpInside);
        return button;
    }();
    
    // 份数
    lazy var numberLabel: UILabel = {
        let label = UILabel();
        label.text = "0";
        label.textAlignment = .center;
        label.isHidden = true;
        label.font = Font(size: 32/2);
        label.textColor = RGBWithHexColor(hexColor: 0x1a1a1a);
        return label;
    }();
    
    // 加号按钮
    lazy var plusBtn: UIButton = {
        let button = UIButton(type: .custom);
        button.setImage(UIImage.imageWithName(name: "menu_plusBtn"), for: .normal);
        button.isHidden = true;
        button.addTarget(self, action: #selector(plusBtnClick(button:)), for: .touchUpInside);
        return button;
    }();
    
    // 加入按钮
    lazy var addBtn: UIButton = {
        let button = UIButton(type: .custom);
        button.setBackgroundImage(UIImage.imageWithName(name: "menu_addBtn"), for: .normal);
        button.addTarget(self, action: #selector(addBtnClick(button:)), for: .touchUpInside);
        return button;
    }();
    
    // 新品
    private lazy var hotBtn: UIButton = {
        let hotBtn = UIButton(type: .custom);
        hotBtn.setBackgroundImage(UIImage.imageWithName(name: "menu_hotBtn_background"), for: .normal);
        hotBtn.setTitle("新品", for: .normal);
        hotBtn.titleLabel?.font = Font(size: 28/2);
        hotBtn.setTitleColor(RGBWithHexColor(hexColor: 0xf4f4f4), for: .normal);
        hotBtn.isUserInteractionEnabled = true;
        return hotBtn;
    }();

    
    // 隐藏加入按钮，显示加减号按钮
    var addBtnCallBack: ((_ model: JCDishModel) -> ())?;
    // 增加份数
    var plucBtnCallBack: ((_ model: JCDishModel) -> ())?;
    // 减少份数
    var minusBtnCallBack: ((_ model: JCDishModel) -> ())?;
    // 点击图片弹窗
    var clickDishImageCallBack: ((_ model: JCDishModel) -> ())?;
    
    var model: JCDishModel? {
        didSet {
            // 获取可选类型中的数据
            guard let model = model else {
                return;
            }
            
            // 根据模型设置显示和隐藏
            if model.isAddBtn == true {
                addBtn.isHidden = false;
                minusBtn.isHidden = true;
                numberLabel.isHidden = true;
                plusBtn.isHidden = true;
            } else {
                addBtn.isHidden = true;
                minusBtn.isHidden = false;
                numberLabel.isHidden = false;
                plusBtn.isHidden = false;
            }
            
            numberLabel.text = "\(model.number)";
            // 如果份数为0，显示加入按钮，隐藏加减号按钮
            if numberLabel.text == "0" {
                addBtn.isHidden = false;
                minusBtn.isHidden = true;
                numberLabel.isHidden = true;
                plusBtn.isHidden = true;
            }
           
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
        }
    }
    
    deinit {
        print("JCMenuCell 被释放了");
    }
    
    // 初始化
    override init(frame: CGRect) {
        super.init(frame: frame);

        
        // 添加背景
        contentView.addSubview(background);
       
        // 添加菜图片
        background.addSubview(dishImage);
        
        // 添加新品
        dishImage.addSubview(hotBtn);
        
        // 添加菜名
        background.addSubview(dishNameLabel);
        
        // 添加菜价格
        background.addSubview(priceLabel);
        
        // 添加加号按钮
        background.addSubview(plusBtn);
        
        // 添加份数
        background.addSubview(numberLabel);
        
        // 添加减号按钮
        background.addSubview(minusBtn);
        
        // 添加addBtn 
        background.addSubview(addBtn);
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapAction(tap:)));
        dishImage.addGestureRecognizer(tap);
    }
    
    // 轻拍手势，点击图片弹窗
    @objc private func tapAction(tap: UITapGestureRecognizer) -> Void {
        
        if let clickDishImageCallBack = clickDishImageCallBack, let model = model {
            clickDishImageCallBack(model);
        }
    }
    
    // MARK: - 点击加入按钮改变份数
    @objc private func addBtnClick(button: UIButton) -> Void {
        
        if let addBtnCallBack = addBtnCallBack, let model = model {
            addBtnCallBack(model);
        }
    }
    
    // 监听加号按钮点击
    @objc private func plusBtnClick(button: UIButton) -> Void {
        
        if let plucBtnCallBack = plucBtnCallBack, let model = model {
            plucBtnCallBack(model);
        }
    }
    
    // 监听减号按钮的点击
    @objc private func minusBtnClick(button: UIButton) -> Void {
        
        if let minusBtnCallBack = minusBtnCallBack, let model = model {
            minusBtnCallBack(model);
        }
    }
    
    // 设置子控件的frame
    override func layoutSubviews() {
        super.layoutSubviews();
        
        let width = bounds.size.width;
        
        // 设置背景的frame
        background.frame = bounds;
        
        // 设置dishImage 的frame
        let dishImageX = (width - realValue(value: 406/2))/2;
        let dishImageY = realValue(value: 20/2);
        let dishImageW = realValue(value: 406/2);
        let dishImageH = realValue(value: 406/2);
        dishImage.frame = CGRect(x: dishImageX, y: dishImageY, width: dishImageW, height: dishImageH);
        
        // 设置hotBtn 的frame
        let hotBtnW = realValue(value: 96/2);
        let hotBtnH = realValue(value: 42/2);
        let hotBtnX = realValue(value: 22/2);
        let hotBtnY = dishImageH - hotBtnH;
        hotBtn.frame = CGRect(x: hotBtnX, y: hotBtnY, width: hotBtnW, height: hotBtnH);
        
        // 设置dishNameLabel 的frame
        let dishNameLabelX = dishImageX;
        let dishNameLabelY = dishImage.frame.maxY + realValue(value: 30/2);
        let dishNameLabelW = dishImageW;
        let dishNameLabelH = realValue(value: 36/2);
        dishNameLabel.frame = CGRect(x: dishNameLabelX, y: dishNameLabelY, width: dishNameLabelW, height: dishNameLabelH);
        
        // 设置price的frame
        let priceLabelX = dishImageX;
        let priceLabelY = dishNameLabel.frame.maxY + realValue(value: 20/2);
        let priceLabelW = dishImageW;
        let priceLabelH = realValue(value: 36/2);
        priceLabel.frame = CGRect(x: priceLabelX, y: priceLabelY, width: priceLabelW, height: priceLabelH);
        
        // 设置份数的frame
        let numberLabelCenterX = width/2;
        let numberLabelCenterY = priceLabel.frame.maxY + realValue(value: 17/2 + 48/2/2);
        let numberLabelW = realValue(value: 80/2);
        let numberLabelH = realValue(value: 48/2);
        numberLabel.center = CGPoint(x: numberLabelCenterX, y: numberLabelCenterY);
        numberLabel.bounds = CGRect(x: 0, y: 0, width: numberLabelW, height: numberLabelH);
        
        // 设置减号按钮的frame
        let minusBtnX = numberLabel.frame.minX - realValue(value: 48/2);
        let minusBtnY = numberLabel.frame.minY;
        let minusBtnW = realValue(value: 48/2);
        let minusBtnH = minusBtnW;
        minusBtn.frame = CGRect(x: minusBtnX, y: minusBtnY, width: minusBtnW, height: minusBtnH);
        
        // 设置加号按钮的frame
        let plusBtnX = numberLabel.frame.maxX;
        let plusBtnY = minusBtnY;
        let plusBtnW = minusBtnW;
        let plusBtnH = plusBtnW;
        plusBtn.frame = CGRect(x: plusBtnX, y: plusBtnY, width: plusBtnW, height: plusBtnH);
        
        // 设置加入按钮的frame
        let addBtnCenterX = width/2;
        let addBtnCenterY = priceLabel.frame.maxY + realValue(value: 17/2 + 48/2/2);
        let addBtnW = realValue(value: 144/2);
        let addBtnH = realValue(value: 48/2);
        addBtn.center = CGPoint(x: addBtnCenterX, y: addBtnCenterY);
        addBtn.bounds = CGRect(x: 0,  y: 0, width: addBtnW, height: addBtnH);
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
