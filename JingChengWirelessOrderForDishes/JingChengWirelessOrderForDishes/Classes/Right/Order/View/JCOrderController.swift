//
//  JCOrderController.swift
//  JingChengWirelessOrderForDishes
//
//  Created by zhangxu on 2016/11/23.
//  Copyright © 2016年 zhangxu. All rights reserved.
//

import UIKit

// cell常量标识
fileprivate let orderCellIdentifier = "orderCellIdentifier";

class JCOrderController: UIViewController {
    
    // 背景
    fileprivate lazy var background: UIImageView = {
        let background = UIImageView();
        background.image = UIImage.imageWithName(name: "order_background");
        background.isUserInteractionEnabled = true;
        background.isHidden = true;
        return background;
    }();
    
    // 桌号
    lazy var tableLabel: UILabel = {
        let label = UILabel();
        label.text = "桌号：002";
        label.font = Font(size: 36/2);
        label.textColor = RGBWithHexColor(hexColor: 0x1a1a1a);
        label.textAlignment = .center;
        return label;
    }();
    
    // 全部删除
    fileprivate lazy var deleteAllBtn: UIButton = {
        let button = UIButton(type: .custom);
        button.setBackgroundImage(UIImage.imageWithName(name: "order_deleteAllBtn_normal"), for: .normal);
        button.setBackgroundImage(UIImage.imageWithName(name: "order_deleteAllBtn_highlighted"), for: .highlighted);
        button.setTitle("全部删除", for: .normal);
        button.setTitleColor(RGBWithHexColor(hexColor: 0x1a1a1a), for: .normal);
        button.titleLabel?.font = Font(size: 32/2);
        button.addTarget(self, action: #selector(deleteAllBtnClick(button:)), for: .touchUpInside);
        return button;
    }();
    
    // 序号
    fileprivate lazy var serialNumberLabel: UILabel = {
        let label = UILabel();
        label.text = "序号";
        label.textColor = RGBWithHexColor(hexColor: 0x1a1a1a);
        label.font = Font(size: 32/2);
        label.textAlignment = .left;
        return label;
    }();
    
    // 菜名
    fileprivate lazy var dishNameLabel: UILabel = {
        let label = UILabel();
        label.text = "菜名";
        label.font = Font(size: 32/2);
        label.textAlignment = .left;
        label.textColor = RGBWithHexColor(hexColor: 0x1a1a1a);
        return label;
    }();
    
    // 份数
    fileprivate lazy var dishNumberLabel: UILabel = {
        let label = UILabel();
        label.textColor = RGBWithHexColor(hexColor: 0x1a1a1a);
        label.font = Font(size: 32/2);
        label.textAlignment = .left;
        label.text = "份数";
        return label;
    }();
    
    // 价格
    fileprivate lazy var dishPriceLabel: UILabel = {
        let label = UILabel();
        label.font = Font(size: 32/2);
        label.textColor = RGBWithHexColor(hexColor: 0x1a1a1a);
        label.textAlignment = .left;
        label.text = "价格";
        return label;
    }();
    
    // 状态
    fileprivate lazy var dishStatusLabel: UILabel = {
        let label = UILabel();
        label.font = Font(size: 32/2);
        label.textColor = RGBWithHexColor(hexColor: 0x1a1a1a);
        label.textAlignment = .left;
        label.text = "状态";
        return label;
    }();
    
    // 已点菜品列表
    fileprivate lazy var tableView: UITableView = {
        let tableView = UITableView.init(frame: .zero, style: .plain);
        tableView.dataSource = self;
        tableView.delegate = self;
        tableView.backgroundColor = UIColor.clear;
        tableView.rowHeight = realValue(value: 140/2);
        tableView.separatorStyle = .none;
        return tableView;
    }();
    
    // 口味要求
    fileprivate lazy var tasteLabel: UILabel = {
        let label = UILabel();
        label.font = Font(size: 32/2);
        label.text = "味道要求：";
        label.textColor = RGBWithHexColor(hexColor: 0x1a1a1a);
        label.textAlignment = .left;
        return label;
    }();
    
    // 微辣
    fileprivate lazy var mildSpicyBtn: UIButton = {
        let button = UIButton(type: .custom);
        button.setBackgroundImage(UIImage.imageWithName(name: "order_tasteBtn_background_normal"), for: .normal);
        button.setBackgroundImage(UIImage.imageWithName(name: "order_tasteBtn_background_selected"), for: .selected);
        button.setTitle("微辣", for: .normal);
        button.setTitleColor(RGBWithHexColor(hexColor: 0x1a1a1a), for: .normal);
        button.titleLabel?.font = Font(size: 30/2);
        return button;
    }();
    
    // 麻辣
    fileprivate lazy var mediumSpicyBtn: UIButton = {
        let button = UIButton(type: .custom);
        button.setBackgroundImage(UIImage.imageWithName(name: "order_tasteBtn_background_normal"), for: .normal);
        button.setBackgroundImage(UIImage.imageWithName(name: "order_tasteBtn_background_selected"), for: .selected);
        button.setTitle("麻辣", for: .normal);
        button.setTitleColor(RGBWithHexColor(hexColor: 0x1a1a1a), for: .normal);
        button.titleLabel?.font = Font(size: 30/2);
        return button;
    }();
    
    // 重辣
    fileprivate lazy var pepperyBtn: UIButton = {
        let button = UIButton(type: .custom);
        button.setBackgroundImage(UIImage.imageWithName(name: "order_tasteBtn_background_normal"), for: .normal);
        button.setBackgroundImage(UIImage.imageWithName(name: "order_tasteBtn_background_selected"), for: .selected);
        button.setTitle("重辣", for: .normal);
        button.setTitleColor(RGBWithHexColor(hexColor: 0x1a1a1a), for: .normal);
        button.titleLabel?.font = Font(size: 30/2);
        return button;
    }();
    
    
    // 顶部线条
    fileprivate lazy var topLine: UIImageView = {
        let imageView = UIImageView();
        imageView.image = UIImage.imageWithName(name: "order_bottomLine");
        return imageView;
    }();
    
    // 底部线条
    fileprivate lazy var bottomLine: UIImageView = {
        let imageView = UIImageView();
        imageView.image = UIImage.imageWithName(name: "order_bottomLine");
        return imageView;
    }();
    
    // 总价格
    fileprivate lazy var totalPriceLabel: UILabel = {
        let label = UILabel();
        label.text = "总价格：";
        label.font = Font(size: 42/2);
        label.textColor = RGBWithHexColor(hexColor: 0x1a1a1a);
        label.textAlignment = .right;
        return label;
    }();
    
    // 合计
    lazy var amountLabel: UILabel = {
        let label = UILabel();
        label.text = "298.00元";
        label.textAlignment = .right;
        label.font = BoldFont(size: 42/2);
        label.textColor = RGBWithHexColor(hexColor: 0xe98503);
        return label;
    }();
    
    // 重新开台
    fileprivate lazy var keepOrderBtn: UIButton = {
        let button = UIButton(type: .custom);
        button.setBackgroundImage(UIImage.imageWithName(name: "order_open_tab_border_normal"), for: .normal);
        button.setBackgroundImage(UIImage.imageWithName(name: "order_open_tab_border_highlighted"), for: .highlighted);
        button.setTitle("重新开台", for: .normal);
        button.setTitleColor(RGBWithHexColor(hexColor: 0x1a1a1a), for: .normal)
        button.titleLabel?.font = Font(size: 32/2);
        button.addTarget(self, action: #selector(keepOrderBtnClick(button:)), for: .touchUpInside);
        return button;
    }();
    
    // 发送下单
    fileprivate lazy var submitBtn: UIButton = {
        let button = UIButton(type: .custom);
        button.setBackgroundImage(UIImage.imageWithName(name: "order_submitBtn_background_normal"), for: .normal);
        button.setBackgroundImage(UIImage.imageWithName(name: "order_submitBtn_background_highlighted"), for: .highlighted);
        button.setTitle("发送下单", for: .normal);
        button.setTitleColor(RGBWithHexColor(hexColor: 0x1a1a1a), for: .normal);
        button.titleLabel?.font = Font(size: 32/2);
        button.addTarget(self, action: #selector(submitBtnClick(button:)), for: .touchUpInside);
        return button;
    }();
    
    // 已选为空的背景
    fileprivate lazy var emptyBackground: JCEmptyBackground = {
        let emptyBackground = JCEmptyBackground();
        emptyBackground.isHidden = false;
        return emptyBackground;
    }();
    
    // 懒加载数组
    lazy var orderModelArray: [JCDishModel] = [JCDishModel]();
    
    // 回到输入桌号界面
    var dismissCallBack: (() -> ())?;
    
    // 释放
    deinit {
        print("JCOrderController 被释放了");
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 添加已点为空
        view.addSubview(emptyBackground);
        // 添加背景
        view.addSubview(background);
        // 添加桌号
        background.addSubview(tableLabel);
        // 全部删除
        background.addSubview(deleteAllBtn);
        // 添加序号
        background.addSubview(serialNumberLabel);
        // 添加菜名
        background.addSubview(dishNameLabel);
        // 添加份数
        background.addSubview(dishNumberLabel);
        // 添加价格
        background.addSubview(dishPriceLabel);
        // 添加状态
        background.addSubview(dishStatusLabel);
        // 添加tableview
        background.addSubview(tableView);
        // 添加topLine
        background.addSubview(topLine);
        // 口味要求
        background.addSubview(tasteLabel);
        // 微辣
        background.addSubview(mildSpicyBtn);
        // 麻辣
        background.addSubview(mediumSpicyBtn);
        // 重辣
        background.addSubview(pepperyBtn);
        // 底部线条
        background.addSubview(bottomLine);
        // 添加总价格
        background.addSubview(totalPriceLabel);
        // 合计
        background.addSubview(amountLabel);
        // 继续点餐
        background.addSubview(keepOrderBtn);
        // 发送下单
        background.addSubview(submitBtn);
        // 注册cell
        tableView.register(JCOrderCell.self, forCellReuseIdentifier: orderCellIdentifier);
        
        // 更新数组
        updateOrderModelArray();
        
        // 已点为空已点按钮回调
        emptyBackground.orderBtnCallBack = {
            _ in
            // 发送通知，显示菜谱页面，隐藏其他页面
            NotificationCenter.default.post(name: ChangeCategoryNotification, object: nil, userInfo: nil);
        }
        
        // 已点为空页面重新开台按钮的回调
        emptyBackground.keepOrderBtnCallBack = { [weak self]
            _ in
            // 清空数组
            JCDishManager.shared.dishs.removeAll();
            // 回到输入桌号界面
            if let dismissCallBack = self?.dismissCallBack {
                dismissCallBack();
            }
        }
    }
    
    // 更新数组
    func updateOrderModelArray() -> Void {
        
        // 先排序
        JCDishManager.shared.dishs.sort { (model1, model2) -> Bool in
            return model1.serialNumber < model2.serialNumber;
        }
        // 更新序号
        var index: Int = 0;
        let _ = JCDishManager.shared.dishs.map({
            (element) in
            index += 1;
            element.serialNumber = index;
        });

        // 清空数组
        orderModelArray.removeAll();
        // 更新数组
        orderModelArray += JCDishManager.shared.dishs;
        
        // 刷新数据
        tableView.reloadData();
        
        // 更新总价格
        amountLabel.text = String(format: "￥%.2f", JCDishManager.totalPrice());
        
        // 更新交互
        updateEmptyAndBackground();
        
        // 更新frame 
        view.layoutIfNeeded();
        view.setNeedsLayout();
    }
    
    // 更新序号，更新总价格，更新总分数
    func updateUI() -> Void {
        
        // 更新序号
        var currentIndex: Int = 0;
        let _ = orderModelArray.map({
            (model) in
            currentIndex += 1;
            model.serialNumber = currentIndex;
        });
        
        // 更新总价格
        amountLabel.text = String(format: "￥%.2f", JCDishManager.totalPrice());
        
        // 发送通知，改变份数
        NotificationCenter.default.post(name: ChangeRedIconNumberNotification, object: nil, userInfo: nil);
        // 更新交互
        updateEmptyAndBackground();
        
        // 更新frame
        view.layoutIfNeeded();
        view.setNeedsLayout();
    }
    
    // 更新交互
    private func updateEmptyAndBackground() -> Void {
        
        if JCDishManager.shared.dishs.count == 0 {
            emptyBackground.isHidden = false;
            background.isHidden = true;
        } else {
            emptyBackground.isHidden = true;
            background.isHidden = false;
        }
    }
    
    // 设置编辑状态
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        
        return .delete;
    }
    
    // MARK: - 确定tableView可以编辑
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        let model = orderModelArray[indexPath.row];
        JCDishManager.deleteDish(model: model);
        var index: Int = 0;
        let _ = orderModelArray.map({
            (element) in
            if element.dish_id == model.dish_id {
                orderModelArray.remove(at: index);
                let tempIndexPath = IndexPath(row: index, section: 0);
                tableView.deleteRows(at: [tempIndexPath], with: .top);
                // 更新序号，更新总价格，更新总分数
                updateUI();
            }
            index += 1;
        });
    }
    
    // cell将要消失的时候调用此方法
    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        // 在拖拽cell的时候禁止刷新表格
        if tableView.isDragging == true {
            return;
        }
        // 当cell在滚动的时候禁止刷新表格
        if tableView.isDecelerating == true {
            return;
        }
        
        // 刷新表格
        tableView.reloadData();
    }

    
    // MARK: - 点击重新开台，返回到输入桌号页面
    @objc private func keepOrderBtnClick(button: UIButton) -> Void {
        
        // 清空数组
        JCDishManager.shared.dishs.removeAll();
        // 回到输入桌号界面
        if let dismissCallBack = dismissCallBack {
            dismissCallBack();
        }
    }
    
