//
//  JCDishDetailView.swift
//  JingChengOrderMeal
//
//  Created by zhangxu on 2016/11/7.
//  Copyright © 2016年 zhangxu. All rights reserved.
//

import UIKit

class JCDishDetailView: UIView {
    
    // 测试
    deinit {
        print("JCDishDetailView 被释放了");
    }
    
    // 背景
    private lazy var background: UIImageView = {
        let background = UIImageView();
        background.image = UIImage.imageWithName(name: "dishDetailView_background");
        background.isUserInteractionEnabled = true;
        return background;
    }();
    
    // 白布
    lazy var whiteBackground: UIImageView = {
        let whiteBackground = UIImageView();
        whiteBackground.image = UIImage.imageWithName(name: "dishDetailView_whitebackground");
        whiteBackground.isUserInteractionEnabled = true;
        return whiteBackground;
    }();
    
    // 消失按钮
    lazy var deleteBtn: UIButton = {
        let button = UIButton(type: .custom);
        button.setImage(UIImage.imageWithName(name: "dishDetail_deleteBtn"), for: .normal);
        button.addTarget(self, action: #selector(deleteBtnClick), for: .touchUpInside);
        return button;
    }();
    
    // 菜图片
    private lazy var dishImage: UIImageView = {
        let dishImage = UIImageView();
        dishImage.layer.cornerRadius = realValue(value: 20/2);
        dishImage.clipsToBounds = true;
        return dishImage;
    }();
    
    // 菜名
    private lazy var dishNameLabel: UILabel = {
        let label = UILabel();
        label.text = "菜名";
        label.font = BoldFont(size: 60/2);
        label.textAlignment = .left;
        label.textColor = RGBWithHexColor(hexColor: 0x774040);
        return label;
    }();
    
    // 菜品介绍
    private lazy var dishDesLabel: UILabel = {
        let label = UILabel();
        label.font = Font(size: 40/2);
        label.textColor = RGBWithHexColor(hexColor: 0x333333);
        label.textAlignment = .left;
        label.numberOfLines = 0;
        label.text = "介绍：烧肉是最传统的做法之一烧肉是最传统的做法之一烧肉是最传统的做法之一烧肉是最传统的做法之一烧肉是最传统的做法之一";
        return label;
    }();
    
    // 价格
    private lazy var priceLabel: UILabel = {
        let label = UILabel();
        label.text = "￥88";
        label.font = BoldFont(size: 52/2);
        label.textColor = RGBWithHexColor(hexColor: 0x774040);
        label.textAlignment = .left;
        return label;
    }();
    
    // 减号按钮
    lazy var minusBtn: UIButton = {
        let button = UIButton(type: .custom);
        button.setImage(UIImage.imageWithName(name: "dishDetailView_minusBtn"), for: .normal);
        button.isHidden = true;
        return button;
    }();
    
    // 份数
    lazy var numberLabel: UILabel = {
        let label = UILabel();
        label.text = "0";
        label.textAlignment = .center;
        label.font = Font(size: 48/2);
        label.textColor = RGBWithHexColor(hexColor: 0x1a1a1a);
        label.isHidden = true;
        return label;
    }();
    
    // 加号按钮
    lazy var plusBtn: UIButton = {
        let button = UIButton(type: .custom);
        button.setImage(UIImage.imageWithName(name: "dishDetailView_plusBtn"), for: .normal);
        button.isHidden = true;
        return button;
    }();
    
    // 加入按钮
    lazy var addBtn: UIButton = {
        let button = UIButton(type: .custom);
        button.setBackgroundImage(UIImage.imageWithName(name: "dishDetailView_addBtn_background"), for: .normal);
        button.setTitle("加入", for: .normal);
        button.setTitleColor(RGBWithHexColor(hexColor: 0xfefefe), for: .normal);
        button.titleLabel?.font = Font(size: 42/2);
        button.addTarget(self, action: #selector(addBtnClick), for: .touchUpInside);
        return button;
    }();
    
    
    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        return true;
    }
    
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        let deleteBtnPoint = deleteBtn.convert(point, from: self);
        if deleteBtn.point(inside: deleteBtnPoint, with: event) {
            return deleteBtn;
        } else {
            return super.hitTest(point, with: event);
        }
    }
    
    
    // 点击消失按钮，消失
    var deleteBtnCallBack: (() -> ())?;
    // 添加按钮回调
    var plusBtnCallBack: ((_ model: JCDishModel) -> ())?;
    // 减少按钮回调
    var minusBtnCallBack: ((_ model: JCDishModel) -> ())?;
    // 加入按钮回调
    var addBtnCallBack: ((_ model: JCDishModel) -> ())?;
    