    // 点击发送下单
    @objc private func submitBtnClick(button: UIButton) -> Void {
       
    }
    
    // 删除全部
    @objc private func deleteAllBtnClick(button: UIButton) -> Void {
        
        JCDishManager.shared.dishs.removeAll();
        
        // 更新数组
        updateOrderModelArray();
        
        // 发送通知，改变份数
        NotificationCenter.default.post(name: ChangeRedIconNumberNotification, object: nil, userInfo: nil);
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}



// MARK: - 数据源方法
extension JCOrderController: UITableViewDataSource, UITableViewDelegate {
    
    // MARK: - 返回行
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return orderModelArray.count;
    }
    
    // MARK: - 返回cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: orderCellIdentifier, for: indexPath) as? JCOrderCell else {
            return JCOrderCell();
        }
        if indexPath.row < orderModelArray.count {
            
            let model = orderModelArray[indexPath.row];
            handleModelUpdateUI(cell: cell, model: model, indexPath: indexPath);
        }
        
        return cell;
    }
    
    // 处理cell
    private func handleModelUpdateUI(cell: JCOrderCell, model: JCDishModel, indexPath: IndexPath) -> Void {
        
        let resultModel = JCDishManager.findDish(model: model);
        cell.model = (resultModel == nil) ? model : resultModel;
        cell.model?.indexPath = indexPath;
        // 加号按钮
        cell.plusBtnCallBack = { [weak self, weak cell]
            (currentModel) in
            
            // 份数 +1
            JCDishManager.addDish(model: currentModel);
            
            // 更新份数
            let resultModel = JCDishManager.findDish(model: currentModel);
            if resultModel == nil {
                currentModel.number = 0;
                cell?.model = currentModel;
            } else {
                cell?.model = resultModel;
            }
            
            // 更新UI
            self?.updateUI();
        }
        
        // 减号按钮
        cell.minusBtnCallBack = { [weak self]
            (currentModel) in
            
            // 份数 -1
            JCDishManager.reduceDish(model: currentModel);
            
            var index: Int = 0;
            let _ = self?.orderModelArray.map({
                (element) in
                
                let indexPath = IndexPath(row: index, section: 0);
                if element.number == 0 {
                    self?.orderModelArray.remove(at: index);
                    JCDishManager.deleteDish(model: element);
                    self?.tableView.deleteRows(at: [indexPath], with: .top);
                    // 更新序号，更新总价格
                    self?.updateUI();
                } else if element.dish_id == currentModel.dish_id {
                    self?.tableView.reloadData();
                    self?.updateUI();
                }
                index += 1;
            });
        }
    }
}

// MARK: - 布局UI
extension JCOrderController {
    
    // 设置子控件的frame
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews();
        
        // 设置emptyBackground 的frame
        emptyBackground.frame = view.bounds;
        
        // 设置背景的frame
        background.frame = view.bounds;
        
        let width = background.bounds.size.width;
        
        // 设置tableLabel 的frame
        let tableLabelX = realValue(value: 122/2);
        let tableLabelY = realValue(value: 40/2);
        let tableLabelW = calculateWidth(title: tableLabel.text ?? "", fontSize: 36/2, maxWidth: 200) ?? 0;
        let tableLabelH = realValue(value: 36/2);
        tableLabel.frame = CGRect(x: tableLabelX, y: tableLabelY, width: tableLabelW, height: tableLabelH);
        
        // 设置deleteAllBtn 的frame
        let deleteAllBtnY = realValue(value: 40/2);
        let deleteAllBtnW = realValue(value: 220/2);
        let deleteAllBtnX = width - deleteAllBtnW - realValue(value: 176/2);
        let deleteAllBtnH = realValue(value: 72/2);
        deleteAllBtn.frame = CGRect(x: deleteAllBtnX, y: deleteAllBtnY, width: deleteAllBtnW, height: deleteAllBtnH);
        
        // 设置serialNumberLabel 的frame
        let serialNumberLabelX = tableLabelX;
        let serialNumberLabelY = tableLabel.frame.maxY + realValue(value: 60/2);
        let serialNumberLabelW = calculateWidth(title: serialNumberLabel.text ?? "", fontSize: 32/2, maxWidth: realValue(value: 200)) ?? 0;
        let serialNumberLabelH = realValue(value: 32/2);
        serialNumberLabel.frame = CGRect(x: serialNumberLabelX, y: serialNumberLabelY, width: serialNumberLabelW, height: serialNumberLabelH);
        