    var model: JCDishModel? {
        didSet {
            // 取出可选类型中的数据
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
            
            // 份数
            numberLabel.text = "\(model.number)";
            
            // 菜价格
            if let price = model.price {
                priceLabel.text = String(format: "￥%.2f", price);
            }
        }
    }
    
    // MARK: - 初始化
    override init(frame: CGRect) {
        super.init(frame: frame);
        
        self.autoresizingMask = [.flexibleWidth, .flexibleHeight];
        
        // 添加背景
        addSubview(background);
        
        // 添加白色背景
        background.addSubview(whiteBackground);
        
        // 添加删除按钮
        whiteBackground.addSubview(deleteBtn);
        
        // 添加菜图片
        whiteBackground.addSubview(dishImage);
        
        // 添加菜名
        whiteBackground.addSubview(dishNameLabel);
        
        // 添加菜品描述
        whiteBackground.addSubview(dishDesLabel);
        
        // 添加价格
        whiteBackground.addSubview(priceLabel);
        
        // 添加减号按钮
        whiteBackground.addSubview(minusBtn);
        minusBtn.addTarget(self, action: #selector(minusBtnClick), for: .touchUpInside);
        
        // 添加份数
        whiteBackground.addSubview(numberLabel);
    
        
        // 添加加号按钮
        whiteBackground.addSubview(plusBtn);
        plusBtn.addTarget(self, action: #selector(plusBtnClick), for: .touchUpInside);
        
        // 添加addBtn
        whiteBackground.addSubview(addBtn);
    
    }
   
    
    // 点击减号按钮，减少份数
    @objc private func minusBtnClick() -> Void {
        
        if let minusBtnCallBack = minusBtnCallBack, let model = model {
            minusBtnCallBack(model);
        }
    }
    
    // 点击加号按钮，增加份数
    @objc private func plusBtnClick() -> Void {
        
        if let plusBtnCallBack = plusBtnCallBack, let model = model {
            plusBtnCallBack(model);
        }
    }
    
    // 监听加入按钮的点击
    @objc private func addBtnClick() -> Void {
        
        if let addBtnCallBack = addBtnCallBack, let model = model {
            addBtnCallBack(model);
        }
    }
    
    // 监听消失按钮的点击
    @objc private func deleteBtnClick() -> Void {
        
        if let deleteBtnCallBack = deleteBtnCallBack {
            deleteBtnCallBack();
        }
    }
 
    
    // MARK: - 设置子控件的frame
    override func layoutSubviews() {
        super.layoutSubviews();
        
        // 设置background 的frame
        background.frame = bounds;
        
        // 设置whiteBackground 的frame
        let whiteBackgroundCenterX = kScreenWidth/2;
        let whiteBackgroundCenterY = kScreenHeight/2;
        let whiteBackgroundW = realValue(value: 1430/2);
        let whiteBackgroundH = realValue(value: 1408/2);
        whiteBackground.center = CGPoint(x: whiteBackgroundCenterX, y: whiteBackgroundCenterY);
        whiteBackground.bounds = CGRect(x: 0, y: 0, width: whiteBackgroundW, height: whiteBackgroundH);
        
        // 设置删除按钮的frame
        deleteBtn.center = CGPoint(x: whiteBackgroundW, y: 0);
        deleteBtn.bounds = CGRect(x: 0, y: 0, width: realValue(value: 70/2), height: realValue(value: 70/2));
        
        
        // 设置菜图片的frame
        let dishImageX = realValue(value: 20/2);
        let dishImageY = realValue(value: 20/2);
        let dishImageW = realValue(value: 1390/2);
        let dishImageH = realValue(value: 1043/2);
        dishImage.frame = CGRect(x: dishImageX, y: dishImageY, width: dishImageW, height: dishImageH);
        
        // 设置菜名的frame
        let dishNameLabelX = realValue(value: 40/2);
        let dishNameLabelY = dishImage.frame.maxY + realValue(value: 60/2);
        let dishNameLabelW = calculateWidth(title: dishNameLabel.text ?? "", boldFontSize: 60/2, maxWidth: dishImageW/2) ?? 0;
        let dishNameLabelH = realValue(value: 60/2);
        dishNameLabel.frame = CGRect(x: dishNameLabelX, y: dishNameLabelY, width: dishNameLabelW, height: dishNameLabelH);
        
        // 设置菜品描述的frame
        let dishDesLabelX = dishNameLabelX;
        let dishDesLabelY = dishNameLabel.frame.maxY + realValue(value: 60/2);
        let dishDesLabelW = dishImageW - CGFloat(2) * dishDesLabelX;
        let dishDesLabelH = calculateLabelHeight(labelW: dishDesLabelW, text: dishDesLabel.text ?? "", fontSize: 40/2, maxHeight: realValue(value: 1408/2 - 30/2) - dishDesLabelY) ?? 0;
        dishDesLabel.frame = CGRect(x: dishDesLabelX, y: dishDesLabelY, width: dishDesLabelW, height: dishDesLabelH);
        
        // 设置加号按钮的frame
        let plusBtnX = whiteBackgroundW - realValue(value: 119/2);
        let plusBtnY = dishImage.frame.maxY + realValue(value: 60/2);
        let plusBtnW = realValue(value: 60/2);
        let plusBtnH = plusBtnW;
        plusBtn.frame = CGRect(x: plusBtnX, y: plusBtnY, width: plusBtnW, height: plusBtnH);
        
        // 设置份数的frame
        let numberLabelX = plusBtn.frame.minX - realValue(value: 85/2);
        let numberLabelY = plusBtnY;
        let numberLabelW = realValue(value: 85/2);
        let numberLabelH = plusBtnH;
        numberLabel.frame = CGRect(x: numberLabelX, y: numberLabelY, width: numberLabelW, height: numberLabelH);
        
        // 设置减号按钮的frame
        let minusBtnX = numberLabel.frame.minX - plusBtnW;
        let minusBtnY = plusBtnY;
        let minusBtnW = plusBtnW;
        let minusBtnH = plusBtnH;
        minusBtn.frame = CGRect(x: minusBtnX, y: minusBtnY, width: minusBtnW, height: minusBtnH);
        
        
        // 设置价格的frame
        let priceLabelW = calculateWidth(title: priceLabel.text ?? "", boldFontSize: 52/2, maxWidth: 400/2) ?? 0;
        let priceLabelX = minusBtn.frame.minX - realValue(value: 80/2) - priceLabelW;
        let priceLabelY = dishNameLabelY;
        let priceLabelH = realValue(value: 52/2);
        priceLabel.frame = CGRect(x: priceLabelX, y: priceLabelY, width: priceLabelW, height: priceLabelH);
        
        // 设置addBtn的frame
        let addBtnX = whiteBackgroundW - realValue(value: 220/2);
        let addBtnY = dishImage.frame.maxY + realValue(value: 54/2);
        let addBtnW = realValue(value: 200/2);
        let addBtnH = realValue(value: 68/2);
        addBtn.frame = CGRect(x: addBtnX, y: addBtnY, width: addBtnW, height: addBtnH);
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