        //  设置dishNameLabel 的frame
        let dishNameLabelX = serialNumberLabel.frame.maxX + realValue(value: 174/2);
        let dishNameLabelY = serialNumberLabelY;
        let dishNameLabelW = calculateWidth(title: dishNameLabel.text ?? "", fontSize: 32/2, maxWidth: realValue(value: 200)) ?? 0;
        let dishNameLabelH = realValue(value: 32/2);
        dishNameLabel.frame = CGRect(x: dishNameLabelX, y: dishNameLabelY, width: dishNameLabelW, height: dishNameLabelH);
        
        // 设置dishNumberLabel 的frame
        let dishNumberLabelX = dishNameLabel.frame.maxX + realValue(value: 595/2);
        let dishNumberLabelY = serialNumberLabelY;
        let dishNumberLabelW = calculateWidth(title: dishNumberLabel.text ?? "", fontSize: 32/2, maxWidth: realValue(value: 200)) ?? 0;
        let dishNumberLabelH = dishNameLabelH;
        dishNumberLabel.frame = CGRect(x: dishNumberLabelX, y: dishNumberLabelY, width: dishNumberLabelW, height: dishNumberLabelH);
        
        // 设置dishPriceLabel 的frame
        let dishPriceLabelX = dishNumberLabel.frame.maxX + realValue(value: 232/2);
        let dishPriceLabelY = serialNumberLabelY;
        let dishPriceLabelW = calculateWidth(title: dishPriceLabel.text ?? "", fontSize: 32/2, maxWidth: realValue(value: 200)) ?? 0;
        let dishPriceLabelH = serialNumberLabelH;
        dishPriceLabel.frame = CGRect(x: dishPriceLabelX, y: dishPriceLabelY, width: dishPriceLabelW, height: dishPriceLabelH);
        
        // 设置dishStatusLabel 的frame
        let dishStatusLabelX = dishPriceLabel.frame.maxX + realValue(value: 220/2);
        let dishStatusLabelY = serialNumberLabelY;
        let dishStatusLabelW = calculateWidth(title: dishStatusLabel.text ?? "", fontSize: 32/2, maxWidth: realValue(value: 200)) ?? 0;
        let dishStatusLabelH = serialNumberLabelH;
        dishStatusLabel.frame = CGRect(x: dishStatusLabelX, y: dishStatusLabelY, width: dishStatusLabelW, height: dishStatusLabelH);
        
        // 设置tableView 的frame
        let tableViewX = tableLabelX;
        let tableViewY = serialNumberLabel.frame.maxY + realValue(value: 10/2);
        let tableViewW = width - tableViewX * CGFloat(2);
        let tableViewH = realValue(value: 705/2);
        tableView.frame = CGRect(x: tableViewX, y: tableViewY, width: tableViewW, height: tableViewH);
        
        // 设置topLine的frame
        let topLineX = tableLabelX;
        let topLineY = tableView.frame.maxY;
        let topLineW = tableViewW;
        let topLineH = realValue(value: 1/2);
        topLine.frame = CGRect(x: topLineX, y: topLineY ,width: topLineW, height: topLineH);
        
        
        // 设置tasteImage 的frame
        let tasteLabelX = tableLabelX;
        let tasteLabelY = topLine.frame.maxY + (realValue(value: 100/2 - 32/2))/2;
        let tasteLabelW = calculateWidth(title: tasteLabel.text ?? "", fontSize: 32/2, maxWidth: realValue(value: 200)) ?? 0;
        let tasteLabelH = realValue(value: 32/2);
        tasteLabel.frame = CGRect(x: tasteLabelX, y: tasteLabelY, width: tasteLabelW, height: tasteLabelH);
        
        // 设置mildSpicyBtn 的frame
        let mildSpicyBtnX = tasteLabel.frame.maxX + realValue(value: 30/2);
        let mildSpicyBtnY = topLine.frame.maxY + realValue(value: 100/2 - 42/2)/2;
        let mildSpicyBtnW = realValue(value: 86/2);
        let mildSpicyBtnH = realValue(value: 42/2);
        mildSpicyBtn.frame = CGRect(x: mildSpicyBtnX, y: mildSpicyBtnY, width: mildSpicyBtnW, height: mildSpicyBtnH);
        
        // 设置mediumSpicyBtn 的frame
        let mediumSpicyBtnX = mildSpicyBtn.frame.maxX + realValue(value: 60/2);
        let mediumSpicyBtnY = mildSpicyBtnY;
        let mediumSpicyBtnW = mildSpicyBtnW;
        let mediumSpicyBtnH = mildSpicyBtnH;
        mediumSpicyBtn.frame = CGRect(x: mediumSpicyBtnX, y: mediumSpicyBtnY, width: mediumSpicyBtnW, height: mediumSpicyBtnH);
        
        // 设置pepperyBtn 的frame
        let pepperyBtnX = mediumSpicyBtn.frame.maxX + realValue(value: 60/2);
        let pepperyBtnY = mildSpicyBtnY;
        let pepperyBtnW = mildSpicyBtnW;
        let pepperyBtnH = mildSpicyBtnH;
        pepperyBtn.frame = CGRect(x: pepperyBtnX, y: pepperyBtnY, width: pepperyBtnW, height: pepperyBtnH);
        
        // 设置bottomLine 的frame
        let bottomLineX = topLineX;
        let bottomLineY = topLine.frame.maxY + realValue(value: 100/2);
        let bottomLineW = topLineW;
        let bottomLineH = topLineH;
        bottomLine.frame = CGRect(x: bottomLineX, y: bottomLineY, width: bottomLineW, height: bottomLineH);
        
        // 设置amountLabel 的frame
        let amountLabelW = calculateWidth(title: amountLabel.text ?? "", boldFontSize: 42/2, maxWidth: realValue(value: 300)) ?? 0;
        let amountLabelX = width - realValue(value: 176/2) - amountLabelW;
        let amountLabelY = bottomLine.frame.maxY + realValue(value: 45/2);
        let amountLabelH = realValue(value: 42/2);
        amountLabel.frame = CGRect(x: amountLabelX, y: amountLabelY, width: amountLabelW, height: amountLabelH);
     
        // 设置totalPriceLabel 的frame
        let totalPriceLabelW = calculateWidth(title: totalPriceLabel.text ?? "", fontSize: 42/2, maxWidth: realValue(value: 200)) ?? 0;
        let totalPriceLabelX = amountLabel.frame.minX - realValue(value: 48/2) - totalPriceLabelW;
        let totalPriceLabelY = amountLabelY;
        let totalPriceLabelH = amountLabelH;
        totalPriceLabel.frame = CGRect(x: totalPriceLabelX, y: totalPriceLabelY, width: totalPriceLabelW, height: totalPriceLabelH);
        
        // 设置下单按钮的frame
        let submitBtnW = realValue(value: 200/2);
        let submitBtnH = realValue(value: 68/2);
        let submitBtnX = width - realValue(value: 176/2) - submitBtnW;
        let submitBtnY = totalPriceLabel.frame.maxY + realValue(value: 72/2);
        submitBtn.frame = CGRect(x: submitBtnX, y: submitBtnY, width: submitBtnW, height: submitBtnH);
        
        // 设置重新开台的frame
        let keepOrderBtnW = submitBtnW;
        let keepOrderBtnH = submitBtnH;
        let keepOrderBtnX = submitBtn.frame.minX - realValue(value: 130/2) - keepOrderBtnW;
        let keepOrderBtnY = submitBtnY;
        keepOrderBtn.frame = CGRect(x: keepOrderBtnX, y: keepOrderBtnY, width: keepOrderBtnW, height: keepOrderBtnH);
        
    }
}
